FurCEx = {}

local this = FurCEx

this.name = "FurnitureCatalogue_Export"
this.version = 2000000
this.author = "manavortex"

local defaults = {}
local src = FurC.Constants.ItemSources

local function getSortTable(tbl)
  local list = {}
  for name, _ in pairs(tbl) do
    list[#list + 1] = name
  end
  table.sort(list)
  return list
end

function this.Export()
  local itemNames = {}
  for itemId, recipeArray in pairs(FurC.settings.data) do
    if recipeArray.origin == src.CRAFTING then
      itemNames[GetItemLinkName(FurC.Utils.GetItemLink(itemId))] = FurC.Utils.GetItemLink(itemId)
    end
  end

  local tkeys = getSortTable(itemNames)
  local exportKnown = {}
  local exportUnknown = {}
  for _, itemName in pairs(tkeys) do
    local itemLink = itemNames[itemName]
    local recipeArray = FurC.Find(itemLink)
    local known = FurC.IsAccountKnown(itemLink, recipeArray)

    local exportArray = (known and exportKnown) or exportUnknown
    local mats = FurC.GetMats(itemLink, recipeArray, false, true)
    local knowledge = (known and (FurC.GetCrafterList(itemLink, recipeArray) .. ": "):gsub("Can be crafted by ", ""))
      or ""
    local exportString = zo_strformat("<<1>><<2>>", knowledge, mats)
    exportArray[itemName] = exportString
  end

  this.settings.known = exportKnown
  this.settings.unknown = exportUnknown
  ReloadUI("ingame")
end

SLASH_COMMANDS["/furcexport"] = function()
  this.Export()
end

-- initialization stuff
local function init(_, addOnName)
  if addOnName ~= this.name then
    return
  end

  this.settings = ZO_SavedVars:NewAccountWide(this.name, nil, nil, defaults)
  this.makeSettings()
  EVENT_MANAGER:UnregisterForEvent(this.name, EVENT_ADD_ON_LOADED)
end

EVENT_MANAGER:RegisterForEvent(this.name, EVENT_ADD_ON_LOADED, init)
