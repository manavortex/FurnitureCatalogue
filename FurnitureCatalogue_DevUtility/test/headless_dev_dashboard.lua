-- Run from the addon root with ESOLua
FurCDev = {}
FurC = { Logger = { Debug = function() end } }
LibFurnitureCatalogue = { Internal = {} }
local formatCalls = 0

local rendered = {
  ["élan^m"] = "Élan",
  ["höhle^f"] = "Höhle",
  ["дом^m"] = "Дом",
  ["森^n"] = "森",
}
function zo_strformat(template, raw, second)
  if template == "<<1>>: <<2>>" then
    return tostring(raw) .. ": " .. second
  end
  assert(template == "<<C:1>>", "every search name must use capitalising game formatting")
  assert(not raw:find("|", 1, true), "strip display markup before formatting")
  formatCalls = formatCalls + 1
  return rendered[raw] or raw
end
function NonContiguousCount(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end
function GetNumZones()
  return 1
end
function GetNumAchievementCategories()
  return 1
end
function GetAchievementCategoryInfo()
  return "category", 0, 1
end
function GetAchievementId()
  return 11
end
function GetAchievementInfo()
  return "|c00ff00élan^m|r"
end
function GetQuestName(id)
  return id == 12 and "höhle^f" or ""
end
function GetTotalCollectiblesByCategoryType()
  return 1
end
function GetCollectibleIdFromType()
  return 13
end
function GetCollectibleName()
  return "дом^m"
end
function GetCollectibleReferenceId()
  return 23
end
function GetHouseZoneId()
  return 1
end
function GetZoneNameById(id)
  return id == 1 and "森^n" or ""
end
dofile("../LFC/LibFurnitureCatalogue/Format.lua")
dofile("FurnitureCatalogue_DevUtility/Internal.lua")
FurCDev.Internal.BuildAchievementTable()
FurCDev.Internal.BuildQuestTable()
FurCDev.Internal.BuildHouseTable()
FurCDev.Internal.BuildZoneTable()
assert(FurCDev.Achievements[11] == "Élan")
assert(FurCDev.Quests[12] == "Höhle")
assert(FurCDev.Houses[13] == "Дом")
assert(FurCDev.Zones[1] == "森" and FurCDev.HouseMeta[13].zone == "森")
assert(FurCDev.Internal.FormatName("one\ntwo\tthree") == "one two three")
assert(formatCalls >= 5)

function LocaleAwareToLower(value)
  return (
    value:gsub("É", "é"):gsub("Д", "д"):gsub("Ö", "ö"):gsub("[A-Z]", function(c)
      return string.char(string.byte(c) + 32)
    end)
  )
end
dofile("FurnitureCatalogue_DevUtility/Public.lua")
assert(FurCDev.GetAchievementId("élan^m") == 11, "formatted names must still resolve from vendor requirements")
assert(FurCDev.GetAchievementId("ÉLAN") == 11)
assert(FurCDev.FindAchievement("é")[1] == "11: Élan")
assert(FurCDev.FindQuest("HÖHLE")[12] == "Höhle")
assert(FurCDev.FindZone("森")[1] == "森")
assert(next(FurCDev.FindAchievement("%")) == nil, "queries are literal text, not Lua patterns")

local header, readyCallback
local currentState, count = "building", 0
local callbacks = {}
LibFurnitureCatalogue.API = {
  Events = { SCAN_STARTED = "start", SCAN_COMPLETE = "complete", SCAN_FAILED = "failed" },
  IsReady = function()
    return currentState == "ready"
  end,
  GetState = function()
    return currentState
  end,
  GetEntryCount = function()
    assert(currentState == "ready", "do not report a partial build as a complete count")
    return count
  end,
  RegisterCallback = function(event, callback)
    callbacks[event] = callback
  end,
  OnReady = function(callback)
    readyCallback = callback
  end,
}
FurCDevControl_Header = {
  SetText = function(_, text)
    header = text
  end,
}
function GetAPIVersion()
  return 101051
end
function GetCVar()
  return "en"
end
dofile("FurnitureCatalogue_DevUtility/GUI.lua")
FurCDev.InitHeader()
assert(header:find("Catalogue: building", 1, true))
assert(not header:find("0 items", 1, true) and not header:find("no scan yet", 1, true))
currentState, count = "ready", 8537
readyCallback()
assert(header:find("8537 items", 1, true))
currentState = "building"
callbacks.start()
assert(header:find("Catalogue: building", 1, true))
currentState, count = "ready", 8538
callbacks.complete()
assert(header:find("8538 items", 1, true))
currentState = "failed"
callbacks.failed()
assert(header:find("Catalogue: failed", 1, true))
FurCDev.SetScanSummary("Scanning IDs: 250 / 1000")
assert(header:find("Scanning IDs: 250 / 1000", 1, true))
print("Dashboard checks passed: formatted names and lifecycle-driven header.")
