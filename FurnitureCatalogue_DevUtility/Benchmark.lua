-- Deterministic profiling scenarios
--   /furcdev bench     run all scenarios in order (asks for confirmation first)
--   /furcdev bench <n> run one scenario

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
-- scenario id -> { label, steps(), setup?() }
-- (run all runs them in order)
local function scenarios()
  local src = FurC.Constants.ItemSources
  return {
    [1] = {
      label = "window load (cold start + reopen)",
      -- start closed so first open runs cache stuff etc
      -- best after a reloadui (or else it might be cached already)
      setup = function()
        return {
          { fn = ensureClosed, delay = 600 },
          { fn = resetState },
        }
      end,
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
  .. "- best run after a fresh reloadui\n"
  .. "- wait until addons have settled and run only necessary ones\n"
  .. "- be inside player house (stable fps and nothing else happening)\n"
  .. "- can't hurt to rebuild DB first (in case of leftover broken items)\n"
  .. "- don't interact with game and keep game window focused until done (~30s per scenario)\n\n"

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
  local label = (#ns == 1) and tostring(ns[1]) or "ALL"
  d(string.format("|cFF3333FurCDev|r: benchmark %s%s ...", label, autoProfile and " [profiling]" or ""))

  -- clear the default-shown "please wait" label
  if FurCGui_Wait then
    FurCGui_Wait:SetHidden(true)
  end

  local all = {}
  for idx, n in ipairs(ns) do
    local setup = sc[n].setup and sc[n].setup() or { { fn = ensureOpen, delay = 700 }, { fn = resetState } }
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
    d("|cFF3333FurCDev|r: benchmark " .. label .. " done" .. exportHint(autoProfile, loaded))
    PlaySound(SOUNDS.JUSTICE_PICKPOCKET_BONUS)
  end)
end

local function runBenchmark(token)
  local sc = scenarios()
  local n = tonumber(token)
  if not n or not sc[n] then
    d("|cFF3333FurCDev|r: unknown scenario '" .. tostring(token) .. "'. Scenarios:\n" .. scenarioListText())
    return
  end
  confirm("Run: " .. sc[n].label, function()
    runSequence({ n })
  end)
end
this.RunBenchmark = runBenchmark

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
