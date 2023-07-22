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
}

FurC.Constants.Versioning.LATEST = FurC.Constants.Versioning.NECROM
