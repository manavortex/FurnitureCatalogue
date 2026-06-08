local searchString = ""
local dropdownChoiceVersion = 1
local dropdownTextVersion = "All"
local ddSource = 1
local dropdownTextSource = "All"
local dropdownChoiceCharacter = 1
local ddTextCharacter = "Accountwide"
local qualityFilter = {}
local craftingTypeFilter = {}

local hideBooks = false
local hideRumours = false
local hideCrownStore = false
local mergeLuxuryAndSales = false
local showAllOnTextSearch = false
local showAllCrownOnTextSearch = false
local showAllRumourOnTextSearch = false

local recipeArray, itemId, itemLink, itemType, sItemType, recipeIndex, recipeListIndex

local src = FurC.Constants.ItemSources
local ver = FurC.Constants.Versioning

-- Local imports for performance
local GetItemLinkName = GetItemLinkName
local LocaleAwareToLower = LocaleAwareToLower
local gsub = string.gsub
local match = string.match
local getItemLink = FurC.Utils.GetItemLink

function FurC.SetFilter(useDefaults, skipRefresh)
  ClearTooltip(InformationTooltip)
  searchString = FurC.GetSearchFilter()

  if useDefaults then
    dropdownChoiceVersion = FurC.GetDefaultDropdownChoice("Version")
    ddSource = FurC.GetDefaultDropdownChoice("Source")
    dropdownChoiceCharacter = FurC.GetDefaultDropdownChoice("Character")
  else
    dropdownChoiceVersion = FurC.GetDropdownChoice("Version")
    ddSource = FurC.GetDropdownChoice("Source")
    dropdownChoiceCharacter = FurC.GetDropdownChoice("Character")
  end

  -- we need to hold the text here, in case it's not "All"
  ddTextCharacter = FurC.GetDropdownChoiceTextual("Character")

  qualityFilter = FurC.GetFilterQuality()
  craftingTypeFilter = FurC.GetFilterCraftingType()
  hideBooks = FurC.GetHideBooks()
  hideRumours = not FurC.GetShowRumours() and ddSource ~= src.RUMOUR and (FurC.GetHideRumourRecipes())
  hideCrownStore = not FurC.GetShowCrownstore() and ddSource ~= src.CROWN and (FurC.GetHideCrownStoreItems())
  mergeLuxuryAndSales = FurC.GetMergeLuxuryAndSales()

  -- ignore filtered items when no dropdown filter is set and there's a text search?
  showAllOnTextSearch = FurC.GetFilterAllOnText()
    and #searchString > 0
    and src.NONE == ddSource
    and ver.NONE == dropdownChoiceVersion
    and 1 == dropdownChoiceCharacter

  showAllRumourOnTextSearch = showAllOnTextSearch and not FurC.GetFilterAllOnTextNoCrown()
  showAllCrownOnTextSearch = showAllOnTextSearch and not FurC.GetFilterAllOnTextNoCrown()

  if skipRefresh then
    return
  end

  zo_callLater(FurC.UpdateLineVisibility, 200)
end

function FurC.InitFilters()
  FurC.Logger:Debug("Init Filters")
  FurC.SetFilterCraftingType(0)
  FurC.SetFilterQuality(0)
  FurC.SetDropdownChoice("Source", FurC.GetDefaultDropdownChoiceText("Source"), FurC.GetDefaultDropdownChoice("Source"))
  FurC.SetDropdownChoice(
    "Character",
    FurC.GetDefaultDropdownChoiceText("Character"),
    FurC.GetDefaultDropdownChoice("Character")
  )
  FurC.SetDropdownChoice(
    "Version",
    FurC.GetDefaultDropdownChoiceText("Version"),
    FurC.GetDefaultDropdownChoice("Version")
  )
end

local function isRecipeArrayKnown()
  if nil == recipeArray or nil == recipeArray.characters then
    return
  end
  if dropdownChoiceCharacter == 1 then
    for name, value in pairs(recipeArray.characters) do
      if value then
        return true
      end
    end
  else
    return recipeArray.characters[ddTextCharacter]
  end
end

-- Version: All, Homestead, Morrowind
local function matchVersionDropdown()
  return dropdownChoiceVersion == 1 or recipeArray.version == dropdownChoiceVersion
end

local validSourcesForOther = {
  [src.FESTIVAL_DROP] = true,
  [src.DROP] = true,
  [src.FISHING] = true,
  [src.JUSTICE] = true,
  [src.GUILDSTORE] = true,
  [src.TOMES] = true,
  [src.BAZAAR] = true,
}

-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
local function matchSourceDropdown()
  -- "All", don't care
  if src.NONE == ddSource then
    return true
  end
  if src.FAVE == ddSource then
    -- ToDo: store in favourites table for SV, not in database
    return recipeArray.favorite
  end
  if recipeArray.origin == src.CRAFTING then
    if ddSource == src.CRAFTING then
      return true
    end
    local matchingDropdownSource = (isRecipeArrayKnown() and src.CRAFTING_KNOWN) or src.CRAFTING_UNKNOWN
    return matchingDropdownSource == ddSource
  end
  if src.VENDOR == ddSource then
    return recipeArray.origin == src.VENDOR or (mergeLuxuryAndSales and recipeArray.origin == src.LUXURY)
  end
  if src.WRIT_VENDOR == ddSource then
    return recipeArray.origin == src.ROLIS
  end
  if src.TELVAR == ddSource then
    if recipeArray.origin ~= src.PVP then
      return false
    end
    -- look up the item in PVP data to check its currency
    local versionData = FurC.PVP[recipeArray.version]
    if not versionData then
      return false
    end
    for vendorName, vendorData in pairs(versionData) do
      for locationName, locationData in pairs(vendorData) do
        local item = locationData[itemId]
        if item then
          return item.currency == CURT_TELVAR_STONES
        end
      end
    end
    return false
  end
  if src.PVP == ddSource then
    if recipeArray.origin ~= src.PVP then
      return false
    end
    -- exclude TelVar items from the AP filter
    local versionData = FurC.PVP[recipeArray.version]
    if not versionData then
      return true
    end
    for vendorName, vendorData in pairs(versionData) do
      for locationName, locationData in pairs(vendorData) do
        local item = locationData[itemId]
        if item and item.currency == CURT_TELVAR_STONES then
          return false
        end
      end
    end
    return true
  end
  if src.OTHER == ddSource then
    return validSourcesForOther[recipeArray.origin]
  end
  -- we're checking character knowledge
  return recipeArray.origin == ddSource
end

local function matchDropdownFilter()
  return matchVersionDropdown() and matchSourceDropdown()
end

local function matchSearchString()
  if #searchString == 0 then
    return true
  end
  local itemName = LocaleAwareToLower(GetItemLinkName(itemLink))
  local escapedStr = LocaleAwareToLower(searchString)
  escapedStr = gsub(escapedStr, "-", "%%-")
  if match(itemName, escapedStr) then
    return true
  end

  -- Also match if the item belongs to a folio whose name matches
  if FurC.FurnishingFolios then
    for folioId, folioData in pairs(FurC.FurnishingFolios) do
      if folioData.contents then
        for _, contentId in ipairs(folioData.contents) do
          if contentId == itemId then
            local folioLink = FurC.Utils.GetItemLink(folioId)
            local folioName = LocaleAwareToLower(GetItemLinkName(folioLink))
            if match(folioName, escapedStr) then
              return true
            end
          end
        end
      end
    end
  end

  return false
end

local function matchCraftingTypeFilter()
  if not recipeArray.origin == src.CRAFTING then
    return false
  end
  local filterType = FurC.GetCraftingSkillType(itemId, recipeArray)
  return filterType and filterType > 0 and craftingTypeFilter[filterType]
end
local function matchQualityFilter()
  return qualityFilter[GetItemLinkQuality(itemLink)]
end

local function filterBooks(itemId, recipeArray)
  if not (hideBooks or showAllOnTextSearch and FurC.GetFilterAllOnTextNoBooks()) then
    return false
  end
  local versionData = FurC.Books[recipeArray.version]
  if nil == versionData then
    return
  end
  return nil ~= versionData[itemId]
end

function FurC.MatchFilter(currentItemId, currentRecipeArray)
  itemId = currentItemId
  itemLink = getItemLink(currentItemId)
  recipeArray = currentRecipeArray or FurC.Find(itemLink)
  itemType, sItemType = GetItemLinkItemType(itemLink)
  if 0 == itemType and 0 == sItemType then
    if currentRecipeArray.recipeId then
      FurC.Logger:Debug("invalid item type for %s (recipe ID %s)", currentItemId, currentRecipeArray.recipeId)
    else
      FurC.Logger:Debug("invalid item type for %s", currentItemId)
    end
    return false
  end

  if filterBooks(currentItemId, recipeArray) then
    return false
  end

  if not matchSearchString() then
    return false
  end

  if recipeArray.origin == src.RUMOUR and hideRumours then
    if not showAllRumourOnTextSearch and matchSearchString() then
      return false
    end
    return true
  end

  if recipeArray.origin == src.CROWN and hideCrownStore then
    if not showAllCrownOnTextSearch then
      return false
    end
    return true
  end

  if not (matchVersionDropdown() and matchSourceDropdown()) then
    return false
  end

  if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter()) then
    return false
  end
  if not (FurC.settings.filterQualityAll or matchQualityFilter()) then
    return false
  end

  return true
end
