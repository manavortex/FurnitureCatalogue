-- use constants because it's a huge performance gain due to how LUA handles strings... at least unless siri lied :P

local FURC_CANBEPICKED_WW		= GetString(SI_FURC_CANBEPICKED) .. " from woodworkers"
local FURC_CANBEPICKED_ASS 	    = GetString(SI_FURC_CANBEPICKED) .. " from outlaws and assassins"
local FURC_CANBEPICKED_GUARD	= GetString(SI_FURC_CANBEPICKED) .. " from guards"

local FURC_CANBESTOLENINCC 		= GetString(SI_FURC_CANBESTOLEN) .. " in Clockwork City"
local FURC_CANBESTOLEN_SCHOLARS = GetString(SI_FURC_CANBESTOLEN) .. " from scholars"
local FURC_CANBESTOLEN_NERDS	= FURC_CANBESTOLEN_SCHOLARS      .. " and mages"
local FURC_CANBESTOLEN_RELIG	= GetString(SI_FURC_CANBESTOLEN) .. " from priests and pilgrims"
local FURC_CANBESTOLEN_THIEF	= GetString(SI_FURC_CANBESTOLEN) .. " from thieves"
local FURC_CANBESTOLEN_WW	    = GetString(SI_FURC_CANBESTOLEN) .. " from woodworkers"
local FURC_CANBESTOLEN_WW	    = GetString(FURC_CANBESTOLEN_DRUNKARDS) .. " from drunkards"

local FURC_PLANTS_VVARDENFELL   = GetString(FURC_PLANTS) .. " on Vvardenfell"
local FURC_CANBESTOLEN_WROTHGAR	= GetString(SI_FURC_CANBESTOLEN) .. " in Wrothgar"

local FURC_AUTOMATON_CC			= GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local FURC_AUTOMATON_VV			= GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"

local FURC_HARVEST_CHARBOR		= GetString(SI_FURC_HARVEST) .. " in Coldharbour"

local FURC_SCAMBOX_F_ATRO		= zo_strformat("<<1>> (<<2>>)",
                                                GetString(SI_FURC_SCAMBOX), GetString(SI_FURC_FLAME_ATRONACH))

local FURC_DB_POISON			= zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local FURC_DB_SNEAKY			= zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))

local onSummerset               = " on Summerset"

local FURC_FISHING_SUMMERSET    = GetString(SI_FURC_CANBEFISHED) .. onSummerset
local FURC_DROP_ALTMER          = GetString(SI_FURC_DROP) .. onSummerset

local function getCrownPrice(price)
    return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end

local function getScamboxString(scamboxVersion)
    return string.format("%s (%s)", GetString(SI_FURC_SCAMBOX), GetString(scamboxVersion))
end
local function getHouseString(houseId1, houseId2)
    local houseName = GetCollectibleName(houseId1)
    if houseId2 then houseName = houseName .. ", " .. GetCollectibleName(houseId2) end
    return zo_strformat(GetString(SI_FURC_HOUSE), houseName)
end

local questRewardLilandril = GetString(SI_FURC_QUESTREWARD) .. "Lilandril"
local mephalaItemSet = GetString(SI_FURC_ITEMSOURCE_ITEMPACK) .. "'Trappings of Mephala Worship'"
FurC.MiscItemSources[FURC_ALTMER] = {
    [FURC_CROWN] = {
        [130206] = getCrownPrice(370), 	            -- Ayleid Apparatus, Welkynd

        [139061] = getCrownPrice(20),               -- Giant Clam, Sealed

        [139064] = getCrownPrice(20), 	            -- Flowers, Hummingbird Mint
        [139065] = getCrownPrice(20), 	            -- Flowers, Lizard Tail
        [139066] = getCrownPrice(30), 	            -- Plant, Redtop Grass
        [139067] = getCrownPrice(20), 	            -- Flower, Yellow Oleander
        [139068] = getCrownPrice(20), 	            -- Plants, Springwheeze

        [139069] = getCrownPrice(410),              -- Painting of Griffin Nest, Refined
        [139070] = getCrownPrice(410),              -- Painting of College of the Sapiarchs, Refined
        [139071] = getCrownPrice(410),              -- Painting of High Elf Tower, Refined
        [139072] = getCrownPrice(410),              -- Painting of Monastery of Serene Harmony, Refined
        [139073] = getCrownPrice(410),              -- Painting of Summerset Coast, Refined  
        [139074] = getCrownPrice(410),              -- Painting of Aldmeri Ruins, Refined
        [139075] = getCrownPrice(410),              -- Painting of Sinkhole, Refined
        [139076] = getCrownPrice(410),              -- Painting of Ancient Road, Refined

        -- [139077] = getCrownPrice(20),            -- Coral Formation, Bulwark
        [139078] = getCrownPrice(20),               -- Coral Formation, Tree Antler
        -- [139079] = getCrownPrice(20),            -- Coral Formation, Fan Cluster
        -- [139080] = getCrownPrice(20),            -- Coral Formation, Ancient Pillar Polyps
        -- [139081] = getCrownPrice(20),            -- Plants, Sea Grapes
        -- [139082] = getCrownPrice(20),            -- Plants, Ruby Glasswort Patch

        [139083] = getCrownPrice(30), 	            -- Plants, Grasswort Patch
        -- [139084] = getCrownPrice(20),            -- Plants, Pearlwort Cluster

        [139088] = getCrownPrice(50),               -- Alinor Table Runner, Verdant
        [139089] = getCrownPrice(50),               -- Alinor Table Runner, Coiled
        [139090] = getCrownPrice(100),              -- Alinor Table Runner, Cloth of Silver

        [139097] = mephalaItemSet,                  -- Spiral Skein Glowstalks, Sprouts

        [139126] = getCrownPrice(50),               -- Sapling, Ginkgo

        [139140] = getCrownPrice(340),              -- Crystals, Crimson Spray
        [139141] = getCrownPrice(310),              -- Crystals, Crimson Bed
        [139142] = getCrownPrice(380),              -- Crystals, Crimson Spikes
        [139143] = getCrownPrice(310),              -- Crystals, Midnight Cluster
        [139144] = getCrownPrice(400),              -- Crystals, Midnight Spire
        [139145] = getCrownPrice(430),              -- Crystals, Midnight Tower
        [139146] = getCrownPrice(490),              -- Crystals, Midnight Bloom

        [139147] = getCrownPrice(30),               -- Plants, Scarlet Sawleaf
        [139148] = getCrownPrice(70),               -- Mushroom, Nettlecap

        [139150] = getCrownPrice(70),               -- Mushrooms, Midnight Cluster
        [139151] = getCrownPrice(140),              -- Mushrooms, Shadowpalm Cluster

        [139152] = getCrownPrice(360),              -- Cocoon, Enormous Empty
        [139153] = getCrownPrice(40),               -- Cocoon, Dormant
        [139154] = getCrownPrice(40),               -- Cocoons, Dormant Cluster
        [139155] = getCrownPrice(80),               -- Cocoon, Food Storage
        [139156] = getCrownPrice(360),              -- Cocoon, Skeleton
        [139157] = getCrownPrice(90), 	            -- Webs, Thick Sheet

        [139158] = getCrownPrice(150),              -- Daedric Candelabra, Tall
        [139159] = getCrownPrice(920),              -- Daedric Chandelier, Gruesome
        [139160] = getCrownPrice(200),              -- Daedric Armchair, Severe
        [139161] = getCrownPrice(1500),             -- Daedric Table, Grand Necropolis
        [139162] = getCrownPrice(140), 	            -- Webs, Cone

        [139198] = getCrownPrice(190),              -- Alinor Lantern, Hanging
        [139199] = getCrownPrice(190),              -- Alinor Lantern, Stationary
        [139200] = getCrownPrice(220),              -- Alinor Sconce, Wrought Glass
        [139201] = getCrownPrice(220),              -- Alinor Sconce, Arched Glass
        [139202] = getCrownPrice(220),              -- Alinor Sconce, Lantern
        [139203] = getCrownPrice(140),              -- Alinor Brazier, Standing Coals
        [139204] = getCrownPrice(260),              -- Alinor Brazier, Noble
        [139205] = getCrownPrice(110),              -- Alinor Candelabra, Wrought Iron
        [139206] = getCrownPrice(25),               -- Alinor Sconce, Candles
        [139207] = getCrownPrice(25),               -- Alinor Sconce, Candles Tall
        [139208] = getCrownPrice(60),               -- Alinor Candles, Tall Stand
        [139209] = getCrownPrice(60),               -- Alinor Candles, Tall
        [139210] = getCrownPrice(140),              -- Alinor Brazier, Hanging Coals
        [139212] = getCrownPrice(410),              -- Alinor Streetlight, Wrought Iron        

        [139163] = mephalaItemSet,                  -- Mephala, The Webspinner (statue)

        [139293] = getCrownPrice(30),               -- Alinor Chalice, Silver Ornate

        [139237] = getCrownPrice(190),              -- Alinor Wall Mirror, Noble

        [139329] = getCrownPrice(45),               -- Coral Formation, Heart
        [139330] = getCrownPrice(45),               -- Coral Formation, Waving Hands
        [139331] = getCrownPrice(45),               -- Coral Formation, Tree Antler
        [139332] = getCrownPrice(45),               -- Coral Formation, Tree Shelf
        [139333] = getCrownPrice(45),               -- Coral Formation, Trees Capped
        [139334] = getCrownPrice(20),               -- Coral Formation, Tree Capped (green)

        [139335] = getCrownPrice(310),              -- Tree, Shade Ancient
        [139336] = getCrownPrice(90),               -- Trees, Shade Interwoven
        [139337] = getCrownPrice(580),              -- Tree, Ancient Blooming Ginkgo       

        [139338] = getCrownPrice(25),               -- Vines, Sun-Bronzed Ivy Swath
        [139339] = getCrownPrice(25),               -- Vines, Sun-Bronzed Ivy Climber

        [139340] = getCrownPrice(310),              -- Tree, Ancient Summerset Spruce
        [139341] = getCrownPrice(310),              -- Tree, Towering Poplar        
        [139342] = getCrownPrice(45),               -- Tree, Vibrant Pink
        [139343] = getCrownPrice(45),               -- Tree, Cloud White

        [139344] = getCrownPrice(45),               -- Flowers, Hummingbird Mint Cluster
        [139345] = getCrownPrice(45),               -- Flowers, Lizard Tail Cluster
        [139346] = getCrownPrice(45),               -- Flowers, Lizard Tail Patch
        [139347] = getCrownPrice(45),               -- Flowers, Yellow Oleander Cluster

        [139348] = getCrownPrice(940),              -- Alinor Pergola, Purple Wisteria
        [139349] = getCrownPrice(940),              -- Alinor Pergola, Blue Wisteria Peaked
        [139350] = getCrownPrice(940),              -- Alinor Pergola, Purple Wisteria Overhang

        [139351] = getCrownPrice(200),              -- Alinor Monument, Marble        
        [139352] = getCrownPrice(1000),             -- Alinor Tomb, Ornate       

        [139353] = getCrownPrice(340),              -- Mind Trap Coral Spire, Branched
        [139354] = getCrownPrice(340),              -- Mind Trap Coral Spire, Bulbous
        [139355] = getCrownPrice(340),              -- Mind Trap Coral Formation, Heart
        [139356] = getCrownPrice(340),              -- Mind Trap Coral Formation, Waving Hands
        [139357] = getCrownPrice(340),              -- Mind Trap Coral Formation, Tree Antler
        [139358] = getCrownPrice(340),              -- Mind Trap Coral Formation, Tree Capped
        [139359] = getCrownPrice(340),              -- Mind Trap Coral Formation, Trees Capped
        [139360] = getCrownPrice(510),              -- Mind Trap Kelp, Cluster
        [139361] = getCrownPrice(270),              -- Mind Trap Kelp, Young

        [139362] = getCrownPrice(340),              -- Sload Astral Nodule, Small
        [139363] = getCrownPrice(340),              -- Sload Astral Nodule, Large
        [139364] = getCrownPrice(1500),             -- Sload Neural Tree, Active

        [139365] = getCrownPrice(370),              -- Psijic Lighting Globe, Framed

        [139366] = getCrownPrice(2000),             -- Alinor Fountain, Regal        
        [139368] = getCrownPrice(100),              -- Alinor Bathing Robes, Decorative

        [139376] = getCrownPrice(260),              -- Alinor Banner, Hanging                    

        [139481] = getCrownPrice(200),              -- Alinor Column, Jagged Timeworn
        [139482] = getCrownPrice(200),              -- Alinor Column, Huge Timeworn
        [139483] = getCrownPrice(90),               -- Alinor Column, Tumbled Timeworn

        [139480] = getCrownPrice(30),               -- Plants, Redtop Grass Tuft
        [139650] = getCrownPrice(30),               -- Bushes, Ivy Cluster

        [140220] = mephalaItemSet,                  -- Rumours of the Spiral Skein

    }, 
    [FURC_DROP] = {

        [139059] = GetString(SI_FURC_DROP),         -- Ivory, Polished - drops from Echatere, and probably alot else
        [139066] = GetString(SI_FURC_HARVEST),      -- Plant, Redtop Grass

        [139060] = GetString(SI_FURC_GIANT_CLAM),   -- Giant Clam, Ancient
        [139062] = GetString(SI_FURC_GIANT_CLAM),   -- Pearl, Large
        [139063] = GetString(SI_FURC_GIANT_CLAM),   -- Pearl, Enormous

        [139073] = questRewardLilandril             -- Painting of Summerset Coast, Refined
    },
    [FURC_FISHING] = {
        [139080] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Ancient Pillar Polyps
        [139079] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Fan Cluster
        [139081] = FURC_FISHING_SUMMERSET,  -- Plant, Sea Grapes  
        [139084] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
        [139085] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
        [139068] = FURC_FISHING_SUMMERSET,  -- Plants, Springwheeze
        [139077] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Bulwark
        [139078] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Pillar Polyps   
        [139067] =FURC_FISHING_SUMMERSET,   -- Flower, Yellow Oleander
        [139082] =FURC_FISHING_SUMMERSET,   -- Plants, Ruby Glasswort Patch
        [139068] =FURC_FISHING_SUMMERSET,   -- Plants, Springwheeze  
    }

} -- Reach
FurC.MiscItemSources[FURC_DRAGONS] = { -- Reach
    [FURC_DROP] = {
        [134909] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushrooms, Puspocket Group
        [134910] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushrooms, Puspocket Cluster
        [134911] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushroom, Puspocket Sporecap
        [134912] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushroom, Large Puspocket
        [134913] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushroom, Tall Puspocket
        [134914] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), 	-- Mushrooms, Large Puspocket Cluster
    },
    [FURC_JUSTICE] 	= {},
    [FURC_CROWN] 	= {
        [134970] = getCrownPrice(100), 	-- Mushrooms, Glowing Sprawl
        [134947] = getCrownPrice(100), 	-- Mushrooms, Glowing Field
        [134948] = getCrownPrice(400),	-- Mushrooms, Glowing Cluster
        [134971] = getCrownPrice(400),	-- Candles, Votive Group
        [134872] = getCrownPrice(400),	-- Ancient Nord Brazier, Dragon Crest
        [134863] = getCrownPrice(400),	-- Ancient Nord Sconce, Dragon Crest
        [134972] = getCrownPrice(400),	-- Brotherhood Brazier, Wrought Iron
        [134849] = getCrownPrice(400),	-- Monarch Butterfly Flock
        [134848] = getCrownPrice(400),	-- Blue Butterfly Flock
        [94100]  = getCrownPrice(50),	-- Imperial BookCase, Swirled
        [130211] = getCrownPrice(50),	-- Books, Ordered Row
        [130210] = getCrownPrice(50),	-- Books, Scattered Row
    }
}

FurC.MiscItemSources[FURC_CLOCKWORK] = { -- Reach
    [FURC_DROP] = {
        [134407] = FURC_AUTOMATON_CC,			-- Factotum Torso, Obsolete
        [134404] = FURC_AUTOMATON_CC,			-- Factotum Knee, Obsolete
        [134408] = FURC_AUTOMATON_CC,			-- Factotum Elbow, Obsolete
        [134405] = FURC_AUTOMATON_CC,			-- Factotum Arm, Obsolete
        [134409] = FURC_AUTOMATON_CC,			-- Factotum Head, Obsolete
        [134406] = FURC_AUTOMATON_CC,			-- Factotum Body, Obsolete

    },
    [FURC_JUSTICE] 	= {
        [134410] = FURC_CANBESTOLENINCC, 		    -- Clockwork Crank, Miniature
        [134411] = FURC_CANBESTOLENINCC, 		    -- Clockwork Gear Shaft, Miniature
        [134412] = FURC_CANBESTOLENINCC, 		    -- Clockwork Piston, Miniature
        [134413] = FURC_CANBESTOLENINCC, 		    -- Clockwork Magnifier, Handheld
        [134414] = FURC_CANBESTOLENINCC, 		    -- Clockwork Micrometer, Handheld
        [134415] = FURC_CANBESTOLENINCC, 		    -- Clockwork Dial Calipers, Handheld
        [134416] = FURC_CANBESTOLENINCC, 		    -- Clockwork Slide Calipers, Handheld
        [134402] = GetString(SI_FURC_CANBESTOLEN), 	-- Spool, Empty
        [134400] = GetString(SI_FURC_CANBESTOLEN), 	-- Soft Leather, Stacked
        [134401] = GetString(SI_FURC_CANBESTOLEN), 	-- Soft Leather, Folded
        [134417] = GetString(SI_FURC_CANBESTOLEN), 	-- Calipers, Handheld
        [134399] = GetString(SI_FURC_CANBESTOLEN), 	-- Quality Fabric, Folded
        [117939] = FURC_CANBESTOLEN_WW, 		    -- Rough Axe, Practical
    },
    [FURC_CROWN] 	= {
        [134266] = getCrownPrice(80), 	-- Daedric Books, Stacked
        [134265] = getCrownPrice(80), 	-- Daedric Books, Piled

    }
}

FurC.MiscItemSources[FURC_REACH] = { -- Reach
    [FURC_JUSTICE] 	= {
        [130191] = GetString(SI_FURC_CANBESTOLEN), 			-- Shivering Cheese
        [118206] = FURC_CANBESTOLEN_THIEF, 		            -- Gaming dice
    },
    [FURC_CROWN] 	= {
        [131423] = getCrownPrice(750),
    },
    [FURC_DROP] 	= {
        -- Coldharbour items
        [130284] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Seedlings
        [131422] = GetString(SI_FURC_HARVEST),          -- Flower Patch, Glowstalks
        [130283] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Sprout
        [130285] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Young
        [131420] = GetString(SI_FURC_HARVEST),          -- Shrub, Glowing Thistle
        [130281] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Towering
        [130282] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Strong

        [130067] = GetString(SI_FURC_DAEDRA_SOURCE), 	-- Daedric Chain Segment
    },
}

local questRewardSuran = GetString(SI_FURC_QUESTREWARD) .. " Suran"
FurC.MiscItemSources[FURC_MORROWIND]	= {             -- Morrowind
    [FURC_DROP] 	= {

        -- Dwemer parts
        [126660] = FURC_AUTOMATON_VV, 			        -- Dwemer Gear, Tiered
        [126659] = FURC_AUTOMATON_VV, 			        -- Dwemer Gear, Flat

        -- lootable in tombs
        [126754] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Seeker
        [126705] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Wisdom
        [126704] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Majesty
        [126706] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Knowledge
        [126701] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Nerevar
        [126764] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Prowess
        [126702] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Reverance
        [126700] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Honor
        [126703] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Mysteries
        [126752] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Discovery
        [126755] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Change
        [126756] = GetString(SI_FURC_TOMBS), 			-- Velothi Shroud, Mercy

        [126773] = GetString(SI_FURC_TOMBS), 			-- Velothi Caisson, Crypt
        [126753] = GetString(SI_FURC_TOMBS),			-- Velothi Cerecloth, Austere
        [126758] = GetString(SI_FURC_TOMBS),			-- Velothi Mat, Prayer
        [126757] = GetString(SI_FURC_TOMBS),

        [126462] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Volcanic
        [126463] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Forest
        [126464] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Valley

        [126465] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Volcanic
        [126466] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Forest
        [126467] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Valley

        [126468] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Volcanic
        [126469] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Forest
        [126470] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Valley

        [126592] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Volcano
        [126593] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Volcano
        [126594] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Volcano
        [126595] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Volcano
        [126596] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Volcano
        [126597] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Volcano

        [126605] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Waterfall
        [126606] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Waterfall
        [126607] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Waterfall
        [126608] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Waterfall
        [126609] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Waterfall
        [126598] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Waterfall
        [126599] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Geyser
        [126600] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Geyser
        [126601] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Geyser
        [126602] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Geyser
        [126603] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Geyser
        [126604] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Geyser

        -- Ashlander dailies
        [126119] = GetString(SI_FURC_DAILY_ASH), 	    -- Crimson Shard of Moonshadow
        [126393] = GetString(SI_FURC_DAILY_ASH), 		-- Crimson Shard of Moonshadow

        -- drops from plants
        [125631] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Ash Frond
        [125647] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Ash Frond
        [131420] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Ash Frond
        [125553] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage Stalks
        [125551] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage
        [125552] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage Patch
        [125543] = FURC_PLANTS_VVARDENFELL, 		    -- Fern, Ashen
        [125633] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Hanging Pitcher Pair

        [125551] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage			
        [125552] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage Patch	
        [125553] = FURC_PLANTS_VVARDENFELL, 		    -- Flowers, Netch Cabbage Stalks	
        [125562] = FURC_PLANTS_VVARDENFELL, 		    -- Grass, Foxtail Cluster			
        [125595] = FURC_PLANTS_VVARDENFELL, 		    -- Mushroom, Poison Pax Shelf		
        [125596] = FURC_PLANTS_VVARDENFELL, 		    -- Mushroom, Poison Pax Stool		
        [125600] = FURC_PLANTS_VVARDENFELL, 		    -- Mushroom, Spongecap Patch		
        [125606] = FURC_PLANTS_VVARDENFELL, 		    -- Mushroom, Young Milkcap			
        [125608] = FURC_PLANTS_VVARDENFELL, 		    -- Mushrooms, Buttercake Cluster	
        [125609] = FURC_PLANTS_VVARDENFELL, 		    -- Mushrooms, Buttercake Stack		
        [125613] = FURC_PLANTS_VVARDENFELL, 		    -- Mushrooms, Lavaburst Sprouts	
        [125590] = FURC_PLANTS_VVARDENFELL, 		    -- Mushrooms, Lavaburst Cluster	
        [125617] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Bitter Stalk				
        [125618] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Golden Lichen			
        [125619] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Hanging Pitcher			
        [125620] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Hefty Elkhorn			
        [125621] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Lava Brier				
        [125622] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Lava Leaf				
        [125630] = FURC_PLANTS_VVARDENFELL, 		    -- Plant, Young Elkhorn			
        [125631] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Ash Frond				
        [125632] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Hanging Pitcher Cluster	
        [125633] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Hanging Pitcher Pair	
        [125634] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Lava Pitcher Cluster	
        [125635] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Lava Pitcher Shoots		
        [125636] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Swamp Pitcher Cluster	
        [125637] = FURC_PLANTS_VVARDENFELL, 		    -- Plants, Swamp Pitcher Shoots	
        [125647] = FURC_PLANTS_VVARDENFELL, 		    -- Shrub, Bitter Brush				
        [125648] = FURC_PLANTS_VVARDENFELL, 		    -- Shrub, Bitter Cluster			
        [125649] = FURC_PLANTS_VVARDENFELL, 		    -- Shrub, Flowering Dusk			
        [125650] = FURC_PLANTS_VVARDENFELL, 		    -- Shrub, Golden Lichen			
        [125670] = FURC_PLANTS_VVARDENFELL, 		    -- Toadstool, Bloodtooth			
        [125671] = FURC_PLANTS_VVARDENFELL, 		    -- Toadstool, Bloodtooth Cap		
        [125672] = FURC_PLANTS_VVARDENFELL, 		    -- Toadstool, Bloodtooth Cluster	

        [126759] = questRewardSuran,                    -- Sir Sock's Ball of Yarn

        [126592] = GetString(SI_FURC_PLANTS), 			-- Plants, Hanging Pitcher Pair

    },
    [FURC_CROWN] 	= {
        [125566] = getHouseString(1243),                -- Hlaalu Shed, Enclosed
        [125568] = getHouseString(1243),                -- Hlaalu Sidewalk, Sillar Stone
        [125577] = getHouseString(1243),                -- Hlaalu Wall Post, Sillar Stone
        [125579] = getHouseString(1243),                -- Hlaalu Well, Braced Sillar Stone
        [125573] = getHouseString(1243, 1244),          -- Hlaalu Streetlamp, Paper
        [125565] = getHouseString(1244),                -- Hlaalu Lantern, Hanging Paper
        [125567] = getHouseString(1244),                -- Hlaalu Shed, Open
        [125580] = getHouseString(1244),                -- Hlaalu Well, Covered Sillar Stone
        [118663] = getHouseString(1078, 1079),          -- Dark Elf Bed of Coals

    },
    [FURC_JUSTICE] 	= {
        [126481] = FURC_CANBESTOLEN_RELIG .. " on Vvardenfell", -- Indoril Incense, Burning
        [126772] = FURC_CANBESTOLEN_THIEF 		        -- Khajiiti Ponder sphere
    },
}
FurC.MiscItemSources[FURC_HOMESTEAD]	= {
    [FURC_JUSTICE] 	= {
            -- stealing
        [118489] = FURC_CANBESTOLEN_SCHOLARS, 	        -- Papers, Stack
        [118528] = GetString(SI_FURC_CANBESTOLEN), 		-- Signed Contract
        [118890] = GetString(SI_FURC_CANBESTOLEN), 		-- Skull, Human
        [118487] = FURC_CANBESTOLEN_SCHOLARS, 	        -- Letter, Personal
        [120008] = FURC_CANBESTOLEN_NERDS, 		        -- Lesser Soul Gem, Empty
        [120005] = FURC_CANBESTOLEN_NERDS, 		        -- Medium Soul Gem, Empty

        -- Bounty Sheets
        [118711] = FURC_CANBEPICKED_GUARD, 				-- Argonian Male
        [118709] = FURC_CANBEPICKED_GUARD, 				-- Breton Male
        [118712] = FURC_CANBEPICKED_GUARD, 				-- Breton Woman
        [118715] = FURC_CANBEPICKED_GUARD, 				-- Colovian Man
        [118710] = FURC_CANBEPICKED_GUARD, 				-- High Elf Male
        [118714] = FURC_CANBEPICKED_GUARD, 				-- Imperial Man
        [118713] = FURC_CANBEPICKED_GUARD, 				-- Khajiiti Male
        [118716] = FURC_CANBEPICKED_GUARD, 				-- Orc Female
        [118717] = FURC_CANBEPICKED_GUARD, 				-- Orc Male

        [121055] = FURC_CANBESTOLEN_DRUNKARDS, 			-- Breton Mug, Full

        [116512] = FURC_CANBESTOLEN_WROTHGAR,		    -- Orcish Carpet Blood

    },
    [FURC_FISHING] 	= {
        -- fishing
        [118902] = GetString(SI_FURC_CANBEFISHED), 		-- Coral, Sun
        [118903] = GetString(SI_FURC_CANBEFISHED), 		-- Coral, Crown
        [118896] = GetString(SI_FURC_CANBEFISHED), 		-- Seashell, Sandcake
        [118901] = GetString(SI_FURC_CANBEFISHED), 		-- Sea sponge
        [118338] = GetString(SI_FURC_CANBEFISHED), 		-- Fish, Bass
        [118339] = GetString(SI_FURC_CANBEFISHED), 		-- Fish, Salmon
        [118337] = GetString(SI_FURC_CANBEFISHED), 		-- Fish, Trout
        [120753] = GetString(SI_FURC_CANBEFISHED), 		-- Kelp, Green Pile
        [120755] = GetString(SI_FURC_CANBEFISHED), 		-- Kelp, Lush Pile
        [120754] = GetString(SI_FURC_CANBEFISHED), 		-- Kelp, Small Pile
        [118897] = GetString(SI_FURC_CANBEFISHED), 		-- Seashell, Pink Scallop
        [118898] = GetString(SI_FURC_CANBEFISHED), 		-- Seashell, White Scallop
        [118899] = GetString(SI_FURC_CANBEFISHED), 		-- Seashell, Starfish
        [118900] = GetString(SI_FURC_CANBEFISHED), 		-- Seashell, Noble Starfish

    },
    [FURC_DROP]		= {
        [121058] = FURC_DB_SNEAKY, 						-- Candles of Silence

        [119936] = FURC_DB_POISON, 						-- Poisoned Blood
        [119938] = FURC_DB_POISON, 						-- Light and Shadow
        [119952] = FURC_DB_POISON, 						-- Sacrificial Heart

        -- Paintings
        [118216] = GetString(SI_FURC_CHESTS), 		    -- Painting of Spring, Sturdy
        [118217] = GetString(SI_FURC_CHESTS), 		    -- Painting of Pasture, Sturdy
        [118218] = GetString(SI_FURC_CHESTS), 		    -- Painting of Creek, Sturdy
        [118219] = GetString(SI_FURC_CHESTS), 		    -- Painting of Lakes, Sturdy
        [118220] = GetString(SI_FURC_CHESTS), 		    -- Painting of Crags, Sturdy
        [118221] = GetString(SI_FURC_CHESTS), 		    -- Painting of Summer, Sturdy
        [118222] = GetString(SI_FURC_CHESTS), 		    -- Painting of Jungle, Sturdy
        [118223] = GetString(SI_FURC_CHESTS), 		    -- Painting of Palms, Sturdy
        [118265] = GetString(SI_FURC_CHESTS), 		    -- Painting of Winter, Bolted
        [118266] = GetString(SI_FURC_CHESTS), 		    -- Painting of Bridge, Bolted
        [118267] = GetString(SI_FURC_CHESTS), 		    -- Painting of Autumn, Bolted
        [118268] = GetString(SI_FURC_CHESTS), 		    -- Painting of Great Ruins, Bolted

    },
    [FURC_CROWN]	= {
        [118096] = getCrownPrice(10), 			        -- Bread, Plain
        [118098] = getCrownPrice(10), 			        -- Common Bowl, Serving
        [118061] = getCrownPrice(15), 			        -- Chicken Dinner, Display
        [118062] = getCrownPrice(15), 			        -- Chicken Meal, Display
        [118056] = getCrownPrice(15), 			        -- Common Stewpot, Hanging
        [118121] = getCrownPrice(15), 			        -- Knife, Carving
        [118066] = getCrownPrice(15), 			        -- Steak Dinner

        [118057] = getCrownPrice(20), 				    -- Sack of Beans
        [118060] = getCrownPrice(20), 				    -- Sack of Grain
        [118059] = getCrownPrice(20), 				    -- Sack of Millet,
        [118058] = getCrownPrice(20), 				    -- Sack of Rice

        [134473] = getScamboxString(SI_FURC_FLAME_ATRONACH),    -- Malacath Banner

        [118064] = getCrownPrice(45), 			-- Common Barrel, Dry
        [118065] = getCrownPrice(45), 			-- Common Cargo Crate, Dry
        [118064] = getCrownPrice(45), 			-- Common Barrel, Dry

        [118054] = getCrownPrice(80), 			-- Common Firepit, Outdoor
        [118055] = getCrownPrice(80), 			-- Common Firepit, Piled
        [118126] = getCrownPrice(95), 			-- Plaque, Standard

        [118068] = getCrownPrice(120), 			-- Simple Brown Banner
        [118069] = getCrownPrice(120), 			-- Simple Gray Banner
        [118071] = getCrownPrice(120), 			-- Simple Red Banner
        [118070] = getCrownPrice(120), 			-- Simple Purple Banner
        
        
        [120607] = getCrownPrice(50), 			-- Sapling, Lanky Ash
        

        [115698] = getCrownPrice(1100), 		-- Khajiit Statue, Guardian
    }
}
