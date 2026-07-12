FurC.MiscItemSources = FurC.MiscItemSources or {}

local loc = FurC.Constants.Locations
local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources
local npc = FurC.Constants.NPC
local crates = FurC.Constants.CrownCrates
local events = FurC.Constants.Events

local formatAchievement = FurC.Utils.FormatAchievement

local getItemName = FurC.Utils.GetItemName
local getItemLink = FurC.Utils.GetItemLink

local strCrate = FurC.Utils.FmtCrownCrate
local strDungeon = FurC.Utils.FmtDungeon
local strEvent = FurC.Utils.FormatEvent
local strGeneric = FurC.Utils.FmtGeneric
local strPartOf = FurC.Utils.FormatPartOf
local strPrice = FurC.Utils.FormatPrice
local strFurnisher = FurC.Utils.FormatFurnisher
local strQuest = FurC.Utils.FmtQuest
local strSrc = FurC.Utils.FmtSources

local srcChest = GetString(SI_FURC_SRC_CHESTS)
local srcCraft = GetString(SI_FURC_SRC_CRAFTING)
local srcDrop = GetString(SI_FURC_SRC_DROP)
local srcDung = GetString(SI_FURC_SRC_DUNG)
local srcFish = GetString(SI_FURC_SRC_FISH)
local srcHarvest = GetString(SI_FURC_SRC_HARVEST)
local srcPick = GetString(SI_FURC_SRC_PICK)
local srcSafe = GetString(SI_FURC_SRC_SAFEBOX)
local srcSteal = GetString(SI_FURC_SRC_STEAL)
local srcDaily = GetString(SI_FURC_SRC_QUEST_DAILY)
local srcTot = GetString(SI_FURC_SRC_TOT)

local rarityExtremely = GetString(SI_FURC_RARITY_EXTREMELYRARE)
local rarityRare = GetString(SI_FURC_RARITY_RARE)

local function strChests(...)
  return strGeneric(srcChest, nil, "loc", ...)
end

local _strScry = FurC.Utils.FmtScrying
local function strScry(pieces, ...)
  if type(pieces) == "number" then
    return _strScry(pieces, nil, ...)
  end

  return _strScry(0, nil, pieces, ...)
end

local function strScryWithInfo(pieces, info, ...)
  if type(pieces) == "string" then
    return _strScry(0, pieces, info, ...)
  end

  return _strScry(pieces, info, ...)
end

-- Quests and Guilds
local tribute = strGeneric(srcTot)
local tribute_ranked = strGeneric(srcTot, GetString(SI_FURC_REWARD_RANKED_MAIL))
local db_poison = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local db_sneaky = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))
local db_equip = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_EQUIP))

--- TODO maybe: add reward coffers to containers in Constants

-- reward boxes: 126030, 126031
local daily_ashlander = strGeneric(srcDaily, getItemLink(126030), "loc", loc.VVARDENFELL, loc.VVARDENFELL_ALDRUHN)
-- reward box: 145568 Tribal Treasure Crate
local daily_murk = strGeneric(srcDaily, getItemLink(145568), "loc", loc.MURKMIRE)

-- Events
local ev_blackwood = strEvent(events.BLACKWOOD)
local ev_hollowjack = strEvent(events.HOLLOWJACK)
local ev_elsweyr = strEvent(events.ELSWEYR)

-- Stealing
local stealable = strGeneric(srcSteal)
local stealable_guard = strGeneric(srcPick, strSrc("other", npc.CLASS_GUARD))
local stealable_cc = strGeneric(srcSteal, nil, "loc", loc.CWC)
local stealable_scholars = strGeneric(srcPick, strSrc("other", npc.CLASS_SCHOLAR))
local stealable_nerds = strGeneric(srcPick, strSrc("other", npc.CLASS_MAGE, npc.CLASS_SCHOLAR))
local stealable_thief = strGeneric(srcPick, strSrc("other", npc.CLASS_THIEF))
local stealable_noble = strGeneric(srcPick, strSrc("other", npc.CLASS_NOBLE))
local stealable_swamp = strGeneric(srcSteal, nil, "loc", loc.MURKMIRE)
local stealable_elsewhere = strGeneric(srcSteal, nil, "other", loc.NELSWEYR, loc.SELSWEYR)
local pickpocket_necrom = strGeneric(srcPick, nil, "other", loc.TELVANNI, loc.APOCRYPHA)
local pickpocket_summerset = strGeneric(srcPick, nil, "other", loc.SUMMERSET)
local pickpocket_weald = strGeneric(srcPick, nil, "other", loc.WEALD)
local pickpocket_solstice = strGeneric(srcPick, nil, "other", loc.SOLSTICE)
local pickpocket_glenumbra = strGeneric(srcPick, nil, "other", loc.GLENUMBRA)
local painting_summerset = strGeneric(srcSafe, rarityExtremely, "loc", loc.SUMMERSET)
local painting_vvardenfell = strGeneric(
  srcDrop,
  string.format("%s, %s", strSrc("other", srcChest, srcSafe), rarityExtremely),
  "loc",
  loc.VVARDENFELL
)

-- Looting/Harvesting
local automaton_loot_cc = strGeneric(srcDrop, npc.ENEMY_AUTOMATON, nil, loc.CWC)
local automaton_loot_vv = strGeneric(srcDrop, strSrc("other", npc.ENEMY_AUTOMATON), "loc", loc.VVARDENFELL)
local book_hall = strGeneric(srcDung, "vault chests", nil, loc.DUNG_SCRIV)
local chestsGeneral = strGeneric(srcChest)
local chests_blackr_grcaverns = strChests(loc.BLACKREACH_GMC)
local chests_blackwood = strChests(loc.BLACKWOOD)
local chests_elsweyr = strGeneric(srcChest, nil, "other", loc.NELSWEYR, loc.SELSWEYR)
local chests_high = strChests(loc.HIGHISLE)
local chests_necrom = strGeneric(srcChest, nil, "other", loc.TELVANNI, loc.APOCRYPHA)
local chests_skyrim = strChests(loc.WSKYRIM)
local chests_summerset = strChests(loc.SUMMERSET)
local fishing = strGeneric(srcFish)
local fishing_summerset = strGeneric(srcFish, nil, nil, loc.SUMMERSET)
local fishing_swamp = strGeneric(srcFish, nil, "loc", loc.MURKMIRE)
local fishing_solstice = strGeneric(srcFish, nil, nil, loc.SOLSTICE)

local painting_vvardenfell_chests = strGeneric(srcChest, rarityExtremely, nil, loc.VVARDENFELL)
local summerset_clamsngeysers = strGeneric(
  srcDrop,
  strSrc("other", GetString(SI_FURC_SRC_CLAM_GIANT), GetString(SI_FURC_SRC_GEYSER)),
  "loc",
  loc.SUMMERSET
)
local elfpic = strGeneric(srcChest, rarityRare, nil, loc.SUMMERSET)
local vvardenfell_tombsruins =
  strGeneric(srcDrop, strSrc("other", GetString(SI_FURC_TOMBS), GetString(SI_FURC_RUINS)), nil, loc.VVARDENFELL)

local nymic = strDungeon(srcChest, loc.DUNG_NYMIC)
local pdung_vv_fw = strGeneric(srcDrop, nil, "loc", loc.VVARDENFELL, loc.PDUNG_VVARDENFELL_FW)
local plants_vvardenfell = strGeneric(srcHarvest, nil, "loc", loc.VVARDENFELL)
local inf_archive = strDungeon(nil, loc.DUNG_IA)
local frostvault = strDungeon(rarityRare, loc.DUNG_FV)
local plants_solstice = strGeneric(srcHarvest, nil, "loc", loc.SOLSTICE)

-- "Part of the item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold"
local collection_nothingeyes =
  strPartOf(145596, zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY)))

local join = zo_strjoin
local function strMultiple(...)
  return join(" + ", ...)
end

-- Trade Bars
local function strTBars(price)
  return strPrice(price, CURT_TRADE_BARS)
end

local srcBazaar = GetString(SI_FURC_SRC_BAZAAR)
local function strBazaar(price)
  return string.format("%s: %s", srcBazaar, strPrice(price, CURT_TRADE_BARS))
end
local itempacks = {
  ["dawn"] = SI_FURC_TOMESPACK_DAWN,
  ["logic"] = SI_FURC_TOMESPACK_LOGIC,
  ["armor"] = SI_FURC_TOMESPACK_ARMOR,
}
local function strTomesPack(itempackName)
  itempackName = string.lower(itempackName)
  return zo_strformat(GetString(SI_FURC_SRC_TOMESPACK), GetString(itempacks[itempackName]))
end

-- Season Zero Part 2
FurC.MiscItemSources[ver.ZERO2] = {
  [src.DROP] = {
    -- Scrying
    [224855] = strScry(loc.GLENUMBRA), -- Fool's Gold Pile
    [224857] = strScry(loc.GLENUMBRA), -- Window of Divinity
    [224858] = strScry(loc.GLENUMBRA), -- Zenithar Devotional Stele
    [224856] = strScry(loc.GLENUMBRA), -- Tapestry of the Prince's Hunt
  },

  [src.JUSTICE] = {
    [225017] = pickpocket_glenumbra, -- Keg Spigot, Brass
    [225018] = pickpocket_glenumbra, -- Pin Cushion, Red
    [225019] = pickpocket_glenumbra, -- Flask, Fancy
    [225020] = pickpocket_glenumbra, -- Handbell, Brass
    [225021] = pickpocket_glenumbra, -- Pocket Whistle, Brass
    [225022] = pickpocket_glenumbra, -- Hand Mirror, Silver-Plated
    [225023] = pickpocket_glenumbra, -- Order Ledger, Business
    [225024] = pickpocket_glenumbra, -- Key, Brass
    [225025] = pickpocket_glenumbra, -- Teeba-Enoo Ball, Patchwork Leather
    [225026] = pickpocket_glenumbra, -- Chef Hat, Decorative
    [225027] = pickpocket_glenumbra, -- Cheese Crumbs, Echatere
    [225016] = pickpocket_glenumbra, -- Ore, Display
    [225015] = pickpocket_glenumbra, -- Amber Chunk, Display
  },
}

-- Season Zero
FurC.MiscItemSources[ver.ZERO] = {
  [src.DROP] = {
    -- Scrying
    [223867] = strScry(loc.COLDH), -- Bearer of Fargrave, Skeletal Jaw
    [223868] = strScry(loc.COLDH), -- Bearer of Fargrave, Broken Skull
    [223869] = strScry(loc.COLDH), -- Imperial Titan Slayer
    [223870] = strScry(loc.COLDH), -- Valenwood Skull Blocks
    [223871] = strScry(loc.COLDH), -- Hourglass of Akatosh Brace, Massive
  },

  [src.BAZAAR] = {
    [197625] = strBazaar(2000), -- Music Box, Oath of the Keepers
  },

  [src.TOMES] = {
    [224078] = strTomesPack("dawn"), -- Dusklight Rift
    [224077] = strTomesPack("dawn"), -- Dusklight Mote
    [224079] = strTomesPack("dawn"), -- Dawnlight Rift
    [224080] = strTomesPack("dawn"), -- Dawnlight Mote
    [224074] = strTomesPack("logic"), -- High Isle Fireplace, Stone
    [224076] = strTomesPack("logic"), -- Fireplace Screen, Wrought Iron
    [224075] = strTomesPack("logic"), -- Stained Glass of Julianos, Symbol
    [223996] = strTomesPack("armor"), -- Report: Quality of Recruits
    [224007] = strTomesPack("armor"), -- The Rotwood Enigma
    [224006] = strTomesPack("armor"), -- Armor of Myth and Legend
    [224005] = strTomesPack("armor"), -- Folly in Fixation
    [224003] = strTomesPack("armor"), -- Husks and Bones
    [224004] = strTomesPack("armor"), -- The Masters' Hall
    [224002] = strTomesPack("armor"), -- Azarrid's Race
    [224001] = strTomesPack("armor"), -- Settling the Debate
    [224000] = strTomesPack("armor"), -- Discomforts of War
    [223999] = strTomesPack("armor"), -- Call to the Faithful
    [223998] = strTomesPack("armor"), -- Undeniable Truths of Attire
    [223997] = strTomesPack("armor"), -- Xil-Go's Spell
  },
}

-- Seasons of the Worm Cult Part 2
FurC.MiscItemSources[ver.WORMS2] = {
  [src.DROP] = {
    -- Scrying
    [223147] = strScry(loc.SOLSTICE), -- Stone-Nest Pillar, Temple
    [223148] = strScry(loc.SOLSTICE), -- Stone-Nest Gazebo
    [223149] = strScry(loc.SOLSTICE), -- Stone-Nest Counterweight
    [223150] = strScry(loc.SOLSTICE), -- Stone-Nest Pendulum
    [223151] = strScry(loc.SOLSTICE), -- Vitrified Soul Crystal
    [223152] = strScry(loc.SOLSTICE), -- Molag Bal Statue, Fractured Arm
    [223153] = strScry(loc.SOLSTICE), -- Molag Bal Statue, Fractured Head
    [223154] = strScry(loc.SOLSTICE), -- Coldharbour Soul Furnace
    [223155] = strScry(loc.SOLSTICE), -- Daedric Gate, Coldharbour
    [223156] = strScry(loc.SOLSTICE), -- Reaper, Pattern Template
    [219870] = strScry(loc.SOLSTICE), -- Antique Map of Solstice

    [223161] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Worm Cult Tongs, Metal
    [223160] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Worm Cult Carving, Eye
    [223159] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Worm Cult Pickaxe, Mining
    [223158] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Worm Cult Hammer, Mining
    [223157] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Worm Cult Bucket, Bismuth Samples
    [223176] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Leg Armor, Arrow-Damaged
    [223177] = strGeneric(srcDrop, "mobs in public dungeons and delves", nil, loc.SOLSTICE), -- Skull, Extinct Seabeast

    -- Harvesting
    [223173] = strGeneric(srcHarvest, strSrc("src", "Woodworking"), nil, loc.SOLSTICE), -- Leaf Pile, Royal Palm
    [223172] = strGeneric(srcHarvest, strSrc("src", "Woodworking"), nil, loc.SOLSTICE), -- Leaf Pile, Thatch Palm
    [223171] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Plant, Corrupted Fanik Goc
    [223170] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Plant, Corrupted Flowering Fanik Goc
    [223169] = strGeneric(srcHarvest, strSrc("src", "Blacksmithing"), nil, loc.SOLSTICE), -- Stones, Jagged Granite Cluster
    [223168] = strGeneric(srcHarvest, strSrc("src", "Blacksmithing"), nil, loc.SOLSTICE), -- Stone, Smooth Limestone

    [223174] = strChests(loc.SOLSTICE), -- Cook's Still Life Painting, Unfinished
  },

  [src.FISHING] = {
    [223162] = fishing_solstice, -- Kelp Shelf, Small Brown
    [223163] = fishing_solstice, -- Kelp Shelf, Medium Brown
    [223164] = fishing_solstice, -- Kelp, Small Brown Pile
    [223165] = fishing_solstice, -- Kelp, Long Brown Pile
    [223167] = fishing_solstice, -- Argonian Paddle, Wooden
    [223166] = fishing_solstice, -- Knife, Fishing
  },
}

-- Feast of Shadows
FurC.MiscItemSources[ver.SHADOWS] = {}

-- Seasons of the Worm Cult // Solstice
FurC.MiscItemSources[ver.WORMS] = {
  [src.FISHING] = {
    [214461] = fishing_solstice, -- Shrimp, Display
    [214460] = fishing_solstice, -- Seahorse, Display
    [214459] = fishing_solstice, -- Oyster, Display
    [214458] = fishing_solstice, -- Mussel, Display
    [214457] = fishing_solstice, -- Lobster Claw, Display
    [214456] = fishing_solstice, -- Conch Flute, Ceremonial
    [214463] = fishing_solstice, -- Crab, Display
    [214462] = fishing_solstice, -- Snail, Display
    [214452] = fishing_solstice, -- Solstice Shell, Fossilized Nautilus
    [214453] = fishing_solstice, -- Solstice Shell, Fossilized Turritella
    [214455] = fishing_solstice, -- Solstice Shell, Fossilized Conch
  },

  [src.DROP] = {
    [211517] = strQuest(5952), -- Storm Lord Shield
    [211518] = strQuest(5952), -- Pit Daemon Shield
    [211519] = strQuest(5952), -- Fire Drake Shield
    [211520] = strQuest(5952), -- Pit Daemon Wreath
    [211521] = strQuest(5952), -- Storm Lord Wreath
    [211522] = strQuest(5952), -- Fire Drake Wreath
    [211523] = strQuest(5952), -- Storm Lord Rug, Round
    [211530] = strQuest(5952), -- Fire Drake Banner, Long
    [211531] = strQuest(5952), -- Fire Drake Banner, Short
    [211532] = strQuest(5952), -- Fire Drake Mug
    [211533] = strQuest(5952), -- Fire Drake Rug, Horizontal
    [211534] = strQuest(5952), -- Fire Drake Rug, Vertical
    [211535] = strQuest(5952), -- Pit Daemon Rug, Round
    [211536] = strQuest(5952), -- Pit Daemon Banner, Long
    [211537] = strQuest(5952), -- Pit Daemon Banner, Short
    [211538] = strQuest(5952), -- Pit Daemon Mug
    [211539] = strQuest(5952), -- Pit Daemon Rug, Horizontal
    [211540] = strQuest(5952), -- Pit Daemon Rug, Vertical
    [211525] = strQuest(5952), -- Storm Lord Mug
    [211524] = strQuest(5952), -- Storm Lord Banner, Short
    [211526] = strQuest(5952), -- Storm Lord Banner, Long
    [211527] = strQuest(5952), -- Storm Lord Rug, Horizontal
    [211529] = strQuest(5952), -- Fire Drake Rug, Round
    [211528] = strQuest(5952), -- Storm Lord Rug, Vertical

    [214363] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Turtle
    [214364] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Contemplation
    [214365] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Origins
    [214366] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Training
    [214367] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Lizard
    [214368] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Triptych
    [214369] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Sap
    [214370] = strChests(loc.SOLSTICE), -- Tide-Born Tapestry, Snake
    [214371] = strChests(loc.SOLSTICE), -- Tide-Born Reed Art, Turtle
    [214373] = strChests(loc.SOLSTICE), -- Meadow Study Painting, Unfinished
    [214372] = strChests(loc.SOLSTICE), -- Forest Study Painting, Unfinished

    -- Harvesting
    [214479] = strGeneric(srcHarvest, strSrc("src", "Blacksmithing and Jewelry"), nil, loc.SOLSTICE), -- Solstice Bismuth, Deposit II
    [214478] = strGeneric(srcHarvest, strSrc("src", "Blacksmithing and Jewelry"), nil, loc.SOLSTICE), -- Solstice Bismuth, Deposit I
    [214485] = strGeneric(srcHarvest, strSrc("src", "Clothing and Alchemy"), nil, loc.SOLSTICE), -- Plant, Pineapple
    [214482] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Fanik Goc, Sprouted
    [214480] = strGeneric(srcHarvest, strSrc("src", "Clothing and Alchemy"), nil, loc.SOLSTICE), -- Flowers, Poinsettia
    [214481] = strGeneric(srcHarvest, strSrc("src", "Clothing and Alchemy"), nil, loc.SOLSTICE), -- Flower Patch, Flame Lily
    [214483] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Flowering Gorse, Orange
    [214484] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Grass, Pampas Cluster
    [214486] = strGeneric(srcHarvest, strSrc("src", "Clothing"), nil, loc.SOLSTICE), -- Flowers, Sea Lavender Cluster
    [214487] = strGeneric(srcHarvest, strSrc("src", "Clothing and Alchemy"), nil, loc.SOLSTICE), -- Bush, Sea Lavender

    -- Scrying
    [214358] = strScry(loc.SOLSTICE), -- Solstice Bismuth, Large Tower
    [214343] = strScry(5, loc.SOLSTICE), -- Music Box, The Hermit Crab Dance
    [214355] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Skull
    [214356] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Ribs
    [214357] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Tail
    [214359] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Geometric
    [214360] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Iguana
    [214361] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Behemoth
    [214362] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Massive Skull
  },

  [src.JUSTICE] = {
    [214471] = pickpocket_solstice, -- Tide-Born Spoon, Wooden
    [214470] = pickpocket_solstice, -- Tide-Born Spatula, Wooden
    [214469] = pickpocket_solstice, -- Tide-Born Mallet, Crab
    [214468] = pickpocket_solstice, -- Tide-Born Serving Fork, Wooden
    [214467] = pickpocket_solstice, -- Tide-Born Ladle, Wooden
    [214466] = pickpocket_solstice, -- Tide-Born Knife, Kitchen
    [214465] = pickpocket_solstice, -- Tide-Born Fork, Wooden
    [214477] = pickpocket_solstice, -- Green Coconut, Display
    [214476] = pickpocket_solstice, -- Mango, Display
    [214475] = pickpocket_solstice, -- Lychee, Display
    [214474] = pickpocket_solstice, -- Lime, Display
    [214472] = pickpocket_solstice, -- Coconut, Display
    [214464] = pickpocket_solstice, -- Pineapple, Display
    [214473] = pickpocket_solstice, -- Lemon, Display
  },
}

-- 33 Fallen Banners
FurC.MiscItemSources[ver.FALLBAN] = {}

-- 32 Golden Pursuits Update 44
FurC.MiscItemSources[ver.BASE44] = {
  [src.BAZAAR] = {
    [212186] = strBazaar(2000), -- Statue, Breton Hero
    [212187] = strBazaar(2000), -- Statue, Nord Hero
    [212188] = strBazaar(2000), -- Statue, High Elf Hero
    [211303] = strBazaar(2000), -- Statue of Molag Bal, Harvester
  },

  [src.DROP] = {
    [211505] = strQuest(nil, "Tanlorin rapport"), -- Letter from Tanlorin
    [211503] = strQuest(nil, "Zerith-Var rapport"), -- Letter from Zerith-var
  },
}

-- 31 Home Tours Update 43
FurC.MiscItemSources[ver.BASE43] = {}

-- 30 Gold Road
FurC.MiscItemSources[ver.WEALD] = {
  [src.DROP] = {
    [204800] = strChests(loc.WEALD), -- Preparing to Entertain Painting, Wood
    [204801] = strChests(loc.WEALD), -- Great Chapel of Julianos Painting, Wood
    [204802] = strChests(loc.WEALD), -- Wonders of Water Painting, Wood
    [204803] = strChests(loc.WEALD), -- An Alfiq in Skingrad Painting, Metal
    [204804] = strChests(loc.WEALD), -- Arch to Ayleid Mysteries Painting, Wood
    [204805] = strChests(loc.WEALD), -- Colovian Windmill Painting, Wood
    [204806] = strChests(loc.WEALD), -- Autumn on the Gold Road Painting, Wood
    [204807] = strChests(loc.WEALD), -- A Clear Day in Colovia Painting, Metal
    [204808] = strChests(loc.WEALD), -- West Weald Adventures Painting, Metal
    [204754] = strChests(loc.WEALD), -- Sun-Gilded Vineyard Painting, Metal
    [204755] = strChests(loc.WEALD), -- Colovian Bounty Painting, Wood
    [204799] = strChests(loc.WEALD), -- The Optimism of Dogs Painting, Metal

    [204424] = strScry(loc.WEALD), -- Antique Map of West Weald
    [204423] = strScry(5, loc.WEALD), -- Music Box, Lament for the Path Not Taken
    [204618] = strScry(loc.WEALD), -- Ayleid Arch, Wide
    [204619] = strScry(loc.WEALD), -- Ayleid Window, Large
    [204620] = strScry(loc.WEALD), -- Ayleid Sculpture, Simple Tree
    [204621] = strScry(loc.WEALD), -- Ayleid Sculpture, Complex Tree
    [204622] = strScry(loc.WEALD), -- Ayleid Lens Array, Reassembled
    [204419] = strScry(loc.WEALD), -- Ayleid Sculpture, Grand Tree
    [204418] = strScry(loc.WEALD), -- Pottery, Sanguine Repaired
    [204417] = strScry(loc.WEALD), -- Fresco, Colovian Lady
    [204623] = strScry(loc.WEALD), -- Colovian Tapestry, Worn
    [204624] = strScry(loc.WEALD), -- Colovian Tapestry, Pastoral Farm
    [204625] = strScry(loc.WEALD), -- Colovian Tapestry, Fancy Gate

    [204416] = tribute, -- Saint's Wrath Tapestry, Large
    [204413] = tribute, -- Morihaus the Archer Tapestry
    [204414] = tribute, -- Morihaus the Archer Tapestry, Large
    [204415] = tribute, -- Saint's Wrath Tapestry
  },

  [src.JUSTICE] = {
    [204736] = pickpocket_weald, -- Colovian Shovel, Rough
    [204737] = pickpocket_weald, -- Colovian Rake, Rough
    [204738] = pickpocket_weald, -- Cheesemaking Sieve, Metal
    [204739] = pickpocket_weald, -- Woodworking Planer, Simple
    [204740] = pickpocket_weald, -- Beekeeping Smoker, Handheld
    [204741] = pickpocket_weald, -- Glassblowing Shears, Metal
    [204742] = pickpocket_weald, -- Corking Hammer, Metal
    [204743] = pickpocket_weald, -- Cheesemaking Whisk, Wooden
    [204744] = pickpocket_weald, -- Winemaking Cork, Metal
    [204745] = pickpocket_weald, -- Corkscrew, Metal
    [204746] = pickpocket_weald, -- Honey Dipper, Wooden
    [204747] = pickpocket_weald, -- Colovian Cheese Wheel, Wax
    [204748] = pickpocket_weald, -- Smoked Cheese Wheel, Wax
    [204749] = pickpocket_weald, -- Dawnwood Spoon, Bone
    [204750] = pickpocket_weald, -- Dawnwood Fork, Bone
    [204751] = pickpocket_weald, -- Dawnwood Knife, Bone
    [204752] = pickpocket_weald, -- Dawnwood Serving Fork, Bone
    [204753] = pickpocket_weald, -- Dawnwood Carving Knife, Bone
    [204836] = pickpocket_weald, -- Colovian Wine Basket, Plain
  },
}

-- 29 Scions of Ithelia
FurC.MiscItemSources[ver.SCIONS] = {}

-- 28 Secrets of the Telvanni
FurC.MiscItemSources[ver.ENDLESS] = {
  [src.DROP] = {
    [203472] = inf_archive, -- Materials for Novice Necromancers
    [203471] = inf_archive, -- The Spotted Towers
    [203470] = inf_archive, -- Song of Fate
    [203469] = inf_archive, -- House Telvanni Song
    [203468] = inf_archive, -- The Waiting Door
    [203467] = inf_archive, -- Captain Burwarah's Records
    [203466] = inf_archive, -- The Silver Rose Blooms over Borderwatch
    [203465] = inf_archive, -- Archmagister Mavon's Ascension
    [203464] = inf_archive, -- Fynboar the Resurrected
    [203463] = inf_archive, -- Obscure Killers of the North
    [203462] = inf_archive, -- The Remnant Truth
    [203461] = inf_archive, -- Parables of Saint Vorys
    [203460] = inf_archive, -- Malkhest's Journal
    [203459] = inf_archive, -- A Servant's Tale
    [203458] = inf_archive, -- The Last Addition of Bikkus-Muz
    [203457] = inf_archive, -- Preparing Necrom Kwama, Fifth Draft
    [203456] = inf_archive, -- The Prior's Fulcrum
    [203455] = inf_archive, -- Plague Concoctor's Instructions
    [203454] = inf_archive, -- Dusksaber Report
    [203453] = inf_archive, -- Mouth Vabdru's Journal
    [203452] = inf_archive, -- First Mate Dalmir's Log
    [203451] = inf_archive, -- Fanlyrion's Journal
    [203450] = inf_archive, -- Tidefall Cantos I
    [203449] = inf_archive, -- Our Dunmer Heritage
    [203448] = inf_archive, -- A Feast Among the Dead, Chapter IV
    [203447] = inf_archive, -- A Feast Among the Dead, Chapter III
    [203446] = inf_archive, -- A Feast Among the Dead, Chapter II
    [203445] = inf_archive, -- What's an Arcanist? Part 1
    [203444] = inf_archive, -- What's an Arcanist? Part 2
    [203443] = inf_archive, -- Working in the Infinite Panopticon
    [203442] = inf_archive, -- What About Glyphics?
    [203441] = inf_archive, -- On Cipher's Midden
    [203440] = inf_archive, -- The Littlest Tomeshell
    [203439] = inf_archive, -- A New Cult Arises
    [203438] = inf_archive, -- Torvesard's Journal
    [203437] = inf_archive, -- Daedric Worship and the Dark Elves
    [203436] = inf_archive, -- Ciphers of the Eye
    [203435] = inf_archive, -- Planar Exploration Vol. 14: Darkreave Curators
    [203434] = inf_archive, -- Beverages for the Bereaved
    [203433] = inf_archive, -- Denizens of Apocrypha
    [203432] = inf_archive, -- History of Necrom: The City of the Dead
    [203431] = inf_archive, -- Brave Little Scrib and the River Troll
    [203430] = inf_archive, -- A Brief History of House Telvanni
    [203429] = inf_archive, -- A Feast Among the Dead, Chapter I
    [203428] = inf_archive, -- Visitor's Guide: Telvanni Peninsula
    [203427] = inf_archive, -- Critter Dangers: Telvanni Peninsula
    [203426] = inf_archive, -- We Reject the Pact
    [203425] = inf_archive, -- Our Puny Allies
    [203424] = inf_archive, -- The Spires of the 34th Sermon
    [203423] = inf_archive, -- Master of the Tides of Fate
    [203422] = inf_archive, -- On the Nature of Nymics
    [203421] = inf_archive, -- The Dangers of Truth
    [203420] = inf_archive, -- A Summoner's Guide to Nymics
    [203419] = inf_archive, -- Kynmarcher Strix's Journal
    [203418] = inf_archive, -- Life in the Camonna Tong
    [203417] = inf_archive, -- Herma-Mora: The Woodland Man?
    [203416] = inf_archive, -- How Rajhin Stole the Book that Knows
    [203415] = inf_archive, -- On Tracts Perilous
    [203414] = inf_archive, -- Uluscant's Manifesto
    [203413] = inf_archive, -- The Currency of Secrets
    [203412] = inf_archive, -- On Joining the Keepers of the Dead
    [203411] = inf_archive, -- A Report on the Dusksabers
    [203410] = inf_archive, -- Ranks and Titles of House Telvanni
    [203409] = inf_archive, -- Oath of the Keepers
    [203408] = inf_archive, -- Larydeilmo is Sane
    [203211] = inf_archive, -- Apocrypha Crescent
    [203210] = inf_archive, -- Apocrypha Spike, Curved
    [203209] = inf_archive, -- Apocrypha Spike, Tall
    [203208] = inf_archive, -- Apocrypha Pipe, Small
    [203207] = inf_archive, -- Apocrypha Pipe, Small Curved
    [203206] = inf_archive, -- Apocrypha Pipe, Medium
    [203204] = inf_archive, -- Apocrypha Pipe, Large Curved

    [203407] = strChests(loc.WROTHGAR), -- Vosh Rakh
    [203406] = strChests(loc.WROTHGAR), -- Vorgrosh Rot-Tusk's Guide to Dirty Fighting
    [203405] = strChests(loc.WROTHGAR), -- Orc Clans and Symbology
    [203404] = strChests(loc.WROTHGAR), -- Birds of Wrothgar

    [203403] = chests_summerset, -- The Ubiquitous Sinking Isle
    [203402] = chests_summerset, -- The Truth of Minotaurs
    [203401] = chests_summerset, -- The Flight of Gryphons
    [203400] = chests_summerset, -- Artaeum Lost

    [203399] = strChests(loc.SELSWEYR), -- The Marriage of Moon and Tide
    [203398] = strChests(loc.SELSWEYR), -- The Favored Daughter of Fadomai
    [203397] = strChests(loc.SELSWEYR), -- Khunzar-ri and the Lost Alfiq
    [203396] = strChests(loc.SELSWEYR), -- Azurah's Crossing
    [203395] = strChests(loc.SELSWEYR), -- Trail and Tide
    [203394] = strChests(loc.SELSWEYR), -- The Angry Alfiq: A Collection
    [203393] = strChests(loc.SELSWEYR), -- On Those Who Know Baan Dar
    [203392] = strChests(loc.NELSWEYR), -- Anequina and Pellitine: An Introduction
    [203391] = strChests(loc.HEWSBANE), -- The Red Curse, Volume 3
    [203390] = strChests(loc.HEWSBANE), -- The Red Curse, Volume 2
    [203389] = strChests(loc.HEWSBANE), -- The Red Curse, Volume 1
    [203388] = strChests(loc.GOLDCOAST), -- The Wolf and the Dragon
    [203387] = strChests(loc.GOLDCOAST), -- The Blade of Woe
    [203386] = strChests(loc.GOLDCOAST), -- On Minotaurs
    [203385] = strChests(loc.GOLDCOAST), -- Cathedral Hierarchy
    [203384] = strChests(loc.COLDH), -- Journal of Tsona-Ei, Part Two
    [203383] = strChests(loc.COLDH), -- Journal of Tsona-Ei, Part Three
    [203382] = strChests(loc.COLDH), -- Journal of Tsona-Ei, Part One
    [203381] = strChests(loc.COLDH), -- Journal of Tsona-Ei, Part Four
    [203380] = strChests(loc.CWC), -- Worshiping the Illogical
    [203379] = strChests(loc.CWC), -- The Blackfeather Court
    [203378] = strChests(loc.CWC), -- Engine of Expression
    [203377] = strChests(loc.CWC), -- A Brief History of Ald Sotha

    [199117] = tribute, -- Chromatic Reservoir Tapestry, Large
    [199116] = tribute, -- Chromatic Reservoir Tapestry
    [199115] = tribute, -- Seeker Aspirant Tapestry, Large
    [199114] = tribute, -- Seeker Aspirant Tapestry

    [199933] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Scrying Brazier, Tall
    [199932] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Scrying Brazier, Short
    [199890] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Archival Light Diffuser, Large
    [199132] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Tree
    [199131] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Wall Beast
    [199130] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Slug
    [199129] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Ribcage
    [199128] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Watchful Light
    [199127] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Petrified Watcher
    [199126] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Forged Black Book
    [199119] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Infinite Tome
    [199118] = strScry(5, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Clothing Station
    [198576] = strScry(loc.DEADLANDS), -- Shelf, Black Soul Gems
    [198575] = strScry(loc.SELSWEYR), -- Khajiiti Well
    [198574] = strScry(loc.NELSWEYR), -- Khajiiti Water Vessel, Large
    [198573] = strScry(loc.SUMMERSET), -- High Elf Altar, Crystal
    [198572] = strScry(loc.CWC), -- Clockwork Wall Gears
    [198571] = strScry(loc.GOLDCOAST), -- Shrine to Dibella
    [198570] = strScry(loc.SHADOWFEN), -- Painted Stone Frog
    [198569] = strScry(loc.DESHAAN), -- Dark Elf Altar, Ceremonial
    [198568] = strScry(loc.ALIKR), -- Stone Relief, Yokudan
    [198567] = strScry(loc.GLENUMBRA), -- Breton Well, Storm Grey
    [198566] = strScry(loc.REAPER), -- Khajiiti Arch, Rising
    [198325] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Vision of Mora
    [197916] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Archival Light Diffuser, Small
  },
}

-- 27 QOL Base Game Update
FurC.MiscItemSources[ver.BASED] = {}

-- 26 Necrom
FurC.MiscItemSources[ver.NECROM] = {
  [src.DROP] = {
    [197921] = nymic, -- Peryite's Salvation
    [197920] = nymic, -- The Doom of the Hushed
    [197919] = nymic, -- The Legend of Fathoms Drift
    [197918] = nymic, -- Deal with a Daedric Prince
    [197917] = nymic, -- Ode to Vaermina

    [197783] = chests_necrom, -- Pilgrimage Triptych Painting, Wood
    [197782] = chests_necrom, -- Alleyway Still Life Painting
    [197781] = chests_necrom, -- The City of Necrom Painting, Wood
    [197780] = strQuest(nil, "Sharp-as-Night rapport"), -- Letter from Sharp
    [197779] = strQuest(nil, "Azandar's rapport"), -- Letter from Azandar
    [197755] = chests_necrom, -- Shadow over Necrom Painting
    [197754] = chests_necrom, -- Offerings to the Dead Painting, Wood
    [197753] = chests_necrom, -- Telvanni Peninsula Painting, Wood
    [197752] = chests_necrom, -- Mycoturge's Retreat Painting, Wood
    [197751] = chests_necrom, -- Sunset Fleet Painting, Wood
    [197750] = chests_necrom, -- Telvanni Mushroom Spire Painting, Wood
    [197749] = chests_necrom, -- Necrom Still Life Painting, Wood

    [197829] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Music Box, Glyphic Secrets
    [197712] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of Apocrypha
    [197711] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of the Telvanni Peninsula
    [197710] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Mushroom Classification Book
    [197709] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Tribunal Window, Stained Glass
    [197708] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Cliffracer Skeleton Stand
    [197707] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Apocryphal Well
    [197706] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Trifold Mirror of Alternatives
    [197705] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Telvanni Alchemy Station
    [197703] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Arch
    [197702] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Worm
    [197701] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Nautilus
    [197700] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Bones Large

    [193786] = tribute, -- Mercymother Elite Tribute Tapestry
    [193785] = tribute, -- Mercymother Elite Tribute Tapestry, Large
    [193784] = tribute, -- Hand of Almalexia Tribute Tapestry
    [193783] = tribute, -- Hand of Almalexia Tribute Tapestry, Large
  },

  [src.JUSTICE] = {
    [197647] = pickpocket_necrom, -- Telvanni Knife, Bread
    [197646] = pickpocket_necrom, -- Telvanni Knife, Wooden
    [197645] = pickpocket_necrom, -- Telvanni Fork, Wooden
    [197644] = pickpocket_necrom, -- Telvanni Spoon, Wooden
  },
}

-- 25 Scribes of Fate
FurC.MiscItemSources[ver.SCRIBE] = {
  [src.DROP] = {
    [194460] = book_hall, -- Apocrypha, Apocrypha
    [194459] = book_hall, -- Dream of a Thousand Dreamers
    [194458] = book_hall, -- Lord Hollowjack's Dream Realm
    [194456] = book_hall, -- Invocation of Hircine
    [194455] = book_hall, -- Havocrel: Strangers from Oblivion
    [194454] = book_hall, -- The Waters of Oblivion
    [194453] = book_hall, -- A Memory Book, Part 1
    [194452] = book_hall, -- A Memory Book, Part 2
    [194451] = book_hall, -- A Memory Book, Part 3
    [194450] = book_hall, -- Thwarting the Daedra: Dagon's Cult
    [194449] = book_hall, -- In Dreams We Awaken
    [194448] = book_hall, -- Glorious Upheaval
    [194447] = book_hall, -- Stonefire Ritual Tome
    [194446] = book_hall, -- Bisnensel: Our Ancient Roots
    [194445] = book_hall, -- Boethiah and Her Avatars
    [194444] = book_hall, -- Persistence of Daedric Veneration
    [194443] = book_hall, -- Daedra Dossier: The Titans
    [194442] = book_hall, -- Journal of Culanwe
    [194441] = book_hall, -- Graccus' Journal, Volume I
    [194440] = book_hall, -- Tome of Daedric Portals
    [194439] = book_hall, -- The Journal of Emperor Leovic
    [194423] = book_hall, -- Hermaeus Mora Banner, Long
    [194422] = book_hall, -- Hermaeus Mora Banner, Extra Long
    [194421] = book_hall, -- Nesting Boulder, Green
    [194420] = book_hall, -- Nesting Stones, Green
    [194419] = book_hall, -- Scrivener's Hall Vault Door
  },
}

-- 24 Firesong
FurC.MiscItemSources[ver.DRUID] = {
  [src.DROP] = {
    [192432] = strScry(3, loc.GALEN), -- Shipbuilder's Woodworking Station
    [192431] = strScry(loc.GALEN), -- Antique Map of Galen
    [192430] = strScry(loc.GALEN), -- Vulk'esh Egg

    [192404] = tribute, -- Forest Wraith Tribute Tapestry, Large
    [192403] = tribute, -- Forest Wraith Tribute Tapestry
    [192402] = tribute, -- The Chimera Tribute Tapestry, Large
    [192401] = tribute, -- The Chimera Tribute Tapestry
    [190938] = strScry(5, loc.GALEN), -- Music Box, Blessings of Stone
    [187922] = strScry(loc.FARGRAVE), -- Antique Map of Fargrave
  },
}

-- 23 Lost Depths
FurC.MiscItemSources[ver.DEPTHS] = {
  [src.DROP] = {
    [187807] = tribute_ranked, -- Tribute Trophy, Voidsteel
    [187806] = tribute_ranked, -- Tribute Trophy, Quicksilver
    [187805] = tribute_ranked, -- Tribute Trophy, Ebony
    [187804] = tribute_ranked, -- Tribute Trophy, Orichalcum
  },
}

-- 22 High Isle
FurC.MiscItemSources[ver.BRETON] = {
  [src.DROP] = {
    [188285] = tribute, -- Serpentguard Rider Tribute Tapestry, Large
    [188284] = tribute, -- Serpentguard Rider Tribute Tapestry
    [188283] = tribute, -- Pyandonean War Fleet Tribute Tapestry, Large
    [188282] = tribute, -- Pyandonean War Fleet Tribute Tapestry
    [188281] = tribute, -- Prowling Shadow Tribute Tapestry, Large
    [188280] = tribute, -- Prowling Shadow Tribute Tapestry
    [188279] = tribute, -- Knight Commander Tribute Tapestry, Large
    [188278] = tribute, -- Knight Commander Tribute Tapestry
    [188277] = tribute, -- Hlaalu Councilor Tribute Tapestry, Large
    [188276] = tribute, -- Hlaalu Councilor Tribute Tapestry
    [188275] = tribute, -- Hagraven Matron Tribute Tapestry, Large
    [188274] = tribute, -- Hagraven Matron Tribute Tapestry
    [188273] = tribute, -- Blackfeather Knight Tribute Tapestry, Large
    [188272] = tribute, -- Blackfeather Knight Tribute Tapestry
    [188202] = strQuest(nil, "Isobel rapport"), -- Letter From Isobel
    [188201] = strQuest(nil, "Ember rapport"), -- Letter From Ember
    [187877] = chests_high, -- Gates of Gonfalon Bay Painting, Wood
    [187876] = chests_high, -- Gonfalon Colossus Painting, Wood
    [187875] = chests_high, -- Tor Draioch Towers Painting, Wood
    [187874] = chests_high, -- Masted Behemoth Painting, Wood
    [187873] = chests_high, -- Abecean Bounty Painting, Wood
    [187872] = chests_high, -- Light's Warning Painting, Wood
    [187871] = chests_high, -- High Isle Seahome Painting, Metal
    [187870] = chests_high, -- Gifts of the Sun Painting, Metal
    [187869] = chests_high, -- Noble Still Life Painting, Metal
    [187868] = chests_high, -- Ascendant Silence Painting, Metal
    [187808] = tribute_ranked, -- Tribute Trophy, Rubedite
    [187802] = strScry(loc.HIGHISLE), -- Druidic Provisioning Station
    [187801] = strScry(loc.HIGHISLE), -- Sea Elf Galleon Helm
    [187800] = strScry(loc.HIGHISLE), -- Draoife Storystone
    [187799] = strScry(loc.HIGHISLE), -- Antique Map of High Isle
  },
}

-- 21 Ascending Tide
FurC.MiscItemSources[ver.TIDES] = {}

-- 20 Deadlands
FurC.MiscItemSources[ver.DEADL] = {
  [src.DROP] = {
    [178694] = ev_blackwood, -- Target Ogrim
    [166960] = "From combining Stone Husk Fragments from the Labyrinthian in Western Skyrim", -- Target Stone Husk

    [182302] = strScry(3, loc.DEADLANDS), -- Daedric Enchanting Station
    [175728] = strScry(loc.BLACKWOOD), -- Z'en Idol
    [175729] = strScry(loc.BLACKWOOD), -- Kothringi Tidal Canoe
    [178459] = strScry(loc.BLACKWOOD), -- Antique Map of Blackwood
    [183196] = strScry(loc.DEADLANDS), -- Antique Map of the Deadlands
    [171431] = strScry(loc.REACH), -- Antique Map of the Reach
    [165992] = strScry(loc.WSKYRIM), -- Antique Map of Western Skyrim
    [163431] = strScry(3, loc.ANY), -- Music Box, Aldmeri Symphonia "in dreams and memories"
    [182303] = strScry(loc.DEADLANDS), -- Dagon's Scalding Gibbet
    [165863] = strScry(loc.GRAHTWOOD), -- St. Alessia, Paravant

    [178442] = chests_blackwood, -- Idylls of Gideon Painting, Wood
    [178443] = chests_blackwood, -- Path of Eternity Painting, Wood
    [178444] = chests_blackwood, -- A Study in Structure Painting, Wood
    [178445] = chests_blackwood, -- Leyawiin at Night Painting, Wood
    [178446] = chests_blackwood, -- Fire-Shaped Shadows Painting, Silver
    [178447] = chests_blackwood, -- Music in Repose Painting, Silver
    [178448] = chests_blackwood, -- Undying Light Painting, Silver
    [178449] = chests_blackwood, -- The Legacy of Kaladas Painting, Wood
    [178450] = chests_blackwood, -- Harvest's Gifts Painting, Wood
    [178451] = chests_blackwood, -- Reverence's Mandate Painting, Wood
    [145595] = strGeneric(srcHarvest, strSrc("src", getItemName(145595)), nil, loc.MURKMIRE), -- Scuttlebloom
    [147644] = frostvault, -- Palisade, Crude
    [147642] = frostvault, -- Boar Totem, Balance
    [147643] = frostvault, -- Boar Totem, Solitary
    [163432] = string.format("%s %s", formatAchievement(2669, true), strSrc("loc", loc.WSKYRIM)), -- Music Box, Merry Mead Maker ; Achievement
    [166027] = strGeneric(srcDrop, "chaurus mobs", nil, loc.BLACKREACH_GMC), -- Chaurus Egg, Dormant
  },

  [src.JUSTICE] = {
    [134403] = strGeneric(srcSteal, "from wardrobes", nil, loc.HEWSBANE), -- Spool, Red Thread
  },
}

-- Waking Flame
FurC.MiscItemSources[ver.WAKE] = {}

-- 19 Blackwood
FurC.MiscItemSources[ver.BLACKW] = {}

-- 18 Flames of Ambition
FurC.MiscItemSources[ver.FLAMES] = {
  [src.DROP] = {
    [171428] = strScryWithInfo("Harrowstorms", loc.WSKYRIM, loc.REACH), -- Vampiric Stained Glass
  },
}

-- 17 Markarth
FurC.MiscItemSources[ver.MARKAT] = {
  [src.DROP] = {
    [171428] = strScryWithInfo("Harrowstorms", loc.REACH), -- Vampiric Stained Glass
    [171429] = strScry(loc.REACH), -- Red Eagle Cave Painting
  },
}

-- 16 Stonethorn
FurC.MiscItemSources[ver.STONET] = {}

-- 15 Greymoor
FurC.MiscItemSources[ver.SKYRIM] = {
  [src.JUSTICE] = {
    [165828] = strGeneric(srcSteal, nil, nil, loc.WSKYRIM), -- Life in Repose Painting, Wood
  },

  [src.DROP] = {
    [165829] = strChests(loc.NELSWEYR), -- Before the Trade Gathering Painting, Wood
    [165830] = chests_elsweyr, -- Elsweyr Vista Painting, Wood
    [165831] = strChests(loc.NELSWEYR), -- Catnap Painting, Gold
    [165832] = chests_elsweyr, -- Elsweyr Landscape Painting, Gold
    [165833] = strChests(loc.NELSWEYR), -- Elsweyr Dome Architecture Painting, Gold
    [165835] = strChests(loc.NELSWEYR), -- Painting of Khajiiti Arch, Gold
    [165836] = chests_skyrim, -- A Warm Welcome Awaits Painting, Wood
    [165837] = chests_skyrim, -- Jarl of Morthal Painting, Wood
    [165838] = chests_skyrim, -- Painting of Nord Ship, Wood
    [165839] = chests_skyrim, -- Ursine Wandering Painting, Wood
    [165826] = chests_skyrim, -- Fields of Plenty Painting, Wood
    [165827] = chests_skyrim, -- Eternal Moment Painting, Wood
    [165840] = chests_skyrim, -- The Bridge of Dragon Painting, Wood
    [165842] = chests_skyrim, -- Dockside Painting, Silver
    [165845] = chests_skyrim, -- Painting of the Arch, Silver
    [165843] = chests_skyrim, -- River's Journey Painting, Silver
    [165841] = chests_skyrim, -- Silent Solitude Painting, Silver
    [165844] = chests_skyrim, -- The Light Within Painting, Silver
    [166440] = chests_blackr_grcaverns, -- Light as Art Painting, Wood
    [166441] = chests_blackr_grcaverns, -- Gargoyle Guardians Painting, Wood
    [166449] = chests_blackr_grcaverns, -- Scion's Throne Painting, Wood
    [166442] = chests_blackr_grcaverns, -- The Deception of Light Painting, Wood
    [166438] = chests_blackr_grcaverns, -- Red Mist Blooming Painting, Wood
    [166439] = chests_blackr_grcaverns, -- Depths of Darkness Painting, Brass
    [166443] = chests_blackr_grcaverns, -- Contrasts Painting, Brass
    [166444] = chests_blackr_grcaverns, -- Luminescence Painting, Brass
    [166445] = chests_blackr_grcaverns, -- The Keep Painting, Brass
    [166447] = chests_blackr_grcaverns, -- Boon Companion, Brass
    [166448] = chests_blackr_grcaverns, -- The Scion Strides Forth Painting, Brass
    [166446] = chests_blackr_grcaverns, -- Still Life in Death Painting, Wood
    [166437] = chests_blackr_grcaverns, -- Stillness Everlasting Painting, Wood

    [165866] = strScry(loc.STONEFALLS), -- Ashen Infernace Gate
    [165859] = strScry(loc.BALFOYEN), -- The Dutiful Guar
    [165854] = strScry(loc.MURKMIRE), -- Nisswo's Soul Tender
    [165860] = strScry(loc.GRAHTWOOD), -- Eight-Star Chandelier
    [166474] = strScry(loc.CRAGLORN), -- Altar of Celestial Convergence
    [161204] = strScry(loc.WROTHGAR), -- Anvil of Old Orsinium
    [165875] = strScry(loc.BETHNIKH), -- Ayleid Lightwell
    [163705] = strScry(loc.BETHNIKH), -- Warcaller's Painted Drum
    [165848] = strScry(loc.WSKYRIM), -- Font of Auri-El
    [165870] = strScry(loc.COLDH), -- Daedric Pillar of Torment
    [166434] = strScry(loc.ALIKR), -- The Heartland
    [165876] = strScry(loc.BLEAK), -- Ruby Dragon Skull
    [161216] = strScry(loc.BALFOYEN), -- Tri-Angled Truth Altar
    [163706] = strScry(loc.STROSMKAI), -- Dwemer Star Chart
    [166013] = strScry(loc.RIFT), -- Ebony Fox Totem
    [165849] = strScry(loc.AURIDON), -- Echoes of Aldmeris
    [161206] = strScry(loc.GREENSHADE), -- Branch of Falinesti
    [165857] = strScry(loc.BLEAK), -- Brazier of Frozen Flame
    [165871] = strScry(loc.EASTMARCH), -- Carved Whale Totem
    [165864] = strScry(loc.DESHAAN), -- Blessed Dais of Mother Morrowind
    [165861] = strScry(loc.GOLDCOAST), -- Golden Idol of Morihaus
    [166473] = strScry(loc.GREENSHADE), -- Greensong Gathering Circle
    [166436] = strScry(loc.WROTHGAR), -- Tusks of the Orc-Father
    [165856] = strScry(loc.EASTMARCH), -- Sacred Chalice of Ysgramor
    [165852] = strScry(loc.VVARDENFELL), -- St. Nerevar, Moon-and-Star
    [161207] = strScry(loc.MALABAL), -- Hollowbone Wind Chimes
    [165874] = strScry(loc.GLENUMBRA), -- Jeweled Skull of Ayleid Kings
    [165867] = strScry(loc.KHENARTHI), -- Cat's Eye Prism
    [161213] = strScry(loc.REAPER), -- Sorcerer-King's Blade
    [163704] = strScry(loc.GLENUMBRA), -- Kingmaker's Trove
    [166471] = strScry(loc.BANG), -- Tall Papa's Lamp
    [161205] = strScry(loc.COLDH), -- Void-Crystal Anomaly
    [165865] = strScry(loc.STORMHAVEN), -- Beacon of Tower Zero
    [166015] = strScry(loc.KHENARTHI), -- Sweet Khenarthi's Song
    [165869] = strScry(loc.AURIDON), -- Maormeri Serpent Shrine
    [165873] = strScry(loc.GOLDCOAST), -- Meridian Sconce
    [165850] = strScry(loc.CWC), -- Mnemonic Star-Sphere
    [165853] = strScry(loc.SELSWEYR), -- Moons-Blessed Ceremonial Pool
    [165868] = strScry(loc.REAPER), -- Moonlight Mirror
    [165872] = strScry(loc.NELSWEYR), -- Stained Glass of Lunar Phases
    [166472] = strScry(loc.HEWSBANE), -- Morwha's Blessing
    [165862] = strScry(loc.NELSWEYR), -- Moth Priest's Cleansing Bowl
    [161210] = strScry(loc.SUMMERSET), -- Prismatic Sunbird Feather
    [165878] = strScry(loc.STROSMKAI), -- Dwarven Puzzle Box
    [165851] = strScry(loc.VVARDENFELL), -- Sixth House Ritual Table
    [165855] = strScry(loc.STORMHAVEN), -- Noble Knight's Rest
    [161208] = strScry(loc.RIFT), -- Rune-Carved Mammoth Skull
    [161209] = strScry(loc.SHADOWFEN), -- Nest of Shadows
    [161212] = strScry(loc.MALABAL), -- Silvenari Sap-Stone
    [166435] = strScry(loc.WSKYRIM), -- Seat of the Snow Prince
    [166451] = strScry(loc.RIVENSPIRE), -- Riven King's Throne
    [161211] = strScry(loc.RIVENSPIRE), -- Remnant of the False Tower
    [165858] = strScry(loc.ALIKR), -- Coil of Satakal
    [161215] = strScry(loc.HEWSBANE), -- Yokudan Skystone Scabbard
    [161214] = strScry(loc.CRAGLORN), -- Spellscar Shard
    [166014] = strScry(loc.SELSWEYR), -- Shrine of Boethra
    [163710] = strScry(loc.ALIKR), -- Antique Map of Alik'r Desert
    [165996] = strScry(loc.GOLDCOAST), -- Antique Map of Gold Coast
    [163727] = strScry(loc.NELSWEYR), -- Antique Map of Northern Elsweyr
    [163728] = strScry(loc.SELSWEYR), -- Antique Map of Southern Elsweyr
    [163717] = strScry(loc.AURIDON), -- Antique Map of Auridon
    [163711] = strScry(loc.BANG), -- Antique Map of Bangkorai
    [163713] = strScry(loc.DESHAAN), -- Antique Map of Deshaan
    [163707] = strScry(loc.GLENUMBRA), -- Antique Map of Glenumbra
    [163718] = strScry(loc.GRAHTWOOD), -- Antique Map of Grahtwood
    [163719] = strScry(loc.GREENSHADE), -- Antique Map of Greenshade
    [165997] = strScry(loc.HEWSBANE), -- Antique Map of Hew's Bane
    [165993] = strScry(loc.COLDH), -- Antique Map of Coldharbour
    [165994] = strScry(loc.CRAGLORN), -- Antique Map of Craglorn
    [163709] = strScry(loc.RIVENSPIRE), -- Antique Map of Rivenspire
    [163720] = strScry(loc.MALABAL), -- Antique Map of Malabal Tor
    [163715] = strScry(loc.EASTMARCH), -- Antique Map of Eastmarch
    [163716] = strScry(loc.RIFT), -- Antique Map of The Rift
    [163714] = strScry(loc.SHADOWFEN), -- Antique Map of Shadowfen
    [163721] = strScry(loc.REAPER), -- Antique Map of Reaper's March
    [163725] = strScry(loc.SUMMERSET), -- Antique Map of Summerset
    [163708] = strScry(loc.STORMHAVEN), -- Antique Map of Stormhaven
    [163712] = strScry(loc.STONEFALLS), -- Antique Map of Stonefalls
    [163724] = strScry(loc.VVARDENFELL), -- Antique Map of Vvardenfell
    [163726] = strScry(loc.MURKMIRE), -- Antique Map of Murkmire
    [163723] = strScry(loc.WROTHGAR), -- Antique Map of Wrothgar
  },

  [src.FISHING] = {},
}

-- 14 Harrowstorm
FurC.MiscItemSources[ver.HARROW] = {}

-- 13 Dragonhold
FurC.MiscItemSources[ver.DRAGON2] = {}

-- 12 Scalebreaker
FurC.MiscItemSources[ver.SCALES] = {}

-- 11 Elsweyr
FurC.MiscItemSources[ver.KITTY] = {
  [src.JUSTICE] = {
    [151892] = strGeneric(srcSteal, "from wardrobes", nil, loc.NELSWEYR), -- Elsweyr Fragrance Bottle, Moons-Blessed
    [151889] = stealable_elsewhere, -- Elsweyr Comb, Grooming
    [151893] = strGeneric(srcSteal, "from wardrobes", nil, loc.NELSWEYR), -- Elsweyr Fragrance Bottle, Moonlit Tryst
    [151899] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Pillow, Night Blues Wide
    [151898] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Pillow, Gold-Ruby Roll
    [151900] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Pillow, Gold-Ruby Throw
    [151895] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Cloth, Rolled
    [151643] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Rolling Pin, Well-Worn
    [151890] = stealable_noble, -- Elsweyr Hand Mirror, Bronze Oval
    [151891] = stealable_noble, -- Elsweyr Hand Mirror, Rectangular
    [151897] = strGeneric(srcSteal, "from cabinets and wardrobes", nil, loc.NELSWEYR), -- Elsweyr Fabric, Display
    [151886] = stealable_elsewhere, -- Elsweyr Fan, Handheld
    [151887] = stealable_elsewhere, -- Elsweyr Brush, Body
    [151888] = stealable_elsewhere, -- Elsweyr Brush, Head
    [151894] = stealable_elsewhere, -- Elsweyr Mirror, Carved Wall
  },

  [src.DROP] = {
    [153563] = ev_elsweyr, -- Target Bone Goliath, Reanimated
    [165834] = chests_elsweyr, -- A Simple Five-Claw Life Painting, Gold
  },

  [src.FISHING] = {},

  [src.BAZAAR] = {
    [153814] = strBazaar(2550), -- Dragon's Treasure Trove
  },
}

-- 10 Wrathstone
FurC.MiscItemSources[ver.WOTL] = {}

-- 9 Wolfhunter
FurC.MiscItemSources[ver.WEREWOLF] = {
  [src.DROP] = {
    [141851] = strGeneric(srcDung, nil, nil, loc.DUNG_MHK, loc.DUNG_MOS), -- Bear Skull, Fresh
    [141850] = strGeneric(srcDung, nil, nil, loc.DUNG_MHK, loc.DUNG_MOS), -- Bear Skeleton, Picked Clean
    [141847] = strGeneric(srcDung, nil, nil, loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Gnawed
    [141848] = strGeneric(srcDung, nil, nil, loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Jumbled
    [141849] = strGeneric(srcDung, nil, nil, loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Fresh

    [141921] = daily_murk, -- Murkmire Bowl, Geometric Pattern
    [141923] = daily_murk, -- Murkmire Amphora, Seed Pattern
    [141922] = daily_murk, -- Murkmire Dish, Geometric Pattern
    [141924] = daily_murk, -- Murkmire Vase, Scale Pattern
    [141925] = daily_murk, -- Murkmire Hearth Shrine, Sithis Relief
    [141926] = daily_murk, -- Murkmire Hearth Shrine, Sithis Figure
    [141920] = daily_murk, -- Murkmire Brazier, Ceremonial

    [147639] = strGeneric(srcDung, nil, nil, loc.DUNG_DOM), -- Magna-Geode
    [147640] = strGeneric(srcDung, nil, nil, loc.DUNG_DOM), -- Magna-Geode, Large
    [147641] = strGeneric(srcDung, nil, nil, loc.DUNG_DOM), -- Garlas Alpinia, Tall
  },
}

-- 8 Murkmire
FurC.MiscItemSources[ver.SLAVES] = {
  [src.JUSTICE] = {
    [145399] = stealable_swamp, -- Murkmire Rug, Crawling Serpents Worn
    [145400] = stealable_swamp, -- Murkmire Rug, Lurking Lizard Worn
    [145398] = stealable_swamp, -- Murkmire Rug, Supine Turtle Worn
    [145397] = stealable_swamp, -- Murkmire Rug, Hist Gathering Worn
    [145396] = stealable_swamp, -- Murkmire Tapestry, Hist Gathering Worn
    [145550] = strMultiple(stealable_swamp, strGeneric(srcDrop, strSrc("src", npc.ENEMY_RND), nil, loc.MURKMIRE)), -- Murkmire Hunting Lure, Grisly
    [145401] = stealable_swamp, -- Murkmire Tapestry, Xanmeer Worn
    [145403] = stealable_swamp, -- Jel Parchment
  },

  [src.DROP] = {
    [145923] = collection_nothingeyes, -- Lies of the Dread-Father
    [145926] = collection_nothingeyes, -- That of Void
    [145927] = collection_nothingeyes, -- Acts of Honoring
    [145928] = collection_nothingeyes, -- Speakers of Nothing
    [145597] = collection_nothingeyes, -- Scales of Shadow
  },

  [src.FISHING] = {
    [145402] = fishing_swamp, -- Fish, Black Marsh
  },
}

-- 7 Summerset Isles
FurC.MiscItemSources[ver.ALTMER] = {
  [src.DROP] = {
    [139073] = strQuest(6129, nil, loc.SUMMERSET, loc.LILANDRIL), -- Painting of Summerset Coast, Refined ; Quest: The Perils of Art
  },

  [src.JUSTICE] = {
    [139238] = pickpocket_summerset, -- Alinor Wall Mirror, Ornate
    [139239] = pickpocket_summerset, -- Alinor Wall Mirror, Verdant
    [139237] = pickpocket_summerset, -- Alinor Wall Mirror, Noble
    [139090] = pickpocket_summerset, -- Alinor Table Runner, Cloth of Silver
    [139089] = pickpocket_summerset, -- Alinor Table Runner, Coiled
    [139088] = pickpocket_summerset, -- Alinor Table Runner, Verdant
  },
}

-- 6 Dragon Bones
FurC.MiscItemSources[ver.DRAGONS] = {
  [src.DROP] = {
    [134909] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Puspocket Group
    [134910] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Puspocket Cluster
    [134911] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Puspocket Sporecap
    [134912] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Large Puspocket
    [134913] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Tall Puspocket
    [134914] = strDungeon(nil, loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Large Puspocket Cluster
    [139064] = strGeneric(srcHarvest, "Clothing and Alchemy", nil, loc.SUMMERSET), -- Flowers, Hummingbird Mint
    [139067] = strGeneric(srcHarvest, nil, nil, loc.SUMMERSET), -- Flower, Yellow Oleander
    [139068] = strGeneric(srcHarvest, "Clothing", nil, loc.SUMMERSET), -- Plants, Springwheeze
    [139066] = strGeneric(srcHarvest, "Alchemy", nil, loc.SUMMERSET), -- Plant, Redtop Grass
    [139065] = strGeneric(srcHarvest, "Clothing"), -- Flowers, Lizard Tail
    [139076] = chests_summerset, -- Painting of Ancient Road, Refined
    [139075] = chests_summerset, -- Painting of Sinkhole, Refined
    [139072] = elfpic, -- Painting of Monastery of Serene Harmony, Refined
    [139074] = elfpic, -- Painting of Aldmeri Ruins, Refined
    [139069] = elfpic, -- Painting of Gryphon Nest, Elegant
    [139070] = elfpic, -- Painting of College of the Sapiarchs, Refined
    [139071] = elfpic, -- Painting of High Elf Tower, Refined
    [139060] = summerset_clamsngeysers, -- Giant Clam, Ancient
    [139062] = summerset_clamsngeysers, -- Pearl, Large
    [139063] = summerset_clamsngeysers, -- Pearl, Enormous
    [139061] = summerset_clamsngeysers, -- Giant Clam, Sealed
    [139059] = strGeneric(srcDrop), -- Ivory, Polished - drops from Echatere, and probably a lot else
  },

  [src.FISHING] = {
    [139082] = fishing_summerset, -- Plants, Ruby Glasswort Patch
    [139080] = fishing_summerset, -- Coral Formation, Ancient Pillar Polyps
    [139079] = fishing_summerset, -- Coral Formation, Fan Cluster
    [139081] = fishing_summerset, -- Plant, Sea Grapes
    [139084] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139085] = fishing_summerset, -- Plant, Pearlwort
    [139077] = fishing_summerset, -- Coral Formation, Bulwark
    [139078] = fishing_summerset, -- Coral Formation, Pillar Polyps
    [139083] = fishing_summerset, -- Plants, Glasswort Patch
  },

  [src.JUSTICE] = {},
}

-- 5 Clockwork City
FurC.MiscItemSources[ver.CLOCKWORK] = {
  [src.DROP] = {
    [134407] = automaton_loot_cc, -- Factotum Torso, Obsolete
    [134404] = automaton_loot_cc, -- Factotum Knee, Obsolete
    [134408] = automaton_loot_cc, -- Factotum Elbow, Obsolete
    [134405] = automaton_loot_cc, -- Factotum Arm, Obsolete
    [134409] = automaton_loot_cc, -- Factotum Head, Obsolete
    [134406] = automaton_loot_cc, -- Factotum Body, Obsolete
    [132348] = strQuest(6075, nil, loc.CWC), -- The Precursor ; Quest: The Oscillating Son
  },

  [src.JUSTICE] = {
    [134410] = stealable_cc, -- Clockwork Crank, Miniature
    [134411] = stealable_cc, -- Clockwork Gear Shaft, Miniature
    [134412] = stealable_cc, -- Clockwork Piston, Miniature
    [134413] = stealable_cc, -- Clockwork Magnifier, Handheld
    [134414] = stealable_cc, -- Clockwork Micrometer, Handheld
    [134415] = stealable_cc, -- Clockwork Dial Calipers, Handheld
    [134416] = stealable_cc, -- Clockwork Slide Calipers, Handheld
    [134402] = stealable, -- Spool, Empty
    [134400] = stealable, -- Soft Leather, Stacked
    [134401] = stealable, -- Soft Leather, Folded
    [134417] = stealable_cc, -- Clockwork Firm-Joint Calipers, Handheld
    [134399] = stealable, -- Quality Fabric, Folded
    [117939] = strGeneric(srcPick, strSrc("src", npc.CLASS_WOODWORKER)), -- Rough Axe, Practical
  },
}

-- 4 Horns of the Reach
FurC.MiscItemSources[ver.REACH] = {
  [src.JUSTICE] = {
    [130191] = stealable, -- Shivering Cheese
    [118206] = stealable_thief, -- Gaming dice
  },

  [src.DROP] = {
    [130284] = strGeneric(srcHarvest), -- Coldharbour Glowstalk, Seedlings
    [131422] = strGeneric(srcHarvest), -- Flower Patch, Glowstalks
    [130283] = strGeneric(srcHarvest), -- Coldharbour Glowstalk, Sprout
    [130285] = strGeneric(srcHarvest), -- Coldharbour Glowstalk, Young
    [131420] = strGeneric(srcHarvest), -- Shrub, Glowing Thistle
    [130281] = strGeneric(srcHarvest), -- Coldharbour Glowstalk, Towering
    [130282] = strGeneric(srcHarvest), -- Coldharbour Glowstalk, Strong
    [130067] = strGeneric(srcDrop, strSrc("other", npc.CLASS_DAEDRA, GetString(SI_FURC_SRC_DOLMEN))), -- Daedric Chain Segment
  },
}

-- 3 Morrowind
FurC.MiscItemSources[ver.MORROWIND] = {
  [src.DROP] = {

    --Public dungeon Forgotten Wastes / maybe rarest drop at all ingame
    [127149] = pdung_vv_fw, -- Morrowind Banner of the 6th House

    -- Dwemer parts
    [126660] = automaton_loot_vv, -- Dwarven Gear, Tiered
    [126659] = automaton_loot_vv, -- Dwarven Gear, Flat

    -- lootable in tombs
    [126754] = vvardenfell_tombsruins, -- Velothi Shroud, Seeker
    [126705] = vvardenfell_tombsruins, -- Velothi Shroud, Wisdom
    [126704] = vvardenfell_tombsruins, -- Velothi Shroud, Majesty
    [126706] = vvardenfell_tombsruins, -- Velothi Shroud, Knowledge
    [126701] = vvardenfell_tombsruins, -- Velothi Shroud, Nerevar
    [126764] = vvardenfell_tombsruins, -- Velothi Shroud, Prowess
    [126702] = vvardenfell_tombsruins, -- Velothi Shroud, Reverance
    [126700] = vvardenfell_tombsruins, -- Velothi Shroud, Honor
    [126703] = vvardenfell_tombsruins, -- Velothi Shroud, Mysteries
    [126752] = vvardenfell_tombsruins, -- Velothi Shroud, Discovery
    [126755] = vvardenfell_tombsruins, -- Velothi Shroud, Change
    [126756] = vvardenfell_tombsruins, -- Velothi Shroud, Mercy
    [126773] = vvardenfell_tombsruins, -- Velothi Caisson, Crypt
    [126753] = vvardenfell_tombsruins, -- Velothi Cerecloth, Austere
    [126758] = vvardenfell_tombsruins, -- Velothi Mat, Prayer
    [126757] = vvardenfell_tombsruins,

    [126465] = painting_vvardenfell_chests, -- Telvanni Painting, Modest Volcanic
    [126466] = painting_vvardenfell_chests, -- Telvanni Painting, Modest Forest
    [126467] = painting_vvardenfell_chests, -- Telvanni Painting, Modest Valley
    [126468] = painting_vvardenfell_chests, -- Telvanni Painting, Classic Volcanic
    [126469] = painting_vvardenfell_chests, -- Telvanni Painting, Classic Forest
    [126470] = painting_vvardenfell_chests, -- Telvanni Painting, Classic Valley
    [126593] = painting_vvardenfell, -- Velothi Tryptich, Volcano
    [126594] = painting_vvardenfell, -- Velothi Painting, Classic Volcano
    [126595] = painting_vvardenfell, -- Velothi Painting, Modest Volcano
    [126596] = painting_vvardenfell, -- Velothi Tapestry, Volcano
    [126605] = painting_vvardenfell, -- Velothi Tryptich, Waterfall
    [126606] = painting_vvardenfell, -- Velothi Tapestry, Waterfall
    [126608] = painting_vvardenfell, -- Velothi Painting, Classic Waterfall
    [126609] = painting_vvardenfell, -- Velothi Painting, Modest Waterfall
    [126599] = painting_vvardenfell, -- Velothi Tryptich, Geyser
    [126600] = painting_vvardenfell, -- Velothi Tapestry, Geyser
    [126602] = painting_vvardenfell, -- Velothi Painting, Classic Geyser
    [126603] = painting_vvardenfell, -- Velothi Painting, Modest Geyser

    -- Ashlander dailies
    [126119] = daily_ashlander, -- Crimson Shard of Moonshadow
    [126393] = daily_ashlander, -- Ashlander Knife, Cheese

    -- drops from plants
    [125631] = plants_vvardenfell, -- Plants, Ash Frond
    [125544] = plants_vvardenfell, -- Fern, Strong Dusky
    [131420] = plants_vvardenfell, -- Plants, Ash Frond
    [125553] = plants_vvardenfell, -- Flowers, Netch Cabbage Stalks
    [125551] = plants_vvardenfell, -- Flowers, Netch Cabbage
    [125552] = plants_vvardenfell, -- Flowers, Netch Cabbage Patch
    [125543] = plants_vvardenfell, -- Fern, Ashen
    [125633] = plants_vvardenfell, -- Plants, Hanging Pitcher Pair
    [125680] = plants_vvardenfell, -- Vines, Ashen Moss
    [126830] = plants_vvardenfell, -- Mushrooms, Volcanic Cluster
    [125562] = plants_vvardenfell, -- Grass, Foxtail Cluster
    [125595] = plants_vvardenfell, -- Mushroom, Poison Pax Shelf
    [125596] = plants_vvardenfell, -- Mushroom, Poison Pax Stool
    [125600] = plants_vvardenfell, -- Mushroom, Spongecap Patch
    [125606] = plants_vvardenfell, -- Mushroom, Young Milkcap
    [125608] = plants_vvardenfell, -- Mushrooms, Buttercake Cluster
    [125609] = plants_vvardenfell, -- Mushrooms, Buttercake Stack
    [125613] = plants_vvardenfell, -- Mushrooms, Lavaburst Sprouts
    [125590] = plants_vvardenfell, -- Mushrooms, Lavaburst Cluster
    [125617] = plants_vvardenfell, -- Plant, Bitter Stalk
    [125618] = plants_vvardenfell, -- Plant, Golden Lichen
    [125619] = plants_vvardenfell, -- Plant, Hanging Pitcher
    [125620] = plants_vvardenfell, -- Plant, Hefty Elkhorn
    [125621] = plants_vvardenfell, -- Plant, Lava Brier
    [125622] = plants_vvardenfell, -- Plant, Lava Leaf
    [125630] = plants_vvardenfell, -- Plant, Young Elkhorn
    [125632] = plants_vvardenfell, -- Plants, Hanging Pitcher Cluster
    [125634] = plants_vvardenfell, -- Plants, Lava Pitcher Cluster
    [125635] = plants_vvardenfell, -- Plants, Lava Pitcher Shoots
    [125636] = plants_vvardenfell, -- Plants, Swamp Pitcher Cluster
    [125637] = plants_vvardenfell, -- Plants, Swamp Pitcher Shoots
    [125647] = plants_vvardenfell, -- Shrub, Bitter Brush
    [125648] = plants_vvardenfell, -- Shrub, Bitter Cluster
    [125649] = plants_vvardenfell, -- Shrub, Flowering Dusk
    [125650] = plants_vvardenfell, -- Shrub, Golden Lichen
    [125670] = plants_vvardenfell, -- Toadstool, Bloodtooth
    [125671] = plants_vvardenfell, -- Toadstool, Bloodtooth Cap
    [125672] = plants_vvardenfell, -- Toadstool, Bloodtooth Cluster

    [125597] = strGeneric(srcDrop, strSrc("src", "shroom beetles"), nil, loc.VVARDENFELL), -- Mushroom, Polyp Stinkhorn

    [126759] = strQuest(5864, nil, loc.VVARDENFELL, loc.VVARDENFELL_SURAN), -- Sir Sock's Ball of Yarn ; Quest: 'Nothing to Sneeze At'
  },

  [src.JUSTICE] = {
    [126481] = strGeneric(srcPick, strSrc("src", npc.CLASS_PRIEST, npc.CLASS_PILGRIM), loc.VVARDENFELL), -- Indoril Incense, Burning
    [126772] = stealable_thief, -- Khajiiti Ponder sphere
  },
}

-- 2 Homestead
FurC.MiscItemSources[ver.HOMESTEAD] = {
  [src.JUSTICE] = {
    [118489] = stealable_scholars, -- Papers, Stack
    [118528] = stealable, -- Signed Contract
    [118890] = stealable, -- Skull, Human
    [118487] = stealable_scholars, -- Letter, Personal
    [120008] = stealable_nerds, -- Lesser Soul Gem, Empty
    [120005] = stealable_nerds, -- Papers, Stack
    [118711] = stealable_guard, -- Argonian Male
    [118709] = stealable_guard, -- Breton Male
    [118712] = stealable_guard, -- Breton Woman
    [118715] = stealable_guard, -- Colovian Man
    [118710] = stealable_guard, -- High Elf Male
    [118714] = stealable_guard, -- Imperial Man
    [118713] = stealable_guard, -- Khajiiti Male
    [118716] = stealable_guard, -- Orc Female
    [118717] = stealable_guard, -- Orc Male
    [121055] = strGeneric(srcPick, strSrc("src", npc.CLASS_DRUNKARD)), -- Breton Mug, Full
    [116512] = strGeneric(srcSteal, nil, nil, loc.WROTHGAR), -- Orcish Carpet Blood
  },

  [src.FISHING] = {
    [118902] = fishing, -- Coral, Sun
    [118903] = fishing, -- Coral, Crown
    [118896] = fishing, -- Seashell, Sandcake
    [118901] = fishing, -- Sea sponge
    [118338] = fishing, -- Fish, Bass
    [118339] = fishing, -- Fish, Salmon
    [118337] = fishing, -- Fish, Trout
    [120753] = fishing, -- Kelp, Green Pile
    [120755] = fishing, -- Kelp, Lush Pile
    [120754] = fishing, -- Kelp, Small Pile
    [118897] = fishing, -- Seashell, Pink Scallop
    [118898] = fishing, -- Seashell, White Scallop
    [118899] = fishing, -- Seashell, Starfish
    [118900] = fishing, -- Seashell, Noble Starfish
  },

  [src.DROP] = {
    [121058] = db_sneaky, -- Candles of Silence
    [119936] = db_poison, -- Poisoned Blood
    [119938] = db_poison, -- Light and Shadow
    [119952] = db_equip, -- Sacrificial Heart

    -- Paintings
    [118216] = chestsGeneral, -- Painting of Spring, Sturdy
    [118217] = chestsGeneral, -- Painting of Pasture, Sturdy
    [118218] = chestsGeneral, -- Painting of Creek, Sturdy
    [118219] = chestsGeneral, -- Painting of Lakes, Sturdy
    [118220] = chestsGeneral, -- Painting of Crags, Sturdy
    [118221] = chestsGeneral, -- Painting of Summer, Sturdy
    [118222] = chestsGeneral, -- Painting of Jungle, Sturdy
    [118223] = chestsGeneral, -- Painting of Palms, Sturdy
    [118265] = chestsGeneral, -- Painting of Winter, Bolted
    [118266] = chestsGeneral, -- Painting of Bridge, Bolted
    [118267] = chestsGeneral, -- Painting of Autumn, Bolted
    [118268] = chestsGeneral, -- Painting of Great Ruins, Bolted
  },
}
