local searchString                = ""
local dropdownChoiceVersion       = 1
local dropdownTextVersion         = "All"
local ddSource                    = 1
local dropdownTextSource          = "All"
local dropdownChoiceCharacter     = 1
local ddTextCharacter             = "Accountwide"
local qualityFilter               = {}
local craftingTypeFilter          = {}

local hideBooks                   = false
local hideRumours                 = false
local hideCrownStore              = false
local mergeLuxuryAndSales         = false
local showAllOnTextSearch         = false
local showAllCrownOnTextSearch    = false
local showAllRumourOnTextSearch   = false

local sourceIndices

local recipeArray, itemId, itemLink, itemType, sItemType, itemName, recipeIndex, recipeListIndex

function FurC.SetFilter(useDefaults, skipRefresh)
  
  ClearTooltip(InformationTooltip)
  sourceIndices           = FurC.SourceIndices
  searchString            = FurC.GetSearchFilter()
  
  if useDefaults then
      dropdownChoiceVersion     = tonumber(FurC.GetDefaultDropdownChoice("Version"))
      ddSource                  = FurC.GetDefaultDropdownChoice("Source")
      dropdownChoiceCharacter   = FurC.GetDefaultDropdownChoice("Character")
    else
      dropdownChoiceVersion     = tonumber(FurC.GetDropdownChoice("Version"))
      ddSource                  = FurC.GetDropdownChoice("Source")
      dropdownChoiceCharacter   = FurC.GetDropdownChoice("Character")
  end
  
  -- we need to hold the text here, in case it's not "All"
  ddTextCharacter        = FurC.GetDropdownChoiceTextual("Character")
  
  qualityFilter           = FurC.GetFilterQuality()
  craftingTypeFilter      = FurC.GetFilterCraftingType()
  hideBooks               = FurC.GetHideBooks()
  hideRumours             = not FurC.GetShowRumours() and ddSource ~= FURC_RUMOUR and (FurC.GetHideRumourRecipes())
  hideCrownStore          = not FurC.GetShowCrownstore() and ddSource ~= FURC_CROWN  and (FurC.GetHideCrownStoreItems())
  mergeLuxuryAndSales     = FurC.GetMergeLuxuryAndSales()
  
  -- ignore filtered items when no dropdown filter is set and there's a text search?
  showAllOnTextSearch   = FurC.GetFilterAllOnText() and #searchString > 0 and
                           FURC_NONE == ddSource and
                           FURC_NONE == dropdownChoiceVersion and
                           FURC_NONE == dropdownChoiceCharacter
                           
  showAllRumourOnTextSearch = showAllOnTextSearch and not FurC.GetFilterAllOnTextNoCrown()
  showAllCrownOnTextSearch  = showAllOnTextSearch and not FurC.GetFilterAllOnTextNoCrown()
  
  if skipRefresh then return end
  
  zo_callLater(FurC.UpdateLineVisibility, 200)
  
end

function FurC.InitFilters()
  FurC.Logger:Debug("Init Filters")
  FurC.SetFilterCraftingType(0)
  FurC.SetFilterQuality(0)
  FurC.SetDropdownChoice("Source", FurC.GetDefaultDropdownChoiceText("Source"), FurC.GetDefaultDropdownChoice("Source"))
  FurC.SetDropdownChoice("Character", FurC.GetDefaultDropdownChoiceText("Character"), FurC.GetDefaultDropdownChoice("Character"))
  FurC.SetDropdownChoice("Version", FurC.GetDefaultDropdownChoiceText("Version"), FurC.GetDefaultDropdownChoice("Version"))
end

local function isRecipeArrayKnown()
  
  if nil == recipeArray or nil == recipeArray.characters then return end
  if dropdownChoiceCharacter == 1 then
    for name, value in pairs(recipeArray.characters) do
      if (value) then return true end
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
  [FURC_FESTIVAL_DROP]    = true, 
  [FURC_DROP]             = true, 
  [FURC_FISHING]          = true, 
  [FURC_JUSTICE]          = true, 
  [FURC_GUILDSTORE]       = true, 
}

-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
local function matchSourceDropdown()
  
  -- "All", don't care
  if FURC_NONE              == ddSource then
    return true
  end
  if FURC_FAVE               == ddSource then
    return recipeArray.favorite
  end
  if recipeArray.origin == FURC_CRAFTING then 
    if ddSource == FURC_CRAFTING then return true end
    local matchingDropdownSource = (isRecipeArrayKnown(recipeArray) and FURC_CRAFTING_KNOWN) or FURC_CRAFTING_UNKNOWN
    return matchingDropdownSource == ddSource
  end
  if FURC_VENDOR               == ddSource then
    return recipeArray.origin     == FURC_VENDOR or (mergeLuxuryAndSales and recipeArray.origin == FURC_LUXURY)
  end
  if FURC_WRIT_VENDOR           == ddSource then
    return recipeArray.origin     == FURC_ROLIS
  end
  if FURC_OTHER              == ddSource then
    return validSourcesForOther[recipeArray.origin]
  end
  -- we're checking character knowledge
  return recipeArray.origin  == ddSource   
  
end

local function matchDropdownFilter()
  return matchVersionDropdown() and matchSourceDropdown()
end

local function matchSearchString()
  if #searchString == 0 then return true end
  local caseSensitive = nil ~= string.match(searchString, "%u")
  local itemName = GetItemLinkName(itemLink)
  local matchme = (caseSensitive and itemName) or string.lower(itemName)
  return string.match(matchme, searchString)
end

local function matchCraftingTypeFilter()
  if not recipeArray.origin == FURC_CRAFTING then return false end
  local filterType = FurC.GetCraftingSkillType(itemId, recipeArray)
  return filterType and filterType > 0 and craftingTypeFilter[filterType]
end
local function matchQualityFilter()
  return qualityFilter[GetItemLinkQuality(itemLink)]
end

local function filterBooks(itemId, recipeArray)
  if not (hideBooks or showAllOnTextSearch and FurC.GetFilterAllOnTextNoBooks()) then return false end
  local versionData = FurC.Books[recipeArray.version]
  if nil == versionData then return end
  return nil ~= versionData[itemId]
end

function FurC.MatchFilter(currentItemId, currentRecipeArray)
  
  itemLink = FurC.GetItemLink(currentItemId)
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
  
  if  filterBooks(currentItemId, recipeArray)                        then return false end  
  
  if not matchSearchString()                                  then return false end
  
  if recipeArray.origin == FURC_RUMOUR and hideRumours then
    if not showAllRumourOnTextSearch and matchSearchString()  then return false end
    return true
  end
  
  if recipeArray.origin == FURC_CROWN and hideCrownStore then
    if not showAllCrownOnTextSearch then return false end
    return true
  end
  
  if not (matchVersionDropdown() and matchSourceDropdown()) then return false end
  
  
  if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter())  then return false end
  if not (FurC.settings.filterQualityAll     or matchQualityFilter())    then return false end
  
  return true
end
