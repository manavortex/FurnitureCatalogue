FurC.Rollis_Recipes = FurC.Rollis_Recipes or {}

FurC.Rollis_Recipes[FURC_REACH] = {
	["|H1:item:132195:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Telvanni Candelabra, Masterwork
	["|H1:item:132194:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Mammoth Cheese, Mastercrafted
	["|H1:item:132191:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Dwarven Gyroscope
	["|H1:item:132190:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Mages Apparatus, Master
	["|H1:item:132192:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Dres Sewing Kit
	["|H1:item:132193:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = true, -- Hlaalu Bathtub, Masterwork
}
if GetAPIVersion() == "10019" then FurC.Rollis_Recipes[FURC_REACH] = {} end