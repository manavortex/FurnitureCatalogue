local idCounter = {}

---Generate consecutive ids for constants
---@param id_type string
---@return integer nextId
local function getNextIdFor(id_type)
  idCounter[id_type] = (idCounter[id_type] or 0) + 1
  return idCounter[id_type]
end

-- constants for filtering
-- item sources
FURC_NONE             = getNextIdFor('ITEM_SOURCES') -- 1
FURC_FAVE             = getNextIdFor('ITEM_SOURCES') -- 2
FURC_CRAFTING         = getNextIdFor('ITEM_SOURCES') -- 3
FURC_CRAFTING_KNOWN   = getNextIdFor('ITEM_SOURCES') -- 4
FURC_CRAFTING_UNKNOWN = getNextIdFor('ITEM_SOURCES') -- 5
FURC_VENDOR           = getNextIdFor('ITEM_SOURCES') -- 6
FURC_PVP              = getNextIdFor('ITEM_SOURCES') -- 7
FURC_WRIT_VENDOR      = getNextIdFor('ITEM_SOURCES') -- 8
FURC_CROWN            = getNextIdFor('ITEM_SOURCES') -- 9
FURC_RUMOUR           = getNextIdFor('ITEM_SOURCES') -- 10
FURC_LUXURY           = getNextIdFor('ITEM_SOURCES') -- 11
FURC_OTHER            = getNextIdFor('ITEM_SOURCES') -- 12
FURC_ROLIS            = getNextIdFor('ITEM_SOURCES') -- 13
FURC_DROP             = getNextIdFor('ITEM_SOURCES') -- 14
FURC_JUSTICE          = getNextIdFor('ITEM_SOURCES') -- 15
FURC_FISHING          = getNextIdFor('ITEM_SOURCES') -- 16
FURC_GUILDSTORE       = getNextIdFor('ITEM_SOURCES') -- 17
FURC_FESTIVAL_DROP    = getNextIdFor('ITEM_SOURCES') -- 18

FURC_EMPTY_STRING     = ""

-- versioning
FURC_NONE             = getNextIdFor('VERSIONING') -- 1
FURC_HOMESTEAD        = getNextIdFor('VERSIONING') -- 2
FURC_MORROWIND        = getNextIdFor('VERSIONING') -- 3
FURC_REACH            = getNextIdFor('VERSIONING') -- 4
FURC_CLOCKWORK        = getNextIdFor('VERSIONING') -- 5
FURC_DRAGONS          = getNextIdFor('VERSIONING') -- 6
FURC_ALTMER           = getNextIdFor('VERSIONING') -- 7
FURC_WEREWOLF         = getNextIdFor('VERSIONING') -- 8
FURC_SLAVES           = getNextIdFor('VERSIONING') -- 9
FURC_WOTL             = getNextIdFor('VERSIONING') -- 10
FURC_KITTY            = getNextIdFor('VERSIONING') -- 11
FURC_SCALES           = getNextIdFor('VERSIONING') -- 12
FURC_DRAGON2          = getNextIdFor('VERSIONING') -- 13
FURC_HARROW           = getNextIdFor('VERSIONING') -- 14
FURC_SKYRIM           = getNextIdFor('VERSIONING') -- 15
FURC_STONET           = getNextIdFor('VERSIONING') -- 16
FURC_MARKAT           = getNextIdFor('VERSIONING') -- 17
FURC_FLAMES           = getNextIdFor('VERSIONING') -- 18
FURC_BLACKW           = getNextIdFor('VERSIONING') -- 19
FURC_DEADL            = getNextIdFor('VERSIONING') -- 20
FURC_TIDES            = getNextIdFor('VERSIONING') -- 21
FURC_BRETON           = getNextIdFor('VERSIONING') -- 22
FURC_DEPTHS           = getNextIdFor('VERSIONING') -- 23
FURC_DRUID            = getNextIdFor('VERSIONING') -- 24
FURC_SCRIBE           = getNextIdFor('VERSIONING') -- 25

FURC_LATEST           = FURC_SCRIBE
