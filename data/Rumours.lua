FurC.Rumours = FurC.Rumours or {}

local ver = FurC.Constants.Versioning

local rumourSource = GetString(SI_FURC_RUMOUR_SOURCE_ITEM)
local dataminedUnclear = GetString(SI_FURC_DATAMINED_UNCLEAR)

-- 29 Scions of Ithelia
FurC.Rumours[ver.SCIONS] = {
  [204455] = rumourSource, -- Redguard Tent, Squared Blue",
  [204434] = rumourSource, -- Breton Rowboat",
  [204433] = rumourSource, -- Lily Pads, Flowering Patch",
  [204432] = rumourSource, -- Lily Pads, Flowering Cluster",
  [204431] = rumourSource, -- Tree, Young Gentle Weeping Willow",
  [204430] = rumourSource, -- Tree, Tall Gentle Weeping Willow",
  [204429] = rumourSource, -- Tree, Giant Gentle Weeping Willow",
  [204428] = rumourSource, -- Stumps, Swampshadow Cluster",
  [204427] = rumourSource, -- Tree, Young Swampshadow",
  [204426] = rumourSource, -- Tree, Swampshadow",
  [204425] = rumourSource, -- Tree, Giant Swampshadow",
  [203899] = rumourSource, -- Redguard Tent, Rectangular Silk",
  [203898] = rumourSource, -- Redguard Tent, Rectangular Blue",
  [203897] = rumourSource, -- Redguard Tent, Blue Lean-To",
  [203896] = rumourSource, -- Bush, Cave Lichen Patch",
  [203895] = rumourSource, -- Bush, Cave Lichen Cluster",
  [203894] = rumourSource, -- Bush, Cave Lichen",
  [203888] = rumourSource, -- Replica Jubilee Cake Slice 2024",
  [203887] = rumourSource, -- Replica Jubilee Cake Slice 2023",
  [203886] = rumourSource, -- Replica Jubilee Cake Slice 2022",
  [203885] = rumourSource, -- Replica Jubilee Cake Slice 2021",
  [203884] = rumourSource, -- Replica Jubilee Cake Slice 2020",
  [203883] = rumourSource, -- Replica Jubilee Cake Slice 2019",
  [203882] = rumourSource, -- Replica Jubilee Cake Slice 2016-2018",
  [203829] = rumourSource, -- Replica Jubilee Cake 2024",
  [203599] = rumourSource, -- Redguard Fountain, Lion",
  [203598] = rumourSource, -- Flowers, Desert Blush",
  [203597] = rumourSource, -- Shrubs, Speckled Forest Cluster",
  [203596] = rumourSource, -- Ferns, Desert Cluster",
  [203595] = rumourSource, -- Vampiric Cage, Hanging",
  [203594] = rumourSource, -- Druidic Cage, Ivy",
  [203593] = rumourSource, -- Deadlands Brazier",
  [203592] = rumourSource, -- Orc Brazier",
  [203591] = rumourSource, -- Flowers, Dibella's Tears",
  [203590] = rumourSource, -- Flowers, Snowspray",
  [203589] = rumourSource, -- Festering Coral, Large Crimson-Orange",
  [203588] = rumourSource, -- Alinor Boat, Unfinished",
  [203587] = rumourSource, -- Redguard Colonnade, Mosaic",
  [203586] = rumourSource, -- Redguard Archway, Brass",
  [203585] = rumourSource, -- Alinor Maple, Large Red",
  [203584] = rumourSource, -- Altmer Stable, Summerset",
  [203583] = rumourSource, -- Ayleid Panel, Arched",
  [203582] = rumourSource, -- Ayleid Doorway, Tall Arched",
  [203313] = rumourSource, -- Many Paths Monument",
  [203312] = rumourSource, -- Mirror Barrier, Shattered",
  [203276] = rumourSource, -- Rough Dresser",
  [203275] = rumourSource, -- Fish, Silver Trout",
  [203274] = rumourSource, -- Box of Tomatoes",
  [203273] = rumourSource, -- Rough Chair",
  [203272] = rumourSource, -- Rough Bench",
  [203271] = rumourSource, -- Banner, Jester's Festival",
  [203270] = rumourSource, -- Target King Boar, Robust",
  [203269] = rumourSource, -- Chamber Pot Throne",
  [203268] = rumourSource, -- Jester's Festival Stage",
  [203267] = rumourSource, -- Order of the Lamp Pedestal",
  [203266] = rumourSource, -- Twinkling Lights, Blue",
  [203265] = rumourSource, -- Prismatic Cherry Tree",
  [203264] = rumourSource, -- Cursed Curio Aether",
  [203165] = rumourSource, -- Dazzler Dispenser",
  [117914] = rumourSource, -- Redguard Canopy, Florid",
  [117912] = rumourSource, -- Redguard Awning, Florid",
  [117873] = rumourSource, -- Redguard Rugs, Rolled",
  [117867] = rumourSource, -- Statue, Redguard's Respect",
  [117862] = rumourSource, -- Redguard Cart, Merchant",
  [116485] = rumourSource, -- Orcish Shrine, Malacath",
}

-- 28 Secrets of the Telvanni Peninsula
FurC.Rumours[ver.ENDLESS] = {
  [203202] = rumourSource, -- Hermaeus Mora Banner, Large",
  [203178] = rumourSource, -- Apocrypha Coral, Large Teal Tube",
  [203177] = rumourSource, -- Apocrypha Coral, Pink Tube",
  [203176] = rumourSource, -- Apocrypha Geyser, Ink",
  [203166] = rumourSource, -- Sai Sahan Statue",
  [203151] = rumourSource, -- Falmer Gate, Stick"
  [203150] = rumourSource, -- Falmer Fence, Stick",
  [203149] = rumourSource, -- Redguard Seal, Spider",
  [203148] = rumourSource, -- Argonian Puzzle Totem, Head",
  [203147] = rumourSource, -- Shelf, Folded Laundry",
  [203146] = rumourSource, -- Wood Elf Banner, Mages Guild",
  [203145] = rumourSource, -- Banner, Foodhall",
  [203138] = rumourSource, -- Apocrypha Plant, Feather Fern",
  [203135] = rumourSource, -- Redguard Dome, Mosaic",
  [203133] = rumourSource, -- Apocrypha Coral, Spiky",
  [203132] = rumourSource, -- Mushroom, Apocrypha Fossilized",
  [199136] = rumourSource, -- Apocrypha Stalks, Scryeball Patch",
  [199135] = rumourSource, -- Apocrypha Pool, Inky",
  [199134] = rumourSource, -- Apocrypha Waterfall, Inky",
  [199133] = rumourSource, -- Target Daedra, Seeker",
  [199125] = rumourSource, -- Inky Waterup Table",
  [199124] = rumourSource, -- Green ink ceiling light",
  [199123] = rumourSource, -- Cabinet of Curiosities",
  [199122] = rumourSource, -- Redguard Bottle, Glowing",
  [199121] = rumourSource, -- Inky Incense Burner",
  [199120] = rumourSource, -- Framed Vision",
  [199113] = rumourSource, -- Snow Globe Music Box",
  [198747] = rumourSource, -- Druidic Statue, Ancient Augur",
  [198674] = rumourSource, -- Galen Dogwood, Tall",
  [198672] = rumourSource, -- Vines, Verdant Ivy Runner",
  [198671] = rumourSource, -- Druid King's Sentinel",
  [198670] = rumourSource, -- Druidic Hut, Conical Stone",
  [198669] = rumourSource, -- Breton Statue, Chimera",
  [198667] = rumourSource, -- Galen Dogwood, Curved",
  [198666] = rumourSource, -- Galen Dogwood, Twisted",
  [198665] = rumourSource, -- Plant, Emerald Heart Begonia",
  [198664] = rumourSource, -- Galen Dogwood, Small",
  [198663] = rumourSource, -- Fern Plant, Low Lush",
  [198662] = rumourSource, -- Flowers, Orange Daylily Cluster",
  [198661] = rumourSource, -- Druidic Pot, Stout Clay",
  [198660] = rumourSource, -- Druidic Pitcher, Clay",
  [198659] = rumourSource, -- Druidic Kettle, Clay",
  [198658] = rumourSource, -- Druidic Pot, Wide Clay",
  [198657] = rumourSource, -- Druidic Plate, Clay",
  [198656] = rumourSource, -- Druidic Plates, Clay Stack",
  [198655] = rumourSource, -- Druidic Covered Dish, Stone",
  [198654] = rumourSource, -- Druidic Plate, Stone",
  [198653] = rumourSource, -- Druidic Goblet, Stone",
  [198652] = rumourSource, -- Druidic Bowl, Stone",
  [198651] = rumourSource, -- Druidic Brazier, Standing",
  [198650] = rumourSource, -- Druidic Brazier, Leaning",
  [198649] = rumourSource, -- Druidic Smoking Rack, Fish",
  [198648] = rumourSource, -- Druidic Rack, Hide Stretcher",
  [198647] = rumourSource, -- Druidic Drying Rack, Tall",
  [198646] = rumourSource, -- Druidic Drying Rack, Wide",
  [198574] = rumourSource, -- Khajiiti Water Vessel, Large",
}

-- 27 Base Game Patch
FurC.Rumours[ver.BASED] = {
  [198561] = rumourSource, -- Vine, Wide Moonlit Ivy Drape
  [198560] = rumourSource, -- Vine, Large Moonlit Ivy Swath
  [198559] = rumourSource, -- Vine, Large Moonlit Ivy Drape
  [198558] = rumourSource, -- Vine, Medium Moonlit Ivy Swath
  [198557] = rumourSource, -- Vine, Small Moonlit Ivy Drape
  [198555] = rumourSource, -- Shrub, Moonlit Ivy
  [198371] = rumourSource, -- Necrom Lamppost, Single
  [198319] = rumourSource, -- Ice Sculpture
  [198109] = rumourSource, -- Trees, Dead Oak Sapling Duo
  [198108] = rumourSource, -- Tree, Twisted Dead Oak Sapling
  [198107] = rumourSource, -- Trees, Dead Oak Sapling Cluster
  [198106] = rumourSource, -- Tree, Dead Oak Sapling
  [198105] = rumourSource, -- Tree, Large Ancient Dead Oak
  [198104] = rumourSource, -- Tree, Old Dead Oak
  [198103] = rumourSource, -- Tree, Ancient Dead Oak
  [198005] = rumourSource, -- Hedge, Dense Low Angled Wall
  [198004] = rumourSource, -- Hedge, Dense Low Extensive Wall
  [198003] = rumourSource, -- Hedge, Dense Low Corner Wall
  [198002] = rumourSource, -- Hedge, Dense Low Long Wall
  [197840] = rumourSource, -- Necrom Brazier, Elegant Stone
  [197839] = rumourSource, -- Mushrooms, Ambershine Ring
  [197838] = rumourSource, -- Mushrooms, Ambershine Patch
  [197837] = rumourSource, -- Mushrooms, Tall Green Morel Cluster
  [197836] = rumourSource, -- Mushroom, Tall Green Morel
  [197835] = rumourSource, -- Mushrooms, Tall Chanterelle Cluster
  [197834] = rumourSource, -- Statue, Telvanni Magister
  [197833] = rumourSource, -- Statue, Telvanni Spellwright
  [197832] = rumourSource, -- Necrom Gazebo
  [197826] = rumourSource, -- Music Box, Witchmother's Bubbling Brew
  [197825] = rumourSource, -- Statue, The Thirty-Fourth Sermon
}

-- 26 Necrom
FurC.Rumours[ver.NECROM] = {
  [197704] = rumourSource, -- Book of Whispers",
  [197625] = rumourSource, -- Music Box, Oath of the Keepers",
  [197623] = rumourSource, -- Statue, Hermaeus Mora",
  [194539] = rumourSource, -- Rough Hammock, Pole-Strung",
  [194538] = rumourSource, -- Cargo Netting, Large",
  [194536] = rumourSource, -- Dock Buoys, Mounted",
  [194534] = rumourSource, -- Dock Bell, Mounted",
  [190942] = rumourSource, -- Music Box, Sheogorath Butterfly Garden",
  [120485] = rumourSource, -- Cactus, Columnar",
  [118288] = rumourSource, -- Deer Carcass, Hanging",
  [116474] = rumourSource, -- Orcish Effigy, Bear",
  [116473] = rumourSource, -- Orcish Effigy, Mammoth",
  [115708] = rumourSource, -- Khajiit Tile, Waning Moons",
  [115707] = rumourSource, -- Khajiit Tile, Waxing Moons",
  [115706] = rumourSource, -- Khajiit Tile, Full Moons",
  [115705] = rumourSource, -- Khajiit Tile, New Moons",
}

-- 25 Scribes of Fate
FurC.Rumours[ver.SCRIBE] = {
  [190941] = rumourSource, -- Music Box, Direnni's Swan,
}

-- 24 Firesong
FurC.Rumours[ver.DRUID] = {
  [190939] = rumourSource, -- Music Box, Dawnbreaker's Forging",
}

-- 23 Lost Depths
FurC.Rumours[ver.DEPTHS] = {}

-- 22 High Isle
FurC.Rumours[ver.BRETON] = {}

-- 21 Ascending Tide
FurC.Rumours[ver.TIDES] = {}

-- 20 Deadlands
FurC.Rumours[ver.DEADL] = {
  [182925] = rumourSource, -- Rocks, Deadlands Cluster,
  [182922] = rumourSource, -- Vines, Thornpinch,
  [182921] = rumourSource, -- Fargrave Canopy, Large,
  [181611] = rumourSource, -- Vines, Snow Lillies Climber,
  [181610] = rumourSource, -- Vines, Snow Lillies Swath,
  [181609] = rumourSource, -- Tree, Blackwood Beech Cluster,
  [181608] = rumourSource, -- Tree, Blackwood Beech,
  [181607] = rumourSource, -- Tree, Elder Blackwood Beech,
  [181606] = rumourSource, -- Rock, Gabbro Boulder Cluster,
  [181605] = rumourSource, -- Rock, Gabbro Set,
  [181603] = rumourSource, -- Plant, White Flowered Lily Pads,
  [181601] = rumourSource, -- Rock, Wide Gabbro Slab,
  [181600] = rumourSource, -- Rock, Gabbro Boulder,
  [178502] = rumourSource, -- An Ode to the Disenfranchised,
  [178501] = rumourSource, -- The Nomads of Nirn,
  [178500] = rumourSource, -- Museum Guild Letter,
  [178499] = rumourSource, -- Goldleaf Acquisitions, Manager's Notes,
  [178497] = rumourSource, -- The Sonnet of Aetherius Art,
  [178476] = rumourSource, -- Guild Banner, Nomads of Nirn,
  [178475] = rumourSource, -- Guild Banner, Museum,
  [178474] = rumourSource, -- Guild Banner, Goldleaf Acquisitions,
  [178473] = rumourSource, -- Guild Banner, The Disenfranchised,
  [178471] = rumourSource, -- Guild Banner, Aetherius Art,
  [175578] = rumourSource, -- Banner, Meridia,
  [175135] = rumourSource, -- Statue, Prince of Ambition,
  [171940] = rumourSource, -- Statue of Sheogorath, Shivering Isles Sovereign,
  [171875] = rumourSource, -- Target Harrowing Reaper, Trial,
  [171836] = rumourSource, -- Tree, Charred Slim Vvardenfell Pine,
  [171835] = rumourSource, -- Tree, Charred Leaning Vvardenfell Pine,
  [171834] = rumourSource, -- Tree, Charred Vvardenfell Pine,
  [171819] = rumourSource, -- Tree, Towering Cork Oak,
  [171818] = rumourSource, -- Tree, Giant Cork Oak,
  [126590] = rumourSource, -- Vvardenfell Mushrooms, Lavaburst,
  [126589] = rumourSource, -- Vvardenfell Mushrooms, Bloodtooth,
  [126588] = rumourSource, -- Vvardenfell Pitcher Plants, Hanging Bunch,
  [126136] = rumourSource, -- Dwarven Lantern, Powered,
  [120997] = rumourSource, -- Banner, Tattered Blue,
  [120984] = rumourSource, -- Plant, Goldenrod Cluster,
  [120851] = rumourSource, -- Gallows,
}

-- 19 Blackwood
FurC.Rumours[ver.BLACKW] = {}

-- 18 Flames of Ambition
FurC.Rumours[ver.FLAMES] = {}

-- 17 Markarth
FurC.Rumours[ver.MARKAT] = {
  [171382] = rumourSource, -- Reachmen Pergola, Ivy Overhang,
  [167306] = rumourSource, -- Tree, Towering Snowy White Pine,
  [167302] = rumourSource, -- Solitude Brazier, Metal,
  [167297] = rumourSource, -- Trees, Young Snowy White Pine Cluster,
  [167296] = rumourSource, -- Tree, Giant Snowy White Pine,
  [167295] = rumourSource, -- Tree, Great Snowy White Pine,
  [167293] = rumourSource, -- Shrub, Long Amber Bayberry,
  [167292] = rumourSource, -- Rocks, Large Jagged Set,
  [167291] = rumourSource, -- Tree, Towering Royal Pine,
  [167290] = rumourSource, -- Tree, Great Lowland White Pine,
  [167289] = rumourSource, -- Tree, Lowland White Pine,
  [160541] = rumourSource, -- Outfit Station, Clockwork,
  [153841] = rumourSource, -- Rewoven Khajiiti Tapestry,
}

-- 16 Stonethorn
FurC.Rumours[ver.STONET] = {
  [119970] = rumourSource, -- Redguard Round Table
  [119690] = rumourSource, -- Banner of Hircine
  [119689] = rumourSource, -- Arch of the Wild Hunt
  [119688] = rumourSource, -- Basin of the Wild Hunt
  [119687] = rumourSource, -- Statue of the Wild Hunt
  [119686] = rumourSource, -- Totem of the Wild Hunt
  [119679] = rumourSource, -- Covenant Pennant, Small
  [119678] = rumourSource, -- Covenant Keep Pennant
  [119677] = rumourSource, -- Surplus Covenant Cold Fire Trebuchet
  [119676] = rumourSource, -- Surplus Covenant Cold Fire Ballista
  [119674] = rumourSource, -- Surplus Covenant Iceball Trebuchet
  [119673] = rumourSource, -- Surplus Covenant Meatbag Catapult
  [119672] = rumourSource, -- Surplus Covenant Lightning Ballista
  [119671] = rumourSource, -- Surplus Covenant Forward Camp
  [119670] = rumourSource, -- Surplus Covenant Firepot Trebuchet
  [119669] = rumourSource, -- Surplus Covenant Oil Catapult
  [119668] = rumourSource, -- Surplus Covenant Fire Ballista
  [119667] = rumourSource, -- Surplus Covenant Battering Ram
  [119666] = rumourSource, -- Surplus Covenant Stone Trebuchet
  [119665] = rumourSource, -- Surplus Covenant Scattershot Catapult
  [119664] = rumourSource, -- Surplus Covenant Ballista
  [119663] = rumourSource, -- Decommissioned Covenant Flaming Oil
  [119662] = rumourSource, -- Spare Covenant Ballista Figurehead
  [119661] = rumourSource, -- Surplus Covenant Point Capture Flag
  [119660] = rumourSource, -- Covenant Wall Banner, Large
  [119659] = rumourSource, -- Covenant Camp Banner
  [119658] = rumourSource, -- Covenant Wall Banner, Medium
  [119657] = rumourSource, -- Covenant Wall Banner, Small
  [119652] = rumourSource, -- Defaced Pact Flag
  [119640] = rumourSource, -- Decommissioned Pact Flaming Oil
  [119633] = rumourSource, -- Dominion Pennant, Small
  [119632] = rumourSource, -- Dominion Keep Pennant
  [119631] = rumourSource, -- Surplus Dominion Cold Fire Trebuchet
  [119630] = rumourSource, -- Surplus Dominion Cold Fire Ballista
  [119628] = rumourSource, -- Surplus Dominion Iceball Trebuchet
  [119627] = rumourSource, -- Surplus Dominion Meatbag Catapult
  [119626] = rumourSource, -- Surplus Dominion Lightning Ballista
  [119625] = rumourSource, -- Surplus Dominion Forward Camp
  [119624] = rumourSource, -- Surplus Dominion Firepot Trebuchet
  [119623] = rumourSource, -- Surplus Dominion Oil Catapult
  [119622] = rumourSource, -- Surplus Dominion Fire Ballista
  [119621] = rumourSource, -- Surplus Dominion Battering Ram
  [119620] = rumourSource, -- Surplus Dominion Stone Trebuchet
  [119619] = rumourSource, -- Surplus Dominion Scattershot Catapult
  [119618] = rumourSource, -- Surplus Dominion Ballista
  [119616] = rumourSource, -- Spare Dominion Ballista Figurehead
  [119615] = rumourSource, -- Surplus Dominion Point Capture Flag
  [119614] = rumourSource, -- Dominion Wall Banner, Large
  [119613] = rumourSource, -- Dominion Camp Banner
  [119612] = rumourSource, -- Dominion Wall Banner, Medium
  [119611] = rumourSource, -- Dominion Wall Banner, Small
  [119589] = rumourSource, -- Mushrooms, Auridon Group
  [119588] = rumourSource, -- Auridon Mushrooms, Cluster
  [119586] = rumourSource, -- Auridon Fern, Squat
  [119585] = rumourSource, -- Auridon Fern, Tall
  [119584] = rumourSource, -- Auridon Fern, Orange
  [119583] = rumourSource, -- Rough Limestone Tile
  [119582] = rumourSource, -- Rough Timber
  [119579] = rumourSource, -- Murky Palm Tree
  [119576] = rumourSource, -- Palm Tree Cluster
  [119575] = rumourSource, -- Tree, Slender Oak
  [119574] = rumourSource, -- Twisted Oak Tree
  [119573] = rumourSource, -- Young Oak Tree
  [119570] = rumourSource, -- Tree, Topal Weeping Willow
  [119568] = rumourSource, -- Craglorn Ash Tree
  [118909] = rumourSource, -- Remains, Wrapped
  [118908] = rumourSource, -- Lantern, Ship Captain's
  [118895] = rumourSource, -- Bones, Torso
  [118894] = rumourSource, -- Bone, Right Calf
  [118893] = rumourSource, -- Bone, Left Calf
  [118891] = rumourSource, -- Cranium, Human
  [118889] = rumourSource, -- Bone, Pelvis
  [118888] = rumourSource, -- Bone, Right Leg
  [118887] = rumourSource, -- Bone, Left Leg
  [118886] = rumourSource, -- Bone, Humerus
  [118885] = rumourSource, -- Bone, Right Hand
  [118884] = rumourSource, -- Bone, Left Hand
  [118883] = rumourSource, -- Bone, Forearm
  [118878] = rumourSource, -- Bone, Left Arm
  [118877] = rumourSource, -- Bone, Right Arm
  [118856] = rumourSource, -- Remains, Wamasu
  [118825] = rumourSource, -- Remains, Bear
  [118797] = rumourSource, -- Skull, Dragon
  [118796] = rumourSource, -- Skull, Mammoth
  [118795] = rumourSource, -- Skull, Giant Mammoth
  [118794] = rumourSource, -- Skeletal Remains, Orc Prone
  [118792] = rumourSource, -- Skeletal Remains, Khajiiti Side
  [118790] = rumourSource, -- Skeletal Remains, Argonian Side
  [118788] = rumourSource, -- Skeletal Remains, Prone
  [118785] = rumourSource, -- Post, Skulls
  [118784] = rumourSource, -- Post, Skull
  [118781] = rumourSource, -- Heirloom PvP Outlaw Tapestry
  [118780] = rumourSource, -- Heirloom PvP Wormcult Banner
  [118779] = rumourSource, -- Heirloom PvP Wormcult Tapestry
  [118778] = rumourSource, -- Heirloom PvP Imperial Tapestry
  [118777] = rumourSource, -- Heirloom PvP Imperial Banner
  [118776] = rumourSource, -- Pennant, Undaunted
  [118774] = rumourSource, -- Standard, Undaunted
  [118768] = rumourSource, -- Heirloom PvP Ebonheart Siege Head
  [118767] = rumourSource, -- Heirloom PvP Ebonheart Flag
  [118766] = rumourSource, -- Heirloom PvP Ebonheart Standard
  [118765] = rumourSource, -- Heirloom PvP Ebonheart Sign
  [118764] = rumourSource, -- Heirloom PvP Ebonheart Penant
  [118763] = rumourSource, -- Heirloom PvP Ebonheart Banner
  [118762] = rumourSource, -- Heirloom PvP Ebonheart Tapestry
  [118761] = rumourSource, -- Heirloom PvP Aldmeri Siege Head
  [118760] = rumourSource, -- Heirloom PvP Aldmeri Flag
  [118759] = rumourSource, -- Heirloom PvP Aldmeri Standard
  [118758] = rumourSource, -- Heirloom PvP Aldmeri Sign
  [118757] = rumourSource, -- Heirloom PvP Aldmeri Penant
  [118756] = rumourSource, -- Heirloom PvP Aldmeri Banner
  [118755] = rumourSource, -- Heirloom PvP Aldmeri Tapestry
  [118754] = rumourSource, -- Heirloom PvP Daggerfall Siege Head
  [118753] = rumourSource, -- Heirloom PvP Daggerfall Flag
  [118752] = rumourSource, -- Heirloom PvP Daggerfall Standard
  [118751] = rumourSource, -- Heirloom PvP Daggerfall Sign
  [118750] = rumourSource, -- Heirloom PvP Daggerfall Penant
  [118749] = rumourSource, -- Heirloom PvP Daggerfall Banner
  [118748] = rumourSource, -- Heirloom PvP Daggerfall Tapestry
  [118744] = rumourSource, -- Tile, Constellation
  [118482] = rumourSource, -- Book Stack, Tall
  [118354] = rumourSource, -- Box of Fruit
  [118353] = rumourSource, -- Box of Grapes
  [118352] = rumourSource, -- Box of Oranges
  [118350] = rumourSource, -- Box of Tangerines
  [118325] = rumourSource, -- Jar, Yellow Dye
  [118324] = rumourSource, -- Jar, Blue Dye
  [118323] = rumourSource, -- Jar, Covered Dye
  [118321] = rumourSource, -- Jar, Pink Dye
  [118320] = rumourSource, -- Jar, Orange Dye
  [118319] = rumourSource, -- Cask, Yellow Dye
  [118318] = rumourSource, -- Cask, Blue Dye
  [118317] = rumourSource, -- Cask, Green Dye
  [118316] = rumourSource, -- Cask, Pink Dye
  [118315] = rumourSource, -- Cask, Orange Dye
  [118314] = rumourSource, -- Barrel, Empty Dye
  [118313] = rumourSource, -- Barrel, Yellow Dye
  [118312] = rumourSource, -- Barrel, Blue Dye
  [118311] = rumourSource, -- Barrel, Covered Dye
  [118310] = rumourSource, -- Barrel, Green Dye
  [118309] = rumourSource, -- Barrel, Pink Dye
  [118308] = rumourSource, -- Barrel, Orange Dye
  [118277] = rumourSource, -- Ram Horns, Mounted
  [118264] = rumourSource, -- Tuffet, Faded Yellow
  [118263] = rumourSource, -- Tuffet, Faded Blue
  [118262] = rumourSource, -- Tuffet, Faded Red
  [118258] = rumourSource, -- Pillow Roll, Faded Yellow
  [118257] = rumourSource, -- Pillow Roll, Faded Blue
  [118256] = rumourSource, -- Pillow Roll, Faded Red
  [118255] = rumourSource, -- Pillow, Faded Blue Floral
  [118254] = rumourSource, -- Pillow, Faded Purple Floral
  [118253] = rumourSource, -- Pillow, Faded Red Floral
  [118252] = rumourSource, -- Pillow, Faded Yellow Floral
  [118251] = rumourSource, -- Pillow, Faded Blue
  [118250] = rumourSource, -- Pillow, Faded Purple
  [118249] = rumourSource, -- Pillow, Faded Red
  [118248] = rumourSource, -- Pillow, Faded Yellow
  [118240] = rumourSource, -- Cake, Anniversary
  [118239] = rumourSource, -- Vial of Blood
  [118174] = rumourSource, -- Shutters, Blue Lattice
  [118168] = rumourSource, -- Block, Carved Stone
  [118157] = rumourSource, -- Runner of the Sun, Faded
  [118156] = rumourSource, -- Runner of the Oasis, Faded
  [118155] = rumourSource, -- Carpet Roll, Desert
  [118154] = rumourSource, -- Carpet Roll, Oasis
  [118153] = rumourSource, -- Carpet Roll, Floral
  [118152] = rumourSource, -- Carpet Roll, Sunrise
  [118151] = rumourSource, -- Carpet Roll, Sunset
  [118150] = rumourSource, -- Carpet Roll, Colorful
  [118137] = rumourSource, -- Podium, Engraved
  [118128] = rumourSource, -- Pelt, Hanging
  [118125] = rumourSource, -- Plaque, Large
  [118124] = rumourSource, -- Pelt, Wolf
  [118123] = rumourSource, -- Pelt, Ice Wolf
  [118117] = rumourSource, -- Table, Carved
  [118112] = rumourSource, -- Teapot, Common
  [118111] = rumourSource, -- Steak, Display
  [118106] = rumourSource, -- Painting Palette
  [118105] = rumourSource, -- Painting Brush, Angled
  [118104] = rumourSource, -- Painting Brush, Detail
  [118103] = rumourSource, -- Painting Brush, Wide
  [118100] = rumourSource, -- Horn, Carved
  [118079] = rumourSource, -- Banner, Crafting
  [118078] = rumourSource, -- Banner, Mighty
  [118077] = rumourSource, -- Banner, Forceful
  [118076] = rumourSource, -- Banner, Forge
  [118075] = rumourSource, -- Banner, War
  [117962] = rumourSource, -- Rough Bedroll, Rolled
  [117951] = rumourSource, -- Rough Torch, Basic
  [117949] = rumourSource, -- Rough Candle, Pillar
  [117948] = rumourSource, -- Rough Candle, Tealight
  [117947] = rumourSource, -- Rough Spoon, Common
  [117946] = rumourSource, -- Rough Knife, Butter
  [117944] = rumourSource, -- Rough Fork, Common
  [117941] = rumourSource, -- Rough Broom, Practical
  [117938] = rumourSource, -- Rough Sack, Burlap
  [117936] = rumourSource, -- Rough Pouch, Coarse Cloth
  [117935] = rumourSource, -- Rough Pouch, Burlap
  [117934] = rumourSource, -- Rough Carton, Sturdy
  [117933] = rumourSource, -- Rough Bin, Sturdy
  [117932] = rumourSource, -- Rough Tray, Sturdy
  [117927] = rumourSource, -- Rough Barrel, Sturdy
  [117925] = rumourSource, -- Rough Cot, Military
  [117908] = rumourSource, -- Redguard Candlestick, Twisted
  [117904] = rumourSource, -- Redguard Trunk, Garish
  [117903] = rumourSource, -- Redguard Vessel, Gilded
  [117902] = rumourSource, -- Redguard Pot, Gilded
  [117899] = rumourSource, -- Redguard Chest, Crested
  [117898] = rumourSource, -- Redguard Carpet, Dawn
  [117897] = rumourSource, -- Redguard Mat, Sun
  [117896] = rumourSource, -- Redguard Wine Rack, Bolted
  [117894] = rumourSource, -- Redguard Divider, Gilded
  [117893] = rumourSource, -- Redguard Footlocker, Bolted
  [117892] = rumourSource, -- Redguard Chair, Lattice
  [117891] = rumourSource, -- Redguard Armchair, Lattice
  [117887] = rumourSource, -- Redguard Tuffet, Sands
  [117886] = rumourSource, -- Redguard Throw Pillow, Sands
  [117885] = rumourSource, -- Redguard Pillow Roll, Sands
  [117882] = rumourSource, -- Redguard Pillow, Florid Sands
  [117881] = rumourSource, -- Redguard Pillow, Lattice Sands
  [117843] = rumourSource, -- Redguard Bed, Wide Lattice
  [117835] = rumourSource, -- Redguard Lamp, Oil
  [117765] = rumourSource, -- Redguard Canopy, Dusk
  [116490] = rumourSource, -- Orcish Head, Stone
  [116489] = rumourSource, -- Orcish Mask, Shield
  [116488] = rumourSource, -- Orcish Mask, Decorative
  [116487] = rumourSource, -- Orcish Mask, Ceremonial
  [116486] = rumourSource, -- Orcish Urn, Honor's Rest
  [116484] = rumourSource, -- Orcish Funeral Pyre
  [116483] = rumourSource, -- Orcish Totem, Malacath
  [116480] = rumourSource, -- Orcish Pedestal, Stone
  [116479] = rumourSource, -- Orcish Candle, Offering
  [116475] = rumourSource, -- Orcish Skull Goblet, Empty
  [116472] = rumourSource, -- Orcish Throne, Skull
  [116469] = rumourSource, -- Orcish Figure, Stone
  [116445] = rumourSource, -- Orcish Table with Furs
  [116420] = rumourSource, -- Orcish Throne, Pedestal
  [115624] = rumourSource, -- Wood Elf Rug, Boar Hide
  [115623] = rumourSource, -- Wood Elf Pedestal, Stone
  [115622] = rumourSource, -- Wood Elf Handfast Statue
  [115621] = rumourSource, -- Wood Elf Tapestry, Skull Totem
  [115578] = rumourSource, -- Wood Elf Spoon, Decorative
  [115577] = rumourSource, -- Wood Elf Fork, Decorative
  [115542] = rumourSource, -- Argonian Relic, Broken
  [115541] = rumourSource, -- Argonian Effigy, Coiled Snake
  [115540] = rumourSource, -- Argonian Egg, Mnemic Base
  [115538] = rumourSource, -- Argonian Egg, Rough
  [115537] = rumourSource, -- Argonian Nest
  [115412] = rumourSource, -- Nord Bellows, Fireplace
  [115341] = rumourSource, -- Dark Elf Ash Garden
  [115268] = rumourSource, -- Breton Statue, Fighters Guild
  [115261] = rumourSource, -- Breton Forge and Bellows
  [114418] = rumourSource, -- High Elf Statue, Base
  [114414] = rumourSource, -- High Elf Medallion, Winged
  [94181] = rumourSource, -- Imperial Throne of the Bay
  [94160] = rumourSource, -- Imperial Lantern, Imperial City
  [94116] = rumourSource, -- Imperial Cauldron, Pitch-filled
}

-- 15 Greymoor
FurC.Rumours[ver.SKYRIM] = {
  [165995] = rumourSource, -- Antique Map of Cyrodiil
  [163722] = rumourSource, -- Antique Map of Tamriel
  [153814] = rumourSource, -- Dragon's Treasure Trove
  [152259] = rumourSource, -- Banner of Mehrunes Dagon
  [152258] = rumourSource, -- Banner of Boethiah
  [152257] = rumourSource, -- Banner of Mephala
}

-- 14 Harrowstorm
FurC.Rumours[ver.HARROW] = {}

-- 13 Dragonhold
FurC.Rumours[ver.DRAGON2] = {}

-- 12 Scalebreaker
FurC.Rumours[ver.SCALES] = {}

-- 11 Elsweyr
FurC.Rumours[ver.KITTY] = {
  [152149] = rumourSource, -- Orcish Brazier, Pillar,     CRAFTABLE
  [152148] = rumourSource, -- Orcish Tapestry, Hunt,      CRAFTABLE
  [152146] = rumourSource, -- Orcish Chandelier, Spiked,  CRAFTABLE
  [152145] = rumourSource, -- Orcish Tapestry, War,       CRAFTABLE
  [152144] = rumourSource, -- Orcish Mirror, Peaked,      CRAFTABLE
  [152143] = rumourSource, -- Orcish Sconce, Scrolled,    CRAFTABLE
  [152142] = rumourSource, -- Orcish Sconce, Bordered,    CRAFTABLE
  [152141] = rumourSource, -- Orcish Brazier, Bordered,   CRAFTABLE
  [150775] = rumourSource, -- Banner of Jyggalag,
  [150774] = rumourSource, -- Banner of Vaermina,
}

-- 10 Wrathstone
FurC.Rumours[ver.WOTL] = {
  [147644] = rumourSource, -- Palisade, Crude,
  [147636] = rumourSource, -- Banner of Hermaeus Mora,
  [147573] = rumourSource, -- Barricade, Bladed Hurdle,
  [147572] = rumourSource, -- Barricade, Bladed Fence,
  [146069] = rumourSource, -- Target Voriplasm,
  [140297] = rumourSource, -- Replica Throne of Alinor,
  [134287] = rumourSource, -- Projector TBD,
  [134246] = rumourSource, -- The Law of Gears,
  [132204] = rumourSource, -- Imperial Statue, Truth,
  [132203] = rumourSource, -- Stone, Anvil Limestone,
  [132202] = rumourSource, -- Rock, Anvil Limestone,
  [132201] = rumourSource, -- Tree, Kvatch Nut,
  [132200] = rumourSource, -- Imperial Well, Akatosh,
  [132197] = rumourSource, -- Death Skeleton, Shrouded,
  [132166] = rumourSource, -- Death Skeleton, Robed,
  [130195] = rumourSource, -- Target Iron Atronach,
  [130194] = rumourSource, -- Target Stone Atronach,
  [130193] = rumourSource, -- Robust Target Minotaur Handler,
  [130091] = rumourSource, -- Statue of Molag Bal, God of Schemes,
  [130089] = rumourSource, -- Daedric Brazier, Molag Bal,
  [130087] = rumourSource, -- Daedric Shards, Coldharbour,
  [130086] = rumourSource, -- Daedric Pennant, Molag Bal,
  [130085] = rumourSource, -- Daedric Banner, Molag Bal,
  [130084] = rumourSource, -- Daedric Tapestry, Molag Bal,
  [130083] = rumourSource, -- Daedric Block, Seat,
  [130081] = rumourSource, -- Soul-Shriven, Armored,
  [130080] = rumourSource, -- Soul Gems, Scattered,
  [120882] = rumourSource, -- Tombstone, Small,
  [120881] = rumourSource, -- Tombstone, Engraved, Order of the Hour,
  [120880] = rumourSource, -- Tombstone, Engraved, Decorative,
  [120874] = rumourSource, -- Daedric Coffin, Lid,
  [120872] = rumourSource, -- Daedric Pike, Daedroth Head,
  [120861] = rumourSource, -- Yokudan Sitting Griffin Statue,
  [120860] = rumourSource, -- Yokudan Throne,
  [120858] = rumourSource, -- Yokudan Tapestry,
  [120857] = rumourSource, -- Yokudan Sarcophagus Lid,
  [120856] = rumourSource, -- Yokudan Sarcophagus,
  [120852] = rumourSource, -- Holding Cell,
}

-- 9 Wolfhunter
FurC.Rumours[ver.WEREWOLF] = {
  [134823] = dataminedUnclear, -- Target Mournful Aegis
  [134686] = dataminedUnclear, -- Sithis, The Dread Father
  [132198] = dataminedUnclear, -- Death Skeleton, Wrapped
  [126776] = dataminedUnclear, -- Indoril Tapestry, House
  [126771] = dataminedUnclear, -- Velothi Podium of Illumination
  [126109] = dataminedUnclear, -- Display Death Crown Crate
  [126108] = dataminedUnclear, -- Display Atronach Crown Crate
  [126107] = dataminedUnclear, -- Display Wild Hunt Crown Crate
  [125592] = dataminedUnclear, -- Mushroom, Lavaburster
  [125537] = dataminedUnclear, -- Dwarven Piston Cylinder
  [125532] = dataminedUnclear, -- Dwarven Pipeline, Fan
  [125489] = dataminedUnclear, -- Daedric Brazier, Flaming
  [121023] = dataminedUnclear, -- Tree, Strong Olive
  [121022] = dataminedUnclear, -- Bush, Green Forest
  [121016] = dataminedUnclear, -- Bush, Red Berry
  [121015] = dataminedUnclear, -- Shrub, Sparse Green
  [121013] = dataminedUnclear, -- Saplings, Fragile Autumn Birch
  [121010] = dataminedUnclear, -- Tree, Young Green Birch
  [121008] = dataminedUnclear, -- Tree, Autumn Maple
  [121007] = dataminedUnclear, -- Tree, Strong Maple
  [121004] = dataminedUnclear, -- Hedge, Solid Arc
  [121000] = dataminedUnclear, -- Shrub, Trimmed Green
  [120987] = dataminedUnclear, -- Dark Elf Lightpost, Capped
  [120986] = dataminedUnclear, -- Dark Elf Lightpost, Full
  [120985] = dataminedUnclear, -- Dark Elf Lightpost, Single
  [120873] = dataminedUnclear, -- Daedric Coffin
  [120871] = dataminedUnclear, -- Deadric Vase, Spiked
  [120867] = dataminedUnclear, -- Daedric Pike, Clannfear Head
  [120866] = dataminedUnclear, -- Daedric Brazier, Tabletop
  [120865] = dataminedUnclear, -- Daedric Table
  [120863] = dataminedUnclear, -- Daedric Light Pillar
  [120862] = dataminedUnclear, -- Ancient Patriarch Banner
  [120859] = dataminedUnclear, -- Yokudan Wall Embellishment
  [120855] = dataminedUnclear, -- Collected Wanted Poster
  [120854] = dataminedUnclear, -- Guard Lamppost
}

-- 8 Murkmire
FurC.Rumours[ver.SLAVES] = {
  [145576] = rumourSource, -- Timid Vine-Tongue
  [145556] = rumourSource, -- Tree, Tall Snowy Fir
  [145555] = rumourSource, -- Tree, Snowy Fir
  [145554] = rumourSource, -- Tree, Towering Snowy Fir
  [145467] = rumourSource, -- The Way of Shadow
  [145458] = rumourSource, -- Tree, Huge Ancient Banyan
  [145457] = rumourSource, -- Tree, Banyan
  [145456] = rumourSource, -- Plant, Hist Bulb
  [145455] = rumourSource, -- Plant, Dendritic Hist Bulb
  [145454] = rumourSource, -- Plant, Marsh Aloe Pod
  [145453] = rumourSource, -- Plant, Marsh Aloe
  [145452] = rumourSource, -- Shrine, Sithis Looming Anointed
  [145451] = rumourSource, -- Shrine, Sithis Figure Anointed
  [145450] = rumourSource, -- Stele, Hist Cultivation
  [145449] = rumourSource, -- Stele, Hist Guardians
  [145446] = rumourSource, -- Sithis, the Hungering Dark
}

-- 7 Summerset Isles
FurC.Rumours[ver.ALTMER] = {
  [140297] = dataminedUnclear, -- Replica Throne of Alinor,
  [139367] = dataminedUnclear, -- Regal Sauna Pool, Two Person
  [134287] = dataminedUnclear, -- Projector TBD
  [132203] = dataminedUnclear, -- Stone, Anvil Limestone
  [132202] = dataminedUnclear, -- Rock, Anvil Limestone
  [132201] = dataminedUnclear, -- Tree, Kvatch Nut
  [132200] = dataminedUnclear, -- Imperial Well, Akatosh
  [132197] = dataminedUnclear, -- Death Skeleton, Shrouded
  [132166] = dataminedUnclear, -- Death Skeleton, Robed
  [130195] = dataminedUnclear, -- Target Iron Atronach
  [130194] = dataminedUnclear, -- Target Stone Atronach
  [130193] = dataminedUnclear, -- Robust Target Minotaur Handler
  [130070] = dataminedUnclear, -- Daedric Spout, Arched,
  [120882] = dataminedUnclear, -- Tombstone, Small
  [120881] = dataminedUnclear, -- Tombstone, Engraved, Order of the Hour
  [120880] = dataminedUnclear, -- Tombstone, Engraved, Decorative
  [120874] = dataminedUnclear, -- Daedric Coffin, Lid
  [120872] = dataminedUnclear, -- Daedric Pike, Daedroth Head
  [120858] = dataminedUnclear, -- Yokudan Tapestry
  [120857] = dataminedUnclear, -- Yokudan Sarcophagus Lid
  [120856] = dataminedUnclear, -- Yokudan Sarcophagus
}

-- 6 Dragon Bones
FurC.Rumours[ver.DRAGONS] = {}

-- 5 Clockwork City
FurC.Rumours[ver.CLOCKWORK] = {
  [125509] = dataminedUnclear, -- Replica Dwarven Crown Crate
}

-- 4 Horns of the Reach
FurC.Rumours[ver.REACH] = {}

-- 3 Morrowind
FurC.Rumours[ver.MORROWIND] = {
  [132531] = dataminedUnclear, -- Hlaalu Planter, Tall
  [126568] = dataminedUnclear, -- Daedric Urn, Ritual
  [125597] = dataminedUnclear, -- Mushroom, Polyp Stinkhorn
  [125591] = dataminedUnclear, -- Mushroom, Lavaburst Patch
  [125576] = dataminedUnclear, -- Hlaalu Wall Pillar, Sillar Stone
  [125570] = dataminedUnclear, -- Hlaalu Stairs, Sillar Stone
  [125569] = dataminedUnclear, -- Hlaalu Sidewalk, Sillar Stone Corner
  [120411] = dataminedUnclear, -- Noble's Chalice of Wine
}

-- 2 Homestead
FurC.Rumours[ver.HOMESTEAD] = {
  [118304] = rumourSource, -- Shelf, Poison
  [118300] = rumourSource, -- Bottle, Poison
  [118299] = rumourSource, -- Bottle, Beaker
  [118297] = rumourSource, -- Mantikora Horns, Wall Mount
  [118296] = rumourSource, -- Mantikora Head, Wall Mount
  [118295] = rumourSource, -- Haj Mota Head, Wall Mount
  [118293] = rumourSource, -- Echatere, Wall Mount
  [118291] = rumourSource, -- Durzog Head, Wall Mount
  [118290] = rumourSource, -- Antlers, Wall Mount
  [118289] = rumourSource, -- Haj Mota Shell, Wall Mount
  [118284] = rumourSource, -- Horn, Display, Cracked
  [118283] = rumourSource, -- Horn, Display, Huge
  [118127] = rumourSource, -- Plaque, Small
  [116433] = rumourSource, -- Orcish Desk with Furs
}
