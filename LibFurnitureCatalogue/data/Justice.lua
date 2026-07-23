FurC.Justice = FurC.Justice or {}

local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC

local strGeneric = FurC.Utils.FmtGeneric
local strSrc = FurC.Utils.FmtSources

local join = zo_strjoin
local function strMultiple(...)
  return join(" + ", ...)
end

local srcDrop = GetString(SI_FURC_SRC_DROP)
local srcPick = GetString(SI_FURC_SRC_PICK)
local srcSteal = GetString(SI_FURC_SRC_STEAL)

-- Furnishings obtained via pickpocketing / stealing (Justice system)
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

-- Season Zero Part 2
FurC.Justice[ver.ZERO2] = {
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

-- Seasons of the Worm Cult // Solstice
FurC.Justice[ver.WORMS] = {
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

-- 30 Gold Road
FurC.Justice[ver.WEALD] = {
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

-- 26 Necrom
FurC.Justice[ver.NECROM] = {
  [src.JUSTICE] = {
    [197647] = pickpocket_necrom, -- Telvanni Knife, Bread
    [197646] = pickpocket_necrom, -- Telvanni Knife, Wooden
    [197645] = pickpocket_necrom, -- Telvanni Fork, Wooden
    [197644] = pickpocket_necrom, -- Telvanni Spoon, Wooden
  },
}

-- 20 Deadlands
FurC.Justice[ver.DEADL] = {}

-- 15 Greymoor
FurC.Justice[ver.SKYRIM] = {}

-- 11 Elsweyr
FurC.Justice[ver.KITTY] = {
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
}

-- 8 Murkmire
FurC.Justice[ver.SLAVES] = {
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
}

-- 7 Summerset Isles
FurC.Justice[ver.ALTMER] = {
  [src.JUSTICE] = {
    [139238] = pickpocket_summerset, -- Alinor Wall Mirror, Ornate
    [139239] = pickpocket_summerset, -- Alinor Wall Mirror, Verdant
    [139237] = pickpocket_summerset, -- Alinor Wall Mirror, Noble
    [139090] = pickpocket_summerset, -- Alinor Table Runner, Cloth of Silver
    [139089] = pickpocket_summerset, -- Alinor Table Runner, Coiled
    [139088] = pickpocket_summerset, -- Alinor Table Runner, Verdant
  },
}

-- 5 Clockwork City
FurC.Justice[ver.CLOCKWORK] = {
  [src.JUSTICE] = {
    [134403] = strGeneric(srcSteal, "from wardrobes", nil, loc.HEWSBANE), -- Spool, Red Thread
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
  },
}

-- 4 Horns of the Reach
FurC.Justice[ver.REACH] = {
  [src.JUSTICE] = {
    [130191] = stealable, -- The Shivering Cheese   
  },
}

-- 3 Morrowind
FurC.Justice[ver.MORROWIND] = {
  [src.JUSTICE] = {
    [126481] = strGeneric(srcPick, strSrc("src", npc.CLASS_PRIEST, npc.CLASS_PILGRIM), loc.VVARDENFELL), -- Indoril Incense, Burning
    [126772] = stealable_thief, -- Khajiit Ponder Sphere
  },
}

-- 2 Homestead
FurC.Justice[ver.HOMESTEAD] = {
  [src.JUSTICE] = {
    [117939] = strGeneric(srcPick, strSrc("src", npc.CLASS_WOODWORKER)), -- Rough Axe, Practical
	[118206] = stealable_thief, -- Gaming die
    [118489] = stealable_scholars, -- Papers, Stack
    [118528] = stealable, -- Signed Contract
    [118890] = strGeneric(srcPick, strSrc("src", npc.CLASS_CULTIST, npc.CLASS_ASSASSIN)), -- Skull, Human
    [118487] = stealable_scholars, -- Letter, Personal
    [120008] = stealable_nerds, -- Soul Gem, Lesser
    [120005] = stealable_nerds, -- Soul Gem, Common
    [118711] = stealable_guard, -- Bounty Sheet: Argonian Man
    [118709] = stealable_guard, -- Bounty Sheet: Breton Man
    [118712] = stealable_guard, -- Bounty Sheet: Breton Woman
    [118715] = stealable_guard, -- Bounty Sheet: Colovian Man
    [118710] = stealable_guard, -- Bounty Sheet: High Elf Man
    [118714] = stealable_guard, -- Bounty Sheet: Imperial Man
    [118713] = stealable_guard, -- Bounty Sheet: Khajiiti Man
    [118716] = stealable_guard, -- Bounty Sheet: Orc Woman
    [118717] = stealable_guard, -- Bounty Sheet: Orc Man
    [121055] = strGeneric(srcPick, strSrc("src", npc.CLASS_DRUNKARD)), -- Breton Mug, Full
    [116512] = strGeneric(srcSteal, nil, nil, loc.WROTHGAR), -- Orcish Carpet, Blood
  },
}