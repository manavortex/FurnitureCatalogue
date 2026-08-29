-- Public consumer API
-- Use those functions to get furniture data

local LFC = LibFurnitureCatalogue
local api = LFC.API
local internal = LFC.Internal
local lifecycle = internal.Lifecycle
local state = lifecycle.State

local fmt, query = internal.Format, internal.Query
local getItemId, getItemLink = fmt.GetItemId, fmt.GetItemLink
local find, getSourceRecords = query.Find, query.GetSourceRecords
local getIngredients, getItemDescription = query.GetIngredients, query.GetItemDescription
local getMiscItemPrice = query.GetMiscItemPrice
local ensureDB = internal.Build.EnsureDB

api.State = {
  UNINITIALIZED = state.UNINITIALIZED,
  BUILDING = state.BUILDING,
  READY = state.READY,
  FAILED = state.FAILED,
}

-- Declared in Constants.lua because of load order
api.Events = internal.Constants.ApiEvents

local knownEvents = {}
for _, eventName in pairs(api.Events) do
  knownEvents[eventName] = true
end

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
  if not knownEvents[eventName] then
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
---Every callback receives the api table first, then the event payload:
---`(api)`: SCAN_STARTED
---`(api, revision)`: CHANGE, READY, SCAN_COMPLETE
---`(api, errorString)`: SCAN_FAILED
---@param eventName string one of API.Events
---@param callback function
---@param arg? any optional first callback argument, callback sees `(arg, api, ...)`
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

---Fire one public event
---@param eventName string
---@param ... any payload appended after the api table
function internal.PublishEvent(eventName, ...)
  local registry = lifecycle.callbacks[eventName]
  if not registry then
    return
  end
  -- Snapshot registrations so callbacks may safely unregister while firing.
  local snapshot = {}
  for index, registration in ipairs(registry) do
    snapshot[index] = registration
  end
  for _, registration in ipairs(snapshot) do
    invokeCallback(eventName, registration.callback, registration.arg, api, ...)
  end
end

---Drain OnReady queue, then fire READY callbacks
---@param revision integer
function internal.PublishReady(revision)
  local waiters = lifecycle.readyWaiters
  lifecycle.readyWaiters = {}
  for callback in pairs(waiters) do
    invokeCallback(api.Events.READY, callback, nil, api, revision)
  end
  internal.PublishEvent(api.Events.READY, revision)
end

---Snapshot of one DB entry
---@param itemOrLink string|integer item link, blueprint link, or itemId
---@return FurCEntry? entry copy, nil when unknown
function api.GetEntry(itemOrLink)
  local entry = find(itemOrLink)
  if nil == next(entry) then
    return nil
  end
  return ZO_DeepTableCopy(entry)
end

---@param itemOrLink string|integer
---@return boolean
function api.Has(itemOrLink)
  return next(find(itemOrLink)) ~= nil
end

---@return integer[] itemIds snapshot of all known item ids
function api.GetItemIds()
  local ids = {}
  for id in pairs(internal.DB) do
    -- malformed data files can leave string keys behind; the contract is numeric
    if type(id) == "number" then
      ids[#ids + 1] = id
    end
  end
  return ids
end

--TODO: add luadoc types for our constants for better autocomplete
---Every source of an item, ranked best-first
---@param itemOrLink string|integer
---@return { source: { type: integer, vendor: string?, location: string?, achievement: integer?, event: string? }, cost: { currency: integer, amount: integer }[], availability: { version: integer, lastSeen: string? } }[]
function api.GetSources(itemOrLink)
  return getSourceRecords(itemOrLink)
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
    invokeCallback(api.Events.READY, callback, nil, api, internal.DBRevision)
    return true
  end
  lifecycle.readyWaiters[callback] = true
  if lifecycle.current == state.UNINITIALIZED then
    ensureDB()
  end
  return true
end

local countRevision, countMemo
---@return integer count number of known items
function api.GetEntryCount()
  if countRevision ~= internal.DBRevision then
    countRevision = internal.DBRevision
    local count = 0
    for id in pairs(internal.DB) do
      -- keep in step with GetItemIds: only numeric keys are real entries
      if type(id) == "number" then
        count = count + 1
      end
    end
    countMemo = count
  end
  return countMemo
end

-- Utility

---Resolve an item link or numeric id to a numeric item id
---@param itemLinkOrId string|integer
---@return integer? id nil on empty/invalid
function api.GetItemId(itemLinkOrId)
  return getItemId(itemLinkOrId)
end

---Build item link from id, or pass through an existing link
---@param itemOrId string|integer
---@return string link empty string on invalid
function api.GetItemLink(itemOrId)
  return getItemLink(itemOrId)
end

-- Query helpers

---Ingredient list for a recipe
---@param itemLink string item or blueprint link
---@param recipeArray? FurCEntry entry from GetEntry; looked up when omitted
---@return table<string, integer> ingredients map of ingredient link -> quantity
function api.GetIngredients(itemLink, recipeArray)
  return getIngredients(itemLink, recipeArray)
end

---Human-readable description for a primary source
---Structured consumers should prefer GetSources
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry looked up via GetEntry when omitted
---@param stripColor? boolean strip colour control characters
---@param opts? { dateFormat?: string } render options, for instance luxury date format
---@return string description empty when unknown
function api.GetItemDescription(recipeKey, recipeArray, stripColor, opts)
  return getItemDescription(recipeKey, recipeArray, stripColor, opts)
end

-- Constants

---Source type enum values. Compare against constant, the numbers shift
---@return table<string, integer> sourceTypes fresh copy, yours to keep
---```lua
---local API = LibFurnitureCatalogue.API
---local src = API.GetSourceTypes()
---
---src.CROWN --> 9
---src.DROP  --> 14
---
---for _, record in ipairs(API.GetSources(itemLink)) do
---  if record.source.type == src.CROWN then
---    d(record.cost[1].amount) --> 2000
---  end
---end
---```
function api.GetSourceTypes()
  return ZO_ShallowTableCopy(internal.Constants.ItemSources)
end

-- Bridge helpers
-- These exist so third-party AddOns can migrate off raw FurC.* table access before DB is converted to structured records

---Temporary compatibility bridge for prices hidden in baked strings
---Stable, multi-source prices in api.GetSources().
---@deprecated Migrate to GetSources()
---Returns (currency, amount) or nil. Will be removed
---@param itemId integer
---@param version integer
---@param source integer source type constant, see GetSourceTypes
---@return integer? currency ESO currency constant
---@return integer? amount
function api.GetMiscItemPrice(itemId, version, source)
  return getMiscItemPrice(itemId, version, source)
end

-- Legacy flat aliases for third-party AddOns

---@deprecated Use LibFurnitureCatalogue.API.GetItemId
FurC.GetItemId = api.GetItemId

---@deprecated Use LibFurnitureCatalogue.API.GetItemLink
FurC.GetItemLink = api.GetItemLink

---@deprecated Use LibFurnitureCatalogue.API.GetIngredients
FurC.GetIngredients = api.GetIngredients

---@deprecated Use LibFurnitureCatalogue.API.GetItemDescription
FurC.GetItemDescription = api.GetItemDescription

---@deprecated Use LibFurnitureCatalogue.API.GetEntry. Unlike GetEntry, this
---returns the mutable internal row and an empty table on a miss.
FurC.Find = internal.Query.Find

---@deprecated Use LibFurnitureCatalogue.API.GetIngredients and format the
---ingredient map in the consumer.
FurC.GetMats = internal.Query.GetMats
