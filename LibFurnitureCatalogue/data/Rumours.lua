-- Data: datamined, but no confirmed src
-- If a src exists for same id, leftovers in here should be ignored

FurC.Rumours = FurC.Rumours or {}

local LFC = LibFurnitureCatalogue
local ver = LFC.Internal.Constants.Versioning

local rumourSource = GetString(SI_FURC_SRC_RUMOUR_ITEM)
local dataminedUnclear = GetString(SI_FURC_DATAMINED_UNCLEAR)

-- Return of the Thieves Guild
FurC.Rumours[ver.THIEVES] = {
  [225408] = rumourSource, -- Tapestry, Sanguine
  [217601] = rumourSource, -- Molag Bal Plaque
  [225410] = rumourSource, -- Vines, Rose Ivy Curtain
  [225411] = rumourSource, -- Vines, Rose Ivy Swath
  [225028] = rumourSource, -- Witches Fest, Plunder Skull Basket
  [225413] = rumourSource, -- Flowers, Small Rose Ivy Patch
  [225414] = rumourSource, -- Flowers, Large Rose Ivy Patch
  [225409] = rumourSource, -- Vines, Verdant Rose Ivy Swath
  [226738] = rumourSource, -- Dwarven Diving Chamber, Replica
  [224863] = rumourSource, -- Ichor Splatter
  [224862] = rumourSource, -- Daedric Cage, Bladed
  [224861] = rumourSource, -- Ayleid Cage, Spiked
  [224860] = rumourSource, -- Imperial Brazier, Cold-Flame
  [224859] = rumourSource, -- Necrom Brazier, Cold-Flame
  [226760] = rumourSource, -- Pirate Flag, Sea Elf
  [217650] = rumourSource, -- Argonian Houseboat
  [226941] = rumourSource, -- School of fish Green
  [226784] = rumourSource, -- Driftwood Log
  [226776] = rumourSource, -- Sage Voernet's Tome, Replica
  [226775] = rumourSource, -- Nexus Orrery Shard, Replica
  [226774] = rumourSource, -- Nowhere Vault Door, Replica
  [225337] = rumourSource, -- Freaking Big Boi Butterfly!
  [226773] = rumourSource, -- Scrying Device, Untuned
  [226747] = rumourSource, -- Fossil, Giant Sea Beast Tail
  [226748] = rumourSource, -- Fossil, Giant Sea Beast Head
  [226749] = rumourSource, -- Fossil, Mudcrab
  [226750] = rumourSource, -- Fossil, Mud Hopper
  [225343] = rumourSource, -- Harbingers Door
  [225344] = rumourSource, -- Harbingers Chandelier
  [225345] = rumourSource, -- Harbingers Fireplace
  [225346] = rumourSource, -- Harbingers Candle, Giant
  [225347] = rumourSource, -- Harbingers Candle, Small
  [225348] = rumourSource, -- Harbingers Candle, Large
  [225349] = rumourSource, -- Harbingers Candles, Small Cluster
  [225350] = rumourSource, -- Harbingers Candles, Large Cluster
  [225351] = rumourSource, -- Aspect of the Mad God, Fury
  [225352] = rumourSource, -- Aspect of the Mad God, Dementia
  [225353] = rumourSource, -- Aspect of the Mad God, Mania
  [225354] = rumourSource, -- Butterfly Flock, Ephemeral
  [225355] = rumourSource, -- Target Butterfly, Ephemeral Monarch
  [225356] = rumourSource, -- Target Butterfly, Ephemeral Mara's Blush
  [225357] = rumourSource, -- Mushroom, Large Baldcap
  [225358] = rumourSource, -- Mushroom, Medium Baldcap
  [225359] = rumourSource, -- Mushroom, Giant Clawcap Cluster
  [225360] = rumourSource, -- Mushroom, Small Baldcap
  [226769] = rumourSource, -- Ship Figurehead, Yokudan
  [226772] = rumourSource, -- Nexus Orrery, Replica
  [226771] = rumourSource, -- Driftwood Sculpture, Large
  [225364] = rumourSource, -- Beauty Goddess Blanket
  [225365] = rumourSource, -- Beauty Goddess Shade
  [225366] = rumourSource, -- Beauty Goddess Cake
  [225367] = rumourSource, -- Beauty Goddess Cake Slice
  [225368] = rumourSource, -- Beauty Goddess Lantern
  [225369] = rumourSource, -- Beauty Goddess Seat Cushion
  [225370] = rumourSource, -- Beauty Goddess Picnic Basket
  [225371] = rumourSource, -- Cherry Blossom Petals, Large Blanket
  [225372] = rumourSource, -- Cherry Blossom Petals, Small Blanket
  [225373] = rumourSource, -- Alinor Tree, Cherry Blossom
  [225374] = rumourSource, -- Alinor Tree, Large Cherry Blossom
  [225375] = rumourSource, -- Alinor Tree, Cherry Blossom Canopy
  [224864] = rumourSource, -- Witch's Infernal Hat, Decorative
  [224865] = rumourSource, -- Yokudan Burial Relief, Noble
  [224866] = rumourSource, -- Breton Monument, Tall Mossy
  [224867] = rumourSource, -- Orcish Statue, Blacksmith
  [224868] = rumourSource, -- Dark Elf Statue, Mage
  [226765] = rumourSource, -- Ship in a Bottle, Yokudan
  [226918] = rumourSource, -- Target Kargrym, Trial
  [226761] = rumourSource, -- Golden King of the Abecean Sea
  [226759] = rumourSource, -- Book, Ship's Log
  [226758] = rumourSource, -- Bountiful Treasure Chest
  [226923] = rumourSource, -- Cheese Stack, Large
  [226924] = rumourSource, -- Cheese Stack, Medium
  [226925] = rumourSource, -- Cheese Stack, Small
  [226926] = rumourSource, -- Hanging Cheese, Long
  [226927] = rumourSource, -- Hanging Cheese, Medium
  [226928] = rumourSource, -- Hanging Cheese, Short
  [226929] = rumourSource, -- Hanging Cheese Stack, Long Aged
  [226930] = rumourSource, -- Hanging Cheese Stack, Short Aged
  [226931] = rumourSource, -- Hanging Cheese Stack, Long
  [226932] = rumourSource, -- Hanging Cheese Stack, Short
  [226933] = rumourSource, -- Cheese Pile, Massive
  [226754] = rumourSource, -- Cursed Ship's Bell
  [226753] = rumourSource, -- Aquarium, Conjured Sphere
  [226936] = rumourSource, -- School of fish Blue
  [226752] = rumourSource, -- Fossil, Yaghra
  [226751] = rumourSource, -- Fossil, Slaughterfish
  [225412] = rumourSource, -- Vines, Rose Ivy Drape
  [225404] = rumourSource, -- Carnaval Tent, Enclosed
  [225405] = rumourSource, -- Carnaval Wall, Long Rectangular Cloth
  [225406] = rumourSource, -- Carnaval Wagon, Covered
  [225407] = rumourSource, -- Colovian Throne, Noble
}

-- Season Zero Part 2
FurC.Rumours[ver.ZERO2] = {
  [224876] = rumourSource, -- Music Box, A Wish for Fish
  [225184] = rumourSource, -- Pipe, Stately
  [223844] = rumourSource, -- Hearts Week Decor, Red Bow
}

-- Season Zero
FurC.Rumours[ver.ZERO] = {
  [223894] = rumourSource, -- Flowers, Blue Moth
  [223993] = rumourSource, -- Jornibret's Last Dance
  [223994] = rumourSource, -- Rislav the Righteous, Part 1
  [223995] = rumourSource, -- Heavy Armor Forging
  [217703] = rumourSource, -- Music Box, Delight of the Does
  [223848] = rumourSource, -- Hearts Week Garland, Curved Floral
  [223849] = rumourSource, -- Hearts Week Decor, Floral Dangle
  [223850] = rumourSource, -- Hearts Week Decor, Long Floral Dangle
  [223851] = rumourSource, -- Hearts Week Wreath, Floral
  [223892] = rumourSource, -- Kelp Tree, Giant
  [223841] = rumourSource, -- Hearts Week Banner, Standing
  [223842] = rumourSource, -- Hearts Week Banner, Hanging
  [223843] = rumourSource, -- Hearts Week Banner, Small Standing
  [223844] = rumourSource, -- Hearts Week Decor, Red Bow
  [223845] = rumourSource, -- Hearts Week Garland, Curved Ribbon
  [223846] = rumourSource, -- Hearts Week Garland, Curved Long Ribbon
  [223847] = rumourSource, -- Hearts Week Garland, Curved Floral Dangles
  [223893] = rumourSource, -- Plants, Sunset Pitcher Patch
  [223139] = rumourSource, -- Worm Cult Shrine
  [223141] = rumourSource, -- Coldharbour Sconce
  [219862] = rumourSource, -- Music Box, Grave-Stake Gambol
  [223175] = rumourSource, -- Nord Shed Painting, Unfinished
}

-- 33 Fallen Banners (U45)
FurC.Rumours[ver.FALLBAN] = {
  [212553] = rumourSource, -- Zeal Decorations, Hanging Lamp
  [212552] = rumourSource, -- Zeal Decorations, Coins
  [212551] = rumourSource, -- Zeal Decorations, Banners Long
  [212550] = rumourSource, -- Zeal Decorations, Banners Short
  [212549] = rumourSource, -- Zeal Decorations, Pennants Long
  [212548] = rumourSource, -- Zeal Decorations, Pennants Short
  [208160] = rumourSource, -- Music Box, Sorrow of the Night Mother
  [204778] = rumourSource, -- Wine Press Scaffolding, Tall
  [204777] = rumourSource, -- Wine Press Scaffolding, Short
  [204776] = rumourSource, -- Colovian Grape Press, Compact
  [204775] = rumourSource, -- Colovian Grape Tub, Tall
}

-- 29 Scions of Ithelia
FurC.Rumours[ver.SCIONS] = {
  [203898] = rumourSource, -- Redguard Tent, Rectangular Blue
}

-- 28 Secrets of the Telvanni Peninsula
FurC.Rumours[ver.ENDLESS] = {
  [199125] = rumourSource, -- Inky Waterup Table
  [199124] = rumourSource, -- Green ink ceiling light
  [199123] = rumourSource, -- Cabinet of Curiosities
  [199121] = rumourSource, -- Inky Incense Burner
  [199120] = rumourSource, -- Framed Vision
}

-- 26 Necrom
FurC.Rumours[ver.NECROM] = {
  [120485] = rumourSource, -- Cactus, Columnar
  [118288] = rumourSource, -- Deer Carcass, Hanging
  [116474] = rumourSource, -- Orcish Effigy, Bear
  [116473] = rumourSource, -- Orcish Effigy, Mammoth
  [115708] = rumourSource, -- Khajiit Tile, Waning Moons
  [115707] = rumourSource, -- Khajiit Tile, Waxing Moons
  [115706] = rumourSource, -- Khajiit Tile, Full Moons
  [115705] = rumourSource, -- Khajiit Tile, New Moons
}

-- 20 Deadlands
FurC.Rumours[ver.DEADL] = {
  [175578] = rumourSource, -- Banner, Meridia
  [126590] = rumourSource, -- Vvardenfell Mushrooms, Lavaburst
  [126589] = rumourSource, -- Vvardenfell Mushrooms, Bloodtooth
  [126588] = rumourSource, -- Vvardenfell Pitcher Plants, Hanging Bunch
  [126136] = rumourSource, -- Dwarven Lantern, Powered
  [120984] = rumourSource, -- Plant, Goldenrod Cluster
  [120851] = rumourSource, -- Gallows
}

-- 17 Markarth
FurC.Rumours[ver.MARKAT] = {
  [160541] = rumourSource, -- Outfit Station, Clockwork
  [153841] = rumourSource, -- Rewoven Khajiiti Tapestry
}

-- 16 Stonethorn
FurC.Rumours[ver.STONET] = {
  [119690] = rumourSource, -- Banner of Hircine
  [119689] = rumourSource, -- Arch of the Wild Hunt
  [119688] = rumourSource, -- Basin of the Wild Hunt
  [119687] = rumourSource, -- Statue of the Wild Hunt
  [119686] = rumourSource, -- Totem of the Wild Hunt
  [119663] = rumourSource, -- Decommissioned Covenant Flaming Oil
  [119640] = rumourSource, -- Decommissioned Pact Flaming Oil
  [119589] = rumourSource, -- Mushrooms, Auridon Group
  [119588] = rumourSource, -- Auridon Mushrooms, Cluster
  [119586] = rumourSource, -- Auridon Fern, Squat
  [119585] = rumourSource, -- Auridon Fern, Tall
  [119584] = rumourSource, -- Auridon Fern, Orange
  [119583] = rumourSource, -- Rough Limestone Tile
  [119582] = rumourSource, -- Rough Timber
  [119579] = rumourSource, -- Murky Palm Tree
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
  [118240] = rumourSource, -- Cake, Anniversary
  [118239] = rumourSource, -- Vial of Blood
  [118151] = rumourSource, -- Carpet Roll, Sunset
  [118150] = rumourSource, -- Carpet Roll, Colorful
  [118124] = rumourSource, -- Pelt, Wolf
  [118123] = rumourSource, -- Pelt, Ice Wolf
  [118106] = rumourSource, -- Painting Palette
  [118105] = rumourSource, -- Painting Brush, Angled
  [118104] = rumourSource, -- Painting Brush, Detail
  [118103] = rumourSource, -- Painting Brush, Wide
  [118100] = rumourSource, -- Horn, Carved
  [117898] = rumourSource, -- Redguard Carpet, Dawn
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
  [94160] = rumourSource, -- Imperial Lantern, Imperial City
  [94116] = rumourSource, -- Imperial Cauldron, Pitch-filled
}

-- 15 Greymoor
FurC.Rumours[ver.SKYRIM] = {
  [165995] = rumourSource, -- Antique Map of Cyrodiil
  [163722] = rumourSource, -- Antique Map of Tamriel
  [152258] = rumourSource, -- Banner of Boethiah
}

-- 10 Wrathstone
FurC.Rumours[ver.WOTL] = {
  [132197] = rumourSource, -- Death Skeleton, Shrouded
  [132166] = rumourSource, -- Death Skeleton, Robed
  [130195] = rumourSource, -- Target Iron Atronach
  [130194] = rumourSource, -- Target Stone Atronach
  [130193] = rumourSource, -- Robust Target Minotaur Handler
  [120882] = rumourSource, -- Tombstone, Small
  [120881] = rumourSource, -- Tombstone, Engraved, Order of the Hour
  [120880] = rumourSource, -- Tombstone, Engraved, Decorative
  [120874] = rumourSource, -- Daedric Coffin, Lid
  [120872] = rumourSource, -- Daedric Pike, Daedroth Head
  [120861] = rumourSource, -- Yokudan Sitting Griffin Statue
  [120860] = rumourSource, -- Yokudan Throne
  [120858] = rumourSource, -- Yokudan Tapestry
  [120857] = rumourSource, -- Yokudan Sarcophagus Lid
  [120856] = rumourSource, -- Yokudan Sarcophagus
  [120852] = rumourSource, -- Holding Cell
}

-- 9 Wolfhunter
FurC.Rumours[ver.WEREWOLF] = {
  [132198] = dataminedUnclear, -- Death Skeleton, Wrapped
  [126776] = dataminedUnclear, -- Indoril Tapestry, House
  [126771] = dataminedUnclear, -- Velothi Podium of Illumination
  [126109] = dataminedUnclear, -- Display Death Crown Crate
  [126108] = dataminedUnclear, -- Display Atronach Crown Crate
  [126107] = dataminedUnclear, -- Display Wild Hunt Crown Crate
  [125592] = dataminedUnclear, -- Mushroom, Lavaburster
  [121000] = dataminedUnclear, -- Shrub, Trimmed Green
  [120987] = dataminedUnclear, -- Dark Elf Lightpost, Capped
  --[120986] = dataminedUnclear, -- Dark Elf Lightpost, Full ; removed @BASE44?
  [120985] = dataminedUnclear, -- Dark Elf Lightpost, Single
  [120873] = dataminedUnclear, -- Daedric Coffin
  [120871] = dataminedUnclear, -- Daedric Vase, Spiked
  [120867] = dataminedUnclear, -- Daedric Pike, Clannfear Head
  [120866] = dataminedUnclear, -- Daedric Brazier, Tabletop
  [120865] = dataminedUnclear, -- Daedric Table
  [120863] = dataminedUnclear, -- Daedric Light Pillar
  [120862] = dataminedUnclear, -- Ancient Patriarch Banner
  [120859] = dataminedUnclear, -- Yokudan Wall Embellishment
  [120855] = dataminedUnclear, -- Collected Wanted Poster
  [120854] = dataminedUnclear, -- Guard Lamppost
}

-- 7 Summerset Isles
FurC.Rumours[ver.ALTMER] = {
  -- [134287] = rumourSource, -- Projector TBD ; removed @BASE44?
  [132197] = dataminedUnclear, -- Death Skeleton, Shrouded
  [132166] = dataminedUnclear, -- Death Skeleton, Robed
  [130195] = dataminedUnclear, -- Target Iron Atronach
  [130194] = dataminedUnclear, -- Target Stone Atronach
  [130193] = dataminedUnclear, -- Robust Target Minotaur Handler
  [120882] = dataminedUnclear, -- Tombstone, Small
  [120881] = dataminedUnclear, -- Tombstone, Engraved, Order of the Hour
  [120880] = dataminedUnclear, -- Tombstone, Engraved, Decorative
  [120874] = dataminedUnclear, -- Daedric Coffin, Lid
  [120872] = dataminedUnclear, -- Daedric Pike, Daedroth Head
  [120858] = dataminedUnclear, -- Yokudan Tapestry
  [120857] = dataminedUnclear, -- Yokudan Sarcophagus Lid
  [120856] = dataminedUnclear, -- Yokudan Sarcophagus
}

-- 5 Clockwork City
FurC.Rumours[ver.CLOCKWORK] = {
  [125509] = dataminedUnclear, -- Replica Dwarven Crown Crate
}

-- 3 Morrowind
FurC.Rumours[ver.MORROWIND] = {
  [132531] = dataminedUnclear, -- Hlaalu Planter, Tall
  [126568] = dataminedUnclear, -- Daedric Urn, Ritual
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
  [116433] = rumourSource, -- Orcish Desk with Furs
  [120853] = rumourSource, -- Stockade
}
