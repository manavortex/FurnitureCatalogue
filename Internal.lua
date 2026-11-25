-- FurC.Internal helper namespace: non-DB runtime utils.
-- Not an API, could change at any time.

FurC = FurC or {}
FurC.Internal = FurC.Internal or {}
local this = FurC.Internal
local LFC = LibFurnitureCatalogue
local getItemLink = LFC.API.GetItemLink

--[[_______________________
    |                     |
    |    RUNTIME UTILS    |
    |_____________________|]]

local sFormat = zo_strformat

local currentChar
---Get the current character name in desired format
---@return string
function this.GetCurrentChar()
  currentChar = currentChar or sFormat("<<1>>", GetUnitName("player"))
  return currentChar
end

---Check if item is a furnishing
---@param itemLink string
---@return boolean isFurniture
function this.IsFurniture(itemLink)
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)
  return isRecipe or IsItemLinkPlaceableFurniture(itemLink)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param itemLink string
---@return string blueprintLink or empty string
function this.GetBlueprintForItem(itemLink)
  if IsItemLinkFurnitureRecipe(itemLink) then
    return itemLink
  end
  local entry = FurC.DB[GetItemLinkItemId(itemLink)]
  if not entry or not entry.blueprint then
    return ""
  end
  return getItemLink(entry.blueprint)
end

---Example: FurC.Utils.GetBlueprintForItem("|H1:item:166781:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h") -> "|H1:item:165634:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
---@param blueprintLink string
---@return string itemLink or empty string
function this.GetItemFromBlueprint(blueprintLink)
  if IsItemLinkPlaceableFurniture(blueprintLink) then
    return blueprintLink
  end
  return GetItemLinkRecipeResultItemLink(blueprintLink)
end

---@deprecated use LibFurnitureCatalogue.API.GetItemId
---@see FurC.Internal.GetItemId
this.GetItemId = LFC.API.GetItemId

-- Legacy alias
FurC.Utils = FurC.Utils or {}
FurC.Utils.GetCurrentChar = this.GetCurrentChar
FurC.Utils.IsFurniture = this.IsFurniture
FurC.Utils.GetBlueprintForItem = this.GetBlueprintForItem
FurC.Utils.GetItemFromBlueprint = this.GetItemFromBlueprint
FurC.Utils.GetItemId = this.GetItemId
