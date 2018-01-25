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
		
		
FurC.version						= 2.017

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
	[FURC_NONE]							= GetString(SI_FURC_NONE),			
	[FURC_FAVE] 						= GetString(SI_FURC_FAVE), 			
	[FURC_CRAFTING] 					= GetString(SI_FURC_CRAFTING), 		
	[FURC_CRAFTING_KNOWN] 				= GetString(SI_FURC_CRAFTING_KNOWN), 	
	[FURC_CRAFTING_UNKNOWN] 			= GetString(SI_FURC_CRAFTING_UNKNOWN),
	[FURC_VENDOR] 						= GetString(SI_FURC_VENDOR), 			
	[FURC_PVP] 							= GetString(SI_FURC_PVP), 			
	[FURC_CROWN] 						= GetString(SI_FURC_CROWN), 			
	[FURC_RUMOUR] 						= GetString(SI_FURC_RUMOUR), 			
	[FURC_LUXURY] 						= GetString(SI_FURC_LUXURY), 			
	[FURC_OTHER] 						= GetString(SI_FURC_OTHER), 			
}
local tooltipsSource = {
	[FURC_NONE]							= GetString(SI_FURC_NONE_TT),			
	[FURC_FAVE] 						= GetString(SI_FURC_FAVE_TT), 			
	[FURC_CRAFTING] 					= GetString(SI_FURC_CRAFTING_TT), 		
	[FURC_CRAFTING_KNOWN] 				= GetString(SI_FURC_CRAFTING_KNOWN_TT), 	
	[FURC_CRAFTING_UNKNOWN] 			= GetString(SI_FURC_CRAFTING_UNKNOWN_TT),
	[FURC_VENDOR] 						= GetString(SI_FURC_VENDOR_TT), 			
	[FURC_PVP] 							= GetString(SI_FURC_PVP_TT), 			
	[FURC_CROWN] 						= GetString(SI_FURC_CROWN_TT), 			
	[FURC_RUMOUR] 						= GetString(SI_FURC_RUMOUR_TT), 			
	[FURC_LUXURY] 						= GetString(SI_FURC_LUXURY_TT), 			
	[FURC_OTHER] 						= GetString(SI_FURC_OTHER_TT), 			
}

FurnitureCatalogue.DropdownData = {
	ChoicesVersion	= {
		[1] = GetString(SI_FURC_FILTER_VERSION_OFF), 
		[2] = GetString(SI_FURC_FILTER_VERSION_HS	),
		[3] = GetString(SI_FURC_FILTER_VERSION_M	),
		[4] = GetString(SI_FURC_FILTER_VERSION_R	),
		[5] = GetString(SI_FURC_FILTER_VERSION_CC	),
		[6] = GetString(SI_FURC_FILTER_VERSION_DRAGON),
	},
	TooltipsVersion	= {
		[1] =  GetString(SI_FURC_FILTER_VERSION_OFF_TT), 
		[2] =  GetString(SI_FURC_FILTER_VERSION_HS_TT),
		[3] =  GetString(SI_FURC_FILTER_VERSION_M_TT),
		[4] =  GetString(SI_FURC_FILTER_VERSION_R_TT),
		[5] =  GetString(SI_FURC_FILTER_VERSION_CC_TT),
		[6] =  GetString(SI_FURC_FILTER_VERSION_DRAGON_TT),
	},
	ChoicesCharacter  = {
		[1]	= GetString(SI_FURC_FILTER_CHAR_OFF), 
	},
	TooltipsCharacter = {
		[1]	= GetString(SI_FURC_FILTER_CHAR_OFF_TT), 
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