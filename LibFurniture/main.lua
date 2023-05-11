LibFurniture = {
  name = "LibFurniture",
  author = "wookiefriseur",
  tag = "LibFur",
  version = 1.0,
  settings = { debug = true },
  internal = {}
}

local lib = LibFurniture

local logger
--- Gets the current logger or creates it if it doesn't exist yet
--- @return Logger logger instance
local function getLogger()
  if logger then return logger end -- return existing reference

  if not LibDebugLogger then
    local function ignore(...)
    end -- black hole for most property calls, like logger:Debug
    local function info(self, ...)
      local prefix = string.format("[%s]: ", lib.tag)
      if tostring(...):find("%%") then
        d(prefix .. string.format(...))
      else
        d(prefix .. tostring(...))
      end
    end
    logger = {}
    logger.Verbose = ignore
    logger.Debug = ignore
    logger.Info = info
    logger.Warn = ignore
    logger.Error = ignore
    logger.Log = ignore
    return logger
  end

  -- use logger from library
  logger = LibDebugLogger(lib.tag)

  -- set initial log level
  if lib.settings.debug then
    logger:SetMinLevelOverride(logger.LOG_LEVEL_DEBUG)
  else
    logger:SetMinLevelOverride(logger.LOG_LEVEL_INFO)
  end

  return logger
end
lib.internal.Logger = logger

local function init(eventIt, addOnName)
  if lib.name ~= addOnName then return end
  logger = getLogger()
  lib.internal.Logger = logger
end

EVENT_MANAGER:RegisterForEvent(lib.name, EVENT_ADD_ON_LOADED, init)
