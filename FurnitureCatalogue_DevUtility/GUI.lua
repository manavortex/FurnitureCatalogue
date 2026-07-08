-- FurCDev GUI (data textbox, context menues etc)
local this = FurCDev

FurCDevControl_LinkHandlerBackup_OnLinkMouseUp = nil
this.textbox = this.textbox or FurCDevControlBox
local textbox = this.textbox

local cachedItemLink
local cachedAchName
local cachedName
local cachedPrice
local cachedCanBuy
local cachedIsLetter

local cachedItemIds = {}

function this.ToggleEditBox()
  local show = this.control:IsHidden()
  this.control:SetHidden(not show)
  if show and this.RefreshHeader then
    this.RefreshHeader()
  end
end

local function showTextbox()
  this.control:SetHidden(false)
end

function this.clearControl()
  this.textbox:Clear()
  cachedItemIds = {}
end

function this.selectEntireTextbox()
  if this.control:IsHidden() then
    return
  end

  textbox:SelectAll()
end

function this.onTextboxTextChanged()
  if this.control:IsHidden() then
    return
  end

  local text = textbox:GetText() or ""
  if #text > 0 then
    return
  end
  this.clearControl()
end

local indent = "  "
local s_default = "[%d] = strCrown(99), -- %s"
local s_letter = "[%d] = rumourSource, -- %s"
local s_withPrice = "[%d] = { -- %s\n" .. indent .. "itemPrice = %d,\n},"
local s_withAchievement = "[%d] = { -- %s\n" .. indent .. "itemPrice = %d,\n" .. indent .. "achievement = %d, -- %s\n},"
local s_forRecipe = "%d, -- %s"

local function makeOutput()
  if not cachedItemLink then
    return
  end

  local isRecipe = IsItemLinkFurnitureRecipe(cachedItemLink)
  local debugString = (isRecipe and s_forRecipe) or s_default

  cachedName = cachedName or GetItemLinkName(cachedItemLink)
  cachedPrice = cachedPrice or 0

  if 0 < cachedPrice then
    debugString = s_withPrice
  end
  if cachedAchName and "" ~= cachedAchName then
    debugString = s_withAchievement
  end

  local achievementId = this.GetAchievementId(cachedAchName)

  if cachedIsLetter then
    debugString = s_letter
  end

  return string.format(
    debugString .. "\n",
    tonumber(GetItemLinkItemId(cachedItemLink)),
    cachedName,
    tonumber(cachedPrice),
    tonumber(achievementId),
    cachedAchName
  )
end

local function isItemIdCached()
  local itemId = GetItemLinkItemId(cachedItemLink)
  if not itemId then
    return
  end
  if cachedItemIds[itemId] then
    return true
  end

  cachedItemIds[itemId] = true
  return false
end

local function concatToTextbox()
  if isItemIdCached() then
    return
  end

  local textSoFar = this.textbox:GetText() or ""
  this.textbox:SetText(textSoFar .. makeOutput())
  showTextbox()
end

function this.concatToTextbox(itemId)
  if itemId then
    cachedItemLink = FurC.Utils.GetItemLink(itemId)
    cachedName = GetItemLinkName(cachedItemLink)
    cachedPrice = 0
    concatToTextbox()
  end
end

-- Returns true if a new line was added
local function addStoreEntry(storeIndex)
  local itemLink = GetStoreItemLink(storeIndex, LINK_STYLE_DEFAULT)
  if not itemLink or #itemLink == 0 or not FurC.Utils.IsFurniture(itemLink) then
    return false
  end

  local _, name, _, price, _, _, _, _, _, currencyType1, currencyQuantity1, _, _, _, _, buyErrorStringId =
    GetStoreEntryInfo(storeIndex)

  local success, errorMsg = pcall(GetErrorString, buyErrorStringId)
  cachedAchName = (success and errorMsg) or ""
  local matchWithoutQuotes = string.match(cachedAchName, "Requires (.+) Achievement to purchase%.")
  cachedAchName = matchWithoutQuotes or string.match(cachedAchName, ".+ %„(.+)%“.+")

  cachedItemLink = itemLink
  cachedName = zo_strformat("<<1>>", name)
  cachedPrice = (price and price > 0 and price) or currencyQuantity1 or 0
  cachedIsLetter = false

  local before = #(this.textbox:GetText() or "")
  concatToTextbox()
  return #(this.textbox:GetText() or "") > before
end

-- Dump every furnishing/recipe from currently open trader into box
function this.AddAllFromTrader()
  if IsStoreEmpty() then
    FurC.Logger:Info("|cFF3333FurCDev|r: no store open, or trader has no items.")
    return
  end

  local numItems = GetNumStoreItems()
  local added = 0
  for i = 1, numItems do
    if addStoreEntry(i) then
      added = added + 1
    end
  end
  showTextbox()
  FurC.Logger:Info("|cFF3333FurCDev|r: added %d of %d store items.", added, numItems)
end

local function doNothing() end

local S_ADD_TO_BOX = "Add data to textbox"
local S_DIVIDER = "-"
local function addMenuItems()
  AddCustomMenuItem(S_DIVIDER, doNothing, MENU_ADD_OPTION_LABEL)
  AddCustomMenuItem(S_ADD_TO_BOX, concatToTextbox, MENU_ADD_OPTION_LABEL)
end

function FurCDevControl_HandleClickEvent(itemLink, mouseButton, control)
  if type(itemLink) == "string" and #itemLink > 0 then
    local currentSceneName = SCENE_MANAGER:GetCurrentScene().name
    cachedCanBuy = currentSceneName == "store"
    cachedIsLetter = currentSceneName == "mailInbox"
    cachedItemLink = itemLink
    cachedName = GetItemLinkName(cachedItemLink)

    local handled = LINK_HANDLER:FireCallbacks(
      LINK_HANDLER.LINK_MOUSE_UP_EVENT,
      itemLink,
      mouseButton,
      ZO_LinkHandler_ParseLink(itemLink)
    )
    if not handled then
      FurCDevControl_LinkHandlerBackup_OnLinkMouseUp(itemLink, mouseButton, control)
      -- end
      if mouseButton == 2 and itemLink and #itemLink > 0 then
        addMenuItems()
      end
      ShowMenu(control)
    end
  end
end

-- thanks Randactyl for helping me with the handler :)
function FurCDevControl_HandleInventoryContextMenu(control)
  control = control or moc()
  if not control then
    return
  end

  local icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToEquip, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, entryType, buyStoreFailure, buyErrorStringId

  local st = ZO_InventorySlot_GetType(control)
  cachedItemLink = nil
  if
    st == SLOT_TYPE_ITEM
    or st == SLOT_TYPE_BANK_ITEM
    or st == SLOT_TYPE_GUILD_BANK_ITEM
    or st == SLOT_TYPE_TRADING_HOUSE_POST_ITEM
  then
    local bagId, slotId = ZO_Inventory_GetBagAndIndex(control)
    cachedItemLink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
    name = GetItemLinkName(cachedItemLink)
    price = 0
    local canBuy = true
  elseif st == SLOT_TYPE_STORE_BUY then
    local storeEntryIndex = control.index or 0

    icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToEquip, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, entryType, buyStoreFailure, buyErrorStringId =
      GetStoreEntryInfo(storeEntryIndex)

    local success, errorMsg = pcall(GetErrorString, buyErrorStringId)

    cachedAchName = (success and errorMsg) or ""
    -- Different tooltip formatting depending on locale
    -- DE: Benötigt die Errungenschaft „Sieger von Bal Sunnar“.
    -- EN: Requires Bal Sunnar Vanquisher to purchase.
    local matchWithoutQuotes = string.match(cachedAchName, "Requires (.+) Achievement to purchase%.")
    cachedAchName = matchWithoutQuotes or string.match(cachedAchName, ".+ %„(.+)%“.+")

    cachedItemLink = GetStoreItemLink(storeEntryIndex)
  end

  cachedName = name
  cachedPrice = price or 0
  cachedCanBuy = meetsRequirementsToBuy

  if not FurC.Find(cachedItemLink) then
    return
  end

  zo_callLater(function()
    addMenuItems()
    ShowMenu()
  end, 80)
end

function this.OnControlMouseUp(control, mouseButton)
  if (not control) or mouseButton ~= 2 then
    return
  end

  if not control.itemLink or #control.itemLink == 0 then
    return
  end

  cachedItemLink = control.itemLink
  local cachedHasAchievement = ItemTooltip and ItemTooltip:GetNamedChild("Condition")

  zo_callLater(function()
    ItemTooltip:SetHidden(true)
    ClearMenu()
    addMenuItems()
    ShowMenu()
  end, 50)
end

function this.InitRightclickMenu()
  FurCDevControl_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
  ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control)
    FurCDevControl_HandleClickEvent(itemLink, button, control)
  end
  ZO_PreHook("ZO_InventorySlot_ShowContextMenu", function(rowControl)
    FurCDevControl_HandleInventoryContextMenu(rowControl)
  end)
end

-------------------------
-- Dashboard controller
-------------------------

local dashboard = { order = {}, panels = {}, buttons = {}, current = nil }
this.Dashboard = dashboard

-- Register tab. Panels render in registration order in tab bar
---@param id string unique tab id
---@param label string button caption
---@param panel table content control shown when tab is active
function this.RegisterTab(id, label, panel)
  if not dashboard.panels[id] then
    dashboard.order[#dashboard.order + 1] = id
  end
  dashboard.panels[id] = { label = label, control = panel }
end

-- Show one panel, hide rest, mark active btn
function this.SelectTab(id)
  if not dashboard.panels[id] then
    return
  end
  for tabId, entry in pairs(dashboard.panels) do
    if entry.control then
      entry.control:SetHidden(tabId ~= id)
    end
  end
  for tabId, btn in pairs(dashboard.buttons) do
    btn:SetState((tabId == id) and BSTATE_PRESSED or BSTATE_NORMAL, tabId == id)
  end
  dashboard.current = id
end

local TAB_WIDTH = 96
local TAB_HEIGHT = 26
local TAB_GAP = 4
local function buildTabButtons()
  local bar = FurCDevControl_TabBar
  if not bar then
    return
  end
  local predecessor
  for _, id in ipairs(dashboard.order) do
    local entry = dashboard.panels[id]
    local btn = dashboard.buttons[id]
      or WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Tab_" .. id, bar, "ZO_DefaultButton")
    btn:SetDimensions(TAB_WIDTH, TAB_HEIGHT)
    btn:SetText(entry.label)
    btn:ClearAnchors()
    if predecessor then
      btn:SetAnchor(LEFT, predecessor, RIGHT, TAB_GAP, 0)
    else
      btn:SetAnchor(TOPLEFT, bar, TOPLEFT, 0, 0)
    end
    btn:SetHandler("OnClicked", function()
      this.SelectTab(id)
    end)
    dashboard.buttons[id] = btn
    predecessor = btn
  end
end

-- Last scanner summary, shown in the header
function this.SetScanSummary(text)
  dashboard.lastScan = text
  this.RefreshHeader()
end

-- Fill header bar from game state
function this.RefreshHeader()
  local label = FurCDevControl_Header
  if not label then
    return
  end
  local api = (GetAPIVersion and GetAPIVersion()) or 0
  local locale = (GetCVar and GetCVar("Language.2")) or "?"
  local dbCount = (FurC and FurC.DB and NonContiguousCount(FurC.DB)) or 0
  local catCount = (GetNumFurnitureCategories and GetNumFurnitureCategories()) or 0
  local scan = dashboard.lastScan or "no scan yet"
  label:SetText(
    string.format("API %d  |  %s  |  DB %d items  |  %d categories  |  scan: %s", api, locale, dbCount, catCount, scan)
  )
end

local MAX_OUTPUT_CHARS = 200000
function this.InitDashboard()
  this.textbox = this.textbox or FurCDevControlBox
  if this.textbox then
    this.textbox:SetMaxInputChars(MAX_OUTPUT_CHARS)
  end

  this.RegisterTab("output", "Output", FurCDevControl_Output)
  buildTabButtons()
  this.SelectTab("output")
  this.RefreshHeader()
end
