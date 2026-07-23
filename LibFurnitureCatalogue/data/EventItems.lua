FurC.EventItems = FurC.EventItems or {}

local ver = FurC.Constants.Versioning
local events = FurC.Constants.Events
local npc = FurC.Constants.NPC
local containers = FurC.Constants.Containers

local function getQuestString(questIdOrName)
  local questName = questIdOrName
  if type(questIdOrName) == "number" then
    questName = GetQuestName(questIdOrName)
  end
  return zo_strformat("<<1>>: <<2>>", GetString(SI_FURC_SRC_QUEST), questName)
end

local function getCollectibleString(collectibleIdOrName)
  local collectibleName = collectibleIdOrName
  if type(collectibleIdOrName) == "number" then
    collectibleName = GetCollectibleName(collectibleIdOrName)
  end
  return zo_strformat("<<1>>: <<2>>", GetString(SI_FURC_SRC_COLLECTIBLE), collectibleName)
end

FurC.EventItems[ver.ZERO] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [223759] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2026
      [224081] = { -- Replica Jubilee Cake 2026 
	    itemPrice = 300,
		achievement = getCollectibleString(14325),
	  },
    },
  },
  
  [events.NIGHTMARKET] = {
    [npc.NM] = {
      [224092] = { -- Thousand Eyes Banner, Small Hanging
        itemPrice = 5000,
        achievement = getQuestString(7363), -- Those Who Would Rule
      },
	  [224089] = { -- Thousand Eyes Banner, Large Hanging
	    itemPrice = 5000,
        achievement = getQuestString(7363),
	  },
	  [224090] = { -- Glittering Goad Banner, Small Hanging
	    itemPrice = 5000,
        achievement = getQuestString(7363),
	  },
	  [224087] = { -- Glittering Goad Banner, Large Hanging
	    itemPrice = 5000,
        achievement = getQuestString(7363),
	  },
	  [224091] = { -- Ruckus Banner, Small Hanging
	    itemPrice = 5000,
        achievement = getQuestString(7363),
	  },
	  [224088] = { -- Ruckus Banner, Large Hanging
	    itemPrice = 5000,
        achievement = getQuestString(7363),
	  },
	  [224095] = { -- Antiweather Pylon
	    itemPrice = 20000,
	  },
	  [224096] = { -- Incandescent Pod, Small
	    itemPrice = 5000,
	  },
	  [224093] = { -- Incandescent Pod, Large
	    itemPrice = 25000,
	  },
	  [224094] = { -- Flamepitcher
	    itemPrice = 20000,
	  },
	  [224097] = { -- Duneripper Viscera
	    itemPrice = 3000,
	  },
	  [224098] = { -- Jump Pad, Decommissioned
	    itemPrice = 2000,
	  },
	  [224099] = { -- Essence Crucible
	    itemPrice = 20000,
		achievement = 4522, -- Brazen Bruiser
	  },
	  [224100] = { -- Hourglass of Akatosh, Shattered
	    itemPrice = 20000,
		achievement = 4521, -- Argent Annihilation
	  },	  
	},
  },
}

-- 37 Seasons of the Worm Cult Part 2
FurC.EventItems[ver.WORMS2] = {
  [events.JESTER] = {
    [containers.JESTERBOX] = {
      [214490] = { -- Jester's Garland, Short
		itemPrice = 10000,
		achievement = 1720, -- Dazzling Entertainer
	  },
	  [214489] = { -- Jester's Garland, Long
		itemPrice = 10000,
		achievement = 1720,
	  },
	  [214488] = { -- Jester's Mask, Happy
		itemPrice = 5000,
		achievement = 1719, -- Illusive Dazzler
	  },
	  [214491] = { -- Jester's Mask, Sad
		itemPrice = 5000,
		achievement = 1719,
	  },
	  [214492] = { -- Jester's Festival Flyer
		itemPrice = 5000,
		achievement = 1719,
	  },
    },
  },
}

FurC.EventItems[ver.FALLBAN] = {
  [events.CRIME] = {
    [containers.POUCH] = {
      [214244] = true, -- Crime Notice, Large
      [214245] = true, -- Crime Notice, Small
      [214246] = true, -- Coin, Single
      [214247] = true, -- Coin Pile, Small
      [214248] = true, -- Coin Pile, Tall
    },
  },
  
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [214243] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2025
      [214242] = { -- Replica Jubilee Cake 2025 
	    itemPrice = 300,
		achievement = getCollectibleString(13520),
	  },
    },
  },
}

-- 33 Golden Pursuits 44
FurC.EventItems[ver.BASE44] = {
  [events.ANNIVERSARY] = {
      [containers.JUBILEEBOX] = {
        [211549] = { -- Jubilee Banner, Hanging
          itemPrice = 10000,
		  achievement = 4031, -- Cake Devourer
        },
        [211550] = { -- Jubilee Banner, Small
          itemPrice = 2500,
		  achievement = 4031,
        },
        [211541] = { -- Jubilee Garland, Curved
          itemPrice = 2500,
		  achievement = 4031,
        },
        [211544] = { -- Jubilee Garland, Curved Double
          itemPrice = 5000,
		  achievement = 4031,
        },
        [211542] = { -- Jubilee Garland, Straight Long
          itemPrice = 2500,
		  achievement = 4031,
        },
        [211543] = { -- Jubilee Garland, Straight Short
          itemPrice = 2500,
		  achievement = 4031,
        },
        [211551] = { -- Jubilee Garland, Streamers
          itemPrice = 5000,
		  achievement = 4031,
        },
        [211548] = { -- Jubilee Rug, Small
          itemPrice = 5000,
		  achievement = 4031,
        },
        [211547] = { -- Jubilee Wind Chime, Floral
          itemPrice = 10000,
		  achievement = 4292, -- Jubilee Cake Slice 2025
        },
        [211545] = { -- Jubilee Wreath
          itemPrice = 5000,
		  achievement = 4031,
        },
        [211546] = { -- Jubilee Wreath, Bell Chime
          itemPrice = 10000,
		  achievement = 4292, 
        },
	  },
	},
	[events.JESTER] = {
	  [containers.JESTERBOX] = {
	    [211553] = { -- Jester's Festival Garland, Long Flags
          itemPrice = 5000,
 		  achievement = 1723,
        },
        [211552] = { -- Jester's Festival Garland, Short Flags
          itemPrice = 2500,
		  achievement = 1723,
        },
        [211554] = { -- Jester's Festival Plaque, King Boar
          itemPrice = 50000,
		  achievement = 1716,
        },
        [211555] = { -- Jester's Festival Plaque, Queen Boar
          itemPrice = 50000,
		  achievement = 1716,
        },
        [211558] = { -- Jester's Festival Rug, Star
          itemPrice = 10000,
		  achievement = 1720,
        },
        [211557] = { -- Jester's Festival Rug, Swirls
          itemPrice = 5000,
		  achievement = 1720,
        },
        [211559] = { -- Jester's Festival Sign
          itemPrice = 10000,
		  achievement = 1720,
        },
        [211556] = { -- Jester's Festival Wreath
          itemPrice = 10000,
		  achievement = 1720,
        },
      },
  },
}

-- 32 Home Tours Update 43
FurC.EventItems[ver.BASE43] = {
  [events.UNDAUNTED] = {
    [containers.UNDAUNTEDBOX] = {
      [208112] = true, -- Rug of the Undaunted, Rectangular
      [208110] = true, -- Tankard of Undaunted Victory, Infernal
      [208108] = true, -- Tankard of Undaunted Victory, Green
      [208107] = true, -- Wind Chimes, Undaunted Glory
      [208106] = true, -- Stuffed Troll Head, Ivy-Adorned
	  [208114] = true, -- Garland of Undaunted Trophies
	  [208113] = true, -- Rug of the Undaunted, Octagram
	  [208111] = true, -- Keg of Triumph, Jeering Clannfear Beer
	  [208109] = true, -- Tankard of Undaunted Victory, Bone
    },
  },
}

-- 30 Scions of Ithelia
FurC.EventItems[ver.SCIONS] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [203888] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2024
      [203887] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2023
      [203886] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2022
      [203885] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2021
      [203884] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2020
      [203883] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2019
      [203882] = { itemPrice = 100 }, -- Replica Jubilee Cake Slice 2016-2018
      [203829] = { -- Replica Jubilee Cake 2024 
	    itemPrice = 300,
		achievement = getCollectibleString(12422),
	  },
    },
  },
}

-- 28 Base Game Patch
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

-- 26 Scribes of Fate
FurC.EventItems[ver.SCRIBE] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [194359] = { -- Replica Jubilee Cake 2023 
	    itemPrice = 300,
		achievement = getCollectibleString(11089),
	  },
    },
  },
}

-- 22 Ascending Tide
FurC.EventItems[ver.TIDES] = {
  [events.ANNIVERSARY] = {
    [npc.EVENT] = {
      [183902] = { -- Replica Jubilee Cake 2022 
	    itemPrice = 300,
		achievement = getCollectibleString(10287),
	  },
    },
  },
}

-- 20 Waking Flame
FurC.EventItems[ver.WAKE] = {
  [events.BLACKWOOD] = { -- 2021-9-30 - 2021-10-12
    [npc.EVENT] = {
      [181488] = { itemPrice = 500 }, -- Statue, Saint Kaladas
    },
  },

  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [181494] = true, -- Vampiric Container, Yellow Liquid
      [181493] = true, -- Vampiric Container, Congealed Liquid
      [181492] = true, -- Vampiric Flask Stand, Double
      [181491] = true, -- Vampiric Lightpost, Azure Double
      [181490] = true, -- Vampiric Lightpost, Azure Single
      [181489] = true, -- Vampiric Lamp, Azure Tall
      [178799] = true, -- Ruby Candlefly Gathering
    },
  },
}

-- 14 Harrowstorm
FurC.EventItems[ver.HARROW] = {
  [events.ANNIVERSARY] = { -- 2020-04-02 till 2020-04-14; 2021-04-01 till 2021-04-15
    [npc.EVENT] = {
      [171601] = { -- Replica Jubilee Cake 2021 
	    itemPrice = 300,
		achievement = getCollectibleString(9012),
	  },
      [159470] = { -- Replica Jubilee Cake 2020 
	    itemPrice = 300,
		achievement = getCollectibleString(7619),
	  },
      [159467] = { -- Replica Jubilee Cake 2019 
	    itemPrice = 300,
		achievement = getCollectibleString(5886),
	  },
      [159466] = { -- Replica Jubilee Cake 2018 
	    itemPrice = 300,
		achievement = getCollectibleString(4786),
	  },
      [159465] = { -- Replica Jubilee Cake 2017 
	    itemPrice = 300,
		achievement = getCollectibleString(1109),
	  },
      [159464] = { -- Replica Jubilee Cake 2016 
	    itemPrice = 300,
		achievement = getCollectibleString(356),
	  },
    },
  },
}

-- 9 Wolfhunter
FurC.EventItems[ver.WEREWOLF] = {
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [145317] = true, -- Gravestone, Broken
	  [120877] = true, -- Gravestone, Cracked
	  [145318] = true, -- Gravestone, Small Broken
	  [120878] = true, -- Gravestone, Ornamented
    },
    [npc.EVENT] = {
	  [142004] = { itemPrice = 200 }, -- Specimen Jar, Spare Brain
	},
  },
}

-- 6 Dragon Bones
FurC.EventItems[ver.DRAGONS] = {
  [events.JESTER] = {
    [containers.JESTERBOX] = {
      [134680] = true, -- Jester's Coffer
    },
  },
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [139162] = true, -- Webs, Cone
    },
  },
}

-- 5 Clockwork City
FurC.EventItems[ver.CLOCKWORK] = {
  [events.NEWLIFE] = {
    [npc.HOLIDAY] = {
      [134291] = { -- New Life Bonfire
        itemPrice = 10000,
        achievement = 1671,
      },
      [134290] = { -- New Life Celebrant's Standard
        itemPrice = 2500,
        achievement = 1674,
      },
    },
  },
 }
 
-- 4 Horns of the Reach
FurC.EventItems[ver.REACH] = {
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [130340] = true, -- Witches Totem, Gnarled Vines and Skull
      [130339] = true, -- Witches Totem, Twisted Vines and Skull
	  [130326] = true, -- Witches Brazier, Primitive Log
      [130338] = true, -- Witches Bones, Offering
      [130337] = true, -- Witches Corpse, Wrapped
      [130332] = true, -- Witches Totem, Bone Charms
      [130328] = true, -- Witches Skull, Horned Ram
      [130327] = true, -- Witches Totem, Wooden Rack
      [130325] = true, -- Witches Totem, Emphatic Warning
	  [130322] = true, -- Tool, Harvest Scythe
      [130319] = true, -- Crop, Wheat Stack
      [130318] = true, -- Crop, Wheat Pile
      [130317] = true, -- Pumpkin, Sickly
      [130316] = true, -- Pumpkin, Frail
    },
	
	[npc.HOLIDAY] = {
      [131433] = { -- Witches Festival, Plunder Skulls
        itemPrice = 10000,
        achievement = 1542,
      },
      [130336] = { -- Witches Remains, Hagraven
        itemPrice = 10000,
        achievement = 1546,
      },
      [131434] = { -- Witch's Festival, Cursed Totem
        itemPrice = 25000,
        achievement = 1543,
      },
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
	
	[npc.HOLIDAY] = {
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

  [events.NEWLIFE] = {
    [containers.NEWLIFEBOX] = {
      [118053] = true, -- Common Campfire, Outdoor
    },
  },
  
  [events.WITCHES] = {
    [containers.PLUNDERSKULL] = {
      [118149] = true, -- Block and Axe, Chopping
	  [125589] = true, -- Mushroom, Lavaburst Bud
	  [125672] = true, -- Toadstool, Bloodtooth Cluster
      [125671] = true, -- Toadstool, Bloodtooth Cap
      [125670] = true, -- Toadstool, Bloodtooth
      [125598] = true, -- Mushroom, Emerging Stinkhorn
      [125596] = true, -- Mushroom, Poison Pax Stool
      [125590] = true, -- Mushroom, Lavaburst Cluster
    },	
  },
}

-- 2 Homestead
FurC.EventItems[ver.HOMESTEAD] = {
  [events.JESTER] = {
    [containers.JESTERBOX] = {
      [120994] = { -- Tree, Jester's Large
        itemPrice = 15000,
        achievement = 1723,
      },
      [118529] = { -- Tree, Jester's Small
        itemPrice = 5000,
        achievement = 1723,
      },
	  [120995] = { -- Banner, Jester's Standard
	    itemPrice = 5000,
		achievement = 1723,
	  },
    },
  },
}
