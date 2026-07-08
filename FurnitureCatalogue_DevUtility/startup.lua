FurCDev = {}

local this = FurCDev

local control = FurCDevControl

this.name = "FurnitureCatalogue_DevUtility"
this.control = control
this.textbox = FurCDevControlBox

-- List of TestSuites so we can start them from FurCDev
this.TestSuites = {
  "FurC:Unit",
  "FurC:Regression",
}

-- find TestSuites (with or without prefix)
local function resolveSuiteId(token)
  token = (token or ""):lower()
  if token == "" then
    return nil
  end
  for _, id in ipairs(this.TestSuites) do
    local tail = id:match(":(.+)$")
    if id:lower() == token or (tail and tail:lower() == token) then
      return id
    end
  end
  return nil
end

-- list all FurC TestSuites
local function listSuites()
  d("|cFF3333FurCDev|r test suites:")
  for _, id in ipairs(this.TestSuites) do
    d(" - " .. id)
  end
  d("Run with |cAACCFF/furcdev test <id>|r, or |cAACCFF/furcdev test|r for all.")
end
this.ListTestSuites = listSuites

-- Run single suite or all suites when no ID given
-- (Taneth wrapper to make it easier to use)
local function runTests(token)
  if not Taneth then
    d("|cFF3333FurCDev|r: Taneth missing, cannot run test")
    return
  end

  if token == "" then
    d("|cFF3333FurCDev|r: running test suites...")
    Taneth:RunTestSuites({ unpack(this.TestSuites) })
    return
  end

  local id = resolveSuiteId(token)
  if not id then
    d("|cFF3333FurCDev|r: unknown suite '" .. token .. "'.")
    listSuites()
    return
  end

  d("|cFF3333FurCDev|r: running " .. id .. "...")
  Taneth:RunTestSuites({ id })
end
this.RunTests = runTests

local function handleSlash(args)
  local cmd, rest = tostring(args or ""):match("^%s*(%S*)%s*(.-)%s*$")
  cmd = (cmd or ""):lower()

  -- no arg: trader furniture list
  if cmd == "" then
    this.ToggleEditBox()
  -- list tests
  elseif cmd == "tests" then
    listSuites()
  -- run tests
  elseif cmd == "test" then
    runTests(rest or "")
  -- DB dump with metadata (for full export)
  elseif cmd == "dump" then
    if this.DumpMeta then
      this.DumpMeta()
    end
  -- profiling benchmarks (runs all if no id)
  elseif cmd == "bench" then
    local bn = tostring(rest or ""):match("^(%S*)")
    if bn == "" then
      if this.RunAllBenchmarks then
        this.RunAllBenchmarks()
      end
    elseif this.RunBenchmark then
      this.RunBenchmark(bn)
    end
  else
    d("|cFF3333FurCDev|r: unknown cmd '" .. cmd .. "'.")
    d("Cmds: |cAACCFF/furcdev|r            toggle trader box")
    d("      |cAACCFF/furcdev tests|r      list tests")
    d("      |cAACCFF/furcdev test [id]|r  run test")
    d("      |cAACCFF/furcdev dump|r       dump DB including metadata to SavedVars")
    d("      |cAACCFF/furcdev bench [n]|r  run profiler scenario (leave empty for all)")
  end
end
this.HandleSlash = handleSlash
SLASH_COMMANDS["/furcdev"] = handleSlash

local function init(_, addonName)
  if addonName ~= this.name then
    return
  end
  this.textbox = FurCDevControlBox
  this.InitRightclickMenu()
  this.InitDashboard()

  EVENT_MANAGER:UnregisterForEvent(FurCDev.name, EVENT_ADD_ON_LOADED)
end

ZO_CreateStringId("SI_BINDING_NAME_FURCDEV_TOGGLE_TEXTBOX", "Toggle |cFF3333FurCDev|r text box")
EVENT_MANAGER:RegisterForEvent(this.name, EVENT_ADD_ON_LOADED, init)
