local function getCrownPrice(price)
    return string.format("%s (PTS, %u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end
	
FurC.MiscItemSources[FURC_SLAVES]	= {
    [FURC_RUMOUR]   = {
		[146048] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Festive Fir
		[146049] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Winter Festival Hearth
		[146050] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Winter Festival Hearthfire
		[145923] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Lies of the Dread-Father
		[146052] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Vvardvark Ice Sculpture
		[146053] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Guar Ice Sculpture
		[145926] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- That of Void
		[145927] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Acts of Honoring
		[145928] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Speakers of Nothing
		[146057] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Snowmortal, Human
		[146058] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Snowmortal, Argonian
		[146060] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Ladle		
		[146062] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Winter Ouroboros Wreath
		[145553] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Small Glyphed
		[145426] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Felucca, Canopied
		[145427] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Serpent Skull, Colossal
		[145428] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Lantern Post, Covered
		[145429] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant Cluster, Cardinal Flower Large
		[145430] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Star Blossom
		[145431] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Marsh Nigella
		[145432] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Canna Lily
		[146061] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Triptych Banner
		[145434] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Large Lantern Flower
		[145435] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Marsh Mani Flower
		[145436] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Canopied Felucca, Double Hulled
		[145437] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Reed Felucca, Double Hulled
		[145438] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Large Glyphed
		[145439] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Large Fearsome
		[145440] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Large Skull
		[145441] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Large Serpent
		[145442] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Grave Stake, Large Twinned
		[145443] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Shrine, Sithis Looming
		[145444] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Totem, Hist Guardian
		[145445] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- The Sharper Tongue: A Jel Primer
		[145446] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Sithis, the Hungering Dark
		[145447] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Dais, Engraved
		[145448] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Throne, Engraved
		[145449] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Stele, Hist Guardians
		[145450] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Stele, Hist Cultivation
		[145451] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Shrine, Sithis Figure Anointed
		[145452] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Shrine, Sithis Looming Anointed
		[145453] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Marsh Aloe
		[145454] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Marsh Aloe Pod
		[145455] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Dendritic Hist Bulb
		[145456] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Hist Bulb
		[145457] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Tree, Banyan
		[145458] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Tree, Ancient Banyan
		[141875] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Witches Festival Scarecrow
		[145462] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Cardinal Flower
		[146059] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Snowmortal, Khajiit
		[146051] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Mudcrab Ice Sculpture
		[146054] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Garland
		[145467] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- The Way of Shadow
		[145468] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Wedding Lantern, Hanging
		[145469] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Redguard Gazebo, Palatial Domed
		[145470] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Redguard Vase, Golden
		[145471] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Redguard Raincatcher, Golden
		[145472] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Antler Coral, Crimson
		[145473] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Antler Coral, Stout Crimson
		[145474] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Flytrap
		[145475] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Plant, Soulsplinter Weed
		[145476] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Alinor Shrine, Trinimac
		[145477] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Alinor Pedestal, Shrine
		[145478] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Alinor Shrine, Y'ffre
		[145479] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Iron Maiden, Occupied
		[145480] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Corpse, Burned Seated
		[145481] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Corpse, Burned Sprawled
		[145482] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Wheelbarrow, Bones
		[145483] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Column, Ossuary
		[145484] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Dark Elf Statue, Ordinator
		[145485] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Dark Elf Statue, Knight
		[145486] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Door, Sweet Mother
		[145487] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Banner, Order of the Hour
		[145488] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Banner, Jewelry Crafting
		[146055] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Garland Wreath
		[146056] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- New Life Cookies and Ale
		[145491] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Static Pitcher
		[145492] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Gas Blossom
		[145493] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Lantern Mantis
		[141854] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Decorative Hollowjack Flame-Skull
		[145554] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Tree, Towering Snowy Fir
		[145555] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Tree, Snowy Fir
		[145597] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Scales of Shadow
		[145595] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Scuttlebloom
		[145322] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Music Box, Blood and Glory
		[145576] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Timid Vine-Tongue
		[145318] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Gravestone, Small Broken
		[145317] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Gravestone, Broken
		[141920] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Brazier, Ceremonial
		[141921] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Bowl, Geometric Pattern
		[141922] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Dish, Geometric Pattern
		[141923] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Amphora, Seed Pattern
		[141924] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Vase, Scale Pattern
		[141925] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Hearth Shrine, Sithis Relief
		[141926] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Hearth Shrine, Sithis Figure
		[145550] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Hunting Lure, Grisly
		[145549] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Totem, Stone Head
		[141870] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Raven-Perch Cemetery Wreath		
		[142235] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Music Box, Flickering Shadows		
		[141856] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Decorative Hollowjack Daedra-Skull
		[141855] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Decorative Hollowjack Wraith-Lantern
		[145556] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Tree, Tall Snowy Fir
		[145396] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Tapestry, Hist Gathering Worn
		[145397] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Rug, Hist Gathering Worn
		[145398] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Rug, Supine Turtle Worn
		[145399] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Rug, Crawling Serpents Worn
		[145400] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Rug, Lurking Lizard Worn
		[145401] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Murkmire Tapestry, Xanmeer Worn
		[145402] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Fish, Black Marsh
		[145403] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- Jel Parchment
		[146047] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM), -- From Old Life To New
    },
	
    [FURC_CROWN]	= {     	
		[145433] = getCrownPrice(1), -- Plant, Rafflesia
		[145459] = getCrownPrice(1), -- Murkmire Kiln, Ancient Stone
		[145460] = getCrownPrice(1), -- Plant, Canna Leaves
		[145461] = getCrownPrice(1), -- Plant Cluster, Cardinal Flower Small
		[145463] = getCrownPrice(1), -- Plant Cluster, Red Sister Ti
		[145464] = getCrownPrice(1), -- Plant, Red Sister Ti
		[145465] = getCrownPrice(1), -- Plant Cluster, Wilted Hist Bulb
		[145466] = getCrownPrice(1), -- Plant, Wilted Hist Bulb
		[141939] = getCrownPrice(1), -- Grave, Grasping
		[145411] = getCrownPrice(1), -- Plant, Lantern Flower
		[141965] = getCrownPrice(1), -- Hollowjack Lantern, Soaring Dragon
		[141966] = getCrownPrice(1), -- Hollowjack Lantern, Toothy Grin
		[141967] = getCrownPrice(1), -- Hollowjack Lantern, Ouroboros
		[142004] = getCrownPrice(1), -- Specimen Jar, Spare Brain
		[142005] = getCrownPrice(1), -- Specimen Jar, Monstrous Remains
		[142003] = getCrownPrice(1), -- Specimen Jar, Eyes
		[141869] = getCrownPrice(1), -- Alinor Potted Plant, Cypress
		[141976] = getCrownPrice(1), -- Pumpkin Patch, Display
		[141853] = getCrownPrice(1), -- Statue of Hircine's Bitter Mercy
		
    },
    [FURC_FISHING] 	= {
        -- fishing
        -- [118902] = GetString(SI_FURC_CANBEFISHED), 		-- Coral, Sun
    },
    [FURC_DROP]		= {
        -- [121058] = FURC_DB_SNEAKY, 						-- Candles of Silence
    },
		
}


FurC.Recipes[FURC_SLAVES] = {
		
	145944, -- Praxis: Murkmire Chair, Engraved
	145945, -- Praxis: Murkmire Bench, Wide
	145946, -- Praxis: Murkmire Bench, Armless
	145947, -- Praxis: Murkmire Bed, Enclosed
	145948, -- Praxis: Murkmire Pedestal, Low
	145949, -- Praxis: Murkmire Table, Engraved
	145950, -- Praxis: Murkmire Brazier, Engraved
	145951, -- Praxis: Murkmire Bookshelf, Grand
	145952, -- Praxis: Murkmire Bookshelf, Grand Full
	145953, -- Praxis: Murkmire Sarcophagus, Empty
	145954, -- Praxis: Murkmire Sarcophagus Lid
	145955, -- Praxis: Murkmire Bookshelf
	145956, -- Praxis: Murkmire Bookshelf, Full
	145957, -- Praxis: Murkmire Platform, Sectioned
	145958, -- Praxis: Murkmire Pedestal, Winged
	145959, -- Praxis: Murkmire Totem, Beacon
	145960, -- Diagram: Murkmire Brazier, Bowl
	145961, -- Praxis: Murkmire Hearth Shrine, Sithis Rearing
	145962, -- Praxis: Murkmire Hearth Shrine, Sithis Coiled
	145963, -- Praxis: Murkmire Hearth Shrine, Sithis Looming
	145964, -- Praxis: Murkmire Shrine, Sithis Relief
	145965, -- Praxis: Murkmire Shrine, Sithis Rearing
	145966, -- Praxis: Murkmire Shrine, Sithis Figure
	145967, -- Praxis: Murkmire Shrine, Sithis Coiled
	145968, -- Design: Murkmire Pot, Large Carved
	145969, -- Design: Bowl of Worms
	145970, -- Design: Bowl of Guts
	145971, -- Design: Bowl of Worms, Large
	145972, -- Design: Grub Kebabs
	145973, -- Design: Murkmire Berry Strand
	145974, -- Design: Murkmire Pot, Handmade
	145975, -- Design: Melon, Wax
	145976, -- Design: Dragonfruit, Wax
	145977, -- Blueprint: Murkmire Platter, Large
	145978, -- Blueprint: Murkmire Plate, Charger
	145979, -- Praxis: Murkmire Wall, Stone
	145980, -- Blueprint: Murkmire Bonding Chimes, Domed
	145981, -- Formula: Murkmire Lantern, Covered
	145982, -- Formula: Murkmire Lamp, Hanging Bottle
	145983, -- Formula: Murkmire Lamp, Hanging Conch
	145984, -- Formula: Murkmire Sconce, Shell
	145985, -- Formula: Murkmire Brazier, Shell
	145986, -- Formula: Murkmire Lamp, Shell
	145987, -- Design: Murkmire Candlepost, Timber
	145988, -- Design: Murkmire Candlepost, Driftwood
	145989, -- Design: Murkmire Candles, Bone Group
	145990, -- Design: Murkmire Candle, Bone Tall
	145991, -- Design: Murkmire Candle, Bone Squat
	145992, -- Blueprint: Murkmire Bed, Carved
	145993, -- Blueprint: Murkmire Wardrobe, Woven
	145994, -- Blueprint: Murkmire Chair, Woven
	141899, -- Praxis: Sacrificial Altar, Hircine
	141900, -- Blueprint: Ritual Fetish, Hircine
	146004, -- Blueprint: Murkmire Ramp, Reed
	146005, -- Blueprint: Murkmire Platform, Reed
	146006, -- Blueprint: Murkmire Gate, Arched
	146007, -- Blueprint: Murkmire Wall, Straight
	146008, -- Blueprint: Murkmire Totem Post, Carved
	146009, -- Blueprint: Murkmire Wall, Corner Curve
	146010, -- Pattern: Murkmire Tapestry, Hist Gathering
	146011, -- Pattern: Murkmire Rug, Hist Gathering
	146012, -- Pattern: Murkmire Rug, Supine Turtle
	146013, -- Pattern: Murkmire Rug, Crawling Serpents
	146014, -- Pattern: Murkmire Rug, Lurking Lizard
	146015, -- Pattern: Murkmire Tapestry, Xanmeer
	146016, -- Blueprint: Murkmire Bonding Chimes, Simple
	146017, -- Blueprint: Murkmire Totem, Wolf-Lizard
	141898, -- Praxis: Ritual Stone, Hircine
	141897, -- Praxis: Obelisk, Lord Hircine Ritual
	141896, -- Sketch: Figurine, The Dragon's Glare
	145995, -- Blueprint: Murkmire Trunk, Leatherbound
	145999, -- Blueprint: Murkmire Shelf, Reed
	145996, -- Blueprint: Murkmire Counter, Cabinet
	145997, -- Blueprint: Murkmire Counter, Low Cabinet
	145998, -- Blueprint: Murkmire Table, Woven
	145915, -- Praxis: Murkmire Desk, Engraved
	146000, -- Blueprint: Murkmire Shelves, Woven
	146001, -- Blueprint: Murkmire Shelf, Woven Hanging
	146002, -- Blueprint: Murkmire Ramp, Marshwood
	146003, -- Blueprint: Murkmire Walkway, Reed
}



FurC.AchievementVendors[FURC_SLAVES] = {
	-- ["the Undaunted Enclaves"] = {
		-- ["Undaunted Quartermaster"] = {
			-- [141858] = {        --Banner of the Silver Dawn
                -- itemPrice   = 15000,
                -- achievement = 2152,
            -- },
            -- [141857] = {        --Ritual Chalice, Hircine
                -- itemPrice   = 5000,
                -- achievement = 2162,
            -- },
		-- },
	-- },
	["Murkmire"] = {
		[GetString(FURC_AV_HAR)] = {
			[145408] = {        	--Argon Pedestal, Replica
				itemPrice   = 15000,
				achievement = 0,	-- The river of rebirth
			},
			[145406] = {        	--Banner, Bright-Throat
				itemPrice   = 10000,
				achievement = 2353,	-- murky marketeer 
			},
			[145404] = {        	--Banner, Dead-Water
				itemPrice   = 10000,
				achievement = 2354, -- Cold Blood, Warm Heart 
			},
			[145405] = {        	--Banner, Rootwater
				itemPrice   = 10000,
				achievement = 0,	-- Resplendent Rootmender
			},
			[145553] = {        	--Grave Stake, Small Glyphed
				itemPrice   = 5000,
				achievement = 2330,	-- Surreptiliously Shadowed 
			},
			[145549] = {       		--Murkmire Totem, Stone Head
				itemPrice   = 12000,
				achievement = 0,	-- Art of the Nisswo
			},
			[145407] = {        	-- Remnant of Argon, Replica
				itemPrice   = 75000,
				achievement = 2339,	-- River of Rebirth	 
			},
			[145412] = {        	--Seed Doll, Turtle
				itemPrice   = 20000,
				achievement = 2336,	-- Sap-Sleeper 
			},
			[145576] = {        	--Timid Vine-Tongue
				itemPrice   = 40000,
				achievement = 2357,	--	Vine-Tongue Traveler  
			},

		},
		[GetString(FURC_AV_ADO)] = {
			[145551] = {        -- Murkmire Kiln, Derelict
				itemPrice   = 450,
			},
			[145557] = {        -- Plant Cluster, Spadeleaf
				itemPrice   = 350,
			},
			[145414] = {        -- Plant Cluster, Marsh Saplings
				itemPrice   = 250,
			},
			[145417] = {        -- Plant, Bramblebrush
				itemPrice   = 250,
			},
			[145413] = {        -- Plant, Marsh Palm
				itemPrice   = 350,
			},
			[145419] = {        -- Plant, Marshfrond
				itemPrice   = 400,
			},
			[145547] = {        -- Plant, Moorstalk Hive
				itemPrice   = 1250,
			},
			[145416] = {        -- Plant, Purple Spadeleaf
				itemPrice   = 300,
			},
			[145420] = {        -- Plant, Thorny Swamp Lily
				itemPrice   = 400,
			},
			[145418] = {        -- Plant, Young Marshfrond
				itemPrice   = 250,
			},
			[145425] = {        -- Rock, Mossy Marsh
				itemPrice   = 250,
			},
			[145424] = {        -- Rocks, Mossy Marsh Cluster
				itemPrice   = 750,
			},
			[145422] = {        -- Tree Cluster, Young Sycamore
				itemPrice   = 450,
			},
			[145421] = {        -- Tree, Marsh Cypress
				itemPrice   = 350,
			},
			[145423] = {        -- Tree, Mire Mangrove
				itemPrice   = 4000,
			},
			[145415] = {        -- Tree, Mossy Sycamore
				itemPrice   = 2000,
			},

		}
	}
}

-- local versionData = FurC.MiscItemSources[FURC_SLAVES]

-- d(zo_strformat("num entries in FurC.MiscItemSources[FURC_SLAVES]: <<1>>", NonContiguousCount(versionData)))
-- for origin, originData in pairs(versionData) do
	-- d(zo_strformat("origin <<1>>, <<2>> entries", origin, NonContiguousCount(originData))) 
-- end