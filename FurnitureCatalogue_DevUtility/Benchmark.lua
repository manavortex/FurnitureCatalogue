-- Deterministic profiling scenarios
--   /furcdev bench   run all scenarios in order (asks for confirmation first)

if not FurCDev then
  return
end
local this = FurCDev

-- initial settle before each step
local DELAY = 1000 -- ms
local IDLE_TIMEOUT = 6000 -- ms

-- scroll scenario: pages to step through, and the settle between them
local SCROLL_PAGES = 10
local SCROLL_DELAY = 400 -- ms

-- should work in all locales (only tested EN and DE):
local SEARCH_ITEM_ID = 211366 -- Ayleid Lamp, Ornate Stone
local SEARCH_LEN = 5 -- "aylei"
local SEARCH_FALLBACK = "ayl" -- if item name isn't loaded

local function box()
  return FurC_SearchBox
end

-- profiler timeline marker
local function mark(label)
  if RecordScriptProfilerUserEvent then
    RecordScriptProfilerUserEvent("furcbench|" .. label)
  end
end

-- first n characters of UTF-8 string
local function utf8prefix(s, n)
  local i, len, chars = 1, #s, 0
  while i <= len and chars < n do
    local b = string.byte(s, i)
    i = i + (b < 0x80 and 1 or b < 0xE0 and 2 or b < 0xF0 and 3 or 4)
    chars = chars + 1
  end
  return string.sub(s, 1, i - 1)
end

-- poll until FurC is done (abuses the "please wait" label)
local function whenIdle(cb, waited)
  waited = waited or 0
  -- The wait control can retain its visible state while its parent window is
  -- hidden. In that case no GUI refresh can be running, so treat it as idle.
  local busy = FurCGui and not FurCGui:IsControlHidden() and FurCGui_Wait and not FurCGui_Wait:IsControlHidden()
  if busy and waited < IDLE_TIMEOUT then
    zo_callLater(function()
      whenIdle(cb, waited + 200)
    end, 200)
  else
    cb(busy, waited)
  end
end

local function runSteps(steps, onDone)
  local i = 0
  local function nextStep()
    i = i + 1
    local s = steps[i]
    if not s then
      return onDone and onDone()
    end
    local stepNumber = i
    s.fn()
    -- wait for idle before next step
    zo_callLater(function()
      whenIdle(function(timedOut, idleWaited)
        if timedOut then
          mark("idle-timeout step=" .. stepNumber)
          d(
            string.format(
              "|cFF3333FurCDev|r: idle timeout after %d ms at benchmark step %d; continuing",
              idleWaited,
              stepNumber
            )
          )
        end
        nextStep()
      end)
    end, s.delay or DELAY)
  end
  nextStep()
end

-- FurC GUI must be open already, otherwise load delay
local function ensureOpen()
  if FurCGui and FurCGui:IsControlHidden() then
    FurnitureCatalogue_Toggle()
  end
end

-- hide FurC GUI
local function ensureClosed()
  if FurCGui and not FurCGui:IsControlHidden() then
    FurnitureCatalogue_Toggle()
  end
end

-- clear all filters and debounce rebuild stuff, so we don't keep reloading
local function resetState()
  local realUpdate = FurC.UpdateGui
  FurC.UpdateGui = function() end
  FurC.InitFilters()
  if box() then
    box():SetText("")
  end
  zo_callLater(function()
    FurC.UpdateGui = realUpdate
    FurC.SetFilter(true)
    FurC.UpdateGui()
  end, 700)
end

-- Always same preconditions for every benchmark
local function clearCaches()
  FurC.Utils.ClearLinkCache()
  FurC.ClearFilterCaches()
  FurC.SearchIndex.Invalidate()
  -- force sorted-index rebuild
  LibFurnitureCatalogue.Internal.DBRevision = LibFurnitureCatalogue.Internal.DBRevision + 1
end

local function warmCaches()
  FurC.UpdateGui()
  if box() then
    box():SetText(SEARCH_FALLBACK)
    FurC.GuiSetSearchboxTextFrom(box())
  end
end

-- Runs before the profiler starts, so none of it is profiled
local function prepareSteps(cold)
  local steps = {
    { fn = ensureClosed, delay = 600 },
    {
      fn = function()
        mark("prepare")
        FurC.RebuildDB(true) -- blocking: identical data, and no scan inside the capture
        clearCaches()
      end,
      delay = DELAY,
    },
    { fn = resetState },
  }
  if not cold then
    steps[#steps + 1] = { fn = ensureOpen, delay = 700 }
    steps[#steps + 1] = { fn = warmCaches, delay = DELAY }
    steps[#steps + 1] = { fn = resetState }
  end
  return steps
end

-- How many rows the current filter left in the list.
local function resultCount()
  local dataLines = FurCGui_ListHolder and FurCGui_ListHolder.dataLines
  return dataLines and #dataLines
end

-- Skip, in case a filter is gone or renamed
local function selectOrSkip(tag, dropdownName, value)
  local choices = FurC.DropdownData["Choices" .. dropdownName]
  local text = value and choices and choices[value]
  if not text then
    mark(string.format("%s SKIPPED %s choice %s not offered", tag, dropdownName, tostring(value)))
    d(
      string.format(
        "|cFF3333FurCDev|r: %s skipped, %s choice %s is no longer offered",
        tag,
        dropdownName,
        tostring(value)
      )
    )
    return false
  end
  FurC.SetDropdownChoice(dropdownName, text, value)
  return true
end

-- Select one dropdown value, then record what it matched. An empty result is a legitimate outcome
local function filterSteps(id, dropdownName, value)
  return function()
    local selected = false
    return {
      {
        fn = function()
          selected = selectOrSkip(id, dropdownName, value)
        end,
        delay = DELAY,
      },
      {
        fn = function()
          if selected then
            mark(id .. " result-count=" .. (resultCount() or "unavailable"))
          end
        end,
        delay = 0,
      },
    }
  end
end

-- A scenario that selects 1 dropdown value
local function filterScenario(id, label, dropdownName, value)
  return {
    label = label,
    filter = { dropdown = dropdownName, value = value },
    steps = filterSteps(id, dropdownName, value),
  }
end

-- Scroll the unfiltered list down 1 page at a time. Every page redraws each visible row, and the source line is composed per row per redraw (replicates what a player would experience while scrolling)
local function scrollSteps(id)
  return function()
    local steps = {
      {
        fn = function()
          FurCGui_ListHolder.dataOffset = 0
          FurC.UpdateInventoryScroll() -- also settles maxLines for the page size
          mark(
            string.format("%d scroll rows=%d page-size=%d", id, resultCount() or 0, FurCGui_ListHolder.maxLines or 0)
          )
        end,
        delay = DELAY,
      },
    }
    for page = 1, SCROLL_PAGES do
      steps[#steps + 1] = {
        fn = function()
          local holder = FurCGui_ListHolder
          local pageSize = holder.maxLines or 0
          local offset = holder.dataOffset or 0
          local last = (resultCount() or 0) - pageSize
          if pageSize <= 0 or offset >= last then
            mark(string.format("%d scroll page=%d SKIPPED list-exhausted at offset=%d", id, page, offset))
            return
          end
          mark(string.format("%d scroll page=%d offset=%d", id, page, offset))
          FurC.GuiOnScroll(holder, -pageSize) -- what the mouse wheel does
        end,
        delay = SCROLL_DELAY,
      }
    end
    return steps
  end
end

-- one step per keystroke, growing the localized item name from 3 chars up to SEARCH_LEN
local function searchSteps()
  local name = GetItemLinkName(FurC.Utils.GetItemLink(SEARCH_ITEM_ID))
  if not name or name == "" then
    name = SEARCH_FALLBACK
  end
  local steps = {}
  for k = 3, SEARCH_LEN do
    local term = utf8prefix(name, k)
    steps[#steps + 1] = {
      fn = function()
        if box() then
          box():SetText(term)
          FurC.GuiSetSearchboxTextFrom(box())
        end
      end,
      delay = DELAY,
    }
  end
  return steps
end

-- structure:
-- scenario id -> { label, steps(), coldCaches? }
-- (run all runs them in order)
local function scenarios()
  local constants = LibFurnitureCatalogue.Internal.Constants
  local src = constants.ItemSources
  local ver = constants.Versioning
  return {
    [1] = {
      label = "window load (cold start + reopen)",
      -- measures the first refresh
      coldCaches = true,
      steps = function()
        local function open(tag)
          return {
            fn = function()
              mark(tag)
              FurCGui:SetHidden(false)
              FurC.UpdateGui()
            end,
            delay = DELAY,
          }
        end
        local function close()
          return {
            fn = function()
              FurCGui:SetHidden(true)
            end,
            delay = 1200,
          }
        end
        return { open("open1-cold"), close(), open("open2-warm"), close(), open("open3-warm") }
      end,
    },
    [2] = filterScenario(2, "source = Crafting", "Source", src.CRAFTING),
    [3] = filterScenario(3, "source = PVP", "Source", src.PVP),
    [4] = filterScenario(4, "source = Vendor (gold)", "Source", src.VENDOR),
    [5] = filterScenario(5, "version = Homestead", "Version", ver.HOMESTEAD),
    [6] = {
      label = "search keystrokes",
      steps = searchSteps,
    },
    [7] = {
      label = "scroll full list by pages",
      steps = scrollSteps(7),
    },
    -- Must run last
    [8] = {
      label = "rebuild DB + caches",
      steps = function()
        return {
          {
            fn = function()
              clearCaches()
              FurC.RebuildDB() -- async, exactly as normal use
              mark("8 onready-request")
              LibFurnitureCatalogue.API.OnReady(function()
                mark("8 onready-callback")
              end)
            end,
            delay = DELAY,
          },
          -- first refresh rebuilds sorted index
          { fn = FurC.UpdateGui, delay = DELAY },
          -- first search rebuilds search-term index
          {
            fn = function()
              if box() then
                box():SetText(SEARCH_FALLBACK)
                FurC.GuiSetSearchboxTextFrom(box())
              end
            end,
            delay = DELAY,
          },
        }
      end,
    },
  }
end

local function scenarioListText()
  local sc = scenarios()
  local lines = {}
  for i = 1, #sc do
    lines[i] = string.format("%d - %s", i, sc[i].label)
  end
  return table.concat(lines, "\n")
end

local REMINDER = "Before running:\n"
  .. "- wait until addons have settled and run only necessary ones\n"
  .. "- be inside player house (stable fps and nothing else happening)\n"
  .. "- don't interact with game and keep game window focused until done (~30s per scenario)\n\n"
  .. "It might take up to 45 seconds before you see the first test pop up, just be patient.\n\n"

-- confirmation popup with Cancel
local function confirm(body, run)
  local LAM = LibAddonMenu2
  if LAM and LAM.util and LAM.util.ShowConfirmationDialog then
    LAM.util.ShowConfirmationDialog("FurCDev benchmark", REMINDER .. body, run)
  else
    run()
  end
end

local function exportHint(autoProfile, profilerLoaded)
  return (autoProfile and " - Journal > ESO Profiler > Export (reloads UI)")
    or (profilerLoaded and " - stop profiler, then Export (reloads UI)")
    or " (no profiler addon loaded)"
end

local function profilerState()
  local loaded = ESO_PROFILER ~= nil and StartScriptProfiler and StopScriptProfiler
  return loaded, loaded and not ESO_PROFILER.profiling
end

-- run scenario ids in sequence under one profiler run
-- (each scenario sets a marker, so you can identify it in the dump)
local function runSequence(ns)
  local sc = scenarios()
  local loaded, autoProfile = profilerState()
  d(string.format("|cFF3333FurCDev|r: benchmark ALL%s ...", autoProfile and " [profiling]" or ""))

  -- clear the default-shown "please wait" label
  if FurCGui_Wait then
    FurCGui_Wait:SetHidden(true)
  end

  local all = {}
  for idx, n in ipairs(ns) do
    local position = idx
    local scenarioId = n
    local scenario = sc[scenarioId]
    local scenarioTag = scenarioId .. " " .. scenario.label

    -- preconditions for the whole capture
    local setup = (position == 1 and prepareSteps(scenario.coldCaches))
      or { { fn = ensureOpen, delay = 700 }, { fn = resetState } }
    for _, s in ipairs(setup) do
      all[#all + 1] = s
    end
    if position == 1 and autoProfile then
      all[#all + 1] = { fn = StartScriptProfiler }
    end
    all[#all + 1] = {
      fn = function()
        d(string.format("|cFF3333FurCDev|r: [%d/%d] %s", position, #ns, scenario.label))
        mark(scenarioTag)
      end,
    }
    for _, s in ipairs(scenario.steps()) do
      all[#all + 1] = s
    end
    all[#all + 1] = {
      fn = function()
        mark("end " .. scenarioTag)
      end,
      delay = 0,
    }
  end

  runSteps(all, function()
    mark("benchmark-end")
    local function finish()
      if autoProfile then
        StopScriptProfiler()
      end
      -- cleanup
      ensureClosed()
      resetState()
      d("|cFF3333FurCDev|r: benchmark ALL done" .. exportHint(autoProfile, loaded))
      PlaySound(SOUNDS.JUSTICE_PICKPOCKET_BONUS)
    end
    if autoProfile then
      -- Give the profiler a separate update to record the final marker before
      -- stopping it.
      zo_callLater(finish, 100)
    else
      finish()
    end
  end)
end

local function runAll()
  local sc = scenarios()
  local ns = {}
  for i = 1, #sc do
    ns[i] = i
  end
  confirm("Run ALL in order:\n" .. scenarioListText(), function()
    runSequence(ns)
  end)
end
this.RunAllBenchmarks = runAll
this.BenchmarkScenarios = scenarios
