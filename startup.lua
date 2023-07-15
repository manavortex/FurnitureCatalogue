FurnitureCatalogue = {}
FurnitureCatalogue.name = "FurnitureCatalogue"
FurnitureCatalogue.author = "manavortex"
FurnitureCatalogue.tag = "FurC"

FurnitureCatalogue.version = 4072000 -- will be AUTOREPLACED with AddonVersion
FurnitureCatalogue.CharacterName = nil
FurnitureCatalogue.settings = {}

FurC = FurnitureCatalogue

FurC.AchievementVendors = {}
FurC.LuxuryFurnisher = {}
FurC.Recipes = {}
FurC.Rolis = {}
FurC.Faustina = {}
FurC.RolisRecipes = {}
FurC.FaustinaRecipes = {}
FurC.Books = {}
FurC.EventItems = {}
FurC.PVP = {}
FurC.MiscItemSources = {}
FurC.RumourRecipes = {}

-- TODO: set up the filtering for FURC_RUMOUR and FURC_CROWN in submenus by origin
local defaults = {

  hideMats = true,
  dontScanTradingHouse = false,
  enableDebug = false,

  data = {},
  filterCraftingType = {},
  filterQuality = {},

  resetDropdownChoice = false,
  useTinyUi = true,
  useInventoryIcons = true,
  fontSize = 18,

  gui = {
    lastX = 100,
    lastY = 100,
    width = 650,
    height = 550,
  },

  dropdownDefaults = {
    Source = 1,
    Character = 1,
    Version = 1,
  },

  accountCharacters = {},

  -- tooltips
  disableTooltips = false,
  coloredTooltips = true,
  hideKnowledge = false,

  hideBooks = true,
  hideDoubtfuls = true,
  hideCrownstore = true,
  hideRumourEntry = false,
  hideCrownStoreEntry = false,
  wipeDatabase = false,

  hideUiButtons = {
    FURC_RUMOUR = false,
    FURC_CROWN = false,
  },
}

local sourceIndicesKeys = {}
local function getSourceIndicesKeys()
  sourceIndicesKeys[FURC_NONE] = "off"
  sourceIndicesKeys[FURC_FAVE] = "favorites"
  sourceIndicesKeys[FURC_CRAFTING] = "craft_all"
  sourceIndicesKeys[FURC_CRAFTING_KNOWN] = "craft_known"
  sourceIndicesKeys[FURC_CRAFTING_UNKNOWN] = "craft_unknown"
  sourceIndicesKeys[FURC_VENDOR] = "purch_gold"
  sourceIndicesKeys[FURC_PVP] = "purch_ap"
  sourceIndicesKeys[FURC_CROWN] = "crownstore"
  sourceIndicesKeys[FURC_RUMOUR] = "rumour"
  sourceIndicesKeys[FURC_LUXURY] = "luxury"
  sourceIndicesKeys[FURC_OTHER] = "other"
  sourceIndicesKeys[FURC_WRIT_VENDOR] = "writ_vendor"

  return sourceIndicesKeys
end
FurC.GetSourceIndicesKeys = getSourceIndicesKeys

local choicesSource = {}
local function getChoicesSource()
  choicesSource[FURC_NONE] = GetString(SI_FURC_NONE)
  choicesSource[FURC_FAVE] = GetString(SI_FURC_FAVE)
  choicesSource[FURC_CRAFTING] = GetString(SI_FURC_CRAFTING)
  choicesSource[FURC_CRAFTING_KNOWN] = GetString(SI_FURC_CRAFTING_KNOWN)
  choicesSource[FURC_CRAFTING_UNKNOWN] = GetString(SI_FURC_CRAFTING_UNKNOWN)
  choicesSource[FURC_VENDOR] = GetString(SI_FURC_VENDOR)
  choicesSource[FURC_PVP] = GetString(SI_FURC_PVP)
  choicesSource[FURC_WRIT_VENDOR] = GetString(SI_FURC_STRING_WRIT_VENDOR)
  choicesSource[FURC_CROWN] = GetString(SI_FURC_CROWN)
  choicesSource[FURC_RUMOUR] = GetString(SI_FURC_RUMOUR)
  choicesSource[FURC_LUXURY] = GetString(SI_FURC_LUXURY)
  choicesSource[FURC_OTHER] = GetString(SI_FURC_OTHER)

  return choicesSource
end
FurC.GetChoicesSource = getChoicesSource

local tooltipsSource = {}
local function getTooltipsSource()
  tooltipsSource[FURC_NONE] = GetString(SI_FURC_NONE_TT)
  tooltipsSource[FURC_FAVE] = GetString(SI_FURC_FAVE_TT)
  tooltipsSource[FURC_CRAFTING] = GetString(SI_FURC_CRAFTING_TT)
  tooltipsSource[FURC_CRAFTING_KNOWN] = GetString(SI_FURC_CRAFTING_KNOWN_TT)
  tooltipsSource[FURC_CRAFTING_UNKNOWN] = GetString(SI_FURC_CRAFTING_UNKNOWN_TT)
  tooltipsSource[FURC_VENDOR] = GetString(SI_FURC_VENDOR_TT)
  tooltipsSource[FURC_PVP] = GetString(SI_FURC_PVP_TT)
  tooltipsSource[FURC_CROWN] = GetString(SI_FURC_CROWN_TT)
  tooltipsSource[FURC_WRIT_VENDOR] = GetString(SI_FURC_STRING_WRIT_VENDOR_TT)
  tooltipsSource[FURC_RUMOUR] = GetString(SI_FURC_RUMOUR_TT)
  tooltipsSource[FURC_LUXURY] = GetString(SI_FURC_LUXURY_TT)
  tooltipsSource[FURC_OTHER] = GetString(SI_FURC_OTHER_TT)

  return tooltipsSource
end
FurC.GetTooltipsSource = getTooltipsSource

-- [UPGRADING GAME VERSIONS, PTS compatibility]
FurC.DropdownData = {
  ChoicesVersion = {
    [FURC_NONE] = GetString(SI_FURC_FILTER_VERSION_OFF),
    [FURC_HOMESTEAD] = GetString(SI_FURC_FILTER_VERSION_HS),
    [FURC_MORROWIND] = GetString(SI_FURC_FILTER_VERSION_M),
    [FURC_REACH] = GetString(SI_FURC_FILTER_VERSION_R),
    [FURC_CLOCKWORK] = GetString(SI_FURC_FILTER_VERSION_CC),
    [FURC_DRAGONS] = GetString(SI_FURC_FILTER_VERSION_DRAGON),
    [FURC_ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER),
    [FURC_WEREWOLF] = GetString(SI_FURC_FILTER_VERSION_SLAVES),
    [FURC_SLAVES] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF),
    [FURC_WOTL] = GetString(SI_FURC_FILTER_VERSION_WOTL),
    [FURC_KITTY] = GetString(SI_FURC_FILTER_VERSION_KITTY),
    [FURC_SCALES] = GetString(SI_FURC_FILTER_VERSION_SCALES),
    [FURC_DRAGON2] = GetString(SI_FURC_FILTER_VERSION_DRAGON2),
    [FURC_HARROW] = GetString(SI_FURC_FILTER_VERSION_HARROW),
    [FURC_SKYRIM] = GetString(SI_FURC_FILTER_VERSION_SKYRIM),
    [FURC_STONET] = GetString(SI_FURC_FILTER_VERSION_STONET),
    [FURC_MARKAT] = GetString(SI_FURC_FILTER_VERSION_MARKAT),
    [FURC_FLAMES] = GetString(SI_FURC_FILTER_VERSION_FLAMES),
    [FURC_BLACKW] = GetString(SI_FURC_FILTER_VERSION_BLACKW),
    [FURC_DEADL] = GetString(SI_FURC_FILTER_VERSION_DEADL),
    [FURC_TIDES] = GetString(SI_FURC_FILTER_VERSION_TIDES),
    [FURC_BRETON] = GetString(SI_FURC_FILTER_VERSION_BRETON),
    [FURC_DEPTHS] = GetString(SI_FURC_FILTER_VERSION_DEPTHS),
    [FURC_DRUID] = GetString(SI_FURC_FILTER_VERSION_DRUID),
    [FURC_SCRIBE] = GetString(SI_FURC_FILTER_VERSION_SCRIBE),
    [FURC_NECROM] = GetString(SI_FURC_FILTER_VERSION_NECROM),
  },

  TooltipsVersion = {
    [FURC_NONE] = GetString(SI_FURC_FILTER_VERSION_OFF_TT),
    [FURC_HOMESTEAD] = GetString(SI_FURC_FILTER_VERSION_HS_TT),
    [FURC_MORROWIND] = GetString(SI_FURC_FILTER_VERSION_M_TT),
    [FURC_REACH] = GetString(SI_FURC_FILTER_VERSION_R_TT),
    [FURC_CLOCKWORK] = GetString(SI_FURC_FILTER_VERSION_CC_TT),
    [FURC_DRAGONS] = GetString(SI_FURC_FILTER_VERSION_DRAGON_TT),
    [FURC_ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER_TT),
    [FURC_WEREWOLF] = GetString(SI_FURC_FILTER_VERSION_SLAVES_TT),
    [FURC_SLAVES] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF_TT),
    [FURC_WOTL] = GetString(SI_FURC_FILTER_VERSION_WOTL_TT),
    [FURC_KITTY] = GetString(SI_FURC_FILTER_VERSION_KITTY_TT),
    [FURC_SCALES] = GetString(SI_FURC_FILTER_VERSION_SCALES_TT),
    [FURC_DRAGON2] = GetString(SI_FURC_FILTER_VERSION_DRAGON2_TT),
    [FURC_HARROW] = GetString(SI_FURC_FILTER_VERSION_HARROW_TT),
    [FURC_SKYRIM] = GetString(SI_FURC_FILTER_VERSION_SKYRIM_TT),
    [FURC_STONET] = GetString(SI_FURC_FILTER_VERSION_STONET_TT),
    [FURC_MARKAT] = GetString(SI_FURC_FILTER_VERSION_MARKAT_TT),
    [FURC_FLAMES] = GetString(SI_FURC_FILTER_VERSION_FLAMES_TT),
    [FURC_BLACKW] = GetString(SI_FURC_FILTER_VERSION_BLACKW_TT),
    [FURC_DEADL] = GetString(SI_FURC_FILTER_VERSION_DEADL_TT),
    [FURC_TIDES] = GetString(SI_FURC_FILTER_VERSION_TIDES_TT),
    [FURC_BRETON] = GetString(SI_FURC_FILTER_VERSION_BRETON_TT),
    [FURC_DEPTHS] = GetString(SI_FURC_FILTER_VERSION_DEPTHS_TT),
    [FURC_DRUID] = GetString(SI_FURC_FILTER_VERSION_DRUID_TT),
    [FURC_SCRIBE] = GetString(SI_FURC_FILTER_VERSION_SCRIBE_TT),
    [FURC_NECROM] = GetString(SI_FURC_FILTER_VERSION_NECROM_TT),
  },

  ChoicesCharacter = {
    [1] = GetString(SI_FURC_FILTER_CHAR_OFF),
  },
  TooltipsCharacter = {
    [1] = GetString(SI_FURC_FILTER_CHAR_OFF_TT),
  },

  -- will be set in setupSourceDropdown
  ChoicesSource = {},
  TooltipsSource = {},
}

function FurC.UpdateDropdowns()
  FurC.DropdownData.ChoicesSource = FurC.GetChoicesSource()
  FurC.DropdownData.TooltipsSource = FurC.GetTooltipsSource()
end

local function setupSourceDropdown()
  FurC.UpdateDropdowns()
  FurC.SourceIndices = getSourceIndicesKeys()
end

local logger
--- Gets the current logger or creates it if it doesn't exist yet
--- @param forceCreate boolean Force (re)creation of logger
--- @return table logger instance
function FurC.getOrCreateLogger(forceCreate)
  if not forceCreate and logger then
    return logger
  end -- return existing reference

  if not FurC.settings.enableDebug or not LibDebugLogger then
    -- Do not log at all, if not in debug mode or no log lib available
    local function ignore(...) end -- black hole for most property calls, like logger:Debug
    local function info(self, ...)
      local prefix = string.format("[%s]: ", FurC.tag)
      if tostring(...):find("%%") then
        d(prefix .. string.format(...))
      else
        d(prefix .. tostring(...))
      end
    end
    logger = {}
    logger.Verbose = ignore
    logger.Debug = ignore
    logger.Info = info
    logger.Warn = ignore
    logger.Error = ignore
    logger.Log = ignore
    return logger
  else
    -- use logger from library
    logger = LibDebugLogger(FurC.tag)
    return logger
  end
end

-- initialization stuff
function FurnitureCatalogue_Initialize(eventCode, addOnName)
  if addOnName ~= FurC.name then
    return
  end

  FurC.settings = ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Settings", 2, nil, defaults)
  -- setup the "source" dropdown for the menu
  setupSourceDropdown()

  FurC.CreateSettings(FurC.settings, defaults)
  FurC.Logger = FurC.getOrCreateLogger(true)
  FurC.Logger:Debug("Initialising...")

  FurC.CharacterName = zo_strformat(GetUnitName("player"))

  FurC.RegisterEvents()

  FurC.InitGui()

  FurC.CreateTooltips()
  FurC.InitRightclickMenu()

  FurC.SetupInventoryRecipeIcons()

  local scanFiles = false
  if FurC.settings.version < FurC.version then
    FurC.settings.version = FurC.version
    scanFiles = true
  end

  FurC.ScanRecipes(scanFiles, not FurC.GetSkipInitialScan())
  FurC.settings.databaseVersion = FurC.version
  SLASH_COMMANDS["/fur"] = FurnitureCatalogue_Toggle

  FurC.SetFilter(true)

  EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED)
  FurC.Logger:Debug("Initialisation complete")
end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle Furniture Catalogue window")
ZO_CreateStringId(
  "SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE_RECIPE",
  "Toggle Furniture Catalogue blueprint on tooltip"
)
EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue", EVENT_ADD_ON_LOADED, FurnitureCatalogue_Initialize)
