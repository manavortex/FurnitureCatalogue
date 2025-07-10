local ver = FurC.Constants.Versioning
local events = FurC.Constants.Events
local npc = FurC.Constants.NPC
local containers = FurC.Constants.Containers


FurC.EventItems[ver.FALLBAN] = {
  [events.CRIME] = {
    [containers.POUCH] = {
      [214244] = true, -- Crime Notice, Large",
      [214245] = true, -- Crime Notice, Small",
      [214246] = true, -- Coin, Single",
      [214247] = true, -- Coin Pile, Small",
      [214248] = true, -- Coin Pile, Tall",
	  },
  },
 }

-- 31 Base Game Update 43
FurC.EventItems[ver.BASE43] = {
  [events.UNDAUNTED] = {
    [containers.UNDAUNTEDBOX] = {
      [208112] = true, -- Rug of the Undaunted, Rectangular
      [208110] = true, -- Tankard of Undaunted Victory, Infernal
      [208108] = true, -- Tankard of Undaunted Victory, Green
      [208107] = true, -- Wind Chimes, Undaunted Glory
      [208106] = true, -- Stuffed Troll Head, Ivy-Adorned
    },
  },
}

-- 28 Scions of Ithelia
FurC.EventItems[ver.SCIONS] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [203888] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2024
      [203887] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2023
      [203886] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2022
      [203885] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2021
      [203884] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2020
      [203883] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2019
      [203882] = { itemPrice = 1 }, -- Replica Jubilee Cake Slice 2016-2018
      [203829] = { itemPrice = 3 }, -- Replica Jubilee Cake 2024
    },
  },
}

-- 27 Base Game Patch
FurC.EventItems[ver.BASED] = {
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [198390] = true, -- Apocrypha Specimen Jar, Leech
      [198389] = true, -- Apocrypha Specimen Jar, Spider
      [198388] = true, -- Apocrypha Specimen Jar, Tomeshell Viscera
      [198387] = true, -- Apocrypha Specimen Jar, Scorpion
      [198386] = true, -- Apocrypha Specimen Jar, Eyes
      [198385] = true, -- Apocrypha Specimen Jar, Abyssal Eel
      [198384] = true, -- Apocrypha Specimen Jar, Nascent Creatia
      [198383] = true, -- Apocrypha Specimen Jar, Centipede
      [198382] = true, -- Apocrypha Specimen Jar, Brains
      [198381] = true, -- Apocrypha Ink Pestle, Green
      [198380] = true, -- Apocrypha Ink Pestle, Black
      [198379] = true, -- Apocrypha Inkwell
      [198378] = true, -- Apocrypha Ink Jar, Green
      [198377] = true, -- Apocrypha Ink Jar, Black
      [198376] = true, -- Apocrypha Ink Vat, Small
      [198375] = true, -- Apocrypha Ink Vat, Green
      [198374] = true, -- Apocrypha Ink Vat, Black
      [198373] = true, -- Apocrypha Ink Bottle, Green
      [198372] = true, -- Apocrypha Ink Bottle, Black
    },
  },
}

-- 25 Scribes of Fate
FurC.EventItems[ver.SCRIBE] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [194359] = { itemPrice = 3 }, -- Replica Jubilee Cake 2023,
    },
  },
}

-- 21 Ascending Tide
FurC.EventItems[ver.TIDES] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [183902] = { itemPrice = 3 }, -- Replica Jubilee Cake 2022,
    },
  },
}

-- 20 Deadlands
FurC.EventItems[ver.DEADL] = {
  [events.BLACKWOOD] = { -- 2021-9-30 - 2021-10-12
    [npc.EVENT] = {
      [181488] = { itemPrice = 5 }, -- Statue, Saint Kaladas
    },
  },

  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [181494] = true, -- Vampiric Container, Yellow Liquid,
      [181493] = true, -- Vampiric Container, Congealed Liquid,
      [181492] = true, -- Vampiric Flask Stand, Double,
      [181491] = true, -- Vampiric Lightpost, Azure Double,
      [181490] = true, -- Vampiric Lightpost, Azure Single,
      [181489] = true, -- Vampiric Lamp, Azure Tall,
      [178799] = true, -- Ruby Candlefly Gathering,
      [130326] = true, -- Witches Brazier, Primitive Log,
      [130322] = true, -- Tool, Harvest Scythe
      [130319] = true, -- Crop, Wheat Stack
      [130318] = true, -- Crop, Wheat Pile
      [130317] = true, -- Pumpkin, Sickly
      [130316] = true, -- Pumpkin, Frail
      [125672] = true, -- Toadstool, Bloodtooth Cluster
      [125671] = true, -- Toadstool, Bloodtooth Cap
      [125670] = true, -- Toadstool, Bloodtooth
      [125598] = true, -- Mushroom, Emerging Stinkhorn
      [125596] = true, -- Mushroom, Poison Pax Stool
      [125595] = true, -- Mushroom, Poison Pax Shelf
      [125590] = true, -- Mushrooms, Lavaburst Cluster
      [125589] = true, -- Mushroom, Lavaburst Bud
      [125583] = true, -- Mushroom, Cave Bracket
      [120878] = true, -- Gravestone, Ornamented
    },
  },
}

-- 14 Harrowstorm
FurC.EventItems[ver.HARROW] = {
  [events.ANNIVERSARY] = { -- 2020-04-02 till 2020-04-14; 2021-04-01 till 2021-04-15
    [npc.EVENT] = {
      [171601] = { itemPrice = 3 }, -- Replica Jubilee Cake 2021
      [159470] = { itemPrice = 3 }, -- Replica Jubilee Cake 2020
      [159467] = { itemPrice = 3 }, -- Replica Jubilee Cake 2019
      [159466] = { itemPrice = 3 }, -- Replica Jubilee Cake 2018
      [159465] = { itemPrice = 3 }, -- Replica Jubilee Cake 2017
      [159464] = { itemPrice = 3 }, -- Replica Jubilee Cake 2016
    },
  },
}

-- 11 Elsweyr
FurC.EventItems[ver.KITTY] = {
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [145317] = true, -- Gravestone, Broken
      [118149] = true, -- Block and Axe, Chopping
    },
  },
}

-- 6 Dragon Bones
FurC.EventItems[ver.DRAGONS] = {
  [events.JESTER] = {
    [containers.JESTERBOX] = {
      [134680] = true, -- Jester Box
    },
  },
}

-- 4 Horns of the Reach
FurC.EventItems[ver.REACH] = {
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [145318] = true, -- Small Gravestone
      [130340] = true, -- Witches Totem, Gnarled Vines and Skull,
      [130339] = true, -- Witches Totem, Twisted Vines and Skull
      [130338] = true, -- Witches Bones, Offering,
      [130337] = true, -- Witches Corpse, Wrapped,
      [130332] = true, -- Witches Totem, Bone Charms,
      [130328] = true, -- Witches Skull, Horned Ram,
      [130327] = true, -- Witches Totem, Wooden Rack,
      [130325] = true, -- Witches Totem, Emphatic Warning,
      [130302] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Shrub, Burnt Brush
      [130301] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Saplings, Burnt Sparse
      [130300] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Saplings, Burnt Tall
      [130299] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Saplings, Burnt Cluster
      [130298] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Curved Laurel
      [130297] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Forked Laurel
      [130296] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Sturdy Laurel
      [130295] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Sturdy Burnt
      [130294] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Forked Burnt
      [130293] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Branch, Curved Burnt
      [130280] = GetString(SI_FURC_LOOT_HARVEST_WOOD), -- Sapling, Petrified Ashen
    },
  },
}

-- 3 Morrowind
FurC.EventItems[ver.MORROWIND] = {
  [events.MAYHEM] = {
    [containers.BOONBOX] = {
      [126164] = true, -- Song of Pelinal, #8
      [126163] = true, -- Song of Pelinal, #7
      [126162] = true, -- Song of Pelinal, #6
      [126161] = true, -- Song of Pelinal, #5
      [126160] = true, -- Song of Pelinal, #4
      [126159] = true, -- Song of Pelinal, #3
      [126158] = true, -- Song of Pelinal, #2
      [126157] = true, -- Song of Pelinal, #1
    },
  },

  [events.NEWLIFE] = {
    [containers.NEWLIFEBOX] = {
      [118053] = true, -- Common Campfire, Outdoor
    },
  },
}

-- 2 Homestead
FurC.EventItems[ver.HOMESTEAD] = {
  [events.JESTER] = {
    [containers.JESTERBOX] = {
      [134680] = true, -- Banner, Jester's Standard
      [120995] = true, -- Banner, Jester's Standard
    },
  },
}
