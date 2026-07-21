FurC.AchievementVendors = FurC.AchievementVendors or {}
FurC.Books = FurC.Books or {}

local events = FurC.Constants.Events
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local skillLine = FurC.Constants.SkillLines
local ver = FurC.Constants.Versioning

local strRank = FurC.Utils.FmtRank

local function getQuestString(questIdOrName)
  local questName = questIdOrName
  if type(questIdOrName) == "number" then
    questName = GetQuestName(questIdOrName)
  end
  return zo_strformat("<<1>>: <<2>>", GetString(SI_FURC_SRC_QUEST), questName)
end

local bookList = {
  [120197] = { -- 16 accords of madness, vol vi
    itemPrice = 500,
  },
  [120121] = { -- The Glenmoril Wyrd
    itemPrice = 500,
  },
  [120112] = { -- Legend of the fallen drotto
    itemPrice = 500,
  },
  [120115] = { -- The Posting of the hunt
    itemPrice = 500,
  },
  [120117] = { -- The Viridian Sentinel
    itemPrice = 500,
  },
  [120120] = { -- Ancient Scrolls of the Dwemer IV
    itemPrice = 500,
  },
  [120181] = { -- Antecedent of Dwemer Law
    itemPrice = 500,
  },
  [120116] = { -- Aspects of Lord Hircine
    itemPrice = 500,
  },
  [120114] = { -- Bangkorai, Shield of High Rock
    itemPrice = 500,
  },
  [120104] = { -- Bloodfiends of Rivenspire
    itemPrice = 500,
  },
  [120132] = { -- Circus of Cheerful Slaughter
    itemPrice = 5000,
  },
  [120186] = { -- Dwemer Inquiries, Vol I
    itemPrice = 500,
  },
  [120187] = { -- Dwemer Inquiries, Vol II
    itemPrice = 500,
  },
  [120188] = { -- Dwemer Inquiries, Vol III
    itemPrice = 500,
  },
  [120106] = { -- House-Folk of Silverhoof
    itemPrice = 500,
  },
  [120111] = { -- House Ravenwatch Proclamation
    itemPrice = 500,
  },
  [120108] = { -- House Tamrith - A recent history
    itemPrice = 500,
  },
  [120113] = { -- Living with Lycantrophy
    itemPrice = 500,
  },
  [120194] = { -- Myths of Sheogorath, Vol 1
    itemPrice = 500,
  },
  [120110] = { -- Myths of Sheogorath, Vol 2
    itemPrice = 500,
  },
  [120195] = { -- Myths of Sheogorath, Vol 2
    itemPrice = 500,
  },
  [120236] = { -- Proper Life: Three CHants
    itemPrice = 500,
  },
  [120133] = { -- Robier's Vegetable Garden
    itemPrice = 5000,
  },
  [120109] = { -- Shornhelm, city of the north
    itemPrice = 500,
  },
  [120102] = { -- The Barrows of Westmark Moor
    itemPrice = 500,
  },
  [120232] = { -- The Cantatas of Vivec
    itemPrice = 500,
  },
  [120190] = { -- The Homilies of Blessed Almalexia
    itemPrice = 500,
  },
  [120191] = { -- The Legendary Scourge
    itemPrice = 500,
  },
  [120192] = { -- The Lusty Argonian Maid 1
    itemPrice = 500,
  },
  [120193] = { -- The Lusty Argonian Maid 2
    itemPrice = 500,
  },
  [120199] = { -- Wabbajack
    itemPrice = 500,
  },
  [120235] = { -- Ode to the Tundrastriders
    itemPrice = 500,
  },
  [120237] = { -- Song of the Askelde men
    itemPrice = 500,
  },
  [120230] = { -- Battle of Glenumbra Moors
    itemPrice = 500,
  },
  [120231] = { -- Book of Dawn and Dusk
    itemPrice = 500,
  },
  [120196] = { -- Warrior's Charge
    itemPrice = 500,
  },
  [120082] = {
    itemPrice = 500,
  },
  [120083] = {
    itemPrice = 500,
  },
  [120084] = {
    itemPrice = 500,
  },
  [120085] = {
    itemPrice = 500,
  },
  [120086] = {
    itemPrice = 500,
  },
  [120087] = {
    itemPrice = 500,
  },
  [120088] = {
    itemPrice = 500,
  },
  [120089] = {
    itemPrice = 500,
  },
  [120090] = {
    itemPrice = 500,
  },
  [120091] = {
    itemPrice = 500,
  },
  [120092] = {
    itemPrice = 500,
  },
  [120093] = {
    itemPrice = 500,
  },
  [120094] = {
    itemPrice = 500,
  },
  [120095] = {
    itemPrice = 500,
  },
  [120096] = {
    itemPrice = 500,
  },
  [120097] = {
    itemPrice = 500,
  },
  [120098] = {
    itemPrice = 500,
  },
  [120099] = {
    itemPrice = 500,
  },
  [120100] = {
    itemPrice = 500,
  },
  [120101] = {
    itemPrice = 500,
  },
  [120103] = {
    itemPrice = 500,
  },
  [120105] = {
    itemPrice = 500,
  },
  [120107] = {
    itemPrice = 500,
  },
  [120118] = {
    itemPrice = 500,
  },
  [120119] = {
    itemPrice = 500,
  },
  [120122] = {
    itemPrice = 500,
  },
  [120123] = {
    itemPrice = 500,
  },
  [120124] = {
    itemPrice = 500,
  },
  [120125] = {
    itemPrice = 500,
  },
  [120126] = {
    itemPrice = 500,
  },
  [120127] = {
    itemPrice = 500,
  },
  [120128] = {
    itemPrice = 500,
  },
  [120129] = {
    itemPrice = 500,
  },
  [120130] = {
    itemPrice = 500,
  },
  [120131] = {
    itemPrice = 500,
  },
  [120134] = {
    itemPrice = 500,
  },
  [120135] = {
    itemPrice = 500,
  },
  [120136] = {
    itemPrice = 500,
  },
  [120137] = {
    itemPrice = 500,
  },
  [120138] = {
    itemPrice = 500,
  },
  [120139] = {
    itemPrice = 500,
  },
  [120140] = {
    itemPrice = 500,
  },
  [120141] = {
    itemPrice = 500,
  },
  [120142] = {
    itemPrice = 500,
  },
  [120143] = {
    itemPrice = 500,
  },
  [120144] = {
    itemPrice = 500,
  },
  [120145] = {
    itemPrice = 500,
  },
  [120146] = {
    itemPrice = 500,
  },
  [120147] = {
    itemPrice = 500,
  },
  [120148] = {
    itemPrice = 500,
  },
  [120149] = {
    itemPrice = 500,
  },
  [120150] = {
    itemPrice = 500,
  },
  [120151] = {
    itemPrice = 500,
  },
  [120152] = {
    itemPrice = 500,
  },
  [120153] = {
    itemPrice = 500,
  },
  [120154] = {
    itemPrice = 500,
  },
  [120155] = {
    itemPrice = 500,
  },
  [120156] = {
    itemPrice = 500,
  },
  [120157] = {
    itemPrice = 500,
  },
  [120158] = {
    itemPrice = 500,
  },
  [120159] = {
    itemPrice = 500,
  },
  [120160] = {
    itemPrice = 500,
  },
  [120161] = {
    itemPrice = 500,
  },
  [120162] = {
    itemPrice = 500,
  },
  [120163] = {
    itemPrice = 500,
  },
  [120164] = {
    itemPrice = 500,
  },
  [120165] = {
    itemPrice = 500,
  },
  [120166] = {
    itemPrice = 500,
  },
  [120167] = {
    itemPrice = 500,
  },
  [120168] = {
    itemPrice = 500,
  },
  [120169] = {
    itemPrice = 500,
  },
  [120170] = {
    itemPrice = 500,
  },
  [120171] = {
    itemPrice = 500,
  },
  [120172] = {
    itemPrice = 500,
  },
  [120173] = {
    itemPrice = 500,
  },
  [120174] = {
    itemPrice = 500,
  },
  [120175] = {
    itemPrice = 500,
  },
  [120176] = {
    itemPrice = 500,
  },
  [120177] = {
    itemPrice = 500,
  },
  [120178] = {
    itemPrice = 500,
  },
  [120179] = {
    itemPrice = 500,
  },
  [120180] = {
    itemPrice = 500,
  },
  [120182] = {
    itemPrice = 500,
  },
  [120183] = {
    itemPrice = 500,
  },
  [120184] = {
    itemPrice = 500,
  },
  [120185] = {
    itemPrice = 500,
  },
  [120189] = {
    itemPrice = 500,
  },
  [120198] = {
    itemPrice = 500,
  },
  [120200] = {
    itemPrice = 500,
  },
  [120201] = {
    itemPrice = 500,
  },
  [120202] = {
    itemPrice = 500,
  },
  [120203] = {
    itemPrice = 500,
  },
  [120204] = {
    itemPrice = 500,
  },
  [120205] = {
    itemPrice = 500,
  },
  [120206] = {
    itemPrice = 500,
  },
  [120207] = {
    itemPrice = 500,
  },
  [120208] = {
    itemPrice = 500,
  },
  [120209] = {
    itemPrice = 500,
  },
  [120210] = {
    itemPrice = 500,
  },
  [120211] = {
    itemPrice = 500,
  },
  [120212] = {
    itemPrice = 500,
  },
  [120213] = {
    itemPrice = 500,
  },
  [120214] = {
    itemPrice = 500,
  },
  [120215] = {
    itemPrice = 500,
  },
  [120216] = {
    itemPrice = 500,
  },
  [120217] = {
    itemPrice = 500,
  },
  [120218] = {
    itemPrice = 500,
  },
  [120219] = {
    itemPrice = 500,
  },
  [120220] = {
    itemPrice = 500,
  },
  [120221] = {
    itemPrice = 500,
  },
  [120222] = {
    itemPrice = 500,
  },
  [120223] = {
    itemPrice = 500,
  },
  [120224] = {
    itemPrice = 500,
  },
  [120225] = {
    itemPrice = 500,
  },
  [120226] = {
    itemPrice = 500,
  },
  [120227] = {
    itemPrice = 500,
  },
  [120228] = {
    itemPrice = 500,
  },
  [120229] = {
    itemPrice = 500,
  },
  [120233] = {
    itemPrice = 500,
  },
  [120234] = {
    itemPrice = 500,
  },
  [120238] = {
    itemPrice = 500,
  },
  [120239] = {
    itemPrice = 500,
  },
  [120240] = {
    itemPrice = 500,
  },
  [120241] = {
    itemPrice = 500,
  },
  [120242] = {
    itemPrice = 500,
  },
  [120243] = {
    itemPrice = 500,
  },
  [120244] = {
    itemPrice = 500,
  },
  [120245] = {
    itemPrice = 500,
  },
  [120246] = {
    itemPrice = 500,
  },
  [120247] = {
    itemPrice = 500,
  },
  [120248] = {
    itemPrice = 500,
  },
  [120249] = {
    itemPrice = 500,
  },
  [120250] = {
    itemPrice = 500,
  },
  [120251] = {
    itemPrice = 500,
  },
  [120252] = {
    itemPrice = 500,
  },
  [120253] = {
    itemPrice = 500,
  },
  [120254] = {
    itemPrice = 500,
  },
  [120255] = {
    itemPrice = 500,
  },
  [120256] = {
    itemPrice = 500,
  },
  [120257] = {
    itemPrice = 500,
  },
  [120258] = {
    itemPrice = 500,
  },
  [120259] = {
    itemPrice = 500,
  },
  [120260] = {
    itemPrice = 500,
  },
  [120261] = {
    itemPrice = 500,
  },
  [120262] = {
    itemPrice = 500,
  },
  [120263] = {
    itemPrice = 500,
  },
  [120264] = {
    itemPrice = 500,
  },
  [120265] = {
    itemPrice = 500,
  },
  [120266] = {
    itemPrice = 500,
  },
  [120267] = {
    itemPrice = 500,
  },
  [120268] = {
    itemPrice = 500,
  },
  [120269] = {
    itemPrice = 500,
  },
  [120270] = {
    itemPrice = 500,
  },
  [120271] = {
    itemPrice = 500,
  },
  [120272] = {
    itemPrice = 500,
  },
  [120273] = {
    itemPrice = 500,
  },
  [120274] = {
    itemPrice = 500,
  },
  [120275] = {
    itemPrice = 500,
  },
  [120276] = {
    itemPrice = 500,
  },
  [120277] = {
    itemPrice = 500,
  },
  [120278] = {
    itemPrice = 500,
  },
  [120279] = {
    itemPrice = 500,
  },
  [120280] = {
    itemPrice = 500,
  },
  [120281] = {
    itemPrice = 500,
  },
  [120282] = {
    itemPrice = 500,
  },
  [120283] = {
    itemPrice = 500,
  },
  [120284] = {
    itemPrice = 500,
  },
  [120285] = {
    itemPrice = 500,
  },
  [120286] = {
    itemPrice = 500,
  },
  [120287] = {
    itemPrice = 500,
  },
  [120288] = {
    itemPrice = 500,
  },
  [120289] = {
    itemPrice = 500,
  },
  [120290] = {
    itemPrice = 500,
  },
  [120291] = {
    itemPrice = 500,
  },
  [120292] = {
    itemPrice = 500,
  },
  [120293] = {
    itemPrice = 500,
  },
  [120294] = {
    itemPrice = 500,
  },
  [120295] = {
    itemPrice = 500,
  },
  [120296] = {
    itemPrice = 500,
  },
  [120297] = {
    itemPrice = 500,
  },
  [120298] = {
    itemPrice = 500,
  },
  [120299] = {
    itemPrice = 500,
  },
  [120300] = {
    itemPrice = 500,
  },
  [120301] = {
    itemPrice = 500,
  },
  [120302] = {
    itemPrice = 500,
  },
  [120303] = {
    itemPrice = 500,
  },
  [120304] = {
    itemPrice = 500,
  },
  [120305] = {
    itemPrice = 500,
  },
  [120306] = {
    itemPrice = 500,
  },
  [120307] = {
    itemPrice = 500,
  },
  [120308] = {
    itemPrice = 500,
  },
  [120309] = {
    itemPrice = 500,
  },
  [120310] = {
    itemPrice = 500,
  },
  [120311] = {
    itemPrice = 500,
  },
  [120312] = {
    itemPrice = 500,
  },
  [120313] = {
    itemPrice = 500,
  },
  [120314] = {
    itemPrice = 500,
  },
  [120315] = {
    itemPrice = 500,
  },
  [120316] = {
    itemPrice = 500,
  },
  [120317] = {
    itemPrice = 500,
  },
  [120318] = {
    itemPrice = 500,
  },
  [120319] = {
    itemPrice = 500,
  },
  [120320] = {
    itemPrice = 500,
  },
  [120321] = {
    itemPrice = 500,
  },
  [120322] = {
    itemPrice = 500,
  },
  [120323] = {
    itemPrice = 500,
  },
  [120324] = {
    itemPrice = 500,
  },
  [120325] = {
    itemPrice = 500,
  },
  [120326] = {
    itemPrice = 500,
  },
  [120327] = {
    itemPrice = 500,
  },
  [120328] = {
    itemPrice = 500,
  },
  [120329] = {
    itemPrice = 500,
  },
  [120330] = {
    itemPrice = 500,
  },
  [120331] = {
    itemPrice = 500,
  },
  [120332] = {
    itemPrice = 500,
  },
  [120333] = {
    itemPrice = 500,
  },
  [120334] = {
    itemPrice = 500,
  },
  [120335] = {
    itemPrice = 500,
  },
  [120336] = {
    itemPrice = 500,
  },
  [120337] = {
    itemPrice = 500,
  },
  [120338] = {
    itemPrice = 500,
  },
  [120339] = {
    itemPrice = 500,
  },
  [120340] = {
    itemPrice = 500,
  },
  [120341] = {
    itemPrice = 500,
  },
  [120342] = {
    itemPrice = 500,
  },
  [120343] = {
    itemPrice = 500,
  },
  [120344] = {
    itemPrice = 500,
  },
  [120345] = {
    itemPrice = 500,
  },
  [120346] = {
    itemPrice = 500,
  },
  [120347] = {
    itemPrice = 500,
  },
  [120348] = {
    itemPrice = 500,
  },
  [120349] = {
    itemPrice = 500,
  },
  [120350] = {
    itemPrice = 500,
  },
  [120351] = {
    itemPrice = 500,
  },
  [120352] = {
    itemPrice = 500,
  },
  [120353] = {
    itemPrice = 500,
  },
  [120354] = {
    itemPrice = 500,
  },
  [120355] = {
    itemPrice = 500,
  },
  [120356] = {
    itemPrice = 500,
  },
  [120357] = {
    itemPrice = 500,
  },
  [120358] = {
    itemPrice = 500,
  },
  [120359] = {
    itemPrice = 500,
  },
  [120360] = {
    itemPrice = 500,
  },
  [120361] = {
    itemPrice = 500,
  },
  [120362] = {
    itemPrice = 500,
  },
  [120363] = {
    itemPrice = 500,
  },
  [120364] = {
    itemPrice = 500,
  },
  [120365] = {
    itemPrice = 500,
  },
  [120366] = {
    itemPrice = 500,
  },
  [120367] = {
    itemPrice = 500,
  },
  [120368] = {
    itemPrice = 500,
  },
  [120369] = {
    itemPrice = 500,
  },
  [120370] = {
    itemPrice = 500,
  },
  [120371] = {
    itemPrice = 500,
  },
  [120372] = {
    itemPrice = 500,
  },
  [120373] = {
    itemPrice = 500,
  },
  [120374] = {
    itemPrice = 500,
  },
  [120375] = {
    itemPrice = 500,
  },
  [120376] = {
    itemPrice = 500,
  },
  [120406] = {
    itemPrice = 500,
  },
  [120407] = {
    itemPrice = 500,
  },
}

-- 40 Season One
FurC.AchievementVendors[ver.THIEVES] = {
  [loc.GLENUMBRA] = {
    [npc.AF] = {
      [225179] = { -- Koldane Cartel Banner
        itemPrice = 900,
        achievement = 4589,
      },
      [225180] = { -- Nowhere Key, Replica
        itemPrice = 9000,
        achievement = 4591,
      },
      [225181] = { -- Thieves Moon, Replica
        itemPrice = 31500,
        achievement = 4594,
      },
      [225182] = { -- Cheese Stack, Giant
        itemPrice = 18000,
        achievement = 4597,
      },
      [225195] = { -- Aspect of the Mad God, Anger
        itemPrice = 45000,
        achievement = 4599,
      },
      [225196] = { -- Aspect of the Mad God, Amusement
        itemPrice = 45000,
        achievement = 4599,
      },
      [225197] = { -- Aspect of the Mad God, Laughter
        itemPrice = 45000,
        achievement = 4599,
      },
    },
  },
}

-- 38 Season Zero
FurC.AchievementVendors[ver.ZERO] = {}

-- 37 Seasons of the Worm Cult Part 2
FurC.AchievementVendors[ver.WORMS2] = {
  [loc.SOLSTICE] = {
    [npc.AF] = {
      [223664] = { -- Worm Cult Tent, Cultist's
        itemPrice = 75000,
        achievement = 4460,
      },
      [223663] = { -- Worm Cult Banner, Hanging Red
        itemPrice = 10000,
        achievement = 4473,
      },
      [223661] = { -- Worm King's Sarcophagus, Necropolis Replica
        itemPrice = 150000,
        achievement = 4475, -- Hero of Solstice
      },
      [223662] = { -- Ashbound Hall Aspect Lock, Replica
        itemPrice = 75000,
        achievement = 4407,
      },
    },
  },
}

-- 36 Feast of Shadows
FurC.AchievementVendors[ver.SHADOWS] = {
  [loc.SOLSTICE] = {
    [npc.AF] = {
      [219726] = { -- Worm Cult Crystal Pylon
        itemPrice = 50000,
        achievement = 4449, -- Barrier Buster
      },
      [219725] = { -- Stirk Fellowship Command Tent
        itemPrice = 100000,
        achievement = 4425, -- Siege Camp Guardian
      },
    },
  },

  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [217972] = { -- Naj-Caldeesh Drawbridge, Stone
        itemPrice = 40000,
        achievement = 4311, -- Naj-Caldeesh Vanquisher
      },
      [217971] = { -- Coldharbour Archway, Grand
        itemPrice = 25000,
        achievement = 4334, -- Black Gem Foundry Vanquisher
      },
    },
  },
}

-- 35 Seasons of the Worm Cult
FurC.AchievementVendors[ver.WORMS] = {
  [npc.CAF] = {
    [217650] = { -- Argonian Houseboat
      itemPrice = 50000,
      achievement = 4426, -- Commemorative Master Angler
    },
    [217601] = { -- Molag Bal Plaque
      itemPrice = 14000,
      achievement = 1003,
    },
  },
  [loc.SOLSTICE] = {
    [npc.AF] = {
      [217593] = { -- Doorway, Daedric Vertebrae
        itemPrice = 25000,
        achievement = 4266, -- Ossein Cage Vanquisher
      },
      [217592] = { -- Inert Portal
        itemPrice = 24000,
        achievement = 4264, -- Deetra Grotto Group event
      },
      [217591] = { -- Solstice Bismuth, Giant Formation
        itemPrice = 70000,
        achievement = 4263, -- Western Solstice Cave Delver
      },
      [217596] = { -- Subclassing Banner
        itemPrice = 12000,
        achievement = 4402,
      },
      [217599] = { -- Sunport Banner
        itemPrice = 12000,
        achievement = 4412, -- Sunport Savior
      },
      [217595] = { -- Tide-Born Boat
        itemPrice = 8000,
        achievement = 4404, -- Western Solstice Master Angler
      },
      [217598] = { -- Worm Cult Banner
        itemPrice = 12000,
        achievement = 4414, -- Archmage Whisperer
      },
      [217594] = { -- Tide-Born Pool, Ceremonial
        itemPrice = 50000,
        achievement = 4408,
      },
      [217597] = { -- Meridian Cynosure, Inert
        itemPrice = 5000,
        achievement = 4461,
      },
    },
  },
}

-- 34 Fallen Banners
FurC.AchievementVendors[ver.FALLBAN] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [212586] = { -- Redguard Boat, Sailing
        itemPrice = 50000,
        achievement = 4128,
      },
      [212587] = { -- Exiled Redoubt Banner
        itemPrice = 4500,
        achievement = 4109,
      },
      [214249] = { -- Replica Soul Reaper
        itemPrice = 50000,
        achievement = 4306,
      },
    },
  },
}

-- 33 Golden Pursuits Update 44
FurC.AchievementVendors[ver.BASE44] = {
  [loc.REAPER] = {
    [npc.AF] = {
      [211504] = { -- Sky Spirits Reflection Pool
        itemPrice = 25000,
        achievement = 4248,
      },
      [211506] = { -- Empathic Portal Remnant
        itemPrice = 25000,
        achievement = 4245,
      },
    },
  },
}

-- 32 Home Tours Update 43
FurC.AchievementVendors[ver.BASE43] = {
  [loc.DUNG_IA] = {
    [npc.AF] = {
      [203600] = { -- Scribing Altar
        itemPrice = 30000,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3985, -- Inheritor of the Scholarium
      },
    },
  },
}

-- 31 Gold Road
FurC.AchievementVendors[ver.WEALD] = {
  [loc.WEALD] = {
    [npc.AF] = {
      [204789] = { -- Ayleid Stele, Tall
        itemPrice = 20000,
        achievement = 3951, -- Gold Road Master Explorer
      },
      [204788] = { -- Colovian Cheese Press, Large
        itemPrice = 10000,
        achievement = 3970, -- Quality Colovian Tools
      },
      [204787] = { -- Colovian Lamppost, Overgrown
        itemPrice = 15000,
        achievement = 3962, -- Fate-Eater Bane
      },
      [204786] = { -- Lucent Throne, Replica
        itemPrice = 20000,
        achievement = 3976, -- Seeker of the Forgotten
      },
      [204798] = { -- Mirror of Truth, Replica
        itemPrice = 25000,
        achievement = 3949, -- West Weald Skyshard Hunter
      },
      [204794] = { -- Null Arca, Replica
        itemPrice = 75000,
        achievement = 4013, -- Lucent Citadel Vanquisher
      },
      [204779] = { -- Portal to the Loom of the Untraveled Road, Replica
        itemPrice = 50000,
        achievement = 4043, -- Champion of Gold Road
      },
      [204785] = { -- Recollection Camp Sign, Sprouted
        itemPrice = 15000,
        achievement = 3950, -- Hero of the Gold Road
      },
      [204791] = { -- Sapling, Dawnwood Growth
        itemPrice = 4000,
        achievement = 3968, -- Gold Road Partaker
      },
      [204781] = { -- Skingrad Banner, Small
        itemPrice = 10000,
        achievement = 3974, -- False Hope
      },
    },
  },

  [loc.SCHOLAR] = {
    [npc.AF] = {
      [204780] = { -- Fable of the Dragon
        itemPrice = 4000,
        achievement = 3997, -- Signature Script Mastery
      },
      [204782] = { -- Fable of the Gryphon
        itemPrice = 4000,
        achievement = 3996, -- Focus Script Mastery
      },
      [204783] = { -- Fable of the Indrik
        itemPrice = 4000,
        achievement = 3988, -- Master Scriber
      },
      [204790] = { -- Fable of the Netch
        itemPrice = 4000,
        achievement = 3998, -- Affix Script Mastery
      },
      [204793] = { -- Scholarium Column, Large
        itemPrice = 8000,
        achievement = 3991, -- Ink Amasser
      },
      [204795] = { -- Scholarium Door, Dragon
        itemPrice = 20000,
        achievement = 4103, -- This One's a Puzzler
      },
      [204796] = { -- Scholarium Door, Gryphon
        itemPrice = 20000,
        achievement = 4102, -- Feathered Knight, Furred Thief
      },
      [204797] = { -- Scholarium Door, Indrik
        itemPrice = 20000,
        achievement = 4100, -- The Responsibility of Power
      },
      [206538] = { -- Scholarium Door, Netch
        itemPrice = 20000,
        achievement = 4101, -- Stay Buoyant, Be Joyous
      },
      [198673] = { -- Scholarium Door, Study
        itemPrice = 15000,
        achievement = 4099, -- A Portal to Last a Lifetime
      },
      [207961] = { -- Scholarium Ward
        itemPrice = 65000,
        achievement = 4104, -- Beyond the Locked Door
      },
    },
  },
}

-- 30 Scions of Ithelia
FurC.AchievementVendors[ver.SCIONS] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [203313] = { -- Many Paths Monument
        itemPrice = 20000,
        achievement = 3810, -- Oathsworn Pit Vanquisher
      },
      [203312] = { -- Mirror Barrier, Shattered
        itemPrice = 15000,
        achievement = 3851, -- Bedlam Veil Vanquisher
      },
    },
  },
}

-- 29 Secrets of the Telvanni
FurC.AchievementVendors[ver.ENDLESS] = {
  [loc.DUNG_IA] = {
    [npc.AF] = {
      [203155] = { -- Apocrypha Drying Rack, Paper
        itemPrice = 1000,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3765, -- A Little Help Never Hurt
      },
      [203153] = { -- Apocrypha Pedestal
        itemPrice = 5500,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3799, -- Mora's Onslaught (There is an error in game with this achievement. The item states the achievement required is called "Gathering Arms" though no such achievement is found. It may be any stage of the achievement listed above.)
      },
      [203158] = { -- Apocrypha Plant, Languid Tentacles
        itemPrice = 20000,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3798, -- Archive's Most Adored
      },
      [203152] = { -- Apocrypha Window, Eye
        itemPrice = 6800,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3762, -- Fortune's Soldier
      },
      [203157] = { -- Apocryphal Obelisk
        itemPrice = 7500,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3769, -- First Splurge!
      },
      [203154] = { -- Choral Altar
        itemPrice = 7500,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3805, -- Studying Up
      },
      [203159] = { -- Daedric Arch, Glass
        itemPrice = 6500,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3760, -- Heavy Hitter
      },
      [203160] = { -- Infinite Archive Access, Replica
        itemPrice = 6000,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3802, -- A Sturdy Shield
      },
      [203156] = { -- Infinite Archive Index, Replica
        itemPrice = 25000,
        currency = CURT_ARCHIVAL_FORTUNES,
        achievement = 3772, -- Running the Gauntlet
      },
    },
  },
}

-- 27 Necrom
FurC.AchievementVendors[ver.NECROM] = {
  [loc.TELVANNI] = {
    [npc.AF] = {
      [197717] = { -- Apocrypha Altar, Lighted
        itemPrice = 25000,
        achievement = 3642, -- Apocryphal Investigator
      },
      [197719] = { -- Apocrypha Courtyard Pool
        itemPrice = 18000,
        achievement = 3646, -- Secret Keeper
      },
      [197722] = { -- Apocrypha Portal Seal, Replica
        itemPrice = 17000,
        achievement = 3635, -- Defender of Necrom
      },
      [197723] = { -- Apocrypha Stalk, Scryeball
        itemPrice = 10000,
        achievement = 3636, -- Necrom Master Angler
      },
      [197716] = { -- Crystalline Mind Barrier, Replica
        itemPrice = 25000,
        achievement = 3558, -- Sanity's Edge Vanquisher
      },
      [197726] = { -- Dormant Tyranite Calx
        itemPrice = 20000,
        achievement = 3689, -- Sharp's Companion
      },
      [197720] = { -- Hermaeus Mora Banner
        itemPrice = 12000,
        achievement = 3676, -- Pulled from the Depths
      },
      [197718] = { -- Necrom Archway
        itemPrice = 15000,
        achievement = 3679, -- Necrom Master Explorer
      },
      [197715] = { -- Necrom Stele, Ceremonial
        itemPrice = 80000,
        achievement = 3674, -- Hero of Necrom
      },
      [197725] = { -- Replica Fateweaver Key
        itemPrice = 20000,
        achievement = 3692, -- Azandar's Companion
      },
      [197724] = { -- Tales of Tribute Kit, Travel
        itemPrice = 11000,
        achievement = 3702, -- Play the Paramount
      },
      [197721] = { -- The Lord of Fate and Knowledge Frieze
        itemPrice = 15000,
        achievement = 3640, -- Ghost Catcher
      },
    },
  },
}

-- 26 Scribes of Fate
FurC.AchievementVendors[ver.SCRIBE] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [193815] = { -- Craglorn Podium, Filled
        itemPrice = 4500,
        achievement = 3529, -- Scrivener's Hall Vanquisher
      },
      [193814] = { -- Dark Elf Archway, Stone
        itemPrice = 15000,
        achievement = 3468, -- Bal Sunnar Vanquisher
      },
    },
  },
}

-- 25 Firesong
FurC.AchievementVendors[ver.DRUID] = {
  [loc.GALEN] = {
    [npc.AF] = {
      [192426] = { -- Ascendant Knight Banner
        itemPrice = 12000,
        achievement = 3508, -- Bane of the Dreadsails
      },
      [192416] = { -- Druid Ritual Stone
        itemPrice = 20000,
        achievement = 3491, -- Galen Master Explorer
      },
      [192415] = { -- Druidic Statue, Left Hand
        itemPrice = 2000,
        achievement = 3556, -- Buried Bequest
      },
      [192411] = { -- Druidic Statue, Right Hand
        itemPrice = 2000,
        achievement = 3556, -- Buried Bequest
      },
      [192419] = { -- Druidic Throne, Floral Stone
        itemPrice = 25000,
        achievement = 3553, -- Broken Braigh
      },
      [192428] = { -- Eerie Sconce, Emerald
        itemPrice = 14000,
        achievement = 3511, -- Dreamwalker
      },
      [192564] = { -- Firesong Spring, Basalt
        itemPrice = 40000,
        achievement = 3514, -- Druid Kingslayer
      },
      [192417] = { -- Flower Trap, Tamed
        itemPrice = 15000,
        achievement = 3494, -- Defender of Galen
      },
      [192565] = { -- Lava Spout
        itemPrice = 75000,
        achievement = 3497, -- Volcanic Vanquisher
      },
      [192424] = { -- Systres Trinket Box, Painted
        itemPrice = 2500,
        achievement = 3551, -- Anointed Archdruid
      },
      [192421] = { -- The Druid King's Ivy Throne
        itemPrice = 50000,
        achievement = 3501, -- Savior of Galen
      },
    },
  },
}

-- 24 Lost Depths
FurC.AchievementVendors[ver.DEPTHS] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [189504] = { -- Deeproot's Undying Bloom
        itemPrice = 25000,
        achievement = 3375, -- Earthen Root Enclave Vanquisher
      },
      [189505] = { -- Reinforced Dwarfglass Window, Massive
        itemPrice = 40000,
        achievement = 3394, -- Graven Deep Vanquisher
      },
    },
  },
}

-- 23 High Isle
FurC.AchievementVendors[ver.BRETON] = {
  [loc.HIGHISLE] = {
    [npc.AF] = {
      [187867] = { -- Dreadsail Door, Grand
        itemPrice = 35000,
        achievement = 3242, -- Dreadsail Reef Vanquisher
      },
      [187866] = { -- Gonfalon Bay Banner
        itemPrice = 12000,
        achievement = 3304, -- The Plot Thickens
      },
      [187809] = { -- High Isle Door, Ornate Crypt
        itemPrice = 10000,
        achievement = 3271, -- Savior of High Isle
      },
      [187810] = { -- High Isle Mausoleum, Ancient Marble
        itemPrice = 20000,
        achievement = 3306, -- Ascendant Unmasked
      },
      [187815] = { -- High Isle Oar, Gondola
        itemPrice = 2000,
        achievement = 3269, -- High Isle Master Angler
      },
      [187798] = { -- High Isle Sundial
        itemPrice = 3000,
        achievement = 3272, -- High Isle Master Explorer
      },
      [187812] = { -- Replica Bloodmage's Crystal Heart
        itemPrice = 70000,
        achievement = 3284, -- Crimson Coin Conqueror
      },
      [187813] = { -- Replica Invitation Medallion
        itemPrice = 15000,
        achievement = 3300, -- Champion of High Isle
      },
      [187811] = { -- Replica Maormer Lightning-Rod
        itemPrice = 15000,
        achievement = 3244, -- Dreadsail Reef Conqueror
      },
      [187803] = { -- Tales of Tribute Banner
        itemPrice = 4000,
        achievement = 3319, -- The Roister's Roost
      },
    },
  },
}

-- 22 Ascending Tides
FurC.AchievementVendors[ver.TIDES] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [184204] = { -- Eerie Lantern, Hanging
        itemPrice = 10000,
        achievement = 3114, -- Shipwright's Regret Vanquisher
      },
      [184203] = { -- Gryphon Nest
        itemPrice = 2000,
        achievement = 3104, -- Coral Aerie Vanquisher
      },
    },
  },
}

-- 21 Deadlands
FurC.AchievementVendors[ver.DEADL] = {
  [loc.FARGRAVE] = {
    [npc.AF] = {
      [182306] = { -- Daedric Altar, Mehrunes Dagon
        itemPrice = 4500,
        achievement = 3145, -- Hero of Fargrave
      },
      [182310] = { -- Deadlands Buttress
        itemPrice = 2500,
        achievement = 3141,
      },
      [182309] = { -- Deadlands Buttress, Large
        itemPrice = 4000,
        achievement = 3138,
      },
      [182312] = { -- Deadlands Displacer, Inactive
        itemPrice = 4000,
        achievement = 3192, -- Deadlands Portal Punisher
      },
      [182307] = { -- Deadlands Lightning Rod, Etched
        itemPrice = 60000,
        achievement = 3217, -- Eternal Optimist
      },
      [182311] = { -- Deadlands Platform, Octagonal
        itemPrice = 4000,
        achievement = 3204, -- The Grasp of the Stricture
      },
      [182308] = { -- Deadlands Wind Gate Pinion
        itemPrice = 14000,
        achievement = 3208, -- Deadlands Grand Adventurer
      },
      [182305] = { -- Deadlands Window, Stormglass
        itemPrice = 40000,
        achievement = 3214, -- Hopeful Rescuer
      },
      [182313] = { -- Portal Key Replica
        itemPrice = 20000,
        achievement = 3209, -- Stranger in Town
      },
      [182315] = { -- Sulfur Pool
        itemPrice = 20000,
        achievement = 3144, -- Deadlands Master Angler
      },
      [182304] = { -- Tree, Charred Dagonic
        itemPrice = 15000,
        achievement = 3211, -- Deadlands Jailbreaker
      },
    },
  },
}

-- 20 Waking Flame
FurC.AchievementVendors[ver.WAKE] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [181509] = { -- Agonymium Stone, Inert
        itemPrice = 15000,
        achievement = 3026, -- The Dread Cellar Vanquisher
      },
      [181510] = { -- Silver Rose Banner
        itemPrice = 12000,
        achievement = 3016, -- Red Petal Bastion Vanquisher
      },
    },
  },
}

-- 19 Blackwood
FurC.AchievementVendors[ver.BLACKW] = {
  [loc.BLACKWOOD] = {
    [npc.AF] = {
      [175707] = { -- Banner of Leyawiin
        itemPrice = 12000,
        achievement = 3056, -- Blackwood Grand Adventurer
      },
      [175703] = { -- Banner, Tattered Mehrunes Dagon
        itemPrice = 12000,
        achievement = 2985,
      },
      [175700] = { -- Deadlands Chandelier, Caged
        itemPrice = 10000,
        achievement = 2971,
      },
      [175705] = { -- Deadlands Pillar, Tall Inscribed
        itemPrice = 20000,
        achievement = 3050, -- Ambition Acquirer
      },
      [175709] = { -- Deadlands Podium of Ruination
        itemPrice = 15000,
        achievement = 3053, -- Disaster Averter
      },
      [175708] = { -- Deadlands Tormentor, Chained
        itemPrice = 20000,
        achievement = 3051, -- Party Crasher
      },
      [175702] = { -- Entwined Snakes, Crystal Holder
        itemPrice = 12000,
        achievement = 2980,
      },
      [175704] = { -- Inert Oblivion Gate
        itemPrice = 50000,
        achievement = 3007, -- Rockgrove Vanquisher
      },
      [175706] = { -- Seal of the Ambitions
        itemPrice = 25000,
        achievement = 3055, -- Champion of Blackwood
      },
      [175701] = { -- Xi-Tsei Stone Idol
        itemPrice = 4000,
        achievement = 2973,
      },
    },
  },
}

-- 18 Flames of Ambition
FurC.AchievementVendors[ver.FLAMES] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [171775] = { -- Fountain of the Fiery Drake
        itemPrice = 50000,
        achievement = 2831, -- Black Drake Villa Vanquisher
      },
      [171776] = { -- Basalt Pillar, Glowing
        itemPrice = 12000,
        achievement = 2841, -- Cauldron Vanquisher
      },
    },
  },
}

-- 16 Stonethorn
FurC.AchievementVendors[ver.STONET] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [167310] = { -- Castle Thorn Gargoyle
        itemPrice = 25000,
        achievement = 2704, -- Castle Thorn Vanquisher
      },
      [167334] = { -- Stone Garden Tank, Rootbound
        itemPrice = 75000,
        achievement = 2694, -- Stone Garden Vanquisher
      },
    },
  },

  [loc.SELSWEYR] = {
    [npc.AF] = {
      [156752] = { -- Aeonstone Formation, Large
        itemPrice = 50000,
        achievement = 2604, -- Bright Moons over Elsweyr
      },
      [153887] = { -- Dragonguard Banner
        itemPrice = 10000,
        achievement = 2567, -- Companion of Sai Sahan
      },
      [156754] = { -- Dragonguard Sarcophagus
        itemPrice = 12000,
        achievement = 2612, -- Dragonguard Operative
      },
      [156756] = { -- Khenarthic Bell
        itemPrice = 50000,
        achievement = 2597, --  Khenarthi's Guidance
      },
      [156753] = { -- Khenarthi's Windbells
        itemPrice = 100000,
        achievement = 2600, --  Return of the Dragonguard
      },
      [156762] = { -- Map of Southern Elsweyr, Hanging
        itemPrice = 10000,
        achievement = 2559, -- Southern Elsweyr Master Explorer
      },
      [156758] = { -- New Moon Cult Banner
        itemPrice = 10000,
        achievement = 2598, -- Infiltrating the New Moon
      },
      [156757] = { -- New Moon Cult Banner, Large
        itemPrice = 12000,
        achievement = 2598, -- Infiltrating the New Moon
      },
      [156761] = { -- Painted Rock, Heart's Ease
        itemPrice = 2000,
        achievement = 2633, -- Helping the Helpless
      },
      [156760] = { -- Painted Rock, Life's Glory
        itemPrice = 2500,
        achievement = 2633, -- Helping the Helpless
      },
      [156759] = { -- Painted Rock, Swirls
        itemPrice = 300,
        achievement = 2633, -- Helping the Helpless
      },
      [156763] = { -- Senchal Banner
        itemPrice = 10000,
        achievement = 2600, --  Return of the Dragonguard
      },
      [156755] = { -- Vine, Moonlit Cove
        itemPrice = 1000,
        achievement = 2560, -- Southern Elsweyr Cave Delver
      },
    },
  },
}

-- 17 Markarth
FurC.AchievementVendors[ver.MARKAT] = {
  [loc.REACH] = {
    [npc.AF] = {
      [171395] = { -- Dwarven Beacon, Aetheric
        itemPrice = 50000,
        achievement = 2860, -- Dynastor Deposted
      },
      [171389] = { -- Dwarven Crystal Receptacle
        itemPrice = 15000,
        achievement = 2855, -- Reach Cave Delver
      },
      [170171] = { -- Dwarven Liminal Diffusion
        itemPrice = 50000,
        achievement = 2906, -- Taking Up the Mantle
      },
      [171394] = { -- Dwarven Stand, Void Crystal
        itemPrice = 50000,
        achievement = 2859, -- Weaned From Darkness
      },
      [171388] = { -- Dwarven Tonal Cascade
        itemPrice = 15000,
        achievement = 2854, -- The Reach Master Explorer
      },
      [171396] = { -- Dwarven Tonal Manacle
        itemPrice = 15000,
        achievement = 2858, -- Defender of the Reach
      },
      [171392] = { -- Falmer Totem of Dominance
        itemPrice = 7000,
        achievement = 2852, -- Gloomreach Explorer
      },
      [171387] = { -- Nighthollow Banner
        itemPrice = 10000,
        achievement = 2941, -- Savior of the Reach
      },
      [171391] = { -- Reach Effigy of Turnabout
        itemPrice = 10000,
        achievement = 2908, -- Vateshran Hollows Conqueror
      },
      [171390] = { -- Reachwitch Protective Totem
        itemPrice = 4000,
        achievement = 2861, -- the Reach Master Angler
      },
      [171393] = { -- Tree, Reach Totem
        itemPrice = 5000,
        achievement = 2853, -- Briar Rock Ruins Explorer
      },
    },
  },
}

-- 15 Greymoor
FurC.AchievementVendors[ver.SKYRIM] = {
  [loc.WSKYRIM] = {
    [npc.AF] = {
      [166018] = { -- Doll, Heiruna
        itemPrice = 2000,
        achievement = 2645, -- Western Skyrim Cave Delver
      },
      [166020] = { -- Greymoor Keep Banner, Hanging
        itemPrice = 10000,
        achievement = 2724, -- Threat-Ender
      },
      [166016] = { --Ice Statue, Cowering Wretch
        itemPrice = 10000,
        achievement = 2641, -- Frozen Coast Explorer
      },
      [166021] = { -- Karthwatch Banner, Hanging
        itemPrice = 10000,
        achievement = 2807, -- Swordthane of Karthwatch
      },
      [166024] = { -- Kyne's Aegis Banner, Hanging
        itemPrice = 10000,
        achievement = 2732, -- Kyne's Aegis Completed
      },
      [165990] = { -- Mammoth Cheese, Pungent
        itemPrice = 25000,
        achievement = 2765, -- Giant Cheese Connoisseur
      },
      [166463] = { -- Map of Western Skyrim, Hanging
        itemPrice = 10000,
        achievement = 2647, -- Western Skyrim Master Explorer
      },
      [166022] = { -- Morthal Banner, Hanging
        itemPrice = 10000,
        achievement = 2760, -- Shieldthane of Morthal
      },
      [166025] = { -- Nord Basket Trap, Fishing
        itemPrice = 4000,
        achievement = 2655, -- Western Skyrim Master Angler
      },
      [166026] = { -- Nord Boat, Fishing
        itemPrice = 250000,
        achievement = 2734, -- Kyne's Aegis Conqueror
      },
      [166019] = { -- Replica Throne of Windhelm
        itemPrice = 100000,
        achievement = 2712, -- Savior of Western Skyrim
      },
      [166023] = { -- Solitude Banner, Hanging
        itemPrice = 10000,
        achievement = 2724, -- Threat-Ender
      },
      [166017] = { -- Witch Pike, Quiescent
        itemPrice = 15000,
        achievement = 2716, -- Champion of Solitude
      },
    },
  },
}

-- 14 Harrowstorm
FurC.AchievementVendors[ver.HARROW] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [159452] = { -- Gray Reliquary
        itemPrice = 25000,
        achievement = 2549,
      },
      [159453] = { -- Icereach Coven Totem, Emblem
        itemPrice = 12000,
        achievement = 2539,
      },
    },
  },
}

-- 13 Dragonhold
FurC.AchievementVendors[ver.DRAGON2] = {}

-- 12 Scalebreaker
FurC.AchievementVendors[ver.SCALES] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [153750] = { -- Hemo Helot, Benign
        itemPrice = 50000,
        achievement = 2415, -- Moongrave Fane Vanquisher
      },
      [153686] = { -- Plant Cluster, Azureblight Scaleleaf
        itemPrice = 3000,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
      [153685] = { -- Tree, Azureblight Acacia
        itemPrice = 12000,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
      [153687] = { -- Vine, Azureblight Strangler
        itemPrice = 4500,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
    },
  },
}

-- 11 Elsweyr
FurC.AchievementVendors[ver.KITTY] = {
  [loc.NELSWEYR] = {
    [npc.AF] = {
      [151790] = { -- Akaviri Table, Stone
        itemPrice = 10000,
        achievement = getQuestString(6307), -- Descendant of the Potentate
      },
      [151781] = { -- Banner, Anequina
        itemPrice = 10000,
        achievement = 2482,
      },
      [151780] = { -- Banner, Rimmen
        itemPrice = 10000,
        achievement = 2485,
      },
      [151801] = { -- Barrel, Riverhold
        itemPrice = 1000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151800] = { -- Cage, Small Animal
        itemPrice = 4000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151791] = { -- Column, Fatal Warning
        itemPrice = 3000,
        achievement = 2476,
      },
      [151802] = { -- Crate, Riverhold
        itemPrice = 1000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151625] = { -- Door, Akatosh Chancel
        itemPrice = 100000,
        achievement = 2433,
      },
      [151782] = { -- Khajiit Burial Mound
        itemPrice = 500,
        achievement = 2440,
      },
      [151787] = { -- Khajiit Lion Crest
        itemPrice = 15000,
        achievement = 2486,
      },
      [151788] = { -- Khajiit Wagon, Burned
        itemPrice = 500,
        achievement = 2474,
      },
      [151789] = { -- Khajiit Wagon, Merchant
        itemPrice = 1000,
        achievement = 2475,
      },
      [151968] = { -- Map of Elsweyr, Hanging
        itemPrice = 10000,
        achievement = 2404,
      },
      [151779] = { -- Moon Gate
        itemPrice = 100000,
        achievement = 2488,
      },
      [151786] = { -- Moon Temple Pad
        itemPrice = 20000,
        achievement = 2487,
      },
      [151799] = { -- Projection Stone, Moons
        itemPrice = 20000,
        achievement = 2487,
      },
      [151783] = { -- Replica Dragon Horn, Large
        itemPrice = 35000,
        achievement = 2486, -- Assassination Cessation
      },
      [151784] = { -- Replica Dragon Horn, Small
        itemPrice = 12000,
        achievement = 2486, -- Assassination Cessation
      },
      [151796] = { -- Riverhold Defense Spikes, Piled
        itemPrice = 500,
        achievement = 2484, -- Riverhold Defense
      },
      [151798] = { -- Riverhold Defense Spikes, Roof-Mounted
        itemPrice = 1000,
        achievement = 2484, -- Riverhold Defense
      },
      [151797] = { -- Riverhold Defense Spikes, Tripod
        itemPrice = 1000,
        achievement = 2484, -- Riverhold Defense
      },
      [151778] = { -- Statue, Lokkestiiz
        itemPrice = 35000,
        achievement = 2470, -- Stormchaser
      },
      [151777] = { -- Statue, Yolnahkriin
        itemPrice = 50000,
        achievement = 2469, -- Stoking the Fire
      },
      [151792] = { -- Tojay-Raht Statue, Monk
        itemPrice = 75000,
        achievement = getQuestString(6310), -- The Lunacy of Two Moons
      },
      [151785] = { -- Wrathstone, Replica
        itemPrice = 50000,
        achievement = 2446, -- Tharn Collaborator
      },
    },
  },
}

-- 10 Wrathstone
FurC.AchievementVendors[ver.WOTL] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [147645] = { -- Dwarven Tonal Arc
        itemPrice = 15000,
        achievement = 2260,
      },
      [147638] = { -- Replica Cursed Orb of Meridia
        itemPrice = 100000,
        achievement = 2270,
      },
    },
  },
}

-- 9 Wolfhunter
FurC.AchievementVendors[ver.WEREWOLF] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [141857] = { -- Ritual Chalice, Hircine
        itemPrice = 5000,
        achievement = 2162,
      },
      [141858] = { -- Banner of the Silver Dawn
        itemPrice = 15000,
        achievement = 2152,
      },
    },
  },
}

-- 8 Murkmire
FurC.AchievementVendors[ver.SLAVES] = {
  [npc.CAF] = {
    [145488] = { -- Banner, Jewelry Crafting
      itemPrice = 5000,
      achievement = 2215,
    },
  },
  [loc.MURKMIRE] = {
    [npc.AF] = {
      [145408] = { -- Argon Pedestal, Replica
        itemPrice = 15000,
        achievement = 2339, -- The River of Rebirth
      },
      [145406] = { -- Banner, Bright-Throat
        itemPrice = 10000,
        achievement = 2353, -- The Progeny
      },
      [145404] = { -- Banner, Dead-Water
        itemPrice = 10000,
        achievement = 2354, -- Cold Blood, Warm Heart
      },
      [145405] = { -- Banner, Rootwater
        itemPrice = 10000,
        achievement = 2352, -- Resplendent Rootmender
      },
      [145553] = { -- Grave Stake, Small Glyphed
        itemPrice = 5000,
        achievement = 2330, -- Surreptitiously Shadowed
      },
      [145549] = { -- Murkmire Totem, Stone Head
        itemPrice = 12000,
        achievement = getQuestString(6280), -- Art of the Nisswo
      },
      [145407] = { -- Remnant of Argon, Replica
        itemPrice = 75000,
        achievement = 2339, -- River of Rebirth
      },
      [145412] = { -- Seed Doll, Turtle
        itemPrice = 20000,
        achievement = 2336, -- Sap-Sleeper
      },
      [145576] = { -- Timid Vine-Tongue
        itemPrice = 40000,
        achievement = 2357, --  Vine-Tongue Traveler
      },
      [145596] = { -- Look Upon Their Nothing Eyes
        itemPrice = 15000,
        achievement = 2341, -- Poems of Nothing
      },
    },
  },
}

-- 7 Summerset
FurC.AchievementVendors[ver.ALTMER] = {
  [loc.SUMMERSET] = {
    [npc.AF] = {
      [139369] = { -- Abyssal Pearl, Sealed
        itemPrice = 75000,
        achievement = 2101, -- Back to the Abyss
      },
      [139388] = { -- Banner of the House of Reveries, Hanging
        itemPrice = 10000,
        achievement = getQuestString(6114), -- Manor of Masques
      },
      [139377] = { -- Banner of the Sapiarchs, Hanging
        itemPrice = 10000,
        achievement = 2204, -- Resolute Guardian
      },
      [139393] = { -- Cloudrest Banner, hanging
        itemPrice = 10000,
        achievement = 2131, -- Cloudrest Completed
      },
      [139379] = { -- Coral Formation, Luminescent
        itemPrice = 15000,
        achievement = 2202, -- Precious Pearl
      },
      [139380] = { -- Crystal Tower Key, Replica
        itemPrice = 150000,
        achievement = 2208, -- What Must Be Done
      },
      [139371] = { -- Crystal Tower Stand
        itemPrice = 50000,
        achievement = 2193, -- Savior of Summerset
      },
      [139386] = { -- Direnni Banner, Hanging
        itemPrice = 10000,
        achievement = getQuestString(6118), -- Lauriel's Lament
      },
      [139302] = { -- Display Case, Exhibit
        itemPrice = 25000,
        achievement = 2203, -- Mind Games
      },
      [139374] = { -- Enchanted Text, Illusory Forest
        itemPrice = 100000,
        achievement = 2209, -- Summerset Grand Adventurer
      },
      [139381] = { -- Evergloam Wispstone
        itemPrice = 75000,
        achievement = 2207, -- Enemy of my enemy
      },
      [139326] = { -- High Elf Statue, Kinlady
        itemPrice = 50000,
        achievement = 2204, -- Resolute Guardian
      },
      [139373] = { -- High Elf Wine Press, Display
        itemPrice = 20000,
        achievement = 2007, -- Summerset Cave Delver
      },
      [139387] = { -- Lillandril Banner
        itemPrice = 10000,
        achievement = getQuestString(6111), -- Murder In Lillandril
      },
      [139372] = { -- Mind Trap Kelp, Full-Sized
        itemPrice = 20000,
        achievement = 2203, -- Mind Games
      },
      [139383] = { -- Psijic Control Globe, Inactive
        itemPrice = 50000,
        achievement = 2206, -- Unreliable Narrator
      },
      [139370] = { -- Replica of the Transparent Law
        itemPrice = 100000,
        achievement = 2193, -- Saviour of Summerset
      },
      [139378] = { -- Shimmerene Banner, Hanging
        itemPrice = 10000,
        achievement = 2194, -- The Good of Many
      },
      [139446] = { -- Spiral Skein Coral, Brittle-Vein
        itemPrice = 10000,
        achievement = 2008, -- Summerset Pathfinder
      },
      [139382] = { -- Spiral Skein Coral, Elkhorn
        itemPrice = 1000,
        achievement = 2205, -- Sweet Dreams
      },
      [139392] = { -- Sunhold Banner, Hanging
        itemPrice = 10000,
        achievement = 2095, -- Sunhold Group Event
      },
      [139385] = { -- The Keeper's Oath
        itemPrice = 75000,
        achievement = 2099, -- Relics of Summerset
      },
      [139384] = { -- Waterfall, Small Everlasting
        itemPrice = 75000,
        achievement = 2197, -- Divine Magistrate
      },
    },
  },
}

-- 6 Dragon Bones
FurC.AchievementVendors[ver.DRAGONS] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [134908] = { -- Blackmarrow Banner
        itemPrice = 15000,
        achievement = 1959, -- Scalecaller Peak Vanquisher
      },
      [134907] = { -- Orb of Stone
        itemPrice = 50000,
        achievement = 1975,
      },
    },
  },
}

-- 5 Clockwork City
FurC.AchievementVendors[ver.CLOCKWORK] = {
  [loc.CWC] = {
    [npc.AF] = {
      [134285] = { -- Active Fabrication Tank
        itemPrice = 75000,
        achievement = 2049, -- Hero of Clockwork City
      },
      [134286] = { -- Clockwork Stylus
        itemPrice = 3000,
        achievement = 2068, -- CC Adventurer
      },
      [134289] = { -- Energetic Anima Core
        itemPrice = 15000,
        achievement = 2072, -- Brass Fortress Quarter Master
      },
      [134284] = { -- Mysterious Clockwork Sphere
        itemPrice = 35000,
        achievement = 2018, -- CC Master explorer
      },
      [134288] = { -- Skeleton Key Replica
        itemPrice = 7500,
        achievement = 2064, -- The Burden Of Knowledge
      },
      [134283] = { -- The motionless Guardian
        itemPrice = 12000,
        achievement = 2067, -- Honorary Blackfeather
      },
      [134547] = { -- The Truth in Sequence
        itemPrice = 20000,
        achievement = 2069, -- Grand Adventurer
      },
    },
  },
}

-- 4 Horns of the Reach
FurC.AchievementVendors[ver.REACH] = {
  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [131428] = { -- Horn of the Reachclans
        itemPrice = 50000,
        achievement = 1698,
      },
      [131429] = { -- Vine, Bloodroot Wriggler
        itemPrice = 5000,
        achievement = 1690,
      },
      [131432] = { -- Vine, Bloodroot Stem
        itemPrice = 5000,
        achievement = 1690,
      },
      [131430] = { -- Vine, Bloodroot Mangler
        itemPrice = 5000,
        achievement = 1690,
      },
      [131431] = { -- Vine, Bloodroot Grasper
        itemPrice = 5000,
        achievement = 1690,
      },
    },
  },
}

-- 3 Morrowind
FurC.AchievementVendors[ver.MORROWIND] = {
  [loc.VVARDENFELL] = {
    [npc.AF] = {
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
      [126792] = { -- Temple Doctrine: The 36 Lessons
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
  },

  [loc.ANY_CAPITAL] = {
    [npc.BGF] = {
      [126649] = { -- Banner of the Fire Drakes
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126712] = { -- Banner of the PD
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126650] = { -- Banner of the Storm Lords
        itemPrice = 50000,
        achievement = 1909, -- Crowd Favorite
      },
      [126646] = { -- Standard of the Fire Drake
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },
      [126648] = { -- Standard of the Fire Drake
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },
      [126647] = { -- Standard of the Storm Lords
        itemPrice = 25000,
        achievement = 1907, -- Grand Standard-Guardian
      },
      [126713] = { -- Tapestry of the Fire Drake
        itemPrice = 100000,
        achievement = 1910, -- Conquering Hero
      },
      [126715] = { -- Tapestry of the Fire Drake
        itemPrice = 100000,
        achievement = 1910, -- Conquering Hero
      },
      [126714] = { -- Tapestry of the Storm Lords
        itemPrice = 100000,
        achievement = 1910, -- Conquering Hero
      },
      [126716] = { -- Brazier of the Fire Drake
        itemPrice = 50000,
        achievement = 1913, -- Grand Champion
      },
      [126718] = { -- Chained Skull of the Fire Drake
        itemPrice = 100000,
        achievement = 1913, -- Grand Champion
      },
      [126717] = { -- Weathervane of the Storm Lords
        itemPrice = 125000,
        achievement = 1913, -- Grand Champion
      },
      [126643] = { -- Crown of the Storm Lords
        itemPrice = 75000,
        achievement = 1901, -- Grand Relic Guardian
      },
      [126644] = { -- Fire Drake's Skull
        itemPrice = 150000,
        achievement = 1901, -- Grand Relic Guardian
      },
      [126645] = { -- Skull of the Fire Drake
        itemPrice = 100000,
        achievement = 1901, -- Grand Relic Guardian
      },
    },
  },
}

-- 2 Homestead
FurC.Books[ver.HOMESTEAD] = bookList

FurC.AchievementVendors[ver.HOMESTEAD] = {
  [npc.CAF] = {
    [119987] = { -- Coldharbour Urn
      itemPrice = 5000,
      achievement = 993,
    },
    [120064] = { -- Covenant Hero Shield
      itemPrice = 10000,
      achievement = 61,
    },
    [120037] = { -- Decorative Skyshard
      itemPrice = 25000,
      achievement = 989,
    },
    [120001] = { -- Decorative Treasure Chest
      itemPrice = 10000,
      achievement = 22,
    },
    [119994] = { -- Depleted Sigil Stone
      itemPrice = 5000,
      achievement = 1000,
    },
    [120066] = { -- Display Craft Bag
      itemPrice = 5000,
      achievement = "ESO+",
    },
    [120063] = { -- Dominion Hero Shield
      itemPrice = 10000,
      achievement = 618,
    },
    [120043] = { -- Fishing Vessel
      itemPrice = 25000,
      achievement = 494,
    },
    [120056] = { -- Hanging Map of Tamriel
      itemPrice = 10000,
      achievement = 867,
    },
    [119993] = { -- Lantern of Anguish
      itemPrice = 5000,
      achievement = 999,
    },
    [120065] = { -- Pact Hero Shield
      itemPrice = 10000,
      achievement = 617,
    },
    [120039] = { -- Primal Altar to Hircine
      itemPrice = 50000,
      achievement = 1009,
    },
    [119989] = { -- Replica Black Soul Gem
      itemPrice = 2500,
      achievement = 995,
    },
    [119988] = { -- Replica Soul Gem
      itemPrice = 500,
      achievement = 994,
    },
    [119995] = { -- Silent Sentinel
      itemPrice = 20000,
      achievement = 1001,
    },
    [119990] = { -- Soul Gem Case
      itemPrice = 4000,
      achievement = 996,
    },
    [119992] = { -- Soul Gem Crate
      itemPrice = 5000,
      achievement = 998,
    },
    [119996] = { -- Soul Gem Stand
      itemPrice = 4000,
      achievement = 1002,
    },
    [119991] = { -- Spare Flesh Atronach Parts
      itemPrice = 10000,
      achievement = 997,
    },
    [119873] = { -- Tamrith Coffin
      itemPrice = 20000,
      achievement = 1010,
    },
    [119872] = { -- Tamrith Coffin Lid
      itemPrice = 5000,
      achievement = 1010,
    },
    [119997] = { -- The Final Threat
      itemPrice = 100000,
      achievement = 1003,
    },
  },
  [loc.DESHAAN] = {
    [npc.AF] = {
      [119908] = { -- Swamp Anemone
        itemPrice = 15000,
        achievement = 595,
      },
      [119914] = { -- Touch of Plague
        itemPrice = 500,
        achievement = 363,
      },
      [119913] = { -- Tribunal Altar
        itemPrice = 25000,
        achievement = 364,
      },
      [119911] = { -- Tribunal Rug
        itemPrice = 5000,
        achievement = 949,
      },
      [119910] = { -- Veloth's Reliquary
        itemPrice = 50000,
        achievement = 365,
      },
    },
  },

  [loc.BALFOYEN] = {
    [npc.AF] = {
      [120956] = { -- Atmoran Eagle Totem Medallion
        itemPrice = 3000,
        achievement = 194,
      },
      [120954] = { -- Atmoran Snake Totem Medallion
        itemPrice = 3000,
        achievement = 194,
      },
      [120955] = { -- Atmoran Whale Totem Medallion
        itemPrice = 3000,
        achievement = 194,
      },
    },
  },

  [loc.STONEFALLS] = {
    [npc.AF] = {
      [119890] = { -- Blood Fountain
        itemPrice = 100000,
        achievement = 948,
      },
      [119889] = { -- Daedric Sconce
        itemPrice = 5000,
        achievement = 209,
      },
      [119888] = { -- Lacquered Kwama Egg
        itemPrice = 1000,
        achievement = 593,
      },
      [119892] = { -- Remnant of Balreth
        itemPrice = 15000,
        achievement = 201,
      },
      [119887] = { -- Serien's Stand
        itemPrice = 10000,
        achievement = 204,
      },
    },
  },

  [loc.EASTMARCH] = {
    [npc.AF] = {
      [119905] = { -- Dragon Shrine Altar
        itemPrice = 20000,
        achievement = 598,
      },
      [119901] = { -- Lob's Challenge Horn
        itemPrice = 1000,
        achievement = 597,
      },
      [119904] = { -- Standing Slab
        itemPrice = 1000,
        achievement = 600,
      },
      [119906] = { -- Throne of the Skald King
        itemPrice = 50000,
        achievement = 951,
      },
      [119907] = { -- Visage of the Skald
        itemPrice = 25000,
        achievement = 599,
      },
    },
  },

  [loc.SHADOWFEN] = {
    [npc.AF] = {
      [119897] = { -- Argonian Egg
        itemPrice = 2500,
        achievement = 185,
      },
      [119893] = { -- Mimic Hist Tree
        itemPrice = 20000,
        achievement = 950,
      },
      [119900] = { -- Oblivion Stone
        itemPrice = 5000,
        achievement = 184,
      },
      [119898] = { -- Replica Mnemic Egg
        itemPrice = 100000,
        achievement = 596,
      },
      [119899] = { -- Replica Stone Nest
        itemPrice = 10000,
        achievement = 186,
      },
    },
  },

  [loc.RIFT] = {
    [npc.AF] = {
      [119915] = { -- Ancient Cultist Totem
        itemPrice = 5000,
        achievement = 337,
      },
      [119918] = { -- Statue of the Wolf
        itemPrice = 7500,
        achievement = 336,
      },
      [119922] = { -- Torn Worm Cult Banner
        itemPrice = 10000,
        achievement = 952,
      },
      [119920] = { -- Totem of the Reach
        itemPrice = 40000,
        achievement = 335,
      },
      [119916] = { -- Ysgramor Statue
        itemPrice = 20000,
        achievement = 603,
      },
    },
  },

  [loc.ALIKR] = {
    [npc.AF] = {
      [119879] = { -- Kneeling Ansei Statue
        itemPrice = 15000,
        achievement = 518,
      },
      [119877] = { -- Reconstructed Necromantic Focus
        itemPrice = 5000,
        achievement = 517,
      },
      [119880] = { -- Replica Of Shattered Ansei Sword
        itemPrice = 35000,
        achievement = 956,
      },
      [119878] = { -- Standing Ansei Statue
        itemPrice = 15000,
        achievement = 59,
      },
      [119876] = { -- Tu'whacca's Brazier
        itemPrice = 5000,
        achievement = 516,
      },
    },
  },

  [loc.BANG] = {
    [npc.AF] = {
      [119885] = { -- Ceremonial Redguard vessel
        itemPrice = 3000,
        achievement = 147,
      },
      [119882] = { -- Damaged Knight of St. Pelin Statue
        itemPrice = 5000,
        achievement = 146,
      },
      [119883] = { -- Evermore Mourning Banner
        itemPrice = 4000,
        achievement = 145,
      },
      [119881] = { -- Glenmoril Wyrd Stone
        itemPrice = 5000,
        achievement = 60,
      },
      [119884] = { -- Ragged Imperial Banner
        itemPrice = 4000,
        achievement = 958,
      },
    },
  },

  [loc.BETNIKH] = {
    [npc.AF] = {
      [119984] = { -- Pirate Banner
        itemPrice = 10000,
        achievement = 415,
      },
    },
  },

  [loc.GLENUMBRA] = {
    [npc.AF] = {
      [119855] = { -- Wyrdstone
        itemPrice = 2500,
        achievement = 30,
      },
      [119856] = { -- Torn Lion Guard Banner
        itemPrice = 5000,
        achievement = 28,
      },
      [119862] = { -- Hagraven Totem
        itemPrice = 5000,
        achievement = 34,
      },
      [119857] = { -- Breton Gravewatcher Statue
        itemPrice = 25000,
        achievement = 31,
      },
      [119858] = { -- Bloodthorn Vines, Small
        itemPrice = 5000,
        achievement = 953,
      },
    },
  },

  [loc.RIVENSPIRE] = {
    [npc.AF] = {
      [119871] = { -- Wagon of DEATH
        itemPrice = 25000,
        achievement = 58,
      },
      [120951] = { -- Hope of Rivenspire
        itemPrice = 5000,
        achievement = 590,
      },
      [119875] = { -- Gargoyle Statue
        itemPrice = 50000,
        achievement = 589,
      },
      [120040] = { -- Crimson-Stained Bowl
        itemPrice = 2500,
        achievement = 591,
      },
      [119870] = { -- Constellation Tile: The Tower
        itemPrice = 10000,
        achievement = 955,
      },
      [119869] = { -- Constellation Tile: The Shadow
        itemPrice = 10000,
        achievement = 955,
      },
      [119868] = { -- Constellation Tile: The Ritual
        itemPrice = 10000,
        achievement = 955,
      },
    },
  },

  [loc.STORMHAVEN] = {
    [npc.AF] = {
      [119865] = { -- Wayrest Guillotine
        itemPrice = 75000,
        achievement = 156,
      },
      [119867] = { -- Vaermina Statue
        itemPrice = 75000,
        achievement = 57,
      },
      [119864] = { -- Spirit Warden Azura Statue
        itemPrice = 75000,
        achievement = 155,
      },
      [119866] = { -- Replica Dreamshard
        itemPrice = 2000,
        achievement = 954,
      },
      [119863] = { -- Knights of the Flame Banner
        itemPrice = 10000,
        achievement = 154,
      },
    },
  },

  [loc.AURIDON] = {
    [npc.AF] = {
      [119823] = { -- Tanzelwil Culanda Stone
        itemPrice = 5000,
        achievement = 360,
      },
      [119824] = { -- Veiled Crystal
        itemPrice = 5000,
        achievement = 361,
      },
      [119825] = { -- Mehrunes Dagon Brazier
        itemPrice = 10000,
        achievement = 362,
      },
      [119826] = { -- High Elf Throne
        itemPrice = 25000,
        achievement = 943,
      },
      [119827] = { -- Ancient High Elf Statue
        itemPrice = 35000,
        achievement = 604,
      },
    },
  },

  [loc.GREENSHADE] = {
    [npc.AF] = {
      [119839] = { -- Fires of the Wilderking
        itemPrice = 4000,
        achievement = 510,
      },
      [119841] = { -- Hectahame Arboretum Relic
        itemPrice = 10000,
        achievement = 512,
      },
      [120991] = { -- Rise of the Silvenar
        itemPrice = 5000,
        achievement = 945,
      },
      [119840] = { -- Sea Elf Banner
        itemPrice = 10000,
        achievement = 511,
      },
      [119842] = { -- Wood Elf Path Marker
        itemPrice = 7500,
        achievement = 610,
      },
    },
  },

  [loc.KHENARTHI] = {
    [npc.AF] = {
      [119986] = { -- Maormer Totem
        itemPrice = 10000,
      },
    },
  },

  [loc.MALABAL] = {
    [npc.AF] = {
      [119847] = { -- Handfast
        itemPrice = 25000,
        achievement = 611,
      },
      [119846] = { -- Handfast Pedestal
        itemPrice = 5000,
        achievement = 946,
      },
      [119845] = { -- Wood Elf Union Trellis
        itemPrice = 15000,
        achievement = 285,
      },
      [119843] = { -- Wood Orc Dream Catcher
        itemPrice = 4000,
        achievement = 283,
      },
      [119844] = { -- Wood Orc Malacath Banner
        itemPrice = 10000,
        achievement = 284,
      },
    },
  },

  [loc.GRAHTWOOD] = {
    [npc.AF] = {
      [119834] = { -- Aulus's Captive Audience
        itemPrice = 10000,
        achievement = 605,
      },
      [119836] = { -- Guardian Mane
        itemPrice = 10000,
        achievement = 607,
      },
      [119837] = { -- Orrery Control Pillar Replica
        itemPrice = 10000,
        achievement = 944,
      },
      [119835] = { -- Ukaezai's Ward
        itemPrice = 10000,
        achievement = 606,
      },
      [119838] = { -- Valenwood Brazier
        itemPrice = 4000,
        achievement = 608,
      },
    },
  },

  [loc.REAPER] = {
    [npc.AF] = {
      [119848] = { -- Colovian Projection Crystal
        itemPrice = 5000,
        achievement = 536,
      },
      [119853] = { -- Full Moons Tile
        itemPrice = 5000,
        achievement = 602,
      },
      [119850] = { -- Khajiiti Shrine Guardian Statue
        itemPrice = 20000,
        achievement = 538,
      },
      [119849] = { -- Moonmont Lunar Altar
        itemPrice = 15000,
        achievement = 537,
      },
      [119854] = { -- New Moons Tile
        itemPrice = 5000,
        achievement = 602,
      },
      [119852] = { -- Waning Moons Tile
        itemPrice = 5000,
        achievement = 602,
      },
      [119851] = { -- Waxing Moons Wall Tile
        itemPrice = 5000,
        achievement = 602,
      },
    },
  },

  [loc.CRAGLORN] = {
    [npc.AF] = {
      [119933] = { -- Craglorn Brazier
        itemPrice = 5000,
        achievement = 1663,
      },
      [119934] = { -- Craglorn Sconce
        itemPrice = 5000,
        achievement = 1664,
      },
      [119931] = { -- Craglorn Tapestry
        itemPrice = 35000,
        achievement = 936,
      },
      [119925] = { -- Nirncrux Bowl
        itemPrice = 4000,
        achievement = 1665,
      },
      [119935] = { -- Observatory Banner
        itemPrice = 25000,
        achievement = 909,
      },
      [119923] = { -- Serpent Stone
        itemPrice = 5000,
        achievement = 992,
      },
      [119929] = { -- Snake Prayer Tile
        itemPrice = 5000,
        achievement = 909,
      },
      [119930] = { -- Totem of the Serpent
        itemPrice = 10000,
        achievement = 1143,
      },
    },
  },

  [loc.COLDH] = {
    [npc.AF] = {
      [119828] = { -- Ayleid Throne
        itemPrice = 50000,
        achievement = 612,
      },
      [119830] = { -- Coldharbour Chandelier
        itemPrice = 25000,
        achievement = 614,
      },
      [119831] = { -- Cowering Statue
        itemPrice = 10000,
        achievement = 957,
      },
      [119832] = { -- Light of Meridia
        itemPrice = 10000,
        achievement = 524,
      },
      [119833] = { -- Molag Bal Banner
        itemPrice = 20000,
        achievement = 616,
      },
      [119829] = { -- Shackle Control Stone
        itemPrice = 25000,
        achievement = 613,
      },
    },
  },

  [loc.GOLDCOAST] = {
    [npc.AF] = {
      [119947] = { -- Banner of the Kvatch Guard
        itemPrice = 15000,
        achievement = 1433,
      },
      [119697] = { -- Blade of Woe, Replica
        itemPrice = 25000,
        achievement = 1435,
      },
      [119941] = { -- Brotherhood Poison Vial
        itemPrice = 2500,
        achievement = 1440,
      },
      [119945] = { -- Dark Brotherhood Banner
        itemPrice = 10000,
        achievement = 1442,
      },
      [119953] = { -- Dark Ledger
        itemPrice = 50000,
        achievement = 1453,
      },
      [119937] = { -- Gold Coast Estate Keg
        itemPrice = 500000,
        achievement = 1436,
      },
      [120950] = { -- Hanging Hourglass
        itemPrice = 15000,
        achievement = 1443,
      },
      [119939] = { -- Hourglass Rug
        itemPrice = 10000,
        achievement = 1438,
      },
      [119951] = { -- Litany of Blood
        itemPrice = 25000,
        achievement = 1437,
      },
      [119944] = { -- Order of the Hour banner
        itemPrice = 5000,
        achievement = 1441,
      },
      [119950] = { -- Preserved Sweetrolls
        itemPrice = 500,
        achievement = 1458,
      },
      [119940] = { -- Sanctuary Sconce
        itemPrice = 10000,
        achievement = 1439,
      },
      [119948] = { -- Statue of the Mother
        itemPrice = 100000,
        achievement = 1444,
      },
    },
  },

  [loc.HEWSBANE] = {
    [npc.AF] = {
      [119965] = { -- Abah's Landing Banner
        itemPrice = 10000,
        achievement = 1366,
      },
      [119961] = { -- An Adoring Fan
        itemPrice = 2500,
        achievement = 1363,
      },
      [119969] = { -- Banner of Taneth
        itemPrice = 10000,
        achievement = 1378,
      },
      [119968] = { -- Distracting Harpy Egg
        itemPrice = 1500,
        achievement = 1377,
      },
      [120989] = { -- Hanging Wedding Lantern
        itemPrice = 3000,
        achievement = 1362,
      },
      [119974] = { -- Hiding Place
        itemPrice = 1000,
        achievement = 1360,
      },
      [119960] = { -- Jar of Green Dye
        itemPrice = 500,
        achievement = 1361,
      },
      [120990] = { -- Large Covered Well
        itemPrice = 15000,
        achievement = 1375,
      },
      [119966] = { -- Iron Wheel Banner
        itemPrice = 15000,
        achievement = 1370,
      },
      [120952] = { -- Opulent Dowry Chest
        itemPrice = 50000,
        achievement = 1363,
      },
      [119955] = { -- Pale Garden Flowers
        itemPrice = 500,
        achievement = 1370,
      },
      [119954] = { -- Reliquary Skull
        itemPrice = 25000,
        achievement = 1371,
      },
      [119971] = { -- Statue of Shadows
        itemPrice = 25000,
        achievement = 1401,
      },
      [119967] = { -- Vibrant Garden Flowers
        itemPrice = 500,
        achievement = getQuestString(4641), -- That Which Was Lost
      },
      [119963] = { -- Yokudan Puzzle Column
        itemPrice = 5000,
        achievement = 1361,
      },
    },
  },

  [loc.WROTHGAR] = {
    [npc.AF] = {
      [119981] = { -- Throne of the Orc King
        itemPrice = 50000,
        achievement = 1260,
      },
      [119980] = { -- Orcish Totem
        itemPrice = 10000,
        achievement = 1328,
      },
      [119979] = { -- Fur Throne
        itemPrice = 25000,
        achievement = 1245,
      },
      [119978] = { -- Orcish Battle Totem
        itemPrice = 7500,
        achievement = 1244,
      },
      [119976] = { -- Orc Adventuring Backpack
        itemPrice = 500,
        achievement = 1242,
      },
      [119977] = { -- Orcish War Totem
        itemPrice = 5000,
        achievement = 1243,
      },
      [119975] = { -- Orsinium Cart
        itemPrice = 10000,
        achievement = 1241,
      },
    },
  },

  [loc.ANY_CITY] = {
    [npc.ENCHANTERS] = {
      [120051] = { -- Enchanting Gem
        itemPrice = 5000,
        achievement = 1317,
      },
      [120050] = { -- Enchanter's Sign
        itemPrice = 5000,
        achievement = 1034,
      },
    },

    [npc.ALCHEMISTS] = {
      [120058] = { -- Harvester's Herbs
        itemPrice = 1000,
        achievement = 68,
      },
      [120045] = { -- Poison Satchel
        itemPrice = 5000,
        achievement = 1464,
      },
      [120044] = { -- Alchemy sign
        itemPrice = 10000,
        achievement = 1031,
      },
    },

    [npc.COOKS] = {
      [120053] = { -- Chef's Cleaver
        itemPrice = 2500,
        achievement = 1028,
      },
      [120052] = { -- Provisioner's Sign
        itemPrice = 5000,
        achievement = 1035,
      },
    },

    [npc.CLOTHIERS] = {
      [120061] = { -- Harvester's Garden Shrub
        itemPrice = 10000,
        achievement = 68,
      },
      [120060] = { -- Harvester's Critter Trap
        itemPrice = 5000,
        achievement = 68,
      },
      [120048] = { -- Clothier's sign
        itemPrice = 5000,
        achievement = 1033,
      },
    },

    [npc.CARPENTERS] = {
      [120057] = { -- Harvester's Woodpile
        itemPrice = 1000,
        achievement = 68,
      },
      [120054] = { -- Woodworker's Sign
        itemPrice = 5000,
        achievement = 1036,
      },
    },

    [npc.BLACKSMITHS] = {
      [120062] = { -- Smith's Bellow
        itemPrice = 10000,
        achievement = 1022,
      },
      [120059] = { -- Harvester's Ore
        itemPrice = 1000,
        achievement = 68,
      },
      [120046] = { -- Blacksmith's Sign
        itemPrice = 5000,
        achievement = 1032,
      },
    },

    [npc.THIEVES_MERCH] = {
      [120993] = { -- Scales of Felonious Recompense
        itemPrice = 5000,
        achievement = 1196, -- Felonious Recompense
      },
      [120957] = { -- Faded Fence Banner
        itemPrice = 10000,
        achievement = strRank(skillLine.LEGERDEMAIN, 20),
      },
      [120033] = { -- Decorative Safebox
        itemPrice = 5000,
        achievement = 1200, -- Safebox Cracker
      },
      [120032] = { -- Decorative Thieves Trove
        itemPrice = 5000,
        achievement = 1397, -- Leave No Stash Behind
      },
      [120031] = { -- Replica Key, Blank
        itemPrice = 1000,
        achievement = 1208, -- Master Burglar
      },
      [120030] = { -- Pocket Change
        itemPrice = 500,
        achievement = 1191,
      },
      [120029] = { -- Noble Pocket Lint
        itemPrice = 1000,
        achievement = 1192, -- Sneak Thief Extraordinaire
      },
      [120028] = { -- Death Marker
        itemPrice = 5000,
        achievement = 1225, -- Serial Killer
      },
      [120027] = { -- Mass Tombstone
        itemPrice = 10000,
        achievement = 1226, -- Mass Murderer
      },
      [120026] = { -- Mountain of Loot
        itemPrice = 10000,
        achievement = 1202, -- Black Market Mogul
      },
      [120025] = { -- Pile of Coins
        itemPrice = 2500,
        achievement = 1196, -- Felonious Recompense
      },
      [120023] = { -- Outlaw Banner
        itemPrice = 5000,
        achievement = strRank(skillLine.LEGERDEMAIN, 20),
      },
    },
  },

  [GetString(SI_FURC_GUILD_MAGES)] = {
    [npc.MAGES_MYSTIC] = {
      [120011] = { -- Mages' Guild Banner
        itemPrice = 10000,
        achievement = 702,
      },
      [120003] = { -- Cheese Cutter
        itemPrice = 5000,
        achievement = 1686,
      },
    },
  },

  [GetString(SI_FURC_GUILD_FIGHTERS)] = {
    [npc.FIGHTERS_STEWARD] = {
      [120948] = { -- Dark Anchor Pinion
        itemPrice = 100000,
        achievement = 318,
      },
      [120019] = { -- Fighters' Guild Banner
        itemPrice = 10000,
        achievement = 703,
      },
      [120000] = { -- Broken Chain
        itemPrice = 50000,
        achievement = 587,
      },
      [119999] = { -- Daedric Chest
        itemPrice = 10000,
        achievement = 1683,
      },
    },
  },

  [loc.UNDAUNTED] = {
    [npc.UNDAUNTED_QM] = {
      [120036] = { -- Undaunted Banner
        itemPrice = 15000,
        achievement = 1013,
      },
      [120035] = { -- Undaunted Chest
        itemPrice = 5000,
        achievement = 1680,
      },
      [120034] = { -- Undaunted Mug
        itemPrice = 1000,
        achievement = 704,
      },
    },
  },
}

function FurC.InitAchievementVendorList()
  FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_GUILD_MAGES)] = bookList
end
