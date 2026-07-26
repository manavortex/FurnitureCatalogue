-- DB read path: Find, ingredient/material queries, per-source description renderers

local FurC = FurC or {}
FurC.DBQuery = FurC.DBQuery or {}
local this = FurC.DBQuery

local LFC = LibFurnitureCatalogue
local colour = LFC.Internal.Constants.Colours
local loc = LFC.Internal.Constants.Locations
local npc = LFC.Internal.Constants.NPC
local src = LFC.Internal.Constants.ItemSources

local colourise = LFC.Internal.Format.Colourise
local getItemId = LFC.Internal.Format.GetItemId
local getItemLink = LFC.Internal.Format.GetItemLink
local strEvent = LFC.Internal.Format.FormatEvent
local strFurnisher = LFC.Internal.Format.FormatFurnisher
local strGeneric = LFC.Internal.Format.FmtGeneric
local stripText = LFC.Internal.Format.stripTxt
local strSrc = LFC.Internal.Format.FmtSources
local strPartOf = LFC.Internal.Format.FormatPartOf

local db = LFC.Internal.DB
local ensureDB = LFC.Internal.Build.EnsureDB
local parseFurnitureItem = LFC.Internal.Build.ParseFurnitureItem
local parseBlueprint = LFC.Internal.Build.ParseBlueprint
local SOURCE_PRIORITY = LFC.Internal.Constants.SOURCE_PRIORITY

-- single-entry memo for find
local lastLink = nil
local recipeArray = nil

---DB entry for an item/blueprint, builds DB on first use
---@param itemOrBlueprintLink string|integer item link, blueprint link, or itemId
---@return FurCEntry entry the entry, or `{}` if unknown
local function find(itemOrBlueprintLink)
  ensureDB()
  if tonumber(itemOrBlueprintLink) == itemOrBlueprintLink then
    itemOrBlueprintLink = getItemLink(itemOrBlueprintLink)
  end
  if nil == itemOrBlueprintLink or #itemOrBlueprintLink == 0 then
    return {}
  end

  if itemOrBlueprintLink == lastLink and nil ~= recipeArray then
    return recipeArray
  else
    recipeArray = nil
    lastLink = itemOrBlueprintLink
  end

  if IsItemLinkFurnitureRecipe(itemOrBlueprintLink) then
    recipeArray = parseBlueprint(itemOrBlueprintLink)
  elseif IsItemLinkPlaceableFurniture(itemOrBlueprintLink) then
    recipeArray = parseFurnitureItem(itemOrBlueprintLink)
  else
    local itemId = getItemId(itemOrBlueprintLink)
    if itemId ~= nil and tonumber(itemId) > 0 then
      recipeArray = db[itemId]
    end
  end

  return recipeArray or {}
end
this.Find = find

---@deprecated alias for DBQuery.Find
FurC.Find = find

local function getIngredients(itemLink, recipeArray)
  recipeArray = recipeArray or find(itemLink)
  local ingredients = {}
  if not recipeArray or next(recipeArray) == nil then
    return ingredients
  end
  if recipeArray.blueprint then
    local blueprintLink = getItemLink(recipeArray.blueprint)
    local numIngredients = GetItemLinkRecipeNumIngredients(blueprintLink)
    for ingredientIndex = 1, numIngredients do
      local name, _, qty = GetItemLinkRecipeIngredientInfo(blueprintLink, ingredientIndex)
      local ingredientLink = GetItemLinkRecipeIngredientItemLink(blueprintLink, ingredientIndex, LINK_STYLE_DEFAULT)
      ingredients[ingredientLink] = qty
    end
  else
    local _, name, numIngredients = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
    for ingredientIndex = 1, numIngredients do
      local name, _, qty =
        GetRecipeIngredientItemInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex, ingredientIndex)
      local ingredientLink = GetRecipeIngredientItemLink(
        recipeArray.recipeListIndex,
        recipeArray.recipeIndex,
        ingredientIndex,
        LINK_STYLE_DEFAULT
      )
      ingredients[ingredientLink] = qty
    end
  end
  return ingredients
end
this.GetIngredients = getIngredients

---@deprecated alias for DBQuery.GetIngredients
FurC.GetIngredients = getIngredients

local function makeMaterial(recipeKey, recipeArray, tryPlaintext, forcePlaintext)
  if
    nil == recipeArray
    or (nil == recipeArray.blueprint and nil == recipeArray.recipeIndex and nil == recipeArray.recipeListIndex)
  then
    return "couldn't get material list, please re-scan character knowledge"
  end
  local ret = ""
  local ingredients = getIngredients(recipeKey, recipeArray)
  forcePlaintext = forcePlaintext or tryPlaintext and NonContiguousCount(ingredients) > 4
  for ingredientLink, qty in pairs(ingredients) do
    -- auto-capitalize because for some reason the ZOS API doesn't
    local itemText = (
      forcePlaintext and string.gsub(" " .. GetItemLinkName(ingredientLink), "%W%l", string.upper):sub(2)
    ) or ingredientLink
    ret = zo_strformat("<<1>> <<2>>x <<3>>, ", ret, qty, itemText)
  end
  return ret:sub(0, -3)
end
this.GetMats = makeMaterial

---@deprecated alias for DBQuery.GetMats
FurC.GetMats = makeMaterial

local srcEvent = GetString(SI_FURC_EVENT)
local srcEditor = GetString(SI_FURC_SRC_EDITOR)
local strEditorTag = GetString(SI_FURC_SRC_EDITOR_TAG)

local strVoucherVendor = strSrc("src", npc.ROLIS, npc.FAUSTINA)

local join = zo_strjoin
local function strMultiple(...)
  return join(" + ", ...)
end

-- Writ Voucher recipes referenced by blueprint id, so every lookup has to try blueprint as well as id
local function voucherEntry(versionData, recipeKey, blueprintId)
  if nil == versionData then
    return
  end
  return versionData[recipeKey] or (blueprintId and versionData[blueprintId])
end

local function strVoucher(vendor, entry)
  local price = type(entry) == "table" and entry.itemPrice or entry
  local info = type(entry) == "table" and entry.info or nil
  return strFurnisher(vendor, loc.ANY_CAPITAL, price, CURT_WRIT_VOUCHERS, info)
end

local function getRolisSource(recipeKey, recipeArray)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return
  end
  local version = recipeArray.version
  local blueprintId = recipeArray.blueprint

  local entry = voucherEntry(FurC.Rolis[version], recipeKey, blueprintId)
  if nil ~= entry then
    return strVoucher(npc.ROLIS, entry)
  end

  entry = voucherEntry(FurC.Faustina[version], recipeKey, blueprintId)
    or voucherEntry(FurC.FaustinaRecipes[version], recipeKey, blueprintId)
  if nil ~= entry then
    return strVoucher(npc.FAUSTINA, entry)
  end

  -- check if this recipe is part of a furnishing folio
  if FurC.FurnishingFolios then
    for folioId, folioData in pairs(FurC.FurnishingFolios) do
      if folioData.contents then
        for _, contentId in ipairs(folioData.contents) do
          if contentId == recipeKey or contentId == blueprintId then
            local partOfStr = strPartOf(folioId)
            return strFurnisher(npc.FAUSTINA, loc.ANY_CAPITAL, folioData.price, CURT_WRIT_VOUCHERS, partOfStr)
          end
        end
      end
    end
  end

  return strVoucherVendor -- fallback
end

this.GetRolisSource = getRolisSource

local emptyString = GetString(SI_FURC_SRC_EMPTY)

local strAroundDate = GetString(SI_FURC_STRING_WEEKEND_AROUND)
local function getLuxurySource(recipeKey, recipeArray, stripColor, opts)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return
  end

  local versionData = FurC.LuxuryFurnisher[recipeArray.version]
  local itemData = versionData and versionData[recipeKey]
  if not itemData then
    for _, vData in pairs(FurC.LuxuryFurnisher) do
      if vData[recipeKey] then
        itemData = vData[recipeKey]
        break
      end
    end
  end
  if not itemData then
    return emptyString
  end

  local yyyy, mm, dd = string.match(itemData.itemDate, "(%d+)-(%d+)-(%d+)")

  local formattedDate = ""
  if yyyy and mm and dd then
    local formatted = (opts and opts.dateFormat) or "YYYY-MM-DD"
    formatted = string.gsub(formatted, "YYYY", yyyy)
    formatted = string.gsub(formatted, "MM", mm)
    formatted = string.gsub(formatted, "DD", dd)
    formattedDate = formatted
  end

  local luxuryStr = (nil == itemData.itemDate and "")
    or zo_strformat(strAroundDate, colourise(formattedDate, colour.Gold))
  local result = strFurnisher(npc.LUXF, loc.COLDH, itemData.itemPrice, nil, luxuryStr)
  if stripColor then
    result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
  end
  return result
end
this.GetLuxurySource = getLuxurySource

local function getPvpSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return
  end

  local function findIn(versionData)
    if not versionData then
      return
    end
    for vendorName, vendorData in pairs(versionData) do
      for locationName, locationData in pairs(vendorData) do
        if nil ~= locationData[recipeKey] then
          return vendorName, locationName, locationData[recipeKey]
        end
      end
    end
  end

  local vendorName, locationName, item = findIn(FurC.PVP[recipeArray.version])
  if not item then
    for _, versionData in pairs(FurC.PVP) do
      vendorName, locationName, item = findIn(versionData)
      if item then
        break
      end
    end
  end
  if not item then
    return emptyString
  end

  local currency = item.currency or CURT_ALLIANCE_POINTS
  local result = strFurnisher(vendorName, locationName, item.itemPrice, currency, item.achievement)
  if stripColor then
    result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
  end
  return result
end
this.GetPvpSource = getPvpSource

-- TODO #REFACTOR: add info to item in DB and generate str from that. then use lookup by id
local function getAchievementVendorSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return
  end

  local function findIn(versionData)
    if not versionData then
      return
    end
    for zoneName, zoneData in pairs(versionData) do
      for vendorName, vendorData in pairs(zoneData) do
        if vendorData[recipeKey] then
          return zoneName, vendorName, vendorData[recipeKey]
        end
      end
    end
  end

  local zoneName, vendorName, databaseEntry = findIn(FurC.AchievementVendors[recipeArray.version])
  if not databaseEntry then
    for _, versionData in pairs(FurC.AchievementVendors) do
      zoneName, vendorName, databaseEntry = findIn(versionData)
      if databaseEntry then
        break
      end
    end
  end
  if not databaseEntry then
    return emptyString
  end

  local currency = CURT_MONEY
  if databaseEntry.currency then
    currency = databaseEntry.currency
  end

  local result = strFurnisher(vendorName, zoneName, databaseEntry.itemPrice, currency, databaseEntry.achievement)
  if stripColor then
    result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
  end
  return result
end
this.GetAchievementVendorSource = getAchievementVendorSource

local validEventItemTypes = {
  ["boolean"] = true,
  ["string"] = true,
  ["table"] = true,
}
local function getEventDropSource(recipeKey, recipeArray)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return
  end

  local itemPriceString = "getEventDropSource: couldn't find " .. tostring(recipeKey)
  local versionDataExists = nil ~= FurC.EventItems[recipeArray.version]
  if not versionDataExists then
    return itemPriceString
  end

  -- leaf can have 3 types: boolean, string or table
  -- FurC.EventItems[27]["Witches Festival"]["plunderskulllink"][198390] = true
  -- FurC.EventItems[4]["Witches Festival"]["plunderskulllink"][130302] = "text"
  -- FurC.EventItems[25]["Anniversary"]["npcname"][198390] = {itemPrice=123}
  for version, events in pairs(FurC.EventItems) do
    for eventName, sources in pairs(events) do
      for srcName, items in pairs(sources) do
        local item = items[recipeKey]

        if nil ~= item then -- item found
          local itemType = type(item)
          assert(validEventItemTypes[itemType], "getEventDropSource: invalid item type")

          if itemType == "boolean" then -- probably a drop
            return strGeneric(srcEvent, srcName, "src", eventName)
          end

          if itemType == "string" then -- must be additional source
            local src1 = strGeneric(srcEvent, srcName, "src", eventName)
            local src2 = strSrc("src", item)
            return strMultiple(src1, src2)
          end

          if itemType == "table" then -- Schema: must have price, may have currency + achievement
            local currency = item.currency or (srcName == npc.EVENT and CURT_TRADE_BARS or CURT_MONEY)
            return strFurnisher(srcName, eventName, item.itemPrice, currency, item.achievement)
          end
        end
      end
    end
  end
end
this.GetEventDropSource = getEventDropSource

local function getMiscItemSource(recipeKey, recipeArray, stripColor, source)
  recipeArray = recipeArray or find(recipeKey)
  -- "source" allows asking for specific category
  -- defaults to primary (top ranked source)
  source = source or recipeArray.origin
  if nil == next(recipeArray) or not source then
    return emptyString
  end

  -- same [version][source][itemId] shape in both files
  local dataFiles = { FurC.MiscItemSources, FurC.CrownStore, FurC.Antiquities, FurC.Justice, FurC.Fishing }

  -- TODO: overwrite version (there can be only one)
  local function lookup(version)
    for _, dataFile in ipairs(dataFiles) do
      local versionFiles = version and dataFile[version]
      local bucket = versionFiles and versionFiles[source]
      local originData = bucket and bucket[recipeKey]
      if originData then
        return originData
      end
    end
  end
  local originData = lookup(recipeArray.version)
  if not originData then
    for _, dataFile in ipairs(dataFiles) do
      for version, versionFiles in pairs(dataFile) do
        local bucket = versionFiles[source]
        if bucket and bucket[recipeKey] then
          originData = bucket[recipeKey]
          break
        end
      end
      if originData then
        break
      end
    end
  end
  if not originData then
    return emptyString
  end

  if source == src.EDITOR then
    originData = zo_strformat(strEditorTag, originData, srcEditor)
  end

  if stripColor then
    originData = string.format("%s %s", getItemLink(recipeKey), stripText(originData))
  end

  return originData
end
this.GetMiscItemSource = getMiscItemSource

local function getRecipeSource(recipeKey, recipeArray)
  if nil == recipeKey and nil == recipeArray then
    return
  end
  if nil == FurC.RecipeSources then
    return
  end
  if nil ~= FurC.RecipeSources[recipeKey] then
    return FurC.RecipeSources[recipeKey]
  end

  recipeArray = recipeArray or find(recipeKey)

  recipeKey = recipeArray.blueprint or recipeKey

  return (recipeArray.origin == src.RUMOUR and this.GetRumourSource(recipeKey, recipeArray))
    or FurC.RecipeSources[recipeKey]
end
this.GetRecipeSource = getRecipeSource

local strRItem = GetString(SI_FURC_SRC_RUMOUR_ITEM)
local strRRecipe = GetString(SI_FURC_SRC_RUMOUR_RECIPE)
local function getRumourSource(recipeKey, recipeArray)
  return (recipeArray.blueprint and strRRecipe) or strRItem
end
this.GetRumourSource = getRumourSource

local function getCraftingSkillType(recipeKey, recipeArray)
  local itemLink = getItemLink(recipeKey)
  local craftingSkillType = GetItemLinkCraftingSkillType(itemLink)

  if 0 == craftingSkillType and recipeArray.blueprint then
    craftingSkillType = GetItemLinkRecipeCraftingSkillType(getItemLink(recipeArray.blueprint))
  elseif 0 == craftingSkillType and recipeArray.recipeListIndex and recipeArray.recipeIndex then
    _, _, _, _, _, _, craftingSkillType = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
  end

  return craftingSkillType
end
this.GetCraftingSkillType = getCraftingSkillType

-- Description string for each source
local function describeSource(recipeKey, recipeArray, source, stripColor, opts)
  if source == src.CRAFTING or source == src.WRIT_VENDOR then
    -- where blueprint is bought, if we know (otherwise just material list)
    local recipeSource = this.GetRecipeSource(recipeKey, recipeArray)
    if recipeSource and #recipeSource > 0 then
      return (stripColor and stripText(recipeSource)) or recipeSource
    end
    return makeMaterial(recipeKey, recipeArray, stripColor)
  end
  if source == src.ROLIS then
    return this.GetRolisSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.LUXURY then
    return this.GetLuxurySource(recipeKey, recipeArray, stripColor, opts)
  end
  if source == src.GUILDSTORE then
    return GetString(SI_FURC_SEEN_IN_GUILDSTORE)
  end
  if source == src.VENDOR then
    return this.GetAchievementVendorSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.FESTIVAL_DROP then
    return this.GetEventDropSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.PVP then
    return this.GetPvpSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.RUMOUR then
    return this.GetRumourSource(recipeKey, recipeArray, stripColor)
  end
  return this.GetMiscItemSource(recipeKey, recipeArray, stripColor, source)
end
this.DescribeSource = describeSource

-- Single-string description for primary origin (by ranking)
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry looked up via FurC.Find if omitted
---@param stripColor? boolean strip colour control chars
---@param opts? { dateFormat?: string } render options, e.g. the luxury date format (default "YYYY-MM-DD")
---@return string
local function getItemDescription(recipeKey, recipeArray, stripColor, opts)
  recipeKey = getItemId(recipeKey)
  recipeArray = recipeArray or find(recipeKey)
  if nil == next(recipeArray) then
    return ""
  end
  return describeSource(recipeKey, recipeArray, recipeArray.origin, stripColor, opts)
end
this.GetItemDescription = getItemDescription

---@deprecated alias for DBQuery.GetItemDescription
FurC.GetItemDescription = getItemDescription

-- Every non-crafting source of an item, ranked, unfiltered — hiding sources is the consumer's business
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry looked up if omitted
---@param stripColor? boolean strip colour control chars
---@param opts? { dateFormat?: string } render options, e.g. the luxury date format (default "YYYY-MM-DD")
---@return { source: FurCItemSource, text: string }[] ranked best-first, empty renders omitted
local function getRankedSources(recipeKey, recipeArray, stripColor, opts)
  recipeKey = getItemId(recipeKey)
  recipeArray = recipeArray or find(recipeKey)
  local sources = recipeArray and recipeArray.sources
  if not sources then
    return {}
  end

  local ranked = {}
  for s in pairs(sources) do
    if s ~= src.CRAFTING then
      ranked[#ranked + 1] = s
    end
  end
  table.sort(ranked, function(a, b)
    return (SOURCE_PRIORITY[a] or math.huge) < (SOURCE_PRIORITY[b] or math.huge)
  end)

  local lines = {}
  for _, s in ipairs(ranked) do
    local text = describeSource(recipeKey, recipeArray, s, stripColor, opts)
    if text and #text > 0 then
      lines[#lines + 1] = { source = s, text = text }
    end
  end
  return lines
end
this.GetRankedSources = getRankedSources
