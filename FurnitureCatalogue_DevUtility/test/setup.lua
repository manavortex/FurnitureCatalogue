-- Shared test helper with some example data

if not Taneth then
  return
end

local Test = {}
FurCDev.Test = Test

-- Seed missing FurC.settings (because it might be empty in headless)
if not FurC.settings then
  FurC.settings = {}
end

FurC.settings.version = FurC.settings.version or 0
FurC.settings.emptyItemSources = FurC.settings.emptyItemSources or {}
FurC.CharacterName = FurC.CharacterName or "Eats-Your-Bugs"

local function count(t)
  return NonContiguousCount(t or {})
end

-- version table as: version, itemsTable
local function firstPopulatedVersion(versioned)
  for ver, items in pairs(versioned or {}) do
    if count(items) > 0 then
      return ver, items
    end
  end
end

local dataset

--- Build once and return data set
--- (if headless it builds, in-game addon already does it)
function Test.dataset()
  if dataset then
    return dataset
  end

  FurC.EnsureDB()
  local db = FurC.DB

  local DS = {}
  for id in pairs(db or {}) do
    if type(id) == "number" and id > 9999 then
      DS.dbItem = id
      break
    end
  end

  for id, arr in pairs(db or {}) do
    if type(arr) == "table" and arr.origin == FURC_CRAFTING and arr.blueprint then
      DS.craftable = id
      break
    end
  end

  local luxVer, luxItems = firstPopulatedVersion(FurC.LuxuryFurnisher)
  DS.luxVersion, DS.luxItem = luxVer, luxItems and next(luxItems)

  local rolisVer, rolisItems = firstPopulatedVersion(FurC.Rolis)
  DS.rolisVersion, DS.rolisItem = rolisVer, rolisItems and next(rolisItems)

  dataset = DS
  return DS
end

--- itemlink for integer id in expected FurC format
function Test.link(id)
  return string.format("|H1:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", id)
end

--- Count FurC.DB to check if scan ran at all
function Test.dbSize()
  return count(FurC.DB)
end
