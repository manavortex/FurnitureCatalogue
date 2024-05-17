-- Utilities and often used functions

FurC = FurC or {}

local this = {}

-- TABLE UTILS --

--- Merges Table2 into Table1, mutates Table1 inplace and replaces its values if they have the same key. Example: merge({a="1",b="3"},{b="2"}) => {a="1",b="2"}
--- @param t1 any
--- @param t2 any
--- @see ZO_CombineNonContiguousTables (for no entry replacement)
--- @return table
function this.MergeTable(t1, t2)
  if nil == t2 and nil == t1 then
    return {}
  elseif nil == t2 then
    return t1
  elseif nil == t1 then
    return t2
  end

  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

-- ruthlessly stolen from TextureIt
--- Sorts table by given key
--- @return table sortedTable
function this.SortTable(tTable, sortKey, SortOrderUp)
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

-- STRING UTILS --

function this.capitalise(str)
  str = str:gsub("^(%l)(%w*)", function(a, b)
    return LocaleAwareToUpper(a) .. b
  end)
  return str
end

-- TODO #REFACTOR: make more flexible
function this.stripColour(aString)
  if nil == aString then
    return ""
  end
  return aString:gsub("|%l%l%d%d%d%d%d", ""):gsub("|%l%l%d%l%l%d%d", ""):gsub("|c25C31E", ""):gsub("", "")
end

-- TODO #REFACTOR: remove/change ret param
-- TODO #REFACTOR: don't replace with thousands here, that should happen earlier
function this.Colourise(txt, colourCode, ret)
  txt = tostring(txt)
  if txt:find("%d000$") then
    txt = txt:gsub("000$", "k")
  end
  if ret then
    return txt
  end
  return string.format("|c%s%s|r", colourCode, txt)
end

---Join multiple strings with a custom concatenation string
---@param strings table
---@param conjunction string|nil (optional) like `, ` (defaults to ` or `)
---@return string
function this.Join(strings, conjunction)
  if not strings or #strings == 0 then
    return ""
  end

  conjunction = conjunction or (" " .. GetString(SI_FURC_OR) .. " ")
  return table.concat(strings, conjunction)
end

-- GAME UTILS --

-- TODO #REFACTOR: collecting those in 1 place for now, move later, make some available in API

---Get the current character name in desired format
---@return string
function this.GetCurrentChar()
  return zo_strformat(GetUnitName("player"))
end

local colours = FurC.ItemLinkColours
local currencies = {
  [CURT_NONE] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_NONE),
  },
  [CURT_MONEY] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_MONEY),
  },
  [CURT_ALLIANCE_POINTS] = {
    colour = colours.AP,
    name = GetCurrencyName(CURT_ALLIANCE_POINTS),
  },
  [CURT_TELVAR_STONES] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_TELVAR_STONES),
  },
  [CURT_WRIT_VOUCHERS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_WRIT_VOUCHERS),
  },
  [CURT_CHAOTIC_CREATIA] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CHAOTIC_CREATIA),
  },
  [CURT_CROWN_GEMS] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CROWN_GEMS),
  },
  [CURT_CROWNS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_CROWNS),
  },
  [CURT_STYLE_STONES] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_STYLE_STONES),
  },
  [CURT_EVENT_TICKETS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_EVENT_TICKETS),
  },
  [CURT_UNDAUNTED_KEYS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_UNDAUNTED_KEYS),
  },
  [CURT_ENDEAVOR_SEALS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_ENDEAVOR_SEALS),
  },
}

function this.FormatPrice(price, currency_id)
  local priceUnknown = "?"
  local priceString = ((not price or price < 0) and priceUnknown) or tostring(price)

  local currency = currencies[currency_id]
  priceString = this.Colourise(priceString, currency.colour)

  return zo_strformat("<<1>> (<<2>>)", currency.name, priceString)
end

function this.FormatPartOf(itemid, note)
  if not itemid or itemid == 0 then
    return ""
  end

  local itemLink = this.GetItemLink(itemid)

  local result_str = zo_strformat(GetString(SI_FURC_PART_OF), itemLink)
  if note then
    return result_str .. " - " .. note
  end

  return result_str
end

local prepDefault = GetString(SI_FURC_GRAMMAR_LOC_PREP_DEFAULT)
---Format a location string containing an optional preposition like "Summerset^on".
---<br>Will remove the preposition by default.
---@param locRef string location reference like SI_FURC_LOC_SUMMERSET, saved as "Summerset^on"
---@param showPrep boolean|nil show the preposition, defaults to false
---@return string locStr location with or without preposition, like "on Summerset" and "Summerset"
function this.GetLocationString(locRef, showPrep)
  local format = GetString(SI_FURC_GRAMMAR_WORDORDER_LOC)
  local locStr = GetString(locRef)

  -- if the translation contains a preposition, get it out of the location string
  local preposition = prepDefault
  local prepIndex = string.find(locStr, "^")
  if prepIndex then
    preposition = string.sub(locStr, prepIndex + 1)
    locStr = string.sub(locStr, 1, prepIndex - 1)
  end

  if showPrep then
    return zo_strformat(format, preposition, locStr)
  else
    return locStr
  end
end

-- TODO #INVESTIGATE: GetZoneNameById, GetZoneNameByIndex for all map available zones?

---Get the plural or singular form of an NPC type
---@param stringRef string reference like SI_FURC_NPC_GUARD, saved as "singular;plural" or "1form"
---@param singular boolean|nil request singular form
---@return string npcString plural form
function this.GetNPCString(stringRef, singular)
  local npcType = GetString(stringRef) -- incoming like "guard;guards"

  -- Return the full translation stringId if we don't have singular+plural
  local colonIndex = npcType:find(";")
  if not colonIndex then
    return npcType
  end
  if singular then
    npcType = string.sub(npcType, 1, colonIndex - 1)
  else
    npcType = string.sub(npcType, colonIndex + 1)
  end
  return npcType
end

local vendorString = GetString(SI_FURC_STRING_VENDOR)

---comment
---@param vendorRef string vendor string like SI_FURC_TRADERS_NALIRSEWEN
---@param locRefs table locations with optional hierarchies like {*_ZONE, *_PLACE, *_SHOP}
---@param price any
---@param requirement any
---@return string
function this.SoldBy(vendorRef, locRefs, price, requirement)
  return zo_strformat(
    vendorString,
    this.Colourise(vendorRef, colours.Vendor, this.stripColour),
    this.Colourise(locRefs, colours.Vendor, this.stripColour),
    this.Colourise(price, colours.Gold, this.stripColour),
    requirement
  )
end

-- FURNITURE UTILS --

---Check if item is a furnishing
---@param itemLink string
---@return boolean isFurniture
function this.IsFurniture(itemLink)
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)
  return isRecipe or IsItemLinkPlaceableFurniture(itemLink)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param itemLink string
---@return string blueprintLink or empty string
function this.GetBlueprintForItem(itemLink)
  if IsItemLinkFurnitureRecipe(itemLink) then
    return itemLink
  end
  local blueprintId = FurC.DB[GetItemLinkItemId(itemLink)].blueprint
  return this.GetItemLink(blueprintId)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param blueprintLink string
---@return string itemLink or empty string
function this.GetItemFromBlueprint(blueprintLink)
  if IsItemLinkPlaceableFurniture(blueprintLink) then
    return blueprintLink
  end
  return GetItemLinkRecipeResultItemLink(blueprintLink)
end

-- GetItemLinkItemId doesn't work the way I need it
-- TODO #REFACTOR: should only take one type of link (not nil, number, string, links)
function this.GetItemId(itemLink)
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
FurC.GetItemId = this.GetItemId

--- Get item link from itemId (or itemLink)
--- @param item number|string ID or itemlink
--- @return string link or empty string
function this.GetItemLink(item)
  if not item or (type(item) ~= "number" and type(item) ~= "string") then
    return ""
  end

  if type(item) == "number" then
    return zo_strformat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", item)
  end

  local itemId = GetItemLinkItemId(item)
  if itemId == 0 then
    -- invalid, let's clean it up
    return ""
  end

  -- already a link, nothing to do
  return item
end

-- OTHER --

-- make available for use and autocompletion
FurC.Utils = this
