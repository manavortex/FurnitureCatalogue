-- Public consumer API
-- Use those functions to get furniture data
--
-- Which endpoint to use:
--   is this item in the DB   Has
--   everything about 1 item  GetEntry
--   does it have source X    entry.sources[X], a set
--   vendor, price, version   GetSourceDetails, one record per source
--   ready-made tooltip text  GetItemDescription
--   walk the whole DB        GetItemIds, then GetEntry per id
--   react to a DB rebuild    OnReady, RegisterCallback, GetDBRevision

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
---```lua
---local API = LibFurnitureCatalogue.API
---
---local function onChange(_, revision) d("db changed, revision " .. revision) end
---API.RegisterCallback(API.Events.CHANGE, onChange) --> true
---```
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
---```lua
---API.UnregisterCallback(API.Events.CHANGE, onChange) --> true
---API.UnregisterCallback(API.Events.CHANGE, onChange) --> false, already gone
---```
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
---@return FurCEntry? entry copy, nil when the item is not in the DB
---@see LibFurnitureCatalogue.API.GetSourceDetails for vendor, price and version per source
---```lua
---local src = API.GetSourceTypes()
---local entry = API.GetEntry(203600)
---
---entry.origin  --> 6, top-ranked source, see GetSourceTypes
---entry.version --> 32, see GetDataVersions
---
----- sources is a SET of source types, so membership is just 1 lookup
---entry.sources --> { [6] = true, [7] = true, [13] = true }
---entry.sources[src.PVP] --> true
---
---API.GetEntry(99123456) --> nil
---```
function api.GetEntry(itemOrLink)
  local entry = find(itemOrLink)
  if nil == next(entry) then
    return nil
  end
  return ZO_DeepTableCopy(entry)
end

---@param itemOrLink string|integer
---@return boolean
---```lua
---API.Has(134686)   --> true
---API.Has(99123456) --> false
---```
function api.Has(itemOrLink)
  return next(find(itemOrLink)) ~= nil
end

---@return integer[] itemIds snapshot of every item id in the DB
---```lua
---local ids = API.GetItemIds()
---
---#ids   --> 8536
---ids[1] --> 118061
---```
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
---Every source of an item, one record per source, ranked best-first
---@param itemOrLink string|integer
---@return { source: { type: integer, vendor: string?, location: string?, achievement: integer?, event: string? }, cost: { currency: integer, amount: integer }?, availability: { version: integer, lastSeen: string? } }[]
---```lua
---local src = API.GetSourceTypes()
---
----- 203600 has three: vendor, writ vendor and pvp
---for _, record in ipairs(API.GetSourceDetails(203600)) do
---  record.source.type              --> 6, then 13, then 7
---  record.source.vendor            --> "Faustina Curio" on the writ vendor one
---  record.availability.version     --> 32, see GetDataVersions
---
---  -- one price per source, nil when the source has no price. A source that
---  -- takes two currencies is modelled as two sources, not two prices
---  if record.cost then
---    record.cost.currency --> 12, then 4, then 2
---    record.cost.amount   --> 30000, then 800, then 1000000
---  end
---
---  if record.source.type == src.CRAFTING then
---    d("craftable, see GetIngredients")
---  end
---end
---
----- just checking membership? the entry answers it in one lookup
---API.GetEntry(203600).sources[src.CRAFTING] --> true
---```
function api.GetSourceDetails(itemOrLink)
  return getSourceRecords(itemOrLink)
end

---@return integer libVersion the lib's AddOnVersion
---```lua
---API.GetVersion() --> 10000
---```
function api.GetVersion()
  return LFC.version
end

---Build counter, starts at 0 and rises on every DB build. Unrelated to entry count
---@return integer revision
---```lua
---if API.GetDBRevision() ~= myCachedRevision then
---  myCache, myCachedRevision = {}, API.GetDBRevision()
---end
---```
function api.GetDBRevision()
  return internal.DBRevision
end

---Current database lifecycle state and the most recent build error, if any
---@return LFCDBState state
---@return string? error
---```lua
---local state, err = API.GetState()
---
---state --> "ready", one of API.State
---err   --> nil, or the build error while state is API.State.FAILED
---```
function api.GetState()
  return lifecycle.current, lifecycle.error
end

---@return boolean ready true while a complete DB snapshot is available
---```lua
---API.IsReady() --> true
---```
function api.IsReady()
  return lifecycle.current == state.READY
end

---Run once after a complete DB snapshot is available
---Calls immediately when already ready; otherwise starts the lazy build and waits.
---@param callback fun(api: table, revision: integer)
---@return boolean accepted
---```lua
---API.OnReady(function(_, revision)
---  d(API.GetEntryCount() .. " items at revision " .. revision)
---end) --> true
---```
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
---@return integer count number of items in the DB
---```lua
---API.GetEntryCount() --> 8536
---```
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
---```lua
---API.GetItemId("|H1:item:134686:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") --> 134686
---API.GetItemId(134686) --> 134686
---```
function api.GetItemId(itemLinkOrId)
  return getItemId(itemLinkOrId)
end

---Build item link from id, or pass through an existing link
---@param itemOrId string|integer
---@return string link empty string on invalid
---```lua
---API.GetItemLink(134686) --> "|H1:item:134686:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---```
function api.GetItemLink(itemOrId)
  return getItemLink(itemOrId)
end

-- Query helpers

---Ingredient list for a recipe
---@param itemLink string item or blueprint link
---@param recipeArray? FurCEntry entry from GetEntry; looked up when omitted
---@return table<string, integer> ingredients map of ingredient link -> quantity
---```lua
---local mats = API.GetIngredients(API.GetItemLink(itemId), API.GetEntry(itemId))
---
----- keyed by ingredient LINK, not by item id, empty when not craftable
---for ingredientLink, quantity in pairs(mats) do
---  d(quantity .. "x " .. GetItemLinkName(ingredientLink)) --> "6x Rough Oak"
---end
---```
function api.GetIngredients(itemLink, recipeArray)
  return getIngredients(itemLink, recipeArray)
end

---Human-readable description for a primary source
---Structured consumers should prefer GetSourceDetails
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry looked up via GetEntry when omitted
---@param stripColor? boolean strip colour control characters
---@param opts? { dateFormat?: string } render options, for instance luxury date format
---@return string description localised, empty when the item is not in the DB
---```lua
---API.GetItemDescription(134686, API.GetEntry(134686), true)
----->  "|H1:item:134686:...|h|h 2,000"
---```
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
---for _, record in ipairs(API.GetSourceDetails(139136)) do
---  if record.source.type == src.VENDOR then
---    d(record.cost.amount) --> 100
---  end
---end
---```
function api.GetSourceTypes()
  return ZO_ShallowTableCopy(internal.Constants.ItemSources)
end

---Game version enum values
---@return table<string, integer> versions fresh copy, yours to keep
---```lua
---local API = LibFurnitureCatalogue.API
---local ver = API.GetDataVersions()
---
---ver.HOMESTEAD --> 2
---ver.LATEST    --> 40
---
---for _, record in ipairs(API.GetSourceDetails(itemLink)) do
---  if record.availability.version == ver.LATEST then
---    d("added this update")
---  end
---end
---```
function api.GetDataVersions()
  return ZO_ShallowTableCopy(internal.Constants.Versioning)
end

-- Bridge helpers
-- These exist so third-party AddOns can migrate off raw FurC.* table access before DB is converted to structured records

---Temporary compatibility bridge for prices hidden in baked strings
---Stable, multi-source prices in api.GetSourceDetails().
---@deprecated Migrate to GetSourceDetails()
---Returns (currency, amount) or nil. Will be removed
---@param itemId integer
---@param version integer
---@param source integer source type constant, see GetSourceTypes
---@return integer? currency ESO currency constant
---@return integer? amount
---```lua
---local currency, amount = API.GetMiscItemPrice(134686, 6, API.GetSourceTypes().CROWN)
---
---currency --> 7, CURT_CROWNS
---amount   --> 2000
---
---API.GetMiscItemPrice(99123456, 1, API.GetSourceTypes().CROWN) --> nil
---```
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
