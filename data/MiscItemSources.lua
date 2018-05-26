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

local FURC_FISHING_SUMMERSET    = GetString(SI_FURC_CANBEFISHED) .. " on Summerset"

local function getCrownStorePriceString(price)
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

FurC.MiscItemSources[FURC_ALTMER] = {
    [FURC_CROWN] = {
        [130206] = getCrownStorePriceString(370), 	-- Ayleid Apparatus, Welkynd
    }, 
    [FURC_DROP] = {
        [139066] = GetString(SI_FURC_HARVEST),      -- Plant, Redtop Grass
        
        [139060] = GetString(SI_FURC_GEYSIR),  -- Giant Clam, Ancient
    },
    [FURC_FISHING] = {
        [139080] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Ancient Pillar Polyps
        [139079] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Fan Cluster
        [139081] = FURC_FISHING_SUMMERSET,  -- Plant, Sea Grapes  
        [139084] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
        [139085] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
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
        [134970] = getCrownStorePriceString(100), 	-- Mushrooms, Glowing Sprawl
        [134947] = getCrownStorePriceString(100), 	-- Mushrooms, Glowing Field
        [134948] = getCrownStorePriceString(400),	-- Mushrooms, Glowing Cluster
        [134971] = getCrownStorePriceString(400),	-- Candles, Votive Group
        [134872] = getCrownStorePriceString(400),	-- Ancient Nord Brazier, Dragon Crest
        [134863] = getCrownStorePriceString(400),	-- Ancient Nord Sconce, Dragon Crest
        [134972] = getCrownStorePriceString(400),	-- Brotherhood Brazier, Wrought Iron
        [134849] = getCrownStorePriceString(400),	-- Monarch Butterfly Flock
        [134848] = getCrownStorePriceString(400),	-- Blue Butterfly Flock
        [94100]  = getCrownStorePriceString(50),	-- Imperial BookCase, Swirled
        [130211]  = getCrownStorePriceString(50),	-- Books, Ordered Row
        [130210]  = getCrownStorePriceString(50),	-- Books, Scattered Row
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
        [134266] = getCrownStorePriceString(80), 	-- Daedric Books, Stacked
        [134265] = getCrownStorePriceString(80), 	-- Daedric Books, Piled

    }
}

FurC.MiscItemSources[FURC_REACH] = { -- Reach
    [FURC_JUSTICE] 	= {
        [130191] = GetString(SI_FURC_CANBESTOLEN), 			-- Shivering Cheese
        [118206] = FURC_CANBESTOLEN_THIEF, 		            -- Gaming dice
    },
    [FURC_CROWN] 	= {
        [131423] = getCrownStorePriceString(750),
    },
    [FURC_DROP] 	= {
        -- Coldharbour items
        [130284] = GetString(SI_FURC_HARVEST), 		                -- Glowstalk, Seedlings
        [131422] = GetString(SI_FURC_HARVEST), 		                -- Flower Patch, Glowstalks
        [130283] = GetString(SI_FURC_HARVEST), 		                -- Glowstalk, Sprout
        [130285] = GetString(SI_FURC_HARVEST), 		                -- Glowstalk, Young
        [131420] = GetString(SI_FURC_HARVEST), 		                -- Shrub, Glowing Thistle
        [130281] = GetString(SI_FURC_HARVEST), 		                -- Glowstalk, Towering
        [130282] = GetString(SI_FURC_HARVEST), 		                -- Glowstalk, Strong

        [130067] = GetString(SI_FURC_DAEDRA_SOURCE), 			-- Daedric Chain Segment
    },
}
FurC.MiscItemSources[FURC_MORROWIND]	= { -- Morrowind
    [FURC_DROP] 	= {

        -- Dwemer parts
        [126660] = FURC_AUTOMATON_VV, 			-- Dwemer Gear, Tiered
        [126659] = FURC_AUTOMATON_VV, 			-- Dwemer Gear, Flat

        -- lootable in tombs
        [126754] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Seeker
        [126705] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Wisdom
        [126704] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Majesty
        [126706] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Knowledge
        [126701] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Nerevar
        [126764] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Prowess
        [126702] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Reverance
        [126700] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Honor
        [126703] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Mysteries
        [126752] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Discovery
        [126755] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Change
        [126756] = GetString(SI_FURC_TOMBS), 					-- Velothi Shroud, Mercy

        [126773] = GetString(SI_FURC_TOMBS), 					-- Velothi Caisson, Crypt
        [126753] = GetString(SI_FURC_TOMBS),					-- Velothi Cerecloth, Austere
        [126758] = GetString(SI_FURC_TOMBS),					-- Velothi Mat, Prayer
        [126757] = GetString(SI_FURC_TOMBS),


        [126462] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Oversized Volcanic
        [126463] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Oversized Forest
        [126464] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Oversized Valley

        [126465] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Modest Volcanic
        [126466] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Modest Forest
        [126467] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Modest Valley

        [126468] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Classic Volcanic
        [126469] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Classic Forest
        [126470] = GetString(SI_FURC_DROP_CHEST_VVARDENFELL),     -- Telvanni Painting, Classic Valley


        [126592] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Panels, Volcano
        [126593] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tryptich, Volcano
        [126594] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Classic Volcano
        [126595] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Modest Volcano
        [126596] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tapestry, Volcano
        [126597] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Oversized Volcano

        [126605] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tryptich, Waterfall
        [126606] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tapestry, Waterfall
        [126607] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Oversized Waterfall
        [126608] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Classic Waterfall
        [126609] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Modest Waterfall
        [126598] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Panels, Waterfall
        [126599] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tryptich, Geyser
        [126600] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Tapestry, Geyser
        [126601] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Oversized Geyser
        [126602] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Classic Geyser
        [126603] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Painting, Modest Geyser
        [126604] = GetString(SI_FURC_VVARDENFELL_PAINTING),     -- Velothi Panels, Geyser


        -- Ashlander dailies
        [126119] = GetString(SI_FURC_DAILY_ASHLANDERS), 		-- Crimson Shard of Moonshadow
        [126393] = GetString(SI_FURC_DAILY_ASHLANDERS), 		-- Crimson Shard of Moonshadow

        -- drops from plants
        [125631] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Ash Frond
        [125647] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Ash Frond
        [131420] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Ash Frond
        [125553] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage Stalks
        [125551] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage
        [125552] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage Patch
        [125543] = FURC_PLANTS_VVARDENFELL, 		            -- Fern, Ashen
        [125633] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Hanging Pitcher Pair
                                                                
        [125551] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage			
        [125552] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage Patch	
        [125553] = FURC_PLANTS_VVARDENFELL, 		            -- Flowers, Netch Cabbage Stalks	
        [125562] = FURC_PLANTS_VVARDENFELL, 		            -- Grass, Foxtail Cluster			
        [125595] = FURC_PLANTS_VVARDENFELL, 		            -- Mushroom, Poison Pax Shelf		
        [125596] = FURC_PLANTS_VVARDENFELL, 		            -- Mushroom, Poison Pax Stool		
        [125600] = FURC_PLANTS_VVARDENFELL, 		            -- Mushroom, Spongecap Patch		
        [125606] = FURC_PLANTS_VVARDENFELL, 		            -- Mushroom, Young Milkcap			
        [125608] = FURC_PLANTS_VVARDENFELL, 		            -- Mushrooms, Buttercake Cluster	
        [125609] = FURC_PLANTS_VVARDENFELL, 		            -- Mushrooms, Buttercake Stack		
        [125613] = FURC_PLANTS_VVARDENFELL, 		            -- Mushrooms, Lavaburst Sprouts	
        [125590] = FURC_PLANTS_VVARDENFELL, 		            -- Mushrooms, Lavaburst Cluster	
        [125617] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Bitter Stalk				
        [125618] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Golden Lichen			
        [125619] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Hanging Pitcher			
        [125620] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Hefty Elkhorn			
        [125621] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Lava Brier				
        [125622] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Lava Leaf				
        [125630] = FURC_PLANTS_VVARDENFELL, 		            -- Plant, Young Elkhorn			
        [125631] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Ash Frond				
        [125632] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Hanging Pitcher Cluster	
        [125633] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Hanging Pitcher Pair	
        [125634] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Lava Pitcher Cluster	
        [125635] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Lava Pitcher Shoots		
        [125636] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Swamp Pitcher Cluster	
        [125637] = FURC_PLANTS_VVARDENFELL, 		            -- Plants, Swamp Pitcher Shoots	
        [125647] = FURC_PLANTS_VVARDENFELL, 		            -- Shrub, Bitter Brush				
        [125648] = FURC_PLANTS_VVARDENFELL, 		            -- Shrub, Bitter Cluster			
        [125649] = FURC_PLANTS_VVARDENFELL, 		            -- Shrub, Flowering Dusk			
        [125650] = FURC_PLANTS_VVARDENFELL, 		            -- Shrub, Golden Lichen			
        [125670] = FURC_PLANTS_VVARDENFELL, 		            -- Toadstool, Bloodtooth			
        [125671] = FURC_PLANTS_VVARDENFELL, 		            -- Toadstool, Bloodtooth Cap		
        [125672] = FURC_PLANTS_VVARDENFELL, 		            -- Toadstool, Bloodtooth Cluster	
        
        [126759] = GetString(SI_FURC_QUESTREWARD) .. " Suran",  -- Sir Sock's Ball of Yarn

        [126592] = GetString(SI_FURC_PLANTS), 					-- Plants, Hanging Pitcher Pair

    },
    [FURC_CROWN] 	= {
        [125566] = getHouseString(1243),        -- Hlaalu Shed, Enclosed
        [125568] = getHouseString(1243),        -- Hlaalu Sidewalk, Sillar Stone
        [125577] = getHouseString(1243),        -- Hlaalu Wall Post, Sillar Stone
        [125579] = getHouseString(1243),        -- Hlaalu Well, Braced Sillar Stone
        [125573] = getHouseString(1243, 1244),  -- Hlaalu Streetlamp, Paper
        [125565] = getHouseString(1244),        -- Hlaalu Lantern, Hanging Paper
        [125567] = getHouseString(1244),        -- Hlaalu Shed, Open
        [125580] = getHouseString(1244),        -- Hlaalu Well, Covered Sillar Stone
        [118663] = getHouseString(1078, 1079),  -- Dark Elf Bed of Coals
       
    },
    [FURC_JUSTICE] 	= {
        [126481] = FURC_CANBESTOLEN_RELIG .. " on Vvardenfell", -- Indoril Incense, Burning
        [126772] = FURC_CANBESTOLEN_THIEF 		-- Khajiiti Ponder sphere
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
        [118216] = GetString(SI_FURC_CHESTS), 		        -- Painting of Spring, Sturdy
        [118217] = GetString(SI_FURC_CHESTS), 		        -- Painting of Pasture, Sturdy
        [118218] = GetString(SI_FURC_CHESTS), 		        -- Painting of Creek, Sturdy
        [118219] = GetString(SI_FURC_CHESTS), 		        -- Painting of Lakes, Sturdy
        [118220] = GetString(SI_FURC_CHESTS), 		        -- Painting of Crags, Sturdy
        [118221] = GetString(SI_FURC_CHESTS), 		        -- Painting of Summer, Sturdy
        [118222] = GetString(SI_FURC_CHESTS), 		        -- Painting of Jungle, Sturdy
        [118223] = GetString(SI_FURC_CHESTS), 		        -- Painting of Palms, Sturdy
        [118265] = GetString(SI_FURC_CHESTS), 		        -- Painting of Winter, Bolted
        [118266] = GetString(SI_FURC_CHESTS), 		        -- Painting of Bridge, Bolted
        [118267] = GetString(SI_FURC_CHESTS), 		        -- Painting of Autumn, Bolted
        [118268] = GetString(SI_FURC_CHESTS), 		        -- Painting of Great Ruins, Bolted
        


    },
    [FURC_CROWN]	= {
        [118096] = getCrownStorePriceString(10), 			-- Bread, Plain
        [118098] = getCrownStorePriceString(10), 			-- Common Bowl, Serving
        [118061] = getCrownStorePriceString(15), 			-- Chicken Dinner, Display
        [118062] = getCrownStorePriceString(15), 			-- Chicken Meal, Display
        [118056] = getCrownStorePriceString(15), 			-- Common Stewpot, Hanging
        [118121] = getCrownStorePriceString(15), 			-- Knife, Carving
        [118066] = getCrownStorePriceString(15), 			-- Steak Dinner

        [118057] = getCrownStorePriceString(20), 				-- Sack of Beans
        [118060] = getCrownStorePriceString(20), 				-- Sack of Grain
        [118059] = getCrownStorePriceString(20), 				-- Sack of Millet,
        [118058] = getCrownStorePriceString(20), 				-- Sack of Rice

        [134473] = getScamboxString(SI_FURC_FLAME_ATRONACH),    -- Malacath Banner



        [118064] = getCrownStorePriceString(45), 			-- Common Barrel, Dry
        [118065] = getCrownStorePriceString(45), 			-- Common Cargo Crate, Dry
        [118064] = getCrownStorePriceString(45), 			-- Common Barrel, Dry

        [118054] = getCrownStorePriceString(80), 			-- Common Firepit, Outdoor
        [118055] = getCrownStorePriceString(80), 			-- Common Firepit, Piled
        [118126] = getCrownStorePriceString(95), 			-- Plaque, Standard

        [118068] = getCrownStorePriceString(120), 			-- Simple Brown Banner
        [118069] = getCrownStorePriceString(120), 			-- Simple Gray Banner
        [118071] = getCrownStorePriceString(120), 			-- Simple Red Banner
        [118070] = getCrownStorePriceString(120), 			-- Simple Purple Banner

        [115698] = getCrownStorePriceString(1100), 		-- Khajiit Statue, Guardian
    }
}

