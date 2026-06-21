-- Deterministic profiling scenarios
--   /furcdev bench            list scenarios
--   /furcdev bench <n>        run scenario n (starts ESOProfiler if enabled)

if not FurCDev then
  return
end
local this = FurCDev

local DELAY = 1000 -- ms between steps

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

local function runSteps(steps, onDone)
  local i = 0
  local function step()
    i = i + 1
    local s = steps[i]
    if not s then
      return onDone and onDone()
    end
    s.fn()
    zo_callLater(step, s.delay or DELAY)
  end
  step()
end

local function resetState()
  FurC.InitFilters()
  if box() then
    box():SetText("")
  end
  FurC.SetFilter(true)
  FurC.UpdateGui()
end

local function setSource(value)
  return function()
    FurC.SetDropdownChoice("Source", FurC.DropdownData.ChoicesSource[value], value)
    FurC.SetFilter()
    FurC.UpdateGui()
  end
end

local function setVersion(value)
  return function()
    FurC.SetDropdownChoice("Version", FurC.DropdownData.ChoicesVersion[value], value)
    FurC.SetFilter()
    FurC.UpdateGui()
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
      delay = 700,
    }
  end
  return steps
end

-- scenario id -> { label, steps() }
local function scenarios()
  local src = FurC.Constants.ItemSources
  return {
    [1] = {
      label = "search keystrokes",
      steps = searchSteps,
    },
    [2] = {
      label = "source = PVP",
      steps = function()
        return {
          { fn = setSource(src.PVP) },
        }
      end,
    },
    [3] = {
      label = "source = TelVar",
      steps = function()
        return {
          { fn = setSource(src.TELVAR) },
        }
      end,
    },
    [4] = {
      label = "source = Crafting",
      steps = function()
        return {
          { fn = setSource(src.CRAFTING) },
        }
      end,
    },
    [5] = {
      label = "version = latest",
      steps = function()
        return {
          { fn = setVersion(maxVersion()) },
        }
      end,
    },
    [6] = {
      label = "open window",
      steps = function()
        return {
          {
            fn = function()
              FurCGui:SetHidden(true)
            end,
            delay = 600,
          },
          {
            fn = function()
              FurCGui:SetHidden(false)
              FurC.UpdateGui()
            end,
          },
        }
      end,
    },
  }
end

local function listScenarios()
  d("|cFF3333FurCDev|r benchmark scenarios:")
  local sc = scenarios()
  for i = 1, #sc do
    d(string.format(" %d - %s", i, sc[i].label))
  end
  d("Run: |cAACCFF/furcdev bench <n>|r")
  d("Rebuild DB first for comparable results")
end
this.ListBenchmarks = listScenarios

local function runBenchmark(token)
  local n = tonumber(token)
  local sc = scenarios()
  if not n or not sc[n] then
    d("|cFF3333FurCDev|r: unknown scenario '" .. tostring(token) .. "'.")
    return listScenarios()
  end
  if not FurCGui or (FurCGui:IsControlHidden() and n ~= 6) then
    d("|cFF3333FurCDev|r: open the FurC window first")
  end

  -- use ESO Profiler automatically, if loaded
  local profilerLoaded = ESO_PROFILER ~= nil and StartScriptProfiler and StopScriptProfiler
  local autoBracket = profilerLoaded and not ESO_PROFILER.profiling
  d(string.format("|cFF3333FurCDev|r: benchmark %d (%s)%s ...", n, sc[n].label, autoBracket and " [profiling]" or ""))

  -- reset OUTSIDE profiler logging, then run scenario
  runSteps({ { fn = resetState } }, function()
    if autoBracket then
      StartScriptProfiler()
    end
    runSteps(sc[n].steps(), function()
      if autoBracket then
        StopScriptProfiler()
      end
      local tail = (autoBracket and " - open Journal > ESO Profiler > Export")
        or (profilerLoaded and " - stop profiler & export")
        or " (no profiler addon loaded)"
      d("|cFF3333FurCDev|r: benchmark " .. n .. " done" .. tail)
      PlaySound(SOUNDS.JUSTICE_PICKPOCKET_BONUS)
    end)
  end)
end
this.RunBenchmark = runBenchmark
