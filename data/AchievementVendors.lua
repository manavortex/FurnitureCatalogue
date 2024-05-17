FurC.AchievementVendors = FurC.AchievementVendors or {}
FurC.Books = FurC.Books or {}

local merge = FurC.MergeTable
local ver = FurC.Constants.Versioning

-- /script for i = 6000, 6300 do if string.match(string.lower(GetQuestName(i)), ("verloren")) then d(tostring(i) .. ": " .. GetQuestName(i)) end end

local function getQuestString(questIdOrName)
  local questName = questIdOrName
  if type(questIdOrName) == "number" then
    questName = GetQuestName(questIdOrName)
  end
  return zo_strformat("<<1>>: <<2>>", GetString(SI_FURC_ITEMSRC_QUEST), questName)
end

local b2 = {
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

local holidayVendor = {
  [134433] = { --Stablemaster's Sign, Small
    itemPrice = 10000,
    achievement = 1542, -- Plunder Skull Fanatic
  },
  [120994] = { -- tree, Jester's Large
    itemPrice = 15000,
    achievement = 1723,
  },
  [118529] = { -- tree, Jester's Small
    itemPrice = 5000,
    achievement = 1723,
  },
  [126720] = { -- Banner of Mayhem
    itemPrice = 5000,
    achievement = 1883, -- Mayhem Connoisseur
  },
  [126721] = { -- Corpse of Mayhem, Argonian
    itemPrice = 15000,
    achievement = 1888,
  },
  [126722] = { -- Corpse of Mayhem, Khajiit
    itemPrice = 15000,
    achievement = 1888,
  },
  [126723] = { -- Corpse of Mayhem, Orc
    itemPrice = 15000,
    achievement = 1888,
  },
  [126724] = { -- Probably-Not-Punch-Bowl of Mayhem
    itemPrice = 30000,
    achievement = 1892,
  },
  [126719] = { -- Stamdard of Mayhem
    itemPrice = 2500,
    achievement = 1883,
  },
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
}

local capitalVendor = {
  [119987] = { -- Coldharbour Urn
    itemPrice = 5000,
    achievement = 993,
  },
  [145488] = { -- Banner, Jewelry Crafting
    itemPrice = 5000,
    achievement = 2215,
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
}

local furnishingVendor = {
  [120998] = { -- Block,Wood Cutting
    itemPrice = 100,
  },
  [117994] = { -- Rough Block,Stone Slab
    itemPrice = 100,
  },
  [117971] = { -- Rough Clothesline,Post
    itemPrice = 100,
  },
  [117980] = { -- Rough Firewood,Fireplace
    itemPrice = 100,
  },
  [117982] = { -- Rough Firewood,Stack
    itemPrice = 100,
  },
  [117977] = { -- Rough Stool,Round
    itemPrice = 100,
  },
  [117990] = { -- Tea Table,Carved
    itemPrice = 250,
  },
}

local morrowindStones = {
  [120563] = { -- Stone,Jagged Grey
    itemPrice = 100,
  },
  [120570] = { -- Stone,Slanted Grey
    itemPrice = 100,
  },
  [120571] = { -- Pebbles,Stacked Grey
    itemPrice = 100,
  },
  [120564] = { -- Pebbles,Stacked Weathered
    itemPrice = 100,
  },
  [120572] = { -- Rocks,Jagged Set
    itemPrice = 100,
  },
}

local structures = {
  [117984] = { -- Rough Block, Dark Stone
    itemPrice = 100,
  },
  [117983] = { -- Rough Block, Light Stone
    itemPrice = 100,
  },
  [117995] = { -- Rough Block, Stone Brick
    itemPrice = 100,
  },
  [117993] = { -- Rough Block, Stone Chunk
    itemPrice = 100,
  },
  [117992] = { -- Rough Block, Stone Section
    itemPrice = 100,
  },
  [117994] = { -- Rough Block, Stone Slab
    itemPrice = 100,
  },
  [117961] = { -- Rough Block, Woodcutter's
    itemPrice = 100,
  },
  [117986] = { -- Rough Plank, Long
    itemPrice = 100,
  },
  [117987] = { -- Rough Planks, Narrow
    itemPrice = 100,
  },
  [117988] = { -- Rough Planks, Platform
    itemPrice = 100,
  },
  [117989] = { -- Rough Plank, Wide
    itemPrice = 100,
  },
  [117973] = { -- Rough Crate, Dry
    itemPrice = 100,
  },
}

local boxes = {
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

local laundry = {
  [117968] = { -- Rough Clothesline, Full
    itemPrice = 100,
  },
  [117970] = { -- Rough Clothesline, Half
    itemPrice = 100,
  },
  [117969] = { -- Rough Clothesline, Long
    itemPrice = 100,
  },
  [117972] = { -- Rough Clothesline, Short
    itemPrice = 100,
  },
  [117971] = { -- Rough Clothesline, Post
    itemPrice = 100,
  },
  [117966] = { -- Rough Tarp, Oversized
    itemPrice = 100,
  },
  [117967] = { -- Rough Tarp, Standard
    itemPrice = 100,
  },
}

local fishing_trip = {
  [117965] = { -- Rough Campfire, Doused
    itemPrice = 100,
  },
  [117978] = { -- Rough Rod, Fishing
    itemPrice = 100,
  },
  [117979] = { -- Rough Spear, Fishing
    itemPrice = 100,
  },
  [117977] = { -- Rough Stool, Fishing
    itemPrice = 100,
  },
}

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
  [120192] = { -- The LUsty Argonian Maid 1
    itemPrice = 500,
  },
  [120193] = { -- The LUsty Argonian Maid 2
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

local miscVendor = merge(merge(merge(structures, boxes), laundry), fishing_trip)

-- 28 Secrets of the Telvanni
FurC.AchievementVendors[ver.ENDLESS] = {
  [GetString(SI_FURC_TELVANNI_NECROM_FRF)] = {

    [GetString(SI_FURC_TRADERS_MURKHOLG)] = {
      [198463] = { -- Apocrypha Boulder
        itemPrice = 500,
      },
      [198470] = { -- Apocrypha Coral, Teal Tube
        itemPrice = 450,
      },
      [198464] = { -- Apocrypha Plant, Chromatic Succulent
        itemPrice = 2000,
      },
      [198465] = { -- Apocrypha Plant, Feather Fern Cluster
        itemPrice = 150,
      },
      [198466] = { -- Apocrypha Plant, Ink-Grass
        itemPrice = 150,
      },
      [198467] = { -- Apocrypha Tree, Blue Spore
        itemPrice = 24000,
      },
      [198469] = { -- Apocrypha Tree, Branched Green Spore
        itemPrice = 4000,
      },
      [198468] = { -- Apocrypha Tree, Teal Spiral
        itemPrice = 7000,
      },
      [198476] = { -- Bridge, Reclaimed Wood
        itemPrice = 1000,
      },
      [198471] = { -- Mushroom, Russet Chanterelle Pair
        itemPrice = 400,
      },
      [198473] = { -- Mushroom, Tall Green Morel Pair
        itemPrice = 3000,
      },
      [198472] = { -- Mushrooms, Gilled Dusk Cluster
        itemPrice = 500,
      },
      [198477] = { -- Platform, Reclaimed Wood Square
        itemPrice = 300,
      },
      [198478] = { -- Platform, Reclaimed Wood Triangle
        itemPrice = 300,
      },
      [198475] = { -- Post, Reclaimed Wood
        itemPrice = 50,
      },
      [198474] = { -- Stairway, Reclaimed Wood
        itemPrice = 300,
      },
    },
  },
  [GetString(FURC_AV_ENDLESS)] = {
    -- These items are purchased with Archival Fortunes, not gold.
    [GetString(SI_FURC_TRADERS_TEZURS)] = {
      [203155] = { --Apocrypha Drying Rack, Paper
        itemPrice = 1000,
        achievement = 3765, -- A Little Help Never Hurt
      },
      [203153] = { --Apocrypha Pedestal
        itemPrice = 5500,
        achievement = 3799, -- Battle Ready (Armed Onslaught 5/25)
      },
      [203158] = { --Apocrypha Plant, Languid Tentacles
        itemPrice = 20000,
        achievement = 3798, -- Archive's Most Adored
      },
      [203152] = { --Apocrypha Window, Eye
        itemPrice = 6800,
        achievement = 3763, -- probably "Fabled Foil" after rename of "Dynamic Destroyer"
      },
      [203157] = { --Apocryphal Obelisk
        itemPrice = 7500,
        achievement = 3769, -- First Splurge!
      },
      [203154] = { --Choral Altar
        itemPrice = 7500,
        achievement = 3805, -- Studying Up
      },
      [203159] = { --Daedric Arch, Glass
        itemPrice = 6500,
        achievement = 3760, -- Heavy Hitter
      },
      [203160] = { --Endless Archive Access, Replica
        itemPrice = 6000,
        achievement = 3802, -- A Sturdy Shield
      },
      [203156] = { --Endless Archive Index, Replica
        itemPrice = 25000,
        achievement = 3772, -- Running the Gauntlet
      },
    },
  },
}

-- 26 Necrom
FurC.AchievementVendors[ver.NECROM] = {
  [GetString(SI_FURC_TELVANNI_NECROM_FRF)] = {

    [GetString(SI_FURC_TRADERS_MURKHOLG)] = {
      [197642] = { -- Apocrypha Plant, Anemone Cluster
        itemPrice = 1200,
      },
      [197641] = { -- Apocrypha Plant, Suckerleaf
        itemPrice = 2000,
      },
      [197640] = { -- Apocrypha Tree, Fossilized
        itemPrice = 500,
      },
      [197639] = { -- Apocrypha Tree, Spore
        itemPrice = 20000,
      },
      [197643] = { -- Boulder, Apocrypha Fossil
        itemPrice = 5000,
      },
      [197634] = { -- Mushroom, Dual Mauve Dusk
        itemPrice = 500,
      },
      [197635] = { -- Mushroom, Gilled Mauve Dusk
        itemPrice = 4000,
      },
      [197638] = { -- Mushroom, Tall Russet Chanterelle
        itemPrice = 500,
      },
      [197636] = { -- Plants, Guar Cabbage Cluster
        itemPrice = 2000,
      },
      [197637] = { -- Plants, Lava Pitcher Patch
        itemPrice = 1500,
      },
      [197633] = { -- Tree, Large Gnarled Laurel
        itemPrice = 2500,
      },
    },

    [GetString(SI_FURC_TRADERS_VASEI)] = {
      [197717] = { --Apocrypha Altar, Lighted
        itemPrice = 25000,
        achievement = 3642, -- Apocryphal Investigator
      },
      [197719] = { --Apocrypha Courtyard Pool
        itemPrice = 18000,
        achievement = 3646, -- Secret Keeper
      },
      [197722] = { --Apocrypha Portal Seal, Replica
        itemPrice = 17000,
        achievement = 3635, -- Defender of Necrom
      },
      [197723] = { --Apocrypha Stalk, Scryeball
        itemPrice = 10000,
        achievement = 3636, -- Necrom Master Angler
      },
      [197716] = { --Crystalline Mind Barrier, Replica
        itemPrice = 25000,
        achievement = 3558, -- Sanity's Edge Vanquisher
      },
      [197726] = { --Dormant Tyranite Calx
        itemPrice = 20000,
        achievement = 3689, -- Sharp's Companion
      },
      [197720] = { --Hermaeus Mora Banner
        itemPrice = 12000,
        achievement = 3676, -- Pulled from the Depths
      },
      [197718] = { --Necrom Archway
        itemPrice = 15000,
        achievement = 3679, -- Necrom Master Explorer
      },
      [197715] = { --Necrom Stele, Ceremonial
        itemPrice = 80000,
        achievement = 3674, -- Hero of Necrom
      },
      [197725] = { --Replica Fateweaver Key
        itemPrice = 20000,
        achievement = 3692, -- Azandar's Companion
      },
      [197724] = { --Tales of Tribute Kit, Travel
        itemPrice = 11000,
        achievement = 3702, -- Play the Paramount
      },
      [197721] = { --The Lord of Fate and Knowledge Frieze
        itemPrice = 15000,
        achievement = 3640, -- Ghost Catcher
      },
    },
  },
}

-- 25 Scribes of Fate
FurC.AchievementVendors[ver.SCRIBE] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [193815] = { --Craglorn Podium, Filled
        itemPrice = 4500,
        achievement = 3529, -- Scrivener's Hall Vanquisher
      },
      [193814] = { --Dark Elf Archway, Stone
        itemPrice = 15000,
        achievement = 3468, -- Bal Sunnar Vanquisher
      },
    },
  },
}

-- 24 Firesong
FurC.AchievementVendors[ver.DRUID] = {
  [GetString(SI_FURC_TRADERS_VASEITYR_TOHF)] = {
    [GetString(SI_FURC_TRADERS_ORMAX)] = {
      [192400] = { -- Druidic Planter, Sunflowers
        itemPrice = 4500,
      },
      [192399] = { -- Flowers, Galen Sea Daffodil
        itemPrice = 300,
      },
      [192396] = { -- Flowers, Sunflower Cluster
        itemPrice = 400,
      },
      [192395] = { -- Flowers, Sunflower Patch
        itemPrice = 4000,
      },
      [192398] = { -- Plant, Galen Agave
        itemPrice = 125,
      },
      [192394] = { -- Sapling, Galen Beech
        itemPrice = 200,
      },
      [192393] = { -- Tree, Large Galen Beech
        itemPrice = 3500,
      },
      [192397] = { -- Tree,  Large Galen Pine
        itemPrice = 425,
      },
    },

    [GetString(SI_FURC_TRADERS_IDRENIE)] = {
      [192426] = { --Ascendant Knight Banner
        itemPrice = 12000,
        achievement = 3508, -- Bane of the Dreadsails
      },
      [192416] = { --Druid Ritual Stone
        itemPrice = 20000,
        achievement = 3491, -- Galen Master Explorer
      },
      [192415] = { --Druidic Statue, Left Hand
        itemPrice = 2000,
        achievement = 3556, -- Buried Bequest
      },
      [192411] = { --Druidic Statue, Right Hand
        itemPrice = 2000,
        achievement = 3556, -- Buried Bequest
      },
      [192419] = { --Druidic Throne, Floral Stone
        itemPrice = 25000,
        achievement = 3553, -- Broken Braigh
      },
      [192428] = { --Eerie Sconce, Emerald
        itemPrice = 14000,
        achievement = 3511, -- Dreamwalker
      },
      [192564] = { --Firesong Spring, Basalt
        itemPrice = 40000,
        achievement = 3514, -- Druid Kingslayer
      },
      [192417] = { --Flower Trap, Tamed
        itemPrice = 15000,
        achievement = 3494, -- Defender of Galen
      },
      [192565] = { --Lava Spout
        itemPrice = 75000,
        achievement = 3497, -- Volcanic Vanquisher
      },
      [192424] = { --Systres Trinket Box, Painted
        itemPrice = 2500,
        achievement = 3551, -- Anointed Archdruid
      },
      [192421] = { --The Druid King's Ivy Throne
        itemPrice = 50000,
        achievement = 3501, -- Savior of Galen
      },
    },
  },
}

-- 23 Lost Depths
FurC.AchievementVendors[ver.DEPTHS] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [189504] = { --Deeproot's Undying Bloom
        itemPrice = 25000,
        achievement = 3375, -- Earthen Root Enclave Vanquisher
      },
      [189505] = { --Reinforced Dwarfglass Window, Massive
        itemPrice = 40000,
        achievement = 3394, -- Graven Deep Vanquisher
      },
    },
  },
}

-- 22 High Isle
FurC.AchievementVendors[ver.BRETON] = {
  [GetString(FURC_AV_GONFALON_FOFF)] = {

    [GetString(SI_FURC_TRADERS_MIRUZA)] = {
      [187780] = { -- Boulder, Large Mossy Limestone
        itemPrice = 200,
      },
      [187779] = { -- Boulder, Small Limestone
        itemPrice = 100,
      },
      [187814] = { -- Flowers, Butterweed
        itemPrice = 1000,
      },
      [187783] = { -- Flowers, Daylily Cluster
        itemPrice = 3000,
      },
      [187784] = { -- Shrub Cluster, Gorse
        itemPrice = 2000,
      },
      [187856] = { -- Tree, Conical Cypress
        itemPrice = 2500,
      },
      [187782] = { -- Tree, Forked Cypress
        itemPrice = 700,
      },
      [187781] = { -- Tree, Tall Conical Cypress
        itemPrice = 3000,
      },
    },

    [GetString(SI_FURC_TRADERS_JERAN)] = {
      [187867] = { --Dreadsail Door, Grand
        itemPrice = 35000,
        achievement = 3242, -- Dreadsail Reef Vanquisher
      },
      [187866] = { --Gonfalon Bay Banner
        itemPrice = 12000,
        achievement = 3304, -- The Plot Thickens
      },
      [187809] = { --High Isle Door, Ornate Crypt
        itemPrice = 10000,
        achievement = 3271, -- Savior of High Isle
      },
      [187810] = { --High Isle Mausoleum, Ancient Marble
        itemPrice = 20000,
        achievement = 3306, -- Ascendant Unmasked
      },
      [187815] = { --High Isle Oar, Gondola
        itemPrice = 2000,
        achievement = 3269, -- High Isle Master Angler
      },
      [187798] = { --High Isle Sundial
        itemPrice = 3000,
        achievement = 3272, -- High Isle Master Explorer
      },
      [187812] = { --Replica Bloodmage's Crystal Heart
        itemPrice = 70000,
        achievement = 3284, -- Crimson Coin Conqueror
      },
      [187813] = { --Replica Invitation Medallion
        itemPrice = 15000,
        achievement = 3300, -- Champion of High Isle
      },
      [187811] = { --Replica Maormer Lightning-Rod
        itemPrice = 15000,
        achievement = 3244, -- Dreadsail Reef Conqueror
      },
      [187803] = { --Tales of Tribute Banner
        itemPrice = 4000,
        achievement = 3319, -- The Roister's Roost
      },
    },
  },
}

-- 21 Ascending Tides
FurC.AchievementVendors[ver.TIDES] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [184204] = { --Eerie Lantern, Hanging
        itemPrice = 10000,
        achievement = 3114, -- Shipwright's Regret Vanquisher
      },
      [184203] = { --Gryphon Nest
        itemPrice = 2000,
        achievement = 3104, -- Coral Aerie Vanquisher
      },
    },
  },
}

-- 20 Deadlands
FurC.AchievementVendors[ver.DEADL] = {
  [GetString(FURC_AV_FARGRAVE_FF)] = {
    [GetString(SI_FURC_TRADERS_NIF)] = {
      [181598] = { -- Bush, Low Redleaf Cluster
        itemPrice = 300,
      },
      [181597] = { -- Bush, Sharp Underbrush
        itemPrice = 300,
      },
      [134942] = { -- Bushes, Withered Cluster
        itemPrice = 100,
      },
      [182213] = { -- Fargrave Canopy
        itemPrice = 250,
      },
      [182217] = { -- Fargrave Clutter, Papers
        itemPrice = 100,
      },
      [182220] = { -- Fargrave Flag, Long
        itemPrice = 100,
      },
      [182218] = { -- Fargrave Flag, Regular
        itemPrice = 85,
      },
      [182219] = { -- Fargrave Flag, Short
        itemPrice = 75,
      },
      [182214] = { -- Fargrave Flags, String
        itemPrice = 300,
      },
      [182215] = { -- Fargrave Pennants, Long String
        itemPrice = 250,
      },
      [182216] = { -- Fargrave Pennants, String
        itemPrice = 100,
      },
      [181593] = { -- Log, Charred Oak
        itemPrice = 250,
      },
      [125616] = { -- Pebble, Volcanic Chunk
        itemPrice = 100,
      },
      [181596] = { -- Plant Cluster, Maroon Aloe
        itemPrice = 300,
      },
      [181595] = { -- Plant, Harrada Root
        itemPrice = 500,
      },
      [181594] = { -- Rock, Volcanic Boulder
        itemPrice = 100,
      },
      [181587] = { -- Tree, Charred Oak
        itemPrice = 250,
      },
      [181592] = { -- Tree, Deadlands Pine
        itemPrice = 500,
      },
      [181588] = { -- Tree, Old Charred Oak
        itemPrice = 400,
      },
      [181591] = { -- Tree, Short Charred Pine
        itemPrice = 100,
      },
      [181590] = { -- Tree, Tall Charred Pine
        itemPrice = 250,
      },
      [181589] = { -- Tree, Young Charred Oak
        itemPrice = 100,
      },
    },

    [GetString(SI_FURC_TRADERS_ULZ)] = {
      [182306] = { --Daedric Altar, Mehrunes Dagon
        itemPrice = 4500,
        achievement = 3145, -- Hero of Fargrave
      },
      [182310] = { -- Deadlands Buttress
        itemPrice = 2500,
      },
      [182309] = { -- Deadlands Buttress, Large
        itemPrice = 4000,
      },
      [182312] = { --Deadlands Displacer, Inactive
        itemPrice = 4000,
        achievement = 3192, -- Deadlands Portal Punisher
      },
      [182307] = { --Deadlands Lightning Rod, Etched
        itemPrice = 60000,
        achievement = 3217, -- Eternal Optimist
      },
      [182311] = { --Deadlands Platform, Octagonal
        itemPrice = 4000,
        achievement = 3204, -- The Grasp of the Stricture
      },
      [182308] = { --Deadlands Wind Gate Pinion
        itemPrice = 14000,
        achievement = 3208, -- Deadlands Grand Adventurer
      },
      [182305] = { --Deadlands Window, Stormglass
        itemPrice = 40000,
        achievement = 3214, -- Hopeful Rescuer
      },
      [182313] = { --Portal Key Replica
        itemPrice = 20000,
        achievement = 3209, -- Stranger in Town
      },
      [182315] = { --Sulfur Pool
        itemPrice = 20000,
        achievement = 3144, -- the Deadlands Master Angler
      },
      [182304] = { --Tree, Charred Dagonic
        itemPrice = 15000,
        achievement = 3211, -- Deadlands Jailbreaker
      },
    },
  },
}

-- 19 Blackwood
FurC.AchievementVendors[ver.BLACKW] = {
  [GetString(SI_FURC_LOC_BLACKWOOD_LEYAWIIN_DBF)] = {
    [GetString(SI_FURC_TRADERS_MIRASO)] = {
      [175707] = { --Banner of Leyawiin
        itemPrice = 12000,
        achievement = 3056, -- Blackwood Grand Adventurer
      },
      [175703] = { -- Banner, Tattered Mehrunes Dagon
        itemPrice = 12000,
      },
      [175700] = { -- Deadlands Chandelier, Caged
        itemPrice = 10000,
      },
      [175705] = { --Deadlands Pillar, Tall Inscribed
        itemPrice = 20000,
        achievement = 3050, -- Ambition Acquirer
      },
      [175709] = { --Deadlands Podium of Ruination
        itemPrice = 15000,
        achievement = 3053, -- Disaster Averter
      },
      [175708] = { --Deadlands Tormentor, Chained
        itemPrice = 20000,
        achievement = 3051, -- Party Crasher
      },
      [175702] = { -- Entwined Snakes, Crystal Holder
        itemPrice = 12000,
      },
      [175704] = { --Inert Oblivion Gate
        itemPrice = 50000,
        achievement = 3007, -- Rockgrove Vanquisher
      },
      [175706] = { --Seal of the Ambitions
        itemPrice = 25000,
        achievement = 3055, -- Champion of Blackwood
      },
      [175701] = { -- Xi-Tsei Stone Idol
        itemPrice = 4000,
      },
    },

    [GetString(SI_FURC_TRADERS_BARNABE)] = {
      [165809] = { -- Firelogs, White Pine
        itemPrice = 250,
      },
      [175725] = { -- Leyawiin Carpet, Small Worn
        itemPrice = 250,
      },
      [175723] = { -- Leyawiin Carpet, Threadbare
        itemPrice = 350,
      },
      [175727] = { -- Leyawiin Palisade, Reinforced
        itemPrice = 2000,
      },
      [175724] = { -- Leyawiin Rug, Worn
        itemPrice = 350,
      },
      [175722] = { -- Leyawiin Socks, Pair
        itemPrice = 75,
      },
      [175721] = { -- Leyawiin Trousers, Strewn
        itemPrice = 100,
      },
      [175720] = { -- Leyawiin Wheel, Splintered Axle
        itemPrice = 250,
      },
      [175774] = { -- Leyawiin Windowbox, Irises
        itemPrice = 4000,
      },
      [175773] = { -- Leyawiin Windowbox, Yellow Daisies
        itemPrice = 4500,
      },
      [175771] = { -- Tree, Bent Blackwood Elm
        itemPrice = 300,
      },
      [175770] = { -- Tree, Branching Blackwood Pine
        itemPrice = 1000,
      },
      [175772] = { -- Tree, Forked Blackwood Elm
        itemPrice = 350,
      },
    },
  },
}

-- 18 Flames of Ambition
FurC.AchievementVendors[ver.FLAMES] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [171775] = { --Fountain of the Fiery Drake
        itemPrice = 50000,
        achievement = 2831, -- Black Drake Villa Vanquisher
      },
      [171776] = { --Basalt Pillar, Glowing
        itemPrice = 12000,
        achievement = 2841, -- the Cauldron Vanquisher
      },
      [181509] = { --Agonymium Stone, Inert
        itemPrice = 15000,
        achievement = 3026, -- The Dread Cellar Vanquisher
      },
      [181510] = { --Silver Rose Banner
        itemPrice = 12000,
        achievement = 3016, -- Red Petal Bastion Vanquisher
      },
    },
  },
}

-- 16 Stonethorn
FurC.AchievementVendors[ver.STONET] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [167310] = { --Castle Thorn Gargoyle
        itemPrice = 25000,
        achievement = 2704, -- Castle Thorn Vanquisher
      },
      [167334] = { --Stone Garden Tank, Rootbound
        itemPrice = 75000,
        achievement = 2694, -- Stone Garden Vanquisher
      },
    },
  },

  [GetString(FURC_AV_DRAGONHOLD)] = {
    [GetString(SI_FURC_TRADERS_MARTINA)] = {
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
  [GetString(SI_FURC_LOC_REACH_MARKARTH_MM)] = {
    [GetString(SI_FURC_TRADERS_AVERIO)] = {
      [171383] = { -- Dwarven Broom, Restored
        itemPrice = 400,
      },
      [171384] = { -- Dwarven Loaf Pan, Rectangular
        itemPrice = 250,
      },
      [171385] = { -- Dwarven Plate, Salvaged Decorative
        itemPrice = 100,
      },
      [171386] = { -- Reachfolk Banner, Markarth
        itemPrice = 2000,
      },
    },

    [GetString(SI_FURC_TRADERS_TIRUDILMO)] = {
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
      [171391] = { --Reach Effigy of Turnabout
        itemPrice = 10000,
        achievement = 2908, -- Vateshran Hollows Conqueror
      },
      [171390] = { --Reachwitch Protective Totem
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
  [GetString(FURC_AV_SOLITUDE_DH)] = {
    [GetString(FURC_SKYRIM_MASELA)] = {
      [165809] = { -- Firelogs, White Pine
        itemPrice = 250,
      },
      [165817] = { -- Log, Fallen Winter Pine
        itemPrice = 250,
      },
      [165810] = { -- Logs, Twice-Split
        itemPrice = 750,
      },
      [165822] = { -- Plant Cluster, Haafingar Underbrush
        itemPrice = 250,
      },
      [165819] = { -- Sapling, White Pine
        itemPrice = 300,
      },
      [165821] = { -- Shrub, Wild Basil
        itemPrice = 250,
      },
      [165811] = { -- Solitude Fence, Stick
        itemPrice = 100,
      },
      [165812] = { -- Solitude Fence, Stick Triple
        itemPrice = 250,
      },
      [165813] = { -- Solitude Wagon Wheel, Heavy
        itemPrice = 250,
      },
      [165824] = { -- Tree, Mountain Mahogany
        itemPrice = 300,
      },
      [165825] = { -- Tree, Twisted Mountain Mahogany
        itemPrice = 1000,
      },
      [165818] = { -- Tree, White Pine
        itemPrice = 900,
      },
      [165815] = { -- Tree, Winter Pine
        itemPrice = 900,
      },
      [165816] = { -- Tree, Young Aspen
        itemPrice = 300,
      },
      [165823] = { -- Tree, Young Mountain Mahogany
        itemPrice = 250,
      },
      [165814] = { -- Tree, Young Winter Pine
        itemPrice = 250,
      },
      [165820] = { -- Fern, Sting-Vine
        itemPrice = 100,
      },
    },

    [GetString(FURC_SKYRIM_NETINDELL)] = {
      [166018] = { --Doll, Heiruna
        itemPrice = 2000,
        achievement = 2645, -- Western Skyrim Cave Delver
      },
      [166020] = { --Greymoor Keep Banner, Hanging
        itemPrice = 10000,
        achievement = 2724, -- Threat-Ender
      },
      [166016] = { --Ice Statue, Cowering Wretch
        itemPrice = 10000,
        achievement = 2641, -- Frozen Coast Explorer
      },
      [166021] = { --Karthwatch Banner, Hanging
        itemPrice = 10000,
        achievement = 2807, -- Swordthane of Karthwatch
      },
      [166024] = { --Kyne's Aegis Banner, Hanging
        itemPrice = 10000,
        achievement = 2732, -- Kyne's Aegis Completed
      },
      [165990] = { --Mammoth Cheese, Pungent
        itemPrice = 25000,
        achievement = 2765, -- Giant Cheese Connoisseur
      },
      [166463] = { --Map of Western Skyrim, Hanging
        itemPrice = 10000,
        achievement = 2647, -- Western Skyrim Master Explorer
      },
      [166022] = { --Morthal Banner, Hanging
        itemPrice = 10000,
        achievement = 2760, -- Shieldthane of Morthal
      },
      [166025] = { --Nord Basket Trap, Fishing
        itemPrice = 4000,
        achievement = 2655, -- Western Skyrim Master Angler
      },
      [166026] = { --Nord Boat, Fishing
        itemPrice = 250000,
        achievement = 2734, -- Kyne's Aegis Conqueror
      },
      [166019] = { --Replica Throne of Windhelm
        itemPrice = 100000,
        achievement = 2712, -- Savior of Western Skyrim
      },
      [166023] = { --Solitude Banner, Hanging
        itemPrice = 10000,
        achievement = 2724, -- Threat-Ender
      },
      [166017] = { --Witch Pike, Quiescent
        itemPrice = 15000,
        achievement = 2716, -- Champion of Solitude
      },
    },
  },
}

-- 14 Harrowstorm
FurC.AchievementVendors[ver.HARROW] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [159452] = { --Gray Reliquary
        itemPrice = 25000,
        achievement = 2549,
      },
      [159453] = { --Icereach Coven Totem, Emblem
        itemPrice = 12000,
        achievement = 2539,
      },
    },
  },
}

-- 13 Dragonhold
FurC.AchievementVendors[ver.DRAGON2] = {
  [GetString(FURC_AV_SENCHAL_MARKET)] = {
    [GetString(SI_FURC_TRADERS_ZADRASKA)] = {
      [156677] = { -- Vines, Verdant Ivy Climber
        itemPrice = 750,
      },
      [156678] = { -- Vines, Verdant Ivy Swath
        itemPrice = 1250,
      },
    },
  },
}

-- 12 Scalebreaker
FurC.AchievementVendors[ver.SCALES] = {
  [GetString(FURC_AV_IC_EVENT)] = {
    [GetString(SI_FURC_TRADERS_IMPRESS)] = {
      [153554] = { -- Imperial Mirror, Standing
        itemPrice = 1,
      },
      [153562] = { itemPrice = 1 }, -- Daedric Brazier, Standing
      [153561] = { itemPrice = 3 }, -- Daedric Chandelier, Ritual
      [153557] = { itemPrice = 1 }, -- Imperial Footlocker, Scrollwork
      [153558] = { itemPrice = 2 }, -- Imperial Wardrobe, Scrollwork
      [153553] = { itemPrice = 1 }, -- Imperial Dresser, Scrollwork
      [153556] = { itemPrice = 1 }, -- Imperial Divider, Folding
      [153555] = { itemPrice = 1 }, -- Imperial Nightstand, Scrollwork
      [153560] = { itemPrice = 2 }, -- Imperial Shrine of the Bay
      [153552] = { itemPrice = 1 }, -- Imperial Tapestry, Akatosh
      [153559] = { itemPrice = 2 }, -- Imperial Bed, Canopy
    },
  },

  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [153750] = { --Hemo Helot, Benign
        itemPrice = 50000,
        achievement = 2415, -- Moongrave Fane Vanquisher
      },
      [153686] = { --Plant Cluster, Azureblight Scaleleaf
        itemPrice = 3000,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
      [153685] = { --Tree, Azureblight Acacia, thanks Des-demona
        itemPrice = 12000,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
      [153687] = { --Vine, Azureblight Strangler, thanks Des-demona
        itemPrice = 4500,
        achievement = 2425, -- Lair of Marselook Vanquisher
      },
    },
  },
}

-- 11 Elsweyr
FurC.AchievementVendors[ver.KITTY] = {
  ["Rimmen"] = {
    [GetString(SI_FURC_TRADERS_LATHAHIM)] = {
      [151790] = { --Akaviri Table, Stone
        itemPrice = 10000,
        achievement = getQuestString(6307), -- Descendant of the Potentate
      },
      [151781] = { --Banner, Anequina
        itemPrice = 10000,
        achievement = 2482,
      },
      [151780] = { --Banner, Rimmen
        itemPrice = 10000,
        achievement = 2485,
      },
      [151801] = { --Barrel, Riverhold
        itemPrice = 1000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151800] = { --Cage, Small Animal
        itemPrice = 4000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151791] = { --Column, Fatal Warning
        itemPrice = 3000,
        achievement = 2476,
      },
      [151802] = { --Crate, Riverhold
        itemPrice = 1000,
        achievement = getQuestString(6311), -- The Riverhold Abduction
      },
      [151625] = { --Door, Akatosh Chancel
        itemPrice = 100000,
        achievement = 2433,
      },
      [151782] = { --Khajiit Burial Mound
        itemPrice = 500,
        achievement = 2440,
      },
      [151787] = { --Khajiit Lion Crest
        itemPrice = 15000,
        achievement = 2486,
      },
      [151788] = { --Khajiit Wagon, Burned
        itemPrice = 500,
        achievement = 2474,
      },
      [151789] = { --Khajiit Wagon, Merchant
        itemPrice = 1000,
        achievement = 2475,
      },
      [151968] = { --Map of Elsweyr, Hanging
        itemPrice = 10000,
        achievement = 2404,
      },
      [151779] = { --Moon Gate
        itemPrice = 100000,
        achievement = 2488,
      },
      [151786] = { --Moon Temple Pad
        itemPrice = 20000,
        achievement = 2487,
      },
      [151799] = { --Projection Stone, Moons
        itemPrice = 20000,
        achievement = 2487,
      },
      [151783] = { --Replica Dragon Horn, Large
        itemPrice = 35000,
        achievement = 2486, -- Assassination Cessation
      },
      [151784] = { --Replica Dragon Horn, Small
        itemPrice = 12000,
        achievement = 2486, -- Assassination Cessation
      },
      [151796] = { --Riverhold Defense Spikes, Piled
        itemPrice = 500,
        achievement = 2484, -- Riverhold Defense
      },
      [151798] = { --Riverhold Defense Spikes, Roof-Mounted
        itemPrice = 1000,
        achievement = 2484, -- Riverhold Defense
      },
      [151797] = { --Riverhold Defense Spikes, Tripod
        itemPrice = 1000,
        achievement = 2484, -- Riverhold Defense
      },
      [151778] = { --Statue, Lokkestiiz
        itemPrice = 35000,
        achievement = 2470, -- Stormchaser
      },
      [151777] = { --Statue, Yolnahkriin
        itemPrice = 50000,
        achievement = 2469, -- Stoking the Fire
      },
      [151792] = { --Tojay-Raht Statue, Monk
        itemPrice = 75000,
        achievement = getQuestString(6310), -- The Lunacy of Two Moons
      },
      [151785] = { --Wrathstone, Replica
        itemPrice = 50000,
        achievement = 2446, -- Tharn Collaborator
      },
    },

    [GetString(SI_FURC_TRADERS_YATAVA)] = {
      [151821] = { -- Desert Grass, Patch
        itemPrice = 150,
      },
      [151820] = { -- Desert Grass, Tall
        itemPrice = 100,
      },
      [151804] = { -- Elsweyr Pillar, Rough Wooden
        itemPrice = 100,
      },
      [153684] = { -- Plant Cluster, Keet Fern
        itemPrice = 100,
      },
      [153681] = { -- Plant Cluster, Palmetto
        itemPrice = 150,
      },
      [153680] = { -- Plant Cluster, Tenmar Dija
        itemPrice = 300,
      },
      [153683] = { -- Plant Cluster, Zahmia
        itemPrice = 150,
      },
      [151816] = { -- Plant, Flowering Thorned Succulent
        itemPrice = 100,
      },
      [153682] = { -- Plant, Tropical Bush
        itemPrice = 100,
      },
      [151807] = { -- Rock Field, Ancient Stone
        itemPrice = 100,
      },
      [151806] = { -- Rubble Pile, Ancient Stone
        itemPrice = 100,
      },
      [151813] = { -- Sapling, Desert Acacia
        itemPrice = 350,
      },
      [153679] = { -- Tree, Anequine Acacia Arching
        itemPrice = 400,
      },
      [153688] = { -- Tree, Anequine Acacia Forking
        itemPrice = 300,
      },
      [151808] = { -- Tree, Fan Palm
        itemPrice = 100,
      },
      [153677] = { -- Trees, Shade Palm Cluster
        itemPrice = 400,
      },
      [153678] = { -- Trees, Towering Palm Cluster
        itemPrice = 400,
      },

      [151805] = { -- Elsweyr Rack, Poles
        itemPrice = 350,
      },
      [151803] = { -- Elsweyr Wagon Wheel, Ironshod
        itemPrice = 250,
      },
      [151819] = { -- Flower Patch, Prairie-Fire
        itemPrice = 350,
      },
      [151817] = { -- Flowers, Daedra Thorn
        itemPrice = 250,
      },
      [151815] = { -- Flowers, Desert Sunrise
        itemPrice = 250,
      },
      [151818] = { -- Shrub, Yellow Necklacepod
        itemPrice = 250,
      },
      [151810] = { -- Tree, Branched Succulent
        itemPrice = 400,
      },
      [151814] = { -- Tree, Desert Acacia
        itemPrice = 550,
      },
      [151812] = { -- Tree, Engulfing Termite Mound
        itemPrice = 350,
      },
      [151811] = { -- Tree, Tall Iroko
        itemPrice = 400,
      },
      [151823] = { -- Vines, Dragonfire Ivy Climber
        itemPrice = 300,
      },
      [151809] = { -- Trees, Fan Palm Cluster
        itemPrice = 250,
      },
      [151822] = { -- Vines, Dragonfire Ivy Swath
        itemPrice = 450,
      },
    },
  },
}

-- 10 Wrathstone
FurC.AchievementVendors[ver.WOTL] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [147645] = { --Dwarven Tonal Arc
        itemPrice = 15000,
        achievement = 2260,
      },
      [147638] = { --Replica Cursed Orb of Meridia
        itemPrice = 100000,
        achievement = 2270,
      },
    },
  },
}

-- 9 Wolfhunter
FurC.AchievementVendors[ver.WEREWOLF] = {
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [141857] = { --Ritual Chalice, Hircine
        itemPrice = 5000,
        achievement = 2162,
      },
      [141858] = { --Banner of the Silver Dawn
        itemPrice = 15000,
        achievement = 2152,
      },
    },
  },

  [GetString(SI_FURC_LOC_HEW)] = {
    [GetString(SI_FURC_TRADERS_LTS)] = {
      [119966] = { -- Iron Wheel Banner
        itemPrice = 15000,
      },
      [119971] = { -- Statue of Shadows
        itemPrice = 25000,
      },
    },
  },

  [GetString(SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE)] = {
    [GetString(SI_FURC_TRADERS_UNWOTIL)] = {
      [141824] = {
        itemPrice = 100,
      },
      [141819] = {
        itemPrice = 500,
      },
      [141818] = {
        itemPrice = 100,
      },
      [141817] = {
        itemPrice = 750,
      },
      [141816] = {
        itemPrice = 500,
      },
    },
  },

  [GetString(SI_FURC_LOC_GLENUMBRA_DAGGERFALL_RL)] = {
    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [130305] = { -- Stone, Mossy Swamp
        itemPrice = 100,
      },
      [130306] = { -- Stones, Gray Swampy
        itemPrice = 100,
      },
      [130292] = { -- Stump, Fetid Swamp
        itemPrice = 100,
      },
      [130291] = { -- Stump, Rotten Pine
        itemPrice = 100,
      },
    },
  },

  [GetString(FURC_AV_RAWLKHA_MARKET)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120658] = { -- Tree, Forked Sturdy
        itemPrice = 250,
      },
    },
  },
}

-- 8 Murkmire
FurC.AchievementVendors[ver.SLAVES] = {
  [GetString(SI_FURC_LOC_MURKMIRE)] = {
    [GetString(SI_FURC_TRADERS_HARNWULF)] = {
      [145408] = { --Argon Pedestal, Replica
        itemPrice = 15000,
        achievement = 2339, -- The river of rebirth
      },
      [145406] = { --Banner, Bright-Throat
        itemPrice = 10000,
        achievement = 2353, -- murky marketeer
      },
      [145404] = { --Banner, Dead-Water
        itemPrice = 10000,
        achievement = 2354, -- Cold Blood, Warm Heart
      },
      [145405] = { --Banner, Rootwater
        itemPrice = 10000,
        achievement = 2352, -- Resplendent Rootmender
      },
      [145553] = { --Grave Stake, Small Glyphed
        itemPrice = 5000,
        achievement = 2330, -- Surreptiliously Shadowed
      },
      [145549] = { --Murkmire Totem, Stone Head
        itemPrice = 12000,
        achievement = getQuestString(6280), -- Art of the Nisswo
      },
      [145407] = { -- Remnant of Argon, Replica
        itemPrice = 75000,
        achievement = 2339, -- River of Rebirth
      },
      [145412] = { --Seed Doll, Turtle
        itemPrice = 20000,
        achievement = 2336, -- Sap-Sleeper
      },
      [145576] = { --Timid Vine-Tongue
        itemPrice = 40000,
        achievement = 2357, --  Vine-Tongue Traveler
      },
      [145596] = { --Look upon Their Nothing Eyes
        itemPrice = 15000,
        achievement = 2341, -- Poems of Nothing
      },
    },

    [GetString(SI_FURC_TRADERS_ADOSA)] = {
      [145551] = { -- Murkmire Kiln, Derelict
        itemPrice = 450,
      },
      [145557] = { -- Plant Cluster, Spadeleaf
        itemPrice = 350,
      },
      [145414] = { -- Plant Cluster, Marsh Saplings
        itemPrice = 250,
      },
      [145417] = { -- Plant, Bramblebrush
        itemPrice = 250,
      },
      [145413] = { -- Plant, Marsh Palm
        itemPrice = 350,
      },
      [145419] = { -- Plant, Marshfrond
        itemPrice = 400,
      },
      [145547] = { -- Plant, Moorstalk Hive
        itemPrice = 1250,
      },
      [145416] = { -- Plant, Purple Spadeleaf
        itemPrice = 300,
      },
      [145420] = { -- Plant, Thorny Swamp Lily
        itemPrice = 400,
      },
      [145418] = { -- Plant, Young Marshfrond
        itemPrice = 250,
      },
      [145425] = { -- Rock, Mossy Marsh
        itemPrice = 250,
      },
      [145424] = { -- Rocks, Mossy Marsh Cluster
        itemPrice = 750,
      },
      [145422] = { -- Tree Cluster, Young Sycamore
        itemPrice = 450,
      },
      [145421] = { -- Tree, Marsh Cypress
        itemPrice = 350,
      },
      [145423] = { -- Tree, Mire Mangrove
        itemPrice = 4000,
      },
      [145415] = { -- Tree, Mossy Sycamore
        itemPrice = 2000,
      },
    },
  },
}

-- 7 Summerset
FurC.AchievementVendors[ver.ALTMER] = {
  [GetString(SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE)] = {
    [GetString(SI_FURC_TRADERS_UNWOTIL)] = {
      [139122] = { -- Bush, Summerset Spruce
        itemPrice = 100,
      },
      [139107] = { -- Coral Shelf, Flat
        itemPrice = 100,
      },
      [139108] = { --  Coral Shelf, Large
        itemPrice = 250,
      },
      [139127] = { -- Hedge, Overgrown
        itemPrice = 100,
      },
      [139128] = { -- Hedge, Overgrown long
        itemPrice = 100,
      },
      [139112] = { -- Limestone Border, Boulders
        itemPrice = 100,
      },
      [139113] = { -- Limestone Border, Pebbles
        itemPrice = 100,
      },
      [139111] = { -- Limestone Border, Stones
        itemPrice = 100,
      },
      [139114] = { -- Limestone Retaining Wall, Curved
        itemPrice = 100,
      },
      [139116] = { -- Limestone Retaining Wall, Long
        itemPrice = 100,
      },
      [139115] = { -- Limestone Retaining Wall, Short
        itemPrice = 100,
      },
      [139109] = { -- Limestone Shelf, Curved
        itemPrice = 100,
      },
      [139110] = { -- Limestone Shelf, Large
        itemPrice = 250,
      },
      [139117] = { -- Limestone Stairway, Natural
        itemPrice = 100,
      },
      [139126] = { -- Sapling, Gingko
        itemPrice = 100,
      },
      [139121] = { -- Sapling, Growing Shade
        itemPrice = 100,
      },
      [139132] = { -- Sapling, Sea Grapes
        itemPrice = 100,
      },
      [139124] = { -- Sapling, Summerset Spruce
        itemPrice = 100,
      },
      [139120] = { -- Sapling, Young Shade
        itemPrice = 100,
      },
      [139130] = { -- Saplings, Mangrove
        itemPrice = 100,
      },
      [139125] = { -- Tree, Blooming Gingko
        itemPrice = 2000,
      },
      [139131] = { -- Tree, Solitary Mangrove
        itemPrice = 250,
      },
      [139134] = { -- Tree, Seagrapes
        itemPrice = 100,
      },
      [139136] = { -- Tree, Twin Poplar
        itemPrice = 100,
      },
      [139123] = { -- Tree, Summerset Spruce
        itemPrice = 250,
      },
      [139119] = { -- Tree, Upstretched Shade
        itemPrice = 250,
      },
      [139118] = { -- Tree, Wide-Trunked Shade
        itemPrice = 250,
      },
      [139129] = { -- Tree, Young Mangrove
        itemPrice = 100,
      },
      [139135] = { -- Tree, Young Poplar
        itemPrice = 100,
      },
      [139133] = { -- Tree, Young Sea Grapes
        itemPrice = 100,
      },
    },

    [GetString(SI_FURC_TRADERS_TARMIMN)] = {
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
      [139372] = { -- Mind Trap Kelp, Adult
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
  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [134908] = { -- Blackmarrow Banner
        itemPrice = 15000,
        achievement = 1959, -- Scalecaller Peak Vanquisher
      },
      [134907] = { --Orb of Stone
        itemPrice = 50000,
        achievement = 1975,
      },
    },
  },
}

-- 5 Clockwork City
FurC.Books[ver.CLOCKWORK] = {
  [134548] = { -- The Truth in Sequence, Volume 1
    itemPrice = 20000,
  },
  [134549] = { -- The Truth in Sequence, Volume 2
    itemPrice = 20000,
  },
  [134550] = { -- The Truth in Sequence, Volume 3
    itemPrice = 20000,
  },
  [134551] = { -- The Truth in Sequence, Volume 4
    itemPrice = 20000,
  },
  [134552] = { -- The Truth in Sequence, Volume 5
    itemPrice = 20000,
  },
  [134553] = { -- The Truth in Sequence, Volume 6
    itemPrice = 20000,
  },
  [134554] = { -- The Truth in Sequence, Volume 7
    itemPrice = 20000,
  },
  [134555] = { -- The Truth in Sequence, Volume 8
    itemPrice = 20000,
  },
  [134556] = { -- The Truth in Sequence, Volume 9
    itemPrice = 20000,
  },
  [134557] = { -- The Truth in Sequence, Volume 10
    itemPrice = 20000,
  },
  [134558] = { --The Truth in Sequence: Volume 11,
    itemPrice = 20000,
  },
  [134559] = { --The Truth in Sequence: Volume 12,
    itemPrice = 20000,
  },
}

FurC.AchievementVendors[ver.CLOCKWORK] = {
  [GetString(SI_FURC_LOC_CC_CITADEL_MARKET)] = {
    [GetString(SI_FURC_TRADERS_RAZOUFA_COLL)] = FurC.Books[ver.CLOCKWORK],
    [GetString(SI_FURC_TRADERS_RAZOUFA)] = {
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
    [GetString(SI_FURC_TRADERS_MULVISE)] = {
      [134304] = { -- Boulder, Basalt Slap
        itemPrice = 1000,
      },
      [134292] = { -- Boulder, Metallic Rubble
        itemPrice = 500,
      },
      [134293] = { -- Boulder, Metallic Shard
        itemPrice = 500,
      },
      [134305] = { -- Clockwork Junk Heap, Small
        itemPrice = 1000,
      },
      [134303] = { -- Rock, Basalt Slab
        itemPrice = 500,
      },
      [134296] = { -- Rocks, Sintered Cluster
        itemPrice = 1000,
      },
      [134294] = { -- Rocks, Sintered Column
        itemPrice = 1000,
      },
      [134295] = { -- Rocks, Sintered Pile
        itemPrice = 1000,
      },
      [134297] = { -- Scavenged Grating, Narrow
        itemPrice = 500,
      },
      [134298] = { -- Scavenged Grating, Wide
        itemPrice = 500,
      },
      [134301] = { -- Scavenged Plate, Ornate
        itemPrice = 500,
      },
      [134299] = { -- Scavenged Plate, Plain
        itemPrice = 500,
      },
      [134300] = { -- Scavenged Plate, Wide
        itemPrice = 500,
      },
      [134302] = { -- Scavenged Support, Straight
        itemPrice = 500,
      },
    },
  },

  [GetString(SI_FURC_LOC_CAPITAL)] = {
    [GetString(SI_FURC_TRADERS_HERALDA)] = {
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
FurC.AchievementVendors[ver.REACH] = {
  [GetString(SI_FURC_LOC_COLDH_HOLLOW_CGG)] = {
    [GetString(SI_FURC_TRADERS_KRRZTRRB)] = {
      [130273] = { -- Boulder, Coldharbour Fan
        itemPrice = 5000,
      },
      [130274] = { -- Boulder, Coldharbour Shard
        itemPrice = 5000,
      },
      [130275] = { -- Boulder, Coldharbour Spikes
        itemPrice = 5000,
      },
      [130276] = { -- Boulder, Coldharbour Spikes
        itemPrice = 250,
      },
      [131421] = { -- Sapling, Withered Thicket
        itemPrice = 250,
      },
      [130279] = { -- Tree, Petrified AShen
        itemPrice = 2500,
      },
      [130278] = { -- Tree, Strong Withered
        itemPrice = 5000,
      },
      [130277] = { -- Tree, Towering Withered
        itemPrice = 5000,
      },
    },
  },

  [GetString(SI_FURC_LOC_GLENUMBRA_DAGGERFALL_RL)] = {
    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [120706] = { -- Boulder, Giant Mossy
        itemPrice = 100,
      },
      [130309] = { -- Boulder, Swampy Growth
        itemPrice = 250,
      },
      [132221] = { -- Lily Pads, Swamp Cluster
        itemPrice = 5000,
      },
      [130287] = { -- Log, Fallen Laurel
        itemPrice = 250,
      },
      [130288] = { -- Log, Fallen Pine
        itemPrice = 250,
      },
      [130286] = { -- Log, Rotten Log
        itemPrice = 250,
      },
      [130307] = { -- Rocks, Swampy Slan
        itemPrice = 250,
      },
      [130304] = { -- Saplings, Marsh Cluster
        itemPrice = 250,
      },
      [130303] = { -- Shrug, Swamp Sprig
        itemPrice = 250,
      },
      [130289] = { -- Stump, Mossy Cypress
        itemPrice = 250,
      },
      [130290] = { -- Stump, Rotten Hollow
        itemPrice = 250,
      },
      [130315] = { -- Tree, Ancient Rotten
        itemPrice = 7500,
      },
      [130310] = { -- Tree, Dead Marsh
        itemPrice = 7500,
      },
      [130312] = { -- Tree, Dead Pine
        itemPrice = 2500,
      },
      [130311] = { -- Tree, Dead Swamp
        itemPrice = 5000,
      },
      [130313] = { -- Tree, Gnarled Marsh
        itemPrice = 5000,
      },
      [130314] = { -- Tree, Withering Marsh
        itemPrice = 2500,
      },
    },
  },

  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
      [131428] = { -- Horn of the Reachclans
        itemPrice = 50000,
      },
      [131429] = { -- Vine, Bloodroot Wiggler
        itemPrice = 5000,
      },
      [131432] = { -- Vine, Bloodroot Stem
        itemPrice = 5000,
      },
      [131430] = { -- Vine, Bloodroot Mangler
        itemPrice = 5000,
      },
      [131431] = { -- Vine, Bloodroot Grasper
        itemPrice = 5000,
      },
    },
  },

  [GetString(SI_FURC_LOC_EASTMARCH)] = {
    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [132215] = { -- Boulder, Granite Cap
        itemPrice = 1000,
      },
      [132213] = { -- Boulder, Granite Chunk
        itemPrice = 1000,
      },
      [132214] = { -- Boulder, Granite Slab
        itemPrice = 1000,
      },
      [132217] = { -- Rock, Granite Chunk
        itemPrice = 5000,
      },
      [132209] = { -- Sapling, Foothills Pine
        itemPrice = 250,
      },
      [132212] = { -- Shrub, Mountain Thistle
        itemPrice = 250,
      },
      [132220] = { -- Stones, Granite Cluster
        itemPrice = 250,
      },
      [132219] = { -- Stones, Granite Group
        itemPrice = 250,
      },
      [132218] = { -- Stones, Granite Pair
        itemPrice = 250,
      },
      [132210] = { -- Tree, Ancient Cedar
        itemPrice = 2500,
      },
      [132207] = { -- Tree, Ancient Mountain Pine
        itemPrice = 1000,
      },
      [132208] = { -- Tree, Foothills Pine
        itemPrice = 1000,
      },
      [132205] = { -- Tree, Hardy Cedar
        itemPrice = 250,
      },
      [132206] = { -- Tree, Towering Mountain Pine
        itemPrice = 1000,
      },
      [132211] = { -- Ferns, Mountain Cluster
        itemPrice = 250,
      },
    },
  },

  [GetString(SI_FURC_LOC_AURIDON_SKYWATCH)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120652] = { -- Boulder, Flat Lichen
        itemPrice = 100,
      },
      [120651] = { -- Boulder, Grey Saddle
        itemPrice = 100,
      },
      [120648] = { -- Boulder, Lichen Covered
        itemPrice = 100,
      },

      [120672] = { -- Hedge, Green Short
        itemPrice = 1000,
      },
      [120673] = { -- Hedge, Long Horseshoe
        itemPrice = 2500,
      },
      [120671] = { -- Hedge, Small Horseshoe
        itemPrice = 1250,
      },
      [120674] = { -- Hedge, Tall Green
        itemPrice = 1250,
      },
      [121005] = { -- Hedge, Wall Arc
        itemPrice = 3000,
      },

      [120653] = { -- Rock, Slanted Lichen
        itemPrice = 100,
      },
      [120655] = { -- Stone, Slanted Lichen
        itemPrice = 100,
      },
      [120654] = { -- Stone, Slanted Rough
        itemPrice = 100,
      },
      [120656] = { -- Stones, Gray Mossy
        itemPrice = 100,
      },
      [120675] = { -- Topiary, Manicured Evergreen
        itemPrice = 2000,
      },
      [120676] = { -- Topiary, Pruned Evergreen
        itemPrice = 1000,
      },

      [120670] = { -- Tree, Sturdy Jungle
        itemPrice = 250,
      },
      [120664] = { -- Tree, Tiered Light Cherry
        itemPrice = 15000,
      },
      [120665] = { -- Tree, Tiered Pink Cherry
        itemPrice = 15000,
      },
      [120666] = { -- Tree, Tiered White Cherry
        itemPrice = 25000,
      },
      [120657] = { -- Tree, twisted Pink cherry
        itemPrice = 15000,
      },
      [120667] = { -- Tree, twisted white cherry
        itemPrice = 12000,
      },
      [120659] = { -- Trees, Crooked Swamp
        itemPrice = 100,
      },
      [120668] = { -- Tree, Squat Pink Cherry
        itemPrice = 10000,
      },
      [120669] = { -- Tree, Squat White Cherry
        itemPrice = 10000,
      },
    },
  },
}

-- 3 Morrowind
FurC.Books[ver.MORROWIND] = {
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

FurC.AchievementVendors[ver.MORROWIND] = {
  [GetString(FURC_AV_VIVEC_SDI)] = {
    [GetString(SI_FURC_TRADERS_DROPSNOGLASS_COLL)] = FurC.Books[ver.MORROWIND],
    [GetString(SI_FURC_TRADERS_DROPSNOGLASS)] = {
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

    [GetString(SI_FURC_TRADERS_UZIPA)] = {
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

  [GetString(FURC_AV_VIVEC_GQ)] = {
    [GetString(SI_FURC_TRADERS_BRELDA)] = {
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

    [GetString(SI_FURC_TRADERS_LLIVAS)] = {
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

  [GetString(SI_FURC_LOC_CAPITAL)] = {
    [GetString(SI_FURC_TRADERS_HERALDA)] = {
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

  [GetString(FURC_AV_MAGES)] = {
    [GetString(SI_FURC_TRADERS_MYSTIC_COLL)] = FurC.Books[ver.MORROWIND],
  },
}

-- 2 Homestead
FurC.Books[ver.HOMESTEAD] = bookList

FurC.AchievementVendors[ver.HOMESTEAD] = {
  [GetString(SI_FURC_LOC_CAPITAL)] = {
    [GetString(SI_FURC_TRADERS_NARWAAWENDE)] = capitalVendor,
    [GetString(SI_FURC_TRADERS_HERALDA)] = holidayVendor,
  },
  [GetString(FURC_AV_MOURNHOLDBANK)] = {
    [GetString(SI_FURC_TRADERS_LTS)] = {
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
    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [120567] = { -- Bush,Vibrant Barberry
        itemPrice = 250,
      },
      [120566] = { -- Fern Plant,Healthy Green
        itemPrice = 100,
      },
      [120574] = { -- Mushroom,Huge Chanterelle
        itemPrice = 250,
      },
      [120568] = { -- Mushroom,Tall Chanterelle
        itemPrice = 250,
      },
    },
  },

  [GetString(SI_FURC_LOC_BALFOYEN_DHALMORA)] = {
    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120621] = { -- Plant, Red Aloe
        itemPrice = 250,
      },
      [120620] = { -- Plant, Red Aloe Succulent
        itemPrice = 250,
      },
      [120618] = { -- Tree, Gnarled Ashflower
        itemPrice = 5000,
      },
      [120619] = { -- Tree, Twisted Ashflower
        itemPrice = 7500,
      },
      [120622] = { -- Vines, Clustered Ivy
        itemPrice = 600,
      },
    },

    [GetString(SI_FURC_TRADERS_LTS)] = {
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

  [GetString(SI_FURC_LOC_STONEFALLS__EBONHEART)] = {
    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [121028] = { -- Hedge, Dense Low Wall
        itemPrice = 1300,
      },

      [121284] = { -- Dark Elf Column Lantern
        itemPrice = 250,
      },

      [120621] = { -- Plant, Red Aloe
        itemPrice = 250,
      },
      [120620] = { -- Plant, Red Aloe Succulent
        itemPrice = 250,
      },
      [120618] = { -- Tree, Gnarled Ashflower
        itemPrice = 5000,
      },
      [120619] = { -- Tree, Twisted Ashflower
        itemPrice = 7500,
      },
      [120622] = { -- Vines, Clustered Ivy
        itemPrice = 600,
      },
      [120680] = { -- Topiary, Fragile Cypress
        itemPrice = 2500,
      },
      [120681] = { -- Topiary, Pruned Cypress
        itemPrice = 1100,
      },
      [120677] = { -- Tree, Autumn Cherry Blossom
        itemPrice = 15000,
      },
    },

    [GetString(SI_FURC_TRADERS_LTS)] = {
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

  [GetString(SI_FURC_LOC_EASTMARCH_AMOL)] = {
    [GetString(SI_FURC_TRADERS_FROHILDE)] = miscVendor,

    [GetString(SI_FURC_TRADERS_LTS)] = {
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
  [GetString(SI_FURC_LOC_SHADOWFEN_CORIMONT)] = {

    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120630] = { -- Pebble, Stacked Lichen
        itemPrice = 100,
      },
      [120632] = { -- Pebble, Stacked Mossy
        itemPrice = 100,
      },
      [120637] = { -- Plant, Dry Spike
        itemPrice = 100,
      },
      [120627] = { -- Rocks, Stacked Angular
        itemPrice = 100,
      },
      [120628] = { -- Rocks, Slanted Mossy
        itemPrice = 100,
      },
      [120629] = { -- Rocks, Smooth Mossy
        itemPrice = 100,
      },
      [120634] = { -- Tree, Towering Swamp Palm
        itemPrice = 250,
      },
      [120636] = { -- Tree, Mud Palm
        itemPrice = 250,
      },
    },

    [GetString(SI_FURC_TRADERS_LTS)] = {
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

  [GetString(FURC_AV_RIFTEN_ARMORER)] = {

    [GetString(SI_FURC_TRADERS_FROHILDE)] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [120492] = { -- Boulder, Flat , Weathered
        itemPrice = 100,
      },
      [120496] = { -- Fern, dead
        itemPrice = 100,
      },
      [120494] = { -- Pebble, Stacked, Weathered
        itemPrice = 100,
      },
      [120493] = { -- Rock, Slanted, Tan
        itemPrice = 100,
      },
      [120495] = { -- Sapling, Budding Red
        itemPrice = 100,
      },
      [120500] = { -- Sapling, Tender Autumn
        itemPrice = 100,
      },
      [120499] = { -- Sapling, Tender Harvest
        itemPrice = 250,
      },
    },

    [GetString(SI_FURC_TRADERS_LTS)] = {
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
  [GetString(SI_FURC_LOC_ALIKR_KOZANZET_SWI)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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
      [119876] = { -- Tu'whacca's Braizer
        itemPrice = 5000,
        achievement = 516,
      },
    },
    [GetString(SI_FURC_TRADERS_ROHZIKA)] = miscVendor,
  },

  [GetString(FURC_AV_EVERMORE)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
      [119885] = { -- ceremonial Redguard vessel
        itemPrice = 3000,
        achievement = 147,
      },
      [119882] = { -- Damaged Knight of St. Pelin statue
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
    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [120449] = { -- Bush, Desert Scrub
        itemPrice = 100,
      },
      [120457] = { -- Pebble, smooth desert
        itemPrice = 100,
      },
      [120461] = { -- Cactus, Desert Wine
        itemPrice = 500,
      },
      [120452] = { -- Pebble, smooth grey
        itemPrice = 100,
      },
      [120460] = { -- Plant, green water
        itemPrice = 100,
      },
      [120450] = { -- plant, squat Yucca
        itemPrice = 100,
      },
      [120462] = { -- Plant, tall flowering Yucca
        itemPrice = 100,
      },
      [120440] = { -- Rocks, Scattered, Weatherd
        itemPrice = 100,
      },
      [120454] = { -- Rocks, Stacked Desert
        itemPrice = 100,
      },
      [120438] = { -- Rocks, Stacked Weathered
        itemPrice = 100,
      },
      [120441] = { -- Sapling, Short Highland
        itemPrice = 100,
      },
      [120443] = { -- Sapling, Tall Highland
        itemPrice = 100,
      },
      [120442] = { -- Sapling, Squat Highland
        itemPrice = 100,
      },
      [120459] = { -- Shrub, Browncrub
        itemPrice = 100,
      },
      [120458] = { -- Shrub, Speckled Forest
        itemPrice = 250,
      },
      [120446] = { -- Small Juniper Tree
        itemPrice = 100,
      },
      [120451] = { -- Stones, Smooth Gray
        itemPrice = 100,
      },
      [120455] = { -- Stone, stacked desert
        itemPrice = 100,
      },
      [120439] = { -- Stone, tapered weathered
        itemPrice = 100,
      },
      [120445] = { -- Sturdy Juniper Tree
        itemPrice = 100,
      },
      [120453] = { -- Tree, hardened Juniper
        itemPrice = 100,
      },
      [120448] = { -- Tree, old Juniper
        itemPrice = 100,
      },
    },
  },

  [GetString(SI_FURC_LOC_BETHNIKH_LTT)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
      [119984] = { -- Pirate Banner
        itemPrice = 10000,
        achievement = 415,
      },
    },

    [GetString(SI_FURC_TRADERS_ROHZIKA)] = miscVendor,
  },

  [GetString(SI_FURC_LOC_GLENUMBRA_DAGGERFALL_RL)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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
      [119858] = { -- Bloodthorn Vines, small
        itemPrice = 5000,
        achievement = 953,
      },
    },

    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [121011] = { -- Trees, young autumn birch
        itemPrice = 100,
      },
      [120713] = { -- Trees, Towering Autumn Birch
        itemPrice = 250,
      },
      [120720] = { -- Shrubs, Small Berry
        itemPrice = 100,
      },
      [120718] = { -- Shrub, Dense Forest
        itemPrice = 100,
      },
      [120717] = { -- Shrub, Autumn Forest
        itemPrice = 100,
      },
      [120711] = { -- Sapling, Young Birch
        itemPrice = 250,
      },
      [120716] = { -- Sapling, Autumn Cluster
        itemPrice = 100,
      },
      [120708] = { -- Rocks, Craggy set
        itemPrice = 100,
      },
      [120527] = { -- Fern Plant, Green Curly
        itemPrice = 100,
      },
      [120707] = { -- Boulder, Mossy Weathered
        itemPrice = 100,
      },
      [120705] = { -- Boulder, Mossy Grey
        itemPrice = 100,
      },
      [120706] = { -- Boulder, Giant Mossy
        itemPrice = 100,
      },
    },
  },

  [GetString(FURC_AV_SHORNHELM_DW)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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
      [119870] = { -- Constellation: The Tower
        itemPrice = 10000,
        achievement = 955,
      },
      [119869] = { -- Constellation: The Shadow
        itemPrice = 10000,
        achievement = 955,
      },
      [119868] = { -- Constellation: The Ritual
        itemPrice = 10000,
        achievement = 955,
      },
    },

    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [120578] = { -- Sapling, Young Aspen
        itemPrice = 100,
      },
      [120576] = { -- Sapling ,Fragile Aspen
        itemPrice = 100,
      },
      [120579] = { -- Flower, Stout Hibiscus
        itemPrice = 250,
      },
      [120580] = { -- Flower, Healthy Hibiscus
        itemPrice = 250,
      },
    },
  },

  [GetString(FURC_AV_WAYREST_MERCHANT)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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

    [GetString(SI_FURC_TRADERS_ROHZIKA)] = {
      [120582] = { -- Tree, Yellowing Oak
        itemPrice = 20000,
      },
      [120442] = { -- Sapling, Squat Highland
        itemPrice = 100,
      },
      [120444] = { -- Sapling, Tall Highland
        itemPrice = 100,
      },
      [120443] = { -- Sapling, strong Highland
        itemPrice = 100,
      },
    },
  },

  [GetString(SI_FURC_LOC_AURIDON_SKYWATCH)] = {
    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
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

    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120663] = { -- Saplings, Healthy Forest
        itemPrice = 100,
      },
      [120662] = { -- Saplings, Squat Forest
        itemPrice = 100,
      },
      [120661] = { -- Saplings, Young Forest
        itemPrice = 100,
      },
    },
  },

  [GetString(SI_FURC_LOC_GREENSHADE_MARBRUK)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120597] = { -- Fern Plant, Vibrant
        itemPrice = 100,
      },
      [120599] = { -- Fern, Healthy Green
        itemPrice = 100,
      },
      [120595] = { -- Fern, Lush
        itemPrice = 100,
      },
      [120600] = { -- Fern, Young, Healthy
        itemPrice = 100,
      },
      [120598] = { -- Plants, Low weeds
        itemPrice = 100,
      },
      [120588] = { -- Rock, Slanted Algae
        itemPrice = 100,
      },
      [120590] = { -- Rocks, Smooth Set
        itemPrice = 100,
      },
      [120592] = { -- Saplings, Highland Cluster
        itemPrice = 100,
      },
      [120593] = { -- Saplings, Twin Highland
        itemPrice = 100,
      },
      [120589] = { -- Stone, Slanted Weathered
        itemPrice = 100,
      },
      [120591] = { -- Tree, Vibrant Privet
        itemPrice = 250,
      },
      [120587] = { -- Boulder, Flat Grey
        itemPrice = 250,
      },
      [120586] = { -- Boulder, Moss Covered
        itemPrice = 250,
      },
    },

    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
      [119839] = { -- Fires of the WIlderking
        itemPrice = 4000,
        achievement = 510,
      },
      [119841] = { -- Hectahame Arboretum Relic
        itemPrice = 10000,
        achievement = 512,
      },
      [120991] = { -- Rise of the Silvenaar
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

  [GetString(SI_FURC_LOC_KHENARTHI_MISTRAL)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = miscVendor,
    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
      [119986] = { -- Maomer Totem
        itemPrice = 10000,
      },
    },
  },

  [GetString(FURC_AV_VULKWAESTEN_TAVERN)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120529] = { -- Fern Cluster, Healthy
        itemPrice = 100,
      },
      [120531] = { -- Fern Fronts, Healthy Green
        itemPrice = 100,
      },
      [120530] = { -- Fern Fronds, Sunburst
        itemPrice = 100,
      },
      [120527] = { -- Fern Plant, Green Curly
        itemPrice = 100,
      },
      [120528] = { -- Fern Plant, Sturdy Mature
        itemPrice = 100,
      },
      [120640] = { -- Fern, Budding Forest
        itemPrice = 100,
      },
      [120641] = { -- Fern, Low Red
        itemPrice = 100,
      },
      [120642] = { -- Mushrooms, Brown Gilled
        itemPrice = 100,
      },
      [120534] = { -- Mushroom, Bruising Webcap
        itemPrice = 250,
      },
      [120532] = { -- Mushrooms, Poison Pax Cluster
        itemPrice = 100,
      },
      [120533] = { -- Mushrooms, Poison Pax Group
        itemPrice = 100,
      },
      [120638] = { -- Rock, Slanted Weathered
        itemPrice = 100,
      },
      [120523] = { -- Rocks, Mossy Cluster
        itemPrice = 100,
      },
      [120524] = { -- Rocks, Mossy Set
        itemPrice = 100,
      },
      [120639] = { -- Stones, Smooth Mossy
        itemPrice = 100,
      },
      [120525] = { -- Tree, Mossy Swamp
        itemPrice = 100,
      },
      [120643] = { -- Vines, Curtain Ivy
        itemPrice = 750,
      },
      [120645] = { -- Vines, Draped Ivy
        itemPrice = 750,
      },
      [120644] = { -- Vines, Lush Ivy
        itemPrice = 600,
      },
    },

    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
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

  [GetString(SI_FURC_LOC_GRAHTWOOD_REDFUR)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120725] = { -- Boulder, Mossy Crag
        itemPrice = 100,
      },
      [121285] = { -- Tree, Ancient Banyan
        itemPrice = 25000,
      },
      [121286] = { -- Tree, Giant Cypress
        itemPrice = 5000,
      },
      [121287] = { -- Tree, Towering Cypress
        itemPrice = 5000,
      },
      [120742] = { -- Tree, Twisted Banyan
        itemPrice = 25000,
      },
      [119578] = { -- Tree, Towering Palm Cluster
        itemPrice = 100,
      },
      [120741] = { -- Tree, Towering Wax Palm
        itemPrice = 250,
      },
      [121288] = { -- Tree, Mossy Murkmire Cluster
        itemPrice = 250,
      },
      [117975] = { -- Rough Hay Bed, Sloppy
        itemPrice = 100,
      },
    },

    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
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

  [GetString(FURC_AV_RAWLKHA_MARKET)] = {
    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [120998] = { -- Block, Wood Cutting
        itemPrice = 100,
      },
      [120511] = { -- Bush, Mountain Scrub
        itemPrice = 100,
      },
      [120690] = { -- Fern Plant, Hardy
        itemPrice = 100,
      },
      [120510] = { -- Fern Plant, Sturdy Towering
        itemPrice = 100,
      },
      [120512] = { -- Fern, Fragile
        itemPrice = 100,
      },
      [120521] = { -- Fern, Withering
        itemPrice = 100,
      },
      [120691] = { -- Fern, Young Sunburnt
        itemPrice = 100,
      },
      [120703] = { -- Khajiit Column, Spiked
        itemPrice = 4000,
      },
      [120561] = { -- Plant, Jungle Leaf
        itemPrice = 100,
      },
      [120697] = { -- Plant, Leafy Sprouts
        itemPrice = 100,
      },
      [120560] = { -- Plant, Squat Jungle Leaf
        itemPrice = 100,
      },
      [120562] = { -- Plant, Towering Jungle Leaf
        itemPrice = 100,
      },
      [120699] = { -- Platform, Weathered Dock
        itemPrice = 250,
      },
      [120700] = { -- Post, Barnacle Covered
        itemPrice = 100,
      },
      [120515] = { -- Shrub, Lanky Highland
        itemPrice = 100,
      },
      [120522] = { -- Shrub, Tender Privet
        itemPrice = 100,
      },
      [117990] = { -- Tea Table, Carved
        itemPrice = 250,
      },
      [121282] = { -- Tree, Ancient Jungle
        itemPrice = 5000,
      },
      [121283] = { -- Tree, Healthy Jungle
        itemPrice = 250,
      },
      [120519] = { -- Tree, Healthy Privet
        itemPrice = 250,
      },
      [120687] = { -- Tree, Sturdy Shade
        itemPrice = 250,
      },
      [120558] = { -- Sapling, Eucalyptus Shrub
        itemPrice = 100,
      },
    },

    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
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

  [GetString(SI_FURC_LOC_CRAGLORN_BELKARTH_WOOD)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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

    [GetString(SI_FURC_TRADERS_KRRZTRRB)] = {
      [120964] = { -- Boulder, Craggy Heap
        itemPrice = 100,
      },
      [120545] = { -- Tree, Sturdy Summer
        itemPrice = 250,
      },
      [120963] = { -- Boulder, Jagged Crag
        itemPrice = 100,
      },
      [120552] = { -- Bush, Flowering Scrub
        itemPrice = 250,
      },
      [120555] = { -- Flowers, Healthy Goldenrod
        itemPrice = 250,
      },
      [120551] = { -- Plant, Healthy Sage
        itemPrice = 100,
      },
      [120977] = { -- Plant, Strong Sage
        itemPrice = 100,
      },
      [120966] = { -- Rock, Craggy Rubble
        itemPrice = 100,
      },
      [120539] = { -- Rock, Jagged Craggy
        itemPrice = 100,
      },
      [120969] = { -- Sapling, Crabapple
        itemPrice = 100,
      },
      [120972] = { -- Sapling, Desert
        itemPrice = 100,
      },
      [120548] = { -- Sapling, Leaning Ash
        itemPrice = 100,
      },
      [120973] = { -- Sapling, Mountain
        itemPrice = 100,
      },
      [120983] = { -- Sapling, Mountain
        itemPrice = 100,
      },
      [120971] = { -- Sapling, Tall Scrub
        itemPrice = 100,
      },
      [120982] = { -- Sapling, Twisted
        itemPrice = 100,
      },
      [120553] = { -- Sapling, Young Scrub
        itemPrice = 100,
      },
      [120976] = { -- Sapling, Juniper Cluster
        itemPrice = 100,
      },
      [120981] = { -- Sapling, Desert Scrub
        itemPrice = 100,
      },
      [120967] = { -- Stone, Angled Grey
        itemPrice = 100,
      },
      [120975] = { -- Tree, Angled Ash
        itemPrice = 100,
      },
      [120543] = { -- Tree, Blooming Crabapple
        itemPrice = 6000,
      },
      [120549] = { -- Tree, Large Twisted Ash
        itemPrice = 250,
      },
      [120547] = { -- Tree, Leaning Ash
        itemPrice = 250,
      },
      [120970] = { -- Tree, Sturdy Crabapple
        itemPrice = 13000,
      },
      [120974] = { -- Tree, Sturdy Summer
        itemPrice = 250,
      },
      [120550] = { -- Tree, Twisted
        itemPrice = 100,
      },
    },
  },
  [GetString(SI_FURC_LOC_COLDH_HOLLOW_CGG)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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

    [GetString(SI_FURC_TRADERS_KRRZTRRB)] = boxes,
  },

  [GetString(SI_FURC_LOC_GOLDCOAST_KVATCH)] = {
    [GetString(SI_FURC_TRADERS_ATHRAGOR)] = {
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

    [GetString(SI_FURC_TRADERS_FROHILDE)] = structures,
  },

  [GetString(SI_FURC_LOC_HEW)] = {
    [GetString(SI_FURC_TRADERS_LTS)] = {
      [119965] = { -- Abah's Landing Banner
        itemPrice = 10000,
        achievement = 1366,
      },
      [119961] = { -- An Adoring Fan
        itemPrice = 2500,
        achievement = 1363,
      },
      [119969] = { -- Banner of TAneth
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

    [GetString(SI_FURC_TRADERS_ROHZIKA)] = structures,
  },

  [GetString(SI_FURC_LOC_PLACE_ORSINIUM)] = {
    [GetString(SI_FURC_TRADERS_LOZOTUSK)] = {
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

    [GetString(SI_FURC_TRADERS_MALADDIQ)] = {
      [117986] = { -- Rough Plank, Long
        itemPrice = 100,
      },
      [117985] = { -- Rough Bread, Morsel
        itemPrice = 100,
      },
      [117981] = { -- Rough Firewood, Smoldering
        itemPrice = 100,
      },
      [117976] = { -- Rough Hay Bed, Covered
        itemPrice = 100,
      },
      [117975] = { -- Rough Hay Bed, Sloppy
        itemPrice = 100,
      },
      [117974] = { -- Rough Hay Bed, Tidy
        itemPrice = 100,
      },
      [117964] = { -- Rough Fire, doused
        itemPrice = 100,
      },
      [117955] = { -- Box, Slatted
        itemPrice = 100,
      },
    },
  },

  [GetString(SI_FURC_LOC_CITY)] = {
    [GetString(SI_FURC_TRADERS_ENCHANTERS)] = {
      [120051] = { -- Enchanting Gem
        itemPrice = 5000,
        achievement = 1317,
      },
      [120050] = { -- Enchanter's Sign
        itemPrice = 5000,
        achievement = 1034,
      },
    },

    [GetString(SI_FURC_TRADERS_ALCHEMISTS)] = {
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

    [GetString(SI_FURC_TRADERS_COOKS)] = {
      [120053] = { -- Chef's Cleaver
        itemPrice = 2500,
        achievement = 1028,
      },
      [120052] = { -- Provisioner's Sign
        itemPrice = 5000,
        achievement = 1035,
      },
    },

    [GetString(SI_FURC_TRADERS_CLOTHIERS)] = {
      [120061] = { -- Harvester's Garden Shrub
        itemPrice = 10000,
        achievement = 68,
      },
      [120060] = { -- Harvester's Critter Trap
        itemPrice = 5000,
        achievement = 68,
      },
      [120048] = { -- clothier's sign
        itemPrice = 5000,
        achievement = 1033,
      },
    },

    [GetString(SI_FURC_TRADERS_CARPENTERS)] = {
      [120057] = { -- Harvester's Woodpile
        itemPrice = 1000,
        achievement = 68,
      },
      [120054] = { -- Woodworker's Sign
        itemPrice = 5000,
        achievement = 1036,
      },
    },

    [GetString(SI_FURC_TRADERS_BLACKSMITHS)] = {
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

    [GetString(SI_FURC_TRADERS_OUTLAW)] = {
      [120993] = { -- Scales of Felonious Recompense
        itemPrice = 5000,
        achievement = 1196, -- Felonious Recompense
      },
      [120957] = { -- Faded fence banner
        itemPrice = 10000,
        achievement = GetString(FURC_AV_LEGERDEMAIN_20),
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
        achievement = GetString(FURC_AV_LEGERDEMAIN_20),
      },
    },
  },

  [GetString(FURC_AV_MAGES)] = {
    [GetString(SI_FURC_TRADERS_MYSTIC_COLL)] = {},
    [GetString(SI_FURC_TRADERS_MYSTIC)] = {
      [120011] = { -- Mages' Guild Banner
        itemPrice = 10000,
        achievement = 702,
      },
      [120003] = { -- cheese cutter
        itemPrice = 5000,
        achievement = 1686,
      },
    },
  },

  [GetString(FURC_AV_FIGHTERS)] = {
    [GetString(FURC_AV_FIGHTERS_STEWARD)] = {
      [120948] = { -- Dark Anchor Pinion
        itemPrice = 100000,
        achievement = 318,
      },
      [120019] = { -- Fighters' Guild Banner
        itemPrice = 10000,
        achievement = 703,
      },
      [120000] = { --Broken Chain
        itemPrice = 50000,
        achievement = 587,
      },
      [119999] = { -- Daedric Chest
        itemPrice = 10000,
        achievement = 1683,
      },
    },
  },

  [GetString(SI_FURC_LOC_UNDAUNTED)] = {
    [GetString(SI_FURC_TRADERS_UNDAUNTEDQM)] = {
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
  local addTable, listTable

  FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_MAGES)][GetString(SI_FURC_TRADERS_MYSTIC_COLL)] = bookList

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_BALFOYEN_DHALMORA)][GetString(
    SI_FURC_TRADERS_FROHILDE
  )]
  addTable = merge(furnishingVendor, morrowindStones)
  listTable = merge(listTable, addTable)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_MOURNHOLDBANK)][GetString(SI_FURC_TRADERS_FROHILDE)]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_STONEFALLS__EBONHEART)][GetString(
    SI_FURC_TRADERS_FROHILDE
  )]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_SHADOWFEN_CORIMONT)][GetString(
    SI_FURC_TRADERS_FROHILDE
  )]
  addTable = furnishingVendor
  listTable = merge(listTable, addTable)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_RIFTEN_ARMORER)][GetString(SI_FURC_TRADERS_FROHILDE)]
  addTable = furnishingVendor
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_EVERMORE)][GetString(SI_FURC_TRADERS_ROHZIKA)]
  listTable = merge(listTable, addTable)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_WAYREST_MERCHANT)][GetString(SI_FURC_TRADERS_ROHZIKA)]
  listTable = merge(listTable, addTable)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_GREENSHADE_MARBRUK)][GetString(
    SI_FURC_TRADERS_MALADDIQ
  )]
  listTable = merge(listTable, addTable)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_VULKWAESTEN_TAVERN)][GetString(SI_FURC_TRADERS_MALADDIQ)]
  listTable = merge(listTable, addTable)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_RAWLKHA_MARKET)][GetString(SI_FURC_TRADERS_MALADDIQ)]
  listTable = merge(listTable, structures)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_GRAHTWOOD_REDFUR)][GetString(SI_FURC_TRADERS_MALADDIQ)]
  listTable = merge(listTable, furnishingVendor)
  listTable = merge(listTable, miscVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_CRAGLORN_BELKARTH_WOOD)][GetString(
    SI_FURC_TRADERS_KRRZTRRB
  )]
  listTable = merge(listTable, furnishingVendor)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_COLDH_HOLLOW_CGG)][GetString(SI_FURC_TRADERS_KRRZTRRB)]
  listTable = merge(listTable, structures)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_GOLDCOAST_KVATCH)][GetString(SI_FURC_TRADERS_FROHILDE)]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_HEW)][GetString(SI_FURC_TRADERS_ROHZIKA)]
  listTable = merge(listTable, furnishingVendor)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_PLACE_ORSINIUM)][GetString(SI_FURC_TRADERS_MALADDIQ)]
  listTable = merge(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_GLENUMBRA_DAGGERFALL_RL)][GetString(
    SI_FURC_TRADERS_ROHZIKA
  )]
  listTable = merge(listTable, furnishingVendor)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(FURC_AV_SHORNHELM_DW)][GetString(SI_FURC_TRADERS_ROHZIKA)]
  listTable = merge(listTable, furnishingVendor)

  listTable =
    FurC.AchievementVendors[ver.HOMESTEAD][GetString(SI_FURC_LOC_PLACE_ORSINIUM)][GetString(SI_FURC_TRADERS_MALADDIQ)]
  listTable = merge(listTable, structures)
end
