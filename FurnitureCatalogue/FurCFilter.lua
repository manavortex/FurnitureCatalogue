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

-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
local function matchSourceDropdown()	
	 
	-- "All", don't care	
	if FURC_NONE						== ddSource then  -- All
		return true
	elseif FURC_CRAFTING_KNOWN 			== ddSource then 
		return recipeArray.origin 		== FURC_CRAFTING and isRecipeArrayKnown(recipeArray)
	elseif FURC_CRAFTING_UNKNOWN 		== ddSource then 
		return recipeArray.origin 		== FURC_CRAFTING and not isRecipeArrayKnown(recipeArray) 
	elseif FURC_FAVE 					== ddSource then
		return recipeArray.favorite
	elseif FURC_VENDOR 					== ddSource then 
		return (recipeArray.origin 		== FURC_VENDOR or (mergeLuxuryAndSales and recipeArray.origin == FURC_LUXURY))
	elseif FURC_RUMOUR 					== ddSource then
		return recipeArray.origin 		== FURC_RUMOUR
	elseif FURC_WRIT_VENDOR 			== ddSource then
		return recipeArray.origin 		== FURC_ROLLIS 
	elseif FURC_OTHER					== ddSource then 
		return (
			recipeArray.origin == FURC_FESTIVAL_DROP or
			recipeArray.origin == FURC_DROP 	or 
			recipeArray.origin == FURC_FISHING 	or 
			recipeArray.origin == FURC_JUSTICE 	or 
			recipeArray.origin == FURC_GUILDSTORE
		)
	else return recipeArray.origin  == ddSource end
	
	
	-- we're checking character knowledge
	return 1 == dropdownChoiceCharacter or recipeArray.origin == FURC_CRAFTING	
	
end

local function matchDropdownFilter()	
	return matchVersionDropdown() and matchSourceDropdown()
end

local function stringMatch(s1, s2) 
	return nil ~= string.match(string.lower(s1), string.lower(s2))
end

local function matchSearchString()
	if searchString == "" then return true end
	return stringMatch(GetItemLinkName(itemLink), searchString)
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
	if not hideBooks then return false end
	local versionData = FurC.Books[recipeArray.version]
	if nil == versionData then return end 
	return nil ~= versionData[itemId]	
end

function FurC.MatchFilter(currentItemId, currentRecipeArray)

	itemId = currentItemId
	itemLink = FurC.GetItemLink(itemId) 
	recipeArray = currentRecipeArray or FurC.Find(itemLink)
	itemType, sItemType = GetItemLinkItemType(itemLink)
	
	
	if shouldBeHidden()															then return false end	
	if not matchSearchString() 													then return false end	
	if not matchDropdownFilter()												then return false end
	if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter())	then return false end
	if not (FurC.settings.filterQualityAll 		or matchQualityFilter())		then return false end
	
	if filterBooks(itemId, recipeArray)			then return false end
	
	return true
	
end