local FurC = FurC

local vendorColor 	= "d68957"
local goldColor 	= "e5da40"
local apColor 		= "25C31E"
local tvColor		= "5EA4FF"
local p 			= FurC.DebugOut -- debug function calling zo_strformat with up to 10 args


local function colorise(str, col)
	str = tostring(str)
	if str:find("%d000$") then str = str:gsub("000$", "k") end
	return zo_strformat("|c<<1>><<2>>|r", col, str)
end

FURC_STRING_ROLLIS = "Sold by |cd68957Rollis Hlaalu|r"

local function getRollisSource(recipeKey, recipeArray)
	recipeArray = recipeArray or FurC.Find(recipeKey)
	if not recipeArray then return end
	local versionData = FurC.Rollis[recipeArray.version]
	if not versionData then return end
		if nil ~= versionData[recipeKey] then 
			return FURC_STRING_ROLLIS .. " for |ce5da40" .. versionData[recipeKey] .. "|h vouchers" 
		end
	
	return FURC_STRING_ROLLIS
end
FurC.getRollisSource = getRollisSource

FURC_STRING_FETCHER = "Was sold by |cd68957Zanil Theran|r in |cd68957Hollow City|r"

local function getLuxurySource(recipeKey, recipeArray)
	recipeArray = recipeArray or FurC.Find(recipeKey)
	if not recipeArray then return end
	local versionData = FurC.LuxuryFurnisher[recipeArray.version]
	if not versionData then return FURC_STRING_FETCHER end
	
	local itemData = versionData[recipeKey]
	
	if nil ~= itemData then		
		return zo_strformat(
		"<<1>> (<<2>>)", 
			FURC_STRING_FETCHER,
			colorise(itemData.itemPrice, goldColor)
		)		
	end
	
	return FURC_STRING_FETCHER
	
end
FurC.getLuxurySource = getLuxurySource

FURC_STRING_VENDOR = "sold by <<1>> in <<2>> (<<3>><<4>>)"
FURC_STRING_GOLD	= ""
FURC_STRING_AP		= " AP"

local function getPvpSource(recipeKey, recipeArray)
	
	recipeArray = recipeArray or FurC.Find(recipeKey)
	if not recipeArray then return end
	local versionData = FurC.PVP[recipeArray.version]
	if not versionData then return "getPvpSource: nil" end
	
	for vendorName, vendorData in pairs(versionData) do
		for locationName, locationData in pairs(vendorData) do
			if nil ~= locationData[recipeKey] then 
				return zo_strformat(
					FURC_STRING_VENDOR, 
					colorise(vendorName, 	vendorColor), 
					colorise(locationName, 	vendorColor), 
					colorise(locationData[recipeKey].itemPrice, 	apColor),
					FURC_STRING_AP
				)
			end
		end
	end
	
	return "getPvpSource"
	
end
FurC.getPvpSource = getPvpSource

local function getAchievementVendorSource(recipeKey, recipeArray)

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
					FURC_STRING_VENDOR, 
					colorise(vendorName, 				vendorColor), 
					colorise(zoneName, 					vendorColor), 
					colorise(databaseEntry.itemPrice, 	goldColor), 
					""
				)
			end
		end
	end
	return zo_strformat("getAchievementVendorSource, found version data but no item data for <<1>> ", recipeKey)
end
FurC.getAchievementVendorSource = getAchievementVendorSource

local function getEventVendorSource(recipeKey, recipeArray)

	recipeArray = recipeArray or FurC.Find(recipeKey)
	if not recipeArray then return end
	local versionData = FurC.AchievementVendors[recipeArray.version]
	if not versionData then 	
		return "getEventVendorSource: " .. tostring(recipeKey) 
	end
	for versionNumber, versionData in pairs(FurC.EventItems) do
			for eventName, eventData in pairs(versionData) do
				for eventItemSource, eventItemData in pairs(eventData) do
					if eventData[recipeKey] then 
						itemPriceString = zo_strformat(
							"can be acquired during <<1>> from ( <<2>> )", 
							colorise(eventName, 	vendorColor), 
							colorise(eventItemSource, 		vendorColor)
						)
					end
				end		
			end 
		end 
	
	return itemPriceString
end
FurC.getEventVendorSource = getEventVendorSource

function FurC.GetMiscItemSource(recipeKey, recipeArray)
	if not recipeArray or not recipeArray.version or not recipeArray.origin then return end
	
	if recipeArray.origin == FURC_RUMOUR then
		return FurC.getRumourSource(recipeKey, recipeArray)
	end

	local versionFiles = FurC.MiscItemSources[recipeArray.version]
	if not versionFiles then return end
	local originData = versionFiles[recipeArray.origin]
	if nil == originData then return end
	return originData[recipeKey]
end

FURC_RUMOUR_SOURCE_RECIPE = "This recipe has been datamined, but not seen in-game"
FURC_RUMOUR_SOURCE_ITEM = "This item has been datamined, but not seen in-game"
function FurC.getRumourSource(recipeKey, recipeArray)
	return (recipeArray.blueprint and FURC_RUMOUR_SOURCE_RECIPE) or FURC_RUMOUR_SOURCE_ITEM	
end

local FURC_STRING_CRAFTABLE_BY = "Can be crafted by "
local FURC_STRING_CANNOT_CRAFT = "You cannot craft this yet"

function FurC.GetCrafterList(recipeArray)
	if nil == recipeArray or recipeArray.origin ~= FURC_CRAFTING then 
		return "FurC.GetCrafterList called for a non-craftable"
	end
	if nil == recipeArray.characters or NonContiguousCount(recipeArray.characters) == 0 then 
		return FURC_STRING_CANNOT_CRAFT
	end
	local ret = FURC_STRING_CRAFTABLE_BY
	for characterName, characterKnowledge in pairs(recipeArray.characters) do
		ret = zo_strformat("<<1>> <<2>>, ", ret, characterName)
	end
	return ret:sub(0, -3)
end

function FurC.Export()
	
	local accountName = GetUnitDisplayName("player")
	local itemNames = {}
	local itemName = "%a25"
	for itemId, recipeArray in pairs(FurC.settings["data"]) do
		if FurC.CanCraft(itemId, recipeArray) then 
			itemName = GetItemLinkName(makeItemLink(itemId))
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