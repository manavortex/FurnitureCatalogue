-- use constants because it's a huge performance gain due to how LUA handles strings... at least unless siri lied :P

local FURC_CANBEPICKED 					= "can be pickpocketed"
local FURC_CANBEPICKED_WW				= FURC_CANBEPICKED .. " from woodworkers"
local FURC_CANBEPICKED_ASS 				= FURC_CANBEPICKED .. " from outlaws and assassins"
local FURC_CANBEPICKED_GUARD	 		= FURC_CANBEPICKED .. " from guards"
	
local FURC_CANBESTOLEN 					= "can be stolen"
local FURC_CANBESTOLENINCC 				= FURC_CANBESTOLEN .. " in Clockwork City"
local FURC_CANBESTOLEN_SCHOLARS 		= FURC_CANBESTOLEN .. " from scholars"
local FURC_CANBESTOLEN_NERDS	 		= FURC_CANBESTOLEN_SCHOLARS .. " and mages"
local FURC_CANBESTOLEN_RELIG	 		= FURC_CANBESTOLEN .. " from priests and pilgrims"
local FURC_CANBESTOLEN_THIEF	 		= FURC_CANBESTOLEN .. " from thieves"
	
local FURC_AUTOMATON 					= "from automatons"
local FURC_AUTOMATON_CC					= FURC_AUTOMATON .. " in Clockwork City"
local FURC_AUTOMATON_VV					= FURC_AUTOMATON .. " on Vvardenfell"
local FURC_TOMBS 						= "Ancestor tombs and ruins on Vvardenfell"
	
local FURC_PLANTS						= "from harvesting plants"
	
local FURC_HARVEST						= "from harvesting nodes"
local FURC_HARVEST_CHARBOR				= FURC_HARVEST .. " in Coldharbour"
	
local FURC_CANBEFISHED 					= "can be fished"

local FURC_CROWNSTORE_CRATE_F_ATRO		= "Crown Crates (Flame Atronach)"

local FURC_CROWNSTORESOURCE				= "Crown Store "
local FURC_CROWNSTORE_TEN				= FURC_CROWNSTORESOURCE .. "(10)"
local FURC_CROWNSTORE_FIFTEEN			= FURC_CROWNSTORESOURCE .. "(15)"
local FURC_CROWNSTORE_TWENTY			= FURC_CROWNSTORESOURCE .. "(20)"
local FURC_CROWNSTORE_FOURTYFIVE		= FURC_CROWNSTORESOURCE .. "(45)"
local FURC_CROWNSTORE_EIGHTY			= FURC_CROWNSTORESOURCE .. "(80)"
local FURC_CROWNSTORE_NINETYFIVE		= FURC_CROWNSTORESOURCE .. "(95)"
local FURC_CROWNSTORE_ONEHUNDRED		= FURC_CROWNSTORESOURCE .. "(100)"
local FURC_CROWNSTORE_ONETWENTY			= FURC_CROWNSTORESOURCE .. "(120)"
local FURC_CROWNSTORE_FOURHUNDRED		= FURC_CROWNSTORESOURCE .. "(400)"
local FURC_CROWNSTORE_SEVENFIFTY		= FURC_CROWNSTORESOURCE .. "(750)"
local FURC_CROWNSTORE_ONEK				= FURC_CROWNSTORESOURCE .. "(1000)"
local FURC_CROWNSTORE_ONEONEHUNDRED		= FURC_CROWNSTORESOURCE .. "(1100)"

local FURC_DAEDRA_SOURCE				= "from Daedra and Dolmen chests"
local FURC_DB							= "The Dark Brotherhood supplies vendor hands these out "
local FURC_DB_POISON					= FURC_DB .. "with poison"
local FURC_DB_SNEAKY					= FURC_DB .. "as a way to be sneaky"
	
local FURC_DAILY_ASHLANDERS			= "Ashlander daily quest rewards"
	
local FURC_PLUNDERSKULL				= "Drops from Plunder Skulls during Witches' Festival"


FurC.MiscItemSources 	= {
	
	[FURC_DRAGONS] = { -- Reach	
		[FURC_DROP] = {	
		
			
		},
		[FURC_JUSTICE] 	= {
		},
		[FURC_CROWN] 	= {
		
			[130212] = FURC_CROWNSTORE_ONEK, 		-- Daedric Worship: The Ayleids
			[134970] = FURC_CROWNSTORE_ONEHUNDRED, 	-- Mushrooms, Glowing Sprawl
			[134947] = FURC_CROWNSTORE_ONEHUNDRED, 	-- Mushrooms, Glowing Field
			[134948] = FURC_CROWNSTORE_FOURHUNDRED,	-- Mushrooms, Glowing Cluster
			[134971] = FURC_CROWNSTORE_FOURHUNDRED,	-- Candles, Votive Group
			[134872] = FURC_CROWNSTORE_FOURHUNDRED,	-- Ancient Nord Brazier, Dragon Crest
			[134863] = FURC_CROWNSTORE_FOURHUNDRED,	-- Ancient Nord Sconce, Dragon Crest
			[134972] = FURC_CROWNSTORE_FOURHUNDRED,	-- Brotherhood Brazier, Wrought Iron
			[134849] = FURC_CROWNSTORE_FOURHUNDRED,	-- Monarch Butterfly Flock  
			[134848] = FURC_CROWNSTORE_FOURHUNDRED,	-- Blue Butterfly Flock  
			
		}
	},
	[FURC_CLOCKWORK] = { -- Reach	
		[FURC_DROP] = {	
			[134407] = FURC_AUTOMATON_CC,			-- Torso, Obsolete
			[134404] = FURC_AUTOMATON_CC,			-- Factotum Knee, Obsolete
			[134408] = FURC_AUTOMATON_CC,			-- Factotum Elbow, Obsolete
			[134405] = FURC_AUTOMATON_CC,			-- Factotum Arm, Obsolete
			[134409] = FURC_AUTOMATON_CC,			-- Factotum Head, Obsolete
			[134406] = FURC_AUTOMATON_CC,			-- Factotum Body, Obsolete
			
			
		},
		[FURC_JUSTICE] 	= {
			[134411] = FURC_CANBESTOLENINCC, 		-- Ventilation shaft
			[134415] = FURC_CANBESTOLENINCC, 		-- Clockwork Dial Calipers, Handheld
			[134413] = FURC_CANBESTOLENINCC, 		-- Clockwork Magnifier, Handheld 
			[134412] = FURC_CANBESTOLENINCC, 		-- Clockwork Piston, Miniature
			[134410] = FURC_CANBESTOLENINCC, 		-- Clockwork Crank, Miniature
			[134411] = FURC_CANBESTOLENINCC, 		-- Clockwork Gear Shaft, Miniature
			[134400] = FURC_CANBEPICKED, 			-- Soft Leather, Stacked
			[134401] = FURC_CANBEPICKED, 			-- Soft Leather, Folded
			[134417] = FURC_CANBEPICKED, 			-- Calipers, Handheld
			[134399] = FURC_CANBEPICKED, 			-- Quality Fabric, Folded
			[117939] = FURC_CANBEPICKED_WW, 		-- Rough Axe, Practical
		},
		[FURC_CROWN] 	= {
			[134266] = FURC_CROWNSTORE_EIGHTY, 		-- Daedric Books, Stacked
			[134265] = FURC_CROWNSTORE_EIGHTY, 		-- Daedric Books, Piled			
			
		}
	},
		
	[FURC_REACH] = { -- Reach		
		[FURC_JUSTICE] 	= {
			[130191] = FURC_CANBESTOLEN, 			-- Shivering Cheese		
			[118206] = FURC_CANBESTOLEN_THIEF, 		-- Gaming dice
		},
		[FURC_CROWN] 	= {
			[131423] = FURC_CROWNSTORE_SEVENFIFTY,
		},
		[FURC_DROP] 	= {
			-- Coldharbour items
			[130284] = FURC_HARVEST_CHARBOR, 		-- Glowstalk, Seedlings
			[131422] = FURC_HARVEST_CHARBOR, 		-- Flower Patch, Glowstalks
			[130283] = FURC_HARVEST_CHARBOR, 		-- Glowstalk, Sprout
			[130285] = FURC_HARVEST_CHARBOR, 		-- Glowstalk, Young
			[131420] = FURC_HARVEST_CHARBOR, 		-- Shrub, Glowing Thistle
			[130281] = FURC_HARVEST_CHARBOR, 		-- Glowstalk, Towering
			[130282] = FURC_HARVEST_CHARBOR, 		-- Glowstalk, Strong
			
			[130067] = FURC_DAEDRA_SOURCE, 			-- Daedric Chain Segment
		},
		
	},
	[FURC_MORROWIND]	= { -- Morrowind
		[FURC_DROP] 	= {
			
			-- Dwemer parts
			[126660] = FURC_AUTOMATON_VV, 			-- Dwemer Gear, Tiered
			[126659] = FURC_AUTOMATON_VV, 			-- Dwemer Gear, Flat
		
			-- lootable in tombs
			[126773] = FURC_TOMBS, 					-- Velothi Caisson, Crypt
			[126704] = FURC_TOMBS, 
			-- Velothi Shroud, Majesty
			[126706] = FURC_TOMBS, 
			-- Velothi Shroud, Knowledge
			[126701] = FURC_TOMBS, 
			-- Velothi Shroud, Nerevar
			[126753] = FURC_TOMBS, 
			-- Velothi Cerecloth, Austere
			[126758] = FURC_TOMBS, 
			-- Velothi Mat, Prayer
			[126764] = FURC_TOMBS, 
			-- Velothi Shroud, Prowess
			[126702] = FURC_TOMBS, 
			-- Velothi Shroud, Reverance			
			[126700] = FURC_TOMBS, 
			-- Velothi Shroud, Honor			
			[126703] = FURC_TOMBS, 
		
			-- Ashlander dailies
			[126119] = FURC_DAILY_ASHLANDERS, 		-- Crimson Shard of Moonshadow
			[126393] = FURC_DAILY_ASHLANDERS, 		-- Crimson Shard of Moonshadow
		
			-- drops from plants
			[125631] = FURC_PLANTS, 					-- Plants, Ash Frond
			[125647] = FURC_PLANTS, 					-- Plants, Ash Frond
			[131420] = FURC_PLANTS, 					-- Plants, Ash Frond
			[125553] = FURC_PLANTS, 					-- Flowers, Netch Cabbage Stalks
			[125551] = FURC_PLANTS, 					-- Flowers, Netch Cabbage
			[125543] = FURC_PLANTS, 					-- Fern, Ashen
			[125633] = FURC_PLANTS, 					-- Plants, Hanging Pitcher Pair
			
		},
		[FURC_CROWN] 	= {
		},
		[FURC_JUSTICE] 	= {
			[126481] = FURC_CANBESTOLEN_RELIG, 		-- Indoril Incense, Burning
		},
	},
	[FURC_HOMESTEAD]	= {
		[FURC_JUSTICE] 	= {
				-- stealing
			[118489] = FURC_CANBESTOLEN_SCHOLARS, 	-- Papers, Stack
			[118528] = FURC_CANBESTOLEN, 			-- Signed Contract
			[118890] = FURC_CANBESTOLEN, 			-- Skull, Human
			[118487] = FURC_CANBESTOLEN_SCHOLARS, 	-- Letter, Personal
			[120008] = FURC_CANBESTOLEN_NERDS, 		-- Lesser Soul Gem, Empty
			[120005] = FURC_CANBESTOLEN_NERDS, 		-- Medium Soul Gem, Empty
				
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
					
		},		
		[FURC_FISHING] 	= {		
			-- fishing		
			[118902] = FURC_CANBEFISHED, 					-- Coral, Sun
			[118903] = FURC_CANBEFISHED, 					-- Coral, Crown
			[118896] = FURC_CANBEFISHED, 					-- Seashell, Sandcake
			[118901] = FURC_CANBEFISHED, 					-- Sea sponge
			[121269] = FURC_CANBEFISHED, 					-- Ocean Antler Coral
			[118338] = FURC_CANBEFISHED, 					-- Fish, Bass
			[118339] = FURC_CANBEFISHED, 					-- Fish, Salmon 
			[118337] = FURC_CANBEFISHED, 					-- Fish, Trout
			[120753] = FURC_CANBEFISHED, 					-- Kelp, Green Pile 
			[120755] = FURC_CANBEFISHED, 					-- Kelp, Lush Pile 
			[120754] = FURC_CANBEFISHED, 					-- Kelp, Small Pile 
			[118897] = FURC_CANBEFISHED, 					-- Seashell, Pink Scallop
			[118898] = FURC_CANBEFISHED, 					-- Seashell, White Scallop
		},				
		[FURC_DROP]		= { 		
			[121058] = FURC_DB_SNEAKY, 						-- Candles of Silence		
					
			[119936] = FURC_DB_POISON, 						-- Poisoned Blood				
			[119938] = FURC_DB_POISON, 						-- Light and Shadow			
			[119952] = FURC_DB_POISON, 						-- Sacrificial Heart			
		}, 		
		[FURC_CROWN]	= {		
			[118096] = FURC_CROWNSTORE_TEN, 				-- Bread, Plain
			[118098] = FURC_CROWNSTORE_TEN, 				-- Common Bowl, Serving
			[118061] = FURC_CROWNSTORE_FIFTEEN, 			-- Chicken Dinner, Display
			[118062] = FURC_CROWNSTORE_FIFTEEN, 			-- Chicken Meal, Display
			[118056] = FURC_CROWNSTORE_FIFTEEN, 			-- Common Stewpot, Hanging
			[118121] = FURC_CROWNSTORE_FIFTEEN, 			-- Knife, Carving
			[118066] = FURC_CROWNSTORE_FIFTEEN, 			-- Steak Dinner
			
			[118057] = FURC_CROWNSTORE_TWENTY, 				-- Sack of Beans
			[118060] = FURC_CROWNSTORE_TWENTY, 				-- Sack of Grain
			[118059] = FURC_CROWNSTORE_TWENTY, 				-- Sack of Millet,
			[118058] = FURC_CROWNSTORE_TWENTY, 				-- Sack of Rice
			
			[134473] = FURC_CROWNSTORE_CRATE_F_ATRO, 			-- Malacath Banner
			
		

			[118064] = FURC_CROWNSTORE_FOURTYFIVE, 			-- Common Barrel, Dry
			[118065] = FURC_CROWNSTORE_FOURTYFIVE, 			-- Common Cargo Crate, Dry
			[118064] = FURC_CROWNSTORE_FOURTYFIVE, 			-- Common Barrel, Dry
			
			[118053] = FURC_CROWNSTORE_EIGHTY, 				-- Common Campfire, Outdoor
			[118054] = FURC_CROWNSTORE_EIGHTY, 				-- Common Firepit, Outdoor
			[118055] = FURC_CROWNSTORE_EIGHTY, 				-- Common Firepit, Piled
			[118126] = FURC_CROWNSTORE_NINETYFIVE, 			-- Plaque, Standard
			
			[118068] = FURC_CROWNSTORE_ONETWENTY, 			-- Simple Brown Banner
			[118069] = FURC_CROWNSTORE_ONETWENTY, 			-- Simple Gray Banner
			[118071] = FURC_CROWNSTORE_ONETWENTY, 			-- Simple Red Banner
			[118070] = FURC_CROWNSTORE_ONETWENTY, 			-- Simple Purple Banner
			
			[115698] = FURC_CROWNSTORE_ONEONEHUNDRED, 		-- Khajiit Statue, Guardian
		}
	},
}

if GetAPIVersion() ~= 100022 then 
	FurC.MiscItemSources[FURC_DRAGONS] 	= {}
end