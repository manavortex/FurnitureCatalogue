FurnitureCatalogue 					= {}
FurnitureCatalogue.name				= "FurnitureCatalogue"
FurnitureCatalogue.author			= "manavortex"
FurnitureCatalogue.version          = "2.3.3"
FurnitureCatalogue.CharacterName	= nil
FurnitureCatalogue.settings			= {}	
	
FurC 								= FurnitureCatalogue
FurC.DevDebug						= false
FurC.AccountName					= GetDisplayName() 

FurC.AchievementVendors				= {}
FurC.LuxuryFurnisher				= {}
FurC.Recipes						= {}
FurC.Rolis							= {}
FurC.RollisRecipes					= {}
FurC.Books							= {}
FurC.EventItems						= {}
FurC.PVP							= {}
FurC.MiscItemSources                = {}
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
FURC_ALTMER						    = 7
			
FurC.version						= 2.2

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
	hideCrownStoreEntry				= false,
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
FURC_WRIT_VENDOR 		= FURC_DROP +1
FURC_JUSTICE 			= FURC_WRIT_VENDOR +1
FURC_FISHING 			= FURC_JUSTICE +1
FURC_GUILDSTORE 		= FURC_FISHING +1
FURC_FESTIVAL_DROP 		= FURC_GUILDSTORE +1
FURC_EMPTY_STRING 		= ""

local sourceIndicesKeys = {}
local function getSourceIndicesKeys()
	sourceIndicesKeys[FURC_NONE] 						= "off"
	sourceIndicesKeys[FURC_FAVE] 						= "favorites"
	sourceIndicesKeys[FURC_CRAFTING] 					= "craft_all"
	sourceIndicesKeys[FURC_CRAFTING_KNOWN] 				= "craft_known"
	sourceIndicesKeys[FURC_CRAFTING_UNKNOWN] 			= "craft_unknown"
	sourceIndicesKeys[FURC_VENDOR] 						= "purch_gold"
	sourceIndicesKeys[FURC_PVP] 						= "purch_ap"	
	sourceIndicesKeys[FURC_CROWN] 					    = "crownstore"	
    sourceIndicesKeys[FURC_RUMOUR] 					    = "rumour"		
    sourceIndicesKeys[FURC_LUXURY] 					    = "luxury"	
	sourceIndicesKeys[FURC_OTHER] 						= "other"	
	sourceIndicesKeys[FURC_WRIT_VENDOR] 				= "writ_vendor"	
	return sourceIndicesKeys
end
FurC.GetSourceIndicesKeys = getSourceIndicesKeys

local choicesSource = {}
local function getChoicesSource()
	choicesSource[FURC_NONE]						= GetString(SI_FURC_NONE)		
	choicesSource[FURC_FAVE] 						= GetString(SI_FURC_FAVE)		
	choicesSource[FURC_CRAFTING] 					= GetString(SI_FURC_CRAFTING)	
	choicesSource[FURC_CRAFTING_KNOWN] 				= GetString(SI_FURC_CRAFTING_KNOWN)	
	choicesSource[FURC_CRAFTING_UNKNOWN] 			= GetString(SI_FURC_CRAFTING_UNKNOWN)
	choicesSource[FURC_VENDOR] 						= GetString(SI_FURC_VENDOR)	
	choicesSource[FURC_PVP] 						= GetString(SI_FURC_PVP)
	choicesSource[FURC_WRIT_VENDOR] 				= GetString(SI_FURC_STRING_WRIT_VENDOR)
	choicesSource[FURC_CROWN] 					    = GetString(SI_FURC_CROWN)
	choicesSource[FURC_RUMOUR] 					    = GetString(SI_FURC_RUMOUR)	
    choicesSource[FURC_LUXURY] 					    = GetString(SI_FURC_LUXURY)
	choicesSource[FURC_OTHER] 				        = GetString(SI_FURC_OTHER)
	
	return choicesSource
end
FurC.GetChoicesSource = getChoicesSource

local tooltipsSource = {}
local function getTooltipsSource()
	tooltipsSource[FURC_NONE]						= GetString(SI_FURC_NONE_TT)		
	tooltipsSource[FURC_FAVE] 						= GetString(SI_FURC_FAVE_TT)		
	tooltipsSource[FURC_CRAFTING] 					= GetString(SI_FURC_CRAFTING_TT)	
	tooltipsSource[FURC_CRAFTING_KNOWN] 			= GetString(SI_FURC_CRAFTING_KNOWN_TT)	
	tooltipsSource[FURC_CRAFTING_UNKNOWN] 			= GetString(SI_FURC_CRAFTING_UNKNOWN_TT)
	tooltipsSource[FURC_VENDOR] 					= GetString(SI_FURC_VENDOR_TT)	
	tooltipsSource[FURC_PVP] 						= GetString(SI_FURC_PVP_TT)
    tooltipsSource[FURC_CROWN] 					    = GetString(SI_FURC_CROWN_TT)
	tooltipsSource[FURC_WRIT_VENDOR] 				= GetString(SI_FURC_STRING_WRIT_VENDOR_TT)
    tooltipsSource[FURC_RUMOUR] 				    = GetString(SI_FURC_RUMOUR_TT)
    tooltipsSource[FURC_LUXURY] 				    = GetString(SI_FURC_LUXURY_TT)
	tooltipsSource[FURC_OTHER] 				        = GetString(SI_FURC_OTHER_TT)
	
	return tooltipsSource
end

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
if GetAPIVersion() == 100023 then 
    FurnitureCatalogue.DropdownData.ChoicesVersion[FURC_ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER)
    FurnitureCatalogue.DropdownData.TooltipsVersion[FURC_ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER_TT)
end

local function updateDropdownData()
	FurnitureCatalogue.DropdownData.ChoicesSource  = getChoicesSource()
	FurnitureCatalogue.DropdownData.TooltipsSource = getTooltipsSource()
end
FurnitureCatalogue.updateDropdownData = updateDropdownData

local function setupSourceDropdown()
	updateDropdownData()   
	sourceIndices = {}

	for idx, key in ipairs(getSourceIndicesKeys()) do
		sourceIndices[key] = idx
	end
	FurC.SourceIndices = sourceIndices
end

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

local function p(...)
	FurC.DebugOut(...)
end

function whoami()
	return FurnitureCatalogue.CharacterName
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
	if (addOnName ~= FurnitureCatalogue.name) then return end
	
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
    FurC.SetHideRumourRecipesEntry(false)
    FurC.SetHideCrownStoreEntry(false)
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
    
    FurC.IsDebugging = GetWorldName() == "PTS" and GetUnitDisplayName("player") == "@manavortex"
    
	EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)
	
end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle Furniture Catalogue")
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)