FurC.MiscItemSources = FurC.MiscItemSources or {}

local loc = FurC.Constants.Locations
local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources

local join = zo_strjoin
local strSrcLoc = FurC.Utils.FmtSrcLoc
local strDungeon = FurC.Utils.FmtDungeon
local strEvent = FurC.Utils.FormatEvent
local strLoc = FurC.Utils.FmtLocations
local strPartOf = FurC.Utils.FormatPartOf
local strPick = FurC.Utils.FormatPickpocket
local strPrice = FurC.Utils.FormatPrice
local strQuest = FurC.Utils.FmtQuest
local strScry = FurC.Utils.FormatScryingWithPieces
local strSteal = FurC.Utils.FormatSteal

local loc_vvardenfell = loc.VVARDENFELL
local loc_nelsweyr = loc.NELSWEYR
local loc_selsweyr = loc.SELSWEYR
local loc_elsweyr = { loc_nelsweyr, loc_selsweyr }
local loc_cwc = loc.CWC

-- Quests and Guilds
local questRewardString = GetString(SI_FURC_QUESTREWARD)
local tribute = GetString(SI_FURC_SRC_TOT)
local tribute_ranked = GetString(SI_FURC_SRC_TOT_RANKED)
local db_poison = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local db_sneaky = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))
local db_equip = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_EQUIP))

-- Events
local ev_blackwood = strEvent(GetString(SI_FURC_EVENT_BLACKWOOD))
local ev_hollowjack = strEvent(GetString(SI_FURC_EVENT_HOLLOWJACK))
local ev_elsweyr = strEvent(GetString(SI_FURC_EVENT_ELSWEYR))

-- Stealing

local stealable = GetString(SI_FURC_LOOT_STEALING)
local stealable_guard = strPick({ GetString(SI_FURC_NPC_GUARD) }, {})
local stealable_cc = strSteal({}, { loc_cwc })
local stealable_scholars = stealable .. GetString(SI_FURC_NPC_SCHOLAR)
local stealable_mages = stealable .. ": " .. GetString(SI_FURC_NPC_MAGE)
local stealable_nerds = stealable .. ": " .. join(",", GetString(SI_FURC_NPC_MAGE), GetString(SI_FURC_NPC_SCHOLAR))
local stealable_priests = stealable .. ": " .. GetString(SI_FURC_NPC_PRIEST)
local stealable_pilgrims = stealable .. ": " .. GetString(SI_FURC_NPC_PILGRIM)
local stealable_thief = stealable .. ": " .. GetString(SI_FURC_NPC_THIEF)
local stealable_wood = stealable .. ": " .. GetString(SI_FURC_NPC_WOODWORKER)
local stealable_drunkards = stealable .. ": " .. GetString(SI_FURC_NPC_DRUNKARD)
local stealable_loc_wrothgar = stealable .. ": " .. " loc_wrothgar"
local stealable_swamp = stealable .. " loc_murkmire"
local stealable_elsewhere = strSteal(loc_elsweyr)
local pickpocket_necrom = strPick({ loc.TELVANNI, loc.APOCRYPHA })
local painting_summerset = GetString(SI_FURC_SRC_SAFEBOX) .. strLoc(loc.SUMMERSET)

-- Looting/Harvesting
local chests_string = GetString(SI_FURC_LOOT_CHESTS)

local automaton_loot_cc = GetString(SI_FURC_NPC_AUTOMATON) .. strLoc(loc_cwc)
local automaton_loot_vv = GetString(SI_FURC_NPC_AUTOMATON) .. strLoc(loc_vvardenfell)
local chests_skyrim = chests_string .. loc.WSKYRIM
local chests_blackwood = chests_string .. loc.BLACKWOOD
local chests_summerset = chests_string .. loc.SUMMERSET
local chests_elsweyr = chests_string .. "loc_elsweyr"
local chests_high = chests_string .. loc.HIGHISLE
local chests_blackr_grcaverns = chests_string .. " in Blackreach: Greymoor Caverns"
local book_hall = "From chests in the Scrivener's Hall vault"
local nymic = "From Bastion Nymic reward chests"
local chests_necrom = chests_string .. loc.TELVANNI .. loc.APOCRYPHA
local pdung_vv_fw = strSrcLoc(GetString(SI_FURC_DROP), loc.PDUNG_VVARDENFELL_FW, loc.VVARDENFELL)
local plants_vvardenfell = GetString(SI_FURC_LOOT_PLANTS) .. "loc_vvardenfell"
local fishing = GetString(SI_FURC_LOOT_FISH)
local fishing_summerset = fishing .. loc.SUMMERSET
local fishing_swamp = fishing .. loc.MURKMIRE

-- Crowns
local function strCrown(price)
  return strPrice(price, CURT_CROWNS)
end

local function strGem(price)
  return strPrice(price, CURT_CROWN_GEMS)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2) -- use collectible number from https://wiki.esoui.com/Collectibles instead of houseIDs.
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then
    houseName = houseName .. ", " .. GetCollectibleName(houseId2)
  end
  return zo_strformat(housesource, houseName)
end
local mischouse = GetString(SI_FURC_SRC_MISCHOUSE)

local scamboxes = {
  -- Source: https://en.uesp.net/wiki/Online:Crown_Crates
  ["carnivale"] = SI_FURC_CRATE_CARNIVALE, -- ????
  ["db"] = SI_FURC_CRATE_DB, -- ????
  ["mirror"] = SI_FURC_CRATE_MIRROR, -- ????
  ["diamond"] = SI_FURC_CRATE_DIAMOND, -- 2024-07
  ["lamp"] = SI_FURC_CRATE_LAMP, -- 2024-04
  ["allmaker"] = SI_FURC_CRATE_ALLMAKER, -- 2023-12
  ["armiger"] = SI_FURC_CRATE_ARMIGER, -- 2023-09
  ["feather"] = SI_FURC_CRATE_FEATHER, -- 2023-06
  ["rage"] = SI_FURC_CRATE_RAGE, -- 2023-04
  ["stonelore"] = SI_FURC_CRATE_STONELORE, -- 2022-12
  ["wraith"] = SI_FURC_CRATE_WRAITH, -- 2022-09
  ["dark"] = SI_FURC_CRATE_DARK, -- 2022-06
  ["sunken"] = SI_FURC_CRATE_SUNKEN, -- 2022-04
  ["celestial"] = SI_FURC_CRATE_CELESTIAL, -- 2021-12
  ["harlequin"] = SI_FURC_CRATE_HARLEQUIN, -- 2021-09
  ["irony"] = SI_FURC_CRATE_IRONY, -- 2021-06
  ["ayleid"] = SI_FURC_CRATE_AYLEID, -- 2021-03
  ["potentate"] = SI_FURC_CRATE_POTENTATE, -- 2020-12
  ["sovngarde"] = SI_FURC_CRATE_SOVNGARDE, -- 2020-09
  ["nightfall"] = SI_FURC_CRATE_NIGHTFALL, -- 2020-06
  ["gloomspore"] = SI_FURC_CRATE_GLOOMSPORE, -- 2020-04
  ["frosty"] = SI_FURC_CRATE_FROSTY, -- 2020-01
  ["newmoon"] = SI_FURC_CRATE_NEWMOON, -- 2019-09
  ["baandari"] = SI_FURC_CRATE_BAANDARI, -- 2019-07
  ["dragonscale"] = SI_FURC_CRATE_DRAGONSCALE, -- 2019-04
  ["xanmeer"] = SI_FURC_CRATE_XANMEER, -- 2018-12
  ["hollowjack"] = SI_FURC_CRATE_HOLLOWJACK, -- 2018-09
  ["scalecaller"] = SI_FURC_CRATE_SCALECALLER, -- 2018-03
  ["psijic"] = SI_FURC_CRATE_PSIJIC, -- 2018-06
  ["fireatro"] = SI_FURC_CRATE_FIREATRO, -- 2017-11
  ["reaper"] = SI_FURC_CRATE_REAPER, -- 2017-09
  ["dwemer"] = SI_FURC_CRATE_DWEMER, -- 2017-07
  ["wildhunt"] = SI_FURC_CRATE_WILDHUNT, -- 2017-04
  -- no exclusive furnishings in Storm Atronach Crate 2016-12
}
local function strCrate(scamboxName)
  scamboxName = string.lower(scamboxName)
  return zo_strformat("<<1>> [<<2>>]", GetString(SI_FURC_SCAMBOX), GetString(scamboxes[scamboxName]))
end

local itempacks = {
  ["moonbishop"] = SI_FURC_ITEMPACK_MOONBISHOP,
  ["oasis"] = SI_FURC_ITEMPACK_OASIS,
  ["vampire"] = SI_FURC_ITEMPACK_VAMPIRE,
  ["heart"] = SI_FURC_ITEMPACK_HEART,
  ["cragknicks"] = SI_FURC_ITEMPACK_CRAGKNICKS,
  ["hubtreasure"] = SI_FURC_ITEMPACK_HUBTREASURE,
  ["dibella"] = SI_FURC_ITEMPACK_DIBELLA,
  ["mermaid"] = SI_FURC_ITEMPACK_MERMAID,
  ["zeni"] = SI_FURC_ITEMPACK_ZENI,
  ["windows"] = SI_FURC_ITEMPACK_WINDOWS,
  ["ambitions"] = SI_FURC_ITEMPACK_AMBITIONS,
  ["forge"] = SI_FURC_ITEMPACK_FORGE,
  ["coven"] = SI_FURC_ITEMPACK_COVEN,
  ["tyrants"] = SI_FURC_ITEMPACK_TYRANTS,
  ["khajiit"] = SI_FURC_ITEMPACK_KHAJIIT,
  ["malacath"] = SI_FURC_ITEMPACK_MALACATH,
  ["alchemist"] = SI_FURC_ITEMPACK_ALCHEMIST,
  ["azura"] = SI_FURC_ITEMPACK_AZURA,
  ["coldharbour"] = SI_FURC_ITEMPACK_COLDHARBOUR,
  ["fargrave"] = SI_FURC_ITEMPACK_FARGRAVE,
  ["aquatic"] = SI_FURC_ITEMPACK_AQUATIC,
  ["maormer"] = SI_FURC_ITEMPACK_MAORMER,
  ["newlife2018"] = SI_FURC_ITEMPACK_NEWLIFE2018,
  ["deepmire"] = SI_FURC_ITEMPACK_DEEPMIRE,
  ["dwemer"] = SI_FURC_ITEMPACK_DWEMER,
  ["vivec"] = SI_FURC_ITEMPACK_VIVEC,
  ["swamp"] = SI_FURC_ITEMPACK_SWAMP,
  ["molag"] = SI_FURC_ITEMPACK_MOLAG,
  ["ayleid"] = SI_FURC_ITEMPACK_AYLEID,
  ["sotha"] = SI_FURC_ITEMPACK_SOTHA,
  ["astula"] = SI_FURC_ITEMPACK_ASTULA,
  ["mephala"] = SI_FURC_ITEMPACK_MEPHALA,
}
local function strPack(itempackName)
  itempackName = string.lower(itempackName)
  return zo_strformat(GetString(SI_FURC_SRC_ITEMPACK), GetString(itempacks[itempackName]))
end

-- 28 Secrets of the Telvanni
FurC.MiscItemSources[ver.ENDLESS] = {
  [src.CROWN] = {
    [199112] = strCrate("allmaker"), -- Chandelier, Kyne's Radiance",
    [199111] = strCrate("allmaker"), -- Fountain, Kyne's Radiance",
    [199110] = strCrate("allmaker"), -- Snowfall, Gentle",
    [199109] = strCrate("allmaker"), -- Boulder, Clear Ice",
  },

  [src.DROP] = {
    [203472] = loc.DUNG_IA, -- Materials for Novice Necromancers",
    [203471] = loc.DUNG_IA, -- The Spotted Towers",
    [203470] = loc.DUNG_IA, -- Song of Fate",
    [203469] = loc.DUNG_IA, -- House Telvanni Song",
    [203468] = loc.DUNG_IA, -- The Waiting Door",
    [203467] = loc.DUNG_IA, -- Captain Burwarah's Records",
    [203466] = loc.DUNG_IA, -- The Silver Rose Blooms over Borderwatch",
    [203465] = loc.DUNG_IA, -- Archmagister Mavon's Ascension",
    [203464] = loc.DUNG_IA, -- Fynboar the Resurrected",
    [203463] = loc.DUNG_IA, -- Obscure Killers of the North",
    [203462] = loc.DUNG_IA, -- The Remnant Truth",
    [203461] = loc.DUNG_IA, -- Parables of Saint Vorys",
    [203460] = loc.DUNG_IA, -- Malkhest's Journal",
    [203459] = loc.DUNG_IA, -- A Servant's Tale",
    [203458] = loc.DUNG_IA, -- The Last Addition of Bikkus-Muz",
    [203457] = loc.DUNG_IA, -- Preparing Necrom Kwama, Fifth Draft",
    [203456] = loc.DUNG_IA, -- The Prior's Fulcrum",
    [203455] = loc.DUNG_IA, -- Plague Concoctor's Instructions",
    [203454] = loc.DUNG_IA, -- Dusksaber Report",
    [203453] = loc.DUNG_IA, -- Mouth Vabdru's Journal",
    [203452] = loc.DUNG_IA, -- First Mate Dalmir's Log",
    [203451] = loc.DUNG_IA, -- Fanlyrion's Journal",
    [203450] = loc.DUNG_IA, -- Tidefall Cantos I",
    [203449] = loc.DUNG_IA, -- Our Dunmer Heritage",
    [203448] = loc.DUNG_IA, -- A Feast Among the Dead, Chapter IV",
    [203447] = loc.DUNG_IA, -- A Feast Among the Dead, Chapter III",
    [203446] = loc.DUNG_IA, -- A Feast Among the Dead, Chapter II",
    [203445] = loc.DUNG_IA, -- What's an Arcanist? Part 1",
    [203444] = loc.DUNG_IA, -- What's an Arcanist? Part 2",
    [203443] = loc.DUNG_IA, -- Working in the Infinite Panopticon",
    [203442] = loc.DUNG_IA, -- What About Glyphics?",
    [203441] = loc.DUNG_IA, -- On Cipher's Midden",
    [203440] = loc.DUNG_IA, -- The Littlest Tomeshell",
    [203439] = loc.DUNG_IA, -- A New Cult Arises",
    [203438] = loc.DUNG_IA, -- Torvesard's Journal",
    [203437] = loc.DUNG_IA, -- Daedric Worship and the Dark Elves",
    [203436] = loc.DUNG_IA, -- Ciphers of the Eye",
    [203435] = loc.DUNG_IA, -- Planar Exploration Vol. 14: Darkreave Curators",
    [203434] = loc.DUNG_IA, -- Beverages for the Bereaved",
    [203433] = loc.DUNG_IA, -- Denizens of Apocrypha",
    [203432] = loc.DUNG_IA, -- History of Necrom: The City of the Dead",
    [203431] = loc.DUNG_IA, -- Brave Little Scrib and the River Troll",
    [203430] = loc.DUNG_IA, -- A Brief History of House Telvanni",
    [203429] = loc.DUNG_IA, -- A Feast Among the Dead, Chapter I",
    [203428] = loc.DUNG_IA, -- Visitor's Guide: Telvanni Peninsula",
    [203427] = loc.DUNG_IA, -- Critter Dangers: Telvanni Peninsula",
    [203426] = loc.DUNG_IA, -- We Reject the Pact",
    [203425] = loc.DUNG_IA, -- Our Puny Allies",
    [203424] = loc.DUNG_IA, -- The Spires of the 34th Sermon",
    [203423] = loc.DUNG_IA, -- Master of the Tides of Fate",
    [203422] = loc.DUNG_IA, -- On the Nature of Nymics",
    [203421] = loc.DUNG_IA, -- The Dangers of Truth",
    [203420] = loc.DUNG_IA, -- A Summoner's Guide to Nymics",
    [203419] = loc.DUNG_IA, -- Kynmarcher Strix's Journal",
    [203418] = loc.DUNG_IA, -- Life in the Camonna Tong",
    [203417] = loc.DUNG_IA, -- Herma-Mora: The Woodland Man?",
    [203416] = loc.DUNG_IA, -- How Rajhin Stole the Book that Knows",
    [203415] = loc.DUNG_IA, -- On Tracts Perilous",
    [203414] = loc.DUNG_IA, -- Uluscant's Manifesto",
    [203413] = loc.DUNG_IA, -- The Currency of Secrets",
    [203412] = loc.DUNG_IA, -- On Joining the Keepers of the Dead",
    [203411] = loc.DUNG_IA, -- A Report on the Dusksabers",
    [203410] = loc.DUNG_IA, -- Ranks and Titles of House Telvanni",
    [203409] = loc.DUNG_IA, -- Oath of the Keepers",
    [203408] = loc.DUNG_IA, -- Larydeilmo is Sane",
    [203407] = chests_string .. " in Wrothgar", -- Vosh Rakh",
    [203406] = chests_string .. " in Wrothgar", -- Vorgrosh Rot-Tusk's Guide to Dirty Fighting",
    [203405] = chests_string .. " in Wrothgar", -- Orc Clans and Symbology",
    [203404] = chests_string .. " in Wrothgar", -- Birds of Wrothgar",
    [203403] = chests_summerset, -- The Ubiquitous Sinking Isle",
    [203402] = chests_summerset, -- The Truth of Minotaurs",
    [203401] = chests_summerset, -- The Flight of Gryphons",
    [203400] = chests_summerset, -- Artaeum Lost",
    [203399] = chests_string .. " loc_selsweyr", -- The Marriage of Moon and Tide",
    [203398] = chests_string .. " loc_selsweyr", -- The Favored Daughter of Fadomai",
    [203397] = chests_string .. " loc_selsweyr", -- Khunzar-ri and the Lost Alfiq",
    [203396] = chests_string .. " loc_selsweyr", -- Azurah's Crossing",
    [203395] = chests_string .. " loc_selsweyr", -- Trail and Tide",
    [203394] = chests_string .. " loc_selsweyr", -- The Angry Alfiq: A Collection",
    [203393] = chests_string .. " loc_selsweyr", -- On Those Who Know Baan Dar",
    [203392] = loc.DUNG_IA, -- Anequina and Pellitine: An Introduction",
    [203391] = chests_string .. " " .. " loc_hewsbane", -- The Red Curse, Volume 3",
    [203390] = chests_string .. " " .. " loc_hewsbane", -- The Red Curse, Volume 2",
    [203389] = chests_string .. " " .. " loc_hewsbane", -- The Red Curse, Volume 1",
    [203388] = chests_string .. " in the Gold Coast", -- The Wolf and the Dragon",
    [203387] = chests_string .. " in the Gold Coast", -- The Blade of Woe",
    [203386] = chests_string .. " in the Gold Coast", -- On Minotaurs",
    [203385] = chests_string .. " in the Gold Coast", -- Cathedral Hierarchy",
    [203384] = chests_string .. " in Coldharbour", -- Journal of Tsona-Ei, Part Two",
    [203383] = chests_string .. " in Coldharbour", -- Journal of Tsona-Ei, Part Three",
    [203382] = chests_string .. " in Coldharbour", -- Journal of Tsona-Ei, Part One",
    [203381] = chests_string .. " in Coldharbour", -- Journal of Tsona-Ei, Part Four",
    [203380] = chests_string .. " in Clockwork City", -- Worshiping the Illogical",
    [203379] = chests_string .. " in Clockwork City", -- The Blackfeather Court",
    [203378] = chests_string .. " in Clockwork City", -- Engine of Expression",
    [203377] = chests_string .. " in Clockwork City", -- A Brief History of Ald Sotha",
    [203211] = loc.DUNG_IA, -- Apocrypha Crescent",
    [203210] = loc.DUNG_IA, -- Apocrypha Spike, Curved",
    [203209] = loc.DUNG_IA, -- Apocrypha Spike, Tall",
    [203208] = loc.DUNG_IA, -- Apocrypha Pipe, Small",
    [203207] = loc.DUNG_IA, -- Apocrypha Pipe, Small Curved",
    [203206] = loc.DUNG_IA, -- Apocrypha Pipe, Medium",
    [203204] = loc.DUNG_IA, -- Apocrypha Pipe, Large Curved",
    [199117] = tribute, -- Chromatic Reservoir Tapestry, Large",
    [199116] = tribute, -- Chromatic Reservoir Tapestry",
    [199115] = tribute, -- Seeker Aspirant Tapestry, Large",
    [199114] = tribute, -- Seeker Aspirant Tapestry",

    [199933] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Scrying Brazier, Tall",
    [199932] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Scrying Brazier, Short",
    [199890] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Archival Light Diffuser, Large",
    [199132] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Tree",
    [199131] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Wall Beast",
    [199130] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Slug",
    [199129] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Ribcage",
    [199128] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Watchful Light",
    [199127] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Petrified Watcher",
    [199126] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Forged Black Book",
    [199119] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Infinite Tome",
    [199118] = strScry(5, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Clothing Station",
    [198576] = strScry(0, loc.DEADLANDS), -- Shelf, Black Soul Gems",
    [198575] = strScry(0, loc.SELSWEYR), -- Khajiiti Well",
    [198573] = strScry(0, loc.SUMMERSET), -- High Elf Altar, Crystal",
    [198572] = strScry(0, loc.CWC), -- Clockwork Wall Gears",
    [198571] = strScry(0, loc.GOLDCOAST), -- Shrine to Dibella",
    [198570] = strScry(0, loc.SHADOWFEN), -- Painted Stone Frog",
    [198569] = strScry(0, loc.DESHAAN), -- Dark Elf Altar, Ceremonial",
    [198568] = strScry(0, loc.ALIKR), -- Stone Relief, Yokudan",
    [198567] = strScry(0, loc.GLENUMBRA), -- Breton Well, Storm Grey",
    [198566] = strScry(0, loc.REAPER), -- Khajiiti Arch, Rising",
    [198325] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Vision of Mora",
    [197916] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Archival Light Diffuser, Small",
  },
}

-- 27 Base Game Patch
FurC.MiscItemSources[ver.BASED] = {
  [src.CROWN] = {
    [197823] = strCrate("armiger"), -- Necrom Podium, Buoyant Armiger
    [197824] = strCrate("armiger"), -- Harrowstorm Mists
    [197822] = strCrate("armiger"), -- Redoran Sconce, Beetle
    [197821] = strCrate("armiger"), -- Spellscar Bridge
  },
}

-- 26 Necrom
FurC.MiscItemSources[ver.NECROM] = {
  [src.CROWN] = {
    [197624] = strCrown(1200), -- Apocryphal Shifting Sculpture",

    [197622] = join(", ", strCrate("feather"), strGem(400)), -- Constellation Projection Apparatus",
    [197621] = join(", ", strCrate("feather"), strGem(40)), -- Household Shrine, Meridian",
    [197620] = join(", ", strCrate("feather"), strGem(100)), -- Throne of the Lich",
    [197619] = join(", ", strCrate("feather"), strGem(100)), -- Meridian Mote",
  },

  [src.DROP] = {
    [197921] = nymic, -- Peryite's Salvation",
    [197920] = nymic, -- The Doom of the Hushed",
    [197919] = nymic, -- The Legend of Fathoms Drift",
    [197918] = nymic, -- Deal with a Daedric Prince",
    [197917] = nymic, -- Ode to Vaermina",
    [197829] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Music Box, Glyphic Secrets",
    [197783] = chests_necrom, -- Pilgrimage Triptych Painting, Wood",
    [197782] = chests_necrom, -- Alleyway Still Life Painting",
    [197781] = chests_necrom, -- The City of Necrom Painting, Wood",
    [197780] = "Reward for completeing Sharp-as-Night's rapport quests", -- Letter from Sharp",
    [197779] = "Reward for completeing Azandar's rapport quests", -- Letter from Azandar",
    [197755] = chests_necrom, -- Shadow over Necrom Painting",
    [197754] = chests_necrom, -- Offerings to the Dead Painting, Wood",
    [197753] = chests_necrom, -- Telvanni Peninsula Painting, Wood",
    [197752] = chests_necrom, -- Mycoturge's Retreat Painting, Wood",
    [197751] = chests_necrom, -- Sunset Fleet Painting, Wood",
    [197750] = chests_necrom, -- Telvanni Mushroom Spire Painting, Wood",
    [197749] = chests_necrom, -- Necrom Still Life Painting, Wood",
    [197712] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of Apocrypha",
    [197711] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Antique Map of the Telvanni Peninsula",
    [197710] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Mushroom Classification Book",
    [197709] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Tribunal Window, Stained Glass",
    [197708] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Cliffracer Skeleton Stand",
    [197707] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Apocryphal Well",
    [197706] = strScry(3, loc.TELVANNI, loc.APOCRYPHA), -- Trifold Mirror of Alternatives",
    [197705] = strScry(10, loc.TELVANNI, loc.APOCRYPHA), -- Telvanni Alchemy Station",
    [197703] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Arch",
    [197702] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Worm",
    [197701] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Nautilus",
    [197700] = strScry(0, loc.TELVANNI, loc.APOCRYPHA), -- Apocrypha Fossil, Bones Large",
    [197647] = pickpocket_necrom, -- Telvanni Knife, Bread",
    [197646] = pickpocket_necrom, -- Telvanni Knife, Wooden",
    [197645] = pickpocket_necrom, -- Telvanni Fork, Wooden",
    [197644] = pickpocket_necrom, -- Telvanni Spoon, Wooden",
    [193786] = tribute, -- Mercymother Elite Tribute Tapestry",
    [193785] = tribute, -- Mercymother Elite Tribute Tapestry, Large",
    [193784] = tribute, -- Hand of Almalexia Tribute Tapestry",
    [193783] = tribute, -- Hand of Almalexia Tribute Tapestry, Large",
  },
}

-- 25 Scribes of Fate
FurC.MiscItemSources[ver.SCRIBE] = {

  [src.CROWN] = {
    [194411] = strCrown(240), -- Stonelore Tale Pillar, Rounded Stone,
    [194410] = strCrown(240), -- Stonelore Tale Pillar, Slanted Stone,
    [194409] = strCrown(140), -- Potted Tree, Systres Pine,
    [194408] = strCrown(150), -- Systres Brewing Still, Copper,
    [194407] = strCrown(40), -- Harbor Rope, Hanging,
    [194406] = strCrown(110), -- Harbor Rope, Coiled Buoy,
    [194405] = strCrown(40), -- Harbor Line, Coiled,
    [194404] = strCrown(40), -- Harbor Line, Loose,
    [194403] = strCrown(110), -- Harbor Netting, Buoy Cluster,
    [194402] = strCrown(110), -- Harbor Netting, Hanging Wall,
    [194401] = strCrown(150), -- Galen Dogwood, Medium Cluster,
    [194400] = strCrown(170), -- Galen Dogwood, Large,
    [194399] = strCrown(1000), -- Music Box, Unfathomable Knowledge,

    [193818] = strPack("astula"), -- Shad Astula Scholar, Right,
    [193817] = strPack("astula"), -- Shad Astula Scholar, Left,

    [193796] = join(", ", strCrate("rage"), strGem(100)), -- Orb of the Spirit Queen,
    [193795] = join(", ", strCrate("rage"), strGem(40)), -- Rite of the Harrowforged,
    [193794] = join(", ", strCrate("rage"), strGem(100)), -- Target Hagraven, Robust,
    [193793] = join(", ", strCrate("rage"), strGem(40)), -- Reach Chandelier, Hagraven,
  },

  [src.DROP] = {
    [194460] = book_hall, -- Apocrypha, Apocrypha,
    [194459] = book_hall, -- Dream of a Thousand Dreamers,
    [194458] = book_hall, -- Lord Hollowjack's Dream Realm,
    [194456] = book_hall, -- Invocation of Hircine,
    [194455] = book_hall, -- Havocrel: Strangers from Oblivion,
    [194454] = book_hall, -- The Waters of Oblivion,
    [194453] = book_hall, -- A Memory Book, Part 1,
    [194452] = book_hall, -- A Memory Book, Part 2,
    [194451] = book_hall, -- A Memory Book, Part 3,
    [194450] = book_hall, -- Thwarting the Daedra: Dagon's Cult,
    [194449] = book_hall, -- In Dreams We Awaken,
    [194448] = book_hall, -- Glorious Upheaval,
    [194447] = book_hall, -- Stonefire Ritual Tome,
    [194446] = book_hall, -- Bisnensel: Our Ancient Roots,
    [194445] = book_hall, -- Boethiah and Her Avatars,
    [194444] = book_hall, -- Persistence of Daedric Veneration,
    [194443] = book_hall, -- Daedra Dossier: The Titans,
    [194442] = book_hall, -- Journal of Culanwe,
    [194441] = book_hall, -- Graccus' Journal, Volume I,
    [194440] = book_hall, -- Tome of Daedric Portals,
    [194439] = book_hall, -- The Journal of Emperor Leovic,
    [194423] = book_hall, -- Hermaeus Mora Banner, Long,
    [194422] = book_hall, -- Hermaeus Mora Banner, Extra Long,
    [194421] = book_hall, -- Nesting Boulder, Green,
    [194420] = book_hall, -- Nesting Stones, Green,
    [194419] = book_hall, -- Scrivener's Hall Vault Door,
  },
}

-- 24 Firesong
FurC.MiscItemSources[ver.DRUID] = {
  [src.CROWN] = {
    [192429] = join(",", strCrown(110), strPack("maormer")), -- Maormer Sconce, Serpentine
    [192427] = join(",", strCrown(70), strPack("maormer")), -- Maormer Lamp, Serpentine
    [192425] = join(",", strCrown(150), strPack("maormer")), -- Maormer Teapot, Serpentine
    [192423] = join(",", strCrown(340), strPack("maormer")), -- Maormer Runner, Amethyst Waves
    [192422] = join(",", strCrown(80), strPack("maormer")), -- Maormer Half-Rug
    [192420] = join(",", strCrown(180), strPack("maormer")), -- Maormer Rug, Serpentine
    [192418] = join(",", strCrown(10), strPack("maormer")), -- Maormer Mug, Serpentine
    [192414] = join(",", strCrown(160), strPack("maormer")), -- Maormer Armchair, Carved
    [192413] = join(",", strCrown(180), strPack("maormer")), -- Maormer Table, Carved
    [192412] = join(",", strCrown(340), strPack("maormer")), -- Maormer Curtain, Serpentine Cloth
    [192410] = join(",", strCrown(85), strPack("maormer")), -- Maormer Chair, Carved
    [192409] = join(",", strCrown(3000), strPack("maormer")), -- Maormer Cookfire
    [192408] = join(",", strCrown(70), strPack("maormer")), -- Maormer Trunk, Carved
    [192407] = join(",", strCrown(720), strPack("maormer")), -- Maormer Tent, Raider's
    [192406] = strPack("maormer"), -- Maormer Ship's Prow, Serpentine
    [192405] = strPack("maormer"), -- Maormer Tent, Raid Leader's

    [190945] = strCrown(5000), -- Tree, Seasons of Y'ffre
    [190940] = strCrown(1000), -- Music Box, Songbird's Paradise",

    [190951] = join(", ", strCrate("stonelore"), strGem(100)), -- Target Spriggan, Robust
    [190950] = join(", ", strCrate("stonelore"), strGem(40)), -- Rose Petal Cascade
    [190947] = join(", ", strCrate("stonelore"), strGem(40)), -- Druidic Arch, Floral
    [190946] = join(", ", strCrate("stonelore"), strGem(40)), -- Earthen Root Essence
  },

  [src.DROP] = {
    [192432] = strScry(3, loc.GALEN), -- Shipbuilder's Woodworking Station",
    [192431] = strScry(0, loc.GALEN), -- Antique Map of Galen",
    [192430] = strScry(0, loc.GALEN), -- Vulk'esh Egg",
    [192404] = tribute, -- Forest Wraith Tribute Tapestry, Large",
    [192403] = tribute, -- Forest Wraith Tribute Tapestry",
    [192402] = tribute, -- The Chimera Tribute Tapestry, Large",
    [192401] = tribute, -- The Chimera Tribute Tapestry",
    [190938] = strScry(5, loc.GALEN), -- Music Box, Blessings of Stone",
    [187922] = strScry(0, loc.FARGRAVE), -- Antique Map of Fargrave",
  },
}

-- 23 Lost Depths
FurC.MiscItemSources[ver.DEPTHS] = {
  [src.CROWN] = {
    [189465] = strCrown(1200), -- Music Box, Gonfalon Galliard,
    [189464] = strCrown(1000), -- Music Box, Deeproot Dirge,
    [189463] = strCrown(3500), -- Statue, Bendu Olo,

    [188344] = join(", ", strCrate("wraith"), strGem(40)), -- Y'ffre's Falling Leaves, Autumn,
    [188343] = join(", ", strCrate("wraith"), strGem(100)), -- Moonlight Path Bridge,
    [188342] = join(", ", strCrate("wraith"), strGem(40)), -- Bat Swarm, Domesticated,
    [188341] = join(", ", strCrate("wraith"), strGem(100)), -- Red Diamond Stained Glass,
  },

  [src.DROP] = {
    [187807] = tribute_ranked, -- Tribute Trophy, Voidsteel,
    [187806] = tribute_ranked, -- Tribute Trophy, Quicksilver,
    [187805] = tribute_ranked, -- Tribute Trophy, Ebony,
    [187804] = tribute_ranked, -- Tribute Trophy, Orichalcum,
  },
}

-- 22 High Isle
FurC.MiscItemSources[ver.BRETON] = {
  [src.CROWN] = {
    [187865] = strCrown(55), -- Flowers, Butterweed Cluster
    [187861] = strCrown(110), -- High Isle Hourglass, Compass Rose
    [187860] = strCrown(65), -- High Isle Vase, Gilded
    [187667] = strCrown(1200), -- Music Box, High Isle Duel
    [187666] = strCrown(1000), -- Music Box, Steadfast Armistice
    [187665] = strCrown(3500), -- Statue, Kynareth's Blessings
    [187664] = strCrown(6000), -- Target Deadlands Harvester, Trial
    [147926] = strCrown(6000), -- Target Iron Atronach, Trial

    [187663] = join(", ", strCrate("dark"), strGem(40)), -- Blue Fang Shark, Mounted
    [187662] = join(", ", strCrate("dark"), strGem(100)), -- House Dufort Chandelier
    [187661] = join(", ", strCrate("dark"), strGem(40)), -- Mage's Flame
    [187660] = join(", ", strCrate("dark"), strGem(100)), -- Mages Guild Stained Glass
  },

  [src.DROP] = {
    [188285] = tribute, -- Serpentguard Rider Tribute Tapestry, Large
    [188284] = tribute, -- Serpentguard Rider Tribute Tapestry
    [188283] = tribute, -- Pyandonean War Fleet Tribute Tapestry, Large
    [188282] = tribute, -- Pyandonean War Fleet Tribute Tapestry
    [188281] = tribute, -- Prowling Shadow Tribute Tapestry, Large
    [188280] = tribute, -- Prowling Shadow Tribute Tapestry
    [188279] = tribute, -- Knight Commander Tribute Tapestry, Large
    [188278] = tribute, -- Knight Commander Tribute Tapestry
    [188277] = tribute, -- Hlaalu Councilor Tribute Tapestry, Large
    [188276] = tribute, -- Hlaalu Councilor Tribute Tapestry
    [188275] = tribute, -- Hagraven Matron Tribute Tapestry, Large
    [188274] = tribute, -- Hagraven Matron Tribute Tapestry
    [188273] = tribute, -- Blackfeather Knight Tribute Tapestry, Large
    [188272] = tribute, -- Blackfeather Knight Tribute Tapestry
    [188202] = "Reward for completeing Isobel's rapport quests", -- Letter From Isobel
    [188201] = "Reward for completeing Ember's rapport quests", -- Letter From Ember
    [187877] = chests_high, -- Gates of Gonfalon Bay Painting, Wood
    [187876] = chests_high, -- Gonfalon Colossus Painting, Wood
    [187875] = chests_high, -- Tor Draioch Towers Painting, Wood
    [187874] = chests_high, -- Masted Behemoth Painting, Wood
    [187873] = chests_high, -- Abecean Bounty Painting, Wood
    [187872] = chests_high, -- Light's Warning Painting, Wood
    [187871] = chests_high, -- High Isle Seahome Painting, Metal
    [187870] = chests_high, -- Gifts of the Sun Painting, Metal
    [187869] = chests_high, -- Noble Still Life Painting, Metal
    [187868] = chests_high, -- Ascendant Silence Painting, Metal
    [187808] = tribute_ranked, -- Tribute Trophy, Rubedite
    [187802] = strScry(0, loc.HIGHISLE), -- Druidic Provisioning Station
    [187801] = strScry(0, loc.HIGHISLE), -- Sea Elf Galleon Helm
    [187800] = strScry(0, loc.HIGHISLE), -- Draoife Storystone
    [187799] = strScry(0, loc.HIGHISLE), -- Antique Map of High Isle
  },
}

-- 21 Ascending Tide
FurC.MiscItemSources[ver.TIDES] = {
  [src.CROWN] = {
    [184250] = strCrown(240), -- Nedic Banner, Ancient,
    [184249] = join(", ", strCrown(20), strPack("aquatic")), -- Elkhorn Coral, Branching,
    [184248] = join(", ", strCrown(20), strPack("aquatic")), -- Stones, Coral Cluster,
    [184247] = join(", ", strCrown(45), strPack("aquatic")), -- Brittle-Vein Coral, Cluster,
    [184246] = strCrown(130), -- Nedic Bench, Carved,
    [184245] = strCrown(610), -- Nedic Chandelier, Swords,
    [184244] = strCrown(110), -- Nedic Sconce, Torch,
    [184243] = strCrown(640), -- Nedic Brazier, Cold-Flame Pillar,
    [184242] = strCrown(370), -- Nedic Brazier, Cold-Flame,
    [184205] = join(", ", strCrown(120), strPack("aquatic")), -- Sand Drift, Oceanic,
    [184175] = strCrown(3500), -- Statue, Ancestor-King Auri-El,
    [184112] = join(", ", strCrown(170), strPack("aquatic")), -- Lilac Coral, Strong,
    [184111] = join(", ", strCrown(170), strPack("aquatic")), -- Lilac Anemone, Sprout,
    [184110] = join(", ", strCrown(170), strPack("aquatic")), -- Verdant Anemone, Strong,
    [184109] = join(", ", strCrown(90), strPack("aquatic")), -- Kelp Grouping, Robust,
    [184108] = join(", ", strCrown(90), strPack("aquatic")), -- Kelp Grouping, Thin,
    [184107] = join(", ", strCrown(20), strPack("aquatic")), -- Kelp Stalk, Tall,
    [184106] = join(", ", strCrown(20), strPack("aquatic")), -- Kelp Stalk, Plain,
    [184105] = join(", ", strCrown(45), strPack("aquatic")), -- Green Algae Coral Formation, Tree Capped,
    [184104] = join(", ", strCrown(45), strPack("aquatic")), -- Red Algae Coral Formation, Waving Hands,
    [184103] = join(", ", strCrown(45), strPack("aquatic")), -- Red Algae Coral Formation, Tree Antler,
    [183894] = strPack("aquatic"), -- Nedic Chest, Bubbling,
    [183893] = join(", ", strCrown(1500), strPack("aquatic")), -- Bubbles of Aeration,
    [183892] = join(", ", strCrown(430), strPack("aquatic")), -- Minnow School,
    [183891] = strPack("aquatic"), -- Jellyfish Bloom, Heliotrope,
    [183856] = strPack("aquatic"), -- Target Mudcrab, Robust Coral,
    [183201] = strCrown(1000), -- Music Box: Bleak Beacon Shanty,
    [183200] = strCrown(1100), -- Music Box: Wonders of the Shoals,
    [183198] = join(", ", loc.FARGRAVE, strCrown(10)), -- Bushes, Withered Cluster,
    [178477] = strCrown(170), -- Nedic Bookcase, Filled,
    [120853] = "This is craftable, or " .. strCrown(430), -- Stockade,

    [184127] = join(", ", strCrate("sunken"), strGem(40)), -- Tranquility Pond, Botanical,
    [184126] = join(", ", strCrate("sunken"), strGem(100)), -- Waterfall Fountain, Round,
    [184072] = join(", ", strCrate("sunken"), strGem(100)), -- Aquarium, Large Abecean Coral,
    [184071] = join(", ", strCrate("sunken"), strGem(40)), -- Aquarium, Abecean Coral,
  },
}

-- 20 Deadlands
FurC.MiscItemSources[ver.DEADL] = {
  --[[ ============== To do: =======================

	Furnishing packs!
		Limited Time -
			intrepid gourmet
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

	 Can I add a separate crown source for housing editor vs normal crown store? Seems like it should be fairly easy. Model after SI_FURC_SRC_CROWNSTORE and strCrown

	 Add seals of endeavor prices with the gem prices for crate items (can I add a constant for pricing? ie: strGem(40) would output "40 Gems or 2000 Endeavors"

	 Learn how to add housing sources (I see it there, just need to play with it)

	 Sort things into their proper versions! I've been adding most things to the top of the most recent version, but sorting needs to happen!
	]]

  [src.DROP] = {
    [178694] = ev_blackwood, -- Target Ogrim,
    [166960] = "From combining Stone Husk Fragments from the Labyrinthian in Western Skyrim", -- Target Stone Husk,

    [182302] = strScry(3, loc.DEADLANDS), -- Daedric Enchanting Station,
    [175728] = strScry(0, loc.BLACKWOOD), -- Z'en Idol,
    [175729] = strScry(0, loc.BLACKWOOD), -- Kothringi Tidal Canoe,
    [178459] = strScry(0, loc.BLACKWOOD), -- Antique Map of Blackwood,
    [183196] = strScry(0, loc.DEADLANDS), -- Antique Map of the Deadlands,
    [171431] = strScry(0, loc.REACH), -- Antique Map of the Reach,
    [165992] = strScry(0, loc.WSKYRIM), -- Antique Map of Western Skyrim
    [163431] = strScry(3, loc.ANY), -- Music Box, Aldmeri Symphonia "in dreams and memories"
    [182303] = strScry(0, loc.DEADLANDS), -- Dagon's Scalding Gibbet,
    [165863] = strScry(0, loc.GRAHTWOOD), -- St. Alessia, Paravant

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

  [src.CROWN] = {
    [171857] = strCrown(3000), -- Aetherial Well,

    -- ==================== Crown Housing Editor ==============================
    [182915] = strCrown(260), -- Fargrave Container Plants, Long,
    [182916] = strCrown(260), -- Fargrave Container Plant, Large Square,
    [182917] = strCrown(260), -- Fargrave Container Plants, Large Round,
    [182914] = strCrown(140), -- Fargrave Container Plants,
    [182913] = strCrown(140), -- Fargrave Container Plants, Small,
    [141832] = strCrown(70), -- Tree, Robust Fig,
    [141833] = strCrown(150), -- Tree, Ancient Fig,
    [141834] = strCrown(170), -- Tree, Towering Fig,
    [141835] = strCrown(70), -- Tree, Whorled Fig,
    [181532] = strCrown(3600), -- Leyawiin Fountain, Round Grand,
    [182281] = strCrown(2300), -- Fargrave Fountain,
    [118148] = join(",", strCrown(80), mischouse), --Firelogs, Ashen,
    [118146] = join(",", strCrown(80), mischouse), --Firelogs, Flaming,
    [118147] = join(",", strCrown(80), mischouse), --Firelogs, Charred,
    [167294] = join(",", strCrown(20), mischouse), -- Boulder, Jagged Stone,
    [118350] = strCrown(25), --Box of Tangerines,
    [118352] = strCrown(25), --Box of Oranges,
    [118353] = strCrown(25), --Box of Grapes,
    [118354] = strCrown(25), --Box of Fruit,
    [134278] = strCrown(3500), --Clockwork Alchemy Station,
    [134279] = strCrown(3500), --Clockwork Blacksmithing Station,
    [134282] = strCrown(3500), --Clockwork Woodworking Station,
    [134281] = strCrown(3500), --Clockwork Clothing Station,
    [134277] = strCrown(3000), --Clockwork Provisioning Station,
    [134276] = strCrown(4500), --Clockwork Dye Station,
    [134280] = strCrown(3500), --Clockwork Enchanting Station,
    [139064] = join(",", strCrown(20), mischouse), -- Flowers, Hummingbird Mint
    [118175] = strCrown(170), --Shutters, Hinged Lattice,
    [118174] = strCrown(170), --Shutters, Blue Lattice,
    [118173] = strCrown(170), --Shutters, Blue Hinged,
    [118172] = strCrown(170), --Shutters, Blue Slatted,
    [118171] = strCrown(170), --Shutters, Blue Hatch,
    [118170] = strCrown(170), --Shutters, Blue Double,
    [118169] = strCrown(170), --Shutters, Blue Single,
    [141845] = strCrown(370), -- Mushrooms, Climbing Ambershine
    [141846] = strCrown(370), -- Mushrooms, Ambershine Cluster
    [141844] = strCrown(70), -- Plants, Amber Spadeleaf Cluster
    [182918] = strCrown(160), -- Boulder, Weathered Fargrave,
    [182919] = strCrown(160), -- Rocks, Fargrave Cluster,
    [141841] = strCrown(40), -- Tree Ferns, Cluster,
    [141842] = strCrown(10), -- Tree Ferns, Juvenile Cluster,
    [171817] = join(",", strCrown(730), mischouse), -- Ayleid Chandelier, Caged,
    [181602] = strCrown(30), -- Bush, Low Greenleaf Cluster,
    [181604] = strCrown(30), -- Bush, Snow Lillies,
    [182935] = strCrown(140), -- Stump, Charred Deadlands,
    [182934] = strCrown(140), -- Log, Charred Deadlands,
    [182933] = strCrown(260), -- Tree, Charred Large Deadlands,
    [182932] = strCrown(260), -- Tree, Charred Large Twisted Deadlands,
    [182931] = strCrown(140), -- Tree, Charred Deadlands,
    [182930] = strCrown(110), -- Plant, Pixas,
    [182929] = strCrown(110), -- Plant, Hynvik,
    [125581] = strCrown(25), -- Mushroom, Buttercake,

    --======================= Limited Time Crown Store Items ==========================
    [156645] = strCrown(4000), -- Statue, Kaalgrontiid's Ascent
    [159439] = strCrown(3500), -- Statue, Pride of Alkosh Hero
    [147646] = strCrown(3000), -- Meridia, Lady of Infinite Energies,
    [165991] = strCrown(3500), -- Statue, Vampiric Sovereign
    [147747] = strCrown(2500), -- Cadwell's Astounding Portal
    [147746] = strCrown(1400), -- Bust: Abnur Tharn

    --======================= Music Boxes ===========================================
    [156554] = strCrown(800), -- Music Box, A Frost Melt Melody
    [171943] = strCrown(1000), -- Music Box, The Liberation of Leyawiin,
    [142235] = strCrown(800), -- Music Box, Flickering Shadows
    [171543] = strCrown(1000), -- Music Box, Feast of All Flames,
    [171944] = strCrown(1000), -- Music Box, The Mirefrog's Hymn,
    [171542] = strCrown(800), -- Music Box, Farewell to Nenalata,
    [167428] = strCrown(1000), -- Music Box, Mother Morrowind's Sacred Lullaby,
    [167429] = strCrown(1000), -- Music Box, Never Fall, Never Die,
    [167007] = strCrown(1000), -- Music Box, Subterranean Sonata,
    [167006] = strCrown(1000), -- Music Box, Hymn of Five-Hundred Axes,
    [153634] = strCrown(800), -- Music Box, Diamond Melody
    [163428] = strCrown(800), -- Music Box, The Shadows Stir
    [163429] = strCrown(1000), -- Music Box, Enigmas of the Elder Way
    [156553] = strCrown(800), -- Music Box, That Breezy Night in Bruma
    [159596] = strCrown(800), -- Music Box, The Mad Harlequin's Reverie
    [159598] = strCrown(800), -- Music Box, Dreams of Yokuda
    [151909] = strCrown(800), -- Music Box, A Clash of Fang and Flame
    [151910] = strCrown(800), -- Music Box, Dancing Among the Flowers Fine
    [147507] = strCrown(800), -- Music Box, Hinterlands
    [147505] = strCrown(800), -- Music Box, Y'ffre in Every Leaf
    [147506] = strCrown(800), -- Music Box, Sands of the Alik'r
    [178522] = strCrown(800), -- Music Box, Silver Rose
    [181636] = strCrown(1000), -- Music Box, \"Fargrave Daydreams\",
    [181637] = strCrown(1200), -- Music Box, \"Time's Architect\",
    [153633] = strCrown(800), -- Music Box, The Ghosts of Frostfall
    [178521] = strCrown(1000), -- Music Box, \"Invitation to Chaos\",

    -- ====================== Crown Furnishing Packs =============================
    [156775] = strPack("heart"), -- Bed, Petal-Strewn Double
    [156764] = join(",", strCrown(85), strPack("heart")), -- Bouquet, Small Dibella's
    [156776] = join(",", strCrown(85), strPack("heart")), -- Bouquet, Large Dibella's
    [156777] = join(",", strCrown(85), strPack("heart")), -- Bouquet, Medium Dibella's
    [156765] = join(",", strCrown(290), strPack("heart")), -- Chair, Love-Blessed
    [156766] = join(",", strCrown(180), strPack("heart")), -- Petals, Blanket
    [156767] = strPack("heart"), -- Sweetroll Platter
    [156768] = join(",", strCrown(100), strPack("heart")), -- Love's Flame Candlestick
    [156769] = join(",", strCrown(500), strPack("heart")), -- Kitten Moppet, Heart's Promise
    [156770] = join(",", strCrown(500), strPack("heart")), -- Kitten Moppet, Love-Blessed
    [156771] = join(",", strCrown(410), strPack("heart")), -- Table, Love-Blessed
    [156772] = join(",", strCrown(340), strPack("heart")), -- Petals, Large Blanket
    [156773] = join(",", strCrown(180), strPack("heart")), -- Rug, Love-Blessed
    [156774] = join(",", strCrown(180), strPack("heart")), -- Tapestry, Love-Blessed
    [156778] = join(",", strCrown(85), strPack("heart")), -- Flower, Dibella's Promise
    [134971] = join(",", strCrown(100), strPack("heart")), -- Candles, Votive Group

    [134879] = strPack("hubtreasure"), -- Hubalajad's Reflection
    [134880] = strPack("hubtreasure"), -- Ra Gada Reliquary, Miniature Palace,
    [134881] = strPack("hubtreasure"), -- In Defense of Prince Hubalajad,
    [134882] = join(",", strCrown(90), strPack("hubtreasure")), -- Gold Drakes, Pristine,
    [134883] = join(",", strCrown(360), strPack("hubtreasure")), -- Ra Gada Funerary Statue, Stone Cat,
    [134884] = join(",", strCrown(360), strPack("hubtreasure")), -- Ra Gada Funerary Statue, Gilded Cat,
    [134885] = join(",", strCrown(360), strPack("hubtreasure")), -- Ra Gada Funerary Statue, Gilded Ibis,
    [134886] = join(",", strCrown(360), strPack("hubtreasure")), -- Ra Gada Funerary Statue, Gilded Servant,
    [134887] = join(",", strCrown(2000), strPack("hubtreasure")), -- Ra Gada Guardian Statue, Lion Ibis,
    [134888] = join(",", strCrown(2000), strPack("hubtreasure")), -- Ra Gada Guardian Statue, Winged Bull,
    [134889] = join(",", strCrown(2000), strPack("hubtreasure")), -- Ra Gada Guardian Statue, Riding Camel,
    [117901] = join(",", strCrown(140), strPack("hubtreasure")), --Redguard Amphora, Gilded,
    [117894] = join(",", strCrown(240), strPack("hubtreasure")), --Redguard Divider, Gilded,
    [117904] = join(",", strCrown(190), strPack("hubtreasure")), --Redguard Trunk, Garish,
    [134823] = strPack("hubtreasure"), -- Target Mournful Aegis,

    [117906] = join(",", ev_elsweyr, strPack("cragknicks")), -- Redguard Urn, Gilded
    [121053] = join(",", strCrown(170), strPack("cragknicks"), strPack("hubtreasure")), -- Jar, Gilded Canopic
    [121046] = strPack("cragknicks"), -- Cheeses of Tamriel,
    [121049] = strPack("cragknicks"), -- Parcels, Wrapped,
    [120417] = strPack("cragknicks"), -- Redguard Barrel, Corded
    [118490] = strPack("cragknicks"), --Scroll, Rolled,
    [134890] = strPack("dibella"), -- Dibella, Lady of Love,
    [134848] = join(",", strCrown(1500), strPack("dibella"), strPack("oasis")), -- Blue Butterfly Flock
    [134961] = strPack("dibella"), -- Dibella's Mysteries and Revelations,
    [134899] = join(",", strCrown(45), strPack("dibella")), -- Flower Spray, Crimson Daisies,
    [134901] = join(",", strCrown(45), strPack("dibella")), -- Flower Spray, Starlight Daisies,
    [134896] = join(",", strCrown(45), strPack("dibella")), -- Flower, Lover's Lily
    [134898] = join(",", strCrown(45), strPack("dibella")), -- Flowers, Midnight Sage,
    [134900] = join(",", strCrown(20), strPack("dibella")), -- Flowers, Red Poppy,
    [134902] = join(",", strCrown(20), strPack("dibella")), -- Flowers, Violet Bellflower,
    [134903] = join(",", strCrown(45), strPack("dibella")), -- Flowers, Midnight Glory,
    [94163] = join(",", strCrown(290), strPack("dibella")), --Imperial Bench, Scrollwork
    [134849] = join(",", strCrown(1500), strPack("dibella"), strPack("oasis")), -- Monarch Butterfly Flock
    [134891] = join(",", strCrown(2500), strPack("dibella")), -- Pergola, Festive Flowers
    [134895] = join(",", strCrown(1800), strPack("dibella")), -- Redguard Fountain, Mosaic
    [134904] = join(",", strCrown(260), strPack("dibella")), -- Seal of Dibella
    [134905] = join(",", strCrown(260), strPack("dibella")), -- Ritual Stone, Dibella
    [134906] = join(",", strCrown(240), strPack("dibella")), -- Ritual Brazier, Gilded
    [134892] = join(",", strCrown(85), strPack("dibella")), -- Tree, Pale Gold
    [134893] = join(",", strCrown(85), strPack("dibella")), -- Tree, Argent Blue
    [134894] = join(",", strCrown(20), strPack("dibella")), -- Wildflowers, Yellow and Orange
    [134897] = join(",", strCrown(45), strPack("dibella")), -- Vine Curtain, Festive Flowers

    [181547] = join(",", strCrown(1000), strPack("mermaid")), -- Leyawiin Fountain, Corner,
    [181486] = join(",", strCrown(2700), strPack("mermaid")), -- Leyawiin Fountain, Round,
    [181599] = join(",", strCrown(1100), strPack("mermaid")), -- Leyawiin Fountain, Tall,
    [181485] = strPack("mermaid"), -- Statue, Mermaid of Anvil,
    [181435] = join(",", strCrown(1500), strPack("mermaid")), -- Steam of Repose,

    [175695] = join(",", strCrown(510), strPack("zeni")), -- Leyawiin Shrine of the Eight,
    [175696] = join(",", strCrown(410), strPack("zeni")), -- Leyawiin Tapestry, Divines Horizontal,
    [175697] = join(",", strCrown(410), strPack("zeni")), -- Leyawiin Tapestry, Divines Vertical,
    [175698] = strPack("zeni"), -- Zenithar, God of Work and Commerce,
    [175699] = join(",", strPack("zeni"), strPack("windows")), -- Stained Glass of Zenithar,

    [181483] = strPack("windows"), -- Stained Glass of Akatosh,
    [181484] = strPack("windows"), -- Stained Glass of Julianos,
    [181482] = strPack("windows"), -- Stained Glass of Arkay,
    [181481] = strPack("windows"), -- Stained Glass of Dibella,
    [181480] = strPack("windows"), -- Stained Glass of Stendarr,
    [181479] = strPack("windows"), -- Stained Glass of Mara,
    [181478] = strPack("windows"), -- Stained Glass of Kynareth,

    [182292] = join(",", strCrown(260), strPack("ambitions")), -- Deadlands Base, Tower,
    [182291] = join(",", strCrown(1500), strPack("ambitions")), -- Deadlands Window, Fireglass,
    [182290] = join(",", strCrown(140), strPack("ambitions")), -- Deadlands Grate, Large,
    [182289] = join(",", strCrown(140), strPack("ambitions")), -- Deadlands Wall, Etched,
    [182295] = join(",", strCrown(510), strPack("ambitions")), -- Deadlands Firepit, Large,
    [182294] = join(",", strCrown(770), strPack("ambitions")), -- Deadlands Platform, Tower,
    [182293] = join(",", strCrown(260), strPack("ambitions")), -- Deadlands Stairway, Tower,
    [182912] = join(",", strCrown(270), strPack("ambitions")), -- Deadlands Pillar, Tall,

    [147585] = join(",", strCrown(40), strPack("forge")), -- Dwarven Gear, Large Spokes,
    [147586] = join(",", strCrown(50), strPack("forge")), -- Dwarven Hub, Sentry Wheel,
    [147587] = join(",", strCrown(40), strPack("forge")), -- Dwarven Gear, Large Open,
    [147588] = join(",", strCrown(220), strPack("forge")), -- Dwarven Conduit, Rounded,
    [147589] = join(",", strCrown(150), strPack("forge")), -- Dwarven Brazier, Open,
    [147590] = strPack("forge"), -- Dwarven Bust, Forge-Lord,
    [147664] = join(",", strCrown(270), strPack("forge")), -- Dwarven Dais, Conduit,
    [147574] = strPack("forge"), -- Dwarven Frieze, Wrathstone,
    [147575] = strPack("forge"), -- Dwarven Frieze, Power in Twain,
    [147576] = strPack("forge"), -- Dwarven Frieze, Colossal Power,
    [147577] = join(",", strCrown(920), strPack("forge")), -- Dwarven Platform, Fan,
    [147578] = join(",", strCrown(1400), strPack("forge")), -- Dwarven Throne, Conduit,
    [147579] = join(",", strCrown(240), strPack("forge")), -- Dwarven Gearwork, Perpetual,
    [147580] = join(",", strCrown(310), strPack("forge")), -- Dwarven Lamps, Heavy,
    [147581] = join(",", strCrown(350), strPack("forge")), -- Dwarven Table, Heavy Workbench,
    [147582] = join(",", strCrown(50), strPack("forge")), -- Dwarven Part, Sentry Head,
    [147583] = join(",", strCrown(220), strPack("forge")), -- Dwarven Valve, Sealed,
    [147584] = join(",", strCrown(160), strPack("forge")), -- Dwarven Rack, Spider Legs,

    [130226] = join(",", strCrown(85), strPack("coven")), -- Carcass, Hanging Deer
    [131424] = strPack("coven"), -- Fogs of the Hag Fen,
    [130220] = join(",", strCrown(3300), strPack("coven")), -- Hagraven Altar,
    [130222] = join(",", strCrown(260), strPack("coven")), -- Hagraven Totem, Skull
    [131423] = join(",", strCrown(750), strPack("coven")), -- Mists of the Hag Fen
    [130221] = join(",", strCrown(430), strPack("coven")), -- Reachmen Cage, Sturdy
    [130216] = join(",", strCrown(510), strPack("coven")), -- Witches' Basin, Scrying
    [130219] = join(",", strCrown(240), strPack("coven")), -- Witches' Brazier, Beast Skull
    [130223] = join(",", strCrown(340), strPack("coven")), -- Reachmen Rug, Mottled Skin
    [130224] = join(",", strCrown(180), strPack("coven")), -- Reachmen Rug, Smooth Skin
    [130225] = join(",", strCrown(340), strPack("coven")), -- Skulls, Heap
    [130227] = join(",", strCrown(850), strPack("coven")), -- Witches' Tent, Lean-To
    [130229] = join(",", strCrown(290), strPack("coven")), -- Tree, Wretched Cypress
    [130230] = join(",", strCrown(90), strPack("coven")), -- Stump, Wretched Cypress
    [130247] = join(",", strCrown(290), strPack("coven")), -- Tree, Fetid Cypress
    [130228] = strPack("coven"), -- The Witches of Hag Fen,
    [130215] = strPack("coven"), -- Witches' Cauldron, Provisioning,
    [130334] = join(",", strCrown(260), strPack("coven")), -- Witches Totem, Antler Charms,

    [134870] = strPack("tyrants"), -- Ancient Nord Chest, Dragon Crest,
    [134871] = strPack("tyrants"), -- Ancient Nord Urn, Dragon Crest,
    [134873] = strPack("tyrants"), -- Ancient Nord Bookshelf, Wide,
    [134874] = strPack("tyrants"), -- Ancient Nord Bookshelf, Narrow,
    [134875] = strPack("tyrants"), -- Ancient Nord Funerary Jar, Linked Rings,
    [134876] = strPack("tyrants"), -- Ancient Nord Funerary Jar, Crimson Sash,
    [134877] = strPack("tyrants"), -- Ancient Nord Funerary Jar, Dragon Figure,
    [134878] = strPack("tyrants"), -- Ancient Nord Funerary Jar, Dragon Crest,
    [134872] = strPack("tyrants"), -- Ancient Nord Brazier, Dragon Crest
    [134863] = strPack("tyrants"), -- Ancient Nord Sconce, Dragon Crest
    [134862] = strPack("tyrants"), -- Ancient Nord Runestone, Memorial,
    [134856] = strPack("tyrants"), -- Dragon Skeleton, Mid-Flight,
    [134857] = strPack("tyrants"), -- Dragon Priest Frieze: Triumph,
    [134858] = strPack("tyrants"), -- Dragon Priest Frieze: Exodus,
    [134859] = strPack("tyrants"), -- Dragon Priest Frieze: Restoration,
    [134860] = strPack("tyrants"), -- Dragon Priest Frieze: Ascension,
    [134861] = strPack("tyrants"), -- The History of Zaan The Scalecaller,
    [134864] = strPack("tyrants"), -- Dragon Cranium, Ancient,
    [134865] = strPack("tyrants"), -- Unidentified Bones, Gargantuan,
    [134866] = strPack("tyrants"), -- Lamia Cranium, Ancient,
    [134867] = strPack("tyrants"), -- Argonian Skull, Complete,
    [134868] = strPack("tyrants"), -- Khajiit Skull, Complete,
    [134869] = strPack("tyrants"), -- Orc Skull, Complete,

    [151901] = join(",", strCrown(20), strPack("khajiit")), -- Elsweyr Bowl, Moon-Sugar,
    [153660] = join(",", strCrown(560), strPack("khajiit")), -- Elsweyr Cart, Moons-Blessed
    [153669] = join(",", strCrown(300), strPack("khajiit")), -- Elsweyr Well, Simple Arched
    [153658] = join(",", strCrown(70), strPack("khajiit")), -- Moon-Sugar, Row
    [153659] = join(",", strCrown(30), strPack("khajiit")), -- Moon-Sugar, Cluster
    [153667] = join(",", strCrown(170), strPack("khajiit")), -- Moon-Sugar, Harvested Large
    [153668] = join(",", strCrown(90), strPack("khajiit")), -- Moon-Sugar, Harvested Small
    [153632] = join(",", strCrown(1500), strPack("khajiit")), -- Sapphire Candlefly Gathering
    [153661] = join(",", strCrown(40), strPack("khajiit")), -- Straw Pile
    [153662] = join(",", strCrown(40), strPack("khajiit")), -- Tool, Plow
    [153663] = join(",", strCrown(40), strPack("khajiit")), -- Tool, Sickle
    [153664] = join(",", strCrown(40), strPack("khajiit")), -- Tool, Pitchfork
    [153665] = join(",", strCrown(40), strPack("khajiit")), -- Tool, Hoe
    [153666] = join(",", strCrown(40), strPack("khajiit")), -- Tool, Two-Person Crosscut Saw

    [134270] = join(",", strCrown(85), strPack("malacath")), -- Cave Deposit, Large Double-Sided
    [134271] = join(",", strCrown(85), strPack("malacath")), -- Cave Deposit, Tall Stalagmite
    [134272] = join(",", strCrown(10), strPack("malacath")), -- Cave Deposit, Stalagmite Cluster,
    [134258] = strPack("malacath"), -- Prayer to the Furious One,
    [134259] = strPack("malacath"), -- Malacath, God of Oaths and Curses,
    [134260] = strPack("malacath"), -- Orcish Bas-Relief, Axe,
    [134261] = strPack("malacath"), -- Orcish Bas-Relief, Sword,
    [134262] = strPack("malacath"), -- Orcish Bas-Relief, Spear,
    [134268] = join(",", strCrown(570), strPack("malacath")), -- Orcish Brazier, Column
    [134269] = join(",", strCrown(220), strPack("malacath")), -- Orcish Dais, Raised
    [116518] = join(",", strCrown(270), strPack("malacath")), -- Orcish Drop Hammer, Repeating,
    [152147] = strPack("malacath"), -- Orcish Statue, Strength,
    [134267] = join(",", strCrown(380), strPack("malacath")), -- Orcish Table, Grand Furs
    [134263] = join(",", strCrown(410), strPack("malacath")), -- Orcish Throne, Ancient

    [126114] = strPack("azura"), -- Statue of Azura, Queen of Dawn and Dusk,
    [126115] = strPack("azura"), -- Statue of Azura's Moon,
    [126116] = strPack("azura"), -- Statue of Azura's Sun,
    [126117] = strPack("azura"), -- Tapestry of Azura,
    [126118] = strPack("azura"), -- Banner of Azura,
    [125489] = strPack("azura"), -- Daedric Brazier, Flaming,
    [126128] = strPack("azura"), -- The Five Points of the Star,

    [134251] = strPack("coldharbour"), -- Coldharbour Bookshelf, Filled,
    [134252] = strPack("coldharbour"), -- Coldharbour Bookshelf, Black Laboratory,
    [134253] = strPack("coldharbour"), -- Coldharbour Bookshelf, Filled Wide,
    [134256] = strPack("coldharbour"), -- Coldharbour Bookshelf, Filled Pillar,
    [134254] = strPack("coldharbour"), -- Seal of Molag Bal,
    [134255] = strPack("coldharbour"), -- Transliminal Rupture,
    [134257] = strPack("coldharbour"), -- Daedra Dossier: Cold-Flame Atronach
    [134264] = join(",", strCrown(190), strPack("coldharbour")), -- Daedric Brazier, Cold-Flame
    [134273] = join(",", strCrown(200), strPack("coldharbour")), -- Daedric Plinth, Sacrificial
    [134274] = join(",", strCrown(200), strPack("coldharbour")), -- Coldharbour Crate, Black Soul Gem
    [134275] = join(",", strCrown(200), strPack("coldharbour")), -- Coldharbour Bin, Black Soul Gem

    [182285] = join(",", strCrown(160), strPack("fargrave")), -- Book Wall, Levitating,
    [182286] = join(",", strCrown(860), strPack("fargrave")), -- Fargrave Terrarium, Snakevine,
    [182288] = join(",", strCrown(820), strPack("fargrave")), -- Fargrave Terrarium, Massive Gas Blossom,
    [182284] = join(",", strCrown(20), strPack("fargrave")), -- Fargrave Bread Loaves, Round,
    [182283] = join(",", strCrown(870), strPack("fargrave")), -- Fargrave Terrarium, Lantern Flower,
    [182282] = join(",", strCrown(560), strPack("fargrave")), -- Fargrave Water Globules, Levitating,
    [182258] = join(",", strCrown(540), strPack("fargrave")), -- Fargrave Terrarium, Claws,
    [182230] = join(",", strCrown(140), strPack("fargrave")), -- Mushrooms, Glowing Shelf,

    [182280] = strCrate("celestial"), -- Fargrave Relic Case,
    [182207] = strCrate("celestial"), -- Celestial Vortex,
    [181643] = strCrate("celestial"), -- Warrior's Flame,
    [181487] = strCrate("harlequin"), -- Grim Harlequin Chandelier,
    [181438] = strCrate("harlequin"), -- Mad God's Monarch Flock,
    [178800] = strCrate("harlequin"), -- Amethyst Candlefly Gathering,
    [171947] = strCrate("irony"), -- Deadlands Chandelier, Bladed,
    [171946] = strCrate("irony"), -- Deadlands Cage, Bladed,
    [171945] = strCrate("irony"), -- Deadlands Sconce, Horned,
    [171546] = strCrate("ayleid"), -- Ayleid Relief, Blessed Life-Tree,
    [171545] = strCrate("ayleid"), -- Ayleid Gate, Large,
    [171544] = strCrate("ayleid"), -- Comet, Aetherial,
    [156644] = join(", ", strCrate("frosty"), strGem(40)), -- Books, Towering Pile
  },
}

-- 19 Blackwood
FurC.MiscItemSources[ver.BLACKW] = {}

-- 18 Flames of Ambition
FurC.MiscItemSources[ver.FLAMES] = {
  [src.CROWN] = {
    [171932] = strCrown(160), -- Daedric Sconce, Torch,
    [171933] = strCrown(80), -- Daedric Candles, Tall Stand,
    [171934] = strCrown(360), -- Daedric Brazier, Plinth,
    [118482] = strCrown(25), -- Book Stack, Tall
  },

  [src.DROP] = {
    [171428] = strScry(0, " (gold lead, Harrowstorm Reliquary)"), -- Vampiric Stained Glass
  },
}

-- 17 Markarth
FurC.MiscItemSources[ver.MARKAT] = {
  [src.DROP] = {
    [171428] = strScry(0, " in the Reach (Harrowstorms)"), -- Vampiric Stained Glass
  },

  [src.CROWN] = {
    [167935] = strCrate("potentate"), -- Dwarven Work Lamp, Powered Floor,
    [167934] = strCrate("potentate"), -- Dwarven Orrery, Scholastic,
    [167933] = strCrate("potentate"), -- Dwarven Beam Emitter, Medium,

    [171397] = strPack("alchemist"), -- Stone Garden Tank, Vacant,
    [171398] = strPack("alchemist"), -- Stone Garden Vat, Alchemized Bristleback,
    [171399] = strPack("alchemist"), -- Stone Garden Vat, Alchemized Chaurus,
    [171400] = strPack("alchemist"), -- Stone Garden Vat, Alchemized Durzog,
    [171401] = strPack("alchemist"), -- Stone Garden Vat, Vacant,
    [171402] = strPack("alchemist"), -- Stone Garden Circulator, Rootbound,
    [171403] = strPack("alchemist"), -- Stone Garden Casket, Alchemized Bloodknight,
    [169117] = strPack("alchemist"), -- Target Bloodknight,

    [167299] = strCrown(920), -- Dwarven Chandelier, Polished Braced,
    [167301] = strCrown(560), -- Dwarven Lamppost, Polished Powered,
    [167300] = strCrown(160), -- Dwarven Lantern, Polished Wall,
    [167298] = strCrown(310), -- Dwarven Sconce, Polished Barred,
  },
}

-- 16 Stonethorn
FurC.MiscItemSources[ver.STONET] = {
  [src.CROWN] = {
    [119587] = strCrown(10), -- Auridon Coneplants, Cluster
    [118347] = strCrown(20), -- Bread, Various Loaves
    [118344] = strCrown(20), -- Breads, Assortment
    [118287] = strCrown(85), -- Carcass, Brown Hare
    [118282] = strCrown(85), -- Carcass, Fresh Goose
    [118162] = strCrown(340), -- Carpet of the Desert Flame, Faded
    [118167] = strCrown(340), -- Carpet of the Desert Flame, Faded
    [118166] = strCrown(340), -- Carpet of the Desert, Faded
    [118161] = strCrown(340), -- Carpet of the Mirage, Faded
    [118159] = strCrown(340), -- Carpet of the Oasis, Faded
    [118158] = strCrown(340), -- Carpet of the Sun, Faded Summer
    [118043] = strCrown(25), -- Common Torch, Holder
    [118261] = strCrown(25), -- Cushion, Faded Yellow
    [118260] = strCrown(25), -- Cushion, Faded Blue
    [118259] = strCrown(25), -- Cushion, Faded Red
    [94091] = strCrown(95), -- Imperial Carpet, Akatosh
    [94092] = strCrown(95), -- Imperial Carpet, Kyne
    [94093] = strCrown(95), -- Imperial Carpet, Stendarr
    [94094] = strCrown(140), -- Imperial Banner, Akatosh
    [94095] = strCrown(140), -- Imperial Banner, Kyne
    [94096] = strCrown(140), -- Imperial Banner, Stendarr
    [94097] = strCrown(95), -- Imperial Bed, Bunk
    [94099] = strCrown(60), -- Imperial Dresser, Short
    [94101] = strCrown(45), -- Imperial Chair, Slatted
    [94102] = strCrown(120), -- Imperial Rack, Cask
    [94103] = strCrown(60), -- Imperial Dresser, Open
    [94104] = strCrown(40), -- Imperial Stool, Sturdy
    [94105] = strCrown(95), -- Imperial Table, Family
    [94106] = strCrown(95), -- Imperial Desk, Sturdy
    [94107] = strCrown(50), -- Imperial Table, Common
    [94108] = strCrown(50), -- Imperial Shelf, Wall
    [94109] = strCrown(50), -- Imperial Lantern, Wall
    [94110] = strCrown(110), -- Imperial Lightpost, Stone
    [94111] = strCrown(95), -- Imperial Well, Grated
    [94112] = strCrown(70), -- Imperial Pedestal, Stone
    [94113] = strCrown(70), -- Imperial Basin, Stone
    [94114] = strCrown(430), -- Imperial Statue, Monolith
    [94115] = strCrown(430), -- Imperial Statue, Obelisk
    [94117] = strCrown(220), -- Imperial Rug, Akatosh
    [94118] = strCrown(220), -- Imperial Rug, Kynareth
    [94119] = strCrown(220), -- Imperial Rug, Stars
    [94120] = strCrown(220), -- Imperial Rug, Stendarr
    [94129] = strCrown(220), -- Imperial Tapestry, Akatosh
    [94130] = strCrown(220), -- Imperial Tapestry, Kynareth
    [94131] = strCrown(220), -- Imperial Tapestry, Stendarr
    [94132] = strCrown(150), -- Imperial Brazier, Firepot
    [94133] = strCrown(220), -- Imperial Bed, Four-Poster
    [94134] = strCrown(220), -- Imperial Bed, Double
    [94135] = strCrown(160), -- Imperial Pew, Windowed
    [94136] = strCrown(160), -- Imperial Bench, Fitted
    [94137] = strCrown(110), -- Imperial Bookcase, Scrollwork
    [94138] = strCrown(100), -- Imperial Chair, Rocking
    [94139] = strCrown(100), -- Imperial Chair, Windowed
    [94140] = strCrown(85), -- Imperial Chest, Sturdy
    [94141] = strCrown(120), -- Imperial Hutch, Scrollwork
    [94142] = strCrown(120), -- Imperial Cupboard, Scrollwork
    [94143] = strCrown(180), -- Imperial Chest of Drawers
    [94144] = strCrown(220), -- Imperial Counter, Long Cabinet
    [94145] = strCrown(110), -- Imperial Shelf, Barrel
    [94146] = strCrown(220), -- Imperial Desk, Swirled
    [94147] = strCrown(220), -- Imperial Table, Dining
    [94148] = strCrown(220), -- Imperial Trestle, Sturdy
    [94149] = strCrown(85), -- Imperial Table, Game
    [94150] = strCrown(220), -- Imperial Table, Kitchen
    [94151] = strCrown(240), -- Imperial Lightpost, Pair
    [94152] = strCrown(240), -- Imperial Lightpost, Single
    [94153] = strCrown(220), -- Imperial Well, Arched
    [94154] = strCrown(160), -- Imperial Basin, Heavy
    [94155] = strCrown(1000), -- Imperial Tent, Commander's
    [94156] = strCrown(290), -- Imperial Brazier, Caged
    [94157] = strCrown(410), -- Imperial Medallion, Crest
    [94158] = strCrown(410), -- Imperial Tapestry, Stars
    [94159] = strCrown(450), -- Imperial Streetlight, Imperial City
    [94161] = strCrown(310), -- Imperial Pedestal, Chiseled
    [94162] = strCrown(290), -- Imperial Pew, Scrollwork
    [94163] = strCrown(290), -- Imperial Bench, Scrollwork
    [94164] = strCrown(220), -- Imperial Sideboard, Scrollwork
    [94165] = strCrown(200), -- Imperial Chair, Scrollwork
    [94166] = strCrown(220), -- Imperial Armchair, Scrollwork
    [94167] = strCrown(220), -- Imperial Cabinet, Scrollwork
    [94168] = strCrown(220), -- Imperial Curio, Scrollwork
    [94169] = strCrown(160), -- Imperial Coffer, Scrollwork
    [94170] = strCrown(270), -- Imperial Dresser, Scrollwork
    [94171] = strCrown(240), -- Imperial Counter, Corner
    [94172] = strCrown(490), -- Imperial Bar, Cabinet
    [94173] = strCrown(200), -- Imperial Mirror, Standing
    [94174] = strCrown(120), -- Imperial Nightstand, Scrollwork
    [94175] = strCrown(200), -- Imperial Divider, Folding
    [94176] = strCrown(200), -- Imperial Divider, Curved
    [94177] = strCrown(170), -- Imperial Stool, Padded
    [94178] = strCrown(410), -- Imperial Desk, Scrollwork
    [94179] = strCrown(410), -- Imperial Table, Formal
    [94180] = strCrown(410), -- Imperial Trestle, Scrollwork
    [94182] = strCrown(160), -- Imperial Footlocker, Scrollwork
    [94183] = strCrown(350), -- Imperial Wardrobe, Scrollwork
    [94184] = strCrown(240), -- Imperial Wine Rack, Scrollwork
    [94185] = strCrown(450), -- Imperial Lightpost, Full
    [94187] = strCrown(410), -- Imperial Well, Covered
    [94188] = strCrown(410), -- Imperial Carpet, Gilded Dibella
    [94189] = strCrown(410), -- Imperial Carpet, Verdant Dibella
    [94190] = strCrown(410), -- Imperial Rug, Dibella
    [94191] = strCrown(410), -- Imperial Tapestry, Dibella
    [94192] = strCrown(610), -- Imperial Banner, Dibella
    [94193] = strCrown(410), -- Imperial Pillar, Straight
    [94194] = strCrown(410), -- Imperial Pillar, Chipped
    [94195] = strCrown(410), -- Imperial Bed, Canopy
    [94196] = strCrown(410), -- Imperial Cradle, Scrollwork
    [94197] = strCrown(610), -- Imperial Shrine of the Bay
    [94198] = strCrown(610), -- Imperial Altar of the Bay
    [94200] = strCrown(1000), -- Imperial Fountain of the Bay
    [94201] = strCrown(820), -- Imperial Statue, Knight
    [94202] = strCrown(820), -- Imperial Statue, Emperor
    [94203] = strCrown(820), -- Imperial Statue, Warrior
    [118160] = strCrown(340), -- Mat of Meditation, Faded
    [118164] = strCrown(340), -- Mat of the Sunset, Faded
    [118163] = strCrown(340), -- Mat of the Oasis, Faded
    [118165] = strCrown(340), -- Mat of the Sunrise, Faded
    [115421] = strCrown(110), -- Nord Sconce, Torch
    [118244] = strCrown(340), -- Orc Rug, Echatere Skin
    [118131] = strCrown(180), -- Pelt, Bear
    [118107] = strCrown(40), -- Pie, Display

    [119685] = strCrate("wildhunt"), -- Tapestry of Hircine
    [119684] = strCrate("wildhunt"), -- Statue of Hircine
  },

  [src.DROP] = {
    [171429] = strScry(0, loc.REACH), -- Red Eagle Cave Painting:1
  },
}

-- 15 Greymoor
FurC.MiscItemSources[ver.SKYRIM] = {
  [src.JUSTICE] = {
    [165828] = GetString(SI_FURC_LOOT_STEALING) .. " loc_skyrim", -- Painting: Life in Repose Painting, Wood
  },

  [src.DROP] = {
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

    [165866] = strScry(0, loc.STONEFALLS), -- Ashen Infernace Gate
    [165859] = strScry(0, loc.BALFOYEN), -- The Dutiful Guar
    [165854] = strScry(0, loc.MURKMIRE), -- Nisswo's Soul Tender
    [165860] = strScry(0, loc.GRAHTWOOD), -- Eight-Star Chandelier
    [166474] = strScry(0, loc.CRAGLORN), -- Altar of Celestial Convergence
    [161204] = strScry(0, loc.WROTHGAR), -- Anvil of Old Orsinium
    [165875] = strScry(0, loc.BETHNIKH), -- Ayleid Lightwell
    [163705] = strScry(0, loc.BETHNIKH), -- Warcaller's Painted Drum
    [165848] = strScry(0, loc.WSKYRIM), -- Font of Auri-El
    [165870] = strScry(0, loc.COLDH), -- Daedric Pillar of Torment
    [166434] = strScry(0, loc.ALIKR), -- The Heartland
    [165876] = strScry(0, loc.BLEAK), -- Ruby Dragon Skull
    [161216] = strScry(0, loc.BALFOYEN), -- Tri-Angled Truth Altar
    [163706] = strScry(0, loc.STROSMKAI), -- Dwemer Star Chart
    [166013] = strScry(0, loc.RIFT), -- Ebony Fox Totem
    [165849] = strScry(0, loc.AURIDON), -- Echoes of Aldmeris
    [161206] = strScry(0, loc.GREENSHADE), -- Branch of Falinesti
    [165857] = strScry(0, loc.BLEAK), -- Brazier of Frozen Flame
    [165871] = strScry(0, loc.EASTMARCH), -- Carved Whale Totem
    [165864] = strScry(0, loc.DESHAAN), -- Blessed Dais of Mother Morrowind
    [165861] = strScry(0, loc.GOLDCOAST), -- Golden Idol of Morihaus
    [166473] = strScry(0, loc.GREENSHADE), -- Greensong Gathering Circle
    [166436] = strScry(0, loc.WROTHGAR), -- Tusks of the Orc-Father
    [165856] = strScry(0, loc.EASTMARCH), -- Sacred Chalice of Ysgramor
    [165852] = strScry(0, loc.VVARDENFELL), -- St. Nerevar, Moon-and-Star
    [161207] = strScry(0, loc.MALABAL), -- Hollowbone Wind Chimes
    [165874] = strScry(0, loc.GLENUMBRA), -- Jeweled Skull of Ayleid Kings
    [165867] = strScry(0, loc.KHENARTHI), -- Cat's Eye Prism
    [161213] = strScry(0, loc.REAPER), -- Sorcerer-King's Blade
    [163704] = strScry(0, loc.GLENUMBRA), -- Kingmaker's Trove
    [166471] = strScry(0, loc.BANGKORAI), -- Tall Papa's Lamp
    [161205] = strScry(0, loc.COLDH), -- Void-Crystal Anomaly
    [165865] = strScry(0, loc.STORMHAVEN), -- Beacon of Tower Zero
    [166015] = strScry(0, loc.KHENARTHI), -- Sweet Khenarthi's Song
    [165869] = strScry(0, loc.AURIDON), -- Maormeri Serpent Shrine
    [165873] = strScry(0, loc.GOLDCOAST), -- Meridian Sconce
    [165850] = strScry(0, loc.CWC), -- Mnemonic Star-Sphere
    [165853] = strScry(0, loc.SELSWEYR), -- Moons-Blessed Ceremonial Pool
    [165868] = strScry(0, loc.REAPER), -- Moonlight Mirror
    [165872] = strScry(0, loc.NELSWEYR), -- Stained Glass of Lunar Phases
    [166472] = strScry(0, loc.HEWSBANE), -- Morwha's Blessing
    [165862] = strScry(0, loc.NELSWEYR), -- Moth Priest's Cleansing Bowl
    [161210] = strScry(0, loc.SUMMERSET), -- Prismatic Sunbird Feather
    [165878] = strScry(0, loc.STROSMKAI), -- Dwarven Puzzle Box
    [165851] = strScry(0, loc.VVARDENFELL), -- Sixth House Ritual Table
    [165855] = strScry(0, loc.STORMHAVEN), -- Noble Knight's Rest
    [161208] = strScry(0, loc.RIFT), -- Rune-Carved Mammoth Skull
    [161209] = strScry(0, loc.SHADOWFEN), -- Nest of Shadows
    [161212] = strScry(0, loc.MALABAL), -- Silvenari Sap-Stone
    [166435] = strScry(0, loc.WSKYRIM), -- Seat of the Snow Prince
    [166451] = strScry(0, loc.RIVENSPIRE), -- Riven King's Throne
    [161211] = strScry(0, loc.RIVENSPIRE), -- Remnant of the False Tower
    [165858] = strScry(0, loc.ALIKR), -- Coil of Satakal
    [161215] = strScry(0, loc.HEWSBANE), -- Yokudan Skystone Scabbard
    [161214] = strScry(0, loc.CRAGLORN), -- Spellscar Shard
    [166014] = strScry(0, loc.SELSWEYR), -- Shrine of Boethra
    [163710] = strScry(0, loc.ALIKR), -- Antique Map of Alik'r Desert
    [165996] = strScry(0, loc.GOLDCOAST), -- Antique Map of Gold Coast
    [163727] = strScry(0, loc.NELSWEYR), -- Antique Map of Northern Elsweyr
    [163728] = strScry(0, loc.SELSWEYR), -- Antique Map of Southern Elsweyr
    [163717] = strScry(0, loc.AURIDON), -- Antique Map of Auridon
    [163711] = strScry(0, loc.BANGKORAI), -- Antique Map of Bangkorai
    [163713] = strScry(0, loc.DESHAAN), -- Antique Map of Deshaan
    [163707] = strScry(0, loc.GLENUMBRA), -- Antique Map of Glenumbra
    [163718] = strScry(0, loc.GRAHTWOOD), -- Antique Map of Grahtwood
    [163719] = strScry(0, loc.GREENSHADE), -- Antique Map of Greenshade
    [165997] = strScry(0, loc.HEWSBANE), -- Antique Map of Hew's Bane
    [165993] = strScry(0, loc.COLDH), -- Antique Map of Coldharbour
    [165994] = strScry(0, loc.CRAGLORN), -- Antique Map of Craglorn
    [163709] = strScry(0, loc.RIVENSPIRE), -- Antique Map of Rivenspire
    [163720] = strScry(0, loc.MALABAL), -- Antique Map of Malabal Tor
    [163715] = strScry(0, loc.EASTMARCH), -- Antique Map of Eastmarch
    [163716] = strScry(0, loc.RIFT), -- Antique Map of The Rift
    [163714] = strScry(0, loc.SHADOWFEN), -- Antique Map of Shadowfen
    [163721] = strScry(0, loc.REAPER), -- Antique Map of Reaper's March
    [163725] = strScry(0, loc.SUMMERSET), -- Antique Map of Summerset
    [163708] = strScry(0, loc.STORMHAVEN), -- Antique Map of Stormhaven
    [163712] = strScry(0, loc.STONEFALLS), -- Antique Map of Stonefalls
    [163724] = strScry(0, loc.VVARDENFELL), -- Antique Map of Vvardenfell
    [163726] = strScry(0, loc.MURKMIRE), -- Antique Map of Murkmire
    [163723] = strScry(0, loc.WROTHGAR), -- Antique Map of Wrothgar
  },

  [src.CROWN] = {
    [153675] = strCrown(200), -- Daedric Altar, Four Alcoves
    [153676] = strCrown(270), -- Daedric Sarcophagus, Stone
    [159462] = strCrown(170), -- Redguard Fence, Wooden
    [166452] = strCrown(440), -- Vampiric Column, Ancient
    [166044] = strCrown(90), -- Watering Trough, Full
    [159460] = strCrown(310), -- Tree, Slim Wrothgar Pine
    [159461] = strCrown(30), -- Shrubs, Desert Scrub
    [159496] = strCrown(240), -- Tree, Ancient Bristlecone
    [159456] = strCrown(410), -- Orsinium Well, Open
    [159457] = strCrown(170), -- Tree, Dagger Bark
    [159458] = strCrown(310), -- Tree, Broad Wrothgar Pine
    [159459] = strCrown(310), -- Trees, Paired Wrothgar Pine

    [167332] = join(", ", strCrate("sovngarde"), strGem(40)), -- The Mage's Staff Painting, Gold
    [167231] = join(", ", strCrate("sovngarde"), strGem(100)), -- Celestial Nimbus
    [167230] = join(", ", strCrate("sovngarde"), strGem(100)), -- Alkosh's Hourglass, Replica
    [166030] = strCrate("nightfall"), -- Greymoor Tapestry, Harrowstorm
    [166029] = strCrate("nightfall"), -- Vampiric Fountain, Bat Swarm
    [165568] = strCrate("nightfall"), -- Ancient Nord Gate
    [156669] = strCrate("frosty"), -- Target Frost Atronach
    [153650] = strCrate("newmoon"), -- Crystal Sconce, Green,
    [153631] = strCrate("newmoon"), -- Emerald Candlefly Gathering
  },

  [src.FISHING] = {},
}

-- 14 Harrowstorm
FurC.MiscItemSources[ver.HARROW] = {}

-- 13 Dragonhold
FurC.MiscItemSources[ver.DRAGON2] = {}

-- 12 Scalebreaker
FurC.MiscItemSources[ver.SCALES] = {}

-- 11 Elsweyr
FurC.MiscItemSources[ver.KITTY] = {
  [src.JUSTICE] = {
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

  [src.DROP] = {
    [153563] = ev_elsweyr, -- Target Bone Goliath, Reanimated
    [153814] = ev_elsweyr, -- Dragon's Treasure Trove
    [145317] = "Witches' Festival, Plunder Skull", -- Gravestone, Broken
    [153751] = "In Cyrodiil for Volundrung Vanquisher or Volendrung Wielder", -- Volendrung Replica TODO set up properly
    [165834] = chests_elsweyr, -- A Simple Five-Claw Life Painting, Gold
  },

  [src.CROWN] = {
    [151838] = strPack("oasis"), -- Elsweyr Fountain, Moons-Blessed,
    [151840] = join(",", strCrown(70), strPack("oasis")), -- Plant, Desert Fan,
    [151841] = join(",", strCrown(70), strPack("oasis")), -- Plant, Tall Desert Fan,
    [151842] = join(",", strCrown(20), strPack("oasis")), -- Plant, Cask Palm,
    [151843] = join(",", strCrown(45), strPack("oasis")), -- Cactus, Flowering Cluster,
    [151844] = join(",", strCrown(30), strPack("oasis")), -- Cactus, Bilberry,
    [151845] = join(",", strCrown(95), strPack("oasis")), -- Elsweyr Potted Cactus, Flowering,
    [151846] = join(",", strCrown(35), strPack("oasis"), strPack("mermaid")), -- Elsweyr Potted Plant, Cask Palm,
    [151835] = strPack("oasis"), -- Cathay-Raht Statue, Warrior,
    [151836] = strPack("oasis"), -- Tojay Statue, Dancer,
    [151837] = strPack("oasis"), -- Ohmes-Raht Statue, Trickster,
    [151847] = join(",", strCrown(20), strPack("oasis")), -- Plant, Flowering Desert Aloe,
    [151848] = join(",", strCrown(15), strPack("oasis")), -- Trees, Sunset Palm Cluster,
    [151849] = join(",", strCrown(45), strPack("oasis")), -- Cactus, Lily Flower,
    [151850] = join(",", strCrown(20), strPack("oasis")), -- Tree, Anequina Bonsai,
    [151834] = join(",", strCrown(90), strPack("oasis")), -- Tree, Desert Acacia Shade,

    [151906] = strPack("moonbishop"), -- Robust Target Dro-m'Athra,
    [151829] = strPack("moonbishop"), -- Suthay Statue, Nimble Bishop,
    [151824] = strPack("moonbishop"), -- Lunar Tapestry, The Open Path,
    [151825] = strPack("moonbishop"), -- Lunar Tapestry, The Gathering,
    [151826] = strPack("moonbishop"), -- Lunar Tapestry, The Dance,
    [151827] = strPack("moonbishop"), -- Lunar Tapestry, The Gate,
    [151828] = strPack("moonbishop"), -- Lunar Tapestry, The Demon,
    [151830] = join(",", strCrown(190), strPack("moonbishop")), -- Elsweyr Divider, Elegant Wooden,
    [151832] = join(",", strCrown(100), strPack("moonbishop")), -- Elsweyr Ceremonial Lantern, Jone,
    [151833] = join(",", strCrown(100), strPack("moonbishop")), -- Elsweyr Ceremonial Lantern, Jode,

    [165578] = strPack("vampire"), -- Basin of Loss
    [165569] = strPack("vampire"), -- Soul-Sworn Thrall

    [151808] = strCrown(10), -- Tree, Fan Palm,
    [151813] = strCrown(10), -- Sapling, Desert Acacia,
    [151816] = strCrown(10), -- Plant, Flowering Thorned Succulent,
    [151820] = strCrown(10), -- Desert Grass, Tall,
    [151821] = strCrown(15), -- Desert Grass, Patch,
    [151831] = strCrown(290), -- Elsweyr Sugar Pipe, Ceremonial,
    [151857] = strCrown(150), -- Elsweyr Gazebo, Ancient Stone,
    [151867] = strCrown(340), -- Hakoshae Lanterns, Festival,
    [151868] = strCrown(180), -- Hakoshae Banners, Festival,
    [151869] = strCrown(300), -- Elsweyr Wagon, Covered,
    [151870] = strCrown(560), -- Elsweyr Wagon, Pedlar,
    [151871] = strCrown(300), -- Elsweyr Dais, Temple,
    [151874] = strCrown(300), -- Elsweyr Shrine, Ancient Stone,
    [151875] = strCrown(560), -- Elsweyr Bridge, Ancient Stone,
    [151876] = strCrown(590), -- Elsweyr Tent, Caravan,
    [151877] = strCrown(590), -- Elsweyr Canopy, Bazaar,
    [151878] = strCrown(450), -- Elsweyr Canopy, Peaked,
    [151883] = strCrown(240), -- Tree, Towering Iroko,
    [151905] = strCrown(10), -- Rock, Wide Flat Slate,
    [151911] = strCrown(5), -- Rock, Flat Slate,
    [151912] = strCrown(10), -- Stepping Stones, Slate,
    [151914] = strCrown(25), -- Tree, Desert Acacia Tall,
    [151804] = strCrown(30), -- Elsweyr Pillar, Rough Wooden,
    [151807] = strCrown(5), -- Rock Field, Ancient Stone,
    [151884] = strCrown(310), -- Tree, Giant Ficus,
    [151885] = strCrown(310), -- Tree, Massive Ficus,
    [151872] = strCrown(110), -- Boulder, Towering Lunar Spire,
    [151873] = strCrown(50), -- Boulder, Lunar Crag,
    [151879] = strCrown(560), -- Cactus, Lunar Tendrils,
    [151880] = strCrown(640), -- Cactus, Lunar Branching,
    [151881] = strCrown(640), -- Cactus, Lunar Branching Tall,
    [151882] = strCrown(140), -- Cactus, Banded Lunar Violet Trio,
    [151904] = strCrown(370), -- Glowgrass, Patch,
    [151913] = strCrown(5), -- Rock, Slate,

    [152145] = mischouse .. " or Craftable", -- Orcish Tapestry, War,       CRAFTABLE
    [152149] = mischouse .. " or Craftable", -- Orcish Brazier, Pillar,     CRAFTABLE
    [152148] = mischouse .. " or Craftable", -- Orcish Tapestry, Hunt,      CRAFTABLE
    [152146] = mischouse .. " or Craftable", -- Orcish Chandelier, Spiked,  CRAFTABLE
    [152141] = mischouse .. " or Craftable", -- Orcish Brazier, Bordered,   CRAFTABLE
    [152144] = mischouse .. " or Craftable", -- Orcish Mirror, Peaked,      CRAFTABLE
    [152143] = mischouse .. " or Craftable", -- Orcish Sconce, Scrolled,    CRAFTABLE
    [152142] = mischouse .. " or Craftable", -- Orcish Sconce, Bordered,    CRAFTABLE

    [159438] = strCrate("gloomspore"), -- Fungus, Gloomspore Ghost
    [159437] = strCrate("gloomspore"), -- Painting of Blackreach, Rough
    [159436] = strCrate("gloomspore"), -- Dwarven Miniature Sun, Portable
    [153630] = join(",", strCrate("newmoon"), strGem(55)), -- Shadow Tendril Patch
    [151612] = strCrate("baandari"), -- Pile of Dubious Riches,
    [151611] = strCrate("baandari"), -- The Mane, Moons-Blessed,
    [151589] = strCrate("baandari"), -- Baandari Lunar Compass,
  },

  [src.FISHING] = {},
}

-- 10 Wrathstone
FurC.MiscItemSources[ver.WOTL] = {
  [src.CROWN] = {
    [147600] = strCrate("dragonscale"), -- Tapestry of Namira,
    [147599] = strCrate("dragonscale"), -- Banner of Namira,
    [147591] = strCrate("dragonscale"), -- Namira, Mistress of Decay,
  },
}

-- 9 Wolfhunter
FurC.MiscItemSources[ver.WEREWOLF] = {
  [src.DROP] = {
    [141851] = strDungeon(loc.DUNG_MHK, loc.DUNG_MOS), -- Bear Skull, Fresh
    [141850] = strDungeon(loc.DUNG_MHK, loc.DUNG_MOS), -- Bear Skeleton, Picked Clean
    [141847] = strDungeon(loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Gnawed
    [141848] = strDungeon(loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Jumbled
    [141849] = strDungeon(loc.DUNG_MHK, loc.DUNG_MOS), -- Animal Bones, Fresh

    [141921] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Bowl, Geometric Pattern

    [141923] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Amphora, Seed Pattern
    [141922] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Dish, Geometric Pattern
    [141924] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Vase, Scale Pattern
    [141925] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Hearth Shrine, Sithis Relief
    [141926] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Hearth Shrine, Sithis Figure
    [141920] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Brazier, Ceremonial

    [147639] = strDungeon(loc.DUNG_DOM), -- Magna-Geode
    [147640] = strDungeon(loc.DUNG_DOM), -- Magna-Geode, Large
    [147641] = strDungeon(loc.DUNG_DOM), -- Garlas Alpinia, Tall
  },

  [src.CROWN] = {
    [141836] = strCrown(170), -- Monolith, Lord Hircine Ritual
    [141843] = strCrown(30), -- Plants, Yellow Frond Cluster
    [125681] = strCrown(50), -- Vines, Volcanic Roses
    [134921] = strCrown(520), -- Redguard Lamppost, Stone
    [134922] = strCrown(250), -- Redguard Pillar, Tiered
    [134923] = strCrown(2000), -- Redguard Trellis, Peaked
    [134924] = strCrown(380), -- Redguard Fence, Brass Capped
    [134925] = strCrown(2200), -- Redguard Fountain, Pillar
    [134926] = strCrown(1200), -- Redguard Awning, Wall
    [134927] = strCrown(1200), -- Wedding Pergola, Double
    [134928] = strCrown(1200), -- Wedding Pergola, Triple
    [134929] = strCrown(45), -- Trees, Savanna Cluster
    [134930] = strCrown(30), -- Bushes, Swordgrass Cluster
    [134931] = strCrown(50), -- Boulder, Weathered Desert
    [134932] = strCrown(50), -- Boulder, Tiered Desert
    [134933] = strCrown(90), -- Cranium, Jawless
    [134934] = strCrown(10), -- Rocks, Basalt Chunks
    [134936] = strCrown(110), -- Cave Deposit, Tall Stalagmite Cluster
    [134938] = strCrown(110), -- Cave Deposit, Stalagmite Group
    [134945] = strCrown(200), -- Cave Deposit, Extended Spire
    [134973] = strCrown(200), -- Cave Deposit, Stalactite Cone Cluster
    [134939] = strCrown(110), -- Cave Deposit, Stalactite Cone
    [134941] = strCrown(110), -- Cave Deposit, Spire
    [120603] = strCrown(20), -- Boulder, Flat Mossy
    [120604] = strCrown(20), -- Rock, Slanted Mossy
    [120605] = strCrown(20), -- Rocks, Deep Mossy
    [120606] = strCrown(20), -- Stones, Mossy Cluster
    [134943] = strCrown(1000), -- Brotherhood Banner, Long
    [134944] = strCrown(340), -- Brotherhood Column, Tall Ornate
    [134946] = strCrown(340), -- Brotherhood Column, Ornate
    [120612] = strCrown(10), -- Plant, Tall Mammoth Ear
    [120613] = strCrown(10), -- Plant, Towering Mammoth Ear
    [120614] = strCrown(10), -- Plant Cluster, Jungle Leaf
    [134951] = strCrown(30), -- Mushrooms, Assorted Cluster
    [134952] = strCrown(30), -- Mushrooms, Sporous Browncap
    [134953] = strCrown(340), -- Brotherhood Carpet, Large Worn
    [126774] = strCrown(510), -- Dres Tapestry, House
    [126775] = strCrown(510), -- Hlaalu Tapestry, House
    [126777] = strCrown(510), -- Redoran Tapestry, House
    [126778] = strCrown(510), -- Telvanni Tapestry, House
    [134974] = strCrown(340), -- Brotherhood Carpet, Worn
    [126830] = strCrown(10), -- Mushrooms, Volcanic Cluster
    [120631] = strCrown(5), -- Pebble, Stacked Mossy
    [134330] = strCrown(490), -- Clockwork Control Panel, Double
    [134337] = strCrown(1800), -- Clockwork Somnolostation, Octet
    [121036] = strCrown(30), -- Shrub, Sparse Violet
    [121035] = strCrown(30), -- Plant, Paired Verdant Hosta
    [121034] = strCrown(10), -- Shrub, Delicate Forest
    [121032] = strCrown(25), -- Saplings, Young Laurel
    [121031] = strCrown(45), -- Topiary, Paired Cypress
    [121030] = strCrown(54), -- Topiary, Young Cypress
    [121029] = strCrown(45), -- Topiary, Strong Cypress
    [120709] = strCrown(70), -- Tree, Sturdy Young Birch
    [121026] = strCrown(45), -- Hedge, Dense High Wall
    [121025] = strCrown(70), -- Trees, Sprawling Juniper Cluster
    [121024] = strCrown(70), -- Trees, Paired Leaning Juniper
    [121021] = strCrown(10), -- Plants, Dry Underbrush
    [121020] = strCrown(10), -- Plants, Sparse Underbrush
    [121018] = strCrown(10), -- Plant, Forest Sprig
    [121014] = strCrown(20), -- Topiary, Sparse
    [121012] = strCrown(70), -- Trees, Fragile Autumn Birch
    [121009] = strCrown(70), -- Tree, Young Healthy Birch
    [120726] = strCrown(20), -- Rock, Jagged Algae Coated
    [120727] = strCrown(5), -- Stone, Angled Mossy
    [120728] = strCrown(20), -- Rock, Jagged Lichen
    [121006] = strCrown(45), -- Flower Patch, Violets
    [120730] = strCrown(45), -- Topiary, Lush Evergreen
    [120731] = strCrown(25), -- Tree, Mossy Summer
    [120732] = strCrown(70), -- Tree, Mossy Forest
    [120733] = strCrown(70), -- Tree, Gnarled Forest
    [120734] = strCrown(25), -- Saplings, Squat Desert
    [120735] = strCrown(52), -- Saplings, Young Desert
    [120736] = strCrown(290), -- Tree, Gentle Weeping Willow
    [120737] = strCrown(150), -- Tree, Weeping Willow
    [120738] = strCrown(70), -- Tree, Towering Willow
    [120743] = strCrown(70), -- Tree, Strong Cypress
    [120996] = strCrown(120), -- Banner, Tattered Red
    [120745] = strCrown(60), -- Tree, Water Palm
    [120483] = strCrown(30), -- Cactus, Lemon Bulbs
    [120748] = strCrown(70), -- Tree, Leaning Swamp
    [120749] = strCrown(10), -- Grass, Tall Bamboo Shoots
    [120750] = strCrown(10), -- Grass, Drying Bamboo Shoots
    [120751] = strCrown(10), -- Grass, Twin Bamboo Shoots
    [120752] = strCrown(10), -- Grass, Young Bamboo Shoots
    [120471] = strCrown(25), -- Tree, Wilted Palm
    [120756] = strCrown(10), -- Plant, Palm Fronds
    [120463] = strCrown(20), -- Boulder, Weathered Flat
    [120456] = strCrown(5), -- Stone, Smooth Desert
    [134579] = strCrown(5), -- Rubble Pile, Worked Stone
    [120760] = strCrown(50), -- Flower, Red Honeysuckle
    [125544] = strCrown(30), -- Fern, Strong Dusky
    [125547] = strCrown(85), -- Flower, Healthy Purple Bat Bloom
    [125546] = strCrown(85), -- Flower Patch, Lava Blooms
    [120765] = strCrown(15), -- Breton Cup, Empty
    [120766] = strCrown(15), -- Breton Cup, Full
    [134950] = strCrown(31), -- Mushrooms, Flapjack Stack
    [139238] = strCrown(190), -- Alinor Wall Mirror, Ornate
    [139239] = strCrown(190), -- Alinor Wall Mirror, Verdant
    [139389] = strCrown(200), -- Crystal, Crimson Cluster
    [139184] = strCrown(200), -- Alinor Plinth, Sarcophagus

    [130093] = strPack("molag"), -- Coldharbour Compact
    [130071] = join(",", strCrown(300), strPack("molag")), -- Daedric Torch, Coldharbour
    [130075] = join(",", strCrown(380), strPack("molag")), -- Daedric Altar, Molag Bal
    [130078] = join(",", strCrown(380), strPack("molag")), -- Soul Gem, Single
    [130079] = join(",", strCrown(380), strPack("molag")), -- Soul Gems, Pile
    [130082] = join(",", strCrown(640), strPack("molag")), -- Soul-Shriven, Robed
    [130094] = join(",", strCrown(140), strPack("molag")), -- Daedric Chains, Hanging
    [130095] = join(",", strCrown(640), strPack("molag")), -- Daedric Torture Device, Chained
    [130069] = join(",", strCrown(2000), strPack("molag")), -- Daedric Spout, Block
    [130070] = join(",", strCrown(2000), strPack("molag")), -- Daedric Spout, Arched
    [130080] = strPack("molag"), -- Soul Gems, Scattered
    [130081] = strPack("molag"), -- Soul-Shriven, Armored
    [130083] = strPack("molag"), -- Daedric Block, Seat
    [130084] = strPack("molag"), -- Daedric Tapestry, Molag Bal
    [130085] = strPack("molag"), -- Daedric Banner, Molag Bal
    [130086] = strPack("molag"), -- Daedric Pennant, Molag Bal
    [130089] = join(",", strCrown(360), strPack("molag")), -- Daedric Brazier, Molag Bal
    [130087] = strPack("molag"), -- Daedric Shards, Coldharbour
    [130091] = strPack("molag"), -- Statue of Molag Bal, God of Schemes
    [130090] = join(",", strCrown(310), strPack("molag")), -- Daedric Sconce, Molag Bal
    [130088] = strPack("molag"), -- Daedric Fragment, Coldharbour
    [130092] = strPack("molag"), -- Seal of Molag Bal, Grand

    [126138] = strPack("dwemer"), -- A Guide to Dwemer Mega-Structures
    [125516] = strPack("dwemer"), -- Dwarven Gear Assembly, Grinding

    [126140] = strPack("vivec"), -- Vivec's Grand Bed
    [126141] = strPack("vivec"), -- Vivec's Grand Throne
    [126142] = strPack("vivec"), -- Vivec's Divination Pool
    [126143] = strPack("vivec"), -- Statue, Vivec's Triumph
    [126144] = strPack("vivec"), -- Seal of Vivec
    [126145] = strPack("vivec"), -- Sigil of Vivec
    [126146] = strPack("vivec"), -- Banner, Vivec
    [126149] = strPack("vivec"), -- Tapestry, Vivec
    [126150] = strPack("vivec"), -- Tribunal Tablet of Sotha Sil
    [126152] = strPack("vivec"), -- The Cliff-Strider Song

    [134855] = strCrate("scalecaller"), -- Banner of Peryite
    [134854] = strCrate("scalecaller"), -- Tapestry of Peryite
    [134853] = strCrate("scalecaller"), -- Peryite, The Taskmaster
    [134475] = strCrate("fireatro"), -- Statue of Malacath, Orc-Father
    [126132] = strCrate("string") .. " (any)", -- Resplendent Sweetroll
    [125654] = strCrate("dwemer"), -- Tapestry, Clavicus Vile
    [125480] = strCrate("dwemer"), -- Banner, Clavicus Vile
  },
}

-- 8 Murkmire
FurC.MiscItemSources[ver.SLAVES] = {
  [src.JUSTICE] = {
    [145399] = stealable_swamp, -- Murkmire Rug, Crawling Serpents Worn
    [145400] = stealable_swamp, -- Murkmire Rug, Lurking Lizard Worn
    [145398] = stealable_swamp, -- Murkmire Rug, Supine Turtle Worn
    [145397] = stealable_swamp, -- Murkmire Rug, Hist Gathering Worn
    [145396] = stealable_swamp, -- Murkmire Tapestry, Hist Gathering Worn
    [145550] = join(", ", stealable_swamp, GetString(SI_FURC_DROP_MURKMIRE)), -- Murkmire Hunting Lure, Grisly
    [145401] = stealable_swamp, -- Murkmire Tapestry, Xanmeer Worn
    [145403] = stealable_swamp, -- Jel Parchment
  },

  [src.DROP] = {
    [141856] = join(",", ev_hollowjack, strCrate("hollowjack")), -- Decorative Hollowjack Daedra-Skull
    [141855] = join(",", ev_hollowjack, strCrate("hollowjack")), -- Decorative Hollowjack Wraith-Lantern
    [141854] = join(",", ev_hollowjack, strCrate("hollowjack")), -- Decorative Hollowjack Flame-Skull
    [141870] = ev_hollowjack, -- Raven-Perch Cemetery Wreath
    [141875] = ev_hollowjack, -- Witches Festival Scarecrow
    [139157] = ev_hollowjack, -- Webs, Thick Sheet
    [139162] = ev_hollowjack, -- Webs, Cone
    [141939] = ev_hollowjack, -- Grave, Grasping
    [141965] = ev_hollowjack, -- Hollowjack Lantern, Soaring Dragon
    [141966] = ev_hollowjack, -- Hollowjack Lantern, Toothy Grin
    [141967] = ev_hollowjack, -- Hollowjack Lantern, Ouroboros
    [142004] = ev_hollowjack, -- Specimen Jar, Spare Brain
    [142005] = ev_hollowjack, -- Specimen Jar, Monstrous Remains
    [142003] = ev_hollowjack, -- Specimen Jar, Eyes
    [120877] = ev_hollowjack, -- Gravestone, Cracked
    [120876] = ev_hollowjack, -- Gravestone, Imp Engraving
    [120875] = ev_hollowjack, -- Gravestone, Clover Engraving
    [141778] = ev_hollowjack, -- Target Wraith-of-Crows

    -- "Part of the item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold"
    [145923] = strPartOf(
      145596,
      zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY))
    ), -- Lies of the Dread-Father
    [145926] = strPartOf(
      145596,
      zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY))
    ), -- That of Void
    [145927] = strPartOf(
      145596,
      zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY))
    ), -- Acts of Honoring
    [145928] = strPartOf(
      145596,
      zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY))
    ), -- Speakers of Nothing
    [145597] = strPartOf(
      145596,
      zo_strformat("<<1>>, <<2>>: <<3>>", loc.MURKMIRE, loc.MURKMIRE_LIL, strPrice(15000, CURT_MONEY))
    ), -- Scales of Shadow
  },

  [src.CROWN] = {
    [145466] = strCrown(30), -- Plant, Wilted Hist Bulb
    [145465] = strCrown(40), -- Plant Cluster, Wilted Hist Bulb
    [145464] = strCrown(30), -- Plant, Red Sister Ti
    [145463] = strCrown(35), -- Plant Cluster, Red Sister Ti
    [145462] = strCrown(40), -- Plant, Cardinal Flower
    [145460] = strCrown(30), -- Plant, Canna Leaves
    [145459] = strCrown(90), -- Murkmire Kiln, Ancient Stone
    [145448] = strCrown(1000), -- Murkmire Throne, Engraved
    [145444] = strCrown(130), -- Murkmire Totem, Hist Guardian
    [145429] = strCrown(65), -- Plant Cluster, Bounteous Flower Large
    [145411] = strCrown(410), -- Plant, Luminous Lantern Flower
    [145322] = strCrown(800), -- Music Box, Blood and Glory
    [141976] = strCrown(60), -- Pumpkin Patch, Display
    [141869] = strCrown(150), -- Alinor Potted Plant, Cypress
    [141853] = strCrown(2500), -- Statue of Hircine's Bitter Mercy
    [134326] = strCrown(260), -- Clockwork Pump, Horizontal
    [134250] = strCrown(750), -- Fabrication Sphere, Inactive

    [146062] = strPack("newlife2018"), -- Winter Ouroboros Wreath
    [146061] = strPack("newlife2018"), -- New Life Triptych Banner
    [146060] = strPack("newlife2018"), -- New Life Ladle
    [146059] = strPack("newlife2018"), -- New Life Snowmortal, Khajiit
    [146058] = strPack("newlife2018"), -- New Life Snowmortal, Argonian
    [146057] = strPack("newlife2018"), -- New Life Snowmortal, Human
    [146056] = strPack("newlife2018"), -- New Life Cookies and Ale
    [146055] = strPack("newlife2018"), -- New Life Garland Wreath
    [146054] = strPack("newlife2018"), -- New Life Garland
    [146053] = strPack("newlife2018"), -- Guar Ice Sculpture
    [146052] = strPack("newlife2018"), -- Vvardvark Ice Sculpture
    [146051] = strPack("newlife2018"), -- Mudcrab Ice Sculpture
    [146050] = strPack("newlife2018"), -- Winter Festival Hearthfire
    [146049] = strPack("newlife2018"), -- Winter Festival Hearth
    [146048] = strPack("newlife2018"), -- New Life Festive Fir
    [146047] = strPack("newlife2018"), -- From Old Life To New

    [146073] = join(",", strCrown(70), strPack("deepmire")), -- Plant Cluster, Marsh Nigella,
    [145461] = join(",", strCrown(30), strPack("deepmire")), -- Plant Cluster, Cardinal Flower
    [145447] = join(",", strCrown(260), strPack("swamp")), -- Murkmire Dais, Engraved
    [145445] = strPack("deepmire"), -- The Sharper Tongue: A Jel Primer
    [145443] = join(",", strCrown(270), strPack("deepmire")), -- Murkmire Shrine, Sithis Looming
    [145442] = join(",", strCrown(140), strPack("deepmire")), -- Grave Stake, Large Twinned
    [145441] = join(",", strCrown(140), strPack("deepmire")), -- Grave Stake, Large Serpent
    [145440] = join(",", strCrown(140), strPack("deepmire")), -- Grave Stake, Large Skull
    [145439] = join(",", strCrown(140), strPack("deepmire")), -- Grave Stake, Large Fearsome
    [145438] = join(",", strCrown(140), strPack("deepmire")), -- Grave Stake, Large Glyphed
    [145437] = join(",", strCrown(240), strPack("deepmire")), -- Reed Felucca, Double Hulled
    [145436] = strPack("deepmire"), -- Canopied Felucca, Double Hulled
    [145435] = join(",", strCrown(110), strPack("deepmire")), -- Plant, Marsh Mani Flower
    [145434] = join(",", strCrown(110), strPack("deepmire")), -- Plant, Large Inert Lantern Flower
    [145433] = join(",", strCrown(60), strPack("deepmire")), -- Plant, Rafflesia
    [145432] = join(",", strCrown(70), strPack("deepmire")), -- Plant, Canna Lily
    [145431] = join(",", strCrown(35), strPack("deepmire")), -- Plant, Marsh Nigella
    [145430] = join(",", strCrown(55), strPack("deepmire")), -- Plant, Star Blossom
    [145428] = join(",", strCrown(65), strPack("deepmire")), -- Murkmire Lantern Post, Covered
    [145427] = strPack("deepmire"), -- Serpent Skull, Colossal
    [145426] = join(",", strCrown(410), strPack("deepmire")), -- Murkmire Felucca, Canopied

    [134249] = strPack("sotha"), -- Sotha Sil, The Clockwork God
    [134248] = strPack("sotha"), -- Grand Mnemograph
    [134246] = strPack("sotha"), -- The Law of Gears

    [145493] = strCrate("xanmeer"), -- Lantern Mantis
    [145492] = strCrate("xanmeer"), -- Gas Blossom
    [145491] = strCrate("xanmeer"), -- Static Pitcher
  },

  [src.FISHING] = {
    -- fishing
    [145402] = fishing_swamp, -- Fish, Black Marsh
  },
}

-- 7 Summerset Isles
FurC.MiscItemSources[ver.ALTMER] = {
  [src.CROWN] = {
    [139650] = strCrown(30), -- Bushes, Ivy Cluster
    [139483] = strCrown(90), -- Alinor Column, Tumbled Timeworn
    [139482] = strCrown(200), -- Alinor Column, Huge Timeworn
    [139481] = strCrown(200), -- Alinor Column, Jagged Timeworn
    [139480] = strCrown(30), -- Plants, Redtop Grass Tuft
    [139376] = strCrown(260), -- Alinor Banner, Hanging
    [139368] = strCrown(100), -- Alinor Bathing Robes, Decorative
    [139366] = strCrown(2000), -- Alinor Fountain, Regal
    [139365] = strCrown(370), -- Psijic Lighting Globe, Framed
    [139364] = strCrown(1500), -- Sload Neural Tree, Active
    [139363] = strCrown(340), -- Sload Astral Nodule, Large
    [139362] = strCrown(340), -- Sload Astral Nodule, Small
    [139361] = strCrown(270), -- Mind Trap Kelp, Young
    [139360] = strCrown(510), -- Mind Trap Kelp, Cluster
    [139359] = strCrown(340), -- Mind Trap Coral Formation, Trees Capped
    [139358] = strCrown(340), -- Mind Trap Coral Formation, Tree Capped
    [139357] = strCrown(340), -- Mind Trap Coral Formation, Tree Antler
    [139356] = strCrown(340), -- Mind Trap Coral Formation, Waving Hands
    [139355] = strCrown(340), -- Mind Trap Coral Formation, Heart
    [139354] = strCrown(340), -- Mind Trap Coral Spire, Bulbous
    [139353] = strCrown(340), -- Mind Trap Coral Spire, Branched
    [139352] = strCrown(1000), -- Alinor Tomb, Ornate
    [139351] = strCrown(200), -- Alinor Monument, Marble
    [139350] = strCrown(940), -- Alinor Pergola, Purple Wisteria Overhang
    [139349] = strCrown(940), -- Alinor Pergola, Blue Wisteria Peaked
    [139348] = strCrown(940), -- Alinor Pergola, Purple Wisteria
    [139347] = strCrown(45), -- Flowers, Yellow Oleander Cluster
    [139346] = strCrown(45), -- Flowers, Lizard Tail Patch
    [139345] = strCrown(45), -- Flowers, Lizard Tail Cluster
    [139344] = strCrown(45), -- Flowers, Hummingbird Mint Cluster
    [139343] = strCrown(45), -- Tree, Cloud White
    [139342] = strCrown(45), -- Tree, Vibrant Pink
    [139341] = strCrown(310), -- Tree, Towering Poplar
    [139340] = strCrown(310), -- Tree, Ancient Summerset Spruce
    [139339] = strCrown(25), -- Vines, Sun-Bronzed Ivy Climber
    [139338] = strCrown(25), -- Vines, Sun-Bronzed Ivy Swath
    [139337] = strCrown(580), -- Tree, Ancient Blooming Ginkgo
    [139336] = strCrown(90), -- Trees, Shade Interwoven
    [139335] = strCrown(310), -- Tree, Shade Ancient
    [139334] = strCrown(20), -- Coral Formation, Tree Capped (green)
    [139333] = strCrown(45), -- Coral Formation, Trees Capped
    [139332] = join(",", strCrown(45), strPack("aquatic")), -- Coral Formation, Tree Shelf
    [139331] = strCrown(45), -- Coral Formation, Tree Antler
    [139330] = strCrown(45), -- Coral Formation, Waving Hands
    [139329] = strCrown(45), -- Coral Formation, Heart
    [139328] = strCrown(45), -- Coral Spire, Branched
    [139327] = strCrown(45), -- Coral Spire, Sturdy
    [139293] = strCrown(30), -- Alinor Chalice, Silver Ornate
    [139237] = strCrown(190), -- Alinor Wall Mirror, Noble
    [139161] = strCrown(1500), -- Daedric Table, Grand Necropolis
    [139160] = strCrown(200), -- Daedric Armchair, Severe
    [139159] = strCrown(920), -- Daedric Chandelier, Gruesome
    [139158] = strCrown(150), -- Daedric Candelabra, Tall
    [139156] = strCrown(360), -- Cocoon, Skeleton
    [139155] = strCrown(80), -- Cocoon, Food Storage
    [139154] = strCrown(40), -- Cocoons, Dormant Cluster
    [139153] = strCrown(40), -- Cocoon, Dormant
    [139152] = strCrown(360), -- Cocoon, Enormous Empty
    [139151] = strCrown(140), -- Mushrooms, Shadowpalm Cluster
    [139150] = strCrown(70), -- Mushrooms, Midnight Cluster
    [139149] = strCrown(30), -- Plant, Scarlet Fleshfrond
    [139148] = strCrown(70), -- Mushroom, Nettlecap
    [139147] = strCrown(30), -- Plants, Scarlet Sawleaf
    [139146] = strCrown(490), -- Crystals, Midnight Bloom
    [139145] = strCrown(430), -- Crystals, Midnight Tower
    [139144] = strCrown(400), -- Crystals, Midnight Spire
    [139143] = strCrown(310), -- Crystals, Midnight Cluster
    [139142] = strCrown(380), -- Crystals, Crimson Spikes
    [139141] = strCrown(310), -- Crystals, Crimson Bed
    [139140] = strCrown(340), -- Crystals, Crimson Spray
    [139126] = strCrown(50), -- Sapling, Ginkgo
    [139090] = strCrown(100), -- Alinor Table Runner, Cloth of Silver
    [139089] = strCrown(50), -- Alinor Table Runner, Coiled
    [139088] = strCrown(50), -- Alinor Table Runner, Verdant
    [139083] = strCrown(30), -- Plants, Grasswort Patch
    [139068] = strCrown(20), -- Plants, Springwheeze
    [139067] = strCrown(20) .. " or from harvesting plants in Summerset", -- Flower, Yellow Oleander
    [139066] = strCrown(30), -- Plant, Redtop Grass
    [139065] = strCrown(20), -- Flowers, Lizard Tail
    [134247] = strCrown(190), -- Soul Gem Module, Experimental
    [132165] = strCrown(750), -- Hlaalu Bath Tub, Empty Basin
    [126464] = strCrown(610), -- Telvanni Painting, Oversized Valley
    [126463] = strCrown(610), -- Telvanni Painting, Oversized Forest
    [126462] = strCrown(610), -- Telvanni Painting, Oversized Volcanic
    [126038] = strCrown(4000), -- Target Centurion, Robust Lambent
    [126037] = strCrown(4000), -- Target Centurion, Lambent
    [126034] = strCrown(4000), -- The Lord
    [125461] = strCrown(4000), -- The Lover
    [125460] = strCrown(4000), -- The Mage
    [125459] = strCrown(4000), -- The Ritual
    [125458] = strCrown(4000), -- The Serpent
    [125457] = strCrown(4000), -- The Shadow
    [125456] = strCrown(4000), -- The Steed
    [125455] = strCrown(4000), -- The Thief
    [125454] = strCrown(4000), -- The Tower
    [125453] = strCrown(4000), -- The Warrior
    [125452] = strCrown(4000), -- The Lady
    [125451] = strCrown(4000), -- The Apprentice
    [119556] = strCrown(4000), -- The Atronach
    [118491] = strCrown(55), -- Scroll, Bound
    [118145] = strCrown(410), -- Painting of a Desert, Refined
    [118144] = strCrown(410), -- Painting of a Forest, Refined
    [118142] = strCrown(410), -- Painting of Swamp, Refined
    [118140] = strCrown(410), -- Painting of a Waterfall, Refined
    [118138] = strCrown(410), -- Painting of Mountains, Refined

    [140220] = strPack("mephala"), -- Rumours of the Spiral Skein
    [139163] = strPack("mephala"), -- Mephala, The Webspinner (statue)
    [139097] = strPack("mephala"), -- Spiral Skein Glowstalks, Sprouts

    [139139] = strCrate("psijic"), -- Nocturnal, Mistress of Shadows
    [139138] = strCrate("psijic"), -- Banner, Nocturnal
    [139137] = strCrate("psijic"), -- Tapestry, Nocturnal
    [134474] = strCrate("fireatro"), -- Banner, Malacath
    [130192] = strCrate("reaper"), -- Statue of Sheogorath, the Madgod
    [130190] = strCrate("reaper"), -- Banner of Sheogorath
    [130189] = strCrate("reaper"), -- Tapestry of Sheogorath
  },

  [src.DROP] = {
    [139059] = GetString(SI_FURC_DROP), -- Ivory, Polished - drops from Echatere, and probably alot else
    [139066] = GetString(SI_FURC_LOOT_HARVEST), -- Plant, Redtop Grass

    [139060] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Ancient
    [139062] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Large
    [139063] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Enormous
    [139061] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Sealed

    [139073] = strQuest(6129, strLoc(loc.SUMMERSET, loc.LILANDRIL)), -- Painting of Summerset Coast, Refined ; Quest: The Perils of Art
    [139072] = GetString(SI_FURC_ELF_PIC), -- Painting of Monastery of Serene Harmony, Refined
    [139074] = GetString(SI_FURC_ELF_PIC), -- Painting of Aldmeri Ruins, Refined
    [139069] = GetString(SI_FURC_ELF_PIC), -- Painting of Griffin Nest, Refined
    [139070] = GetString(SI_FURC_ELF_PIC), -- Painting of College of the Sapiarchs, Refined
    [139071] = GetString(SI_FURC_ELF_PIC), -- Painting of High Elf Tower, Refined

    [87709] = GetString(SI_FURC_SRC_LVLUP), -- Imperial Brazier, Spiked
    [94098] = GetString(SI_FURC_SRC_LVLUP), -- Imperial Bed, Single

    [118143] = painting_summerset, -- Painting of Tree, Refined
    [118141] = painting_summerset, -- Painting of Cottage, Refined
    [118139] = painting_summerset, -- Painting of Valley, Refined
  },

  [src.FISHING] = {
    [139080] = fishing_summerset, -- Coral Formation, Ancient Pillar Polyps
    [139079] = fishing_summerset, -- Coral Formation, Fan Cluster
    [139081] = fishing_summerset, -- Plant, Sea Grapes
    [139084] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139085] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139068] = fishing_summerset, -- Plants, Springwheeze
    [139077] = fishing_summerset, -- Coral Formation, Bulwark
    [139078] = fishing_summerset, -- Coral Formation, Pillar Polyps
    [139082] = fishing_summerset, -- Plants, Ruby Glasswort Patch
  },
}

-- 6 Dragon Bones
FurC.MiscItemSources[ver.DRAGONS] = {
  [src.DROP] = {
    [134909] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Puspocket Group
    [134910] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Puspocket Cluster
    [134911] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Puspocket Sporecap
    [134912] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Large Puspocket
    [134913] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushroom, Tall Puspocket
    [134914] = strDungeon(loc.DUNG_FL, loc.DUNG_SCP), -- Mushrooms, Large Puspocket Cluster
  },

  [src.JUSTICE] = {},

  [src.CROWN] = {
    [134970] = strCrown(100), -- Mushrooms, Glowing Sprawl
    [134947] = strCrown(100), -- Mushrooms, Glowing Field
    [134948] = strCrown(400), -- Mushrooms, Glowing Cluster
    [134971] = strCrown(400), -- Candles, Votive Group
    [134972] = strCrown(400), -- Brotherhood Brazier, Wrought Iron
    [94100] = strCrown(50), -- Imperial BookCase, Swirled
    [130211] = strCrown(50), -- Books, Ordered Row
    [130210] = strCrown(50), -- Books, Scattered Row
  },
}

-- 5 Clockwork City
FurC.MiscItemSources[ver.CLOCKWORK] = {
  [src.DROP] = {
    [134407] = automaton_loot_cc, -- Factotum Torso, Obsolete
    [134404] = automaton_loot_cc, -- Factotum Knee, Obsolete
    [134408] = automaton_loot_cc, -- Factotum Elbow, Obsolete
    [134405] = automaton_loot_cc, -- Factotum Arm, Obsolete
    [134409] = automaton_loot_cc, -- Factotum Head, Obsolete
    [134406] = automaton_loot_cc, -- Factotum Body, Obsolete

    [132348] = questRewardString .. "the Brass Citadel", -- The Precursor
  },

  [src.JUSTICE] = {
    [134410] = stealable_cc, -- Clockwork Crank, Miniature
    [134411] = stealable_cc, -- Clockwork Gear Shaft, Miniature
    [134412] = stealable_cc, -- Clockwork Piston, Miniature
    [134413] = stealable_cc, -- Clockwork Magnifier, Handheld
    [134414] = stealable_cc, -- Clockwork Micrometer, Handheld
    [134415] = stealable_cc, -- Clockwork Dial Calipers, Handheld
    [134416] = stealable_cc, -- Clockwork Slide Calipers, Handheld
    [134402] = stealable, -- Spool, Empty
    [134400] = stealable, -- Soft Leather, Stacked
    [134401] = stealable, -- Soft Leather, Folded
    [134417] = stealable_cc, -- Clockwork Firm-Joint Calipers, Handheld
    [134399] = stealable, -- Quality Fabric, Folded
    [117939] = stealable_wood, -- Rough Axe, Practical
  },

  [src.CROWN] = {
    [134266] = strCrown(80), -- Daedric Books, Stacked
    [134265] = strCrown(80), -- Daedric Books, Piled
    [134373] = strCrown(410), -- Clockwork Wall Machinery, Rectangular
    [134374] = strCrown(410), -- Clockwork Wall Machinery, Circular
    [134382] = strCrown(870), -- Fabricant Tree, Beryl Cypress
    [134383] = strCrown(870), -- Fabricant Tree, Towering Maple
    [134385] = strCrown(870), -- Fabricant Tree, Brass Swamp
    [134387] = strCrown(870), -- Fabricant Tree, Tall Cobalt Spruce
    [134388] = strCrown(870), -- Fabricant Tree, Cobalt Oak
    [134384] = strCrown(870), -- Fabricant Tree, Decorative Electrum
    [134386] = strCrown(260), -- Fabricant Tree, Forked Cherry Blossom
    [134389] = strCrown(140), -- Fabricant Tree, Decorative Brass
    [134390] = strCrown(140), -- Clockwork Junk Heap, Large
    [134391] = strCrown(510), -- Clockwork Sequence Spool, Column
    [134392] = strCrown(260), -- Clockwork Recharging Column, Octet
    [134393] = strCrown(270), -- Clockwork Workbench, Spacious
    [134394] = strCrown(460), -- Clockwork Illuminator, Capsule Chandelier
    [134395] = strCrown(150), -- Clockwork Illuminator, Wall Capsule
    [134396] = strCrown(410), -- Clockwork Wall Machinery, Tall
    [134397] = strCrown(410), -- Clockwork Wall Machinery, Ovoid
    [134398] = strCrown(1300), -- Clockwork Gazebo, Copper and Basalt
  },
}

-- 4 Horns of the Reach
FurC.MiscItemSources[ver.REACH] = {
  [src.JUSTICE] = {
    [130191] = stealable, -- Shivering Cheese
    [118206] = stealable_thief, -- Gaming dice
  },
  [src.DROP] = {
    -- Coldharbour items
    [130284] = GetString(SI_FURC_LOOT_HARVEST), -- Glowstalk, Seedlings
    [131422] = GetString(SI_FURC_LOOT_HARVEST), -- Flower Patch, Glowstalks
    [130283] = GetString(SI_FURC_LOOT_HARVEST), -- Glowstalk, Sprout
    [130285] = GetString(SI_FURC_LOOT_HARVEST), -- Glowstalk, Young
    [131420] = GetString(SI_FURC_LOOT_HARVEST), -- Shrub, Glowing Thistle
    [130281] = GetString(SI_FURC_LOOT_HARVEST), -- Glowstalk, Towering
    [130282] = GetString(SI_FURC_LOOT_HARVEST), -- Glowstalk, Strong

    [130067] = GetString(SI_FURC_DAEDRA_SOURCE), -- Daedric Chain Segment
  },
}

-- 3 Morrowind
FurC.MiscItemSources[ver.MORROWIND] = {
  [src.DROP] = {

    --Public dungeon Forgotten Wastes / maybe rarest drop at all ingame
    [127149] = pdung_vv_fw, -- Morrowind Banner of the 6th House

    -- Dwemer parts
    [126660] = automaton_loot_vv, -- Dwemer Gear, Tiered
    [126659] = automaton_loot_vv, -- Dwemer Gear, Flat

    -- lootable in tombs
    [126754] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Seeker
    [126705] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Wisdom
    [126704] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Majesty
    [126706] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Knowledge
    [126701] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Nerevar
    [126764] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Prowess
    [126702] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Reverance
    [126700] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Honor
    [126703] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Mysteries
    [126752] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Discovery
    [126755] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Change
    [126756] = GetString(SI_FURC_TOMBS), -- Velothi Shroud, Mercy

    [126773] = GetString(SI_FURC_TOMBS), -- Velothi Caisson, Crypt
    [126753] = GetString(SI_FURC_TOMBS), -- Velothi Cerecloth, Austere
    [126758] = GetString(SI_FURC_TOMBS), -- Velothi Mat, Prayer
    [126757] = GetString(SI_FURC_TOMBS),

    [126465] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Modest Volcanic
    [126466] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Modest Forest
    [126467] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Modest Valley

    [126468] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Classic Volcanic
    [126469] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Classic Forest
    [126470] = GetString(SI_FURC_CHEST_VV), -- Telvanni Painting, Classic Valley

    [126593] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Volcano
    [126594] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Volcano
    [126595] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Volcano
    [126596] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Volcano
    [126605] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Waterfall
    [126606] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Waterfall
    [126608] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Waterfall
    [126609] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Waterfall
    [126599] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tryptich, Geyser
    [126600] = GetString(SI_FURC_VV_PAINTING), -- Velothi Tapestry, Geyser
    [126602] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Classic Geyser
    [126603] = GetString(SI_FURC_VV_PAINTING), -- Velothi Painting, Modest Geyser

    -- Ashlander dailies
    [126119] = GetString(SI_FURC_DAILY_ASH), -- Crimson Shard of Moonshadow
    [126393] = GetString(SI_FURC_DAILY_ASH), -- Ashlander Knife, Cheese

    -- drops from plants
    [125631] = plants_vvardenfell, -- Plants, Ash Frond
    [131420] = plants_vvardenfell, -- Plants, Ash Frond
    [125553] = plants_vvardenfell, -- Flowers, Netch Cabbage Stalks
    [125551] = plants_vvardenfell, -- Flowers, Netch Cabbage
    [125552] = plants_vvardenfell, -- Flowers, Netch Cabbage Patch
    [125543] = plants_vvardenfell, -- Fern, Ashen
    [125633] = plants_vvardenfell, -- Plants, Hanging Pitcher Pair
    [125680] = plants_vvardenfell, -- Vines, Ashen Moss

    [125562] = plants_vvardenfell, -- Grass, Foxtail Cluster
    [125595] = plants_vvardenfell, -- Mushroom, Poison Pax Shelf
    [125596] = plants_vvardenfell, -- Mushroom, Poison Pax Stool
    [125600] = plants_vvardenfell, -- Mushroom, Spongecap Patch
    [125606] = plants_vvardenfell, -- Mushroom, Young Milkcap
    [125608] = plants_vvardenfell, -- Mushrooms, Buttercake Cluster
    [125609] = plants_vvardenfell, -- Mushrooms, Buttercake Stack
    [125613] = plants_vvardenfell, -- Mushrooms, Lavaburst Sprouts
    [125590] = plants_vvardenfell, -- Mushrooms, Lavaburst Cluster
    [125617] = plants_vvardenfell, -- Plant, Bitter Stalk
    [125618] = plants_vvardenfell, -- Plant, Golden Lichen
    [125619] = plants_vvardenfell, -- Plant, Hanging Pitcher
    [125620] = plants_vvardenfell, -- Plant, Hefty Elkhorn
    [125621] = plants_vvardenfell, -- Plant, Lava Brier
    [125622] = plants_vvardenfell, -- Plant, Lava Leaf
    [125630] = plants_vvardenfell, -- Plant, Young Elkhorn
    [125632] = plants_vvardenfell, -- Plants, Hanging Pitcher Cluster
    [125634] = plants_vvardenfell, -- Plants, Lava Pitcher Cluster
    [125635] = plants_vvardenfell, -- Plants, Lava Pitcher Shoots
    [125636] = plants_vvardenfell, -- Plants, Swamp Pitcher Cluster
    [125637] = plants_vvardenfell, -- Plants, Swamp Pitcher Shoots
    [125647] = plants_vvardenfell, -- Shrub, Bitter Brush
    [125648] = plants_vvardenfell, -- Shrub, Bitter Cluster
    [125649] = plants_vvardenfell, -- Shrub, Flowering Dusk
    [125650] = plants_vvardenfell, -- Shrub, Golden Lichen
    [125670] = plants_vvardenfell, -- Toadstool, Bloodtooth
    [125671] = plants_vvardenfell, -- Toadstool, Bloodtooth Cap
    [125672] = plants_vvardenfell, -- Toadstool, Bloodtooth Cluster

    [126759] = strQuest(5864, strLoc(loc.VVARDENFELL, loc.VVARDENFELL_SURAN)), -- Sir Sock's Ball of Yarn ; Quest: 'Nothing to Sneeze At'

    [126592] = GetString(SI_FURC_LOOT_PLANTS), -- Plants, Hanging Pitcher Pair
  },

  [src.CROWN] = {
    [130213] = join(",", strCrown(430), strPack("ayleid")), -- Ayleid Cage, Hanging
    [130212] = strPack("ayleid"), -- Daedra Worship: The Ayleids
    [130207] = join(",", strCrown(270), strPack("ayleid")), -- Ayleid Plinth, Engraved
    [130206] = join(",", strCrown(370), strPack("ayleid")), -- Ayleid Apparatus, Welkynd
    [130205] = join(",", strCrown(680), strPack("ayleid")), -- Ayleid Statue, Pious Priest
    [130204] = join(",", strCrown(410), strPack("ayleid")), -- Welkynd Stones, Glowing
    [130202] = join(",", strCrown(170), strPack("ayleid")), -- Ayleid Grate, Tall
    [130201] = join(",", strCrown(170), strPack("ayleid")), -- Ayleid Grate, Small
    [130199] = join(",", strCrown(170), strPack("ayleid")), -- Ayleid Bookshelf, Bare
    [130197] = join(",", strCrown(170), strPack("ayleid")), -- Ayleid Bookcase, Filled

    [134578] = strCrown(110), -- Ice Floe, Thick
    [134577] = strCrown(50), -- Ice Floe, Thin
    [134576] = strCrown(190), -- Orcish Brazier, Snowswept Column
    [134575] = strCrown(50), -- Boulder, Snowswept Crag
    [134574] = strCrown(50), -- Boulder, Snowswept Peak
    [134573] = strCrown(5), -- Stone, Snowswept Shard
    [134572] = strCrown(5), -- Stones, Snowswept Cluster
    [134571] = strCrown(120), -- Snow Pile, Large
    [134570] = strCrown(110), -- Snow Pile
    [134569] = strCrown(40), -- Trees, Snowswept Pair
    [134568] = strCrown(40), -- Tree, Snowswept Evergreen
    [134567] = strCrown(10), -- Bush Cluster, Snowswept
    [134566] = strCrown(30), -- Shrub Cluster, Snowswept
    [134565] = strCrown(130), -- Fabrication Tank, Reinforced
    [134381] = strCrown(110), -- Rocks, Sintered Outcropping
    [134380] = strCrown(110), -- Rocks, Sintered Arch
    [134379] = strCrown(50), -- Boulder, Large Metallic Shard
    [131427] = strCrown(1700), -- Orcish Tent, General's
    [131426] = strCrown(680), -- Orcish Tent, Officer's
    [131425] = strCrown(360), -- Orcish Tent, Soldier's
    [130329] = strCrown(240), -- Primal Brazier, Rock Slab
    [130322] = strCrown(90), -- Tool, Harvest Scythe
    [130319] = strCrown(10), -- Crop, Wheat Stack
    [130318] = strCrown(10), -- Crop, Wheat Pile
    [130317] = strCrown(25), -- Pumpkin, Sickly
    [130316] = strCrown(25), -- Pumpkin, Frail
    [126686] = strCrown(400), -- Dwarven Chest, Relic
    [126607] = strCrown(410), -- Velothi Painting, Oversized Waterfall
    [126604] = strCrown(410), -- Velothi Panels, Geyser
    [126601] = strCrown(410), -- Velothi Painting, Oversized Geyser
    [126598] = strCrown(410), -- Velothi Panels, Waterfall
    [126597] = strCrown(410), -- Velothi Painting, Oversized Volcano
    [126592] = strCrown(410), -- Velothi Panels, Volcano
    [126479] = strCrown(310), -- Telvanni Sconce, Organic Amber
    [126478] = strCrown(560), -- Telvanni Arched Light, Organic Amber
    [126477] = strCrown(560), -- Telvanni Streetlight, Organic Amber
    [126476] = strCrown(200), -- Telvanni Lamp, Organic Amber
    [126475] = strCrown(260), -- Telvanni Lantern, Organic Amber
    [125628] = strCrown(70), -- Plant, Rosetted Sundew
    [125616] = strCrown(5), -- Pebble, Volcanic Chunk
    [125610] = strCrown(25), -- Mushrooms, Cave Bracket Cluster
    [125607] = strCrown(10), -- Mushroom, Young Netch Shield
    [125605] = strCrown(10), -- Mushroom, Young Erupted Stinkcap
    [125603] = strCrown(40), -- Mushroom, Stinkhorn Spore
    [125580] = getHouseString(1244), -- Hlaalu Well, Covered Sillar Stone
    [125579] = getHouseString(1243), -- Hlaalu Well, Braced Sillar Stone
    [125577] = getHouseString(1243), -- Hlaalu Wall Post, Sillar Stone
    [125573] = getHouseString(1243, 1244), -- Hlaalu Streetlamp, Paper
    [125568] = getHouseString(1243), -- Hlaalu Sidewalk, Sillar Stone
    [125567] = getHouseString(1244), -- Hlaalu Shed, Open
    [125566] = getHouseString(1243), -- Hlaalu Shed, Enclosed
    [125565] = getHouseString(1244), -- Hlaalu Lantern, Hanging Paper
    [125555] = strCrown(85), -- Flowers, Sullen Purple Bat Blooms
    [125554] = strCrown(85), -- Flowers, Opposing Purple Bat Blooms
    [125550] = strCrown(85), -- Flowers, Lava Blooms
    [125549] = strCrown(85), -- Flowers, Double Purple Bat Blooms
    [125548] = strCrown(85), -- Flower, Towering Purple Bat Bloom
    [125545] = strCrown(30), -- Fern, Young Dusky
    [125484] = strCrown(30), -- Bush, Lush Laurel
    [125482] = strCrown(50), -- Boulder, Volcanic Crag
    [121400] = strCrown(2000), -- Target Skeleton, Robust Argonian
    [121399] = strCrown(2000), -- Target Skeleton, Robust Khajiit
    [121056] = strCrown(25), -- Book Stack, Decorative
    [121054] = strCrown(30), -- Breton Mug, Empty
    [121053] = strCrown(170), -- Jar, Gilded Canopic
    [121052] = strCrown(100), -- Vase, Gilded Offering
    [121047] = strCrown(25), -- Book Row, Long
    [121045] = strCrown(25), -- Book Row, Decorative
    [121044] = strCrown(30), -- Plant, Healthy White Hosta
    [121043] = strCrown(30), -- Plant, Summer Hosta
    [121042] = strCrown(10), -- Plant, Young Summer Hosta
    [121041] = strCrown(10), -- Plant, Young Verdant Hosta
    [121040] = strCrown(30), -- Plant, Verdant Hosta
    [121039] = strCrown(30), -- Plant, Blooming White Hosta
    [121038] = strCrown(30), -- Plant, Paired White Hosta
    [121037] = strCrown(30), -- Shrub, Sparse Pink
    [121033] = strCrown(25), -- Sapling, Sparse Laurel
    [121027] = strCrown(45), -- Hedge, Dense Low Arc
    [121019] = strCrown(10), -- Plants, Dense Underbrush
    [121017] = strCrown(10), -- Bush, Dense Forest
    [121002] = strCrown(45), -- Flowers, Violet Prairie
    [121001] = strCrown(45), -- Flowers, Golden Prairie
    [120491] = strCrown(30), -- Fern, Hearty Autumn
    [120486] = strCrown(30), -- Cactus, Stocky Columnar
    [120484] = strCrown(30), -- Cactus, Golden Barrel
    [120482] = strCrown(30), -- Cactus, Golden Bulbs
    [120481] = strCrown(150), -- Tree, Ancient Juniper
    [120475] = strCrown(70), -- Trees, Paired Wax Palms4
    [120473] = strCrown(60), -- Sapling, Thin Palm
    [120472] = strCrown(25), -- Tree, Young Palm
    [120470] = strCrown(25), -- Tree, Leaning Palm
    [120466] = strCrown(5), -- Pebble, Stacked Desert
    [120465] = strCrown(5), -- Stone, Tapered Rough
    [120464] = strCrown(20), -- Rocks, Stacked Cracked
    [120427] = strCrown(1500), -- Target Skeleton, Argonian
    [120426] = strCrown(1500), -- Target Skeleton, Khajiit
    [120420] = strCrown(140), -- Plaque, Bolted Deer Antlers
    [120416] = strCrown(40), -- Common Cloak on a Hook
    [120415] = strCrown(30), -- Breton Tankard, Full
    [120414] = strCrown(30), -- Breton Tankard, Empty
    [120413] = strCrown(30), -- Breton Pitcher, Clay
    [120412] = strCrown(50), -- Noble's Chalice
    [120409] = strCrown(100), -- Argonian Rack, Woven
    [120408] = strCrown(25), -- Argonian Fish in a Basket
    [118663] = getHouseString(1078, 1079), -- Dark Elf Bed of Coals

    [126039] = strCrate("dwemer"), -- Statue of masked Clavicus Vile with Barbas
  },

  [src.JUSTICE] = {
    [126481] = zo_strformat("<<1>> <<2>>", join(",", stealable_priests, stealable_pilgrims), loc_vvardenfell), -- Indoril Incense, Burning
    [126772] = stealable_thief, -- Khajiiti Ponder sphere
  },
}

-- 2 Homestead
FurC.MiscItemSources[ver.HOMESTEAD] = {
  [src.JUSTICE] = {
    -- stealing
    [118489] = stealable_scholars, -- Papers, Stack
    [118528] = stealable, -- Signed Contract
    [118890] = stealable, -- Skull, Human
    [118487] = stealable_scholars, -- Letter, Personal
    [120008] = stealable_nerds, -- Lesser Soul Gem, Empty
    [120005] = stealable_nerds, -- Papers, Stack

    -- Bounty Sheets
    [118711] = stealable_guard, -- Argonian Male
    [118709] = stealable_guard, -- Breton Male
    [118712] = stealable_guard, -- Breton Woman
    [118715] = stealable_guard, -- Colovian Man
    [118710] = stealable_guard, -- High Elf Male
    [118714] = stealable_guard, -- Imperial Man
    [118713] = stealable_guard, -- Khajiiti Male
    [118716] = stealable_guard, -- Orc Female
    [118717] = stealable_guard, -- Orc Male

    [121055] = stealable_drunkards, -- Breton Mug, Full

    [116512] = stealable_loc_wrothgar, -- Orcish Carpet Blood
  },

  [src.FISHING] = {
    -- fishing
    [118902] = fishing, -- Coral, Sun
    [118903] = fishing, -- Coral, Crown
    [118896] = fishing, -- Seashell, Sandcake
    [118901] = fishing, -- Sea sponge
    [118338] = fishing, -- Fish, Bass
    [118339] = fishing, -- Fish, Salmon
    [118337] = fishing, -- Fish, Trout
    [120753] = fishing, -- Kelp, Green Pile
    [120755] = fishing, -- Kelp, Lush Pile
    [120754] = fishing, -- Kelp, Small Pile
    [118897] = fishing, -- Seashell, Pink Scallop
    [118898] = fishing, -- Seashell, White Scallop
    [118899] = fishing, -- Seashell, Starfish
    [118900] = fishing, -- Seashell, Noble Starfish
  },

  [src.DROP] = {
    [121058] = db_sneaky, -- Candles of Silence
    [119936] = db_poison, -- Poisoned Blood
    [119938] = db_poison, -- Light and Shadow
    [119952] = db_equip, -- Sacrificial Heart

    -- Paintings
    [118216] = chests_string, -- Painting of Spring, Sturdy
    [118217] = chests_string, -- Painting of Pasture, Sturdy
    [118218] = chests_string, -- Painting of Creek, Sturdy
    [118219] = chests_string, -- Painting of Lakes, Sturdy
    [118220] = chests_string, -- Painting of Crags, Sturdy
    [118221] = chests_string, -- Painting of Summer, Sturdy
    [118222] = chests_string, -- Painting of Jungle, Sturdy
    [118223] = chests_string, -- Painting of Palms, Sturdy
    [118265] = chests_string, -- Painting of Winter, Bolted
    [118266] = chests_string, -- Painting of Bridge, Bolted
    [118267] = chests_string, -- Painting of Autumn, Bolted
    [118268] = chests_string, -- Painting of Great Ruins, Bolted
  },

  [src.CROWN] = {
    [120607] = strCrown(50), -- Sapling, Lanky Ash
    [120413] = strCrown(30), -- Breton Pitcher, Clay
    [118351] = strCrown(25), -- Box of Peaches
    [118278] = strCrown(140), -- Plaque, Bordered Deer Antlers
    [118126] = strCrown(95), -- Plaque, Standard
    [118121] = strCrown(15), -- Knife, Carving
    [118120] = strCrown(120), -- Minecart, Push
    [118119] = strCrown(120), -- Minecart, Empty
    [118118] = strCrown(100), -- Candles, Lasting
    [118098] = strCrown(10), -- Common Bowl, Serving
    [118096] = strCrown(10), -- Bread, Plain
    [118071] = strCrown(120), -- Simple Red Banner
    [118070] = strCrown(120), -- Simple Purple Banner
    [118069] = strCrown(120), -- Simple Gray Banner
    [118068] = strCrown(120), -- Simple Brown Banner
    [118066] = strCrown(15), -- Steak Dinner
    [118065] = strCrown(45), -- Common Cargo Crate, Dry
    [118064] = strCrown(45), -- Common Barrel, Dry
    [118062] = strCrown(15), -- Chicken Meal, Display
    [118061] = strCrown(15), -- Chicken Dinner, Display
    [118060] = strCrown(20), -- Sack of Grain
    [118059] = strCrown(20), -- Sack of Millet,
    [118058] = strCrown(20), -- Sack of Rice
    [118057] = strCrown(20), -- Sack of Beans
    [118056] = strCrown(15), -- Common Stewpot, Hanging
    [118055] = strCrown(80), -- Common Firepit, Piled
    [118054] = strCrown(80), -- Common Firepit, Outdoor
    [118000] = strCrown(10), -- Garlic String, Display
    [117952] = strCrown(35), -- Rough Torch, Wall
    [115698] = strCrown(1100), -- Khajiit Statue, Guardian
    [115395] = strCrown(40), -- Nord Drinking Horn, Display
    [94098] = strCrown(95), -- Imperial Bed, Single

    [134473] = strCrate("fireatro"), -- Tapestry,  Malacath
  },
}
