FurC = FurC or {}
FurC.Constants = {}

local getZoneStr = GetZoneNameById

-- TODO #DBOVERHAUL maybe: Current DB is tree-like which works well with LUA. Right now entries are indexed by localised strings, which may change, may not be unique and are different per language. That is no problem, because people usually don't switch between languages and rebuilding the DB doesn't take long. But if we, for whatever reason, switch to a relational DB or want to sync it with an online relational DB we will need unique and consistent indices.

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

-- Location Ids, mix of ingame strings and translations, more control over translations
FurC.Constants.Locations = {
  -- Translations exist ingame
  ALIKR = getZoneStr(104), -- Alik'r Desert
  APOCRYPHA = getZoneStr(1413), -- Apocrypha
  ARTAEUM = getZoneStr(1027), -- Artaeum
  AURIDON = getZoneStr(381), -- Auridon
  BALFOYEN = getZoneStr(281), -- Bal Foyen
  BANG = getZoneStr(94), -- Bangkorai
  BETHNIKH = getZoneStr(535), -- Betnikh
  BLACKWOOD = getZoneStr(1261), -- Blackwood
  BLEAK = getZoneStr(280), -- Bleakrock Isle
  CRAGLORN = getZoneStr(888), -- Craglorn
  CWC = getZoneStr(980), -- Clockwork City
  COLDH = getZoneStr(347), -- Coldharbor
  DEADLANDS = getZoneStr(1286), -- Deadlands
  DESHAAN = getZoneStr(57), -- Deshaan
  DESHAAN_MH = getZoneStr(600), -- Mournhold
  DUNG_DOM = getZoneStr(1081), -- Depths of Malatar
  DUNG_FL = getZoneStr(1009), -- Fang Lair
  DUNG_IA = getZoneStr(1436), -- Infinite Archive
  DUNG_MHK = getZoneStr(1052), -- Moon Hunter Keep
  DUNG_MOS = getZoneStr(1055), -- March of the Sacrifices
  DUNG_SCP = getZoneStr(1010), -- Scalecaller Peak
  EASTMARCH = getZoneStr(101), -- Eastmarch
  FARGRAVE = getZoneStr(1282), -- Fargrave
  GALEN = getZoneStr(1383), -- Galen
  GLENUMBRA = getZoneStr(3), -- Glenumbra
  GOLDCOAST = getZoneStr(823), -- Gold Coast
  GRAHTWOOD = getZoneStr(383), -- Grahtwood
  GREENSHADE = getZoneStr(108), -- Greenshade
  HEWSBANE = getZoneStr(816), -- Hew's Bane
  HIGHISLE = getZoneStr(1318), -- High Isle
  KHENARTHI = getZoneStr(537), -- Khenarthi's Roost
  MALABAL = getZoneStr(58), -- Malabal Tor
  MURKMIRE = getZoneStr(726), -- Murkmire
  NELSWEYR = getZoneStr(1086), -- Northern Elsweyr
  REACH = getZoneStr(1207), -- The Reach
  REAPER = getZoneStr(382), -- Reaper's March
  RIFT = getZoneStr(103), -- Rift
  SELSWEYR = getZoneStr(1133), -- Southern Elsweyr
  SHADOWFEN = getZoneStr(117), -- Shadowfen
  STONEFALLS = getZoneStr(41), -- Stonefalls
  STROSMKAI = getZoneStr(534), -- Stonefalls
  SUMMERSET = getZoneStr(1011), -- Summerset
  TELVANNI = getZoneStr(1414), -- Telvanni Peninsula
  VVARDENFELL = getZoneStr(849), -- Vvardenfell
  WROTHGAR = getZoneStr(684), -- Wrothgar
  WSKYRIM = getZoneStr(1160), -- Western Skyrim
  -- Custom or not directly available ingame (might exist in string table, but ids keep changing)
  -- TODO: Could extract city names from outlaw refuge string, but would be a bit hacky
  ALIKR_KOZANZET_SWI = GetString(SI_FURC_LOC_ALIKR_KOZANZET_SWI),
  ANY = GetString(SI_FURC_LOC_ANY),
  ANY_CAPITAL = GetString(SI_FURC_LOC_ANY_CAPITAL),
  ANY_CITY = GetString(SI_FURC_LOC_ANY_CITY),
  AURIDON_SKYWATCH = GetString(SI_FURC_LOC_AURIDON_SKYWATCH),
  BALFOYEN_DHALMORA = GetString(SI_FURC_LOC_BALFOYEN_DHALMORA),
  BANG_EVERMORE = GetString(SI_FURC_LOC_BANG_EVERMORE),
  BETHNIKH_LTT = GetString(SI_FURC_LOC_BETHNIKH_LTT),
  BLACKWOOD_LEYAWIIN = GetString(SI_FURC_LOC_BLACKWOOD_LEYAWIIN),
  BLACKWOOD_LEYAWIIN_DBF = GetString(SI_FURC_LOC_BLACKWOOD_LEYAWIIN_DBF),
  COLDH_HOLLOW = GetString(SI_FURC_LOC_COLDH_HOLLOW),
  COLDH_HOLLOW_CGG = GetString(SI_FURC_LOC_COLDH_HOLLOW_CGG),
  CRAGLORN_BELKARTH = GetString(SI_FURC_LOC_CRAGLORN_BELKARTH),
  CRAGLORN_BELKARTH_WOOD = GetString(SI_FURC_LOC_CRAGLORN_BELKARTH_WOOD),
  CWC_CITADEL_MARKET = GetString(SI_FURC_LOC_CWC_CITADEL_MARKET),
  DESHAAN_MH_BANK = GetString(SI_FURC_LOC_DESHAAN_MH_BANK),
  EASTMARCH_AMOL = GetString(SI_FURC_LOC_EASTMARCH_AMOL),
  ELSWEYR = GetString(SI_FURC_LOC_ELSWEYR),
  FARGRAVE_FF = GetString(SI_FURC_LOC_FARGRAVE_FF),
  GALEN_VAS = GetString(SI_FURC_LOC_GALEN_VAS),
  GALEN_VAS_TOHF = GetString(SI_FURC_LOC_GALEN_VAS_TOHF),
  GLENUMBRA_DF_RL = GetString(SI_FURC_LOC_GLENUMBRA_DF_RL),
  GOLDCOAST_KVATCH = GetString(SI_FURC_LOC_GOLDCOAST_KVATCH),
  GRAHTWOOD_REDFUR = GetString(SI_FURC_LOC_GRAHTWOOD_REDFUR),
  GREENSHADE_MARBRUK = GetString(SI_FURC_LOC_GREENSHADE_MARBRUK),
  HIGHISLE_GFB = GetString(SI_FURC_LOC_HIGHISLE_GFB),
  HIGHISLE_GFB_FOFF = GetString(SI_FURC_LOC_HIGHISLE_GFB_FOFF),
  KHENARTHI_MISTRAL = GetString(SI_FURC_LOC_KHENARTHI_MISTRAL),
  LILANDRIL = GetString(SI_FURC_LOC_LILANDRIL),
  MURKMIRE_LIL = GetString(SI_FURC_LOC_MURKMIRE_LIL),
  PLACE_ORSINIUM = GetString(SI_FURC_LOC_PLACE_ORSINIUM),
  REACH_MARKARTH_MM = GetString(SI_FURC_LOC_REACH_MARKARTH_MM),
  SELSWEYR_DHA = GetString(SI_FURC_LOC_SELSWEYR_DHA),
  SHADOWFEN_CORIMONT = GetString(SI_FURC_LOC_SHADOWFEN_CORIMONT),
  STONEFALLS_EBONHEART = GetString(SI_FURC_LOC_STONEFALLS_EBONHEART),
  SUMMERSET_ALINOR = GetString(SI_FURC_LOC_SUMMERSET_ALINOR),
  SUMMERSET_ALINOR_RIVERSIDE = GetString(SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE),
  UNDAUNTED = GetString(SI_FURC_LOC_UNDAUNTED),
  VVARDENFELL_SURAN = GetString(SI_FURC_LOC_VVARDENFELL_SURAN),
}

-- NPC ids, for better readability and more control of the string sources
FurC.Constants.NPC = {
  ADOSA = GetString(SI_FURC_TRADERS_ADOSA), -- Murkmire, Lilmoth, High-End Furnishings
  ALCHEMISTS = GetString(SI_FURC_TRADERS_ALCHEMISTS), -- any alchemist
  ATHRAGOR = GetString(SI_FURC_TRADERS_ATHRAGOR), -- Achievement furnisher in AD zones + Kvatch + Cyrodiil: Western Elseweyr Gate
  AVERIO = GetString(SI_FURC_TRADERS_AVERIO), -- Reach, Markarth, Sticks and Stones
  BARNABE = GetString(SI_FURC_TRADERS_BARNABE), -- Blackwood, Leyawiin, Domestic Bliss Furnishings
  BLACKSMITHS = GetString(SI_FURC_TRADERS_BLACKSMITHS), -- any blacksmith
  BRELDA = GetString(SI_FURC_TRADERS_BRELDA), -- Vvardenfell, Vivec City, Battleground Housing Goods
  CARPENTERS = GetString(SI_FURC_TRADERS_CARPENTERS), -- any capenter
  CLOTHIERS = GetString(SI_FURC_TRADERS_CLOTHIERS), -- any clothier
  COOKS = GetString(SI_FURC_TRADERS_COOKS), -- any cook
  DROPSNOGLASS = GetString(SI_FURC_TRADERS_DROPSNOGLASS), -- Achievement furnisher on Vvardenfell, Vivec City, Vivec City Furnishings
  DROPSNOGLASS_COLL = GetString(SI_FURC_TRADERS_DROPSNOGLASS_COLL),
  ENCHANTERS = GetString(SI_FURC_TRADERS_ENCHANTERS), -- any enchanter
  FROHILDE = GetString(SI_FURC_TRADERS_FROHILDE), -- Home Goods Furnisher in EP zones + Kvatch + Cyrodiil: Southern Morrowind Gate
  HARNWULF = GetString(SI_FURC_TRADERS_HARNWULF), -- Achievement furnisher Murkmire, Lilmoth, High-End Furnishings
  HERALDA = GetString(SI_FURC_TRADERS_HERALDA), -- Achievement furnisher, any capital city
  IDRENIE = GetString(SI_FURC_TRADERS_IDRENIE), -- Achievement furnisher on Highisle, Vastyr, Touch of Home Furnishings
  IMPRESS = GetString(SI_FURC_TRADERS_IMPRESS),
  JERAN = GetString(SI_FURC_TRADERS_JERAN),
  KRRZTRRB = GetString(SI_FURC_TRADERS_KRRZTRRB),
  LATHAHIM = GetString(SI_FURC_TRADERS_LATHAHIM),
  LLIVAS = GetString(SI_FURC_TRADERS_LLIVAS),
  LOZOTUSK = GetString(SI_FURC_TRADERS_LOZOTUSK),
  LTS = GetString(SI_FURC_TRADERS_LTS),
  MALADDIQ = GetString(SI_FURC_TRADERS_MALADDIQ),
  MARTINA = GetString(SI_FURC_TRADERS_MARTINA),
  MIRASO = GetString(SI_FURC_TRADERS_MIRASO),
  MIRUZA = GetString(SI_FURC_TRADERS_MIRUZA),
  MULVISE = GetString(SI_FURC_TRADERS_MULVISE),
  MURKHOLG = GetString(SI_FURC_TRADERS_MURKHOLG),
  MYSTIC = GetString(SI_FURC_TRADERS_MYSTIC),
  MYSTIC_COLL = GetString(SI_FURC_TRADERS_MYSTIC_COLL),
  NALIRSEWEN = GetString(SI_FURC_TRADERS_NALIRSEWEN),
  NARWAAWENDE = GetString(SI_FURC_TRADERS_NARWAAWENDE),
  NIF = GetString(SI_FURC_TRADERS_NIF),
  ORMAX = GetString(SI_FURC_TRADERS_ORMAX),
  OUTLAW = GetString(SI_FURC_TRADERS_OUTLAW),
  RAZOUFA = GetString(SI_FURC_TRADERS_RAZOUFA),
  RAZOUFA_COLL = GetString(SI_FURC_TRADERS_RAZOUFA_COLL),
  ROHZIKA = GetString(SI_FURC_TRADERS_ROHZIKA),
  TARMIMN = GetString(SI_FURC_TRADERS_TARMIMN),
  TEZURS = GetString(SI_FURC_TRADERS_TEZURS),
  TIRUDILMO = GetString(SI_FURC_TRADERS_TIRUDILMO),
  ULZ = GetString(SI_FURC_TRADERS_ULZ),
  UNDAUNTEDQM = GetString(SI_FURC_TRADERS_UNDAUNTEDQM),
  UNWOTIL = GetString(SI_FURC_TRADERS_UNWOTIL),
  UZIPA = GetString(SI_FURC_TRADERS_UZIPA),
  VASEI = GetString(SI_FURC_TRADERS_VASEI),
  YATAVA = GetString(SI_FURC_TRADERS_YATAVA),
  ZADRASKA = GetString(SI_FURC_TRADERS_ZADRASKA),
  ZANIL = GetString(SI_FURC_TRADERS_ZANIL),
}

local colours = {
  Vendor = "D68957",
  Location = "D68957",
  Gold = "E5dA40",
  Voucher = "25C31E",
  AP = "5EA4FF",
  TelVar = "82BCFF",
}
FurC.Constants.Colours = colours

FurC.Constants.Currencies = {
  [CURT_NONE] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_NONE),
  },
  [CURT_MONEY] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_MONEY),
  },
  [CURT_ALLIANCE_POINTS] = {
    colour = colours.AP,
    name = GetCurrencyName(CURT_ALLIANCE_POINTS),
  },
  [CURT_TELVAR_STONES] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_TELVAR_STONES),
  },
  [CURT_WRIT_VOUCHERS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_WRIT_VOUCHERS),
  },
  [CURT_CHAOTIC_CREATIA] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CHAOTIC_CREATIA),
  },
  [CURT_CROWN_GEMS] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CROWN_GEMS),
  },
  [CURT_CROWNS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_CROWNS),
  },
  [CURT_STYLE_STONES] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_STYLE_STONES),
  },
  [CURT_EVENT_TICKETS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_EVENT_TICKETS),
  },
  [CURT_UNDAUNTED_KEYS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_UNDAUNTED_KEYS),
  },
  [CURT_ENDEAVOR_SEALS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_ENDEAVOR_SEALS),
  },
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
