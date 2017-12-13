FURC_AV_RAZ = "Razoufa"
FURC_AV_MUL = "Mulvise Valyn"

FurC.AchievementVendors[FURC_CLOCKWORK] = {
	["The Brass Citadel, Market"] = {
		["Razoufa"] = {
			[134285] = { -- Active Fabrication Tank
				itemPrice 	= 75000, 
				achievement = 2049, -- Hero of Clockwork City
			},	
			[134286] = { -- Clockwork Stylus
				itemPrice = 3000, 
				achievement = 2068, -- CC Adventurer
			},	
			[134289] = { -- Energetic Anima Core
				itemPrice = 15000, 
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
}

function tableMerge(t1, t2)
	if nil == t2 and nil == t1 then 
		return {} 
	elseif nil == t2 then
		return t1
	elseif nil == t1 then
		return t2
	end 
	
    for k,v in pairs(t2) do
		t1[k] = v        
    end
    return t1
end

 
-- global function, needs to live here, YES MANA
function FurC.InitAchievementVendorList()
	
	FurC.SetupHomesteadItems()
	FurC.SetupMorrowindItems()
	FurC.SetupReachItems()
	
	-- local generatedTable, listTable
	
	-- FurC.ReachHornData.AchievementVendors["the Mages' guild"]["the Mystic as part of a collection"] = bookList
	
	-- listTable = FurC.ReachHornData.AchievementVendors["any Alliance Capital"]["Heralda Garscroft"]
	-- listTable = tableMerge(listTable, achievementVendor)	
	

	
end
