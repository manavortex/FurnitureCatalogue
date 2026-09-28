-- Text-search index: localised plain strings for search box
-- (built once, lazily, survives DB rebuild)
--
-- Built from Constants and the DB keys, not from description (because the latter has too much trash and raw links)

FurC.SearchIndex = FurC.SearchIndex or {}
local this = FurC.SearchIndex

local LFC = LibFurnitureCatalogue
local getItemLink = LFC.API.GetItemLink
local GetString = GetString
local GetZoneNameById = GetZoneNameById

local lower = LocaleAwareToLower
local stripTxt = FurC.SourceFormat.Strip
local STRIP_CONTROL = FurC.SourceFormat.STRIP_CONTROL
local concat = table.concat
local find = string.find

-- container tables that still have to be managed and indexed by us (so it is searchable)
local CONTAINER_TABLES = { "BookCollections", "FurnishingFolios" }

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

local function build()
  local add, buckets = newBuilder()
  for _, itemId in ipairs(LFC.API.GetItemIds()) do
    for _, record in ipairs(LFC.API.GetSourceDetails(itemId)) do
      local source = record.source
      for _, field in ipairs({ "vendor", "event", "bundle", "itemPack" }) do
        if source[field] then
          add(itemId, GetString(source[field]))
        end
      end
      for _, placement in ipairs(source.locations or {}) do
        if placement.location then
          add(itemId, GetZoneNameById(placement.location))
        end
        if placement.place then
          add(itemId, GetString(placement.place))
        end
      end
      add(itemId, getAchievementName(source.achievement))
      add(itemId, getItemName(source.partOf))
      add(itemId, getItemName(source.container))
      for _, pack in ipairs(source.packs or {}) do
        add(itemId, getItemName(pack))
      end
      if source.crate then
        add(itemId, GetCrownCrateName(source.crate))
      end
    end
  end

  -- A container's name is a search term for everything it holds. Books already name their container through part_of. Folios only hold recipes, whose source records don't name the folio, we have to supply that name
  for _, name in ipairs(CONTAINER_TABLES) do
    for containerId, container in pairs(FurC[name] or {}) do
      local containerName = getItemName(containerId)
      for _, contentId in ipairs(container.contents or {}) do
        add(FurC.DBQuery.ResolveRecipe(contentId), containerName)
      end
    end
  end

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
