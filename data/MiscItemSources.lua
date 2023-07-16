FurC.MiscItemSources = FurC.MiscItemSources or {}

-- constants save performance on string handling
local questRewardString = GetString(SI_FURC_QUESTREWARD)
local tribute = GetString(SI_FURC_TRIBUTE)
local tribute_ranked = GetString(SI_FURC_TRIBUTE_RANKED)

local pickpocket_ww = GetString(SI_FURC_CANBEPICKED) .. " from woodworkers"
local pickpocket_ass = GetString(SI_FURC_CANBEPICKED) .. " from outlaws and assassins"
local pickpocket_guard = GetString(SI_FURC_CANBEPICKED) .. " from guards"

local automaton_loot_cc = GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local automaton_loot_vv = GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"

local scambox_string = GetString(SI_FURC_SCAMBOX)
local scambox_newmoon = zo_strformat("<<1>> (<<2>>)", scambox_string, "New Moon")
local scambox_gloomspore = zo_strformat("<<1>> (<<2>>)", scambox_string, "Gloomspore")

local sinister_hollowjack = "Sinister Hollowjack Items"

local scambox_sovngarde = zo_strformat("<<1>> (<<2>>)", scambox_string, "Sovngarde")
local scambox_frosty = zo_strformat("<<1>> (<<2>>)", scambox_string, "Frost Atronach")
local scambox_wraith = zo_strformat("<<1>> (<<2>>)", scambox_string, "Wraithtide")
local scambox_sunken = zo_strformat("<<1>> (<<2>>)", scambox_string, "Sunken Trove")
local scambox_stonelore = zo_strformat("<<1>> (<<2>>)", scambox_string, "Stonelore")
local scambox_dark = zo_strformat("<<1>> (<<2>>)", scambox_string, "Dark Chivalry")

local itemPackMoonBishop = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Moon Bishop’s Sanctuary")
local itemPackOasis = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Moons-Blessed Oasis")
local itemPackVampire = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Vampiric Libations")
local itemPackHeart = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Heart's Day Retreat")
local itemPackCragKnicks = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Craglorn Multicultural Knick-Knacks")
local itemPackHubTreasure = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Hubalajad's Final Treasure")
local itemPackDibella = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Dibella's Garden")
local itemPackMermaid = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Steam Bath Serenity")
local itemPackZeni = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Chapel of Zenithar")
local itemPackWindows = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Windows of the Divines")
local itemPackAmbitions = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Daedric Ambitions")
local itemPackForge = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Forge-Lord's Great Works")
local itemPackCoven = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Witches' Coven")
local itemPackTyrants = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Tyrants of the Merethic Era")
local itemPackKhajiit = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Khajiiti Life")
local itemPackMalacath = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Malacath's Chosen")
local itemPackAlchemist = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Mad Alchemist")
local itemPackAzura = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Daedric Set of Azura")
local itemPackColdharbour = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Coldharbour Arcanaeum")
local itemPackFargrave = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Fargrave Bazaar")
local itemPackAquatic = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Aquatic Splendor")
local itemPackMaormer = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Maormer Boarding Party")

local elsewhere = " in S. Elsweyr"
local in_skyrim = " in Western Skyrim"
local in_blackwood = " in Blackwood"
local in_summerset = " in Summerset"
local in_elsweyr = " in Elsweyr"

local stealable = GetString(SI_FURC_CANBESTOLEN)
local fishing_elsewhere = GetString(SI_FURC_CANBEFISHED) .. elsewhere
local drop_elsewhere = GetString(SI_FURC_DROP) .. elsewhere
local stealable_elsewhere = GetString(SI_FURC_CANBESTOLEN) .. in_elsweyr
local chests_string = GetString(SI_FURC_CHESTS)
local chests_skyrim = chests_string .. in_skyrim
local chests_blackwood = chests_string .. in_blackwood
local scrying = GetString(SI_FURC_CANBESCRYED)
local chests_summerset = chests_string .. in_summerset
local chests_elsweyr = chests_string .. in_elsweyr
local mischouse = "From select house purchases"
local chests_high = chests_string .. " in High Isle"
local chests_blackr_grcaverns = chests_string .. " in Blackreach: Greymoor Caverns"

local book_hall = "From chests in the Scrivener's Hall vault"

local rumourSource = GetString(SI_FURC_RUMOUR_SOURCE_ITEM) -- has been datamined, but no clue where to get it
local itemsourceUnknown = GetString(SI_FURC_DATAMINED_UNCLEAR) -- is in-game (guildstore or TTC), but no clue where to get it

local elsweyr_event = GetString(SI_FURC_EVENT_ELSWEYR)
local priceUnknown = "?"

local blackwood_event = GetString(SI_FURC_EVENT_BLACKWOOD)

local crownstoresource = GetString(SI_FURC_CROWNSTORESOURCE)
local function getCrownPrice(price)
  local priceString = ((not price or price < 0) and priceUnknown) or tostring(price)
  return string.format("%s (%s)", crownstoresource, priceString)
end

local scamgemString = GetString(SI_FURC_SCAMBOX_GEMS)
local function getGemPrice(price)
  local priceString = ((not price or price < 0) and priceUnknown) or tostring(price)
  return string.format("%s (%s)", scamgemString, priceString)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2) -- use collectible number from https://wiki.esoui.com/Collectibles instead of houseIDs.
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then
    houseName = houseName .. ", " .. GetCollectibleName(houseId2)
  end
  return zo_strformat(housesource, houseName)
end

FurC.MiscItemSources[FURC_NECROM] = {

  [FURC_CROWN] = {},

  [FURC_DROP] = {},

  [FURC_RUMOUR] = {

    [197644] = rumourSource, -- Telvanni Spoon, Wooden",
    [197645] = rumourSource, -- Telvanni Fork, Wooden",
    [197646] = rumourSource, -- Telvanni Knife, Wooden",
    [197647] = rumourSource, -- Telvanni Knife, Bread",
    [118288] = rumourSource, -- Deer Carcass, Hanging",
    [197779] = rumourSource, -- Letter from Azandar",
    [197780] = rumourSource, -- Letter from Sharp",
    [197781] = rumourSource, -- The City of Necrom Painting, Wood",
    [197782] = rumourSource, -- Alleyway Still Life Painting",
    [197783] = rumourSource, -- Pilgrimage Triptych Painting, Wood",
    [197917] = rumourSource, -- Ode to Vaermina",
    [197918] = rumourSource, -- Deal with a Daedric Prince",
    [197919] = rumourSource, -- The Legend of Fathoms Drift",
    [197920] = rumourSource, -- The Doom of the Hushed",
    [197921] = rumourSource, -- Peryite's Salvation",
    [120485] = rumourSource, -- Cactus, Columnar",
    [116474] = rumourSource, -- Orcish Effigy, Bear",
    [197622] = rumourSource, -- Constellation Projection Apparatus",
    [193785] = rumourSource, -- Mercymother Elite Tribute Tapestry, Large",
    [152143] = rumourSource, -- Orcish Sconce, Scrolled",
    [115707] = rumourSource, -- Khajiit Tile, Waxing Moons",
    [193786] = rumourSource, -- Mercymother Elite Tribute Tapestry",
    [115705] = rumourSource, -- Khajiit Tile, New Moons",
    [193784] = rumourSource, -- Hand of Almalexia Tribute Tapestry",
    [193783] = rumourSource, -- Hand of Almalexia Tribute Tapestry, Large",
    [197750] = rumourSource, -- Telvanni Mushroom Spire Painting, Wood",
    [197621] = rumourSource, -- Household Shrine, Meridian",
    [197620] = rumourSource, -- Throne of the Lich",
    [197619] = rumourSource, -- Meridian Mote",
    [152144] = rumourSource, -- Orcish Mirror, Peaked",
    [197700] = rumourSource, -- Apocrypha Fossil, Bones Large",
    [197829] = rumourSource, -- Music Box, Glyphic Secrets",
    [197702] = rumourSource, -- Apocrypha Fossil, Worm",
    [197703] = rumourSource, -- Apocrypha Fossil, Arch",
    [197704] = rumourSource, -- Book of Whispers",
    [197705] = rumourSource, -- Telvanni Alchemy Station",
    [197706] = rumourSource, -- Trifold Mirror of Alternatives",
    [197707] = rumourSource, -- Apocryphal Well",
    [197708] = rumourSource, -- Cliffracer Skeleton Stand",
    [152141] = rumourSource, -- Orcish Brazier, Bordered",
    [152142] = rumourSource, -- Orcish Sconce, Bordered",
    [197711] = rumourSource, -- Antique Map of the Telvanni Peninsula",
    [197712] = rumourSource, -- Antique Map of Apocrypha",
    [152145] = rumourSource, -- Orcish Tapestry, War",
    [152146] = rumourSource, -- Orcish Chandelier, Spiked",
    [152148] = rumourSource, -- Orcish Tapestry, Hunt",
    [152149] = rumourSource, -- Orcish Brazier, Pillar",
    [116473] = rumourSource, -- Orcish Effigy, Mammoth",
    [197710] = rumourSource, -- Mushroom Classification Book",
    [190942] = rumourSource, -- Music Box, Sheogorath Butterfly Garden",
    [197623] = rumourSource, -- Statue, Hermaeus Mora",
    [197624] = rumourSource, -- Apocryphal Shifting Sculpture",
    [197625] = rumourSource, -- Music Box, Oath of the Keepers",
    [194534] = rumourSource, -- Dock Bell, Mounted",
    [197709] = rumourSource, -- Tribunal Window, Stained Glass",
    [194536] = rumourSource, -- Dock Buoys, Mounted",
    [194538] = rumourSource, -- Cargo Netting, Large",
    [194539] = rumourSource, -- Rough Hammock, Pole-Strung",
    [196204] = rumourSource, -- Blackwood Brazier, Cold-Flame",
    [196205] = rumourSource, -- Systres Brazier, Cold-Flame",
    [196206] = rumourSource, -- Daedric Post, Spike",
    [196207] = rumourSource, -- Daedric Turret, Flame Tower",
    [196208] = rumourSource, -- Sarcophagus, Stone Base",
    [196209] = rumourSource, -- Sarcophagus, Stone Lid",
    [196210] = rumourSource, -- Necrom Coffin",
    [196211] = rumourSource, -- Apocrypha Statue, Lurker",
    [196212] = rumourSource, -- Apocrypha Statue, Mouth of Mora",
    [196213] = rumourSource, -- Door, Dark Brotherhood Sanctuary",
    [196214] = rumourSource, -- Order of the Hour Rug, Winged",
    [197751] = rumourSource, -- Sunset Fleet Painting, Wood",
    [197752] = rumourSource, -- Mycoturge's Retreat Painting, Wood",
    [197753] = rumourSource, -- Telvanni Peninsula Painting, Wood",
    [115706] = rumourSource, -- Khajiit Tile, Full Moons",
    [197755] = rumourSource, -- Shadow over Necrom Painting",
    [115708] = rumourSource, -- Khajiit Tile, Waning Moons",
    [197701] = rumourSource, -- Apocrypha Fossil, Nautilus",
    [197749] = rumourSource, -- Necrom Still Life Painting, Wood",
    [197754] = rumourSource, -- Offerings to the Dead Painting, Wood",
  },
}

FurC.MiscItemSources[FURC_SCRIBE] = {

  [FURC_CROWN] = {},

  [FURC_DROP] = {

    [194456] = book_hall, -- Invocation of Hircine,
    [194460] = book_hall, -- Apocrypha, Apocrypha,
    [194459] = book_hall, -- Dream of a Thousand Dreamers,
    [194458] = book_hall, -- Lord Hollowjack's Dream Realm,
    [194455] = book_hall, -- Havocrel: Strangers from Oblivion,
    [194454] = book_hall, -- The Waters of Oblivion,
    [194453] = book_hall, -- A Memory Book, Part 1,
    [194452] = book_hall, -- A Memory Book, Part 2,
    [194451] = book_hall, -- A Memory Book, Part 3,
    [194449] = book_hall, -- In Dreams We Awaken,
    [194448] = book_hall, -- Glorious Upheaval,
    [194447] = book_hall, -- Stonefire Ritual Tome,
    [194446] = book_hall, -- Bisnensel: Our Ancient Roots,
    [194445] = book_hall, -- Boethiah and Her Avatars,
    [194444] = book_hall, -- Persistence of Daedric Veneration,
    [194443] = book_hall, -- Daedra Dossier: The Titans,
    [194419] = book_hall, -- Scrivener's Hall Vault Door,
    [194420] = book_hall, -- Nesting Stones, Green,
    [194421] = book_hall, -- Nesting Boulder, Green,
    [194422] = book_hall, -- Hermaeus Mora Banner, Extra Long,
    [194423] = book_hall, -- Hermaeus Mora Banner, Long,
    [194442] = book_hall, -- Journal of Culanwe,
    [194441] = book_hall, -- Graccus' Journal, Volume I,
    [194440] = book_hall, -- Tome of Daedric Portals,
    [194439] = book_hall, -- The Journal of Emperor Leovic,
    [194450] = book_hall, -- Thwarting the Daedra: Dagon's Cult,
  },

  [FURC_RUMOUR] = {

    [193793] = rumourSource, -- Reach Chandelier, Hagraven,
    [193794] = rumourSource, -- Target Hagraven, Robust,
    [193795] = rumourSource, -- Rite of the Harrowforged,
    [193796] = rumourSource, -- Orb of the Spirit Queen,
    [193797] = rumourSource, -- Wrothgar Puzzle Cube, Mountains,
    [193798] = rumourSource, -- Wrothgar Puzzle Cube, Hunter,
    [193799] = rumourSource, -- Falmer Hut, Long,
    [193800] = rumourSource, -- Falmer Tent, Conical,
    [193801] = rumourSource, -- Ayleid Partition, Arched,
    [193802] = rumourSource, -- Ayleid Constellation Stele, The Steed,
    [193803] = rumourSource, -- Tree, Large Pink Maple,
    [193804] = rumourSource, -- High Elf Wine Pot,
    [193805] = rumourSource, -- Yokudan Sarcophagus Base, Gilded,
    [193806] = rumourSource, -- Redguard Window, Iron Lattice,
    [193817] = rumourSource, -- Shad Astula Scholar, Left,
    [193818] = rumourSource, -- Shad Astula Scholar, Right,
    [194359] = rumourSource, -- Replica Jubilee Cake 2023,
    [190941] = rumourSource, -- Music Box, Direnni's Swan,
    [194399] = rumourSource, -- Music Box, Unfathomable Knowledge,
    [194400] = rumourSource, -- Galen Dogwood, Large,
    [194401] = rumourSource, -- Galen Dogwood, Medium Cluster,
    [194402] = rumourSource, -- Harbor Netting, Hanging Wall,
    [194403] = rumourSource, -- Harbor Netting, Buoy Cluster,
    [194404] = rumourSource, -- Harbor Line, Loose,
    [194405] = rumourSource, -- Harbor Line, Coiled,
    [194406] = rumourSource, -- Harbor Rope, Coiled Buoy,
    [194407] = rumourSource, -- Harbor Rope, Hanging,
    [194408] = rumourSource, -- Systres Brewing Still, Copper,
    [194409] = rumourSource, -- Potted Tree, Systres Pine,
    [194410] = rumourSource, -- Stonelore Tale Pillar, Slanted Stone,
    [193789] = rumourSource, -- Gonfalon Bay Dockside Bell,
    [193790] = rumourSource, -- Festering Coral, Crimson-Orange,
    [193791] = rumourSource, -- Palm, Blooming Tropical,
    [194411] = rumourSource, -- Stonelore Tale Pillar, Rounded Stone,
  },
}

FurC.MiscItemSources[FURC_DRUID] = {

  [FURC_CROWN] = {

    [190945] = getCrownPrice(5000), -- Tree, Seasons of Y'ffre

    [190946] = scambox_stonelore .. getGemPrice(40), -- Earthen Root Essence
    [190947] = scambox_stonelore .. getGemPrice(40), -- Druidic Arch, Floral
    [190950] = scambox_stonelore .. getGemPrice(40), -- Rose Petal Cascade
    [190951] = scambox_stonelore .. getGemPrice(100), -- Target Spriggan, Robust

    [192405] = itemPackMaormer, -- Maormer Tent, Raid Leader's
    [192406] = itemPackMaormer, -- Maormer Ship's Prow, Serpentine
    [192407] = getCrownPrice(720) .. " or " .. itemPackMaormer, -- Maormer Tent, Raider's
    [192408] = getCrownPrice(70) .. " or " .. itemPackMaormer, -- Maormer Trunk, Carved
    [192409] = getCrownPrice(3000) .. " or " .. itemPackMaormer, -- Maormer Cookfire
    [192410] = getCrownPrice(85) .. " or " .. itemPackMaormer, -- Maormer Chair, Carved
    [192412] = getCrownPrice(340) .. " or " .. itemPackMaormer, -- Maormer Curtain, Serpentine Cloth
    [192413] = getCrownPrice(180) .. " or " .. itemPackMaormer, -- Maormer Table, Carved
    [192414] = getCrownPrice(160) .. " or " .. itemPackMaormer, -- Maormer Armchair, Carved
    [192418] = getCrownPrice(10) .. " or " .. itemPackMaormer, -- Maormer Mug, Serpentine
    [192420] = getCrownPrice(180) .. " or " .. itemPackMaormer, -- Maormer Rug, Serpentine
    [192425] = getCrownPrice(150) .. " or " .. itemPackMaormer, -- Maormer Teapot, Serpentine
    [192427] = getCrownPrice(70) .. " or " .. itemPackMaormer, -- Maormer Lamp, Serpentine
    [192429] = getCrownPrice(110) .. " or " .. itemPackMaormer, -- Maormer Sconce, Serpentine
    [192422] = getCrownPrice(80) .. " or " .. itemPackMaormer, -- Maormer Half-Rug
    [192423] = getCrownPrice(340) .. " or " .. itemPackMaormer, -- Maormer Runner, Amethyst Waves
  },

  [FURC_DROP] = {
    [187922] = scrying .. " in Fargrave ", -- Antique Map of Fargrave",
    [192430] = scrying .. " in Galen ", -- Vulk'esh Egg",
    [192431] = scrying .. " in Galen ", -- Antique Map of Galen",
    [192432] = scrying .. " in Galen (3 Pieces)", -- Shipbuilder's Woodworking Station",
    [190938] = scrying .. " in Galen (5 Pieces)", -- Music Box, Blessings of Stone",

    [192401] = tribute, -- The Chimera Tribute Tapestry",
    [192402] = tribute, -- The Chimera Tribute Tapestry, Large",
    [192403] = tribute, -- Forest Wraith Tribute Tapestry",
    [192404] = tribute, -- Forest Wraith Tribute Tapestry, Large",
  },

  [FURC_RUMOUR] = {
    [192579] = rumourSource, -- Common Crate, Fabric Bolts",
    [192569] = rumourSource, -- Alchemy Shelves, Filled",
    [190939] = rumourSource, -- Music Box, Dawnbreaker's Forging",
    [190940] = rumourSource, -- Music Box, Songbird's Paradise",
  },
}

FurC.MiscItemSources[FURC_DEPTHS] = {

  [FURC_CROWN] = {
    [188341] = scambox_wraith .. " (100 gems)", -- Red Diamond Stained Glass,
    [188342] = scambox_wraith .. " (40 gems)", -- Bat Swarm, Domesticated,
    [188343] = scambox_wraith .. " (100 gems)", -- Moonlight Path Bridge,
    [188344] = scambox_wraith .. " (40 gems)", -- Y'ffre's Falling Leaves, Autumn,

    [189463] = getCrownPrice(3500), -- Statue, Bendu Olo,
    [189464] = getCrownPrice(1000), -- Music Box, Deeproot Dirge,
    [189465] = getCrownPrice(1200), -- Music Box, Gonfalon Galliard,
  },

  [FURC_DROP] = {
    [187804] = tribute_ranked, -- Tribute Trophy, Orichalcum,
    [187805] = tribute_ranked, -- Tribute Trophy, Ebony,
    [187806] = tribute_ranked, -- Tribute Trophy, Quicksilver,
    [187807] = tribute_ranked, -- Tribute Trophy, Voidsteel,
  },
}

FurC.MiscItemSources[FURC_BRETON] = {

  [FURC_CROWN] = {

    [187861] = getCrownPrice(110), -- High Isle Hourglass, Compass Rose
    [187665] = getCrownPrice(3500), -- Statue, Kynareth's Blessings
    [187860] = getCrownPrice(65), -- High Isle Vase, Gilded
    [187865] = getCrownPrice(55), -- Flowers, Butterweed Cluster
    [147926] = getCrownPrice(6000), -- Target Iron Atronach, Trial
    [187664] = getCrownPrice(6000), -- Target Deadlands Harvester, Trial

    [187666] = getCrownPrice(1000), -- Music Box, Steadfast Armistice
    [187667] = getCrownPrice(1200), -- Music Box, High Isle Duel

    [187661] = scambox_dark .. getGemPrice(40), -- Mage's Flame
    [187662] = scambox_dark .. getGemPrice(100), -- House Dufort Chandelier
    [187663] = scambox_dark .. getGemPrice(40), -- Blue Fang Shark, Mounted
    [187660] = scambox_dark .. getGemPrice(100), -- Mages Guild Stained Glass
  },

  [FURC_DROP] = {
    [187802] = scrying .. " in High Isle ", -- Druidic Provisioning Station
    [187800] = scrying .. " in High Isle ", -- Draoife Storystone
    [187801] = scrying .. " in High Isle ", -- Sea Elf Galleon Helm
    [187799] = scrying .. " in High Isle ", -- Antique Map of High Isle

    [187868] = chests_high, -- Ascendant Silence Painting, Metal
    [187869] = chests_high, -- Noble Still Life Painting, Metal
    [187870] = chests_high, -- Gifts of the Sun Painting, Metal
    [187871] = chests_high, -- High Isle Seahome Painting, Metal
    [187873] = chests_high, -- Abecean Bounty Painting, Wood
    [187874] = chests_high, -- Masted Behemoth Painting, Wood
    [187875] = chests_high, -- Tor Draioch Towers Painting, Wood
    [187876] = chests_high, -- Gonfalon Colossus Painting, Wood
    [187877] = chests_high, -- Gates of Gonfalon Bay Painting, Wood
    [187872] = chests_high, -- Light's Warning Painting, Wood

    [188272] = tribute, -- Blackfeather Knight Tribute Tapestry
    [188273] = tribute, -- Blackfeather Knight Tribute Tapestry, Large
    [188274] = tribute, -- Hagraven Matron Tribute Tapestry
    [188275] = tribute, -- Hagraven Matron Tribute Tapestry, Large
    [188276] = tribute, -- Hlaalu Councilor Tribute Tapestry
    [188277] = tribute, -- Hlaalu Councilor Tribute Tapestry, Large
    [188278] = tribute, -- Knight Commander Tribute Tapestry
    [188279] = tribute, -- Knight Commander Tribute Tapestry, Large
    [188280] = tribute, -- Prowling Shadow Tribute Tapestry
    [188281] = tribute, -- Prowling Shadow Tribute Tapestry, Large
    [188282] = tribute, -- Pyandonean War Fleet Tribute Tapestry
    [188283] = tribute, -- Pyandonean War Fleet Tribute Tapestry, Large
    [188284] = tribute, -- Serpentguard Rider Tribute Tapestry
    [188285] = tribute, -- Serpentguard Rider Tribute Tapestry, Large
    [187808] = tribute_ranked, -- Tribute Trophy, Rubedite

    [188201] = "Reward for completeing Ember's rapport quests", -- Letter From Ember
    [188202] = "Reward for completeing Isobel's rapport quests", -- Letter From Isobel
  },
}

FurC.MiscItemSources[FURC_TIDES] = {

  [FURC_CROWN] = {

    [184072] = scambox_sunken .. " (100 gems)", -- Aquarium, Large Abecean Coral,
    [184071] = scambox_sunken .. " (40 gems)", -- Aquarium, Abecean Coral,
    [184127] = scambox_sunken .. " (40 gems)", -- Tranquility Pond, Botanical,
    [184126] = scambox_sunken .. " (100 gems)", -- Waterfall Fountain, Round,

    [183200] = getCrownPrice(1100), -- Music Box: Wonders of the Shoals,
    [183201] = getCrownPrice(1000), -- Music Box: Bleak Beacon Shanty,

    [178477] = getCrownPrice(170), -- Nedic Bookcase, Filled,
    [183198] = "Fargrave homegoods vendor, or " .. getCrownPrice(10), -- Bushes, Withered Cluster,
    [184175] = getCrownPrice(3500), -- Statue, Ancestor-King Auri-El,
    [184242] = getCrownPrice(370), -- Nedic Brazier, Cold-Flame,
    [184243] = getCrownPrice(640), -- Nedic Brazier, Cold-Flame Pillar,
    [184244] = getCrownPrice(110), -- Nedic Sconce, Torch,
    [184245] = getCrownPrice(610), -- Nedic Chandelier, Swords,
    [184246] = getCrownPrice(130), -- Nedic Bench, Carved,
    [184250] = getCrownPrice(240), -- Nedic Banner, Ancient,
    [120853] = "This is craftable, or " .. getCrownPrice(430), -- Stockade,

    --Crown Furnishing Packs--
    [184107] = getCrownPrice(20) .. " or " .. itemPackAquatic, -- Kelp Stalk, Tall,
    [184108] = getCrownPrice(90) .. " or " .. itemPackAquatic, -- Kelp Grouping, Thin,
    [184110] = getCrownPrice(170) .. " or " .. itemPackAquatic, -- Verdant Anemone, Strong,
    [184111] = getCrownPrice(170) .. " or " .. itemPackAquatic, -- Lilac Anemone, Sprout,
    [183891] = itemPackAquatic, -- Jellyfish Bloom, Heliotrope,
    [183892] = getCrownPrice(430) .. " or " .. itemPackAquatic, -- Minnow School,
    [183893] = getCrownPrice(1500) .. " or " .. itemPackAquatic, -- Bubbles of Aeration,
    [183894] = itemPackAquatic, -- Nedic Chest, Bubbling,
    [184109] = getCrownPrice(90) .. " or " .. itemPackAquatic, -- Kelp Grouping, Robust,
    [184112] = getCrownPrice(170) .. " or " .. itemPackAquatic, -- Lilac Coral, Strong,
    [184205] = getCrownPrice(120) .. " or " .. itemPackAquatic, -- Sand Drift, Oceanic,
    [184106] = getCrownPrice(20) .. " or " .. itemPackAquatic, -- Kelp Stalk, Plain,
    [184105] = getCrownPrice(45) .. " or " .. itemPackAquatic, -- Green Algae Coral Formation, Tree Capped,
    [184104] = getCrownPrice(45) .. " or " .. itemPackAquatic, -- Red Algae Coral Formation, Waving Hands,
    [184103] = getCrownPrice(45) .. " or " .. itemPackAquatic, -- Red Algae Coral Formation, Tree Antler,
    [183856] = itemPackAquatic, -- Target Mudcrab, Robust Coral,
    [184247] = getCrownPrice(45) .. " or " .. itemPackAquatic, -- Brittle-Vein Coral, Cluster,
    [184248] = getCrownPrice(20) .. " or " .. itemPackAquatic, -- Stones, Coral Cluster,
    [184249] = getCrownPrice(20) .. " or " .. itemPackAquatic, -- Elkhorn Coral, Branching,
  },
}

FurC.MiscItemSources[FURC_DEADL] = {

  --[[ ============== To do: =======================

	Furnishing packs!
		Limited Time -
			Lord vivec
			intrepid gourmet
			moons bless oasis
			moon bishop's sanctuary
			clockwork god's domain
			stone and shadow
			dwarven pipes?
			island hideaway parlor

		Always in crown store -
			Summerset Noble's Bathing
			Summerset Noble's Parlor
			Formal Garden Shrubbery
			Tamrielic Household Necessities
			Trees of Tamriel Garden
			Craglorn Multicultural Bedroom
			Home in Nibenay Bedroom
			Summerset Noble's Bedroom
			Crag Multicultural Kitchen
			Niben Valley Kitchen
			Summerset Noble's Kitchen
			Craglorn Multicultural Parlor
			Cyrodilic Parlor


	 Crown crate/gem furnishings!
		Frost Atronach
		Grimm Harlequin
		Celestial
		Ayleid
		Sovngarde

	 Remove rumoursource items that have been given a source. No need for them to be listed multiple times.

	 Can I add a separate crown source for housing editor vs normal crown store? Seems like it should be fairly easy. Model after SI_FURC_CROWNSTORESOURCE and getCrownPrice

	 Add seals of endeavor prices with the gem prices for crate items (can I add a constant for pricing? ie: getGemPrice(40) would output "40 Gems or 2000 Endeavors"

	 Learn how to add housing sources (I see it there, just need to play with it)

	 Sort things into their proper versions! I've been adding most things to the top of the most recent version, but sorting needs to happen!
	]]

  [FURC_DROP] = {
    [178694] = blackwood_event, -- Target Ogrim,
    [166960] = "From combining Stone Husk Fragments from the Labyrinthian in Western Skyrim", -- Target Stone Husk,

    [156644] = scambox_frosty .. " (40 gems)", -- Books, Towering Pile

    [182302] = scrying .. " in the Deadlands (3 pieces)", -- Daedric Enchanting Station,
    [175728] = scrying .. " in Blackwood", -- Z'en Idol,
    [175729] = scrying .. " in Blackwood", -- Kothringi Tidal Canoe,
    [178459] = scrying .. " in Blackwood", -- Antique Map of Blackwood,
    [183196] = scrying .. " in the Deadlands", -- Antique Map of the Deadlands,
    [171431] = scrying .. " in the Reach", -- Antique Map of the Reach,
    [165992] = scrying .. " in Western Skyrim", -- Antique Map of Western Skyrim
    [163431] = scrying .. " (3 pieces)", -- Music Box, Aldmeri Symphonia "in dreams and memories"
    [182303] = scrying .. " in the Deadlands", -- Dagon's Scalding Gibbet,
    [165863] = scrying .. " in Grahtwood", -- St. Alessia, Paravant

    [178442] = chests_blackwood, -- Idylls of Gideon Painting, Wood,
    [178443] = chests_blackwood, -- Path of Eternity Painting, Wood,
    [178444] = chests_blackwood, -- A Study in Structure Painting, Wood,
    [178445] = chests_blackwood, -- Leyawiin at Night Painting, Wood,
    [178446] = chests_blackwood, -- Fire-Shaped Shadows Painting, Silver,
    [178447] = chests_blackwood, -- Music in Repose Painting, Silver,
    [178448] = chests_blackwood, -- Undying Light Painting, Silver,
    [178449] = chests_blackwood, -- The Legacy of Kaladas Painting, Wood,
    [178450] = chests_blackwood, -- Harvest's Gifts Painting, Wood,
    [178451] = chests_blackwood, -- Reverence's Mandate Painting, Wood,
    [139076] = chests_summerset, -- Painting of Ancient Road, Refined
    [165829] = chests_elsweyr, -- Before the Trade Gathering Painting, Wood
    [165830] = chests_elsweyr, -- Elsweyr Vista Painting, Wood
    [165831] = chests_elsweyr, -- Catnap Painting, Gold
    [165832] = chests_elsweyr, -- Elsweyr Landscape Painting, Gold
    [165833] = chests_elsweyr, -- Elsweyr Dome Architecture Painting, Gold
    [165835] = chests_elsweyr, -- Painting of Khajiiti Arch, Gold,
    [139075] = chests_summerset, -- Painting of Sinkhole, Refined

    [94100] = "Can be gained as a level up reward or Crown Store (50)", -- Imperial BookCase, Swirled
    [145595] = "From sneaking up on Scuttleblooms in Murkmire", -- Scuttlebloom
    [147644] = "Frostvault rare drop", -- Palisade, Crude,
    [147642] = "Frostvault rare drop", -- Boar Totem, Balance,
    [147643] = "Frostvault rare drop", -- Boar Totem, Solitary,
    [163432] = "Reward for 'An Instrumental Triumph' achievement from the Bard's College in Solitude, Western Skyrim", -- Music Box, Merry Mead Maker
    [166027] = "Drops from chaurus mobs in Blackreach", -- Chaurus Egg, Dormant

    [134403] = "Can be stolen, mostly from wardrobes in Hew's Bane", --Spool, Red Thread,

    [178472] = "Given to members of the Dauntless Bananas Guild as part of a 2020 contest", -- Guild Banner, Dauntless Bananas,
    [178498] = "Given to members of the Dauntless Bananas Guild as part of a 2020 contest", -- A Tale of the Dauntless Bananas,
  },

  [FURC_CROWN] = {

    [171857] = getCrownPrice(3000), -- Aetherial Well,

    -- ==================== Crown Housing Editor ==============================
    [182915] = getCrownPrice(260), -- Fargrave Container Plants, Long,
    [182916] = getCrownPrice(260), -- Fargrave Container Plant, Large Square,
    [182917] = getCrownPrice(260), -- Fargrave Container Plants, Large Round,
    [182914] = getCrownPrice(140), -- Fargrave Container Plants,
    [182913] = getCrownPrice(140), -- Fargrave Container Plants, Small,
    [141832] = getCrownPrice(70), -- Tree, Robust Fig,
    [141833] = getCrownPrice(150), -- Tree, Ancient Fig,
    [141834] = getCrownPrice(170), -- Tree, Towering Fig,
    [141835] = getCrownPrice(70), -- Tree, Whorled Fig,
    [181532] = getCrownPrice(3600), -- Leyawiin Fountain, Round Grand,
    [182281] = getCrownPrice(2300), -- Fargrave Fountain,
    [118148] = getCrownPrice(80) .. " or " .. mischouse, --Firelogs, Ashen,
    [118146] = getCrownPrice(80) .. " or " .. mischouse, --Firelogs, Flaming,
    [118147] = getCrownPrice(80) .. " or " .. mischouse, --Firelogs, Charred,
    [167294] = getCrownPrice(20) .. " or " .. mischouse, -- Boulder, Jagged Stone,
    [118350] = getCrownPrice(25), --Box of Tangerines,
    [118352] = getCrownPrice(25), --Box of Oranges,
    [118353] = getCrownPrice(25), --Box of Grapes,
    [118354] = getCrownPrice(25), --Box of Fruit,
    [134278] = getCrownPrice(3500), --Clockwork Alchemy Station,
    [134279] = getCrownPrice(3500), --Clockwork Blacksmithing Station,
    [134282] = getCrownPrice(3500), --Clockwork Woodworking Station,
    [134281] = getCrownPrice(3500), --Clockwork Clothing Station,
    [134277] = getCrownPrice(3000), --Clockwork Provisioning Station,
    [134276] = getCrownPrice(4500), --Clockwork Dye Station,
    [134280] = getCrownPrice(3500), --Clockwork Enchanting Station,
    [139064] = getCrownPrice(20) .. " or " .. mischouse, -- Flowers, Hummingbird Mint
    [118175] = getCrownPrice(170), --Shutters, Hinged Lattice,
    [118174] = getCrownPrice(170), --Shutters, Blue Lattice,
    [118173] = getCrownPrice(170), --Shutters, Blue Hinged,
    [118172] = getCrownPrice(170), --Shutters, Blue Slatted,
    [118171] = getCrownPrice(170), --Shutters, Blue Hatch,
    [118170] = getCrownPrice(170), --Shutters, Blue Double,
    [118169] = getCrownPrice(170), --Shutters, Blue Single,
    [141845] = getCrownPrice(370), -- Mushrooms, Climbing Ambershine
    [141846] = getCrownPrice(370), -- Mushrooms, Ambershine Cluster
    [141844] = getCrownPrice(70), -- Plants, Amber Spadeleaf Cluster
    [182918] = getCrownPrice(160), -- Boulder, Weathered Fargrave,
    [182919] = getCrownPrice(160), -- Rocks, Fargrave Cluster,
    [141841] = getCrownPrice(40), -- Tree Ferns, Cluster,
    [141842] = getCrownPrice(10), -- Tree Ferns, Juvenile Cluster,
    [171817] = getCrownPrice(730) .. " or " .. mischouse, -- Ayleid Chandelier, Caged,
    [181602] = getCrownPrice(30), -- Bush, Low Greenleaf Cluster,
    [181604] = getCrownPrice(30), -- Bush, Snow Lillies,
    [182935] = getCrownPrice(140), -- Stump, Charred Deadlands,
    [182934] = getCrownPrice(140), -- Log, Charred Deadlands,
    [182933] = getCrownPrice(260), -- Tree, Charred Large Deadlands,
    [182932] = getCrownPrice(260), -- Tree, Charred Large Twisted Deadlands,
    [182931] = getCrownPrice(140), -- Tree, Charred Deadlands,
    [182930] = getCrownPrice(110), -- Plant, Pixas,
    [182929] = getCrownPrice(110), -- Plant, Hynvik,
    [125581] = getCrownPrice(25), -- Mushroom, Buttercake,

    --======================= Limited Time Crown Store Items ==========================
    [156645] = getCrownPrice(4000), -- Statue, Kaalgrontiid's Ascent
    [159439] = getCrownPrice(3500), -- Statue, Pride of Alkosh Hero
    [147646] = getCrownPrice(3000), -- Meridia, Lady of Infinite Energies,
    [165991] = getCrownPrice(3500), -- Statue, Vampiric Sovereign
    [147747] = getCrownPrice(2500), -- Cadwell's Astounding Portal
    [147746] = getCrownPrice(1400), -- Bust: Abnur Tharn

    --======================= Music Boxes ===========================================
    [156554] = getCrownPrice(800), -- Music Box, A Frost Melt Melody
    [171943] = getCrownPrice(1000), -- Music Box, The Liberation of Leyawiin,
    [142235] = getCrownPrice(800), -- Music Box, Flickering Shadows
    [171543] = getCrownPrice(1000), -- Music Box, Feast of All Flames,
    [171944] = getCrownPrice(1000), -- Music Box, The Mirefrog's Hymn,
    [171542] = getCrownPrice(800), -- Music Box, Farewell to Nenalata,
    [167428] = getCrownPrice(1000), -- Music Box, Mother Morrowind's Sacred Lullaby,
    [167429] = getCrownPrice(1000), -- Music Box, Never Fall, Never Die,
    [167007] = getCrownPrice(1000), -- Music Box, Subterranean Sonata,
    [167006] = getCrownPrice(1000), -- Music Box, Hymn of Five-Hundred Axes,
    [153634] = getCrownPrice(800), -- Music Box, Diamond Melody
    [163428] = getCrownPrice(800), -- Music Box, The Shadows Stir
    [163429] = getCrownPrice(1000), -- Music Box, Enigmas of the Elder Way
    [156553] = getCrownPrice(800), -- Music Box, That Breezy Night in Bruma
    [159596] = getCrownPrice(800), -- Music Box, The Mad Harlequin's Reverie
    [159598] = getCrownPrice(800), -- Music Box, Dreams of Yokuda
    [151909] = getCrownPrice(800), -- Music Box, A Clash of Fang and Flame
    [151910] = getCrownPrice(800), -- Music Box, Dancing Among the Flowers Fine
    [147507] = getCrownPrice(800), -- Music Box, Hinterlands
    [147505] = getCrownPrice(800), -- Music Box, Y'ffre in Every Leaf
    [147506] = getCrownPrice(800), -- Music Box, Sands of the Alik'r
    [178522] = getCrownPrice(800), -- Music Box, Silver Rose
    [181636] = getCrownPrice(1000), -- Music Box, \"Fargrave Daydreams\",
    [181637] = getCrownPrice(1200), -- Music Box, \"Time's Architect\",
    [153633] = getCrownPrice(800), -- Music Box, The Ghosts of Frostfall
    [178521] = getCrownPrice(1000), -- Music Box, \"Invitation to Chaos\",

    -- ====================== Crown Furnishing Packs =============================
    [156775] = itemPackHeart, -- Bed, Petal-Strewn Double
    [156764] = getCrownPrice(85) .. " or " .. itemPackHeart, -- Bouquet, Small Dibella's
    [156776] = getCrownPrice(85) .. " or " .. itemPackHeart, -- Bouquet, Large Dibella's
    [156777] = getCrownPrice(85) .. " or " .. itemPackHeart, -- Bouquet, Medium Dibella's
    [156765] = getCrownPrice(290) .. " or " .. itemPackHeart, -- Chair, Love-Blessed
    [156766] = getCrownPrice(180) .. " or " .. itemPackHeart, -- Petals, Blanket
    [156767] = itemPackHeart, -- Sweetroll Platter
    [156768] = getCrownPrice(100) .. " or " .. itemPackHeart, -- Love's Flame Candlestick
    [156769] = getCrownPrice(500) .. " or " .. itemPackHeart, -- Kitten Moppet, Heart's Promise
    [156770] = getCrownPrice(500) .. " or " .. itemPackHeart, -- Kitten Moppet, Love-Blessed
    [156771] = getCrownPrice(410) .. " or " .. itemPackHeart, -- Table, Love-Blessed
    [156772] = getCrownPrice(340) .. " or " .. itemPackHeart, -- Petals, Large Blanket
    [156773] = getCrownPrice(180) .. " or " .. itemPackHeart, -- Rug, Love-Blessed
    [156774] = getCrownPrice(180) .. " or " .. itemPackHeart, -- Tapestry, Love-Blessed
    [156778] = getCrownPrice(85) .. " or " .. itemPackHeart, -- Flower, Dibella's Promise
    [134971] = getCrownPrice(100) .. " or " .. itemPackHeart, -- Candles, Votive Group

    [134879] = itemPackHubTreasure, -- Hubalajad's Reflection
    [134880] = itemPackHubTreasure, -- Ra Gada Reliquary, Miniature Palace,
    [134881] = itemPackHubTreasure, -- In Defense of Prince Hubalajad,
    [134882] = getCrownPrice(90) .. " or " .. itemPackHubTreasure, -- Gold Drakes, Pristine,
    [134883] = getCrownPrice(360) .. " or " .. itemPackHubTreasure, -- Ra Gada Funerary Statue, Stone Cat,
    [134884] = getCrownPrice(360) .. " or " .. itemPackHubTreasure, -- Ra Gada Funerary Statue, Gilded Cat,
    [134885] = getCrownPrice(360) .. " or " .. itemPackHubTreasure, -- Ra Gada Funerary Statue, Gilded Ibis,
    [134886] = getCrownPrice(360) .. " or " .. itemPackHubTreasure, -- Ra Gada Funerary Statue, Gilded Servant,
    [134887] = getCrownPrice(2000) .. " or " .. itemPackHubTreasure, -- Ra Gada Guardian Statue, Lion Ibis,
    [134888] = getCrownPrice(2000) .. " or " .. itemPackHubTreasure, -- Ra Gada Guardian Statue, Winged Bull,
    [134889] = getCrownPrice(2000) .. " or " .. itemPackHubTreasure, -- Ra Gada Guardian Statue, Riding Camel,
    [117901] = getCrownPrice(140) .. " or " .. itemPackHubTreasure, --Redguard Amphora, Gilded,
    [117894] = getCrownPrice(240) .. " or " .. itemPackHubTreasure, --Redguard Divider, Gilded,
    [117904] = getCrownPrice(190) .. " or " .. itemPackHubTreasure, --Redguard Trunk, Garish,
    [134823] = itemPackHubTreasure, -- Target Mournful Aegis,

    [117906] = elsweyr_event .. (" or " .. itemPackCragKnicks), -- Redguard Urn, Gilded
    [121053] = getCrownPrice(170) .. " or " .. itemPackCragKnicks .. " or " .. itemPackHubTreasure, -- Jar, Gilded Canopic
    [121046] = itemPackCragKnicks, -- Cheeses of Tamriel,
    [121049] = itemPackCragKnicks, -- Parcels, Wrapped,
    [120417] = itemPackCragKnicks, -- Redguard Barrel, Corded
    [118490] = itemPackCragKnicks, --Scroll, Rolled,

    [134890] = itemPackDibella, -- Dibella, Lady of Love,
    [134848] = getCrownPrice(1500) .. " or " .. itemPackDibella .. " or " .. itemPackOasis, -- Blue Butterfly Flock
    [134961] = itemPackDibella, -- Dibella's Mysteries and Revelations,
    [134899] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Flower Spray, Crimson Daisies,
    [134901] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Flower Spray, Starlight Daisies,
    [134896] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Flower, Lover's Lily
    [134898] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Flowers, Midnight Sage,
    [134900] = getCrownPrice(20) .. " or " .. itemPackDibella, -- Flowers, Red Poppy,
    [134902] = getCrownPrice(20) .. " or " .. itemPackDibella, -- Flowers, Violet Bellflower,
    [134903] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Flowers, Midnight Glory,
    [94163] = getCrownPrice(290) .. " or " .. itemPackDibella, --Imperial Bench, Scrollwork
    [134849] = getCrownPrice(1500) .. " or " .. itemPackDibella .. " or " .. itemPackOasis, -- Monarch Butterfly Flock
    [134891] = getCrownPrice(2500) .. " or " .. itemPackDibella, -- Pergola, Festive Flowers
    [134895] = getCrownPrice(1800) .. " or " .. itemPackDibella, -- Redguard Fountain, Mosaic
    [134904] = getCrownPrice(260) .. " or " .. itemPackDibella, -- Seal of Dibella
    [134905] = getCrownPrice(260) .. " or " .. itemPackDibella, -- Ritual Stone, Dibella
    [134906] = getCrownPrice(240) .. " or " .. itemPackDibella, -- Ritual Brazier, Gilded
    [134892] = getCrownPrice(85) .. " or " .. itemPackDibella, -- Tree, Pale Gold
    [134893] = getCrownPrice(85) .. " or " .. itemPackDibella, -- Tree, Argent Blue
    [134894] = getCrownPrice(20) .. " or " .. itemPackDibella, -- Wildflowers, Yellow and Orange
    [134897] = getCrownPrice(45) .. " or " .. itemPackDibella, -- Vine Curtain, Festive Flowers

    [181547] = getCrownPrice(1000) .. " or " .. itemPackMermaid, -- Leyawiin Fountain, Corner,
    [181486] = getCrownPrice(2700) .. " or " .. itemPackMermaid, -- Leyawiin Fountain, Round,
    [181599] = getCrownPrice(1100) .. " or " .. itemPackMermaid, -- Leyawiin Fountain, Tall,
    [181485] = itemPackMermaid, -- Statue, Mermaid of Anvil,
    [181435] = getCrownPrice(1500) .. " or " .. itemPackMermaid, -- Steam of Repose,

    [175695] = getCrownPrice(510) .. " or " .. itemPackZeni, -- Leyawiin Shrine of the Eight,
    [175696] = getCrownPrice(410) .. " or " .. itemPackZeni, -- Leyawiin Tapestry, Divines Horizontal,
    [175697] = getCrownPrice(410) .. " or " .. itemPackZeni, -- Leyawiin Tapestry, Divines Vertical,
    [175698] = itemPackZeni, -- Zenithar, God of Work and Commerce,
    [175699] = itemPackZeni .. " or " .. itemPackWindows, -- Stained Glass of Zenithar,

    [181483] = itemPackWindows, -- Stained Glass of Akatosh,
    [181484] = itemPackWindows, -- Stained Glass of Julianos,
    [181482] = itemPackWindows, -- Stained Glass of Arkay,
    [181481] = itemPackWindows, -- Stained Glass of Dibella,
    [181480] = itemPackWindows, -- Stained Glass of Stendarr,
    [181479] = itemPackWindows, -- Stained Glass of Mara,
    [181478] = itemPackWindows, -- Stained Glass of Kynareth,

    [182292] = getCrownPrice(260) .. " or " .. itemPackAmbitions, -- Deadlands Base, Tower,
    [182291] = getCrownPrice(1500) .. " or " .. itemPackAmbitions, -- Deadlands Window, Fireglass,
    [182290] = getCrownPrice(140) .. " or " .. itemPackAmbitions, -- Deadlands Grate, Large,
    [182289] = getCrownPrice(140) .. " or " .. itemPackAmbitions, -- Deadlands Wall, Etched,
    [182295] = getCrownPrice(510) .. " or " .. itemPackAmbitions, -- Deadlands Firepit, Large,
    [182294] = getCrownPrice(770) .. " or " .. itemPackAmbitions, -- Deadlands Platform, Tower,
    [182293] = getCrownPrice(260) .. " or " .. itemPackAmbitions, -- Deadlands Stairway, Tower,
    [182912] = getCrownPrice(270) .. " or " .. itemPackAmbitions, -- Deadlands Pillar, Tall,

    [147585] = getCrownPrice(40) .. " or " .. itemPackForge, -- Dwarven Gear, Large Spokes,
    [147586] = getCrownPrice(50) .. " or " .. itemPackForge, -- Dwarven Hub, Sentry Wheel,
    [147587] = getCrownPrice(40) .. " or " .. itemPackForge, -- Dwarven Gear, Large Open,
    [147588] = getCrownPrice(220) .. " or " .. itemPackForge, -- Dwarven Conduit, Rounded,
    [147589] = getCrownPrice(150) .. " or " .. itemPackForge, -- Dwarven Brazier, Open,
    [147590] = itemPackForge, -- Dwarven Bust, Forge-Lord,
    [147664] = getCrownPrice(270) .. " or " .. itemPackForge, -- Dwarven Dais, Conduit,
    [147574] = itemPackForge, -- Dwarven Frieze, Wrathstone,
    [147575] = itemPackForge, -- Dwarven Frieze, Power in Twain,
    [147576] = itemPackForge, -- Dwarven Frieze, Colossal Power,
    [147577] = getCrownPrice(920) .. " or " .. itemPackForge, -- Dwarven Platform, Fan,
    [147578] = getCrownPrice(1400) .. " or " .. itemPackForge, -- Dwarven Throne, Conduit,
    [147579] = getCrownPrice(240) .. " or " .. itemPackForge, -- Dwarven Gearwork, Perpetual,
    [147580] = getCrownPrice(310) .. " or " .. itemPackForge, -- Dwarven Lamps, Heavy,
    [147581] = getCrownPrice(350) .. " or " .. itemPackForge, -- Dwarven Table, Heavy Workbench,
    [147582] = getCrownPrice(50) .. " or " .. itemPackForge, -- Dwarven Part, Sentry Head,
    [147583] = getCrownPrice(220) .. " or " .. itemPackForge, -- Dwarven Valve, Sealed,
    [147584] = getCrownPrice(160) .. " or " .. itemPackForge, -- Dwarven Rack, Spider Legs,

    [130226] = getCrownPrice(85) .. " or " .. itemPackCoven, -- Carcass, Hanging Deer
    [131424] = itemPackCoven, -- Fogs of the Hag Fen,
    [130220] = getCrownPrice(3300) .. " or " .. itemPackCoven, -- Hagraven Altar,
    [130222] = getCrownPrice(260) .. " or " .. itemPackCoven, -- Hagraven Totem, Skull
    [131423] = getCrownPrice(750) .. " or " .. itemPackCoven, -- Mists of the Hag Fen
    [130221] = getCrownPrice(430) .. " or " .. itemPackCoven, -- Reachmen Cage, Sturdy
    [130216] = getCrownPrice(510) .. " or " .. itemPackCoven, -- Witches' Basin, Scrying
    [130219] = getCrownPrice(240) .. " or " .. itemPackCoven, -- Witches' Brazier, Beast Skull
    [130223] = getCrownPrice(340) .. " or " .. itemPackCoven, -- Reachmen Rug, Mottled Skin
    [130224] = getCrownPrice(180) .. " or " .. itemPackCoven, -- Reachmen Rug, Smooth Skin
    [130225] = getCrownPrice(340) .. " or " .. itemPackCoven, -- Skulls, Heap
    [130227] = getCrownPrice(850) .. " or " .. itemPackCoven, -- Witches' Tent, Lean-To
    [130229] = getCrownPrice(290) .. " or " .. itemPackCoven, -- Tree, Wretched Cypress
    [130230] = getCrownPrice(90) .. " or " .. itemPackCoven, -- Stump, Wretched Cypress
    [130247] = getCrownPrice(290) .. " or " .. itemPackCoven, -- Tree, Fetid Cypress
    [130228] = itemPackCoven, -- The Witches of Hag Fen,
    [130215] = itemPackCoven, -- Witches' Cauldron, Provisioning,
    [130334] = getCrownPrice(260) .. " or " .. itemPackCoven, -- Witches Totem, Antler Charms,

    [134870] = itemPackTyrants, -- Ancient Nord Chest, Dragon Crest,
    [134871] = itemPackTyrants, -- Ancient Nord Urn, Dragon Crest,
    [134873] = itemPackTyrants, -- Ancient Nord Bookshelf, Wide,
    [134874] = itemPackTyrants, -- Ancient Nord Bookshelf, Narrow,
    [134875] = itemPackTyrants, -- Ancient Nord Funerary Jar, Linked Rings,
    [134876] = itemPackTyrants, -- Ancient Nord Funerary Jar, Crimson Sash,
    [134877] = itemPackTyrants, -- Ancient Nord Funerary Jar, Dragon Figure,
    [134878] = itemPackTyrants, -- Ancient Nord Funerary Jar, Dragon Crest,
    [134872] = itemPackTyrants, -- Ancient Nord Brazier, Dragon Crest
    [134863] = itemPackTyrants, -- Ancient Nord Sconce, Dragon Crest
    [134862] = itemPackTyrants, -- Ancient Nord Runestone, Memorial,
    [134856] = itemPackTyrants, -- Dragon Skeleton, Mid-Flight,
    [134857] = itemPackTyrants, -- Dragon Priest Frieze: Triumph,
    [134858] = itemPackTyrants, -- Dragon Priest Frieze: Exodus,
    [134859] = itemPackTyrants, -- Dragon Priest Frieze: Restoration,
    [134860] = itemPackTyrants, -- Dragon Priest Frieze: Ascension,
    [134861] = itemPackTyrants, -- The History of Zaan The Scalecaller,
    [134864] = itemPackTyrants, -- Dragon Cranium, Ancient,
    [134865] = itemPackTyrants, -- Unidentified Bones, Gargantuan,
    [134866] = itemPackTyrants, -- Lamia Cranium, Ancient,
    [134867] = itemPackTyrants, -- Argonian Skull, Complete,
    [134868] = itemPackTyrants, -- Khajiit Skull, Complete,
    [134869] = itemPackTyrants, -- Orc Skull, Complete,

    [151901] = getCrownPrice(20) .. " or " .. itemPackKhajiit, -- Elsweyr Bowl, Moon-Sugar,
    [153660] = getCrownPrice(560) .. " or " .. itemPackKhajiit, -- Elsweyr Cart, Moons-Blessed
    [153669] = getCrownPrice(300) .. " or " .. itemPackKhajiit, -- Elsweyr Well, Simple Arched
    [153658] = getCrownPrice(70) .. " or " .. itemPackKhajiit, -- Moon-Sugar, Row
    [153659] = getCrownPrice(30) .. " or " .. itemPackKhajiit, -- Moon-Sugar, Cluster
    [153667] = getCrownPrice(170) .. " or " .. itemPackKhajiit, -- Moon-Sugar, Harvested Large
    [153668] = getCrownPrice(90) .. " or " .. itemPackKhajiit, -- Moon-Sugar, Harvested Small
    [153632] = getCrownPrice(1500) .. " or " .. itemPackKhajiit, -- Sapphire Candlefly Gathering
    [153661] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Straw Pile
    [153662] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Tool, Plow
    [153663] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Tool, Sickle
    [153664] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Tool, Pitchfork
    [153665] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Tool, Hoe
    [153666] = getCrownPrice(40) .. " or " .. itemPackKhajiit, -- Tool, Two-Person Crosscut Saw

    [134270] = getCrownPrice(85) .. " or " .. itemPackMalacath, -- Cave Deposit, Large Double-Sided
    [134271] = getCrownPrice(85) .. " or " .. itemPackMalacath, -- Cave Deposit, Tall Stalagmite
    [134272] = getCrownPrice(10) .. " or " .. itemPackMalacath, -- Cave Deposit, Stalagmite Cluster,
    [134258] = itemPackMalacath, -- Prayer to the Furious One,
    [134259] = itemPackMalacath, -- Malacath, God of Oaths and Curses,
    [134260] = itemPackMalacath, -- Orcish Bas-Relief, Axe,
    [134261] = itemPackMalacath, -- Orcish Bas-Relief, Sword,
    [134262] = itemPackMalacath, -- Orcish Bas-Relief, Spear,
    [134268] = getCrownPrice(570) .. " or " .. itemPackMalacath, -- Orcish Brazier, Column
    [134269] = getCrownPrice(220) .. " or " .. itemPackMalacath, -- Orcish Dais, Raised
    [116518] = getCrownPrice(270) .. " or " .. itemPackMalacath, -- Orcish Drop Hammer, Repeating,
    [152147] = itemPackMalacath, -- Orcish Statue, Strength,
    [134267] = getCrownPrice(380) .. " or " .. itemPackMalacath, -- Orcish Table, Grand Furs
    [134263] = getCrownPrice(410) .. " or " .. itemPackMalacath, -- Orcish Throne, Ancient

    [126114] = itemPackAzura, -- Statue of Azura, Queen of Dawn and Dusk,
    [126115] = itemPackAzura, -- Statue of Azura's Moon,
    [126116] = itemPackAzura, -- Statue of Azura's Sun,
    [126117] = itemPackAzura, -- Tapestry of Azura,
    [126118] = itemPackAzura, -- Banner of Azura,
    [125489] = itemPackAzura, -- Daedric Brazier, Flaming,
    [126128] = itemPackAzura, -- The Five Points of the Star,

    [134251] = itemPackColdharbour, -- Coldharbour Bookshelf, Filled,
    [134252] = itemPackColdharbour, -- Coldharbour Bookshelf, Black Laboratory,
    [134253] = itemPackColdharbour, -- Coldharbour Bookshelf, Filled Wide,
    [134256] = itemPackColdharbour, -- Coldharbour Bookshelf, Filled Pillar,
    [134254] = itemPackColdharbour, -- Seal of Molag Bal,
    [134255] = itemPackColdharbour, -- Transliminal Rupture,
    [134257] = itemPackColdharbour, -- Daedra Dossier: Cold-Flame Atronach
    [134264] = getCrownPrice(190) .. " or " .. itemPackColdharbour, -- Daedric Brazier, Cold-Flame
    [134273] = getCrownPrice(200) .. " or " .. itemPackColdharbour, -- Daedric Plinth, Sacrificial
    [134274] = getCrownPrice(200) .. " or " .. itemPackColdharbour, -- Coldharbour Crate, Black Soul Gem
    [134275] = getCrownPrice(200) .. " or " .. itemPackColdharbour, -- Coldharbour Bin, Black Soul Gem

    [182285] = getCrownPrice(160) .. " or " .. itemPackFargrave, -- Book Wall, Levitating,
    [182286] = getCrownPrice(860) .. " or " .. itemPackFargrave, -- Fargrave Terrarium, Snakevine,
    [182288] = getCrownPrice(820) .. " or " .. itemPackFargrave, -- Fargrave Terrarium, Massive Gas Blossom,
    [182284] = getCrownPrice(20) .. " or " .. itemPackFargrave, -- Fargrave Bread Loaves, Round,
    [182283] = getCrownPrice(870) .. " or " .. itemPackFargrave, -- Fargrave Terrarium, Lantern Flower,
    [182282] = getCrownPrice(560) .. " or " .. itemPackFargrave, -- Fargrave Water Globules, Levitating,
    [182258] = getCrownPrice(540) .. " or " .. itemPackFargrave, -- Fargrave Terrarium, Claws,
    [182230] = getCrownPrice(140) .. " or " .. itemPackFargrave, -- Mushrooms, Glowing Shelf,
  },

  [FURC_RUMOUR] = {
    [141836] = rumourSource, -- Monolith, Lord Hircine Ritual,
    [141843] = rumourSource, -- Plants, Yellow Frond Cluster,
    [171544] = rumourSource, -- Comet, Aetherial,
    [171545] = rumourSource, -- Ayleid Gate, Large,
    [171546] = rumourSource, -- Ayleid Relief, Blessed Life-Tree,
    [120859] = rumourSource, -- Yokudan Wall Embellishment,
    [120862] = rumourSource, -- Ancient Patriarch Banner,
    [175135] = rumourSource, -- Statue, Prince of Ambition,
    [120865] = rumourSource, -- Daedric Table,
    [120866] = rumourSource, -- Daedric Brazier, Tabletop,
    [120867] = rumourSource, -- Daedric Pike, Clannfear Head,
    [120871] = rumourSource, -- Deadric Vase, Spiked,
    [130088] = rumourSource, -- Daedric Fragment, Coldharbour,
    [120873] = rumourSource, -- Daedric Coffin,
    [130090] = rumourSource, -- Daedric Sconce, Molag Bal,
    [130092] = rumourSource, -- Seal of Molag Bal, Grand,
    [120878] = rumourSource, -- Gravestone, Ornamented,
    [125509] = rumourSource, -- Replica Dwarven Crown Crate,
    [120411] = rumourSource, -- Noble's Chalice of Wine,
    [125532] = rumourSource, -- Dwarven Pipeline, Fan,,
    [132198] = rumourSource, -- Death Skeleton, Wrapped,
    [139367] = rumourSource, -- Regal Sauna Pool, Two Person,
    [126568] = rumourSource, -- Daedric Urn, Ritual,
    [134249] = rumourSource, -- Sotha Sil, The Clockwork God,
    [125550] = rumourSource, -- Flowers, Lava Blooms,
    [126588] = rumourSource, -- Vvardenfell Pitcher Plants, Hanging Bunch,
    [126589] = rumourSource, -- Vvardenfell Mushrooms, Bloodtooth,
    [126590] = rumourSource, -- Vvardenfell Mushrooms, Lavaburst,
    [139391] = rumourSource, -- Master Crafter's Banner, Hanging,
    [125569] = rumourSource, -- Hlaalu Sidewalk, Sillar Stone Corner,
    [125570] = rumourSource, -- Hlaalu Stairs, Sillar Stone,
    [125576] = rumourSource, -- Hlaalu Wall Pillar, Sillar Stone,
    [182921] = rumourSource, -- Fargrave Canopy, Large,
    [182922] = rumourSource, -- Vines, Thornpinch,
    [125583] = rumourSource, -- Mushroom, Cave Bracket,
    [125589] = rumourSource, -- Mushroom, Lavaburst Bud,
    [175766] = rumourSource, -- Mushroom, Glowing Trumpet,
    [125591] = rumourSource, -- Mushroom, Lavaburst Patch,
    [120984] = rumourSource, -- Plant, Goldenrod Cluster,
    [120985] = rumourSource, -- Dark Elf Lightpost, Single,
    [120986] = rumourSource, -- Dark Elf Lightpost, Full,
    [120987] = rumourSource, -- Dark Elf Lightpost, Capped,
    [126108] = rumourSource, -- Display Atronach Crown Crate,
    [125597] = rumourSource, -- Mushroom, Polyp Stinkhorn,
    [125598] = rumourSource, -- Mushroom, Emerging Stinkhorn,
    [121000] = rumourSource, -- Shrub, Trimmed Green,
    [121004] = rumourSource, -- Hedge, Solid Arc,
    [121007] = rumourSource, -- Tree, Strong Maple,
    [121010] = rumourSource, -- Tree, Young Green Birch,
    [126132] = rumourSource, -- Resplendent Sweetroll,
    [121013] = rumourSource, -- Saplings, Fragile Autumn Birch,
    [121015] = rumourSource, -- Shrub, Sparse Green,
    [121016] = rumourSource, -- Bush, Red Berry,
    [121022] = rumourSource, -- Bush, Green Forest,
    [121023] = rumourSource, -- Tree, Strong Olive,
    [134853] = rumourSource, -- Peryite, The Taskmaster,
    [134854] = rumourSource, -- Tapestry of Peryite,
    [134855] = rumourSource, -- Banner of Peryite,
    [181487] = rumourSource, -- Grim Harlequin Chandelier,
    [178471] = rumourSource, -- Guild Banner, Aetherius Art,
    [171818] = rumourSource, -- Tree, Giant Cork Oak,
    [178475] = rumourSource, -- Guild Banner, Museum,
    [178476] = rumourSource, -- Guild Banner, Nomads of Nirn,
    [171834] = rumourSource, -- Tree, Charred Vvardenfell Pine,
    [171835] = rumourSource, -- Tree, Charred Leaning Vvardenfell Pine,
    [171836] = rumourSource, -- Tree, Charred Slim Vvardenfell Pine,
    [178497] = rumourSource, -- The Sonnet of Aetherius Art,
    [178499] = rumourSource, -- Goldleaf Acquisitions, Manager's Notes,
    [178500] = rumourSource, -- Museum Guild Letter,
    [178501] = rumourSource, -- The Nomads of Nirn,
    [178502] = rumourSource, -- An Ode to the Disenfranchised,
    [134475] = rumourSource, -- Statue of Malacath, Orc-Father,
    [181601] = rumourSource, -- Rock, Wide Gabbro Slab,
    [171875] = rumourSource, -- Target Harrowing Reaper, Trial,
    [181605] = rumourSource, -- Rock, Gabbro Set,
    [181606] = rumourSource, -- Rock, Gabbro Boulder Cluster,
    [181607] = rumourSource, -- Tree, Elder Blackwood Beech,
    [181608] = rumourSource, -- Tree, Blackwood Beech,
    [181609] = rumourSource, -- Tree, Blackwood Beech Cluster,
    [181610] = rumourSource, -- Vines, Snow Lillies Swath,
    [181611] = rumourSource, -- Vines, Snow Lillies Climber,
    [139137] = rumourSource, -- Tapestry, Nocturnal,
    [139138] = rumourSource, -- Banner, Nocturnal,
    [139139] = rumourSource, -- Nocturnal, Mistress of Shadows,
    [181643] = rumourSource, -- Warrior's Flame,
    [171940] = rumourSource, -- Statue of Sheogorath, Shivering Isles Sovereign,
    [182925] = rumourSource, -- Rocks, Deadlands Cluster,
    [171945] = rumourSource, -- Deadlands Sconce, Horned,
    [171946] = rumourSource, -- Deadlands Cage, Bladed,
    [171947] = rumourSource, -- Deadlands Chandelier, Bladed,
    [132531] = rumourSource, -- Hlaalu Planter, Tall,
    [182207] = rumourSource, -- Celestial Vortex,
    [182280] = rumourSource, -- Fargrave Relic Case,
    [175765] = rumourSource, -- Tapestry of a Failed Incarnate, The Brute,
    [171819] = rumourSource, -- Tree, Towering Cork Oak,
    [181603] = rumourSource, -- Plant, White Flowered Lily Pads,
    [181600] = rumourSource, -- Rock, Gabbro Boulder,
    [181543] = rumourSource, -- Harpy Totem, Feathered,
    [120851] = rumourSource, -- Gallows,
    [120854] = rumourSource, -- Guard Lamppost,
    [120855] = rumourSource, -- Collected Wanted Poster,
    [134686] = rumourSource, -- Sithis, The Dread Father,
    [120863] = rumourSource, -- Daedric Light Pillar,
    [125480] = rumourSource, -- Banner, Clavicus Vile,
    [126771] = rumourSource, -- Velothi Podium of Illumination,
    [175578] = rumourSource, -- Banner, Meridia,
    [126776] = rumourSource, -- Indoril Tapestry, House,
    [125592] = rumourSource, -- Mushroom, Lavaburster,
    [130212] = rumourSource, -- Daedra Worship: The Ayleids,
    [181438] = rumourSource, -- Mad God's Monarch Flock,
    [178800] = rumourSource, -- Amethyst Candlefly Gathering,
    [125537] = rumourSource, -- Dwarven Piston Cylinder,
    [178474] = rumourSource, -- Guild Banner, Goldleaf Acquisitions,
    [178473] = rumourSource, -- Guild Banner, The Disenfranchised,
    [126107] = rumourSource, -- Display Wild Hunt Crown Crate,
    [126109] = rumourSource, -- Display Death Crown Crate,
    [120997] = rumourSource, -- Banner, Tattered Blue,
    [121008] = rumourSource, -- Tree, Autumn Maple,
    [126136] = rumourSource, -- Dwarven Lantern, Powered,
    [125654] = rumourSource, -- Tapestry, Clavicus Vile,
  },
}

FurC.MiscItemSources[FURC_FLAMES] = {

  [FURC_CROWN] = {

    [171932] = getCrownPrice(160), -- Daedric Sconce, Torch,
    [171933] = getCrownPrice(80), -- Daedric Candles, Tall Stand,
    [171934] = getCrownPrice(360), -- Daedric Brazier, Plinth,
    [118482] = getCrownPrice(25), -- Book Stack, Tall
  },

  [FURC_DROP] = {
    [171428] = scrying .. " (gold lead, Harrowstorm Reliquary)", -- Vampiric Stained Glass
  },
}

FurC.MiscItemSources[FURC_MARKAT] = {
  [FURC_DROP] = {
    [171428] = scrying .. " in the Reach (Harrowstorms)", -- Vampiric Stained Glass
  },

  [FURC_CROWN] = {
    [171397] = itemPackAlchemist, -- Stone Garden Tank, Vacant,
    [171398] = itemPackAlchemist, -- Stone Garden Vat, Alchemized Bristleback,
    [171399] = itemPackAlchemist, -- Stone Garden Vat, Alchemized Chaurus,
    [171400] = itemPackAlchemist, -- Stone Garden Vat, Alchemized Durzog,
    [171401] = itemPackAlchemist, -- Stone Garden Vat, Vacant,
    [171402] = itemPackAlchemist, -- Stone Garden Circulator, Rootbound,
    [171403] = itemPackAlchemist, -- Stone Garden Casket, Alchemized Bloodknight,
    [169117] = itemPackAlchemist, -- Target Bloodknight,

    [167299] = getCrownPrice(920), -- Dwarven Chandelier, Polished Braced,
    [167301] = getCrownPrice(560), -- Dwarven Lamppost, Polished Powered,
    [167300] = getCrownPrice(160), -- Dwarven Lantern, Polished Wall,
    [167298] = getCrownPrice(310), -- Dwarven Sconce, Polished Barred,
  },

  [FURC_RUMOUR] = {
    [171382] = rumourSource, -- Reachmen Pergola, Ivy Overhang,
    [153841] = rumourSource, -- Rewoven Khajiiti Tapestry,
    [167289] = rumourSource, -- Tree, Lowland White Pine,
    [167290] = rumourSource, -- Tree, Great Lowland White Pine,
    [167291] = rumourSource, -- Tree, Towering Royal Pine,
    [167292] = rumourSource, -- Rocks, Large Jagged Set,
    [167293] = rumourSource, -- Shrub, Long Amber Bayberry,
    [167295] = rumourSource, -- Tree, Great Snowy White Pine,
    [167296] = rumourSource, -- Tree, Giant Snowy White Pine,
    [167297] = rumourSource, -- Trees, Young Snowy White Pine Cluster,
    [167302] = rumourSource, -- Solitude Brazier, Metal,
    [167306] = rumourSource, -- Tree, Towering Snowy White Pine,
    [167933] = rumourSource, -- Dwarven Beam Emitter, Medium,
    [160541] = rumourSource, -- Outfit Station, Clockwork,
    [167934] = rumourSource, -- Dwarven Orrery, Scholastic,
    [167935] = rumourSource, -- Dwarven Work Lamp, Powered Floor,
  },
}

FurC.MiscItemSources[FURC_STONET] = {

  [FURC_CROWN] = {

    [119587] = getCrownPrice(10), -- Auridon Coneplants, Cluster
    [118347] = getCrownPrice(20), -- Bread, Various Loaves
    [118344] = getCrownPrice(20), -- Breads, Assortment
    [118287] = getCrownPrice(85), -- Carcass, Brown Hare
    [118282] = getCrownPrice(85), -- Carcass, Fresh Goose
    [118162] = getCrownPrice(340), -- Carpet of the Desert Flame, Faded
    [118167] = getCrownPrice(340), -- Carpet of the Desert Flame, Faded
    [118166] = getCrownPrice(340), -- Carpet of the Desert, Faded
    [118161] = getCrownPrice(340), -- Carpet of the Mirage, Faded
    [118159] = getCrownPrice(340), -- Carpet of the Oasis, Faded
    [118158] = getCrownPrice(340), -- Carpet of the Sun, Faded Summer
    [118043] = getCrownPrice(25), -- Common Torch, Holder
    [118261] = getCrownPrice(25), -- Cushion, Faded Yellow
    [118260] = getCrownPrice(25), -- Cushion, Faded Blue
    [118259] = getCrownPrice(25), -- Cushion, Faded Red
    [94091] = getCrownPrice(95), -- Imperial Carpet, Akatosh
    [94092] = getCrownPrice(95), -- Imperial Carpet, Kyne
    [94093] = getCrownPrice(95), -- Imperial Carpet, Stendarr
    [94094] = getCrownPrice(140), -- Imperial Banner, Akatosh
    [94095] = getCrownPrice(140), -- Imperial Banner, Kyne
    [94096] = getCrownPrice(140), -- Imperial Banner, Stendarr
    [94097] = getCrownPrice(95), -- Imperial Bed, Bunk
    [94099] = getCrownPrice(60), -- Imperial Dresser, Short
    [94101] = getCrownPrice(45), -- Imperial Chair, Slatted
    [94102] = getCrownPrice(120), -- Imperial Rack, Cask
    [94103] = getCrownPrice(60), -- Imperial Dresser, Open
    [94104] = getCrownPrice(40), -- Imperial Stool, Sturdy
    [94105] = getCrownPrice(95), -- Imperial Table, Family
    [94106] = getCrownPrice(95), -- Imperial Desk, Sturdy
    [94107] = getCrownPrice(50), -- Imperial Table, Common
    [94108] = getCrownPrice(50), -- Imperial Shelf, Wall
    [94109] = getCrownPrice(50), -- Imperial Lantern, Wall
    [94110] = getCrownPrice(110), -- Imperial Lightpost, Stone
    [94111] = getCrownPrice(95), -- Imperial Well, Grated
    [94112] = getCrownPrice(70), -- Imperial Pedestal, Stone
    [94113] = getCrownPrice(70), -- Imperial Basin, Stone
    [94114] = getCrownPrice(430), -- Imperial Statue, Monolith
    [94115] = getCrownPrice(430), -- Imperial Statue, Obelisk
    [94117] = getCrownPrice(220), -- Imperial Rug, Akatosh
    [94118] = getCrownPrice(220), -- Imperial Rug, Kynareth
    [94119] = getCrownPrice(220), -- Imperial Rug, Stars
    [94120] = getCrownPrice(220), -- Imperial Rug, Stendarr
    [94129] = getCrownPrice(220), -- Imperial Tapestry, Akatosh
    [94130] = getCrownPrice(220), -- Imperial Tapestry, Kynareth
    [94131] = getCrownPrice(220), -- Imperial Tapestry, Stendarr
    [94132] = getCrownPrice(150), -- Imperial Brazier, Firepot
    [94133] = getCrownPrice(220), -- Imperial Bed, Four-Poster
    [94134] = getCrownPrice(220), -- Imperial Bed, Double
    [94135] = getCrownPrice(160), -- Imperial Pew, Windowed
    [94136] = getCrownPrice(160), -- Imperial Bench, Fitted
    [94137] = getCrownPrice(110), -- Imperial Bookcase, Scrollwork
    [94138] = getCrownPrice(100), -- Imperial Chair, Rocking
    [94139] = getCrownPrice(100), -- Imperial Chair, Windowed
    [94140] = getCrownPrice(85), -- Imperial Chest, Sturdy
    [94141] = getCrownPrice(120), -- Imperial Hutch, Scrollwork
    [94142] = getCrownPrice(120), -- Imperial Cupboard, Scrollwork
    [94143] = getCrownPrice(180), -- Imperial Chest of Drawers
    [94144] = getCrownPrice(220), -- Imperial Counter, Long Cabinet
    [94145] = getCrownPrice(110), -- Imperial Shelf, Barrel
    [94146] = getCrownPrice(220), -- Imperial Desk, Swirled
    [94147] = getCrownPrice(220), -- Imperial Table, Dining
    [94148] = getCrownPrice(220), -- Imperial Trestle, Sturdy
    [94149] = getCrownPrice(85), -- Imperial Table, Game
    [94150] = getCrownPrice(220), -- Imperial Table, Kitchen
    [94151] = getCrownPrice(240), -- Imperial Lightpost, Pair
    [94152] = getCrownPrice(240), -- Imperial Lightpost, Single
    [94153] = getCrownPrice(220), -- Imperial Well, Arched
    [94154] = getCrownPrice(160), -- Imperial Basin, Heavy
    [94155] = getCrownPrice(1000), -- Imperial Tent, Commander's
    [94156] = getCrownPrice(290), -- Imperial Brazier, Caged
    [94157] = getCrownPrice(410), -- Imperial Medallion, Crest
    [94158] = getCrownPrice(410), -- Imperial Tapestry, Stars
    [94159] = getCrownPrice(450), -- Imperial Streetlight, Imperial City
    [94161] = getCrownPrice(310), -- Imperial Pedestal, Chiseled
    [94162] = getCrownPrice(290), -- Imperial Pew, Scrollwork
    [94163] = getCrownPrice(290), -- Imperial Bench, Scrollwork
    [94164] = getCrownPrice(220), -- Imperial Sideboard, Scrollwork
    [94165] = getCrownPrice(200), -- Imperial Chair, Scrollwork
    [94166] = getCrownPrice(220), -- Imperial Armchair, Scrollwork
    [94167] = getCrownPrice(220), -- Imperial Cabinet, Scrollwork
    [94168] = getCrownPrice(220), -- Imperial Curio, Scrollwork
    [94169] = getCrownPrice(160), -- Imperial Coffer, Scrollwork
    [94170] = getCrownPrice(270), -- Imperial Dresser, Scrollwork
    [94171] = getCrownPrice(240), -- Imperial Counter, Corner
    [94172] = getCrownPrice(490), -- Imperial Bar, Cabinet
    [94173] = getCrownPrice(200), -- Imperial Mirror, Standing
    [94174] = getCrownPrice(120), -- Imperial Nightstand, Scrollwork
    [94175] = getCrownPrice(200), -- Imperial Divider, Folding
    [94176] = getCrownPrice(200), -- Imperial Divider, Curved
    [94177] = getCrownPrice(170), -- Imperial Stool, Padded
    [94178] = getCrownPrice(410), -- Imperial Desk, Scrollwork
    [94179] = getCrownPrice(410), -- Imperial Table, Formal
    [94180] = getCrownPrice(410), -- Imperial Trestle, Scrollwork
    [94182] = getCrownPrice(160), -- Imperial Footlocker, Scrollwork
    [94183] = getCrownPrice(350), -- Imperial Wardrobe, Scrollwork
    [94184] = getCrownPrice(240), -- Imperial Wine Rack, Scrollwork
    [94185] = getCrownPrice(450), -- Imperial Lightpost, Full
    [94187] = getCrownPrice(410), -- Imperial Well, Covered
    [94188] = getCrownPrice(410), -- Imperial Carpet, Gilded Dibella
    [94189] = getCrownPrice(410), -- Imperial Carpet, Verdant Dibella
    [94190] = getCrownPrice(410), -- Imperial Rug, Dibella
    [94191] = getCrownPrice(410), -- Imperial Tapestry, Dibella
    [94192] = getCrownPrice(610), -- Imperial Banner, Dibella
    [94193] = getCrownPrice(410), -- Imperial Pillar, Straight
    [94194] = getCrownPrice(410), -- Imperial Pillar, Chipped
    [94195] = getCrownPrice(410), -- Imperial Bed, Canopy
    [94196] = getCrownPrice(410), -- Imperial Cradle, Scrollwork
    [94197] = getCrownPrice(610), -- Imperial Shrine of the Bay
    [94198] = getCrownPrice(610), -- Imperial Altar of the Bay
    [94200] = getCrownPrice(1000), -- Imperial Fountain of the Bay
    [94201] = getCrownPrice(820), -- Imperial Statue, Knight
    [94202] = getCrownPrice(820), -- Imperial Statue, Emperor
    [94203] = getCrownPrice(820), -- Imperial Statue, Warrior
    [118160] = getCrownPrice(340), -- Mat of Meditation, Faded
    [118164] = getCrownPrice(340), -- Mat of the Sunset, Faded
    [118163] = getCrownPrice(340), -- Mat of the Oasis, Faded
    [118165] = getCrownPrice(340), -- Mat of the Sunrise, Faded
    [115421] = getCrownPrice(110), -- Nord Sconce, Torch
    [118244] = getCrownPrice(340), -- Orc Rug, Echatere Skin
    [118131] = getCrownPrice(180), -- Pelt, Bear
    [118107] = getCrownPrice(40), -- Pie, Display
  },

  [FURC_DROP] = {
    [171429] = scrying .. "in the Reach", -- Red Eagle Cave Painting
  },

  [FURC_RUMOUR] = {
    [94181] = rumourSource, -- Imperial Throne of the Bay
    [94160] = rumourSource, -- Imperial Lantern, Imperial City
    [94116] = rumourSource, -- Imperial Cauldron, Pitch-filled
    [118784] = rumourSource, -- Post, Skull
    [118785] = rumourSource, -- Post, Skulls
    [118788] = rumourSource, -- Skeletal Remains, Prone
    [118277] = rumourSource, -- Ram Horns, Mounted
    [118790] = rumourSource, -- Skeletal Remains, Argonian Side
    [118792] = rumourSource, -- Skeletal Remains, Khajiiti Side
    [118795] = rumourSource, -- Skull, Giant Mammoth
    [118796] = rumourSource, -- Skull, Mammoth
    [118797] = rumourSource, -- Skull, Dragon
    [118308] = rumourSource, -- Barrel, Orange Dye
    [118309] = rumourSource, -- Barrel, Pink Dye
    [118310] = rumourSource, -- Barrel, Green Dye
    [118311] = rumourSource, -- Barrel, Covered Dye
    [118312] = rumourSource, -- Barrel, Blue Dye
    [118313] = rumourSource, -- Barrel, Yellow Dye
    [118314] = rumourSource, -- Barrel, Empty Dye
    [118315] = rumourSource, -- Cask, Orange Dye
    [118316] = rumourSource, -- Cask, Pink Dye
    [118317] = rumourSource, -- Cask, Green Dye
    [118318] = rumourSource, -- Cask, Blue Dye
    [118319] = rumourSource, -- Cask, Yellow Dye
    [118320] = rumourSource, -- Jar, Orange Dye
    [118321] = rumourSource, -- Jar, Pink Dye
    [118323] = rumourSource, -- Jar, Covered Dye
    [118324] = rumourSource, -- Jar, Blue Dye
    [118325] = rumourSource, -- Jar, Yellow Dye
    [115261] = rumourSource, -- Breton Forge and Bellows
    [115268] = rumourSource, -- Breton Statue, Fighters Guild
    [117835] = rumourSource, -- Redguard Lamp, Oil
    [118350] = rumourSource, -- Box of Tangerines
    [118352] = rumourSource, -- Box of Oranges
    [118353] = rumourSource, -- Box of Grapes
    [118354] = rumourSource, -- Box of Fruit
    [117843] = rumourSource, -- Redguard Bed, Wide Lattice
    [118877] = rumourSource, -- Bone, Right Arm
    [118878] = rumourSource, -- Bone, Left Arm
    [118883] = rumourSource, -- Bone, Forearm
    [118884] = rumourSource, -- Bone, Left Hand
    [118885] = rumourSource, -- Bone, Right Hand
    [118886] = rumourSource, -- Bone, Humerus
    [118887] = rumourSource, -- Bone, Left Leg
    [118888] = rumourSource, -- Bone, Right Leg
    [118889] = rumourSource, -- Bone, Pelvis
    [118891] = rumourSource, -- Cranium, Human
    [118893] = rumourSource, -- Bone, Left Calf
    [118894] = rumourSource, -- Bone, Right Calf
    [118895] = rumourSource, -- Bones, Torso
    [117881] = rumourSource, -- Redguard Pillow, Lattice Sands
    [117882] = rumourSource, -- Redguard Pillow, Florid Sands
    [118908] = rumourSource, -- Lantern, Ship Captain's
    [117885] = rumourSource, -- Redguard Pillow Roll, Sands
    [117886] = rumourSource, -- Redguard Throw Pillow, Sands
    [117887] = rumourSource, -- Redguard Tuffet, Sands
    [117891] = rumourSource, -- Redguard Armchair, Lattice
    [117892] = rumourSource, -- Redguard Chair, Lattice
    [117893] = rumourSource, -- Redguard Footlocker, Bolted
    [117894] = rumourSource, -- Redguard Divider, Gilded
    [117896] = rumourSource, -- Redguard Wine Rack, Bolted
    [117897] = rumourSource, -- Redguard Mat, Sun
    [117898] = rumourSource, -- Redguard Carpet, Dawn
    [117899] = rumourSource, -- Redguard Chest, Crested
    [115341] = rumourSource, -- Dark Elf Ash Garden
    [117902] = rumourSource, -- Redguard Pot, Gilded
    [117903] = rumourSource, -- Redguard Vessel, Gilded
    [117904] = rumourSource, -- Redguard Trunk, Garish
    [117908] = rumourSource, -- Redguard Candlestick, Twisted
    [119970] = rumourSource, -- Redguard Round Table
    [117925] = rumourSource, -- Rough Cot, Military
    [117927] = rumourSource, -- Rough Barrel, Sturdy
    [117932] = rumourSource, -- Rough Tray, Sturdy
    [117933] = rumourSource, -- Rough Bin, Sturdy
    [117934] = rumourSource, -- Rough Carton, Sturdy
    [117935] = rumourSource, -- Rough Pouch, Burlap
    [117936] = rumourSource, -- Rough Pouch, Coarse Cloth
    [117938] = rumourSource, -- Rough Sack, Burlap
    [117941] = rumourSource, -- Rough Broom, Practical
    [117944] = rumourSource, -- Rough Fork, Common
    [117946] = rumourSource, -- Rough Knife, Butter
    [117947] = rumourSource, -- Rough Spoon, Common
    [117948] = rumourSource, -- Rough Candle, Tealight
    [117949] = rumourSource, -- Rough Candle, Pillar
    [117951] = rumourSource, -- Rough Torch, Basic
    [116420] = rumourSource, -- Orcish Throne, Pedestal
    [117962] = rumourSource, -- Rough Bedroll, Rolled
    [119690] = rumourSource, -- Banner of Hircine
    [119689] = rumourSource, -- Arch of the Wild Hunt
    [119688] = rumourSource, -- Basin of the Wild Hunt
    [119687] = rumourSource, -- Statue of the Wild Hunt
    [119686] = rumourSource, -- Totem of the Wild Hunt
    [119684] = rumourSource, -- Statue of Hircine
    [118482] = rumourSource, -- Book Stack, Tall
    [115412] = rumourSource, -- Nord Bellows, Fireplace
    [118157] = rumourSource, -- Runner of the Sun, Faded
    [119674] = rumourSource, -- Surplus Covenant Iceball Trebuchet
    [119673] = rumourSource, -- Surplus Covenant Meatbag Catapult
    [118168] = rumourSource, -- Block, Carved Stone
    [116445] = rumourSource, -- Orcish Table with Furs
    [119667] = rumourSource, -- Surplus Covenant Battering Ram
    [119664] = rumourSource, -- Surplus Covenant Ballista
    [115621] = rumourSource, -- Wood Elf Tapestry, Skull Totem
    [118251] = rumourSource, -- Pillow, Faded Blue
    [119661] = rumourSource, -- Surplus Covenant Point Capture Flag
    [119660] = rumourSource, -- Covenant Wall Banner, Large
    [119659] = rumourSource, -- Covenant Camp Banner
    [118252] = rumourSource, -- Pillow, Faded Yellow Floral
    [118253] = rumourSource, -- Pillow, Faded Red Floral
    [118257] = rumourSource, -- Pillow Roll, Faded Blue
    [119640] = rumourSource, -- Decommissioned Pact Flaming Oil
    [114414] = rumourSource, -- High Elf Medallion, Winged
    [119633] = rumourSource, -- Dominion Pennant, Small
    [118249] = rumourSource, -- Pillow, Faded Red
    [118248] = rumourSource, -- Pillow, Faded Yellow
    [114418] = rumourSource, -- High Elf Statue, Base
    [118239] = rumourSource, -- Vial of Blood
    [116469] = rumourSource, -- Orcish Figure, Stone
    [117765] = rumourSource, -- Redguard Canopy, Dusk
    [116472] = rumourSource, -- Orcish Throne, Skull
    [118174] = rumourSource, -- Shutters, Blue Lattice
    [116475] = rumourSource, -- Orcish Skull Goblet, Empty
    [118744] = rumourSource, -- Tile, Constellation
    [118748] = rumourSource, -- Heirloom PvP Daggerfall Tapestry
    [118749] = rumourSource, -- Heirloom PvP Daggerfall Banner
    [116479] = rumourSource, -- Orcish Candle, Offering
    [116480] = rumourSource, -- Orcish Pedestal, Stone
    [118750] = rumourSource, -- Heirloom PvP Daggerfall Penant
    [118751] = rumourSource, -- Heirloom PvP Daggerfall Sign
    [116483] = rumourSource, -- Orcish Totem, Malacath
    [116484] = rumourSource, -- Orcish Funeral Pyre
    [118752] = rumourSource, -- Heirloom PvP Daggerfall Standard
    [116486] = rumourSource, -- Orcish Urn, Honor's Rest
    [116487] = rumourSource, -- Orcish Mask, Ceremonial
    [116488] = rumourSource, -- Orcish Mask, Decorative
    [116489] = rumourSource, -- Orcish Mask, Shield
    [116490] = rumourSource, -- Orcish Head, Stone
    [118754] = rumourSource, -- Heirloom PvP Daggerfall Siege Head
    [119615] = rumourSource, -- Surplus Dominion Point Capture Flag
    [119614] = rumourSource, -- Dominion Wall Banner, Large
    [119613] = rumourSource, -- Dominion Camp Banner
    [119612] = rumourSource, -- Dominion Wall Banner, Medium
    [119568] = rumourSource, -- Craglorn Ash Tree
    [119611] = rumourSource, -- Dominion Wall Banner, Small
    [119570] = rumourSource, -- Tree, Topal Weeping Willow
    [118794] = rumourSource, -- Skeletal Remains, Orc Prone
    [119573] = rumourSource, -- Young Oak Tree
    [119574] = rumourSource, -- Twisted Oak Tree
    [119575] = rumourSource, -- Tree, Slender Oak
    [119576] = rumourSource, -- Palm Tree Cluster
    [118825] = rumourSource, -- Remains, Bear
    [118856] = rumourSource, -- Remains, Wamasu
    [118909] = rumourSource, -- Remains, Wrapped
    [119579] = rumourSource, -- Murky Palm Tree
    [119582] = rumourSource, -- Rough Timber
    [119583] = rumourSource, -- Rough Limestone Tile
    [119584] = rumourSource, -- Auridon Fern, Orange
    [119585] = rumourSource, -- Auridon Fern, Tall
    [119586] = rumourSource, -- Auridon Fern, Squat
    [119588] = rumourSource, -- Auridon Mushrooms, Cluster
    [119589] = rumourSource, -- Mushrooms, Auridon Group
    [118780] = rumourSource, -- Heirloom PvP Wormcult Banner
    [118779] = rumourSource, -- Heirloom PvP Wormcult Tapestry
    [118778] = rumourSource, -- Heirloom PvP Imperial Tapestry
    [118777] = rumourSource, -- Heirloom PvP Imperial Banner
    [118776] = rumourSource, -- Pennant, Undaunted
    [118774] = rumourSource, -- Standard, Undaunted
    [118768] = rumourSource, -- Heirloom PvP Ebonheart Siege Head
    [118767] = rumourSource, -- Heirloom PvP Ebonheart Flag
    [118766] = rumourSource, -- Heirloom PvP Ebonheart Standard
    [118765] = rumourSource, -- Heirloom PvP Ebonheart Sign
    [118764] = rumourSource, -- Heirloom PvP Ebonheart Penant
    [118763] = rumourSource, -- Heirloom PvP Ebonheart Banner
    [118762] = rumourSource, -- Heirloom PvP Ebonheart Tapestry
    [118761] = rumourSource, -- Heirloom PvP Aldmeri Siege Head
    [118760] = rumourSource, -- Heirloom PvP Aldmeri Flag
    [118759] = rumourSource, -- Heirloom PvP Aldmeri Standard
    [118758] = rumourSource, -- Heirloom PvP Aldmeri Sign
    [118757] = rumourSource, -- Heirloom PvP Aldmeri Penant
    [118756] = rumourSource, -- Heirloom PvP Aldmeri Banner
    [118755] = rumourSource, -- Heirloom PvP Aldmeri Tapestry
    [118075] = rumourSource, -- Banner, War
    [118076] = rumourSource, -- Banner, Forge
    [118077] = rumourSource, -- Banner, Forceful
    [118078] = rumourSource, -- Banner, Mighty
    [118079] = rumourSource, -- Banner, Crafting
    [119616] = rumourSource, -- Spare Dominion Ballista Figurehead
    [118753] = rumourSource, -- Heirloom PvP Daggerfall Flag
    [119618] = rumourSource, -- Surplus Dominion Ballista
    [119619] = rumourSource, -- Surplus Dominion Scattershot Catapult
    [119620] = rumourSource, -- Surplus Dominion Stone Trebuchet
    [119621] = rumourSource, -- Surplus Dominion Battering Ram
    [119622] = rumourSource, -- Surplus Dominion Fire Ballista
    [119623] = rumourSource, -- Surplus Dominion Oil Catapult
    [119624] = rumourSource, -- Surplus Dominion Firepot Trebuchet
    [119625] = rumourSource, -- Surplus Dominion Forward Camp
    [119626] = rumourSource, -- Surplus Dominion Lightning Ballista
    [119627] = rumourSource, -- Surplus Dominion Meatbag Catapult
    [119628] = rumourSource, -- Surplus Dominion Iceball Trebuchet
    [118240] = rumourSource, -- Cake, Anniversary
    [119630] = rumourSource, -- Surplus Dominion Cold Fire Ballista
    [119631] = rumourSource, -- Surplus Dominion Cold Fire Trebuchet
    [119632] = rumourSource, -- Dominion Keep Pennant
    [115537] = rumourSource, -- Argonian Nest
    [115538] = rumourSource, -- Argonian Egg, Rough
    [118264] = rumourSource, -- Tuffet, Faded Yellow
    [118100] = rumourSource, -- Horn, Carved
    [115541] = rumourSource, -- Argonian Effigy, Coiled Snake
    [115542] = rumourSource, -- Argonian Relic, Broken
    [118103] = rumourSource, -- Painting Brush, Wide
    [118104] = rumourSource, -- Painting Brush, Detail
    [118105] = rumourSource, -- Painting Brush, Angled
    [118106] = rumourSource, -- Painting Palette
    [118262] = rumourSource, -- Tuffet, Faded Red
    [118111] = rumourSource, -- Steak, Display
    [118112] = rumourSource, -- Teapot, Common
    [118258] = rumourSource, -- Pillow Roll, Faded Yellow
    [119652] = rumourSource, -- Defaced Pact Flag
    [118117] = rumourSource, -- Table, Carved
    [118256] = rumourSource, -- Pillow Roll, Faded Red
    [118255] = rumourSource, -- Pillow, Faded Blue Floral
    [118254] = rumourSource, -- Pillow, Faded Purple Floral
    [119657] = rumourSource, -- Covenant Wall Banner, Small
    [119658] = rumourSource, -- Covenant Wall Banner, Medium
    [118123] = rumourSource, -- Pelt, Ice Wolf
    [118124] = rumourSource, -- Pelt, Wolf
    [118125] = rumourSource, -- Plaque, Large
    [119662] = rumourSource, -- Spare Covenant Ballista Figurehead
    [119663] = rumourSource, -- Decommissioned Covenant Flaming Oil
    [118128] = rumourSource, -- Pelt, Hanging
    [119665] = rumourSource, -- Surplus Covenant Scattershot Catapult
    [119666] = rumourSource, -- Surplus Covenant Stone Trebuchet
    [119668] = rumourSource, -- Surplus Covenant Fire Ballista
    [119669] = rumourSource, -- Surplus Covenant Oil Catapult
    [119670] = rumourSource, -- Surplus Covenant Firepot Trebuchet
    [119671] = rumourSource, -- Surplus Covenant Forward Camp
    [119672] = rumourSource, -- Surplus Covenant Lightning Ballista
    [115577] = rumourSource, -- Wood Elf Fork, Decorative
    [115578] = rumourSource, -- Wood Elf Spoon, Decorative
    [119676] = rumourSource, -- Surplus Covenant Cold Fire Ballista
    [119677] = rumourSource, -- Surplus Covenant Cold Fire Trebuchet
    [119678] = rumourSource, -- Covenant Keep Pennant
    [119679] = rumourSource, -- Covenant Pennant, Small
    [119685] = rumourSource, -- Tapestry of Hircine
    [118150] = rumourSource, -- Carpet Roll, Colorful
    [118151] = rumourSource, -- Carpet Roll, Sunset
    [118152] = rumourSource, -- Carpet Roll, Sunrise
    [118153] = rumourSource, -- Carpet Roll, Floral
    [118154] = rumourSource, -- Carpet Roll, Oasis
    [118156] = rumourSource, -- Runner of the Oasis, Faded
    [118155] = rumourSource, -- Carpet Roll, Desert
    [118137] = rumourSource, -- Podium, Engraved
    [115624] = rumourSource, -- Wood Elf Rug, Boar Hide
    [115540] = rumourSource, -- Argonian Egg, Mnemic Base
    [115622] = rumourSource, -- Wood Elf Handfast Statue
    [115623] = rumourSource, -- Wood Elf Pedestal, Stone
    [118250] = rumourSource, -- Pillow, Faded Purple
    [118263] = rumourSource, -- Tuffet, Faded Blue
    [118781] = rumourSource, -- Heirloom PvP Outlaw Tapestry
  },
}

FurC.MiscItemSources[FURC_SKYRIM] = {
  [FURC_RUMOUR] = {

    [153630] = rumourSource, -- Shadow Tendril Patch
    [153631] = rumourSource, -- Emerald Candlefly Gathering
    [153650] = rumourSource, -- Crystal Sconce, Green,
    [166029] = rumourSource, -- Vampiric Fountain, Bat Swarm
    [166030] = rumourSource, -- Greymoor Tapestry, Harrowstorm
    [153814] = rumourSource, -- Dragon's Treasure Trove
    [165568] = rumourSource, -- Ancient Nord Gate
    [152257] = rumourSource, -- Banner of Mephala
    [152258] = rumourSource, -- Banner of Boethiah
    [152259] = rumourSource, -- Banner of Mehrunes Dagon
    [159438] = rumourSource, -- Fungus, Gloomspore Ghost
    [156669] = rumourSource, -- Target Frost Atronach
    [165995] = rumourSource, -- Antique Map of Cyrodiil
    [163722] = rumourSource, -- Antique Map of Tamriel
  },

  [FURC_JUSTICE] = {
    [165828] = GetString(SI_FURC_CANBESTOLEN) .. in_skyrim, -- Painting: Life in Repose Painting, Wood
  },

  [FURC_DROP] = {
    [165836] = chests_skyrim, -- Painting: A Warm Welcome Awaits Painting, Wood
    [165837] = chests_skyrim, -- Painting: Jarl of Morthal Painting, Wood
    [165838] = chests_skyrim, -- Painting: Painting of Nord Ship, Wood
    [165839] = chests_skyrim, -- Painting: Ursine Wandering Painting, Wood
    [165826] = chests_skyrim, -- Painting: Fields of Plenty Painting, Wood
    [165827] = chests_skyrim, -- Painting: Eternal Moment Painting, Wood
    [165840] = chests_skyrim, -- Painting: The Bridge of Dragon Painting, Wood
    [165842] = chests_skyrim, -- Painting: Dockside Painting, Silver
    [165845] = chests_skyrim, -- Painting: Painting of the Arch, Silver
    [165843] = chests_skyrim, -- Painting: River's Journey Painting, Silver
    [165841] = chests_skyrim, -- Painting: Silent Solitude Painting, Silver
    [165844] = chests_skyrim, -- Painting: The Light Within Painting, Silver
    [166440] = chests_blackr_grcaverns, -- Painting: Light as Art Painting, Wood
    [166441] = chests_blackr_grcaverns, -- Painting: Gargoyle Guardians Painting, Wood
    [166449] = chests_blackr_grcaverns, -- Painting: Scion's Throne Painting, Wood
    [166442] = chests_blackr_grcaverns, -- Painting: The Deception of Light Painting, Wood
    [166438] = chests_blackr_grcaverns, -- Painting: Red Mist Blooming Painting, Wood
    [166439] = chests_blackr_grcaverns, -- Painting: Depths of Darkness Painting, Brass
    [166443] = chests_blackr_grcaverns, -- Painting: Contrasts Painting, Brass
    [166444] = chests_blackr_grcaverns, -- Painting: Luminescence Painting, Brass
    [166445] = chests_blackr_grcaverns, -- Painting: The Keep Painting, Brass
    [166447] = chests_blackr_grcaverns, -- Painting: Boon Companion, Brass
    [166448] = chests_blackr_grcaverns, -- Painting: The Scion Strides Forth Painting, Brass
    [166446] = chests_blackr_grcaverns, -- Painting: Still Life in Death Painting, Wood
    [166437] = chests_blackr_grcaverns, -- Painting: Stillness Everlasting Painting, Wood

    [165866] = scrying .. " in Stonefalls", -- Ashen Infernace Gate
    [165859] = scrying .. " in Bal Foyen", -- The Dutiful Guar
    [165854] = scrying .. " in Murkmire", -- Nisswo's Soul Tender
    [165860] = scrying .. " in Grahtwood", -- Eight-Star Chandelier
    [166474] = scrying .. " in Craglorn", -- Altar of Celestial Convergence
    [161204] = scrying .. " in Wrothgar", -- Anvil of Old Orsinium
    [165875] = scrying .. " in Betnikh", -- Ayleid Lightwell
    [163705] = scrying .. " in Betnikh", -- Warcaller's Painted Drum
    [165848] = scrying .. in_skyrim, -- Font of Auri-El
    [165870] = scrying .. " in Coldharbour", -- Daedric Pillar of Torment
    [166434] = scrying .. " in Alikr", -- The Heartland
    [165876] = scrying .. " in Bleakrock Isle", -- Ruby Dragon Skull",
    [161216] = scrying .. " in Bal Foyen", -- Tri-Angled Truth Altar
    [163706] = scrying .. " in Stros M'Kai", -- Dwemer Star Chart
    [166013] = scrying .. " in Rift", -- Ebony Fox Totem
    [165849] = scrying .. " in Auridon", -- Echoes of Aldmeris
    [161206] = scrying .. " in Greenshade", -- Branch of Falinesti
    [165857] = scrying .. " in Bleakrock Isle", -- Brazier of Frozen Flame
    [165871] = scrying .. " in Eastmarch", -- Carved Whale Totem
    [165864] = scrying .. " in Deshaan", -- Blessed Dais of Mother Morrowind
    [165861] = scrying .. " in Gold Coast", -- Golden Idol of Morihaus
    [166473] = scrying .. " in Greenshade", -- Greensong Gathering Circle
    [166436] = scrying .. " in Wrothgar ", -- Tusks of the Orc-Father
    [165856] = scrying .. " in Eastmarch", -- Sacred Chalice of Ysgramor
    [165852] = scrying .. " in Vvardenfell", -- St. Nerevar, Moon-and-Star
    [161207] = scrying .. " in Malabal Tor", -- Hollowbone Wind Chimes
    [165874] = scrying .. " in Glenumbra", -- Jeweled Skull of Ayleid Kings
    [165867] = scrying .. " in Khenarthi's Roost", -- Cat's Eye Prism
    [161213] = scrying .. " in Reaper's March", -- Sorcerer-King's Blade
    [163704] = scrying .. " in Glenumbra", -- Kingmaker's Trove
    [166471] = scrying .. " in Bangkorai", -- Tall Papa's Lamp
    [161205] = scrying .. " in Coldharbour", -- Void-Crystal Anomaly
    [165865] = scrying .. " in Stormhaven", -- Beacon of Tower Zero
    [166015] = scrying .. " in Khenarthi's Roost", -- Sweet Khenarthi's Song
    [165869] = scrying .. " in Auridon", -- Maormeri Serpent Shrine
    [165873] = scrying .. " in Gold Coast", -- Meridian Sconce
    [165850] = scrying .. " in Clockw. City", -- Mnemonic Star-Sphere
    [165853] = scrying .. " in S. Elsweyr", -- Moons-Blessed Ceremonial Pool
    [165868] = scrying .. " in Reaper's March", -- Moonlight Mirror
    [165872] = scrying .. " in N. Elsweyr", -- Stained Glass of Lunar Phases
    [166472] = scrying .. " in Hew's Bane", -- Morwha's Blessing
    [165862] = scrying .. " in N. Elsweyr", -- Moth Priest's Cleansing Bowl
    [161210] = scrying .. " in Summerset", -- Prismatic Sunbird Feather
    [165878] = scrying .. " in Stros M'Kai", -- Dwarven Puzzle Box
    [165851] = scrying .. " in Vvardenfell", -- Sixth House Ritual Table
    [165855] = scrying .. " in Stormhaven", -- Noble Knight's Rest
    [161208] = scrying .. " in Rift", -- Rune-Carved Mammoth Skull
    [161209] = scrying .. " in Shadowfen", -- Nest of Shadows
    [161212] = scrying .. " in Malabal Tor", -- Silvenari Sap-Stone
    [166435] = scrying .. in_skyrim, -- Seat of the Snow Prince
    [166451] = scrying .. " in Rivenspire", -- Riven King's Throne
    [161211] = scrying .. " in Rivenspire", -- Remnant of the False Tower
    [165858] = scrying .. " in Alikr", -- Coil of Satakal
    [161215] = scrying .. " in Hew's Bane", -- Yokudan Skystone Scabbard
    [161214] = scrying .. " in Craglorn", -- Spellscar Shard
    [166014] = scrying .. elsewhere, -- Shrine of Boethra
    [163710] = scrying .. " in Alik'r Desert", -- Antique Map of Alik'r Desert
    [165996] = scrying .. " in Gold Coast", -- Antique Map of Gold Coast
    [163727] = scrying .. " in Northern Elsweyr", -- Antique Map of Northern Elsweyr
    [163728] = scrying .. elsewhere, -- Antique Map of Southern Elsweyr
    [163717] = scrying .. " in Auridon", -- Antique Map of Auridon
    [163711] = scrying .. " in Bangkorai", -- Antique Map of Bangkorai
    [163713] = scrying .. " in Deshaan", -- Antique Map of Deshaan
    [163707] = scrying .. " in Glenumbra", -- Antique Map of Glenumbra
    [163718] = scrying .. " in Grahtwood", -- Antique Map of Grahtwood
    [163719] = scrying .. " in Greenshade", -- Antique Map of Greenshade
    [165997] = scrying .. " in Hew's Bane", -- Antique Map of Hew's Bane
    [165993] = scrying .. " in Coldharbour", -- Antique Map of Coldharbour
    [165994] = scrying .. " in Craglorn", -- Antique Map of Craglorn
    [163709] = scrying .. " in Rivenspire", -- Antique Map of Rivenspire
    [163720] = scrying .. " in Malabal Tor", -- Antique Map of Malabal Tor
    [163715] = scrying .. " in Eastmarch", -- Antique Map of Eastmarch
    [163716] = scrying .. " in Rift", -- Antique Map of The Rift
    [163714] = scrying .. " in Shadowfen", -- Antique Map of Shadowfen
    [163721] = scrying .. " in Reaper's March", -- Antique Map of Reaper's March
    [163725] = scrying .. " in Summerset", -- Antique Map of Summerset
    [163708] = scrying .. " in Stormhaven", -- Antique Map of Stormhaven
    [163712] = scrying .. " in Stonefalls", -- Antique Map of Stonefalls
    [163724] = scrying .. " in Vvardenfell", -- Antique Map of Vvardenfell
    [163726] = scrying .. " in Murkmire", -- Antique Map of Murkmire
    [163723] = scrying .. " in Wrothgar", -- Antique Map of Wrothgar
  },
  [FURC_CROWN] = {
    [167230] = scambox_sovngarde .. " (100 gems)", -- Alkosh's Hourglass, Replica
    [167231] = scambox_sovngarde .. " (100 gems)", -- Celestial Nimbus
    [167332] = scambox_sovngarde .. " (40 gems)", -- The Mage's Staff Painting, Gold

    [153675] = getCrownPrice(200), -- Daedric Altar, Four Alcoves
    [153676] = getCrownPrice(270), -- Daedric Sarcophagus, Stone
    [159462] = getCrownPrice(170), -- Redguard Fence, Wooden
    [166452] = getCrownPrice(440), -- Vampiric Column, Ancient
    [166044] = getCrownPrice(90), -- Watering Trough, Full
    [159460] = getCrownPrice(310), -- Tree, Slim Wrothgar Pine
    [159461] = getCrownPrice(30), -- Shrubs, Desert Scrub
    [159496] = getCrownPrice(240), -- Tree, Ancient Bristlecone
    [159456] = getCrownPrice(410), -- Orsinium Well, Open
    [159457] = getCrownPrice(170), -- Tree, Dagger Bark
    [159458] = getCrownPrice(310), -- Tree, Broad Wrothgar Pine
    [159459] = getCrownPrice(310), -- Trees, Paired Wrothgar Pine
  },
  [FURC_FISHING] = {},
}

FurC.MiscItemSources[FURC_KITTY] = {

  [FURC_RUMOUR] = {
    --[152145] = rumourSource, -- Orcish Tapestry, War,       CRAFTABLE
    --[152149] = rumourSource, -- Orcish Brazier, Pillar,     CRAFTABLE
    --[152148] = rumourSource, -- Orcish Tapestry, Hunt,      CRAFTABLE
    --[152146] = rumourSource, -- Orcish Chandelier, Spiked,  CRAFTABLE
    --[152141] = rumourSource, -- Orcish Brazier, Bordered,   CRAFTABLE
    --[152144] = rumourSource, -- Orcish Mirror, Peaked,      CRAFTABLE
    --[152143] = rumourSource, -- Orcish Sconce, Scrolled,    CRAFTABLE
    --[152142] = rumourSource, -- Orcish Sconce, Bordered,    CRAFTABLE
    [150774] = rumourSource, -- Banner of Vaermina,
    [150775] = rumourSource, -- Banner of Jyggalag,
    [151589] = rumourSource, -- Baandari Lunar Compass,
    [151611] = rumourSource, -- The Mane, Moons-Blessed,
    [151612] = rumourSource, -- Pile of Dubious Riches,
  },

  [FURC_JUSTICE] = {
    [151892] = stealable_elsewhere, -- Elsweyr Fragrance Bottle, Moons-Blessed
    [151889] = stealable_elsewhere, -- Elsweyr Comb, Grooming
    [151893] = stealable_elsewhere, -- Elsweyr Fragrance Bottle, Moonlit Tryst
    [151899] = stealable_elsewhere, -- Elsweyr Pillow, Night Blues Wide,
    [151898] = stealable_elsewhere, -- Elsweyr Pillow, Gold-Ruby Roll,
    [151900] = stealable_elsewhere, -- Elsweyr Pillow, Gold-Ruby Throw,
    [151895] = stealable_elsewhere, -- Elsweyr Cloth, Rolled,
    [151643] = stealable_elsewhere, -- Elsweyr Rolling Pin, Well-Worn,
    [151890] = stealable .. " from nobles", -- Elsweyr Hand Mirror, Bronze Oval,
    [151891] = stealable .. " from nobles", -- Elsweyr Hand Mirror, Rectangular,
    [151897] = stealable_elsewhere, -- Elsweyr Fabric, Display,
    [151886] = stealable_elsewhere, -- Elsweyr Fan, Handheld,
    [151887] = stealable_elsewhere, -- Elsweyr Brush, Body,
    [151888] = stealable_elsewhere, -- Elsweyr Brush, Head,
    [151894] = stealable_elsewhere, -- Elsweyr Mirror, Carved Wall
  },

  [FURC_DROP] = {
    [153563] = elsweyr_event, -- Target Bone Goliath, Reanimated
    [153814] = elsweyr_event, -- Dragon's Treasure Trove
    [145317] = "Witches' Festival, Plunder Skull", -- Gravestone, Broken
    [153751] = "In Cyrodiil for Volundrung Vanquisher or Volendrung Wielder", -- Volendrung Replica TODO set up properly
    [165834] = chests_elsweyr, -- A Simple Five-Claw Life Painting, Gold
  },

  [FURC_CROWN] = {

    [153630] = scambox_newmoon .. " (55 gems)",
    [159436] = scambox_gloomspore, -- Dwarven Miniature Sun, Portable
    [159437] = scambox_gloomspore, -- Painting of Blackreach, Rough

    [151838] = itemPackOasis, -- Elsweyr Fountain, Moons-Blessed,
    [151840] = getCrownPrice(70) .. " or " .. itemPackOasis, -- Plant, Desert Fan,
    [151841] = getCrownPrice(70) .. " or " .. itemPackOasis, -- Plant, Tall Desert Fan,
    [151842] = getCrownPrice(20) .. " or " .. itemPackOasis, -- Plant, Cask Palm,
    [151843] = getCrownPrice(45) .. " or " .. itemPackOasis, -- Cactus, Flowering Cluster,
    [151844] = getCrownPrice(30) .. " or " .. itemPackOasis, -- Cactus, Bilberry,
    [151845] = getCrownPrice(95) .. " or " .. itemPackOasis, -- Elsweyr Potted Cactus, Flowering,
    [151846] = getCrownPrice(35) .. " or " .. itemPackOasis .. " or " .. itemPackMermaid, -- Elsweyr Potted Plant, Cask Palm,
    [151835] = itemPackOasis, -- Cathay-Raht Statue, Warrior,
    [151836] = itemPackOasis, -- Tojay Statue, Dancer,
    [151837] = itemPackOasis, -- Ohmes-Raht Statue, Trickster,
    [151847] = getCrownPrice(20) .. " or " .. itemPackOasis, -- Plant, Flowering Desert Aloe,
    [151848] = getCrownPrice(15) .. " or " .. itemPackOasis, -- Trees, Sunset Palm Cluster,
    [151849] = getCrownPrice(45) .. " or " .. itemPackOasis, -- Cactus, Lily Flower,
    [151850] = getCrownPrice(20) .. " or " .. itemPackOasis, -- Tree, Anequina Bonsai,
    [151834] = getCrownPrice(90) .. " or " .. itemPackOasis, -- Tree, Desert Acacia Shade,

    [151906] = itemPackMoonBishop, -- Robust Target Dro-m'Athra,
    [151829] = itemPackMoonBishop, -- Suthay Statue, Nimble Bishop,
    [151824] = itemPackMoonBishop, -- Lunar Tapestry, The Open Path,
    [151825] = itemPackMoonBishop, -- Lunar Tapestry, The Gathering,
    [151826] = itemPackMoonBishop, -- Lunar Tapestry, The Dance,
    [151827] = itemPackMoonBishop, -- Lunar Tapestry, The Gate,
    [151828] = itemPackMoonBishop, -- Lunar Tapestry, The Demon,
    [151830] = getCrownPrice(190) .. " or " .. itemPackMoonBishop, -- Elsweyr Divider, Elegant Wooden,
    [151832] = getCrownPrice(100) .. " or " .. itemPackMoonBishop, -- Elsweyr Ceremonial Lantern, Jone,
    [151833] = getCrownPrice(100) .. " or " .. itemPackMoonBishop, -- Elsweyr Ceremonial Lantern, Jode,

    [165578] = itemPackVampire, -- Basin of Loss
    [165569] = itemPackVampire, -- Soul-Sworn Thrall

    [151808] = getCrownPrice(10), -- Tree, Fan Palm,
    [151813] = getCrownPrice(10), -- Sapling, Desert Acacia,
    [151816] = getCrownPrice(10), -- Plant, Flowering Thorned Succulent,
    [151820] = getCrownPrice(10), -- Desert Grass, Tall,
    [151821] = getCrownPrice(15), -- Desert Grass, Patch,
    [151831] = getCrownPrice(290), -- Elsweyr Sugar Pipe, Ceremonial,
    [151857] = getCrownPrice(150), -- Elsweyr Gazebo, Ancient Stone,
    [151867] = getCrownPrice(340), -- Hakoshae Lanterns, Festival,
    [151868] = getCrownPrice(180), -- Hakoshae Banners, Festival,
    [151869] = getCrownPrice(300), -- Elsweyr Wagon, Covered,
    [151870] = getCrownPrice(560), -- Elsweyr Wagon, Pedlar,
    [151871] = getCrownPrice(300), -- Elsweyr Dais, Temple,
    [151874] = getCrownPrice(300), -- Elsweyr Shrine, Ancient Stone,
    [151875] = getCrownPrice(560), -- Elsweyr Bridge, Ancient Stone,
    [151876] = getCrownPrice(590), -- Elsweyr Tent, Caravan,
    [151877] = getCrownPrice(590), -- Elsweyr Canopy, Bazaar,
    [151878] = getCrownPrice(450), -- Elsweyr Canopy, Peaked,
    [151883] = getCrownPrice(240), -- Tree, Towering Iroko,
    [151905] = getCrownPrice(10), -- Rock, Wide Flat Slate,
    [151911] = getCrownPrice(5), -- Rock, Flat Slate,
    [151912] = getCrownPrice(10), -- Stepping Stones, Slate,
    [151914] = getCrownPrice(25), -- Tree, Desert Acacia Tall,
    [151804] = getCrownPrice(30), -- Elsweyr Pillar, Rough Wooden,
    [151807] = getCrownPrice(5), -- Rock Field, Ancient Stone,
    [151884] = getCrownPrice(310), -- Tree, Giant Ficus,
    [151885] = getCrownPrice(310), -- Tree, Massive Ficus,
    [151872] = getCrownPrice(110), -- Boulder, Towering Lunar Spire,
    [151873] = getCrownPrice(50), -- Boulder, Lunar Crag,
    [151879] = getCrownPrice(560), -- Cactus, Lunar Tendrils,
    [151880] = getCrownPrice(640), -- Cactus, Lunar Branching,
    [151881] = getCrownPrice(640), -- Cactus, Lunar Branching Tall,
    [151882] = getCrownPrice(140), -- Cactus, Banded Lunar Violet Trio,
    [151904] = getCrownPrice(370), -- Glowgrass, Patch,
    [151913] = getCrownPrice(5), -- Rock, Slate,
  },

  [FURC_FISHING] = {},
}
