-- Public consumer API
-- Use those functions to get furniture data

local LFC = LibFurnitureCatalogue
local api = LFC.API
local internal = LFC.Internal

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

---@return boolean ready true once the first scan completed
function api.IsReady()
  return internal.DBReady == true
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
