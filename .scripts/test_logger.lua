-- Standalone startup regression: lua .scripts/test_logger.lua
local startup = arg[1] or ((arg[0]:match("^(.*)/") or ".") .. "/../Startup.lua")

local function enum()
  local nextId = 0
  return setmetatable({}, {
    __index = function(self, key)
      nextId = nextId + 1
      rawset(self, key, nextId)
      return nextId
    end,
  })
end

local checks = 0
local function check(label, build, healthy)
  local calls, registered, output = 0, false, {}
  local instance = {
    SetMinLevelOverride = function(self, level)
      self.level = level
    end,
  }
  local lib
  if build then
    lib = setmetatable({ LOG_LEVEL_INFO = "info", LOG_LEVEL_DEBUG = "debug" }, {
      __call = function()
        calls = calls + 1
        return build(instance)
      end,
    })
  end
  local env = setmetatable({
    LibDebugLogger = lib,
    LibFurnitureCatalogue = { API = { GetSourceTypes = enum, GetDataVersions = enum } },
    GetString = function()
      return ""
    end,
    ZO_CreateStringId = function() end,
    EVENT_ADD_ON_LOADED = 1,
    EVENT_MANAGER = {
      RegisterForEvent = function(_, name, event, callback)
        registered = name == "FurnitureCatalogue" and event == 1 and type(callback) == "function"
      end,
    },
    d = function(message)
      output[#output + 1] = message
    end,
  }, { __index = _G })
  local chunk = assert(loadfile(startup))
  setfenv(chunk, env)
  local ok, err = pcall(chunk)
  assert(ok, label .. ": " .. tostring(err))
  assert(registered, label .. ": startup did not register its initialization callback")
  local logger = env.FurC.Logger
  assert(type(logger) == "table", label .. ": missing logger")
  assert(env.FurC.getOrCreateLogger() == logger, label .. ": logger was not cached")
  assert(calls == (build and 1 or 0), label .. ": builder was retried")
  if healthy then
    assert(logger == instance and logger.level == "info", label .. ": healthy logger was replaced or not configured")
  else
    for _, method in ipairs({ "Verbose", "Debug", "Warn", "Error", "Log", "SetMinLevelOverride" }) do
      logger[method](logger, "test")
    end
    logger:Info("fallback %s", "works")
    assert(output[1] == "[FurC]: fallback works", label .. ": fallback Info failed")
    assert(#output == 1, label .. ": fallback emitted unexpected messages")
  end
  checks = checks + 1
  print("PASS: " .. label)
end

check("no library", nil)
check("healthy library", function(instance)
  return instance
end, true)
check("constructor error", function()
  error("missing LogPerformance")
end)
check("constructor assertion", function()
  assert(false, "logger initialization failed")
end)
check("constructor returns nil", function()
  return nil
end)
check("configuration assertion", function(instance)
  instance.SetMinLevelOverride = function()
    assert(false, "logger configuration failed")
  end
  return instance
end)
print(checks .. " logger startup checks passed")
