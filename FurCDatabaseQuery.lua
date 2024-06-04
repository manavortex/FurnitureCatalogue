local FurC = FurC or {}

local colour = FurC.Constants.Colours
local curr = FurC.Constants.Currencies
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local src = FurC.Constants.ItemSources

local join = zo_strjoin

local colourise = FurC.Utils.Colourise
local stripText = FurC.Utils.stripTxt
local getItemLink = FurC.Utils.GetItemLink
local fmtFurnisher = FurC.Utils.FormatFurnisher

local strVoucherVendor = GetString(SI_FURC_STRING_VOUCHER_VENDOR)
local fmtVendor = GetString(SI_FURC_STRING_VENDOR)

local function getRolisSource(recipeKey, recipeArray)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local versionData = FurC.Rolis[recipeArray.version]

  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice =
      zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colourise(versionData[recipeKey], colour.Voucher))
    return zo_strformat(GetString(SI_FURC_TRADERS_ROLIS), itemPrice)
  end

  versionData = FurC.Faustina[recipeArray.version]
  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice =
      zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colourise(versionData[recipeKey], colour.Voucher))
    return zo_strformat(GetString(SI_FURC_TRADERS_FAUSTINA), itemPrice)
  end

  return strVoucherVendor -- fallback
end
FurC.getRolisSource = getRolisSource

local strAroundDate = GetString(SI_FURC_STRING_WEEKEND_AROUND)
local function getLuxurySource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local versionData = FurC.LuxuryFurnisher[recipeArray.version]
  if not versionData then
    return "SI_FURC_STRING_FETCHER" -- ToDo: placeholder until I know who it is
  end

  local itemData = versionData[recipeKey]
  if nil ~= itemData then
    local yyyy, mm, dd = string.match(itemData.itemDate, "(%d+)-(%d+)-(%d+)")

    local formattedDate = ""
    if yyyy and mm and dd then
      local formatted = FurC.GetDateFormat()
      formatted = string.gsub(formatted, "YYYY", yyyy)
      formatted = string.gsub(formatted, "MM", mm)
      formatted = string.gsub(formatted, "DD", dd)
      formattedDate = formatted
    end

    local weekendString = (nil == itemData.itemDate and "")
      or zo_strformat(strAroundDate, colourise(formattedDate, colour.Gold))
    local result = fmtFurnisher(npc.LUXF, loc.COLDH, itemData.itemPrice, nil, weekendString)
    if stripColor then
      result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
    end
    return result
  end

  return "SI_FURC_STRING_FETCHER" -- ToDo: placeholder until I know who it is
end
FurC.getLuxurySource = getLuxurySource

local function getPvpSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local versionData = FurC.PVP[recipeArray.version]
  if not versionData then
    return "getPvpSource: nil"
  end

  -- structure: [2] = {[Furnishing vendor] = {[Cyrodiil] = {[123] = {}}}}
  for vendorName, vendorData in pairs(versionData) do
    for locationName, locationData in pairs(vendorData) do
      if nil ~= locationData[recipeKey] then
        local item = locationData[recipeKey]
        local result = fmtFurnisher(vendorName, locationName, item.itemPrice, CURT_ALLIANCE_POINTS, item.achievement)
        if stripColor then
          result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
        end
        return result
      end
    end
  end

  return "getPvpSource"
end
FurC.getPvpSource = getPvpSource

-- TODO #REFACTOR: add info to item in DB and generate str from that. then use lookup by id
local function getAchievementVendorSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local versionData = FurC.AchievementVendors[recipeArray.version]
  if not versionData then
    return zo_strformat(
      "getAchievementVendorSource: failed version lookup for ID <<1>> [<<2>>]",
      recipeKey,
      recipeArray.version
    )
  end

  for zoneName, zoneData in pairs(versionData) do
    for vendorName, vendorData in pairs(zoneData) do
      local databaseEntry = vendorData[recipeKey]
      local currency = CURT_MONEY
      if zoneName == loc.DUNG_IA then -- workaround for now, store this info in item in the future
        currency = CURT_ENDLESS_DUNGEON
      end
      if databaseEntry then
        local result = fmtFurnisher(vendorName, zoneName, databaseEntry.itemPrice, currency, databaseEntry.achievement)
        if stripColor then
          result = string.format("%s %s", getItemLink(recipeKey), stripText(result))
        end
        return result
      end
    end
  end
  return zo_strformat("getAchievementVendorSource, found version data but no item data for <<1>> ", recipeKey)
end
FurC.getAchievementVendorSource = getAchievementVendorSource

local function getEventDropSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local itemPriceString = "getEventDropSource: couldn't find " .. tostring(recipeKey)
  local versionDataExists = nil ~= FurC.EventItems[recipeArray.version]
  if not versionDataExists then
    return itemPriceString
  end
  for versionNumber, versionData in pairs(FurC.EventItems) do
    for eventName, eventData in pairs(versionData) do
      for eventItemSource, eventSourceData in pairs(eventData) do
        if eventSourceData[recipeKey] then
          local vendorString = colourise(eventItemSource, colour.Vendor, stripColor)
          itemPriceString = zo_strformat(
            GetString(SI_FURC_GRAMMAR_OBTAINABLE),
            colourise(eventName, colour.Vendor, stripColor),
            vendorString
          )

          if not eventSourceData[recipeKey] then
            return itemPriceString
          end

          local additionalSource = eventSourceData[recipeKey]
          if additionalSource and type(additionalSource) == "table" and additionalSource.itemPrice then
            local itemPrice = colourise(additionalSource.itemPrice, colour.Voucher, stripColor)
            itemPriceString = itemPriceString:sub(1, -2)
              .. zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice)
              .. ")"
          elseif #(tostring(additionalSource)) > 4 then
            itemPriceString = itemPriceString .. "\n" .. tostring(additionalSource)
          end

          return itemPriceString
        end
      end
    end
  end

  return itemPriceString
end
FurC.getEventDropSource = getEventDropSource

local emptyString = GetString(SI_FURC_SRC_EMPTY)
local function registerEmptyItem(recipeKey)
  if recipeKey and tonumber(recipeKey) > 0 then
    FurC.settings.emptyItemSources[recipeKey] =
      zo_strformat(", -- <<1>>", GetItemLinkName(FurC.Utils.GetItemLink(recipeKey)))
  end
  return emptyString
end
local function getMiscItemSource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray or not recipeArray.version or not recipeArray.origin then
    return registerEmptyItem(recipeKey)
  end

  local versionFiles = FurC.MiscItemSources[recipeArray.version]
  if not versionFiles or not versionFiles[recipeArray.origin] then
    return registerEmptyItem(recipeKey)
  end
  local originData = versionFiles[recipeArray.origin][recipeKey]
  if not originData then
    return registerEmptyItem(recipeKey)
  end

  if stripColor then
    originData = string.format("%s %s", getItemLink(recipeKey), stripText(originData))
  end

  return originData
end
FurC.getMiscItemSource = getMiscItemSource

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

  return (recipeArray.origin == src.RUMOUR and FurC.getRumourSource(recipeKey, recipeArray))
    or FurC.RecipeSources[recipeKey]
end
FurC.getRecipeSource = getRecipeSource

local strRItem = GetString(SI_FURC_SRC_RUMOUR_ITEM)
local strRRecipe = GetString(SI_FURC_SRC_RUMOUR_RECIPE)
function FurC.getRumourSource(recipeKey, recipeArray)
  return (recipeArray.blueprint and strRRecipe) or strRItem
end

local strCantCraft = GetString(SI_FURC_STRING_CANNOT_CRAFT)
local strCraftedBy = GetString(SI_FURC_STRING_CRAFTABLE_BY)
function FurC.GetCrafterList(itemLink, recipeArray)
  if nil == recipeArray and nil == itemLink then
    return
  end
  recipeArray = recipeArray or FurC.Find(itemLink)
  if nil == recipeArray then
    return zo_strformat("FurC.GetCrafterList called for a non-craftable")
  end

  if nil == recipeArray.characters or NonContiguousCount(recipeArray.characters) == 0 then
    return strCantCraft
  end
  local ret = strCraftedBy
  for characterName, characterKnowledge in pairs(recipeArray.characters) do
    ret = string.format("%s %s, ", ret, characterName)
  end
  return ret:sub(0, -3)
end
