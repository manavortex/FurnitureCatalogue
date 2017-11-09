local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end

local searchString 				= ""
local dropdownChoiceVersion		= 1
local dropdownTextVersion		= "All"
local dropdownChoiceSource		= 1
local dropdownTextSource		= "All"
local dropdownChoiceCharacter	= 1
local dropdownTextCharacter		= "Accountwide"
local qualityFilter 			= {}
local craftingTypeFilter 		= {}

local hideBooks 				= false
local mergeLuxuryAndSales		= false

local sourceIndices 

function FurC.SetFilter(useDefaults)
	sourceIndices 					= FurC.SourceIndices
	searchString 					= FurC.GetSearchFilter()	
	
	if useDefaults then		
		dropdownChoiceVersion		= tonumber(FurC.GetDefaultDropdownChoice("Version"))
		dropdownChoiceSource		= FurC.GetDefaultDropdownChoice("Source")
		dropdownChoiceCharacter 	= FurC.GetDefaultDropdownChoice("Character")
	else
		dropdownChoiceVersion		= tonumber(FurC.GetDropdownChoice("Version"))
		dropdownChoiceSource		= FurC.GetDropdownChoice("Source")
		dropdownChoiceCharacter 	= FurC.GetDropdownChoice("Character")
	end
	
	-- we need to hold the text here, in case it's not "All"
	dropdownTextCharacter		= FurC.GetDropdownChoiceTextual("Character")

	qualityFilter 				= FurC.GetFilterQuality()
	craftingTypeFilter			= FurC.GetFilterCraftingType()

	hideBooks					= FurC.GetHideBooks()
	mergeLuxuryAndSales 		= FurC.GetMergeLuxuryAndSales()
	FurC.GuiOnScroll(nil, 0)
end

function FurC.InitFilters()
	FurC.SetFilterCraftingType(0)
	FurC.SetFilterQuality(0)
	FurC.SetDropdownChoice("Source", FurC.GetDefaultDropdownChoiceText("Source"), FurC.GetDefaultDropdownChoice("Source"))
	FurC.SetDropdownChoice("Character", FurC.GetDefaultDropdownChoiceText("Character"), FurC.GetDefaultDropdownChoice("Character"))
	FurC.SetDropdownChoice("Version", FurC.GetDefaultDropdownChoiceText("Version"), FurC.GetDefaultDropdownChoice("Version"))
end


local function isRecipeArrayKnown(recipeArray)
	 if dropdownChoiceCharacter == 1 then 
		 for name, value in pairs(recipeArray.characters) do
			if (value) then return true end
		 end
	 else
		return recipeArray.characters[dropdownTextCharacter]
	end
end

-- Version: All, Homestead, Morrowind
local function matchVersionDropdown(recipeArray)
	if dropdownChoiceVersion == 1 then return true end
	if not recipeArray.version then recipeArray.version = 2 end
	return (recipeArray.version >= dropdownChoiceVersion and recipeArray.version < dropdownChoiceVersion +1 )	
end

--[[
_G["FURC_CRAFTING"] = 1
_G["FURC_VENDOR"] 	= 2
_G["FURC_ROLLIS"] 	= 3
_G["FURC_DROP"] 	= 4
_G["FURC_JUSTICE"] 	= 5
_G["FURC_FISHING"] 	= 6
_G["FURC_STORE"] 	= 7
_G["FURC_CROWN"] 	= 8
_G["FURC_RUMOUR"] 	= 9
_G["FURC_PVP"] 		= 10
_G["FURC_LUXURY"] 	= 11

-- versioning
_G["FURC_HOMESTEAD"]	= 2
_G["FURC_MORROWIND"]	= 3
_G["FURC_REACH"]		= 4

local sourceIndices = {
	off 			= 1,
	favorites		= 2
	craft_all 		= 3,
	craft_known 	= 4,
	craft_unknown 	= 5,
	purch_gold		= 6,
	purch_ap		= 7,
	crownstore		= 8,
	rumour			= 9,
	luxury			= 10,
	other			= 11,	
}
]]
	
local function shouldBeHidden(origin)
	if origin == FURC_RUMOUR then 
		return FurC.GetHideRumourRecipes() and 8 ~= dropdownChoiceSource 
	elseif origin == FURC_CROWN then 
		return FurC.GetHideCrownStoreItems() and 7 ~= dropdownChoiceSource
	end
end


-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
local function matchSourceDropdown(recipeArray)
	
	if shouldBeHidden(recipeArray.origin) then return false end
	
	-- "All", don't care	
	if sourceIndices.off				 == dropdownChoiceSource then  -- All
		return true 
		
	elseif sourceIndices.favorites 		== dropdownChoiceSource then
		return recipeArray.favorite
	elseif sourceIndices.craft_all 		== dropdownChoiceSource then -- craftable: All
		return recipeArray.origin 		== FURC_CRAFTING
	elseif sourceIndices.craft_known 	== dropdownChoiceSource then 
		return recipeArray.origin 		== FURC_CRAFTING and isRecipeArrayKnown(recipeArray)
	elseif sourceIndices.craft_unknown 	== dropdownChoiceSource then 
		return recipeArray.origin 		== FURC_CRAFTING and not isRecipeArrayKnown(recipeArray)
	
	elseif sourceIndices.purch_gold 	== dropdownChoiceSource then 
		return (recipeArray.origin 		== FURC_VENDOR or (mergeLuxuryAndSales and recipeArray.origin == FURC_LUXURY))
	elseif sourceIndices.purch_ap 		== dropdownChoiceSource then 
		return recipeArray.origin 		== FURC_PVP	
	
	elseif sourceIndices.crownstore 	== dropdownChoiceSource then return recipeArray.origin == FURC_CROWN
	elseif sourceIndices.rumour 		== dropdownChoiceSource then return (recipeArray.origin == FURC_RUMOUR)
	elseif sourceIndices.luxury 		== dropdownChoiceSource then return (recipeArray.origin == FURC_LUXURY)
	elseif sourceIndices.other			== dropdownChoiceSource then 
		return (
			recipeArray.origin == FURC_DROP 	or 
			recipeArray.origin == FURC_FISHING 	or 
			recipeArray.origin == FURC_JUSTICE 	or 
			recipeArray.origin == FURC_STORE
		)
	end
	
	-- we're checking character knowledge
	return 1 == dropdownChoiceCharacter or recipeArray.origin == FURC_CRAFTING	
	
end
-- Character: Accountwide, crafter1, crafter2...
local function matchCharacterDropdown(recipeArray)
	if dropdownChoiceCharacter == 1 then return true end
	
	return nil ~= recipeArray.characters and recipeArray.characters[dropdownTextCharacter]	
end

local function matchDropdownFilter(recipeArray)	
	return matchVersionDropdown(recipeArray) and matchSourceDropdown(recipeArray) -- and matchCharacterDropdown(recipeArray))	
end

local function stringMatch(s1, s2) 
	return nil ~= string.match(string.lower(s1), string.lower(s2))
end

local function matchSearchString(recipeArray)
	if searchString == "" then return true end
	local search = string.lower(searchString)
	return stringMatch(recipeArray.itemName, searchString) or 
	(recipeArray.origin == FURC_VENDOR and stringMatch(recipeArray.source, searchString))
end

local function matchCraftingTypeFilter(recipeArray)	
	return craftingTypeFilter[recipeArray.tradeskillType]
end
local function matchQualityFilter(recipeArray)
	return qualityFilter[recipeArray.itemQuality]
end

local function filterBooks(recipeArray)
	if not hideBooks then return false end
	for versionNo, versionData in pairs(FurC.Books) do
		if nil ~= versionData[recipeArray.itemLink] then return true end
	end	
end

function FurC.MatchFilter(recipeArray)
		
	if nil == recipeArray or nil == recipeArray.itemLink then return false end
	
	if not matchSearchString(recipeArray) 		then return false end	
	if not matchDropdownFilter(recipeArray)		then return false end
	if not (FurC.settings.filterCraftingTypeAll or matchCraftingTypeFilter(recipeArray))	then return false end
	if not (FurC.settings.filterQualityAll 		or matchQualityFilter(recipeArray))		then return false end
	if filterBooks(recipeArray)					then return false end
	
	return true
	
end