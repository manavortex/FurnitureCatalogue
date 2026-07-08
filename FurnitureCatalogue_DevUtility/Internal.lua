-- FurCDev.Internal (achievements, quests, zones)

local this = FurCDev
FurCDev.Internal = FurCDev.Internal or {}
local internal = FurCDev.Internal

local achievementTable = {}
local questTable = {}
local zoneTable = {}

this.Achievements = achievementTable
this.Quests = questTable
this.Zones = zoneTable

local function addAchievement(id)
  if not id or id == 0 then
    return
  end
  local achieveName = GetAchievementInfo(id)
  if achieveName ~= "" then
    -- Save gendered and lowercased achievement name
    achievementTable[id] = LocaleAwareToLower(zo_strformat(achieveName))
  end
end

-- Use achievement category tree
-- MAX_ACHIEVEMENTS and guessing ID range was not enough anymore
local function buildAchievementTable()
  for ci = 1, GetNumAchievementCategories() do
    local _, numSubCategories, numAchievements = GetAchievementCategoryInfo(ci)
    for ai = 1, (numAchievements or 0) do
      addAchievement(GetAchievementId(ci, nil, ai))
    end
    for si = 1, (numSubCategories or 0) do
      local _, subNumAchievements = GetAchievementSubCategoryInfo(ci, si)
      for ai = 1, (subNumAchievements or 0) do
        addAchievement(GetAchievementId(ci, si, ai))
      end
    end
  end
end
internal.BuildAchievementTable = buildAchievementTable

local function buildQuestTable()
  local MAX_QUESTS = 10000
  for id = 1, MAX_QUESTS do
    local questName = GetQuestName(id)
    if questName ~= "" then
      questTable[id] = questName
    end
  end
end
internal.BuildQuestTable = buildQuestTable

local NUM_ZONES = GetNumZones() -- 1096 as of version 101050
local MAX_INDEX = NUM_ZONES * 100 -- don't iterate higher than that, man
local STEP_SIZE = NUM_ZONES -- "What are you doing, step size?"
local zoneLock = false
local function buildZoneTable(iFrom)
  if zoneLock then
    return
  end
  zoneLock = true -- protect from call conflicts
  iFrom = iFrom or 1
  local iTo = iFrom + STEP_SIZE - 1

  FurC.Logger:Debug("Building Zone Table: %d/%d [%5d...%5d]", NonContiguousCount(this.Zones), NUM_ZONES, iFrom, iTo)
  for id = iFrom, iTo do
    -- do NOT use `GetZoneNameByIndex` as it's a contiguous version of *ById, means the indices change
    local zoneName = GetZoneNameById(id)
    if zoneName ~= "" then
      zoneTable[id] = zoneName
    end
    iFrom = id
  end

  -- If we haven't found all zones yet, slowly iterate through the rest
  if NonContiguousCount(this.Zones) < NUM_ZONES and iFrom <= MAX_INDEX then
    zo_callLater(function()
      zoneLock = false
      buildZoneTable(iFrom + 1)
    end, 2000)
  else
    FurC.Logger:Debug("Zones table done: %d/%d [%d]", NonContiguousCount(this.Zones), NUM_ZONES, iFrom)
    zoneLock = false
  end
end
internal.BuildZoneTable = buildZoneTable
