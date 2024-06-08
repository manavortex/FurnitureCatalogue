FurC.PVP = FurC.PVP or {}

local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local ver = FurC.Constants.Versioning

-- TODO: add missing, npc.HGF has nothing unique

-- 16 Stonethorn
FurC.PVP[ver.STONET] = {
  [npc.AF] = {
    [loc.CYRO] = {
      [119678] = { -- Covenant Keep Pennant
        itemPrice = 8000,
        achievement = 113,
      },
    },
  },
}

-- 11 Elsweyr
FurC.PVP[ver.KITTY] = {
  [npc.AF] = {
    [loc.CYRO] = {
      [153751] = { -- Volendrung Replica
        itemPrice = 2000000,
        -- TODO #DBOVERHAUL : allow for list of achievements if this happens often
        achievement = 2510, -- Volendrung Wielder (2510) and Volundrung Vanquisher (2511)
      },
    },
  },
}

-- 2 Homestead
FurC.PVP[ver.HOMESTEAD] = {
  [npc.AF] = {
    [loc.CYRO] = {
      [120079] = { -- Transitus shrine
        itemPrice = 100000,
        achievement = 114,
      },
      [120075] = { -- Elder Scroll
        itemPrice = 200000,
        achievement = 935,
      },
      [120038] = { -- Throne
        itemPrice = 250000,
        achievement = 935,
      },
      [120002] = { -- Dueling Banner
        itemPrice = 20000,
        achievement = 1689,
      },
      [119675] = { -- Defaced Covenant Flag
        itemPrice = 2000,
        achievement = 110,
      },
      [119656] = { -- Pact Pennant, Small
        itemPrice = 200,
        achievement = 92, -- Volunteer
      },
      [119655] = { -- Keep Pennant
        itemPrice = 8000,
        achievement = 113, -- Grand Warlord
      },
      [119654] = { -- Cold Fire
        itemPrice = 50000,
        achievement = 112,
      },
      [119653] = { -- Cold fire ballista
        itemPrice = 30000,
        achievement = 111,
      },
      [119651] = { -- Iceball Treb
        itemPrice = 50000,
        achievement = 109,
      },
      [119650] = { -- Meatbag Catapult
        itemPrice = 30000,
        achievement = 107,
      },
      [119649] = { -- Lightning Ballista
        itemPrice = 30000,
        achievement = 107,
      },
      [119648] = { -- Forward Camp
        itemPrice = 50000,
        achievement = 106,
      },
      [119647] = { -- Fire
        itemPrice = 45000,
        achievement = 105,
      },
      [119646] = { -- Oil Catapult
        itemPrice = 25000,
        achievement = 104,
      },
      [119645] = { -- Fire Ballista
        itemPrice = 30000,
        achievement = 103, -- Colonel
      },
      [119644] = { -- Battering ram
        itemPrice = 25000,
        achievement = 102,
      },
      [119643] = { -- Stone Trebuchet
        itemPrice = 40000,
        achievement = 108,
      },
      [119642] = { -- Scattershot Catapult
        itemPrice = 15000,
        achievement = 100, -- Captain
      },
      [119641] = { -- Ballista
        itemPrice = 20000,
        achievement = 99,
      },
      [119639] = { -- Spare figurehead
        itemPrice = 5000,
        achievement = 98, -- Sergeant
      },
      [119638] = { -- Point Capture Flag
        itemPrice = 4000,
        achievement = 97, -- Corporal
      },
      [119637] = { -- Wall Banner, Large
        itemPrice = 3000,
        achievement = 96, -- Veteran
      },
      [119636] = { -- Camp Banner
        itemPrice = 1000,
        achievement = 95, -- Legionary
      },
      [119635] = { -- Wall Banner, Medium
        itemPrice = 600,
        achievement = 94, -- Tyro
      },
      [119634] = { -- Pact Wall Banner, Small
        itemPrice = 400,
        achievement = 93, -- Recruit
      },
      [119629] = { -- Defaced Dominion Flag
        itemPrice = 2000,
        achievement = 110,
      },
      [119617] = { -- Flaming Oil
        itemPrice = 10000,
        achievement = 104, -- Tribune
      },
    },
    [loc.IMPCITY] = {
      [119983] = { -- Imperial Banner
        itemPrice = 15000,
        achievement = 1169, -- all POI in sewers, TODO: check if correct
      },
      [119982] = { -- Molag Bal Brazier
        itemPrice = 25000,
        achievement = 1175, -- Molag Bal Achievement TODO: check if correct
      },
    },
  },
}
