
FurC.AchievementVendors[FURC_WOTL] = {
  ["the Undaunted Enclaves"] = {
    ["Undaunted Quartermaster"] = {
     [147645] = {    --Dwarven Tonal Arc
		itemPrice   = 15000, 
		achievement = 2260,
	  },

      [147638] = {    --Replica Cursed Orb of Meridia
		itemPrice   = 100000,
		achievement = 2270,
	  },

    },
  },
}

local rumourSource          = GetString(SI_FURC_RUMOUR_SOURCE_ITEM)
FurC.MiscItemSources[FURC_WOTL]  = {
  [FURC_RUMOUR]   = {
		[134272] = rumourSource,     -- Cave Deposit, Stalagmite Cluster,    
        [147585] = rumourSource,     -- Dwarven Gear, Large Spokes,    
        [147586] = rumourSource,     -- Dwarven Hub, Sentry Wheel,    
        [147587] = rumourSource,     -- Dwarven Gear, Large Open,    
        [147588] = rumourSource,     -- Dwarven Conduit, Rounded,    
        [147589] = rumourSource,     -- Dwarven Brazier, Open,    
        [147590] = rumourSource,     -- Dwarven Bust, Forge-Lord,    
        [147591] = rumourSource,     -- Namira, Mistress of Decay,    
        [147592] = rumourSource,     -- Silver Kettle, Masterworked,    
        [140297] = rumourSource,     -- Replica Throne of Alinor,    
        [147594] = rumourSource,     -- Pottery Wheel, Ever-Turning,    
        [147595] = rumourSource,     -- Alchemical Apparatus, Condenser,    
        [147596] = rumourSource,     -- Hlaalu Salt Lamp, Enchanted,    
        [130189] = rumourSource,     -- Tapestry of Sheogorath,    
        [130190] = rumourSource,     -- Banner of Sheogorath,    
        [134287] = rumourSource,     -- Projector TBD,    
        [147600] = rumourSource,     -- Tapestry of Namira,    
        [130193] = rumourSource,     -- Robust Target Minotaur Handler,    
        [130194] = rumourSource,     -- Target Stone Atronach,    
        [130195] = rumourSource,     -- Target Iron Atronach,    
        [120852] = rumourSource,     -- Holding Cell,    
        [146069] = rumourSource,     -- Target Voriplasm,    
        [120856] = rumourSource,     -- Yokudan Sarcophagus,    
        [146073] = rumourSource,     -- Plant Cluster, Marsh Nigella,    
        [120858] = rumourSource,     -- Yokudan Tapestry,    
        [120860] = rumourSource,     -- Yokudan Throne,    
        [120861] = rumourSource,     -- Yokudan Sitting Griffin Statue,    
        [130080] = rumourSource,     -- Soul Gems, Scattered,    
        [130081] = rumourSource,     -- Soul-Shriven, Armored,    
        [130083] = rumourSource,     -- Daedric Block, Seat,    
        [130084] = rumourSource,     -- Daedric Tapestry, Molag Bal,    
        [130085] = rumourSource,     -- Daedric Banner, Molag Bal,    
        [130086] = rumourSource,     -- Daedric Pennant, Molag Bal,    
        [130087] = rumourSource,     -- Daedric Shards, Coldharbour,    
        [120872] = rumourSource,     -- Daedric Pike, Daedroth Head,    
        [130089] = rumourSource,     -- Daedric Brazier, Molag Bal,    
        [120874] = rumourSource,     -- Daedric Coffin, Lid,    
        [130091] = rumourSource,     -- Statue of Molag Bal, God of Schemes,    
        [120876] = rumourSource,     -- Gravestone, Imp Engraving,    
        [120877] = rumourSource,     -- Gravestone, Cracked,    
        [120880] = rumourSource,     -- Tombstone, Engraved, Decorative,    
        [120881] = rumourSource,     -- Tombstone, Engraved, Order of the Hour,    
        [120882] = rumourSource,     -- Tombstone, Small,    
        [147507] = rumourSource,     -- Music Box, \"Hinterlands\",    
        [147636] = rumourSource,     -- Banner of Hermaeus Mora,    
        [147638] = rumourSource,     -- Replica Cursed Orb of Meridia,    
        [147639] = rumourSource,     -- Magna-Geode,    
        [147640] = rumourSource,     -- Magna-Geode, Large,    
        [147641] = rumourSource,     -- Garlas Alpinia, Tall,    
        [147642] = rumourSource,     -- Boar Totem, Balance,    
        [147643] = rumourSource,     -- Boar Totem, Solitary,    
        [147644] = rumourSource,     -- Palisade, Crude,    
        [147645] = rumourSource,     -- Dwarven Tonal Arc,    
        [147646] = rumourSource,     -- Meridia, Lady of Infinite Energies,    
        [147647] = rumourSource,     -- Dwarven Centurion Blade, Detached,    
        [147648] = rumourSource,     -- Dwarven Press Bed, Forge-Sized,    
        [132166] = rumourSource,     -- Death Skeleton, Robed,    
        [134474] = rumourSource,     -- Banner, Malacath,    
        [147664] = rumourSource,     -- Dwarven Dais, Conduit,    
        [147599] = rumourSource,     -- Banner of Namira,    
        [147584] = rumourSource,     -- Dwarven Rack, Spider Legs,    
        [120857] = rumourSource,     -- Yokudan Sarcophagus Lid,    
        [147505] = rumourSource,     -- Music Box, \"Y'ffre in Every Leaf\",    
        [147506] = rumourSource,     -- Music Box, \"Sands of the Alik'r\",    
        [120853] = rumourSource,     -- Stockade,    
        [147574] = rumourSource,     -- Dwarven Frieze, Wrathstone,    
        [147573] = rumourSource,     -- Barricade, Bladed Hurdle,    
        [132197] = rumourSource,     -- Death Skeleton, Shrouded,    
        [134246] = rumourSource,     -- The Law of Gears,    
        [147572] = rumourSource,     -- Barricade, Bladed Fence,    
        [132200] = rumourSource,     -- Imperial Well, Akatosh,    
        [132201] = rumourSource,     -- Tree, Kvatch Nut,    
        [132202] = rumourSource,     -- Rock, Anvil Limestone,    
        [132203] = rumourSource,     -- Stone, Anvil Limestone,    
        [132204] = rumourSource,     -- Imperial Statue, Truth,    
        [134253] = rumourSource,     -- Coldharbour Bookshelf, Filled Wide,    
        [134254] = rumourSource,     -- Seal of Molag Bal,    
        [134255] = rumourSource,     -- Transliminal Rupture,    
        [134256] = rumourSource,     -- Coldharbour Bookshelf, Filled Pillar,    
        [134257] = rumourSource,     -- Daedra Dossier: Cold-Flame Atronach,    
        [134258] = rumourSource,     -- Prayer to the Furious One,    
        [134259] = rumourSource,     -- Malacath, God of Oaths and Curses,    
        [134260] = rumourSource,     -- Orcish Bas-Relief, Axe,    
        [134261] = rumourSource,     -- Orcish Bas-Relief, Sword,    
        [134262] = rumourSource,     -- Orcish Bas-Relief, Spear,    
        [147575] = rumourSource,     -- Dwarven Frieze, Power in Twain,    
        [147576] = rumourSource,     -- Dwarven Frieze, Colossal Power,    
        [147577] = rumourSource,     -- Dwarven Platform, Fan,    
        [147578] = rumourSource,     -- Dwarven Throne, Conduit,    
        [147579] = rumourSource,     -- Dwarven Gearwork, Perpetual,    
        [147580] = rumourSource,     -- Dwarven Lamps, Heavy,    
        [147581] = rumourSource,     -- Dwarven Table, Heavy Workbench,    
        [147582] = rumourSource,     -- Dwarven Part, Sentry Head,    
        [147583] = rumourSource,     -- Dwarven Valve, Sealed,    
  },
  
  [FURC_JUSTICE] = {
  
  }, 
  
  [FURC_DROP]    = {
  
  },
  
  [FURC_CROWN]  = {   
   
    
  },
  [FURC_FISHING]   = {
     
  },
  
}