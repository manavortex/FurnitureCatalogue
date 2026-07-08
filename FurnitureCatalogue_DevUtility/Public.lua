-- FurCDev public API

local this = FurCDev
local internal = FurCDev.Internal

local function getAchievementId(achievementName)
  if not achievementName or achievementName == "" then
    return 0
  end

  if {} == this.Achievements then
    internal.BuildAchievementTable()
  end

  -- making sure achievement name is the same like in the lookup table
  achievementName = LocaleAwareToLower(zo_strformat(achievementName))
  for id, name in pairs(this.Achievements) do
    if name == achievementName then
      return id
    end
  end

  return 0
end
this.GetAchievementId = getAchievementId

---@param achievementName string part of the achievement name
---@return table results list of achievements that match the given name
local function findAchievement(achievementName)
  local results = {}
  if not achievementName or achievementName == "" then
    return results
  end

  if #this.Achievements < 1 then
    internal.BuildAchievementTable()
  end

  achievementName = LocaleAwareToLower(zo_strformat(achievementName))
  for id, name in pairs(this.Achievements) do
    if string.find(name, achievementName) then
      table.insert(results, zo_strformat("<<1>>: <<2>>", id, name))
    end
  end
  return results
end
this.FindAchievement = findAchievement

---@param questName string part of the quest name
---@return table results list of quests that match the given name
local function findQuest(questName)
  local results = {}
  if not questName or questName == "" then
    return results
  end

  if NonContiguousCount(this.Quests) < 1 then
    FurC.Logger:Debug("Have to build quest table, search again")
    internal.BuildQuestTable()
    return results
  end

  questName = LocaleAwareToLower(zo_strformat(questName))
  for id, name in pairs(this.Quests) do
    if string.find(LocaleAwareToLower(name), questName) then
      results[id] = name
    end
  end
  return results
end
this.FindQuest = findQuest

---@param zoneName string part of the zone name
---@return table results list of zones that match the given name (unformatted)
local function findZone(zoneName)
  local results = {}
  if not zoneName or zoneName == "" then
    return results
  end

  if NonContiguousCount(this.Zones) < 1 then
    FurC.Logger:Debug("Have to build zone table, search again when it's done")
    internal.BuildZoneTable()
    return results
  end

  zoneName = LocaleAwareToLower(zo_strformat(zoneName))
  for id, name in pairs(this.Zones) do
    if string.find(LocaleAwareToLower(name), zoneName) then
      results[id] = name
    end
  end
  return results
end
this.FindZone = findZone
