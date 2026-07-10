-- Deterministic profiling scenarios
--   /furcdev bench   run all scenarios in order (asks for confirmation first)

if not FurCDev then
  return
end
local this = FurCDev

-- initial settle before each step
local DELAY = 1000 -- ms

-- should work in all locales (only tested EN and DE):
local SEARCH_ITEM_ID = 211366 -- Ayleid Lamp, Ornate Stone
local SEARCH_LEN = 5 -- "aylei"
local SEARCH_FALLBACK = "ayl" -- if item name isn't loaded

local function box()
  return FurC_SearchBox
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
  if FurCGui_Wait and not FurCGui_Wait:IsControlHidden() and waited < 6000 then
    zo_callLater(function()
      whenIdle(cb, waited + 200)
    end, 200)
  else
    cb()
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
    s.fn()
    -- wait for idle before next step
    zo_callLater(function()
      whenIdle(nextStep)
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

-- profiler timeline marker
local function mark(label)
  if RecordScriptProfilerUserEvent then
    RecordScriptProfilerUserEvent("furcbench|" .. label)
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
  FurC.sortIndexDirty = true
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

local function setSource(value)
  return function()
    FurC.SetDropdownChoice("Source", FurC.DropdownData.ChoicesSource[value], value)
  end
end

local function setVersion(value)
  return function()
    FurC.SetDropdownChoice("Version", FurC.DropdownData.ChoicesVersion[value], value)
  end
end

local function maxVersion()
  local m = 0
  for k in pairs(FurC.DropdownData.ChoicesVersion or {}) do
    if type(k) == "number" and k > m then
      m = k
    end
  end
  return m
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
  local src = FurC.Constants.ItemSources
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
    [2] = {
      label = "source = Crafting",
      steps = function()
        return { { fn = setSource(src.CRAFTING) } }
      end,
    },
    [3] = {
      label = "source = PVP",
      steps = function()
        return { { fn = setSource(src.PVP) } }
      end,
    },
    [4] = {
      label = "source = TelVar",
      steps = function()
        return { { fn = setSource(src.TELVAR) } }
      end,
    },
    [5] = {
      label = "version = latest",
      steps = function()
        return { { fn = setVersion(maxVersion()) } }
      end,
    },
    [6] = {
      label = "search keystrokes",
      steps = searchSteps,
    },
    -- Must run last
    [7] = {
      label = "rebuild DB + caches",
      steps = function()
        return {
          {
            fn = function()
              clearCaches()
              FurC.RebuildDB() -- async, exactly as normal use
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
    -- preconditions for the whole capture
    local setup = (idx == 1 and prepareSteps(sc[n].coldCaches))
      or { { fn = ensureOpen, delay = 700 }, { fn = resetState } }
    for _, s in ipairs(setup) do
      all[#all + 1] = s
    end
    if idx == 1 and autoProfile then
      all[#all + 1] = { fn = StartScriptProfiler }
    end
    all[#all + 1] = {
      fn = function()
        d(string.format("|cFF3333FurCDev|r: [%d/%d] %s", idx, #ns, sc[n].label))
        mark(n .. " " .. sc[n].label)
      end,
    }
    for _, s in ipairs(sc[n].steps()) do
      all[#all + 1] = s
    end
  end

  runSteps(all, function()
    if autoProfile then
      StopScriptProfiler()
    end
    -- cleanup
    ensureClosed()
    resetState()
    d("|cFF3333FurCDev|r: benchmark ALL done" .. exportHint(autoProfile, loaded))
    PlaySound(SOUNDS.JUSTICE_PICKPOCKET_BONUS)
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
