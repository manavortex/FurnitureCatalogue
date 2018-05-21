local currentChar				= FurnitureCatalogue.CharacterName
local task 						= LibStub("LibAsync"):Create("FurnitureCatalogue_ScanDataFiles")
local task2 					= LibStub("LibAsync"):Create("FurnitureCatalogue_ScanCharacterKnowledge")
local characterAlliance 		= GetUnitAlliance('player')

local NUMBER_TYPE 				= "number"
local STRING_TYPE 				= "string"
local STRING_EMPTY 				= ""

local lastLink 					= nil
local recipeArray 				= nil

local FURC_STRING_TRADINGHOUSE = "Seen in trading house"

local function getCurrentChar()
	if nil == currentChar then currentChar = zo_strformat(GetUnitName("player")) end
	return currentChar
end

local p = FurC.DebugOut

local function startupMessage(text)
	if FurC.GetStartupSilently() then return end
	d(text)
end

local function getItemId(itemLink)
	if nil == itemLink or STRING_EMPTY == itemLink then return end
	if type(itemLink) == NUMBER_TYPE and itemLink > 9999 then return itemLink end
	local _, _, _, itemId = ZO_LinkHandler_ParseLink(itemLink)
	return tonumber(itemId)
end
FurC.GetItemId = getItemId

local function getItemLink(itemId)
    if nil == itemId then return end
	itemId = tostring(itemId)
	if #itemId > 55 then return itemId end
	if #itemId < 4 then return end
	return zo_strformat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", itemId)
end
FurC.GetItemLink = getItemLink

local function trySaveDevDebug(recipeArray)
	if not (FurC.AccountName == "@manavortex" or FurC.AccountName == "@Manorin") then return end
	if recipeArray.origin ~= FURC_DROP then return end
	itemLink = (nil ~= recipeArray.blueprintLink and recipeArray.blueprintLink) or recipeArray.itemId
	FurnitureCatalogue.devSettings[itemLink] = "true, -- " .. GetItemLinkName(itemLink)
end

local function addDatabaseEntry(recipeKey, recipeArray)
	if recipeKey and recipeArray and {} ~= recipeArray then
		FurC.settings.data[recipeKey] = recipeArray
	end
end


local function makeMaterial(recipeKey, recipeArray, tryPlaintext, forcePlaintext)

	if nil == recipeArray or (nil == recipeArray.blueprint and nil == recipeArray.recipeIndex and nil == recipeArray.recipeListIndex) then
		return "couldn't get material list, please re-scan character knowledge"
	end
	local ret = ""
	local ingredients = FurC.GetIngredients(recipeKey, recipeArray)
	forcePlaintext = forcePlaintext or tryPlaintext and NonContiguousCount(ingredients) > 4
	for ingredientLink, qty in pairs(ingredients) do
		-- auto-capitalize because for some reason the ZOS API doesn't
		local itemText = (forcePlaintext and string.gsub(" "..GetItemLinkName(ingredientLink), "%W%l", string.upper):sub(2)) or ingredientLink
		 ret = zo_strformat("<<1>> <<2>>x <<3>>, ", ret, qty, itemText)
	end
	return ret:sub(0, -3)

end
FurC.GetMats = makeMaterial

function FurC.GetIngredients(itemLink, recipeArray)
	recipeArray = recipeArray or FurC.Find(itemLink)
	local ingredients = {}
	if recipeArray.blueprint then
		local blueprintLink = FurC.GetItemLink(recipeArray.blueprint)
		numIngredients = GetItemLinkRecipeNumIngredients(blueprintLink)
		for ingredientIndex=1, numIngredients do
			name, _, qty 				= GetItemLinkRecipeIngredientInfo(blueprintLink, ingredientIndex)
			ingredientLink 				= GetItemLinkRecipeIngredientItemLink(blueprintLink, ingredientIndex)
			ingredients[ingredientLink]	= qty
		end
	else
		_, name, numIngredients = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
		for ingredientIndex=1, numIngredients do
			name, _, qty 					= GetRecipeIngredientItemInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex, ingredientIndex)
			ingredientLink 					= GetRecipeIngredientItemLink(recipeArray.recipeListIndex, recipeArray.recipeIndex, ingredientIndex)
			ingredients[ingredientLink]		= qty
		end
	end
	return ingredients
end

local function parseFurnitureItem(itemLink, override)					-- saves to DB, returns recipeArray

	if not (
	override or IsItemLinkPlaceableFurniture(itemLink)
	or  GetItemLinkItemType(itemLink) == ITEMTYPE_FURNITURE
	) then return end

	local recipeKey 					= getItemId(itemLink)
	local recipeArray 					= FurC.settings.data[recipeKey]
	if nil ~= recipeArray then return recipeArray end

	recipeArray = {}

	addDatabaseEntry(recipeKey, recipeArray)

	return recipeArray
end

local function parseBlueprint(blueprintLink)				-- saves to DB, returns recipeArray

	local itemLink 		= GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
	local blueprintId 	= getItemId(blueprintLink)
	local recipeKey 	= getItemId(itemLink)
	if nil == recipeKey or -- we don't have a key to access the database
		nil == itemLink or -- we don't have an item link to parse
		nil == GetItemLinkName(itemLink) -- we didn't find an item result for our recipe
	then return end

	local recipeArray 			= FurC.settings.data[recipeKey] or {}
	recipeArray.origin			= recipeArray.origin			or FURC_CRAFTING
	recipeArray.characters		= recipeArray.characters		or {}
	recipeArray.craftingSkill	= recipeArray.craftingSkill		or GetItemLinkCraftingSkillType(blueprintLink)
	recipeArray.blueprint 		= recipeArray.blueprint 		or getItemId(blueprintLink)


	if (IsItemLinkRecipeKnown(blueprintLink)) then
		recipeArray.characters[getCurrentChar()] 	= true
	end
	addDatabaseEntry(recipeKey, recipeArray)
	return recipeArray

end


function FurC.Find(itemOrBlueprintLink)						-- sets recipeArray, returns it - calls scanItemLink


	if tonumber(itemOrBlueprintLink) == itemOrBlueprintLink then itemOrBlueprintLink = FurC.GetItemLink(itemOrBlueprintLink) end
	if nil == itemOrBlueprintLink or #itemOrBlueprintLink == 0 then return end
	p("scanItemLink(<<1>>)...", itemOrBlueprintLink)		-- do not return empty arrays. If this returns nil, abort!

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
	end

	return recipeArray
end

function FurC.Delete(itemOrBlueprintLink)						-- sets recipeArray, returns it - calls scanItemLink
	local recipeArray = scanItemLink(itemOrBlueprintLink)
	if nil == recipeArray then return end
	local itemLink = recipeArray.itemId
	local itemKey = getItemId(itemLink)
	FurC.settings.data[itemKey] = nil
end

function FurC.GetEntry(itemOrBlueprintLink)
	local itemLink =  (IsItemLinkFurnitureRecipe(itemOrBlueprintLink) and GetRecipeResultItemLink(itemOrBlueprintLink)) or itemOrBlueprintLink
	local recipeArray = FurC.Find(itemLink)
	-- d(string.format("Trying to get entry for %s: %s", itemLink, recipeArray))
	if not recipeArray then return end
	local itemId = getItemId(itemOrBlueprintLink)
	if recipeArray.blueprint then
		itemId = getItemId(GetItemLinkRecipeResultItemLink(blueprintLink))
	end
	return itemId, recipeArray

end

function FurC.IsFavorite(itemLink, recipeArray)
	recipeArray = recipeArray or FurC.Find(itemLink)
	return recipeArray.favorite
end
function FurC.Fave(itemLink, recipeArray)
	recipeArray = recipeArray or FurC.Find(itemLink)
	recipeArray.favorite = not recipeArray.favorite
	if not recipeArray.favorite then
		recipeArray.favorite = nil
	end

	FurC.UpdateGui()
end

local function scanRecipeIndices(recipeListIndex, recipeIndex)		-- returns recipeArray or nil, initialises

	local itemLink = GetRecipeResultItemLink(recipeListIndex, recipeIndex, LINK_STYLE_BRACKETS)
	if nil == itemLink or #itemLink == 0 or not IsItemLinkPlaceableFurniture(itemLink) then return end

	local recipeKey = getItemId(itemLink)

	local recipeArray 			= FurC.settings.data[recipeKey] or {}
	recipeArray.origin 			= FURC_CRAFTING
	recipeArray.version			= recipeArray.version or 2
	recipeArray.recipeListIndex = recipeArray.recipeListIndex or recipeListIndex
	recipeArray.recipeIndex 	= recipeArray.recipeIndex or recipeIndex

	recipeArray.characters		= recipeArray.characters or {}



	if GetRecipeInfo(recipeListIndex, recipeIndex) then
		recipeArray.characters[getCurrentChar()] 	= true
		FurC.settings.accountCharacters = FurC.settings.accountCharacters or {}
		FurC.settings.accountCharacters[getCurrentChar()] = FurC.settings.accountCharacters[getCurrentChar()] or true
	end


	addDatabaseEntry(recipeKey, recipeArray)
	return recipeArray

end

function FurC.TryCreateRecipeEntry(recipeListIndex, recipeIndex)	-- returns scanRecipeIndices, called from Events.lua
	return scanRecipeIndices(recipeListIndex, recipeIndex)
end

function FurC.IsAccountKnown(recipeKey, recipeArray)
	if recipeKey == nil and recipeArray == nil then return false end
	recipeArray = recipeArray or FurC.settings.data[recipeKey]
	return not (nil == recipeArray or nil == recipeArray.characters or NonContiguousCount(recipeArray.characters) == 0)
end

function FurC.CanCraft(recipeKey, recipeArray)
	if recipeKey == nil  and recipeArray == nil then return false end
	recipeArray = recipeArray or FurC.settings.data[recipeKey]
	if FurC.IsAccountKnown(recipeKey, recipeArray) then
		return recipeArray.characters[getCurrentChar()]
	end
	return false
end

function FurC.GetCraftingSkillType(recipeKey, recipeArray)

	local itemLink 			= FurC.GetItemLink(recipeKey)
	local craftingSkillType	= GetItemLinkCraftingSkillType(itemLink)

	if 0 == craftingSkillType and recipeArray.blueprint then
		craftingSkillType = GetItemLinkRecipeCraftingSkillType(FurC.GetItemLink(recipeArray.blueprint))
	elseif 0 == craftingSkillType and recipeArray.recipeListIndex and recipeArray.recipeIndex then
		_, _, _, _, _, _, craftingSkillType = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
	end

	return craftingSkillType
end


local function scanCharacter()
	local listName, numRecipes
	for recipeListIndex=1, GetNumRecipeLists() do
		listName, numRecipes = GetRecipeListInfo(recipeListIndex)
		for recipeIndex=1, numRecipes do
			scanRecipeIndices(recipeListIndex, recipeIndex) --	returns true on success
		end
	end
	p((GetString(SI_FURC_DEBUG_CHARSCANCOMPLETE)))
end
FurC.ScanCharacter = scanCharacter

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
	:Then(FurC.UpdateGui)
end

local recipeArray
local function scanFromFiles(shouldScanCharacter)
	local function parseZoneData(zoneName, zoneData, versionNumber, origin)
		for vendorName, vendorData in pairs(zoneData) do
			for itemId, itemData in pairs(vendorData) do

				recipeArray = parseFurnitureItem(FurC.GetItemLink(itemId), true)
				if not recipeArray then
						p("Error when scanning <<1>>", itemId)
					else

					recipeArray.origin			= origin
					recipeArray.version			= versionNumber
					addDatabaseEntry(itemId, recipeArray)
				end

			end
		end
	end

	local function scanRecipeFile()
		local recipeKey, recipeArray
		local function scanArray(ary, versionNumber, origin)
			if nil == ary then return end

			for key, recipeId in ipairs(ary) do
				local recipeLink = FurC.GetItemLink(recipeId)
				local itemLink = GetItemLinkRecipeResultItemLink(recipeLink) or FurC.GetItemLink(recipeId)
				recipeArray = FurC.Find(itemLink) or parseBlueprint(recipeLink) or parseFurnitureItem(itemLink)
				local recipeListIndex, recipeIndex = GetItemLinkGrantedRecipeIndices(recipeLink)
				if nil == recipeArray then
					p("scanRecipeFile: error for <<1>> (ID was <<2>>)", recipeLink, recipeId)
				else
					recipeKey 					= getItemId(itemLink)
					recipeArray.version 	 	= versionNumber
					recipeArray.origin 			= origin
					recipeArray.blueprint		= recipeId
					addDatabaseEntry(recipeKey, recipeArray)
				end
			end
		end

		for versionNumber, versionData in pairs(FurC.Recipes) do
			scanArray(versionData, versionNumber, FURC_CRAFTING)
		end
		for versionNumber, versionData in pairs(FurC.RolisRecipes) do
			scanArray(versionData, versionNumber, FURC_CRAFTING)
		end
		for versionNumber, versionData in pairs(FurC.FaustinaRecipes) do
			scanArray(versionData, versionNumber, FURC_CRAFTING)
		end
	end

	local function scanRolis()
		for versionNumber, versionData in pairs(FurC.Rolis) do
			for itemId, itemSource in pairs(versionData) do
				recipeArray = parseFurnitureItem(FurC.GetItemLink(recipeId), true)
				if nil ~= recipeArray then
					recipeArray.version = versionNumber
					recipeArray.origin = FURC_Rolis
					addDatabaseEntry(itemId, recipeArray)
				end
			end
		end
		for versionNumber, versionData in pairs(FurC.Faustina) do
			for itemId, itemSource in pairs(versionData) do
				recipeArray = parseFurnitureItem(FurC.GetItemLink(recipeId), true)
				if nil ~= recipeArray then
					recipeArray.version = versionNumber
					recipeArray.origin = FURC_Rolis
					addDatabaseEntry(itemId, recipeArray)
				end
			end
		end
	end

	local function scanFestivalFiles()
		for versionNumber, versionData in pairs(FurC.EventItems) do
			for eventName, eventData in pairs(versionData) do
				for eventItemSource, eventItemData in pairs(eventData) do
					for itemId, _ in pairs(eventItemData) do
						recipeArray             = {}
						recipeArray.craftable 	= false
						recipeArray.version 	= versionNumber
						recipeArray.origin 		= FURC_FESTIVAL_DROP
						addDatabaseEntry(itemId, recipeArray)
					end
				end
			end
		end
	end

	local function scanMiscItemFile()
		for versionNumber, versionData in pairs(FurC.MiscItemSources) do
			for origin, originData in pairs(versionData) do
				for itemId, itemSource in pairs(originData) do
					local itemLink = FurC.GetItemLink(itemId)
					recipeArray = parseFurnitureItem(FurC.GetItemLink(itemId))
					if nil ~= recipeArray then
						recipeArray.version = versionNumber
						recipeArray.origin  = origin
						addDatabaseEntry(itemId, recipeArray)
					else
						p("scanMiscItemFile: Error when scanning <<1>> (<<2>>) -> <<3>>", itemLink, itemId, origin)
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
				parseZoneData(zoneName, zoneData, versionNumber, FURC_VENDOR)
			end
		end

		for versionNumber, vendorData in pairs(FurC.LuxuryFurnisher) do
			for itemId, itemData in pairs(vendorData) do
					 local recipeArray 			= {}

					recipeArray.origin			= FURC_LUXURY
					recipeArray.version			= versionNumber
					addDatabaseEntry(itemId, recipeArray)
			end
		end

		for versionNumber, versionData in pairs(FurC.PVP) do
			for zoneName, zoneData in pairs(versionData) do
				parseZoneData(zoneName, zoneData, versionNumber, FURC_PVP)
			end
		end
	end

	local function scanRumourRecipes()
		for index, blueprintId in pairs(FurC.RumourRecipes) do
			local blueprintLink = FurC.GetItemLink(blueprintId)
			local itemLink = GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
			if #itemLink == 0 then itemLink = blueprintLink end
			local itemId = getItemId(itemLink)
			recipeArray = parseBlueprint(blueprintLink) or parseFurnitureItem(itemLink) or {}
			if blueprintId ~= itemId then
				recipeArray.blueprint = blueprintId
			end
			recipeArray.recipeListIndex, recipeArray.recipeIndex =  GetItemLinkGrantedRecipeIndices(blueprintLink)
			recipeArray.origin = FURC_RUMOUR
			recipeArray.verion = FURC_HOMESTEAD
			addDatabaseEntry(itemId, recipeArray)
		end
	end
	FurC.IsLoading(true)

	task:Call(scanRecipeFile)
	:Then(scanMiscItemFile)
	:Then(scanRolis)
	:Then(scanVendorFiles)
	:Then(scanRolis)
	:Then(scanFestivalFiles)
	:Then(
	function()
		if shouldScanCharacter then
			scanCharacter()
		else
			startupMessage(GetString(SI_FURC_VERBOSE_STARTUP))
		end
	end)
	:Then(scanRumourRecipes)
	:Then(FurC.UpdateGui)
	startupMessage(GetString(SI_FURC_VERBOSE_DB_UPTODATE))

end

function FurC.ScanFromFiles(scanCharacterKnowledge)
	return scanFromFiles(scanCharacterKnowledge)
end

local function getScanFromFiles()

	if (FurC.settings.version < FurC.version) then
		FurC.settings.version = FurC.version
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
		p(GetString(SI_FURC_VERBOSE_SCANNING_DATA_FILE))
		scanFromFiles(shouldScanCharacter)
	elseif (shouldScanCharacter) then
		p(GetString(SI_FURC_VERBOSE_SCANNING_CHARS))
		scanCharacter()
	end
end

function FurC.GetItemDescription(recipeKey, recipeArray, stripColor)
FurC.settings.emptyItemSources =  FurC.settings.emptyItemSources or {}
	recipeArray = recipeArray or FurC.Find(recipeKey, recipeArray)
	if not recipeArray then return "" end
	local origin = recipeArray.origin
	if origin == FURC_CRAFTING or origin == FURC_WRIT_VENDOR then
		return FurC.GetMats(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_Rolis then
		return FurC.getRolisSource(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_LUXURY then
		return FurC.getLuxurySource(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_GUILDSTORE then
		return GetString(SI_FURC_SEEN_IN_GUILDSTORE)
	elseif origin == FURC_VENDOR then
		return FurC.getAchievementVendorSource(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_FESTIVAL_DROP then
		return FurC.getEventDropSource(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_PVP then
		return FurC.getPvpSource(recipeKey, recipeArray, stripColor)
	elseif origin == FURC_RUMOUR then
		return FurC.getRumourSource(recipeKey, recipeArray, stripColor)
	else
		itemSource = FurC.GetMiscItemSource(recipeKey, recipeArray, stripColor)
	end
    if not itemSource then
        FurC.settings.emptyItemSources[recipeKey] = ", --" .. GetItemLinkName(FurC.GetItemLink(recipeKey))
    end
	return itemSource or GetString(SI_FURC_ITEMSOURCE_EMPTY)
end

