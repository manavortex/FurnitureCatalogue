FurC.Antiquities = FurC.Antiquities or {}

local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources
local loc = FurC.Constants.Locations

-- Furnishings recovered via Scrying/Excavation (Antiquities system)
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

-- 40 Season One
FurC.Antiquities[ver.THIEVES] = {
  [src.ANTIQUITY] = {
    [224855] = strScry(loc.GLENUMBRA), -- Fool's Gold Pile
    [224856] = strScry(loc.GLENUMBRA), -- Tapestry of the Prince's Hunt
	[224854] = strScry(5, loc.HEWSBANE), -- Thieves Guild Armory Station
  },
}

-- 39 Season Zero Part 2
FurC.Antiquities[ver.ZERO2] = {
  [src.ANTIQUITY] = {
    [224857] = strScry(loc.GLENUMBRA), -- Window of Divinity
    [224858] = strScry(loc.GLENUMBRA), -- Zenithar Devotional Stele
  },
}

-- 38 Season Zero
FurC.Antiquities[ver.ZERO] = {
  [src.ANTIQUITY] = {
    [223867] = strScry(loc.COLDH), -- Bearer of Fargrave, Skeletal Jaw
    [223868] = strScry(loc.COLDH), -- Bearer of Fargrave, Broken Skull
    [223869] = strScry(loc.COLDH), -- Imperial Titan Slayer
    [223870] = strScry(loc.COLDH), -- Valenwood Skull Blocks
    [223871] = strScry(loc.COLDH), -- Hourglass of Akatosh Brace, Massive
  },
}

-- 37 Seasons of the Worm Cult Part 2
FurC.Antiquities[ver.WORMS2] = {
  [src.ANTIQUITY] = {
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
	[219871] = strScry(5, loc.SOLSTICE), -- Cult Blacksmithing Station
  },
}

-- 35 Seasons of the Worm Cult // Solstice
FurC.Antiquities[ver.WORMS] = {
  [src.ANTIQUITY] = {
    [214358] = strScry(loc.SOLSTICE), -- Large Solstice Bismuth Tower
    [214343] = strScry(5, loc.SOLSTICE), -- Music Box, The Hermit Crab Dance
    [214355] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Skull
    [214356] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Ribs
    [214357] = strScry(loc.SOLSTICE), -- Solstice Giant Crocodile Tail
    [214359] = strScry(loc.SOLSTICE), -- Geometric Stone-Nest Totem
    [214360] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Iguana
    [214361] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Behemoth
    [214362] = strScry(loc.SOLSTICE), -- Stone-Nest Totem, Massive Skull
  },
}

-- 32 Home Tours
FurC.Antiquities[ver.BASE43] = {
  [src.ANTIQUITY] = {
    [208128] = strScry(10, loc.APOCRYPHA), -- Apocrypha Jewelry Crafting Station
  },
}

-- 30 Gold Road
FurC.Antiquities[ver.WEALD] = {
  [src.ANTIQUITY] = {
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
	[204420] = strScry(5, loc.WEALD), -- Ayleid Blacksmithing Station
  },
}

-- 28 Secrets of the Telvanni
FurC.Antiquities[ver.ENDLESS] = {
  [src.ANTIQUITY] = {
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
    [199118] = strScry(5, loc.TELVANNI, loc.APOCRYPHA), -- Apocryphal Clothier Station
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

-- 26 Necrom
FurC.Antiquities[ver.NECROM] = {
  [src.ANTIQUITY] = {
    [197829] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Music Box, Glyphic Secrets
    [197712] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of Apocrypha
    [197711] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of the Telvanni Peninsula
    [197710] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Mushroom Classification Book
    [197709] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Tribunal Window, Stained Glass
    [197707] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Apocryphal Well
    [197706] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Trifold Mirror of Alternatives
    [197705] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Telvanni Alchemy Station
    [197703] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Arch
    [197702] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Worm
    [197701] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Nautilus
    [197700] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Bones Large
  },
}

-- 24 Firesong
FurC.Antiquities[ver.DRUID] = {
  [src.ANTIQUITY] = {
    [192432] = strScry(3, loc.GALEN), -- Shipbuilder's Crafting Station
    [192431] = strScry(loc.GALEN), -- Antique Map of Galen
    [192430] = strScry(loc.GALEN), -- Vulk'esh Egg
    [190938] = strScry(5, loc.GALEN), -- Music Box, Blessings of Stone
  },
}

-- 22 High Isle
FurC.Antiquities[ver.BRETON] = {
  [src.ANTIQUITY] = {
    [187802] = strScry(loc.HIGHISLE), -- Druidic Provisioning Station
    [187801] = strScry(loc.HIGHISLE), -- Sea Elf Galleon Helm
    [187800] = strScry(loc.HIGHISLE), -- Draoife Storystone
    [187799] = strScry(loc.HIGHISLE), -- Antique Map of High Isle
  },
}

-- 20 Deadlands
FurC.Antiquities[ver.DEADL] = {
  [src.ANTIQUITY] = {
    [182302] = strScry(3, loc.DEADLANDS), -- Daedric Enchanting Station
    [183196] = strScry(loc.DEADLANDS), -- Antique Map of the Deadlands
    [182303] = strScry(loc.DEADLANDS), -- Dagon's Scalding Gibbet
	[197708] = strScry(loc.TELVANNI, loc.APOCRYPHA), -- Cliff Strider Skeleton Stand
	[187922] = strScry(loc.FARGRAVE), -- Antique Map of Fargrave
  },
}

-- 19 Blackwood
FurC.Antiquities[ver.BLACKW] = {
  [src.ANTIQUITY] = {
    [175729] = strScry(loc.BLACKWOOD), -- Kothringi Tidal Canoe
	[175728] = strScry(loc.BLACKWOOD), -- Z'en Idol
    [178459] = strScry(loc.BLACKWOOD), -- Antique Map of Blackwood
  },
}

-- 17 Markarth
FurC.Antiquities[ver.MARKAT] = {
  [src.ANTIQUITY] = {
    [171428] = strScryWithInfo("Harrowstorms", loc.REACH), -- Vampiric Stained Glass
	[171431] = strScry(loc.REACH), -- Antique Map of the Reach
    [171429] = strScry(loc.REACH), -- Red Eagle Cave Painting
  },
}

-- 15 Greymoor
FurC.Antiquities[ver.SKYRIM] = {
  [src.ANTIQUITY] = {
    [165866] = strScry(loc.STONEFALLS), -- Ashen Infernace Gate
	[165992] = strScry(loc.WSKYRIM), -- Antique Map of Western Skyrim
	[163431] = strScry(3, loc.ANY), -- Music Box, Dreams and Memories
	[165863] = strScry(loc.GRAHTWOOD), -- St. Alessia, Paravant
    [165859] = strScry(loc.BALFOYEN), -- The Dutiful Guar
    [165854] = strScry(loc.MURKMIRE), -- Nisswo's Soul Tender
    [165860] = strScry(loc.GRAHTWOOD), -- Eight-Star Chandelier
    [166474] = strScry(loc.CRAGLORN), -- Altar of Celestial Convergence
    [161204] = strScry(loc.WROTHGAR), -- Anvil of Old Orsinium
    [165875] = strScry(loc.BETNIKH), -- Ayleid Lightwell
    [163705] = strScry(loc.BETNIKH), -- Warcaller's Painted Drum
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
    [165864] = strScry(loc.DESHAAN), -- Blessed Dais of Almalexia
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
}