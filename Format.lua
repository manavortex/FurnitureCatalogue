-- Source lines: creates the description a player reads from one published source record
--
-- The library hands out records, FC formats the stuff, glues it together, uses colours and decides on presentation
--
-- LFC keeps a rudimentary renderer of its own for its chat commands
--
-- A record names one way to obtain the item. The shapes are:
--   a vendor sells it        "<vendor> : <where> (<price>, <detail>)"
--   it comes in a container  "Part of item <link> - <vendor>, <where>: <price>"
--   anything else            "<category>: <where> (<qualifiers>)"
-- Everything below is one of those three, the crown store's offers, or one of the
-- specials (crafting, datamined, guild store).

local LFC = LibFurnitureCatalogue
local api = LFC.API
local src = api.GetSourceTypes()

local sFormat = zo_strformat
local getItemLink = api.GetItemLink
local getIngredients = api.GetIngredients
local getSourceDetails = api.GetSourceDetails

local this = {}
FurC.SourceFormat = this

-- TODO: read from the settings once colours are configurable
local colours = {
  Gold = "E5DA40",
  House = "40D0C0",
  Location = "CF6D00",
  Quest = "E5DA40",
  Vendor = "72DB00",
  Voucher = "25C31E",
}

-- An item can come furnished with a whole list of houses, got to limit how many we're showing
local HOUSE_LIMIT = 3

--[[_______________________
    |                     |
    |      PRIMITIVES     |
    |_____________________|]]

-- Strip control suffixes if we cannot or don't want to strformat them
local STRIP_CONTROL = { "%^.+" }

-- Strip stuff that a chat input cannot display
local STRIP_MARKUP = {
  "|c%x%x%x%x%x%x", -- <colour>
  "|r", -- </colour>
  "|u%d+:%d+.+|u", -- <number/>
  "|t%d+.+|t", -- <texture/>
}

---@param txt string
---@param patterns? table<string> defaults to the chat-incompatible markup
---@return string
local function stripTxt(txt, patterns)
  if txt == nil or txt == "" then
    return ""
  end
  for _, pattern in ipairs(patterns or STRIP_MARKUP) do
    txt = txt:gsub(pattern, "")
  end
  return txt
end
this.Strip = stripTxt

local function colourise(txt, colourCode, plain)
  txt = tostring(txt)
  if plain then
    return txt
  end
  return string.format("|c%s%s|r", colourCode, txt)
end

local function formatPrice(price, currency)
  return ZO_Currency_FormatKeyboard(currency or CURT_MONEY, price, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
end

local function itemName(itemId)
  return stripTxt(GetItemLinkName(getItemLink(itemId)), STRIP_CONTROL)
end
this.ItemName = itemName
this.STRIP_CONTROL = STRIP_CONTROL

--[[_______________________
    |                     |
    |      RESOLVERS      |
    |_____________________|]]

--- The library's resolvers, so an exported name and an in-game name cannot drift apart
local resolvers = LFC.Internal.Constants.Resolvers
local resolveZone = resolvers.Zone
--- Place, npc and event ids are all plain locale strings
local resolveString = resolvers.Place
--- Monster social classes are the game's own strings, rendered singular
local resolveNpcClass = resolvers.NpcClass

--- One note value: a string id, a literal, or a structured table.
local resolveNote = LFC.Internal.Query.ResolveNote
--- Which crafting-station recipe a row grants
local grantedRecipeIndices = LFC.Internal.Query.GrantedRecipeIndices

--[[_______________________
    |                     |
    |      SENTENCES      |
    |_____________________|]]

local SOURCE_SEPARATOR = " + "

local fmtPartOf = GetString(SI_FURC_PART_OF)
local function formatPartOf(itemId, detail)
  if not itemId or itemId == 0 then
    return ""
  end
  local result = sFormat(fmtPartOf, getItemLink(itemId))
  if detail then
    return string.format("%s - %s", result, detail)
  end
  return result
end

local fmtHouse = GetString(SI_FURC_HOUSE)
local fmtHouseMore = GetString(SI_FURC_HOUSE_MORE)
local fmtMiscHouse = GetString(SI_FURC_SRC_MISCHOUSE)
local function formatHouses(houses)
  local count = #houses
  -- an empty list means it comes furnished with a house the data cannot name
  if count == 0 then
    return fmtMiscHouse
  end
  local named = {}
  for i = 1, math.min(count, HOUSE_LIMIT) do
    named[i] = GetCollectibleName(houses[i])
  end
  local text = colourise(table.concat(named, ", "), colours.House)
  if count > HOUSE_LIMIT then
    text = sFormat(fmtHouseMore, text, count - HOUSE_LIMIT)
  end
  return sFormat(fmtHouse, text)
end

local fmtItemPack = GetString(SI_FURC_SRC_ITEMPACK)
local packSources = {}
local function formatItemPack(packItemId)
  local text = packSources[packItemId]
  if not text then
    text = sFormat(fmtItemPack, getItemLink(packItemId))
    packSources[packItemId] = text
  end
  return text
end

local fmtItemBundle = GetString(SI_FURC_SRC_ITEMBUNDLE)
local function formatItemBundle(bundleStringId)
  return sFormat(fmtItemBundle, GetString(bundleStringId))
end

--- Unique locations in the English client mostly come without the `^N` suffix, which returns "at the Clockwork City" instead of "in Clockwork City"
local function addSuffixIfMissing(txt)
  if nil ~= txt:find("%^") then
    return txt
  end
  return string.format("%s^N", txt)
end

local function oneSource(source, format, colour)
  local result = sFormat(format or "<<1>>", source)
  if colour then
    result = colourise(result, colour)
  end
  return result
end

local SOURCE_TYPES = {
  ["loc"] = {
    prep = GetString(SI_FURC_GRAMMAR_PREP_LOC_DEFAULT), -- "in"
    sep = ", ",
    colour = colours.Location,
  },
  ["src"] = {
    prep = GetString(SI_FURC_GRAMMAR_PREP_SRC_DEFAULT), -- "from"
    sep = ", ",
    colour = colours.Vendor,
  },
  ["other"] = {
    prep = "",
    sep = string.format(" %s ", GetString(SI_FURC_GRAMMAR_CONJ_OR)),
    colour = colours.Voucher,
  },
}

---Locations or people, with the preposition their category takes
---@param cat string "loc", "src" or "other"
---@param ... string resolved names
---@return string
local function fmtSources(cat, ...)
  local count = select("#", ...)
  if count == 0 then
    return ""
  end
  cat = cat or "loc"

  if count == 1 then
    local text = ...
    local format = "<<1>>"
    if cat == "loc" then
      format = "<<Al:1>>"
      text = addSuffixIfMissing(text)
    end
    return oneSource(text, format, SOURCE_TYPES[cat].colour)
  end

  local sources = { ... }
  for i, text in ipairs(sources) do
    if i == 1 and cat == "loc" then
      sources[i] = addSuffixIfMissing(text)
    end
    sources[i] = oneSource(sources[i])
  end
  if SOURCE_TYPES[cat].prep ~= "" then
    sources[1] = string.format("%s %s", SOURCE_TYPES[cat].prep, sources[1])
  end
  return colourise(table.concat(sources, SOURCE_TYPES[cat].sep), SOURCE_TYPES[cat].colour)
end

---`<CATEGORY>: <LOCATIONS> (<SUFFIX>)`
---@param cat string resolved category word like "dungeon^n,from"
---@param suffix string|nil already formatted detail
---@param srcType string|nil "loc", "src" or "other", defaults to "loc"
---@param ... string|table one place, either resolved text or a list of its resolved parts
---@return string
local function fmtGeneric(cat, suffix, srcType, ...)
  suffix = suffix or ""
  srcType = srcType or "loc"

  -- callers that name one thing pass text; placesOf passes a part list per place
  local locations = {}
  for i = 1, select("#", ...) do
    local place = select(i, ...)
    locations[i] = (type(place) == "table") and place or { place }
  end
  local hasSuffix = suffix ~= ""
  if #locations == 0 then
    if hasSuffix then
      return sFormat("<<Cal:1>> (<<2>>)", cat, suffix)
    end
    return sFormat("<<Cal:1>>", cat)
  end

  ---A place of several parts reads as one location: the parts are joined, not separated
  local function joinParts(parts)
    local named = {}
    for i, part in ipairs(parts) do
      named[i] = colourise(stripTxt(part, STRIP_CONTROL), colours.Location)
    end
    return table.concat(named, ", ")
  end

  if #locations == 1 then
    local prefix = sFormat("<<t:1>>", cat)
    local only = locations[1]
    -- one part keeps the grammar the single-location case has always had
    local text = (#only == 1 and fmtSources(srcType, only[1])) or joinParts(only)
    if hasSuffix then
      return string.format("%s: %s (%s)", prefix, text, suffix)
    end
    return string.format("%s: %s", prefix, text)
  end

  local prefix = sFormat("<<tm:1>>", cat)
  local named = {}
  for i = 1, #locations do
    named[i] = joinParts(locations[i])
  end
  local joined = table.concat(named, " \\ ")
  if hasSuffix then
    return string.format("%s: %s (%s)", prefix, joined, suffix)
  end
  return string.format("%s: %s", prefix, joined)
end

local fmtAch = GetString(SI_FURC_REQUIRES_ACHIEVEMENT)
local anyAchievement = sFormat("<<a:1>>", GetString(SI_FURC_ACHIEVEMENT_UNKNOWN))
---@param req number|string achievement id, or a description when the data has no id
local function formatAchievement(req)
  local fmt = fmtAch
  if type(req) == "string" then
    return sFormat(fmt, req)
  end
  if req == 0 then
    return sFormat(fmt, anyAchievement)
  end
  return sFormat(fmt, GetAchievementLink(req, LINK_STYLE_DEFAULT))
end

local strCollectible = GetString(SI_FURC_SRC_COLLECTIBLE)
local function formatCollectible(collectibleId)
  return sFormat("<<1>>: <<2>>", strCollectible, GetCollectibleName(collectibleId))
end

local strRank = GetString(SI_FURC_RANK)
local function formatRank(skillLine, rank)
  local skill = (skillLine and colourise(stripTxt(GetSkillLineNameById(skillLine), STRIP_CONTROL), colours.Quest)) or ""
  return string.format("%s : %s", skill, sFormat(strRank, tostring(rank or 0)))
end

local strQuest = GetString(SI_FURC_SRC_QUEST)
local function formatQuestReq(questId)
  return sFormat("<<1>>: <<2>>", strQuest, GetQuestName(questId))
end

---`<vendor> : <where> (<price>, <detail>)`
local function formatFurnisher(trader, location, price, currency, detail)
  trader = trader or "UNKNOWN TRADER"
  location = location or "UNKNOWN LOCATION"
  price = price or 0

  local strPrice = (price > 0 and formatPrice(price, currency)) or ""
  local hasPrice = (price > 0 and 1) or 0
  local strDetail = detail or ""
  local hasDetail = (strDetail ~= "" and 1) or 0

  local strVendor = colourise(trader, colours.Vendor)
  local strLoc = colourise(location, colours.Location)

  -- 0=none, 1=price, 2=price+detail (no price + detail does not exist)
  local flag = hasPrice + hasDetail
  if flag == 0 then
    return sFormat("<<1>> : <<2>>", strVendor, strLoc)
  end
  if flag == 1 then
    return sFormat("<<1>> : <<2>> (<<3>>)", strVendor, strLoc, strPrice)
  end
  return sFormat("<<1>> : <<2>> (<<3>>, <<4>>)", strVendor, strLoc, strPrice, strDetail)
end
this.Furnisher = formatFurnisher

local srcScambox = GetString(SI_FURC_SRC_SCAMBOX)
local function formatCrownCrate(crateId)
  local name = crateId and crateId ~= 0 and GetCrownCrateName(crateId)
  if name and "" ~= name then
    return fmtGeneric(srcScambox, colourise(name, colours.Gold))
  end
  return sFormat("<<alm:1>>", srcScambox)
end

--[[_______________________
    |                     |
    |       RECORDS       |
    |_____________________|]]

-- The category word a record renders under when it does not name its own
local MISC_CATEGORY = {
  [src.DROP] = SI_FURC_SRC_DROP,
  [src.DUNGEON] = SI_FURC_SRC_DUNG,
  [src.HARVEST] = SI_FURC_SRC_HARVEST,
  [src.CHEST] = SI_FURC_SRC_CHESTS,
  [src.QUEST] = SI_FURC_SRC_QUEST,
  [src.BAZAAR] = SI_FURC_SRC_BAZAAR,
  [src.FISHING] = SI_FURC_SRC_FISH,
  [src.PICKPOCKET] = SI_FURC_SRC_PICK,
  [src.STEAL_CONTAINER] = SI_FURC_SRC_STEAL,
  [src.ANTIQUITY] = SI_FURC_SRC_SCRYING,
}

local strEvent = GetString(SI_FURC_EVENT)
local strLeads = GetString(SI_FURC_SRC_LEADS)
local strEditor = GetString(SI_FURC_SRC_EDITOR)
local strEditorTag = GetString(SI_FURC_SRC_EDITOR_TAG)
local strAroundDate = GetString(SI_FURC_STRING_WEEKEND_AROUND)
local strRumourItem = GetString(SI_FURC_SRC_RUMOUR_ITEM)
local emptyString = GetString(SI_FURC_SRC_EMPTY)

---Adds to a suffix: a single value, or a list of alternatives
---@param parts string[] appended to in place
---@param value any a vocabulary value, a `{ npc = }`-style part, or a list of either
---@param resolve fun(value: any): string
local function addQualifier(parts, value, resolve)
  if value == nil then
    return
  end
  -- A list of ids this client does not define is an empty table, not a value to resolve
  if type(value) == "table" and next(value) == nil then
    return
  end
  if type(value) ~= "table" or value[1] == nil then
    local resolved = resolve(value)
    if resolved ~= "" then
      parts[#parts + 1] = fmtSources("src", resolved)
    end
    return
  end
  local alternatives = {}
  for _, part in ipairs(value) do
    local resolved = resolve(part)
    if resolved ~= "" then
      alternatives[#alternatives + 1] = resolved
    end
  end
  -- 1 alternative means it's just 1 value
  if #alternatives == 1 then
    parts[#parts + 1] = fmtSources("src", alternatives[1])
  elseif #alternatives > 1 then
    parts[#parts + 1] = fmtSources("other", unpack(alternatives))
  end
end

---The one detail slot a vendor record fills: what it requires, what it comes with, or a note
local function vendorDetail(source)
  if source.skillRank then
    return formatRank(source.skillLine, source.skillRank)
  end
  if source.quest then
    return formatQuestReq(source.quest)
  end
  if source.achievement then
    return formatAchievement(source.achievement)
  end
  if source.collectible then
    return formatCollectible(source.collectible)
  end
  if source.partOf then
    return formatPartOf(source.partOf)
  end
  if source.note then
    return resolveNote(source.note)
  end
end

---One placement resolved into its parts: a zone and a place inside it are one location
local function partsOf(placement)
  local parts = {}
  if placement.location then
    parts[#parts + 1] = resolveZone(placement.location)
  end
  if placement.place then
    parts[#parts + 1] = resolveString(placement.place)
  end
  return parts
end

---Where a record says the item is, as arguments for fmtGeneric
local function placesOf(source)
  local places = {}
  for _, placement in ipairs(source.locations or {}) do
    local parts = partsOf(placement)
    if #parts > 0 then
      places[#places + 1] = parts
    end
  end
  if source.event then
    places[#places + 1] = { resolveString(source.event) }
  end
  return places
end

---A record that names no vendor: "<category>: <where> (<qualifiers>)"
local function renderCategory(record)
  local source = record.source
  local cost = record.cost

  if source.itemPack then
    return sFormat(GetString(SI_FURC_SRC_TOMESPACK), GetString(source.itemPack))
  end

  local places = placesOf(source)

  -- an event is its own category word, the event name goes where a location would
  local category = GetString(source.category or (source.event and SI_FURC_EVENT) or MISC_CATEGORY[source.type])

  if cost and #places == 0 then
    return string.format("%s: %s", category, formatPrice(cost.amount, cost.currency))
  end

  -- one suffix slot, so the parts are joined in a fixed order
  local notes = {}
  if source.leads then
    notes[#notes + 1] = strLeads
  end
  addQualifier(notes, source.npcClass, resolveNpcClass)
  addQualifier(notes, source.containerKind, resolveNote)
  addQualifier(notes, source.note, resolveNote)
  if source.achievement then
    notes[#notes + 1] = formatAchievement(source.achievement)
  end
  if source.container then
    notes[#notes + 1] = getItemLink(source.container)
  end
  if source.rarity then
    notes[#notes + 1] = GetString(source.rarity)
  end
  local suffix = table.concat(notes, ", ")

  -- the quest names itself first and the rest follows
  if source.quest then
    local questName = GetQuestName(source.quest)
    local named = ""
    if "" ~= questName then
      named = colourise(sFormat("'<<1>>'", questName), colours.Quest)
      if suffix ~= "" then
        named = string.format("%s, %s", named, suffix)
      end
    end
    return fmtGeneric(strQuest, named, "loc", unpack(places))
  end

  return fmtGeneric(category, suffix, "loc", unpack(places))
end

---One crown-store offer
local function renderCrownOffer(record)
  local source = record.source
  local parts = {}
  if record.cost then
    parts[#parts + 1] = formatPrice(record.cost.amount, record.cost.currency)
  end
  for _, packId in ipairs(source.packs or {}) do
    parts[#parts + 1] = formatItemPack(packId)
  end
  if source.bundle then
    parts[#parts + 1] = formatItemBundle(source.bundle)
  end
  if source.crate then
    parts[#parts + 1] = formatCrownCrate(source.crate)
  end
  if source.houses then
    parts[#parts + 1] = formatHouses(source.houses)
  end
  -- a house purchase with no house named
  if source.note then
    parts[#parts + 1] = GetString(source.note)
  end
  -- the row is not a crown-store offer at all (crafted, levelup reward)
  if source.category then
    parts[#parts + 1] = fmtGeneric(GetString(source.category))
  end
  if #parts == 0 then
    if source.type == src.EDITOR then
      return strEditor
    end
    return emptyString
  end
  local text = table.concat(parts, SOURCE_SEPARATOR)
  return source.type == src.EDITOR and sFormat(strEditorTag, text, strEditor) or text
end

local LUXURY_DATE = "(%d+)-(%d+)-(%d+)"
local function luxuryDetail(record, opts)
  local lastSeen = record.lastSeen
  if not lastSeen then
    return ""
  end
  local yyyy, mm, dd = string.match(lastSeen, LUXURY_DATE)
  local formatted = ""
  if yyyy and mm and dd then
    formatted = (opts and opts.dateFormat) or "YYYY-MM-DD"
    formatted = string.gsub(formatted, "YYYY", yyyy)
    formatted = string.gsub(formatted, "MM", mm)
    formatted = string.gsub(formatted, "DD", dd)
  end
  return sFormat(strAroundDate, colourise(formatted, colours.Gold))
end

---A record that names a vendor: "<vendor> : <where> (<price>, <detail>)"
local function renderVendor(record, opts)
  local source = record.source
  local cost = record.cost
  local detail = (source.type == src.LUXURY and luxuryDetail(record, opts)) or vendorDetail(source)
  local placements = source.locations
  local where
  if placements and #placements == 1 then
    local parts = partsOf(placements[1])
    where = (#parts > 0) and table.concat(parts, ", ") or nil
  elseif placements then
    -- a vendor standing in several places names them all
    local named = {}
    for i, parts in ipairs(placesOf(source)) do
      named[i] = table.concat(parts, ", ")
    end
    where = table.concat(named, " \\ ")
  end
  return formatFurnisher(resolveString(source.vendor), where, cost and cost.amount, cost and cost.currency, detail)
end

---An event record: sold by somebody at the event, or dropped by the event itself
local function renderEvent(record)
  local source = record.source
  local eventName = source.event and resolveString(source.event)
  local cost = record.cost
  -- a source that is not an NPC is a container
  local named = (source.vendor and resolveString(source.vendor)) or (source.container and getItemLink(source.container))

  if cost or source.vendor then
    return formatFurnisher(
      named or eventName,
      eventName,
      cost and cost.amount,
      cost and cost.currency,
      vendorDetail(source)
    )
  end
  return fmtGeneric(strEvent, named or nil, "src", eventName)
end

---One source record as the line a player reads
---@param record LFCSourceRecord
---@param itemId integer
---@param entry FurCEntry|nil the item's DB entry, for the sources that are not in the record
---@param opts? { dateFormat?: string }
---@return string
local function formatRecord(record, itemId, entry, opts)
  local source = record.source
  local type_ = source.type

  if type_ == src.IGNORED then
    return GetString(SI_FURC_SRC_IGNORED)
  end
  if type_ == src.RUMOUR then
    return strRumourItem
  end
  if type_ == src.GUILDSTORE then
    return GetString(SI_FURC_SEEN_IN_GUILDSTORE)
  end
  if type_ == src.CROWN or type_ == src.EDITOR then
    return renderCrownOffer(record)
  end
  if type_ == src.FESTIVAL_DROP then
    return renderEvent(record)
  end
  if source.vendor or type_ == src.LUXURY then
    return renderVendor(record, opts)
  end
  return renderCategory(record)
end
this.FormatRecord = formatRecord

-- What a material list says when the recipe is not in the character's knowledge.
local strNoMats = "couldn't get material list, please re-scan character knowledge"
this.NoMaterials = strNoMats

---@param ingredients table<string, integer> ingredient link -> quantity
---@param plain boolean names instead of links
---@return string
local function composeMaterials(ingredients, plain)
  local links = {}
  for ingredientLink in pairs(ingredients) do
    links[#links + 1] = ingredientLink
  end
  -- pairs would return them in a different order every session, the link sorts by item id
  table.sort(links)

  local parts = {}
  for index, ingredientLink in ipairs(links) do
    local itemText = ingredientLink
    if plain then
      -- ingredient names come lowercased, so we capitalise them ourselves
      itemText = string.gsub(" " .. GetItemLinkName(ingredientLink), "%W%l", string.upper):sub(2)
    end
    parts[index] = sFormat("<<1>>x <<2>>", ingredients[ingredientLink], itemText)
  end
  return table.concat(parts, ", ")
end

---The ingredient list as a player reads it: "2x Rough Oak, 1x Bast, 5x Banana"
---@param itemOrLink string|integer
---@param entry FurCEntry|nil
---@param plain? boolean names instead of links
---@return string
local function formatMaterials(itemOrLink, entry, plain)
  if not entry or not (entry.blueprint or grantedRecipeIndices(entry)) then
    return strNoMats
  end
  return composeMaterials(getIngredients(itemOrLink, entry), plain == true)
end
this.FormatMaterials = formatMaterials

---Where a craftable's blueprint comes from, from the record the item's crafting source carries
---@param itemId integer
---@param opts? { dateFormat?: string }
---@return string|nil text nil when no row names the blueprint
local function recipeSource(itemId, opts)
  for _, record in ipairs(getSourceDetails(itemId)) do
    local source = record.source
    if source.type == src.CRAFTING then
      -- the blueprint's row, in the same shapes every other record takes
      if source.event and not source.vendor then
        return renderEvent(record)
      end
      if source.vendor then
        return renderVendor(record, opts)
      end
      if source.category then
        return renderCategory(record)
      end
      return
    end
  end
end
this.RecipeSource = recipeSource

---A craftable's line: where its blueprint comes from, or what it is made of
---@param itemId integer
---@param entry FurCEntry|nil
---@param stripColor? boolean
---@param opts? { dateFormat?: string }
---@return string
local function craftingLine(itemId, entry, stripColor, opts)
  local text = recipeSource(itemId, opts)
  if not text or text == "" then
    text = formatMaterials(itemId, entry, stripColor)
  end
  if stripColor then
    return stripTxt(text)
  end
  return text
end
this.CraftingLine = craftingLine

---Every line for one item, ranked, records of one source type joined into one line
---
---Crafting is left out unless `withCrafting` asks for it, because the tooltip shows the material separately
---@param itemId integer
---@param entry FurCEntry|nil
---@param opts? { dateFormat?: string }
---@param withCrafting? boolean
---@return { source: integer, text: string }[]
local function formatItem(itemId, entry, opts, withCrafting)
  local lines, byType = {}, {}
  for _, record in ipairs(getSourceDetails(itemId)) do
    local type_ = record.source.type
    local text
    if type_ ~= src.CRAFTING then
      text = formatRecord(record, itemId, entry, opts)
    elseif withCrafting then
      text = craftingLine(itemId, entry, false, opts)
    end
    if text and #text > 0 then
      local line = byType[type_]
      if not line then
        -- one source type, several ways to obtain it: player reads one line
        line = { source = type_, parts = {} }
        byType[type_] = line
        lines[#lines + 1] = line
      end
      line.parts[#line.parts + 1] = text
    end
  end
  for _, line in ipairs(lines) do
    line.text = table.concat(line.parts, SOURCE_SEPARATOR)
    line.parts = nil
  end
  return lines
end
this.FormatItem = formatItem

---What a container unpacks into (books, blueprints, furnishings)
---@param itemId integer
---@return string|nil text nil when the item is not a container we know the contents of
local function formatContents(itemId)
  local collection = FurC.BookCollections and FurC.BookCollections[itemId]
  if collection and collection.contents then
    return sFormat(GetString(SI_FURC_CONTAINS_BOOKS), #collection.contents)
  end
end
this.FormatContents = formatContents

---The one line for an item's top-ranked source
---@param itemId integer
---@param entry FurCEntry|nil
---@param stripColor? boolean drop colour, currency and texture markup, for chat
---@param opts? { dateFormat?: string }
---@return string
local function formatDescription(itemId, entry, stripColor, opts)
  -- the ranked list decides which source describes the item
  local first = formatItem(itemId, entry, opts, true)[1]
  local text = (first and first.text) or ""
  if not (first and first.source == src.CRAFTING) then
    local contents = formatContents(itemId)
    if contents then
      text = (text ~= "" and string.format("%s - %s", text, contents)) or contents
    end
  end
  if stripColor then
    return stripTxt(text)
  end
  return text
end
this.FormatDescription = formatDescription
