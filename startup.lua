FurnitureCatalogue                = {}
FurnitureCatalogue.name           = "FurnitureCatalogue"
FurnitureCatalogue.author         = "manavortex"
FurnitureCatalogue.version        = 3.541111111
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
  choicesSource[FURC_NONE]            = GetString(SI_FURC_NONE)
  choicesSource[FURC_FAVE]             = GetString(SI_FURC_FAVE)
  choicesSource[FURC_CRAFTING]           = GetString(SI_FURC_CRAFTING)
  choicesSource[FURC_CRAFTING_KNOWN]         = GetString(SI_FURC_CRAFTING_KNOWN)
  choicesSource[FURC_CRAFTING_UNKNOWN]       = GetString(SI_FURC_CRAFTING_UNKNOWN)
  choicesSource[FURC_VENDOR]             = GetString(SI_FURC_VENDOR)
  choicesSource[FURC_PVP]             = GetString(SI_FURC_PVP)
  choicesSource[FURC_WRIT_VENDOR]         = GetString(SI_FURC_STRING_WRIT_VENDOR)
  choicesSource[FURC_CROWN]               = GetString(SI_FURC_CROWN)
  choicesSource[FURC_RUMOUR]               = GetString(SI_FURC_RUMOUR)
  choicesSource[FURC_LUXURY]               = GetString(SI_FURC_LUXURY)
  choicesSource[FURC_OTHER]                 = GetString(SI_FURC_OTHER)

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

FurnitureCatalogue.DropdownData = {
  ChoicesVersion  = {
    [1] = GetString(SI_FURC_FILTER_VERSION_OFF),
    [2] = GetString(SI_FURC_FILTER_VERSION_HS  ),
    [3] = GetString(SI_FURC_FILTER_VERSION_M  ),
    [4] = GetString(SI_FURC_FILTER_VERSION_R  ),
    [5] = GetString(SI_FURC_FILTER_VERSION_CC  ),
    [6] = GetString(SI_FURC_FILTER_VERSION_DRAGON),
    [7] = GetString(SI_FURC_FILTER_VERSION_ALTMER),
    [8] = GetString(SI_FURC_FILTER_VERSION_SLAVES),
    [9] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF),
    [10] = GetString(SI_FURC_FILTER_VERSION_WOTL),
    [11] = GetString(SI_FURC_FILTER_VERSION_KITTY),
    [12] = GetString(SI_FURC_FILTER_VERSION_SCALES),
    [13] = GetString(SI_FURC_FILTER_VERSION_DRAGON2),
  },
  TooltipsVersion  = {
    [1] =  GetString(SI_FURC_FILTER_VERSION_OFF_TT),
    [2] =  GetString(SI_FURC_FILTER_VERSION_HS_TT),
    [3] =  GetString(SI_FURC_FILTER_VERSION_M_TT),
    [4] =  GetString(SI_FURC_FILTER_VERSION_R_TT),
    [5] =  GetString(SI_FURC_FILTER_VERSION_CC_TT),
    [6] =  GetString(SI_FURC_FILTER_VERSION_DRAGON_TT),
    [7] = GetString(SI_FURC_FILTER_VERSION_ALTMER_TT),
    [8] = GetString(SI_FURC_FILTER_VERSION_SLAVES_TT),
    [9] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF_TT),
    [10] = GetString(SI_FURC_FILTER_VERSION_WOTL_TT),
    [11] = GetString(SI_FURC_FILTER_VERSION_KITTY_TT),
    [12] = GetString(SI_FURC_FILTER_VERSION_SCALES_TT),
    [12] = GetString(SI_FURC_FILTER_VERSION_DRAGON2_TT),
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

local logger = (LibDebugLogger and LibDebugLogger("MyAddon")) or nil
function FurC.DebugOut(...)
  if logger then 
    logger:Debug(...)  
  elseif FurC.settings.enableDebug then 
    zo_strformat(...) 
  end
end
local p = FurC.DebugOut 

function whoami()
  return FurnitureCatalogue.CharacterName
end


-- initialization stuff
function FurnitureCatalogue_Initialize(eventCode, addOnName)
  if (addOnName ~= FurnitureCatalogue.name) then return end

  FurnitureCatalogue.settings   = ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Settings", 2, nil, defaults)

  -- setup the "source" dropdown for the menu  
  setupSourceDropdown()

  FurnitureCatalogue.CreateSettings(FurnitureCatalogue.settings, defaults, FurnitureCatalogue)

  FurnitureCatalogue.CharacterName = zo_strformat(GetUnitName('player'))

  FurC.RegisterEvents()

  FurC.InitGui()

  FurnitureCatalogue.CreateTooltips()
  FurC.InitRightclickMenu()

  FurC.SetupInventoryRecipeIcons()

  local scanFiles = false
  if FurC.settings.version     < FurC.version then
      FurC.settings.version     = FurC.version
    scanFiles = true
  end

  FurnitureCatalogue.ScanRecipes(scanFiles, not FurC.GetSkipInitialScan())
  FurC.settings.databaseVersion   = FurC.version
  SLASH_COMMANDS["/fur"]          = FurnitureCatalogue_Toggle

  FurC.SetFilter(true)

  EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)

end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle Furniture Catalogue")
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)

