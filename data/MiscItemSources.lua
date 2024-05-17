FurC.MiscItemSources = FurC.MiscItemSources or {}

local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources

-- locations
local backwaterSwamp = GetString(SI_FURC_LOC_MURKMIRE)
local gloriousHome = GetString(SI_FURC_LOC_VVARDENFELL)
local in_blackwood = GetString(SI_FURC_LOC_BLACKWOOD)
local in_elsweyr = GetString(SI_FURC_LOC_ELSWEYR)
local in_goldcoast = GetString(SI_FURC_LOC_GOLDCOAST)
local in_necrom = GetString(SI_FURC_LOC_NECROM)
local in_hewsbane = GetString(SI_FURC_LOC_HEW)
local in_nelsweyr = GetString(SI_FURC_LOC_NELSWEYR)
local in_selsweyr = GetString(SI_FURC_LOC_SELSWEYR)
local in_skyrim = GetString(SI_FURC_LOC_SKYRIM)
local on_summerset = GetString(SI_FURC_LOC_SUMMERSET)
local in_wrothgar = GetString(SI_FURC_LOC_WROTHGAR)

-- Quests and Guilds
local questRewardString = GetString(SI_FURC_QUESTREWARD)
local questRewardSuran = zo_strformat("<<1>> <<2>>", questRewardString, GetString(SI_FURC_LOC_SURAN))
local questRewardLilandril = zo_strformat("<<1>> <<2>>", questRewardString, GetString(SI_FURC_LOC_LILANDRIL))
local tribute = GetString(SI_FURC_ITEMSRC_TRIBUTE)
local tribute_ranked = GetString(SI_FURC_ITEMSRC_TRIBUTE_RANKED)
local db_poison = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local db_sneaky = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))
local db_equip = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_EQUIP))

-- Events
local blackwood_event = GetString(SI_FURC_EVENT_BLACKWOOD)
local sinister_hollowjack = GetString(SI_FURC_EVENT_HOLLOWJACK)
local elsweyr_event = GetString(SI_FURC_EVENT_ELSWEYR)

-- Stealing
local stealable = GetString(SI_FURC_CANBESTOLEN)
local pickpocketable = GetString(SI_FURC_CANBEPICKED)
local stealable_guard = pickpocketable .. " from guards"
local stealable_cc = stealable .. " in Clockwork City"
local stealable_scholars = stealable .. " from scholars"
local stealable_nerds = stealable_scholars .. " and mages"
local stealable_priests = stealable .. " from priests and pilgrims"
local stealable_thief = stealable .. " from thieves"
local stealable_woodworkers = stealable .. " from woodworkers"
local stealable_drunkards = stealable .. " from drunkards"
local stealable_wrothgar = stealable .. " " .. in_wrothgar
local stealable_swamp = stealable .. backwaterSwamp
local stealable_elsewhere = stealable .. in_elsweyr
local pickpocket_necrom = pickpocketable .. " in Telvanni Peninsula or Apocrypha"
local painting_summerset = GetString(SI_FURC_ITEMSOURCE_SAFEBOX) .. " (Summerset)"

-- Looting/Harvesting
local scrying = GetString(SI_FURC_CANBESCRYED)
local chests_string = GetString(SI_FURC_CHESTS)

local automaton_loot_cc = GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local automaton_loot_vv = GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"
local chests_skyrim = chests_string .. in_skyrim
local chests_blackwood = chests_string .. in_blackwood
local chests_summerset = chests_string .. on_summerset
local chests_elsweyr = chests_string .. in_elsweyr
local chests_high = chests_string .. " in High Isle"
local chests_blackr_grcaverns = chests_string .. " in Blackreach: Greymoor Caverns"
local book_hall = "From chests in the Scrivener's Hall vault"
local nymic = "From Bastion Nymic reward chests"
local chests_necrom = chests_string .. in_necrom
local puplicdungeon_fw_vv = GetString(SI_FURC_DROP) .. " in Forgotten Wastes" .. gloriousHome
local plants_vvardenfell = GetString(SI_FURC_PLANTS) .. gloriousHome
local fishing_summerset = GetString(SI_FURC_CANBEFISHED) .. on_summerset
local fishing_swamp = GetString(SI_FURC_CANBEFISHED) .. backwaterSwamp
local endless_archive = "From chests in the Infinite Archive"

local colours = FurC.ItemLinkColours
local currencies = {
  [CURT_NONE] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_NONE),
  },
  [CURT_MONEY] = {
    colour = colours.Gold,
    name = GetCurrencyName(CURT_MONEY),
  },
  [CURT_ALLIANCE_POINTS] = {
    colour = colours.AP,
    name = GetCurrencyName(CURT_ALLIANCE_POINTS),
  },
  [CURT_TELVAR_STONES] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_TELVAR_STONES),
  },
  [CURT_WRIT_VOUCHERS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_WRIT_VOUCHERS),
  },
  [CURT_CHAOTIC_CREATIA] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CHAOTIC_CREATIA),
  },
  [CURT_CROWN_GEMS] = {
    colour = colours.TelVar,
    name = GetCurrencyName(CURT_CROWN_GEMS),
  },
  [CURT_CROWNS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_CROWNS),
  },
  [CURT_STYLE_STONES] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_STYLE_STONES),
  },
  [CURT_EVENT_TICKETS] = {
    colour = colours.Voucher,
    name = GetCurrencyName(CURT_EVENT_TICKETS),
  },
  [CURT_UNDAUNTED_KEYS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_UNDAUNTED_KEYS),
  },
  [CURT_ENDEAVOR_SEALS] = {
    colour = colours.Vendor,
    name = GetCurrencyName(CURT_ENDEAVOR_SEALS),
  },
}

local priceUnknown = "?"
local function getPriceString(price, currency_id)
  local priceString = ((not price or price < 0) and priceUnknown) or tostring(price)

  local currency = currencies[currency_id]
  priceString = FurC.colourise(priceString, currency.colour)

  return zo_strformat("<<1>> (<<2>>)", currency.name, priceString)
end
FurC.GetPriceString = getPriceString

local function getPartOfItemString(itemid, note)
  if not itemid or itemid == 0 then
    return ""
  end

  local itemLink = zo_strformat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", tostring(itemid))

  local result_str = zo_strformat(GetString(SI_FURC_PART_OF), itemLink)
  if note then
    return result_str .. " - " .. note
  end

  return result_str
end
FurC.GetPartOfItemString = getPartOfItemString

-- Crowns
local function getCrownPrice(price)
  return getPriceString(price, CURT_CROWNS)
end

local function getGemPrice(price)
  return getPriceString(price, CURT_CROWN_GEMS)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2) -- use collectible number from https://wiki.esoui.com/Collectibles instead of houseIDs.
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then
    houseName = houseName .. ", " .. GetCollectibleName(houseId2)
  end
  return zo_strformat(housesource, houseName)
end
local mischouse = GetString(SI_FURC_ITEMSOURCE_MISCHOUSE)

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
local function getScamboxString(scamboxName)
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
local function getItempackString(itempackName)
  itempackName = string.lower(itempackName)
  return zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), GetString(itempacks[itempackName]))
end

-- Multiple Sources
local function getMultipleSources(sources)
  -- returns a string with all sources separated by localised " or "
  local sourceString = ""
  for i, source in ipairs(sources) do
    if i > 1 then
      sourceString = sourceString .. " " .. GetString(SI_FURC_OR) .. " "
    end
    sourceString = sourceString .. source
  end
  return sourceString
end

-- 28 Secrets of the Telvanni
FurC.MiscItemSources[ver.ENDLESS] = {
  [src.CROWN] = {
    [199112] = getScamboxString("allmaker"), -- Chandelier, Kyne's Radiance",
    [199111] = getScamboxString("allmaker"), -- Fountain, Kyne's Radiance",
    [199110] = getScamboxString("allmaker"), -- Snowfall, Gentle",
    [199109] = getScamboxString("allmaker"), -- Boulder, Clear Ice",
  },

  [src.DROP] = {
    [203472] = endless_archive, -- Materials for Novice Necromancers",
    [203471] = endless_archive, -- The Spotted Towers",
    [203470] = endless_archive, -- Song of Fate",
    [203469] = endless_archive, -- House Telvanni Song",
    [203468] = endless_archive, -- The Waiting Door",
    [203467] = endless_archive, -- Captain Burwarah's Records",
    [203466] = endless_archive, -- The Silver Rose Blooms over Borderwatch",
    [203465] = endless_archive, -- Archmagister Mavon's Ascension",
    [203464] = endless_archive, -- Fynboar the Resurrected",
    [203463] = endless_archive, -- Obscure Killers of the North",
    [203462] = endless_archive, -- The Remnant Truth",
    [203461] = endless_archive, -- Parables of Saint Vorys",
    [203460] = endless_archive, -- Malkhest's Journal",
    [203459] = endless_archive, -- A Servant's Tale",
    [203458] = endless_archive, -- The Last Addition of Bikkus-Muz",
    [203457] = endless_archive, -- Preparing Necrom Kwama, Fifth Draft",
    [203456] = endless_archive, -- The Prior's Fulcrum",
    [203455] = endless_archive, -- Plague Concoctor's Instructions",
    [203454] = endless_archive, -- Dusksaber Report",
    [203453] = endless_archive, -- Mouth Vabdru's Journal",
    [203452] = endless_archive, -- First Mate Dalmir's Log",
    [203451] = endless_archive, -- Fanlyrion's Journal",
    [203450] = endless_archive, -- Tidefall Cantos I",
    [203449] = endless_archive, -- Our Dunmer Heritage",
    [203448] = endless_archive, -- A Feast Among the Dead, Chapter IV",
    [203447] = endless_archive, -- A Feast Among the Dead, Chapter III",
    [203446] = endless_archive, -- A Feast Among the Dead, Chapter II",
    [203445] = endless_archive, -- What's an Arcanist? Part 1",
    [203444] = endless_archive, -- What's an Arcanist? Part 2",
    [203443] = endless_archive, -- Working in the Infinite Panopticon",
    [203442] = endless_archive, -- What About Glyphics?",
    [203441] = endless_archive, -- On Cipher's Midden",
    [203440] = endless_archive, -- The Littlest Tomeshell",
    [203439] = endless_archive, -- A New Cult Arises",
    [203438] = endless_archive, -- Torvesard's Journal",
    [203437] = endless_archive, -- Daedric Worship and the Dark Elves",
    [203436] = endless_archive, -- Ciphers of the Eye",
    [203435] = endless_archive, -- Planar Exploration Vol. 14: Darkreave Curators",
    [203434] = endless_archive, -- Beverages for the Bereaved",
    [203433] = endless_archive, -- Denizens of Apocrypha",
    [203432] = endless_archive, -- History of Necrom: The City of the Dead",
    [203431] = endless_archive, -- Brave Little Scrib and the River Troll",
    [203430] = endless_archive, -- A Brief History of House Telvanni",
    [203429] = endless_archive, -- A Feast Among the Dead, Chapter I",
    [203428] = endless_archive, -- Visitor's Guide: Telvanni Peninsula",
    [203427] = endless_archive, -- Critter Dangers: Telvanni Peninsula",
    [203426] = endless_archive, -- We Reject the Pact",
    [203425] = endless_archive, -- Our Puny Allies",
    [203424] = endless_archive, -- The Spires of the 34th Sermon",
    [203423] = endless_archive, -- Master of the Tides of Fate",
    [203422] = endless_archive, -- On the Nature of Nymics",
    [203421] = endless_archive, -- The Dangers of Truth",
    [203420] = endless_archive, -- A Summoner's Guide to Nymics",
    [203419] = endless_archive, -- Kynmarcher Strix's Journal",
    [203418] = endless_archive, -- Life in the Camonna Tong",
    [203417] = endless_archive, -- Herma-Mora: The Woodland Man?",
    [203416] = endless_archive, -- How Rajhin Stole the Book that Knows",
    [203415] = endless_archive, -- On Tracts Perilous",
    [203414] = endless_archive, -- Uluscant's Manifesto",
    [203413] = endless_archive, -- The Currency of Secrets",
    [203412] = endless_archive, -- On Joining the Keepers of the Dead",
    [203411] = endless_archive, -- A Report on the Dusksabers",
    [203410] = endless_archive, -- Ranks and Titles of House Telvanni",
    [203409] = endless_archive, -- Oath of the Keepers",
    [203408] = endless_archive, -- Larydeilmo is Sane",
    [203407] = chests_string .. " in Wrothgar", -- Vosh Rakh",
    [203406] = chests_string .. " in Wrothgar", -- Vorgrosh Rot-Tusk's Guide to Dirty Fighting",
    [203405] = chests_string .. " in Wrothgar", -- Orc Clans and Symbology",
    [203404] = chests_string .. " in Wrothgar", -- Birds of Wrothgar",
    [203403] = chests_summerset, -- The Ubiquitous Sinking Isle",
    [203402] = chests_summerset, -- The Truth of Minotaurs",
    [203401] = chests_summerset, -- The Flight of Gryphons",
    [203400] = chests_summerset, -- Artaeum Lost",
    [203399] = chests_string .. in_selsweyr, -- The Marriage of Moon and Tide",
    [203398] = chests_string .. in_selsweyr, -- The Favored Daughter of Fadomai",
    [203397] = chests_string .. in_selsweyr, -- Khunzar-ri and the Lost Alfiq",
    [203396] = chests_string .. in_selsweyr, -- Azurah's Crossing",
    [203395] = chests_string .. in_selsweyr, -- Trail and Tide",
    [203394] = chests_string .. in_selsweyr, -- The Angry Alfiq: A Collection",
    [203393] = chests_string .. in_selsweyr, -- On Those Who Know Baan Dar",
    [203392] = endless_archive, -- Anequina and Pellitine: An Introduction",
    [203391] = chests_string .. " " .. in_hewsbane, -- The Red Curse, Volume 3",
    [203390] = chests_string .. " " .. in_hewsbane, -- The Red Curse, Volume 2",
    [203389] = chests_string .. " " .. in_hewsbane, -- The Red Curse, Volume 1",
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
    [203211] = endless_archive, -- Apocrypha Crescent",
    [203210] = endless_archive, -- Apocrypha Spike, Curved",
    [203209] = endless_archive, -- Apocrypha Spike, Tall",
    [203208] = endless_archive, -- Apocrypha Pipe, Small",
    [203207] = endless_archive, -- Apocrypha Pipe, Small Curved",
    [203206] = endless_archive, -- Apocrypha Pipe, Medium",
    [203204] = endless_archive, -- Apocrypha Pipe, Large Curved",
    [199117] = tribute, -- Chromatic Reservoir Tapestry, Large",
    [199116] = tribute, -- Chromatic Reservoir Tapestry",
    [199115] = tribute, -- Seeker Aspirant Tapestry, Large",
    [199114] = tribute, -- Seeker Aspirant Tapestry",

    [199933] = scrying .. in_necrom, -- Scrying Brazier, Tall",
    [199932] = scrying .. in_necrom, -- Scrying Brazier, Short",
    [199890] = scrying .. in_necrom, -- Archival Light Diffuser, Large",
    [199132] = scrying .. in_necrom, -- Apocrypha Fossil, Tree",
    [199131] = scrying .. in_necrom, -- Apocrypha Fossil, Wall Beast",
    [199130] = scrying .. in_necrom, -- Apocrypha Fossil, Slug",
    [199129] = scrying .. in_necrom, -- Apocrypha Fossil, Ribcage",
    [199128] = scrying .. in_necrom, -- Watchful Light",
    [199127] = scrying .. in_necrom, -- Petrified Watcher",
    [199126] = scrying .. in_necrom, -- Forged Black Book",
    [199119] = scrying .. in_necrom .. " (3 pieces)", -- Infinite Tome",
    [199118] = scrying .. in_necrom .. " (5 pieces)", -- Apocrypha Clothing Station",
    [198576] = scrying .. " in Deadlands", -- Shelf, Black Soul Gems",
    [198575] = scrying .. in_selsweyr, -- Khajiiti Well",
    [198573] = scrying .. on_summerset, -- High Elf Altar, Crystal",
    [198572] = scrying .. " in Clockwork City", -- Clockwork Wall Gears",
    [198571] = scrying .. in_goldcoast, -- Shrine to Dibella",
    [198570] = scrying .. " in Shadowfen", -- Painted Stone Frog",
    [198569] = scrying .. " in Deshaan", -- Dark Elf Altar, Ceremonial",
    [198568] = scrying .. " in Alik'r Desert", -- Stone Relief, Yokudan",
    [198567] = scrying .. " in Glenumbra", -- Breton Well, Storm Grey",
    [198566] = scrying .. " in Reaper's March", -- Khajiiti Arch, Rising",
    [198325] = scrying .. in_necrom .. " (3 pieces)", -- Vision of Mora",
    [197916] = scrying .. in_necrom, -- Archival Light Diffuser, Small",
  },
}

-- 27 Base Game Patch
FurC.MiscItemSources[ver.BASED] = {
  [src.CROWN] = {
    [197823] = getScamboxString("armiger"), -- Necrom Podium, Buoyant Armiger
    [197824] = getScamboxString("armiger"), -- Harrowstorm Mists
    [197822] = getScamboxString("armiger"), -- Redoran Sconce, Beetle
    [197821] = getScamboxString("armiger"), -- Spellscar Bridge
  },
}

-- 26 Necrom
FurC.MiscItemSources[ver.NECROM] = {
  [src.CROWN] = {
    [197624] = getCrownPrice(1200), -- Apocryphal Shifting Sculpture",

    [197622] = getScamboxString("feather") .. ", " .. getGemPrice(400), -- Constellation Projection Apparatus",
    [197621] = getScamboxString("feather") .. ", " .. getGemPrice(40), -- Household Shrine, Meridian",
    [197620] = getScamboxString("feather") .. ", " .. getGemPrice(100), -- Throne of the Lich",
    [197619] = getScamboxString("feather") .. ", " .. getGemPrice(100), -- Meridian Mote",
  },

  [src.DROP] = {
    [197921] = nymic, -- Peryite's Salvation",
    [197920] = nymic, -- The Doom of the Hushed",
    [197919] = nymic, -- The Legend of Fathoms Drift",
    [197918] = nymic, -- Deal with a Daedric Prince",
    [197917] = nymic, -- Ode to Vaermina",
    [197829] = scrying .. in_necrom .. " (10 pieces)", -- Music Box, Glyphic Secrets",
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
    [197712] = scrying .. in_necrom, -- Antique Map of Apocrypha",
    [197711] = scrying .. in_necrom, -- Antique Map of the Telvanni Peninsula",
    [197710] = scrying .. in_necrom, -- Mushroom Classification Book",
    [197709] = scrying .. in_necrom, -- Tribunal Window, Stained Glass",
    [197708] = scrying .. in_necrom, -- Cliffracer Skeleton Stand",
    [197707] = scrying .. in_necrom .. " (3 pieces)", -- Apocryphal Well",
    [197706] = scrying .. in_necrom .. " (3 pieces)", -- Trifold Mirror of Alternatives",
    [197705] = scrying .. in_necrom .. " (10 pieces)", -- Telvanni Alchemy Station",
    [197703] = scrying .. in_necrom, -- Apocrypha Fossil, Arch",
    [197702] = scrying .. in_necrom, -- Apocrypha Fossil, Worm",
    [197701] = scrying .. in_necrom, -- Apocrypha Fossil, Nautilus",
    [197700] = scrying .. in_necrom, -- Apocrypha Fossil, Bones Large",
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
    [194411] = getCrownPrice(240), -- Stonelore Tale Pillar, Rounded Stone,
    [194410] = getCrownPrice(240), -- Stonelore Tale Pillar, Slanted Stone,
    [194409] = getCrownPrice(140), -- Potted Tree, Systres Pine,
    [194408] = getCrownPrice(150), -- Systres Brewing Still, Copper,
    [194407] = getCrownPrice(40), -- Harbor Rope, Hanging,
    [194406] = getCrownPrice(110), -- Harbor Rope, Coiled Buoy,
    [194405] = getCrownPrice(40), -- Harbor Line, Coiled,
    [194404] = getCrownPrice(40), -- Harbor Line, Loose,
    [194403] = getCrownPrice(110), -- Harbor Netting, Buoy Cluster,
    [194402] = getCrownPrice(110), -- Harbor Netting, Hanging Wall,
    [194401] = getCrownPrice(150), -- Galen Dogwood, Medium Cluster,
    [194400] = getCrownPrice(170), -- Galen Dogwood, Large,
    [194399] = getCrownPrice(1000), -- Music Box, Unfathomable Knowledge,

    [193818] = getItempackString("astula"), -- Shad Astula Scholar, Right,
    [193817] = getItempackString("astula"), -- Shad Astula Scholar, Left,

    [193796] = getScamboxString("rage") .. ", " .. getGemPrice(100), -- Orb of the Spirit Queen,
    [193795] = getScamboxString("rage") .. ", " .. getGemPrice(40), -- Rite of the Harrowforged,
    [193794] = getScamboxString("rage") .. ", " .. getGemPrice(100), -- Target Hagraven, Robust,
    [193793] = getScamboxString("rage") .. ", " .. getGemPrice(40), -- Reach Chandelier, Hagraven,
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
    [192429] = getMultipleSources({ getCrownPrice(110), getItempackString("maormer") }), -- Maormer Sconce, Serpentine
    [192427] = getMultipleSources({ getCrownPrice(70), getItempackString("maormer") }), -- Maormer Lamp, Serpentine
    [192425] = getMultipleSources({ getCrownPrice(150), getItempackString("maormer") }), -- Maormer Teapot, Serpentine
    [192423] = getMultipleSources({ getCrownPrice(340), getItempackString("maormer") }), -- Maormer Runner, Amethyst Waves
    [192422] = getMultipleSources({ getCrownPrice(80), getItempackString("maormer") }), -- Maormer Half-Rug
    [192420] = getMultipleSources({ getCrownPrice(180), getItempackString("maormer") }), -- Maormer Rug, Serpentine
    [192418] = getMultipleSources({ getCrownPrice(10), getItempackString("maormer") }), -- Maormer Mug, Serpentine
    [192414] = getMultipleSources({ getCrownPrice(160), getItempackString("maormer") }), -- Maormer Armchair, Carved
    [192413] = getMultipleSources({ getCrownPrice(180), getItempackString("maormer") }), -- Maormer Table, Carved
    [192412] = getMultipleSources({ getCrownPrice(340), getItempackString("maormer") }), -- Maormer Curtain, Serpentine Cloth
    [192410] = getMultipleSources({ getCrownPrice(85), getItempackString("maormer") }), -- Maormer Chair, Carved
    [192409] = getMultipleSources({ getCrownPrice(3000), getItempackString("maormer") }), -- Maormer Cookfire
    [192408] = getMultipleSources({ getCrownPrice(70), getItempackString("maormer") }), -- Maormer Trunk, Carved
    [192407] = getMultipleSources({ getCrownPrice(720), getItempackString("maormer") }), -- Maormer Tent, Raider's
    [192406] = getItempackString("maormer"), -- Maormer Ship's Prow, Serpentine
    [192405] = getItempackString("maormer"), -- Maormer Tent, Raid Leader's

    [190945] = getCrownPrice(5000), -- Tree, Seasons of Y'ffre
    [190940] = getCrownPrice(1000), -- Music Box, Songbird's Paradise",

    [190951] = getScamboxString("stonelore") .. ", " .. ", " .. getGemPrice(100), -- Target Spriggan, Robust
    [190950] = getScamboxString("stonelore") .. ", " .. ", " .. getGemPrice(40), -- Rose Petal Cascade
    [190947] = getScamboxString("stonelore") .. ", " .. ", " .. getGemPrice(40), -- Druidic Arch, Floral
    [190946] = getScamboxString("stonelore") .. ", " .. ", " .. getGemPrice(40), -- Earthen Root Essence
  },

  [src.DROP] = {
    [192432] = scrying .. " in Galen (3 Pieces)", -- Shipbuilder's Woodworking Station",
    [192431] = scrying .. " in Galen ", -- Antique Map of Galen",
    [192430] = scrying .. " in Galen ", -- Vulk'esh Egg",
    [192404] = tribute, -- Forest Wraith Tribute Tapestry, Large",
    [192403] = tribute, -- Forest Wraith Tribute Tapestry",
    [192402] = tribute, -- The Chimera Tribute Tapestry, Large",
    [192401] = tribute, -- The Chimera Tribute Tapestry",
    [190938] = scrying .. " in Galen (5 Pieces)", -- Music Box, Blessings of Stone",
    [187922] = scrying .. " in Fargrave ", -- Antique Map of Fargrave",
  },
}

-- 23 Lost Depths
FurC.MiscItemSources[ver.DEPTHS] = {
  [src.CROWN] = {
    [189465] = getCrownPrice(1200), -- Music Box, Gonfalon Galliard,
    [189464] = getCrownPrice(1000), -- Music Box, Deeproot Dirge,
    [189463] = getCrownPrice(3500), -- Statue, Bendu Olo,

    [188344] = getScamboxString("wraith") .. ", " .. ", " .. getGemPrice(40), -- Y'ffre's Falling Leaves, Autumn,
    [188343] = getScamboxString("wraith") .. ", " .. ", " .. getGemPrice(100), -- Moonlight Path Bridge,
    [188342] = getScamboxString("wraith") .. ", " .. ", " .. getGemPrice(40), -- Bat Swarm, Domesticated,
    [188341] = getScamboxString("wraith") .. ", " .. ", " .. getGemPrice(100), -- Red Diamond Stained Glass,
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
    [187865] = getCrownPrice(55), -- Flowers, Butterweed Cluster
    [187861] = getCrownPrice(110), -- High Isle Hourglass, Compass Rose
    [187860] = getCrownPrice(65), -- High Isle Vase, Gilded
    [187667] = getCrownPrice(1200), -- Music Box, High Isle Duel
    [187666] = getCrownPrice(1000), -- Music Box, Steadfast Armistice
    [187665] = getCrownPrice(3500), -- Statue, Kynareth's Blessings
    [187664] = getCrownPrice(6000), -- Target Deadlands Harvester, Trial
    [147926] = getCrownPrice(6000), -- Target Iron Atronach, Trial

    [187663] = getScamboxString("dark") .. ", " .. getGemPrice(40), -- Blue Fang Shark, Mounted
    [187662] = getScamboxString("dark") .. ", " .. getGemPrice(100), -- House Dufort Chandelier
    [187661] = getScamboxString("dark") .. ", " .. getGemPrice(40), -- Mage's Flame
    [187660] = getScamboxString("dark") .. ", " .. getGemPrice(100), -- Mages Guild Stained Glass
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
    [187802] = scrying .. " in High Isle ", -- Druidic Provisioning Station
    [187801] = scrying .. " in High Isle ", -- Sea Elf Galleon Helm
    [187800] = scrying .. " in High Isle ", -- Draoife Storystone
    [187799] = scrying .. " in High Isle ", -- Antique Map of High Isle
  },
}

-- 21 Ascending Tide
FurC.MiscItemSources[ver.TIDES] = {
  [src.CROWN] = {
    [184250] = getCrownPrice(240), -- Nedic Banner, Ancient,
    [184249] = getMultipleSources({ getCrownPrice(20), getItempackString("aquatic") }), -- Elkhorn Coral, Branching,
    [184248] = getMultipleSources({ getCrownPrice(20), getItempackString("aquatic") }), -- Stones, Coral Cluster,
    [184247] = getMultipleSources({ getCrownPrice(45), getItempackString("aquatic") }), -- Brittle-Vein Coral, Cluster,
    [184246] = getCrownPrice(130), -- Nedic Bench, Carved,
    [184245] = getCrownPrice(610), -- Nedic Chandelier, Swords,
    [184244] = getCrownPrice(110), -- Nedic Sconce, Torch,
    [184243] = getCrownPrice(640), -- Nedic Brazier, Cold-Flame Pillar,
    [184242] = getCrownPrice(370), -- Nedic Brazier, Cold-Flame,
    [184205] = getMultipleSources({ getCrownPrice(120), getItempackString("aquatic") }), -- Sand Drift, Oceanic,
    [184175] = getCrownPrice(3500), -- Statue, Ancestor-King Auri-El,
    [184112] = getMultipleSources({ getCrownPrice(170), getItempackString("aquatic") }), -- Lilac Coral, Strong,
    [184111] = getMultipleSources({ getCrownPrice(170), getItempackString("aquatic") }), -- Lilac Anemone, Sprout,
    [184110] = getMultipleSources({ getCrownPrice(170), getItempackString("aquatic") }), -- Verdant Anemone, Strong,
    [184109] = getMultipleSources({ getCrownPrice(90), getItempackString("aquatic") }), -- Kelp Grouping, Robust,
    [184108] = getMultipleSources({ getCrownPrice(90), getItempackString("aquatic") }), -- Kelp Grouping, Thin,
    [184107] = getMultipleSources({ getCrownPrice(20), getItempackString("aquatic") }), -- Kelp Stalk, Tall,
    [184106] = getMultipleSources({ getCrownPrice(20), getItempackString("aquatic") }), -- Kelp Stalk, Plain,
    [184105] = getMultipleSources({ getCrownPrice(45), getItempackString("aquatic") }), -- Green Algae Coral Formation, Tree Capped,
    [184104] = getMultipleSources({ getCrownPrice(45), getItempackString("aquatic") }), -- Red Algae Coral Formation, Waving Hands,
    [184103] = getMultipleSources({ getCrownPrice(45), getItempackString("aquatic") }), -- Red Algae Coral Formation, Tree Antler,
    [183894] = getItempackString("aquatic"), -- Nedic Chest, Bubbling,
    [183893] = getMultipleSources({ getCrownPrice(1500), getItempackString("aquatic") }), -- Bubbles of Aeration,
    [183892] = getMultipleSources({ getCrownPrice(430), getItempackString("aquatic") }), -- Minnow School,
    [183891] = getItempackString("aquatic"), -- Jellyfish Bloom, Heliotrope,
    [183856] = getItempackString("aquatic"), -- Target Mudcrab, Robust Coral,
    [183201] = getCrownPrice(1000), -- Music Box: Bleak Beacon Shanty,
    [183200] = getCrownPrice(1100), -- Music Box: Wonders of the Shoals,
    [183198] = getMultipleSources({ GetString(FURC_AV_FARGRAVE_FF), getCrownPrice(10) }), -- Bushes, Withered Cluster,
    [178477] = getCrownPrice(170), -- Nedic Bookcase, Filled,
    [120853] = "This is craftable, or " .. getCrownPrice(430), -- Stockade,

    [184127] = getScamboxString("sunken") .. ", " .. getGemPrice(40), -- Tranquility Pond, Botanical,
    [184126] = getScamboxString("sunken") .. ", " .. getGemPrice(100), -- Waterfall Fountain, Round,
    [184072] = getScamboxString("sunken") .. ", " .. getGemPrice(100), -- Aquarium, Large Abecean Coral,
    [184071] = getScamboxString("sunken") .. ", " .. getGemPrice(40), -- Aquarium, Abecean Coral,
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

	 Can I add a separate crown source for housing editor vs normal crown store? Seems like it should be fairly easy. Model after SI_FURC_CROWNSTORESOURCE and getCrownPrice

	 Add seals of endeavor prices with the gem prices for crate items (can I add a constant for pricing? ie: getGemPrice(40) would output "40 Gems or 2000 Endeavors"

	 Learn how to add housing sources (I see it there, just need to play with it)

	 Sort things into their proper versions! I've been adding most things to the top of the most recent version, but sorting needs to happen!
	]]

  [src.DROP] = {
    [178694] = blackwood_event, -- Target Ogrim,
    [166960] = "From combining Stone Husk Fragments from the Labyrinthian in Western Skyrim", -- Target Stone Husk,

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

  [src.CROWN] = {
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
    [118148] = getMultipleSources({ getCrownPrice(80), mischouse }), --Firelogs, Ashen,
    [118146] = getMultipleSources({ getCrownPrice(80), mischouse }), --Firelogs, Flaming,
    [118147] = getMultipleSources({ getCrownPrice(80), mischouse }), --Firelogs, Charred,
    [167294] = getMultipleSources({ getCrownPrice(20), mischouse }), -- Boulder, Jagged Stone,
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
    [139064] = getMultipleSources({ getCrownPrice(20), mischouse }), -- Flowers, Hummingbird Mint
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
    [171817] = getMultipleSources({ getCrownPrice(730), mischouse }), -- Ayleid Chandelier, Caged,
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
    [156775] = getItempackString("heart"), -- Bed, Petal-Strewn Double
    [156764] = getMultipleSources({ getCrownPrice(85), getItempackString("heart") }), -- Bouquet, Small Dibella's
    [156776] = getMultipleSources({ getCrownPrice(85), getItempackString("heart") }), -- Bouquet, Large Dibella's
    [156777] = getMultipleSources({ getCrownPrice(85), getItempackString("heart") }), -- Bouquet, Medium Dibella's
    [156765] = getMultipleSources({ getCrownPrice(290), getItempackString("heart") }), -- Chair, Love-Blessed
    [156766] = getMultipleSources({ getCrownPrice(180), getItempackString("heart") }), -- Petals, Blanket
    [156767] = getItempackString("heart"), -- Sweetroll Platter
    [156768] = getMultipleSources({ getCrownPrice(100), getItempackString("heart") }), -- Love's Flame Candlestick
    [156769] = getMultipleSources({ getCrownPrice(500), getItempackString("heart") }), -- Kitten Moppet, Heart's Promise
    [156770] = getMultipleSources({ getCrownPrice(500), getItempackString("heart") }), -- Kitten Moppet, Love-Blessed
    [156771] = getMultipleSources({ getCrownPrice(410), getItempackString("heart") }), -- Table, Love-Blessed
    [156772] = getMultipleSources({ getCrownPrice(340), getItempackString("heart") }), -- Petals, Large Blanket
    [156773] = getMultipleSources({ getCrownPrice(180), getItempackString("heart") }), -- Rug, Love-Blessed
    [156774] = getMultipleSources({ getCrownPrice(180), getItempackString("heart") }), -- Tapestry, Love-Blessed
    [156778] = getMultipleSources({ getCrownPrice(85), getItempackString("heart") }), -- Flower, Dibella's Promise
    [134971] = getMultipleSources({ getCrownPrice(100), getItempackString("heart") }), -- Candles, Votive Group

    [134879] = getItempackString("hubtreasure"), -- Hubalajad's Reflection
    [134880] = getItempackString("hubtreasure"), -- Ra Gada Reliquary, Miniature Palace,
    [134881] = getItempackString("hubtreasure"), -- In Defense of Prince Hubalajad,
    [134882] = getMultipleSources({ getCrownPrice(90), getItempackString("hubtreasure") }), -- Gold Drakes, Pristine,
    [134883] = getMultipleSources({ getCrownPrice(360), getItempackString("hubtreasure") }), -- Ra Gada Funerary Statue, Stone Cat,
    [134884] = getMultipleSources({ getCrownPrice(360), getItempackString("hubtreasure") }), -- Ra Gada Funerary Statue, Gilded Cat,
    [134885] = getMultipleSources({ getCrownPrice(360), getItempackString("hubtreasure") }), -- Ra Gada Funerary Statue, Gilded Ibis,
    [134886] = getMultipleSources({ getCrownPrice(360), getItempackString("hubtreasure") }), -- Ra Gada Funerary Statue, Gilded Servant,
    [134887] = getMultipleSources({ getCrownPrice(2000), getItempackString("hubtreasure") }), -- Ra Gada Guardian Statue, Lion Ibis,
    [134888] = getMultipleSources({ getCrownPrice(2000), getItempackString("hubtreasure") }), -- Ra Gada Guardian Statue, Winged Bull,
    [134889] = getMultipleSources({ getCrownPrice(2000), getItempackString("hubtreasure") }), -- Ra Gada Guardian Statue, Riding Camel,
    [117901] = getMultipleSources({ getCrownPrice(140), getItempackString("hubtreasure") }), --Redguard Amphora, Gilded,
    [117894] = getMultipleSources({ getCrownPrice(240), getItempackString("hubtreasure") }), --Redguard Divider, Gilded,
    [117904] = getMultipleSources({ getCrownPrice(190), getItempackString("hubtreasure") }), --Redguard Trunk, Garish,
    [134823] = getItempackString("hubtreasure"), -- Target Mournful Aegis,

    [117906] = getMultipleSources({ elsweyr_event, getItempackString("cragknicks") }), -- Redguard Urn, Gilded
    [121053] = getMultipleSources({
      getCrownPrice(170),
      getItempackString("cragknicks"),
      getItempackString("hubtreasure"),
    }), -- Jar, Gilded Canopic
    [121046] = getItempackString("cragknicks"), -- Cheeses of Tamriel,
    [121049] = getItempackString("cragknicks"), -- Parcels, Wrapped,
    [120417] = getItempackString("cragknicks"), -- Redguard Barrel, Corded
    [118490] = getItempackString("cragknicks"), --Scroll, Rolled,
    [134890] = getItempackString("dibella"), -- Dibella, Lady of Love,
    [134848] = getMultipleSources({ getCrownPrice(1500), getItempackString("dibella"), getItempackString("oasis") }), -- Blue Butterfly Flock
    [134961] = getItempackString("dibella"), -- Dibella's Mysteries and Revelations,
    [134899] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Flower Spray, Crimson Daisies,
    [134901] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Flower Spray, Starlight Daisies,
    [134896] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Flower, Lover's Lily
    [134898] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Flowers, Midnight Sage,
    [134900] = getMultipleSources({ getCrownPrice(20), getItempackString("dibella") }), -- Flowers, Red Poppy,
    [134902] = getMultipleSources({ getCrownPrice(20), getItempackString("dibella") }), -- Flowers, Violet Bellflower,
    [134903] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Flowers, Midnight Glory,
    [94163] = getMultipleSources({ getCrownPrice(290), getItempackString("dibella") }), --Imperial Bench, Scrollwork
    [134849] = getMultipleSources({ getCrownPrice(1500), getItempackString("dibella"), getItempackString("oasis") }), -- Monarch Butterfly Flock
    [134891] = getMultipleSources({ getCrownPrice(2500), getItempackString("dibella") }), -- Pergola, Festive Flowers
    [134895] = getMultipleSources({ getCrownPrice(1800), getItempackString("dibella") }), -- Redguard Fountain, Mosaic
    [134904] = getMultipleSources({ getCrownPrice(260), getItempackString("dibella") }), -- Seal of Dibella
    [134905] = getMultipleSources({ getCrownPrice(260), getItempackString("dibella") }), -- Ritual Stone, Dibella
    [134906] = getMultipleSources({ getCrownPrice(240), getItempackString("dibella") }), -- Ritual Brazier, Gilded
    [134892] = getMultipleSources({ getCrownPrice(85), getItempackString("dibella") }), -- Tree, Pale Gold
    [134893] = getMultipleSources({ getCrownPrice(85), getItempackString("dibella") }), -- Tree, Argent Blue
    [134894] = getMultipleSources({ getCrownPrice(20), getItempackString("dibella") }), -- Wildflowers, Yellow and Orange
    [134897] = getMultipleSources({ getCrownPrice(45), getItempackString("dibella") }), -- Vine Curtain, Festive Flowers

    [181547] = getMultipleSources({ getCrownPrice(1000), getItempackString("mermaid") }), -- Leyawiin Fountain, Corner,
    [181486] = getMultipleSources({ getCrownPrice(2700), getItempackString("mermaid") }), -- Leyawiin Fountain, Round,
    [181599] = getMultipleSources({ getCrownPrice(1100), getItempackString("mermaid") }), -- Leyawiin Fountain, Tall,
    [181485] = getItempackString("mermaid"), -- Statue, Mermaid of Anvil,
    [181435] = getMultipleSources({ getCrownPrice(1500), getItempackString("mermaid") }), -- Steam of Repose,

    [175695] = getMultipleSources({ getCrownPrice(510), getItempackString("zeni") }), -- Leyawiin Shrine of the Eight,
    [175696] = getMultipleSources({ getCrownPrice(410), getItempackString("zeni") }), -- Leyawiin Tapestry, Divines Horizontal,
    [175697] = getMultipleSources({ getCrownPrice(410), getItempackString("zeni") }), -- Leyawiin Tapestry, Divines Vertical,
    [175698] = getItempackString("zeni"), -- Zenithar, God of Work and Commerce,
    [175699] = getMultipleSources({ getItempackString("zeni"), getItempackString("windows") }), -- Stained Glass of Zenithar,

    [181483] = getItempackString("windows"), -- Stained Glass of Akatosh,
    [181484] = getItempackString("windows"), -- Stained Glass of Julianos,
    [181482] = getItempackString("windows"), -- Stained Glass of Arkay,
    [181481] = getItempackString("windows"), -- Stained Glass of Dibella,
    [181480] = getItempackString("windows"), -- Stained Glass of Stendarr,
    [181479] = getItempackString("windows"), -- Stained Glass of Mara,
    [181478] = getItempackString("windows"), -- Stained Glass of Kynareth,

    [182292] = getMultipleSources({ getCrownPrice(260), getItempackString("ambitions") }), -- Deadlands Base, Tower,
    [182291] = getMultipleSources({ getCrownPrice(1500), getItempackString("ambitions") }), -- Deadlands Window, Fireglass,
    [182290] = getMultipleSources({ getCrownPrice(140), getItempackString("ambitions") }), -- Deadlands Grate, Large,
    [182289] = getMultipleSources({ getCrownPrice(140), getItempackString("ambitions") }), -- Deadlands Wall, Etched,
    [182295] = getMultipleSources({ getCrownPrice(510), getItempackString("ambitions") }), -- Deadlands Firepit, Large,
    [182294] = getMultipleSources({ getCrownPrice(770), getItempackString("ambitions") }), -- Deadlands Platform, Tower,
    [182293] = getMultipleSources({ getCrownPrice(260), getItempackString("ambitions") }), -- Deadlands Stairway, Tower,
    [182912] = getMultipleSources({ getCrownPrice(270), getItempackString("ambitions") }), -- Deadlands Pillar, Tall,

    [147585] = getMultipleSources({ getCrownPrice(40), getItempackString("forge") }), -- Dwarven Gear, Large Spokes,
    [147586] = getMultipleSources({ getCrownPrice(50), getItempackString("forge") }), -- Dwarven Hub, Sentry Wheel,
    [147587] = getMultipleSources({ getCrownPrice(40), getItempackString("forge") }), -- Dwarven Gear, Large Open,
    [147588] = getMultipleSources({ getCrownPrice(220), getItempackString("forge") }), -- Dwarven Conduit, Rounded,
    [147589] = getMultipleSources({ getCrownPrice(150), getItempackString("forge") }), -- Dwarven Brazier, Open,
    [147590] = getItempackString("forge"), -- Dwarven Bust, Forge-Lord,
    [147664] = getMultipleSources({ getCrownPrice(270), getItempackString("forge") }), -- Dwarven Dais, Conduit,
    [147574] = getItempackString("forge"), -- Dwarven Frieze, Wrathstone,
    [147575] = getItempackString("forge"), -- Dwarven Frieze, Power in Twain,
    [147576] = getItempackString("forge"), -- Dwarven Frieze, Colossal Power,
    [147577] = getMultipleSources({ getCrownPrice(920), getItempackString("forge") }), -- Dwarven Platform, Fan,
    [147578] = getMultipleSources({ getCrownPrice(1400), getItempackString("forge") }), -- Dwarven Throne, Conduit,
    [147579] = getMultipleSources({ getCrownPrice(240), getItempackString("forge") }), -- Dwarven Gearwork, Perpetual,
    [147580] = getMultipleSources({ getCrownPrice(310), getItempackString("forge") }), -- Dwarven Lamps, Heavy,
    [147581] = getMultipleSources({ getCrownPrice(350), getItempackString("forge") }), -- Dwarven Table, Heavy Workbench,
    [147582] = getMultipleSources({ getCrownPrice(50), getItempackString("forge") }), -- Dwarven Part, Sentry Head,
    [147583] = getMultipleSources({ getCrownPrice(220), getItempackString("forge") }), -- Dwarven Valve, Sealed,
    [147584] = getMultipleSources({ getCrownPrice(160), getItempackString("forge") }), -- Dwarven Rack, Spider Legs,

    [130226] = getMultipleSources({ getCrownPrice(85), getItempackString("coven") }), -- Carcass, Hanging Deer
    [131424] = getItempackString("coven"), -- Fogs of the Hag Fen,
    [130220] = getMultipleSources({ getCrownPrice(3300), getItempackString("coven") }), -- Hagraven Altar,
    [130222] = getMultipleSources({ getCrownPrice(260), getItempackString("coven") }), -- Hagraven Totem, Skull
    [131423] = getMultipleSources({ getCrownPrice(750), getItempackString("coven") }), -- Mists of the Hag Fen
    [130221] = getMultipleSources({ getCrownPrice(430), getItempackString("coven") }), -- Reachmen Cage, Sturdy
    [130216] = getMultipleSources({ getCrownPrice(510), getItempackString("coven") }), -- Witches' Basin, Scrying
    [130219] = getMultipleSources({ getCrownPrice(240), getItempackString("coven") }), -- Witches' Brazier, Beast Skull
    [130223] = getMultipleSources({ getCrownPrice(340), getItempackString("coven") }), -- Reachmen Rug, Mottled Skin
    [130224] = getMultipleSources({ getCrownPrice(180), getItempackString("coven") }), -- Reachmen Rug, Smooth Skin
    [130225] = getMultipleSources({ getCrownPrice(340), getItempackString("coven") }), -- Skulls, Heap
    [130227] = getMultipleSources({ getCrownPrice(850), getItempackString("coven") }), -- Witches' Tent, Lean-To
    [130229] = getMultipleSources({ getCrownPrice(290), getItempackString("coven") }), -- Tree, Wretched Cypress
    [130230] = getMultipleSources({ getCrownPrice(90), getItempackString("coven") }), -- Stump, Wretched Cypress
    [130247] = getMultipleSources({ getCrownPrice(290), getItempackString("coven") }), -- Tree, Fetid Cypress
    [130228] = getItempackString("coven"), -- The Witches of Hag Fen,
    [130215] = getItempackString("coven"), -- Witches' Cauldron, Provisioning,
    [130334] = getMultipleSources({ getCrownPrice(260), getItempackString("coven") }), -- Witches Totem, Antler Charms,

    [134870] = getItempackString("tyrants"), -- Ancient Nord Chest, Dragon Crest,
    [134871] = getItempackString("tyrants"), -- Ancient Nord Urn, Dragon Crest,
    [134873] = getItempackString("tyrants"), -- Ancient Nord Bookshelf, Wide,
    [134874] = getItempackString("tyrants"), -- Ancient Nord Bookshelf, Narrow,
    [134875] = getItempackString("tyrants"), -- Ancient Nord Funerary Jar, Linked Rings,
    [134876] = getItempackString("tyrants"), -- Ancient Nord Funerary Jar, Crimson Sash,
    [134877] = getItempackString("tyrants"), -- Ancient Nord Funerary Jar, Dragon Figure,
    [134878] = getItempackString("tyrants"), -- Ancient Nord Funerary Jar, Dragon Crest,
    [134872] = getItempackString("tyrants"), -- Ancient Nord Brazier, Dragon Crest
    [134863] = getItempackString("tyrants"), -- Ancient Nord Sconce, Dragon Crest
    [134862] = getItempackString("tyrants"), -- Ancient Nord Runestone, Memorial,
    [134856] = getItempackString("tyrants"), -- Dragon Skeleton, Mid-Flight,
    [134857] = getItempackString("tyrants"), -- Dragon Priest Frieze: Triumph,
    [134858] = getItempackString("tyrants"), -- Dragon Priest Frieze: Exodus,
    [134859] = getItempackString("tyrants"), -- Dragon Priest Frieze: Restoration,
    [134860] = getItempackString("tyrants"), -- Dragon Priest Frieze: Ascension,
    [134861] = getItempackString("tyrants"), -- The History of Zaan The Scalecaller,
    [134864] = getItempackString("tyrants"), -- Dragon Cranium, Ancient,
    [134865] = getItempackString("tyrants"), -- Unidentified Bones, Gargantuan,
    [134866] = getItempackString("tyrants"), -- Lamia Cranium, Ancient,
    [134867] = getItempackString("tyrants"), -- Argonian Skull, Complete,
    [134868] = getItempackString("tyrants"), -- Khajiit Skull, Complete,
    [134869] = getItempackString("tyrants"), -- Orc Skull, Complete,

    [151901] = getMultipleSources({ getCrownPrice(20), getItempackString("khajiit") }), -- Elsweyr Bowl, Moon-Sugar,
    [153660] = getMultipleSources({ getCrownPrice(560), getItempackString("khajiit") }), -- Elsweyr Cart, Moons-Blessed
    [153669] = getMultipleSources({ getCrownPrice(300), getItempackString("khajiit") }), -- Elsweyr Well, Simple Arched
    [153658] = getMultipleSources({ getCrownPrice(70), getItempackString("khajiit") }), -- Moon-Sugar, Row
    [153659] = getMultipleSources({ getCrownPrice(30), getItempackString("khajiit") }), -- Moon-Sugar, Cluster
    [153667] = getMultipleSources({ getCrownPrice(170), getItempackString("khajiit") }), -- Moon-Sugar, Harvested Large
    [153668] = getMultipleSources({ getCrownPrice(90), getItempackString("khajiit") }), -- Moon-Sugar, Harvested Small
    [153632] = getMultipleSources({ getCrownPrice(1500), getItempackString("khajiit") }), -- Sapphire Candlefly Gathering
    [153661] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Straw Pile
    [153662] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Tool, Plow
    [153663] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Tool, Sickle
    [153664] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Tool, Pitchfork
    [153665] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Tool, Hoe
    [153666] = getMultipleSources({ getCrownPrice(40), getItempackString("khajiit") }), -- Tool, Two-Person Crosscut Saw

    [134270] = getMultipleSources({ getCrownPrice(85), getItempackString("malacath") }), -- Cave Deposit, Large Double-Sided
    [134271] = getMultipleSources({ getCrownPrice(85), getItempackString("malacath") }), -- Cave Deposit, Tall Stalagmite
    [134272] = getMultipleSources({ getCrownPrice(10), getItempackString("malacath") }), -- Cave Deposit, Stalagmite Cluster,
    [134258] = getItempackString("malacath"), -- Prayer to the Furious One,
    [134259] = getItempackString("malacath"), -- Malacath, God of Oaths and Curses,
    [134260] = getItempackString("malacath"), -- Orcish Bas-Relief, Axe,
    [134261] = getItempackString("malacath"), -- Orcish Bas-Relief, Sword,
    [134262] = getItempackString("malacath"), -- Orcish Bas-Relief, Spear,
    [134268] = getMultipleSources({ getCrownPrice(570), getItempackString("malacath") }), -- Orcish Brazier, Column
    [134269] = getMultipleSources({ getCrownPrice(220), getItempackString("malacath") }), -- Orcish Dais, Raised
    [116518] = getMultipleSources({ getCrownPrice(270), getItempackString("malacath") }), -- Orcish Drop Hammer, Repeating,
    [152147] = getItempackString("malacath"), -- Orcish Statue, Strength,
    [134267] = getMultipleSources({ getCrownPrice(380), getItempackString("malacath") }), -- Orcish Table, Grand Furs
    [134263] = getMultipleSources({ getCrownPrice(410), getItempackString("malacath") }), -- Orcish Throne, Ancient

    [126114] = getItempackString("azura"), -- Statue of Azura, Queen of Dawn and Dusk,
    [126115] = getItempackString("azura"), -- Statue of Azura's Moon,
    [126116] = getItempackString("azura"), -- Statue of Azura's Sun,
    [126117] = getItempackString("azura"), -- Tapestry of Azura,
    [126118] = getItempackString("azura"), -- Banner of Azura,
    [125489] = getItempackString("azura"), -- Daedric Brazier, Flaming,
    [126128] = getItempackString("azura"), -- The Five Points of the Star,

    [134251] = getItempackString("coldharbour"), -- Coldharbour Bookshelf, Filled,
    [134252] = getItempackString("coldharbour"), -- Coldharbour Bookshelf, Black Laboratory,
    [134253] = getItempackString("coldharbour"), -- Coldharbour Bookshelf, Filled Wide,
    [134256] = getItempackString("coldharbour"), -- Coldharbour Bookshelf, Filled Pillar,
    [134254] = getItempackString("coldharbour"), -- Seal of Molag Bal,
    [134255] = getItempackString("coldharbour"), -- Transliminal Rupture,
    [134257] = getItempackString("coldharbour"), -- Daedra Dossier: Cold-Flame Atronach
    [134264] = getMultipleSources({ getCrownPrice(190), getItempackString("coldharbour") }), -- Daedric Brazier, Cold-Flame
    [134273] = getMultipleSources({ getCrownPrice(200), getItempackString("coldharbour") }), -- Daedric Plinth, Sacrificial
    [134274] = getMultipleSources({ getCrownPrice(200), getItempackString("coldharbour") }), -- Coldharbour Crate, Black Soul Gem
    [134275] = getMultipleSources({ getCrownPrice(200), getItempackString("coldharbour") }), -- Coldharbour Bin, Black Soul Gem

    [182285] = getMultipleSources({ getCrownPrice(160), getItempackString("fargrave") }), -- Book Wall, Levitating,
    [182286] = getMultipleSources({ getCrownPrice(860), getItempackString("fargrave") }), -- Fargrave Terrarium, Snakevine,
    [182288] = getMultipleSources({ getCrownPrice(820), getItempackString("fargrave") }), -- Fargrave Terrarium, Massive Gas Blossom,
    [182284] = getMultipleSources({ getCrownPrice(20), getItempackString("fargrave") }), -- Fargrave Bread Loaves, Round,
    [182283] = getMultipleSources({ getCrownPrice(870), getItempackString("fargrave") }), -- Fargrave Terrarium, Lantern Flower,
    [182282] = getMultipleSources({ getCrownPrice(560), getItempackString("fargrave") }), -- Fargrave Water Globules, Levitating,
    [182258] = getMultipleSources({ getCrownPrice(540), getItempackString("fargrave") }), -- Fargrave Terrarium, Claws,
    [182230] = getMultipleSources({ getCrownPrice(140), getItempackString("fargrave") }), -- Mushrooms, Glowing Shelf,

    [182280] = getScamboxString("celestial"), -- Fargrave Relic Case,
    [182207] = getScamboxString("celestial"), -- Celestial Vortex,
    [181643] = getScamboxString("celestial"), -- Warrior's Flame,
    [181487] = getScamboxString("harlequin"), -- Grim Harlequin Chandelier,
    [181438] = getScamboxString("harlequin"), -- Mad God's Monarch Flock,
    [178800] = getScamboxString("harlequin"), -- Amethyst Candlefly Gathering,
    [171947] = getScamboxString("irony"), -- Deadlands Chandelier, Bladed,
    [171946] = getScamboxString("irony"), -- Deadlands Cage, Bladed,
    [171945] = getScamboxString("irony"), -- Deadlands Sconce, Horned,
    [171546] = getScamboxString("ayleid"), -- Ayleid Relief, Blessed Life-Tree,
    [171545] = getScamboxString("ayleid"), -- Ayleid Gate, Large,
    [171544] = getScamboxString("ayleid"), -- Comet, Aetherial,
    [156644] = getScamboxString("frosty") .. ", " .. getGemPrice(40), -- Books, Towering Pile
  },
}

-- 19 Blackwood
FurC.MiscItemSources[ver.BLACKW] = {}

-- 18 Flames of Ambition
FurC.MiscItemSources[ver.FLAMES] = {
  [src.CROWN] = {
    [171932] = getCrownPrice(160), -- Daedric Sconce, Torch,
    [171933] = getCrownPrice(80), -- Daedric Candles, Tall Stand,
    [171934] = getCrownPrice(360), -- Daedric Brazier, Plinth,
    [118482] = getCrownPrice(25), -- Book Stack, Tall
  },

  [src.DROP] = {
    [171428] = scrying .. " (gold lead, Harrowstorm Reliquary)", -- Vampiric Stained Glass
  },
}

-- 17 Markarth
FurC.MiscItemSources[ver.MARKAT] = {
  [src.DROP] = {
    [171428] = scrying .. " in the Reach (Harrowstorms)", -- Vampiric Stained Glass
  },

  [src.CROWN] = {
    [167935] = getScamboxString("potentate"), -- Dwarven Work Lamp, Powered Floor,
    [167934] = getScamboxString("potentate"), -- Dwarven Orrery, Scholastic,
    [167933] = getScamboxString("potentate"), -- Dwarven Beam Emitter, Medium,

    [171397] = getItempackString("alchemist"), -- Stone Garden Tank, Vacant,
    [171398] = getItempackString("alchemist"), -- Stone Garden Vat, Alchemized Bristleback,
    [171399] = getItempackString("alchemist"), -- Stone Garden Vat, Alchemized Chaurus,
    [171400] = getItempackString("alchemist"), -- Stone Garden Vat, Alchemized Durzog,
    [171401] = getItempackString("alchemist"), -- Stone Garden Vat, Vacant,
    [171402] = getItempackString("alchemist"), -- Stone Garden Circulator, Rootbound,
    [171403] = getItempackString("alchemist"), -- Stone Garden Casket, Alchemized Bloodknight,
    [169117] = getItempackString("alchemist"), -- Target Bloodknight,

    [167299] = getCrownPrice(920), -- Dwarven Chandelier, Polished Braced,
    [167301] = getCrownPrice(560), -- Dwarven Lamppost, Polished Powered,
    [167300] = getCrownPrice(160), -- Dwarven Lantern, Polished Wall,
    [167298] = getCrownPrice(310), -- Dwarven Sconce, Polished Barred,
  },
}

-- 16 Stonethorn
FurC.MiscItemSources[ver.STONET] = {
  [src.CROWN] = {
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

    [119685] = getScamboxString("wildhunt"), -- Tapestry of Hircine
    [119684] = getScamboxString("wildhunt"), -- Statue of Hircine
  },

  [src.DROP] = {
    [171429] = scrying .. "in the Reach", -- Red Eagle Cave Painting:1
  },
}

-- 15 Greymoor
FurC.MiscItemSources[ver.SKYRIM] = {
  [src.JUSTICE] = {
    [165828] = GetString(SI_FURC_CANBESTOLEN) .. in_skyrim, -- Painting: Life in Repose Painting, Wood
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
    [165853] = scrying .. in_selsweyr, -- Moons-Blessed Ceremonial Pool
    [165868] = scrying .. " in Reaper's March", -- Moonlight Mirror
    [165872] = scrying .. in_nelsweyr, -- Stained Glass of Lunar Phases
    [166472] = scrying .. " " .. in_hewsbane, -- Morwha's Blessing
    [165862] = scrying .. in_nelsweyr, -- Moth Priest's Cleansing Bowl
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
    [161215] = scrying .. " " .. in_hewsbane, -- Yokudan Skystone Scabbard
    [161214] = scrying .. " in Craglorn", -- Spellscar Shard
    [166014] = scrying .. in_selsweyr, -- Shrine of Boethra
    [163710] = scrying .. " in Alik'r Desert", -- Antique Map of Alik'r Desert
    [165996] = scrying .. " in Gold Coast", -- Antique Map of Gold Coast
    [163727] = scrying .. in_nelsweyr, -- Antique Map of Northern Elsweyr
    [163728] = scrying .. in_selsweyr, -- Antique Map of Southern Elsweyr
    [163717] = scrying .. " in Auridon", -- Antique Map of Auridon
    [163711] = scrying .. " in Bangkorai", -- Antique Map of Bangkorai
    [163713] = scrying .. " in Deshaan", -- Antique Map of Deshaan
    [163707] = scrying .. " in Glenumbra", -- Antique Map of Glenumbra
    [163718] = scrying .. " in Grahtwood", -- Antique Map of Grahtwood
    [163719] = scrying .. " in Greenshade", -- Antique Map of Greenshade
    [165997] = scrying .. " " .. in_hewsbane, -- Antique Map of Hew's Bane
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

  [src.CROWN] = {
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

    [167332] = getScamboxString("sovngarde") .. ", " .. getGemPrice(40), -- The Mage's Staff Painting, Gold
    [167231] = getScamboxString("sovngarde") .. ", " .. getGemPrice(100), -- Celestial Nimbus
    [167230] = getScamboxString("sovngarde") .. ", " .. getGemPrice(100), -- Alkosh's Hourglass, Replica
    [166030] = getScamboxString("nightfall"), -- Greymoor Tapestry, Harrowstorm
    [166029] = getScamboxString("nightfall"), -- Vampiric Fountain, Bat Swarm
    [165568] = getScamboxString("nightfall"), -- Ancient Nord Gate
    [156669] = getScamboxString("frosty"), -- Target Frost Atronach
    [153650] = getScamboxString("newmoon"), -- Crystal Sconce, Green,
    [153631] = getScamboxString("newmoon"), -- Emerald Candlefly Gathering
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
    [153563] = elsweyr_event, -- Target Bone Goliath, Reanimated
    [153814] = elsweyr_event, -- Dragon's Treasure Trove
    [145317] = "Witches' Festival, Plunder Skull", -- Gravestone, Broken
    [153751] = "In Cyrodiil for Volundrung Vanquisher or Volendrung Wielder", -- Volendrung Replica TODO set up properly
    [165834] = chests_elsweyr, -- A Simple Five-Claw Life Painting, Gold
  },

  [src.CROWN] = {
    [151838] = getItempackString("oasis"), -- Elsweyr Fountain, Moons-Blessed,
    [151840] = getMultipleSources({ getCrownPrice(70), getItempackString("oasis") }), -- Plant, Desert Fan,
    [151841] = getMultipleSources({ getCrownPrice(70), getItempackString("oasis") }), -- Plant, Tall Desert Fan,
    [151842] = getMultipleSources({ getCrownPrice(20), getItempackString("oasis") }), -- Plant, Cask Palm,
    [151843] = getMultipleSources({ getCrownPrice(45), getItempackString("oasis") }), -- Cactus, Flowering Cluster,
    [151844] = getMultipleSources({ getCrownPrice(30), getItempackString("oasis") }), -- Cactus, Bilberry,
    [151845] = getMultipleSources({ getCrownPrice(95), getItempackString("oasis") }), -- Elsweyr Potted Cactus, Flowering,
    [151846] = getMultipleSources({ getCrownPrice(35), getItempackString("oasis"), getItempackString("mermaid") }), -- Elsweyr Potted Plant, Cask Palm,
    [151835] = getItempackString("oasis"), -- Cathay-Raht Statue, Warrior,
    [151836] = getItempackString("oasis"), -- Tojay Statue, Dancer,
    [151837] = getItempackString("oasis"), -- Ohmes-Raht Statue, Trickster,
    [151847] = getMultipleSources({ getCrownPrice(20), getItempackString("oasis") }), -- Plant, Flowering Desert Aloe,
    [151848] = getMultipleSources({ getCrownPrice(15), getItempackString("oasis") }), -- Trees, Sunset Palm Cluster,
    [151849] = getMultipleSources({ getCrownPrice(45), getItempackString("oasis") }), -- Cactus, Lily Flower,
    [151850] = getMultipleSources({ getCrownPrice(20), getItempackString("oasis") }), -- Tree, Anequina Bonsai,
    [151834] = getMultipleSources({ getCrownPrice(90), getItempackString("oasis") }), -- Tree, Desert Acacia Shade,

    [151906] = getItempackString("moonbishop"), -- Robust Target Dro-m'Athra,
    [151829] = getItempackString("moonbishop"), -- Suthay Statue, Nimble Bishop,
    [151824] = getItempackString("moonbishop"), -- Lunar Tapestry, The Open Path,
    [151825] = getItempackString("moonbishop"), -- Lunar Tapestry, The Gathering,
    [151826] = getItempackString("moonbishop"), -- Lunar Tapestry, The Dance,
    [151827] = getItempackString("moonbishop"), -- Lunar Tapestry, The Gate,
    [151828] = getItempackString("moonbishop"), -- Lunar Tapestry, The Demon,
    [151830] = getMultipleSources({ getCrownPrice(190), getItempackString("moonbishop") }), -- Elsweyr Divider, Elegant Wooden,
    [151832] = getMultipleSources({ getCrownPrice(100), getItempackString("moonbishop") }), -- Elsweyr Ceremonial Lantern, Jone,
    [151833] = getMultipleSources({ getCrownPrice(100), getItempackString("moonbishop") }), -- Elsweyr Ceremonial Lantern, Jode,

    [165578] = getItempackString("vampire"), -- Basin of Loss
    [165569] = getItempackString("vampire"), -- Soul-Sworn Thrall

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

    [152145] = mischouse .. " or Craftable", -- Orcish Tapestry, War,       CRAFTABLE
    [152149] = mischouse .. " or Craftable", -- Orcish Brazier, Pillar,     CRAFTABLE
    [152148] = mischouse .. " or Craftable", -- Orcish Tapestry, Hunt,      CRAFTABLE
    [152146] = mischouse .. " or Craftable", -- Orcish Chandelier, Spiked,  CRAFTABLE
    [152141] = mischouse .. " or Craftable", -- Orcish Brazier, Bordered,   CRAFTABLE
    [152144] = mischouse .. " or Craftable", -- Orcish Mirror, Peaked,      CRAFTABLE
    [152143] = mischouse .. " or Craftable", -- Orcish Sconce, Scrolled,    CRAFTABLE
    [152142] = mischouse .. " or Craftable", -- Orcish Sconce, Bordered,    CRAFTABLE

    [159438] = getScamboxString("gloomspore"), -- Fungus, Gloomspore Ghost
    [159437] = getScamboxString("gloomspore"), -- Painting of Blackreach, Rough
    [159436] = getScamboxString("gloomspore"), -- Dwarven Miniature Sun, Portable
    [153630] = getMultipleSources({ getScamboxString("newmoon"), " (55 gems)" }), -- Shadow Tendril Patch
    [151612] = getScamboxString("baandari"), -- Pile of Dubious Riches,
    [151611] = getScamboxString("baandari"), -- The Mane, Moons-Blessed,
    [151589] = getScamboxString("baandari"), -- Baandari Lunar Compass,
  },

  [src.FISHING] = {},
}

-- 10 Wrathstone
FurC.MiscItemSources[ver.WOTL] = {
  [src.CROWN] = {
    [147600] = getScamboxString("dragonscale"), -- Tapestry of Namira,
    [147599] = getScamboxString("dragonscale"), -- Banner of Namira,
    [147591] = getScamboxString("dragonscale"), -- Namira, Mistress of Decay,
  },
}

-- 9 Wolfhunter
FurC.MiscItemSources[ver.WEREWOLF] = {
  [src.DROP] = {
    [141851] = GetString(SI_FURC_WW_DUNGEON_DROP), -- Bear Skull, Fresh
    [141850] = GetString(SI_FURC_WW_DUNGEON_DROP), -- Bear Skeleton, Picked Clean
    [141847] = GetString(SI_FURC_WW_DUNGEON_DROP), -- Animal Bones, Gnawed
    [141848] = GetString(SI_FURC_WW_DUNGEON_DROP), -- Animal Bones, Jumbled
    [141849] = GetString(SI_FURC_WW_DUNGEON_DROP), -- Animal Bones, Fresh

    [141921] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Bowl, Geometric Pattern

    [141923] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Amphora, Seed Pattern
    [141922] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Dish, Geometric Pattern
    [141924] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Vase, Scale Pattern
    [141925] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Hearth Shrine, Sithis Relief
    [141926] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Hearth Shrine, Sithis Figure
    [141920] = GetString(SI_FURC_SLAVES_DAILY), -- Murkmire Brazier, Ceremonial

    [147639] = GetString(SI_FURC_DOM_DUNGEON_DROP), -- Magna-Geode
    [147640] = GetString(SI_FURC_DOM_DUNGEON_DROP), -- Magna-Geode, Large
    [147641] = GetString(SI_FURC_DOM_DUNGEON_DROP), -- Garlas Alpinia, Tall
  },

  [src.CROWN] = {
    [141836] = getCrownPrice(170), -- Monolith, Lord Hircine Ritual
    [141843] = getCrownPrice(30), -- Plants, Yellow Frond Cluster
    [125681] = getCrownPrice(50), -- Vines, Volcanic Roses
    [134921] = getCrownPrice(520), -- Redguard Lamppost, Stone
    [134922] = getCrownPrice(250), -- Redguard Pillar, Tiered
    [134923] = getCrownPrice(2000), -- Redguard Trellis, Peaked
    [134924] = getCrownPrice(380), -- Redguard Fence, Brass Capped
    [134925] = getCrownPrice(2200), -- Redguard Fountain, Pillar
    [134926] = getCrownPrice(1200), -- Redguard Awning, Wall
    [134927] = getCrownPrice(1200), -- Wedding Pergola, Double
    [134928] = getCrownPrice(1200), -- Wedding Pergola, Triple
    [134929] = getCrownPrice(45), -- Trees, Savanna Cluster
    [134930] = getCrownPrice(30), -- Bushes, Swordgrass Cluster
    [134931] = getCrownPrice(50), -- Boulder, Weathered Desert
    [134932] = getCrownPrice(50), -- Boulder, Tiered Desert
    [134933] = getCrownPrice(90), -- Cranium, Jawless
    [134934] = getCrownPrice(10), -- Rocks, Basalt Chunks
    [134936] = getCrownPrice(110), -- Cave Deposit, Tall Stalagmite Cluster
    [134938] = getCrownPrice(110), -- Cave Deposit, Stalagmite Group
    [134945] = getCrownPrice(200), -- Cave Deposit, Extended Spire
    [134973] = getCrownPrice(200), -- Cave Deposit, Stalactite Cone Cluster
    [134939] = getCrownPrice(110), -- Cave Deposit, Stalactite Cone
    [134941] = getCrownPrice(110), -- Cave Deposit, Spire
    [120603] = getCrownPrice(20), -- Boulder, Flat Mossy
    [120604] = getCrownPrice(20), -- Rock, Slanted Mossy
    [120605] = getCrownPrice(20), -- Rocks, Deep Mossy
    [120606] = getCrownPrice(20), -- Stones, Mossy Cluster
    [134943] = getCrownPrice(1000), -- Brotherhood Banner, Long
    [134944] = getCrownPrice(340), -- Brotherhood Column, Tall Ornate
    [134946] = getCrownPrice(340), -- Brotherhood Column, Ornate
    [120612] = getCrownPrice(10), -- Plant, Tall Mammoth Ear
    [120613] = getCrownPrice(10), -- Plant, Towering Mammoth Ear
    [120614] = getCrownPrice(10), -- Plant Cluster, Jungle Leaf
    [134951] = getCrownPrice(30), -- Mushrooms, Assorted Cluster
    [134952] = getCrownPrice(30), -- Mushrooms, Sporous Browncap
    [134953] = getCrownPrice(340), -- Brotherhood Carpet, Large Worn
    [126774] = getCrownPrice(510), -- Dres Tapestry, House
    [126775] = getCrownPrice(510), -- Hlaalu Tapestry, House
    [126777] = getCrownPrice(510), -- Redoran Tapestry, House
    [126778] = getCrownPrice(510), -- Telvanni Tapestry, House
    [134974] = getCrownPrice(340), -- Brotherhood Carpet, Worn
    [126830] = getCrownPrice(10), -- Mushrooms, Volcanic Cluster
    [120631] = getCrownPrice(5), -- Pebble, Stacked Mossy
    [134330] = getCrownPrice(490), -- Clockwork Control Panel, Double
    [134337] = getCrownPrice(1800), -- Clockwork Somnolostation, Octet
    [121036] = getCrownPrice(30), -- Shrub, Sparse Violet
    [121035] = getCrownPrice(30), -- Plant, Paired Verdant Hosta
    [121034] = getCrownPrice(10), -- Shrub, Delicate Forest
    [121032] = getCrownPrice(25), -- Saplings, Young Laurel
    [121031] = getCrownPrice(45), -- Topiary, Paired Cypress
    [121030] = getCrownPrice(54), -- Topiary, Young Cypress
    [121029] = getCrownPrice(45), -- Topiary, Strong Cypress
    [120709] = getCrownPrice(70), -- Tree, Sturdy Young Birch
    [121026] = getCrownPrice(45), -- Hedge, Dense High Wall
    [121025] = getCrownPrice(70), -- Trees, Sprawling Juniper Cluster
    [121024] = getCrownPrice(70), -- Trees, Paired Leaning Juniper
    [121021] = getCrownPrice(10), -- Plants, Dry Underbrush
    [121020] = getCrownPrice(10), -- Plants, Sparse Underbrush
    [121018] = getCrownPrice(10), -- Plant, Forest Sprig
    [121014] = getCrownPrice(20), -- Topiary, Sparse
    [121012] = getCrownPrice(70), -- Trees, Fragile Autumn Birch
    [121009] = getCrownPrice(70), -- Tree, Young Healthy Birch
    [120726] = getCrownPrice(20), -- Rock, Jagged Algae Coated
    [120727] = getCrownPrice(5), -- Stone, Angled Mossy
    [120728] = getCrownPrice(20), -- Rock, Jagged Lichen
    [121006] = getCrownPrice(45), -- Flower Patch, Violets
    [120730] = getCrownPrice(45), -- Topiary, Lush Evergreen
    [120731] = getCrownPrice(25), -- Tree, Mossy Summer
    [120732] = getCrownPrice(70), -- Tree, Mossy Forest
    [120733] = getCrownPrice(70), -- Tree, Gnarled Forest
    [120734] = getCrownPrice(25), -- Saplings, Squat Desert
    [120735] = getCrownPrice(52), -- Saplings, Young Desert
    [120736] = getCrownPrice(290), -- Tree, Gentle Weeping Willow
    [120737] = getCrownPrice(150), -- Tree, Weeping Willow
    [120738] = getCrownPrice(70), -- Tree, Towering Willow
    [120743] = getCrownPrice(70), -- Tree, Strong Cypress
    [120996] = getCrownPrice(120), -- Banner, Tattered Red
    [120745] = getCrownPrice(60), -- Tree, Water Palm
    [120483] = getCrownPrice(30), -- Cactus, Lemon Bulbs
    [120748] = getCrownPrice(70), -- Tree, Leaning Swamp
    [120749] = getCrownPrice(10), -- Grass, Tall Bamboo Shoots
    [120750] = getCrownPrice(10), -- Grass, Drying Bamboo Shoots
    [120751] = getCrownPrice(10), -- Grass, Twin Bamboo Shoots
    [120752] = getCrownPrice(10), -- Grass, Young Bamboo Shoots
    [120471] = getCrownPrice(25), -- Tree, Wilted Palm
    [120756] = getCrownPrice(10), -- Plant, Palm Fronds
    [120463] = getCrownPrice(20), -- Boulder, Weathered Flat
    [120456] = getCrownPrice(5), -- Stone, Smooth Desert
    [134579] = getCrownPrice(5), -- Rubble Pile, Worked Stone
    [120760] = getCrownPrice(50), -- Flower, Red Honeysuckle
    [125544] = getCrownPrice(30), -- Fern, Strong Dusky
    [125547] = getCrownPrice(85), -- Flower, Healthy Purple Bat Bloom
    [125546] = getCrownPrice(85), -- Flower Patch, Lava Blooms
    [120765] = getCrownPrice(15), -- Breton Cup, Empty
    [120766] = getCrownPrice(15), -- Breton Cup, Full
    [134950] = getCrownPrice(31), -- Mushrooms, Flapjack Stack
    [139238] = getCrownPrice(190), -- Alinor Wall Mirror, Ornate
    [139239] = getCrownPrice(190), -- Alinor Wall Mirror, Verdant
    [139389] = getCrownPrice(200), -- Crystal, Crimson Cluster
    [139184] = getCrownPrice(200), -- Alinor Plinth, Sarcophagus

    [130093] = getItempackString("molag"), -- Coldharbour Compact
    [130071] = getMultipleSources({ getCrownPrice(300), getItempackString("molag") }), -- Daedric Torch, Coldharbour
    [130075] = getMultipleSources({ getCrownPrice(380), getItempackString("molag") }), -- Daedric Altar, Molag Bal
    [130078] = getMultipleSources({ getCrownPrice(380), getItempackString("molag") }), -- Soul Gem, Single
    [130079] = getMultipleSources({ getCrownPrice(380), getItempackString("molag") }), -- Soul Gems, Pile
    [130082] = getMultipleSources({ getCrownPrice(640), getItempackString("molag") }), -- Soul-Shriven, Robed
    [130094] = getMultipleSources({ getCrownPrice(140), getItempackString("molag") }), -- Daedric Chains, Hanging
    [130095] = getMultipleSources({ getCrownPrice(640), getItempackString("molag") }), -- Daedric Torture Device, Chained
    [130069] = getMultipleSources({ getCrownPrice(2000), getItempackString("molag") }), -- Daedric Spout, Block
    [130070] = getMultipleSources({ getCrownPrice(2000), getItempackString("molag") }), -- Daedric Spout, Arched
    [130080] = getItempackString("molag"), -- Soul Gems, Scattered
    [130081] = getItempackString("molag"), -- Soul-Shriven, Armored
    [130083] = getItempackString("molag"), -- Daedric Block, Seat
    [130084] = getItempackString("molag"), -- Daedric Tapestry, Molag Bal
    [130085] = getItempackString("molag"), -- Daedric Banner, Molag Bal
    [130086] = getItempackString("molag"), -- Daedric Pennant, Molag Bal
    [130089] = getMultipleSources({ getCrownPrice(360), getItempackString("molag") }), -- Daedric Brazier, Molag Bal
    [130087] = getItempackString("molag"), -- Daedric Shards, Coldharbour
    [130091] = getItempackString("molag"), -- Statue of Molag Bal, God of Schemes
    [130090] = getMultipleSources({ getCrownPrice(310), getItempackString("molag") }), -- Daedric Sconce, Molag Bal
    [130088] = getItempackString("molag"), -- Daedric Fragment, Coldharbour
    [130092] = getItempackString("molag"), -- Seal of Molag Bal, Grand

    [126138] = getItempackString("dwemer"), -- A Guide to Dwemer Mega-Structures
    [125516] = getItempackString("dwemer"), -- Dwarven Gear Assembly, Grinding

    [126140] = getItempackString("vivec"), -- Vivec's Grand Bed
    [126141] = getItempackString("vivec"), -- Vivec's Grand Throne
    [126142] = getItempackString("vivec"), -- Vivec's Divination Pool
    [126143] = getItempackString("vivec"), -- Statue, Vivec's Triumph
    [126144] = getItempackString("vivec"), -- Seal of Vivec
    [126145] = getItempackString("vivec"), -- Sigil of Vivec
    [126146] = getItempackString("vivec"), -- Banner, Vivec
    [126149] = getItempackString("vivec"), -- Tapestry, Vivec
    [126150] = getItempackString("vivec"), -- Tribunal Tablet of Sotha Sil
    [126152] = getItempackString("vivec"), -- The Cliff-Strider Song

    [134855] = getScamboxString("scalecaller"), -- Banner of Peryite
    [134854] = getScamboxString("scalecaller"), -- Tapestry of Peryite
    [134853] = getScamboxString("scalecaller"), -- Peryite, The Taskmaster
    [134475] = getScamboxString("fireatro"), -- Statue of Malacath, Orc-Father
    [126132] = getScamboxString("string") .. " (any)", -- Resplendent Sweetroll
    [125654] = getScamboxString("dwemer"), -- Tapestry, Clavicus Vile
    [125480] = getScamboxString("dwemer"), -- Banner, Clavicus Vile
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
    [145550] = getMultipleSources({ stealable_swamp, GetString(SI_FURC_DROP_MURKMIRE) }), -- Murkmire Hunting Lure, Grisly
    [145401] = stealable_swamp, -- Murkmire Tapestry, Xanmeer Worn
    [145403] = stealable_swamp, -- Jel Parchment
  },

  [src.DROP] = {
    [141856] = getMultipleSources({ sinister_hollowjack, getScamboxString("hollowjack") }), -- Decorative Hollowjack Daedra-Skull
    [141855] = getMultipleSources({ sinister_hollowjack, getScamboxString("hollowjack") }), -- Decorative Hollowjack Wraith-Lantern
    [141854] = getMultipleSources({ sinister_hollowjack, getScamboxString("hollowjack") }), -- Decorative Hollowjack Flame-Skull
    [141870] = sinister_hollowjack, -- Raven-Perch Cemetery Wreath
    [141875] = sinister_hollowjack, -- Witches Festival Scarecrow
    [139157] = sinister_hollowjack, -- Webs, Thick Sheet
    [139162] = sinister_hollowjack, -- Webs, Cone
    [141939] = sinister_hollowjack, -- Grave, Grasping
    [141965] = sinister_hollowjack, -- Hollowjack Lantern, Soaring Dragon
    [141966] = sinister_hollowjack, -- Hollowjack Lantern, Toothy Grin
    [141967] = sinister_hollowjack, -- Hollowjack Lantern, Ouroboros
    [142004] = sinister_hollowjack, -- Specimen Jar, Spare Brain
    [142005] = sinister_hollowjack, -- Specimen Jar, Monstrous Remains
    [142003] = sinister_hollowjack, -- Specimen Jar, Eyes
    [120877] = sinister_hollowjack, -- Gravestone, Cracked
    [120876] = sinister_hollowjack, -- Gravestone, Imp Engraving
    [120875] = sinister_hollowjack, -- Gravestone, Clover Engraving
    [141778] = sinister_hollowjack, -- Target Wraith-of-Crows

    -- "Part of the item 'Look upon Their Nothing Eyes' in Lilmoth, Murkmire, 15k gold"
    [145923] = getPartOfItemString(
      145596,
      zo_strformat(
        "<<1>>, <<2>>: <<3>>",
        GetString(SI_FURC_LOC_MURKMIRE),
        GetString(SI_FURC_LOC_LILMOTH),
        getPriceString(15000, CURT_MONEY)
      )
    ), -- Lies of the Dread-Father
    [145926] = getPartOfItemString(
      145596,
      zo_strformat(
        "<<1>>, <<2>>: <<3>>",
        GetString(SI_FURC_LOC_MURKMIRE),
        GetString(SI_FURC_LOC_LILMOTH),
        getPriceString(15000, CURT_MONEY)
      )
    ), -- That of Void
    [145927] = getPartOfItemString(
      145596,
      zo_strformat(
        "<<1>>, <<2>>: <<3>>",
        GetString(SI_FURC_LOC_MURKMIRE),
        GetString(SI_FURC_LOC_LILMOTH),
        getPriceString(15000, CURT_MONEY)
      )
    ), -- Acts of Honoring
    [145928] = getPartOfItemString(
      145596,
      zo_strformat(
        "<<1>>, <<2>>: <<3>>",
        GetString(SI_FURC_LOC_MURKMIRE),
        GetString(SI_FURC_LOC_LILMOTH),
        getPriceString(15000, CURT_MONEY)
      )
    ), -- Speakers of Nothing
    [145597] = getPartOfItemString(
      145596,
      zo_strformat(
        "<<1>>, <<2>>: <<3>>",
        GetString(SI_FURC_LOC_MURKMIRE),
        GetString(SI_FURC_LOC_LILMOTH),
        getPriceString(15000, CURT_MONEY)
      )
    ), -- Scales of Shadow
  },

  [src.CROWN] = {
    [145466] = getCrownPrice(30), -- Plant, Wilted Hist Bulb
    [145465] = getCrownPrice(40), -- Plant Cluster, Wilted Hist Bulb
    [145464] = getCrownPrice(30), -- Plant, Red Sister Ti
    [145463] = getCrownPrice(35), -- Plant Cluster, Red Sister Ti
    [145462] = getCrownPrice(40), -- Plant, Cardinal Flower
    [145460] = getCrownPrice(30), -- Plant, Canna Leaves
    [145459] = getCrownPrice(90), -- Murkmire Kiln, Ancient Stone
    [145448] = getCrownPrice(1000), -- Murkmire Throne, Engraved
    [145444] = getCrownPrice(130), -- Murkmire Totem, Hist Guardian
    [145429] = getCrownPrice(65), -- Plant Cluster, Bounteous Flower Large
    [145411] = getCrownPrice(410), -- Plant, Luminous Lantern Flower
    [145322] = getCrownPrice(800), -- Music Box, Blood and Glory
    [141976] = getCrownPrice(60), -- Pumpkin Patch, Display
    [141869] = getCrownPrice(150), -- Alinor Potted Plant, Cypress
    [141853] = getCrownPrice(2500), -- Statue of Hircine's Bitter Mercy
    [134326] = getCrownPrice(260), -- Clockwork Pump, Horizontal
    [134250] = getCrownPrice(750), -- Fabrication Sphere, Inactive

    [146062] = getItempackString("newlife2018"), -- Winter Ouroboros Wreath
    [146061] = getItempackString("newlife2018"), -- New Life Triptych Banner
    [146060] = getItempackString("newlife2018"), -- New Life Ladle
    [146059] = getItempackString("newlife2018"), -- New Life Snowmortal, Khajiit
    [146058] = getItempackString("newlife2018"), -- New Life Snowmortal, Argonian
    [146057] = getItempackString("newlife2018"), -- New Life Snowmortal, Human
    [146056] = getItempackString("newlife2018"), -- New Life Cookies and Ale
    [146055] = getItempackString("newlife2018"), -- New Life Garland Wreath
    [146054] = getItempackString("newlife2018"), -- New Life Garland
    [146053] = getItempackString("newlife2018"), -- Guar Ice Sculpture
    [146052] = getItempackString("newlife2018"), -- Vvardvark Ice Sculpture
    [146051] = getItempackString("newlife2018"), -- Mudcrab Ice Sculpture
    [146050] = getItempackString("newlife2018"), -- Winter Festival Hearthfire
    [146049] = getItempackString("newlife2018"), -- Winter Festival Hearth
    [146048] = getItempackString("newlife2018"), -- New Life Festive Fir
    [146047] = getItempackString("newlife2018"), -- From Old Life To New

    [146073] = getMultipleSources({ getCrownPrice(70), getItempackString("deepmire") }), -- Plant Cluster, Marsh Nigella,
    [145461] = getMultipleSources({ getCrownPrice(30), getItempackString("deepmire") }), -- Plant Cluster, Cardinal Flower
    [145447] = getMultipleSources({ getCrownPrice(260), getItempackString("swamp") }), -- Murkmire Dais, Engraved
    [145445] = getItempackString("deepmire"), -- The Sharper Tongue: A Jel Primer
    [145443] = getMultipleSources({ getCrownPrice(270), getItempackString("deepmire") }), -- Murkmire Shrine, Sithis Looming
    [145442] = getMultipleSources({ getCrownPrice(140), getItempackString("deepmire") }), -- Grave Stake, Large Twinned
    [145441] = getMultipleSources({ getCrownPrice(140), getItempackString("deepmire") }), -- Grave Stake, Large Serpent
    [145440] = getMultipleSources({ getCrownPrice(140), getItempackString("deepmire") }), -- Grave Stake, Large Skull
    [145439] = getMultipleSources({ getCrownPrice(140), getItempackString("deepmire") }), -- Grave Stake, Large Fearsome
    [145438] = getMultipleSources({ getCrownPrice(140), getItempackString("deepmire") }), -- Grave Stake, Large Glyphed
    [145437] = getMultipleSources({ getCrownPrice(240), getItempackString("deepmire") }), -- Reed Felucca, Double Hulled
    [145436] = getItempackString("deepmire"), -- Canopied Felucca, Double Hulled
    [145435] = getMultipleSources({ getCrownPrice(110), getItempackString("deepmire") }), -- Plant, Marsh Mani Flower
    [145434] = getMultipleSources({ getCrownPrice(110), getItempackString("deepmire") }), -- Plant, Large Inert Lantern Flower
    [145433] = getMultipleSources({ getCrownPrice(60), getItempackString("deepmire") }), -- Plant, Rafflesia
    [145432] = getMultipleSources({ getCrownPrice(70), getItempackString("deepmire") }), -- Plant, Canna Lily
    [145431] = getMultipleSources({ getCrownPrice(35), getItempackString("deepmire") }), -- Plant, Marsh Nigella
    [145430] = getMultipleSources({ getCrownPrice(55), getItempackString("deepmire") }), -- Plant, Star Blossom
    [145428] = getMultipleSources({ getCrownPrice(65), getItempackString("deepmire") }), -- Murkmire Lantern Post, Covered
    [145427] = getItempackString("deepmire"), -- Serpent Skull, Colossal
    [145426] = getMultipleSources({ getCrownPrice(410), getItempackString("deepmire") }), -- Murkmire Felucca, Canopied

    [134249] = getItempackString("sotha"), -- Sotha Sil, The Clockwork God
    [134248] = getItempackString("sotha"), -- Grand Mnemograph
    [134246] = getItempackString("sotha"), -- The Law of Gears

    [145493] = getScamboxString("xanmeer"), -- Lantern Mantis
    [145492] = getScamboxString("xanmeer"), -- Gas Blossom
    [145491] = getScamboxString("xanmeer"), -- Static Pitcher
  },

  [src.FISHING] = {
    -- fishing
    [145402] = fishing_swamp, -- Fish, Black Marsh
  },
}

-- 7 Summerset Isles
FurC.MiscItemSources[ver.ALTMER] = {
  [src.CROWN] = {
    [139650] = getCrownPrice(30), -- Bushes, Ivy Cluster
    [139483] = getCrownPrice(90), -- Alinor Column, Tumbled Timeworn
    [139482] = getCrownPrice(200), -- Alinor Column, Huge Timeworn
    [139481] = getCrownPrice(200), -- Alinor Column, Jagged Timeworn
    [139480] = getCrownPrice(30), -- Plants, Redtop Grass Tuft
    [139376] = getCrownPrice(260), -- Alinor Banner, Hanging
    [139368] = getCrownPrice(100), -- Alinor Bathing Robes, Decorative
    [139366] = getCrownPrice(2000), -- Alinor Fountain, Regal
    [139365] = getCrownPrice(370), -- Psijic Lighting Globe, Framed
    [139364] = getCrownPrice(1500), -- Sload Neural Tree, Active
    [139363] = getCrownPrice(340), -- Sload Astral Nodule, Large
    [139362] = getCrownPrice(340), -- Sload Astral Nodule, Small
    [139361] = getCrownPrice(270), -- Mind Trap Kelp, Young
    [139360] = getCrownPrice(510), -- Mind Trap Kelp, Cluster
    [139359] = getCrownPrice(340), -- Mind Trap Coral Formation, Trees Capped
    [139358] = getCrownPrice(340), -- Mind Trap Coral Formation, Tree Capped
    [139357] = getCrownPrice(340), -- Mind Trap Coral Formation, Tree Antler
    [139356] = getCrownPrice(340), -- Mind Trap Coral Formation, Waving Hands
    [139355] = getCrownPrice(340), -- Mind Trap Coral Formation, Heart
    [139354] = getCrownPrice(340), -- Mind Trap Coral Spire, Bulbous
    [139353] = getCrownPrice(340), -- Mind Trap Coral Spire, Branched
    [139352] = getCrownPrice(1000), -- Alinor Tomb, Ornate
    [139351] = getCrownPrice(200), -- Alinor Monument, Marble
    [139350] = getCrownPrice(940), -- Alinor Pergola, Purple Wisteria Overhang
    [139349] = getCrownPrice(940), -- Alinor Pergola, Blue Wisteria Peaked
    [139348] = getCrownPrice(940), -- Alinor Pergola, Purple Wisteria
    [139347] = getCrownPrice(45), -- Flowers, Yellow Oleander Cluster
    [139346] = getCrownPrice(45), -- Flowers, Lizard Tail Patch
    [139345] = getCrownPrice(45), -- Flowers, Lizard Tail Cluster
    [139344] = getCrownPrice(45), -- Flowers, Hummingbird Mint Cluster
    [139343] = getCrownPrice(45), -- Tree, Cloud White
    [139342] = getCrownPrice(45), -- Tree, Vibrant Pink
    [139341] = getCrownPrice(310), -- Tree, Towering Poplar
    [139340] = getCrownPrice(310), -- Tree, Ancient Summerset Spruce
    [139339] = getCrownPrice(25), -- Vines, Sun-Bronzed Ivy Climber
    [139338] = getCrownPrice(25), -- Vines, Sun-Bronzed Ivy Swath
    [139337] = getCrownPrice(580), -- Tree, Ancient Blooming Ginkgo
    [139336] = getCrownPrice(90), -- Trees, Shade Interwoven
    [139335] = getCrownPrice(310), -- Tree, Shade Ancient
    [139334] = getCrownPrice(20), -- Coral Formation, Tree Capped (green)
    [139333] = getCrownPrice(45), -- Coral Formation, Trees Capped
    [139332] = getMultipleSources({ getCrownPrice(45), getItempackString("aquatic") }), -- Coral Formation, Tree Shelf
    [139331] = getCrownPrice(45), -- Coral Formation, Tree Antler
    [139330] = getCrownPrice(45), -- Coral Formation, Waving Hands
    [139329] = getCrownPrice(45), -- Coral Formation, Heart
    [139328] = getCrownPrice(45), -- Coral Spire, Branched
    [139327] = getCrownPrice(45), -- Coral Spire, Sturdy
    [139293] = getCrownPrice(30), -- Alinor Chalice, Silver Ornate
    [139237] = getCrownPrice(190), -- Alinor Wall Mirror, Noble
    [139161] = getCrownPrice(1500), -- Daedric Table, Grand Necropolis
    [139160] = getCrownPrice(200), -- Daedric Armchair, Severe
    [139159] = getCrownPrice(920), -- Daedric Chandelier, Gruesome
    [139158] = getCrownPrice(150), -- Daedric Candelabra, Tall
    [139156] = getCrownPrice(360), -- Cocoon, Skeleton
    [139155] = getCrownPrice(80), -- Cocoon, Food Storage
    [139154] = getCrownPrice(40), -- Cocoons, Dormant Cluster
    [139153] = getCrownPrice(40), -- Cocoon, Dormant
    [139152] = getCrownPrice(360), -- Cocoon, Enormous Empty
    [139151] = getCrownPrice(140), -- Mushrooms, Shadowpalm Cluster
    [139150] = getCrownPrice(70), -- Mushrooms, Midnight Cluster
    [139149] = getCrownPrice(30), -- Plant, Scarlet Fleshfrond
    [139148] = getCrownPrice(70), -- Mushroom, Nettlecap
    [139147] = getCrownPrice(30), -- Plants, Scarlet Sawleaf
    [139146] = getCrownPrice(490), -- Crystals, Midnight Bloom
    [139145] = getCrownPrice(430), -- Crystals, Midnight Tower
    [139144] = getCrownPrice(400), -- Crystals, Midnight Spire
    [139143] = getCrownPrice(310), -- Crystals, Midnight Cluster
    [139142] = getCrownPrice(380), -- Crystals, Crimson Spikes
    [139141] = getCrownPrice(310), -- Crystals, Crimson Bed
    [139140] = getCrownPrice(340), -- Crystals, Crimson Spray
    [139126] = getCrownPrice(50), -- Sapling, Ginkgo
    [139090] = getCrownPrice(100), -- Alinor Table Runner, Cloth of Silver
    [139089] = getCrownPrice(50), -- Alinor Table Runner, Coiled
    [139088] = getCrownPrice(50), -- Alinor Table Runner, Verdant
    [139083] = getCrownPrice(30), -- Plants, Grasswort Patch
    [139068] = getCrownPrice(20), -- Plants, Springwheeze
    [139067] = getCrownPrice(20) .. " or from harvesting plants in Summerset", -- Flower, Yellow Oleander
    [139066] = getCrownPrice(30), -- Plant, Redtop Grass
    [139065] = getCrownPrice(20), -- Flowers, Lizard Tail
    [134247] = getCrownPrice(190), -- Soul Gem Module, Experimental
    [132165] = getCrownPrice(750), -- Hlaalu Bath Tub, Empty Basin
    [126464] = getCrownPrice(610), -- Telvanni Painting, Oversized Valley
    [126463] = getCrownPrice(610), -- Telvanni Painting, Oversized Forest
    [126462] = getCrownPrice(610), -- Telvanni Painting, Oversized Volcanic
    [126038] = getCrownPrice(4000), -- Target Centurion, Robust Lambent
    [126037] = getCrownPrice(4000), -- Target Centurion, Lambent
    [126034] = getCrownPrice(4000), -- The Lord
    [125461] = getCrownPrice(4000), -- The Lover
    [125460] = getCrownPrice(4000), -- The Mage
    [125459] = getCrownPrice(4000), -- The Ritual
    [125458] = getCrownPrice(4000), -- The Serpent
    [125457] = getCrownPrice(4000), -- The Shadow
    [125456] = getCrownPrice(4000), -- The Steed
    [125455] = getCrownPrice(4000), -- The Thief
    [125454] = getCrownPrice(4000), -- The Tower
    [125453] = getCrownPrice(4000), -- The Warrior
    [125452] = getCrownPrice(4000), -- The Lady
    [125451] = getCrownPrice(4000), -- The Apprentice
    [119556] = getCrownPrice(4000), -- The Atronach
    [118491] = getCrownPrice(55), -- Scroll, Bound
    [118145] = getCrownPrice(410), -- Painting of a Desert, Refined
    [118144] = getCrownPrice(410), -- Painting of a Forest, Refined
    [118142] = getCrownPrice(410), -- Painting of Swamp, Refined
    [118140] = getCrownPrice(410), -- Painting of a Waterfall, Refined
    [118138] = getCrownPrice(410), -- Painting of Mountains, Refined

    [140220] = getItempackString("mephala"), -- Rumours of the Spiral Skein
    [139163] = getItempackString("mephala"), -- Mephala, The Webspinner (statue)
    [139097] = getItempackString("mephala"), -- Spiral Skein Glowstalks, Sprouts

    [139139] = getScamboxString("psijic"), -- Nocturnal, Mistress of Shadows
    [139138] = getScamboxString("psijic"), -- Banner, Nocturnal
    [139137] = getScamboxString("psijic"), -- Tapestry, Nocturnal
    [134474] = getScamboxString("fireatro"), -- Banner, Malacath
    [130192] = getScamboxString("reaper"), -- Statue of Sheogorath, the Madgod
    [130190] = getScamboxString("reaper"), -- Banner of Sheogorath
    [130189] = getScamboxString("reaper"), -- Tapestry of Sheogorath
  },

  [src.DROP] = {
    [139059] = GetString(SI_FURC_DROP), -- Ivory, Polished - drops from Echatere, and probably alot else
    [139066] = GetString(SI_FURC_FARM_HARVEST), -- Plant, Redtop Grass

    [139060] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Ancient
    [139062] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Large
    [139063] = GetString(SI_FURC_GIANT_CLAM), -- Pearl, Enormous
    [139061] = GetString(SI_FURC_GIANT_CLAM), -- Giant Clam, Sealed

    [139073] = questRewardLilandril, -- Painting of Summerset Coast, Refined
    [139072] = GetString(SI_FURC_ELF_PIC), -- Painting of Monastery of Serene Harmony, Refined
    [139074] = GetString(SI_FURC_ELF_PIC), -- Painting of Aldmeri Ruins, Refined
    [139069] = GetString(SI_FURC_ELF_PIC), -- Painting of Griffin Nest, Refined
    [139070] = GetString(SI_FURC_ELF_PIC), -- Painting of College of the Sapiarchs, Refined
    [139071] = GetString(SI_FURC_ELF_PIC), -- Painting of High Elf Tower, Refined

    [87709] = GetString(SI_FURC_LEVELUP), -- Imperial Brazier, Spiked
    [94098] = GetString(SI_FURC_LEVELUP), -- Imperial Bed, Single

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
    [134909] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Puspocket Group
    [134910] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Puspocket Cluster
    [134911] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Puspocket Sporecap
    [134912] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Large Puspocket
    [134913] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushroom, Tall Puspocket
    [134914] = GetString(SI_FURC_DRAGON_DUNGEON_DROP), -- Mushrooms, Large Puspocket Cluster
  },

  [src.JUSTICE] = {},

  [src.CROWN] = {
    [134970] = getCrownPrice(100), -- Mushrooms, Glowing Sprawl
    [134947] = getCrownPrice(100), -- Mushrooms, Glowing Field
    [134948] = getCrownPrice(400), -- Mushrooms, Glowing Cluster
    [134971] = getCrownPrice(400), -- Candles, Votive Group
    [134972] = getCrownPrice(400), -- Brotherhood Brazier, Wrought Iron
    [94100] = getCrownPrice(50), -- Imperial BookCase, Swirled
    [130211] = getCrownPrice(50), -- Books, Ordered Row
    [130210] = getCrownPrice(50), -- Books, Scattered Row
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
    [117939] = stealable_woodworkers, -- Rough Axe, Practical
  },

  [src.CROWN] = {
    [134266] = getCrownPrice(80), -- Daedric Books, Stacked
    [134265] = getCrownPrice(80), -- Daedric Books, Piled
    [134373] = getCrownPrice(410), -- Clockwork Wall Machinery, Rectangular
    [134374] = getCrownPrice(410), -- Clockwork Wall Machinery, Circular
    [134382] = getCrownPrice(870), -- Fabricant Tree, Beryl Cypress
    [134383] = getCrownPrice(870), -- Fabricant Tree, Towering Maple
    [134385] = getCrownPrice(870), -- Fabricant Tree, Brass Swamp
    [134387] = getCrownPrice(870), -- Fabricant Tree, Tall Cobalt Spruce
    [134388] = getCrownPrice(870), -- Fabricant Tree, Cobalt Oak
    [134384] = getCrownPrice(870), -- Fabricant Tree, Decorative Electrum
    [134386] = getCrownPrice(260), -- Fabricant Tree, Forked Cherry Blossom
    [134389] = getCrownPrice(140), -- Fabricant Tree, Decorative Brass
    [134390] = getCrownPrice(140), -- Clockwork Junk Heap, Large
    [134391] = getCrownPrice(510), -- Clockwork Sequence Spool, Column
    [134392] = getCrownPrice(260), -- Clockwork Recharging Column, Octet
    [134393] = getCrownPrice(270), -- Clockwork Workbench, Spacious
    [134394] = getCrownPrice(460), -- Clockwork Illuminator, Capsule Chandelier
    [134395] = getCrownPrice(150), -- Clockwork Illuminator, Wall Capsule
    [134396] = getCrownPrice(410), -- Clockwork Wall Machinery, Tall
    [134397] = getCrownPrice(410), -- Clockwork Wall Machinery, Ovoid
    [134398] = getCrownPrice(1300), -- Clockwork Gazebo, Copper and Basalt
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
    [130284] = GetString(SI_FURC_FARM_HARVEST), -- Glowstalk, Seedlings
    [131422] = GetString(SI_FURC_FARM_HARVEST), -- Flower Patch, Glowstalks
    [130283] = GetString(SI_FURC_FARM_HARVEST), -- Glowstalk, Sprout
    [130285] = GetString(SI_FURC_FARM_HARVEST), -- Glowstalk, Young
    [131420] = GetString(SI_FURC_FARM_HARVEST), -- Shrub, Glowing Thistle
    [130281] = GetString(SI_FURC_FARM_HARVEST), -- Glowstalk, Towering
    [130282] = GetString(SI_FURC_FARM_HARVEST), -- Glowstalk, Strong

    [130067] = GetString(SI_FURC_DAEDRA_SOURCE), -- Daedric Chain Segment
  },
}

-- 3 Morrowind
FurC.MiscItemSources[ver.MORROWIND] = {
  [src.DROP] = {

    --Public dungeon Forgotten Wastes / maybe rarest drop at all ingame
    [127149] = puplicdungeon_fw_vv, -- Morrowind Banner of the 6th House

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

    [126759] = questRewardSuran, -- Sir Sock's Ball of Yarn

    [126592] = GetString(SI_FURC_PLANTS), -- Plants, Hanging Pitcher Pair
  },

  [src.CROWN] = {
    [130213] = getMultipleSources({ getCrownPrice(430), getItempackString("ayleid") }), -- Ayleid Cage, Hanging
    [130212] = getItempackString("ayleid"), -- Daedra Worship: The Ayleids
    [130207] = getMultipleSources({ getCrownPrice(270), getItempackString("ayleid") }), -- Ayleid Plinth, Engraved
    [130206] = getMultipleSources({ getCrownPrice(370), getItempackString("ayleid") }), -- Ayleid Apparatus, Welkynd
    [130205] = getMultipleSources({ getCrownPrice(680), getItempackString("ayleid") }), -- Ayleid Statue, Pious Priest
    [130204] = getMultipleSources({ getCrownPrice(410), getItempackString("ayleid") }), -- Welkynd Stones, Glowing
    [130202] = getMultipleSources({ getCrownPrice(170), getItempackString("ayleid") }), -- Ayleid Grate, Tall
    [130201] = getMultipleSources({ getCrownPrice(170), getItempackString("ayleid") }), -- Ayleid Grate, Small
    [130199] = getMultipleSources({ getCrownPrice(170), getItempackString("ayleid") }), -- Ayleid Bookshelf, Bare
    [130197] = getMultipleSources({ getCrownPrice(170), getItempackString("ayleid") }), -- Ayleid Bookcase, Filled

    [134578] = getCrownPrice(110), -- Ice Floe, Thick
    [134577] = getCrownPrice(50), -- Ice Floe, Thin
    [134576] = getCrownPrice(190), -- Orcish Brazier, Snowswept Column
    [134575] = getCrownPrice(50), -- Boulder, Snowswept Crag
    [134574] = getCrownPrice(50), -- Boulder, Snowswept Peak
    [134573] = getCrownPrice(5), -- Stone, Snowswept Shard
    [134572] = getCrownPrice(5), -- Stones, Snowswept Cluster
    [134571] = getCrownPrice(120), -- Snow Pile, Large
    [134570] = getCrownPrice(110), -- Snow Pile
    [134569] = getCrownPrice(40), -- Trees, Snowswept Pair
    [134568] = getCrownPrice(40), -- Tree, Snowswept Evergreen
    [134567] = getCrownPrice(10), -- Bush Cluster, Snowswept
    [134566] = getCrownPrice(30), -- Shrub Cluster, Snowswept
    [134565] = getCrownPrice(130), -- Fabrication Tank, Reinforced
    [134381] = getCrownPrice(110), -- Rocks, Sintered Outcropping
    [134380] = getCrownPrice(110), -- Rocks, Sintered Arch
    [134379] = getCrownPrice(50), -- Boulder, Large Metallic Shard
    [131427] = getCrownPrice(1700), -- Orcish Tent, General's
    [131426] = getCrownPrice(680), -- Orcish Tent, Officer's
    [131425] = getCrownPrice(360), -- Orcish Tent, Soldier's
    [130329] = getCrownPrice(240), -- Primal Brazier, Rock Slab
    [130322] = getCrownPrice(90), -- Tool, Harvest Scythe
    [130319] = getCrownPrice(10), -- Crop, Wheat Stack
    [130318] = getCrownPrice(10), -- Crop, Wheat Pile
    [130317] = getCrownPrice(25), -- Pumpkin, Sickly
    [130316] = getCrownPrice(25), -- Pumpkin, Frail
    [126686] = getCrownPrice(400), -- Dwarven Chest, Relic
    [126607] = getCrownPrice(410), -- Velothi Painting, Oversized Waterfall
    [126604] = getCrownPrice(410), -- Velothi Panels, Geyser
    [126601] = getCrownPrice(410), -- Velothi Painting, Oversized Geyser
    [126598] = getCrownPrice(410), -- Velothi Panels, Waterfall
    [126597] = getCrownPrice(410), -- Velothi Painting, Oversized Volcano
    [126592] = getCrownPrice(410), -- Velothi Panels, Volcano
    [126479] = getCrownPrice(310), -- Telvanni Sconce, Organic Amber
    [126478] = getCrownPrice(560), -- Telvanni Arched Light, Organic Amber
    [126477] = getCrownPrice(560), -- Telvanni Streetlight, Organic Amber
    [126476] = getCrownPrice(200), -- Telvanni Lamp, Organic Amber
    [126475] = getCrownPrice(260), -- Telvanni Lantern, Organic Amber
    [125628] = getCrownPrice(70), -- Plant, Rosetted Sundew
    [125616] = getCrownPrice(5), -- Pebble, Volcanic Chunk
    [125610] = getCrownPrice(25), -- Mushrooms, Cave Bracket Cluster
    [125607] = getCrownPrice(10), -- Mushroom, Young Netch Shield
    [125605] = getCrownPrice(10), -- Mushroom, Young Erupted Stinkcap
    [125603] = getCrownPrice(40), -- Mushroom, Stinkhorn Spore
    [125580] = getHouseString(1244), -- Hlaalu Well, Covered Sillar Stone
    [125579] = getHouseString(1243), -- Hlaalu Well, Braced Sillar Stone
    [125577] = getHouseString(1243), -- Hlaalu Wall Post, Sillar Stone
    [125573] = getHouseString(1243, 1244), -- Hlaalu Streetlamp, Paper
    [125568] = getHouseString(1243), -- Hlaalu Sidewalk, Sillar Stone
    [125567] = getHouseString(1244), -- Hlaalu Shed, Open
    [125566] = getHouseString(1243), -- Hlaalu Shed, Enclosed
    [125565] = getHouseString(1244), -- Hlaalu Lantern, Hanging Paper
    [125555] = getCrownPrice(85), -- Flowers, Sullen Purple Bat Blooms
    [125554] = getCrownPrice(85), -- Flowers, Opposing Purple Bat Blooms
    [125550] = getCrownPrice(85), -- Flowers, Lava Blooms
    [125549] = getCrownPrice(85), -- Flowers, Double Purple Bat Blooms
    [125548] = getCrownPrice(85), -- Flower, Towering Purple Bat Bloom
    [125545] = getCrownPrice(30), -- Fern, Young Dusky
    [125484] = getCrownPrice(30), -- Bush, Lush Laurel
    [125482] = getCrownPrice(50), -- Boulder, Volcanic Crag
    [121400] = getCrownPrice(2000), -- Target Skeleton, Robust Argonian
    [121399] = getCrownPrice(2000), -- Target Skeleton, Robust Khajiit
    [121056] = getCrownPrice(25), -- Book Stack, Decorative
    [121054] = getCrownPrice(30), -- Breton Mug, Empty
    [121053] = getCrownPrice(170), -- Jar, Gilded Canopic
    [121052] = getCrownPrice(100), -- Vase, Gilded Offering
    [121047] = getCrownPrice(25), -- Book Row, Long
    [121045] = getCrownPrice(25), -- Book Row, Decorative
    [121044] = getCrownPrice(30), -- Plant, Healthy White Hosta
    [121043] = getCrownPrice(30), -- Plant, Summer Hosta
    [121042] = getCrownPrice(10), -- Plant, Young Summer Hosta
    [121041] = getCrownPrice(10), -- Plant, Young Verdant Hosta
    [121040] = getCrownPrice(30), -- Plant, Verdant Hosta
    [121039] = getCrownPrice(30), -- Plant, Blooming White Hosta
    [121038] = getCrownPrice(30), -- Plant, Paired White Hosta
    [121037] = getCrownPrice(30), -- Shrub, Sparse Pink
    [121033] = getCrownPrice(25), -- Sapling, Sparse Laurel
    [121027] = getCrownPrice(45), -- Hedge, Dense Low Arc
    [121019] = getCrownPrice(10), -- Plants, Dense Underbrush
    [121017] = getCrownPrice(10), -- Bush, Dense Forest
    [121002] = getCrownPrice(45), -- Flowers, Violet Prairie
    [121001] = getCrownPrice(45), -- Flowers, Golden Prairie
    [120491] = getCrownPrice(30), -- Fern, Hearty Autumn
    [120486] = getCrownPrice(30), -- Cactus, Stocky Columnar
    [120484] = getCrownPrice(30), -- Cactus, Golden Barrel
    [120482] = getCrownPrice(30), -- Cactus, Golden Bulbs
    [120481] = getCrownPrice(150), -- Tree, Ancient Juniper
    [120475] = getCrownPrice(70), -- Trees, Paired Wax Palms4
    [120473] = getCrownPrice(60), -- Sapling, Thin Palm
    [120472] = getCrownPrice(25), -- Tree, Young Palm
    [120470] = getCrownPrice(25), -- Tree, Leaning Palm
    [120466] = getCrownPrice(5), -- Pebble, Stacked Desert
    [120465] = getCrownPrice(5), -- Stone, Tapered Rough
    [120464] = getCrownPrice(20), -- Rocks, Stacked Cracked
    [120427] = getCrownPrice(1500), -- Target Skeleton, Argonian
    [120426] = getCrownPrice(1500), -- Target Skeleton, Khajiit
    [120420] = getCrownPrice(140), -- Plaque, Bolted Deer Antlers
    [120416] = getCrownPrice(40), -- Common Cloak on a Hook
    [120415] = getCrownPrice(30), -- Breton Tankard, Full
    [120414] = getCrownPrice(30), -- Breton Tankard, Empty
    [120413] = getCrownPrice(30), -- Breton Pitcher, Clay
    [120412] = getCrownPrice(50), -- Noble's Chalice
    [120409] = getCrownPrice(100), -- Argonian Rack, Woven
    [120408] = getCrownPrice(25), -- Argonian Fish in a Basket
    [118663] = getHouseString(1078, 1079), -- Dark Elf Bed of Coals

    [126039] = getScamboxString("dwemer"), -- Statue of masked Clavicus Vile with Barbas
  },

  [src.JUSTICE] = {
    [126481] = zo_strformat("<<1>> <<2>>", stealable_priests, gloriousHome), -- Indoril Incense, Burning
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

    [116512] = stealable_wrothgar, -- Orcish Carpet Blood
  },

  [src.FISHING] = {
    -- fishing
    [118902] = GetString(SI_FURC_CANBEFISHED), -- Coral, Sun
    [118903] = GetString(SI_FURC_CANBEFISHED), -- Coral, Crown
    [118896] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Sandcake
    [118901] = GetString(SI_FURC_CANBEFISHED), -- Sea sponge
    [118338] = GetString(SI_FURC_CANBEFISHED), -- Fish, Bass
    [118339] = GetString(SI_FURC_CANBEFISHED), -- Fish, Salmon
    [118337] = GetString(SI_FURC_CANBEFISHED), -- Fish, Trout
    [120753] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Green Pile
    [120755] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Lush Pile
    [120754] = GetString(SI_FURC_CANBEFISHED), -- Kelp, Small Pile
    [118897] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Pink Scallop
    [118898] = GetString(SI_FURC_CANBEFISHED), -- Seashell, White Scallop
    [118899] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Starfish
    [118900] = GetString(SI_FURC_CANBEFISHED), -- Seashell, Noble Starfish
  },

  [src.DROP] = {
    [121058] = db_sneaky, -- Candles of Silence
    [119936] = db_poison, -- Poisoned Blood
    [119938] = db_poison, -- Light and Shadow
    [119952] = db_equip, -- Sacrificial Heart

    -- Paintings
    [118216] = GetString(SI_FURC_CHESTS), -- Painting of Spring, Sturdy
    [118217] = GetString(SI_FURC_CHESTS), -- Painting of Pasture, Sturdy
    [118218] = GetString(SI_FURC_CHESTS), -- Painting of Creek, Sturdy
    [118219] = GetString(SI_FURC_CHESTS), -- Painting of Lakes, Sturdy
    [118220] = GetString(SI_FURC_CHESTS), -- Painting of Crags, Sturdy
    [118221] = GetString(SI_FURC_CHESTS), -- Painting of Summer, Sturdy
    [118222] = GetString(SI_FURC_CHESTS), -- Painting of Jungle, Sturdy
    [118223] = GetString(SI_FURC_CHESTS), -- Painting of Palms, Sturdy
    [118265] = GetString(SI_FURC_CHESTS), -- Painting of Winter, Bolted
    [118266] = GetString(SI_FURC_CHESTS), -- Painting of Bridge, Bolted
    [118267] = GetString(SI_FURC_CHESTS), -- Painting of Autumn, Bolted
    [118268] = GetString(SI_FURC_CHESTS), -- Painting of Great Ruins, Bolted
  },

  [src.CROWN] = {
    [120607] = getCrownPrice(50), -- Sapling, Lanky Ash
    [120413] = getCrownPrice(30), -- Breton Pitcher, Clay
    [118351] = getCrownPrice(25), -- Box of Peaches
    [118278] = getCrownPrice(140), -- Plaque, Bordered Deer Antlers
    [118126] = getCrownPrice(95), -- Plaque, Standard
    [118121] = getCrownPrice(15), -- Knife, Carving
    [118120] = getCrownPrice(120), -- Minecart, Push
    [118119] = getCrownPrice(120), -- Minecart, Empty
    [118118] = getCrownPrice(100), -- Candles, Lasting
    [118098] = getCrownPrice(10), -- Common Bowl, Serving
    [118096] = getCrownPrice(10), -- Bread, Plain
    [118071] = getCrownPrice(120), -- Simple Red Banner
    [118070] = getCrownPrice(120), -- Simple Purple Banner
    [118069] = getCrownPrice(120), -- Simple Gray Banner
    [118068] = getCrownPrice(120), -- Simple Brown Banner
    [118066] = getCrownPrice(15), -- Steak Dinner
    [118065] = getCrownPrice(45), -- Common Cargo Crate, Dry
    [118064] = getCrownPrice(45), -- Common Barrel, Dry
    [118062] = getCrownPrice(15), -- Chicken Meal, Display
    [118061] = getCrownPrice(15), -- Chicken Dinner, Display
    [118060] = getCrownPrice(20), -- Sack of Grain
    [118059] = getCrownPrice(20), -- Sack of Millet,
    [118058] = getCrownPrice(20), -- Sack of Rice
    [118057] = getCrownPrice(20), -- Sack of Beans
    [118056] = getCrownPrice(15), -- Common Stewpot, Hanging
    [118055] = getCrownPrice(80), -- Common Firepit, Piled
    [118054] = getCrownPrice(80), -- Common Firepit, Outdoor
    [118000] = getCrownPrice(10), -- Garlic String, Display
    [117952] = getCrownPrice(35), -- Rough Torch, Wall
    [115698] = getCrownPrice(1100), -- Khajiit Statue, Guardian
    [115395] = getCrownPrice(40), -- Nord Drinking Horn, Display
    [94098] = getCrownPrice(95), -- Imperial Bed, Single

    [134473] = getScamboxString("fireatro"), -- Tapestry,  Malacath
  },
}
