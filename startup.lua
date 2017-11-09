FurnitureCatalogue 					= {}
FurnitureCatalogue.name				= "FurnitureCatalogue"
FurnitureCatalogue.author			= "manavortex"
FurnitureCatalogue.CharacterName	= nil
FurnitureCatalogue.settings			= {}	
	
FurC 								= FurnitureCatalogue
FurC.DevDebug						= false
FurC.AccountName					= GetDisplayName() 



FurC.AchievementVendors				= {}
FurC.LuxuryFurnisher				= {}
FurC.Recipes						= {}
FurC.Rollis							= {}
FurC.RollisRecipes					= {}
FurC.Books							= {}
FurC.EventItems						= {}
FurC.PVP							= {}

FurC.HomesteadData 					= {}
FurC.MorrowindData 					= {}
FurC.ReachHornData 					= {}
FurC.Cyrodiil						= {}
FurC.ClockworkData					= {}


-- versioning
_G["FURC_HOMESTEAD"]				= 2
_G["FURC_MORROWIND"]				= 3
_G["FURC_REACH"]					= 4
_G["FURC_CLOCKWORK"]				= 5

FurnitureCatalogue.version			= 1.9106
FurC.gameVersion					= FURC_REACH

local defaults 					= {

	hideMats					= true,
	dontScanTradingHouse 		= false,
	enableDebug 				= false,
		
	filterCraftingType 			= {},
	filterQuality 				= {},
		
	data						= {},	-- item database
	databaseVersion				= 0.1,
	resetDropdownChoice			= false,
	useTinyUi					= false,
	useInventoryIcons			= true,
	fontSize					= 18,
		
	gui							= {		
		lastX					= 100,
		lastY					= 100,
		width					= 650,
		height 					= 550,		
	},		
	dropdownDefaults			= {
		Source					= 1, 
		Character				= 1, 
		Version					= 1, 	
	},	
		
	accountCharacters			= {},	
		
	version 					= 1.6,
		
	-- tooltips	
	disableTooltips				= false,
	coloredTooltips 			= true,
	hideKnowledge				= false,
		
	hideBooks					= true, 
	hideDoubtfuls				= true,
	hideCrownstore				= true,
	hideRumourEntry				= false,
	hideCrownStoreEntry			= true,
	wipeDatabase				= false,
	startupSilently				= false,
		
	visibility					= {
		hud						= true,
		hudui					= true,
	}
}

local sourceIndicesKeys = {
	[1] 						= "off",
	[2] 						= "favorites",
	[3] 						= "craft_all",
	[4] 						= "craft_known",
	[5] 						= "craft_unknown",
	[6] 						= "purch_gold",
	[7] 						= "purch_ap",
	[8] 						= "crownstore",
	[9] 						= "rumour",
	[10] 						= "luxury",
	[11] 						= "other"
}

FurC.sourceIndices	= {		
	off 						= 1,
	favorites 					= 2,
	craft_all 					= 3,
	craft_known 				= 4,
	craft_unknown 				= 5,
	purch_gold 					= 6,
	purch_ap 					= 7,
	crownstore 					= 8,
	rumour 						= 9,
	luxury 						= 10,
	other  						= 11
}
local sourceIndices				= FurC.sourceIndices
local sI 						= sourceIndices

local choicesSource = {
	[sI.off]			= "Source filter: off", 
	[sI.favorites] 		= "Favorites", 
	[sI.craft_all] 		= "Craftable: All", 
	[sI.craft_known] 	= "Craftable: Known", 
	[sI.craft_unknown] 	= "Craftable: Unknown", 
	[sI.purch_gold] 	= "Purchaseable (gold)",
	[sI.purch_ap] 		= "Purchaseable (AP)",
	[sI.crownstore] 	= "Crown Store",
	[sI.rumour] 		= "Rumour items",
	[sI.luxury] 		= "Luxury items",
	[sI.other] 			= "Other",		
}
local tooltipsSource = {
	[sI.off]			= "disables this filter", 
	[sI.favorites] 		= "Shows your favorites", 
	[sI.craft_all] 		= "Shows all craftable items", 
	[sI.craft_known] 	= "Shows only known craftable items", 
	[sI.craft_unknown] 	= "Shows only unknown craftable items", 
	[sI.purch_gold] 	= "Shows only items that cannot be crafted",
	[sI.purch_ap] 		= "Items that are sold for alliance points",
	[sI.crownstore] 	= "Shows items that can only be acquired from crown store",
	[sI.rumour] 		= "Items and recipes that have been datamined, but haven't been confirmed existing",
	[sI.luxury] 		= "Items that at some point were sold by Zanil Theran, Cicero's General Goods, Coldharbour",
	[sI.other] 			= "Shows items that can be farmed/stolen/found",
}

FurnitureCatalogue.DropdownData = {
	ChoicesVersion	= {
		[1] = "Version filter: off", 
		[2] = "Homestead", 
		[3] = "Morrowind", 
		[4] = "Horns of the Reach", 
		[5] = "Clockwork City", 
	},
	TooltipsVersion	= {
		[1] = "disables this filter", 
		[2] = "Items released in Homestead update", 
		[3] = "YOU N\'WAH!", 
		[4] = "Because all we needed were more Reachmen", 
		[5] = "Where the flywheels churn and the brass is pretty", 
	},
	ChoicesCharacter  = {
		[1]	= "Character filter: off", 
	},
	TooltipsCharacter = {
		[1]	= "disables this filter", 
	},
	
	-- will be set in setupSourceDropdown
	ChoicesSource	= {},
	TooltipsSource 	= {},	
}

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



function FurnitureCatalogue.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	if not FurC.GetEnableDebug() then return end		
	if a10 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10))
	elseif a9 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5, a6, a7, a8, a9))
	elseif a8 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5, a6, a7, a8))
	elseif a7 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5, a6, a7))
	elseif a6 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5, a6))
	elseif a5 then 
		d(zo_strformat(output, a1, a2, a3, a4, a5))
	elseif a4 then 
		d(zo_strformat(output, a1, a2, a3, a4))
	elseif a3 then
		d(zo_strformat(output, a1, a2, a3))
	elseif a2 then
		d(zo_strformat(output, a1, a2))
	elseif a1 then 
		d(zo_strformat(output, a1))
	elseif output then
		d(zo_strformat(output))
	else
		d("\n")
	end	
end

local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end

function whoami()
	return FurnitureCatalogue.CharacterName
end

local function setupSourceDropdown()	

	if FurC.GetMergeLuxuryAndSales() then
        table.remove(choicesSource, 	sourceIndices.luxury)
        table.remove(tooltipsSource, 	sourceIndices.luxury)
        table.remove(sourceIndicesKeys, 	sourceIndices.luxury)
    end
	 if FurC.GetHideCrownStoreEntry() then	-- 8
        table.remove(choicesSource, 	sourceIndices.crownstore)
        table.remove(tooltipsSource, 	sourceIndices.crownstore)
        table.remove(sourceIndicesKeys, 	sourceIndices.crownstore)
    end
    if FurC.GetHideRumourRecipesEntry() then
        table.remove(choicesSource, 	sourceIndices.rumour)
        table.remove(tooltipsSource, 	sourceIndices.rumour)
        table.remove(sourceIndicesKeys, 	sourceIndices.rumour)
    end
   
   FurnitureCatalogue.DropdownData.ChoicesSource  = choicesSource
   FurnitureCatalogue.DropdownData.TooltipsSource = tooltipsSource
   
	sourceIndices = {}
	
	for idx, key in pairs(sourceIndicesKeys) do
		sourceIndices[key] = idx
	end
	FurC.SourceIndices = sourceIndices
end

function FurnitureCatalogue_ToggleDev(arg)
	if arg == 0 or arg == "true" then
		FurC.DevDebug = true
	else
		FurC.DevDebug = false
	end
end

-- initialization stuff
function FurnitureCatalogue_Initialize(eventCode, addOnName)
	if (addOnName ~= "FurnitureCatalogue") then return end
	
	FurnitureCatalogue.settings 	= ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Settings", 1, nil, defaults)	
	

	if FurC.AccountName == "@manavortex" or FurC.AccountName == "@Manorin" then
		FurnitureCatalogue.devSettings 	= ZO_SavedVars:NewAccountWide("_FurC_DevData", 1, nil, {})
		SLASH_COMMANDS["/furc_dev"] = FurnitureCatalogue_ToggleDev
	end
	
	-- initialise setting, also setup the "source" dropdown for the menu
	FurC.settings.data = FurC.settings.data or {}	
	FurC.settings.filterCraftingType 		= {}
	FurC.settings.filterQuality 			= {}
	setupSourceDropdown()
	
	FurnitureCatalogue.CreateSettings(FurnitureCatalogue.settings, defaults, FurnitureCatalogue)	
	
	FurnitureCatalogue.CharacterName = zo_strformat(GetUnitName('player'))
	
	if GetAPIVersion() == 10020 then 
		FurnitureCatalogue.DropdownData.ChoicesVersion[5] = nil
		FurnitureCatalogue.DropdownData.TooltipsVersion[5] = nil
	end
	
	
	FurC.RegisterEvents()
	
	
	
	FurnitureCatalogue.InitGui()
		FurnitureCatalogue.CreateTooltips()
	FurC.InitRightclickMenu()
	
	FurC.SetupInventoryRecipeIcons()
	
	local scanFiles = false
	if FurC.settings.version < FurC.version then
		FurC.settings.version = FurC.version
		scanFiles = true
	end
	
	FurnitureCatalogue.ScanRecipes(scanFiles, not FurC.GetSkipInitialScan())
	FurC.settings.databaseVersion = FurC.version
	SLASH_COMMANDS["/fur"] 		= FurnitureCatalogue_Toggle
	
	
	FurC.SetFilter(true)
	EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)
	
end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle Furniture Catalogue")
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)