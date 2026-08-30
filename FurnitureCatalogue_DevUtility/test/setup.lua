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

function Test.ensureDB()
  FurC.EnsureDB(true)
end

Test.ensureDB()

local dataset

--- Build once and return data set
function Test.dataset()
  if dataset then
    return dataset
  end

  Test.ensureDB()
  local db = FurC.DB
  assert(next(db) ~= nil, "FurC.DB is empty, scan did not run")

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

  -- luxItem comes straight from the data file, this one is also guaranteed to be in the DB
  for _, versionData in pairs(FurC.LuxuryFurnisher) do
    for itemId in pairs(versionData) do
      if db[itemId] then
        DS.luxItemInDB = itemId
        break
      end
    end
    if DS.luxItemInDB then
      break
    end
  end

  local rolisVer, rolisItems = firstPopulatedVersion(FurC.Rolis)
  DS.rolisVersion, DS.rolisItem = rolisVer, rolisItems and next(rolisItems)

  dataset = DS
  return DS
end

--- itemlink for integer id in expected FurC format
function Test.link(id)
  assert(type(id) == "number", "Test.link needs an item id, got " .. tostring(id))
  return string.format("|H1:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", id)
end

--- Count FurC.DB to check if scan ran at all
function Test.dbSize()
  return count(FurC.DB)
end

function Test.keySet(tbl)
  local set = {}
  for key in pairs(tbl) do
    set[key] = true
  end
  return set
end

function Test.nameSet(names)
  local set = {}
  for i = 1, #names do
    set[names[i]] = true
  end
  return set
end
