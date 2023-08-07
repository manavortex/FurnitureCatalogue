local ver = FurC.Constants.Versioning

-- 25 Scribes of Fate
FurC.EventItems[ver.SCRIBE] = {
  ["Anniversary Jubilee"] = {
    ["Impresario"] = {
      [194359] = { itemPrice = 3 }, -- Replica Jubilee Cake 2023,
    },
  },
}

-- 21 Ascending Tide
FurC.EventItems[ver.TIDES] = {
  ["Anniversary Jubilee"] = {
    ["Impresario"] = {
      [183902] = { itemPrice = 3 }, -- Replica Jubilee Cake 2022,
    },
  },
}

-- 20 Deadlands
FurC.EventItems[ver.DEADL] = {
  ["Bounties of Blackwood"] = { -- 2021-9-30 - 2021-10-12
    ["Impressario"] = {
      [181488] = { itemPrice = 5 }, -- Statue, Saint Kaladas
    },
  },

  ["Witches' Festival"] = {
    ["Plunder Skull"] = {
      [178799] = true, -- Ruby Candlefly Gathering,
      [181491] = true, -- Vampiric Lightpost, Azure Double,
      [181490] = true, -- Vampiric Lightpost, Azure Single,
      [181489] = true, -- Vampiric Lamp, Azure Tall,
      [181494] = true, -- Vampiric Container, Yellow Liquid,
      [181492] = true, -- Vampiric Flask Stand, Double,
      [181493] = true, -- Vampiric Container, Congealed Liquid,

      -- update 12-1-21
      [130316] = true, -- Pumpkin, Frail
      [130317] = true, -- Pumpkin, Sickly
      [130318] = true, -- Crop, Wheat Pile
      [130319] = true, -- Crop, Wheat Stack
      [130322] = true, -- Tool, Harvest Scythe
      [130326] = true, -- Witches Brazier, Primitive Log,
      [125670] = true, -- Toadstool, Bloodtooth
      [125671] = true, -- Toadstool, Bloodtooth Cap
      [125672] = true, -- Toadstool, Bloodtooth Cluster
      [125595] = true, -- Mushroom, Poison Pax Shelf
      [125596] = true, -- Mushroom, Poison Pax Stool
      [125590] = true, -- Mushrooms, Lavaburst Cluster
      [125589] = true, -- Mushroom, Lavaburst Bud
      [125598] = true, -- Mushroom, Emerging Stinkhorn
      [125583] = true, -- Mushroom, Cave Bracket
      [120878] = true, -- Gravestone, Ornamented
    },
  },
}

-- 14 Harrowstorm
FurC.EventItems[ver.HARROW] = {
  ["Anniversary Jubilee"] = { -- 2020-04-02 till 2020-04-14; 2021-04-01 till 2021-04-15
    ["Impresario"] = {
      [159464] = { itemPrice = 3 }, -- Replica Jubilee Cake 2016
      [159465] = { itemPrice = 3 }, -- Replica Jubilee Cake 2017
      [159466] = { itemPrice = 3 }, -- Replica Jubilee Cake 2018
      [159467] = { itemPrice = 3 }, -- Replica Jubilee Cake 2019
      [159470] = { itemPrice = 3 }, -- Replica Jubilee Cake 2020
      [171601] = { itemPrice = 3 }, -- Replica Jubilee Cake 2021
    },
  },
}

-- 11 Elsweyr
FurC.EventItems[ver.KITTY] = {
  ["Witches' Festival"] = {
    ["Plunder Skull"] = {
      [118149] = true, -- Block and Axe, Chopping
      [145317] = true, -- Gravestone, Broken
    },
  },
}

-- 6 Dragon Bones
FurC.EventItems[ver.DRAGONS] = {
  ["Jester's Festival"] = {
    ["Jester's Boxes"] = {
      [134680] = true, -- Jester Box
    },
  },
}

-- 4 Horns of the Reach
FurC.EventItems[ver.REACH] = {
  ["Witches' Festival"] = {
    ["Plunder Skull"] = {
      [130337] = true, -- Witches Corpse, Wrapped,
      [130325] = true, -- Witches Totem, Emphatic Warning,
      [130327] = true, -- Witches Totem, Wooden Rack,
      [130328] = true, -- Witches Skull, Horned Ram,
      [130332] = true, -- Witches Totem, Bone Charms,
      [130340] = true, -- Witches Totem, Gnarled Vines and Skull,
      [130339] = true, -- Witches Totem, Twisted Vines and Skull
      [130338] = true, -- Witches Bones, Offering,
      [145318] = true, -- Small Gravestone
      [130302] = GetString(SI_FURC_WW), -- Shrub, Burnt Brush
      [130298] = GetString(SI_FURC_WW), -- Branch, Curved Laurel
      [130296] = GetString(SI_FURC_WW), -- Branch, Sturdy Laurel
      [130295] = GetString(SI_FURC_WW), -- Branch, Sturdy Burnt
      [130294] = GetString(SI_FURC_WW), -- Branch, Forked Burnt
      [130293] = GetString(SI_FURC_WW), -- Branch, Curved Burnt
      [130301] = GetString(SI_FURC_WW), -- Saplings, Burnt Sparse
      [130299] = GetString(SI_FURC_WW), -- Saplings, Burnt Cluster
      [130300] = GetString(SI_FURC_WW), -- Saplings, Burnt Tall
      [130297] = GetString(SI_FURC_WW), -- Branch, Forked Laurel
      [130280] = GetString(SI_FURC_WW), -- Sapling, Petrified Ashen
    },
  },
}

-- 3 Morrowind
FurC.EventItems[ver.MORROWIND] = {
  ["Midyear Mayhem"] = {
    ["Boon Box"] = {
      [126157] = true, -- Song of Pelinal, #1
      [126158] = true, -- Song of Pelinal, #2
      [126159] = true, -- Song of Pelinal, #3
      [126160] = true, -- Song of Pelinal, #4
      [126161] = true, -- Song of Pelinal, #5
      [126162] = true, -- Song of Pelinal, #6
      [126163] = true, -- Song of Pelinal, #7
      [126164] = true, -- Song of Pelinal, #8
    },
  },

  ["New Life"] = {
    ["Gift Box"] = {
      [118053] = true, -- Common Campfire, Outdoor
    },
  },
}

-- 2 Homestead
FurC.EventItems[ver.HOMESTEAD] = {
  ["Jester Festival"] = {
    ["Jester Boxes"] = {
      [120995] = true, -- Banner, Jester's Standard
      [134680] = true, -- Banner, Jester's Standard
    },
  },
}
