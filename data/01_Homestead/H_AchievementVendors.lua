FurC.AchievementVendors    = FurC.AchievementVendors or {}
FurC.Books                 = FurC.Books or {}

local jesterVendor         = {
  -- tree, Jester's Large
  [120994] = {
    itemPrice   = 15000,
    achievement = 1723,
  },
  -- tree, Jester's Small
  [118529] = {
    itemPrice   = 5000,
    achievement = 1723,
  },
  -- Banner of Mayhem
  [126720] = {
    itemPrice   = 5000,
    achievement = 1883,
  },
  -- Corpse of Mayhem, Argonian
  [126721] = {
    itemPrice   = 15000,
    achievement = 1888,
  },
  -- Corpse of Mayhem, Khajiit
  [126722] = {
    itemPrice   = 15000,
    achievement = 1888,
  },
  -- Corpse of Mayhem, Orc
  [126723] = {
    itemPrice   = 15000,
    achievement = 1888,
  },
  -- Probably-Not-Punch-Bowl of Mayhem
  [126724] = {
    itemPrice   = 30000,
    achievement = 1892,
  },
  -- Stamdard of Mayhem
  [126719] = {
    itemPrice   = 2500,
    achievement = 1883,
  },
  [131433] = { -- Witches Festival, Plunder Skulls
    itemPrice   = 10000,
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

local capitalVendor        = {
  [119987] = { -- Coldharbour Urn
    itemPrice   = 5000,
    achievement = 993,
  },
  [145488] = { -- Banner, Jewelry Crafting
    itemPrice   = 5000,
    achievement = 2215,
  },
  [120064] = { -- Covenant Hero Shield
    itemPrice   = 10000,
    achievement = 61,
  },
  [120037] = { -- Decorative Skyshard
    itemPrice   = 25000,
    achievement = 989,
  },
  [120001] = { -- Decorative Treasure Chest
    itemPrice   = 10000,
    achievement = 22,
  },
  [119994] = { -- Depleted Sigil Stone
    itemPrice   = 5000,
    achievement = 1000,
  },
  [120066] = { -- Display Craft Bag
    itemPrice   = 5000,
    achievement = "ESO+",
  },
  [120063] = { -- Dominion Hero Shield
    itemPrice   = 10000,
    achievement = 618,
  },
  [120043] = { -- Fishing Vessel
    itemPrice   = 25000,
    achievement = 494,
  },
  [120056] = { -- Hanging Map of Tamriel
    itemPrice   = 10000,
    achievement = 867,
  },
  [119993] = { -- Lantern of Anguish
    itemPrice   = 5000,
    achievement = 999,
  },
  [120065] = { -- Pact Hero Shield
    itemPrice   = 10000,
    achievement = 617,
  },
  [120039] = { -- Primal Altar to Hircine
    itemPrice   = 50000,
    achievement = 1009,
  },
  [119989] = { -- Replica Black Soul Gem
    itemPrice   = 2500,
    achievement = 995,
  },
  [119988] = { -- Replica Soul Gem
    itemPrice   = 500,
    achievement = 994,
  },
  [119995] = { -- Silent Sentinel
    itemPrice   = 20000,
    achievement = 1001,
  },
  [119990] = { -- Soul Gem Case
    itemPrice   = 4000,
    achievement = 996,
  },
  [119992] = { -- Soul Gem Crate
    itemPrice   = 5000,
    achievement = 998,
  },
  [119996] = { -- Soul Gem Stand
    itemPrice   = 4000,
    achievement = 1002,
  },
  [119991] = { -- Spare Flesh Atronach Parts
    itemPrice   = 10000,
    achievement = 997,
  },
  [119873] = { -- Tamrith Coffin
    itemPrice   = 20000,
    achievement = 1010,
  },
  [119872] = { -- Tamrith Coffin Lid
    itemPrice   = 5000,
    achievement = 1010,
  },
  [119997] = { -- The Final Threat
    itemPrice   = 100000,
    achievement = 1003,
  },
}

local furnishingVendor     = {
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

local morrowindStones      = {
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

local structures           = {
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
  [117987] = { -- Rough Plank, Long
    itemPrice = 100,
  },
  [117961] = { -- Rough Planks, Narrow
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

local boxes                = {
  [120998] = { -- Block,Wood Cutting
    itemPrice = 100,
  },
  [117959] = { -- Rough Container, Shipping
    itemPrice = 100,
  },
  [117959] = { -- Rough Box, Slatted
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

local laundry              = {
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

local fishing_trip         = {
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

local bookList             = {
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

FurC.Books[FURC_HOMESTEAD] = bookList
--[[
      [""] = {    --
        itemPrice   = 100,
      },
]]
local miscVendor = FurC.MergeTable(FurC.MergeTable(FurC.MergeTable(structures, boxes), laundry), fishing_trip)


FurC.AchievementVendors[FURC_HOMESTEAD] = {
  [GetString(FURC_AV_CAPITAL)]                        = {
    [GetString(FURC_AV_NAR)] = capitalVendor,
    [GetString(FURC_AV_HER)] = jesterVendor,
  },
  -- location name
  ["Mournhold Bank"]                                  = {
    -- vendor name
    [GetString(FURC_AV_LTS)] = {
      [119908] = { -- Swamp Anemone
        itemPrice   = 15000,
        achievement = 595,
      },
      [119914] = { -- Touch of Plague
        itemPrice   = 500,
        achievement = 363,
      },
      [119913] = { -- Tribunal Altar
        itemPrice   = 25000,
        achievement = 364,
      },
      [119911] = { -- Tribunal Rug
        itemPrice   = 5000,
        achievement = 949,
      },
      [119910] = { -- Veloth's Reliquary
        itemPrice   = 50000,
        achievement = 365,
      },
    },
    [GetString(FURC_AV_FRO)] = {
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
  ["Dhalmora, Bal Foyen"]                             = {

    [GetString(FURC_AV_FRO)] = {
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
    [GetString(FURC_AV_LTS)] = {
      [120956] = { -- Atmoran Eagle Totem Medallion
        itemPrice   = 3000,
        achievement = 194,
      },
      [120954] = { -- Atmoran Snake Totem Medallion
        itemPrice   = 3000,
        achievement = 194,
      },
      [120955] = { -- Atmoran Whale Totem Medallion
        itemPrice   = 3000,
        achievement = 194,
      },
    },

  },
  ["Stonefalls, Ebonheart"]                           = {

    [GetString(FURC_AV_FRO)] = {
      [120502] = { -- Flower, Grandmother Hibiscus
        itemPrice = 1000,
      },
      [121028] = { -- Hedge, Dense Low Wall
        itemPrice = 1300,
      },

      [121284] = { -- Dark Elf Column Lantern
        itemPrice = 250,
      },

      [120621] = {   -- Plant, Red Aloe
        itemPrice = 250,
      },[120620] = { -- Plant, Red Aloe Succulent
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

    [GetString(FURC_AV_LTS)] = {
      [119890] = { -- Blood Fountain
        itemPrice   = 100000,
        achievement = 948,
      },
      [119889] = { -- Daedric Sconce
        itemPrice   = 5000,
        achievement = 209,
      },
      [119888] = { -- Lacquered Kwama Egg
        itemPrice   = 1000,
        achievement = 593,
      },
      [119892] = { -- Remnant of Balreth
        itemPrice   = 15000,
        achievement = 201,
      },
      [119887] = { -- Serien's Stand
        itemPrice   = 10000,
        achievement = 204,
      },
    },

  },
  ["Eastmarch, Fort Amol"]                            = {

    [GetString(FURC_AV_FRO)] = miscVendor,


    [GetString(FURC_AV_LTS)] = {
      [119905] = { -- Dragon Shrine Altar
        itemPrice   = 20000,
        achievement = 598,
      },
      [119901] = { -- Lob's Challenge Horn
        itemPrice   = 1000,
        achievement = 597,
      },
      [119904] = { -- Standing Slab
        itemPrice   = 1000,
        achievement = 600,
      },
      [119906] = { -- Throne of the Skald King
        itemPrice   = 50000,
        achievement = 951,
      },
      [119907] = { -- Visage of the Skald
        itemPrice   = 25000,
        achievement = 599,
      },
    },

  },
  ["Shadowfen, Alten Corimont"]                       = {

    [GetString(FURC_AV_FRO)] = {
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

    [GetString(FURC_AV_LTS)] = {
      [119897] = { -- Argonian Egg
        itemPrice   = 2500,
        achievement = 185,
      },
      [119893] = { -- Mimic Hist Tree
        itemPrice   = 20000,
        achievement = 950,
      },
      [119900] = { -- Oblivion Stone
        itemPrice   = 5000,
        achievement = 184,
      },
      [119898] = { -- Replica Mnemic Egg
        itemPrice   = 100000,
        achievement = 596,
      },
      [119899] = { -- Replica Stone Nest
        itemPrice   = 10000,
        achievement = 186,
      },
    },

  },
  ["Riften, Market, Armorer"]                         = {

    [GetString(FURC_AV_FRO)] = {
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

    [GetString(FURC_AV_LTS)] = {
      [119915] = { -- Ancient Cultist Totem
        itemPrice   = 5000,
        achievement = 337,
      },
      [119918] = { -- Statue of the Wolf
        itemPrice   = 7500,
        achievement = 336,
      },
      [119922] = { -- Torn Worm Cult Banner
        itemPrice   = 10000,
        achievement = 952,
      },
      [119920] = { -- Totem of the Reach
        itemPrice   = 40000,
        achievement = 335,
      },
      [119916] = { -- Ysgramor Statue
        itemPrice   = 20000,
        achievement = 603,
      },
    },
  },
  ["Alik'r, Kozanzet, Sweetwater Inn"]                = {
    [GetString(FURC_AV_LOT)] = {
      [119879] = { -- Kneeling Ansei Statue
        itemPrice   = 15000,
        achievement = 518,
      },
      [119877] = { -- Reconstructed Necromantic Focus
        itemPrice   = 5000,
        achievement = 517,
      },
      [119880] = { -- Replica Of Shattered Ansei Sword
        itemPrice   = 35000,
        achievement = 956,
      },
      [119878] = { -- Standing Ansei Statue
        itemPrice   = 15000,
        achievement = 59,
      },
      [119876] = { -- Tu'whacca's Braizer
        itemPrice   = 5000,
        achievement = 516,
      },
    },
    [GetString(FURC_AV_ROH)] = miscVendor,
  },
  ["Bangkorai, Evermore"]                             = {
    [GetString(FURC_AV_LOT)] = {
      [119885] = { -- ceremonial Redguard vessel
        itemPrice   = 3000,
        achievement = 147,
      },
      [119882] = { -- Damaged Knight of St. Pelin statue
        itemPrice   = 5000,
        achievement = 146,
      },
      [119883] = { -- Evermore Mourning Banner
        itemPrice   = 4000,
        achievement = 145,
      },
      [119881] = { -- Glenmoril Wyrd Stone
        itemPrice   = 5000,
        achievement = 60,
      },
      [119884] = { -- Ragged Imperial Banner
        itemPrice   = 4000,
        achievement = 958,
      },

    },
    [GetString(FURC_AV_ROH)] = {
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
      [120443] = { -- Sapling, Strong Highland
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
  ["Bethnikh, near tavern"]                           = {
    [GetString(FURC_AV_LOT)] = {
      [119984] = { -- Pirate Banner
        itemPrice   = 10000,
        achievement = 415,
      },
    },
    [GetString(FURC_AV_ROH)] = miscVendor,
  },
  ["Glenumbra, Daggerfall, The Rosy Lion"]            = {
    [GetString(FURC_AV_LOT)] = {
      [119855] = { -- Wyrdstone
        itemPrice   = 2500,
        achievement = 30,
      },
      [119856] = { -- Torn Lion Guard Banner
        itemPrice   = 5000,
        achievement = 28,
      },
      [119862] = { -- Hagraven Totem
        itemPrice   = 5000,
        achievement = 34,
      },
      [119857] = { -- Breton Gravewatcher Statue
        itemPrice   = 25000,
        achievement = 31,
      },
      [119858] = { -- Bloodthorn Vines, small
        itemPrice   = 5000,
        achievement = 953,
      },
    },
    [GetString(FURC_AV_ROH)] = {
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
  ["Rivenspire, Shornhelm, Dead Wolf Inn"]            = {
    [GetString(FURC_AV_LOT)] = {
      [119871] = { -- Wagon of DEATH
        itemPrice   = 25000,
        achievement = 58,
      },
      [120951] = { -- Hope of Rivenspire
        itemPrice   = 5000,
        achievement = 590,
      },
      [119875] = { -- Gargoyle Statue
        itemPrice   = 50000,
        achievement = 589,
      },
      [120040] = { -- Crimson-Stained Bowl
        itemPrice   = 2500,
        achievement = 591,
      },
      [119870] = { -- Constellation: The Tower
        itemPrice   = 10000,
        achievement = 955,
      },
      [119869] = { -- Constellation: The Shadow
        itemPrice   = 10000,
        achievement = 955,
      },
      [119868] = { -- Constellation: The Ritual
        itemPrice   = 10000,
        achievement = 955,
      },
    },
    [GetString(FURC_AV_ROH)] = {
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
  ["Stormhaven, Wayrest, Merchant district"]          = {
    [GetString(FURC_AV_LOT)] = {
      [119865] = { -- Wayrest Guillotine
        itemPrice   = 75000,
        achievement = 156,
      },
      [119867] = { -- Vaermina Statue
        itemPrice   = 75000,
        achievement = 57,
      },
      [119864] = { -- Spirit Warden Azura Statue
        itemPrice   = 75000,
        achievement = 155,
      },
      [119866] = { -- Replica Dreamshard
        itemPrice   = 2000,
        achievement = 954,
      },
      [119863] = { -- Knights of the Flame Banner
        itemPrice   = 10000,
        achievement = 154,
      },
    },
    [GetString(FURC_AV_ROH)] = {

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
    }
  },
  ["Skywatch, Auridon"]                               = {
    [GetString(FURC_AV_ATH)] = {
      [119823] = { -- Tanzelwil Culanda Stone
        itemPrice   = 5000,
        achievement = 360,
      },
      [119824] = { -- Veiled Crystal
        itemPrice   = 5000,
        achievement = 361,
      },
      [119825] = { -- Mehrunes Dagon Brazier
        itemPrice   = 10000,
        achievement = 362,
      },
      [119826] = { -- High Elf Throne
        itemPrice   = 25000,
        achievement = 943,
      },
      [119827] = { -- Ancient High Elf Statue
        itemPrice   = 35000,
        achievement = 604,
      },
    },
    [GetString(FURC_AV_MAL)] = {
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
  ["Greenshade, Marbruk"]                             = {
    [GetString(FURC_AV_MAL)] = {
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


    [GetString(FURC_AV_ATH)] = {
      [119839] = { -- Fires of the WIlderking
        itemPrice   = 4000,
        achievement = 510,
      },
      [119841] = { -- Hectahame Arboretum Relic
        itemPrice   = 10000,
        achievement = 512,
      },
      [120991] = { -- Rise of the Silvenaar
        itemPrice   = 5000,
        achievement = 945,
      },
      [119840] = { -- Sea Elf Banner
        itemPrice   = 10000,
        achievement = 511,
      },
      [119842] = { -- Wood Elf Path Marker
        itemPrice   = 7500,
        achievement = 610,
      },
    },

  },
  ["Khenarthi's Roost, Mistral"]                      = {
    [GetString(FURC_AV_MAL)] = miscVendor,
    [GetString(FURC_AV_ATH)] = {
      [119986] = { -- Maomer Totem
        itemPrice = 10000,
      },
    },
  },
  ["Malabal Tor, Vulkwaesten, tavern"]                = {
    [GetString(FURC_AV_MAL)] = {
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
    [GetString(FURC_AV_ATH)] = {
      [119847] = { -- Handfast
        itemPrice   = 25000,
        achievement = 611,
      },
      [119846] = { -- Handfast Pedestal
        itemPrice   = 5000,
        achievement = 946,
      },
      [119845] = { -- Wood Elf Union Trellis
        itemPrice   = 15000,
        achievement = 285,
      },
      [119843] = { -- Wood Orc Dream Catcher
        itemPrice   = 4000,
        achievement = 283,
      },
      [119844] = { -- Wood Orc Malacath Banner
        itemPrice   = 10000,
        achievement = 284,
      },
    },
  },
  ["Grahtwood, Redfur Trading Post"]                  = {
    [GetString(FURC_AV_MAL)] = {
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
    [GetString(FURC_AV_ATH)] = {
      [119834] = { -- Aulus's Captive Audience
        itemPrice   = 10000,
        achievement = 605,
      },
      [119836] = { -- Guardian Mane
        itemPrice   = 10000,
        achievement = 607,
      },
      [119837] = { -- Orrery Control Pillar Replica
        itemPrice   = 10000,
        achievement = 944,
      },
      [119835] = { -- Ukaezai's Ward
        itemPrice   = 10000,
        achievement = 606,
      },
      [119838] = { -- Valenwood Brazier
        itemPrice   = 4000,
        achievement = 608,
      },
    },
  },
  ["Reaper's March, Rawl'Kha, Market"]                = {
    [GetString(FURC_AV_MAL)] = {
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
    [GetString(FURC_AV_ATH)] = {
      [119848] = { -- Colovian Projection Crystal
        itemPrice   = 5000,
        achievement = 536,
      },
      [119853] = { -- Full Moons Tile
        itemPrice   = 5000,
        achievement = 602,
      },
      [119850] = { -- Khajiiti Shrine Guardian Statue
        itemPrice   = 20000,
        achievement = 538,
      },
      [119849] = { -- Moonmont Lunar Altar
        itemPrice   = 15000,
        achievement = 537,
      },
      [119854] = { -- New Moons Tile
        itemPrice   = 5000,
        achievement = 602,
      },
      [119852] = { -- Waning Moons Tile
        itemPrice   = 5000,
        achievement = 602,
      },
      [119851] = { -- Waxing Moons Wall Tile
        itemPrice   = 5000,
        achievement = 602,
      },
    },
  },
  ["Craglorn, Belkarth Woodworking store"]            = {
    [GetString(FURC_AV_LOT)] = {
      [119933] = { -- Craglorn Brazier
        itemPrice   = 5000,
        achievement = 1663,
      },
      [119934] = { -- Craglorn Sconce
        itemPrice   = 5000,
        achievement = 1664,
      },
      [119931] = { -- Craglorn Tapestry
        itemPrice   = 35000,
        achievement = 936,
      },
      [119925] = { -- Nirncrux Bowl
        itemPrice   = 4000,
        achievement = 1665,
      },
      [119935] = { -- Observatory Banner
        itemPrice   = 25000,
        achievement = 909,
      },
      [119923] = { -- Serpent Stone
        itemPrice   = 5000,
        achievement = 992,
      },
      [119929] = { -- Snake Prayer Tile
        itemPrice   = 5000,
        achievement = 909,
      },
      [119930] = { -- Totem of the Serpent
        itemPrice   = 10000,
        achievement = 1143,
      },

    },
    [GetString(FURC_AV_KRR)] = {
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
  ["Coldharbour, Hollow City, Cicero's General Good"] = {

    [GetString(FURC_AV_LOT)] = {
      [119828] = { -- Ayleid Throne
        itemPrice   = 50000,
        achievement = 612,
      },
      [119830] = { -- Coldharbour Chandelier
        itemPrice   = 25000,
        achievement = 614,
      },
      [119831] = { -- Cowering Statue
        itemPrice   = 10000,
        achievement = 957,
      },
      [119832] = { -- Light of Meridia
        itemPrice   = 10000,
        achievement = 524,
      },
      [119833] = { -- Molag Bal Banner
        itemPrice   = 20000,
        achievement = 616,
      },
      [119829] = { -- Shackle Control Stone
        itemPrice   = 25000,
        achievement = 613,
      },
    },
    [GetString(FURC_AV_KRR)] = boxes,
  },
  ["Gold Coast, Kvatch"]                              = {
    [GetString(FURC_AV_ATH)] = {
      [119947] = { -- Banner of the Kvatch Guard
        itemPrice   = 15000,
        achievement = 1433,
      },
      [119697] = { -- Blade of Woe, Replica
        itemPrice   = 25000,
        achievement = 1435,
      },
      [119941] = { -- Brotherhood Poison Vial
        itemPrice   = 2500,
        achievement = 1440,
      },
      [119945] = { -- Dark Brotherhood Banner
        itemPrice   = 10000,
        achievement = 1442,
      },
      [119953] = { -- Dark Ledger
        itemPrice   = 50000,
        achievement = 1453,
      },
      [119937] = { -- Gold Coast Estate Keg
        itemPrice   = 500000,
        achievement = 1436,
      },
      [120950] = { -- Hanging Hourglass
        itemPrice   = 15000,
        achievement = 1443,
      },
      [119939] = { -- Hourglass Rug
        itemPrice   = 10000,
        achievement = 1438,
      },
      [119951] = { -- Litany of Blood
        itemPrice   = 25000,
        achievement = 1437,
      },
      [119944] = { -- Order of the Hour banner
        itemPrice   = 5000,
        achievement = 1441,
      },
      [119950] = { -- Preserved Sweetrolls
        itemPrice   = 500,
        achievement = 1458,
      },
      [119940] = { -- Sanctuary Sconce
        itemPrice   = 10000,
        achievement = 1439,
      },
      [119948] = { -- Statue of the Mother
        itemPrice   = 100000,
        achievement = 1444,
      },
    },
    [GetString(FURC_AV_FRO)] = structures,
  },
  ["Hew's Bane"]                                      = {
    [GetString(FURC_AV_LTS)] = {
      [119965] = { -- Abah's Landing Banner
        itemPrice   = 10000,
        achievement = 1366,
      },
      [119961] = { -- An Adoring Fan
        itemPrice   = 2500,
        achievement = 1363,
      },
      [119969] = { -- Banner of TAneth
        itemPrice   = 10000,
        achievement = 1378,
      },
      [119968] = { -- Distracting Harpy Egg
        itemPrice   = 1500,
        achievement = 1377,
      },
      [120989] = { -- Hanging Wedding Lantern
        itemPrice   = 3000,
        achievement = 1362,
      },
      [119974] = { -- Hiding Place
        itemPrice   = 1000,
        achievement = 1360,
      },
      [119974] = { -- Iron Wheel Banner
        itemPrice   = 15000,
        achievement = 1375,
      },
      [119960] = { -- Jar of Green Dye
        itemPrice   = 500,
        achievement = 1361,
      },
      [120990] = { -- Large Covered Well
        itemPrice   = 15000,
        achievement = 1375,
      },
      [120952] = { -- Opulent Dowry Chest
        itemPrice   = 50000,
        achievement = 1363,
      },
      [119955] = { -- Pale Garden Flowers
        itemPrice   = 500,
        achievement = 1370,
      },
      [119954] = { -- Reliquary Skull
        itemPrice   = 25000,
        achievement = 1371,
      },
      [119954] = { -- Statue of Shadows
        itemPrice   = 25000,
        achievement = 1401,
      },
      [119967] = { -- Vibrant Garden Flowers
        itemPrice   = 500,
        achievement = "That which was lost quest completion"
      },
      [119963] = { -- Yokudan Puzzle Column
        itemPrice   = 5000,
        achievement = 1361,
      },
    },
    ["Rohiza"] = structures,
  },
  ["Orsinium"]                                        = {

    [GetString(FURC_AV_LOT)] = {
      [119979] = { -- Fur Throne
        itemPrice   = 25000,
        achievement = 1245,
      },
      [119976] = { -- Orc Adventuring Backpack
        itemPrice   = 500,
        achievement = 1242,
      },
      [119978] = { -- Orcish Battle Totem
        itemPrice   = 7500,
        achievement = 1244,
      },
      [119980] = { -- Orcish Totem
        itemPrice   = 10000,
        achievement = 1328,
      },
      [119977] = { -- Orcish War Totem
        itemPrice   = 5000,
        achievement = 1243,
      },
      [119975] = { -- Orsinium Cart
        itemPrice   = 10000,
        achievement = 1241,
      },
      [119981] = { -- Throne of the Orc King
        itemPrice   = 50000,
        achievement = 1260,
      },
    },

    [GetString(FURC_AV_MAL)] = {
      [117955] = { -- Box, Slatted
        itemPrice = 100,
      },
      [117964] = { -- Rough Fire, doused
        itemPrice = 100,
      },
      [117985] = { -- Rough Bread, Morsel
        itemPrice = 100,
      },
      [117981] = { -- Rough Firewood, Smoldering
        itemPrice = 100,
      },
      [117976] = { -- Rough Hay Bed, Sloppy
        itemPrice = 100,
      },
      [117976] = { -- Rough Hay Bed, Covered
        itemPrice = 100,
      },
      [117974] = { -- Rough Hay Bed, Tidy
        itemPrice = 100,
      },
      [117986] = { -- Rough Plank, Long
        itemPrice = 100,
      },

    },

  },
  ["any city"]                                        = {
    [GetString(FURC_AV_ENC)] = {
      [120050] = { -- Enchanter's Sign
        itemPrice   = 5000,
        achievement = 1034,
      },
      [120051] = { -- Enchanting Gem
        itemPrice   = 5000,
        achievement = 1317,
      },
    },
    [GetString(FURC_AV_ALC)] = {
      [120044] = { -- Alchemy sign
        itemPrice   = 10000,
        achievement = 1031,
      },
      [120058] = { -- Harvester's Herbs
        itemPrice   = 1000,
        achievement = 68,
      },
      [120045] = { -- Poison Satchel
        itemPrice   = 5000,
        achievement = 1464,
      },
    },
    [GetString(FURC_AV_COO)] = {
      [120053] = { -- Chef's Cleaver
        itemPrice   = 2500,
        achievement = 1028,
      },
      [120052] = { -- Provisioner's Sign
        itemPrice   = 5000,
        achievement = 1035,
      },
    },
    [GetString(FURC_AV_CLO)] = {
      [120048] = { -- clothier's sign
        itemPrice   = 5000,
        achievement = 1033,
      },
      [120060] = { -- Harvester's Critter Trap
        itemPrice   = 5000,
        achievement = 68,
      },
      [120061] = { -- Harvester's Garden Shrub
        itemPrice   = 10000,
        achievement = 68,
      },
    },
    [GetString(FURC_AV_CAR)] = {
      [120057] = { -- Harvester's Woodpile
        itemPrice   = 1000,
        achievement = 68,
      },
      [120054] = { -- Woodworker's Sign
        itemPrice   = 5000,
        achievement = 1036,
      },
    },
    [GetString(FURC_AV_BSM)] = {

      [120046] = { -- Blacksmith's Sign
        itemPrice   = 5000,
        achievement = 1032,
      },
      [120059] = { -- Harvester's Ore
        itemPrice   = 1000,
        achievement = 68,
      },
      [120062] = { -- Smith's Bellow
        itemPrice   = 10000,
        achievement = 1022,
      },
    },
    [GetString(FURC_AV_OUT)] = {
      [120028] = { -- Death Marker
        itemPrice   = 5000,
        achievement = 1226,
      },
      [120033] = {          -- Decorative Safebox
        itemPrice   = 5000,
        achievement = 1200, -- Safebox Cracker
      },
      [120032] = {          -- Decorative Thieves Trove
        itemPrice   = 5000,
        achievement = "",   -- No Stash Left Behind
      },
      [120957] = {          -- Faded fence banner
        itemPrice   = 10000,
        achievement = "Ledgerdmain Rank 20",
      },
      [120027] = { -- Mass Tombstone
        itemPrice   = 10000,
        achievement = 1226,
      },
      [120026] = {          -- Mountain of Loot
        itemPrice   = 10000,
        achievement = "",   -- Black Market Mogul
      },
      [120029] = {          -- Noble Pocket Lint
        itemPrice   = 1000,
        achievement = 1192, -- Sneak Thief Extraordinaire
      },
      [120023] = {          -- Outlaw Banner
        itemPrice   = 5000,
        achievement = "Ledgerdmain Rank 20",
      },
      [120025] = {          -- Pile of Coins
        itemPrice   = 2500,
        achievement = 1196, -- Felonious Recompense
      },
      [120030] = {          -- Pocket Change
        itemPrice   = 500,
        achievement = 1191,
      },
      [120031] = {          -- Replica Key, Blank
        itemPrice   = 1000,
        achievement = 1208, -- Master Burglar
      },
      [120993] = {          -- Scales of Felonious Recompense
        itemPrice   = 5000,
        achievement = 1196, -- Felonious Recompense
      },
    },

  },
  ["the Mages' guild"]                                = {
    ["the Mystic as part of a collection"] = {},
    ["the Mystic"] = {
      [120003] = { -- cheese cutter
        itemPrice   = 5000,
        achievement = 1686,
      },
      [120011] = { -- Mages' Guild Banner
        itemPrice   = 10000,
        achievement = 702,
      },
    }

  },
  ["the Fighters' guild"]                             = {
    ["Hall Steward"] = {
      [120000] = { --Broken Chain
        itemPrice   = 50000,
        achievement = 587,
      },
      [119999] = { -- Daedric Chest
        itemPrice   = 10000,
        achievement = 1683,
      },
      [120948] = { -- Dark Anchor Pinion
        itemPrice   = 100000,
        achievement = 318,
      },
      [120019] = { -- Fighters' Guild Banner
        itemPrice   = 10000,
        achievement = 703,
      },
    },
  },
  ["the Undaunted Enclaves"]                          = {
    ["Undaunted Quartermaster"] = {
      [120036] = { -- Undaunted Banner
        itemPrice   = 15000,
        achievement = 1013,
      },
      [120035] = { -- Undaunted Chest
        itemPrice   = 5000,
        achievement = 1680,
      },
      [120034] = { -- Undaunted Mug
        itemPrice   = 1000,
        achievement = 704,
      },
    },
  },
}

function FurC.SetupHomesteadItems()
  local generatedTable, listTable

  FurC.AchievementVendors[FURC_HOMESTEAD]["the Mages' guild"]["the Mystic as part of a collection"] = bookList


  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Dhalmora, Bal Foyen"][GetString(FURC_AV_FRO)]
  addTable = FurC.MergeTable(furnishingVendor, morrowindStones)
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Mournhold Bank"][GetString(FURC_AV_FRO)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Stonefalls, Ebonheart"][GetString(FURC_AV_FRO)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Shadowfen, Alten Corimont"][GetString(FURC_AV_FRO)]
  addTable = furnishingVendor
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Riften, Market, Armorer"][GetString(FURC_AV_FRO)]
  addTable = furnishingVendor
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Bangkorai, Evermore"][GetString(FURC_AV_ROH)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Stormhaven, Wayrest, Merchant district"][GetString(FURC_AV_ROH)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Greenshade, Marbruk"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Malabal Tor, Vulkwaesten, tavern"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, addTable)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Reaper's March, Rawl'Kha, Market"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, structures)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Grahtwood, Redfur Trading Post"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, furnishingVendor)
  listTable = FurC.MergeTable(listTable, miscVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Craglorn, Belkarth Woodworking store"][GetString(FURC_AV_KRR)]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Coldharbour, Hollow City, Cicero's General Good"]
      [GetString(FURC_AV_KRR)]
  listTable = FurC.MergeTable(listTable, structures)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Gold Coast, Kvatch"][GetString(FURC_AV_FRO)]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Hew's Bane"]["Rohiza"]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Orsinium"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Glenumbra, Daggerfall, The Rosy Lion"]["Rohiza"]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Rivenspire, Shornhelm, Dead Wolf Inn"]["Rohiza"]
  listTable = FurC.MergeTable(listTable, furnishingVendor)

  listTable = FurC.AchievementVendors[FURC_HOMESTEAD]["Orsinium"][GetString(FURC_AV_MAL)]
  listTable = FurC.MergeTable(listTable, structures)
end
