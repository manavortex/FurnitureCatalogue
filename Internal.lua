-- FurC.Internal helper namespace: non-DB runtime utils.
-- Not an API, could change at any time.

FurC = FurC or {}
FurC.Internal = FurC.Internal or {}
local this = FurC.Internal
local LFC = LibFurnitureCatalogue

--[[_______________________
    |                     |
    |    RUNTIME UTILS    |
    |_____________________|]]

local Utils = this
local sFormat = zo_strformat

-- ruthlessly stolen from TextureIt
--- Sorts table by given key
--- @return table sortedTable
function Utils.SortTable(tTable, sortKey, SortOrderUp)
  --[[
    TODO #REFACTOR:
      - expect function instead of boolean "SortOrderUp"
      - ZO_TableOrderingFunction
      - make generic, not itemlink dependant
  ]]

  local keys = {}
  for k in pairs(tTable) do
    table.insert(keys, k)
  end
  table.sort(keys, function(a, b)
    if nil == tTable[a] or nil == tTable[b] then
    elseif nil == tTable[a][sortKey] then
      return false
    elseif nil == tTable[b][sortKey] then
      return true
    else
      if SortOrderUp then
        return tTable[a][sortKey] > tTable[b][sortKey]
      else
        return tTable[a][sortKey] < tTable[b][sortKey]
      end
    end
    return tTable
  end)

  local ret = {}
  local scannedLinks = {}
  for _, k in ipairs(keys) do
    local entry = tTable[k]
    local itemLink = entry["itemLink"]
    local ingredients = entry["ingredients"]
    local index = scannedLinks[itemLink] or k

    table.insert(ret, entry)
  end

  return ret
end

local currentChar
---Get the current character name in desired format
---@return string
function Utils.GetCurrentChar()
  currentChar = currentChar or sFormat("<<1>>", GetUnitName("player"))
  return currentChar
end

---Check if item is a furnishing
---@param itemLink string
---@return boolean isFurniture
function Utils.IsFurniture(itemLink)
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)
  return isRecipe or IsItemLinkPlaceableFurniture(itemLink)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param itemLink string
---@return string blueprintLink or empty string
function Utils.GetBlueprintForItem(itemLink)
  if IsItemLinkFurnitureRecipe(itemLink) then
    return itemLink
  end
  local entry = FurC.DB[GetItemLinkItemId(itemLink)]
  if not entry or not entry.blueprint then
    return ""
  end
  return LFC.Internal.Format.GetItemLink(entry.blueprint)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param blueprintLink string
---@return string itemLink or empty string
function Utils.GetItemFromBlueprint(blueprintLink)
  if IsItemLinkPlaceableFurniture(blueprintLink) then
    return blueprintLink
  end
  return GetItemLinkRecipeResultItemLink(blueprintLink)
end

---@deprecated will be replaced by API function in the future
---@see FurC.Internal.GetItemId
this.GetItemId = LFC.Internal.Format.GetItemId

-- Legacy alias
FurC.Utils = FurC.Utils or {}
FurC.Utils.SortTable = this.SortTable
FurC.Utils.GetCurrentChar = this.GetCurrentChar
FurC.Utils.IsFurniture = this.IsFurniture
FurC.Utils.GetBlueprintForItem = this.GetBlueprintForItem
FurC.Utils.GetItemFromBlueprint = this.GetItemFromBlueprint
FurC.Utils.GetItemId = this.GetItemId
