-- Utilities and often used functions

FurC = FurC or {}

local this = {}

local sJoin = zo_strjoin
local sFormat = zo_strformat

local colours = FurC.Constants.Colours
local currencies = FurC.Constants.Currencies

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

-- TODO #REFACTOR: do it in any zo_strformat calls instead
function this.capitalise(str)
  return LocaleAwareToUpper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

-- TODO #REFACTOR: make more flexible
function this.stripColour(aString)
  if nil == aString then
    return ""
  end
  return aString:gsub("|%l%l%d%d%d%d%d", ""):gsub("|%l%l%d%l%l%d%d", ""):gsub("|c25C31E", ""):gsub("|r", "")
end

-- TODO #REFACTOR: remove/change ret param?
-- TODO builtin colorization function?
local function colourise(txt, colourCode, ret)
  txt = tostring(txt)
  if ret then
    return txt
  end
  return string.format("|c%s%s|r", colourCode, txt)
end
this.Colourise = colourise

-- GAME UTILS --

local currentChar
---Get the current character name in desired format
---@return string
function this.GetCurrentChar()
  currentChar = currentChar or sFormat(GetUnitName("player"))
  return currentChar
end

-- TODO #REFACTOR: collecting those in 1 place for now, move later, make some available in API
-- TODO #REFACTOR maybe: for now separate formatters for each use case for more flexibility, later merge into one

-- TODO #REFACTOR: Use ZO_Currency_Format$Platform
function this.FormatPrice(price, currency_id)
  local priceUnknown = "?"
  local priceString = ((not price or price < 0) and priceUnknown) or tostring(price)

  local currency = currencies[currency_id]
  priceString = this.Colourise(priceString, currency.colour)

  return sFormat("<<1>> (<<2>>)", currency.name, priceString)
end

function this.FormatPartOf(itemid, note)
  if not itemid or itemid == 0 then
    return ""
  end

  local itemLink = this.GetItemLink(itemid)

  local result_str = sFormat(GetString(SI_FURC_PART_OF), itemLink)
  if note then
    return result_str .. " - " .. note
  end

  return result_str
end

local function formatSingleLocation(loc, showPrep)
  if showPrep then
    return sFormat("<<Al:1>>", loc)
  end
  return sFormat("<<1>>", loc)
end

local inStr = GetString(SI_FURC_GRAMMAR_PREP_LOC_DEFAULT) -- "in"
---Format a location table or a a single location string
---<br>- if a preposition is requested but missing, the default is used (EN: "in")
---@param ... string locations resolved by GetString like "Summerset^N,on"
---@return string locStr single location with preposition or multiple comma separated locations
function this.FormatLocation(...)
  local numLocs = select("#", ...)

  if numLocs == 0 then
    return ""
  end

  if numLocs == 1 then
    assert(type(...) == "string", "location must be a string")
    return colourise(formatSingleLocation(..., true), colours.Location)
  end

  local locs = { ... }
  for i, str in ipairs(locs) do
    locs[i] = sFormat(formatSingleLocation(str, false))
  end

  -- prepend "in" before joined location strings. good for now, but won't look great with all languages
  locs[1] = string.format("%s %s", inStr, locs[1])

  return colourise(sJoin(", ", unpack(locs)), colours.Location)
end

local eventTranslation = GetString(SI_FURC_EVENT)
local eventStr, eventsStr = this.GetSingularPlural(eventTranslation)

---Formatted Event String
---@param events table raw strings from GetString(SI_FURC_XYZ) like {"Bounties of Blackwood", "Elsweyr Dragons^p,from"}
---@return string formatted like "From the events: Bounties of Blackwood, Elsweyr Dragons"
function this.FormatEvent(events)
  assert(type(events) == "table", "events must be a table")

  local joined = ""
  local prefix = eventsStr
  -- decide on singular or plural from event;events
  if #events > 1 then
    joined = this.Join(events, ", ")
    prefix = eventsStr
  else
    joined = events[1]
    prefix = eventStr
  end

  return this.capitalise(prefix) .. ": " .. joined
end

local dungFmt = GetString(SI_FURC_STRING_DUNGEONS)

---Formatted Dungeon String
---@param ... string Resolved names from GetString(SI_FURC_XYZ) like "Fungal Grotto"
---@return string formatted like "Dungeon: Fungal Grotto"
function this.FormatDungeon(...)
  local numDungs = select("#", ...)
  local joined = sJoin(", ", ...)

  return sFormat(dungFmt, numDungs, joined)
end

---Get the plural or singular form of an NPC type
---@param npcType string resolved name like "guard^m,from" or "guards"
---@param useSingular boolean|nil request singular (default plural)
---@return string npcString singular or plural form
function this.FormatNPC(npcType, useSingular)
  local singular, plural = this.GetSingularPlural(npcType)
  return useSingular and singular or plural
end

local translSteal = GetString(SI_FURC_LOOT_STEALING)
function this.FormatSteal(people, places)
  people = people or {}
  places = places or {}

  local formatted = sFormat("<<C:1>>", translSteal)
  if #people == 0 and #places == 0 then
    return formatted
  end

  if #people > 0 then
    local peopleStr = this.Join(people)
    formatted = peopleStr
  end

  if #places > 0 then
    local placeStr = this.Join(places, ", ")
    formatted = string.format("%s%s%s", formatted, #people > 0 and ", " or "", placeStr)
  end

  return formatted
end

local translPick = GetString(SI_FURC_LOOT_PICKPOCKET)
function this.FormatPickpocket(people, places)
  people = people or {}
  places = places or {}

  local formatted = sFormat("<<C:1>>", translPick)
  if #people == 0 and #places == 0 then
    return formatted
  end

  if #people > 0 then
    local peopleStr = this.Join(people)
    formatted = peopleStr
  end

  if #places > 0 then
    local placeStr = this.Join(places, ", ")
    formatted = string.format("%s%s%s", formatted, #people > 0 and ", " or "", placeStr)
  end

  return formatted
end

local scrFrom = GetString(SI_FURC_LOOT_SCRYING)
local piecesFmt = GetString(SI_FURC_STRING_PIECES)

---Formatted Antiquities String
---@param pieceNum number required amount of pieces
---@param ... string with raw location like "Summerset^N,on"
---@return string formatted like "Scyring on Summerset"
function this.FormatScry(pieceNum, ...)
  pieceNum = pieceNum or 0

  local locations = { ... }

  for i = 1, #locations do
    if type(locations[i]) == "string" then
      locations[i] = this.FormatLocation(locations[i])
    end
  end

  local pieces = sFormat(piecesFmt, pieceNum)

  return string.format("%s %s %s", sFormat("<<C:1>>", scrFrom), table.concat(locations, "/"), pieces)
end

local vendorString = GetString(SI_FURC_STRING_VENDOR)

---comment
---@param vendorRef string vendor string like SI_FURC_TRADERS_NALIRSEWEN
---@param locRefs table locations with optional hierarchies like {*_ZONE, *_PLACE, *_SHOP}
---@param price any
---@param requirement any
---@return string
function this.SoldBy(vendorRef, locRefs, price, requirement)
  return sFormat(
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
    return sFormat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", item)
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
