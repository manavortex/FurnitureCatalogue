local searchString = ""
local searchPattern = ""
local dropdownChoiceVersion = 1
local dropdownTextVersion = "All"
local ddSource = 1
local dropdownTextSource = "All"
local dropdownChoiceCharacter = 1
local ddTextCharacter = "Accountwide"
local qualityFilter = {}
local craftingTypeFilter = {}
local furnCategoryFilter = {}
local furnSubcategoryFilter = {}

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

-- Build item link lazily (only if required and not already cached)
local function ensureItemLink()
  if nil == itemLink then
    itemLink = getItemLink(itemId)
  end
  return itemLink
end

-- itemType for id doesn't change, so we can cache it
local validTypeCache = {}
local function isValidItemType()
  local valid = validTypeCache[itemId]
  if nil == valid then
    local itemType, sItemType = GetItemLinkItemType(ensureItemLink())
    valid = not (0 == itemType and 0 == sItemType)
    validTypeCache[itemId] = valid
    if not valid then
      FurC.Logger:Debug("invalid itemtype for %s", itemId)
    end
  end
  return valid
end

-- cached lowercased item name
local searchNameCache = {}
local function getSearchName()
  local n = searchNameCache[itemId]
  if nil == n then
    n = LocaleAwareToLower(GetItemLinkName(ensureItemLink()))
    searchNameCache[itemId] = n
  end
  return n
end

function FurC.SetFilter(useDefaults, skipRefresh)
  ClearTooltip(InformationTooltip)
  searchString = FurC.GetSearchFilter()
  searchPattern = gsub(LocaleAwareToLower(searchString), "-", "%%-")

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
  furnCategoryFilter = FurC.GetFilterFurnCategory()
  furnSubcategoryFilter = FurC.GetFilterFurnSubcategory()
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
  FurC.SetFilterFurnCategory(0)
  FurC.SetFilterFurnSubcategory(0)
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
  if FurC.Lib.LCKAvailable() then
    -- LCK tracks recipe, not furnishing result
    local recipeItem = recipeArray and recipeArray.blueprint and getItemLink(recipeArray.blueprint)
    if not recipeItem then
      return
    end
    local name = (dropdownChoiceCharacter ~= 1) and ddTextCharacter or nil
    return FurC.Lib.IsKnownByName(recipeItem, name)
  end
  if nil == recipeArray or nil == recipeArray.characters then
    return
  end
  if dropdownChoiceCharacter == 1 then
    for _, value in pairs(recipeArray.characters) do
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
    return FurC.IsFavoriteById(itemId)
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

-- build folio stuff lazily for better search performance
local folioNamesByContent
local function getFolioNames(contentId)
  if nil == folioNamesByContent then
    folioNamesByContent = {}
    if FurC.FurnishingFolios then
      for folioId, folioData in pairs(FurC.FurnishingFolios) do
        if folioData.contents then
          local folioName = LocaleAwareToLower(GetItemLinkName(getItemLink(folioId)))
          for _, cId in ipairs(folioData.contents) do
            local names = folioNamesByContent[cId]
            if names then
              names[#names + 1] = folioName
            else
              folioNamesByContent[cId] = { folioName }
            end
          end
        end
      end
    end
  end
  return folioNamesByContent[contentId]
end

local function matchSearchString()
  if #searchString == 0 then
    return true
  end
  if match(getSearchName(), searchPattern) then
    return true
  end

  -- Also match if the item belongs to a folio whose name matches
  local folioNames = getFolioNames(itemId)
  if folioNames then
    for i = 1, #folioNames do
      if match(folioNames[i], searchPattern) then
        return true
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
  return qualityFilter[GetItemLinkQuality(ensureItemLink())]
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

local function matchFurnCategoryFilter()
  -- If all-off (no category selected), pass everything through
  if FurC.settings.filterFurnCategoryAll then
    return true
  end

  local itemCat = recipeArray.furnCategory or 0
  local itemSubcat = recipeArray.furnSubcategory or 0

  -- Check if the item's top-level category is selected
  if furnCategoryFilter[itemCat] then
    -- If a subcategory filter is also active, require subcategory match too
    if not FurC.settings.filterFurnSubcategoryAll then
      return furnSubcategoryFilter[itemSubcat] == true
    end
    return true
  end

  -- Even if the top-level category isn't selected, check subcategory directly
  -- (allows "show all Lighting regardless of source" use case)
  if not FurC.settings.filterFurnSubcategoryAll then
    return furnSubcategoryFilter[itemSubcat] == true
  end

  return false
end

function FurC.MatchFilter(currentItemId, currentRecipeArray)
  itemId = currentItemId
  itemLink = nil -- built on demand
  recipeArray = currentRecipeArray or FurC.Find(ensureItemLink())
  if nil == recipeArray then
    return false
  end

  local origin = recipeArray.origin

  -- Hidden rumours / crown-store bypass filter and only show up through text search override
  if origin == src.RUMOUR and hideRumours then
    if filterBooks(itemId, recipeArray) then
      return false
    end
    return showAllRumourOnTextSearch and matchSearchString() and isValidItemType()
  end
  if origin == src.CROWN and hideCrownStore then
    if filterBooks(itemId, recipeArray) then
      return false
    end
    return showAllCrownOnTextSearch and matchSearchString() and isValidItemType()
  end

  -- Filter stuff out first before expensive operations
  if filterBooks(itemId, recipeArray) then
    return false
  end
  if not (matchVersionDropdown() and matchSourceDropdown()) then
    return false
  end
  if not (FurC.settings.filterFurnCategoryAll and FurC.settings.filterFurnSubcategoryAll) then
    if not matchFurnCategoryFilter() then
      return false
    end
  end
  if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter()) then
    return false
  end
  if not (FurC.settings.filterQualityAll or matchQualityFilter()) then
    return false
  end
  if not matchSearchString() then
    return false
  end
  if not isValidItemType() then
    return false
  end

  return true
end
