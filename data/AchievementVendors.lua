FurC.AchievementVendors[FURC_CLOCKWORK] = {
	["The Brass Citadel, Market"] = {
		["Razoufa"] = {
			["|H1:item:134285:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Active Fabrication Tank
				["itemPrice"] 	= 75000, 
				["achievement"] = "|H1:achievement:2049:0:0|h|h", -- Hero of Clockwork City
			},	
			["|H1:item:134286:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Clockwork Stylus
				["itemPrice"] = 3000, 
				["achievement"] = "|H1:achievement:2068:0:0|h|h", -- CC Adventurer
			},	
			["|H1:item:134289:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Energetic Anima Core
				["itemPrice"] = 15000, 
				["achievement"] = "", -- Brass Fortress Quarter Master
			},	
			["|H1:item:134284:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mysterious Clockwork Sphere
				["itemPrice"] = 35000, 
				["achievement"] = "|H1:achievement:2018:0:0|h|h", -- CC Master explorer
			},	
			["|H1:item:134288:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Skeleton Key Replica
				["itemPrice"] = 7500, 
				["achievement"] = "", -- The Burden Of Knowledge
			},	
			["|H1:item:134283:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- The motionless Guardian
				["itemPrice"] = 12000, 
				["achievement"] = "", -- Honorary Blackfeather
			},	
			["|H1:item:134547:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- The Truth in Sequence
				["itemPrice"] = 20000, 
				["achievement"] = "", -- Grand Adventurer
			},	
		},
		["Mulvise Valyn"] = {
			["|H1:item:134304:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Boulder, Basalt Slap
				["itemPrice"] = 1000, 
			},	
			["|H1:item:134292:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Boulder, Metallic Rubble
				["itemPrice"] = 500, 
			},	
			["|H1:item:134293:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Boulder, Metallic Shard
				["itemPrice"] = 500, 
			},	
			["|H1:item:134305:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Clockwork Junk Heap, Small
				["itemPrice"] = 1000, 
			},	
			["|H1:item:134303:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rock, Basalt Slab
				["itemPrice"] = 500, 
			},	
			["|H1:item:134296:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rocks, Sintered Cluster
				["itemPrice"] = 1000, 
			},	
			["|H1:item:134294:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rocks, Sintered Column
				["itemPrice"] = 1000, 
			},	
			["|H1:item:134295:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rocks, Sintered Pile
				["itemPrice"] = 1000, 
			},	
			["|H1:item:134297:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Grating, Narrow
				["itemPrice"] = 500, 
			},	
			["|H1:item:134298:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Grating, Wide
				["itemPrice"] = 500, 
			},	
			["|H1:item:134301:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Plate, Ornate
				["itemPrice"] = 500, 
			},	
			["|H1:item:134299:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Plate, Plain
				["itemPrice"] = 500, 
			},	
			["|H1:item:134300:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Plate, Wide
				["itemPrice"] = 500, 
			},	
			["|H1:item:134302:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Scavenged Support, Straight
				["itemPrice"] = 500, 
			},
		},
	},
}
if GetAPIVersion() == 100020 then FurC.AchievementVendors[FURC_CLOCKWORK] = {} end

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
