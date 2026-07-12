FurC.CrownStore = FurC.CrownStore or {}

local loc = FurC.Constants.Locations
local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources
local crates = FurC.Constants.CrownCrates
local packs = FurC.Constants.ItemPacks
local bundles = FurC.Constants.ItemBundles

local strCrate = FurC.Utils.FmtCrownCrate
local strGeneric = FurC.Utils.FmtGeneric
local strPrice = FurC.Utils.FormatPrice
local getItemLink = FurC.Utils.GetItemLink

local srcCraft = GetString(SI_FURC_SRC_CRAFTING)
local srcHarvest = GetString(SI_FURC_SRC_HARVEST)

local events = FurC.Constants.Events
local strEvent = FurC.Utils.FormatEvent
local ev_elsweyr = strEvent(events.ELSWEYR)
local srcLvlup = GetString(SI_FURC_SRC_LVLUP)

local join = zo_strjoin
local function strMultiple(...)
  return join(" + ", ...)
end

-- Crowns
local function strCrown(price)
  return strPrice(price, CURT_CROWNS)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2) -- use collectible number from https://wiki.esoui.com/Collectibles instead of houseIDs.
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then
    houseName = houseName .. ", " .. GetCollectibleName(houseId2)
  end
  return zo_strformat(housesource, houseName)
end
local mischouse = GetString(SI_FURC_SRC_MISCHOUSE)

local packSources = {}
--- Get item pack link from ID
---@param packItemId integer see FurC.Constants.ItemPacks
---@return string
local function strPack(packItemId)
  local source = packSources[packItemId]
  if not source then
    source = zo_strformat(GetString(SI_FURC_SRC_ITEMPACK), getItemLink(packItemId))
    packSources[packItemId] = source
  end
  return source
end

--- Older Crown Store bundles never shipped as an item, so they keep a translated name.
---@param bundleStringId integer see FurC.Constants.ItemBundles
---@return string
local function strBundle(bundleStringId)
  return zo_strformat(GetString(SI_FURC_SRC_ITEMBUNDLE), GetString(bundleStringId))
end

local srcEditor = GetString(SI_FURC_SRC_EDITOR)
local function strEditor()
  return srcEditor
end

--[[ If the item has multiple sources (particularly if it is sold in
the housing editor as well as a house and/or furnishing pack or crown
crate), put it in the EDITOR table of the version of its first appearance
because this means it's available all the time. List all sources. If even one
of those sources isn't crowns, IT DOESN'T BELONG IN THIS FILE.]]
--

FurC.CrownStore[ver.ZERO2] = {
  [src.CROWN] = {
    [224739] = strCrate(crates.ANU_PAD), -- Aetherean Rupture, Liminal
    [224843] = strCrate(crates.ANU_PAD), -- Starsong Staircase, Spiral
    [224846] = strCrate(crates.ANU_PAD), -- Marble Platform, Anu Pattern Square
    [224845] = strCrate(crates.ANU_PAD), -- Sigil Trim, Padomay Pattern
    [224844] = strCrate(crates.ANU_PAD), -- Sigil Trim, Anu Pattern
    [224847] = strCrate(crates.ANU_PAD), -- Marble Platform, Padomay Pattern Square
    [224848] = strCrate(crates.ANU_PAD), -- Marble Pillar, Anu Pattern
    [224849] = strCrate(crates.ANU_PAD), -- Marble Pillar, Padomay Pattern
    [224853] = strPack(packs.DARIEN), -- A Hero Strides Forth Painting, Gold
    [224852] = strPack(packs.DARIEN), -- An Evening with Darien Painting, Gold
    [224851] = strPack(packs.DARIEN), -- Statue, Meridia's Champion
    [225088] = strPack(packs.DARIEN), -- Cheers to the Hero Painting, Gold
  },

  [src.EDITOR] = {
    [225183] = strCrown(1000), -- Completed Bounty Sheet, Framed Breton Man
  },
}

FurC.CrownStore[ver.ZERO] = {
  [src.CROWN] = {
    [223743] = strCrown(4000), -- Almalexia, Mother Morrowind
    [223735] = strCrown(1200), -- Music Box, Duel of the Seablades
    [223744] = strPack(packs.TOYMAKER), -- Toymaker's Diorama, Racing
    [223745] = strPack(packs.TOYMAKER), -- Toymaker's Mobile, Animals
    [223746] = strPack(packs.TOYMAKER), -- Mudcrab Moppet, Tan
    [223747] = strPack(packs.TOYMAKER), -- Jerboa Moppet, Tan
    [223748] = strPack(packs.TOYMAKER), -- Lion Cub Moppet, Tan
    [223749] = strPack(packs.TOYMAKER), -- Guar Moppet, Tan
    [223750] = strPack(packs.TOYMAKER), -- Vvardvark Moppet, Tan
    [223751] = strPack(packs.TOYMAKER), -- Bantam Guar Moppet, Tan
    [223738] = strCrate(crates.WAVE), -- Warrior Wave Platform, Yathian Turquoise
    [223739] = strCrate(crates.WAVE), -- Warrior Wave Illustrated Tome
    [223736] = strCrate(crates.WAVE), -- Warrior Wave Door, Glinting Talon
    [223737] = strCrate(crates.WAVE), -- Warrior Wave Bed, Winged
    [223740] = strCrate(crates.WAVE), -- Warrior Wave Lamp, Small
    [223741] = strCrate(crates.WAVE), -- Warrior Wave Lamp, Medium
    [223742] = strCrate(crates.WAVE), -- Warrior Wave Lamp, Large
  },

  [src.EDITOR] = {},
}

FurC.CrownStore[ver.WORMS2] = {
  [src.CROWN] = {
    [223146] = strPack(packs.WRITHING), -- Writhing Wall, Soulstream
    [223145] = strPack(packs.WRITHING), -- Writhing Wall, Segment
    [223144] = strPack(packs.WRITHING), -- Black Soul Gems, Giant Cluster
    [223142] = strPack(packs.WRITHING), -- Black Soul Gems, Spiky Cluster
    [223143] = strPack(packs.WRITHING), -- Black Soul Gems, Patch
    [223135] = strPack(packs.WRITHING), -- Worm King's Throne, Base Replica
    [223136] = strPack(packs.WRITHING), -- Writhing Fortress Pylon, Massive
    [223184] = strPack(packs.WRITHING), -- Writhing Fortress Pylon, Massive Crystal
    [219876] = strPack(packs.WRITHING), -- Target Maldrith
    [223182] = strPack(packs.WRITHING), -- Black Soul Gems, Massive Spire
    [223183] = strPack(packs.WRITHING), -- Replica Soul Flayer
    [223137] = strPack(packs.WRITHING), -- Worm Cult Banner, Post
    [223138] = strPack(packs.WRITHING), -- Worm Cult Banner, Hanging
    [223140] = strPack(packs.WRITHING), -- Worm Cult Relic, Panel
    [223134] = strMultiple(strPack(packs.WRITHING), getHouseString(13881)), -- Statue, Arch-Deacon of Worms
    [223126] = strPack(packs.WINTER), -- Stormhaven Potted Plant, Poinsettia
    [223127] = strPack(packs.WINTER), -- New Life Festive Fir, Giant
    [223128] = strPack(packs.WINTER), -- New Life Dessert Banquet
    [223129] = strPack(packs.WINTER), -- New Life Feast Banquet
    [223130] = strPack(packs.WINTER), -- New Life Garland, Long
    [223132] = strPack(packs.WINTER), -- Indrik Statue, Brass
    [223133] = strPack(packs.WINTER), -- New Life Candle, Floating
    [219867] = strCrate(crates.ORSINIUM), -- Paper Lantern, Blue
    [219868] = strCrate(crates.ORSINIUM), -- Paper Lantern, Gold
    [219869] = strCrate(crates.ORSINIUM), -- Paper Lantern, Green
    [223123] = strCrate(crates.ORSINIUM), -- Paper Lantern, Purple
    [223124] = strCrate(crates.ORSINIUM), -- Paper Lantern, Red
    [219863] = strCrate(crates.ORSINIUM), -- Forgemaster's Throne
    [219864] = strCrate(crates.ORSINIUM), -- Bazaar Chandelier, Paper Lantern
    [219866] = strCrate(crates.ORSINIUM), -- Honorfeather Dove Flock
    [219865] = strCrate(crates.ORSINIUM), -- Sphere of Kynareth's Lightning
    [223732] = getHouseString(13881), -- Target Worm Colossus
    [223942] = getHouseString(13882), -- Druidspring Gazebo, Round
  },

  [src.EDITOR] = {
    [223178] = strMultiple(strCrown(2800), getHouseString(13881)), -- Worm Cult Winch, Chain
    [223179] = strMultiple(strCrown(260), getHouseString(13881)), -- Worm Cult Rack, Ballista
    [223180] = strMultiple(strCrown(380), getHouseString(13881)), -- Worm Cult Ballista, Decommissioned
    [223181] = strMultiple(strCrown(240), getHouseString(13881)), -- Worm Cult Armchair, Padded
  },
}

FurC.CrownStore[ver.SHADOWS] = {
  [src.CROWN] = {
    [217691] = strPack(packs.MOONPATH), -- Moonlight Path Bridge, Long
    [217689] = strPack(packs.MOONPATH), -- Moonlight Path Platform, Whorls
    [217690] = strPack(packs.MOONPATH), -- Moonlight Path Bridge, Curved
    [217692] = strPack(packs.MOONPATH), -- Moonlight Path Sparkles, Trail
    [217693] = strPack(packs.MOONPATH), -- Moonlight Path Sparkles, Stationary
    [217694] = strPack(packs.SANGUINE), -- Carnaval Fountain, Wine
    [217695] = strPack(packs.SANGUINE), -- Carnaval Tent, Open
    [217696] = strPack(packs.SANGUINE), -- Carnaval Wall, Square Cloth
    [217697] = strPack(packs.SANGUINE), -- Carnaval Wall, Rectangular Cloth
    [217698] = strPack(packs.SANGUINE), -- Carnaval Wall, Triangular Cloth
    [217699] = strPack(packs.SANGUINE), -- Carnaval Pennants, String
    [217700] = strPack(packs.SANGUINE), -- Carnaval Stall, Merchant
    [217701] = strPack(packs.SANGUINE), -- Carnaval Confetti, Cascade
    [217702] = strPack(packs.SANGUINE), -- Carnaval Confetti, Burst
    [217687] = strCrate(crates.KINDRED), -- Ceremonial Peryite Skeever Altar
    [217686] = strCrate(crates.KINDRED), -- Ceremonial Peryite Skeever Stake
    [217684] = strCrate(crates.KINDRED), -- Vaermina Dreamtrapper Pillar
    [217683] = strCrate(crates.KINDRED), -- Vaermina Nightmare Sconce
    [217685] = strCrate(crates.KINDRED), -- Mara's Blessed Garland
  },

  [src.EDITOR] = {},
}

FurC.CrownStore[ver.WORMS] = {
  [src.CROWN] = {

    [214332] = strCrate(crates.AKA_ALDU), -- Dragonclash Firepit
    [214333] = strCrate(crates.AKA_ALDU), -- Stone-Nest Spellmote
    [214331] = strCrate(crates.AKA_ALDU), -- World-Eater Effigy
    [214334] = strCrate(crates.AKA_ALDU), -- Illusory Dragon God Ornamentation
    [214335] = strPack(packs.THEATER), -- Clockwork Spotlight Cycler
    [214336] = strPack(packs.THEATER), -- Scrolling Theater Backdrop
    [214337] = strPack(packs.NEREID), -- Statue, Nereid
    [214338] = strPack(packs.NEREID), -- Waterfall, Everlasting
    [214339] = strPack(packs.NEREID), -- Scenic Waterfall, Linear
    [214340] = strPack(packs.NEREID), -- Scenic Waterfall, Branched
    [214341] = strPack(packs.NEREID), -- Everlasting Splashes
    [214342] = strPack(packs.NEREID), -- Geyser, Cone
    [214344] = strPack(packs.NEREID), -- Basin, Grand
  },

  [src.EDITOR] = {
    [214454] = strMultiple(strCrown(20), getHouseString(13558)), -- Solstice Shell, Fossilized Echinoid
    [214520] = strMultiple(strCrown(45), getHouseString(13560)), -- Elkhorn Coral, Sturdy Branching
    [214518] = strMultiple(strCrown(20), getHouseString(13560)), -- Coral Formation, Tiered Shelves
    [214521] = strMultiple(strCrown(20), getHouseString(13560)), -- Elkhorn Coral, Cluster
    [214519] = strMultiple(strCrown(90), getHouseString(13560)), -- Elkhorn Coral, Verdant Branching
    [214516] = strMultiple(strCrown(350), getHouseString(13560)), -- Antler Coral, Glowing Branched Crimson
    [214515] = strMultiple(strCrown(350), getHouseString(13560)), -- Antler Coral, Glowing Broad Crimson
    [118152] = strMultiple(strCrown(180), getHouseString(13560)), -- Carpet Roll, Sunrise
    [118153] = strMultiple(strCrown(180), getHouseString(13560)), -- Carpet Roll, Floral
    [118154] = strMultiple(strCrown(180), getHouseString(13560)), -- Carpet Roll, Oasis
    [118155] = strMultiple(strCrown(180), getHouseString(13560)), -- Carpet Roll, Desert
    [214514] = strCrown(350), -- Antler Coral, Glowing Short Crimson
  },
}

FurC.CrownStore[ver.FALLBAN] = {
  [src.CROWN] = {
    [212419] = strCrate(crates.CARNAVAL), -- Carnaval Window, Stained Glass
    [212418] = strCrate(crates.CARNAVAL), -- Sanguine's Wall
    [212417] = strCrate(crates.CARNAVAL), -- Carnaval Stage
    [212416] = strCrate(crates.CARNAVAL), -- Lightning Wall
    [214250] = strPack(packs.COMBAT), -- Dueling Mat
    [214254] = strPack(packs.COMBAT), -- Battleground Powerup, Speed
    [214253] = strPack(packs.COMBAT), -- Battleground Powerup, Ultimate
    [214252] = strPack(packs.COMBAT), -- Battleground Powerup, Defense
    [214251] = strPack(packs.COMBAT), -- Battleground Powerup, Damage
    [212423] = strPack(packs.LOOM), -- Replica Mirrormoor Loom, Altar
    [212422] = strPack(packs.LOOM), -- Replica Mirrormoor Loom, Backing
    [212421] = strPack(packs.LOOM), -- Replica Mirrormoor Loom, Spindle
    [212213] = getHouseString(13078, 13759), -- Colovian Gazebo
    [212214] = getHouseString(13078), -- Skingrad Banner
    [212420] = strCrown(1200), -- Music Box, Jester's Caprice
  },

  [src.EDITOR] = {},
}

FurC.CrownStore[ver.BASE44] = {
  [src.CROWN] = {
    [211302] = strCrate(crates.MIRROR), -- Mirrormoor Wall Sconce
    [211301] = strCrate(crates.MIRROR), -- Replica Fate-Thread Fracture
    [211300] = strCrate(crates.MIRROR), -- Target Tho'at Replicanum, Robust
    [211299] = strCrate(crates.MIRROR), -- Fargrave Miasma Censer
    [125561] = getHouseString(12732), -- Mushrooms, Mucksponge Podlet
    [115271] = getHouseString(12732), -- Breton Statue, Druid
    [115270] = getHouseString(12732), -- Breton Statue, Guard
    [210890] = getHouseString(12732), -- 10-Year Anniversary Banner, Large
    [210891] = getHouseString(12732), -- 10-Year Anniversary Banner, Medium
    [210892] = getHouseString(12732), -- 10-Year Anniversary Banner, Small
    [210893] = getHouseString(12732), -- 10-Year Anniversary Rug, Round
    [210894] = getHouseString(12732), -- 10-Year Anniversary Rug, Rectangular
    [210895] = getHouseString(12732), -- 10-Year Anniversary Rug, Runner
    [210896] = getHouseString(12732), -- 10-Year Anniversary Drape, Wall
    [211499] = strPack(packs.DWARVEN), -- Target Dwarf-light the Destroyer, Robust
    [199113] = strCrown(1100), -- Music Box, New Life Snow Symphony
    [211498] = strCrown(1200), -- Music Box, Merry Mudcrab Melody
  },

  [src.EDITOR] = {
    [211502] = strMultiple(strCrown(410), strPack(packs.DWARVEN)), -- Dwarven Furnace
    [211501] = strMultiple(strCrown(270), strPack(packs.DWARVEN)), -- Dwarven Dais, Stone
    [211500] = strMultiple(strCrown(1200), strPack(packs.DWARVEN)), -- Dwarven Archway
    [203880] = strMultiple(strCrown(200), strPack(packs.DWARVEN)), -- Dwarven Red Lamp, Cylinder Cage
  },
}

FurC.CrownStore[ver.BASE43] = {
  [src.CROWN] = {
    [208125] = strCrate(crates.DB), -- Hollowsoul Arrangement
    [208124] = strCrate(crates.DB), -- Ardor's Cascade
    [208123] = strCrate(crates.DB), -- Bloodfont of Sithis
    [208122] = strCrate(crates.DB), -- Vision of the Bloodmoon
    [208358] = getHouseString(12655), -- Handbook for New Homeowners
    [204792] = getHouseString(12656), -- Table, Visions of the Five Companions
    [115052] = getHouseString(12656), -- Imperial Simple Lamppost
    [208159] = getHouseString(12656), -- Imperial Banner, Emperor's
    [208126] = strCrown(3500), -- Statue, Mistress of Nightmares
    [203608] = strPack(packs.HAUNTED), -- Spooky Fog, Glowing
    [203607] = strPack(packs.HAUNTED), -- Haunted Chair
    [203606] = strPack(packs.HAUNTED), -- Haunted Skull
    [203605] = strPack(packs.HAUNTED), -- Haunted Broom
    [208127] = strPack(packs.HAUNTED), -- Haunted Table
    [203604] = strPack(packs.HAUNTED), -- Haunted Bookcase, Whispering
    [203603] = strPack(packs.HAUNTED), -- Haunted Still Life Painting
    [203602] = strPack(packs.HAUNTED), -- Haunted Door, Clattering
    [203601] = strPack(packs.HAUNTED), -- Haunted Dresser, Floating
  },

  [src.EDITOR] = {
    [207974] = strMultiple(strCrown(90), getHouseString(12656)), -- Tree, Large Green Beech
    [207978] = strMultiple(strCrown(90), getHouseString(12656)), -- Tree, Large Yellow Beech
    [207979] = strMultiple(strCrown(90), getHouseString(12656)), -- Tree, Small Yellow Beech Cluster
    [207975] = strMultiple(strCrown(60), getHouseString(12656)), -- Tree, Small Green Beech
    [207977] = strMultiple(strCrown(60), getHouseString(12656)), -- Tree, Small Red Beech
    [207976] = strMultiple(strCrown(430), getHouseString(12656)), -- Tree, Large Red Beech
  },
}

FurC.CrownStore[ver.WEALD] = {
  [src.CROWN] = {
    [204422] = strCrown(1100), -- Music Box, Ascension to the Ruby Throne
    [204407] = strCrown(3000), -- Daedric Statue, Sanguine
    [204408] = strCrown(6000), -- Target Serpent's Image, Trial
    [204409] = strCrate(crates.DIAMOND), -- Dark Anchor Gateway
    [204411] = strCrate(crates.DIAMOND), -- Coldharbour Sentinel
    [204412] = strCrate(crates.DIAMOND), -- Revelry Sparkles
    [204410] = strCrate(crates.DIAMOND), -- Five Companions Tome
  },

  [src.EDITOR] = {
    [205388] = strMultiple(strCrown(2400), getHouseString(12472)), -- Colovian Windmill, Decorative
  },
}

FurC.CrownStore[ver.SCIONS] = {
  [src.CROWN] = {
    [203267] = strCrate(crates.LAMP), -- Order of the Lamp Pedestal
    [203266] = strCrate(crates.LAMP), -- Twinkling Lights, Blue
    [203265] = strCrate(crates.LAMP), -- Prismatic Cherry Tree
    [203264] = strCrate(crates.LAMP), -- Cursed Curio Aether
    [117914] = getHouseString(14078, 11456), -- Redguard Canopy, Florid
    [117912] = getHouseString(14078, 11456), -- Redguard Awning, Florid
    [204455] = getHouseString(11456), -- Redguard Tent, Squared Blue
    [203899] = getHouseString(11456), -- Redguard Tent, Rectangular Silk
    [203897] = getHouseString(11456), -- Redguard Tent, Blue Lean-To
    [203896] = getHouseString(11456), -- Bush, Cave Lichen Patch
    [203895] = getHouseString(11456), -- Bush, Cave Lichen Cluster
    [203894] = getHouseString(11456), -- Bush, Cave Lichen
    [203599] = getHouseString(11456), -- Redguard Fountain, Lion
    [203598] = getHouseString(11456), -- Flowers, Desert Blush
    [203597] = getHouseString(11456), -- Shrubs, Speckled Forest Cluster
    [203596] = getHouseString(11456), -- Ferns, Desert Cluster
    [117873] = getHouseString(11456), -- Redguard Rugs, Rolled
    [117867] = getHouseString(11456), -- Statue, Redguard's Respect
    [117862] = getHouseString(11456), -- Redguard Cart, Merchant
    [190942] = strCrown(1000), -- Music Box, Mad God's Garden
    [203270] = strPack(packs.JESTER), -- Target King Boar, Robust
    [203269] = strPack(packs.JESTER), -- Chamber Pot Throne
    [203268] = strPack(packs.JESTER), -- Jester's Festival Stage
    [203165] = strPack(packs.JESTER), -- Dazzler Dispenser
    [203271] = strPack(packs.JESTER), -- Banner, Jester's Festival
  },

  [src.EDITOR] = {
    [204434] = strMultiple(strCrown(320), getHouseString(14078, 12270)), -- Breton Rowboat
    [204433] = strMultiple(strCrown(45), getHouseString(12270)), -- Lily Pads, Flowering Patch
    [204432] = strMultiple(strCrown(20), getHouseString(12270)), -- Lily Pads, Flowering Cluster
    [204431] = strMultiple(strCrown(60), getHouseString(12270)), -- Tree, Young Gentle Weeping Willow
    [204430] = strMultiple(strCrown(100), getHouseString(12270)), -- Tree, Tall Gentle Weeping Willow
    [204429] = strMultiple(strCrown(230), getHouseString(12270)), -- Tree, Giant Gentle Weeping Willow
    [204428] = strMultiple(strCrown(40), getHouseString(12270)), -- Stumps, Swampshadow Cluster
    [204427] = strMultiple(strCrown(40), getHouseString(12270)), -- Tree, Young Swampshadow
    [204426] = strMultiple(strCrown(100), getHouseString(12270)), -- Tree, Swampshadow
    [204425] = strMultiple(strCrown(230), getHouseString(12270)), -- Tree, Giant Swampshadow
    [203274] = strMultiple(strCrown(10), strPack(packs.JESTER)), -- Box of Tomatoes
    [203275] = strMultiple(strCrown(25), strPack(packs.JESTER)), -- Fish, Silver Trout
    [203272] = strMultiple(strCrown(60), strPack(packs.JESTER)), -- Rough Bench
    [203273] = strMultiple(strCrown(40), strPack(packs.JESTER)), -- Rough Chair
    [203276] = strMultiple(strCrown(50), strPack(packs.JESTER)), -- Rough Dresser
  },
}

FurC.CrownStore[ver.ENDLESS] = {
  [src.CROWN] = {
    [199112] = strCrate(crates.ALLMAKER), -- Chandelier, Kyne's Radiance
    [199111] = strCrate(crates.ALLMAKER), -- Fountain, Kyne's Radiance
    [199110] = strCrate(crates.ALLMAKER), -- Snowfall, Gentle
    [199109] = strCrate(crates.ALLMAKER), -- Boulder, Clear Ice
    [197823] = strCrate(crates.ARMIGER), -- Necrom Podium, Buoyant Armiger
    [197824] = strCrate(crates.ARMIGER), -- Harrowstorm Mists
    [197822] = strCrate(crates.ARMIGER), -- Redoran Sconce, Beetle
    [197821] = strCrate(crates.ARMIGER), -- Spellscar Bridge
    [197826] = strCrown(1200), -- Music Box, Witchmother's Bubbling Brew
    [203166] = strCrown(2800), -- Sai Sahan Statue
    [197825] = strCrown(3000), -- Statue, The Thirty-Fourth Sermon
    [197833] = strPack(packs.NECROM), -- Statue, Telvanni Spellwright
    [197834] = strPack(packs.NECROM), -- Statue, Telvanni Magister
    [197832] = strPack(packs.NECROM), -- Necrom Gazebo
    [199135] = strPack(packs.CURIO), -- Apocrypha Pool, Inky
    [199134] = strPack(packs.CURIO), -- Apocrypha Waterfall, Inky
    [199133] = strPack(packs.CURIO), -- Target Daedra, Seeker
    [198672] = strPack(packs.DRUIDIC), -- Vines, Verdant Ivy Runner
    [198669] = strPack(packs.DRUIDIC), -- Breton Statue, Chimera
    [146047] = strMultiple(getHouseString(9735), strPack(packs.NEWLIFE2018)), -- From Old Life To New
    [145467] = strPack(packs.SWAMP), -- The Way of Shadow
  },

  [src.EDITOR] = {
    [203178] = strMultiple(strCrown(140), strPack(packs.CURIO)), -- Apocrypha Coral, Large Teal Tube
    [203177] = strMultiple(strCrown(140), strPack(packs.CURIO)), -- Apocrypha Coral, Pink Tube
    [203176] = strMultiple(strCrown(770), strPack(packs.CURIO)), -- Apocrypha Geyser, Ink
    [199136] = strMultiple(strCrown(130), strPack(packs.CURIO)), -- Apocrypha Stalks, Scryeball Patch
    [203133] = strMultiple(strCrown(20), strPack(packs.CURIO)), -- Apocrypha Coral, Spiky
    [198747] = strMultiple(strCrown(430), strPack(packs.DRUIDIC)), -- Druidic Statue, Ancient Augur
    [198674] = strMultiple(strCrown(110), strPack(packs.DRUIDIC)), -- Galen Dogwood, Tall
    [198671] = strMultiple(strCrown(780), strPack(packs.DRUIDIC)), -- Druid King's Sentinel
    [198670] = strMultiple(strCrown(510), strPack(packs.DRUIDIC)), -- Druidic Hut, Conical Stone
    [197839] = strMultiple(strCrown(370), strPack(packs.NECROM)), -- Mushrooms, Ambershine Ring
    [197838] = strMultiple(strCrown(370), strPack(packs.NECROM)), -- Mushrooms, Ambershine Patch
    [197837] = strMultiple(strCrown(70), strPack(packs.NECROM)), -- Mushrooms, Tall Green Morel Cluster
    [197836] = strMultiple(strCrown(70), strPack(packs.NECROM)), -- Mushroom, Tall Green Morel
    [197835] = strMultiple(strCrown(30), strPack(packs.NECROM)), -- Mushrooms, Tall Chanterelle Cluster
    [198664] = strMultiple(strCrown(140), strPack(packs.DRUIDIC), getHouseString(11655)), -- Galen Dogwood, Small
    [198666] = strMultiple(strCrown(170), strPack(packs.DRUIDIC), getHouseString(11655)), -- Galen Dogwood, Twisted
    [198663] = strMultiple(strCrown(10), strPack(packs.DRUIDIC), getHouseString(11655, 13759)), -- Fern Plant, Low Lush
    [198662] = strMultiple(strCrown(10), strPack(packs.DRUIDIC), getHouseString(11655, 13759)), -- Flowers, Orange Daylily Cluster
    [197840] = strMultiple(strCrown(260), strPack(packs.NECROM), getHouseString(11525)), -- Necrom Brazier, Elegant Stone
    [203132] = strMultiple(strCrown(50), getHouseString(11687)), -- Mushroom, Apocrypha Fossilized
    [203202] = strMultiple(strCrown(770), getHouseString(11687)), -- Hermaeus Mora Banner, Large
    [198651] = strMultiple(strCrown(55), getHouseString(13882, 11655, 13758)), -- Druidic Brazier, Standing
    [198667] = strMultiple(strCrown(170), getHouseString(11655)), -- Galen Dogwood, Curved
    [198665] = strMultiple(strCrown(10), getHouseString(11655, 13759)), -- Plant, Emerald Heart Begonia
    [198661] = strMultiple(strCrown(65), getHouseString(11655)), -- Druidic Pot, Stout Clay
    [198660] = strMultiple(strCrown(20), getHouseString(11655)), -- Druidic Pitcher, Clay
    [198659] = strMultiple(strCrown(80), getHouseString(11655)), -- Druidic Kettle, Clay
    [198658] = strMultiple(strCrown(65), getHouseString(11655)), -- Druidic Pot, Wide Clay
    [198657] = strMultiple(strCrown(10), getHouseString(11655)), -- Druidic Plate, Clay
    [198656] = strMultiple(strCrown(15), getHouseString(11655)), -- Druidic Plates, Clay Stack
    [198655] = strMultiple(strCrown(30), getHouseString(11655)), -- Druidic Covered Dish, Stone
    [198654] = strMultiple(strCrown(5), getHouseString(11655)), -- Druidic Plate, Stone
    [198653] = strMultiple(strCrown(5), getHouseString(11655)), -- Druidic Goblet, Stone
    [198652] = strMultiple(strCrown(5), getHouseString(11655)), -- Druidic Bowl, Stone
    [198650] = strMultiple(strCrown(55), getHouseString(11655)), -- Druidic Brazier, Leaning
    [198649] = strMultiple(strCrown(10), getHouseString(11655)), -- Druidic Smoking Rack, Fish
    [198648] = strMultiple(strCrown(10), getHouseString(11655)), -- Druidic Rack, Hide Stretcher
    [198647] = strMultiple(strCrown(30), getHouseString(11655)), -- Druidic Drying Rack, Tall
    [198646] = strMultiple(strCrown(30), getHouseString(11655)), -- Druidic Drying Rack, Wide
  },
}

FurC.CrownStore[ver.BASED] = {
  [src.CROWN] = {},

  [src.EDITOR] = {
    [198561] = strMultiple(strCrown(25), getHouseString(11260)), -- Vine, Wide Moonlit Ivy Drape
    [198560] = strMultiple(strCrown(25), getHouseString(11260)), -- Vine, Large Moonlit Ivy Swath
    [198559] = strMultiple(strCrown(25), getHouseString(11260)), -- Vine, Large Moonlit Ivy Drape
    [198558] = strMultiple(strCrown(25), getHouseString(11260)), -- Vine, Medium Moonlit Ivy Swath
    [198557] = strMultiple(strCrown(25), getHouseString(11260)), -- Vine, Small Moonlit Ivy Drape
    [198555] = strMultiple(strCrown(70), getHouseString(11260)), -- Shrub, Moonlit Ivy
    [198109] = strMultiple(strCrown(40), getHouseString(11260)), -- Trees, Dead Oak Sapling Duo
    [198108] = strMultiple(strCrown(40), getHouseString(11260)), -- Tree, Twisted Dead Oak Sapling
    [198107] = strMultiple(strCrown(40), getHouseString(11260)), -- Trees, Dead Oak Sapling Cluster
    [198106] = strMultiple(strCrown(40), getHouseString(11260)), -- Tree, Dead Oak Sapling
    [198105] = strMultiple(strCrown(150), getHouseString(11260)), -- Tree, Large Ancient Dead Oak
    [198104] = strMultiple(strCrown(150), getHouseString(11260)), -- Tree, Old Dead Oak
    [198103] = strMultiple(strCrown(150), getHouseString(11260)), -- Tree, Ancient Dead Oak
    [198005] = strMultiple(strCrown(45), getHouseString(11260)), -- Hedge, Dense Low Angled Wall
    [198004] = strMultiple(strCrown(45), getHouseString(11260)), -- Hedge, Dense Low Extensive Wall
    [198003] = strMultiple(strCrown(45), getHouseString(11260)), -- Hedge, Dense Low Corner Wall
    [198002] = strMultiple(strCrown(45), getHouseString(11260)), -- Hedge, Dense Low Long Wall
  },
}

FurC.CrownStore[ver.NECROM] = {
  [src.CROWN] = {
    [197624] = strCrown(1200), -- Apocryphal Shifting Sculpture
    [197623] = strCrown(3000), -- Statue, Hermaeus Mora
    [197622] = strCrate(crates.FEATHER), -- Constellation Projection Apparatus
    [197621] = strCrate(crates.FEATHER), -- Household Shrine, Meridian
    [197620] = strCrate(crates.FEATHER), -- Throne of the Lich
    [197619] = strCrate(crates.FEATHER), -- Meridian Mote
  },

  [src.EDITOR] = {
    [194538] = strMultiple(strCrown(110), getHouseString(11216, 14078)), -- Cargo Netting, Large
    [194539] = strMultiple(strCrown(110), getHouseString(11216)), -- Rough Hammock, Pole-Strung
    [194534] = strMultiple(strCrown(260), getHouseString(11216)), -- Dock Bell, Mounted
    [194536] = strMultiple(strCrown(40), getHouseString(11216, 14078)), -- Dock Buoys, Mounted
  },
}

FurC.CrownStore[ver.SCRIBE] = {
  [src.CROWN] = {
    [194399] = strCrown(1000), -- Music Box, Unfathomable Knowledge
    [190941] = strCrown(1000), -- Music Box, Direnni's Swan
    [193818] = strPack(packs.ASTULA), -- Shad Astula Scholar, Right
    [193817] = strPack(packs.ASTULA), -- Shad Astula Scholar, Left
    [193796] = strCrate(crates.RAGE), -- Orb of the Spirit Queen
    [193795] = strCrate(crates.RAGE), -- Rite of the Harrowforged
    [193794] = strCrate(crates.RAGE), -- Target Hagraven, Robust
    [193793] = strCrate(crates.RAGE), -- Reach Chandelier, Hagraven
  },

  [src.EDITOR] = {
    [194411] = strMultiple(strCrown(240), getHouseString(13882, 11172)), -- Stonelore Tale Pillar, Rounded Stone
    [194410] = strMultiple(strCrown(240), getHouseString(13882, 11172)), -- Stonelore Tale Pillar, Slanted Stone
    [194409] = strMultiple(strCrown(140), getHouseString(12472, 11172, 14077, 12270)), -- Potted Tree, Systres Pine
    [194408] = strMultiple(strCrown(150), getHouseString(11216)), -- Systres Brewing Still, Copper
    [194407] = strCrown(40), -- Harbor Rope, Hanging
    [194406] = strMultiple(strCrown(110), getHouseString(11172, 11216, 14078)), -- Harbor Rope, Coiled Buoy
    [194405] = strMultiple(strCrown(40), getHouseString(14078, 11216)), -- Harbor Line, Coiled
    [194404] = strMultiple(strCrown(40), getHouseString(11172, 11216, 14078)), -- Harbor Line, Loose
    [194403] = strMultiple(strCrown(110), getHouseString(11172, 11216, 14078)), -- Harbor Netting, Buoy Cluster
    [194402] = strMultiple(strCrown(110), getHouseString(11172, 14078)), -- Harbor Netting, Hanging Wall
    [194401] = strMultiple(strCrown(150), getHouseString(11172, 11655)), -- Galen Dogwood, Medium Cluster
    [194400] = strMultiple(strCrown(170), getHouseString(11172, 11655)), -- Galen Dogwood, Large
  },
}

FurC.CrownStore[ver.DRUID] = {
  [src.CROWN] = {
    [192406] = strPack(packs.MAORMER), -- Maormer Ship's Prow, Serpentine
    [192405] = strPack(packs.MAORMER), -- Maormer Tent, Raid Leader's
    [190945] = strCrown(5000), -- Tree, Seasons of Y'ffre
    [190940] = strCrown(1000), -- Music Box, Songbird's Paradise
    [190939] = strCrown(1100), -- Music Box, Dawnbreaker's Forging
    [190951] = strCrate(crates.STONELORE), -- Target Spriggan, Robust
    [190950] = strCrate(crates.STONELORE), -- Rose Petal Cascade
    [190947] = strCrate(crates.STONELORE), -- Druidic Arch, Floral
    [190946] = strCrate(crates.STONELORE), -- Earthen Root Essence
  },

  [src.EDITOR] = {
    [192429] = strMultiple(strCrown(110), strPack(packs.MAORMER)), -- Maormer Sconce, Serpentine
    [192427] = strMultiple(strCrown(70), strPack(packs.MAORMER)), -- Maormer Lamp, Serpentine
    [192425] = strMultiple(strCrown(150), strPack(packs.MAORMER)), -- Maormer Teapot, Serpentine
    [192423] = strMultiple(strCrown(340), strPack(packs.MAORMER)), -- Maormer Runner, Amethyst Waves
    [192422] = strMultiple(strCrown(80), strPack(packs.MAORMER)), -- Maormer Half-Rug
    [192420] = strMultiple(strCrown(180), strPack(packs.MAORMER)), -- Maormer Rug, Serpentine
    [192418] = strMultiple(strCrown(10), strPack(packs.MAORMER)), -- Maormer Mug, Serpentine
    [192414] = strMultiple(strCrown(160), strPack(packs.MAORMER)), -- Maormer Armchair, Carved
    [192413] = strMultiple(strCrown(180), strPack(packs.MAORMER)), -- Maormer Table, Carved
    [192412] = strMultiple(strCrown(340), strPack(packs.MAORMER)), -- Maormer Curtain, Serpentine Cloth
    [192410] = strMultiple(strCrown(85), strPack(packs.MAORMER)), -- Maormer Chair, Carved
    [192409] = strMultiple(strCrown(3000), strPack(packs.MAORMER)), -- Maormer Cookfire
    [192408] = strMultiple(strCrown(70), strPack(packs.MAORMER)), -- Maormer Trunk, Carved
    [192407] = strMultiple(strCrown(720), strPack(packs.MAORMER)), -- Maormer Tent, Raider's
  },
}

FurC.CrownStore[ver.DEPTHS] = {
  [src.CROWN] = {
    [189465] = strCrown(1200), -- Music Box, Gonfalon Galliard
    [189464] = strCrown(1000), -- Music Box, Deeproot Dirge
    [189463] = strCrown(3500), -- Statue, Bendu Olo
    [188344] = strCrate(crates.WRAITH), -- Y'ffre's Falling Leaves, Autumn
    [188343] = strCrate(crates.WRAITH), -- Moonlight Path Bridge
    [188342] = strCrate(crates.WRAITH), -- Bat Swarm, Domesticated
    [188341] = strCrate(crates.WRAITH), -- Red Diamond Stained Glass
  },

  [src.EDITOR] = {},
}

FurC.CrownStore[ver.BRETON] = {
  [src.CROWN] = {
    [187667] = strCrown(1200), -- Music Box, High Isle Duel
    [187666] = strCrown(1000), -- Music Box, Steadfast Armistice
    [187665] = strCrown(3500), -- Statue, Kynareth's Blessings
    [187664] = strCrown(6000), -- Target Deadlands Harvester, Trial
    [187663] = strCrate(crates.DARK), -- Blue Fang Shark, Mounted
    [187662] = strCrate(crates.DARK), -- House Dufort Chandelier
    [187661] = strCrate(crates.DARK), -- Mage's Flame
    [187660] = strCrate(crates.DARK), -- Mages Guild Stained Glass
  },

  [src.EDITOR] = {
    [187865] = strMultiple(strCrown(55), getHouseString(13882, 10511)), -- Flowers, Butterweed Cluster
    [187861] = strMultiple(strCrown(110), getHouseString(10511)), -- High Isle Hourglass, Compass Rose
    [187860] = strMultiple(strCrown(65), getHouseString(10511)), -- High Isle Vase, Gilded
  },
}

FurC.CrownStore[ver.TIDES] = {
  [src.CROWN] = {
    [184175] = strCrown(3500), -- Statue, Ancestor-King Auri-El
    [183894] = strPack(packs.AQUATIC), -- Nedic Chest, Bubbling
    [183856] = strPack(packs.AQUATIC), -- Target Mudcrab, Robust Coral
    [183201] = strCrown(1000), -- Music Box: Bleak Beacon Shanty
    [183200] = strCrown(1100), -- Music Box: Wonders of the Shoals
    [184127] = strCrate(crates.SUNKEN), -- Tranquility Pond, Botanical
    [184126] = strCrate(crates.SUNKEN), -- Waterfall Fountain, Round
    [184072] = strCrate(crates.SUNKEN), -- Aquarium, Large Abecean Coral
    [184071] = strCrate(crates.SUNKEN), -- Aquarium, Abecean Coral
  },

  [src.EDITOR] = {
    [184249] = strMultiple(strCrown(20), getHouseString(10223)), -- Elkhorn Coral, Branching
    [184248] = strMultiple(strCrown(20), getHouseString(10223, 11172)), -- Stones, Coral Cluster
    [184247] = strMultiple(strCrown(45), getHouseString(10223)), -- Brittle-Vein Coral, Cluster
    [184250] = strMultiple(strCrown(240), getHouseString(10223)), -- Nedic Banner, Ancient
    [184246] = strMultiple(strCrown(130), getHouseString(10223)), -- Nedic Bench, Carved
    [184245] = strMultiple(strCrown(610), getHouseString(10223)), -- Nedic Chandelier, Swords
    [184244] = strMultiple(strCrown(110), getHouseString(10223)), -- Nedic Sconce, Torch
    [184243] = strMultiple(strCrown(640), getHouseString(10223)), -- Nedic Brazier, Cold-Flame Pillar
    [184242] = strMultiple(strCrown(370), getHouseString(10223)), -- Nedic Brazier, Cold-Flame
    [178477] = strMultiple(strCrown(170), getHouseString(10223)), -- Nedic Bookcase, Filled
    [184205] = strMultiple(strCrown(120), strPack(packs.AQUATIC)), -- Sand Drift, Oceanic
    [184112] = strMultiple(strCrown(170), strPack(packs.AQUATIC)), -- Lilac Coral, Strong
    [184111] = strMultiple(strCrown(170), strPack(packs.AQUATIC)), -- Lilac Anemone, Sprout
    [184110] = strMultiple(strCrown(170), strPack(packs.AQUATIC)), -- Verdant Anemone, Strong
    [184109] = strMultiple(strCrown(90), strPack(packs.AQUATIC)), -- Kelp Grouping, Robust
    [184108] = strMultiple(strCrown(90), strPack(packs.AQUATIC)), -- Kelp Grouping, Thin
    [184107] = strMultiple(strCrown(20), strPack(packs.AQUATIC)), -- Kelp Stalk, Tall
    [184106] = strMultiple(strCrown(20), strPack(packs.AQUATIC)), -- Kelp Stalk, Plain
    [184105] = strMultiple(strCrown(45), strPack(packs.AQUATIC)), -- Green Algae Coral Formation, Tree Capped
    [184104] = strMultiple(strCrown(45), strPack(packs.AQUATIC)), -- Red Algae Coral Formation, Waving Hands
    [184103] = strMultiple(strCrown(45), strPack(packs.AQUATIC)), -- Red Algae Coral Formation, Tree Antler
    [183893] = strMultiple(strCrown(1500), strPack(packs.AQUATIC)), -- Bubbles of Aeration
    [183892] = strMultiple(strCrown(430), strPack(packs.AQUATIC)), -- Minnow School
    [183891] = strMultiple(strCrown(430), strPack(packs.AQUATIC)), -- Jellyfish Bloom, Heliotrope
  },
}

FurC.CrownStore[ver.DEADL] = {
  [src.CROWN] = {
    [181636] = strCrown(1000), -- Music Box, Fargrave Daydreams
    [181637] = strCrown(1200), -- Music Box, Time's Architect
    [182280] = strCrate(crates.CELESTIAL), -- Fargrave Relic Case
    [182207] = strCrate(crates.CELESTIAL), -- Celestial Vortex
    [181643] = strCrate(crates.CELESTIAL), -- Warrior's Flame
    [181487] = strCrate(crates.HARLEQUIN), -- Grim Harlequin Chandelier
    [181438] = strCrate(crates.HARLEQUIN), -- Mad God's Monarch Flock
    [178800] = strCrate(crates.HARLEQUIN), -- Amethyst Candlefly Gathering
    [171947] = strCrate(crates.IRONY), -- Deadlands Chandelier, Bladed
    [171946] = strCrate(crates.IRONY), -- Deadlands Cage, Bladed
    [171945] = strCrate(crates.IRONY), -- Deadlands Sconce, Horned
    [171546] = strCrate(crates.AYLEID), -- Ayleid Relief, Blessed Life-Tree
    [171545] = strCrate(crates.AYLEID), -- Ayleid Gate, Large
    [171544] = strCrate(crates.AYLEID), -- Comet, Aetherial
    [156644] = strCrate(crates.FROSTY), -- Books, Towering Pile
  },

  [src.EDITOR] = {
    [182915] = strMultiple(strCrown(260), getHouseString(10051, 13060)), -- Fargrave Container Plants, Long
    [182916] = strMultiple(strCrown(260), getHouseString(10051, 13060)), -- Fargrave Container Plant, Large Square
    [182917] = strMultiple(strCrown(260), getHouseString(10051, 13060)), -- Fargrave Container Plants, Large Round
    [182914] = strMultiple(strCrown(140), getHouseString(10051)), -- Fargrave Container Plants
    [182913] = strMultiple(strCrown(140), getHouseString(10051, 13060)), -- Fargrave Container Plants, Small
    [182281] = strMultiple(strCrown(2300), getHouseString(10051)), -- Fargrave Fountain
    [182921] = strMultiple(strCrown(490), getHouseString(10051)), -- Fargrave Canopy, Large
    [182918] = strMultiple(strCrown(160), getHouseString(10051)), -- Boulder, Weathered Fargrave
    [182919] = strMultiple(strCrown(160), getHouseString(10051)), -- Rocks, Fargrave Cluster
    [182935] = strMultiple(strCrown(140), getHouseString(10052)), -- Stump, Charred Deadlands
    [182934] = strMultiple(strCrown(140), getHouseString(10052)), -- Log, Charred Deadlands
    [182933] = strMultiple(strCrown(260), getHouseString(10052)), -- Tree, Charred Large Deadlands
    [182922] = strMultiple(strCrown(40), getHouseString(10052)), -- Vines, Thornpinch
    [182925] = strMultiple(strCrown(160), getHouseString(10052)), -- Rocks, Deadlands Cluster
    [182292] = strMultiple(strCrown(260), strPack(packs.AMBITIONS)), -- Deadlands Base, Tower
    [182291] = strMultiple(strCrown(1500), strPack(packs.AMBITIONS)), -- Deadlands Window, Fireglass
    [182290] = strMultiple(strCrown(140), strPack(packs.AMBITIONS)), -- Deadlands Grate, Large
    [182289] = strMultiple(strCrown(140), strPack(packs.AMBITIONS)), -- Deadlands Wall, Etched
    [182295] = strMultiple(strCrown(510), strPack(packs.AMBITIONS)), -- Deadlands Firepit, Large
    [182294] = strMultiple(strCrown(770), strPack(packs.AMBITIONS)), -- Deadlands Platform, Tower
    [182293] = strMultiple(strCrown(260), strPack(packs.AMBITIONS)), -- Deadlands Stairway, Tower
    [182912] = strMultiple(strCrown(270), strPack(packs.AMBITIONS)), -- Deadlands Pillar, Tall
    [182285] = strMultiple(strCrown(160), strPack(packs.FARGRAVE)), -- Book Wall, Levitating
    [182286] = strMultiple(strCrown(860), strPack(packs.FARGRAVE)), -- Fargrave Terrarium, Snakevine
    [182288] = strMultiple(strCrown(820), strPack(packs.FARGRAVE)), -- Fargrave Terrarium, Massive Gas Blossom
    [182284] = strMultiple(strCrown(20), strPack(packs.FARGRAVE)), -- Fargrave Bread Loaves, Round
    [182283] = strMultiple(strCrown(870), strPack(packs.FARGRAVE)), -- Fargrave Terrarium, Lantern Flower
    [182282] = strMultiple(strCrown(560), strPack(packs.FARGRAVE)), -- Fargrave Water Globules, Levitating
    [182258] = strMultiple(strCrown(540), strPack(packs.FARGRAVE)), -- Fargrave Terrarium, Claws
    [182230] = strMultiple(strCrown(140), strPack(packs.FARGRAVE), getHouseString(13882)), -- Mushrooms, Glowing Shelf
  },
}

FurC.CrownStore[ver.WAKE] = {
  [src.CROWN] = {
    [178522] = strCrown(800), -- Music Box, Silver Rose
    [178521] = strCrown(1000), -- Music Box, Invitation to Chaos
    [181485] = strPack(packs.MERMAID), -- Statue, Mermaid of Anvil
    [181483] = strPack(packs.WINDOWS), -- Stained Glass of Akatosh
    [181484] = strPack(packs.WINDOWS), -- Stained Glass of Julianos
    [181482] = strPack(packs.WINDOWS), -- Stained Glass of Arkay
    [181481] = strPack(packs.WINDOWS), -- Stained Glass of Dibella
    [181480] = strPack(packs.WINDOWS), -- Stained Glass of Stendarr
    [181479] = strPack(packs.WINDOWS), -- Stained Glass of Mara
    [181478] = strPack(packs.WINDOWS), -- Stained Glass of Kynareth
  },

  [src.EDITOR] = {
    [181532] = strMultiple(strCrown(3600), getHouseString(9735), strPack(packs.MERMAID)), -- Leyawiin Fountain, Round Grand
    [181602] = strCrown(30), -- Bush, Low Greenleaf Cluster
    [181604] = strMultiple(strCrown(30), getHouseString(13882)), -- Bush, Snow Lillies
    [181600] = strMultiple(strCrown(20), getHouseString(9735)), -- Rock, Gabbro Boulder
    [181606] = strMultiple(strCrown(50), getHouseString(9735)), -- Rock, Gabbro Boulder Cluster
    [181605] = strMultiple(strCrown(5), getHouseString(12270, 9735)), -- Rock, Gabbro Set
    [181601] = strMultiple(strCrown(50), getHouseString(9735)), -- Rock, Wide Gabbro Slab
    [181603] = strCrown(70), -- Plant, White Flowered Lily Pads
    [181607] = strMultiple(strCrown(90), mischouse), -- Tree, Elder Blackwood Beech
    [181608] = strMultiple(strCrown(20), mischouse), -- Tree, Blackwood Beech
    [181609] = strMultiple(strCrown(20), mischouse), -- Tree, Blackwood Beech Cluster
    [181610] = strMultiple(strCrown(25), getHouseString(13882, 9735)), -- Vines, Snow Lillies Swath
    [181611] = strMultiple(strCrown(10), getHouseString(13882, 9735)), -- Vines, Snow Lillies Climber
    [182932] = strMultiple(strCrown(260), getHouseString(10052)), -- Tree, Charred Large Twisted Deadlands
    [182931] = strMultiple(strCrown(140), getHouseString(10052)), -- Tree, Charred Deadlands
    [182930] = strMultiple(strCrown(110), getHouseString(10052)), -- Plant, Pixas
    [182929] = strMultiple(strCrown(110), getHouseString(10052)), -- Plant, Hynvik
    [181547] = strMultiple(strCrown(1000), strPack(packs.MERMAID)), -- Leyawiin Fountain, Corner
    [181486] = strMultiple(strCrown(2700), strPack(packs.MERMAID), getHouseString(9735)), -- Leyawiin Fountain, Round
    [181599] = strMultiple(strCrown(1100), strPack(packs.MERMAID), getHouseString(9735)), -- Leyawiin Fountain, Tall
    [181435] = strMultiple(strCrown(1500), strPack(packs.MERMAID)), -- Steam of Repose
  },
}

FurC.CrownStore[ver.BLACKW] = {
  [src.CROWN] = {
    [175135] = strCrown(3500), -- Statue, Prince of Ambition
    [171943] = strCrown(1000), -- Music Box, The Liberation of Leyawiin
    [171944] = strCrown(1000), -- Music Box, The Mirefrog's Hymn
    [175698] = strPack(packs.ZENI), -- Zenithar, God of Work and Commerce
    [175699] = strMultiple(strPack(packs.ZENI), strPack(packs.WINDOWS)), -- Stained Glass of Zenithar
  },

  [src.EDITOR] = {
    [175695] = strMultiple(strCrown(510), strPack(packs.ZENI)), -- Leyawiin Shrine of the Eight
    [175696] = strMultiple(strCrown(410), strPack(packs.ZENI), getHouseString(9735, 9412)), -- Leyawiin Tapestry, Divines Horizontal
    [175697] = strMultiple(strCrown(410), strPack(packs.ZENI), getHouseString(9412)), -- Leyawiin Tapestry, Divines Vertical
  },
}

FurC.CrownStore[ver.FLAMES] = {
  [src.CROWN] = {
    [171875] = strCrown(6000), -- Target Harrowing Reaper, Trial
    [171857] = strCrown(3000), -- Aetherial Well
    [171543] = strCrown(1000), -- Music Box, Feast of All Flames
    [171542] = strCrown(800), -- Music Box, Farewell to Nenalata
  },

  [src.EDITOR] = {
    [171932] = strMultiple(strCrown(160), getHouseString(9013)), -- Daedric Sconce, Torch
    [171933] = strMultiple(strCrown(80), getHouseString(9013)), -- Daedric Candles, Tall Stand
    [171934] = strMultiple(strCrown(360), getHouseString(9013)), -- Daedric Brazier, Plinth
    [171834] = strMultiple(strCrown(40), getHouseString(9013)), -- Tree, Charred Vvardenfell Pine
    [171835] = strMultiple(strCrown(40), getHouseString(9013)), -- Tree, Charred Leaning Vvardenfell Pine
    [171836] = strMultiple(strCrown(40), getHouseString(9013)), -- Tree, Charred Slim Vvardenfell Pine
    [171940] = strMultiple(strCrown(280), getHouseString(9013)), -- Statue of Sheogorath, Shivering Isles Sovereign
    [171817] = strMultiple(strCrown(730), getHouseString(9014)), -- Ayleid Chandelier, Caged
    [171819] = strMultiple(strCrown(310), getHouseString(9014)), -- Tree, Towering Cork Oak
  },
}

FurC.CrownStore[ver.MARKAT] = {
  [src.CROWN] = {
    [167935] = strCrate(crates.POTENTATE), -- Dwarven Work Lamp, Powered Floor
    [167934] = strCrate(crates.POTENTATE), -- Dwarven Orrery, Scholastic
    [167933] = strCrate(crates.POTENTATE), -- Dwarven Beam Emitter, Medium
    [171397] = strPack(packs.ALCHEMIST), -- Stone Garden Tank, Vacant
    [171398] = strPack(packs.ALCHEMIST), -- Stone Garden Vat, Alchemized Bristleback
    [171399] = strPack(packs.ALCHEMIST), -- Stone Garden Vat, Alchemized Chaurus
    [171400] = strPack(packs.ALCHEMIST), -- Stone Garden Vat, Alchemized Durzog
    [171401] = strPack(packs.ALCHEMIST), -- Stone Garden Vat, Vacant
    [171402] = strPack(packs.ALCHEMIST), -- Stone Garden Circulator, Rootbound
    [171403] = strPack(packs.ALCHEMIST), -- Stone Garden Casket, Alchemized Bloodknight
    [169117] = strPack(packs.ALCHEMIST), -- Target Bloodknight
    [167428] = strCrown(1000), -- Music Box, Mother Morrowind's Sacred Lullaby
    [167429] = strCrown(1000), -- Music Box, Never Fall, Never Die
  },

  [src.EDITOR] = {
    [171382] = strMultiple(strCrown(180), getHouseString(8697)), -- Reachmen Pergola, Ivy Overhang
  },
}

FurC.CrownStore[ver.STONET] = {
  [src.CROWN] = {
    [167007] = strCrown(1000), -- Music Box, Subterranean Sonata
    [167006] = strCrown(1000), -- Music Box, Hymn of Five-Hundred Axes
    [167295] = getHouseString(13882, 8323), -- Tree, Great Snowy White Pine
    [167302] = getHouseString(8652, 8323), -- Solitude Brazier, Metal
    [119685] = strCrate(crates.WILD_HUNT), -- Tapestry of Hircine
    [119684] = strCrate(crates.WILD_HUNT), -- Statue of Hircine
  },

  [src.EDITOR] = {
    [167294] = strMultiple(strCrown(20), mischouse), -- Boulder, Jagged Stone
    [167299] = strMultiple(strCrown(920), getHouseString(8697, 14069, 8323)), -- Dwarven Chandelier, Polished Braced
    [167301] = strMultiple(strCrown(560), getHouseString(8697, 14069, 8323)), -- Dwarven Lamppost, Polished Powered
    [167300] = strMultiple(strCrown(160), getHouseString(8697, 14069, 8323)), -- Dwarven Lantern, Polished Wall
    [167298] = strMultiple(strCrown(310), getHouseString(8697, 14069, 8323)), -- Dwarven Sconce, Polished Barred
    [167289] = strMultiple(strCrown(20), mischouse), -- Tree, Lowland White Pine
    [167290] = strMultiple(strCrown(20), mischouse), -- Tree, Great Lowland White Pine
    [167291] = strMultiple(strCrown(150), mischouse), -- Tree, Towering Royal Pine
    [167306] = strMultiple(strCrown(70), mischouse), -- Tree, Towering Snowy White Pine
    [167292] = strMultiple(strCrown(5), mischouse), -- Rocks, Large Jagged Set
    [167293] = strMultiple(strCrown(30), mischouse), -- Shrub, Long Amber Bayberry
    [167297] = strMultiple(strCrown(30), mischouse), -- Trees, Young Snowy White Pine Cluster
    [167296] = strMultiple(strCrown(20), mischouse), -- Tree, Giant Snowy White Pine
  },
}

FurC.CrownStore[ver.SKYRIM] = {
  [src.CROWN] = {
    [165991] = strCrown(3500), -- Statue, Vampiric Sovereign
    [147747] = strCrown(2500), -- Cadwell's Astounding Portal
    [163428] = strCrown(800), -- Music Box, The Shadows Stir
    [163429] = strCrown(1000), -- Music Box, Enigmas of the Elder Way
    [167332] = strCrate(crates.SOVNGARDE), -- The Mage's Staff Painting, Gold
    [167231] = strCrate(crates.SOVNGARDE), -- Celestial Nimbus
    [167230] = strCrate(crates.SOVNGARDE), -- Alkosh's Hourglass, Replica
    [166030] = strCrate(crates.NIGHTFALL), -- Greymoor Tapestry, Harrowstorm
    [166029] = strCrate(crates.NIGHTFALL), -- Vampiric Fountain, Bat Swarm
    [165568] = strCrate(crates.NIGHTFALL), -- Ancient Nord Gate
    [156669] = strCrate(crates.FROSTY), -- Target Frost Atronach
    [153650] = strCrate(crates.NEWMOON), -- Crystal Sconce, Green,
    [153631] = strCrate(crates.NEWMOON), -- Emerald Candlefly Gathering
    [165578] = strPack(packs.VAMPIRE), -- Basin of Loss
    [165569] = strPack(packs.VAMPIRE), -- Soul-Sworn Thrall
  },

  [src.EDITOR] = {
    [166044] = strMultiple(strCrown(90), strBundle(bundles.STABLE)), -- Watering Trough, Full
    [166452] = strMultiple(strCrown(440), getHouseString(8011)), -- Vampiric Column, Ancient
  },
}

FurC.CrownStore[ver.HARROW] = {
  [src.CROWN] = {
    [159596] = strCrown(800), -- Music Box, The Mad Harlequin's Reverie
    [159439] = strCrown(3500), -- Statue, Pride of Alkosh Hero
    [159598] = strCrown(800), -- Music Box, Dreams of Yokuda
    [159438] = strCrate(crates.GLOOMSPORE), -- Fungus, Gloomspore Ghost
    [159437] = strCrate(crates.GLOOMSPORE), -- Painting of Blackreach, Rough
    [159436] = strCrate(crates.GLOOMSPORE), -- Dwarven Miniature Sun, Portable
  },

  [src.EDITOR] = {
    [159462] = strCrown(170), -- Redguard Fence, Wooden
    [159459] = strMultiple(strCrown(310), getHouseString(7600)), -- Trees, Paired Wrothgar Pine
    [159458] = strMultiple(strCrown(310), getHouseString(7600)), -- Tree, Broad Wrothgar Pine
    [159456] = strMultiple(strCrown(410), getHouseString(7600)), -- Orsinium Well, Open
    [159460] = strMultiple(strCrown(310), getHouseString(7600)), -- Tree, Slim Wrothgar Pine
    [118277] = strMultiple(strCrown(140), mischouse), -- Ram Horns, Mounted
    [159496] = strMultiple(strCrown(240), getHouseString(7600)), -- Tree, Ancient Bristlecone
    [159457] = strMultiple(strCrown(170), getHouseString(7601)), -- Tree, Dagger Bark
    [159461] = strMultiple(strCrown(30), getHouseString(7601)), -- Shrubs, Desert Scrub
  },
}

FurC.CrownStore[ver.DRAGON2] = {
  [src.CROWN] = {
    [156554] = strCrown(800), -- Music Box, A Frost Melt Melody
    [156645] = strCrown(4000), -- Statue, Kaalgrontiid's Ascent
    [156553] = strCrown(800), -- Music Box, That Breezy Night in Bruma
    [156775] = strPack(packs.HEART), -- Bed, Petal-Strewn Double
    [156767] = strPack(packs.HEART), -- Sweetroll Platter
  },

  [src.EDITOR] = {
    [156764] = strMultiple(strCrown(85), strPack(packs.HEART)), -- Bouquet, Small Dibella's
    [156776] = strMultiple(strCrown(85), strPack(packs.HEART)), -- Bouquet, Large Dibella's
    [156777] = strMultiple(strCrown(85), strPack(packs.HEART)), -- Bouquet, Medium Dibella's
    [156765] = strMultiple(strCrown(290), strPack(packs.HEART)), -- Chair, Love-Blessed
    [156766] = strMultiple(strCrown(180), strPack(packs.HEART)), -- Petals, Blanket
    [156768] = strMultiple(strCrown(100), strPack(packs.HEART)), -- Love's Flame Candlestick
    [156769] = strMultiple(strCrown(500), strPack(packs.HEART)), -- Kitten Moppet, Heart's Promise
    [156770] = strMultiple(strCrown(500), strPack(packs.HEART)), -- Kitten Moppet, Love-Blessed
    [156771] = strMultiple(strCrown(410), strPack(packs.HEART)), -- Table, Love-Blessed
    [156772] = strMultiple(strCrown(340), strPack(packs.HEART)), -- Petals, Large Blanket
    [156773] = strMultiple(strCrown(180), strPack(packs.HEART)), -- Rug, Love-Blessed
    [156774] = strMultiple(strCrown(180), strPack(packs.HEART)), -- Tapestry, Love-Blessed
    [156778] = strMultiple(strCrown(85), strPack(packs.HEART)), -- Flower, Dibella's Promise
    [134971] = strMultiple(strCrown(100), strPack(packs.HEART)), -- Candles, Votive Group
  },
}

FurC.CrownStore[ver.SCALES] = {
  [src.CROWN] = {
    [152257] = strBundle(bundles.EBONY), -- Banner of Mephala
    [152259] = strBundle(bundles.RAZOR), -- Banner of Mehrunes Dagon
    [147746] = strCrown(1400), -- Bust: Abnur Tharn
    [153634] = strCrown(800), -- Music Box, Diamond Melody
    [153633] = strCrown(800), -- Music Box, The Ghosts of Frostfall
    [153630] = strCrate(crates.NEWMOON), -- Shadow Tendril Patch
  },

  [src.EDITOR] = {
    [153675] = strMultiple(strCrown(200), getHouseString(6752)), -- Daedric Altar, Four Alcoves
    [153676] = strMultiple(strCrown(270), getHouseString(6752)), -- Daedric Sarcophagus, Stone
    [153660] = strMultiple(strCrown(560), strPack(packs.KHAJIIT)), -- Elsweyr Cart, Moons-Blessed
    [153669] = strMultiple(strCrown(300), strPack(packs.KHAJIIT)), -- Elsweyr Well, Simple Arched
    [153658] = strMultiple(strCrown(70), strPack(packs.KHAJIIT)), -- Moon-Sugar, Row
    [153659] = strMultiple(strCrown(30), strPack(packs.KHAJIIT)), -- Moon-Sugar, Cluster
    [153667] = strMultiple(strCrown(170), strPack(packs.KHAJIIT)), -- Moon-Sugar, Harvested Large
    [153668] = strMultiple(strCrown(90), strPack(packs.KHAJIIT)), -- Moon-Sugar, Harvested Small
    [153632] = strMultiple(strCrown(1500), strPack(packs.KHAJIIT)), -- Sapphire Candlefly Gathering
    [153661] = strMultiple(strCrown(40), strPack(packs.KHAJIIT), strBundle(bundles.STABLE)), -- Straw Pile
    [153662] = strMultiple(strCrown(40), strPack(packs.KHAJIIT), getHouseString(13882)), -- Tool, Plow
    [153663] = strMultiple(strCrown(40), strPack(packs.KHAJIIT)), -- Tool, Sickle
    [153664] = strMultiple(strCrown(40), strPack(packs.KHAJIIT), strBundle(bundles.STABLE)), -- Tool, Pitchfork
    [153665] = strMultiple(strCrown(40), strPack(packs.KHAJIIT)), -- Tool, Hoe
    [153666] = strMultiple(strCrown(40), strPack(packs.KHAJIIT), getHouseString(6752)), -- Tool, Two-Person Crosscut Saw
  },
}

FurC.CrownStore[ver.KITTY] = {
  [src.CROWN] = {
    [151909] = strCrown(800), -- Music Box, A Clash of Fang and Flame
    [151910] = strCrown(800), -- Music Box, Dancing Among the Flowers Fine
    [147926] = strCrown(6000), -- Target Iron Atronach, Trial
    [151838] = strPack(packs.OASIS), -- Elsweyr Fountain, Moons-Blessed
    [151835] = strPack(packs.OASIS), -- Cathay-Raht Statue, Warrior
    [151836] = strPack(packs.OASIS), -- Tojay Statue, Dancer
    [151837] = strPack(packs.OASIS), -- Ohmes-Raht Statue, Trickster
    [151906] = strPack(packs.MOONBISHOP), -- Robust Target Dro-m'Athra
    [151829] = strPack(packs.MOONBISHOP), -- Suthay Statue, Nimble Bishop
    [150775] = strBundle(bundles.JYGGALAG), -- Banner of Jyggalag
    [152145] = strMultiple(mischouse, srcCraft), -- Orcish Tapestry, War       CRAFTABLE
    [152149] = strMultiple(mischouse, srcCraft), -- Orcish Brazier, Pillar     CRAFTABLE
    [152148] = strMultiple(mischouse, srcCraft), -- Orcish Tapestry, Hunt      CRAFTABLE
    [152146] = strMultiple(mischouse, srcCraft), -- Orcish Chandelier, Spiked  CRAFTABLE
    [152141] = strMultiple(mischouse, srcCraft), -- Orcish Brazier, Bordered   CRAFTABLE
    [152144] = strMultiple(mischouse, srcCraft), -- Orcish Mirror, Peaked      CRAFTABLE
    [152143] = strMultiple(mischouse, srcCraft), -- Orcish Sconce, Scrolled    CRAFTABLE
    [152142] = strMultiple(mischouse, srcCraft), -- Orcish Sconce, Bordered    CRAFTABLE
    [151612] = strCrate(crates.BAANDARI), -- Pile of Dubious Riches
    [151611] = strCrate(crates.BAANDARI), -- The Mane, Moons-Blessed
    [151589] = strCrate(crates.BAANDARI), -- Baandari Lunar Compass
  },

  [src.EDITOR] = {
    [151901] = strMultiple(strCrown(20), strPack(packs.KHAJIIT)), -- Elsweyr Bowl, Moon-Sugar
    [151840] = strMultiple(strCrown(70), strPack(packs.OASIS)), -- Plant, Desert Fan
    [151841] = strMultiple(strCrown(70), strPack(packs.OASIS)), -- Plant, Tall Desert Fan
    [151842] = strMultiple(strCrown(20), strPack(packs.OASIS), getHouseString(12456)), -- Plant, Cask Palm
    [151843] = strMultiple(strCrown(45), strPack(packs.OASIS)), -- Cactus, Flowering Cluster
    [151844] = strMultiple(strCrown(30), strPack(packs.OASIS)), -- Cactus, Bilberry
    [151845] = strMultiple(strCrown(95), strPack(packs.OASIS), mischouse), -- Elsweyr Potted Cactus, Flowering
    [151846] = strMultiple(strCrown(35), strPack(packs.OASIS), strPack(packs.MERMAID), mischouse), -- Elsweyr Potted Plant, Cask Palm
    [151847] = strMultiple(strCrown(20), strPack(packs.OASIS)), -- Plant, Flowering Desert Aloe
    [151848] = strMultiple(strCrown(15), strPack(packs.OASIS)), -- Trees, Sunset Palm Cluster
    [151849] = strMultiple(strCrown(45), strPack(packs.OASIS)), -- Cactus, Lily Flower
    [151850] = strMultiple(strCrown(20), strPack(packs.OASIS)), -- Tree, Anequina Bonsai
    [151834] = strMultiple(strCrown(90), strPack(packs.OASIS), getHouseString(6399)), -- Tree, Desert Acacia Shade
    [151830] = strMultiple(strCrown(190), strPack(packs.MOONBISHOP), mischouse), -- Elsweyr Divider, Elegant Wooden
    [151832] = strMultiple(strCrown(100), strPack(packs.MOONBISHOP)), -- Elsweyr Ceremonial Lantern, Jone
    [151833] = strMultiple(strCrown(100), strPack(packs.MOONBISHOP)), -- Elsweyr Ceremonial Lantern, Jode
    [151831] = strMultiple(strCrown(290), strPack(packs.MOONBISHOP), getHouseString(10051)), -- Elsweyr Sugar Pipe, Ceremonial
    [151867] = strMultiple(strCrown(340), getHouseString(7226)), -- Hakoshae Lanterns, Festival
    [151868] = strMultiple(strCrown(180), getHouseString(7218, 7226)), -- Hakoshae Banners, Festival
    [151869] = strCrown(300), -- Elsweyr Wagon, Covered
    [151870] = strCrown(560), -- Elsweyr Wagon, Pedlar
    [151871] = strCrown(300), -- Elsweyr Dais, Temple
    [151874] = strMultiple(strCrown(300), getHouseString(6399)), -- Elsweyr Shrine, Ancient Stone
    [151875] = strCrown(560), -- Elsweyr Bridge, Ancient Stone
    [151876] = strCrown(590), -- Elsweyr Tent, Caravan
    [151877] = strCrown(590), -- Elsweyr Canopy, Bazaar
    [151878] = strCrown(450), -- Elsweyr Canopy, Peaked  (no longer in housing editor)
    [151883] = strCrown(240), -- Tree, Towering Iroko
    [151905] = strMultiple(strCrown(10), getHouseString(6399, 12456)), -- Rock, Wide Flat Slate
    [151911] = strMultiple(strCrown(5), getHouseString(6399, 12456)), -- Rock, Flat Slate
    [151912] = strMultiple(strCrown(10), getHouseString(6399, 12456)), -- Stepping Stones, Slate
    [151914] = strMultiple(strCrown(25), getHouseString(6399)), -- Tree, Desert Acacia Tall
    [151884] = strMultiple(strCrown(310), getHouseString(12456)), -- Tree, Giant Ficus
    [151885] = strMultiple(strCrown(310), getHouseString(12456)), -- Tree, Massive Ficus
    [151872] = strCrown(110), -- Boulder, Towering Lunar Spire
    [151873] = strCrown(50), -- Boulder, Lunar Crag
    [151879] = strMultiple(strCrown(560), getHouseString(6399)), -- Cactus, Lunar Tendrils
    [151880] = strMultiple(strCrown(640), getHouseString(6399)), -- Cactus, Lunar Branching
    [151881] = strMultiple(strCrown(640), getHouseString(6399)), -- Cactus, Lunar Branching Tall
    [151882] = strMultiple(strCrown(140), getHouseString(6399)), -- Cactus, Banded Lunar Violet Trio
    [151904] = strMultiple(strCrown(370), getHouseString(6399)), -- Glowgrass, Patch
    [151913] = strMultiple(strCrown(5), getHouseString(6399)), -- Rock, Slate
  },
}

FurC.CrownStore[ver.WOTL] = {
  [src.CROWN] = {
    [147600] = strCrate(crates.DRAGONSCALE), -- Tapestry of Namira
    [147599] = strCrate(crates.DRAGONSCALE), -- Banner of Namira
    [147591] = strCrate(crates.DRAGONSCALE), -- Namira, Mistress of Decay
    [147646] = strCrown(3000), -- Meridia, Lady of Infinite Energies
    [147507] = strCrown(800), -- Music Box, Hinterlands
    [147505] = strCrown(800), -- Music Box, Y'ffre in Every Leaf
    [147506] = strCrown(800), -- Music Box, Sands of the Alik'r
    [147636] = strBundle(bundles.FIRSTBLADE), -- Banner of Hermaeus Mora
    [147590] = strPack(packs.FORGE), -- Dwarven Bust, Forge-Lord
    [147574] = strPack(packs.FORGE), -- Dwarven Frieze, Wrathstone
    [147575] = strPack(packs.FORGE), -- Dwarven Frieze, Power in Twain
    [147576] = strPack(packs.FORGE), -- Dwarven Frieze, Colossal Power
    [151824] = strPack(packs.MOONBISHOP), -- Lunar Tapestry, The Open Path
    [151825] = strPack(packs.MOONBISHOP), -- Lunar Tapestry, The Gathering
    [151826] = strPack(packs.MOONBISHOP), -- Lunar Tapestry, The Dance
    [151827] = strPack(packs.MOONBISHOP), -- Lunar Tapestry, The Gate
    [151828] = strPack(packs.MOONBISHOP), -- Lunar Tapestry, The Demon
  },

  [src.EDITOR] = {
    [147585] = strMultiple(strCrown(40), strPack(packs.FORGE), getHouseString(6139)), -- Dwarven Gear, Large Spokes
    [147586] = strMultiple(strCrown(50), strPack(packs.FORGE)), -- Dwarven Hub, Sentry Wheel
    [147587] = strMultiple(strCrown(40), strPack(packs.FORGE)), -- Dwarven Gear, Large Open
    [147588] = strMultiple(strCrown(220), strPack(packs.FORGE)), -- Dwarven Conduit, Rounded
    [147589] = strMultiple(strCrown(150), strPack(packs.FORGE)), -- Dwarven Brazier, Open
    [147664] = strMultiple(strCrown(270), strPack(packs.FORGE)), -- Dwarven Dais, Conduit
    [147577] = strMultiple(strCrown(920), strPack(packs.FORGE)), -- Dwarven Platform, Fan
    [147578] = strMultiple(strCrown(1400), strPack(packs.FORGE)), -- Dwarven Throne, Conduit
    [147579] = strMultiple(strCrown(240), strPack(packs.FORGE), getHouseString(6139)), -- Dwarven Gearwork, Perpetual
    [147580] = strMultiple(strCrown(310), strPack(packs.FORGE), getHouseString(6139)), -- Dwarven Lamps, Heavy
    [147581] = strMultiple(strCrown(350), strPack(packs.FORGE), getHouseString(6139)), -- Dwarven Table, Heavy Workbench
    [147582] = strMultiple(strCrown(50), strPack(packs.FORGE)), -- Dwarven Part, Sentry Head
    [147583] = strMultiple(strCrown(220), strPack(packs.FORGE), getHouseString(6139)), -- Dwarven Valve, Sealed
    [147584] = strMultiple(strCrown(160), strPack(packs.FORGE)), -- Dwarven Rack, Spider Legs
    [147572] = strCrown(120), -- Barricade, Bladed Fence
    [147573] = strCrown(120), -- Barricade, Bladed Hurdle
  },
}

FurC.CrownStore[ver.WEREWOLF] = {
  [src.CROWN] = {
    [141835] = getHouseString(5461), -- Tree, Whorled Fig
  },

  [src.EDITOR] = {
    [141832] = strMultiple(strCrown(70), getHouseString(5461)), -- Tree, Robust Fig
    [141833] = strMultiple(strCrown(150), getHouseString(5461)), -- Tree, Ancient Fig
    [141834] = strMultiple(strCrown(170), getHouseString(5461)), -- Tree, Towering Fig
    [141845] = strMultiple(strCrown(370), getHouseString(5461)), -- Mushrooms, Climbing Ambershine
    [141846] = strMultiple(strCrown(370), getHouseString(5461)), -- Mushrooms, Ambershine Cluster
    [141844] = strMultiple(strCrown(70), getHouseString(5461)), -- Plants, Amber Spadeleaf Cluster
    [141841] = strMultiple(strCrown(40), getHouseString(5461)), -- Tree Ferns, Cluster
    [141842] = strMultiple(strCrown(10), getHouseString(5461)), -- Tree Ferns, Juvenile Cluster
    [141836] = strMultiple(strCrown(170), getHouseString(5461)), -- Monolith, Lord Hircine Ritual
    [141843] = strMultiple(strCrown(30), getHouseString(5461)), -- Plants, Yellow Frond Cluster
    [140297] = strMultiple(strCrown(1700), strPack(packs.NOBLEPARLOUR)), -- Replica Throne of Alinor
    [141976] = strMultiple(strCrown(60), strPack(packs.HOLLOWJACK)), -- Pumpkin Patch, Display
    [141869] = strMultiple(strCrown(150), getHouseString(5462)), -- Alinor Potted Plant, Cypress
    [141853] = strMultiple(strCrown(2500), getHouseString(5461)), -- Statue of Hircine's Bitter Mercy
    [139364] = strCrown(1500), -- Sea Sload Neural Tree, Active
    [139363] = strCrown(340), -- Sea Sload Astral Nodule, Large
    [139362] = strCrown(340), -- Sea Sload Astral Nodule, Small
  },
}

FurC.CrownStore[ver.SLAVES] = {
  [src.CROWN] = {
    [145446] = strPack(packs.SWAMP), -- Sithis, the Hungering Dark
    [146069] = strPack(packs.SWAMP), -- Target Voriplasm
    [145493] = strCrate(crates.XANMEER), -- Lantern Mantis
    [145492] = strCrate(crates.XANMEER), -- Gas Blossom
    [145491] = strCrate(crates.XANMEER), -- Static Pitcher
  },

  [src.EDITOR] = {
    [142235] = strCrown(800), -- Music Box, Flickering Shadows
    [145466] = strCrown(40), -- Plant, Wilted Hist Bulb
    [145465] = strCrown(30), -- Plant Cluster, Wilted Hist Bulb
    [145464] = strCrown(30), -- Plant, Red Sister Ti
    [145463] = strCrown(35), -- Plant Cluster, Red Sister Ti
    [145462] = strCrown(40), -- Plant, Cardinal Flower
    [145460] = strCrown(30), -- Plant, Canna Leaves
    [145459] = strCrown(90), -- Murkmire Kiln, Ancient Stone
    [145448] = strMultiple(strCrown(1000), strPack(packs.SWAMP), getHouseString(5757)), -- Murkmire Throne, Engraved
    [145444] = strCrown(130), -- Murkmire Totem, Hist Guardian
    [145429] = strCrown(65), -- Plant Cluster, Bounteous Cardinal Flower
    [145411] = strCrown(410), -- Plant, Luminous Lantern Flower
    [145322] = strCrown(800), -- Music Box, Blood and Glory
    [145457] = strCrown(70), -- Tree, Banyan
    [145458] = strCrown(220), -- Tree, Huge Ancient Banyan
    [146062] = strMultiple(strCrown(270), strPack(packs.NEWLIFE2018)), -- Winter Ouroboros Wreath
    [146061] = strMultiple(strCrown(270), strPack(packs.NEWLIFE2018)), -- New Life Triptych Banner
    [146060] = strMultiple(strCrown(95), strPack(packs.NEWLIFE2018)), -- New Life Ladle
    [146059] = strMultiple(strCrown(360), strPack(packs.NEWLIFE2018)), -- New Life Snowmortal, Khajiit
    [146058] = strMultiple(strCrown(360), strPack(packs.NEWLIFE2018)), -- New Life Snowmortal, Argonian
    [146057] = strMultiple(strCrown(360), strPack(packs.NEWLIFE2018)), -- New Life Snowmortal, Human
    [146056] = strMultiple(strCrown(130), strPack(packs.NEWLIFE2018)), -- New Life Cookies and Ale
    [146055] = strMultiple(strCrown(65), strPack(packs.NEWLIFE2018), strPack(packs.WINTER)), -- New Life Garland Wreath
    [146054] = strMultiple(strCrown(60), strPack(packs.NEWLIFE2018), strPack(packs.WINTER)), -- New Life Garland
    [146053] = strMultiple(strCrown(480), strPack(packs.NEWLIFE2018)), -- Guar Ice Sculpture
    [146052] = strMultiple(strCrown(480), strPack(packs.NEWLIFE2018)), -- Vvardvark Ice Sculpture
    [146051] = strMultiple(strCrown(480), strPack(packs.NEWLIFE2018)), -- Mudcrab Ice Sculpture
    [146050] = strMultiple(strCrown(2700), strPack(packs.NEWLIFE2018)), -- Winter Festival Hearthfire
    [146049] = strMultiple(strCrown(750), strPack(packs.NEWLIFE2018)), -- Winter Festival Hearth
    [146048] = strMultiple(strCrown(1200), strPack(packs.NEWLIFE2018)), -- New Life Festive Fir
    [145556] = strMultiple(strCrown(60), getHouseString(5756)), -- Tree, Tall Snowy Fir
    [145555] = strMultiple(strCrown(40), getHouseString(5756)), -- Tree, Snowy Fir
    [145554] = strMultiple(strCrown(210), getHouseString(5756)), -- Tree, Towering Snowy Fir
    [145454] = strMultiple(strCrown(30), strPack(packs.SWAMP), getHouseString(13882)), -- Plant, Marsh Aloe Pod
    [145453] = strMultiple(strCrown(30), strPack(packs.SWAMP)), -- Plant, Marsh Aloe
    [145456] = strMultiple(strCrown(260), strPack(packs.SWAMP)), -- Plant, Hist Bulb
    [145455] = strMultiple(strCrown(290), strPack(packs.SWAMP)), -- Plant, Dendritic Hist Bulb
    [145452] = strMultiple(strCrown(170), strPack(packs.SWAMP)), -- Shrine, Sithis Looming Anointed
    [145451] = strMultiple(strCrown(140), strPack(packs.SWAMP)), -- Shrine, Sithis Figure Anointed
    [145449] = strMultiple(strCrown(450), strPack(packs.SWAMP)), -- Stele, Hist Guardians
    [145450] = strMultiple(strCrown(450), strPack(packs.SWAMP)), -- Stele, Hist Cultivation
    [146073] = strMultiple(strCrown(70), strPack(packs.DEEPMIRE)), -- Plant Cluster, Marsh Nigella
    [145461] = strCrown(30), -- Plant Cluster, Cardinal Flower
    [145447] = strMultiple(strCrown(260), strPack(packs.SWAMP), getHouseString(5757)), -- Murkmire Dais, Engraved
    [145445] = strPack(packs.DEEPMIRE), -- The Sharper Tongue: A Jel Primer
    [145443] = strMultiple(strCrown(270), strPack(packs.DEEPMIRE), getHouseString(5757)), -- Murkmire Shrine, Sithis Looming
    [145442] = strMultiple(strCrown(140), strPack(packs.DEEPMIRE)), -- Grave-Stake, Large Twinned
    [145441] = strMultiple(strCrown(140), strPack(packs.DEEPMIRE)), -- Grave-Stake, Large Serpent
    [145440] = strMultiple(strCrown(140), strPack(packs.DEEPMIRE)), -- Grave-Stake, Large Skull
    [145439] = strMultiple(strCrown(140), strPack(packs.DEEPMIRE)), -- Grave-Stake, Large Fearsome
    [145438] = strMultiple(strCrown(140), strPack(packs.DEEPMIRE)), -- Grav-Stake, Large Glyphed
    [145437] = strMultiple(strCrown(240), strPack(packs.DEEPMIRE)), -- Reed Felucca, Double Hulled
    [145436] = strPack(packs.DEEPMIRE), -- Canopied Felucca, Double Hulled
    [145435] = strMultiple(strCrown(110), strPack(packs.DEEPMIRE)), -- Plant, Marsh Mani Flower
    [145434] = strMultiple(strCrown(110), strPack(packs.DEEPMIRE)), -- Plant, Large Inert Lantern Flower
    [145433] = strMultiple(strCrown(60), strPack(packs.DEEPMIRE), getHouseString(5757)), -- Plant, Rafflesia
    [145432] = strMultiple(strCrown(70), strPack(packs.DEEPMIRE)), -- Plant, Canna Lily
    [145431] = strMultiple(strCrown(35), strPack(packs.DEEPMIRE)), -- Plant, Marsh Nigella
    [145430] = strMultiple(strCrown(55), strPack(packs.DEEPMIRE)), -- Plant, Star Blossom
    [145428] = strMultiple(strCrown(65), strPack(packs.DEEPMIRE), getHouseString(11172)), -- Murkmire Lantern Post, Covered
    [145427] = strPack(packs.DEEPMIRE), -- Serpent Skull, Colossal
    [145426] = strMultiple(strCrown(410), strPack(packs.DEEPMIRE)), -- Murkmire Felucca, Canopied
  },
}

FurC.CrownStore[ver.ALTMER] = {
  [src.CROWN] = {},

  [src.EDITOR] = {
    [139483] = strMultiple(strCrown(90), getHouseString(5169)), -- Alinor Column, Tumbled Timeworn
    [139482] = strMultiple(strCrown(200), getHouseString(5169, 5462)), -- Alinor Column, Huge Timeworn
    [139481] = strMultiple(strCrown(200), getHouseString(5169)), -- Alinor Column, Jagged Timeworn
    [139368] = strMultiple(strCrown(100), strPack(packs.NOBLEBATH), strPack(packs.JESTER), getHouseString(13558)), -- Alinor Bathing Robes, Decorative
    [139366] = strMultiple(strCrown(2000), strPack(packs.NOBLEPARLOUR)), -- Alinor Fountain, Regal
    [139352] = strMultiple(strCrown(1000), getHouseString(5169)), -- Alinor Tomb, Ornate
    [139351] = strCrown(200), -- Alinor Monument, Marble
    [139350] = strMultiple(strCrown(940), getHouseString(13882, 12655, 13560)), -- Alinor Pergola, Purple Wisteria Overhang
    [139349] = strMultiple(strCrown(940), getHouseString(5168, 12655)), -- Alinor Pergola, Blue Wisteria Peaked
    [139348] = strMultiple(strCrown(940), getHouseString(5462, 5168)), -- Alinor Pergola, Purple Wisteria
  },
}

FurC.CrownStore[ver.DRAGONS] = {
  [src.CROWN] = {
    [134855] = strCrate(crates.SCALECALLER), -- Banner of Peryite
    [134854] = strCrate(crates.SCALECALLER), -- Tapestry of Peryite
    [134853] = strCrate(crates.SCALECALLER), -- Peryite, The Taskmaster
    [134686] = strCrown(2000), -- Sithis, The Dread Father
    [134879] = strPack(packs.HUBTREASURE), -- Hubalajad's Reflection
    [134880] = strPack(packs.HUBTREASURE), -- Ra Gada Reliquary, Miniature Palace
    [134881] = strPack(packs.HUBTREASURE), -- In Defense of Prince Hubalajad
    [134823] = strPack(packs.HUBTREASURE), -- Target Mournful Aegis
    [134890] = strPack(packs.DIBELLA), -- Dibella, Lady of Love
    [134961] = strPack(packs.DIBELLA), -- Dibella's Mysteries and Revelations
    [134870] = strPack(packs.TYRANTS), -- Ancient Nord Chest, Dragon Crest
    [134871] = strMultiple(strPack(packs.TYRANTS), getHouseString(8652)), -- Ancient Nord Urn, Dragon Crest
    [134873] = strMultiple(strPack(packs.TYRANTS), getHouseString(8652)), -- Ancient Nord Bookcase, Wide
    [134874] = strPack(packs.TYRANTS), -- Ancient Nord Bookcase, Narrow
    [134875] = strPack(packs.TYRANTS), -- Ancient Nord Funerary Jar, Linked Rings
    [134876] = strPack(packs.TYRANTS), -- Ancient Nord Funerary Jar, Crimson Sash
    [134877] = strMultiple(strPack(packs.TYRANTS), getHouseString(8652)), -- Ancient Nord Funerary Jar, Dragon Figure
    [134878] = strPack(packs.TYRANTS), -- Ancient Nord Funerary Jar, Dragon Crest
    [134872] = strMultiple(strPack(packs.TYRANTS), getHouseString(8652)), -- Ancient Nord Brazier, Dragon Crest
    [134863] = strMultiple(strPack(packs.TYRANTS), getHouseString(8652)), -- Ancient Nord Sconce, Dragon Crest
    [134862] = strPack(packs.TYRANTS), -- Ancient Nord Runestone, Memorial
    [134856] = strPack(packs.TYRANTS), -- Dragon Skeleton, Mid-Flight
    [134857] = strPack(packs.TYRANTS), -- Dragon Priest Frieze: Triumph
    [134858] = strPack(packs.TYRANTS), -- Dragon Priest Frieze: Exodus
    [134859] = strPack(packs.TYRANTS), -- Dragon Priest Frieze: Restoration
    [134860] = strPack(packs.TYRANTS), -- Dragon Priest Frieze: Ascension
    [134861] = strPack(packs.TYRANTS), -- The History of Zaan The Scalecaller
    [134864] = strPack(packs.TYRANTS), -- Dragon Cranium, Ancient
    [134865] = strPack(packs.TYRANTS), -- Unidentified Bones, Gargantuan
    [134866] = strPack(packs.TYRANTS), -- Lamia Cranium, Ancient
    [134867] = strPack(packs.TYRANTS), -- Argonian Skull, Complete
    [134868] = strPack(packs.TYRANTS), -- Khajiit Skull, Complete
    [134869] = strPack(packs.TYRANTS), -- Orc Skull, Complete
    [140220] = strPack(packs.MEPHALA), -- Rumors of the Spiral Skein
    [139163] = strPack(packs.MEPHALA), -- Mephala, The Webspinner (statue)
    [139139] = strMultiple(strCrate(crates.PSIJIC), getHouseString(11260)), -- Nocturnal, Mistress of Shadows
    [139138] = strCrate(crates.PSIJIC), -- Banner, Nocturnal
    [139137] = strCrate(crates.PSIJIC), -- Tapestry, Nocturnal
  },

  [src.EDITOR] = {
    [134970] = strMultiple(strCrown(100), getHouseString(4794)), -- Mushrooms, Glowing Sprawl
    [134947] = strMultiple(strCrown(100), getHouseString(4794)), -- Mushrooms, Glowing Field
    [134948] = strMultiple(strCrown(400), getHouseString(4794)), -- Mushrooms, Glowing Cluster
    [134972] = strMultiple(strCrown(400), getHouseString(4794)), -- Brotherhood Brazier, Wrought Iron
    [134882] = strMultiple(strCrown(90), strPack(packs.HUBTREASURE), getHouseString(14586)), -- Gold Drakes, Pristine
    [134883] = strMultiple(strCrown(360), strPack(packs.HUBTREASURE)), -- Ra Gada Funerary Statue, Stone Cat
    [134884] = strMultiple(strCrown(360), strPack(packs.HUBTREASURE)), -- Ra Gada Funerary Statue, Gilded Cat
    [134885] = strMultiple(strCrown(360), strPack(packs.HUBTREASURE)), -- Ra Gada Funerary Statue, Gilded Ibis
    [134886] = strMultiple(strCrown(360), strPack(packs.HUBTREASURE)), -- Ra Gada Funerary Statue, Gilded Servant
    [134887] = strMultiple(strCrown(2000), strPack(packs.HUBTREASURE)), -- Ra Gada Guardian Statue, Lion Ibis
    [134888] = strMultiple(strCrown(2000), strPack(packs.HUBTREASURE)), -- Ra Gada Guardian Statue, Winged Bull
    [134889] = strMultiple(strCrown(2000), strPack(packs.HUBTREASURE)), -- Ra Gada Guardian Statue, Riding Camel
    [134971] = strMultiple(strCrown(400), strPack(packs.HEART), getHouseString(4794)), -- Candles, Votive Group
    [134848] = strMultiple(strCrown(1500), strPack(packs.DIBELLA), strPack(packs.OASIS)), -- Blue Butterfly Flock
    [134899] = strMultiple(strCrown(45), strPack(packs.DIBELLA)), -- Flower Spray, Crimson Daisies
    [134901] = strMultiple(strCrown(45), strPack(packs.DIBELLA), getHouseString(13882)), -- Flower Spray, Starlight Daisies
    [134896] = strMultiple(strCrown(45), strPack(packs.DIBELLA)), -- Flower, Lover's Lily
    [134898] = strMultiple(strCrown(45), strPack(packs.DIBELLA)), -- Flowers, Midnight Sage
    [134900] = strMultiple(strCrown(20), strPack(packs.DIBELLA)), -- Flowers, Red Poppy
    [134902] = strMultiple(strCrown(20), strPack(packs.DIBELLA)), -- Flowers, Violet Bellflower
    [134903] = strMultiple(strCrown(45), strPack(packs.DIBELLA)), -- Flowers, Midnight Glory
    [134849] = strMultiple(strCrown(1500), strPack(packs.DIBELLA), strPack(packs.OASIS)), -- Monarch Butterfly Flock
    [134891] = strMultiple(strCrown(2500), strPack(packs.DIBELLA)), -- Pergola, Festive Flowers
    [134895] = strMultiple(strCrown(1800), strPack(packs.DIBELLA)), -- Redguard Fountain, Mosaic
    [134904] = strMultiple(strCrown(260), strPack(packs.DIBELLA)), -- Seal of Dibella
    [134905] = strMultiple(strCrown(260), strPack(packs.DIBELLA)), -- Ritual Stone, Dibella
    [134906] = strMultiple(strCrown(240), strPack(packs.DIBELLA), getHouseString(13060)), -- Ritual Brazier, Gilded
    [134892] = strMultiple(strCrown(85), strPack(packs.DIBELLA)), -- Tree, Pale Gold
    [134893] = strMultiple(strCrown(85), strPack(packs.DIBELLA), getHouseString(14587)), -- Tree, Argent Blue
    [134894] = strMultiple(strCrown(20), strPack(packs.DIBELLA)), -- Wildflowers, Yellow and Orange
    [134897] = strMultiple(strCrown(45), strPack(packs.DIBELLA), getHouseString(13882)), -- Vine Curtain, Festive Flowers
    [134921] = strMultiple(strCrown(520), mischouse, strPack(packs.FARGRAVE)), -- Redguard Lamppost, Stone
    [134922] = strMultiple(strCrown(250), getHouseString(4795)), -- Redguard Pillar, Tiered
    [134923] = strMultiple(strCrown(2000), getHouseString(4795)), -- Redguard Trellis, Peaked
    [134924] = strCrown(380), -- Redguard Fence, Brass Capped
    [134925] = strMultiple(strCrown(2200), getHouseString(4795)), -- Redguard Fountain, Pillar
    [134926] = strMultiple(strCrown(1200), getHouseString(4795)), -- Redguard Awning, Wall
    [134927] = strMultiple(strCrown(1200), getHouseString(4795, 7601)), -- Wedding Pergola, Double
    [134928] = strMultiple(strCrown(1200), getHouseString(4795)), -- Wedding Pergola, Triple
    [134929] = strMultiple(strCrown(45), getHouseString(4795)), -- Trees, Savanna Cluster
    [134930] = strMultiple(strCrown(30), getHouseString(4795)), -- Bushes, Swordgrass Cluster
    [134931] = strMultiple(strCrown(50), getHouseString(4795)), -- Boulder, Weathered Desert
    [134932] = strMultiple(strCrown(50), getHouseString(4795)), -- Boulder, Tiered Desert
    [134933] = strMultiple(strCrown(90), getHouseString(6752, 4794)), -- Cranium, Jawless
    [134934] = strMultiple(strCrown(10), getHouseString(4794)), -- Rocks, Basalt Chunks
    [134936] = strMultiple(strCrown(110), getHouseString(4794)), -- Cave Deposit, Tall Stalagmite Cluster
    [134938] = strMultiple(strCrown(110), getHouseString(4794)), -- Cave Deposit, Stalagmite Group
    [134945] = strMultiple(strCrown(200), getHouseString(4794)), -- Cave Deposit, Extended Spire
    [134973] = strMultiple(strCrown(200), getHouseString(4794)), -- Cave Deposit, Stalactite Cone Cluster
    [134939] = strMultiple(strCrown(110), getHouseString(4794)), -- Cave Deposit, Stalactite Cone
    [134941] = strMultiple(strCrown(110), getHouseString(4794)), -- Cave Deposit, Spire
    [134943] = strMultiple(strCrown(1000), getHouseString(4794)), -- Brotherhood Banner, Long
    [134944] = strCrown(340), -- Brotherhood Column, Tall Ornate
    [134946] = strCrown(340), -- Brotherhood Column, Ornate
    [134951] = strMultiple(strCrown(30), getHouseString(4794)), -- Mushrooms, Assorted Cluster
    [134952] = strMultiple(strCrown(30), getHouseString(4794)), -- Mushrooms, Sporous Browncap
    [134953] = strMultiple(strCrown(340), getHouseString(4794)), -- Brotherhood Carpet, Large Worn
    [126774] = strCrown(510), -- Dres Tapestry, House
    [126775] = strCrown(510), -- Hlaalu Tapestry, House
    [126777] = strCrown(510), -- Redoran Tapestry, House
    [126778] = strCrown(510), -- Telvanni Tapestry, House
    [134974] = strMultiple(strCrown(340), getHouseString(4794)), -- Brotherhood Carpet, Worn
    [134950] = strMultiple(strCrown(30), getHouseString(4794)), -- Mushrooms, Flapjack Stack
    [139389] = strMultiple(strCrown(200), strPack(packs.MEPHALA)), -- Crystal, Crimson Cluster
    [139367] = strMultiple(strCrown(1000), strPack(packs.NOBLEBATH)), -- Regal Sauna Pool, Two Person
    [139650] = strMultiple(strCrown(30), getHouseString(5169, 13882)), -- Bushes, Ivy Cluster
    [139480] = strMultiple(strCrown(30), getHouseString(5169, 13882)), -- Plants, Redtop Grass Tuft
    [139376] = strMultiple(strCrown(260), strPack(packs.NOBLEPARLOUR), getHouseString(5169, 5168)), -- Alinor Banner, Hanging
    [139365] = strCrown(370), -- Psijic Lighting Globe, Framed
    [139361] = strCrown(270), -- Mind Trap Kelp, Young
    [139360] = strCrown(510), -- Mind Trap Kelp, Cluster
    [139359] = strCrown(340), -- Mind Trap Coral Formation, Trees Capped
    [139358] = strCrown(340), -- Mind Trap Coral Formation, Tree Capped
    [139357] = strCrown(340), -- Mind Trap Coral Formation, Tree Antler
    [139356] = strCrown(340), -- Mind Trap Coral Formation, Waving Hands
    [139355] = strCrown(340), -- Mind Trap Coral Formation, Heart
    [139354] = strCrown(340), -- Mind Trap Coral Spire, Bulbous
    [139353] = strCrown(340), -- Mind Trap Coral Spire, Branched
    [139347] = strCrown(45), -- Flowers, Yellow Oleander Cluster
    [139346] = strMultiple(strCrown(45), getHouseString(13882)), -- Flowers, Lizard Tail Patch
    [139345] = strMultiple(strCrown(45), getHouseString(13882)), -- Flowers, Lizard Tail Cluster
    [139344] = strCrown(45), -- Flowers, Hummingbird Mint Cluster
    [139343] = strMultiple(strCrown(45), getHouseString(13882)), -- Tree, Cloud White
    [139342] = strMultiple(strCrown(45), mischouse), -- Tree, Vibrant Pink
    [139341] = strCrown(310), -- Tree, Towering Poplar
    [139340] = strCrown(310), -- Tree, Ancient Summerset Spruce
    [139339] = strMultiple(strCrown(25), getHouseString(5462, 9014)), -- Vines, Sun-Bronzed Ivy Climber
    [139338] = strMultiple(strCrown(25), mischouse), -- Vines, Sun-Bronzed Ivy Swath
    [139337] = strMultiple(strCrown(580), getHouseString(5462, 13882)), -- Tree, Ancient Blooming Ginkgo
    [139336] = strCrown(90), -- Trees, Shade Interwoven
    [139335] = strCrown(310), -- Tree, Shade Ancient
    [139334] = strMultiple(strCrown(20), getHouseString(11172)), -- Coral Formation, Tree Capped (green)
    [139333] = strMultiple(strCrown(45), getHouseString(11172, 5169)), -- Coral Formation, Trees Capped
    [139332] = strMultiple(strCrown(45), strPack(packs.AQUATIC), getHouseString(11172, 5169)), -- Coral Formation, Tree Shelf
    [139331] = strMultiple(strCrown(45), getHouseString(11172, 5169, 10223)), -- Coral Formation, Tree Antler
    [139330] = strMultiple(strCrown(45), getHouseString(11172, 10223)), -- Coral Formation, Waving Hands
    [139329] = strMultiple(strCrown(45), getHouseString(11172)), -- Coral Formation, Heart
    [139328] = strMultiple(strCrown(45), getHouseString(11172, 5169, 10223)), -- Coral Spire, Branched
    [139327] = strMultiple(strCrown(45), getHouseString(11172, 5169)), -- Coral Spire, Sturdy
    [139161] = strMultiple(strCrown(1500), strPack(packs.MEPHALA), getHouseString(6752)), -- Daedric Table, Grand Necropolis
    [139160] = strMultiple(strCrown(200), strPack(packs.MEPHALA)), -- Daedric Armchair, Severe
    [139159] = strMultiple(strCrown(920), strPack(packs.MEPHALA), getHouseString(6752, 10052)), -- Daedric Chandelier, Gruesome
    [139158] = strMultiple(strCrown(150), strPack(packs.MEPHALA), getHouseString(6752)), -- Daedric Candelabra, Tall
    [139156] = strMultiple(strCrown(360), strPack(packs.MEPHALA)), -- Cocoon, Skeleton
    [139155] = strMultiple(strCrown(80), strPack(packs.MEPHALA)), -- Cocoon, Food Storage
    [139154] = strMultiple(strCrown(40), strPack(packs.MEPHALA)), -- Cocoons, Dormant Cluster
    [139153] = strMultiple(strCrown(40), strPack(packs.MEPHALA)), -- Cocoon, Dormant
    [139152] = strMultiple(strCrown(360), strPack(packs.MEPHALA)), -- Cocoon, Enormous Empty
    [139151] = strMultiple(strCrown(140), strPack(packs.MEPHALA)), -- Mushrooms, Shadowpalm Cluster
    [139150] = strMultiple(strCrown(70), strPack(packs.MEPHALA)), -- Mushrooms, Midnight Cluster
    [139149] = strMultiple(strCrown(30), strPack(packs.MEPHALA)), -- Plant, Scarlet Fleshfrond
    [139148] = strMultiple(strCrown(70), strPack(packs.MEPHALA)), -- Mushroom, Nettlecap
    [139147] = strMultiple(strCrown(30), strPack(packs.MEPHALA)), -- Plants, Scarlet Sawleaf
    [139146] = strMultiple(strCrown(490), strPack(packs.MEPHALA)), -- Crystals, Midnight Bloom
    [139145] = strMultiple(strCrown(430), strPack(packs.MEPHALA)), -- Crystals, Midnight Tower
    [139144] = strMultiple(strCrown(400), strPack(packs.MEPHALA)), -- Crystals, Midnight Spire
    [139143] = strMultiple(strCrown(310), strPack(packs.MEPHALA)), -- Crystals, Midnight Cluster
    [139142] = strMultiple(strCrown(380), strPack(packs.MEPHALA)), -- Crystals, Crimson Spikes
    [139141] = strMultiple(strCrown(310), strPack(packs.MEPHALA)), -- Crystals, Crimson Bed
    [139140] = strMultiple(strCrown(340), strPack(packs.MEPHALA)), -- Crystals, Crimson Spray
  },
}

FurC.CrownStore[ver.CLOCKWORK] = {
  [src.CROWN] = {
    [134473] = strCrate(crates.FIREATRO), -- Tapestry,  Malacath
    [134475] = strCrate(crates.FIREATRO), -- Statue of Malacath, Orc-Father
    [134474] = strCrate(crates.FIREATRO), -- Banner, Malacath
    [134258] = strPack(packs.MALACATH), -- Prayer to the Furious One
    [134259] = strPack(packs.MALACATH), -- Malacath, God of Oaths and Curses
    [134260] = strPack(packs.MALACATH), -- Orcish Bas-Relief, Axe
    [134261] = strPack(packs.MALACATH), -- Orcish Bas-Relief, Sword
    [134262] = strPack(packs.MALACATH), -- Orcish Bas-Relief, Spear
    [134251] = strPack(packs.COLDHARBOUR), -- Coldharbour Bookcase, Filled
    [134252] = strPack(packs.COLDHARBOUR), -- Coldharbour Bookcase, Black Laboratory
    [134253] = strPack(packs.COLDHARBOUR), -- Coldharbour Bookcase, Filled Wide
    [134256] = strPack(packs.COLDHARBOUR), -- Coldharbour Bookcase, Filled Pillar
    [134254] = strPack(packs.COLDHARBOUR), -- Seal of Molag Bal
    [134255] = strPack(packs.COLDHARBOUR), -- Transliminal Rupture
    [134257] = strPack(packs.COLDHARBOUR), -- Daedra Dossier: Cold-Flame Atronach
    [134249] = strPack(packs.SOTHA), -- Sotha Sil, The Clockwork God
    [134248] = strPack(packs.SOTHA), -- Grand Mnemograph
    [134246] = strPack(packs.SOTHA), -- The Law of Gears
  },

  [src.EDITOR] = {
    [134278] = strCrown(3500), -- Clockwork Alchemy Station
    [134279] = strCrown(3500), -- Clockwork Blacksmithing Station
    [134282] = strCrown(3500), -- Clockwork Woodworking Station
    [134281] = strCrown(3500), -- Clockwork Clothing Station
    [134277] = strCrown(3000), -- Clockwork Provisioning Station
    [134276] = strCrown(4500), -- Clockwork Dye Station
    [134280] = strCrown(3500), -- Clockwork Enchanting Station
    [134270] = strMultiple(strCrown(85), strPack(packs.MALACATH)), -- Cave Deposit, Large Double-Sided
    [134271] = strMultiple(strCrown(85), strPack(packs.MALACATH)), -- Cave Deposit, Tall Stalagmite
    [134272] = strMultiple(strCrown(10), strPack(packs.MALACATH)), -- Cave Deposit, Stalagmite Cluster
    [134268] = strMultiple(strCrown(570), strPack(packs.MALACATH), getHouseString(1445)), -- Orcish Brazier, Column
    [134269] = strMultiple(strCrown(220), strPack(packs.MALACATH), getHouseString(1445)), -- Orcish Dais, Raised
    [116518] = strMultiple(strCrown(270), strPack(packs.MALACATH)), -- Orcish Drop Hammer, Repeating
    [134267] = strMultiple(strCrown(380), strPack(packs.MALACATH), getHouseString(1445, 10223)), -- Orcish Table, Grand Furs
    [134263] = strMultiple(strCrown(410), strPack(packs.MALACATH), getHouseString(1445)), -- Orcish Throne, Ancient
    [134264] = strMultiple(strCrown(190), strPack(packs.COLDHARBOUR)), -- Daedric Brazier, Cold-Flame
    [134273] = strMultiple(strCrown(200), strPack(packs.COLDHARBOUR), getHouseString(13881)), -- Daedric Plinth, Sacrificial
    [134274] = strMultiple(strCrown(200), strPack(packs.COLDHARBOUR), getHouseString(13881)), -- Coldharbour Crate, Black Soul Gem
    [134275] = strMultiple(strCrown(200), strPack(packs.COLDHARBOUR), getHouseString(13881)), -- Coldharbour Bin, Black Soul Gem
    [134330] = strCrown(490), -- Clockwork Control Panel, Double
    [134337] = strCrown(1800), -- Clockwork Somnolostation, Octet
    [134579] = strMultiple(strCrown(5), getHouseString(1445)), -- Rubble Pile, Worked Stone
    [130082] = strMultiple(strCrown(640), strPack(packs.MOLAG)), -- Soul-Shriven, Robed
    [134326] = strMultiple(strCrown(260), strPack(packs.SOTHA), getHouseString(1446)), -- Clockwork Pump, Horizontal
    [134250] = strMultiple(strCrown(750), strPack(packs.SOTHA), getHouseString(1446)), -- Fabrication Sphere, Inactive
    [134247] = strMultiple(strCrown(190), strPack(packs.SOTHA), getHouseString(1446)), -- Soul Gem Module, Experimental
    [134266] = strMultiple(strCrown(35), strPack(packs.COLDHARBOUR), getHouseString(10052, 6752)), -- Daedric Books, Stacked
    [134265] = strMultiple(strCrown(80), strPack(packs.COLDHARBOUR), getHouseString(10052, 6752)), -- Daedric Books, Piled
    [134373] = strMultiple(strCrown(410), strPack(packs.SOTHA)), -- Clockwork Wall Machinery, Rectangular
    [134374] = strCrown(410), -- Clockwork Wall Machinery, Circular
    [134382] = strCrown(870), -- Fabricant Tree, Beryl Cypress
    [134383] = strCrown(870), -- Fabricant Tree, Towering Maple
    [134385] = strCrown(870), -- Fabricant Tree, Brass Swamp
    [134387] = strCrown(870), -- Fabricant Tree, Tall Cobalt Spruce
    [134388] = strCrown(870), -- Fabricant Tree, Cobalt Oak
    [134384] = strCrown(870), -- Fabricant Tree, Decorative Electrum
    [134386] = strCrown(260), -- Fabricant Tree, Forked Cherry Blossom
    [134389] = strCrown(140), -- Fabricant Tree, Decorative Brass
    [134390] = strCrown(140), -- Clockwork Junk Heap, Large
    [134391] = strMultiple(strCrown(510), getHouseString(1446)), -- Clockwork Sequence Spool, Column
    [134392] = strCrown(260), -- Clockwork Recharging Column, Octet
    [134393] = strMultiple(strCrown(270), strPack(packs.SOTHA), getHouseString(1446)), -- Clockwork Workbench, Spacious
    [134394] = strCrown(460), -- Clockwork Illuminator, Capsule Chandelier
    [134395] = strCrown(150), -- Clockwork Illuminator, Wall Capsule
    [134396] = strCrown(410), -- Clockwork Wall Machinery, Tall
    [134397] = strMultiple(strCrown(410), strPack(packs.SOTHA)), -- Clockwork Wall Machinery, Ovoid
    [134398] = strCrown(1300), -- Clockwork Gazebo, Copper and Basalt
    [134578] = strMultiple(strCrown(110), getHouseString(1445)), -- Ice Floe, Thick
    [134577] = strMultiple(strCrown(50), getHouseString(1445)), -- Ice Floe, Thin
    [134576] = strMultiple(strCrown(190), getHouseString(1445)), -- Orcish Brazier, Snowswept Column
    [134575] = strMultiple(strCrown(50), getHouseString(1445)), -- Boulder, Snowswept Crag
    [134574] = strMultiple(strCrown(50), getHouseString(1445)), -- Boulder, Snowswept Peak
    [134573] = strMultiple(strCrown(5), getHouseString(1445)), -- Stone, Snowswept Shard
    [134572] = strMultiple(strCrown(5), getHouseString(1445)), -- Stones, Snowswept Cluster
    [134571] = strMultiple(strCrown(120), getHouseString(1445)), -- Snow Pile, Large
    [134570] = strMultiple(strCrown(110), strPack(packs.NEWLIFE2018), getHouseString(1445)), -- Snow Pile
    [134569] = strMultiple(strCrown(40), getHouseString(1445)), -- Trees, Snowswept Pair
    [134568] = strMultiple(strCrown(40), getHouseString(1445)), -- Tree, Snowswept Evergreen
    [134567] = strMultiple(strCrown(10), getHouseString(1445, 5756)), -- Bush Cluster, Snowswept
    [134566] = strMultiple(strCrown(30), getHouseString(1445, 5756)), -- Shrub Cluster, Snowswept
    [134565] = strMultiple(strCrown(130), getHouseString(1446)), -- Fabrication Tank, Reinforced
    [134381] = strCrown(110), -- Rocks, Sintered Outcropping
    [134380] = strCrown(110), -- Rocks, Sintered Arch
    [134379] = strCrown(50), -- Boulder, Large Metallic Shard
  },
}

FurC.CrownStore[ver.REACH] = {
  [src.CROWN] = {
    [132204] = getHouseString(1309), -- Imperial Statue, Truth
    [132200] = getHouseString(1309), -- Imperial Well, Akatosh
    [132202] = getHouseString(1309), -- Rock, Anvil Limestone
    [132203] = getHouseString(1309), -- Stone, Anvil Limestone
    [132201] = getHouseString(1309, 13758), -- Tree, Kvatch Nut
    [130228] = strPack(packs.COVEN), -- The Witches of Hag Fen
    [130215] = strPack(packs.COVEN), -- Witches' Cauldron, Provisioning
    [131424] = strPack(packs.COVEN), -- Fogs of the Hag Fen
    [130081] = strPack(packs.MOLAG), -- Soul-Shriven, Armored
    [130083] = strPack(packs.MOLAG), -- Daedric Block, Seat
    [130084] = strPack(packs.MOLAG), -- Daedric Tapestry, Molag Bal
    [130085] = strPack(packs.MOLAG), -- Daedric Banner, Molag Bal
    [130086] = strPack(packs.MOLAG), -- Daedric Pennant, Molag Bal
    [130093] = strPack(packs.MOLAG), -- Coldharbour Compact
    [130087] = strPack(packs.MOLAG), -- Daedric Shards, Coldharbour
    [130091] = strPack(packs.MOLAG), -- Statue of Molag Bal, God of Schemes
    [130088] = strPack(packs.MOLAG), -- Daedric Fragment, Coldharbour
    [130092] = strPack(packs.MOLAG), -- Seal of Molag Bal, Grand
    [130212] = strPack(packs.AYLEID), -- Daedra Worship: The Ayleids
    [130192] = strCrate(crates.REAPER), -- Statue of Sheogorath, the Madgod
    [130190] = strCrate(crates.REAPER), -- Banner of Sheogorath
    [130189] = strCrate(crates.REAPER), -- Tapestry of Sheogorath
  },

  [src.EDITOR] = {
    [118287] = strMultiple(strCrown(85), getHouseString(8697, 1445, 5461)), -- Carcass, Brown Hare
    [118282] = strMultiple(strCrown(85), getHouseString(5461)), -- Carcass, Fresh Goose
    [130211] = strMultiple(strCrown(50), strPack(packs.AYLEID)), -- Books, Ordered Row
    [130210] = strMultiple(strCrown(50), strPack(packs.AYLEID)), -- Books, Scattered Row
    [130226] = strMultiple(strCrown(85), strPack(packs.COVEN), getHouseString(5461, 8697)), -- Carcass, Hanging Deer
    [130220] = strMultiple(strCrown(3300), strPack(packs.COVEN)), -- Hagraven Altar
    [130222] = strMultiple(strCrown(260), strPack(packs.COVEN)), -- Hagraven Totem, Skull
    [131423] = strMultiple(strCrown(750), strPack(packs.COVEN)), -- Mists of the Hag Fen
    [130221] = strMultiple(strCrown(430), strPack(packs.COVEN)), -- Reachmen Cage, Sturdy
    [130216] = strMultiple(strCrown(510), strPack(packs.COVEN)), -- Witches' Basin, Scrying
    [130219] = strMultiple(strCrown(240), strPack(packs.COVEN)), -- Witches' Brazier, Beast Skull
    [130223] = strMultiple(strCrown(340), strPack(packs.COVEN)), -- Reachmen Rug, Mottled Skin
    [130224] = strMultiple(strCrown(180), strPack(packs.COVEN), getHouseString(1310, 1311)), -- Reachmen Rug, Smooth Skin
    [130225] = strMultiple(strCrown(340), strPack(packs.COVEN), getHouseString(10052, 6752)), -- Skulls, Heap
    [130227] = strMultiple(strCrown(850), strPack(packs.COVEN)), -- Witches' Tent, Lean-To
    [130229] = strMultiple(strCrown(290), strPack(packs.COVEN)), -- Tree, Wretched Cypress
    [130230] = strMultiple(strCrown(90), strPack(packs.COVEN)), -- Stump, Wretched Cypress
    [130247] = strMultiple(strCrown(290), strPack(packs.COVEN)), -- Tree, Fetid Cypress
    [130070] = strMultiple(strCrown(2000), strPack(packs.MOLAG), getHouseString(13881)), -- Daedric Spout, Arched
    [130071] = strMultiple(strCrown(300), strPack(packs.MOLAG)), -- Daedric Torch, Coldharbour
    [130075] = strMultiple(strCrown(380), strPack(packs.MOLAG)), -- Daedric Altar, Molag Bal
    [130078] = strMultiple(strCrown(380), strPack(packs.MOLAG), getHouseString(13881)), -- Soul Gem, Single
    [130079] = strMultiple(strCrown(380), strPack(packs.MOLAG)), -- Soul Gems, Pile
    [130094] = strMultiple(strCrown(140), strPack(packs.MOLAG), getHouseString(10052)), -- Daedric Chains, Hanging
    [130095] = strMultiple(strCrown(640), strPack(packs.MOLAG)), -- Daedric Torture Device, Chained
    [130069] = strMultiple(strCrown(2000), strPack(packs.MOLAG)), -- Daedric Spout, Block
    [130070] = strMultiple(strCrown(2000), strPack(packs.MOLAG), getHouseString(13881)), -- Daedric Spout, Arched
    [130080] = strMultiple(strPack(packs.MOLAG), getHouseString(13881)), -- Soul Gems, Scattered
    [130089] = strMultiple(strCrown(360), strPack(packs.MOLAG)), -- Daedric Brazier, Molag Bal
    [130090] = strMultiple(strCrown(310), strPack(packs.MOLAG)), -- Daedric Sconce, Molag Bal
    [132165] = strCrown(750), -- Hlaalu Bath Tub, Empty Basin
    [130207] = strMultiple(strCrown(270), strPack(packs.AYLEID)), -- Ayleid Plinth, Engraved
    [130206] = strMultiple(strCrown(370), strPack(packs.AYLEID)), -- Ayleid Apparatus, Welkynd
    [130205] = strMultiple(strCrown(680), strPack(packs.AYLEID)), -- Ayleid Statue, Pious Priest
    [130204] = strMultiple(strCrown(410), strPack(packs.AYLEID), getHouseString(13560)), -- Welkynd Stones, Glowing
    [130202] = strMultiple(strCrown(170), strPack(packs.AYLEID)), -- Ayleid Grate, Tall
    [130201] = strMultiple(strCrown(170), strPack(packs.AYLEID)), -- Ayleid Grate, Small
    [130199] = strMultiple(strCrown(170), strPack(packs.AYLEID), getHouseString(9014)), -- Ayleid Bookshelf, Short Bare
    [130197] = strMultiple(strCrown(170), strPack(packs.AYLEID), getHouseString(9014)), -- Ayleid Bookcase, Tall Filled
    [131427] = strCrown(1700), -- Orcish Tent, General's
    [131426] = strCrown(680), -- Orcish Tent, Officer's
    [131425] = strCrown(360), -- Orcish Tent, Soldier's
    [130329] = strCrown(240), -- Primal Brazier, Rock Slab
  },
}

FurC.CrownStore[ver.MORROWIND] = {
  [src.CROWN] = {
    [126132] = strCrate(), -- Resplendent Sweetroll
    [125654] = strCrate(crates.DWEMER), -- Tapestry, Clavicus Vile
    [125480] = strCrate(crates.DWEMER), -- Banner, Clavicus Vile
    [126138] = strBundle(bundles.DWEMER), -- A Guide to Dwemer Mega-Structures
    [125516] = strBundle(bundles.DWEMER), -- Dwarven Gear Assembly, Grinding
    [126140] = strPack(packs.VIVEC), -- Vivec's Grand Bed
    [126141] = strPack(packs.VIVEC), -- Vivec's Grand Throne
    [126142] = strPack(packs.VIVEC), -- Vivec's Divination Pool
    [126143] = strPack(packs.VIVEC), -- Statue, Vivec's Triumph
    [126144] = strPack(packs.VIVEC), -- Seal of Vivec
    [126145] = strPack(packs.VIVEC), -- Sigil of Vivec
    [126146] = strPack(packs.VIVEC), -- Banner, Vivec
    [126149] = strPack(packs.VIVEC), -- Tapestry, Vivec
    [126150] = strPack(packs.VIVEC), -- Tribunal Tablet of Sotha Sil
    [126152] = strPack(packs.VIVEC), -- The Cliff-Strider Song
    [125532] = strPack(packs.PIPES), -- Dwarven Pipeline, Fan
    [125537] = strPack(packs.PIPES), -- Dwarven Piston Cylinder
    [125580] = getHouseString(1244), -- Hlaalu Well, Covered Sillar Stone
    [125579] = getHouseString(1243), -- Hlaalu Well, Braced Sillar Stone
    [125577] = getHouseString(1243), -- Hlaalu Wall Post, Sillar Stone
    [125573] = getHouseString(1243, 1244), -- Hlaalu Streetlamp, Paper
    [125568] = getHouseString(1243), -- Hlaalu Sidewalk, Sillar Stone
    [125567] = strMultiple(getHouseString(1244), strBundle(bundles.STABLE)), -- Hlaalu Shed, Open
    [125566] = getHouseString(1243), -- Hlaalu Shed, Enclosed
    [125565] = getHouseString(1244), -- Hlaalu Lantern, Hanging Paper
    [126114] = strPack(packs.AZURA), -- Statue of Azura, Queen of Dawn and Dusk
    [126115] = strPack(packs.AZURA), -- Statue of Azura's Moon
    [126116] = strPack(packs.AZURA), -- Statue of Azura's Sun
    [126118] = strPack(packs.AZURA), -- Banner of Azura
    [125489] = strPack(packs.AZURA), -- Daedric Brazier, Flaming
    [126039] = strCrate(crates.DWEMER), -- Statue of masked Clavicus Vile with Barbas
  },

  [src.EDITOR] = {
    [130213] = strMultiple(strCrown(430), strPack(packs.AYLEID), getHouseString(13560)), -- Ayleid Cage, Hanging
    [125581] = strMultiple(strCrown(25), getHouseString(1245)), -- Mushroom, Buttercake
    [126128] = strMultiple(strPack(packs.AZURA), getHouseString(6752)), -- The Five Points of the Star
    [94157] = strCrown(410), -- Imperial Medallion, Crest
    [125681] = strCrown(50), -- Vines, Volcanic Roses
    [120733] = strMultiple(strCrown(70), getHouseString(1099)), -- Tree, Gnarled Forest
    [125547] = strCrown(85), -- Flower, Healthy Purple Bat Bloom
    [126464] = strMultiple(strCrown(610), getHouseString(1245)), -- Telvanni Painting, Oversized Valley
    [126463] = strMultiple(strCrown(610), getHouseString(1245)), -- Telvanni Painting, Oversized Forest
    [126462] = strMultiple(strCrown(610), getHouseString(1245)), -- Telvanni Painting, Oversized Volcanic
    [126038] = strCrown(5000), -- Target Centurion, Robust Lambent
    [126037] = strCrown(4000), -- Target Centurion, Lambent
    [126034] = strCrown(4000), -- The Lord
    [125461] = strCrown(4000), -- The Lover
    [125460] = strCrown(4000), -- The Mage
    [125459] = strCrown(4000), -- The Ritual
    [125458] = strCrown(4000), -- The Serpent
    [125457] = strCrown(4000), -- The Shadow
    [125456] = strCrown(4000), -- The Steed
    [125455] = strCrown(4000), -- The Thief
    [125454] = strCrown(4000), -- The Tower
    [125453] = strCrown(4000), -- The Warrior
    [125452] = strCrown(4000), -- The Lady
    [125451] = strCrown(4000), -- The Apprentice
    [119556] = strCrown(4000), -- The Atronach
    [126686] = strCrown(400), -- Dwarven Chest, Relic
    [126607] = strMultiple(strCrown(410), getHouseString(1244, 1243)), -- Velothi Painting, Oversized Waterfall
    [126604] = strCrown(410), -- Velothi Panels, Geyser
    [126601] = strMultiple(strCrown(410), getHouseString(1243)), -- Velothi Painting, Oversized Geyser
    [126598] = strCrown(410), -- Velothi Panels, Waterfall
    [126597] = strCrown(410), -- Velothi Painting, Oversized Volcano
    [126592] = strCrown(410), -- Velothi Panels, Volcano
    [126479] = strMultiple(strCrown(310), getHouseString(1245)), -- Telvanni Sconce, Organic Amber
    [126478] = strMultiple(strCrown(560), getHouseString(1245)), -- Telvanni Arched Light, Organic Amber
    [126477] = strMultiple(strCrown(560), getHouseString(1245)), -- Telvanni Streetlight, Organic Amber
    [126476] = strMultiple(strCrown(200), getHouseString(1245)), -- Telvanni Lamp, Organic Amber
    [126475] = strMultiple(strCrown(260), getHouseString(1245)), -- Telvanni Lantern, Organic Amber
    [125628] = strCrown(70), -- Plant, Rosetted Sundew
    [125610] = strMultiple(strCrown(25), getHouseString(11223, 11525)), -- Mushrooms, Cave Bracket Cluster
    [125607] = strMultiple(strCrown(10), getHouseString(11223, 12732, 11525)), -- Mushroom, Young Netch Shield
    [125605] = strCrown(10), -- Mushroom, Young Erupted Stinkcap
    [125603] = strCrown(50), -- Mushroom, Stinkhorn Spore
    [125555] = strCrown(85), -- Flowers, Sullen Purple Bat Blooms
    [125554] = strCrown(85), -- Flowers, Opposing Purple Bat Blooms
    [125550] = strMultiple(strCrown(85), getHouseString(12732, 11223, 1245)), -- Flowers, Lava Blooms
    [125549] = strCrown(85), -- Flowers, Double Purple Bat Blooms
    [125548] = strCrown(85), -- Flower, Towering Purple Bat Bloom
    [125545] = strMultiple(strCrown(30), getHouseString(11525, 11223)), -- Fern, Young Dusky
    [125484] = strMultiple(strCrown(30), getHouseString(11525, 11223, 1243)), -- Bush, Lush Laurel
    [125482] = strCrown(50), -- Boulder, Volcanic Crag
    [120465] = strMultiple(strCrown(5), getHouseString(14078, 1095)), -- Stone, Tapered Rough
  },
}

FurC.CrownStore[ver.HOMESTEAD] = {
  [src.CROWN] = {
    [118663] = getHouseString(1078, 1079), -- Dark Elf Bed of Coals
    [126117] = strPack(packs.AZURA), -- Tapestry of Azura
    [121004] = getHouseString(1309), -- Hedge, Solid Arc
    [117887] = getHouseString(10051), -- Redguard Tuffet, Sands
    [121004] = getHouseString(1309), -- Hedge, Solid Arc
    [94181] = getHouseString(6752), -- Imperial Throne of the Bay
    [121007] = strPack(packs.TREES), -- Tree, Strong Maple
    [121008] = strPack(packs.TREES), -- Tree, Autumn Maple
    [121013] = strPack(packs.TREES), -- Saplings, Fragile Autumn Birch
    [121016] = strPack(packs.TREES), -- Bush, Red Berry
    [121022] = strPack(packs.TREES), -- Bush, Green Forest
    [117908] = getHouseString(1100), -- Redguard Candlestick, Twisted
    [117843] = getHouseString(1094), -- Redguard Bed, Wide Lattice
    [117902] = getHouseString(14077), -- Redguard Pot, Gilded
    [118128] = getHouseString(1445), -- Pelt, Hanging
    [119576] = getHouseString(4795), -- Palm Tree Cluster
    [117906] = strPack(packs.CRAGKNICKS), -- Redguard Urn, Gilded
  },

  [src.EDITOR] = {
    [118148] = strMultiple(strCrown(80), mischouse), -- Firelogs, Ashen
    [118146] = strMultiple(strCrown(80), mischouse), -- Firelogs, Flaming
    [118147] = strMultiple(strCrown(80), mischouse), -- Firelogs, Charred
    [118350] = strMultiple(strCrown(25), mischouse), -- Box of Tangerines
    [118352] = strMultiple(strCrown(25), mischouse), -- Box of Oranges
    [118482] = strMultiple(strCrown(25), mischouse), -- Book Stack, Tall
    [118353] = strMultiple(strCrown(25), getHouseString(1095)), -- Box of Grapes
    [118354] = strMultiple(strCrown(25), mischouse), -- Box of Fruit
    [118175] = strCrown(170), -- Shutters, Hinged Lattice
    [118174] = strCrown(170), -- Shutters, Blue Lattice
    [118173] = strCrown(170), -- Shutters, Blue Hinged
    [118172] = strCrown(170), -- Shutters, Blue Slatted
    [118171] = strCrown(170), -- Shutters, Blue Hatch
    [118170] = strCrown(170), -- Shutters, Blue Double
    [118169] = strCrown(170), -- Shutters, Blue Single
    [94100] = strMultiple(strCrown(50), strPack(packs.CRAGPARLOUR), srcLvlup, mischouse), -- Imperial BookCase, Swirled
    [117901] = strMultiple(strCrown(140), strPack(packs.HUBTREASURE), getHouseString(7601, 10051)), -- Redguard Amphora, Gilded
    [117894] = strMultiple(strCrown(240), strPack(packs.CRAGBED), strPack(packs.HUBTREASURE), mischouse), -- Redguard Divider, Gilded
    [117904] = strMultiple(strCrown(190), strPack(packs.CRAGBED), strPack(packs.HUBTREASURE)), -- Redguard Trunk, Garish
    [121053] = strMultiple(strCrown(170), strPack(packs.CRAGKNICKS), strPack(packs.HUBTREASURE)), -- Jar, Gilded Canopic
    [121046] = strMultiple(strCrown(30), strPack(packs.CRAGKNICKS), mischouse), -- Cheeses of Tamriel
    [118490] = strMultiple(strCrown(55), strPack(packs.CRAGKNICKS), mischouse), -- Scroll, Rolled
    [94163] = strMultiple(strCrown(290), strPack(packs.DIBELLA), mischouse), -- Imperial Bench, Scrollwork
    [119587] = strMultiple(strCrown(10), getHouseString(1066)), -- Auridon Coneplants, Cluster
    [118347] = strCrown(20), -- Bread, Various Loaves
    [118344] = strMultiple(strCrown(20), getHouseString(7601)), -- Breads, Assortment
    [118162] = strMultiple(strCrown(340), getHouseString(13060, 11456)), -- Carpet of the Desert Flame, Faded
    [118167] = strMultiple(strCrown(340), getHouseString(13060, 11456)), -- Carpet of the Desert Flame, Faded
    [118166] = strMultiple(strCrown(340), getHouseString(13060)), -- Carpet of the Desert, Faded
    [118161] = strCrown(340), -- Carpet of the Mirage, Faded
    [118159] = strMultiple(strCrown(340), getHouseString(14078, 11456)), -- Carpet of the Oasis, Faded
    [118158] = strMultiple(strCrown(340), getHouseString(14078, 11456)), -- Carpet of the Sun, Faded Summer
    [118043] = strCrown(25), -- Common Torch, Holder
    [118261] = strCrown(25), -- Cushion, Faded Yellow
    [118260] = strCrown(25), -- Cushion, Faded Blue
    [118259] = strMultiple(strCrown(25), getHouseString(10051)), -- Cushion, Faded Red
    [94091] = strMultiple(strCrown(95), getHouseString(1309, 4794)), -- Imperial Carpet, Arkay
    [94092] = strMultiple(strCrown(95), getHouseString(1309, 1086)), -- Imperial Carpet, Kyne
    [94093] = strCrown(95), -- Imperial Carpet, Stendarr
    [94094] = strMultiple(strCrown(140), getHouseString(1086)), -- Imperial Banner, Arkay
    [94095] = strCrown(140), -- Imperial Banner, Kyne
    [94096] = strMultiple(strCrown(140), getHouseString(1085)), -- Imperial Banner, Stendarr
    [94097] = strMultiple(strCrown(95), getHouseString(1086, 5756)), -- Imperial Bed, Bunk
    [94099] = strMultiple(strCrown(60), getHouseString(9014, 6140)), -- Imperial Dresser, Short
    [94101] = strMultiple(strCrown(45), mischouse), -- Imperial Chair, Slatted
    [94102] = strMultiple(strCrown(120), mischouse), -- Imperial Rack, Cask
    [94103] = strMultiple(strCrown(60), mischouse), -- Imperial Dresser, Open
    [94104] = strMultiple(strCrown(40), mischouse), -- Imperial Stool, Sturdy
    [94105] = strMultiple(strCrown(95), getHouseString(4794, 6140)), -- Imperial Table, Family
    [94106] = strMultiple(strCrown(95), getHouseString(5756)), -- Imperial Desk, Sturdy
    [94107] = strMultiple(strCrown(50), mischouse), -- Imperial Table, Common
    [94108] = strMultiple(strCrown(50), mischouse), -- Imperial Shelf, Wall
    [94109] = strMultiple(strCrown(50), mischouse), -- Imperial Lantern, Wall
    [94110] = strMultiple(strCrown(110), mischouse), -- Imperial Lightpost, Stone
    [94111] = strMultiple(strCrown(95), getHouseString(5756)), -- Imperial Well, Grated
    [94112] = strCrown(70), -- Imperial Pedestal, Stone
    [94113] = strCrown(70), -- Imperial Basin, Stone
    [94114] = strCrown(430), -- Imperial Statue, Monolith
    [94115] = strCrown(430), -- Imperial Statue, Obelisk
    [115083] = strMultiple(strCrown(220), getHouseString(1309, 4794, 12656)), -- Imperial Rug, Arkay
    [94118] = strCrown(220), -- Imperial Rug, Kynareth
    [94119] = strMultiple(strCrown(220), mischouse), -- Imperial Rug, Stars
    [94120] = strCrown(220), -- Imperial Rug, Stendarr
    [94129] = strCrown(220), -- Imperial Tapestry, Arkay
    [94130] = strCrown(220), -- Imperial Tapestry, Kynareth
    [94131] = strCrown(220), -- Imperial Tapestry, Stendarr
    [94132] = strMultiple(strCrown(150), getHouseString(6140)), -- Imperial Brazier, Firepot
    [94133] = strMultiple(strCrown(150), mischouse), -- Imperial Bed, Four-Poster
    [94134] = strCrown(220), -- Imperial Bed, Double
    [94135] = strMultiple(strCrown(160), mischouse), -- Imperial Pew, Windowed
    [94136] = strMultiple(strCrown(160), mischouse), -- Imperial Bench, Fitted
    [94137] = strMultiple(strCrown(110), mischouse), -- Imperial Bookcase, Scrollwork
    [94138] = strMultiple(strCrown(100), getHouseString(6140, 1085)), -- Imperial Chair, Rocking
    [94139] = strMultiple(strCrown(100), mischouse), -- Imperial Chair, Windowed
    [94140] = strMultiple(strCrown(85), mischouse), -- Imperial Chest, Sturdy
    [94141] = strMultiple(strCrown(120), mischouse), -- Imperial Hutch, Scrollwork
    [94142] = strMultiple(strCrown(120), getHouseString(5756, 1309)), -- Imperial Cupboard, Scrollwork
    [94143] = strMultiple(strCrown(180), mischouse), -- Imperial Chest of Drawers
    [94144] = strMultiple(strCrown(220), mischouse), -- Imperial Counter, Long Cabinet
    [94145] = strMultiple(strCrown(110), mischouse), -- Imperial Shelf, Barrel
    [94146] = strMultiple(strCrown(220), mischouse), -- Imperial Desk, Swirled
    [94147] = strMultiple(strCrown(220), mischouse), -- Imperial Table, Dining
    [94148] = strMultiple(strCrown(220), getHouseString(9014)), -- Imperial Trestle, Sturdy
    [94149] = strMultiple(strCrown(85), mischouse), -- Imperial Table, Game
    [94150] = strMultiple(strCrown(220), mischouse), -- Imperial Table, Kitchen
    [94151] = strMultiple(strCrown(220), mischouse), -- Imperial Lightpost, Pair
    [94152] = strCrown(240), -- Imperial Lightpost, Single
    [94153] = strCrown(220), -- Imperial Well, Arched
    [94154] = strCrown(160), -- Imperial Basin, Heavy
    [94155] = strCrown(1000), -- Imperial Tent, Commander's
    [94156] = strCrown(290), -- Imperial Brazier, Caged
    [94158] = strCrown(410), -- Imperial Tapestry, Stars
    [94159] = strCrown(450), -- Imperial Streetlight, Imperial City
    [94161] = strMultiple(strCrown(310), getHouseString(1084, 1086)), -- Imperial Pedestal, Chiseled
    [94162] = strMultiple(strCrown(290), mischouse), -- Imperial Pew, Scrollwork
    [94163] = strMultiple(strCrown(290), strPack(packs.DIBELLA), mischouse), -- Imperial Bench, Scrollwork
    [94164] = strMultiple(strCrown(220), mischouse), -- Imperial Sideboard, Scrollwork
    [94165] = strMultiple(strCrown(200), mischouse), -- Imperial Chair, Scrollwork
    [94166] = strMultiple(strCrown(220), mischouse), -- Imperial Armchair, Scrollwork
    [94167] = strMultiple(strCrown(220), mischouse), -- Imperial Cabinet, Scrollwork
    [94168] = strMultiple(strCrown(220), mischouse), -- Imperial Curio, Scrollwork
    [94169] = strMultiple(strCrown(160), getHouseString(1309)), -- Imperial Coffer, Scrollwork
    [94170] = strMultiple(strCrown(270), mischouse), -- Imperial Dresser, Scrollwork
    [94171] = strMultiple(strCrown(240), mischouse), -- Imperial Counter, Corner
    [94172] = strMultiple(strCrown(490), mischouse), -- Imperial Bar, Cabinet
    [94173] = strMultiple(strCrown(200), mischouse), -- Imperial Mirror, Standing
    [94174] = strMultiple(strCrown(120), mischouse), -- Imperial Nightstand, Scrollwork
    [94175] = strMultiple(strCrown(200), mischouse), -- Imperial Divider, Folding
    [94176] = strMultiple(strCrown(200), mischouse), -- Imperial Divider, Curved
    [94177] = strMultiple(strCrown(170), mischouse), -- Imperial Stool, Padded
    [94178] = strMultiple(strCrown(410), getHouseString(6140)), -- Imperial Desk, Scrollwork
    [94179] = strMultiple(strCrown(410), mischouse), -- Imperial Table, Formal
    [94180] = strMultiple(strCrown(410), getHouseString(6140, 1086)), -- Imperial Trestle, Scrollwork
    [94182] = strMultiple(strCrown(160), mischouse), -- Imperial Footlocker, Scrollwork
    [94183] = strMultiple(strCrown(350), mischouse), -- Imperial Wardrobe, Scrollwork
    [94184] = strMultiple(strCrown(240), mischouse), -- Imperial Wine Rack, Scrollwork
    [94185] = strCrown(450), -- Imperial Lightpost, Full
    [94187] = strCrown(410), -- Imperial Well, Covered
    [94188] = strCrown(410), -- Imperial Carpet, Gilded Dibella
    [94189] = strMultiple(strCrown(410), getHouseString(1309, 12656)), -- Imperial Carpet, Verdant Dibella
    [94190] = strCrown(410), -- Imperial Rug, Dibella
    [94191] = strCrown(410), -- Imperial Tapestry, Dibella
    [94192] = strMultiple(strCrown(610), getHouseString(1309)), -- Imperial Banner, Dibella
    [94193] = strCrown(410), -- Imperial Pillar, Straight
    [94194] = strCrown(410), -- Imperial Pillar, Chipped
    [94195] = strMultiple(strCrown(410), mischouse), -- Imperial Bed, Canopy
    [94196] = strMultiple(strCrown(410), getHouseString(1309)), -- Imperial Cradle, Scrollwork
    [94197] = strCrown(610), -- Imperial Shrine of the Bay
    [94198] = strCrown(610), -- Imperial Altar of the Bay
    [94200] = strCrown(1000), -- Imperial Fountain of the Bay
    [94201] = strMultiple(strCrown(820), getHouseString(12732)), -- Imperial Statue, Knight
    [94202] = strMultiple(strCrown(820), getHouseString(12732)), -- Imperial Statue, Emperor
    [94203] = strMultiple(strCrown(820), getHouseString(12732)), -- Imperial Statue, Warrior
    [118160] = strCrown(340), -- Mat of Meditation, Faded
    [118164] = strCrown(340), -- Mat of the Sunset, Faded
    [118163] = strCrown(340), -- Mat of the Oasis, Faded
    [118165] = strCrown(340), -- Mat of the Sunrise, Faded
    [115421] = strMultiple(strCrown(110), getHouseString(5461)), -- Nord Sconce, Torch
    [118244] = strMultiple(strCrown(340), mischouse), -- Orc Rug, Echatere Skin
    [118131] = strMultiple(strCrown(180), mischouse), -- Pelt, Bear
    [118107] = strMultiple(strCrown(40), strPack(packs.NOBLEKIT), getHouseString(1081)), -- Pie, Display
    [120603] = strMultiple(strCrown(20), getHouseString(1074)), -- Boulder, Flat Mossy
    [120604] = strMultiple(strCrown(20), getHouseString(1074)), -- Rock, Slanted Mossy
    [120605] = strMultiple(strCrown(20), getHouseString(1074)), -- Rocks, Deep Mossy
    [120606] = strMultiple(strCrown(20), getHouseString(1074)), -- Stones, Mossy Cluster
    [120612] = strMultiple(strCrown(10), getHouseString(1074)), -- Plant, Tall Mammoth Ear
    [120613] = strMultiple(strCrown(10), getHouseString(1074)), -- Plant, Towering Mammoth Ear
    [120614] = strMultiple(strCrown(10), getHouseString(1074, 13759)), -- Plant Cluster, Jungle Leaf
    [121036] = strMultiple(strCrown(30), getHouseString(13758)), -- Shrub, Sparse Violet
    [121035] = strMultiple(strCrown(30), getHouseString(12655, 12732)), -- Plant, Paired Verdant Hosta
    [121034] = strMultiple(strCrown(10), getHouseString(14586)), -- Shrub, Delicate Forest
    [121032] = strMultiple(strCrown(25), getHouseString(13758)), -- Saplings, Young Laurel
    [121031] = strMultiple(strCrown(45), getHouseString(1309)), -- Topiary, Paired Cypress
    [121030] = strCrown(45), -- Topiary, Young Cypress
    [121029] = strMultiple(strCrown(45), getHouseString(1309, 5462)), -- Topiary, Strong Cypress
    [120709] = strMultiple(strCrown(70), getHouseString(1097)), -- Tree, Sturdy Young Birch
    [121026] = strMultiple(strCrown(45), getHouseString(1309, 13078)), -- Hedge, Dense High Wall
    [121025] = strMultiple(strCrown(70), mischouse), -- Trees, Sprawling Juniper Cluster
    [121024] = strMultiple(strCrown(70), getHouseString(11456)), -- Trees, Paired Leaning Juniper
    [121021] = strMultiple(strCrown(10), strPack(packs.TREES)), -- Plants, Dry Underbrush
    [121020] = strMultiple(strCrown(10), strPack(packs.TREES), getHouseString(1097, 1310)), -- Plants, Sparse Underbrush
    [121018] = strMultiple(strCrown(10), strPack(packs.TREES)), -- Plant, Forest Sprig
    [121014] = strMultiple(strCrown(20), strPack(packs.TREES), getHouseString(14586)), -- Topiary, Sparse
    [121012] = strMultiple(strCrown(10), strPack(packs.TREES)), -- Trees, Fragile Autumn Birch
    [121009] = strMultiple(strCrown(70), strPack(packs.TREES)), -- Tree, Young Healthy Birch
    [120726] = strMultiple(strCrown(20), getHouseString(1099, 12732)), -- Rock, Jagged Algae Coated
    [120727] = strMultiple(strCrown(5), getHouseString(1099)), -- Stone, Angled Mossy
    [120728] = strMultiple(strCrown(5), getHouseString(1099)), -- Rock, Jagged Lichen
    [121006] = strMultiple(strCrown(45), getHouseString(9735)), -- Flower Patch, Violets
    [120730] = strMultiple(strCrown(45), getHouseString(1099, 12732)), -- Topiary, Lush Evergreen
    [120731] = strMultiple(strCrown(25), getHouseString(1099)), -- Tree, Mossy Summer
    [120732] = strMultiple(strCrown(70), getHouseString(1099)), -- Tree, Mossy Forest
    [120734] = strMultiple(strCrown(25), getHouseString(1099)), -- Saplings, Squat Desert
    [120735] = strMultiple(strCrown(25), mischouse), -- Saplings, Young Desert
    [120736] = strMultiple(strCrown(290), getHouseString(1099)), -- Tree, Gentle Weeping Willow
    [120737] = strMultiple(strCrown(150), getHouseString(1099)), -- Tree, Weeping Willow
    [120738] = strMultiple(strCrown(70), getHouseString(1099)), -- Tree, Towering Willow
    [120743] = strMultiple(strCrown(70), getHouseString(1099)), -- Tree, Strong Cypress
    [120996] = strMultiple(strCrown(120), getHouseString(1094)), -- Banner, Tattered Red
    [120745] = strMultiple(strCrown(60), mischouse), -- Tree, Water Palm
    [120483] = strMultiple(strCrown(30), getHouseString(1095, 14078)), -- Cactus, Lemon Bulbs
    [120748] = strMultiple(strCrown(70), getHouseString(1099)), -- Tree, Leaning Swamp
    [120749] = strMultiple(strCrown(10), getHouseString(1099)), -- Grass, Tall Bamboo Shoots
    [120750] = strMultiple(strCrown(10), getHouseString(1099)), -- Grass, Drying Bamboo Shoots
    [120751] = strMultiple(strCrown(10), getHouseString(1099)), -- Grass, Twin Bamboo Shoots
    [120752] = strMultiple(strCrown(10), getHouseString(1099)), -- Grass, Young Bamboo Shoots
    [120471] = strMultiple(strCrown(25), getHouseString(14078, 1095)), -- Tree, Wilted Palm
    [120756] = strMultiple(strCrown(10), getHouseString(12732, 1099)), -- Plant, Palm Fronds
    [120463] = strMultiple(strCrown(20), getHouseString(14078, 1095)), -- Boulder, Weathered Flat
    [120456] = strMultiple(strCrown(5), getHouseString(1093)), -- Stone, Smooth Desert
    [120760] = strMultiple(strCrown(50), getHouseString(1099, 12270)), -- Flower, Red Honeysuckle
    [125546] = strMultiple(strCrown(85), getHouseString(1245)), -- Flower Patch, Lava Blooms
    [120765] = strMultiple(strCrown(15), strPack(packs.JESTER), mischouse), -- Breton Cup, Empty
    [120766] = strMultiple(strCrown(15), getHouseString(1097)), -- Breton Cup, Full
    [118491] = strMultiple(strCrown(55), mischouse), -- Scroll, Bound
    [118145] = strMultiple(strCrown(410), mischouse), -- Painting of a Desert, Refined
    [118144] = strMultiple(strCrown(410), mischouse), -- Painting of a Forest, Refined
    [118142] = strMultiple(strCrown(410), mischouse), -- Painting of Swamp, Refined
    [118140] = strMultiple(strCrown(410), mischouse), -- Painting of a Waterfall, Refined
    [118138] = strMultiple(strCrown(410), mischouse), -- Painting of Mountains, Refined
    [121400] = strCrown(2000), -- Target Skeleton, Robust Argonian
    [121399] = strCrown(2000), -- Target Skeleton, Robust Khajiit
    [121056] = strMultiple(strCrown(25), mischouse), -- Book Stack, Decorative
    [121054] = strCrown(30), -- Breton Mug, Empty
    [121053] = strMultiple(strCrown(170), strPack(packs.HUBTREASURE)), -- Jar, Gilded Canopic
    [121052] = strMultiple(strCrown(100), getHouseString(1095)), -- Vase, Gilded Offering
    [121047] = strMultiple(strCrown(25), mischouse), -- Book Row, Long
    [121045] = strMultiple(strCrown(25), mischouse), -- Book Row, Decorative
    [121044] = strMultiple(strCrown(30), getHouseString(14587, 12732, 12655)), -- Plant, Healthy White Hosta
    [121043] = strMultiple(strCrown(30), getHouseString(4795, 12732, 12655)), -- Plant, Summer Hosta
    [121042] = strMultiple(strCrown(10), getHouseString(12655)), -- Plant, Young Summer Hosta
    [121041] = strMultiple(strCrown(10), getHouseString(12655)), -- Plant, Young Verdant Hosta
    [121040] = strMultiple(strCrown(30), getHouseString(14587, 12655)), -- Plant, Verdant Hosta
    [121039] = strMultiple(strCrown(30), getHouseString(5168, 12655)), -- Plant, Blooming White Hosta
    [121038] = strMultiple(strCrown(30), getHouseString(14587, 12655)), -- Plant, Paired White Hosta
    [121037] = strCrown(30), -- Shrub, Sparse Pink
    [121033] = strMultiple(strCrown(25), getHouseString(13758, 1309)), -- Sapling, Sparse Laurel
    [121027] = strMultiple(strCrown(45), getHouseString(1309)), -- Hedge, Dense Low Arc
    [121019] = strMultiple(strCrown(10), strPack(packs.TREES), getHouseString(1310, 14586)), -- Plants, Dense Underbrush
    [121017] = strMultiple(strCrown(10), strPack(packs.TREES)), -- Bush, Dense Forest
    [121002] = strMultiple(strCrown(45), strPack(packs.TREES)), -- Flowers, Violet Prairie
    [121001] = strMultiple(strCrown(45), strPack(packs.TREES)), -- Flowers, Golden Prairie
    [120491] = strMultiple(strCrown(30), getHouseString(14078, 1095)), -- Fern, Hearty Autumn
    [120486] = strMultiple(strCrown(30), getHouseString(14078, 1095, 1093)), -- Cactus, Stocky Columnar
    [120484] = strMultiple(strCrown(30), getHouseString(14078, 1095)), -- Cactus, Golden Barrel
    [120482] = strMultiple(strCrown(30), getHouseString(14078, 1095, 1093)), -- Cactus, Golden Bulbs
    [120481] = strMultiple(strCrown(150), mischouse), -- Tree, Ancient Juniper
    [120475] = strMultiple(strCrown(70), mischouse), -- Trees, Paired Wax Palms
    [120473] = strCrown(60), -- Sapling, Thin Palm
    [120472] = strMultiple(strCrown(25), getHouseString(14078, 1095, 14077)), -- Tree, Young Palm
    [120470] = strMultiple(strCrown(25), getHouseString(14078, 1095)), -- Tree, Leaning Palm
    [120466] = strMultiple(strCrown(5), getHouseString(14078, 1095)), -- Pebble, Stacked Desert
    [120464] = strMultiple(strCrown(20), mischouse), -- Rocks, Stacked Cracked
    [120427] = strCrown(1500), -- Target Skeleton, Argonian
    [120426] = strCrown(1500), -- Target Skeleton, Khajiit
    [120420] = strMultiple(strCrown(140), getHouseString(1088, 14586, 7601)), -- Plaque, Bolted Deer Antlers
    [120416] = strMultiple(strCrown(40), mischouse), -- Common Cloak on a Hook
    [120415] = strMultiple(strCrown(30), getHouseString(1097, 1076)), -- Breton Tankard, Full
    [120414] = strMultiple(strCrown(30), getHouseString(1097)), -- Breton Tankard, Empty
    [120413] = strMultiple(strCrown(30), getHouseString(1098)), -- Breton Pitcher, Clay
    [120412] = strMultiple(strCrown(50), getHouseString(1077)), -- Noble's Chalice
    [120409] = strCrown(100), -- Argonian Rack, Woven
    [120408] = strMultiple(strCrown(25), getHouseString(1071)), -- Argonian Fish in a Basket
    [120607] = strMultiple(strCrown(50), getHouseString(1074)), -- Sapling, Lanky Ash
    [118351] = strMultiple(strCrown(25), mischouse), -- Box of Peaches
    [118278] = strMultiple(strCrown(140), strPack(packs.CRAGPARLOUR), getHouseString(7600)), -- Plaque, Bordered Deer Antlers
    [118126] = strCrown(95), -- Plaque, Standard
    [118121] = strCrown(10), -- Knife, Carving
    [118120] = strMultiple(strCrown(120), getHouseString(12731)), -- Minecart, Push
    [118119] = strMultiple(strCrown(120), getHouseString(12731)), -- Minecart, Empty
    [118118] = strMultiple(strCrown(100), getHouseString(6752)), -- Candles, Lasting
    [118098] = strMultiple(strCrown(10), mischouse), -- Common Bowl, Serving
    [118096] = strMultiple(strCrown(10), mischouse), -- Bread, Plain
    [118071] = strCrown(120), -- Simple Red Banner
    [118070] = strCrown(120), -- Simple Purple Banner
    [118069] = strCrown(120), -- Simple Gray Banner
    [118068] = strCrown(120), -- Simple Brown Banner
    [118066] = strCrown(15), -- Steak Dinner
    [118065] = strMultiple(strCrown(45), mischouse), -- Common Cargo Crate, Dry
    [118064] = strMultiple(strCrown(45), mischouse), -- Common Barrel, Dry
    [118062] = strMultiple(strCrown(15), mischouse), -- Chicken Meal, Display
    [118061] = strMultiple(strCrown(15), mischouse), -- Chicken Dinner, Display
    [118060] = strMultiple(strCrown(20), mischouse), -- Sack of Grain
    [118059] = strMultiple(strCrown(20), mischouse), -- Sack of Millet
    [118058] = strMultiple(strCrown(20), mischouse), -- Sack of Rice
    [118057] = strMultiple(strCrown(20), mischouse), -- Sack of Beans
    [118056] = strCrown(15), -- Common Stewpot, Hanging
    [118055] = strMultiple(strCrown(80), mischouse), -- Common Firepit, Piled
    [118054] = strMultiple(strCrown(80), mischouse), -- Common Firepit, Outdoor
    [118000] = strMultiple(strCrown(10), getHouseString(1067, 1099)), -- Garlic String, Display
    [117952] = strMultiple(strCrown(35), getHouseString(1310, 1074)), -- Rough Torch, Wall
    [117881] = strMultiple(strCrown(70), getHouseString(14078, 7601)), -- Redguard Pillow, Lattice Sands
    [117882] = strMultiple(strCrown(70), strPack(packs.CRAGBED), getHouseString(14078)), -- Redguard Pillow, Florid Sands
    [117885] = strMultiple(strCrown(70), strPack(packs.CRAGBED)), -- Redguard Pillow Roll, Sands
    [117886] = strMultiple(strCrown(70), getHouseString(7601)), -- Redguard Throw Pillow, Sands
    [117899] = strMultiple(strCrown(190), getHouseString(14078, 14077)), -- Redguard Chest, Crested
    [117941] = strMultiple(strCrown(15), mischouse), -- Rough Broom, Practical
    [117897] = strMultiple(strCrown(480), strPack(packs.CRAGPARLOUR), mischouse), -- Redguard Mat, Sun
    [117893] = strMultiple(strCrown(190), strPack(packs.CRAGBED), getHouseString(4795)), -- Redguard Footlocker, Bolted
    [117896] = strMultiple(strCrown(290), strPack(packs.CRAGKNICKS), getHouseString(1095, 7601)), -- Redguard Wine Rack, Bolted
    [119970] = strMultiple(strCrown(1400), strPack(packs.CRAGKITCHEN)), -- Redguard Round Table
    [117891] = strMultiple(strCrown(250), strPack(packs.CRAGKITCHEN), mischouse), -- Redguard Armchair, Lattice
    [117892] = strMultiple(strCrown(230), strPack(packs.CRAGBED), mischouse), -- Redguard Chair, Lattice
    [118264] = strMultiple(strCrown(65), getHouseString(11456)), -- Tuffet, Faded Yellow
    [118252] = strCrown(25), -- Pillow, Faded Yellow Floral
    [118248] = strCrown(25), -- Pillow, Faded Yellow
    [118258] = strCrown(25), -- Pillow Roll, Faded Yellow
    [118263] = strCrown(65), -- Tuffet, Faded Blue
    [118262] = strMultiple(strCrown(65), getHouseString(11456)), -- Tuffet, Faded Red
    [118127] = strMultiple(strCrown(95), getHouseString(1098)), -- Plaque, Small
    [118257] = strCrown(25), -- Pillow Roll, Faded Blue
    [118256] = strCrown(25), -- Pillow Roll, Faded Red
    [118255] = strCrown(25), -- Pillow, Faded Blue Floral
    [118254] = strCrown(25), -- Pillow, Faded Purple Floral
    [118253] = strCrown(25), -- Pillow, Faded Red Floral
    [118251] = strMultiple(strCrown(25), getHouseString(7601)), -- Pillow, Faded Blue
    [118250] = strCrown(25), -- Pillow, Faded Purple
    [118249] = strCrown(25), -- Pillow, Faded Red
    [118174] = strCrown(170), -- Shutters, Blue Lattice
    [115395] = strCrown(40), -- Nord Drinking Horn, Display
    [121010] = strMultiple(strPack(packs.TREES), getHouseString(1087, 1097, 1089)), -- Tree, Young Green Birch
    [121015] = strMultiple(strPack(packs.TREES), getHouseString(14586)), -- Shrub, Sparse Green
    [121023] = strMultiple(strPack(packs.TREES), getHouseString(1309)), -- Tree, Strong Olive
    [116420] = strCrown(1200), -- Orcish Throne, Pedestal
    [117843] = getHouseString(1094), -- Redguard Bed, Wide Lattice
    [117902] = getHouseString(14077), -- Redguard Pot, Gilded
    [117903] = strMultiple(strPack(packs.CRAGPARLOUR), strCrown(140)), -- Redguard Vessel, Gilded
    [118117] = strCrown(340), -- Table, Carved
    [118156] = strCrown(340), -- Runner of the Oasis, Faded
    [118157] = strMultiple(strCrown(340), getHouseString(13060, 11456)), -- Runner of the Sun, Faded
    [118075] = strCrown(270), -- Banner, War
    [118076] = strCrown(270), -- Banner, Forge
    [118077] = strMultiple(strCrown(270), getHouseString(1445)), -- Banner, Forceful
    [118078] = strCrown(270), -- Banner, Mighty
    [118079] = strMultiple(strCrown(270), getHouseString(1445)), -- Banner, Crafting
    [118350] = strMultiple(strCrown(25), mischouse), -- Box of Tangerines
    [118352] = strMultiple(strCrown(25), mischouse), -- Box of Oranges
    [118353] = strMultiple(strCrown(25), getHouseString(1095)), -- Box of Grapes
    [118354] = strMultiple(strCrown(25), getHouseString(14078, 11456, 5462)), -- Box of Fruit
    [118482] = strMultiple(strCrown(25), mischouse), -- Book Stack, Tall
    [118125] = strCrown(95), -- Plaque, Large
    [118137] = strCrown(70), -- Podium, Engraved
    [118111] = strCrown(50), -- Steak, Display
    [118112] = strMultiple(strCrown(25), mischouse), -- Teapot, Common
    [117925] = strMultiple(strCrown(30), getHouseString(1310, 5169)), -- Rough Cot, Military
    [117962] = strMultiple(strCrown(30), getHouseString(1311)), -- Rough Bedroll, Rolled
    [117927] = strMultiple(strCrown(15), mischouse), -- Rough Barrel, Sturdy
    [117932] = strMultiple(strCrown(15), mischouse), -- Rough Tray, Sturdy
    [117933] = strMultiple(strCrown(15), mischouse), -- Rough Bin, Sturdy
    [117934] = strMultiple(strCrown(15), mischouse), -- Rough Carton, Sturdy
    [117935] = strMultiple(strCrown(10), mischouse), -- Rough Pouch, Burlap
    [117938] = strMultiple(strCrown(10), mischouse), -- Rough Sack, Burlap
    [117936] = strMultiple(strCrown(10), mischouse), -- Rough Pouch, Coarse Cloth
    [117948] = strMultiple(strCrown(10), mischouse), -- Rough Candle, Tealight
    [117949] = strMultiple(strCrown(10), mischouse), -- Rough Candle, Pillar
    [120997] = strMultiple(strCrown(120), getHouseString(1094)), -- Banner, Tattered Blue
    [117944] = strCrown(5), -- Rough Fork, Common
    [117946] = strCrown(5), -- Rough Knife, Butter
    [117947] = strMultiple(strCrown(5), getHouseString(1078)), -- Rough Spoon, Common
    [117951] = strMultiple(strCrown(35), mischouse), -- Rough Torch, Basic
    [121049] = strMultiple(strPack(packs.CRAGKNICKS), mischouse), -- Parcels, Wrapped
    [120417] = strMultiple(strPack(packs.CRAGKNICKS), mischouse), -- Redguard Barrel, Corded
    [115698] = strCrown(1100), -- Khajiit Statue, Guardian
    [94098] = strMultiple(strCrown(95), strGeneric(srcLvlup), mischouse), -- Imperial Bed, Single
    [87709] = strMultiple(strCrown(65), strGeneric(srcLvlup)), -- Imperial Brazier, Spiked
  },
}
