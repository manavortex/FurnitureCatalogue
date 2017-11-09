
--[[
			[""] = {		-- 
				["itemPrice"] 		= 100,
			},	
]]	
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

local bookList = {
	-- ["|H1:item:120197:3:1:0:0:0:0:0:0:0:0:0:0:0:1:0:0:1:0:0:0|h|h"] = { -- 16 accords of madness, vol vi
		-- ["itemValue"] = 500,
	-- },	
}

local boxes = {}
local b2 = {
	["|H1:item:120998:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {	-- Block,Wood Cutting
		["itemPrice"] 		= 100,
	},		
	["|H1:item:117959:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Container, Shipping
		["itemPrice"] 		= 100, 
	},	
	["|H1:item:117959:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Box, Slatted
		["itemPrice"] 		= 100, 
	},
	["|H1:item:117931:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate Lid
		["itemPrice"] 		= 100, 
	},
	["|H1:item:117957:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate, Cracked
		["itemPrice"] 		= 100, 
	},
	["|H1:item:117958:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate, Empty
		["itemPrice"] 		= 100, 
	},
	["|H1:item:117930:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate, Open
		["itemPrice"] 		= 100, 
	}, 
	["|H1:item:117953:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate, Sealed
		["itemPrice"] 		= 100, 
	},
	["|H1:item:117928:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = {		-- Rough Crate, Sturdy
		["itemPrice"] 		= 100, 
	},
}
FurC.Books[FURC_MORROWIND] = bookList	

FurC.AchievementVendors[FURC_MORROWIND] = {
	["Vivec City, Saint Delyn Inn"] = {
		["Drops-No-Glass"] = {
			["|H1:item:126638:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Ashlander Altar, Anticipations
				["itemPrice"] 		= 50000, 				
				["achievement"] 	= "|H1:achievement:1825:0:0|h|h", -- Clanfriend
			},	
			["|H1:item:126640:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Ashlander Fence, Totems
				["itemPrice"] 		= 10000, 				
				["achievement"] 	= "|H1:achievement:1881:0:0|h|h", -- Ashlander Relic Preserver
			},	
			["|H1:item:126613:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Ashlander Throne
				["itemPrice"] 		= 100000, 				
				["achievement"] 	= "|H1:achievement:1849:0:0|h|h", -- Voices of the Failed Incarnates
			},	
			["|H1:item:126639:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Ashlander Yurt, Netch-Hide
				["itemPrice"] 		= 75000, 				
				["achievement"] 	= "|H1:achievement:1880:0:0|h|h",  -- Ashlands Stalker
			},	
			["|H1:item:126623:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Banner of House Dres
				["itemPrice"] 		= 10000, 				
				["achievement"] 	= "|H1:achievement:1867:7:0|h|h",  -- Morrowind Grand Adventurer
			},	
			["|H1:item:126621:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Banner of House Hlaalu
				["itemPrice"] 		= 10000, 				
				["achievement"] 	= "|H1:achievement:1867:7:0|h|h",  -- Morrowind Grand Adventurer
			},	
			["|H1:item:126620:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Banner of House Redoran
				["itemPrice"] 		= 10000,
				["achievement"] 	= "|H1:achievement:1867:7:0|h|h",  -- Morrowind Grand Adventurer
			},	
			["|H1:item:126622:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Banner of House Telvanni
				["itemPrice"] 		= 10000, 				
				["achievement"] 	= "|H1:achievement:1867:7:0|h|h",  -- Morrowind Grand Adventurer
			},	
			["|H1:item:126628:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Banner, Morag Tong
				["itemPrice"] 		= 25000, 				
				["achievement"] 	= "|H1:achievement:1870:0:0|h|h",  -- Naryu's Confidant
			},	
			["|H1:item:126615:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Blessing Stone
				["itemPrice"] 		= 10000, 				
				["achievement"] 	= "|H1:achievement:1850:0:0|h|h",  -- Bearer of the Blessed Staff
			},	
			["|H1:item:126614:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Blessing Stone Device
				["itemPrice"] 		= 20000, 				
				["achievement"] 	= "|H1:achievement:1850:0:0|h|h",  -- Bearer of the Blessed Staff
			},	
			["|H1:item:126618:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Dwarven Brazier, Eternal
				["itemPrice"] 		= 50000, 				
				["achievement"] 	= "|H1:achievement:1854:0:0|h|h",  -- N'chow conqueror
			},	
			["|H1:item:126632:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Glass Crystal, Plume
				["itemPrice"] 		= 15000, 				
				["achievement"] 	= "|H1:achievement:1874:0:0|h|h",  -- Pilgrim Protector
			},	
			["|H1:item:126631:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Glass Crystal, Radiance
				["itemPrice"] 		= 15000, 				
				["achievement"] 	= "|H1:achievement:1874:0:0|h|h",  -- Pilgrim Protector
			},	
			["|H1:item:126633:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Glass Crystals, Bed
				["itemPrice"] 		= 20000, 				
				["achievement"] 	= "|H1:achievement:1874:0:0|h|h",  -- Pilgrim Protector
			},	
			["|H1:item:126629:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Kwama Queen Egg
				["itemPrice"] 		= 15000, 				
				["achievement"] 	= "|H1:achievement:1872:0:0|h|h",  -- Kwama Miner
			},	
			["|H1:item:126630:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Replica Stone of Ashalmwia
				["itemPrice"] 		= 75000, 				
				["achievement"] 	= "|H1:achievement:1873:1:1493919403|h|h",  -- Dratha Quest
			},	
			["|H1:item:126635:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Sacred Guar Skull
				["itemPrice"] 		= 15000, 				
				["achievement"] 	= "|H1:achievement:1876:0:0|h|h",  -- Ald'Ruhn Annalist
			},	
			["|H1:item:126642:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Silt Strider Shell, Hollow
				["itemPrice"] 		= 10000,
				["achievement"] 	= "|H1:achievement:1826:0:0|h|h",  -- Strider Carawaner
			},	
			["|H1:item:126617:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Statue of Vivec the Champion
				["itemPrice"] 		= 150000, 				
				["achievement"] 	= "|H1:achievement:1852:0:0|h|h",  -- Champion of Vivec
			},	
			["|H1:item:126636:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Statue, Cowering Ebony
				["itemPrice"] 		= 50000, 				
				["achievement"] 	= "|H1:achievement:1877:0:0|h|h",  -- Ebony Enforcer
			},	
			["|H1:item:126637:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Statue, Terrified Ebony
				["itemPrice"] 		= 50000, 				
				["achievement"] 	= "|H1:achievement:1877:0:0|h|h",  -- Ebony Enforcer
			},	
			["|H1:item:126616:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Statuette of Clavicus Vile, Masked
				["itemPrice"] 		= 100000,				
				["achievement"] 	= "|H1:achievement:1851:0:0|h|h",  -- Hand of a Living God
			},	
			["|H1:item:126627:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tapestry, Morag Tong
				["itemPrice"] 		= 35000,
				["achievement"] 	= "|H1:achievement:1870:0:0|h|h",  -- Naryu's Confidant
			},	
			["|H1:item:126634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tapestry, St. Veloth
				["itemPrice"] 		= 20000,
				 
				["achievement"] 	= "|H1:achievement:1875:0:0|h|h",  -- Narsis's Apprentice
			},	
			["|H1:item:126626:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Telvanni Device
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1869:0:1493833887|h|h",  -- Telvanni quest
			},	
			["|H1:item:126792:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Temple Doctrine: the 36
				["itemPrice"] 		= 130000,
				["achievement"] 	= "|H1:achievement:1824:0:0|h|h",  -- Tribunal Preacher
			},	
			["|H1:item:126619:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Totem of the Sixth House
				["itemPrice"] 		= 100000,
				["achievement"] 	= "|H1:achievement:1856:0:0|h|h",  -- Forgotten Wastes Vanquisher
			},	
			["|H1:item:126625:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tribunal Shrine in Fountain
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1868:0:0|h|h",  -- Savior of Morrowind
			},	
			["|H1:item:126641:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Triptych of the Triune
				["itemPrice"] 		= 20000,
				["achievement"] 	= "|H1:achievement:1827:0:0|h|h",  -- The Pilgrim's Path
			},
		},
		["Uzipa"] = {
			["|H1:item:120998:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Block, Wood Cutting
				["itemPrice"] 		= 100, 
			},	
			["|H1:item:125481:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Boulder, Volcanic Column
				["itemPrice"] 		= 500, 
			},	
			["|H1:item:125483:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Boulder, Volcanic Plug
				["itemPrice"] 		= 500, 
			},	
			["|H1:item:125587:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushroom ,Funnel Caps
				["itemPrice"] 		= 15000, 
			},	
			["|H1:item:125588:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushroom, Lanky Erupted Stinkcap
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125593:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushroom, Netch Shield Platform
				["itemPrice"] 		= 25000, 
			},	
			["|H1:item:125594:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushroom, Netch Shield Tower
				["itemPrice"] 		= 20000, 
			},	
			["|H1:item:125599:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- 
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125602:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- 
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125601:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- 
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125604:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- 
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125612:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushrooms, Funnel Cap Cluster
				["itemPrice"] 		= 22500, 
			},	
			["|H1:item:125614:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Mushrooms, Netch Hide Shade
				["itemPrice"] 		= 750, 
			},	
			["|H1:item:125638:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rock, Volcanic Chunk
				["itemPrice"] 		= 100, 
			},		
			["|H1:item:125639:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Rock, Volcanic Slab
				["itemPrice"] 		= 100, 
			},		
			["|H1:item:125641:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Sapling, Forked Ashland
				["itemPrice"] 		= 250, 
			},		
			["|H1:item:125642:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Sapling, Lanky Ash Laurel
				["itemPrice"] 		= 250, 
			},		
			["|H1:item:125643:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Sapling, Sturdy Ash Laurel
				["itemPrice"] 		= 250, 
			},		
			["|H1:item:125644:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Sapling, Tall Ashland
				["itemPrice"] 		= 250, 
			},		
			["|H1:item:125645:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Saplings, Ashland
				["itemPrice"] 		= 250, 
			},		
			["|H1:item:125673:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tree, Lanky Poplar
				["itemPrice"] 		= 500, 
			},	
			["|H1:item:125678:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tree, Sturdy Poplar
				["itemPrice"] 		= 500, 
			},	
			["|H1:item:125679:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tree, Poplar Cluster
				["itemPrice"] 		= 500, 
			},	
			["|H1:item:125677:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tree, Rooted Ashland
				["itemPrice"] 		= 40000, 
			},	
			["|H1:item:125676:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"] = { -- Tree, Rooted Cedar
				["itemPrice"] 		= 50000, 
			},
			
		},	
	},
	["Vivec City, Gladiator's Quarters"] = {
		["Brelda Ofemalen"] = {
			["|H1:item:126649:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Banner of the Fire Drakes
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1909:0:0|h|h", -- Crowd Favorite
			},
			["|H1:item:126712:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Banner of the PD
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1909:0:0|h|h", -- Crowd Favorite
			},
			["|H1:item:126650:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Banner of the SL
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1909:0:0|h|h", -- Crowd Favorite
			},			
			["|H1:item:126646:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Standard of the FD
				["itemPrice"] 		= 25000,
				["achievement"] 	= "|H1:achievement:1907:1:0|h|h", -- Grand Standard-Guardian
			},			
			["|H1:item:126648:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Standard of the PD
				["itemPrice"] 		= 25000,
				["achievement"] 	= "|H1:achievement:1907:0:0|h|h", -- Grand Standard-Guardian
			},			
			["|H1:item:126647:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Standard of the SL
				["itemPrice"] 		= 25000,
				["achievement"] 	= "|H1:achievement:1907:0:0|h|h", -- Grand Standard-Guardian
			},
			
			["|H1:item:126713:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Tapestry of the FD
				["itemPrice"] 		= 100000,
				["achievement"] 	= "|H1:achievement:1910:0:0|h|h", -- Conquering Hero
			},
			["|H1:item:126715:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Tapestry of the PD
				["itemPrice"] 		= 100000,
				["achievement"] 	= "|H1:achievement:1910:0:0|h|h", -- Conquering Hero
			},
			["|H1:item:126714:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Tapestry of the SL
				["itemPrice"] 		= 100000,
				 
				["achievement"] 	= "|H1:achievement:1910:0:0|h|h", -- Conquering Hero
			},
		},
		["Llivas Driler"] = {
			["|H1:item:126716:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Brazier of the FD
				["itemPrice"] 		= 50000,
				["achievement"] 	= "|H1:achievement:1913:0:0|h|h", -- Grand Champion
			},
			["|H1:item:126718:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Chained Skull of the PD
				["itemPrice"] 		= 100000,
				["achievement"] 	= "|H1:achievement:1913:0:0|h|h", -- Grand Champion
			},
			["|H1:item:126717:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Weathervane of the SL
				["itemPrice"] 		= 125000,
				["achievement"] 	= "|H1:achievement:1913:0:0|h|h", -- Grand Champion
			},
			["|H1:item:126643:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Crown of the SL
				["itemPrice"] 		= 75000,
				["achievement"] 	= "|H1:achievement:1901:10:0|h|h", -- Grand Relic Guardian
			},
			["|H1:item:126644:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- FD's Skull
				["itemPrice"] 		= 150000,
				["achievement"] 	= "|H1:achievement:1901:0:0|h|h", -- Grand Relic Guardian
			},
			["|H1:item:126645:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Skull of the PD
				["itemPrice"] 		= 100000,
				["achievement"] 	= "|H1:achievement:1901:10:0|h|h", -- Grand Relic Guardian
			},
		},
	},
	["any Alliance Capital"] = {				
		["Heralda Garscroft"] = {
			["|H1:item:126720:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Banner of Mayhem
				["itemPrice"] 		= 5000, 		
				["achievement"] 	= "|H1:achievement:1883:0:0|h|h", -- Mayhem Connaiseour
			},
			["|H1:item:126721:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Corpse of Mayhem, Argonian
				["itemPrice"] 		= 15000, 		
				["achievement"] 	= "|H1:achievement:1888:0:0|h|h", -- Wrath of the Whitestrake
			},
			["|H1:item:126722:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Corpse of Mayhem,Khajiit
				["itemPrice"] 		= 15000, 		
				["achievement"] 	= "|H1:achievement:1888:0:0|h|h", -- Wrath of the Whitestrake
			},
			["|H1:item:126723:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Corpse of Mayhem, Orc
				["itemPrice"] 		= 15000, 		
				["achievement"] 	= "|H1:achievement:1888:0:0|h|h", -- Wrath of the Whitestrake
			},
			["|H1:item:126724:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Propbably-Not-Punch Bowl of Mayhem
				["itemPrice"] 		= 30000, 		
				["achievement"] 	= "|H1:achievement:1892:0:0|h|h", -- Star-made Knight
			},
			["|H1:item:126719:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"]	= { -- Standard of Mayhem
				["itemPrice"] 		= 2500, 		
				["achievement"] 	= "|H1:achievement:1883:0:0|h|h", -- Mayhem Connaiseour
			},
		},
	},
	["the Mages' guild"] = {
		["the Mystic as part of a collection"] = bookList,
	}, 	
 }
 
 
-- global function, needs to live here, YES MANA
function FurC.SetupMorrowindItems()	
	
	-- FurC.AchievementVendors[FURC_MORROWIND]["the Mages' guild"]["the Mystic as part of a collection"] = bookList
	local listTable
	listTable = FurC.AchievementVendors[FURC_MORROWIND]["Vivec City, Saint Delyn Inn"]["Uzipa"]
	listTable = tableMerge(listTable, boxes)
	
	
end
