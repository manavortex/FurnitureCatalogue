local FurC = FurC or {}
FurC.DBQuery = FurC.DBQuery or {}
local this = FurC.DBQuery
local lib = FurC.Internal

local colour = FurC.Constants.Colours
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local src = FurC.Constants.ItemSources

local colourise = FurC.Utils.Colourise
local getItemLink = FurC.Utils.GetItemLink
local strEvent = FurC.Utils.FormatEvent
local strFurnisher = FurC.Utils.FormatFurnisher
local strGeneric = FurC.Utils.FmtGeneric
local stripText = FurC.Utils.stripTxt
local strSrc = FurC.Utils.FmtSources
local strPartOf = FurC.Utils.FormatPartOf

local srcEvent = GetString(SI_FURC_EVENT)

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
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
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
local function getLuxurySource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
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
    local formatted = FurC.GetDateFormat()
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
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
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
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
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
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
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

          if itemType == "table" then -- must have price
            return strFurnisher(srcName, eventName, item.itemPrice, CURT_TRADE_BARS)
          end
        end
      end
    end
  end
end
this.GetEventDropSource = getEventDropSource

local function getMiscItemSource(recipeKey, recipeArray, stripColor, source)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  -- "source" allows asking for specific category
  -- defaults to primary (top ranked source)
  source = source or recipeArray.origin
  if {} == recipeArray or not source then
    return emptyString
  end

  -- TODO: overwrite version (there can be only one)
  local function lookup(version)
    local versionFiles = version and FurC.MiscItemSources[version]
    local bucket = versionFiles and versionFiles[source]
    return bucket and bucket[recipeKey]
  end
  local originData = lookup(recipeArray.version)
  if not originData then
    for version, versionFiles in pairs(FurC.MiscItemSources) do
      local bucket = versionFiles[source]
      if bucket and bucket[recipeKey] then
        originData = bucket[recipeKey]
        break
      end
    end
  end
  if not originData then
    return emptyString
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

  recipeArray = recipeArray or FurC.Find(recipeKey)

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

local strCantCraft = GetString(SI_FURC_STRING_CANNOT_CRAFT)
local strCraftedBy = GetString(SI_FURC_STRING_CRAFTABLE_BY)
-- ToDo: move to API later
function FurC.GetCrafterList(itemLink, recipeArray)
  if nil == recipeArray and nil == itemLink then
    return
  end
  recipeArray = recipeArray or FurC.Find(itemLink)
  if nil == recipeArray then
    return zo_strformat("FurC.GetCrafterList called for a non-craftable")
  end

  if lib.LCKAvailable() then
    local recipeItem = recipeArray.blueprint and FurC.Utils.GetItemLink(recipeArray.blueprint)
    local names = recipeItem and lib.GetCrafterNames(recipeItem)
    if not names or #names == 0 then
      return strCantCraft
    end
    return strCraftedBy .. table.concat(names, ", ")
  end

  -- TODO: force display LCK tooltip instead somehow
  -- (could hook into recipe variant of hovered item)
  if FurC.CanCraft(nil, recipeArray) then
    return strCraftedBy .. FurC.CharacterName
  end
  return strCantCraft
end
