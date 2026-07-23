-- FurC.Internal helper namespace. Not an API, could change at any time.

FurC = FurC or {}
FurC.Internal = FurC.Internal or {}
local this = FurC.Internal

-- LCK reference, nil when no LCK loaded
---@type LibCharacterKnowledge
local _lck = nil

-- character names for filter
local _charCache = nil

local function lckAvailable()
  return _lck ~= nil
end
this.LCKAvailable = lckAvailable

-- Core LCK API we call unconditionally.
local LCK_REQUIRED_FUNS = {
  "RegisterForCallback",
  "GetServerList",
  "GetCharacterList",
  "GetItemKnowledgeForCharacter",
  "GetItemKnowledgeList",
}

local function lckIsUsable(lck)
  if not lck then
    return false
  end
  for _, name in ipairs(LCK_REQUIRED_FUNS) do
    if type(lck[name]) ~= "function" then
      return false
    end
  end
  return lck.KNOWLEDGE_KNOWN ~= nil
    and lck.KNOWLEDGE_UNKNOWN ~= nil
    and lck.EVENT_INITIALIZED ~= nil
    and lck.EVENT_UPDATE_REFRESH ~= nil
end

local function initLCK(lck)
  _charCache = nil
  -- prevent duplicate callback registrations
  if _lck and _lck.UnregisterForCallback then
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_INITIALIZED)
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH)
  end
  _lck = lck or LibCharacterKnowledge
  if not lckIsUsable(_lck) then
    _lck = nil -- incompatible/old LCK, falling back
    return
  end
  -- chars + knowledge empty until LCK has the info
  _lck.RegisterForCallback("FurnitureCatalogue", _lck.EVENT_INITIALIZED, function()
    _charCache = nil
    -- LCK data is now available: default char can finally be applied
    if FurC.ApplyDefaultCharacter then
      FurC.ApplyDefaultCharacter()
    end
    if FurC.RefreshCharacterDropdown then
      FurC.RefreshCharacterDropdown()
    end
    if FurC.UpdateGui then
      zo_callLater(FurC.UpdateGui, 50)
    end
  end)
  -- Regenerate char dropdown when LCK changes char ordering or tracking
  _lck.RegisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH, function(invalidateCharacterList)
    if invalidateCharacterList then
      _charCache = nil
      if FurC.RefreshCharacterDropdown then
        FurC.RefreshCharacterDropdown()
      end
    end
    if FurC.UpdateGui then
      zo_callLater(FurC.UpdateGui, 50)
    end
  end)
end
this.InitLCK = initLCK

-- Only explicit UNKNOWN hides item
-- Deliberately shown: never scanned, not learnable, LCK absent
-- item: itemId (number) or itemLink (string)
local function charKnows(item)
  if not _lck then
    return true
  end
  return _lck.GetItemKnowledgeForCharacter(item) ~= _lck.KNOWLEDGE_UNKNOWN
end
this.CharKnows = charKnows

-- Account-wide: true if any tracked character knows it
local function accountKnows(item)
  if not _lck then
    return true
  end
  local account = GetDisplayName()
  for _, entry in ipairs(_lck.GetItemKnowledgeList(item)) do
    if entry.account == account and entry.knowledge == _lck.KNOWLEDGE_KNOWN then
      return true
    end
  end
  return false
end
this.AccountKnows = accountKnows

-- LCK blueprint tracking is "plans" category
-- 1 == "Do not track"
-- 2...4 == track by quality
-- 0 == use default
local LCK_PLANS_KEY = "plans"
local LCK_TRACKING_OFF = 1

local function tracksFurnishing(server, charId)
  if not _lck.GetRawCharacterSettings then
    return true -- fallback: don't hide any char
  end
  local settings = _lck.GetRawCharacterSettings(server, charId)
  local tracking = settings and settings.tracking and settings.tracking[LCK_PLANS_KEY]
  return tracking ~= LCK_TRACKING_OFF
end

local function ensureCharCache()
  if _charCache then
    return _charCache
  end
  if not _lck then
    return nil
  end
  local server = _lck.GetServerList()[1] -- current server is always first
  local account = GetDisplayName() -- LCK tracks other accounts too, so we filter those out
  local names, idByName = {}, {}
  for _, char in ipairs(_lck.GetCharacterList(server)) do
    if char.account == account and tracksFurnishing(server, char.id) then
      names[#names + 1] = char.name
      idByName[char.name] = char.id
    end
  end
  _charCache = { server = server, names = names, idByName = idByName }
  return _charCache
end

-- Char names for filter dropdown, empty when no LCK
local function getCharacterNames()
  local cache = ensureCharCache()
  return (cache and cache.names) or {}
end
this.GetCharacterNames = getCharacterNames

-- Drop cached char list so we query LCK again
local function invalidateCharacters()
  _charCache = nil
end
this.InvalidateCharacters = invalidateCharacters

local function isKnownByName(item, name)
  if not _lck then
    return nil
  end
  if not name then
    return accountKnows(item)
  end
  local cache = ensureCharCache()
  local charId = cache and cache.idByName[name]
  if not charId then
    return accountKnows(item)
  end
  return _lck.GetItemKnowledgeForCharacter(item, cache.server, charId) == _lck.KNOWLEDGE_KNOWN
end
this.IsKnownByName = isKnownByName

local function getCrafterNames(item)
  if not _lck then
    return nil
  end
  local account = GetDisplayName()
  local names = {}
  for _, entry in ipairs(_lck.GetItemKnowledgeList(item)) do
    if entry.account == account and entry.knowledge == _lck.KNOWLEDGE_KNOWN then
      names[#names + 1] = entry.name
    end
  end
  return names
end
this.GetCrafterNames = getCrafterNames

--[[_______________________
    |                     |
    |    RUNTIME UTILS    |
    |_____________________|]]

FurC.Utils = FurC.Utils or {}
local Utils = FurC.Utils
local sFormat = zo_strformat

-- ruthlessly stolen from TextureIt
--- Sorts table by given key
--- @return table sortedTable
function Utils.SortTable(tTable, sortKey, SortOrderUp)
  --[[
    TODO #REFACTOR:
      - expect function instead of boolean "SortOrderUp"
      - ZO_TableOrderingFunction
      - make generic, not itemlink dependant
  ]]

  local keys = {}
  for k in pairs(tTable) do
    table.insert(keys, k)
  end
  table.sort(keys, function(a, b)
    if nil == tTable[a] or nil == tTable[b] then
    elseif nil == tTable[a][sortKey] then
      return false
    elseif nil == tTable[b][sortKey] then
      return true
    else
      if SortOrderUp then
        return tTable[a][sortKey] > tTable[b][sortKey]
      else
        return tTable[a][sortKey] < tTable[b][sortKey]
      end
    end
    return tTable
  end)

  local ret = {}
  local scannedLinks = {}
  for _, k in ipairs(keys) do
    local entry = tTable[k]
    local itemLink = entry["itemLink"]
    local ingredients = entry["ingredients"]
    local index = scannedLinks[itemLink] or k

    table.insert(ret, entry)
  end

  return ret
end

local currentChar
---Get the current character name in desired format
---@return string
function Utils.GetCurrentChar()
  currentChar = currentChar or sFormat("<<1>>", GetUnitName("player"))
  return currentChar
end

---Check if item is a furnishing
---@param itemLink string
---@return boolean isFurniture
function Utils.IsFurniture(itemLink)
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)
  return isRecipe or IsItemLinkPlaceableFurniture(itemLink)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param itemLink string
---@return string blueprintLink or empty string
function Utils.GetBlueprintForItem(itemLink)
  if IsItemLinkFurnitureRecipe(itemLink) then
    return itemLink
  end
  local entry = FurC.DB[GetItemLinkItemId(itemLink)]
  if not entry or not entry.blueprint then
    return ""
  end
  return Utils.GetItemLink(entry.blueprint)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param blueprintLink string
---@return string itemLink or empty string
function Utils.GetItemFromBlueprint(blueprintLink)
  if IsItemLinkPlaceableFurniture(blueprintLink) then
    return blueprintLink
  end
  return GetItemLinkRecipeResultItemLink(blueprintLink)
end

-- GetItemLinkItemId doesn't work the way I need it
-- TODO #REFACTOR: should only take one type of link (not nil, number, string, links)
function Utils.GetItemId(itemLink)
  if nil == itemLink or "" == itemLink then
    return
  end
  if type(itemLink) == "number" and itemLink > 9999 then
    return itemLink
  end
  local _, _, _, itemId = ZO_LinkHandler_ParseLink(itemLink)
  return tonumber(itemId)
end

-- Alias for LibPrice
---@deprecated will be replaced by API function in the future
---@see FurC.Utils.GetItemId
FurC.GetItemId = Utils.GetItemId
