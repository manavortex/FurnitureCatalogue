local ver = FurC.Constants.Versioning

-- 27 Base Game Patch
FurC.EventItems[ver.BASED] = {
  ["Witches' Festival"] = {
    ["Plunder Skull"] = {
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
  ["Anniversary Jubilee"] = { -- 2020-04-02 till 2020-04-14; 2021-04-01 till 2021-04-15
    ["Impresario"] = {
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
  ["Witches' Festival"] = {
    ["Plunder Skull"] = {
      [145317] = true, -- Gravestone, Broken
      [118149] = true, -- Block and Axe, Chopping
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
      [145318] = true, -- Small Gravestone
      [130340] = true, -- Witches Totem, Gnarled Vines and Skull,
      [130339] = true, -- Witches Totem, Twisted Vines and Skull
      [130338] = true, -- Witches Bones, Offering,
      [130337] = true, -- Witches Corpse, Wrapped,
      [130332] = true, -- Witches Totem, Bone Charms,
      [130328] = true, -- Witches Skull, Horned Ram,
      [130327] = true, -- Witches Totem, Wooden Rack,
      [130325] = true, -- Witches Totem, Emphatic Warning,
      [130302] = GetString(SI_FURC_WW), -- Shrub, Burnt Brush
      [130301] = GetString(SI_FURC_WW), -- Saplings, Burnt Sparse
      [130300] = GetString(SI_FURC_WW), -- Saplings, Burnt Tall
      [130299] = GetString(SI_FURC_WW), -- Saplings, Burnt Cluster
      [130298] = GetString(SI_FURC_WW), -- Branch, Curved Laurel
      [130297] = GetString(SI_FURC_WW), -- Branch, Forked Laurel
      [130296] = GetString(SI_FURC_WW), -- Branch, Sturdy Laurel
      [130295] = GetString(SI_FURC_WW), -- Branch, Sturdy Burnt
      [130294] = GetString(SI_FURC_WW), -- Branch, Forked Burnt
      [130293] = GetString(SI_FURC_WW), -- Branch, Curved Burnt
      [130280] = GetString(SI_FURC_WW), -- Sapling, Petrified Ashen
    },
  },
}

-- 3 Morrowind
FurC.EventItems[ver.MORROWIND] = {
  ["Midyear Mayhem"] = {
    ["Boon Box"] = {
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
      [134680] = true, -- Banner, Jester's Standard
      [120995] = true, -- Banner, Jester's Standard
    },
  },
}
