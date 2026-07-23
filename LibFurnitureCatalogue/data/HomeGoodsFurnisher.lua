FurC.AchievementVendors = FurC.AchievementVendors or {}

local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local ver = FurC.Constants.Versioning

local merge = FurC.Utils.MergeTable

-- Home Goods Furnisher: generic gold-purchase furnishings sold in every zone, no achievement gating.

local furnishingVendor = {
  [120998] = { -- Block, Wood Cutting
    itemPrice = 100,
  },
  [117994] = { -- Rough Block, Stone Slab
    itemPrice = 100,
  },
  [117971] = { -- Rough Clothesline, Post
    itemPrice = 100,
  },
  [117980] = { -- Rough Firewood, Fireplace
    itemPrice = 100,
  },
  [117982] = { -- Rough Firewood, Stack
    itemPrice = 100,
  },
  [117977] = { -- Rough Stool, Round
    itemPrice = 100,
  },
  [117990] = { -- Tea Table, Carved
    itemPrice = 250,
  },
}

local morrowindStones = {
  [120563] = { -- Stone, Jagged Grey
    itemPrice = 100,
  },
  [120570] = { -- Stone, Slanted Grey
    itemPrice = 100,
  },
  [120571] = { -- Pebbles, Stacked Grey
    itemPrice = 100,
  },
  [120564] = { -- Pebbles, Stacked Weathered
    itemPrice = 100,
  },
  [120572] = { -- Rocks, Jagged Set
    itemPrice = 100,
  },
}

local structures = {
  [117984] = { -- Rough Block, Dark Stone
    itemPrice = 100,
  },
  [117983] = { -- Rough Block, Light Stone
    itemPrice = 100,
  },
  [117995] = { -- Rough Block, Stone Brick
    itemPrice = 100,
  },
  [117993] = { -- Rough Block, Stone Chunk
    itemPrice = 100,
  },
  [117992] = { -- Rough Block, Stone Section
    itemPrice = 100,
  },
  [117994] = { -- Rough Block, Stone Slab
    itemPrice = 100,
  },
  [117961] = { -- Rough Block, Woodcutter's
    itemPrice = 100,
  },
  [117986] = { -- Rough Plank, Long
    itemPrice = 100,
  },
  [117987] = { -- Rough Planks, Narrow
    itemPrice = 100,
  },
  [117988] = { -- Rough Planks, Platform
    itemPrice = 100,
  },
  [117989] = { -- Rough Plank, Wide
    itemPrice = 100,
  },
  [117973] = { -- Rough Crate, Dry
    itemPrice = 100,
  },
}

local boxes = {
  [120998] = { -- Block, Wood Cutting
    itemPrice = 100,
  },
  [117959] = { -- Rough Container, Shipping
    itemPrice = 100,
  },
  [117931] = { -- Rough Crate Lid
    itemPrice = 100,
  },
  [117957] = { -- Rough Crate, Cracked
    itemPrice = 100,
  },
  [117958] = { -- Rough Crate, Empty
    itemPrice = 100,
  },
  [117930] = { -- Rough Crate, Open
    itemPrice = 100,
  },
  [117953] = { -- Rough Crate, Sealed
    itemPrice = 100,
  },
  [117928] = { -- Rough Crate, Sturdy
    itemPrice = 100,
  },
}

local laundry = {
  [117968] = { -- Rough Clothesline, Full
    itemPrice = 100,
  },
  [117970] = { -- Rough Clothesline, Half
    itemPrice = 100,
  },
  [117969] = { -- Rough Clothesline, Long
    itemPrice = 100,
  },
  [117972] = { -- Rough Clothesline, Short
    itemPrice = 100,
  },
  [117971] = { -- Rough Clothesline, Post
    itemPrice = 100,
  },
  [117966] = { -- Rough Tarp, Oversized
    itemPrice = 100,
  },
  [117967] = { -- Rough Tarp, Standard
    itemPrice = 100,
  },
}

local fishing_trip = {
  [117965] = { -- Rough Campfire, Doused
    itemPrice = 100,
  },
  [117978] = { -- Rough Rod, Fishing
    itemPrice = 100,
  },
  [117979] = { -- Rough Spear, Fishing
    itemPrice = 100,
  },
  [117977] = { -- Rough Stool, Fishing
    itemPrice = 100,
  },
}

local miscVendor = merge(merge(merge(structures, boxes), laundry), fishing_trip)

-- ZERO2
FurC.AchievementVendors[ver.ZERO2] = FurC.AchievementVendors[ver.ZERO2] or {}
FurC.AchievementVendors[ver.ZERO2][loc.GLENUMBRA] = FurC.AchievementVendors[ver.ZERO2][loc.GLENUMBRA] or {}
FurC.AchievementVendors[ver.ZERO2]
  [loc.GLENUMBRA]
    [npc.HGF] = {
	  [225029] = { -- Boulders, Mossy Cluster
	    itemPrice = 225,
	  },
	  [225030] = { -- Boulder, Round Mossy Striated
	    itemPrice = 450,
	  },
	  [225031] = { -- Boulder, Angular Mossy Striated
	    itemPrice = 450,
	  },
	  [225038] = { -- Stones, Loose Rubble
	    itemPrice = 270,
	  },
	  [225037] = { -- Rough Crates, Stack
	    itemPrice = 270,
	  },
	  [225036] = { -- Rough Crates, Cargo Shipment
	    itemPrice = 405,
	  },
	  [225035] = { -- Ruined Floor, Stonework
	    itemPrice = 1800,
	  },
	  [225034] = { -- Cave Doorway, Mossy Vine-Covered
	    itemPrice = 18000,
	  },
	  [225033] = { -- Tree, Giant Climbing Wyrdbloom
	    itemPrice = 22500,
	  },
	  [225032] = { -- Logs, Unprocessed
	    itemPrice = 225,
	  },
	  [224922] = { -- Breton Panel, Wood
	    itemPrice = 90,
	  },
	  [224921] = { -- Breton Support Beam, Wood
	    itemPrice = 90,
	  },
	  [224882] = { -- Rope, Thin Knotted
	    itemPrice = 45,
	  },
	  [224880] = { -- Rope, Short Twisted
	    itemPrice = 45,
	  },
	  [224879] = { -- Rope, Twisted
	    itemPrice = 45,
	  },
}

-- WORMS2
FurC.AchievementVendors[ver.WORMS2] = FurC.AchievementVendors[ver.WORMS2] or {}
FurC.AchievementVendors[ver.WORMS2][loc.SOLSTICE] = FurC.AchievementVendors[ver.WORMS2][loc.SOLSTICE] or {}
FurC.AchievementVendors[ver.WORMS2][loc.SOLSTICE][npc.HGF] = {
	  [220354] = { -- Tree, Flowering Red Poinsettia
	    itemPrice = 5000,
	  },
	  [220353] = { -- Driftwood, Spindly
	    itemPrice = 450,
	  },
	  [220352] = { -- Platform, Cut Stone
	    itemPrice = 500,
	  },
	  [220355] = { -- Tree, Sturdy Tamanu
	    itemPrice = 4500,
	  },
	  [220356] = { -- Plant Cluster, Tamanu
	    itemPrice = 25000,
	  },
	  [220357] = { -- Mammoth Grass, Patch
	    itemPrice = 400,
	  },
	  [220350] = { -- Stones, Limestone Cluster
	    itemPrice = 300,
	  },
	  [220351] = { -- Southern Sea Trilobite Shell, Large
	    itemPrice = 1000,
	  },
	  [220358] = { -- Sapling, Magenta Summertide
	    itemPrice = 3000,
	  },
	  [220359] = { -- Saplings, Magenta Summertide Cluster
	    itemPrice = 3500,
	  },
	  [220360] = { -- Sapling, Violet Branched Summertide
	    itemPrice = 4000,
	  },
	  [220361] = { -- Sapling, Violet Leaning Summertide
	    itemPrice = 3500,
	  },
	  [220362] = { -- Debris Pile, Sea-Tossed Flotsam
	    itemPrice = 250,
	  },
	  [220348] = { -- Amethyst Crystals, Small Teal Patch
	    itemPrice = 20000,
	  },
	  [220347] = { -- Amethyst Crystals, Purple Patch
	    itemPrice = 20000,
	  },
	  [220349] = { -- Amethyst Crystals, Teal Cluster
	    itemPrice = 5000,
	  },
	  [220346] = { -- Amethyst Crystals, Small Purple Patch
	    itemPrice = 5000,
	  },
}

-- SHADOWS
FurC.AchievementVendors[ver.SHADOWS] = FurC.AchievementVendors[ver.SHADOWS] or {}
FurC.AchievementVendors[ver.SHADOWS][loc.SOLSTICE] = FurC.AchievementVendors[ver.SHADOWS][loc.SOLSTICE] or {}
FurC.AchievementVendors[ver.SHADOWS][loc.SOLSTICE][npc.HGF] = {
	  [217938] = { -- Tree, Hooked Dawnwood
	    itemPrice = 3000,
	  },
	  [217939] = { -- Tree, Braided Dawnwood
	    itemPrice = 4500,
	  },
	  [217940] = { -- Colovian Well, Overgrown Dawnwood
	    itemPrice = 4500,
	  },
	  [217941] = { -- Colovian Well, Destroyed Dawnwood
	    itemPrice = 450,
	  },
	  [217970] = { -- Tree, Giant Dawnwood Canopy
	    itemPrice = 24000,
	  },
	  [217665] = { -- Solitude Fence, Stick Curved
	    itemPrice = 100,
      },
}

-- WORMS
FurC.AchievementVendors[ver.WORMS] = FurC.AchievementVendors[ver.WORMS] or {}
FurC.AchievementVendors[ver.WORMS][loc.SOLSTICE] = FurC.AchievementVendors[ver.WORMS][loc.SOLSTICE] or {}
FurC.AchievementVendors[ver.WORMS][loc.SOLSTICE][npc.HGF] = {
      [214496] = { -- Boulder, Horizontal Sandstone
        itemPrice = 500,
      },
      [214495] = { -- Boulder, Vertical Sandstone
        itemPrice = 500,
      },
      [214498] = { -- Clam Shell, Large
        itemPrice = 3000,
      },
      [214497] = { -- Conch, Large Spiny
        itemPrice = 3000,
      },
      [214500] = { -- Driftwood, Large Gnarled
        itemPrice = 500,
      },
      [214501] = { -- Driftwood, Large Trunk
        itemPrice = 250,
      },
      [217631] = { -- Flower Curtain, Summertide
        itemPrice = 450,
      },
      [217630] = { -- Flower Patch, Summertide
        itemPrice = 1500,
      },
      [214511] = { -- Flowering Gorse, Purple
        itemPrice = 2500,
      },
      [217629] = { -- Flowers, Climbing Summertide
        itemPrice = 450,
      },
      [217628] = { -- Flowers, Large Climbing Summertide
        itemPrice = 1500,
      },
      [214512] = { -- Grass, Beach Cluster
        itemPrice = 250,
      },
      [214510] = { -- Plant Cluster, Majesty Palm
        itemPrice = 500,
      },
      [214509] = { -- Plant, Majesty Palm
        itemPrice = 350,
      },
      [214507] = { -- Sapling, Royal Palm
        itemPrice = 300,
      },
      [214503] = { -- Sapling, Thatch Palm
        itemPrice = 300,
      },
      [214493] = { -- Solstice Bismuth, Gigantic Deposit I
        itemPrice = 90000,
      },
      [214494] = { -- Solstice Bismuth, Gigantic Deposit II
        itemPrice = 90000,
      },
      [214499] = { -- Tree, Banana
        itemPrice = 450,
      },
      [214505] = { -- Tree, Gigantic Water Chestnut
        itemPrice = 4500,
      },
      [214504] = { -- Tree, Large Water Chestnut
        itemPrice = 4500,
      },
      [214506] = { -- Tree, Royal Palm
        itemPrice = 1000,
      },
      [214508] = { -- Tree, Sierra Palm
        itemPrice = 350,
      },
      [214502] = { -- Tree, Thatch Palm
        itemPrice = 1000,
      },
}

-- Fallen Banners
FurC.AchievementVendors[ver.FALLBAN] = FurC.AchievementVendors[ver.FALLBAN] or {}
FurC.AchievementVendors[ver.FALLBAN][loc.ALIKR] = FurC.AchievementVendors[ver.FALLBAN][loc.ALIKR] or {}
FurC.AchievementVendors[ver.FALLBAN][loc.ALIKR][npc.HGF] = {
	  [118168] = rumourSource, -- Block, Carved Stone
	    itemPrice = 500,
}

-- 30 Gold Road
FurC.AchievementVendors[ver.WEALD] = FurC.AchievementVendors[ver.WEALD] or {}
FurC.AchievementVendors[ver.WEALD][loc.WEALD] = FurC.AchievementVendors[ver.WEALD][loc.WEALD] or {}
FurC.AchievementVendors[ver.WEALD][loc.WEALD][npc.HGF] = {
      [204774] = { -- Boulder, Colovian Highland
        itemPrice = 100,
      },
      [204769] = { -- Bush, Autumn Oak
        itemPrice = 250,
      },
      [204770] = { -- Bush, Autumn Oak Cluster
        itemPrice = 250,
      },
      [204767] = { -- Bush, Squat Maple
        itemPrice = 600,
      },
      [204773] = { -- Leaf Pile, Autumn
        itemPrice = 450,
      },
      [204762] = { -- Sapling, Autumn Maple
        itemPrice = 500,
      },
      [204760] = { -- Sapling, Autumn Oak
        itemPrice = 500,
      },
      [204768] = { -- Sapling, Young Autumn Maple
        itemPrice = 500,
      },
      [204772] = { -- Sawdust Pile, Logging
        itemPrice = 100,
      },
      [204765] = { -- Shrub, Juniper Cluster
        itemPrice = 250,
      },
      [204771] = { -- Stump, Old Maple
        itemPrice = 100,
      },
      [204761] = { -- Tree, Autumn Aspen
        itemPrice = 500,
      },
      [204763] = { -- Tree, Autumn Conical Cypress
        itemPrice = 1000,
      },
      [204756] = { -- Tree, Giant Autumn Maple
        itemPrice = 20000,
      },
      [204757] = { -- Tree, Giant Dawnwood Growth
        itemPrice = 25000,
      },
      [204758] = { -- Tree, Giant Oak
        itemPrice = 2500,
      },
      [204759] = { -- Tree, Healthy Willow
        itemPrice = 5000,
      },
      [204766] = { -- Tree, Squat Cypress
        itemPrice = 250,
      },
      [204764] = { -- Tree, Tall Autumn Conical Cypress
        itemPrice = 250,
      },
      [204810] = { -- Tree, Towering Slim Autumnal Cypress
        itemPrice = 1500,
      },
      [204811] = { -- Tree, Towering Slim Cypress
        itemPrice = 1500,
      },
      [211514] = { -- Fern, Small Mammoth Leaf
        itemPrice = 100,
      },
      [211513] = { -- Fern, Tall Mammoth Leaf
        itemPrice = 500,
      },
      [211516] = { -- Hosta, Orange
        itemPrice = 5000,
      },
      [211507] = { -- Quarry Stone, Large
        itemPrice = 1000,
      },
      [211508] = { -- Quarry Stone, Small
        itemPrice = 500,
      },
      [211515] = { -- Shrub Cluster, Large Red Boxwood
        itemPrice = 200,
      },
      [211509] = { -- Tree, Curled Dawnwood
        itemPrice = 20000,
      },
      [211510] = { -- Tree, Sheltering Dawnwood
        itemPrice = 15000,
      },
      [211512] = { -- Tree, Small Willow
        itemPrice = 2500,
      },
      [211511] = { -- Tree, Twisted Dawnwood
        itemPrice = 25000,
      },
}

-- 28 Secrets of the Telvanni
FurC.AchievementVendors[ver.ENDLESS] = FurC.AchievementVendors[ver.ENDLESS] or {}
FurC.AchievementVendors[ver.ENDLESS][loc.TELVANNI] = FurC.AchievementVendors[ver.ENDLESS][loc.TELVANNI] or {}
FurC.AchievementVendors[ver.ENDLESS][loc.TELVANNI][npc.HGF] = {
      [198463] = { -- Apocrypha Boulder
        itemPrice = 500,
      },
      [198470] = { -- Apocrypha Coral, Teal Tube
        itemPrice = 450,
      },
      [198464] = { -- Apocrypha Plant, Chromatic Succulent
        itemPrice = 2000,
      },
      [198465] = { -- Apocrypha Plant, Feather Fern Cluster
        itemPrice = 150,
      },
      [198466] = { -- Apocrypha Plant, Ink-Grass
        itemPrice = 150,
      },
      [198467] = { -- Apocrypha Tree, Blue Spore
        itemPrice = 24000,
      },
      [198469] = { -- Apocrypha Tree, Branched Green Spore
        itemPrice = 4000,
      },
      [198468] = { -- Apocrypha Tree, Teal Spiral
        itemPrice = 7000,
      },
      [198476] = { -- Bridge, Reclaimed Wood
        itemPrice = 1000,
      },
      [198471] = { -- Mushroom, Russet Chanterelle Pair
        itemPrice = 400,
      },
      [198473] = { -- Mushroom, Tall Green Morel Pair
        itemPrice = 3000,
      },
      [198472] = { -- Mushrooms, Gilled Dusk Cluster
        itemPrice = 500,
      },
      [198477] = { -- Platform, Reclaimed Wood Square
        itemPrice = 300,
      },
      [198478] = { -- Platform, Reclaimed Wood Triangle
        itemPrice = 300,
      },
      [198475] = { -- Post, Reclaimed Wood
        itemPrice = 50,
      },
      [198474] = { -- Stairway, Reclaimed Wood
        itemPrice = 300,
      },
}

-- 26 Necrom
FurC.AchievementVendors[ver.NECROM] = FurC.AchievementVendors[ver.NECROM] or {}
FurC.AchievementVendors[ver.NECROM][loc.TELVANNI] = FurC.AchievementVendors[ver.NECROM][loc.TELVANNI] or {}
FurC.AchievementVendors[ver.NECROM][loc.TELVANNI][npc.HGF] = {
      [197642] = { -- Apocrypha Plant, Anemone Cluster
        itemPrice = 1200,
      },
      [197641] = { -- Apocrypha Plant, Suckerleaf
        itemPrice = 2000,
      },
      [197640] = { -- Apocrypha Tree, Fossilized
        itemPrice = 500,
      },
      [197639] = { -- Apocrypha Tree, Spore
        itemPrice = 20000,
      },
      [197643] = { -- Boulder, Apocrypha Fossil
        itemPrice = 5000,
      },
      [197634] = { -- Mushroom, Dual Mauve Dusk
        itemPrice = 500,
      },
      [197635] = { -- Mushroom, Gilled Mauve Dusk
        itemPrice = 4000,
      },
      [197638] = { -- Mushroom, Tall Russet Chanterelle
        itemPrice = 500,
      },
      [197636] = { -- Plants, Guar Cabbage Cluster
        itemPrice = 2000,
      },
      [197637] = { -- Plants, Lava Pitcher Patch
        itemPrice = 1500,
      },
      [197633] = { -- Tree, Large Gnarled Laurel
        itemPrice = 2500,
      },
}

-- 24 Firesong
FurC.AchievementVendors[ver.DRUID] = FurC.AchievementVendors[ver.DRUID] or {}
FurC.AchievementVendors[ver.DRUID][loc.GALEN] = FurC.AchievementVendors[ver.DRUID][loc.GALEN] or {}
FurC.AchievementVendors[ver.DRUID][loc.GALEN][npc.HGF] = {
      [192400] = { -- Druidic Planter, Sunflowers
        itemPrice = 4500,
      },
      [192399] = { -- Flowers, Galen Sea Daffodil
        itemPrice = 300,
      },
      [192396] = { -- Flowers, Sunflower Cluster
        itemPrice = 400,
      },
      [192395] = { -- Flowers, Sunflower Patch
        itemPrice = 4000,
      },
      [192398] = { -- Plant, Galen Agave
        itemPrice = 125,
      },
      [192394] = { -- Sapling, Galen Beech
        itemPrice = 200,
      },
      [192393] = { -- Tree, Large Galen Beech
        itemPrice = 3500,
      },
      [192397] = { -- Tree,  Large Galen Pine
        itemPrice = 425,
      },
}

-- 22 High Isle
FurC.AchievementVendors[ver.BRETON] = FurC.AchievementVendors[ver.BRETON] or {}
FurC.AchievementVendors[ver.BRETON][loc.HIGHISLE] = FurC.AchievementVendors[ver.BRETON][loc.HIGHISLE] or {}
FurC.AchievementVendors[ver.BRETON][loc.HIGHISLE][npc.HGF] = {
      [187780] = { -- Boulder, Large Mossy Limestone
        itemPrice = 200,
      },
      [187779] = { -- Boulder, Small Limestone
        itemPrice = 100,
      },
      [187814] = { -- Flowers, Butterweed
        itemPrice = 1000,
      },
      [187783] = { -- Flowers, Daylily Cluster
        itemPrice = 3000,
      },
      [187784] = { -- Shrub Cluster, Gorse
        itemPrice = 2000,
      },
      [187856] = { -- Tree, Conical Cypress
        itemPrice = 2500,
      },
      [187782] = { -- Tree, Forked Cypress
        itemPrice = 700,
      },
      [187781] = { -- Tree, Tall Conical Cypress
        itemPrice = 3000,
      },
}

-- 20 Deadlands
FurC.AchievementVendors[ver.DEADL] = FurC.AchievementVendors[ver.DEADL] or {}
FurC.AchievementVendors[ver.DEADL][loc.FARGRAVE] = FurC.AchievementVendors[ver.DEADL][loc.FARGRAVE] or {}
FurC.AchievementVendors[ver.DEADL][loc.FARGRAVE][npc.HGF] = {
      [181598] = { -- Bush, Low Redleaf Cluster
        itemPrice = 300,
      },
      [181597] = { -- Bush, Sharp Underbrush
        itemPrice = 300,
      },
      [182213] = { -- Fargrave Canopy
        itemPrice = 250,
      },
      [182217] = { -- Fargrave Clutter, Papers
        itemPrice = 100,
      },
      [182220] = { -- Fargrave Flag, Long
        itemPrice = 100,
      },
      [182218] = { -- Fargrave Flag, Regular
        itemPrice = 85,
      },
      [182219] = { -- Fargrave Flag, Short
        itemPrice = 75,
      },
      [182214] = { -- Fargrave Flags, String
        itemPrice = 300,
      },
      [182215] = { -- Fargrave Pennants, Long String
        itemPrice = 250,
      },
      [182216] = { -- Fargrave Pennants, String
        itemPrice = 100,
      },
      [181593] = { -- Log, Charred Oak
        itemPrice = 250,
      },
      [125616] = { -- Pebble, Volcanic Chunk
        itemPrice = 100,
      },
      [181596] = { -- Plant Cluster, Maroon Aloe
        itemPrice = 300,
      },
      [181595] = { -- Plant, Harrada Root
        itemPrice = 500,
      },
      [181594] = { -- Rock, Volcanic Boulder
        itemPrice = 100,
      },
      [181587] = { -- Tree, Charred Oak
        itemPrice = 250,
      },
      [181592] = { -- Tree, Deadlands Pine
        itemPrice = 500,
      },
      [181588] = { -- Tree, Old Charred Oak
        itemPrice = 400,
      },
      [181591] = { -- Tree, Short Charred Pine
        itemPrice = 100,
      },
      [181590] = { -- Tree, Tall Charred Pine
        itemPrice = 250,
      },
      [181589] = { -- Tree, Young Charred Oak
        itemPrice = 100,
      },
}

-- 19 Blackwood
FurC.AchievementVendors[ver.BLACKW] = FurC.AchievementVendors[ver.BLACKW] or {}
FurC.AchievementVendors[ver.BLACKW][loc.BLACKWOOD] = FurC.AchievementVendors[ver.BLACKW][loc.BLACKWOOD] or {}
FurC.AchievementVendors[ver.BLACKW][loc.BLACKWOOD][npc.HGF] = {
      [165809] = { -- Firelogs, White Pine
        itemPrice = 250,
      },
      [175725] = { -- Leyawiin Carpet, Small Worn
        itemPrice = 250,
      },
      [175723] = { -- Leyawiin Carpet, Threadbare
        itemPrice = 350,
      },
      [175727] = { -- Leyawiin Palisade, Reinforced
        itemPrice = 2000,
      },
      [175724] = { -- Leyawiin Rug, Worn
        itemPrice = 350,
      },
      [175722] = { -- Leyawiin Socks, Pair
        itemPrice = 75,
      },
      [175721] = { -- Leyawiin Trousers, Strewn
        itemPrice = 100,
      },
      [175720] = { -- Leyawiin Wheel, Splintered Axle
        itemPrice = 250,
      },
      [175774] = { -- Leyawiin Windowbox, Irises
        itemPrice = 4000,
      },
      [175773] = { -- Leyawiin Windowbox, Yellow Daisies
        itemPrice = 4500,
      },
      [175771] = { -- Tree, Bent Blackwood Elm
        itemPrice = 300,
      },
      [175770] = { -- Tree, Branching Blackwood Pine
        itemPrice = 1000,
      },
      [175772] = { -- Tree, Forked Blackwood Elm
        itemPrice = 350,
      },
}

-- 17 Markarth
FurC.AchievementVendors[ver.MARKAT] = FurC.AchievementVendors[ver.MARKAT] or {}
FurC.AchievementVendors[ver.MARKAT][loc.REACH] = FurC.AchievementVendors[ver.MARKAT][loc.REACH] or {}
FurC.AchievementVendors[ver.MARKAT][loc.REACH][npc.HGF] = {
      [171383] = { -- Dwarven Broom, Restored
        itemPrice = 400,
      },
      [171384] = { -- Dwarven Loaf Pan, Rectangular
        itemPrice = 250,
      },
      [171385] = { -- Dwarven Plate, Salvaged Decorative
        itemPrice = 100,
      },
      [171386] = { -- Reachfolk Banner, Markarth
        itemPrice = 2000,
      },
}

-- 15 Greymoor
FurC.AchievementVendors[ver.SKYRIM] = FurC.AchievementVendors[ver.SKYRIM] or {}
FurC.AchievementVendors[ver.SKYRIM][loc.WSKYRIM] = FurC.AchievementVendors[ver.SKYRIM][loc.WSKYRIM] or {}
FurC.AchievementVendors[ver.SKYRIM][loc.WSKYRIM][npc.HGF] = {
      [165809] = { -- Firelogs, White Pine
        itemPrice = 250,
      },
      [165817] = { -- Log, Fallen Winter Pine
        itemPrice = 250,
      },
      [165810] = { -- Logs, Twice-Split
        itemPrice = 750,
      },
      [165822] = { -- Plant Cluster, Haafingar Underbrush
        itemPrice = 250,
      },
      [165819] = { -- Sapling, White Pine
        itemPrice = 300,
      },
      [165821] = { -- Shrub, Wild Basil
        itemPrice = 250,
      },
      [165811] = { -- Solitude Fence, Stick
        itemPrice = 100,
      },
      [165812] = { -- Solitude Fence, Stick Triple
        itemPrice = 250,
      },
      [165813] = { -- Solitude Wagon Wheel, Heavy
        itemPrice = 250,
      },
      [165824] = { -- Tree, Mountain Mahogany
        itemPrice = 300,
      },
      [165825] = { -- Tree, Twisted Mountain Mahogany
        itemPrice = 1000,
      },
      [165818] = { -- Tree, White Pine
        itemPrice = 900,
      },
      [165815] = { -- Tree, Winter Pine
        itemPrice = 900,
      },
      [165816] = { -- Tree, Young Aspen
        itemPrice = 300,
      },
      [165823] = { -- Tree, Young Mountain Mahogany
        itemPrice = 250,
      },
      [165814] = { -- Tree, Young Winter Pine
        itemPrice = 250,
      },
      [165820] = { -- Fern, Sting-Vine
        itemPrice = 100,
      },
}

-- 13 Dragonhold
FurC.AchievementVendors[ver.DRAGON2] = FurC.AchievementVendors[ver.DRAGON2] or {}
FurC.AchievementVendors[ver.DRAGON2][loc.SELSWEYR] = FurC.AchievementVendors[ver.DRAGON2][loc.SELSWEYR] or {}
FurC.AchievementVendors[ver.DRAGON2][loc.SELSWEYR][npc.HGF] = {
      [156677] = { -- Vines, Verdant Ivy Climber
        itemPrice = 750,
      },
      [156678] = { -- Vines, Verdant Ivy Swath
        itemPrice = 1250,
      },
}

-- 11 Elsweyr
FurC.AchievementVendors[ver.KITTY] = FurC.AchievementVendors[ver.KITTY] or {}
FurC.AchievementVendors[ver.KITTY][loc.NELSWEYR] = FurC.AchievementVendors[ver.KITTY][loc.NELSWEYR] or {}
FurC.AchievementVendors[ver.KITTY][loc.NELSWEYR][npc.HGF] = {
      [151821] = { -- Desert Grass, Patch
        itemPrice = 150,
      },
      [151820] = { -- Desert Grass, Tall
        itemPrice = 100,
      },
      [151804] = { -- Elsweyr Pillar, Rough Wooden
        itemPrice = 100,
      },
      [153684] = { -- Plant Cluster, Keet Fern
        itemPrice = 100,
      },
      [153681] = { -- Plant Cluster, Palmetto
        itemPrice = 150,
      },
      [153680] = { -- Plant Cluster, Tenmar Dija
        itemPrice = 300,
      },
      [153683] = { -- Plant Cluster, Zahmia
        itemPrice = 150,
      },
      [151816] = { -- Plant, Flowering Thorned Succulent
        itemPrice = 100,
      },
      [153682] = { -- Plant, Tropical Bush
        itemPrice = 100,
      },
      [151807] = { -- Rock Field, Ancient Stone
        itemPrice = 100,
      },
      [151806] = { -- Rubble Pile, Ancient Stone
        itemPrice = 100,
      },
      [151813] = { -- Sapling, Desert Acacia
        itemPrice = 350,
      },
      [153679] = { -- Tree, Anequine Acacia Arching
        itemPrice = 400,
      },
      [153688] = { -- Tree, Anequine Acacia Forking
        itemPrice = 300,
      },
      [151808] = { -- Tree, Fan Palm
        itemPrice = 100,
      },
      [153677] = { -- Trees, Shade Palm Cluster
        itemPrice = 400,
      },
      [153678] = { -- Trees, Towering Palm Cluster
        itemPrice = 400,
      },

      [151805] = { -- Elsweyr Rack, Poles
        itemPrice = 350,
      },
      [151803] = { -- Elsweyr Wagon Wheel, Ironshod
        itemPrice = 250,
      },
      [151819] = { -- Flower Patch, Prairie-Fire
        itemPrice = 350,
      },
      [151817] = { -- Flowers, Daedra Thorn
        itemPrice = 250,
      },
      [151815] = { -- Flowers, Desert Sunrise
        itemPrice = 250,
      },
      [151818] = { -- Shrub, Yellow Necklacepod
        itemPrice = 250,
      },
      [151810] = { -- Tree, Branched Succulent
        itemPrice = 400,
      },
      [151814] = { -- Tree, Desert Acacia
        itemPrice = 550,
      },
      [151812] = { -- Tree, Engulfing Termite Mound
        itemPrice = 350,
      },
      [151811] = { -- Tree, Tall Iroko
        itemPrice = 400,
      },
      [151823] = { -- Vines, Dragonfire Ivy Climber
        itemPrice = 300,
      },
      [151809] = { -- Trees, Fan Palm Cluster
        itemPrice = 250,
      },
      [151822] = { -- Vines, Dragonfire Ivy Swath
        itemPrice = 450,
      },
}

-- 9 Wolfhunter
FurC.AchievementVendors[ver.WEREWOLF] = FurC.AchievementVendors[ver.WEREWOLF] or {}
FurC.AchievementVendors[ver.WEREWOLF][loc.SUMMERSET] = FurC.AchievementVendors[ver.WEREWOLF][loc.SUMMERSET] or {}
FurC.AchievementVendors[ver.WEREWOLF][loc.SUMMERSET][npc.HGF] = {
      [141824] = {
        itemPrice = 100,
      },
      [141819] = {
        itemPrice = 500,
      },
      [141818] = {
        itemPrice = 100,
      },
      [141817] = {
        itemPrice = 750,
      },
      [141816] = {
        itemPrice = 500,
      },
}
FurC.AchievementVendors[ver.WEREWOLF][loc.GLENUMBRA] = FurC.AchievementVendors[ver.WEREWOLF][loc.GLENUMBRA] or {}
FurC.AchievementVendors[ver.WEREWOLF][loc.GLENUMBRA][npc.HGF] = {
      [130305] = { -- Stone, Mossy Swamp
        itemPrice = 100,
      },
      [130306] = { -- Stones, Gray Swampy
        itemPrice = 100,
      },
      [130292] = { -- Stump, Fetid Swamp
        itemPrice = 100,
      },
      [130291] = { -- Stump, Rotten Pine
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.WEREWOLF][loc.REAPER] = FurC.AchievementVendors[ver.WEREWOLF][loc.REAPER] or {}
FurC.AchievementVendors[ver.WEREWOLF][loc.REAPER][npc.HGF] = {
      [120658] = { -- Tree, Forked Sturdy
        itemPrice = 250,
      },
}

-- 8 Murkmire
FurC.AchievementVendors[ver.SLAVES] = FurC.AchievementVendors[ver.SLAVES] or {}
FurC.AchievementVendors[ver.SLAVES][loc.MURKMIRE] = FurC.AchievementVendors[ver.SLAVES][loc.MURKMIRE] or {}
FurC.AchievementVendors[ver.SLAVES][loc.MURKMIRE][npc.HGF] = {
      [145551] = { -- Murkmire Kiln, Derelict
        itemPrice = 450,
      },
      [145557] = { -- Plant Cluster, Spadeleaf
        itemPrice = 350,
      },
      [145414] = { -- Plant Cluster, Marsh Saplings
        itemPrice = 250,
      },
      [145417] = { -- Plant, Bramblebrush
        itemPrice = 250,
      },
      [145413] = { -- Plant, Marsh Palm
        itemPrice = 350,
      },
      [145419] = { -- Plant, Marshfrond
        itemPrice = 400,
      },
      [145547] = { -- Plant, Moorstalk Hive
        itemPrice = 1250,
      },
      [145416] = { -- Plant, Purple Spadeleaf
        itemPrice = 300,
      },
      [145420] = { -- Plant, Thorny Swamp Lily
        itemPrice = 400,
      },
      [145418] = { -- Plant, Young Marshfrond
        itemPrice = 250,
      },
      [145425] = { -- Rock, Mossy Marsh
        itemPrice = 250,
      },
      [145424] = { -- Rocks, Mossy Marsh Cluster
        itemPrice = 750,
      },
      [145422] = { -- Tree Cluster, Young Sycamore
        itemPrice = 450,
      },
      [145421] = { -- Tree, Marsh Cypress
        itemPrice = 350,
      },
      [145423] = { -- Tree, Mire Mangrove
        itemPrice = 4000,
      },
      [145415] = { -- Tree, Mossy Sycamore
        itemPrice = 2000,
      },
}

-- 7 Summerset
FurC.AchievementVendors[ver.ALTMER] = FurC.AchievementVendors[ver.ALTMER] or {}
FurC.AchievementVendors[ver.ALTMER][loc.SUMMERSET] = FurC.AchievementVendors[ver.ALTMER][loc.SUMMERSET] or {}
FurC.AchievementVendors[ver.ALTMER][loc.SUMMERSET][npc.HGF] = {
      [139122] = { -- Bush, Summerset Spruce
        itemPrice = 100,
      },
      [139107] = { -- Coral Shelf, Flat
        itemPrice = 100,
      },
      [139108] = { --  Coral Shelf, Large
        itemPrice = 250,
      },
      [139127] = { -- Hedge, Overgrown
        itemPrice = 100,
      },
      [139128] = { -- Hedge, Overgrown long
        itemPrice = 100,
      },
      [139112] = { -- Limestone Border, Boulders
        itemPrice = 100,
      },
      [139113] = { -- Limestone Border, Pebbles
        itemPrice = 100,
      },
      [139111] = { -- Limestone Border, Stones
        itemPrice = 100,
      },
      [139114] = { -- Limestone Retaining Wall, Curved
        itemPrice = 100,
      },
      [139116] = { -- Limestone Retaining Wall, Long
        itemPrice = 100,
      },
      [139115] = { -- Limestone Retaining Wall, Short
        itemPrice = 100,
      },
      [139109] = { -- Limestone Shelf, Curved
        itemPrice = 100,
      },
      [139110] = { -- Limestone Shelf, Large
        itemPrice = 250,
      },
      [139117] = { -- Limestone Stairway, Natural
        itemPrice = 100,
      },
      [139126] = { -- Sapling, Gingko
        itemPrice = 100,
      },
      [139121] = { -- Sapling, Growing Shade
        itemPrice = 100,
      },
      [139132] = { -- Sapling, Sea Grapes
        itemPrice = 100,
      },
      [139124] = { -- Sapling, Summerset Spruce
        itemPrice = 100,
      },
      [139120] = { -- Sapling, Young Shade
        itemPrice = 100,
      },
      [139130] = { -- Saplings, Mangrove
        itemPrice = 100,
      },
      [139125] = { -- Tree, Blooming Gingko
        itemPrice = 2000,
      },
      [139131] = { -- Tree, Solitary Mangrove
        itemPrice = 250,
      },
      [139134] = { -- Tree, Seagrapes
        itemPrice = 100,
      },
      [139136] = { -- Tree, Twin Poplar
        itemPrice = 100,
      },
      [139123] = { -- Tree, Summerset Spruce
        itemPrice = 250,
      },
      [139119] = { -- Tree, Upstretched Shade
        itemPrice = 250,
      },
      [139118] = { -- Tree, Wide-Trunked Shade
        itemPrice = 250,
      },
      [139129] = { -- Tree, Young Mangrove
        itemPrice = 100,
      },
      [139135] = { -- Tree, Young Poplar
        itemPrice = 100,
      },
      [139133] = { -- Tree, Young Sea Grapes
        itemPrice = 100,
      },
}

-- 6 Dragon Bones
FurC.AchievementVendors[ver.DRAGONS] = FurC.AchievementVendors[ver.DRAGONS] or {}
FurC.AchievementVendors[ver.DRAGONS][loc.FARGRAVE] = FurC.AchievementVendors[ver.DRAGONS][loc.FARGRAVE] or {}
FurC.AchievementVendors[ver.DRAGONS][loc.FARGRAVE][npc.HGF] = {
	  [134942] = { -- Bushes, Withered Cluster
        itemPrice = 100,
      },
}

-- CLOCKWORK
FurC.AchievementVendors[ver.CLOCKWORK] = FurC.AchievementVendors[ver.CLOCKWORK] or {}
FurC.AchievementVendors[ver.CLOCKWORK][loc.CWC] = FurC.AchievementVendors[ver.CLOCKWORK][loc.CWC] or {}
FurC.AchievementVendors[ver.CLOCKWORK][loc.CWC][npc.HGF] = {
      [134304] = { -- Boulder, Basalt Slap
        itemPrice = 1000,
      },
      [134292] = { -- Boulder, Metallic Rubble
        itemPrice = 500,
      },
      [134293] = { -- Boulder, Metallic Shard
        itemPrice = 500,
      },
      [134305] = { -- Clockwork Junk Heap, Small
        itemPrice = 1000,
      },
      [134303] = { -- Rock, Basalt Slab
        itemPrice = 500,
      },
      [134296] = { -- Rocks, Sintered Cluster
        itemPrice = 1000,
      },
      [134294] = { -- Rocks, Sintered Column
        itemPrice = 1000,
      },
      [134295] = { -- Rocks, Sintered Pile
        itemPrice = 1000,
      },
      [134297] = { -- Scavenged Grating, Narrow
        itemPrice = 500,
      },
      [134298] = { -- Scavenged Grating, Wide
        itemPrice = 500,
      },
      [134301] = { -- Scavenged Plate, Ornate
        itemPrice = 500,
      },
      [134299] = { -- Scavenged Plate, Plain
        itemPrice = 500,
      },
      [134300] = { -- Scavenged Plate, Wide
        itemPrice = 500,
      },
      [134302] = { -- Scavenged Support, Straight
        itemPrice = 500,
      },
}

-- 4 Horns of the Reach
FurC.AchievementVendors[ver.REACH] = FurC.AchievementVendors[ver.REACH] or {}
FurC.AchievementVendors[ver.REACH][loc.COLDH] = FurC.AchievementVendors[ver.REACH][loc.COLDH] or {}
FurC.AchievementVendors[ver.REACH][loc.COLDH][npc.HGF] = {
      [130273] = { -- Boulder, Coldharbour Fan
        itemPrice = 5000,
      },
      [130274] = { -- Boulder, Coldharbour Shard
        itemPrice = 5000,
      },
      [130275] = { -- Boulder, Coldharbour Spikes
        itemPrice = 5000,
      },
      [130276] = { -- Boulder, Coldharbour Spikes
        itemPrice = 250,
      },
      [131421] = { -- Sapling, Withered Thicket
        itemPrice = 250,
      },
      [130279] = { -- Tree, Petrified AShen
        itemPrice = 2500,
      },
      [130278] = { -- Tree, Strong Withered
        itemPrice = 5000,
      },
      [130277] = { -- Tree, Towering Withered
        itemPrice = 5000,
      },
}
FurC.AchievementVendors[ver.REACH][loc.GLENUMBRA] = FurC.AchievementVendors[ver.REACH][loc.GLENUMBRA] or {}
FurC.AchievementVendors[ver.REACH][loc.GLENUMBRA][npc.HGF] = {
      [120706] = { -- Boulder, Giant Mossy
        itemPrice = 100,
      },
      [130309] = { -- Boulder, Swampy Growth
        itemPrice = 250,
      },
      [132221] = { -- Lily Pads, Swamp Cluster
        itemPrice = 5000,
      },
      [130287] = { -- Log, Fallen Laurel
        itemPrice = 250,
      },
      [130288] = { -- Log, Fallen Pine
        itemPrice = 250,
      },
      [130286] = { -- Log, Rotten Log
        itemPrice = 250,
      },
      [130307] = { -- Rocks, Swampy Slan
        itemPrice = 250,
      },
      [130304] = { -- Saplings, Marsh Cluster
        itemPrice = 250,
      },
      [130303] = { -- Shrug, Swamp Sprig
        itemPrice = 250,
      },
      [130289] = { -- Stump, Mossy Cypress
        itemPrice = 250,
      },
      [130290] = { -- Stump, Rotten Hollow
        itemPrice = 250,
      },
      [130315] = { -- Tree, Ancient Rotten
        itemPrice = 7500,
      },
      [130310] = { -- Tree, Dead Marsh
        itemPrice = 7500,
      },
      [130312] = { -- Tree, Dead Pine
        itemPrice = 2500,
      },
      [130311] = { -- Tree, Dead Swamp
        itemPrice = 5000,
      },
      [130313] = { -- Tree, Gnarled Marsh
        itemPrice = 5000,
      },
      [130314] = { -- Tree, Withering Marsh
        itemPrice = 2500,
      },
}
FurC.AchievementVendors[ver.REACH][loc.EASTMARCH] = FurC.AchievementVendors[ver.REACH][loc.EASTMARCH] or {}
FurC.AchievementVendors[ver.REACH][loc.EASTMARCH][npc.HGF] = {
      [132215] = { -- Boulder, Granite Cap
        itemPrice = 1000,
      },
      [132213] = { -- Boulder, Granite Chunk
        itemPrice = 1000,
      },
      [132214] = { -- Boulder, Granite Slab
        itemPrice = 1000,
      },
      [132217] = { -- Rock, Granite Chunk
        itemPrice = 5000,
      },
      [132209] = { -- Sapling, Foothills Pine
        itemPrice = 250,
      },
      [132212] = { -- Shrub, Mountain Thistle
        itemPrice = 250,
      },
      [132220] = { -- Stones, Granite Cluster
        itemPrice = 250,
      },
      [132219] = { -- Stones, Granite Group
        itemPrice = 250,
      },
      [132218] = { -- Stones, Granite Pair
        itemPrice = 250,
      },
      [132210] = { -- Tree, Ancient Cedar
        itemPrice = 2500,
      },
      [132207] = { -- Tree, Ancient Mountain Pine
        itemPrice = 1000,
      },
      [132208] = { -- Tree, Foothills Pine
        itemPrice = 1000,
      },
      [132205] = { -- Tree, Hardy Cedar
        itemPrice = 250,
      },
      [132206] = { -- Tree, Towering Mountain Pine
        itemPrice = 1000,
      },
      [132211] = { -- Ferns, Mountain Cluster
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.REACH][loc.AURIDON] = FurC.AchievementVendors[ver.REACH][loc.AURIDON] or {}
FurC.AchievementVendors[ver.REACH][loc.AURIDON][npc.HGF] = {
      [120652] = { -- Boulder, Flat Lichen
        itemPrice = 100,
      },
      [120651] = { -- Boulder, Grey Saddle
        itemPrice = 100,
      },
      [120648] = { -- Boulder, Lichen Covered
        itemPrice = 100,
      },

      [120672] = { -- Hedge, Green Short
        itemPrice = 1000,
      },
      [120673] = { -- Hedge, Long Horseshoe
        itemPrice = 2500,
      },
      [120671] = { -- Hedge, Small Horseshoe
        itemPrice = 1250,
      },
      [120674] = { -- Hedge, Tall Green
        itemPrice = 1250,
      },
      [121005] = { -- Hedge, Wall Arc
        itemPrice = 3000,
      },

      [120653] = { -- Rock, Slanted Lichen
        itemPrice = 100,
      },
      [120655] = { -- Stone, Slanted Lichen
        itemPrice = 100,
      },
      [120654] = { -- Stone, Slanted Rough
        itemPrice = 100,
      },
      [120656] = { -- Stones, Gray Mossy
        itemPrice = 100,
      },
      [120675] = { -- Topiary, Manicured Evergreen
        itemPrice = 2000,
      },
      [120676] = { -- Topiary, Pruned Evergreen
        itemPrice = 1000,
      },

      [120670] = { -- Tree, Sturdy Jungle
        itemPrice = 250,
      },
      [120664] = { -- Tree, Tiered Light Cherry
        itemPrice = 15000,
      },
      [120665] = { -- Tree, Tiered Pink Cherry
        itemPrice = 15000,
      },
      [120666] = { -- Tree, Tiered White Cherry
        itemPrice = 25000,
      },
      [120657] = { -- Tree, twisted Pink cherry
        itemPrice = 15000,
      },
      [120667] = { -- Tree, twisted white cherry
        itemPrice = 12000,
      },
      [120659] = { -- Trees, Crooked Swamp
        itemPrice = 100,
      },
      [120668] = { -- Tree, Squat Pink Cherry
        itemPrice = 10000,
      },
      [120669] = { -- Tree, Squat White Cherry
        itemPrice = 10000,
      },
}

-- MORROWIND
FurC.AchievementVendors[ver.MORROWIND] = FurC.AchievementVendors[ver.MORROWIND] or {}
FurC.AchievementVendors[ver.MORROWIND][loc.VVARDENFELL] = FurC.AchievementVendors[ver.MORROWIND][loc.VVARDENFELL] or {}
FurC.AchievementVendors[ver.MORROWIND][loc.VVARDENFELL][npc.HGF] = {
      [125481] = { -- Boulder, Volcanic Column
        itemPrice = 500,
      },
      [125483] = { -- Boulder, Volcanic Plug
        itemPrice = 500,
      },
      [125587] = { -- Mushroom ,Funnel Caps
        itemPrice = 15000,
      },
      [125588] = { -- Mushroom, Lanky Erupted Stinkcap
        itemPrice = 750,
      },
      [125593] = { -- Mushroom, Netch Shield Platform
        itemPrice = 25000,
      },
      [125594] = { -- Mushroom, Netch Shield Tower
        itemPrice = 20000,
      },
      [125599] = { --
        itemPrice = 750,
      },
      [125602] = { --
        itemPrice = 750,
      },
      [125601] = { --
        itemPrice = 750,
      },
      [125604] = { --
        itemPrice = 750,
      },
      [125612] = { -- Mushrooms, Funnel Cap Cluster
        itemPrice = 22500,
      },
      [125614] = { -- Mushrooms, Netch Hide Shade
        itemPrice = 750,
      },
      [125638] = { -- Rock, Volcanic Chunk
        itemPrice = 100,
      },
      [125639] = { -- Rock, Volcanic Slab
        itemPrice = 100,
      },
      [125641] = { -- Sapling, Forked Ashland
        itemPrice = 250,
      },
      [125642] = { -- Sapling, Lanky Ash Laurel
        itemPrice = 250,
      },
      [125643] = { -- Sapling, Sturdy Ash Laurel
        itemPrice = 250,
      },
      [125644] = { -- Sapling, Tall Ashland
        itemPrice = 250,
      },
      [125645] = { -- Saplings, Ashland
        itemPrice = 250,
      },
      [125673] = { -- Tree, Lanky Poplar
        itemPrice = 500,
      },
      [125678] = { -- Tree, Sturdy Poplar
        itemPrice = 500,
      },
      [125679] = { -- Tree, Poplar Cluster
        itemPrice = 500,
      },
      [125677] = { -- Tree, Rooted Ashland
        itemPrice = 40000,
      },
      [125676] = { -- Tree, Rooted Cedar
        itemPrice = 50000,
      },
}

-- HOMESTEAD
FurC.AchievementVendors[ver.HOMESTEAD] = FurC.AchievementVendors[ver.HOMESTEAD] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.DESHAAN] = FurC.AchievementVendors[ver.HOMESTEAD][loc.DESHAAN] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.DESHAAN][npc.HGF] = {
      [120567] = { -- Bush,Vibrant Barberry
        itemPrice = 250,
      },
      [120566] = { -- Fern Plant,Healthy Green
        itemPrice = 100,
      },
      [120574] = { -- Mushroom,Huge Chanterelle
        itemPrice = 250,
      },
      [120568] = { -- Mushroom,Tall Chanterelle
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.BALFOYEN] = FurC.AchievementVendors[ver.HOMESTEAD][loc.BALFOYEN] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.BALFOYEN][npc.HGF] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120621] = { -- Plant, Red Aloe
        itemPrice = 250,
      },
      [120620] = { -- Plant, Red Aloe Succulent
        itemPrice = 250,
      },
      [120618] = { -- Tree, Gnarled Ashflower
        itemPrice = 5000,
      },
      [120619] = { -- Tree, Twisted Ashflower
        itemPrice = 7500,
      },
      [120622] = { -- Vines, Clustered Ivy
        itemPrice = 600,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.STONEFALLS] = FurC.AchievementVendors[ver.HOMESTEAD][loc.STONEFALLS] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.STONEFALLS][npc.HGF] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [121028] = { -- Hedge, Dense Low Wall
        itemPrice = 1300,
      },

      [121284] = { -- Dark Elf Column Lantern
        itemPrice = 250,
      },

      [120621] = { -- Plant, Red Aloe
        itemPrice = 250,
      },
      [120620] = { -- Plant, Red Aloe Succulent
        itemPrice = 250,
      },
      [120618] = { -- Tree, Gnarled Ashflower
        itemPrice = 5000,
      },
      [120619] = { -- Tree, Twisted Ashflower
        itemPrice = 7500,
      },
      [120622] = { -- Vines, Clustered Ivy
        itemPrice = 600,
      },
      [120680] = { -- Topiary, Fragile Cypress
        itemPrice = 2500,
      },
      [120681] = { -- Topiary, Pruned Cypress
        itemPrice = 1100,
      },
      [120677] = { -- Tree, Autumn Cherry Blossom
        itemPrice = 15000,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.EASTMARCH] = FurC.AchievementVendors[ver.HOMESTEAD][loc.EASTMARCH] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.EASTMARCH][npc.HGF] = miscVendor
FurC.AchievementVendors[ver.HOMESTEAD][loc.SHADOWFEN] = FurC.AchievementVendors[ver.HOMESTEAD][loc.SHADOWFEN] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.SHADOWFEN][npc.HGF] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120630] = { -- Pebble, Stacked Lichen
        itemPrice = 100,
      },
      [120632] = { -- Pebble, Stacked Mossy
        itemPrice = 100,
      },
      [120637] = { -- Plant, Dry Spike
        itemPrice = 100,
      },
      [120627] = { -- Rocks, Stacked Angular
        itemPrice = 100,
      },
      [120628] = { -- Rocks, Slanted Mossy
        itemPrice = 100,
      },
      [120629] = { -- Rocks, Smooth Mossy
        itemPrice = 100,
      },
      [120634] = { -- Tree, Towering Swamp Palm
        itemPrice = 250,
      },
      [120636] = { -- Tree, Mud Palm
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.RIFT] = FurC.AchievementVendors[ver.HOMESTEAD][loc.RIFT] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.RIFT][npc.HGF] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120492] = { -- Boulder, Flat , Weathered
        itemPrice = 100,
      },
      [120496] = { -- Fern, dead
        itemPrice = 100,
      },
      [120494] = { -- Pebble, Stacked, Weathered
        itemPrice = 100,
      },
      [120493] = { -- Rock, Slanted, Tan
        itemPrice = 100,
      },
      [120495] = { -- Sapling, Budding Red
        itemPrice = 100,
      },
      [120500] = { -- Sapling, Tender Autumn
        itemPrice = 100,
      },
      [120499] = { -- Sapling, Tender Harvest
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.ALIKR] = FurC.AchievementVendors[ver.HOMESTEAD][loc.ALIKR] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.ALIKR][npc.HGF] = miscVendor
FurC.AchievementVendors[ver.HOMESTEAD][loc.BANG] = FurC.AchievementVendors[ver.HOMESTEAD][loc.BANG] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.BANG][npc.HGF] = {
      [120449] = { -- Bush, Desert Scrub
        itemPrice = 100,
      },
      [120457] = { -- Pebble, smooth desert
        itemPrice = 100,
      },
      [120461] = { -- Cactus, Desert Wine
        itemPrice = 500,
      },
      [120452] = { -- Pebble, smooth grey
        itemPrice = 100,
      },
      [120460] = { -- Plant, green water
        itemPrice = 100,
      },
      [120450] = { -- plant, squat Yucca
        itemPrice = 100,
      },
      [120462] = { -- Plant, tall flowering Yucca
        itemPrice = 100,
      },
      [120440] = { -- Rocks, Scattered, Weatherd
        itemPrice = 100,
      },
      [120454] = { -- Rocks, Stacked Desert
        itemPrice = 100,
      },
      [120438] = { -- Rocks, Stacked Weathered
        itemPrice = 100,
      },
      [120441] = { -- Sapling, Short Highland
        itemPrice = 100,
      },
      [120443] = { -- Sapling, Tall Highland
        itemPrice = 100,
      },
      [120442] = { -- Sapling, Squat Highland
        itemPrice = 100,
      },
      [120459] = { -- Shrub, Browncrub
        itemPrice = 100,
      },
      [120458] = { -- Shrub, Speckled Forest
        itemPrice = 250,
      },
      [120446] = { -- Small Juniper Tree
        itemPrice = 100,
      },
      [120451] = { -- Stones, Smooth Gray
        itemPrice = 100,
      },
      [120455] = { -- Stone, stacked desert
        itemPrice = 100,
      },
      [120439] = { -- Stone, tapered weathered
        itemPrice = 100,
      },
      [120445] = { -- Sturdy Juniper Tree
        itemPrice = 100,
      },
      [120453] = { -- Tree, hardened Juniper
        itemPrice = 100,
      },
      [120448] = { -- Tree, old Juniper
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.BETNIKH] = FurC.AchievementVendors[ver.HOMESTEAD][loc.BETNIKH] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.BETNIKH][npc.HGF] = miscVendor
FurC.AchievementVendors[ver.HOMESTEAD][loc.GLENUMBRA] = FurC.AchievementVendors[ver.HOMESTEAD][loc.GLENUMBRA] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GLENUMBRA][npc.HGF] = {
      [121011] = { -- Trees, young autumn birch
        itemPrice = 100,
      },
      [120713] = { -- Trees, Towering Autumn Birch
        itemPrice = 250,
      },
      [120720] = { -- Shrubs, Small Berry
        itemPrice = 100,
      },
      [120718] = { -- Shrub, Dense Forest
        itemPrice = 100,
      },
      [120717] = { -- Shrub, Autumn Forest
        itemPrice = 100,
      },
      [120711] = { -- Sapling, Young Birch
        itemPrice = 250,
      },
      [120716] = { -- Sapling, Autumn Cluster
        itemPrice = 100,
      },
      [120708] = { -- Rocks, Craggy set
        itemPrice = 100,
      },
      [120527] = { -- Fern Plant, Green Curly
        itemPrice = 100,
      },
      [120707] = { -- Boulder, Mossy Weathered
        itemPrice = 100,
      },
      [120705] = { -- Boulder, Mossy Grey
        itemPrice = 100,
      },
      [120706] = { -- Boulder, Giant Mossy
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.RIVENSPIRE] = FurC.AchievementVendors[ver.HOMESTEAD][loc.RIVENSPIRE] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.RIVENSPIRE][npc.HGF] = {
      [120578] = { -- Sapling, Young Aspen
        itemPrice = 100,
      },
      [120576] = { -- Sapling ,Fragile Aspen
        itemPrice = 100,
      },
      [120579] = { -- Flower, Stout Hibiscus
        itemPrice = 250,
      },
      [120580] = { -- Flower, Healthy Hibiscus
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.STORMHAVEN] = FurC.AchievementVendors[ver.HOMESTEAD][loc.STORMHAVEN] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.STORMHAVEN][npc.HGF] = {
      [120582] = { -- Tree, Yellowing Oak
        itemPrice = 20000,
      },
      [120442] = { -- Sapling, Squat Highland
        itemPrice = 100,
      },
      [120444] = { -- Sapling, Tall Highland
        itemPrice = 100,
      },
      [120443] = { -- Sapling, strong Highland
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.AURIDON] = FurC.AchievementVendors[ver.HOMESTEAD][loc.AURIDON] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.AURIDON][npc.HGF] = {
      [120663] = { -- Saplings, Healthy Forest
        itemPrice = 100,
      },
      [120662] = { -- Saplings, Squat Forest
        itemPrice = 100,
      },
      [120661] = { -- Saplings, Young Forest
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GREENSHADE] = FurC.AchievementVendors[ver.HOMESTEAD][loc.GREENSHADE] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GREENSHADE][npc.HGF] = {
      [120597] = { -- Fern Plant, Vibrant
        itemPrice = 100,
      },
      [120599] = { -- Fern, Healthy Green
        itemPrice = 100,
      },
      [120595] = { -- Fern, Lush
        itemPrice = 100,
      },
      [120600] = { -- Fern, Young, Healthy
        itemPrice = 100,
      },
      [120598] = { -- Plants, Low weeds
        itemPrice = 100,
      },
      [120588] = { -- Rock, Slanted Algae
        itemPrice = 100,
      },
      [120590] = { -- Rocks, Smooth Set
        itemPrice = 100,
      },
      [120592] = { -- Saplings, Highland Cluster
        itemPrice = 100,
      },
      [120593] = { -- Saplings, Twin Highland
        itemPrice = 100,
      },
      [120589] = { -- Stone, Slanted Weathered
        itemPrice = 100,
      },
      [120591] = { -- Tree, Vibrant Privet
        itemPrice = 250,
      },
      [120587] = { -- Boulder, Flat Grey
        itemPrice = 250,
      },
      [120586] = { -- Boulder, Moss Covered
        itemPrice = 250,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.KHENARTHI] = FurC.AchievementVendors[ver.HOMESTEAD][loc.KHENARTHI] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.KHENARTHI][npc.HGF] = miscVendor
FurC.AchievementVendors[ver.HOMESTEAD][loc.MALABAL] = FurC.AchievementVendors[ver.HOMESTEAD][loc.MALABAL] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.MALABAL][npc.HGF] = {
      [120529] = { -- Fern Cluster, Healthy
        itemPrice = 100,
      },
      [120531] = { -- Fern Fronts, Healthy Green
        itemPrice = 100,
      },
      [120530] = { -- Fern Fronds, Sunburst
        itemPrice = 100,
      },
      [120527] = { -- Fern Plant, Green Curly
        itemPrice = 100,
      },
      [120528] = { -- Fern Plant, Sturdy Mature
        itemPrice = 100,
      },
      [120640] = { -- Fern, Budding Forest
        itemPrice = 100,
      },
      [120641] = { -- Fern, Low Red
        itemPrice = 100,
      },
      [120642] = { -- Mushrooms, Brown Gilled
        itemPrice = 100,
      },
      [120534] = { -- Mushroom, Bruising Webcap
        itemPrice = 250,
      },
      [120532] = { -- Mushrooms, Poison Pax Cluster
        itemPrice = 100,
      },
      [120533] = { -- Mushrooms, Poison Pax Group
        itemPrice = 100,
      },
      [120638] = { -- Rock, Slanted Weathered
        itemPrice = 100,
      },
      [120523] = { -- Rocks, Mossy Cluster
        itemPrice = 100,
      },
      [120524] = { -- Rocks, Mossy Set
        itemPrice = 100,
      },
      [120639] = { -- Stones, Smooth Mossy
        itemPrice = 100,
      },
      [120525] = { -- Tree, Mossy Swamp
        itemPrice = 100,
      },
      [120643] = { -- Vines, Curtain Ivy
        itemPrice = 750,
      },
      [120645] = { -- Vines, Draped Ivy
        itemPrice = 750,
      },
      [120644] = { -- Vines, Lush Ivy
        itemPrice = 600,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GRAHTWOOD] = FurC.AchievementVendors[ver.HOMESTEAD][loc.GRAHTWOOD] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GRAHTWOOD][npc.HGF] = {
      [120725] = { -- Boulder, Mossy Crag
        itemPrice = 100,
      },
      [121285] = { -- Tree, Ancient Banyan
        itemPrice = 25000,
      },
      [121286] = { -- Tree, Giant Cypress
        itemPrice = 5000,
      },
      [121287] = { -- Tree, Towering Cypress
        itemPrice = 5000,
      },
      [120742] = { -- Tree, Twisted Banyan
        itemPrice = 25000,
      },
      [119578] = { -- Tree, Towering Palm Cluster
        itemPrice = 100,
      },
      [120741] = { -- Tree, Towering Wax Palm
        itemPrice = 250,
      },
      [121288] = { -- Tree, Mossy Murkmire Cluster
        itemPrice = 250,
      },
      [117975] = { -- Rough Hay Bed, Sloppy
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.REAPER] = FurC.AchievementVendors[ver.HOMESTEAD][loc.REAPER] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.REAPER][npc.HGF] = {
      [120998] = { -- Block, Wood Cutting
        itemPrice = 100,
      },
      [120511] = { -- Bush, Mountain Scrub
        itemPrice = 100,
      },
      [120690] = { -- Fern Plant, Hardy
        itemPrice = 100,
      },
      [120510] = { -- Fern Plant, Sturdy Towering
        itemPrice = 100,
      },
      [120512] = { -- Fern, Fragile
        itemPrice = 100,
      },
      [120521] = { -- Fern, Withering
        itemPrice = 100,
      },
      [120691] = { -- Fern, Young Sunburnt
        itemPrice = 100,
      },
      [120703] = { -- Khajiit Column, Spiked
        itemPrice = 4000,
      },
      [120561] = { -- Plant, Jungle Leaf
        itemPrice = 100,
      },
      [120697] = { -- Plant, Leafy Sprouts
        itemPrice = 100,
      },
      [120560] = { -- Plant, Squat Jungle Leaf
        itemPrice = 100,
      },
      [120562] = { -- Plant, Towering Jungle Leaf
        itemPrice = 100,
      },
      [120699] = { -- Platform, Weathered Dock
        itemPrice = 250,
      },
      [120700] = { -- Post, Barnacle Covered
        itemPrice = 100,
      },
      [120515] = { -- Shrub, Lanky Highland
        itemPrice = 100,
      },
      [120522] = { -- Shrub, Tender Privet
        itemPrice = 100,
      },
      [117990] = { -- Tea Table, Carved
        itemPrice = 250,
      },
      [121282] = { -- Tree, Ancient Jungle
        itemPrice = 5000,
      },
      [121283] = { -- Tree, Healthy Jungle
        itemPrice = 250,
      },
      [120519] = { -- Tree, Healthy Privet
        itemPrice = 250,
      },
      [120687] = { -- Tree, Sturdy Shade
        itemPrice = 250,
      },
      [120558] = { -- Sapling, Eucalyptus Shrub
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.CRAGLORN] = FurC.AchievementVendors[ver.HOMESTEAD][loc.CRAGLORN] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.CRAGLORN][npc.HGF] = {
      [120964] = { -- Boulder, Craggy Heap
        itemPrice = 100,
      },
      [120545] = { -- Tree, Sturdy Summer
        itemPrice = 250,
      },
      [120963] = { -- Boulder, Jagged Crag
        itemPrice = 100,
      },
      [120552] = { -- Bush, Flowering Scrub
        itemPrice = 250,
      },
      [120555] = { -- Flowers, Healthy Goldenrod
        itemPrice = 250,
      },
      [120551] = { -- Plant, Healthy Sage
        itemPrice = 100,
      },
      [120977] = { -- Plant, Strong Sage
        itemPrice = 100,
      },
      [120966] = { -- Rock, Craggy Rubble
        itemPrice = 100,
      },
      [120539] = { -- Rock, Jagged Craggy
        itemPrice = 100,
      },
      [120969] = { -- Sapling, Crabapple
        itemPrice = 100,
      },
      [120972] = { -- Sapling, Desert
        itemPrice = 100,
      },
      [120548] = { -- Sapling, Leaning Ash
        itemPrice = 100,
      },
      [120973] = { -- Sapling, Mountain
        itemPrice = 100,
      },
      [120983] = { -- Sapling, Mountain
        itemPrice = 100,
      },
      [120971] = { -- Sapling, Tall Scrub
        itemPrice = 100,
      },
      [120982] = { -- Sapling, Twisted
        itemPrice = 100,
      },
      [120553] = { -- Sapling, Young Scrub
        itemPrice = 100,
      },
      [120976] = { -- Sapling, Juniper Cluster
        itemPrice = 100,
      },
      [120981] = { -- Sapling, Desert Scrub
        itemPrice = 100,
      },
      [120967] = { -- Stone, Angled Grey
        itemPrice = 100,
      },
      [120975] = { -- Tree, Angled Ash
        itemPrice = 100,
      },
      [120543] = { -- Tree, Blooming Crabapple
        itemPrice = 6000,
      },
      [120549] = { -- Tree, Large Twisted Ash
        itemPrice = 250,
      },
      [120547] = { -- Tree, Leaning Ash
        itemPrice = 250,
      },
      [120970] = { -- Tree, Sturdy Crabapple
        itemPrice = 13000,
      },
      [120974] = { -- Tree, Sturdy Summer
        itemPrice = 250,
      },
      [120550] = { -- Tree, Twisted
        itemPrice = 100,
      },
}
FurC.AchievementVendors[ver.HOMESTEAD][loc.COLDH] = FurC.AchievementVendors[ver.HOMESTEAD][loc.COLDH] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.COLDH][npc.HGF] = boxes
FurC.AchievementVendors[ver.HOMESTEAD][loc.GOLDCOAST] = FurC.AchievementVendors[ver.HOMESTEAD][loc.GOLDCOAST] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.GOLDCOAST][npc.HGF] = structures
FurC.AchievementVendors[ver.HOMESTEAD][loc.HEWSBANE] = FurC.AchievementVendors[ver.HOMESTEAD][loc.HEWSBANE] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.HEWSBANE][npc.HGF] = structures
FurC.AchievementVendors[ver.HOMESTEAD][loc.WROTHGAR] = FurC.AchievementVendors[ver.HOMESTEAD][loc.WROTHGAR] or {}
FurC.AchievementVendors[ver.HOMESTEAD][loc.WROTHGAR][npc.HGF] = {
      [117986] = { -- Rough Plank, Long
        itemPrice = 100,
      },
      [117985] = { -- Rough Bread, Morsel
        itemPrice = 100,
      },
      [117981] = { -- Rough Firewood, Smoldering
        itemPrice = 100,
      },
      [117976] = { -- Rough Hay Bed, Covered
        itemPrice = 100,
      },
      [117975] = { -- Rough Hay Bed, Sloppy
        itemPrice = 100,
      },
      [117974] = { -- Rough Hay Bed, Tidy
        itemPrice = 100,
      },
      [117964] = { -- Rough Fire, doused
        itemPrice = 100,
      },
      [117955] = { -- Box, Slatted
        itemPrice = 100,
      },
}

function FurC.InitHomeGoodsFurnisherList()
  local addTable, listTable

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.BALFOYEN][npc.HGF]
  addTable = merge(furnishingVendor, morrowindStones)
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.DESHAAN][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.STONEFALLS][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.SHADOWFEN][npc.HGF]
  addTable = furnishingVendor
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.RIFT][npc.HGF]
  addTable = furnishingVendor
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.BANG][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.STORMHAVEN][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.GREENSHADE][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.MALABAL][npc.HGF]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.REAPER][npc.HGF]
  listTable = merge(listTable, structures)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.GRAHTWOOD][npc.HGF]
  listTable = merge(listTable, furnishingVendor)
  listTable = merge(listTable, miscVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.CRAGLORN][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.COLDH][npc.HGF]
  listTable = merge(listTable, structures)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.GOLDCOAST][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.HEWSBANE][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.WROTHGAR][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.GLENUMBRA][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.RIVENSPIRE][npc.HGF]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][loc.WROTHGAR][npc.HGF]
  listTable = merge(listTable, structures)
end