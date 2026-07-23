FurC.Rolis = FurC.Rolis or {}
FurC.RolisRecipes = FurC.RolisRecipes or {}

FurC.Faustina = FurC.Faustina or {}
FurC.FaustinaRecipes = FurC.FaustinaRecipes or {}

local ver = FurC.Constants.Versioning

local strPartOf = FurC.Utils.FormatPartOf
FurC.FurnishingFolios = FurC.FurnishingFolios or {}

local npc = FurC.Constants.NPC
local loc = FurC.Constants.Locations

FurC.RolisRecipes[ver.ZERO] = {
  [223930] = 125, -- Pattern: Worm Cult Tent, Large
  [223927] = 125, -- Sketch: Golden Skull, Argonian
  [223929] = 125, -- Praxis: Stone-Nest Fountain, Four Headed
  [223926] = 125, -- Formula: Coldharbour Focusing Lens
  [223931] = 125, -- Diagram: Worm Cult Forge, Mining
  [223928] = 125, -- Design: Shell-Tide Hatchery Altar, Replica
  [223932] = 125, -- Blueprint: Worm Cult Torture Rack
}

FurC.FaustinaRecipes[ver.ZERO] = {
  [219665] = 100, -- Blueprint: Tide-Born Hut, Elevated
  [219663] = 100, -- Design: Fruit Arrangement, Tide-Born
  [219664] = 100, -- Diagram: Naj-Caldeesh Impaler, Deactivated
  [219660] = 100, -- Formula: High Elf Castle Painting, In Progress
  [219661] = 100, -- Pattern: Vossa-Satl, Display
  [219666] = 100, -- Praxis: Stone-Nest Fountain, Triple Spout
  [219662] = 100, -- Sketch: Meridian Bell, Temple
}

-- 34 Fallen Banners
FurC.FurnishingFolios[223978] = { -- West Weald 2
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.FALLBAN,
  contents = {
	212567, -- Sketch: Guardian Key, Replica
    212566, -- Praxis: Ayleid Sconce, Winged Floor
    212565, -- Diagram: Ayleid Window, Turquoise Glass
    212564, -- Formula: Dawnwood Hut, Partial
    212563, -- Design: Colovian Grape Vat, Large
    212562, -- Blueprint: Colovian Wine Press
    212561, -- Pattern: Wood Elf Tent, Saplings
  },
}

-- 32 Home Tours
FurC.FurnishingFolios[219721] = { -- West Weald 1
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.BASE43,
  contents = {
    211039, -- Blueprint: Colovian Keg, Gigantic Wine
    211038, -- Design: Dawnwood Platter, Feast
    211034, -- Diagram: Colovian Chandelier, Grapes
    211033, -- Formula: Colovian Alembic Set, Colorful 
    211035, -- Pattern: Colovian Tapestry, Red Diamond
    211036, -- Praxis: Colovian Glassblower's Furnace 
    211037, -- Sketch: Colovian Mirror, Standing
  },
}

FurC.Faustina[ver.BASE43] = {
  [203600] = { itemPrice = 800, info = 3985 }, -- Scribing Altar
}

-- 30 Scions of Ithelia
FurC.FurnishingFolios[214255] = { -- Tomehold
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.SCIONS,
  contents = {
    203325, -- Praxis: Apocrypha Wall, Eye
    203324, -- Sketch: Apocrypha Mirror, Intricate
    203323, -- Diagram: Apocrypha Bookcase Platform
    203322, -- Pattern: Apocrypha Book Press
    203321, -- Formula: Apocrypha Light Diffuser, Stalk
    203320, -- Design: Apocrypha Tree, Spore
    203319, -- Blueprint: Pergola, Reclaimed Wood
  },
}

-- 29 Secrets of the Telvanni
FurC.Faustina[ver.ENDLESS] = {
  [203556] = { itemPrice = 1500, info = 1801 }, -- Grand Master Jewelry Station
  [203555] = { itemPrice = 1500, info = 1801 }, -- Grand Master Blacksmithing Station
  [203553] = { itemPrice = 1500, info = 1801 }, -- Grand Master Clothing Station
  [203554] = { itemPrice = 1500, info = 1801 }, -- Grand Master Woodworking Station
}

-- 27 Based
FurC.FurnishingFolios[211090] = { -- Necrom
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.BASED,
  contents = {
    198065, -- Design: Indoril Chandelier, Vine-Covered
    198064, -- Formula: Telvanni Lantern, Luminous Mushroom
    198063, -- Praxis: Necrom Crematory, Furnace
    198062, -- Blueprint: Necrom Cart, Funerary
    198061, -- Diagram: Dwarven Door, Bronze
    198060, -- Pattern: Dark Elf Tent, Multiroom
    198059, -- Sketch: Daedric Mirror, Nightmarish
  },
}

-- 26 Scribes of Fate
FurC.FurnishingFolios[204499] = { -- Galen
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.SCRIBE,
  contents = {
    194392, -- Sketch: Resonance Crystal, Cerulean
    194393, -- Forumula: Druidic Throne, Y'ffre's Bloom
    194394, -- Design: Druidic Oven, Stone
    194395, -- Pattern: Mage Tapestry, Aurbic Phoenix
    194396, -- Praxis: Stone, Lava-Etched
    194397, -- Diagram: Statue, Bronze Tentacle
    194398, -- Blueprint: Druidic Bridge, Living
  },
}

-- 24 Lost Depths
FurC.FurnishingFolios[198597] = { -- High Isle
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.DEPTHS,
  contents = {
	190075, -- Diagram: High Isle Beacon, Unlit
    190074, -- Formula: Potted Trees, Stonelore Dogwood
    190076, -- Pattern: High Isle Tapestry, Seaside Tourney
    190077, -- Praxis: High Isle Hearth, Tilework
    190078, -- Sketch: High Isle Hourglass, Gold
    190079, -- Design: Shark Jaw, Massive
	190080, -- Blueprint: High Isle Caravel, Miniature,
  },
}

-- 22 Ascending Tides
FurC.FurnishingFolios[194429] = { -- Deadlands
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.TIDES,
  contents = {
	184154, -- Blueprint: Alinor Easel, Carved
    184156, -- Design: Blackwood Provisioning Station
    184151, -- Pattern: Deadlands Tapestry, Mehrunes Dagon
    184149, -- Praxis: Deadlands Puzzle Cube
	184150, -- Diagram: Deadlands Throne
    184152, -- Formula: Fargrave Water Globules, Static
    184153, -- Sketch: Fargrave Window, Grand Medallion
  },
}

-- 20 Waking Flame
FurC.FurnishingFolios[190121] = { -- Blackwood
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.WAKE,
  contents = {
	181556, -- Diagram: Deadlands Torture Rack
    181557, -- Blueprint: Leyawiin Divider, Carved Starfish
    181558, -- Pattern: Leyawiin Tapestry, Hunting Party
    181559, -- Praxis: Leyawiin Hearth, Carved Wood
    181560, -- Design: Leyawiin Bowl, Squid Special
    181561, -- Formula: Blackwood Cottage Painting, Unframed
    181562, -- Sketch: Leyawiin Lightpost, Ornate
  },
}

-- 18 Flames of Ambition
FurC.FurnishingFolios[184192] = { -- Markarth
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.FLAMES,
  contents = {
    171803, -- Blueprint: Solitude Well, Noble
    171806, -- Design: Provisioning Station, Solitude Grill
    171801, -- Diagram: Dwarven Minecart, Ornate
    171805, -- Formula: Vampiric Cauldron, Distilled Coagulant
    171802, -- Pattern: Solitude Yarn Rack, Colorful
    171804, -- Praxis: Solitude Hearth, Rounded Tall
    171807, -- Sketch: Dwarven Crystal Sconce, Mirror
  },
}

-- 16 Stonethorn
FurC.FurnishingFolios[171808] = { -- Western Skyrim
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.STONET,
  contents = {
    167378, -- Diagram: Vampiric Chandelier, Azure Wrought-Iron
    167379, -- Pattern: Solitude Loom, Warp-Weighted
    167380, -- Blueprint: Solitude Game, Blood-on-the-Snow
    167381, -- Praxis: Ancient Nord Monolith, Head
    167382, -- Formula: Winter Cardinal Painting, In Progress
    167383, -- Design: Solitude Smoking Rack, Fish
    167384, -- Sketch: Blackreach Geode, Iridescent
  },
}

-- 14 Harrowstorm
FurC.FurnishingFolios[171778] = { -- Dragonhold
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.HARROW,
  contents = {
    159501, -- Praxis: Khajiit Sigil, Moon Cycle
    159499, -- Pattern: Elsweyr Bed, Senche-Raht
    159502, -- Formula: Elsweyr Mortar and Pestle, Engraved
    159498, -- Diagram: Elsweyr Gong, Ornate
    159503, -- Design: Elsweyr Bread Basket, Feast-Day
    159500, -- Blueprint: Elsweyr Well, Covered
    159504, -- Sketch: Elsweyr Game, Swan Stones
  },
}

-- 13 Scalebreaker
FurC.FurnishingFolios[171574] = { -- Elsweyr
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.SCALES,
  contents = {
    153731, -- Blueprint: Elsweyr Cart, Masterwork
    153729, -- Diagram: Elsweyr Gate, Masterwork
    153730, -- Pattern: Elsweyr Chaise Lounge, Upholstered
    153732, -- Praxis: Elsweyr Statue, Shrine Lion
    153733, -- Formula: Elsweyr Incense, Fragrant
    153734, -- Design: Provisioning Station, Elsweyr Grill
    153735, -- Sketch: Elsweyr Cage, Filigree
  },
}

-- 10 Wrathstone
FurC.FurnishingFolios[171573] = { -- Ebonheart
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 700,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.WOTL,
  contents = {
    147656, -- Dark Elf Tent, Canopy
    147657, -- Hlaalu Stove, Chiminea
    147651, -- Silver Kettle, Masterworked
    147652, -- Frog-Caller, Untuned
    147653, -- Pottery Wheel, Ever-Turning
    147654, -- Alchemical Apparatus, Condenser
    147655, -- Hlaalu Salt Lamp, Enchanted
  },
}

-- 9 Wolfhunter
FurC.FurnishingFolios[171572] = { -- Summerset
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 800,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.WEREWOLF,
  contents = {
    141896, -- Sketch: Figurine, The Dragon's Glare
    141902, -- Diagram: Relic Vault, Impenetrable
    141903, -- Pattern: Alinor Bed, Levitating
    141904, -- Blueprint: Alinor Bookshelf, Grand Full
    141907, -- Design: Alinor Grape Stomping Tub
    141906, -- Formula: Artist's Palette, Pigment
    141905, -- Praxis: Alinor Gaming Table, Punctilious Conflict
    139486, -- Sketch: Alinor Ancestor Clock, Celestial
  },
}

-- 6 Dragon Bones
FurC.FurnishingFolios[171571] = { -- Dark Elf
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 600,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.DRAGONS,
  contents = {
    134987, -- Blueprint: Hlaalu Gaming Table, Foxes & Felines
    134986, -- Design: Miniature Garden, Bottled
    134985, -- Praxis: Hlaalu Trinket Box, Curious Turtle
    134984, -- Pattern: Clothier's Form, Brass
    134983, -- Diagram: Hlaalu Gong
    134982, -- Formula: Alchemical Apparatus, Master
  },
}

-- 7 Summerset
FurC.Faustina[ver.ALTMER] = {
  [137947] = 250, -- Attunable Jewelry Station
  [137870] = 125, -- Jewelry Crafting Station
}

-- 6 Dragon Bones
FurC.Faustina[ver.DRAGONS] = {
  [134675] = 500, -- Outfit station
  [139391] = { itemPrice = 10, info = 1801 }, -- Master Crafter's Banner, Hanging
}

-- 5 Clockwork City
FurC.Rolis[ver.CLOCKWORK] = {
  [133576] = 1250, -- Transmute Station
}

-- 4 Reach
FurC.FurnishingFolios[171569] = { -- Morrowind
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 600,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.REACH,
  contents = {
	132195, -- Blueprint: Telvanni Candelabra, Masterwork
    132194, -- Design: Mammoth Cheese, Mastercrafted
    132193, -- Praxis: Hlaalu Bath Tub, Masterwork
    132192, -- Pattern: Dres Sewing Kit, Master's
    132191, -- Diagram: Dwarven Gyroscope, Masterwork
    132190, -- Formula: Mages Apparatus, Master
  },
}

-- 2 Homestead
FurC.FurnishingFolios[171568] = { -- Crafter's
  vendor   = npc.FAUSTINA,
  location = loc.ANY_CAPITAL,
  price    = 1100,
  currency = CURT_WRIT_VOUCHERS,
  version  = ver.HOMESTEAD,
  contents = {
	121200, -- Blueprint: Cabinet, Poisonmaker's
    121199, -- Design: Mortar and Pestle
    121197, -- Formula: Bottle, Poison Elixir
	121214, -- Design: Orcish Skull Goblet, Full
    121209, -- Pattern: Orcish Tapestry, Spear
    121207, -- Praxis: Orcish Table with Fur
    121168, -- Blueprint: Tools, Case
    121166, -- Blueprint: Podium, Skinning
    121165, -- Diagram: Apparatus, Gem Calipers
    121164, -- Formula: Case of Vials
    121163, -- Diagram: Apparatus, Boiler
  },
}

-- 2 Homestead
FurC.Rolis[ver.HOMESTEAD] = {
  [119822] = 250, -- Attunable Woodworking station
  [119821] = 250, -- Attunable Clothing station
  [119781] = 35, -- Blacksmithing station
  [119744] = 35, -- Woodworking station
  [119707] = 35, -- Clothing station
  [119594] = 250, -- Attunable Blacksmithing station
  [118330] = 35, -- Enchanting station
  [118329] = 35, -- Dye Station
  [118328] = 35, -- Alchemy station
  [118327] = 35, -- Provisioning station
}

-- 2 Homestead
FurC.RolisRecipes[ver.HOMESTEAD] = {
  [126583] = 450, -- Praxis: Target Centurion, Robust Refabricated
  [126582] = 275, -- Praxis: Target Centurion, Dwarf-Brass
  [121315] = 200, -- Praxis: Target Skeleton, Robust Humanoid
  [119592] = 125, -- Praxis: Target Skeleton, Humanoid
}
