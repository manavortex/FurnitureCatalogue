-- Utilities and often used functions

FurC = FurC or {}

local this = {}

local sJoin = zo_strjoin
local sFormat = zo_strformat

local colours = FurC.Constants.Colours
local currencies = FurC.Constants.Currencies
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC

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

-- Patterns that are incompatible with chat messages
local STRIP_PATTERNS = {
  "|c%x%x%x%x%x%x", -- <colour>
  "|r", -- </colour>
  "|u%d+:%d+.+|u", -- <number/>
  "|t%d+.+|t", -- <texture/>
}

---Strips patterns from string
---@param txt string Text containing `|` tags
---@param patterns? table<string> list of patterns to strip
---@return string txt stripped text
function this.stripTxt(txt, patterns)
  assert(type(txt) == "string", "How do you strip that which is no string?")
  if txt == "" then
    return ""
  end

  patterns = patterns or STRIP_PATTERNS
  for _, pattern in ipairs(patterns) do
    txt = txt:gsub(pattern, "")
  end

  return txt
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

---Format price string with currency
---@param price number
---@param currency CurrencyType defaults to CURT_MONEY
---@return string
function this.FormatPrice(price, currency)
  ---@type FormatType
  local curFmt = ZO_CURRENCY_FORMAT_AMOUNT_ICON
  return ZO_Currency_FormatKeyboard(currency, price, curFmt)
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

---Helper for single location formatting
---@param location string
---@param showPrep boolean|nil
---@return string
local function _fmtLocation(location, showPrep)
  if showPrep then
    return sFormat("<<Al:1>>", location) --> "in (the) XYZ"
  end
  return sFormat("<<1>>", location) --> "XYZ"
end

local inStr = GetString(SI_FURC_GRAMMAR_PREP_LOC_DEFAULT) -- "in"
---Format a location table or a a single location string
---<br>- if a preposition is requested but missing, the default is used (EN: "in")
---@param ... string locations resolved by GetString like "Summerset^N,on"
---@return string locStr single location with preposition or multiple comma separated locations
function this.FmtLocations(...)
  local numLocs = select("#", ...)

  if numLocs == 0 then
    return ""
  end

  if numLocs == 1 then
    assert(type(...) == "string", "location must be a string")
    return colourise(_fmtLocation(..., true), colours.Location)
  end

  local locs = { ... }
  for i, str in ipairs(locs) do
    locs[i] = sFormat(_fmtLocation(str, false))
  end

  -- prepend "in" before joined location strings. good for now, but won't look great with all languages
  locs[1] = string.format("%s %s", inStr, locs[1])

  return colourise(table.concat(locs, ", "), colours.Location)
end

local eventTranslation = GetString(SI_FURC_EVENT)
---Formatted Event String
---@param ... string event strings from GetString(SI_FURC_XYZ) like "Elsweyr Dragons^p,from"
---@return string formatted like "From the events: Bounties of Blackwood, Elsweyr Dragons"
function this.FormatEvent(...)
  local numEvents = select("#", ...)

  if numEvents == 1 then
    return sFormat(eventTranslation, ...)
  end

  local events = { ... }
  local prefix = eventTranslation
  -- decide on singular or plural from event;events
  for i, str in ipairs(events) do
    events[i] = sFormat(str)
  end

  events[1] = string.format("%s %s", eventTranslation, events[1])

  return colourise(table.concat(events, ", "), colours.Location)
end

local dungFmt = GetString(SI_FURC_SRC_DUNG)
---Formatted Dungeon String
---@param ... string Resolved names from GetString(SI_FURC_XYZ) like "Fungal Grotto"
---@return string formatted like "Dungeon: Fungal Grotto"
function this.FmtDungeon(...)
  local numDungs = select("#", ...)
  local joined = sJoin(", ", ...)

  return sFormat(dungFmt, numDungs, joined)
end

---Formatted Generic String
---<br>can be used for the middle part between type and price
---@see this.FormatPrefixSuffix
---@param src string source string like "mobs"
---@param ... string locations like ("Auridon^N,on", "Skywatch")
---@return string formatted like "mobs in xyz"
function this.FmtSrcLoc(src, ...)
  assert(type(src) == "string", "src must be a string")

  local numLocs = select("#", ...)

  if numLocs == 0 then
    return src
  end

  if numLocs == 1 then
    return sFormat("<<1>> <<2>>", src, ...)
  end

  local joined = sJoin(", ", ...)
  return sFormat("<<1>>: <<2>>", src, joined)
end

---Surround text with prefix and suffix
---@param text string Current text
---@param prefix any
---@param suffix any
---@return string
function this.FormatPrefixSuffix(text, prefix, suffix)
  assert(type(text) == "string", "text must be a string")

  prefix = prefix or ""
  suffix = suffix or ""

  if prefix == "" and suffix == "" then
    return text
  end

  return sJoin(" ", prefix, text, suffix)
end

local function fmtPeoplePlaces(people, places, prefix, suffix)
  people = people or {}
  places = places or {}
  prefix = prefix or ""

  local formatted = ""
  if #people > 0 then
    local peopleStr = table.concat(people, ", ")
    formatted = peopleStr
  end

  if #places > 0 then
    local placeStr = table.concat(places, ", ")
    formatted = string.format("%s%s%s", formatted, #people > 0 and ", " or "", placeStr)
  end

  return formatted
end

local strSeal = sFormat("<<C:1>>", GetString(SI_FURC_LOOT_STEALING))
function this.FormatSteal(people, places)
  return fmtPeoplePlaces(people, places, strSeal)
end

local strPick = sFormat("<<C:1>>", GetString(SI_FURC_LOOT_PICKPOCKET))
function this.FormatPickpocket(people, places)
  return fmtPeoplePlaces(people, places, strPick)
end

--TODO #DBOVERHAUL: use location here once we have new structure, so we can merge the functions

local fmtAch = GetString(SI_FURC_REQUIRES_ACHIEVEMENT)

---Make an achievement link from a requirement id or description
---@param req number|string
---@return string
local function makeAchievementLink(req)
  assert(type(req) == "string" or type(req) == "number", "requirement must be a string or number")

  if type(req) == "string" then
    -- probably description, format as is
    return sFormat(fmtAch, req)
  end
  -- probably achievement id, make link
  return sFormat(fmtAch, GetAchievementLink(req, LINK_STYLE_DEFAULT))
end

---Format furnisher (Home Goods, Achievement, others)
---@param trader string formatted furnisher string
---@param location string formatted location string
---@param price? integer price, defaults to 0
---@param curt? CurrencyType currency type (default: CURT_MONEY)
---@param info? string|number description or achievement id
---@return string
function this.FormatFurnisher(trader, location, price, curt, info)
  trader = trader or "UNKNOWN TRADER"
  location = location or "UNKNOWN LOCATION"
  price = price or 0
  curt = curt or CURT_MONEY

  local strPrice = ""
  local hasPrice = (price > 0 and 1) or 0
  if hasPrice == 1 then
    strPrice = this.FormatPrice(price, curt)
  end

  local strInfo = ""
  local hasReq = (info and info ~= "" and 1) or 0
  if hasReq == 1 then
    if type(info) == "number" then
      -- must be an achievment ID
      strInfo = makeAchievementLink(info) or ""
    else
      -- must be a description
      strInfo = info or ""
    end
  end

  local colVendor = colours.Vendor
  local colLoc = colours.Location
  local strVendor = colourise(trader, colVendor)
  local strLoc = colourise(location, colLoc)

  -- 0=none, 1=price, 2=price+req (no price + req doesn't exist)
  local priceReqFlag = hasPrice + hasReq
  if priceReqFlag == 0 then
    return sFormat("<<1>> : <<2>>", strVendor, strLoc)
  end

  if priceReqFlag == 1 then
    return sFormat("<<1>> : <<2>> (<<3>>)", strVendor, strLoc, strPrice)
  end

  return sFormat("<<1>> : <<2>> (<<3>>, <<4>>)", strVendor, strLoc, strPrice, strInfo)
end

local scrFrom = GetString(SI_FURC_LOOT_SCRYING)
local piecesFmt = GetString(SI_FURC_STRING_PIECES)

---Formatted Antiquities String
---@param pieceNum number required amount of pieces
---@param ... string with raw location like "Summerset^N,on"
---@return string formatted like "Scyring on Summerset"
function this.FormatScryingWithPieces(pieceNum, ...)
  pieceNum = pieceNum or 0

  local locations = { ... }

  for i = 1, #locations do
    if type(locations[i]) == "string" then
      locations[i] = this.FmtLocations(locations[i])
    end
  end

  local pieces = sFormat(piecesFmt, pieceNum)

  return string.format("%s %s %s", sFormat("<<C:1>>", scrFrom), table.concat(locations, "/"), pieces)
end

local questFmt = GetString(SI_FURC_QUESTREWARD)
function this.FmtQuest(questid, location)
  local name = GetQuestName(questid)
  local flagQ = (name ~= "" and 1) or 0
  local flagL = (location ~= "" and 1) or 0
  return sFormat(questFmt, flagQ + flagL, name, location)
end

function this.FormatScrying(...)
  local locations = { ... }

  for i = 1, #locations do
    if type(locations[i]) == "string" then
      locations[i] = this.FmtLocations(locations[i])
    end
  end

  return string.format("%s %s", sFormat("<<C:1>>", scrFrom), table.concat(locations, "/"))
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
