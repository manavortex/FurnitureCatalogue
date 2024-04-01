FurC = FurC or {}

local this = FurC
this.name = "FurnitureCatalogue"
this.author = "manavortex"
this.tag = "FurC"

this.version = 4080001 -- will be AUTOREPLACED with AddonVersion
this.CharacterName = nil
this.website = "https://www.esoui.com/downloads/fileinfo.php?id=1617"
this.settings = {}

local src = this.Constants.ItemSources
local ver = this.Constants.Versioning

this.AchievementVendors = {}
this.LuxuryFurnisher = {}
this.Recipes = {}
this.Rolis = {}
this.Faustina = {}
this.RolisRecipes = {}
this.FaustinaRecipes = {}
this.Books = {}
this.EventItems = {}
this.PVP = {}
this.MiscItemSources = {}
this.RumourRecipes = {}

this.ItemLinkColours = {
  Vendor = "D68957",
  Gold = "E5dA40",
  Voucher = "25C31E",
  AP = "5EA4FF",
  TelVar = "82BCFF",
}

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
  sourceIndicesKeys[src.NONE] = "off"
  sourceIndicesKeys[src.FAVE] = "favorites"
  sourceIndicesKeys[src.CRAFTING] = "craft_all"
  sourceIndicesKeys[src.CRAFTING_KNOWN] = "craft_known"
  sourceIndicesKeys[src.CRAFTING_UNKNOWN] = "craft_unknown"
  sourceIndicesKeys[src.VENDOR] = "purch_gold"
  sourceIndicesKeys[src.PVP] = "purch_ap"
  sourceIndicesKeys[src.WRIT_VENDOR] = "writ_vendor"
  sourceIndicesKeys[src.CROWN] = "crownstore"
  sourceIndicesKeys[src.RUMOUR] = "rumour"
  sourceIndicesKeys[src.LUXURY] = "luxury"
  sourceIndicesKeys[src.OTHER] = "other"
  --sourceIndicesKeys[src.ROLIS]            = "ROLIS"
  --sourceIndicesKeys[src.DROP]             = "DROP"
  --sourceIndicesKeys[src.JUSTICE]          = "JUSTICE"
  --sourceIndicesKeys[src.FISHING]          = "FISHING"
  --sourceIndicesKeys[src.GUILDSTORE]       = "GUILDSTORE"
  --sourceIndicesKeys[src.FESTIVAL_DROP]    = "FESTIVAL_DROP"

  return sourceIndicesKeys
end
this.GetSourceIndicesKeys = getSourceIndicesKeys

local choicesSource = {}
local function getChoicesSource()
  choicesSource[src.NONE] = GetString(SI_FURC_NONE)
  choicesSource[src.FAVE] = GetString(SI_FURC_FAVE)
  choicesSource[src.CRAFTING] = GetString(SI_FURC_CRAFTING)
  choicesSource[src.CRAFTING_KNOWN] = GetString(SI_FURC_CRAFTING_KNOWN)
  choicesSource[src.CRAFTING_UNKNOWN] = GetString(SI_FURC_CRAFTING_UNKNOWN)
  choicesSource[src.VENDOR] = GetString(SI_FURC_VENDOR)
  choicesSource[src.PVP] = GetString(SI_FURC_PVP)
  choicesSource[src.WRIT_VENDOR] = GetString(SI_FURC_STRING_WRIT_VENDOR)
  choicesSource[src.CROWN] = GetString(SI_FURC_CROWN)
  choicesSource[src.RUMOUR] = GetString(SI_FURC_RUMOUR)
  choicesSource[src.LUXURY] = GetString(SI_FURC_LUXURY)
  choicesSource[src.OTHER] = GetString(SI_FURC_OTHER)
  --choicesSource[src.ROLIS]            = "ROLIS"
  --choicesSource[src.DROP]             = "DROP"
  --choicesSource[src.JUSTICE]          = "JUSTICE"
  --choicesSource[src.FISHING]          = "FISHING"
  --choicesSource[src.GUILDSTORE]       = "GUILDSTORE"
  --choicesSource[src.FESTIVAL_DROP]    = "FESTIVAL_DROP"

  return choicesSource
end
this.GetChoicesSource = getChoicesSource

local tooltipsSource = {}
local function getTooltipsSource()
  tooltipsSource[src.NONE] = GetString(SI_FURC_NONE_TT)
  tooltipsSource[src.FAVE] = GetString(SI_FURC_FAVE_TT)
  tooltipsSource[src.CRAFTING] = GetString(SI_FURC_CRAFTING_TT)
  tooltipsSource[src.CRAFTING_KNOWN] = GetString(SI_FURC_CRAFTING_KNOWN_TT)
  tooltipsSource[src.CRAFTING_UNKNOWN] = GetString(SI_FURC_CRAFTING_UNKNOWN_TT)
  tooltipsSource[src.VENDOR] = GetString(SI_FURC_VENDOR_TT)
  tooltipsSource[src.PVP] = GetString(SI_FURC_PVP_TT)
  tooltipsSource[src.CROWN] = GetString(SI_FURC_CROWN_TT)
  tooltipsSource[src.WRIT_VENDOR] = GetString(SI_FURC_STRING_WRIT_VENDOR_TT)
  tooltipsSource[src.RUMOUR] = GetString(SI_FURC_RUMOUR_TT)
  tooltipsSource[src.LUXURY] = GetString(SI_FURC_LUXURY_TT)
  tooltipsSource[src.OTHER] = GetString(SI_FURC_OTHER_TT)
  --tooltipsSource[src.ROLIS]            = "ROLIS"
  --tooltipsSource[src.DROP]             = "DROP"
  --tooltipsSource[src.JUSTICE]          = "JUSTICE"
  --tooltipsSource[src.FISHING]          = "FISHING"
  --tooltipsSource[src.GUILDSTORE]       = "GUILDSTORE"
  --tooltipsSource[src.FESTIVAL_DROP]    = "FESTIVAL_DROP"

  return tooltipsSource
end
this.GetTooltipsSource = getTooltipsSource

-- [UPGRADING GAME VERSIONS, PTS compatibility]
this.DropdownData = {
  ChoicesVersion = {
    [ver.NONE] = GetString(SI_FURC_FILTER_VERSION_OFF),
    [ver.HOMESTEAD] = GetString(SI_FURC_FILTER_VERSION_HS),
    [ver.MORROWIND] = GetString(SI_FURC_FILTER_VERSION_M),
    [ver.REACH] = GetString(SI_FURC_FILTER_VERSION_R),
    [ver.CLOCKWORK] = GetString(SI_FURC_FILTER_VERSION_CC),
    [ver.DRAGONS] = GetString(SI_FURC_FILTER_VERSION_DRAGON),
    [ver.ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER),
    [ver.SLAVES] = GetString(SI_FURC_FILTER_VERSION_SLAVES),
    [ver.WEREWOLF] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF),
    [ver.WOTL] = GetString(SI_FURC_FILTER_VERSION_WOTL),
    [ver.KITTY] = GetString(SI_FURC_FILTER_VERSION_KITTY),
    [ver.SCALES] = GetString(SI_FURC_FILTER_VERSION_SCALES),
    [ver.DRAGON2] = GetString(SI_FURC_FILTER_VERSION_DRAGON2),
    [ver.HARROW] = GetString(SI_FURC_FILTER_VERSION_HARROW),
    [ver.SKYRIM] = GetString(SI_FURC_FILTER_VERSION_SKYRIM),
    [ver.STONET] = GetString(SI_FURC_FILTER_VERSION_STONET),
    [ver.MARKAT] = GetString(SI_FURC_FILTER_VERSION_MARKAT),
    [ver.FLAMES] = GetString(SI_FURC_FILTER_VERSION_FLAMES),
    [ver.BLACKW] = GetString(SI_FURC_FILTER_VERSION_BLACKW),
    [ver.DEADL] = GetString(SI_FURC_FILTER_VERSION_DEADL),
    [ver.TIDES] = GetString(SI_FURC_FILTER_VERSION_TIDES),
    [ver.BRETON] = GetString(SI_FURC_FILTER_VERSION_BRETON),
    [ver.DEPTHS] = GetString(SI_FURC_FILTER_VERSION_DEPTHS),
    [ver.DRUID] = GetString(SI_FURC_FILTER_VERSION_DRUID),
    [ver.SCRIBE] = GetString(SI_FURC_FILTER_VERSION_SCRIBE),
    [ver.NECROM] = GetString(SI_FURC_FILTER_VERSION_NECROM),
    [ver.BASED] = GetString(SI_FURC_FILTER_VERSION_BASED),
    [ver.ENDLESS] = GetString(SI_FURC_FILTER_VERSION_ENDLESS),
    [ver.SCIONS] = GetString(SI_FURC_FILTER_VERSION_SCIONS),
  },

  TooltipsVersion = {
    [ver.NONE] = GetString(SI_FURC_FILTER_VERSION_OFF_TT),
    [ver.HOMESTEAD] = GetString(SI_FURC_FILTER_VERSION_HS_TT),
    [ver.MORROWIND] = GetString(SI_FURC_FILTER_VERSION_M_TT),
    [ver.REACH] = GetString(SI_FURC_FILTER_VERSION_R_TT),
    [ver.CLOCKWORK] = GetString(SI_FURC_FILTER_VERSION_CC_TT),
    [ver.DRAGONS] = GetString(SI_FURC_FILTER_VERSION_DRAGON_TT),
    [ver.ALTMER] = GetString(SI_FURC_FILTER_VERSION_ALTMER_TT),
    [ver.SLAVES] = GetString(SI_FURC_FILTER_VERSION_SLAVES_TT),
    [ver.WEREWOLF] = GetString(SI_FURC_FILTER_VERSION_WEREWOLF_TT),
    [ver.WOTL] = GetString(SI_FURC_FILTER_VERSION_WOTL_TT),
    [ver.KITTY] = GetString(SI_FURC_FILTER_VERSION_KITTY_TT),
    [ver.SCALES] = GetString(SI_FURC_FILTER_VERSION_SCALES_TT),
    [ver.DRAGON2] = GetString(SI_FURC_FILTER_VERSION_DRAGON2_TT),
    [ver.HARROW] = GetString(SI_FURC_FILTER_VERSION_HARROW_TT),
    [ver.SKYRIM] = GetString(SI_FURC_FILTER_VERSION_SKYRIM_TT),
    [ver.STONET] = GetString(SI_FURC_FILTER_VERSION_STONET_TT),
    [ver.MARKAT] = GetString(SI_FURC_FILTER_VERSION_MARKAT_TT),
    [ver.FLAMES] = GetString(SI_FURC_FILTER_VERSION_FLAMES_TT),
    [ver.BLACKW] = GetString(SI_FURC_FILTER_VERSION_BLACKW_TT),
    [ver.DEADL] = GetString(SI_FURC_FILTER_VERSION_DEADL_TT),
    [ver.TIDES] = GetString(SI_FURC_FILTER_VERSION_TIDES_TT),
    [ver.BRETON] = GetString(SI_FURC_FILTER_VERSION_BRETON_TT),
    [ver.DEPTHS] = GetString(SI_FURC_FILTER_VERSION_DEPTHS_TT),
    [ver.DRUID] = GetString(SI_FURC_FILTER_VERSION_DRUID_TT),
    [ver.SCRIBE] = GetString(SI_FURC_FILTER_VERSION_SCRIBE_TT),
    [ver.NECROM] = GetString(SI_FURC_FILTER_VERSION_NECROM_TT),
    [ver.BASED] = GetString(SI_FURC_FILTER_VERSION_BASED_TT),
    [ver.ENDLESS] = GetString(SI_FURC_FILTER_VERSION_ENDLESS_TT),
    [ver.SCIONS] = GetString(SI_FURC_FILTER_VERSION_SCIONS_TT),
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

function this.UpdateDropdowns()
  this.DropdownData.ChoicesSource = this.GetChoicesSource()
  this.DropdownData.TooltipsSource = this.GetTooltipsSource()
end

local function setupSourceDropdown()
  this.UpdateDropdowns()
  this.SourceIndices = getSourceIndicesKeys()
end

local logger
--- Gets the current logger or creates it if it doesn't exist yet
--- @return Logger logger instance
function this.getOrCreateLogger()
  if logger then
    return logger
  end -- return existing reference

  if not LibDebugLogger then
    local function ignore(...) end -- black hole for most property calls, like logger:Debug
    local function info(self, ...)
      local prefix = string.format("[%s]: ", this.tag)
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
    logger.LOG_LEVEL_VERBOSE = "V"
    logger.LOG_LEVEL_DEBUG = "D"
    logger.LOG_LEVEL_INFO = "I"
    logger.LOG_LEVEL_WARNING = "W"
    logger.LOG_LEVEL_ERROR = "E"
    logger.SetMinLevelOverride = ignore

    return logger
  end

  -- use logger from library
  logger = LibDebugLogger(this.tag)
  logger.LOG_LEVEL_VERBOSE = LibDebugLogger.LOG_LEVEL_VERBOSE
  logger.LOG_LEVEL_DEBUG = LibDebugLogger.LOG_LEVEL_DEBUG
  logger.LOG_LEVEL_INFO = LibDebugLogger.LOG_LEVEL_INFO
  logger.LOG_LEVEL_WARNING = LibDebugLogger.LOG_LEVEL_WARNING
  logger.LOG_LEVEL_ERROR = LibDebugLogger.LOG_LEVEL_ERROR

  -- set initial log level
  if this.settings.enableDebug then
    logger:SetMinLevelOverride(logger.LOG_LEVEL_DEBUG)
  else
    logger:SetMinLevelOverride(logger.LOG_LEVEL_INFO)
  end

  return logger
end

-- initialization stuff
local function initialise(eventCode, addOnName)
  if addOnName ~= this.name then
    return
  end

  this.settings = ZO_SavedVars:NewAccountWide(this.name .. "_Settings", 2, nil, defaults)
  -- setup the "source" dropdown for the menu
  setupSourceDropdown()

  this.CreateSettings(this.settings, defaults)
  this.Logger = this.getOrCreateLogger()
  this.Logger:Debug("Initialising..." .. eventCode)

  this.CharacterName = zo_strformat(GetUnitName("player"))

  this.InitGui()

  this.CreateTooltips()
  this.InitRightclickMenu()

  this.SetupInventoryRecipeIcons()

  local scanFiles = false
  if this.settings.version < this.version then
    this.settings.version = this.version
    scanFiles = true
  end

  this.ScanRecipes(scanFiles, not this.GetSkipInitialScan())
  this.settings.databaseVersion = this.version
  SLASH_COMMANDS["/fur"] = FurnitureCatalogue_Toggle

  this.SetFilter(true)

  EVENT_MANAGER:UnregisterForEvent(this.name, EVENT_ADD_ON_LOADED)
  this.Logger:Debug("Initialisation complete")
end

ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE", "Toggle main window")
ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_FURNITURE_CATALOGUE_RECIPE", "Toggle Blueprint on tooltip")
EVENT_MANAGER:RegisterForEvent(this.name, EVENT_ADD_ON_LOADED, initialise)
