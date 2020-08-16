local FurC = FurC

local vendorColor   = "d68957"
local goldColor     = "e5da40"
local apColor       = "25C31E"
local tvColor       = "5EA4FF"
local voucherColor  = "82BCFF"
local p       = FurC.DebugOut 

local function colorise(str, col, ret)
  str = tostring(str)
  if str:find("%d000$") then str = str:gsub("000$", "k") end
  if ret then return str end
  return string.format("|c%s%s", col, str)
end

local function makeAchievementLink(achievementId)
    if not achievementId then return end
    if tonumber(achievementId) ~= achievementId then return GetString(SI_FURC_REQUIRES_QUEST) ..achievementId end
    return GetString(SI_FURC_REQUIRES_ACHIEVEMENT) .. GetAchievementLink(achievementId)
end

local function getRolisSource(recipeKey, recipeArray)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if not recipeArray then return end

  local versionData = FurC.Rolis[recipeArray.version]

  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colorise(versionData[recipeKey], voucherColor))
    return zo_strformat(GetString(SI_FURC_STRING_Rolis), itemPrice)
  end

  versionData = FurC.Faustina[recipeArray.version]
  if nil ~= versionData and nil ~= versionData[recipeKey] then
    local itemPrice = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), colorise(versionData[recipeKey], voucherColor))
    return zo_strformat(GetString(SI_FURC_STRING_FAUSTINA), itemPrice)
  end

  return GetString(SI_FURC_STRING_VOUCHER_VENDOR)
end
FurC.getRolisSource = getRolisSource


local function getLuxurySource(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if not recipeArray then return end
  local versionData = FurC.LuxuryFurnisher[recipeArray.version]
  if not versionData then return GetString(SI_FURC_STRING_FETCHER) end

  local itemData = versionData[recipeKey]

  if nil ~= itemData then
    local weekendString = (nil == itemData.itemDate and "") or zo_strformat(GetString(SI_FURC_STRING_WEEKEND_AROUND), itemData.itemDate)
    return zo_strformat(
      GetString(SI_FURC_STRING_WASSOLDBY),
      colorise(GetString(SI_FURC_STRING_ASSHOLE), vendorColor, stripColor),
      colorise(GetString(SI_FURC_STRING_HC), vendorColor, stripColor),
      colorise(itemData.itemPrice, goldColor, stripColor),
      weekendString
    )
  end
  return GetString(SI_FURC_STRING_FETCHER)
end
FurC.getLuxurySource = getLuxurySource

local function getPvpSource(recipeKey, recipeArray, stripColor)

  recipeArray = recipeArray or FurC.Find(recipeKey)
  if not recipeArray then return end
  local versionData = FurC.PVP[recipeArray.version]
  if not versionData then return "getPvpSource: nil" end

  for vendorName, vendorData in pairs(versionData) do
    for locationName, locationData in pairs(vendorData) do
      if nil ~= locationData[recipeKey] then
        return zo_strformat(
          GetString(SI_FURC_STRING_VENDOR),
          colorise(vendorName,   vendorColor, stripColor),
          colorise(locationName,   vendorColor, stripColor),
          colorise(locationData[recipeKey].itemPrice,   apColor, stripColor),
          GetString(SI_FURC_STRING_AP)
        )
      end
    end
  end

  return "getPvpSource"

end
FurC.getPvpSource = getPvpSource
local typeTable = "table"
local function getAchievementVendorSource(recipeKey, recipeArray, stripColor)

  recipeArray = recipeArray or FurC.Find(recipeKey)
  if not recipeArray then return end
  local versionData = FurC.AchievementVendors[recipeArray.version]
  if not versionData then
    return zo_strformat("getAchievementVendorSource: failed version lookup for ID <<1>> [<<2>>]", recipeKey, recipeArray.version)
  end

  local databaseEntry

  for zoneName, zoneData in pairs(versionData) do
    for vendorName, vendorData in pairs(zoneData) do
      databaseEntry = vendorData[recipeKey]
      if nil ~= databaseEntry then
        return zo_strformat(
          GetString(SI_FURC_STRING_VENDOR),
          colorise(vendorName,         vendorColor, stripColor),
          colorise(zoneName,           vendorColor, stripColor),
          colorise(databaseEntry.itemPrice,   goldColor,    stripColor),
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
  if not recipeArray then return end
  local versionData = FurC.EventItems[recipeArray.version]
  local itemPriceString = "getEventDropSource: couldn't find " .. tostring(recipeKey)
  if not versionData then
    return itemPriceString
  end
  for versionNumber, versionData in pairs(FurC.EventItems) do
      for eventName, eventData in pairs(versionData) do
        for eventItemSource, eventSourceData in pairs(eventData) do
          if eventSourceData[recipeKey] then
            itemPriceString = zo_strformat(
              GetString(SI_FURC_FESTIVAL_DROP),
              colorise(eventName,       vendorColor, stripColor),
              colorise(eventItemSource,     vendorColor, stripColor)
            )
            local additionalsource = tostring(eventSourceData[recipeKey]) or ""
            if #additionalsource > 4 then
              itemPriceString = itemPriceString .. "\n" .. additionalsource
            end
            return itemPriceString
          end
        end
      end
    end

  return itemPriceString
end
FurC.getEventDropSource = getEventDropSource

	
local emptyString = GetString(SI_FURC_ITEMSOURCE_EMPTY)
local function registerEmptyItem(recipeKey)
	if (recipeKey and tonumber(recipeKey) > 0) then 
		FurC.settings.emptyItemSources[recipeKey] = ", --" .. GetItemLinkName(FurC.GetItemLink(recipeKey))
	end
	return emptyString
end
local function getMiscItemSource(recipeKey, recipeArray, attachItemLink)
	recipeArray = recipeArray or FurC.Find(recipeKey)
	if not recipeArray or not recipeArray.version or not recipeArray.origin then return registerEmptyItem(recipeKey) end

	local versionFiles = FurC.MiscItemSources[recipeArray.version]
	if not versionFiles or not versionFiles[recipeArray.origin] then return registerEmptyItem(recipeKey) end
	local originData = versionFiles[recipeArray.origin][recipeKey]
	if not originData then return registerEmptyItem(recipeKey) end

	return (attachItemLink and string.format("%s: %s", FurC.GetItemLink(recipeKey), originData)) or originData
end
FurC.getMiscItemSource = getMiscItemSource

local function getRecipeSource(recipeKey, recipeArray)
  if nil == recipeKey and nil == recipeArray then return end
  if nil == FurC.RecipeSources then return end
    if nil ~= FurC.RecipeSources[recipeKey] then return FurC.RecipeSources[recipeKey] end

    recipeArray = recipeArray or FurC.Find(recipeKey)

  recipeKey = recipeArray.blueprint or recipeKey

    -- d(recipeKey)
  return (recipeArray.origin == FURC_RUMOUR and FurC.getRumourSource(recipeKey, recipeArray))
        or FurC.RecipeSources[recipeKey]
end
FurC.getRecipeSource = getRecipeSource

function FurC.getRumourSource(recipeKey, recipeArray)
  return (recipeArray.blueprint and GetString(SI_FURC_RUMOUR_SOURCE_RECIPE)) or GetString(SI_FURC_RUMOUR_SOURCE_ITEM)
end

function FurC.GetCrafterList(itemLink, recipeArray)
  if nil == recipeArray and nil == itemLink then return end
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

