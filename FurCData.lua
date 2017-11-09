local currentChar	= nil
local apiVersion 	= 10020
local task = LibStub("LibAsync"):Create("FurnitureCatalogue_ScanDataFiles")
local task2 = LibStub("LibAsync"):Create("FurnitureCatalogue_ScanCharacterKnowledge")

local function getCurrentChar()
	if nil == currentChar then currentChar = zo_strformat(GetUnitName("player")) end
	return currentChar
end
local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end

local function startupMessage(text)
	if FurC.GetStartupSilently() then return end
	d(text)
end

local function tableLength(ary)
	if nil == ary then return -1 end
	local counter = 0
	for k, v in pairs(ary) do
		counter = counter + 1
	end
	return counter
end
local function isEmpty(ary)
	return (tableLength(ary) <= 0)
end
function FurC.IsEmpty(ary)
	return isEmpty(ary) 
end

local function getItemId(itemLink, recipeArray)

	if ((nil == itemLink) and (nil ~= recipeArray)) then 
		itemLink = recipeArray.itemLink 
	end
	if nil == recipeArray and (itemLink == "" or nil == itemLink) then return -1 end
	
	local itemId = itemLink:match("|H.-:item:(.-):.-|h.-|h")
	if itemId == "h" then return -1 end
	return tonumber(itemId)   
end
function FurC.GetItemId(itemLink, recipeArray)
	return getItemId(itemLink)
end

local function getVersionNumber(recipeArray)
	if nil == recipeArray then return end
	local recipeLink = recipeArray.recipeLink
	if nil ~= recipeArray.recipeLink then 
		if nil ~= FurC.Recipes[FURC_HOMESTEAD][recipeLink] then return FURC_HOMESTEAD end
		if nil ~= FurC.Recipes[FURC_MORROWIND][recipeLink] then return FURC_MORROWIND end
		if nil ~= FurC.Recipes[FURC_REACH][recipeLink] then return FURC_REACH end
	end
	return recipeArray.version or FurC.gameVersion
end


local function trySaveDevDebug(recipeArray)
	if not (FurC.AccountName == "@manavortex" or FurC.AccountName == "@Manorin") then return end
	if recipeArray.origin ~= FURC_DROP then return end
	itemLink = (nil ~= recipeArray.blueprintLink and recipeArray.blueprintLink) or recipeArray.itemLink
	FurnitureCatalogue.devSettings[itemLink] = "true, -- " .. GetItemLinkName(itemLink)
end

local function addDatabaseEntry(recipeKey, recipeArray)
	if nil == recipeKey and (nil == recipeArray or {} == recipeArray) then return end
	if nil == recipeArray.itemLink or "" == recipeArray.itemLink or "h" == recipeArray.itemLink then return end
	if #(tostring(recipeKey)) > 6 then recipeKey = getItemId(recipeKey) end
	if nil == recipeKey then recipeKey = getItemId(recipeArray.itemLink) end
	if nil == recipeKey then return end
	
	recipeArray.version 				= getVersionNumber(recipeArray)
	recipeArray.characters 				= recipeArray.characters or {}
	recipeArray.ingredients 			= recipeArray.ingredients or {}	
	recipeArray.itemFurnitureId			= GetItemLinkFurnitureDataId(recipeArray.itemLink)
	local catId, subCatId 				= GetFurnitureDataCategoryInfo(recipeArray.itemFurnitureId)
	recipeArray.furnitureCategoryId 	= catId
	recipeArray.furnitureSubcategoryId 	= subCatId
	
	if nil == recipeArray.source then 
		recipeArray.source =  (recipeArray.origin == FURC_STORE and "Seen in trading house") or 
		((IsItemLinkBound(recipeArray.itemLink) and "This is a crown store item") or "Unknown, possibly a drop")
	end
	if nil ~= FurC.RumourRecipes[recipeArray.itemLink] then
		recipeArray.origin = FURC_RUMOUR
		recipeArray.source = "This recipe has been datamined, but not confirmed."
	end
	
	FurC.settings.data[recipeKey] = recipeArray	
end

local function isItemCraftable(recipeArray)
	if nil == recipeArray then return false end
	local ret = ( 
		recipeArray.craftable 				or
		nil ~= recipeArray.blueprint 		or
		nil ~= recipeArray.tradeskillType 	or 
		(nil ~= recipeArray.recipeIndex and (nil ~= recipeArray.recipeListIndex))
		)
	if ret ~= recipeArray.craftable then
		local recipeKey 				= getItemId(recipeArray.itemLink)
		recipeArray.craftable 		= ret
		addDatabaseEntry(recipeKey, recipeArray)
	end
	return ret
end

-- _G["FURC_CRAFTING"] = 1
-- _G["FURC_VENDOR"] 	= 2
-- _G["FURC_ROLLIS"] 	= 3
-- _G["FURC_DROP"] 		= 4
-- _G["FURC_JUSTICE"] 	= 5
-- _G["FURC_FISHING"] 	= 6
-- _G["FURC_STORE"] 	= 7
-- _G["FURC_CROWN"] 	= 8
-- _G["FURC_RUMOUR"] 	= 9
-- _G["FURC_PVP"] 		= 10
-- _G["FURC_LUXURY"] 	= 11


local function getRollisSource(itemLink)
	for versionNumber, versionData in pairs(FurC.Rollis) do
		if nil ~= versionData[itemLink] then return versionData[itemLink] end
	end
end

local function updateItemSource(recipeArray, forceOverwrite)

	if nil == recipeArray then return {} end
	
	local itemLink, source, origin = recipeArray[itemLink], nil, nil
	
	if recipeArray.craftable then 
		source = FurC.GetRecipeHolders(itemLink, recipeArray)
		origin = FURC_CRAFTING
	elseif (SCENE_MANAGER) and (SCENE_MANAGER:GetCurrentSceneName() == "tradinghouse") then
		source = recipeArray.source or "Seen in trading house"
		origin = FURC_TRADING
	end
	source = (forceOverwrite and source) or (recipeArray.source or source)
	
	recipeArray.source = source
	recipeArray.origin = origin	
	
	return recipeArray
	
end

local function setIngredientsFromBlueprint(recipeArray, blueprint)	-- returns the altered recipeArray
	blueprint = blueprint or recipeArray.blueprint
	if nil ~= recipeArray.blueprint then return end
	if nil == blueprint then return recipeArray end
	
	-- d(zo_strformat("case 2, setting ingredients for <<1>>, number is: <<2>>", recipeArray.itemLink, numIngredients))
	if nil == recipeArray.numIngredients then 
		recipeArray.numIngredients =  GetItemLinkRecipeNumIngredients(blueprint)
	end
	local ingredients = {}
	for ingredientIndex = 1, recipeArray.numIngredients do 
		_, _, qty 		= GetItemLinkRecipeIngredientInfo(blueprint, ingredientIndex)
		ingredientLink	= GetItemLinkRecipeIngredientItemLink(blueprint, ingredientIndex)
		ingredients[ingredientLink]	= qty
	end
	recipeArray.ingredients = ingredients
	return recipeArray
end

local function setIngredientsFromIndices(recipeArray, recipeIndex, recipeListIndex)		-- returns the altered recipeArray
	if nil == recipeIndex or nil == recipeListIndex then return recipeArray end
	if nil == recipeArray then return end
	if nil == recipeArray.numIngredients then 
	_, _, recipeArray.numIngredients = GetRecipeInfo(recipeListIndex, recipeIndex)
	end
	-- d(zo_strformat("case one, setting ingredients for <<1>>, number is: <<2>>", recipeArray.itemLink, numIngredients))
	
	return recipeArray
end

local function initIngredientArray(recipeArray)						-- returns the altered recipeArray
	
	if nil == recipeArray or {} == recipeArray then return end		
	recipeArray.ingredients = recipeArray.ingredients or {}
	
	local ingredients = {}
	
	local numIngredients  = recipeArray.numIngredients or 0
	if numIngredients < 2 then numIngredients = 0 end
	if ((numIngredients > 0) and 
	(recipeArray.ingredients and recipeArray.ingredients ~= {}) and 
	( tableLength(recipeArray.ingredients) == numIngredients)) then 
		return 
	end
	recipeArray.numIngredients = numIngredients
	
	local ingredientLink, qty = nil
	local recipeIndex 		= recipeArray.recipeIndex
	local recipeListIndex  	= recipeArray.recipeListIndex 
	local blueprint 		= recipeArray.blueprint
	
	recipeArray = setIngredientsFromBlueprint(recipeArray, blueprint)
	recipeArray = setIngredientsFromIndices(recipeArray, recipeIndex, recipeListIndex)
	
	return recipeArray
end

function FurC.SetIngredients(recipeArray)--calls initIngredientArray,  returns the altered recipeArray
	return initIngredientArray(recipeArray)
end

function FurC.findVersion(recipeLink)
	for versionNumber, versionData in pairs(FurC.Recipes) do
		for dataRecipeLink, _ in pairs(versionData) do
			if recipeLink == dataRecipeLink then return versionNumber end
		end
	end
end

local function parseFurnitureItem(itemLink)					-- saves to DB, returns recipeArray
	
	local recipeKey 					= getItemId(itemLink)
	local recipeArray 					= FurC.settings.data[recipeKey]
	if nil ~= recipeArray then return recipeArray end
	
	recipeArray = {}
	local itemType, sItemType 		= GetItemLinkItemType(itemLink)
	recipeArray.itemLink 		= itemLink
	recipeArray.itemName			= GetItemLinkName(itemLink)
	
	recipeArray.filterType		= sItemType
	recipeArray.itemQuality		= GetItemLinkQuality(itemLink)
	recipeArray.iconFile			= GetItemLinkInfo(itemLink)
	
	local characters 				= {}
	characters[getCurrentChar()] 	= false
	recipeArray.characters		= characters
	
	recipeArray.tradeskillType	= GetItemLinkCraftingSkillType(itemLink)
	recipeArray.numIngredients 	= 0
	
	recipeArray 					= updateItemSource(recipeArray)
	

	addDatabaseEntry(recipeKey, recipeArray)	
	
	return recipeArray
end

local function scanBlueprint(blueprintLink, itemLink)		-- returns recipeArray, not saving to DB
	itemLink 						= itemLink or GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
	local recipeKey 				= getItemId(itemLink)
	
	if nil == itemLink or nil == recipeKey then return end
	
	-- p("|cFFFFFF>> scanning blueprint|r <<1>>", blueprintLink)
	
	local itemType, sItemType 		= GetItemLinkItemType(itemLink)
	local recipeArray 				= {}
	
	recipeArray.filterType			= sItemType
	recipeArray.itemQuality			= GetItemLinkQuality(itemLink)
	recipeArray.iconFile			= GetItemLinkInfo(itemLink)	
	
	recipeArray.itemLink			= itemLink
	recipeArray.blueprint			= blueprintLink
	
	recipeArray.itemName 			= GetItemLinkName(itemLink)
	recipeArray.numIngredients 		= GetItemLinkRecipeNumIngredients(blueprintLink)
	recipeArray.tradeskillType 		= GetItemLinkRecipeCraftingSkillType(blueprintLink)
	recipeArray.craftable 			= true
	
	-- setup character data 
	local characters 				= recipeArray.characters or {}	
	characters[getCurrentChar()] 	= IsItemLinkRecipeKnown(blueprintLink)
	recipeArray.characters 			= characters
	
	-- setup ingredients
	local ingredients, ingredientLink, qty = {}
	for ingredientIndex=1, recipeArray.numIngredients do
		_, _, qty 					= GetItemLinkRecipeIngredientInfo(blueprintLink, ingredientIndex) 
		ingredientLink 				= GetItemLinkRecipeIngredientItemLink(blueprintLink, ingredientIndex)
		ingredients[ingredientLink]	= qty		
	end
	recipeArray.ingredients 		= ingredients
	recipeArray.source = FurC.GetRecipeHolders(recipeArray.itemLink, recipeArray)
	
	-- make sure we have the correct source
	recipeArray						= updateItemSource(recipeArray, true)
	recipeArray.version 			= FurC.findVersion(recipeLink)
	recipeArray.origin 				= FURC_CRAFTING
	
	return recipeArray
end

local function parseBlueprint(blueprintLink)				-- saves to DB, returns recipeArray
	
	local itemLink 		= GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
	local recipeKey 	= getItemId(itemLink)
	if nil == itemLink or nil == recipeKey then return end	
	
	local recipeArray 	= FurC.settings["data"][recipeKey]
	
	if nil 	== recipeArray 
	or nil 	== recipeArray.blueprint 
	or 0  	== recipeArray.numIngredients
	or nil 	== recipeArray.ingredients
	or {}  	== recipeArray.ingredients	
	then
		-- p("|cFFFFFF>> creating entry for recipe|r <<1>> (<<2>>)", blueprintLink, itemLink)	
		recipeArray 	= scanBlueprint(blueprintLink, itemLink)
	end
	if nil == recipeArray or nil == recipeArray.itemLink then return end
	
	
	
	addDatabaseEntry(recipeKey, recipeArray)
	
	return recipeArray
	
end

local lastLink = nil
local recipeArray = nil 
local function scanItemLink(itemOrBlueprintLink)			-- finds or creates array for the item link, if necessary.
	-- p("scanItemLink(<<1>>)...", itemOrBlueprintLink)		-- do not return empty arrays. If this returns nil, abort!
	if nil == itemOrBlueprintLink then return end
	
	
	if itemOrBlueprintLink == lastLink and nil ~= recipeArray then 
		return recipeArray
	else	
		recipeArray = nil 
		lastLink = itemOrBlueprintLink
	end
	
	if IsItemLinkFurnitureRecipe(itemOrBlueprintLink) then 
		recipeArray = parseBlueprint(itemOrBlueprintLink)
	elseif IsItemLinkPlaceableFurniture(itemOrBlueprintLink) then 		
		recipeArray = parseFurnitureItem(itemOrBlueprintLink)
	else
		return {}
	end	

	return recipeArray or {}
end
function FurC.Find(itemOrBlueprintLink)						-- sets recipeArray, returns it - calls scanItemLink
	return scanItemLink(itemOrBlueprintLink)	
end
function FurC.Delete(itemOrBlueprintLink)						-- sets recipeArray, returns it - calls scanItemLink
	local recipeArray = scanItemLink(itemOrBlueprintLink)	
	if nil == recipeArray then return end
	local itemLink = recipeArray.itemLink
	local itemKey = getItemId(itemLink)
	FurC.settings.data[itemKey] = nil
end

function FurC.IsFavorite(itemLink, recipeArray)
	recipeArray = recipeArray or FurC.Find(itemLink)
	return recipeArray.favorite
end

function FurC.Fave(itemLink, recipeArray)
	recipeArray = recipeArray or FurC.Find(itemLink)
	recipeArray.favorite = not recipeArray.favorite
	FurC.UpdateGui()
end

function FurC.HasMats(itemLink)
	p("FurC.HasMats(<<1>>)...", itemLink)
	local recipeArray = scanItemLink(itemLink)
	return (nil ~= recipeArray and (nil ~= recipeArray.ingredients and {} ~= recipeArray.ingredients))
end

local function scanRecipeIndices(recipeListIndex, recipeIndex)		-- returns recipeArray or nil, initialises
	
	local itemLink = GetRecipeResultItemLink(recipeListIndex, recipeIndex, LINK_STYLE_BRACKETS)
	local recipeKey = getItemId(itemLink)
	if nil == recipeKey or (not IsItemLinkPlaceableFurniture(itemLink)) then return {} end	
	
	local recipeArray = FurC.settings["data"][recipeKey]
	
	local known, itemName, numIngredients, _, _, _, craftingStationType = GetRecipeInfo(recipeListIndex, recipeIndex)
	local _, icon, stack, sellPrice, quality = GetRecipeResultItemInfo(recipeListIndex, recipeIndex)
	
	if (nil == recipeArray) then 
		local itemType, sItemType 	= GetItemLinkItemType(itemLink)
		
		recipeArray 				= {}
		recipeArray.itemLink		= itemLink
		recipeArray.recipeIndex		= recipeIndex
		recipeArray.recipeListIndex	= recipeListIndex
		recipeArray.characters		= {}
		
		-- setup data 	
		recipeArray.itemName		= GetItemLinkName(itemLink)	
		recipeArray.numIngredients 	= numIngredients 		 
		recipeArray.tradeskillType	= GetRecipeTradeskillRequirement(recipeListIndex, recipeIndex)
		recipeArray.itemQuality		= quality
		recipeArray.iconFile		= icon
		recipeArray.filterType		= sItemType
		
		
		-- setup ingredients
		local ingredients = {}
		for ingredientIndex=1, recipeArray.numIngredients do
			_, _, qty 					= GetRecipeIngredientItemInfo(recipeListIndex, recipeIndex, ingredientIndex, LINK_STYLE_DEFAULT) 
			ingredientLink 				= GetRecipeIngredientItemLink(recipeListIndex, recipeIndex, ingredientIndex, LINK_STYLE_DEFAULT)
			ingredients[ingredientLink]	= qty
		end
		recipeArray.ingredients 		= ingredients		
	end
	
	recipeArray.recipeIndex				= recipeIndex
	recipeArray.recipeListIndex			= recipeListIndex
	recipeArray.characters[getCurrentChar()] = known
	

	FurC.settings.accountCharacters[getCurrentChar()] = FurC.settings.accountCharacters[getCurrentChar()] or known
	
	
	-- FurC.settings.accountCharacters[getCurrentChar()] = FurC.settings.accountCharacters[getCurrentChar()] or known
		
		-- p("scanning <<1>>, <<2>> by <<3>>", itemLink, ((known and "known") or "not known"), getCurrentChar())
	recipeArray.craftable 		= true
	recipeArray.origin 			= FURC_CRAFTING
	recipeArray.source			= FurC.GetRecipeHolders(itemLink, recipeArray)
	recipeArray.version			= recipeArray.version or 3
	
	addDatabaseEntry(recipeKey, recipeArray)
	
	return recipeArray 
	-- setup character data 
	-- recipeArray = updateItemKnowledge(recipeArray, recipeListIndex, recipeIndex)
end

function FurC.TryCreateRecipeEntry(recipeListIndex, recipeIndex)	-- returns scanRecipeIndices, called from Events.lua
	local recipeArray =  scanRecipeIndices(recipeListIndex, recipeIndex)
	if nil == recipeArray then return end
	
	recipeArray.characters = recipeArray.characters or {}
	recipeArray.source = FurC.GetRecipeHolders(itemLink, recipeArray)
	return recipeArray
end

function FurC.CanCraft(itemLink, recipeArray)
	local recipeKey = getItemId(itemLink)
	if recipeKey == nil then return false end
	recipeArray = recipeArray or FurC.settings.data[recipeKey]
	if nil == recipeArray or nil == recipeArray.characters then return false end
	return recipeArray.characters[getCurrentChar()]
end

function FurC.IsUnknown(itemLink, recipeArray)
	
	if nil == recipeArray then
		recipeArray = FurC.Find(itemLink)
		if nil == recipeArray then return false end
	end
	if (not recipeArray.craftable) 	then return false end
	
	if nil == recipeArray.characters then return true end
	
	for name, knowledge in pairs(recipeArray.characters) do
		if knowledge then return false end
	end		

	return true
end

function FurC.PrintCraftingStation(recipeArray)
	if not recipeArray.tradeskillType then return "" end
	return (" (" .. GetCraftingSkillName(recipeArray.tradeskillType) .. ")" or "" )
end

function FurC.GetRecipeHolders(itemLink, recipeArray)

	local recipeKey	  = getItemId(itemLink)
	local recipeArray = recipeArray or scanItemLink(itemLink)
	if nil == recipeArray then return end 
	recipeArray.characters = recipeArray.characters  or {}
	local ret = ""
	
	for characterName, itemKnowledge in pairs(recipeArray.characters) do
		if itemKnowledge then 			
			ret = ret .. zo_strformat("<<1>>, ", characterName)
		end
	end
	
	if ret == "" then return "You cannot craft this yet" end
	
		ret = "Can be crafted by " .. ret:gsub(", $", "")
	
	return ret
	
end

function FurC.Export()
	
	local accountName = GetUnitDisplayName("player")
	local itemNames = {}
	local itemName = "%a25"
	for itemId, recipeArray in pairs(FurC.settings["data"]) do
		if not FurC.IsUnknown(recipeArray.itemLink, recipeArray) then 
			itemName = recipeArray.itemName
			itemNames[#itemNames+1] = {
				["itemName"] = (zo_strformat("<<1>>", itemName)), 
				[itemName]	 = true,
				[accountName]= true
			}
		end
	end
	
	local exportArray = {}
	for key, value in pairs(FurC.SortTable(itemNames, "itemName", true)) do
		exportArray[key] = value["itemName"]
	end
	
	FurC.settings["export"] = exportArray
	
	ReloadUI()
	
end


function FurC.ScanRecipeFile()
	scanRecipeFile()
end

local vendorColor 	= "d68957"
local goldColor 	= "e5da40"
local apColor 		= "25C31E"
local tvColor		= "5EA4FF"

local function setupFromFile(itemLink)

	-- p("|cFF99FF>> setupFromFile: creating entry for |r <<1>>|cFFFFFF", itemLink)
	local recipeArray 			= {}
	recipeArray.itemLink 		= itemLink
	recipeArray.itemName		= GetItemLinkName(itemLink)
	
	recipeArray.filterType		= 0
	recipeArray.itemQuality		= GetItemLinkQuality(itemLink)
	recipeArray.iconFile		= GetItemLinkInfo(itemLink)
	
	recipeArray.craftable		= false
	recipeArray 				= updateItemSource(recipeArray)	
	recipeArray.origin			= FURC_VENDOR
	return recipeArray
end


local characterAlliance = GetUnitAlliance('player')
local function parseZoneData(zoneName, zoneData, versionNumber, origin)
	
	
	local function colorise(str, col)
		return zo_strformat("|c<<1>><<2>>|r", col, str)
	end
	local recipeArray
	for vendorName, vendorData in pairs(zoneData) do
		for itemLink, itemData in pairs(vendorData) do
			zo_callLater(function()
				recipeArray = setupFromFile(itemLink)
				if nil ~= recipeArray then 
					local itemPrice = tonumber(itemData["itemPrice"])
					
					local itemPriceString
					
					if origin then			
						recipeArray.origin 		= origin
					end	
					if itemPrice then
						if origin == FURC_PVP then 
							if vendorName:match("Imperial City") then
							itemPriceString = zo_strformat(
									"sold in <<1>> (<<2>> Tel Var Stones)", 
									colorise("Imperial City", 	vendorColor), 
									colorise(itemPrice, 		tvColor)
								)
								
							else	
								itemPriceString = zo_strformat(
									"sold in <<1>> (<<2>> AP)", 
									colorise("Cyrodiil", 	vendorColor), 
									colorise(itemPrice, 	apColor)
								)
							
							end
						elseif origin == FURC_LUXURY then 
							itemPriceString = zo_strformat(
								"was sold by <<1>> (<<2>> gold)", 
								colorise(vendorName, 	vendorColor), 
								colorise(itemPrice, 	goldColor)
							)
						else
							itemPriceString = zo_strformat(
								"sold by <<1>> (<<2>>) for <<3>> gold", 
								colorise(vendorName, 	vendorColor), 
								colorise(zoneName, 		vendorColor), 
								colorise(itemPrice, 	goldColor)
							)
						end							
						recipeArray.source 		= itemPriceString						
					end
					
					recipeArray["achievement"] 	= itemData["achievement"]
					recipeArray.craftable 		= false					
					local version 				= recipeArray.version or versionNumber or FurC.gameVersion
					recipeArray.version 		= math.min((recipeArray.version or version), version)
										
				end	
				addDatabaseEntry(recipeArray.itemLink, recipeArray)
									
			end, 500)
		end
	end	
end

function FurC.ScanMiscItemFile()
	return scanMiscItemFile()
end

local function scanCharacter()
	local listName, numRecipes
	for recipeListIndex=1, GetNumRecipeLists() do
		listName, numRecipes = GetRecipeListInfo(recipeListIndex)
		for recipeIndex=1, numRecipes do			
			scanRecipeIndices(recipeListIndex, recipeIndex) --	returns true on success
		end
	end 
	p(("|c2266ffFurniture Catalogue|r|cffffff: Character scan complete...|r"))
end
local function updateGui()
	zo_callLater(function()
	FurC.UpdateGui() 
	end, 1000)
end


function FurC.RescanRumourRecipes()
	
	local function rescan()
		for itemId, recipeArray in pairs(FurC.settings.data) do		
			if recipeArray.source == FURC_RUMOUR then
				local itemLink = recipeArray[itemLink]
				if not FurC.RumourRecipes[itemLink] then 
					recipeArray.source = FURC_CRAFTING
					recipeArray.origin = nil
				end
			end
		end
	end
	
	task:Call(rescan)
	:Then(updateGui)
end


local function scanFromFiles(shouldScanCharacter)  
	local function scanRecipeFile()
		local recipeKey, recipeArray
		local function scanArray(ary, version)
			if nil == ary then return end
			for recipeLink, _ in pairs(ary) do 
				recipeArray = parseBlueprint(recipeLink)
				if nil == recipeArray then 
					p("scanRecipeFile: error for <<1>>", recipeLink)
				else
					recipeKey = getItemId(recipeArray.itemLink)
					recipeArray.source 			= recipeArray.source or "You cannot craft this yet"
					recipeArray.craftable 		= true
					recipeArray.version 	 	= version
					recipeArray.origin 			= FURC_CRAFTING
					
					addDatabaseEntry(recipeKey, recipeArray)			
				end		
			end
		end	
		
		for versionNumber, versionData in pairs(FurC.Recipes) do
			scanArray(versionData, versionNumber)
		end
		for versionNumber, versionData in pairs(FurC.RollisRecipes) do
			scanArray(versionData, versionNumber)
		end
	end
	
	local function scanRollis()
		for versionNumber, versionData in pairs(FurC.Rollis) do
			for itemLink, itemSource in pairs(versionData) do
				recipeArray = parseFurnitureItem(itemLink)
				if nil ~= recipeArray then 
					recipeArray.source = itemSource
					recipeArray.craftable = false
					recipeArray["version"] = versionNumber
					recipeArray.origin = FURC_ROLLIS
					addDatabaseEntry(itemLink, recipeArray)			
				end
			end	
		end	
	end
	
	local function scanFestivalFiles()
		for versionNumber, versionData in pairs(FurC.EventItems) do
			for eventName, eventData in pairs(versionData) do
				for eventItemSource, eventItemData in pairs(eventData) do
					for itemLink, itemData in pairs(eventItemData) do
						zo_callLater(function()
							recipeArray = setupFromFile(itemLink)
							if nil ~= recipeArray then 
								recipeArray.craftable 	= false					
								recipeArray["version"] 		= versionNumber
								recipeArray.source 		= zo_strformat(
									"Can be acquired during |cd68957<<1>>|r (|cd68957<<2>>|r)", 
									eventName, 
									eventItemSource
									)	
								recipeArray.origin = FURC_VENDOR
							end				
							addDatabaseEntry(recipeArray.itemLink, recipeArray)										
						end, 50)
					end		
				end		
			end 
		end 
	end

	local function scanMiscItemFile()		
		for versionNumber, versionData in pairs(FurC.MiscItemSources) do
			for origin, originData in pairs(versionData) do			
				for itemLink, itemSource in pairs(originData) do
					recipeArray = parseFurnitureItem(itemLink)
					if nil ~= recipeArray then 
						recipeArray.source  = itemSource
						recipeArray.version = versionNumber
						recipeArray.origin  = origin
						addDatabaseEntry(itemLink, recipeArray)			
					end
				end				
			end
		end
	end
	
	local function scanVendorFiles()
	
		FurC.InitAchievementVendorList()
		local recipeKey, recipeArray, itemSource
		
		for versionNumber, versionData in pairs(FurC.AchievementVendors) do
			for zoneName, zoneData in pairs(versionData) do	
				parseZoneData(zoneName, zoneData, versionNumber) 
			end 
		end
		
		for versionNumber, versionData in pairs(FurC.LuxuryFurnisher) do
			for zoneName, zoneData in pairs(versionData) do		
				parseZoneData(zoneName, zoneData, versionNumber, FURC_LUXURY) 
			end 
		end
		
		for versionNumber, versionData in pairs(FurC.PVP) do
			for zoneName, zoneData in pairs(versionData) do		
				parseZoneData(zoneName, zoneData, versionNumber, FURC_PVP) 
			end 
		end	
	end

	FurC.IsLoading(true)
	
	task:Call(scanRollis)
	:Then(scanRecipeFile)
	:Then(scanVendorFiles)
	:Then(scanFestivalFiles)
	:Then(scanMiscItemFile)
	:Then(
	function() 
		if shouldScanCharacter then 
			scanCharacter()
		else
			startupMessage("|c2266ffFurniture Catalogue|r|cffffff: |cffffffIf you miss any recipes, please trigger a scan on your furniture crafter by clicking the refresh button in the UI.|r")
			
		end
	end)
	:Then(updateGui)
	startupMessage(zo_strformat("|c2266ffFurniture Catalogue|r|cffffff: The database is up-to-date.|r"))
	
end
function FurC.ScanFromFiles(scanCharacterKnowledge)
	return scanFromFiles(scanCharacterKnowledge)
end

local function getScanFromFiles()

	if (FurC.settings.databaseVersion < FurC.version) then
		FurC.settings.databaseVersion = FurC.version
		return true
	end
	
	return FurC.settings.data == {}
end	

local function getScanCharacter()
	if nil == FurC.settings.accountCharacters[FurC.CharacterName] then
		FurC.settings.accountCharacters[FurC.CharacterName] = false
		return true
	end
end	

function FurC.ScanRecipes(shouldScanFiles, shouldScanCharacter)								-- returns database
	
	shouldScanFiles = shouldScanFiles or getScanFromFiles()
	shouldScanCharacter = (shouldScanCharacter or getScanCharacter())
	if (shouldScanFiles) then  
		p(("|c2266ffFurniture Catalogue|r|cffffff: Scanning data files...|r"))
		scanFromFiles(shouldScanCharacter)
	elseif (shouldScanCharacter) then
		p("Not scanning files, scanning character knowledge now...")
		scanCharacter() 		
	end	
	

end
