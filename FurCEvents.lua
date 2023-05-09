local em = EVENT_MANAGER

local function onRecipeLearned(eventCode, recipeListIndex, recipeIndex)
  local itemlink = GetRecipeResultItemLink(recipeListIndex, recipeIndex, LINK_STYLE_BRACKETS)
  local info = zo_strformat(GetString(SI_FURC_STRING_RECIPELEARNED), itemlink, recipeListIndex, recipeIndex)
  FurC.Logger:Debug(info)
  FurC.TryCreateRecipeEntry(recipeListIndex, recipeIndex)
  FurC.UpdateGui()
end

local wm = WINDOW_MANAGER

local function createIcon(control)
  local icon
  icon = wm:CreateControlFromVirtual(control:GetName() .. "FurCIcon", control, "FurC_SlotIconKnownYes")
  if FurC.settings["showIconOnLeft"] == nil or
      FurC.settings["showIconOnLeft"] == true then
    icon:SetAnchor(BOTTOMLEFT, control:GetNamedChild("Button"), BOTTOMLEFT, -15, -10)
  else
    icon:SetAnchor(TOPLEFT, control:GetNamedChild("TraitInfo"), TOPLEFT, 0, 0)
  end
  icon:SetHidden(true)
  control.icon = icon
  return icon
end

local function getItemKnowledge(itemLink)
  local recipeArray = FurC.Find(itemLink)
  local itemId = GetItemLinkItemId(itemLink)
  if FurC.GetUseInventoryIconsOnChar() then
    return FurC.CanCraft(itemId, recipeArray)
  end
  return FurC.IsAccountKnown(itemId, recipeArray)
end

local function updateItemInInventory(control)
  if 'listSlot' ~= control.slotControlType then return end
  local icon = control.icon or createIcon(control)
  local data = control.dataEntry.data

  local bagId = data.bagId
  local slotId = data.slotIndex
  local itemLink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)

  if not IsItemLinkFurnitureRecipe(itemLink) then
    icon:SetHidden(true)
    return
  end
  local known = getItemKnowledge(itemLink)

  local hidden = known and FurC.GetHideKnownInventoryIcons() or (not FurC.GetUseInventoryIcons())
  icon:SetHidden(hidden)

  local templateName = "FurC_SlotIconKnown" .. ((known and "Yes") or "No")

  WINDOW_MANAGER:ApplyTemplateToControl(icon, templateName)

  icon.data = { tooltipText = ((known and GetString(SI_FURC_CRAFTING_KNOWN)) or GetString(SI_FURC_CRAFTING_UNKNOWN)) }
  icon:SetHandler("OnMouseEnter", ZO_Options_OnMouseEnter)
  icon:SetHandler("OnMouseExit", ZO_Options_OnMouseExit)
end

function FurC.SetupInventoryRecipeIcons(calledRecursively)
  local function isValidBag(bagId, inventory)
    if bagId == BAG_WORN then return false end
    if bagId == BAG_VIRTUAL then return false end
    local listView = inventory.listView
    if not listView then return false end
    if not listView.dataTypes then return false end
    if not listView.dataTypes[1] then return false end
    return nil ~= listView.dataTypes[1].setupCallback
  end

  local inventories = PLAYER_INVENTORY.inventories
  if not inventories and not calledRecursively then
    return zo_callLater(function() FurC.SetupInventoryRecipeIcons(true) end, 1000)
  end
  -- ruthlessly stolen from Dryzler's Inventory, then tweaked
  for bagId, inventory in pairs(inventories) do
    if isValidBag(bagId, inventory) then
      ZO_PreHook(inventory.listView.dataTypes[1], "setupCallback",
        function(control, slot) updateItemInInventory(control) end
      )
    end
  end
end

function FurC.RegisterEvents()
  em:RegisterForEvent("FurnitureCatalogue", EVENT_RECIPE_LEARNED, onRecipeLearned)
end
