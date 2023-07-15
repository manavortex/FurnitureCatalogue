FurnitureCatalogue_Export = {}
FurCExport = FurnitureCatalogue_Export
local defaults = {}

local function getSortTable(tbl)
  local list = {}
  for name, _ in pairs(tbl) do
    list[#list + 1] = name
  end
  table.sort(list)
  return list
end

function FurCExport.Export()
  local itemNames = {}
  for itemId, recipeArray in pairs(FurC.settings.data) do
    if recipeArray.origin == FURC_CRAFTING then
      itemNames[GetItemLinkName(FurC.GetItemLink(itemId))] = FurC.GetItemLink(itemId)
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

  FurCExport.settings.known = exportKnown
  FurCExport.settings.unknown = exportUnknown
  ReloadUI("ingame")
end

SLASH_COMMANDS["/furcexport"] = function()
  FurCExport.Export()
end

-- initialization stuff
function FurCExport_Initialize(_, addOnName)
  if addOnName ~= "FurnitureCatalogue_Export" then
    return
  end

  FurCExport.settings = ZO_SavedVars:NewAccountWide("FurnitureCatalogue_Export", nil, nil, defaults)
  FurCExport.makeSettings()
  EVENT_MANAGER:UnregisterForEvent("FurnitureCatalogue_Export", EVENT_ADD_ON_LOADED)
end

EVENT_MANAGER:RegisterForEvent("FurnitureCatalogue_Export", EVENT_ADD_ON_LOADED, FurCExport_Initialize)
