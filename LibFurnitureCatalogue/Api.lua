-- Public consumer API
-- Use those functions to get furniture data

local LFC = LibFurnitureCatalogue
local api = LFC.API
local internal = LFC.Internal
local lifecycle = internal.Lifecycle
local state = lifecycle.State

api.State = {
  UNINITIALIZED = state.UNINITIALIZED,
  BUILDING = state.BUILDING,
  READY = state.READY,
  FAILED = state.FAILED,
}

api.Events = {
  CHANGE = "LFC_DATABASE_CHANGED",
}

local function logCallbackError(eventName, err)
  local ok, logger = pcall(internal.GetLogger)
  if ok then
    pcall(logger.Error, logger, "Public callback %s failed: %s", eventName, tostring(err))
  end
end

local function invokeCallback(eventName, callback, callbackArg, ...)
  local ok, err
  if callbackArg ~= nil then
    ok, err = pcall(callback, callbackArg, ...)
  else
    ok, err = pcall(callback, ...)
  end
  if not ok then
    logCallbackError(eventName, err)
  end
end

local function callbackRegistry(eventName)
  if eventName ~= api.Events.CHANGE then
    return nil
  end
  local registry = lifecycle.callbacks[eventName]
  if not registry then
    registry = {}
    lifecycle.callbacks[eventName] = registry
  end
  return registry
end

local function findRegistration(registry, callback, arg)
  for index, registration in ipairs(registry) do
    if registration.callback == callback and registration.arg == arg then
      return index
    end
  end
end

---Register a persistent lifecycle callback
---@param eventName string one of API.Events
---@param callback function receives `(api, revision)`, or `(arg, api, revision)`
---@param arg? any optional first callback argument
---@return boolean registered
function api.RegisterCallback(eventName, callback, arg)
  local registry = callbackRegistry(eventName)
  if not registry or type(callback) ~= "function" then
    return false
  end
  if not findRegistration(registry, callback, arg) then
    registry[#registry + 1] = { callback = callback, arg = arg }
  end
  return true
end

---Unregister a persistent lifecycle callback
---@param eventName string one of API.Events
---@param callback function
---@param arg? any optional argument used during registration
---@return boolean removed
function api.UnregisterCallback(eventName, callback, arg)
  local registry = callbackRegistry(eventName)
  if not registry or type(callback) ~= "function" then
    return false
  end
  local index = findRegistration(registry, callback, arg)
  if not index then
    return false
  end
  table.remove(registry, index)
  return true
end

local function publishChange(revision)
  local registry = lifecycle.callbacks[api.Events.CHANGE]
  if not registry then
    return
  end
  -- Snapshot registrations so callbacks may safely unregister while firing.
  local snapshot = {}
  for index, registration in ipairs(registry) do
    snapshot[index] = registration
  end
  for _, registration in ipairs(snapshot) do
    invokeCallback(api.Events.CHANGE, registration.callback, registration.arg, api, revision)
  end
end

local function publishReady(revision)
  local waiters = lifecycle.readyWaiters
  lifecycle.readyWaiters = {}
  for callback in pairs(waiters) do
    invokeCallback("LFC_READY", callback, nil, api, revision)
  end
end

function internal.PublishLifecycleSuccess(publishedBefore, revision)
  publishReady(revision)
  if publishedBefore then
    publishChange(revision)
  end
end

---Snapshot of one DB entry
---@param itemOrLink string|integer item link, blueprint link, or itemId
---@return FurCEntry? entry copy, nil when unknown
function api.GetEntry(itemOrLink)
  local entry = internal.Query.Find(itemOrLink)
  if nil == next(entry) then
    return nil
  end
  return ZO_DeepTableCopy(entry)
end

---@param itemOrLink string|integer
---@return boolean
function api.Has(itemOrLink)
  return next(internal.Query.Find(itemOrLink)) ~= nil
end

---@return integer[] itemIds snapshot of all known item ids
function api.GetItemIds()
  local ids = {}
  for id in pairs(internal.DB) do
    ids[#ids + 1] = id
  end
  return ids
end

--TODO: add luadoc types for our constants for better autocomplete
---Every source of an item, ranked best-first
---@param itemOrLink string|integer
---@return { source: { type: integer, vendor: string?, location: string?, achievement: integer?, event: string? }, cost: { currency: integer, amount: integer }[], availability: { version: integer, lastSeen: string? } }[]
function api.GetSources(itemOrLink)
  return internal.Query.GetSourceRecords(itemOrLink)
end

---@return integer libVersion the lib's AddOnVersion
function api.GetVersion()
  return LFC.version
end

---@return integer revision DB change counter (for cache invalidation)
function api.GetDBRevision()
  return internal.DBRevision
end

---Current database lifecycle state and the most recent build error, if any
---@return LFCDBState state
---@return string? error
function api.GetState()
  return lifecycle.current, lifecycle.error
end

---@return boolean ready true while a complete DB snapshot is available
function api.IsReady()
  return lifecycle.current == state.READY
end

---Run once after a complete DB snapshot is available
---Calls immediately when already ready; otherwise starts the lazy build and waits.
---@param callback fun(api: table, revision: integer)
---@return boolean accepted
function api.OnReady(callback)
  if type(callback) ~= "function" then
    return false
  end
  if api.IsReady() then
    invokeCallback("LFC_READY", callback, nil, api, internal.DBRevision)
    return true
  end
  lifecycle.readyWaiters[callback] = true
  if lifecycle.current == state.UNINITIALIZED then
    internal.Build.EnsureDB()
  end
  return true
end

local countRevision, countMemo
---@return integer count number of known items
function api.GetEntryCount()
  if countRevision ~= internal.DBRevision then
    countRevision = internal.DBRevision
    countMemo = NonContiguousCount(internal.DB)
  end
  return countMemo
end
