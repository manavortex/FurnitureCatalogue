local async = LibAsync
local task = async:Create("FurnitureCatalogue_Tooltip")
local src = FurC.Constants.ItemSources

local function tryColorize(text)
  if not (text and FurC.GetColouredTooltips()) then
    return text
  end
  return text:gsub("cannot craft", "|cFF0000cannot craft"):gsub("Can be crafted", "|c00FF00Can be crafted")
end

local TYPE_STRING = "string"
local function add(t, arg)
  if nil ~= arg and (TYPE_STRING ~= type(t) or #t > 0) then
    t[#t + 1] = arg
  end
  return t
end

local function addTooltipData(control, itemLink)
  if FurC.GetDisableTooltips() then
    return
  end
  if nil == itemLink or "" == itemLink then
    return
  end
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)

  itemLink = (isRecipe and GetItemLinkRecipeResultItemLink(itemLink)) or itemLink

  if not (isRecipe or IsItemLinkPlaceableFurniture(itemLink)) then
    return
  end
  itemId = GetItemLinkItemId(itemLink)
  recipeArray = FurC.Find(itemLink)

  -- |H0:item:118206:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h

  if not recipeArray then
    return
  end

  local unknown = not FurC.CanCraft(itemId, recipeArray)
  local stringTable = {}

  -- if craftable:
  if isRecipe or recipeArray.origin == src.CRAFTING then
    if unknown and not FurC.GetHideUnknown() or not FurC.GetHideKnowledge() then
      local crafterList = FurC.GetCrafterList(itemLink, recipeArray)
      if crafterList then
        stringTable = add(stringTable, tryColorize(crafterList))
      end
    end
    if not isRecipe and (not FurC.GetHideCraftingStation()) then
      stringTable = add(stringTable, FurC.PrintCraftingStation(itemId, recipeArray))
    end
    if isRecipe then
      stringTable = add(stringTable, FurC.getRecipeSource(itemId, recipeArray))
    end
    -- check if we should show mats
    if not (FurC.GetHideMats() or isRecipe) then
      stringTable = add(stringTable, FurC.GetMats(itemLink, recipeArray, true):gsub(", ", "\n"))
    end
  else
    if not FurC.GetHideSource() then
      stringTable = add(stringTable, FurC.GetItemDescription(itemId, recipeArray))
    end
    stringTable = add(stringTable, recipeArray.achievement)
  end

  if #stringTable == 0 then
    return
  end

  control:AddVerticalPadding(8)
  ZO_Tooltip_AddDivider(control)

  for i = 1, #stringTable do
    control:AddLine(zo_strformat("<<C:1>>", stringTable[i]))
  end
end

local function TooltipHook(tooltipControl, method, linkFunc)
  local origMethod = tooltipControl[method]

  tooltipControl[method] = function(self, ...)
    origMethod(self, ...)
    addTooltipData(self, linkFunc(...))
  end
end

local function ReturnItemLink(itemLink)
  if FurC.showBlueprints then
    local recipeArray = FurC.Find(itemLink)
    if recipeArray and recipeArray.blueprint then
      return FurC.GetItemLink(recipeArray.blueprint)
    end
  end
  return FurC.GetItemLink(itemLink)
end

do
  local identifier = FurC.name .. "Tooltips"
  -- hook real late
  local function HookToolTips()
    EVENT_MANAGER:UnregisterForUpdate(identifier)
    TooltipHook(ItemTooltip, "SetBagItem", GetItemLink)
    TooltipHook(ItemTooltip, "SetTradeItem", GetTradeItemLink)
    TooltipHook(ItemTooltip, "SetBuybackItem", GetBuybackItemLink)
    TooltipHook(ItemTooltip, "SetStoreItem", GetStoreItemLink)
    TooltipHook(ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink)
    TooltipHook(ItemTooltip, "SetLootItem", GetLootItemLink)
    TooltipHook(ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink)
    TooltipHook(ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink)
    TooltipHook(ItemTooltip, "SetLink", ReturnItemLink)
    TooltipHook(PopupTooltip, "SetLink", ReturnItemLink)
  end
  -- hook late
  local function DeferHookToolTips()
    EVENT_MANAGER:UnregisterForEvent(identifier, EVENT_PLAYER_ACTIVATED)
    EVENT_MANAGER:RegisterForUpdate(identifier, 100, HookToolTips)
  end
  function FurC.CreateTooltips()
    EVENT_MANAGER:RegisterForEvent(identifier, EVENT_PLAYER_ACTIVATED, DeferHookToolTips)
  end
end
