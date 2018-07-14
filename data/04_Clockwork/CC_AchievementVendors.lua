

local bookList = {
	[134553] = { -- The Truth in Sequence, Volume 1
		itemPrice = 2000,
	},
	[134554] = { -- The Truth in Sequence, Volume 2
		itemPrice = 2000,
	},
	[134555] = { -- The Truth in Sequence, Volume 3
		itemPrice = 2000,
	},
	[134556] = { -- The Truth in Sequence, Volume 4
		itemPrice = 2000,
	},
	[134557] = { -- The Truth in Sequence, Volume 5
		itemPrice = 2000,
	},
	[134558] = { -- The Truth in Sequence, Volume 6
		itemPrice = 2000,
	},
	[134559] = { -- The Truth in Sequence, Volume 7
		itemPrice = 2000,
	},
	[134560] = { -- The Truth in Sequence, Volume 8
		itemPrice = 2000,
	},
	[134561] = { -- The Truth in Sequence, Volume 9
		itemPrice = 2000,
	},
	[134562] = { -- The Truth in Sequence, Volume 10
		itemPrice = 2000,
	},
}

FurC.Books[FURC_CLOCKWORK] = bookList
FurC.AchievementVendors[FURC_CLOCKWORK] = {
    
	["The Brass Citadel, Market"] = {
        ["Razoufa as part of a collection"] = bookList,
		["Razoufa"] = {
			[134285] = { -- Active Fabrication Tank
				itemPrice 	= 75000,
				achievement = 2049, -- Hero of Clockwork City
			},
			[134286] = { -- Clockwork Stylus
				itemPrice   = 3000,
				achievement = 2068, -- CC Adventurer
			},
			[134289] = { -- Energetic Anima Core
				itemPrice   = 15000,
				achievement = 2072, -- Brass Fortress Quarter Master
			},
			[134284] = { -- Mysterious Clockwork Sphere
				itemPrice = 35000,
				achievement = 2018, -- CC Master explorer
			},
			[134288] = { -- Skeleton Key Replica
				itemPrice = 7500,
				achievement = 2064, -- The Burden Of Knowledge
			},
			[134283] = { -- The motionless Guardian
				itemPrice = 12000,
				achievement = 2067, -- Honorary Blackfeather
			},
			[134547] = { -- The Truth in Sequence
				itemPrice = 20000,
				achievement = 2069, -- Grand Adventurer
			},
		},
		["Mulvise Valyn"] = {
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
		},
	},

	[GetString(FURC_AV_CAPITAL)] = {
		[GetString(FURC_AV_HER)] = {
			[134291] = { -- New Life Bonfire
				itemPrice = 10000,
				achievement = 1671,
			},
			[134290] = { -- New Life Celebrant's Standard
				itemPrice = 2500,
				achievement = 1674,
			}
		},
	},
}

