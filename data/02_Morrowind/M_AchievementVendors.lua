local ver = FurC.Constants.Versioning

local bookList = {
  [126793] = { -- The 36 Lessons: Sermon 1
    itemPrice = 3611,
  },
  [126795] = { -- The 36 Lessons: Sermon 2
    itemPrice = 3611,
  },
  [126796] = { -- The 36 Lessons: Sermon 3
    itemPrice = 3611,
  },
  [126797] = { -- The 36 Lessons: Sermon 4
    itemPrice = 3611,
  },
  [126798] = { -- The 36 Lessons: Sermon 5
    itemPrice = 3611,
  },
  [126799] = { -- The 36 Lessons: Sermon 6
    itemPrice = 3611,
  },
  [126800] = { -- The 36 Lessons: Sermon 7
    itemPrice = 3611,
  },
  [126801] = { -- The 36 Lessons: Sermon 8
    itemPrice = 3611,
  },
  [126802] = { -- The 36 Lessons: Sermon 9
    itemPrice = 3611,
  },
  [126803] = { -- The 36 Lessons: Sermon 10
    itemPrice = 3611,
  },
  [126804] = { -- The 36 Lessons: Sermon 11
    itemPrice = 3611,
  },
  [126805] = { -- The 36 Lessons: Sermon 12
    itemPrice = 3611,
  },
  [126806] = { -- The 36 Lessons: Sermon 13
    itemPrice = 3611,
  },
  [126807] = { -- The 36 Lessons: Sermon 14
    itemPrice = 3611,
  },
  [126808] = { -- The 36 Lessons: Sermon 15
    itemPrice = 3611,
  },
  [126809] = { -- The 36 Lessons: Sermon 16
    itemPrice = 3611,
  },
  [126810] = { -- The 36 Lessons: Sermon 17
    itemPrice = 3611,
  },
  [126811] = { -- The 36 Lessons: Sermon 18
    itemPrice = 3611,
  },
  [126812] = { -- The 36 Lessons: Sermon 19
    itemPrice = 3611,
  },
  [126813] = { -- The 36 Lessons: Sermon 20
    itemPrice = 3611,
  },
  [126814] = { -- The 36 Lessons: Sermon 21
    itemPrice = 3611,
  },
  [126815] = { -- The 36 Lessons: Sermon 22
    itemPrice = 3611,
  },
  [126816] = { -- The 36 Lessons: Sermon 23
    itemPrice = 3611,
  },
  [126817] = { -- The 36 Lessons: Sermon 24
    itemPrice = 3611,
  },
  [126818] = { -- The 36 Lessons: Sermon 25
    itemPrice = 3611,
  },
  [126819] = { -- The 36 Lessons: Sermon 26
    itemPrice = 3611,
  },
  [126820] = { -- The 36 Lessons: Sermon 27
    itemPrice = 3611,
  },
  [126821] = { -- The 36 Lessons: Sermon 28
    itemPrice = 3611,
  },
  [126822] = { -- The 36 Lessons: Sermon 29
    itemPrice = 3611,
  },
  [126823] = { -- The 36 Lessons: Sermon 30
    itemPrice = 3611,
  },
  [126824] = { -- The 36 Lessons: Sermon 31
    itemPrice = 3611,
  },
  [126825] = { -- The 36 Lessons: Sermon 32
    itemPrice = 3611,
  },
  [126826] = { -- The 36 Lessons: Sermon 33
    itemPrice = 3611,
  },
  [126827] = { -- The 36 Lessons: Sermon 34
    itemPrice = 3611,
  },
  [126828] = { -- The 36 Lessons: Sermon 35
    itemPrice = 3611,
  },
  [126829] = { -- The 36 Lessons: Sermon 36
    itemPrice = 3611,
  },
}

local boxes = {}
local b2 = {
  [120998] = { -- Block,Wood Cutting
    itemPrice = 100,
  },
  [117959] = { -- Rough Container, Shipping
    itemPrice = 100,
  },
  [117931] = { -- Rough Crate Lid
    itemPrice = 100,
  },
  [117957] = { -- Rough Crate, Cracked
    itemPrice = 100,
  },
  [117958] = { -- Rough Crate, Empty
    itemPrice = 100,
  },
  [117930] = { -- Rough Crate, Open
    itemPrice = 100,
  },
  [117953] = { -- Rough Crate, Sealed
    itemPrice = 100,
  },
  [117928] = { -- Rough Crate, Sturdy
    itemPrice = 100,
  },
}
FurC.Books[ver.MORROWIND] = bookList

FurC.AchievementVendors[ver.MORROWIND] = {
  ["Vivec City, Saint Delyn Inn"] = {
    ["Drops-No-Glass, Temple Doctrine Collection"] = bookList,
    ["Drops-No-Glass"] = {
      [126638] = { -- Ashlander Altar, Anticipations
        itemPrice = 50000,
        achievement = 1825, -- Clanfriend
      },
      [126640] = { -- Ashlander Fence, Totems
        itemPrice = 10000,
        achievement = 1881, -- Ashlander Relic Preserver
      },
      [126613] = { -- Ashlander Throne
        itemPrice = 100000,
        achievement = 1849, -- Voices of the Failed Incarnates
      },
      [126639] = { -- Ashlander Yurt, Netch-Hide
        itemPrice = 75000,
        achievement = 1880, -- Ashlands Stalker
      },
      [126623] = { -- Banner of House Dres
        itemPrice = 10000,
        achievement = 1867, -- Morrowind Grand Adventurer
      },
      [126621] = { -- Banner of House Hlaalu
        itemPrice = 10000,
        achievement = 1867, -- Morrowind Grand Adventurer
      },
      [126620] = { -- Banner of House Redoran
        itemPrice = 10000,
        achievement = 1867, -- Morrowind Grand Adventurer
      },
      [126622] = { -- Banner of House Telvanni
        itemPrice = 10000,
        achievement = 1867, -- Morrowind Grand Adventurer
      },
      [126624] = { -- Banner of House Indoril
        itemPrice = 10000,
        achievement = 1867, -- Morrowind Grand Adventurer
      },
      [126628] = { -- Banner, Morag Tong
        itemPrice = 25000,
        achievement = 1870, -- Naryu's Confidant
      },
      [126615] = { -- Blessing Stone
        itemPrice = 10000,
        achievement = 1850, -- Bearer of the Blessed Staff
      },
      [126614] = { -- Blessing Stone Device
        itemPrice = 20000,
        achievement = 1850, -- Bearer of the Blessed Staff
      },
      [126618] = { -- Dwarven Brazier, Eternal
        itemPrice = 50000,
        achievement = 1854, -- N'chow conqueror
      },
      [126632] = { -- Glass Crystal, Plume
        itemPrice = 15000,
        achievement = 1874, -- Pilgrim Protector
      },
      [126631] = { -- Glass Crystal, Radiance
        itemPrice = 15000,
        achievement = 1874, -- Pilgrim Protector
      },
      [126633] = { -- Glass Crystals, Bed
        itemPrice = 20000,
        achievement = 1874, -- Pilgrim Protector
      },
      [126629] = { -- Kwama Queen Egg
        itemPrice = 15000,
        achievement = 1872, -- Kwama Miner
      },
      [126630] = { -- Replica Stone of Ashalmwia
        itemPrice = 75000,
        achievement = 1873, -- Dratha Quest
      },
      [126635] = { -- Sacred Guar Skull
        itemPrice = 15000,
        achievement = 1876, -- Ald'Ruhn Annalist
      },
      [126642] = { -- Silt Strider Shell, Hollow
        itemPrice = 10000,
        achievement = 1826, -- Strider Carawaner
      },
      [126617] = { -- Statue of Vivec the Champion
        itemPrice = 150000,
        achievement = 1852, -- Champion of Vivec
      },
      [126636] = { -- Statue, Cowering Ebony
        itemPrice = 50000,
        achievement = 1877, -- Ebony Enforcer
      },
      [126637] = { -- Statue, Terrified Ebony
        itemPrice = 50000,
        achievement = 1877, -- Ebony Enforcer
      },
      [126616] = { -- Statuette of Clavicus Vile, Masked
        itemPrice = 100000,
        achievement = 1851, -- Hand of a Living God
      },
      [126627] = { -- Tapestry, Morag Tong
        itemPrice = 35000,
        achievement = 1870, -- Naryu's Confidant
      },
      [126634] = { -- Tapestry, St. Veloth
        itemPrice = 20000,

        achievement = 1875, -- Narsis's Apprentice
      },
      [126626] = { -- Telvanni Device
        itemPrice = 50000,
        achievement = 1869, -- Telvanni quest
      },
      [126792] = { -- Temple Doctrine: the 36
        itemPrice = 130000,
        achievement = 1824, -- Tribunal Preacher
      },
      [126619] = { -- Totem of the Sixth House
        itemPrice = 100000,
        achievement = 1856, -- Forgotten Wastes Vanquisher
      },
      [126625] = { -- Tribunal Shrine in Fountain
        itemPrice = 50000,
        achievement = 1868, -- Savior of Morrowind
      },
      [126641] = { -- Triptych of the Triune
        itemPrice = 20000,
        achievement = 1827, -- The Pilgrim's Path
      },
      [126794] = { -- Sermon 37
        itemPrice = 50000,
        achievement = 1868, -- Saviour of Morrowind
      },
    },

    ["Uzipa"] = {
      [120998] = { -- Block, Wood Cutting
        itemPrice = 100,
      },
      [125481] = { -- Boulder, Volcanic Column
        itemPrice = 500,
      },
      [125483] = { -- Boulder, Volcanic Plug
        itemPrice = 500,
      },
      [125587] = { -- Mushroom ,Funnel Caps
        itemPrice = 15000,
      },
      [125588] = { -- Mushroom, Lanky Erupted Stinkcap
        itemPrice = 750,
      },
      [125593] = { -- Mushroom, Netch Shield Platform
        itemPrice = 25000,
      },
      [125594] = { -- Mushroom, Netch Shield Tower
        itemPrice = 20000,
      },
      [125599] = { --
        itemPrice = 750,
      },
      [125602] = { --
        itemPrice = 750,
      },
      [125601] = { --
        itemPrice = 750,
      },
      [125604] = { --
        itemPrice = 750,
      },
      [125612] = { -- Mushrooms, Funnel Cap Cluster
        itemPrice = 22500,
      },
      [125614] = { -- Mushrooms, Netch Hide Shade
        itemPrice = 750,
      },
      [125638] = { -- Rock, Volcanic Chunk
        itemPrice = 100,
      },
      [125639] = { -- Rock, Volcanic Slab
        itemPrice = 100,
      },
      [125641] = { -- Sapling, Forked Ashland
        itemPrice = 250,
      },
      [125642] = { -- Sapling, Lanky Ash Laurel
        itemPrice = 250,
      },
      [125643] = { -- Sapling, Sturdy Ash Laurel
        itemPrice = 250,
      },
      [125644] = { -- Sapling, Tall Ashland
        itemPrice = 250,
      },
      [125645] = { -- Saplings, Ashland
        itemPrice = 250,
      },
      [125673] = { -- Tree, Lanky Poplar
        itemPrice = 500,
      },
      [125678] = { -- Tree, Sturdy Poplar
        itemPrice = 500,
      },
      [125679] = { -- Tree, Poplar Cluster
        itemPrice = 500,
      },
      [125677] = { -- Tree, Rooted Ashland
        itemPrice = 40000,
      },
      [125676] = { -- Tree, Rooted Cedar
        itemPrice = 50000,
      },
    },
  },

  ["Vivec City, Gladiator's Quarters"] = {
    ["Brelda Ofemalen"] = {
      [126649] = { -- Banner of the Fire Drakes
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126712] = { -- Banner of the PD
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126650] = { -- Banner of the SL
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126646] = { -- Standard of the FD
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },
      [126648] = { -- Standard of the PD
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },
      [126647] = { -- Standard of the SL
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },

      [126713] = { -- Tapestry of the FD
        itemPrice = 100000,
        achievement = 1910, -- Conquering Hero
      },
      [126715] = { -- Tapestry of the PD
        itemPrice = 100000,
        achievement = 1910, -- Conquering Hero
      },
      [126714] = { -- Tapestry of the SL
        itemPrice = 100000,

        achievement = 1910, -- Conquering Hero
      },
    },

    ["Llivas Driler"] = {
      [126716] = { -- Brazier of the FD
        itemPrice = 50000,
        achievement = 1913, -- Grand Champion
      },
      [126718] = { -- Chained Skull of the PD
        itemPrice = 100000,
        achievement = 1913, -- Grand Champion
      },
      [126717] = { -- Weathervane of the SL
        itemPrice = 125000,
        achievement = 1913, -- Grand Champion
      },
      [126643] = { -- Crown of the SL
        itemPrice = 75000,
        achievement = 1901, -- Grand Relic Guardian
      },
      [126644] = { -- FD's Skull
        itemPrice = 150000,
        achievement = 1901, -- Grand Relic Guardian
      },
      [126645] = { -- Skull of the PD
        itemPrice = 100000,
        achievement = 1901, -- Grand Relic Guardian
      },
    },
  },

  [GetString(FURC_AV_CAPITAL)] = {
    [GetString(FURC_AV_HER)] = {
      [126720] = { -- Banner of Mayhem
        itemPrice = 5000,
        achievement = 1883, -- Mayhem Connaiseour
      },
      [126721] = { -- Corpse of Mayhem, Argonian
        itemPrice = 15000,
        achievement = 1888, -- Wrath of the Whitestrake
      },
      [126722] = { -- Corpse of Mayhem,Khajiit
        itemPrice = 15000,
        achievement = 1888, -- Wrath of the Whitestrake
      },
      [126723] = { -- Corpse of Mayhem, Orc
        itemPrice = 15000,
        achievement = 1888, -- Wrath of the Whitestrake
      },
      [126724] = { -- Propbably-Not-Punch Bowl of Mayhem
        itemPrice = 30000,
        achievement = 1892, -- Star-made Knight
      },
      [126719] = { -- Standard of Mayhem
        itemPrice = 2500,
        achievement = 1883, -- Mayhem Connaiseour
      },
    },
  },

  ["the Mages' guild"] = {
    ["the Mystic as part of a collection"] = bookList,
  },
}

-- global function, needs to live here, YES MANA
function FurC.SetupMorrowindItems()
  -- FurC.AchievementVendors[ver.MORROWIND]["the Mages' guild"]["the Mystic as part of a collection"] = bookList
  local listTable
  listTable = FurC.AchievementVendors[ver.MORROWIND]["Vivec City, Saint Delyn Inn"]["Uzipa"]
  listTable = FurC.MergeTable(listTable, boxes)
end
