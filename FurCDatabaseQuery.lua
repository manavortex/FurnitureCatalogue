local FurC = FurC or {}

local colour = FurC.Constants.Colours
local src = FurC.Constants.ItemSources
local loc = FurC.Constants.Locations
local curr = FurC.Constants.Currencies

local join = zo_strjoin

local colourise = FurC.Utils.Colourise
local getItemLink = FurC.Utils.GetItemLink
local strDungeon = FurC.Utils.FormatDungeon
local strEvent = FurC.Utils.FormatEvent
local strLoc = FurC.Utils.FormatLocations
local strPartOf = FurC.Utils.FormatPartOf
local strPick = FurC.Utils.FormatPickpocket
local strPrice = FurC.Utils.FormatPrice
local strScry = FurC.Utils.FmtScryWithPieces
local strSteal = FurC.Utils.FormatSteal

local function makeAchievementLink(achievementId)
  if not achievementId then
    return
  end
  if tonumber(achievementId) ~= achievementId then
    return GetString(SI_FURC_REQUIRES_ACHIEVEMENT) .. achievementId
  end
  return GetString(SI_FURC_REQUIRES_ACHIEVEMENT) .. GetAchievementLink(achievementId, LINK_STYLE_DEFAULT)
end

local function getRolisSource(recipeKey, recipeArray)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return
  end

  local versionData = FurC.Rolis[recipeArray.version]

  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice =
      zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colourise(versionData[recipeKey], colour.Voucher))
    return zo_strformat(GetString(SI_FURC_STRING_ROLIS), itemPrice)
  end

  versionData = FurC.Faustina[recipeArray.version]
  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice =
      zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colourise(versionData[recipeKey], colour.Voucher))
    return zo_strformat(GetString(SI_FURC_STRING_FAUSTINA), itemPrice)
  end

  return GetString(SI_FURC_STRING_VOUCHER_VENDOR)
end
FurC.getRolisSource = getRolisSource

local WEEKEND_DATE = GetString(SI_FURC_STRING_WEEKEND_AROUND)
local SOLD_BY = GetString(SI_FURC_STRING_WASSOLDBY)
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

    local weekendString = (nil == itemData.itemDate and "") or zo_strformat(WEEKEND_DATE, formattedDate)
    return zo_strformat(
      SOLD_BY,
      colourise(GetString(SI_FURC_TRADERS_ZANIL), colour.Vendor, stripColor),
      colourise(GetString(SI_FURC_LOC_COLDH_HOLLOW), colour.Vendor, stripColor),
      colourise(itemData.itemPrice, colour.Gold, stripColor),
      weekendString
    )
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

  for vendorName, vendorData in pairs(versionData) do
    for locationName, locationData in pairs(vendorData) do
      if nil ~= locationData[recipeKey] then
        return zo_strformat(
          GetString(SI_FURC_STRING_VENDOR),
          colourise(vendorName, colour.Vendor, stripColor),
          colourise(locationName, colour.Vendor, stripColor),
          colourise(locationData[recipeKey].itemPrice, colour.AP, stripColor),
          GetString(SI_FURC_STRING_AP)
        )
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
      if databaseEntry then
        return zo_strformat(
          GetString(SI_FURC_STRING_VENDOR),
          colourise(vendorName, colour.Vendor, stripColor),
          colourise(zoneName, colour.Vendor, stripColor),
          colourise(databaseEntry.itemPrice, colour.Gold, stripColor),
          makeAchievementLink(databaseEntry.achievement)
        )
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
    FurC.settings.emptyItemSources[recipeKey] = ", --" .. GetItemLinkName(FurC.Utils.GetItemLink(recipeKey))
  end
  return emptyString
end
local function getMiscItemSource(recipeKey, recipeArray, attachItemLink)
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

  return (attachItemLink and string.format("%s: %s", getItemLink(recipeKey), originData)) or originData
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

function FurC.getRumourSource(recipeKey, recipeArray)
  return (recipeArray.blueprint and GetString(SI_FURC_SRC_RUMOUR_RECIPE)) or GetString(SI_FURC_SRC_RUMOUR_ITEM)
end

function FurC.GetCrafterList(itemLink, recipeArray)
  if nil == recipeArray and nil == itemLink then
    return
  end
  recipeArray = recipeArray or FurC.Find(itemLink)
  if nil == recipeArray then
    return zo_strformat("FurC.GetCrafterList called for a non-craftable")
  end

  if nil == recipeArray.characters or NonContiguousCount(recipeArray.characters) == 0 then
    return GetString(SI_FURC_STRING_CANNOT_CRAFT)
  end
  local ret = GetString(SI_FURC_STRING_CRAFTABLE_BY)
  for characterName, characterKnowledge in pairs(recipeArray.characters) do
    ret = string.format("%s %s, ", ret, characterName)
  end
  return ret:sub(0, -3)
end
