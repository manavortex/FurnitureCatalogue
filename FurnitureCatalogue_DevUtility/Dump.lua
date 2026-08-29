-- FurnitureCatalogue_DevUtility
--
-- Experimental data dumps, from the Dump tab. Each run replaces FurCDev_SavedVariables:
--   verbose -> .verbose  consumer export, spelled out as English text
--   compact -> .compact  consumer export, ids and source enums
--   meta    -> .meta     full DB + in-game-only metadata
-- TODO: Decide what the dump features should look like. For instance meta is not very useful anymore
--

local this = FurCDev

local LFC = LibFurnitureCatalogue
local api = LFC.API
local build = LFC.Internal.Build
local query = LFC.Internal.Query
local fmt = LFC.Internal.Format
local stripTxt = fmt.stripTxt

local STRIP_COLOUR = { "|c%x%x%x%x%x%x", "|r" }
local GENDER_SUFFIX = { "%^%a[%a,]*" }
local CURRENCY_KEYS = {
  "ALLIANCE_POINTS",
  "ARCHIVAL_FORTUNES",
  "CROWNS",
  "CROWN_GEMS",
  "IMPERIAL_FRAGMENTS",
  "MONEY",
  "SEALS",
  "STYLE_STONES",
  "TELVAR_STONES",
  "TOME_CHALLENGE_REROLLS",
  "TOME_POINTS",
  "TOME_POINT_CACHES",
  "TOME_TOKENS",
  "TRADE_BARS",
  "TRANSMUTE_CRYSTALS",
  "UNDAUNTED_KEYS",
  "WRIT_VOUCHERS",
}

local currencyById, currencyByIcon

-- Icons: `|t<w>:<h>:<path>|t`
local ICON_MARKUP = "|t[^:|]*:[^:|]*:([^|]*)|t"
local function iconKey(path)
  return (tostring(path or ""):lower():match("([^/\\]+)$")) or ""
end

---id -> { key, name }, and icon file -> id
local function currencies()
  if currencyById then
    return currencyById, currencyByIcon
  end
  currencyById, currencyByIcon = {}, {}
  for _, key in ipairs(CURRENCY_KEYS) do
    local id = rawget(_G, "CURT_" .. key)
    local ok, name = pcall(GetCurrencyName, id, false, false) -- plural
    if type(id) == "number" and ok and type(name) == "string" and name ~= "" then
      currencyById[id] = { key = key, name = name }

      local priced, formatted = pcall(ZO_Currency_FormatKeyboard, id, 0, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
      local icon = priced and type(formatted) == "string" and formatted:match(ICON_MARKUP) or nil
      if not icon then
        local gotIcon, fallback = pcall(GetCurrencyKeyboardIcon, id)
        icon = gotIcon and type(fallback) == "string" and fallback or nil
      end
      if icon and icon ~= "" then
        currencyByIcon[iconKey(icon)] = id
      end
    end
  end
  return currencyById, currencyByIcon
end

local function cleanText(value)
  if type(value) ~= "string" or value == "" then
    return value
  end
  value = stripTxt(value, STRIP_COLOUR)

  local _, byIcon = currencies()
  value = value:gsub("|u[^|]*|u", "") -- unit/pluralisation markup around a price
  value = value:gsub("%s*" .. ICON_MARKUP, function(path)
    local id = byIcon[iconKey(path)]
    return (id and " {c" .. id .. "}") or ""
  end)

  return stripTxt(value, GENDER_SUFFIX)
end
local src = LFC.Internal.Constants.ItemSources
local SOURCE_PRIORITY = LFC.Internal.Constants.SOURCE_PRIORITY or {}

local LINK_STYLE = LINK_STYLE_BRACKETS or 1

local VERBOSE_FORMAT = "furniture-export-verbose-v1"
local COMPACT_FORMAT = "furniture-export-compact-v1"
local EXPORT_VERSION = 1
local META_FORMAT = "furniture-meta-v1"

-------------------------
-- Shared helpers
-------------------------

local function currentLocale()
  -- "Language.2" is the CVar name for the UI language "en", "de", and so on
  local locale = GetCVar and GetCVar("Language.2")
  if type(locale) ~= "string" or locale == "" then
    return "unknown"
  end
  return locale
end

local function sortedKeys(tbl)
  local keys = {}
  for key in pairs(tbl or {}) do
    if type(key) == "number" then
      keys[#keys + 1] = key
    end
  end
  table.sort(keys)
  return keys
end

---SavedVariables only reach disk on reload or logout
local function promptReload()
  local LAM = LibAddonMenu2
  if LAM and LAM.util then
    LAM.util.ShowConfirmationDialog("Reload UI?", "Reload to write the dump to disk.", function()
      ReloadUI("ingame")
    end)
  else
    d("|cFF3333FurCDev|r: reload the UI to write the dump to disk.")
  end
end
this.PromptReload = promptReload

---Fresh SavedVariables root: one export per file, no leftovers
local function savedVars()
  FurCDev_SavedVariables = {}
  return FurCDev_SavedVariables
end

---Show text in the dev window's output box, or chat when there is no window
local function showOutput(text)
  if this.textbox and this.control then
    this.textbox:SetText(text)
    this.control:SetHidden(false)
  else
    d(text)
  end
end

-------------------------
-- Shape: meta
-------------------------

---Furniture data id for item or recipe link. A recipe resolves to the furnishing it produces
---@param itemLink any item or recipe link
---@return integer dataId 0 when no furnishing resolved
---@return boolean viaRecipe true if id came from recipe->result resolve
local function furnitureDataIdFor(itemLink)
  local dataId = GetItemLinkFurnitureDataId(itemLink)
  if dataId ~= 0 then
    return dataId, false
  end
  local resultLink = GetItemLinkRecipeResultItemLink(itemLink, LINK_STYLE)
  if resultLink and resultLink ~= "" and resultLink ~= itemLink then
    return GetItemLinkFurnitureDataId(resultLink), true
  end
  return 0, false
end

-- Enumerate all furniture categories
local function buildTaxonomy()
  local categories = {}
  for ci = 1, GetNumFurnitureCategories() do
    local catId = GetFurnitureCategoryId(ci)
    if catId and catId ~= 0 and not categories[catId] then
      local name, parent, _, order = GetFurnitureCategoryInfo(catId)
      categories[catId] = { name = name or "", parent = parent or 0, order = order or 0 }
    end
    for si = 1, GetNumFurnitureSubcategories(ci) do
      local subId = GetFurnitureSubcategoryId(ci, si)
      if subId and subId ~= 0 and not categories[subId] then
        local name, parent, _, order = GetFurnitureCategoryInfo(subId)
        categories[subId] = { name = name or "", parent = parent or catId or 0, order = order or 0 }
      end
    end
  end
  return categories
end

local function buildMeta()
  FurC.EnsureDB(true) -- we need FurC.DB ready, so no LibAsync here
  local getLink = FurC.Utils.GetItemLink
  local getName = FurC.Utils.GetItemName

  local meta = {}
  local stats = { items = 0, furniture = 0, recipesResolved = 0 }

  for id in pairs(FurC.DB or {}) do
    if type(id) == "number" and id > 9999 then
      stats.items = stats.items + 1
      local itemLink = getLink(id)
      local rec = { name = getName(id), quality = GetItemLinkFunctionalQuality(itemLink) or 0 }

      local dataId, viaRecipe = furnitureDataIdFor(itemLink)
      if dataId ~= 0 then
        rec.cat, rec.sub, rec.theme = GetFurnitureDataInfo(dataId)
        stats.furniture = stats.furniture + 1
        if viaRecipe then
          stats.recipesResolved = stats.recipesResolved + 1
        end
      end

      meta[id] = rec
    end
  end

  return meta, buildTaxonomy(), stats
end

-- Build the meta dataset, store it in SavedVars
function this.DumpMeta(skipReloadPrompt)
  local metaItems, categories, stats = buildMeta()

  local numCats = NonContiguousCount(categories)
  savedVars().meta = {
    format = META_FORMAT,
    locale = currentLocale(),
    apiVersion = GetAPIVersion and GetAPIVersion() or 0,
    items = metaItems,
    categories = categories,
  }

  if FurC.Logger then
    FurC.Logger:Info(
      "|cFF3333FurCDev|r meta dump: %d items, %d furniture, %d categories.",
      stats.items,
      stats.furniture,
      numCats
    )
  end

  showOutput(
    string.format(
      "FurCDev meta dump\n  items:      %d\n  furniture:  %d (of which %d resolved via recipe)\n  categories: %d\n\nReload the UI to write SavedVariables to disk.",
      stats.items,
      stats.furniture,
      stats.recipesResolved,
      numCats
    )
  )

  if not skipReloadPrompt then
    promptReload()
  end
end

-------------------------
-- Shapes: verbose and compact
-------------------------

-- Inverted from the enum, so a new source needs no change here
local SOURCE_KEY = {}
for name, value in pairs(src) do
  SOURCE_KEY[value] = name
end

-- Stable English labels. Not the locale strings, those follow the client
local SOURCE_LABEL = {
  [src.NONE] = "Unknown",
  [src.CRAFTING] = "Crafting",
  [src.CRAFTING_KNOWN] = "Crafting",
  [src.CRAFTING_UNKNOWN] = "Crafting",
  [src.VENDOR] = "Achievement Vendor",
  [src.PVP] = "PvP Vendor",
  [src.WRIT_VENDOR] = "Master Writ Vendor",
  [src.CROWN] = "Crown Store",
  [src.RUMOUR] = "Datamined, unconfirmed",
  [src.LUXURY] = "Luxury Furnisher",
  [src.OTHER] = "Other",
  [src.ROLIS] = "Rolis Hlaalu",
  [src.DROP] = "Drop",
  [src.JUSTICE] = "Justice",
  [src.FISHING] = "Fishing",
  [src.GUILDSTORE] = "Guild Store",
  [src.FESTIVAL_DROP] = "Event",
  [src.BAZAAR] = "Gold Coast Bazaar",
  [src.TOMES] = "Tamriel Tomes",
  [src.TELVAR] = "Tel Var Merchant",
  [src.COLL_MERCH] = "Collectibles Merchant",
  [src.EDITOR] = "Housing Editor",
  [src.ANTIQUITY] = "Antiquity",
}

-- Filter pseudo-sources and the favourites flag are UI state, not provenance
local NOT_A_SOURCE = {
  [src.FAVE] = true,
  [src.CRAFTING_KNOWN] = true,
  [src.CRAFTING_UNKNOWN] = true,
}

local function labelFor(sourceId)
  return SOURCE_LABEL[sourceId] or SOURCE_KEY[sourceId] or ("Source " .. tostring(sourceId))
end

---Ranked, de-duplicated real sources for a DB entry
---@param entry FurCEntry
---@return integer[] sourceIds
local function sourcesFor(entry)
  local ids, seen = {}, {}
  for sourceId in pairs(entry.sources or {}) do
    if type(sourceId) == "number" and not seen[sourceId] and not NOT_A_SOURCE[sourceId] then
      seen[sourceId] = true
      ids[#ids + 1] = sourceId
    end
  end
  if type(entry.origin) == "number" and not seen[entry.origin] and not NOT_A_SOURCE[entry.origin] then
    ids[#ids + 1] = entry.origin
  end
  table.sort(ids, function(left, right)
    local leftRank = SOURCE_PRIORITY[left] or math.huge
    local rightRank = SOURCE_PRIORITY[right] or math.huge
    if leftRank == rightRank then
      return left < right
    end
    return leftRank < rightRank
  end)
  return ids
end

---Resolved source text per source, the same strings the in-game tooltip shows
---@param itemId integer
---@param entry FurCEntry
---@param sourceIds integer[] from sourcesFor
---@return table<integer, string>? texts nil when nothing resolved
local function describeFor(itemId, entry, sourceIds)
  if not (query and query.DescribeSource) then
    return nil
  end

  local texts
  for index, sourceId in ipairs(sourceIds) do
    local ok, text
    if sourceId == src.CRAFTING or sourceId == src.WRIT_VENDOR then
      ok, text = pcall(query.GetRecipeSource, itemId, entry)
    else
      ok, text = pcall(query.DescribeSource, itemId, entry, sourceId, false)
    end
    if ok and type(text) == "string" and text ~= "" then
      text = cleanText(text)
      if text ~= "" then
        texts = texts or {}
        texts[index] = text
      end
    end
  end
  return texts
end

---Structured source detail per source: vendor, location, achievement, price, date
---@param itemId integer
---@param sourceIds integer[] from sourcesFor
---@return table<integer, table>? info nil when nothing is modelled
local function sourceInfoFor(itemId, sourceIds)
  if not api.GetSourceDetails then
    return nil
  end
  local ok, records = pcall(api.GetSourceDetails, itemId)
  if not ok or type(records) ~= "table" then
    return nil
  end

  local byType = {}
  for _, rec in ipairs(records) do
    local sourceType = rec.source and rec.source.type
    if sourceType then
      byType[sourceType] = rec
    end
  end

  local info
  for index, sourceId in ipairs(sourceIds) do
    local rec = byType[sourceId]
    if rec then
      local vendor, fromItem = rec.source.vendor, nil
      if type(vendor) == "string" and vendor:find("|H", 1, true) then
        fromItem = fmt.GetItemId(vendor)
        vendor = nil
      end

      local detail = {
        vendor = cleanText(vendor),
        fromItem = fromItem,
        location = cleanText(rec.source.location),
        achievement = rec.source.achievement,
        event = cleanText(rec.source.event),
        lastSeen = rec.availability and rec.availability.lastSeen,
      }
      local cost = rec.cost
      if cost then
        detail.currency = cost.currency
        detail.amount = cost.amount
      end
      if next(detail) then
        info = info or {}
        info[index] = detail
      end
    end
  end
  return info
end

---Ingredient item ids and quantities for a craftable
---@param itemId integer
---@param entry FurCEntry
---@return table<integer, integer>? materials nil when the item is not craftable
local function materialsFor(itemId, entry)
  if not (entry.blueprint or (entry.recipeListIndex and entry.recipeIndex)) then
    return nil
  end
  local getIngredients, getLink = query.GetIngredients, fmt.GetItemLink
  if type(getIngredients) ~= "function" or type(getLink) ~= "function" then
    return nil
  end

  local ok, ingredients = pcall(getIngredients, getLink(itemId), entry)
  if not ok or type(ingredients) ~= "table" then
    return nil
  end

  local materials
  for ingredientLink, quantity in pairs(ingredients) do
    local materialId = tonumber(ingredientLink) or fmt.GetItemId(ingredientLink)
    quantity = tonumber(quantity)
    if materialId and materialId > 0 and quantity and quantity > 0 then
      materials = materials or {}
      materials[materialId] = (materials[materialId] or 0) + quantity
    end
  end
  return materials
end

---Container item id -> contained furnishing ids, for book collections and folios
---Folio contents are recipe ids and resolve to the furnishing they produce
---@return table<integer, integer[]> index itemId -> container ids
---@return table<integer, string> notes container id -> its note, in client locale
local function buildContainerIndex()
  local index, notes = {}, {}
  local resolveRecipe = build and build.ResolveRecipe
  local strip = LFC.Internal.Format.stripTxt

  local function add(itemId, containerId)
    local containers = index[itemId]
    if not containers then
      index[itemId] = { containerId }
      return
    end
    for _, existing in ipairs(containers) do
      if existing == containerId then
        return
      end
    end
    containers[#containers + 1] = containerId
  end

  local function noteFor(container)
    local note = container.note
    if type(note) ~= "string" or note == "" then
      return nil
    end
    note = (strip and strip(note)) or note
    if note:find("|H", 1, true) then
      return nil
    end
    return note
  end

  for containerId, collection in pairs(FurC.BookCollections or {}) do
    notes[containerId] = noteFor(collection)
    for _, bookId in ipairs(collection.contents or {}) do
      add(bookId, containerId)
    end
  end

  for folioId, folio in pairs(FurC.FurnishingFolios or {}) do
    notes[folioId] = noteFor(folio)
    for _, recipeId in ipairs(folio.contents or {}) do
      local itemId = (resolveRecipe and resolveRecipe(recipeId)) or recipeId
      if itemId then
        add(itemId, folioId)
      end
    end
  end

  return index, notes
end

---One build pass feeding both exports
---@return table records itemId -> { sources, materials, containers }
---@return table stats
local function buildRecords()
  FurC.EnsureDB(true) -- blocking: we need the whole DB
  local containers, containerNotes = buildContainerIndex()

  local records = {}
  local stats = { items = 0, craftable = 0, sourceless = 0, inContainers = 0, described = 0, detailed = 0 }

  for id, entry in pairs(FurC.DB or {}) do
    if type(id) == "number" and id > 0 and type(entry) == "table" then
      local sources = sourcesFor(entry)
      local record = {
        sources = sources,
        texts = describeFor(id, entry, sources), -- verbose: the composed sentence
        info = sourceInfoFor(id, sources), -- compact: the parts it is composed from
        materials = materialsFor(id, entry),
        containers = containers[id],
      }
      records[id] = record

      stats.items = stats.items + 1
      if record.texts then
        stats.described = stats.described + 1
      end
      if record.info then
        stats.detailed = stats.detailed + 1
      end
      if record.materials then
        stats.craftable = stats.craftable + 1
      end
      if #sources == 0 then
        stats.sourceless = stats.sourceless + 1
      end
      if record.containers then
        stats.inContainers = stats.inContainers + 1
      end
    end
  end

  stats.locale = currentLocale()
  stats.apiVersion = GetAPIVersion and GetAPIVersion() or 0
  return records, stats, containerNotes
end

---Item, material and container names, in the client's language
---@param records table
---@return table<integer, string> names
local function collectNames(records)
  local getName = FurC.Utils.GetItemName
  local names = {}

  local extraIds = {}
  for itemId, record in pairs(records) do
    names[itemId] = getName(itemId) or ""
    for materialId in pairs(record.materials or {}) do
      extraIds[materialId] = true
    end
    for _, containerId in ipairs(record.containers or {}) do
      extraIds[containerId] = true
    end
  end
  for id in pairs(extraIds) do
    names[id] = names[id] or getName(id) or ""
  end

  return names
end

-------------------------
-- Shape: verbose
-------------------------

local function dumpVerbose()
  local records, stats, containerNotes = buildRecords()
  local names = collectNames(records)

  local items = {}
  for _, itemId in ipairs(sortedKeys(records)) do
    local record = records[itemId]
    local item = {}

    local sources = record.sources
    local texts = record.texts or {}
    if #sources > 0 then
      item.source = labelFor(sources[1])
      item.description = texts[1]
      if #sources > 1 then
        local rest, restTexts = {}, nil
        for index = 2, #sources do
          rest[#rest + 1] = labelFor(sources[index])
          if texts[index] then
            restTexts = restTexts or {}
            restTexts[index - 1] = texts[index]
          end
        end
        item.sources = rest
        item.descriptions = restTexts
      end
    else
      item.source = labelFor(src.NONE)
    end

    if record.materials then
      local pieces = {}
      for _, materialId in ipairs(sortedKeys(record.materials)) do
        local name = names[materialId]
        if not name or name == "" then
          name = tostring(materialId)
        end
        pieces[#pieces + 1] = string.format("%dx %s", record.materials[materialId], name)
      end
      item.materials = table.concat(pieces, ", ")
    end

    if record.containers then
      local pieces, noteParts = {}, {}
      for _, containerId in ipairs(record.containers) do
        local name = names[containerId]
        pieces[#pieces + 1] = (name and name ~= "" and name) or tostring(containerId)
        local note = containerNotes[containerId]
        if note then
          noteParts[#noteParts + 1] = note
        end
      end
      item.collection = table.concat(pieces, ", ")
      if #noteParts > 0 then
        item.notes = table.concat(noteParts, "; ")
      end
    end

    local name = names[itemId]
    if name and name ~= "" then
      item.name = name
    end

    items[itemId] = item
  end

  savedVars().verbose = {
    format = VERBOSE_FORMAT,
    version = EXPORT_VERSION,
    locale = stats.locale,
    apiVersion = stats.apiVersion,
    itemCount = stats.items,
    items = items,
  }

  return stats
end

-------------------------
-- Shape: compact
-------------------------

---Source vocabulary limited to what this dump actually uses
---@param records table
---@return integer[] sourceIds
---@return table<integer, string> keys
---@return table<integer, string> labels
local function sourceVocabulary(records)
  local used = {}
  for _, record in pairs(records) do
    for _, sourceId in ipairs(record.sources) do
      used[sourceId] = true
    end
  end

  local ids = sortedKeys(used)
  local keys, labels = {}, {}
  for _, sourceId in ipairs(ids) do
    keys[sourceId] = SOURCE_KEY[sourceId] or tostring(sourceId)
    labels[sourceId] = labelFor(sourceId)
  end
  return ids, keys, labels
end

local function dumpCompact()
  local records, stats = buildRecords()
  local names = collectNames(records)
  local _, sourceKeys, sourceLabels = sourceVocabulary(records)

  local items, materialNames = {}, {}
  local textList, textIds = {}, {}
  local function internText(text)
    local id = textIds[text]
    if not id then
      id = #textList + 1
      textList[id] = text
      textIds[text] = id
    end
    return id
  end

  local function ref(value)
    if value == nil then
      return 0
    end
    return internText(value)
  end

  local itemNames = {}
  for _, itemId in ipairs(sortedKeys(records)) do
    local record = records[itemId]
    local row, n = {}, 0
    local function put(value)
      n = n + 1
      row[n] = value or 0
    end

    local sources = record.sources or {}
    put(#sources)
    for _, sourceId in ipairs(sources) do
      put(sourceId)
    end

    local materials = record.materials
    local matIds = materials and sortedKeys(materials) or {}
    put(#matIds)
    for _, materialId in ipairs(matIds) do
      put(materialId)
      put(materials[materialId])
      materialNames[materialId] = names[materialId] or ""
    end

    local containers = record.containers or {}
    put(#containers)
    for _, containerId in ipairs(containers) do
      put(containerId)
    end

    local info = record.info or {}
    local infoIdx = sortedKeys(info)
    put(#infoIdx)
    for _, index in ipairs(infoIdx) do
      local detail = info[index]
      local achievement = detail.achievement
      put(index)
      put(ref(detail.vendor))
      put(ref(detail.location))
      put(ref(detail.event))
      put(detail.fromItem)
      put(type(achievement) == "number" and achievement or 0)
      put(type(achievement) == "string" and ref(cleanText(achievement)) or 0)
      put(detail.currency)
      put(detail.amount)
      put(ref(detail.lastSeen))
    end

    local texts = record.texts or {}
    local txtIdx = {}
    for index in ipairs(sources) do
      if texts[index] and not info[index] then
        txtIdx[#txtIdx + 1] = index
      end
    end
    put(#txtIdx)
    for _, index in ipairs(txtIdx) do
      put(index)
      put(internText(texts[index]))
    end

    items[itemId] = row
    local name = names[itemId]
    if name and name ~= "" then
      itemNames[itemId] = name
    end
  end

  savedVars().compact = {
    format = COMPACT_FORMAT,
    version = EXPORT_VERSION,
    locale = stats.locale,
    apiVersion = stats.apiVersion,
    itemCount = stats.items,
    sourceKeys = sourceKeys,
    sourceLabels = sourceLabels,
    rowFormat = "counted sections: src, mats, packs, info, txt - see the rendered accessors",
    sourceTexts = textList,
    itemNames = itemNames,
    currencies = (currencies()),
    materialNames = materialNames,
    items = items,
  }

  return stats
end

---Constants companion as Lua source, for the output box
---@param records table
---@param stats table
---@return string
local function renderConstants(records, stats)
  local names = collectNames(records)
  local sourceIds, sourceKeys, sourceLabels = sourceVocabulary(records)

  local out = {}
  local function line(text)
    out[#out + 1] = text or ""
  end

  local usedMaterials = {}
  for _, record in pairs(records) do
    for materialId in pairs(record.materials or {}) do
      usedMaterials[materialId] = true
    end
  end

  line("-- FurnitureCatalogue furnishing data export -- constants companion.")
  line("--")
  line(string.format("-- Format %s, generated against game API %d.", COMPACT_FORMAT, stats.apiVersion))
  line("")

  line("-- Source constants. Values are FurnitureCatalogue's ItemSources enum.")
  for _, sourceId in ipairs(sourceIds) do
    line(string.format("local SRC_%s = %d", sourceKeys[sourceId], sourceId))
  end
  line("")

  line("-- Stable identifier per source constant.")
  line("local SOURCE_KEYS = {")
  for _, sourceId in ipairs(sourceIds) do
    line(string.format("  [SRC_%s] = %q,", sourceKeys[sourceId], sourceKeys[sourceId]))
  end
  line("}")
  line("")

  line("-- English display label per source constant.")
  line("local SOURCE_LABELS = {")
  for _, sourceId in ipairs(sourceIds) do
    line(string.format("  [SRC_%s] = %q,", sourceKeys[sourceId], sourceLabels[sourceId]))
  end
  line("}")
  line("")

  line("-- Crafting materials referenced by the data file, by item id.")
  for _, materialId in ipairs(sortedKeys(usedMaterials)) do
    local name = (names[materialId] or ""):gsub("[\r\n]", " ")
    line(string.format("-- %d%s", materialId, (name ~= "" and (" -- " .. name)) or ""))
  end
  line("")

  line("return { SOURCE_KEYS = SOURCE_KEYS, SOURCE_LABELS = SOURCE_LABELS }")
  return table.concat(out, "\n")
end

local function report(title, stats, target, skipReloadPrompt)
  local summary = string.format(
    "%s\n  items:      %d\n  craftable:  %d\n  in packs:   %d\n  no source:  %d\n  described:  %d\n  detailed:   %d\n  locale:     %s\n  API:        %d\n\nReload the UI to write %s to disk.",
    title,
    stats.items,
    stats.craftable,
    stats.inContainers,
    stats.sourceless,
    stats.described or 0,
    stats.detailed or 0,
    stats.locale,
    stats.apiVersion,
    target
  )

  if FurC.Logger then
    FurC.Logger:Info("|cFF3333FurCDev|r %s: %d items, %d craftable.", title, stats.items, stats.craftable)
  end

  showOutput(summary)

  if not skipReloadPrompt then
    promptReload()
  end
end

function this.DumpVerbose(skipReloadPrompt)
  report("FurCDev verbose export", dumpVerbose(), "FurCDev_SavedVariables.verbose", skipReloadPrompt)
end

function this.DumpCompact(skipReloadPrompt)
  report("FurCDev compact export", dumpCompact(), "FurCDev_SavedVariables.compact", skipReloadPrompt)
end

---Constants companion into the output box. No SavedVars, no reload
function this.ShowConstants()
  local records, stats = buildRecords()
  local constants = renderConstants(records, stats)

  showOutput(constants)
  if FurC.Logger then
    FurC.Logger:Info("|cFF3333FurCDev|r constants companion: %d chars.", #constants)
  end
end

this.RenderConstants = renderConstants
this.BuildExportRecords = buildRecords

-------------------------
-- Dump tab
-------------------------

local BUTTON_WIDTH = 190
local BUTTON_HEIGHT = 28
local ROW_GAP = 34

---@param panel table parent control
---@param index integer row, top to bottom
---@param label string caption
---@param hint string one-line explanation shown next to the button
---@param onClicked function
---@param panel table parent control
---@param index integer row, top to bottom
---@param label string caption
---@param hint string tooltip text
---@param onClicked function
local function addButton(panel, index, label, hint, onClicked)
  local name = "FurCDevControl_Dump_" .. label:gsub("%W", "")
  local button = WINDOW_MANAGER:CreateControlFromVirtual(name, panel, "ZO_DefaultButton")
  button:SetDimensions(BUTTON_WIDTH, BUTTON_HEIGHT)
  button:SetAnchor(TOPLEFT, panel, TOPLEFT, 0, (index - 1) * ROW_GAP)
  button:SetText(label)
  button:SetHandler("OnClicked", onClicked)

  button:SetHandler("OnMouseEnter", function(control)
    InitializeTooltip(InformationTooltip, control, RIGHT, -8, 0, LEFT)
    SetTooltipText(InformationTooltip, hint)
  end)
  button:SetHandler("OnMouseExit", function()
    ClearTooltip(InformationTooltip)
  end)
  return button
end

function this.BuildDumpTab()
  local sibling = FurCDevControl_Achievements
  local parent = sibling and sibling.GetParent and sibling:GetParent()
  if
    not parent
    or not WINDOW_MANAGER
    or not WINDOW_MANAGER.CreateControl
    or not WINDOW_MANAGER.CreateControlFromVirtual
  then
    return
  end

  local panel = WINDOW_MANAGER:CreateControl("FurCDevControl_Dump", parent, CT_CONTROL)
  panel:SetAnchorFill(parent)
  panel:SetHidden(true)

  addButton(
    panel,
    1,
    "Verbose dump",
    "Every value spelled out as English text.\nWrites FurCDev_SavedVariables.verbose.\nNeeds a reload to reach disk.",
    function()
      this.DumpVerbose(true)
    end
  )
  addButton(
    panel,
    2,
    "Compact dump",
    "Same data as ids and source enums.\nWrites FurCDev_SavedVariables.compact.\nNeeds a reload to reach disk.",
    function()
      this.DumpCompact(true)
    end
  )
  addButton(
    panel,
    3,
    "Meta dump",
    "Names, quality, category and the category tree.\nWrites FurCDev_SavedVariables.meta.\nNeeds a reload to reach disk.",
    function()
      this.DumpMeta(true)
    end
  )
  addButton(
    panel,
    4,
    "Constants only",
    "Source constants and material legend as Lua source.\nGoes to the output box, ready to copy.\nNo reload needed.",
    function()
      this.ShowConstants()
    end
  )
  addButton(panel, 5, "Reload UI", "Flushes SavedVariables to disk.\nAsks first.", promptReload)

  this.RegisterTab("dump", "Dump", panel)
end
