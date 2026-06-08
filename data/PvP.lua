FurC.PVP = FurC.PVP or {}

local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local ver = FurC.Constants.Versioning

-- TODO: add missing, npc.HGF has nothing unique

FurC.PVP[ver.BASE44] = {
  [npc.COLL_MERCH] = {
    [loc.IMPCITY] = {
      [211572] = { -- Imperial Tent, Large
        itemPrice = 18000,
        currency = CURT_TELVAR_STONES,
      },
      [211573] = { -- Imperial Tent, Meeting
        itemPrice = 16000,
        currency = CURT_TELVAR_STONES,
      },
      [211574] = { -- Imperial Dais, Raised
        itemPrice = 9500,
        currency = CURT_TELVAR_STONES,
      },
      [211575] = { -- Daedric Chest, Molag Bal
        itemPrice = 7500,
        currency = CURT_TELVAR_STONES,
      },
      [211576] = { -- Imperial Chest, Reinforced
        itemPrice = 500,
        currency = CURT_TELVAR_STONES,
      },
      [211577] = { -- Imperial Pedestal, Siege
        itemPrice = 4000,
        currency = CURT_TELVAR_STONES,
      },
      [211578] = { -- Imperial Archway, Stone
        itemPrice = 250,
        currency = CURT_TELVAR_STONES,
      },
      [211579] = { -- Imperial Door, Diamond
        itemPrice = 7500,
        currency = CURT_TELVAR_STONES,
      },
      [211580] = { -- Imperial Firepit, Round
        itemPrice = 4000,
        currency = CURT_TELVAR_STONES,
      },
    },
  },
}

-- Scalebreaker
FurC.PVP[ver.SCALES] = {
  [npc.AF] = {
    [loc.CYRO] = {
      [153751] = { -- Volendrung Replica
        itemPrice = 2000000,
        -- TODO #DBOVERHAUL : allow for list of achievements if this happens often
        achievement = 2510, -- need either Volendrung Wielder (2510) and Volundrung Vanquisher (2511)
      },
    },
  },
}

-- 2 Homestead
FurC.PVP[ver.HOMESTEAD] = {
  [npc.AF] = {
    [loc.CYRO] = {
      [120079] = { -- Disconnected Transitus shrine
        itemPrice = 100000,
        achievement = 114, -- Overlord
      },
      [119678] = { -- Covenant Keep Pennant
        itemPrice = 8000,
        achievement = 113, -- Grand War lord
      },
      [119632] = { -- Dominion Keep Pennant
        itemPrice = 8000,
        achievement = 113, -- Grand War lord
      },
      [120075] = { -- Decoy Elder Scroll
        itemPrice = 200000,
        achievement = 705, -- Grand Overlord
      },
      [120038] = { -- Throne of Cyrodiil
        itemPrice = 250000,
        achievement = 935, -- Emperor!
      },
      [120002] = { -- Dueling Banner
        itemPrice = 20000,
        achievement = 1689, -- Master Duelist
      },
      [119675] = { -- Defaced Covenant Flag
        itemPrice = 2000,
        achievement = 110, -- Legate
      },
      [119652] = { -- Defaced Pact Flag
        itemPrice = 2000,
        achievement = 110, -- Legate
      },
      [119656] = { -- Pact Pennant, Small
        itemPrice = 200,
        achievement = 92, -- Volunteer
      },
      [119633] = { -- Dominion Pennant, Small
        itemPrice = 200,
        achievement = 92, -- Volunteer
      },
      [119679] = { -- Covenant Pennant, Small
        itemPrice = 200,
        achievement = 92, -- Volunteer
      },
      [119655] = { -- Pact Keep Pennant
        itemPrice = 8000,
        achievement = 113, -- Grand Warlord
      },
      [119654] = { -- Pact Cold Fire
        itemPrice = 50000,
        achievement = 112, -- Warlord
      },
      [119631] = { -- Surplus Dominion Cold Fire Trebuchet
        itemPrice = 50000,
        achievement = 112, -- Warlord
      },
      [119677] = { -- Surplus Covenant Cold Fire Trebuchet
        itemPrice = 50000,
        achievement = 112, -- Warlord
      },
      [119653] = { -- Pact Cold fire ballista
        itemPrice = 30000,
        achievement = 111, -- General
      },
      [119630] = { -- Surplus Dominion Cold Fire Ballista
        itemPrice = 30000,
        achievement = 111, -- General
      },
      [119676] = { -- Surplus Covenant Cold Fire Ballista
        itemPrice = 30000,
        achievement = 111, -- General
      },
      [119651] = { -- Pact Iceball Treb
        itemPrice = 50000,
        achievement = 109, -- August Palatine
      },
      [119628] = { -- Surplus Dominion Iceball Trebuchet
        itemPrice = 50000,
        achievement = 109, -- August Palatine
      },
      [119674] = { -- Surplus Covenant Iceball Trebuchet
        itemPrice = 50000,
        achievement = 109, -- August Palatine
      },
      [119650] = { -- Surplus Pact Meatbag Catapult
        itemPrice = 30000,
        achievement = 108, -- Palatine
      },
      [119673] = { -- Surplus Covenant Meatbag Catapult
        itemPrice = 30000,
        achievement = 108, -- Palatine
      },
      [119649] = { -- Pact Lightning Ballista
        itemPrice = 30000,
        achievement = 107, -- Praetorian
      },
      [119626] = { -- Surplus Dominion Lightning Ballista
        itemPrice = 30000,
        achievement = 107, -- Praetorian
      },
      [119672] = { -- Surplus Covenant Lightning Ballista
        itemPrice = 30000,
        achievement = 107, -- Praetorian
      },
      [119648] = { -- Pact Forward Camp
        itemPrice = 50000,
        achievement = 106, -- Prefect
      },
      [119625] = { -- Surplus Dominion Forward Camp
        itemPrice = 50000,
        achievement = 106, -- Prefect
      },
      [119671] = { -- Surplus Covenant Forward Camp
        itemPrice = 50000,
        achievement = 106, -- Prefect
      },
      [119647] = { -- Pact Fire Treb
        itemPrice = 45000,
        achievement = 105, -- Brigadier
      },
      [119624] = { -- Surplus Dominion Firepot Trebuchet
        itemPrice = 45000,
        achievement = 105, -- Brigadier
      },
      [119670] = { -- Surplus Covenant Firepot Trebuchet
        itemPrice = 45000,
        achievement = 105, -- Brigadier
      },
      [119646] = { -- Surplus Pact Oil Catapult
        itemPrice = 25000,
        achievement = 104, -- Tribune
      },
      [119645] = { -- Pact Fire Ballista
        itemPrice = 30000,
        achievement = 103, -- Colonel
      },
      [119622] = { -- Surplus Dominion Fire Ballista
        itemPrice = 30000,
        achievement = 103, -- Colonel
      },
      [119668] = { -- Surplus Covenant Fire Ballista
        itemPrice = 30000,
        achievement = 103, -- Colonel
      },
      [119644] = { -- Pact Battering ram
        itemPrice = 25000,
        achievement = 102, -- Centurion
      },
      [119621] = { -- Surplus Dominion Battering Ram
        itemPrice = 25000,
        achievement = 102, -- Centurion
      },
      [119667] = { -- Surplus Covenant Battering Ram
        itemPrice = 25000,
        achievement = 102, -- Centurion
      },
      [119643] = { -- Pact Stone Trebuchet
        itemPrice = 40000,
        achievement = 101, -- Major
      },
      [119627] = { -- Surplus Dominion Meatbag Catapult
        itemPrice = 30000,
        achievement = 108, -- Palatine
      },
      [119642] = { -- Pact Scattershot Catapult
        itemPrice = 15000,
        achievement = 100, -- Captain
      },
      [119619] = { -- Surplus Dominion Scattershot Catapult
        itemPrice = 15000,
        achievement = 100, -- Captain
      },
      [119665] = { -- Surplus Covenant Scattershot Catapult
        itemPrice = 15000,
        achievement = 100, -- Captain
      },
      [119641] = { -- Pact Ballista
        itemPrice = 20000,
        achievement = 99, -- Lieutenant
      },
      [119618] = { -- Surplus Dominion Ballista
        itemPrice = 20000,
        achievement = 99, -- Lieutenant
      },
      [119664] = { -- Surplus Covenant Ballista
        itemPrice = 20000,
        achievement = 99, -- Lieutenant
      },
      [119639] = { -- Pact Spare figurehead
        itemPrice = 5000,
        achievement = 98, -- Sergeant
      },
      [119616] = { -- Spare Dominion Ballista Figurehead
        itemPrice = 5000,
        achievement = 98, -- Sergeant
      },
      [119662] = { -- Spare Covenant Ballista Figurehead
        itemPrice = 5000,
        achievement = 98, -- Sergeant
      },
      [119638] = { -- Pact Point Capture Flag
        itemPrice = 4000,
        achievement = 97, -- Corporal
      },
      [119615] = { -- Surplus Dominion Point Capture Flag
        itemPrice = 4000,
        achievement = 97, -- Corporal
      },
      [119661] = { -- Surplus Covenant Point Capture Flag
        itemPrice = 4000,
        achievement = 97, -- Corporal
      },
      [119637] = { -- Pact Wall Banner, Large
        itemPrice = 3000,
        achievement = 96, -- Veteran
      },
      [119614] = { -- Dominion Wall Banner, Large
        itemPrice = 3000,
        achievement = 96, -- Veteran
      },
      [119660] = { -- Covenant Wall Banner, Large
        itemPrice = 3000,
        achievement = 96, -- Veteran
      },
      [119636] = { -- Pact Camp Banner
        itemPrice = 1000,
        achievement = 95, -- Legionary
      },
      [119613] = { -- Dominion Camp Banner
        itemPrice = 1000,
        achievement = 95, -- Legionary
      },
      [119659] = { -- Covenant Camp Banner
        itemPrice = 1000,
        achievement = 95, -- Legionary
      },
      [119635] = { -- Pact Wall Banner, Medium
        itemPrice = 600,
        achievement = 94, -- Tyro
      },
      [119634] = { -- Pact Wall Banner, Small
        itemPrice = 400,
        achievement = 93, -- Recruit
      },
      [119629] = { -- Defaced Dominion Flag
        itemPrice = 2000,
        achievement = 110, -- Legate
      },
      [119617] = { -- Surplus Flaming Oil
        itemPrice = 10000,
        achievement = 706, -- First Sergeant
      },
      [119611] = { -- Dominion Wall Banner, Small
        itemPrice = 400,
        achievement = 93, -- Recruit
      },
      [119657] = { -- Covenant Wall Banner, Small
        itemPrice = 400,
        achievement = 93, -- Recruit
      },
      [119612] = { -- Dominion Wall Banner, Medium
        itemPrice = 600,
        achievement = 94, -- Tyro
      },
      [119658] = { -- Covenant Wall Banner, Medium
        itemPrice = 600,
        achievement = 94, -- Tyro
      },
      [119620] = { -- Surplus Dominion Stone Trebuchet
        itemPrice = 40000,
        achievement = 101, -- Major
      },
      [119666] = { -- Surplus Covenant Stone Trebuchet
        itemPrice = 40000,
        achievement = 101, -- Major
      },
      [119623] = { -- Surplus Dominion Oil Catapult
        itemPrice = 25000,
        achievement = 104, -- Tribune
      },
      [119669] = { -- Surplus Covenant Oil Catapult
        itemPrice = 25000,
        achievement = 104, -- Tribune
      },
    },
  },

  [npc.COLL_MERCH] = {
    [loc.IMPCITY] = {
      [119983] = { -- Imperial Banner
        itemPrice = 15000,
        currency = CURT_TELVAR_STONES,
        achievement = 1169, -- all POI in sewers
      },
      [119982] = { -- Molag Bal Brazier
        itemPrice = 25000,
        currency = CURT_TELVAR_STONES,
        achievement = 1175, -- Molag Bal Achievement
      },
    },
  },
}
