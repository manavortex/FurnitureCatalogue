FurC = FurC or {}
FurC.Constants = {}

local idCounter = {}

---Generate consecutive ids for constants
---@param id_type string Type for which to generate an ID
---@return integer nextId Next ID for given type
local function getNextIdFor(id_type)
  idCounter[id_type] = (idCounter[id_type] or 0) + 1
  return idCounter[id_type]
end

-- constants for filtering

-- item sources
FurC.Constants.ItemSources = {
  NONE = getNextIdFor("ITEM_SOURCES"), -- 1
  FAVE = getNextIdFor("ITEM_SOURCES"), -- 2
  CRAFTING = getNextIdFor("ITEM_SOURCES"), -- 3
  CRAFTING_KNOWN = getNextIdFor("ITEM_SOURCES"), -- 4
  CRAFTING_UNKNOWN = getNextIdFor("ITEM_SOURCES"), -- 5
  VENDOR = getNextIdFor("ITEM_SOURCES"), -- 6
  PVP = getNextIdFor("ITEM_SOURCES"), -- 7
  WRIT_VENDOR = getNextIdFor("ITEM_SOURCES"), -- 8
  CROWN = getNextIdFor("ITEM_SOURCES"), -- 9
  RUMOUR = getNextIdFor("ITEM_SOURCES"), -- 10
  LUXURY = getNextIdFor("ITEM_SOURCES"), -- 11
  OTHER = getNextIdFor("ITEM_SOURCES"), -- 12
  ROLIS = getNextIdFor("ITEM_SOURCES"), -- 13
  DROP = getNextIdFor("ITEM_SOURCES"), -- 14
  JUSTICE = getNextIdFor("ITEM_SOURCES"), -- 15
  FISHING = getNextIdFor("ITEM_SOURCES"), -- 16
  GUILDSTORE = getNextIdFor("ITEM_SOURCES"), -- 17
  FESTIVAL_DROP = getNextIdFor("ITEM_SOURCES"), -- 18
}

-- versioning
FurC.Constants.Versioning = {
  NONE = getNextIdFor("VERSIONING"), -- 1 off
  HOMESTEAD = getNextIdFor("VERSIONING"), -- 2 Homestead
  MORROWIND = getNextIdFor("VERSIONING"), -- 3 Morrowind
  REACH = getNextIdFor("VERSIONING"), -- 4 Horns of the Reach
  CLOCKWORK = getNextIdFor("VERSIONING"), -- 5 Clockwork City
  DRAGONS = getNextIdFor("VERSIONING"), -- 6 Dragon Bones
  ALTMER = getNextIdFor("VERSIONING"), -- 7 Summerset
  SLAVES = getNextIdFor("VERSIONING"), -- 8 Murkmire
  WEREWOLF = getNextIdFor("VERSIONING"), -- 9 Wolfhunter
  WOTL = getNextIdFor("VERSIONING"), -- 10 Wrathstone
  KITTY = getNextIdFor("VERSIONING"), -- 11 Elsweyr
  SCALES = getNextIdFor("VERSIONING"), -- 12 Scalebreaker
  DRAGON2 = getNextIdFor("VERSIONING"), -- 13 Dragonhold
  HARROW = getNextIdFor("VERSIONING"), -- 14 Harrowstorm
  SKYRIM = getNextIdFor("VERSIONING"), -- 15 Greymoor
  STONET = getNextIdFor("VERSIONING"), -- 16 Stonethorn
  MARKAT = getNextIdFor("VERSIONING"), -- 17 Markarth
  FLAMES = getNextIdFor("VERSIONING"), -- 18 Flames of Ambition
  BLACKW = getNextIdFor("VERSIONING"), -- 19 Blackwood
  DEADL = getNextIdFor("VERSIONING"), -- 20 Deadlands
  TIDES = getNextIdFor("VERSIONING"), -- 21 Ascending Tide
  BRETON = getNextIdFor("VERSIONING"), -- 22 High Isle
  DEPTHS = getNextIdFor("VERSIONING"), -- 23 Lost Depths
  DRUID = getNextIdFor("VERSIONING"), -- 24 Firesong
  SCRIBE = getNextIdFor("VERSIONING"), -- 25 Scribes of Fate
  NECROM = getNextIdFor("VERSIONING"), -- 26 Necrom
  BASED = getNextIdFor("VERSIONING"), -- 27 Base Game Patch
  ENDLESS = getNextIdFor("VERSIONING"), -- 28 Secrets of the Telvanni
  SCIONS = getNextIdFor("VERSIONING"), -- 29 Scions of Ithelia
  WEALD = getNextIdFor("VERSIONING"), -- 30 Gold Road
}

FurC.Constants.Versioning.LATEST = FurC.Constants.Versioning.SCIONS

local getZoneStr = GetZoneNameById

-- Location Ids
FurC.Constants.Locations = {
  -- Translations exist ingame
  ALIKR = getZoneStr(104), -- Alik'r Desert
  APOCRYPHA = getZoneStr(1413), -- Apocrypha
  ARTAEUM = getZoneStr(1027), -- Artaeum
  AURIDON = getZoneStr(381), -- Auridon
  BALFOYEN = getZoneStr(281), -- Bal Foyen
  BETHNIKH = getZoneStr(535), -- Betnikh,
  BLACKWOOD = getZoneStr(1261), -- Blackwood
  CRAGLORN = getZoneStr(888), -- Craglorn
  CWC = getZoneStr(980), -- Clockwork City
  DUNG_DOM = getZoneStr(1081), -- Depths of Malatar
  DUNG_FL = getZoneStr(1009), -- Fang Lair
  DUNG_MHK = getZoneStr(1052), -- Moon Hunter Keep
  DUNG_MOS = getZoneStr(1055), -- March of the Sacrifices
  DUNG_SCP = getZoneStr(1010), -- Scalecaller Peak
  EASTMARCH = getZoneStr(101), -- Eastmarch
  GLENUMBRA = getZoneStr(3), -- Glenumbra
  GLENUMBRA_DF_RL = getZoneStr(942), -- The Rosy Lion (reuse house string)
  GOLDCOAST = getZoneStr(823), -- Gold Coast
  GRAHTWOOD = getZoneStr(383), -- Grahtwood
  GREENSHADE = getZoneStr(108), -- Greenshade
  HEWSBANE = getZoneStr(816), -- Hew's Bane
  KHENARTHI = getZoneStr(537), -- Khenarthi's Roost
  MURKMIRE = getZoneStr(726), -- Murkmire
  NELSWEYR = getZoneStr(1086), -- Northern Elsweyr
  REACH = getZoneStr(1207), -- The Reach
  SELSWEYR = getZoneStr(1133), -- Southern Elsweyr
  SHADOWFEN = getZoneStr(117), -- Shadowfen
  STONEFALLS = getZoneStr(41), -- Stonefalls
  SUMMERSET = getZoneStr(1011), -- Summerset
  TELVANNI = getZoneStr(1414), -- Telvanni Peninsula
  VVARDENFELL = getZoneStr(849), -- Vvardenfell
  WROTHGAR = getZoneStr(684), -- Wrothgar
  WSKYRIM = getZoneStr(1160), -- Western Skyrim
  -- Todo
  -- No translations found (might exist in string table, but ids keep changing)
  STONEFALLS_EBONHEART = GetString(SI_FURC_LOC_STONEFALLS_EBONHEART),
  SHADOWFEN_CORIMONT = GetString(SI_FURC_LOC_SHADOWFEN_CORIMONT),
  CAPITAL = GetString(SI_FURC_LOC_CAPITAL),
  CITY = GetString(SI_FURC_LOC_CITY),
  CWC_CITADEL_MARKET = GetString(SI_FURC_LOC_CWC_CITADEL_MARKET),
  KHENARTHI_MISTRAL = GetString(SI_FURC_LOC_KHENARTHI_MISTRAL),
  REACH_MARKARTH_MM = GetString(SI_FURC_LOC_REACH_MARKARTH_MM),
  GREENSHADE_MARBRUK = GetString(SI_FURC_LOC_GREENSHADE_MARBRUK),
  GRAHTWOOD_REDFUR = GetString(SI_FURC_LOC_GRAHTWOOD_REDFUR),
  ELSWEYR = GetString(SI_FURC_LOC_ELSWEYR),
  LILANDRIL = GetString(SI_FURC_LOC_LILANDRIL),
  EASTMARCH_AMOL = GetString(SI_FURC_LOC_EASTMARCH_AMOL),
  SUMMERSET_ALINOR = GetString(SI_FURC_LOC_SUMMERSET_ALINOR),
  SUMMERSET_ALINOR_RIVERSIDE = GetString(SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE),
  UNDAUNTED = GetString(SI_FURC_LOC_UNDAUNTED),
  CRAGLORN_BELKARTH_WOOD = GetString(SI_FURC_LOC_CRAGLORN_BELKARTH_WOOD),
  BLACKWOOD_LEYAWIIN_DBF = GetString(SI_FURC_LOC_BLACKWOOD_LEYAWIIN_DBF),
  PLACE_ORSINIUM = GetString(SI_FURC_LOC_PLACE_ORSINIUM),
  LILMOTH = GetString(SI_FURC_LOC_LILMOTH),
  BLACKWOOD_LEYAWIIN = GetString(SI_FURC_LOC_BLACKWOOD_LEYAWIIN),
  GOLDCOAST_KVATCH = GetString(SI_FURC_LOC_GOLDCOAST_KVATCH),
  COLDH_HOLLOW = GetString(SI_FURC_LOC_COLDH_HOLLOW),
  COLDH_HOLLOW_CGG = GetString(SI_FURC_LOC_COLDH_HOLLOW_CGG),
  CRAGLORN_BELKARTH = GetString(SI_FURC_LOC_CRAGLORN_BELKARTH),
  VVARDENFELL_SURAN = GetString(SI_FURC_LOC_VVARDENFELL_SURAN),
  ALIKR_KOZANZET_SWI = GetString(SI_FURC_LOC_ALIKR_KOZANZET_SWI),
  AURIDON_SKYWATCH = GetString(SI_FURC_LOC_AURIDON_SKYWATCH),
  BALFOYEN_DHALMORA = GetString(SI_FURC_LOC_BALFOYEN_DHALMORA),
  BETHNIKH_LTT = GetString(SI_FURC_LOC_BETHNIKH_LTT),
}

-- Old Constants as a fallback for other AddOns that use them
-- ToDo: required functionality will be moved to an API in the future

-- fallback item sources

-- @warning deprecated
FURC_NONE = FurC.Constants.ItemSources.NONE -- 1

-- @warning deprecated
FURC_FAVE = FurC.Constants.ItemSources.FAVE -- 2

-- @warning deprecated
FURC_CRAFTING = FurC.Constants.ItemSources.CRAFTING -- 3

-- @warning deprecated
FURC_CRAFTING_KNOWN = FurC.Constants.ItemSources.CRAFTING_KNOWN -- 4

-- @warning deprecated
FURC_CRAFTING_UNKNOWN = FurC.Constants.ItemSources.CRAFTING_UNKNOWN -- 5

-- @warning deprecated
FURC_VENDOR = FurC.Constants.ItemSources.VENDOR -- 6

-- @warning deprecated
FURC_PVP = FurC.Constants.ItemSources.PVP -- 7

-- @warning deprecated
FURC_WRIT_VENDOR = FurC.Constants.ItemSources.WRIT_VENDOR -- 8

-- @warning deprecated
FURC_CROWN = FurC.Constants.ItemSources.CROWN -- 9

-- @warning deprecated
FURC_RUMOUR = FurC.Constants.ItemSources.RUMOUR -- 10

-- @warning deprecated
FURC_LUXURY = FurC.Constants.ItemSources.LUXURY -- 11

-- @warning deprecated
FURC_OTHER = FurC.Constants.ItemSources.OTHER -- 12

-- @warning deprecated
FURC_ROLIS = FurC.Constants.ItemSources.ROLIS -- 13

-- @warning deprecated
FURC_DROP = FurC.Constants.ItemSources.DROP -- 14

-- @warning deprecated
FURC_JUSTICE = FurC.Constants.ItemSources.JUSTICE -- 15

-- @warning deprecated
FURC_FISHING = FurC.Constants.ItemSources.FISHING -- 16

-- @warning deprecated
FURC_GUILDSTORE = FurC.Constants.ItemSources.GUILDSTORE -- 17

-- @warning deprecated
FURC_FESTIVAL_DROP = FurC.Constants.ItemSources.FESTIVAL_DROP -- 18

-- fallback versions

-- @warning deprecated
FURC_HOMESTEAD = FurC.Constants.Versioning.HOMESTEAD -- 2 Homestead

-- @warning deprecated
FURC_MORROWIND = FurC.Constants.Versioning.MORROWIND -- 3 Morrowind

-- @warning deprecated
FURC_REACH = FurC.Constants.Versioning.REACH -- 4 Horns of the Reach

-- @warning deprecated
FURC_CLOCKWORK = FurC.Constants.Versioning.CLOCKWORK -- 5 Clockwork City

-- @warning deprecated
FURC_DRAGONS = FurC.Constants.Versioning.DRAGONS -- 6 Dragon Bones

-- @warning deprecated
FURC_ALTMER = FurC.Constants.Versioning.ALTMER -- 7 Summerset

-- @warning deprecated
FURC_SLAVES = FurC.Constants.Versioning.SLAVES -- 8 Murkmire

-- @warning deprecated
FURC_WEREWOLF = FurC.Constants.Versioning.WEREWOLF -- 9 Wolfhunter

-- @warning deprecated
FURC_WOTL = FurC.Constants.Versioning.WOTL -- 10 Wrathstone

-- @warning deprecated
FURC_KITTY = FurC.Constants.Versioning.KITTY -- 11 Elsweyr

-- @warning deprecated
FURC_SCALES = FurC.Constants.Versioning.SCALES -- 12 Scalebreaker

-- @warning deprecated
FURC_DRAGON2 = FurC.Constants.Versioning.DRAGON2 -- 13 Dragonhold

-- @warning deprecated
FURC_HARROW = FurC.Constants.Versioning.HARROW -- 14 Harrowstorm

-- @warning deprecated
FURC_SKYRIM = FurC.Constants.Versioning.SKYRIM -- 15 Greymoor

-- @warning deprecated
FURC_STONET = FurC.Constants.Versioning.STONET -- 16 Stonethorn

-- @warning deprecated
FURC_MARKAT = FurC.Constants.Versioning.MARKAT -- 17 Markarth

-- @warning deprecated
FURC_FLAMES = FurC.Constants.Versioning.FLAMES -- 18 Flames of Ambition

-- @warning deprecated
FURC_BLACKW = FurC.Constants.Versioning.BLACKW -- 19 Blackwood

-- @warning deprecated
FURC_DEADL = FurC.Constants.Versioning.DEADL -- 20 Deadlands

-- @warning deprecated
FURC_TIDES = FurC.Constants.Versioning.TIDES -- 21 Ascending Tide

-- @warning deprecated
FURC_BRETON = FurC.Constants.Versioning.BRETON -- 22 High Isle

-- @warning deprecated
FURC_DEPTHS = FurC.Constants.Versioning.DEPTHS -- 23 Lost Depths

-- @warning deprecated
FURC_DRUID = FurC.Constants.Versioning.DRUID -- 24 Firesong

-- @warning deprecated
FURC_SCRIBE = FurC.Constants.Versioning.SCRIBE -- 25 Scribes of Fate

-- @warning deprecated
FURC_NECROM = FurC.Constants.Versioning.NECROM -- 26 Necrom

-- @warning deprecated
FURC_BASED = FurC.Constants.Versioning.BASED -- 27 Base Game Patch

-- @warning deprecated
FURC_ENDLESS = FurC.Constants.Versioning.ENDLESS -- 28 Secrets of the Telvanni

-- @warning deprecated
FURC_SCIONS = FurC.Constants.Versioning.SCIONS -- 29 Scions of Ithelia

-- @warning deprecated
FURC_LATEST = FurC.Constants.Versioning.LATEST
