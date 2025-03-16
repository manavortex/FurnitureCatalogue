FurC = FurC or {}

--- Collection of some variables for easier access. Not intended as an API. Some values are constants, while others are generated from string localisation and may change between play sessions or game patches.
FurC.Constants = {}

local getZoneStr = GetZoneNameById
local sFormat = zo_strformat

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

-- TODO #REFACTOR Switch version numbering to the same as game update numbers

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
  BASE43 = getNextIdFor("VERSIONING"), -- 31 Base Game Update 43
  BASE44 = getNextIdFor("VERSIONING"), -- 32 Base Game Update 44
  FALLBAN = getNextIdFor("VERSIONING"), -- 33 Fallen Banners (U45)
}

FurC.Constants.Versioning.LATEST = FurC.Constants.Versioning.FALLBAN

-- Location Ids, mix of ingame strings and translations, more control over translations
FurC.Constants.Locations = {
  -- Translations exist ingame
  --  Careful: the ids may change with expansions, use FurCDev.FindZone to fix any broken ones
  -- TODO: if the id change happens often, write autofixer for it
  ALIKR = getZoneStr(104), -- Alik'r Desert
  APOCRYPHA = getZoneStr(1413), -- Apocrypha
  ARTAEUM = getZoneStr(1027), -- Artaeum
  AURIDON = getZoneStr(381), -- Auridon
  BALFOYEN = getZoneStr(281), -- Bal Foyen
  BANG = getZoneStr(92), -- Bangkorai
  BETHNIKH = getZoneStr(535), -- Betnikh
  BLACKREACH_GMC = getZoneStr(1161), --  Blackreach: Greymoor Caverns
  BLACKWOOD = getZoneStr(1261), -- Blackwood
  BLEAK = getZoneStr(280), -- Bleakrock Isle
  COLDH = getZoneStr(347), -- Coldharbor
  CRAGLORN = getZoneStr(888), -- Craglorn
  CWC = getZoneStr(980), -- Clockwork City
  CYRO = getZoneStr(181), -- Cyrodiil
  DEADLANDS = getZoneStr(1286), -- Deadlands
  DESHAAN = getZoneStr(57), -- Deshaan
  DUNG_DOM = getZoneStr(1081), -- Depths of Malatar
  DUNG_FL = getZoneStr(1009), -- Fang Lair
  DUNG_FV = getZoneStr(1080), -- Frostvault
  DUNG_IA = getZoneStr(1436), -- Infinite Archive
  DUNG_MHK = getZoneStr(1052), -- Moon Hunter Keep
  DUNG_MOS = getZoneStr(1055), -- March of the Sacrifices
  DUNG_NYMIC = getZoneStr(1420), -- Bastion Nymic
  DUNG_SCP = getZoneStr(1010), -- Scalecaller Peak
  DUNG_SCRIV = getZoneStr(1390), -- Scrivener's Hall
  EASTMARCH = getZoneStr(101), -- Eastmarch
  FARGRAVE = getZoneStr(1282), -- Fargrave
  GALEN = getZoneStr(1383), -- Galen
  GLENUMBRA = getZoneStr(3), -- Glenumbra
  GOLDCOAST = getZoneStr(823), -- Gold Coast
  GRAHTWOOD = getZoneStr(383), -- Grahtwood
  GREENSHADE = getZoneStr(108), -- Greenshade
  HEWSBANE = getZoneStr(816), -- Hew's Bane
  HIGHISLE = getZoneStr(1318), -- High Isle
  IMPCITY = getZoneStr(584), -- Imperial City
  KHENARTHI = getZoneStr(537), -- Khenarthi's Roost
  MALABAL = getZoneStr(58), -- Malabal Tor
  MURKMIRE = getZoneStr(726), -- Murkmire
  NELSWEYR = getZoneStr(1086), -- Northern Elsweyr
  PDUNG_VVARDENFELL_FW = getZoneStr(919), -- Forgotten Wastes
  REACH = getZoneStr(1207), -- The Reach
  REAPER = getZoneStr(382), -- Reaper's March
  RIFT = getZoneStr(103), -- Rift
  RIVENSPIRE = getZoneStr(20), -- Rivenspire
  SCHOLAR = getZoneStr(1463), -- The Scholarium
  SELSWEYR = getZoneStr(1133), -- Southern Elsweyr
  SHADOWFEN = getZoneStr(117), -- Shadowfen
  STONEFALLS = getZoneStr(41), -- Stonefalls
  STORMHAVEN = getZoneStr(19), -- Stormhaven
  STROSMKAI = getZoneStr(534), -- Stonefalls
  SUMMERSET = getZoneStr(1011), -- Summerset
  TELVANNI = getZoneStr(1414), -- Telvanni Peninsula
  VVARDENFELL = getZoneStr(849), -- Vvardenfell
  WEALD = getZoneStr(1443), -- West Weald
  WROTHGAR = getZoneStr(684), -- Wrothgar
  WSKYRIM = getZoneStr(1160), -- Western Skyrim
  -- Custom
  ANY = GetString(SI_FURC_LOC_ANY),
  ANY_CAPITAL = GetString(SI_FURC_LOC_ANY_CAPITAL),
  ANY_CITY = GetString(SI_FURC_LOC_ANY_CITY),
  -- TODO
  LILANDRIL = GetString(SI_FURC_LOC_LILANDRIL),
  MURKMIRE_LIL = GetString(SI_FURC_LOC_MURKMIRE_LIL),
  PLACE_ORSINIUM = GetString(SI_FURC_LOC_PLACE_ORSINIUM),
  REACH_MARKARTH_MM = GetString(SI_FURC_LOC_REACH_MARKARTH_MM),
  SELSWEYR_DHA = GetString(SI_FURC_LOC_SELSWEYR_DHA),
  SELSWEYR_SENCHAL_MARKET = GetString(SI_FURC_LOC_SELSWEYR_SENCHAL_MARKET),
  SHADOWFEN_CORIMONT = GetString(SI_FURC_LOC_SHADOWFEN_CORIMONT),
  STONEFALLS_EBONHEART = GetString(SI_FURC_LOC_STONEFALLS_EBONHEART),
  SUMMERSET_ALINOR = GetString(SI_FURC_LOC_SUMMERSET_ALINOR),
  SUMMERSET_ALINOR_RIVERSIDE = GetString(SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE),
  UNDAUNTED = GetString(SI_FURC_LOC_UNDAUNTED),
  STORMHAVEN_WAY_MERCH = GetString(SI_FURC_LOC_STORMHAVEN_WAY_MERCH),
  TELVANNI_NECROM_FRF = GetString(SI_FURC_TELVANNI_NECROM_FRF),
  VVARDENFELL_SURAN = GetString(SI_FURC_LOC_VVARDENFELL_SURAN),
  VVARDENFELL_ALDRUHN = GetString(SI_FURC_LOC_VVARDENFELL_ALDRUHN), -- Vvardenfell
  VVARDENFELL_VIVEC = GetString(SI_FURC_LOC_VVARDENFELL_VIVEC),
  VVARDENFELL_VIVEC_GQ = GetString(SI_FURC_LOC_VVARDENFELL_VIVEC_GQ),
  VVARDENFELL_VIVEC_SDI = GetString(SI_FURC_LOC_VVARDENFELL_VIVEC_SDI),
  WSKYRIM_SOLI_DH = GetString(SI_FURC_LOC_WSKYRIM_SOLI_DH),
}

-- NPC ids, for better readability and more control of the string sources
FurC.Constants.NPC = {
  -- Writ Furnishers
  ROLIS = GetString(SI_FURC_TRADERS_ROLIS), -- Rolis Hlaalu, Mastercraft Mediator
  FAUSTINA = GetString(SI_FURC_TRADERS_FAUSTINA), -- Faustina Curio, Achievement Mediator

  -- Other Furnishers
  ALCHEMISTS = GetString(SI_FURC_TRADERS_ALCHEMISTS), -- any alchemist
  BLACKSMITHS = GetString(SI_FURC_TRADERS_BLACKSMITHS), -- any blacksmith
  CARPENTERS = GetString(SI_FURC_TRADERS_CARPENTERS), -- any capenter
  CLOTHIERS = GetString(SI_FURC_TRADERS_CLOTHIERS), -- any clothier
  COOKS = GetString(SI_FURC_TRADERS_COOKS), -- any cook
  ENCHANTERS = GetString(SI_FURC_TRADERS_ENCHANTERS), -- any enchanter

  -- Special Merchants
  AF = GetString(SI_FURC_TRADERS_AF), -- Achievement Vendor: Lozotusk, ...
  BGF = GetString(SI_FURC_TRADERS_BGF), -- Battlegrounds Furnishers
  CAF = GetString(SI_FURC_TRADERS_CAF), -- Main Achievement Vendor: Nolenowen, ...
  EVENT = GetString(SI_FURC_TRADERS_EVENT), -- Event Merchant, any capital city: The Impressario
  HGF = GetString(SI_FURC_TRADERS_HGF), -- Home Goods Furnisher: Maladiq, Rohzika, ...
  HOLIDAY = GetString(SI_FURC_TRADERS_HOLIDAY), -- Heralda, Tildannire, ...
  LUXF = GetString(SI_FURC_TRADERS_LUXF), -- Luxury Furnisher: Zanil

  -- Guild Traders
  FIGHTERS_STEWARD = GetString(SI_FURC_GUILD_FIGHTERS_STEWARD), -- stewards in Fighters Guild locations
  MAGES_MYSTIC = GetString(SI_FURC_GUILD_MAGES_MYSTIC), --  mystics in Mages Guild locations
  PSIJIC_NALIRSEWEN = GetString(SI_FURC_GUILD_PSIJIC_NALIRSEWEN), -- Psijik Trader on Artaeum
  THIEVES_MERCH = GetString(SI_FURC_GUILD_THIEVES_MERCH), -- Outlaw Merchant in any refuge
  UNDAUNTED_QM = GetString(SI_FURC_GUILD_UNDAUNTED_QM), -- Undaunted Achievement trader

  -- use suffix (collection) instead of 1 string per trader
  DROPSNOGLASS_COLL = GetString(SI_FURC_TRADERS_DROPSNOGLASS_COLL), -- TODO: make collections into special sources
  MAGES_MYSTIC_COLL = GetString(SI_FURC_GUILD_MAGES_MYSTIC_COLL), -- TODO: make collections into special sources
  RAZOUFA_COLL = GetString(SI_FURC_TRADERS_RAZOUFA_COLL), -- TODO: make collections into special sources

  -- enemies (loot) and social classes (pickpocketing)
  ENEMY_AUTOMATON = GetString(SI_FURC_NPC_AUTOMATON),
  ENEMY_RND = sFormat("<<m:1>>", GetString(SI_FURC_SRC_RNDMOB)),
  CLASS_ALCHEMIST = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS2)),
  CLASS_ARTISAN = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS3)),
  CLASS_ASSASSIN = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS4)),
  CLASS_BARD = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS5)),
  CLASS_BEGGAR = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS6)),
  CLASS_CHEF = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS7)),
  CLASS_CIVIL_SERVANT = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS8)),
  CLASS_CLOTHIER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS9)),
  CLASS_COMMONER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS10)),
  CLASS_CRAFTER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS11)),
  CLASS_CULTIST = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS12)),
  CLASS_DAEDRA = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS47)),
  CLASS_DRUNKARD = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS13)),
  CLASS_FARMER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS14)),
  CLASS_FIGHTER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS15)),
  CLASS_FISHER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS16)),
  CLASS_GATHERER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS17)),
  CLASS_GHOST = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS18)),
  CLASS_GUARD = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS19)),
  CLASS_HEALER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS20)),
  CLASS_HUNTER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS21)),
  CLASS_LABORER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS22)),
  CLASS_MAGE = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS23)),
  CLASS_MERCHANT = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS24)),
  CLASS_NOBLE = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS25)),
  CLASS_NUDE = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS26)),
  CLASS_ORDINATOR = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS27)),
  CLASS_OUTLAW = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS28)),
  CLASS_PILGRIM = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS29)),
  CLASS_PRIEST = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS30)),
  CLASS_PRISONER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS31)),
  CLASS_PROVISIONER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS32)),
  CLASS_SAILOR = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS33)),
  CLASS_SCHOLAR = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS34)),
  CLASS_SERVANT = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS35)),
  CLASS_SKELETON = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS36)),
  CLASS_SLAVE = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS37)),
  CLASS_SMITH = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS38)),
  CLASS_SOLDIER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS39)),
  CLASS_STUDENT = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS40)),
  CLASS_THIEF = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS41)),
  CLASS_VAMPIRE = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS42)),
  CLASS_WARRIOR = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS43)),
  CLASS_WATCHMEN = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS44)),
  CLASS_WEREWOLF = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS45)),
  CLASS_WOODWORKER = sFormat("<<1>>", GetString(SI_MONSTERSOCIALCLASS46)),
}

FurC.Constants.CrownCrates = {
  -- Source: https://en.uesp.net/wiki/Online:Crown_Crates

  -- ids not confirmed ingame yet
  AKA_ALDU = GetCrownCrateName(63), -- 2025-09, Akatosh vs. Alduin
  CARNAVAL = GetCrownCrateName(62), -- 2025-06, Carnaval

  MIRROR = GetCrownCrateName(61), -- 2025-03, Mirrormoor
  DB = GetCrownCrateName(60), -- 2024-12, Dark Brotherhood

  -- confirmed ids
  DIAMOND = GetCrownCrateName(59), -- 2024-07, Diamond Anniversary
  LAMP = GetCrownCrateName(58), -- 2024-04
  ALLMAKER = GetCrownCrateName(57), -- 2023-12
  ARMIGER = GetCrownCrateName(55), -- 2023-09
  FEATHER = GetCrownCrateName(54), -- 2023-06, Unfeathered
  RAGE = GetCrownCrateName(53), -- 2023-04
  STONELORE = GetCrownCrateName(52), -- 2022-12
  WRAITH = GetCrownCrateName(51), -- 2022-09
  DARK = GetCrownCrateName(50), -- 2022-06
  SUNKEN = GetCrownCrateName(49), -- 2022-04
  CELESTIAL = GetCrownCrateName(48), -- 2021-12
  HARLEQUIN = GetCrownCrateName(47), -- 2021-09
  IRON_ATRO = GetCrownCrateName(46), -- 2021-06
  AYLEID = GetCrownCrateName(45), -- 2021-03
  POTENTATE = GetCrownCrateName(44), -- 2020-12, Akaviri Potentate
  SOVNGARDE = GetCrownCrateName(41), -- 2020-09
  NIGHTFALL = GetCrownCrateName(39), -- 2020-06
  GLOOMSPORE = GetCrownCrateName(37), -- 2020-04
  FROST_ATRO = GetCrownCrateName(30), -- 2020-01
  NEWMOON = GetCrownCrateName(27), -- 2019-09
  BAANDARI = GetCrownCrateName(21), -- 2019-07, Baandari Pedlar
  DRAGONSCALE = GetCrownCrateName(24), -- 2019-04
  XANMEER = GetCrownCrateName(12), -- 2018-12, Xanmeer
  HOLLOWJACK = GetCrownCrateName(10), -- 2018-09, Hollowjack
  PSIJIC = GetCrownCrateName(9), -- 2018-06, Psijic Vault
  SCALECALLER = GetCrownCrateName(8), -- 2018-03, Scalecaller
  FIRE_ATRO = GetCrownCrateName(6), -- 2017-11, Flame Atronach
  REAPER = GetCrownCrateName(5), -- 2017-09, Reaper's Harvest
  DWEMER = GetCrownCrateName(4), -- 2017-07, Dwemer
  WILD_HUNT = GetCrownCrateName(2), -- 2017-04, Wild Hund
  --STORM_ATRO = GetCrownCrateName(1), -- 2016-12, Storm Atronach, no exclusive furnishings
}

FurC.Constants.SkillLines = {
  -- manual lookup for now:
  -- /script for i=1, 1000 do if (string.find(LocaleAwareToLower(GetSkillLineNameById(i)), "psijic")) then d(string.format("%d: %s", i, GetSkillLineNameById(i))) end end

  LEGERDEMAIN = GetSkillLineNameById(111),
  PSIJIC = GetSkillLineNameById(130),
}

FurC.Constants.Events = {
  ANNIVERSARY = GetString(SI_FURC_EVENT_ANNIVERSARY), -- Anniversary Jubilee
  BLACKWOOD = GetString(SI_FURC_EVENT_BLACKWOOD), -- Bounties of Blackwood
  ELSWEYR = GetString(SI_FURC_EVENT_ELSWEYR), -- Season of the Dragon
  HOLLOWJACK = GetString(SI_FURC_EVENT_HOLLOWJACK), -- Sinister Hollowjack
  IC = GetString(SI_FURC_EVENT_IC), -- Imperial City Celebration Event
  JESTER = GetString(SI_FURC_EVENT_JESTER), -- Jester's Festival
  MAYHEM = GetString(SI_FURC_EVENT_MAYHEM), -- Whitestrake's Mayhem
  NEWLIFE = GetString(SI_FURC_EVENT_NEWLIFE), -- New Life Festival
  UNDAUNTED = GetString(SI_FURC_EVENT_UNDAUNTED), -- Undaunted Celebration
  WITCHES = GetString(SI_FURC_EVENT_WITCHES), -- Witches Festival
  ZENITHAR = GetString(SI_FURC_EVENT_ZENITHAR), -- Zeal of Zenithar
}

FurC.Constants.Containers = {
  BOONBOX = "|H0:item:121526:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Whitestrake's Mayhem
  ELSWEYRCOFFER = "|H0:item:175580:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Season of the Dragon
  JESTERBOX = "|H0:item:194414:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Jester's Festival
  JUBILEEBOX = "|H0:item:134797:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Anniversary Jubilee
  LEGIONZEROBOX = "|H0:item:167210:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Imperial City Celebration
  NEWLIFEBOX = "|H0:item:96390:367:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during New Life Festival
  PLUNDERSKULL = "|H0:item:84521:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Witches' Festival
  UNDAUNTEDBOX = "|H0:item:171267:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Undaunted Celebration
  ZENITHARPARCEL = "|H0:item:187701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- during Zenithar's Zeal
}

-- TODO: allow customisable colours, getting from options
local colours = {
  AP = "5EA4FF",
  Gold = "E5DA40",
  Location = "CF6D00",
  Quest = "E5DA40",
  TelVar = "82BCFF",
  Vendor = "72DB00",
  Voucher = "25C31E",
}
FurC.Constants.Colours = colours

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
FURC_WEALD = FurC.Constants.Versioning.WEALD -- 30 Gold Road

-- @warning deprecated
FURC_BASE43 = FurC.Constants.Versioning.BASE43 -- 31 Update 43 Base Game Patch

-- @warning deprecated
FURC_BASE44 = FurC.Constants.Versioning.BASE44 -- 32 Update 44 Base Game Patch

-- @warning deprecated
FURC_LATEST = FurC.Constants.Versioning.LATEST
