FurC.LuxuryFurnisher = FurC.LuxuryFurnisher or {}

FurC.LuxuryFurnisher[FURC_CLOCKWORK] = {
	["Hollow City, Cicero's General Goods"] = {
		["Zanil Theran, Luxury Furnisher"]	= {	
			-- Nov. 4th
			["|H1:item:118286:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Carcass, Grey Hare
				["itemPrice"] = 5000,
			},
			["|H1:item:118281:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Carcass, Hanging Geese
				["itemPrice"] = 7000,
			},
			["|H1:item:118279:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Deer Head, Wall Mount
				["itemPrice"] = 15000,
			},
			["|H1:item:118298:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Wolf Head, Wall Mount
				["itemPrice"] = 20000,
			},
			
			-- Oct 28th
			["|H1:item:132143:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Reach Sapling, Briarheart
				["itemPrice"] = 50000,
			},
			["|H1:item:132158:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Witch's Remains, Offering
				["itemPrice"] = 50000,
			},
			["|H1:item:132157:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Witch's Remains, Sacrificial
				["itemPrice"] = 50000,
			},
			--[[
				[""] = {	-- 
					["itemPrice"] = 0,
				},
			]]
		},
	},		
}

if GetAPIVersion() == 100020 then FurC.LuxuryFurnisher[FURC_CLOCKWORK] = {} end