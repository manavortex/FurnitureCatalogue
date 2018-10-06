local p 						= FurC.DebugOut -- debug function calling zo_strformat with up to 10 args

local searchString 				= ""
local dropdownChoiceVersion		= 1
local dropdownTextVersion		= "All"
local ddSource		= 1
local dropdownTextSource		= "All"
local dropdownChoiceCharacter	= 1
local ddTextCharacter			= "Accountwide"
local qualityFilter 			= {}
local craftingTypeFilter 		= {}

local hideBooks 				= false
local hideRumours				= false
local hideCrownStore			= false
local mergeLuxuryAndSales		= false
local filterAllOnTextSearch		= false

local sourceIndices

local recipeArray, itemId, itemLink, itemType, sItemType, itemName, recipeIndex, recipeListIndex

function FurC.SetFilter(useDefaults, skipRefresh)
	
    ClearTooltip(InformationTooltip)
	sourceIndices 					= FurC.SourceIndices
	searchString 					= FurC.GetSearchFilter()

	if useDefaults then
		dropdownChoiceVersion		= tonumber(FurC.GetDefaultDropdownChoice("Version"))
		ddSource					= FurC.GetDefaultDropdownChoice("Source")
		dropdownChoiceCharacter 	= FurC.GetDefaultDropdownChoice("Character")
	else
		dropdownChoiceVersion		= tonumber(FurC.GetDropdownChoice("Version"))
		ddSource					= FurC.GetDropdownChoice("Source")
		dropdownChoiceCharacter 	= FurC.GetDropdownChoice("Character")
	end

	-- we need to hold the text here, in case it's not "All"
	ddTextCharacter				= FurC.GetDropdownChoiceTextual("Character")

	qualityFilter 				= FurC.GetFilterQuality()
	craftingTypeFilter			= FurC.GetFilterCraftingType()
	hideBooks					= FurC.GetHideBooks()
	hideRumours					= FurC.GetHideRumourRecipes()
	mergeLuxuryAndSales 		= FurC.GetMergeLuxuryAndSales()
	hideCrownStore 				= FurC.GetHideCrownStoreItems()

    -- ignore filtered items when no dropdown filter is set and there's a text search?
    filterAllOnTextSearch       = FurC.GetFilterAllOnText() and #searchString > 0 and
                                    FURC_NONE == ddSource and
                                    FURC_NONE == dropdownChoiceVersion and
                                    FURC_NONE == dropdownChoiceCharacter

	if not skipRefresh then
		zo_callLater(FurC.UpdateLineVisibility, 200)
	end
end

function FurC.InitFilters()
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

local function shouldBeHidden()
	return (ddSource ~= FURC_RUMOUR and recipeArray.origin == FURC_RUMOUR and hideRumours) or
	(ddSource ~= FURC_CROWN and recipeArray.origin == FURC_CROWN and hideCrownStore)
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
	if FURC_NONE					== ddSource then
		return true
  end
	if FURC_FAVE 					    == ddSource then
		return recipeArray.favorite
  end
  if recipeArray.origin == FURC_CRAFTING then 
      if ddSource == FURC_CRAFTING then return true end
      local matchingDropdownSource = (isRecipeArrayKnown(recipeArray) and FURC_CRAFTING_KNOWN) or FURC_CRAFTING_UNKNOWN
      return matchingDropdownSource == ddSource
  end
	if FURC_VENDOR 					    == ddSource then
		return (recipeArray.origin 		== FURC_VENDOR or (mergeLuxuryAndSales and recipeArray.origin == FURC_LUXURY))
    end
	if FURC_WRIT_VENDOR 			    == ddSource then
		return recipeArray.origin 		== FURC_ROLIS
    end
	if FURC_OTHER					    == ddSource then
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
	if not (hideBooks or filterAllOnTextSearch and FurC.GetFilterAllOnTextNoBooks()) then return false end
	local versionData = FurC.Books[recipeArray.version]
	if nil == versionData then return end
	return nil ~= versionData[itemId]
end

function FurC.MatchFilter(currentItemId, currentRecipeArray)

	itemId = currentItemId
	itemLink = FurC.GetItemLink(itemId)
	recipeArray = currentRecipeArray or FurC.Find(itemLink)
	itemType, sItemType = GetItemLinkItemType(itemLink)
    if 0 == itemType and 0 == sItemType then 
        p("invalid item type for <<1>>", currentItemId)
        return false 
    end
    if  filterBooks(itemId, recipeArray)			                        then return false end


    if recipeArray.origin == FURC_RUMOUR then
        if filterAllOnTextSearch and not FurC.GetFilterAllOnTextNoRumour() then
            return false
        end
        if hideRumours and ddSource ~= FURC_RUMOUR then return false end
    end

    if recipeArray.origin == FURC_CROWN then
        if filterAllOnTextSearch and FurC.GetFilterAllOnTextNoCrown() then return false end
        if hideCrownStore and ddSource ~= FURC_CROWN then return false end
    end

    if not (filterAllOnTextSearch  or  matchDropdownFilter()) then return false end


    if not matchSearchString() 												    then return false end
	if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter())	then return false end
	if not (FurC.settings.filterQualityAll 		or matchQualityFilter())		then return false end

	return true
end
