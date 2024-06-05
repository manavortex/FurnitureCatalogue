FurC_LinkHandlerBackup_OnLinkMouseUp = nil

local FURC_S_SHOPPINGLIST_1 = GetString(SI_FURC_PLUGIN_SL_ADD_ONE)
local FURC_S_SHOPPINGLIST_5 = GetString(SI_FURC_PLUGIN_SL_ADD_FIVE)
local FURC_S_TOGGLE_SL = GetString(SI_FURC_TOGGLE_SHOPPINGLIST)

local linkStyle = LINK_STYLE_DEFAULT
local src = FurC.Constants.ItemSources

local menuEventQueued = false

function AddFurnitureShoppingListMenuEntry(itemId, calledFromFurC)
  if calledFromFurC then
    if not FurC.GetEnableShoppingList() then
      return
    end
    if (nil == moc()) or (nil == FurnitureShoppingListAdd) then
      return
    end
    if nil == moc():GetName():match("_ListItem_") then
      return
    end
  end

  local itemLink = FurC.Utils.GetItemLink(itemId)
  if {} == FurC.Find(itemLink) then
    return
  end
  AddCustomMenuItem(FURC_S_SHOPPINGLIST_1, function()
    FurnitureShoppingListAdd(itemLink)
  end, MENU_ADD_OPTION_LABEL)
  AddCustomMenuItem(FURC_S_SHOPPINGLIST_5, function()
    FurnitureShoppingListAdd(itemLink)
    FurnitureShoppingListAdd(itemLink)
    FurnitureShoppingListAdd(itemLink)
    FurnitureShoppingListAdd(itemLink)
    FurnitureShoppingListAdd(itemLink)
  end, MENU_ADD_OPTION_LABEL)
  AddCustomMenuItem(FURC_S_TOGGLE_SL, function()
    FurnitureShoppingListWindow_Toggle()
  end, MENU_ADD_OPTION_LABEL)
end

local cachedItemLink, cachedRecipeArray

local function toChat()
  FurC.ToChat(cachedItemLink)
end
local function fave()
  FurC.Fave(cachedItemLink)
end
local function postItemSource()
  FurC.ToChat(FurC.GetItemDescription(cachedItemLink, cachedRecipeArray, true))
end
local function postRecipe()
  FurC.ToChat(FurC.Utils.GetItemLink(cachedRecipeArray.blueprint))
end
local function postRecipeResult()
  FurC.ToChat(GetItemLinkRecipeResultItemLink(cachedItemLink))
end
local function postMaterial()
  FurC.ToChat(FurC.GetMats(cachedItemLink, cachedRecipeArray, true, true))
end

local function doNothing()
  return
end

local S_DIVIDER = "-"
local function addMenuItems(itemLink, recipeArray, hideSepBar)
  hideSepBar = hideSepBar or false
  recipeArray = recipeArray or FurC.Find(itemLink)
  if not recipeArray or recipeArray == {} then
    return
  end

  cachedItemLink = itemLink
  cachedRecipeArray = recipeArray

  if not FurC.GetSkipDivider() and not hideSepBar then
    AddCustomMenuItem(S_DIVIDER, doNothing, MENU_ADD_OPTION_LABEL)
  end

  AddCustomMenuItem(GetString(SI_FURC_MENU_HEADER), toChat, MENU_ADD_OPTION_LABEL)

  local faveText = FurC.IsFavorite(itemLink, recipeArray) and GetString(SI_FURC_REMOVE_FAVE)
    or GetString(SI_FURC_ADD_FAVE)
  AddCustomMenuItem(faveText, fave, MENU_ADD_OPTION_LABEL)

  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)

  -- if we hold a recipe: allow posting recipe
  if not isRecipe and recipeArray.blueprint then
    AddCustomMenuItem(GetString(SI_FURC_POST_RECIPE), postRecipe, MENU_ADD_OPTION_LABEL)

    -- if it's a recipe: Allow posting item
  elseif isRecipe then
    AddCustomMenuItem(GetString(SI_FURC_POST_ITEM), postRecipeResult, MENU_ADD_OPTION_LABEL)
  end

  if recipeArray.origin ~= src.CRAFTING then
    AddCustomMenuItem(GetString(SI_FURC_POST_ITEMSOURCE), postItemSource, MENU_ADD_OPTION_LABEL)
  else
    -- post material list
    AddCustomMenuItem(GetString(SI_FURC_POST_MATERIAL), postMaterial, MENU_ADD_OPTION_LABEL)

    -- will do nothing if preferences not met
    AddFurnitureShoppingListMenuEntry(itemLink, true)
  end
end

function FurC_HandleClickEvent(itemLink, mButton, _, _, linkType, ...)
  if
    mButton == MOUSE_BUTTON_INDEX_RIGHT
    and linkType == ITEM_LINK_TYPE
    and type(itemLink) == "string"
    and #itemLink > 0
    and itemLink ~= ""
  then
    if not menuEventQueued then
      menuEventQueued = true
      zo_callLater(function()
        addMenuItems(itemLink, FurC.Find(itemLink))
        ShowMenu()
        menuEventQueued = false
      end)
    end
  end
end

function FurC_HandleMouseEnter(...)
  local inventorySlot = moc()

  if nil == inventorySlot or nil == inventorySlot.dataEntry then
    return
  end
  local data = inventorySlot.dataEntry.data
  if nil == data then
    return
  end

  local bagId, slotIndex = data.bagId, data.slotIndex
  FurC.CurrentLink = GetItemLink(bagId, slotIndex, linkStyle)
  if nil == FurC.CurrentLink then
    return
  end
end

-- thanks Randactyl for helping me with the handler :)
function FurC_HandleInventoryContextMenu(control)
  if FurC.GetHideInventoryMenu() then
    return
  end

  local st = ZO_InventorySlot_GetType(control)
  local itemLink = nil
  if
    st == SLOT_TYPE_ITEM
    or st == SLOT_TYPE_BANK_ITEM
    or st == SLOT_TYPE_GUILD_BANK_ITEM
    or st == SLOT_TYPE_TRADING_HOUSE_POST_ITEM
  then
    local bagId, slotId = ZO_Inventory_GetBagAndIndex(control)
    itemLink = GetItemLink(bagId, slotId, linkStyle)
  elseif st == SLOT_TYPE_STORE_BUY then
    itemLink = GetStoreItemLink(control.index)
  elseif st == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then
    itemLink = GetTradingHouseSearchResultItemLink(ZO_Inventory_GetSlotIndex(control), linkStyle)
  elseif st == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
    itemLink = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(control), linkStyle)
  end

  local recipeArray = FurC.Find(itemLink)
  if {} == recipeArray then
    return
  end

  if not menuEventQueued then
    menuEventQueued = true
    zo_callLater(function()
      addMenuItems(itemLink, recipeArray)
      ShowMenu()
      menuEventQueued = false
    end, 50)
  end
end

function FurC.OnControlMouseUp(control, button)
  if nil == control then
    return
  end

  if button ~= 2 then
    return
  end
  local itemLink = control.itemLink

  if nil == itemLink then
    return
  end
  local recipeArray = FurC.Find(itemLink)
  if {} == recipeArray then
    return
  end

  if not menuEventQueued then
    menuEventQueued = true
    zo_callLater(function()
      ItemTooltip:SetHidden(true)
      ClearMenu()
      addMenuItems(itemLink, recipeArray, true)
      ShowMenu()
      menuEventQueued = false
    end, 50)
  end
end

function FurC.InitRightclickMenu()
  LINK_HANDLER:RegisterCallback(LINK_HANDLER.LINK_MOUSE_UP_EVENT, FurC_HandleClickEvent)
  ZO_PreHook("ZO_InventorySlot_OnMouseEnter", FurC_HandleMouseEnter)
  ZO_PreHook("ZO_InventorySlot_ShowContextMenu", function(rowControl)
    FurC_HandleInventoryContextMenu(rowControl)
  end)
end
