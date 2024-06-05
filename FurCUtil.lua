-- Utilities and often used functions

FurC = FurC or {}

local this = {}

local sJoin = zo_strjoin
local sFormat = zo_strformat

local colours = FurC.Constants.Colours

--[[_______________________
    |                     |
    |     TABLE UTILS     |
    |_____________________|]]

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

--[[_______________________
    |                     |
    |    STRING UTILS     |
    |_____________________|]]

-- Patterns that are incompatible with chat messages
local STRIP_PATTERNS = {
  "|c%x%x%x%x%x%x", -- <colour>
  "|r", -- </colour>
  "|u%d+:%d+.+|u", -- <number/>
  "|t%d+.+|t", -- <texture/>
}

-- Patterns to remove any control and gender suffix to get the clean name, necessary when we have no control over the raw string
local STRIP_CONTROL = {
  "%^.+",
}

---Strips patterns from string
---@param txt string Text containing `|` tags
---@param patterns? table<string> list of patterns to strip
---@return string txt stripped text
local function stripTxt(txt, patterns)
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
this.stripTxt = stripTxt

--[[
TODO #REFACTOR
  right now we are calling this function even with stripColor=true,
    and stripColor is passed from `FurC.GetItemDescription` to `FurC.getXYZSource`, then as `ret` to `this.colourise`, so in some cases colourise actually means "do nothing"
]]
local function colourise(txt, colourCode, ret)
  txt = tostring(txt)
  if ret then
    return txt
  end
  return string.format("|c%s%s|r", colourCode, txt)
end
this.Colourise = colourise

--[[_______________________
    |                     |
    |     GAME UTILS      |
    |_____________________|]]

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

-- TODO #REFACTOR: handle containers
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

---Helper for formatting a single source
---@param source string a raw location (`Summserset^N,on`) or people (`Guards^P,from`)
---@param format? string defaults to "<<1>>"
---@param colour? string colour code like "A1B2C3", defaults to no colour
---@return string
local function _fmtSource(source, format, colour)
  format = format or "<<1>>"
  local result = sFormat(format, source) --> "XYZ"
  if colour then
    result = colourise(result, colour)
  end
  return result
end

local srcType = {
  ["loc"] = {
    prep = GetString(SI_FURC_GRAMMAR_PREP_LOC_DEFAULT), -- "in"
    colour = colours.Location,
  },
  ["src"] = {
    prep = GetString(SI_FURC_GRAMMAR_PREP_SRC_DEFAULT), -- "from"
    colour = colours.Vendor,
  },
}

---Format sources (locations or people)
---<br>- if a source preposition is missing, the default is used (EN: "in" for locations, "from" for general sources)
---@param cat string source category "loc" or "src"
---@param ... string locations resolved by GetString like "Summerset^N,on"
---@return string srcStr single source with preposition or multiple comma separated sources
local function fmtSources(cat, ...)
  local srcCount = select("#", ...)

  if srcCount == 0 then
    return ""
  end

  cat = cat or "loc"
  assert(nil ~= srcType[cat], "Unknown source type: " .. tostring(cat))
  if srcCount == 1 then
    assert(type(...) == "string", string.format("Source must be a string, got %s", type(...)))
    local format = "<<Al:1>>"
    return _fmtSource(..., format, srcType[cat].colour)
  end

  local locs = { ... }
  for i, str in ipairs(locs) do
    locs[i] = sFormat(_fmtSource(str))
  end

  -- prepend "in" or "from" before joined source strings
  locs[1] = string.format("%s %s", srcType[cat].prep, locs[1])

  return colourise(table.concat(locs, ", "), srcType[cat].colour)
end
this.FmtSources = fmtSources

---Generic formatter for strings like `<PREFIX> <LOCATIONS> [SUFFIX]`
---@param cat string raw category string like "Dungeon^n,from" or "Scrying^N,from"
---@param suffix string|nil formatted info like "from chests, very rare"
---@param locSep string|nil override default location separator ", "
---@param ... string raw locations like "Fungal Grotto^N,in"
---@return string formatted like "Dungeon: Fungal Grotto (from chests)"
local function fmtCategorySourcesSuffix(cat, suffix, locSep, ...)
  assert(cat, "need a source string")
  suffix = suffix or ""
  locSep = locSep or ", "

  local locations = { ... }

  local suffixFlag = (suffix ~= "" and 1) or 0
  if #locations == 0 then
    -- `<<Cal:1>>, "dungeon^n,from` => "From a Dungeon"
    return sFormat("<<Cal:1>><<2[/ (<<3>>)/]>>", cat, suffixFlag, suffix)
  end

  if #locations == 1 then
    -- `<<Cl:1>>, "dungeon^n,from` => "From the dungeon"
    return sFormat("<<Cl:1>> <<l:2>><<3[/ (<<4>>)/]>>", cat, fmtSources("loc", locations[1]), suffixFlag, suffix)
  end

  for i = 1, #locations do
    locations[i] = stripTxt(locations[i], STRIP_CONTROL) -- remove `^...` from raw str
    locations[i] = colourise(locations[i], colours.Location)
  end

  -- `<<m:1>>, "dungeon^n,from` => "Dungeons"
  local joined = table.concat(locations, locSep)
  return string.format(
    "%s%s",
    sFormat("<<m:1>>: <<2>>", cat, joined), -- Dungeons: x, y
    sFormat("<<1[/ (<<2>>)/]>>", suffixFlag, suffix) -- (from chests)
  )
end
this.FmtCategorySourcesSuffix = fmtCategorySourcesSuffix

local strEvent = GetString(SI_FURC_EVENT)
---Formatted Event String
---@param ... string event strings from GetString(SI_FURC_XYZ) like "Elsweyr Dragons^p,from"
---@return string formatted like "From the events: Bounties of Blackwood, Elsweyr Dragons"
function this.FormatEvent(...)
  return fmtCategorySourcesSuffix(strEvent, nil, nil, ...)
end

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

  local strVendor = colourise(trader, colours.Vendor)
  local strLoc = colourise(location, colours.Location)

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

local scrFrom = GetString(SI_FURC_SRC_SCRYING)
local piecesFmt = GetString(SI_FURC_STRING_PIECES)
---Formatted Antiquities String
---@param pieceNum? number required amount of pieces
---@param ... string with raw location like "Summerset^N,on"
---@return string formatted like "Scyring on Summerset"
function this.FmtScrying(pieceNum, ...)
  pieceNum = pieceNum or 0
  assert(type(pieceNum) == "number", "first parameter (pieceNum) must be a number or nil") -- we crash here so we don't consume the first location by mistake
  local locations = { ... }

  for i = 1, #locations do
    locations[i] = fmtSources("loc", locations[i])
  end

  local pieces = sFormat(piecesFmt, tostring(pieceNum))

  return string.format("%s %s %s", sFormat("<<C:1>>", scrFrom), table.concat(locations, "/"), pieces)
end

local strRank = GetString(SI_FURC_RANK)
---Format a rank requirement text
---@param skill? string raw skill line name
---@param rank? number required rank
---@param info? string formatted info
---@return string
local function fmtRank(skill, rank, info)
  skill = skill or ""
  rank = rank or 0
  info = info or ""

  if "" ~= skill then
    skill = colourise(stripTxt(skill, STRIP_CONTROL), colours.Quest)
  end

  local sRank = sFormat(strRank, tostring(rank))

  return string.format("%s : %s", skill, sRank)
end
this.FmtRank = fmtRank

local dungStr = GetString(SI_FURC_SRC_DUNG)
-- TODO #REFACTOR: remove
function this.FmtDungeon(suffix, ...)
  return this.FmtCategorySourcesSuffix(dungStr, suffix, " / ", ...)
end

local srcScambox = GetString(SI_FURC_SRC_SCAMBOX)
local function fmtCrownCrate(scamboxName)
  if scamboxName and "" ~= scamboxName then
    return fmtCategorySourcesSuffix(srcScambox, colourise(scamboxName, colours.Gold))
  end

  return zo_strformat("<<alm:1>>", srcScambox)
end
this.FmtCrownCrate = fmtCrownCrate

local strQuest = GetString(SI_FURC_SRC_QUEST)
---Format a quest
---@param questId? number defaults to 0 = no quest
---@param location? string location string (formatted)
---@param suffix? string additional infotext (formatted)
---@return string questString like "Quest 'ABC' in Bangkorai (XYZ)"
function this.FmtQuest(questId, location, suffix)
  questId = questId or 0
  location = location or ""
  suffix = suffix or ""

  local hasQName = false
  local hasLoc = "" ~= location
  local hasSuff = "" ~= suffix

  local name = ""
  if questId > 0 then
    name = GetQuestName(questId)
    if "" ~= name then
      hasQName = true
      name = colourise(name, colours.Quest)
    end
  end

  if hasLoc then
    location = fmtSources("loc", location)
  end

  -- `000` = 0 -> From a quest
  if not (hasQName or hasLoc or hasSuff) then
    return sFormat("<<Cal:1>>", strQuest)
  end
  -- `001` = 1 -> From a quest (`<SUFF>`)
  if not (hasQName or hasLoc) and hasSuff then
    return sFormat("<<Cal:1>> (<<2>>)", strQuest, suffix)
  end
  -- `010` = 2 -> From a quest `<IN_LOC>`
  if not hasQName and hasLoc and not hasSuff then
    return sFormat("<<Cal:1>> <<2>>", strQuest, location)
  end
  -- `011` = 3 -> From a quest `<IN_LOC>` (`<SUFF>`)
  if not hasQName and (hasLoc and hasSuff) then
    return sFormat("<<Cal:1>> <<2>> (<<3>>)", strQuest, location, suffix)
  end
  -- `100` = 4 -> From the quest '<NAME>'
  if hasQName and not (hasLoc or hasSuff) then
    return sFormat("<<Cl:1>> '<<2>>'", strQuest, name)
  end
  -- `101` = 5 -> From the quest '<NAME>' (`<SUFF>`)
  if hasQName and not hasLoc and hasSuff then
    return sFormat("<<Cl:1>> '<<2>>' (<<3>>)", strQuest, name, suffix)
  end
  -- `110` = 6 -> Quest '<NAME>' `<IN_LOC>`
  if hasQName and hasLoc and not hasSuff then
    return sFormat("<<1>> '<<2>>' <<3>>", strQuest, name, location)
  end
  -- `111` = 7 -> Quest '<NAME>' `<IN_LOC>` (`<SUFF>`)
  if hasQName and hasLoc and hasSuff then
    return sFormat("<<1>>: '<<2>>' <<3>> (<<4>>)", stripTxt(strQuest, STRIP_CONTROL), name, location, suffix)
  end

  assert(false, "unreachable")
  return ""
end

--[[_______________________
    |                     |
    |   FURNITURE UTILS   |
    |_____________________|]]

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

--[[_______________________
    |                     |
    |     OTHER UTILS     |
    |_____________________|]]

-- make available for use and autocompletion
FurC.Utils = this
