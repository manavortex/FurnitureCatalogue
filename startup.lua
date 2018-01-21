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
FURC_HOMESTEAD						= 2
FURC_MORROWIND						= 3
FURC_REACH							= 4
FURC_CLOCKWORK						= 5
FURC_DRAGONS						= 6
		
FURC_LOC_HOLLOW_CITY 				= "Hollow City, Cicero's General Goods"
FURC_AV_ZANILTHERAN					= "Zanil Theran, Luxury Furnisher"
		
		
FurC.version						= 2.0

local defaults 						= {
	
	hideMats						= true,
	dontScanTradingHouse 			= false,
	enableDebug 					= false,
			
	filterCraftingType 				= {},
	filterQuality 					= {},
			
	resetDropdownChoice				= false,
	useTinyUi						= false,
	useInventoryIcons				= true,
	fontSize						= 18,
			
	gui								= {		
		lastX						= 100,
		lastY						= 100,
		width						= 650,
		height 						= 550,		
	},			
	dropdownDefaults				= {
		Source						= 1, 
		Character					= 1, 
		Version						= 1, 	
	},		
			
	accountCharacters				= {},	
			
	version 						= 2.0,
			
	-- tooltips		
	disableTooltips					= false,
	coloredTooltips 				= true,
	hideKnowledge					= false,
			
	hideBooks						= true, 
	hideDoubtfuls					= true,
	hideCrownstore					= true,
	hideRumourEntry					= false,
	hideCrownStoreEntry				= true,
	wipeDatabase					= false,
	startupSilently					= true,
			
	visibility						= {
		hud							= true,
		hudui						= true,
	}
}

FURC_NONE				= 1
FURC_FAVE 				= FURC_NONE +1
FURC_CRAFTING			= FURC_FAVE +1
FURC_CRAFTING_KNOWN		= FURC_CRAFTING +1
FURC_CRAFTING_UNKNOWN	= FURC_CRAFTING_KNOWN +1
FURC_VENDOR 			= FURC_CRAFTING_UNKNOWN +1
FURC_PVP 				= FURC_VENDOR +1
FURC_CROWN 				= FURC_PVP +1
FURC_RUMOUR 			= FURC_CROWN +1
FURC_LUXURY 			= FURC_RUMOUR +1
FURC_OTHER 				= FURC_LUXURY +1
FURC_ROLLIS 			= FURC_OTHER +1
FURC_DROP 				= FURC_ROLLIS +1
FURC_JUSTICE 			= FURC_DROP +1
FURC_FISHING 			= FURC_JUSTICE +1
FURC_GUILDSTORE 		= FURC_FISHING +1
FURC_FESTIVAL_DROP 		= FURC_GUILDSTORE +1



FURC_EMPTY_STRING 		= ""


local sourceIndicesKeys = {
	[FURC_NONE] 						= "off",
	[FURC_FAVE] 						= "favorites",
	[FURC_CRAFTING] 					= "craft_all",
	[FURC_CRAFTING_KNOWN] 				= "craft_known",
	[FURC_CRAFTING_UNKNOWN] 			= "craft_unknown",
	[FURC_VENDOR] 						= "purch_gold",
	[FURC_PVP] 							= "purch_ap",
	[FURC_CROWN] 						= "crownstore",
	[FURC_RUMOUR] 						= "rumour",
	[FURC_LUXURY] 						= "luxury",
	[FURC_OTHER] 						= "other"
}

local choicesSource = {
	[FURC_NONE]							= "Source filter: off", 
	[FURC_FAVE] 						= "Favorites", 
	[FURC_CRAFTING] 					= "Craftable: All", 
	[FURC_CRAFTING_KNOWN] 				= "Craftable: Known", 
	[FURC_CRAFTING_UNKNOWN] 			= "Craftable: Unknown", 
	[FURC_VENDOR] 						= "Purchaseable (gold)",
	[FURC_PVP] 							= "Purchaseable (AP)",
	[FURC_CROWN] 						= "Crown Store",
	[FURC_RUMOUR] 						= "Rumour items",
	[FURC_LUXURY] 						= "Luxury items",
	[FURC_OTHER] 						= "Other",
}
local tooltipsSource = {
	[FURC_NONE]							= "disables this filter", 
	[FURC_FAVE] 						= "Shows your favorites", 
	[FURC_CRAFTING] 					= "Shows all craftable items", 
	[FURC_CRAFTING_KNOWN] 				= "Shows only known craftable items", 
	[FURC_CRAFTING_UNKNOWN] 			= "Shows only unknown craftable items", 
	[FURC_VENDOR] 						= "Shows only items that cannot be crafted",
	[FURC_PVP] 							= "Items that are sold for alliance points",
	[FURC_CROWN] 						= "Shows items that can only be acquired from crown store",
	[FURC_RUMOUR] 						= "Items and recipes that have been datamined, but haven't been confirmed existing",
	[FURC_LUXURY] 						= "Items that at some point were sold by Zanil Theran, Cicero's General Goods, Coldharbour",
	[FURC_OTHER] 						= "Shows items that can be farmed/stolen/found",
}

FurnitureCatalogue.DropdownData = {
	ChoicesVersion	= {
		[1] = "Version filter: off", 
		[2] = "Homestead", 
		[3] = "Morrowind", 
		[4] = "Horns of the Reach", 
		[5] = "Clockwork City", 
		[6] = "Dragon Bones", 
	},
	TooltipsVersion	= {
		[1] = "disables this filter", 
		[2] = "Items released in Homestead update", 
		[3] = "YOU N\'WAH!", 
		[4] = "Because all we needed were more Reachmen", 
		[5] = "Where the flywheels churn and the brass is pretty", 
		[6] = "If you got this from Narsis Dren, well...", 
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
	
	FurnitureCatalogue.settings 	= ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Settings", 2, nil, defaults)	
	

	if FurC.AccountName == "@manavortex" or FurC.AccountName == "@Manorin" then
		FurnitureCatalogue.devSettings 	= ZO_SavedVars:NewAccountWide("_FurC_DevData", 2, nil, {})
		SLASH_COMMANDS["/furc_dev"] = FurnitureCatalogue_ToggleDev
	end
	
	-- initialise setting, also setup the "source" dropdown for the menu
	FurC.settings.data 							= FurC.settings.data or {}	
	FurC.settings.filterCraftingType 			= {}
	FurC.settings.filterQuality 				= {}
	setupSourceDropdown()
	
	FurnitureCatalogue.CreateSettings(FurnitureCatalogue.settings, defaults, FurnitureCatalogue)	
	
	FurnitureCatalogue.CharacterName = zo_strformat(GetUnitName('player'))
	
	FurC.RegisterEvents()
	
	FurnitureCatalogue.InitGui()
		FurnitureCatalogue.CreateTooltips()
	FurC.InitRightclickMenu()
	
	FurC.SetupInventoryRecipeIcons()
	
	local scanFiles = false
	if FurC.settings.version 		< FurC.version then
			FurC.settings.version 		= FurC.version		
		scanFiles = true
	end
	
	FurnitureCatalogue.ScanRecipes(scanFiles, not FurC.GetSkipInitialScan())
	FurC.settings.databaseVersion 	= FurC.version
	SLASH_COMMANDS["/fur"] 			= FurnitureCatalogue_Toggle
	
	
	FurC.SetFilter(true)
	EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)
	
end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle Furniture Catalogue")
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)