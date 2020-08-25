FurnitureCatalogue                = {}
FurnitureCatalogue.name           = "FurnitureCatalogue"
FurnitureCatalogue.author         = "manavortex"
FurnitureCatalogue.version        = 4.1111
FurnitureCatalogue.CharacterName  = nil
FurnitureCatalogue.settings       = {}

FurC                               = FurnitureCatalogue

FurC.AchievementVendors           = {}
FurC.LuxuryFurnisher              = {}
FurC.Recipes                      = {}
FurC.Rolis                        = {}
FurC.Faustina                     = {}
FurC.RolisRecipes                 = {}
FurC.FaustinaRecipes              = {}
FurC.Books                        = {}
FurC.EventItems                   = {}
FurC.PVP                          = {}
FurC.MiscItemSources              = {}
FurC.RumourRecipes                = {}

-- TODO: set up the filtering for FURC_RUMOUR and FURC_CROWN in submenus by origin
local defaults             = {
	
	hideMats              = true,
	dontScanTradingHouse  = false,
	enableDebug           = false,
	
	data                 = {},
	filterCraftingType   = {},
	filterQuality        = {},
	
	resetDropdownChoice  = false,
	useTinyUi            = false,
	useInventoryIcons    = true,
	fontSize             = 18,
	
	gui                 = {
		lastX             = 100,
		lastY             = 100,
		width             = 650,
		height            = 550,
	},

	dropdownDefaults    = {
		Source            = 1,
		Character         = 1,
		Version           = 1,
	},
	
	accountCharacters    = {},
	
	-- tooltips
	disableTooltips      = false,
	coloredTooltips      = true,
	hideKnowledge        = false,
	
	hideBooks            = true,
	hideDoubtfuls        = true,
	hideCrownstore       = true,
	hideRumourEntry      = false,
	hideCrownStoreEntry  = false,
	wipeDatabase         = false,
	startupSilently      = true,
	
	hideUiButtons = {
		FURC_RUMOUR = false,
		FURC_CROWN  = false,
	}
	
}


local sourceIndicesKeys = {}
local function getSourceIndicesKeys()
	sourceIndicesKeys[FURC_NONE]                = "off"
	sourceIndicesKeys[FURC_FAVE]                = "favorites"
	sourceIndicesKeys[FURC_CRAFTING]            = "craft_all"
	sourceIndicesKeys[FURC_CRAFTING_KNOWN]      = "craft_known"
	sourceIndicesKeys[FURC_CRAFTING_UNKNOWN]    = "craft_unknown"
	sourceIndicesKeys[FURC_VENDOR]              = "purch_gold"
	sourceIndicesKeys[FURC_PVP]                 = "purch_ap"
	sourceIndicesKeys[FURC_CROWN]               = "crownstore"
	sourceIndicesKeys[FURC_RUMOUR]              = "rumour"
	sourceIndicesKeys[FURC_LUXURY]              = "luxury"
	sourceIndicesKeys[FURC_OTHER]               = "other"
	sourceIndicesKeys[FURC_WRIT_VENDOR]         = "writ_vendor"
	return sourceIndicesKeys
end
FurC.GetSourceIndicesKeys = getSourceIndicesKeys

local choicesSource = {}
local function getChoicesSource()
	choicesSource[FURC_NONE]              = GetString(SI_FURC_NONE)
	choicesSource[FURC_FAVE]              = GetString(SI_FURC_FAVE)
	choicesSource[FURC_CRAFTING]          = GetString(SI_FURC_CRAFTING)
	choicesSource[FURC_CRAFTING_KNOWN]    = GetString(SI_FURC_CRAFTING_KNOWN)
	choicesSource[FURC_CRAFTING_UNKNOWN]  = GetString(SI_FURC_CRAFTING_UNKNOWN)
	choicesSource[FURC_VENDOR]            = GetString(SI_FURC_VENDOR)
	choicesSource[FURC_PVP]               = GetString(SI_FURC_PVP)
	choicesSource[FURC_WRIT_VENDOR]       = GetString(SI_FURC_STRING_WRIT_VENDOR)
	choicesSource[FURC_CROWN]             = GetString(SI_FURC_CROWN)
	choicesSource[FURC_RUMOUR]            = GetString(SI_FURC_RUMOUR)
	choicesSource[FURC_LUXURY]            = GetString(SI_FURC_LUXURY)
	choicesSource[FURC_OTHER]             = GetString(SI_FURC_OTHER)
	
	return choicesSource
end
FurC.GetChoicesSource = getChoicesSource

local tooltipsSource = {}
local function getTooltipsSource()
	tooltipsSource[FURC_NONE]             = GetString(SI_FURC_NONE_TT)
	tooltipsSource[FURC_FAVE]             = GetString(SI_FURC_FAVE_TT)
	tooltipsSource[FURC_CRAFTING]         = GetString(SI_FURC_CRAFTING_TT)
	tooltipsSource[FURC_CRAFTING_KNOWN]   = GetString(SI_FURC_CRAFTING_KNOWN_TT)
	tooltipsSource[FURC_CRAFTING_UNKNOWN] = GetString(SI_FURC_CRAFTING_UNKNOWN_TT)
	tooltipsSource[FURC_VENDOR]           = GetString(SI_FURC_VENDOR_TT)
	tooltipsSource[FURC_PVP]              = GetString(SI_FURC_PVP_TT)
	tooltipsSource[FURC_CROWN]            = GetString(SI_FURC_CROWN_TT)
	tooltipsSource[FURC_WRIT_VENDOR]      = GetString(SI_FURC_STRING_WRIT_VENDOR_TT)
	tooltipsSource[FURC_RUMOUR]           = GetString(SI_FURC_RUMOUR_TT)
	tooltipsSource[FURC_LUXURY]           = GetString(SI_FURC_LUXURY_TT)
	tooltipsSource[FURC_OTHER]            = GetString(SI_FURC_OTHER_TT)
	
	return tooltipsSource
end
FurC.GetTooltipsSource = getTooltipsSource

-- [UPGRADING GAME VERSIONS, PTS compatibility]
FurC.DropdownData = {
	ChoicesVersion  = {
		[1]  = GetString(SI_FURC_FILTER_VERSION_OFF),
		[2]  = GetString(SI_FURC_FILTER_VERSION_HS  ),
		[3]  = GetString(SI_FURC_FILTER_VERSION_M  ),
		[4]  = GetString(SI_FURC_FILTER_VERSION_R  ),
		[5]  = GetString(SI_FURC_FILTER_VERSION_CC  ),
		[6]  = GetString(SI_FURC_FILTER_VERSION_DRAGON),
		[7]  = GetString(SI_FURC_FILTER_VERSION_ALTMER),
		[8]  = GetString(SI_FURC_FILTER_VERSION_SLAVES),
		[9]  = GetString(SI_FURC_FILTER_VERSION_WEREWOLF),
		[10] = GetString(SI_FURC_FILTER_VERSION_WOTL),
		[11] = GetString(SI_FURC_FILTER_VERSION_KITTY),
		[12] = GetString(SI_FURC_FILTER_VERSION_SCALES),
		[13] = GetString(SI_FURC_FILTER_VERSION_DRAGON2),
		[14] = GetString(SI_FURC_FILTER_VERSION_HARROW),
		[15] = GetString(SI_FURC_FILTER_VERSION_SKYRIM),
		[16] = GetString(SI_FURC_FILTER_VERSION_STONET),
	},
	
	TooltipsVersion  = {
		[1]  =  GetString(SI_FURC_FILTER_VERSION_OFF_TT),
		[2]  =  GetString(SI_FURC_FILTER_VERSION_HS_TT),
		[3]  =  GetString(SI_FURC_FILTER_VERSION_M_TT),
		[4]  =  GetString(SI_FURC_FILTER_VERSION_R_TT),
		[5]  =  GetString(SI_FURC_FILTER_VERSION_CC_TT),
		[6]  =  GetString(SI_FURC_FILTER_VERSION_DRAGON_TT),
		[7]  = GetString(SI_FURC_FILTER_VERSION_ALTMER_TT),
		[8]  = GetString(SI_FURC_FILTER_VERSION_SLAVES_TT),
		[9]  = GetString(SI_FURC_FILTER_VERSION_WEREWOLF_TT),
		[10] = GetString(SI_FURC_FILTER_VERSION_WOTL_TT),
		[11] = GetString(SI_FURC_FILTER_VERSION_KITTY_TT),
		[12] = GetString(SI_FURC_FILTER_VERSION_SCALES_TT),
		[13] = GetString(SI_FURC_FILTER_VERSION_DRAGON2_TT),
		[14] = GetString(SI_FURC_FILTER_VERSION_HARROW_TT),
		[15] = GetString(SI_FURC_FILTER_VERSION_SKYRIM_TT),
		[15] = GetString(SI_FURC_FILTER_VERSION_STONET_TT),
	},
	
	ChoicesCharacter  = {
		[1]  = GetString(SI_FURC_FILTER_CHAR_OFF),
	},
	TooltipsCharacter = {
		[1]  = GetString(SI_FURC_FILTER_CHAR_OFF_TT),
	},
	
	-- will be set in setupSourceDropdown
	ChoicesSource  = {},
	TooltipsSource   = {},
}

if GetAPIVersion() == 100032 then	
	FurC.DropdownData.TooltipsVersion[16] =  GetString(SI_FURC_FILTER_VERSION_STONET)
	FurC.DropdownData.TooltipsVersion[15] =  GetString(SI_FURC_FILTER_VERSION_STONET_TT)
end

function FurC.UpdateDropdowns()
	FurC.DropdownData.ChoicesSource  = FurC.GetChoicesSource()
	FurC.DropdownData.TooltipsSource = FurC.GetTooltipsSource()
end

local function setupSourceDropdown()
	FurC.UpdateDropdowns()
	sourceIndices = {}
	
	for idx, key in ipairs(getSourceIndicesKeys()) do
		sourceIndices[key] = idx
	end
	FurC.SourceIndices = sourceIndices
end

local TYPE_STRING = "string"
local logger = (LibDebugLogger and LibDebugLogger(FurC.name)) or nil
function FurC.DebugOut(...)
	if not FurC.settings.enableDebug then return end	
	if logger then
		return logger:Debug(...)
	end
	if (tostring(...):find("%%s")) then
		d(string.format(...))
	else
		d(...)
	end	
end
local p = FurC.DebugOut

function whoami()
	return FurC.CharacterName
end


-- initialization stuff
function FurnitureCatalogue_Initialize(eventCode, addOnName)
	if (addOnName ~= FurC.name) then return end
	
	FurC.settings   = ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Settings", 2, nil, defaults)
	
	-- setup the "source" dropdown for the menu
	setupSourceDropdown()

	FurC.CreateSettings(FurC.settings, defaults, FurnitureCatalogue)

	FurC.CharacterName = zo_strformat(GetUnitName('player'))

	FurC.RegisterEvents()

	FurC.InitGui()

	FurC.CreateTooltips()
	FurC.InitRightclickMenu()

	FurC.SetupInventoryRecipeIcons()

	local scanFiles = false
	if FurC.settings.version     < FurC.version then
		FurC.settings.version     = FurC.version
		scanFiles = true
	end

	FurC.ScanRecipes(scanFiles, not FurC.GetSkipInitialScan())
	FurC.settings.databaseVersion   = FurC.version
	SLASH_COMMANDS["/fur"]          = FurnitureCatalogue_Toggle

	FurC.SetFilter(true)

	EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)

end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE",         "Toggle Furniture Catalogue window")
ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE_RECIPE",  "Toggle Furniture Catalogue blueprint on tooltip")
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)

