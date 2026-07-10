-- Text-search index: localised plain strings for search box
-- (built once, lazily, survives DB rebuild)
--
-- Built from Constants and the DB keys, not from description (because the latter has too much trash and raw links)

FurC.SearchIndex = FurC.SearchIndex or {}
local this = FurC.SearchIndex

local getItemLink = FurC.Utils.GetItemLink
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC

local lower = LocaleAwareToLower
local stripTxt = FurC.Utils.stripTxt
local STRIP_CONTROL = FurC.Utils.STRIP_CONTROL
local concat = table.concat
local find = string.find

-- lowercase built per string, not per row
local loweredCache = {}
local function lowered(text)
  if type(text) ~= "string" or #text == 0 then
    return nil
  end
  local cached = loweredCache[text]
  if nil == cached then
    cached = lower(stripTxt(text, STRIP_CONTROL))
    loweredCache[text] = cached
  end
  return (#cached > 0 and cached) or nil
end

local function isItemLink(text)
  return type(text) == "string" and nil ~= find(text, "|H", 1, true)
end

---Achievement name for an id, lowercased, resolved once per id
---@param achievementId? integer
---@return string? name nil when unresolvable or not an id
local achievementNames = {}
local function getAchievementName(achievementId)
  if type(achievementId) ~= "number" then
    return nil -- in case there is custom text instead of id
  end
  local name = achievementNames[achievementId]
  if nil == name then
    name = lowered(GetAchievementInfo(achievementId)) or ""
    achievementNames[achievementId] = name
  end
  return (#name > 0 and name) or nil
end
this.GetAchievementName = getAchievementName

---Item name for link or id, lowercased, resolved once per key
---Some containers are stored as itemlinks so we extract the name
---@param linkOrId? string|integer
---@return string? name nil when unresolvable
local itemNames = {}
local function getItemName(linkOrId)
  if nil == linkOrId then
    return nil
  end
  local name = itemNames[linkOrId]
  if nil == name then
    local link = (type(linkOrId) == "number" and getItemLink(linkOrId)) or linkOrId
    name = lowered(GetItemLinkName(link)) or ""
    itemNames[linkOrId] = name
  end
  return (#name > 0 and name) or nil
end
this.GetItemName = getItemName

local terms -- "\n"-joined lowercase terms

---Builds set of terms per item
local function newBuilder()
  local buckets, seen = {}, {}
  local function add(itemId, text)
    text = lowered(text)
    if nil == itemId or nil == text then
      return
    end
    local seenHere = seen[itemId]
    if nil == seenHere then
      seenHere = {}
      seen[itemId] = seenHere
      buckets[itemId] = {}
    end
    if not seenHere[text] then
      seenHere[text] = true
      local bucket = buckets[itemId]
      bucket[#bucket + 1] = text
    end
  end
  return add, buckets
end

-- Ach: [version][zone][vendor]
-- PvP: [version][vendor][location]
local function addVendorTables(add)
  for _, versionData in pairs(FurC.AchievementVendors or {}) do
    for zoneName, zoneData in pairs(versionData) do
      for vendorName, vendorData in pairs(zoneData) do
        for itemId, entry in pairs(vendorData) do
          add(itemId, zoneName)
          add(itemId, vendorName)
          if type(entry) == "table" then
            add(itemId, getAchievementName(entry.achievement))
          end
        end
      end
    end
  end

  for _, versionData in pairs(FurC.PVP or {}) do
    for vendorName, vendorData in pairs(versionData) do
      for locationName, locationData in pairs(vendorData) do
        for itemId, entry in pairs(locationData) do
          add(itemId, vendorName)
          add(itemId, locationName)
          if type(entry) == "table" then
            add(itemId, getAchievementName(entry.achievement))
          end
        end
      end
    end
  end

  for _, versionData in pairs(FurC.LuxuryFurnisher or {}) do
    for itemId in pairs(versionData) do
      add(itemId, npc.LUXF)
      add(itemId, loc.COLDH)
    end
  end
end

-- Master Writ stock stored as blueprint id, has to be resolved
local function addWritVendors(add)
  local function addVendorTable(versionedTable, vendorName)
    for _, versionData in pairs(versionedTable or {}) do
      for id, entry in pairs(versionData) do
        local itemId = FurC.DBQuery.ResolveRecipe(id)
        if nil ~= itemId then
          add(itemId, vendorName)
          add(itemId, loc.ANY_CAPITAL)
          if type(entry) == "table" then
            add(itemId, getAchievementName(entry.info))
          end
        end
      end
    end
  end
  addVendorTable(FurC.Rolis, npc.ROLIS)
  addVendorTable(FurC.Faustina, npc.FAUSTINA)
end

local function addFolios(add)
  for folioId, folioData in pairs(FurC.FurnishingFolios or {}) do
    if folioData.contents then
      local folioName = getItemName(folioId)
      for _, contentId in ipairs(folioData.contents) do
        local itemId = FurC.DBQuery.ResolveRecipe(contentId)
        if nil ~= itemId then
          add(itemId, folioName)
          add(itemId, folioData.vendor)
          add(itemId, folioData.location)
        end
      end
    end
  end
end

local function addEvents(add)
  for _, versionData in pairs(FurC.EventItems or {}) do
    for eventName, sources in pairs(versionData) do
      for sourceName, items in pairs(sources) do
        -- we expect NPC name or a container link
        local sourceTerm = (isItemLink(sourceName) and getItemName(sourceName)) or sourceName
        for itemId in pairs(items) do
          add(itemId, eventName)
          add(itemId, sourceTerm)
        end
      end
    end
  end
end

local function build()
  local add, buckets = newBuilder()
  addVendorTables(add)
  addWritVendors(add)
  addFolios(add)
  addEvents(add)

  terms = {}
  for itemId, bucket in pairs(buckets) do
    terms[itemId] = concat(bucket, "\n")
  end
end

---Every searchable source term for an item, nil if it has none
---@param itemId integer
---@return string? terms
function this.GetTerms(itemId)
  if nil == terms then
    build()
  end
  return terms[itemId]
end

---Drops index so the next lookup rebuilds it
function this.Invalidate()
  terms = nil
end
