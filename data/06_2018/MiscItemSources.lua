FurC.MiscItemSources        = FurC.MiscItemSources or {}

-- Local imports for performance
local zo_strformat          = zo_strformat
local GetString             = GetString

-- constants save performance on string handling
local questRewardString     = GetString(SI_FURC_QUESTREWARD)

local pickpocket_ww         = GetString(SI_FURC_CANBEPICKED) .. " from woodworkers"
local pickpocket_ass        = GetString(SI_FURC_CANBEPICKED) .. " from outlaws and assassins"
local pickpocket_guard      = GetString(SI_FURC_CANBEPICKED) .. " from guards"

local stealable             = GetString(SI_FURC_CANBESTOLEN)

local stealable_cc          = stealable .. " in Clockwork City"
local stealable_scholars    = stealable .. " from scholars"
local stealable_nerds       = stealable_scholars .. " and mages"
local stealable_priests     = stealable .. " from priests and pilgrims"
local stealable_thief       = stealable .. " from thieves"
local stealable_woodworkers = stealable .. " from woodworkers"
local stealable_drunkards   = stealable .. " from drunkards"

local automaton_loot_cc     = GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local automaton_loot_vv     = GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"

local harvest_coldharbour   = GetString(SI_FURC_HARVEST) .. " in Coldharbour"

local scambox_string        = GetString(SI_FURC_SCAMBOX)

local scambox_fireatro      = zo_strformat("<<1>> (<<2>>)", scambox_string, GetString(SI_FURC_FLAME_ATRONACH))
local scambox_dwemer        = zo_strformat("<<1>> (<<2>>)", scambox_string, GetString(SI_FURC_DWEMER))
local scambox_reaper        = zo_strformat("<<1>> (<<2>>)", scambox_string, GetString(SI_FURC_REAPER))

local db_poison             = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local db_sneaky             = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))
local db_equip              = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_EQUIP))

local sinister_hollowjack   = "Sinister Hollowjack Items"

local itemPackNewLife2018   = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "New Life Festival")
local itemPackDeepmire      = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Deepmire Expedition")
local itemPackDwemer        = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Dwemer")
local itemPackVivec         = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Lord Vivec")
local itemPackSwamp         = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Shadow and Stone")
local itemPackMolag         = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Molag Bal")
local itemPackAyleid        = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Ayleid")
local itemPackAquatic       = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Aquatic Splendor")
local itemPackSotha         = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "The Clockwork God's Domain")

local onSummerset           = " on Summerset"
local backwaterSwamp        = " in Murkmire"
local gloriousHome          = " on Vvardenfell"
local inWrothgar            = " in Wrothgar"

local puplicdungeon_fw_vv   = GetString(SI_FURC_DROP) .. " in Forgotten Wastes" .. gloriousHome
local plants_vvardenfell    = GetString(SI_FURC_PLANTS) .. gloriousHome

local fishing_summerset     = GetString(SI_FURC_CANBEFISHED) .. onSummerset
local fishing_swamp         = GetString(SI_FURC_CANBEFISHED) .. backwaterSwamp

local drop_altmer           = GetString(SI_FURC_DROP) .. onSummerset
local drop_swamp            = GetString(SI_FURC_DROP) .. backwaterSwamp
local painting_summerset    = GetString(SI_FURC_ITEMSOURCE_SAFEBOX) .. " (Summerset)"

local stealable_wrothgar    = stealable .. inWrothgar
local stealable_swamp       = stealable .. backwaterSwamp

local rumourSource          = GetString(SI_FURC_RUMOUR_SOURCE_ITEM)
local dataminedUnclear      = GetString(SI_FURC_DATAMINED_UNCLEAR)

local crownstoresource      = GetString(SI_FURC_CROWNSTORESOURCE)
local function getCrownPrice(price)
  return string.format("%s (%u)", crownstoresource, price)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2)
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then houseName = houseName .. ", " .. GetCollectibleName(houseId2) end
  return zo_strformat(housesource, houseName)
end

FurC.MiscItemSources[FURC_WOTL]      = {
  [FURC_RUMOUR] = {
    [147591] = rumourSource, -- Namira, Mistress of Decay,
    [140297] = rumourSource, -- Replica Throne of Alinor,
    [130189] = rumourSource, -- Tapestry of Sheogorath,
    [130190] = rumourSource, -- Banner of Sheogorath,
    [134287] = rumourSource, -- Projector TBD,
    [147600] = rumourSource, -- Tapestry of Namira,
    [130193] = rumourSource, -- Robust Target Minotaur Handler,
    [130194] = rumourSource, -- Target Stone Atronach,
    [130195] = rumourSource, -- Target Iron Atronach,
    [120852] = rumourSource, -- Holding Cell,
    [146069] = rumourSource, -- Target Voriplasm,
    [120856] = rumourSource, -- Yokudan Sarcophagus,
    [120858] = rumourSource, -- Yokudan Tapestry,
    [120860] = rumourSource, -- Yokudan Throne,
    [120861] = rumourSource, -- Yokudan Sitting Griffin Statue,
    [130080] = rumourSource, -- Soul Gems, Scattered,
    [130081] = rumourSource, -- Soul-Shriven, Armored,
    [130083] = rumourSource, -- Daedric Block, Seat,
    [130084] = rumourSource, -- Daedric Tapestry, Molag Bal,
    [130085] = rumourSource, -- Daedric Banner, Molag Bal,
    [130086] = rumourSource, -- Daedric Pennant, Molag Bal,
    [130087] = rumourSource, -- Daedric Shards, Coldharbour,
    [120872] = rumourSource, -- Daedric Pike, Daedroth Head,
    [130089] = rumourSource, -- Daedric Brazier, Molag Bal,
    [120874] = rumourSource, -- Daedric Coffin, Lid,
    [130091] = rumourSource, -- Statue of Molag Bal, God of Schemes,
    [120880] = rumourSource, -- Tombstone, Engraved, Decorative,
    [120881] = rumourSource, -- Tombstone, Engraved, Order of the Hour,
    [120882] = rumourSource, -- Tombstone, Small,
    [147636] = rumourSource, -- Banner of Hermaeus Mora,
    [147638] = rumourSource, -- Replica Cursed Orb of Meridia,
    [147642] = rumourSource, -- Boar Totem, Balance,
    [147643] = rumourSource, -- Boar Totem, Solitary,
    [147644] = rumourSource, -- Palisade, Crude,
    [147645] = rumourSource, -- Dwarven Tonal Arc,
    [147647] = rumourSource, -- Dwarven Centurion Blade, Detached,
    [132166] = rumourSource, -- Death Skeleton, Robed,
    [134474] = rumourSource, -- Banner, Malacath,
    [147599] = rumourSource, -- Banner of Namira,
    [120857] = rumourSource, -- Yokudan Sarcophagus Lid,
    [147573] = rumourSource, -- Barricade, Bladed Hurdle,
    [132197] = rumourSource, -- Death Skeleton, Shrouded,
    [134246] = rumourSource, -- The Law of Gears,
    [147572] = rumourSource, -- Barricade, Bladed Fence,
    [132200] = rumourSource, -- Imperial Well, Akatosh,
    [132201] = rumourSource, -- Tree, Kvatch Nut,
    [132202] = rumourSource, -- Rock, Anvil Limestone,
    [132203] = rumourSource, -- Stone, Anvil Limestone,
    [132204] = rumourSource, -- Imperial Statue, Truth,    ,
  },
}

FurC.MiscItemSources[FURC_SLAVES]    = {
  [FURC_RUMOUR]  = {
    [145446] = rumourSource, -- Sithis, the Hungering Dark
    [145449] = rumourSource, -- Stele, Hist Guardians
    [145450] = rumourSource, -- Stele, Hist Cultivation
    [145451] = rumourSource, -- Shrine, Sithis Figure Anointed
    [145452] = rumourSource, -- Shrine, Sithis Looming Anointed
    [145453] = rumourSource, -- Plant, Marsh Aloe
    [145454] = rumourSource, -- Plant, Marsh Aloe Pod
    [145455] = rumourSource, -- Plant, Dendritic Hist Bulb
    [145456] = rumourSource, -- Plant, Hist Bulb
    [145457] = rumourSource, -- Tree, Banyan
    [145458] = rumourSource, -- Tree, Huge Ancient Banyan
    [145467] = rumourSource, -- The Way of Shadow
    [145491] = rumourSource, -- Static Pitcher
    [145492] = rumourSource, -- Gas Blossom
    [145493] = rumourSource, -- Lantern Mantis
    [145554] = rumourSource, -- Tree, Towering Snowy Fir
    [145555] = rumourSource, -- Tree, Snowy Fir
    [145576] = rumourSource, -- Timid Vine-Tongue
    [145556] = rumourSource, -- Tree, Tall Snowy Fir
  },

  [FURC_JUSTICE] = {
    [145399] = stealable_swamp,                                  -- Murkmire Rug, Crawling Serpents Worn
    [145400] = stealable_swamp,                                  -- Murkmire Rug, Lurking Lizard Worn
    [145398] = stealable_swamp,                                  -- Murkmire Rug, Supine Turtle Worn
    [145397] = stealable_swamp,                                  -- Murkmire Rug, Hist Gathering Worn
    [145396] = stealable_swamp,                                  -- Murkmire Tapestry, Hist Gathering Worn
    [145550] = stealable_swamp .. " or random mobs in Murkmire", -- Murkmire Hunting Lure, Grisly
    [145401] = stealable_swamp,                                  -- Murkmire Tapestry, Xanmeer Worn
    [145403] = stealable_swamp,                                  -- Jel Parchment
  },

  [FURC_DROP]    = {
    [141856] = sinister_hollowjack,                                                                          -- Decorative Hollowjack Daedra-Skull
    [141855] = sinister_hollowjack,                                                                          -- Decorative Hollowjack Wraith-Lantern
    [141854] = sinister_hollowjack,                                                                          -- Decorative Hollowjack Flame-Skull
    [141870] = sinister_hollowjack,                                                                          -- Raven-Perch Cemetery Wreath
    [141875] = sinister_hollowjack,                                                                          -- Witches Festival Scarecrow
    [139157] = sinister_hollowjack,                                                                          -- Webs, Thick Sheet
    [139162] = sinister_hollowjack,                                                                          -- Webs, Cone
    [141939] = sinister_hollowjack,                                                                          -- Grave, Grasping
    [141965] = sinister_hollowjack,                                                                          -- Hollowjack Lantern, Soaring Dragon
    [141966] = sinister_hollowjack,                                                                          -- Hollowjack Lantern, Toothy Grin
    [141967] = sinister_hollowjack,                                                                          -- Hollowjack Lantern, Ouroboros
    [142004] = sinister_hollowjack,                                                                          -- Specimen Jar, Spare Brain
    [142005] = sinister_hollowjack,                                                                          -- Specimen Jar, Monstrous Remains
    [142003] = sinister_hollowjack,                                                                          -- Specimen Jar, Eyes
    [120877] = sinister_hollowjack,                                                                          -- Gravestone, Cracked
    [120876] = sinister_hollowjack,                                                                          -- Gravestone, Imp Engraving
    [120875] = sinister_hollowjack,                                                                          -- Gravestone, Clover Engraving
    [141778] = sinister_hollowjack,                                                                          -- Target Wraith-of-Crows

    [145923] = "Part of the achievement item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold", -- Lies of the Dread-Father
    [145926] = "Part of the achievement item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold", -- That of Void
    [145927] = "Part of the achievement item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold", -- Acts of Honoring
    [145928] = "Part of the achievement item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold", -- Speakers of Nothing
    [145597] = "Part of the achievement item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold", -- Scales of Shadow
  },

  [FURC_CROWN]   = {
    [146048] = itemPackNewLife2018,                              -- New Life Festive Fir
    [146049] = itemPackNewLife2018,                              -- Winter Festival Hearth
    [146050] = itemPackNewLife2018,                              -- Winter Festival Hearthfire
    [146052] = itemPackNewLife2018,                              -- Vvardvark Ice Sculpture
    [146053] = itemPackNewLife2018,                              -- Guar Ice Sculpture
    [146059] = itemPackNewLife2018,                              -- New Life Snowmortal, Khajiit
    [146057] = itemPackNewLife2018,                              -- New Life Snowmortal, Human
    [146058] = itemPackNewLife2018,                              -- New Life Snowmortal, Argonian
    [146060] = itemPackNewLife2018,                              -- New Life Ladle
    [146062] = itemPackNewLife2018,                              -- Winter Ouroboros Wreath
    [146061] = itemPackNewLife2018,                              -- New Life Triptych Banner
    [146055] = itemPackNewLife2018,                              -- New Life Garland Wreath
    [146056] = itemPackNewLife2018,                              -- New Life Cookies and Ale
    [146047] = itemPackNewLife2018,                              -- From Old Life To New
    [146051] = itemPackNewLife2018,                              -- Mudcrab Ice Sculpture
    [146054] = itemPackNewLife2018,                              -- New Life Garland

    [145427] = itemPackDeepmire,                                 -- Serpent Skull, Colossal
    [145447] = getCrownPrice(260) .. " or " .. itemPackSwamp,    -- Murkmire Dais, Engraved

    [145428] = getCrownPrice(65) .. " or " .. itemPackDeepmire,  -- Murkmire Lantern Post, Covered
    [145437] = getCrownPrice(240) .. " or " .. itemPackDeepmire, -- Reed Felucca, Double Hulled
    [145431] = getCrownPrice(35) .. " or " .. itemPackDeepmire,  -- Plant, Marsh Nigella
    [145432] = getCrownPrice(70) .. " or " .. itemPackDeepmire,  -- Plant, Canna Lily
    [145434] = getCrownPrice(110) .. " or " .. itemPackDeepmire, -- Plant, Large Inert Lantern Flower
    [145439] = getCrownPrice(140) .. " or " .. itemPackDeepmire, -- Grave Stake, Large Fearsome
    [145438] = getCrownPrice(140) .. " or " .. itemPackDeepmire, -- Grave Stake, Large Glyphed
    [145440] = getCrownPrice(140) .. " or " .. itemPackDeepmire, -- Grave Stake, Large Skull
    [145441] = getCrownPrice(140) .. " or " .. itemPackDeepmire, -- Grave Stake, Large Serpent
    [145442] = getCrownPrice(140) .. " or " .. itemPackDeepmire, -- Grave Stake, Large Twinned
    [145436] = itemPackDeepmire,                                 -- Canopied Felucca, Double Hulled
    [145443] = getCrownPrice(270) .. " or " .. itemPackDeepmire, -- Murkmire Shrine, Sithis Looming
    [145445] = itemPackDeepmire,                                 -- The Sharper Tongue: A Jel Primer
    [145461] = getCrownPrice(30) .. " or " .. itemPackDeepmire,  -- Plant Cluster, Cardinal Flower
    [145433] = getCrownPrice(60) .. " or " .. itemPackDeepmire,  -- Plant, Rafflesia
    [145426] = getCrownPrice(410) .. " or " .. itemPackDeepmire, -- Murkmire Felucca, Canopied
    [145435] = getCrownPrice(110) .. " or " .. itemPackDeepmire, -- Plant, Marsh Mani Flower
    [146073] = getCrownPrice(70) .. " or " .. itemPackDeepmire,  -- Plant Cluster, Marsh Nigella,
    [145430] = getCrownPrice(55) .. " or " .. itemPackDeepmire,  -- Plant, Star Blossom

    [145429] = getCrownPrice(65),                                -- Plant Cluster, Bounteous Flower Large
    [145459] = getCrownPrice(90),                                -- Murkmire Kiln, Ancient Stone
    [145460] = getCrownPrice(30),                                -- Plant, Canna Leaves
    [145411] = getCrownPrice(410),                               -- Plant, Luminous Lantern Flower
    [145462] = getCrownPrice(40),                                -- Plant, Cardinal Flower
    [145463] = getCrownPrice(35),                                -- Plant Cluster, Red Sister Ti
    [145464] = getCrownPrice(30),                                -- Plant, Red Sister Ti
    [145465] = getCrownPrice(40),                                -- Plant Cluster, Wilted Hist Bulb
    [145466] = getCrownPrice(30),                                -- Plant, Wilted Hist Bulb
    [141869] = getCrownPrice(150),                               -- Alinor Potted Plant, Cypress
    [141976] = getCrownPrice(60),                                -- Pumpkin Patch, Display
    [141853] = getCrownPrice(2500),                              -- Statue of Hircine's Bitter Mercy
    [145448] = getCrownPrice(1000),                              -- Murkmire Throne, Engraved
    [145444] = getCrownPrice(130),                               -- Murkmire Totem, Hist Guardian

    [145322] = getCrownPrice(800),                               -- Music Box, Blood and Glory

    [134248] = itemPackSotha,                                    -- Grand Mnemograph
    [134249] = itemPackSotha,                                    -- Sotha Sil, The Clockwork God
    [134246] = itemPackSotha,                                    -- The Law of Gears
    [134250] = getCrownPrice(750),                               -- Fabrication Sphere, Inactive
    [134326] = getCrownPrice(260),                               -- Clockwork Pump, Horizontal
  },

  [FURC_FISHING] = {
    -- fishing
    [145402] = fishing_swamp, -- Fish, Black Marsh
  },
}

FurC.MiscItemSources[FURC_WEREWOLF]  = {
  [FURC_RUMOUR] = {
    [141853] = dataminedUnclear, -- Statue of Hircine's Bitter Mercy

    [120873] = dataminedUnclear, -- Daedric Coffin
    [120871] = dataminedUnclear, -- Deadric Vase, Spiked
    [120867] = dataminedUnclear, -- Daedric Pike, Clannfear Head
    [120866] = dataminedUnclear, -- Daedric Brazier, Tabletop
    [120865] = dataminedUnclear, -- Daedric Table
    [120863] = dataminedUnclear, -- Daedric Light Pillar

    [120985] = dataminedUnclear, -- Dark Elf Lightpost, Single
    [120987] = dataminedUnclear, -- Dark Elf Lightpost, Capped

    [126132] = dataminedUnclear, -- Resplendent Sweetroll
    [121015] = dataminedUnclear, -- Shrub, Sparse Green

    [134475] = dataminedUnclear, -- Statue of Malacath, Orc-Father

    [134686] = dataminedUnclear, -- Sithis, The Dread Father
    [125480] = dataminedUnclear, -- Banner, Clavicus Vile
    [125489] = dataminedUnclear, -- Daedric Brazier, Flaming

    [134853] = dataminedUnclear, -- Peryite, The Taskmaster
    [134854] = dataminedUnclear, -- Tapestry of Peryite
    [134855] = dataminedUnclear, -- Banner of Peryite
    [125654] = dataminedUnclear, -- Tapestry, Clavicus Vile

    [126771] = dataminedUnclear, -- Velothi Podium of Illumination
    [126776] = dataminedUnclear, -- Indoril Tapestry, House
    [126107] = dataminedUnclear, -- Display Wild Hunt Crown Crate

    [125592] = dataminedUnclear, -- Mushroom, Lavaburster

    [121023] = dataminedUnclear, -- Tree, Strong Olive
    [121022] = dataminedUnclear, -- Bush, Green Forest
    [121016] = dataminedUnclear, -- Bush, Red Berry
    [121013] = dataminedUnclear, -- Saplings, Fragile Autumn Birch
    [121010] = dataminedUnclear, -- Tree, Young Green Birch
    [121008] = dataminedUnclear, -- Tree, Autumn Maple
    [121007] = dataminedUnclear, -- Tree, Strong Maple

    [121004] = dataminedUnclear, -- Hedge, Solid Arc
    [121000] = dataminedUnclear, -- Shrub, Trimmed Green
    [126109] = dataminedUnclear, -- Display Death Crown Crate
    [126108] = dataminedUnclear, -- Display Atronach Crown Crate
    [120986] = dataminedUnclear, -- Dark Elf Lightpost, Full
    [132198] = dataminedUnclear, -- Death Skeleton, Wrapped
    [134823] = dataminedUnclear, -- Target Mournful Aegis
    [125537] = dataminedUnclear, -- Dwarven Piston Cylinder
    [125532] = dataminedUnclear, -- Dwarven Pipeline, Fan
    [120862] = dataminedUnclear, -- Ancient Patriarch Banner
    [120859] = dataminedUnclear, -- Yokudan Wall Embellishment
    [120855] = dataminedUnclear, -- Collected Wanted Poster
    [120854] = dataminedUnclear, -- Guard Lamppost
  },

  [FURC_DROP] = {
    [141851] = GetString(SI_FURC_WW_DUNGEON_DROP),  -- Bear Skull, Fresh
    [141850] = GetString(SI_FURC_WW_DUNGEON_DROP),  -- Bear Skeleton, Picked Clean
    [141847] = GetString(SI_FURC_WW_DUNGEON_DROP),  -- Animal Bones, Gnawed
    [141848] = GetString(SI_FURC_WW_DUNGEON_DROP),  -- Animal Bones, Jumbled
    [141849] = GetString(SI_FURC_WW_DUNGEON_DROP),  -- Animal Bones, Fresh

    [141921] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Bowl, Geometric Pattern

    [141923] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Amphora, Seed Pattern
    [141922] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Dish, Geometric Pattern
    [141924] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Vase, Scale Pattern
    [141925] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Hearth Shrine, Sithis Relief
    [141926] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Hearth Shrine, Sithis Figure
    [141920] = GetString(SI_FURC_SLAVES_DAILY),     -- Murkmire Brazier, Ceremonial

    [147639] = GetString(SI_FURC_DoM_DUNGEON_DROP), -- Magna-Geode
    [147640] = GetString(SI_FURC_DoM_DUNGEON_DROP), -- Magna-Geode, Large
    [147641] = GetString(SI_FURC_DoM_DUNGEON_DROP), -- Garlas Alpinia, Tall
  },

  [FURC_CROWN] = {
    [141836] = getCrownPrice(170),                             -- Monolith, Lord Hircine Ritual
    [141843] = getCrownPrice(30),                              -- Plants, Yellow Frond Cluster
    [125681] = getCrownPrice(50),                              -- Vines, Volcanic Roses
    [134921] = getCrownPrice(520),                             -- Redguard Lamppost, Stone
    [134922] = getCrownPrice(250),                             -- Redguard Pillar, Tiered
    [134923] = getCrownPrice(2000),                            -- Redguard Trellis, Peaked
    [134924] = getCrownPrice(380),                             -- Redguard Fence, Brass Capped
    [134925] = getCrownPrice(2200),                            -- Redguard Fountain, Pillar
    [134926] = getCrownPrice(1200),                            -- Redguard Awning, Wall
    [134927] = getCrownPrice(1200),                            -- Wedding Pergola, Double
    [134928] = getCrownPrice(1200),                            -- Wedding Pergola, Triple
    [134929] = getCrownPrice(45),                              -- Trees, Savanna Cluster
    [134930] = getCrownPrice(30),                              -- Bushes, Swordgrass Cluster
    [134931] = getCrownPrice(50),                              -- Boulder, Weathered Desert
    [134932] = getCrownPrice(50),                              -- Boulder, Tiered Desert
    [134933] = getCrownPrice(90),                              -- Cranium, Jawless
    [134934] = getCrownPrice(10),                              -- Rocks, Basalt Chunks
    [134936] = getCrownPrice(110),                             -- Cave Deposit, Tall Stalagmite Cluster
    [134938] = getCrownPrice(110),                             -- Cave Deposit, Stalagmite Group
    [134945] = getCrownPrice(200),                             -- Cave Deposit, Extended Spire
    [134973] = getCrownPrice(200),                             -- Cave Deposit, Stalactite Cone Cluster
    [134939] = getCrownPrice(110),                             -- Cave Deposit, Stalactite Cone
    [134941] = getCrownPrice(110),                             -- Cave Deposit, Spire
    [120603] = getCrownPrice(20),                              -- Boulder, Flat Mossy
    [120604] = getCrownPrice(20),                              -- Rock, Slanted Mossy
    [120605] = getCrownPrice(20),                              -- Rocks, Deep Mossy
    [120606] = getCrownPrice(20),                              -- Stones, Mossy Cluster
    [134943] = getCrownPrice(1000),                            -- Brotherhood Banner, Long
    [134944] = getCrownPrice(340),                             -- Brotherhood Column, Tall Ornate
    [134946] = getCrownPrice(340),                             -- Brotherhood Column, Ornate
    [120612] = getCrownPrice(10),                              -- Plant, Tall Mammoth Ear
    [120613] = getCrownPrice(10),                              -- Plant, Towering Mammoth Ear
    [120614] = getCrownPrice(10),                              -- Plant Cluster, Jungle Leaf
    [134951] = getCrownPrice(30),                              -- Mushrooms, Assorted Cluster
    [134952] = getCrownPrice(30),                              -- Mushrooms, Sporous Browncap
    [134953] = getCrownPrice(340),                             -- Brotherhood Carpet, Large Worn
    [126774] = getCrownPrice(510),                             -- Dres Tapestry, House
    [126775] = getCrownPrice(510),                             -- Hlaalu Tapestry, House
    [126777] = getCrownPrice(510),                             -- Redoran Tapestry, House
    [126778] = getCrownPrice(510),                             -- Telvanni Tapestry, House
    [134974] = getCrownPrice(340),                             -- Brotherhood Carpet, Worn
    [126830] = getCrownPrice(10),                              -- Mushrooms, Volcanic Cluster
    [120631] = getCrownPrice(5),                               -- Pebble, Stacked Mossy
    [134330] = getCrownPrice(490),                             -- Clockwork Control Panel, Double
    [134337] = getCrownPrice(1800),                            -- Clockwork Somnolostation, Octet
    [121036] = getCrownPrice(30),                              -- Shrub, Sparse Violet
    [121035] = getCrownPrice(30),                              -- Plant, Paired Verdant Hosta
    [121034] = getCrownPrice(10),                              -- Shrub, Delicate Forest
    [121032] = getCrownPrice(25),                              -- Saplings, Young Laurel
    [121031] = getCrownPrice(45),                              -- Topiary, Paired Cypress
    [121030] = getCrownPrice(54),                              -- Topiary, Young Cypress
    [121029] = getCrownPrice(45),                              -- Topiary, Strong Cypress
    [120709] = getCrownPrice(70),                              -- Tree, Sturdy Young Birch
    [121026] = getCrownPrice(45),                              -- Hedge, Dense High Wall
    [121025] = getCrownPrice(70),                              -- Trees, Sprawling Juniper Cluster
    [121024] = getCrownPrice(70),                              -- Trees, Paired Leaning Juniper
    [121021] = getCrownPrice(10),                              -- Plants, Dry Underbrush
    [121020] = getCrownPrice(10),                              -- Plants, Sparse Underbrush
    [121018] = getCrownPrice(10),                              -- Plant, Forest Sprig
    [121014] = getCrownPrice(20),                              -- Topiary, Sparse
    [121012] = getCrownPrice(70),                              -- Trees, Fragile Autumn Birch
    [121009] = getCrownPrice(70),                              -- Tree, Young Healthy Birch
    [120726] = getCrownPrice(20),                              -- Rock, Jagged Algae Coated
    [120727] = getCrownPrice(5),                               -- Stone, Angled Mossy
    [120728] = getCrownPrice(20),                              -- Rock, Jagged Lichen
    [121006] = getCrownPrice(45),                              -- Flower Patch, Violets
    [120730] = getCrownPrice(45),                              -- Topiary, Lush Evergreen
    [120731] = getCrownPrice(25),                              -- Tree, Mossy Summer
    [120732] = getCrownPrice(70),                              -- Tree, Mossy Forest
    [120733] = getCrownPrice(70),                              -- Tree, Gnarled Forest
    [120734] = getCrownPrice(25),                              -- Saplings, Squat Desert
    [120735] = getCrownPrice(52),                              -- Saplings, Young Desert
    [120736] = getCrownPrice(290),                             -- Tree, Gentle Weeping Willow
    [120737] = getCrownPrice(150),                             -- Tree, Weeping Willow
    [120738] = getCrownPrice(70),                              -- Tree, Towering Willow
    [120743] = getCrownPrice(70),                              -- Tree, Strong Cypress
    [120996] = getCrownPrice(120),                             -- Banner, Tattered Red
    [120745] = getCrownPrice(60),                              -- Tree, Water Palm
    [120483] = getCrownPrice(30),                              -- Cactus, Lemon Bulbs
    [120748] = getCrownPrice(70),                              -- Tree, Leaning Swamp
    [120749] = getCrownPrice(10),                              -- Grass, Tall Bamboo Shoots
    [120750] = getCrownPrice(10),                              -- Grass, Drying Bamboo Shoots
    [120751] = getCrownPrice(10),                              -- Grass, Twin Bamboo Shoots
    [120752] = getCrownPrice(10),                              -- Grass, Young Bamboo Shoots
    [120471] = getCrownPrice(25),                              -- Tree, Wilted Palm
    [120756] = getCrownPrice(10),                              -- Plant, Palm Fronds
    [120463] = getCrownPrice(20),                              -- Boulder, Weathered Flat
    [120456] = getCrownPrice(5),                               -- Stone, Smooth Desert
    [134579] = getCrownPrice(5),                               -- Rubble Pile, Worked Stone
    [120760] = getCrownPrice(50),                              -- Flower, Red Honeysuckle
    [125544] = getCrownPrice(30),                              -- Fern, Strong Dusky
    [125547] = getCrownPrice(85),                              -- Flower, Healthy Purple Bat Bloom
    [125546] = getCrownPrice(85),                              -- Flower Patch, Lava Blooms
    [120765] = getCrownPrice(15),                              -- Breton Cup, Empty
    [120766] = getCrownPrice(15),                              -- Breton Cup, Full
    [134950] = getCrownPrice(31),                              -- Mushrooms, Flapjack Stack
    [139238] = getCrownPrice(190),                             -- Alinor Wall Mirror, Ornate
    [139239] = getCrownPrice(190),                             -- Alinor Wall Mirror, Verdant
    [139389] = getCrownPrice(200),                             -- Crystal, Crimson Cluster
    [139184] = getCrownPrice(200),                             -- Alinor Plinth, Sarcophagus

    [130093] = itemPackMolag,                                  -- Coldharbour Compact
    [130071] = getCrownPrice(300) .. " or " .. itemPackMolag,  -- Daedric Torch, Coldharbour
    [130075] = getCrownPrice(380) .. " or " .. itemPackMolag,  -- Daedric Altar, Molag Bal
    [130078] = getCrownPrice(380) .. " or " .. itemPackMolag,  -- Soul Gem, Single
    [130079] = getCrownPrice(380) .. " or " .. itemPackMolag,  -- Soul Gems, Pile
    [130082] = getCrownPrice(640) .. " or " .. itemPackMolag,  -- Soul-Shriven, Robed
    [130094] = getCrownPrice(140) .. " or " .. itemPackMolag,  -- Daedric Chains, Hanging
    [130095] = getCrownPrice(640) .. " or " .. itemPackMolag,  -- Daedric Torture Device, Chained
    [130069] = getCrownPrice(2000) .. " or " .. itemPackMolag, -- Daedric Spout, Block
    [130070] = getCrownPrice(2000) .. " or " .. itemPackMolag, -- Daedric Spout, Arched
    [130080] = itemPackMolag,                                  -- Soul Gems, Scattered
    [130081] = itemPackMolag,                                  -- Soul-Shriven, Armored
    [130083] = itemPackMolag,                                  -- Daedric Block, Seat
    [130084] = itemPackMolag,                                  -- Daedric Tapestry, Molag Bal
    [130085] = itemPackMolag,                                  -- Daedric Banner, Molag Bal
    [130086] = itemPackMolag,                                  -- Daedric Pennant, Molag Bal
    [130089] = getCrownPrice(360) .. " or " .. itemPackMolag,  -- Daedric Brazier, Molag Bal
    [130087] = itemPackMolag,                                  -- Daedric Shards, Coldharbour
    [130091] = itemPackMolag,                                  -- Statue of Molag Bal, God of Schemes
    [130090] = getCrownPrice(310) .. " or " .. itemPackMolag,  -- Daedric Sconce, Molag Bal
    [130088] = itemPackMolag,                                  -- Daedric Fragment, Coldharbour
    [130092] = itemPackMolag,                                  -- Seal of Molag Bal, Grand

    [126138] = itemPackDwemer,                                 -- A Guide to Dwemer Mega-Structures
    [125516] = itemPackDwemer,                                 -- Dwarven Gear Assembly, Grinding

    [126140] = itemPackVivec,                                  -- Vivec's Grand Bed
    [126141] = itemPackVivec,                                  -- Vivec's Grand Throne
    [126142] = itemPackVivec,                                  -- Vivec's Divination Pool
    [126143] = itemPackVivec,                                  -- Statue, Vivec's Triumph
    [126144] = itemPackVivec,                                  -- Seal of Vivec
    [126145] = itemPackVivec,                                  -- Sigil of Vivec
    [126146] = itemPackVivec,                                  -- Banner, Vivec
    [126149] = itemPackVivec,                                  -- Tapestry, Vivec
    [126150] = itemPackVivec,                                  -- Tribunal Tablet of Sotha Sil
    [126152] = itemPackVivec,                                  -- The Cliff-Strider Song
  }
}

local questRewardLilandril           = questRewardString .. "Lilandril"
local mephalaItemSet                 = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK),
  "Trappings of Mephala Worship")
FurC.MiscItemSources[FURC_ALTMER]    = {
  [FURC_CROWN] = {
    [139065] = getCrownPrice(20),                                              -- Flowers, Lizard Tail
    [139066] = getCrownPrice(30),                                              -- Plant, Redtop Grass
    [139067] = getCrownPrice(20) .. " or from harvesting plants in Summerset", -- Flower, Yellow Oleander
    [139068] = getCrownPrice(20),                                              -- Plants, Springwheeze

    [118142] = getCrownPrice(410),                                             -- Painting of Swamp, Refined

    [118145] = getCrownPrice(410),                                             -- Painting of a Desert, Refined
    [118144] = getCrownPrice(410),                                             -- Painting of a Forest, Refined
    [118140] = getCrownPrice(410),                                             -- Painting of a Waterfall, Refined
    [118138] = getCrownPrice(410),                                             -- Painting of Mountains, Refined

    [126463] = getCrownPrice(610),                                             -- Telvanni Painting, Oversized Forest
    [126464] = getCrownPrice(610),                                             -- Telvanni Painting, Oversized Valley
    [126462] = getCrownPrice(610),                                             -- Telvanni Painting, Oversized Volcanic

    [139083] = getCrownPrice(30),                                              -- Plants, Grasswort Patch

    [139088] = getCrownPrice(50),                                              -- Alinor Table Runner, Verdant
    [139089] = getCrownPrice(50),                                              -- Alinor Table Runner, Coiled
    [139090] = getCrownPrice(100),                                             -- Alinor Table Runner, Cloth of Silver

    [139097] = mephalaItemSet,                                                 -- Spiral Skein Glowstalks, Sprouts

    [139126] = getCrownPrice(50),                                              -- Sapling, Ginkgo

    [139140] = getCrownPrice(340),                                             -- Crystals, Crimson Spray
    [139141] = getCrownPrice(310),                                             -- Crystals, Crimson Bed
    [139142] = getCrownPrice(380),                                             -- Crystals, Crimson Spikes
    [139143] = getCrownPrice(310),                                             -- Crystals, Midnight Cluster
    [139144] = getCrownPrice(400),                                             -- Crystals, Midnight Spire
    [139145] = getCrownPrice(430),                                             -- Crystals, Midnight Tower
    [139146] = getCrownPrice(490),                                             -- Crystals, Midnight Bloom

    [139147] = getCrownPrice(30),                                              -- Plants, Scarlet Sawleaf
    [139149] = getCrownPrice(30),                                              -- Plant, Scarlet Fleshfrond
    [139148] = getCrownPrice(70),                                              -- Mushroom, Nettlecap

    [139150] = getCrownPrice(70),                                              -- Mushrooms, Midnight Cluster
    [139151] = getCrownPrice(140),                                             -- Mushrooms, Shadowpalm Cluster

    [139152] = getCrownPrice(360),                                             -- Cocoon, Enormous Empty
    [139153] = getCrownPrice(40),                                              -- Cocoon, Dormant
    [139154] = getCrownPrice(40),                                              -- Cocoons, Dormant Cluster
    [139155] = getCrownPrice(80),                                              -- Cocoon, Food Storage
    [139156] = getCrownPrice(360),                                             -- Cocoon, Skeleton

    [139158] = getCrownPrice(150),                                             -- Daedric Candelabra, Tall
    [139159] = getCrownPrice(920),                                             -- Daedric Chandelier, Gruesome
    [139160] = getCrownPrice(200),                                             -- Daedric Armchair, Severe
    [139161] = getCrownPrice(1500),                                            -- Daedric Table, Grand Necropolis

    [139163] = mephalaItemSet,                                                 -- Mephala, The Webspinner (statue)

    [139293] = getCrownPrice(30),                                              -- Alinor Chalice, Silver Ornate

    [139237] = getCrownPrice(190),                                             -- Alinor Wall Mirror, Noble

    [139329] = getCrownPrice(45),                                              -- Coral Formation, Heart
    [139330] = getCrownPrice(45),                                              -- Coral Formation, Waving Hands
    [139331] = getCrownPrice(45),                                              -- Coral Formation, Tree Antler
    [139332] = getCrownPrice(45) .. " or " .. itemPackAquatic,                 -- Coral Formation, Tree Shelf
    [139333] = getCrownPrice(45),                                              -- Coral Formation, Trees Capped
    [139334] = getCrownPrice(20),                                              -- Coral Formation, Tree Capped (green)

    [139335] = getCrownPrice(310),                                             -- Tree, Shade Ancient
    [139336] = getCrownPrice(90),                                              -- Trees, Shade Interwoven
    [139337] = getCrownPrice(580),                                             -- Tree, Ancient Blooming Ginkgo

    [139338] = getCrownPrice(25),                                              -- Vines, Sun-Bronzed Ivy Swath
    [139339] = getCrownPrice(25),                                              -- Vines, Sun-Bronzed Ivy Climber

    [139340] = getCrownPrice(310),                                             -- Tree, Ancient Summerset Spruce
    [139341] = getCrownPrice(310),                                             -- Tree, Towering Poplar
    [139342] = getCrownPrice(45),                                              -- Tree, Vibrant Pink
    [139343] = getCrownPrice(45),                                              -- Tree, Cloud White

    [139344] = getCrownPrice(45),                                              -- Flowers, Hummingbird Mint Cluster
    [139345] = getCrownPrice(45),                                              -- Flowers, Lizard Tail Cluster
    [139346] = getCrownPrice(45),                                              -- Flowers, Lizard Tail Patch
    [139347] = getCrownPrice(45),                                              -- Flowers, Yellow Oleander Cluster

    [139348] = getCrownPrice(940),                                             -- Alinor Pergola, Purple Wisteria
    [139349] = getCrownPrice(940),                                             -- Alinor Pergola, Blue Wisteria Peaked
    [139350] = getCrownPrice(940),                                             -- Alinor Pergola, Purple Wisteria Overhang

    [139351] = getCrownPrice(200),                                             -- Alinor Monument, Marble
    [139352] = getCrownPrice(1000),                                            -- Alinor Tomb, Ornate

    [139353] = getCrownPrice(340),                                             -- Mind Trap Coral Spire, Branched
    [139354] = getCrownPrice(340),                                             -- Mind Trap Coral Spire, Bulbous
    [139355] = getCrownPrice(340),                                             -- Mind Trap Coral Formation, Heart
    [139356] = getCrownPrice(340),                                             -- Mind Trap Coral Formation, Waving Hands
    [139357] = getCrownPrice(340),                                             -- Mind Trap Coral Formation, Tree Antler
    [139358] = getCrownPrice(340),                                             -- Mind Trap Coral Formation, Tree Capped
    [139359] = getCrownPrice(340),                                             -- Mind Trap Coral Formation, Trees Capped
    [139360] = getCrownPrice(510),                                             -- Mind Trap Kelp, Cluster
    [139361] = getCrownPrice(270),                                             -- Mind Trap Kelp, Young

    [139362] = getCrownPrice(340),                                             -- Sload Astral Nodule, Small
    [139363] = getCrownPrice(340),                                             -- Sload Astral Nodule, Large
    [139364] = getCrownPrice(1500),                                            -- Sload Neural Tree, Active

    [139365] = getCrownPrice(370),                                             -- Psijic Lighting Globe, Framed

    [139366] = getCrownPrice(2000),                                            -- Alinor Fountain, Regal
    [139368] = getCrownPrice(100),                                             -- Alinor Bathing Robes, Decorative

    [139376] = getCrownPrice(260),                                             -- Alinor Banner, Hanging

    [139481] = getCrownPrice(200),                                             -- Alinor Column, Jagged Timeworn
    [139482] = getCrownPrice(200),                                             -- Alinor Column, Huge Timeworn
    [139483] = getCrownPrice(90),                                              -- Alinor Column, Tumbled Timeworn

    [139480] = getCrownPrice(30),                                              -- Plants, Redtop Grass Tuft
    [139650] = getCrownPrice(30),                                              -- Bushes, Ivy Cluster

    [140220] = mephalaItemSet,                                                 -- Rumours of the Spiral Skein

    [139327] = getCrownPrice(45),                                              -- Coral Spire, Sturdy
    [139328] = getCrownPrice(45),                                              -- Coral Spire, Branched
    [132165] = getCrownPrice(750),                                             -- Hlaalu Bath Tub, Empty Basin
    [126034] = getCrownPrice(4000),                                            -- The Lord
    [125451] = getCrownPrice(4000),                                            -- The Apprentice
    [125452] = getCrownPrice(4000),                                            -- The Lady
    [125453] = getCrownPrice(4000),                                            -- The Warrior
    [125454] = getCrownPrice(4000),                                            -- The Tower
    [125455] = getCrownPrice(4000),                                            -- The Thief
    [125456] = getCrownPrice(4000),                                            -- The Steed
    [125457] = getCrownPrice(4000),                                            -- The Shadow
    [125458] = getCrownPrice(4000),                                            -- The Serpent
    [125459] = getCrownPrice(4000),                                            -- The Ritual
    [125460] = getCrownPrice(4000),                                            -- The Mage
    [125461] = getCrownPrice(4000),                                            -- The Lover
    [119556] = getCrownPrice(4000),                                            -- The Atronach
    [126037] = getCrownPrice(4000),                                            -- Target Centurion, Lambent
    [126038] = getCrownPrice(4000),                                            -- Target Centurion, Robust Lambent
    [134247] = getCrownPrice(190),                                             -- Soul Gem Module, Experimental
    [118491] = getCrownPrice(55),                                              -- Scroll, Bound
  },

  [FURC_DROP] = {
    [139059] = GetString(SI_FURC_DROP),       -- Ivory, Polished - drops from Echatere, and probably alot else
    [139066] = GetString(SI_FURC_HARVEST),    -- Plant, Redtop Grass

    [139060] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Ancient
    [139062] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Large
    [139063] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Enormous
    [139061] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Sealed

    [139073] = questRewardLilandril,          -- Painting of Summerset Coast, Refined
    [139072] = GetString(SI_FURC_ELF_PIC),    -- Painting of Monastery of Serene Harmony, Refined
    [139074] = GetString(SI_FURC_ELF_PIC),    -- Painting of Aldmeri Ruins, Refined
    [139069] = GetString(SI_FURC_ELF_PIC),    -- Painting of Griffin Nest, Refined
    [139070] = GetString(SI_FURC_ELF_PIC),    -- Painting of College of the Sapiarchs, Refined
    [139071] = GetString(SI_FURC_ELF_PIC),    -- Painting of High Elf Tower, Refined

    [87709] = GetString(SI_FURC_LEVELUP),     -- Imperial Brazier, Spiked
    [94098] = GetString(SI_FURC_LEVELUP),     -- Imperial Bed, Single

    [118143] = painting_summerset,            -- Painting of Tree, Refined
    [118141] = painting_summerset,            -- Painting of Cottage, Refined
    [118139] = painting_summerset,            -- Painting of Valley, Refined

    [130192] = scambox_reaper,                -- Statuette of Sheogorath, the Mad God
  },

  [FURC_FISHING] = {
    [139080] = fishing_summerset, -- Coral Formation, Ancient Pillar Polyps
    [139079] = fishing_summerset, -- Coral Formation, Fan Cluster
    [139081] = fishing_summerset, -- Plant, Sea Grapes
    [139084] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139085] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139068] = fishing_summerset, -- Plants, Springwheeze
    [139077] = fishing_summerset, -- Coral Formation, Bulwark
    [139078] = fishing_summerset, -- Coral Formation, Pillar Polyps
    [139082] = fishing_summerset, -- Plants, Ruby Glasswort Patch
  },

  [FURC_RUMOUR] = {
    [130193] = dataminedUnclear, -- Robust Target Minotaur Handler
    [130194] = dataminedUnclear, -- Target Stone Atronach
    [130195] = dataminedUnclear, -- Target Iron Atronach
    [130189] = dataminedUnclear, -- Tapestry of Sheogorath
    [130190] = dataminedUnclear, -- Banner of Sheogorath
    [134287] = dataminedUnclear, -- Projector TBD
    [130192] = dataminedUnclear, -- Statue of Sheogorath, the Madgod
    -- [130187] = dataminedUnclear,                    -- Statuette of Hircine, the Huntsman
    -- [130188] = dataminedUnclear,                    -- Statuette of Molag Bal, Lord of Brutality
    [132200] = dataminedUnclear, -- Imperial Well, Akatosh
    [132201] = dataminedUnclear, -- Tree, Kvatch Nut
    [132202] = dataminedUnclear, -- Rock, Anvil Limestone
    [132203] = dataminedUnclear, -- Stone, Anvil Limestone
    [132197] = dataminedUnclear, -- Death Skeleton, Shrouded
    [140297] = dataminedUnclear, -- Replica Throne of Alinor,
    [130070] = dataminedUnclear, -- Daedric Spout, Arched,
    [120856] = dataminedUnclear, -- Yokudan Sarcophagus
    [120857] = dataminedUnclear, -- Yokudan Sarcophagus Lid
    [120858] = dataminedUnclear, -- Yokudan Tapestry
    [120872] = dataminedUnclear, -- Daedric Pike, Daedroth Head
    [120874] = dataminedUnclear, -- Daedric Coffin, Lid
    [120880] = dataminedUnclear, -- Tombstone, Engraved, Decorative
    [120881] = dataminedUnclear, -- Tombstone, Engraved, Order of the Hour
    [120882] = dataminedUnclear, -- Tombstone, Small
    [132166] = dataminedUnclear, -- Death Skeleton, Robed
    [134474] = dataminedUnclear, -- Banner, Malacath

    [139137] = dataminedUnclear, -- Tapestry, Nocturnal
    [139138] = dataminedUnclear, -- Banner, Nocturnal
    [139139] = dataminedUnclear, -- Nocturnal, Mistress of Shadows
    [139367] = dataminedUnclear, -- Regal Sauna Pool, Two Person
  }
}

-- Reach
FurC.MiscItemSources[FURC_DRAGONS]   = {
  -- Reach
  [FURC_DROP]    = {
    [134909] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Puspocket Group
    [134910] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Puspocket Cluster
    [134911] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Puspocket Sporecap
    [134912] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Large Puspocket
    [134913] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Tall Puspocket
    [134914] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Large Puspocket Cluster
  },

  [FURC_JUSTICE] = {},

  [FURC_CROWN]   = {
    [134970] = getCrownPrice(100), -- Mushrooms, Glowing Sprawl
    [134947] = getCrownPrice(100), -- Mushrooms, Glowing Field
    [134948] = getCrownPrice(400), -- Mushrooms, Glowing Cluster
    [134971] = getCrownPrice(400), -- Candles, Votive Group
    [134972] = getCrownPrice(400), -- Brotherhood Brazier, Wrought Iron
    [94100]  = getCrownPrice(50),  -- Imperial BookCase, Swirled
    [130211] = getCrownPrice(50),  -- Books, Ordered Row
    [130210] = getCrownPrice(50),  -- Books, Scattered Row
  }
}

FurC.MiscItemSources[FURC_CLOCKWORK] = {
  -- Reach
  [FURC_DROP]    = {
    [134407] = automaton_loot_cc,                        -- Factotum Torso, Obsolete
    [134404] = automaton_loot_cc,                        -- Factotum Knee, Obsolete
    [134408] = automaton_loot_cc,                        -- Factotum Elbow, Obsolete
    [134405] = automaton_loot_cc,                        -- Factotum Arm, Obsolete
    [134409] = automaton_loot_cc,                        -- Factotum Head, Obsolete
    [134406] = automaton_loot_cc,                        -- Factotum Body, Obsolete

    [132348] = questRewardString .. "the Brass Citadel", -- The Precursor
  },

  [FURC_JUSTICE] = {
    [134410] = stealable_cc,          -- Clockwork Crank, Miniature
    [134411] = stealable_cc,          -- Clockwork Gear Shaft, Miniature
    [134412] = stealable_cc,          -- Clockwork Piston, Miniature
    [134413] = stealable_cc,          -- Clockwork Magnifier, Handheld
    [134414] = stealable_cc,          -- Clockwork Micrometer, Handheld
    [134415] = stealable_cc,          -- Clockwork Dial Calipers, Handheld
    [134416] = stealable_cc,          -- Clockwork Slide Calipers, Handheld
    [134402] = stealable,             -- Spool, Empty
    [134400] = stealable,             -- Soft Leather, Stacked
    [134401] = stealable,             -- Soft Leather, Folded
    [134417] = stealable_cc,          -- Clockwork Firm-Joint Calipers, Handheld
    [134399] = stealable,             -- Quality Fabric, Folded
    [117939] = stealable_woodworkers, -- Rough Axe, Practical
  },

  [FURC_CROWN]   = {
    [134266] = getCrownPrice(80),   -- Daedric Books, Stacked
    [134265] = getCrownPrice(80),   -- Daedric Books, Piled
    [134373] = getCrownPrice(410),  -- Clockwork Wall Machinery, Rectangular
    [134374] = getCrownPrice(410),  -- Clockwork Wall Machinery, Circular
    [134382] = getCrownPrice(870),  -- Fabricant Tree, Beryl Cypress
    [134383] = getCrownPrice(870),  -- Fabricant Tree, Towering Maple
    [134385] = getCrownPrice(870),  -- Fabricant Tree, Brass Swamp
    [134387] = getCrownPrice(870),  -- Fabricant Tree, Tall Cobalt Spruce
    [134388] = getCrownPrice(870),  -- Fabricant Tree, Cobalt Oak
    [134384] = getCrownPrice(870),  -- Fabricant Tree, Decorative Electrum
    [134386] = getCrownPrice(260),  -- Fabricant Tree, Forked Cherry Blossom
    [134389] = getCrownPrice(140),  -- Fabricant Tree, Decorative Brass
    [134390] = getCrownPrice(140),  -- Clockwork Junk Heap, Large
    [134391] = getCrownPrice(510),  -- Clockwork Sequence Spool, Column
    [134392] = getCrownPrice(260),  -- Clockwork Recharging Column, Octet
    [134393] = getCrownPrice(270),  -- Clockwork Workbench, Spacious
    [134394] = getCrownPrice(460),  -- Clockwork Illuminator, Capsule Chandelier
    [134395] = getCrownPrice(150),  -- Clockwork Illuminator, Wall Capsule
    [134396] = getCrownPrice(410),  -- Clockwork Wall Machinery, Tall
    [134397] = getCrownPrice(410),  -- Clockwork Wall Machinery, Ovoid
    [134398] = getCrownPrice(1300), -- Clockwork Gazebo, Copper and Basalt
  },

  [FURC_RUMOUR]  = {
    [125509] = dataminedUnclear, -- Replica Dwarven Crown Crate
  }
}

FurC.MiscItemSources[FURC_REACH]     = {
  -- Reach
  [FURC_JUSTICE] = {
    [130191] = stealable,       -- Shivering Cheese
    [118206] = stealable_thief, -- Gaming dice
  },
  [FURC_DROP]    = {
    -- Coldharbour items
    [130284] = GetString(SI_FURC_HARVEST),       -- Glowstalk, Seedlings
    [131422] = GetString(SI_FURC_HARVEST),       -- Flower Patch, Glowstalks
    [130283] = GetString(SI_FURC_HARVEST),       -- Glowstalk, Sprout
    [130285] = GetString(SI_FURC_HARVEST),       -- Glowstalk, Young
    [131420] = GetString(SI_FURC_HARVEST),       -- Shrub, Glowing Thistle
    [130281] = GetString(SI_FURC_HARVEST),       -- Glowstalk, Towering
    [130282] = GetString(SI_FURC_HARVEST),       -- Glowstalk, Strong

    [130067] = GetString(SI_FURC_DAEDRA_SOURCE), -- Daedric Chain Segment
  },
}

local questRewardSuran               = GetString(SI_FURC_QUESTREWARD) .. " Suran"

FurC.MiscItemSources[FURC_MORROWIND] = {
  -- Morrowind
  [FURC_DROP]    = {

    --Public dungeon Forgotten Wastes / maybe rarest drop at all ingame
    [127149] = puplicdungeon_fw_vv, -- Morrowind Banner of the 6th House

    -- Dwemer parts
    [126660] = automaton_loot_vv, -- Dwemer Gear, Tiered
    [126659] = automaton_loot_vv, -- Dwemer Gear, Flat

    -- lootable in tombs
    [126754] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Seeker
    [126705] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Wisdom
    [126704] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Majesty
    [126706] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Knowledge
    [126701] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Nerevar
    [126764] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Prowess
    [126702] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Reverance
    [126700] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Honor
    [126703] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Mysteries
    [126752] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Discovery
    [126755] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Change
    [126756] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Mercy

    [126773] = GetString(SI_FURC_TOMBS), -- Velothi Caisson, Crypt
    [126753] = GetString(SI_FURC_TOMBS), -- Velothi Cerecloth, Austere
    [126758] = GetString(SI_FURC_TOMBS), -- Velothi Mat, Prayer
    [126757] = GetString(SI_FURC_TOMBS),

    [126465] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Modest Volcanic
    [126466] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Modest Forest
    [126467] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Modest Valley

    [126468] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Classic Volcanic
    [126469] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Classic Forest
    [126470] = GetString(SI_FURC_CHEST_VV),    -- Telvanni Painting, Classic Valley

    [126593] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Volcano
    [126594] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Volcano
    [126595] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Volcano
    [126596] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Volcano
    [126605] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Waterfall
    [126606] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Waterfall
    [126608] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Waterfall
    [126609] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Waterfall
    [126599] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Geyser
    [126600] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Geyser
    [126602] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Geyser
    [126603] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Geyser

    -- Ashlander dailies
    [126119] = GetString(SI_FURC_DAILY_ASH), -- Crimson Shard of Moonshadow
    [126393] = GetString(SI_FURC_DAILY_ASH), -- Ashlander Knife, Cheese

    -- drops from plants
    [125631] = plants_vvardenfell,        -- Plants, Ash Frond
    [131420] = plants_vvardenfell,        -- Plants, Ash Frond
    [125553] = plants_vvardenfell,        -- Flowers, Netch Cabbage Stalks
    [125551] = plants_vvardenfell,        -- Flowers, Netch Cabbage
    [125552] = plants_vvardenfell,        -- Flowers, Netch Cabbage Patch
    [125543] = plants_vvardenfell,        -- Fern, Ashen
    [125633] = plants_vvardenfell,        -- Plants, Hanging Pitcher Pair
    [125680] = plants_vvardenfell,        -- Vines, Ashen Moss

    [125562] = plants_vvardenfell,        -- Grass, Foxtail Cluster
    [125595] = plants_vvardenfell,        -- Mushroom, Poison Pax Shelf
    [125596] = plants_vvardenfell,        -- Mushroom, Poison Pax Stool
    [125600] = plants_vvardenfell,        -- Mushroom, Spongecap Patch
    [125606] = plants_vvardenfell,        -- Mushroom, Young Milkcap
    [125608] = plants_vvardenfell,        -- Mushrooms, Buttercake Cluster
    [125609] = plants_vvardenfell,        -- Mushrooms, Buttercake Stack
    [125613] = plants_vvardenfell,        -- Mushrooms, Lavaburst Sprouts
    [125590] = plants_vvardenfell,        -- Mushrooms, Lavaburst Cluster
    [125617] = plants_vvardenfell,        -- Plant, Bitter Stalk
    [125618] = plants_vvardenfell,        -- Plant, Golden Lichen
    [125619] = plants_vvardenfell,        -- Plant, Hanging Pitcher
    [125620] = plants_vvardenfell,        -- Plant, Hefty Elkhorn
    [125621] = plants_vvardenfell,        -- Plant, Lava Brier
    [125622] = plants_vvardenfell,        -- Plant, Lava Leaf
    [125630] = plants_vvardenfell,        -- Plant, Young Elkhorn
    [125632] = plants_vvardenfell,        -- Plants, Hanging Pitcher Cluster
    [125634] = plants_vvardenfell,        -- Plants, Lava Pitcher Cluster
    [125635] = plants_vvardenfell,        -- Plants, Lava Pitcher Shoots
    [125636] = plants_vvardenfell,        -- Plants, Swamp Pitcher Cluster
    [125637] = plants_vvardenfell,        -- Plants, Swamp Pitcher Shoots
    [125647] = plants_vvardenfell,        -- Shrub, Bitter Brush
    [125648] = plants_vvardenfell,        -- Shrub, Bitter Cluster
    [125649] = plants_vvardenfell,        -- Shrub, Flowering Dusk
    [125650] = plants_vvardenfell,        -- Shrub, Golden Lichen
    [125670] = plants_vvardenfell,        -- Toadstool, Bloodtooth
    [125671] = plants_vvardenfell,        -- Toadstool, Bloodtooth Cap
    [125672] = plants_vvardenfell,        -- Toadstool, Bloodtooth Cluster

    [126759] = questRewardSuran,          -- Sir Sock's Ball of Yarn

    [126592] = GetString(SI_FURC_PLANTS), -- Plants, Hanging Pitcher Pair

    [126039] = scambox_dwemer,            -- Statue of masked Clavicus Vile with Barbas
  },

  [FURC_CROWN]   = {
    [130202] = getCrownPrice(170) .. " or " .. itemPackAyleid, -- Ayleid Grate, Tall
    [130204] = getCrownPrice(410) .. " or " .. itemPackAyleid, -- Welkynd Stones, Glowing
    [130205] = getCrownPrice(680) .. " or " .. itemPackAyleid, -- Ayleid Statue, Pious Priest
    [130207] = getCrownPrice(270) .. " or " .. itemPackAyleid, -- Ayleid Plinth, Engraved
    [130197] = getCrownPrice(170) .. " or " .. itemPackAyleid, -- Ayleid Bookcase, Filled
    [130199] = getCrownPrice(170) .. " or " .. itemPackAyleid, -- Ayleid Bookshelf, Bare
    [130201] = getCrownPrice(170) .. " or " .. itemPackAyleid, -- Ayleid Grate, Small
    [130213] = getCrownPrice(430) .. " or " .. itemPackAyleid, -- Ayleid Cage, Hanging
    [130206] = getCrownPrice(370) .. " or " .. itemPackAyleid, -- Ayleid Apparatus, Welkynd
    [130212] = itemPackAyleid,                                 -- Daedra Worship: The Ayleids

    [125566] = getHouseString(1243),                           -- Hlaalu Shed, Enclosed
    [125568] = getHouseString(1243),                           -- Hlaalu Sidewalk, Sillar Stone
    [125577] = getHouseString(1243),                           -- Hlaalu Wall Post, Sillar Stone
    [125579] = getHouseString(1243),                           -- Hlaalu Well, Braced Sillar Stone
    [125573] = getHouseString(1243, 1244),                     -- Hlaalu Streetlamp, Paper
    [125565] = getHouseString(1244),                           -- Hlaalu Lantern, Hanging Paper
    [125567] = getHouseString(1244),                           -- Hlaalu Shed, Open
    [125580] = getHouseString(1244),                           -- Hlaalu Well, Covered Sillar Stone
    [118663] = getHouseString(1078, 1079),                     -- Dark Elf Bed of Coals
    [126475] = getCrownPrice(260),                             -- Telvanni Lantern, Organic Amber
    [126476] = getCrownPrice(200),                             -- Telvanni Lamp, Organic Amber
    [126477] = getCrownPrice(560),                             -- Telvanni Streetlight, Organic Amber
    [126478] = getCrownPrice(560),                             -- Telvanni Arched Light, Organic Amber
    [126479] = getCrownPrice(310),                             -- Telvanni Sconce, Organic Amber
    [121001] = getCrownPrice(45),                              -- Flowers, Golden Prairie
    [121002] = getCrownPrice(45),                              -- Flowers, Violet Prairie
    [121017] = getCrownPrice(10),                              -- Bush, Dense Forest
    [121019] = getCrownPrice(10),                              -- Plants, Dense Underbrush
    [121027] = getCrownPrice(45),                              -- Hedge, Dense Low Arc
    [121033] = getCrownPrice(25),                              -- Sapling, Sparse Laurel
    [121037] = getCrownPrice(30),                              -- Shrub, Sparse Pink
    [121038] = getCrownPrice(30),                              -- Plant, Paired White Hosta
    [121039] = getCrownPrice(30),                              -- Plant, Blooming White Hosta
    [121040] = getCrownPrice(30),                              -- Plant, Verdant Hosta
    [121041] = getCrownPrice(10),                              -- Plant, Young Verdant Hosta
    [121042] = getCrownPrice(10),                              -- Plant, Young Summer Hosta
    [121043] = getCrownPrice(30),                              -- Plant, Summer Hosta
    [121044] = getCrownPrice(30),                              -- Plant, Healthy White Hosta
    [121045] = getCrownPrice(25),                              -- Book Row, Decorative
    [121047] = getCrownPrice(25),                              -- Book Row, Long
    [121052] = getCrownPrice(100),                             -- Vase, Gilded Offering
    [121053] = getCrownPrice(170),                             -- Jar, Gilded Canopic
    [121054] = getCrownPrice(30),                              -- Breton Mug, Empty
    [121056] = getCrownPrice(25),                              -- Book Stack, Decorative
    [134379] = getCrownPrice(50),                              -- Boulder, Large Metallic Shard
    [134380] = getCrownPrice(110),                             -- Rocks, Sintered Arch
    [134381] = getCrownPrice(110),                             -- Rocks, Sintered Outcropping
    [130316] = getCrownPrice(25),                              -- Pumpkin, Frail
    [130317] = getCrownPrice(25),                              -- Pumpkin, Sickly
    [130318] = getCrownPrice(10),                              -- Crop, Wheat Pile
    [130319] = getCrownPrice(10),                              -- Crop, Wheat Stack
    [130322] = getCrownPrice(90),                              -- Tool, Harvest Scythe
    [130329] = getCrownPrice(240),                             -- Primal Brazier, Rock Slab
    [131425] = getCrownPrice(360),                             -- Orcish Tent, Soldier's
    [131426] = getCrownPrice(680),                             -- Orcish Tent, Officer's
    [131427] = getCrownPrice(1700),                            -- Orcish Tent, General's
    [134565] = getCrownPrice(130),                             -- Fabrication Tank, Reinforced
    [134566] = getCrownPrice(30),                              -- Shrub Cluster, Snowswept
    [134567] = getCrownPrice(10),                              -- Bush Cluster, Snowswept
    [134568] = getCrownPrice(40),                              -- Tree, Snowswept Evergreen
    [134569] = getCrownPrice(40),                              -- Trees, Snowswept Pair
    [134570] = getCrownPrice(110),                             -- Snow Pile
    [134571] = getCrownPrice(120),                             -- Snow Pile, Large
    [134572] = getCrownPrice(5),                               -- Stones, Snowswept Cluster
    [134573] = getCrownPrice(5),                               -- Stone, Snowswept Shard
    [134574] = getCrownPrice(50),                              -- Boulder, Snowswept Peak
    [134575] = getCrownPrice(50),                              -- Boulder, Snowswept Crag
    [134576] = getCrownPrice(190),                             -- Orcish Brazier, Snowswept Column
    [134577] = getCrownPrice(50),                              -- Ice Floe, Thin
    [134578] = getCrownPrice(110),                             -- Ice Floe, Thick
    [125482] = getCrownPrice(50),                              -- Boulder, Volcanic Crag
    [125484] = getCrownPrice(30),                              -- Bush, Lush Laurel
    [121399] = getCrownPrice(2000),                            -- Target Skeleton, Robust Khajiit
    [121400] = getCrownPrice(2000),                            -- Target Skeleton, Robust Argonian
    [120408] = getCrownPrice(25),                              -- Argonian Fish in a Basket
    [120409] = getCrownPrice(100),                             -- Argonian Rack, Woven
    [120412] = getCrownPrice(50),                              -- Noble's Chalice
    [120413] = getCrownPrice(30),                              -- Breton Pitcher, Clay
    [120414] = getCrownPrice(30),                              -- Breton Tankard, Empty
    [120415] = getCrownPrice(30),                              -- Breton Tankard, Full
    [120416] = getCrownPrice(40),                              -- Common Cloak on a Hook
    [120420] = getCrownPrice(140),                             -- Plaque, Bolted Deer Antlers
    [125545] = getCrownPrice(30),                              -- Fern, Young Dusky
    [120426] = getCrownPrice(1500),                            -- Target Skeleton, Khajiit
    [120427] = getCrownPrice(1500),                            -- Target Skeleton, Argonian
    [125548] = getCrownPrice(85),                              -- Flower, Towering Purple Bat Bloom
    [125549] = getCrownPrice(85),                              -- Flowers, Double Purple Bat Blooms
    [125554] = getCrownPrice(85),                              -- Flowers, Opposing Purple Bat Blooms
    [125555] = getCrownPrice(85),                              -- Flowers, Sullen Purple Bat Blooms
    [120464] = getCrownPrice(20),                              -- Rocks, Stacked Cracked
    [120465] = getCrownPrice(5),                               -- Stone, Tapered Rough
    [120466] = getCrownPrice(5),                               -- Pebble, Stacked Desert
    [120470] = getCrownPrice(25),                              -- Tree, Leaning Palm
    [120472] = getCrownPrice(25),                              -- Tree, Young Palm
    [120473] = getCrownPrice(60),                              -- Sapling, Thin Palm
    [120475] = getCrownPrice(70),                              -- Trees, Paired Wax Palms4
    [120482] = getCrownPrice(30),                              -- Cactus, Golden Bulbs
    [125603] = getCrownPrice(40),                              -- Mushroom, Stinkhorn Spore
    [120484] = getCrownPrice(30),                              -- Cactus, Golden Barrel
    [125605] = getCrownPrice(10),                              -- Mushroom, Young Erupted Stinkcap
    [120486] = getCrownPrice(30),                              -- Cactus, Stocky Columnar
    [125607] = getCrownPrice(10),                              -- Mushroom, Young Netch Shield
    [125610] = getCrownPrice(25),                              -- Mushrooms, Cave Bracket Cluster
    [120491] = getCrownPrice(30),                              -- Fern, Hearty Autumn
    [125616] = getCrownPrice(5),                               -- Pebble, Volcanic Chunk
    [125628] = getCrownPrice(70),                              -- Plant, Rosetted Sundew
    [126686] = getCrownPrice(400),                             -- Dwarven Chest, Relic
    [120481] = getCrownPrice(150),                             -- Tree, Ancient Juniper
    [126601] = getCrownPrice(410),                             -- Velothi Painting, Oversized Geyser
    [126597] = getCrownPrice(410),                             -- Velothi Painting, Oversized Volcano
    [126607] = getCrownPrice(410),                             -- Velothi Painting, Oversized Waterfall
    [126604] = getCrownPrice(410),                             -- Velothi Panels, Geyser
    [126592] = getCrownPrice(410),                             -- Velothi Panels, Volcano
    [126598] = getCrownPrice(410),                             -- Velothi Panels, Waterfall
    [125550] = getCrownPrice(85),                              -- Flowers, Lava Blooms
  },

  [FURC_JUSTICE] = {
    [126481] = stealable_priests .. " in Vvardenfell", -- Indoril Incense, Burning
    [126772] = stealable_thief                         -- Khajiiti Ponder sphere
  },

  [FURC_RUMOUR]  = {
    [132531] = dataminedUnclear, -- Hlaalu Planter, Tall
    [120411] = dataminedUnclear, -- Noble's Chalice of Wine
    [126568] = dataminedUnclear, -- Daedric Urn, Ritual
    [125569] = dataminedUnclear, -- Hlaalu Sidewalk, Sillar Stone Corner
    [125570] = dataminedUnclear, -- Hlaalu Stairs, Sillar Stone
    [125576] = dataminedUnclear, -- Hlaalu Wall Pillar, Sillar Stone
    [125591] = dataminedUnclear, -- Mushroom, Lavaburst Patch
    [125597] = dataminedUnclear, -- Mushroom, Polyp Stinkhorn
  }
}

FurC.MiscItemSources[FURC_HOMESTEAD] = {
  [FURC_JUSTICE] = {
    -- stealing
    [118489] = stealable_scholars, -- Papers, Stack
    [118528] = stealable,          -- Signed Contract
    [118890] = stealable,          -- Skull, Human
    [118487] = stealable_scholars, -- Letter, Personal
    [120008] = stealable_nerds,    -- Lesser Soul Gem, Empty
    [120005] = stealable_nerds,    -- Papers, Stack

    -- Bounty Sheets
    [118711] = pickpocket_guard,    -- Argonian Male
    [118709] = pickpocket_guard,    -- Breton Male
    [118712] = pickpocket_guard,    -- Breton Woman
    [118715] = pickpocket_guard,    -- Colovian Man
    [118710] = pickpocket_guard,    -- High Elf Male
    [118714] = pickpocket_guard,    -- Imperial Man
    [118713] = pickpocket_guard,    -- Khajiiti Male
    [118716] = pickpocket_guard,    -- Orc Female
    [118717] = pickpocket_guard,    -- Orc Male

    [121055] = stealable_drunkards, -- Breton Mug, Full

    [116512] = stealable_wrothgar,  -- Orcish Carpet Blood
  },

  [FURC_FISHING] = {
    -- fishing
    [118902] = GetString(SI_FURC_CANBEFISHED), -- Coral, Sun
    [118903] = GetString(SI_FURC_CANBEFISHED), -- Coral, Crown
    [118896] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Sandcake
    [118901] = GetString(SI_FURC_CANBEFISHED), -- Sea sponge
    [118338] = GetString(SI_FURC_CANBEFISHED), -- Fish, Bass
    [118339] = GetString(SI_FURC_CANBEFISHED), -- Fish, Salmon
    [118337] = GetString(SI_FURC_CANBEFISHED), -- Fish, Trout
    [120753] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Green Pile
    [120755] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Lush Pile
    [120754] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Small Pile
    [118897] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Pink Scallop
    [118898] = GetString(SI_FURC_CANBEFISHED), -- Seashell, White Scallop
    [118899] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Starfish
    [118900] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Noble Starfish
  },

  [FURC_DROP]    = {
    [121058] = db_sneaky, -- Candles of Silence
    [119936] = db_poison, -- Poisoned Blood
    [119938] = db_poison, -- Light and Shadow
    [119952] = db_equip,  -- Sacrificial Heart

    -- Paintings
    [118216] = GetString(SI_FURC_CHESTS), -- Painting of Spring, Sturdy
    [118217] = GetString(SI_FURC_CHESTS), -- Painting of Pasture, Sturdy
    [118218] = GetString(SI_FURC_CHESTS), -- Painting of Creek, Sturdy
    [118219] = GetString(SI_FURC_CHESTS), -- Painting of Lakes, Sturdy
    [118220] = GetString(SI_FURC_CHESTS), -- Painting of Crags, Sturdy
    [118221] = GetString(SI_FURC_CHESTS), -- Painting of Summer, Sturdy
    [118222] = GetString(SI_FURC_CHESTS), -- Painting of Jungle, Sturdy
    [118223] = GetString(SI_FURC_CHESTS), -- Painting of Palms, Sturdy
    [118265] = GetString(SI_FURC_CHESTS), -- Painting of Winter, Bolted
    [118266] = GetString(SI_FURC_CHESTS), -- Painting of Bridge, Bolted
    [118267] = GetString(SI_FURC_CHESTS), -- Painting of Autumn, Bolted
    [118268] = GetString(SI_FURC_CHESTS), -- Painting of Great Ruins, Bolted
  },

  [FURC_CROWN]   = {
    [118096] = getCrownPrice(10),   -- Bread, Plain
    [118098] = getCrownPrice(10),   -- Common Bowl, Serving
    [118061] = getCrownPrice(15),   -- Chicken Dinner, Display
    [118062] = getCrownPrice(15),   -- Chicken Meal, Display
    [118056] = getCrownPrice(15),   -- Common Stewpot, Hanging
    [118121] = getCrownPrice(15),   -- Knife, Carving
    [118066] = getCrownPrice(15),   -- Steak Dinner

    [118057] = getCrownPrice(20),   -- Sack of Beans
    [118060] = getCrownPrice(20),   -- Sack of Grain
    [118059] = getCrownPrice(20),   -- Sack of Millet,
    [118058] = getCrownPrice(20),   -- Sack of Rice
    [118351] = getCrownPrice(25),   -- Box of Peaches

    [134473] = scambox_fireatro,    -- Tapestry,  Malacath

    [118064] = getCrownPrice(45),   -- Common Barrel, Dry
    [118065] = getCrownPrice(45),   -- Common Cargo Crate, Dry

    [118054] = getCrownPrice(80),   -- Common Firepit, Outdoor
    [118055] = getCrownPrice(80),   -- Common Firepit, Piled
    [118126] = getCrownPrice(95),   -- Plaque, Standard

    [118068] = getCrownPrice(120),  -- Simple Brown Banner
    [118069] = getCrownPrice(120),  -- Simple Gray Banner
    [118071] = getCrownPrice(120),  -- Simple Red Banner
    [118070] = getCrownPrice(120),  -- Simple Purple Banner

    [117952] = getCrownPrice(35),   -- Rough Torch, Wall

    [94098] = getCrownPrice(95),    -- Imperial Bed, Single

    [120607] = getCrownPrice(50),   -- Sapling, Lanky Ash

    [115698] = getCrownPrice(1100), -- Khajiit Statue, Guardian

    [120413] = getCrownPrice(30),   -- Breton Pitcher, Clay
    [118000] = getCrownPrice(10),   -- Garlic String, Display

    [118119] = getCrownPrice(120),  -- Minecart, Empty
    [118120] = getCrownPrice(120),  -- Minecart, Push
    [118278] = getCrownPrice(140),  -- Plaque, Bordered Deer Antlers
    [115395] = getCrownPrice(40),   -- Nord Drinking Horn, Display
    [118118] = getCrownPrice(100),  -- Candles, Lasting
  },

  [FURC_RUMOUR]  = {
    [118290] = rumourSource, -- Antlers, Wall Mount
    [118299] = rumourSource, -- Bottle, Beaker
    [118300] = rumourSource, -- Bottle, Poison
    [118291] = rumourSource, -- Durzog Head, Wall Mount
    [118293] = rumourSource, -- Echatere, Wall Mount
    [118295] = rumourSource, -- Haj Mota Head, Wall Mount
    [118289] = rumourSource, -- Haj Mota Shell, Wall Mount
    [118284] = rumourSource, -- Horn, Display, Cracked
    [118283] = rumourSource, -- Horn, Display, Huge
    [118296] = rumourSource, -- Mantikora Head, Wall Mount
    [118297] = rumourSource, -- Mantikora Horns, Wall Mount
    [116433] = rumourSource, -- Orcish Desk with Furs
    [118304] = rumourSource, -- Shelf, Poison
    [118127] = rumourSource, -- Plaque, Small
  }
}
