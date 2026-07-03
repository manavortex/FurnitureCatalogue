-- Headless Taneth runner for ESOLua (started  by run_tests.sh)
--
-- Uses Taneths run.lua but adds some steps and inits
--
-- Usage:
--   esolua -s <esoui> -- taneth_headless.lua <repo-root> <taneth-src-dir> [suite-id ...]

local repoRoot = arg[1]
local tanethDir = arg[2]
local suiteIds = {}
for i = 3, #arg do
  suiteIds[#suiteIds + 1] = arg[i]
end

if not repoRoot or not tanethDir then
  print("usage: taneth_headless.lua <repo-root> <taneth-src-dir> [suite-id ...]")
  os.exit(2)
end

local function join(...)
  return table.concat({ ... }, "/")
end

--- loads each .lua manifest entry except locale\$(language).lua and missing files
local function loadAddon(manifestPath)
  local fh = io.open(manifestPath, "r")
  if not fh then
    print("cannot open manifest: " .. manifestPath)
    return false
  end
  local dir = manifestPath:match("^(.*)/[^/]+$") or "."
  for line in fh:lines() do
    local entry = line:gsub("\\", "/"):gsub("%s+$", "")
    local first = entry:sub(1, 1)
    -- skip comments and meta stuff and check extension
    if first ~= "#" and first ~= ";" and entry ~= "" and entry:sub(-4) == ".lua" and not entry:find("%$%(") then
      local path = join(dir, entry)
      local probe = io.open(path, "r")
      if not probe then
        print("[skip] not present: " .. path)
      else
        probe:close()
        local ok, err = pcall(dofile, path)
        if not ok then
          -- permission issues?
          print("[load error] " .. path .. ": " .. tostring(err))
        end
      end
    end
  end
  fh:close()
  return true
end

-- stubs must be loaded first
dofile(join(repoRoot, ".scripts", "test_stubs.lua"))

-- AddOn load order matters
loadAddon(join(tanethDir, "Taneth.txt"))
loadAddon(join(repoRoot, "FurnitureCatalogue.txt"))
loadAddon(join(repoRoot, "FurnitureCatalogue_DevUtility", "FurnitureCatalogue_DevUtility.txt"))

FurCDev.repoRoot = repoRoot

-- fire EVENT_ADD_ON_LOADED foreach AddOn
for _, name in ipairs({ "FurnitureCatalogue", "FurnitureCatalogue_DevUtility" }) do
  eso.TriggerEvent(EVENT_ADD_ON_LOADED, name)
end
eso.HandleNextFrame()

local fails = 0

if #suiteIds == 0 then
  -- no named suites, run them all
  local real_d = d
  _G.d = function(msg)
    real_d(msg)
    if type(msg) == "string" then
      local failures, errors = msg:match("(%d+) failures / (%d+) errors")
      if failures then
        fails = fails + tonumber(failures) + tonumber(errors)
      end
      if msg:match("^Failed to run suite") then
        fails = fails + 1
      end
    end
  end
  Taneth:RunAll(function()
    eso.ClearAllEventsAndUpdates()
  end)
  _G.d = real_d
else
  -- if using named suites
  local runs = suiteIds
  Taneth:RunTestSuites(runs, function()
    eso.ClearAllEventsAndUpdates()
  end)
  for _, stats in ipairs(runs) do
    if type(stats) == "table" then
      if stats.error then
        fails = fails + 1
      else
        fails = fails + (stats.failureCount or 0) + (stats.errorCount or 0)
      end
    end
  end
end

os.exit(fails > 0 and 1 or 0)
