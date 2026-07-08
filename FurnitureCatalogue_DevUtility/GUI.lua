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
  if show then
    if this.ApplyPaneSplit then
      this.ApplyPaneSplit()
    end
    if this.RefreshHeader then
      this.RefreshHeader()
    end
    -- start building zones on open so it's ready by the time we use the search
    if this.Internal and NonContiguousCount(this.Zones or {}) < 1 then
      this.Internal.BuildZoneTable()
    end
    if this.RefreshCurrentTab then
      this.RefreshCurrentTab()
    end
  end
end

local function showTextbox()
  this.control:SetHidden(false)
end

function this.clearControl()
  this.textbox:Clear()
  cachedItemIds = {}
end

function this.selectAllOutput()
  local box = this.textbox
  if not box or this.control:IsHidden() then
    return
  end
  box:TakeFocus()
  box:SelectAll()
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
---@param onShow function|nil called each time the tab becomes active
function this.RegisterTab(id, label, panel, onShow)
  if not dashboard.panels[id] then
    dashboard.order[#dashboard.order + 1] = id
  end
  dashboard.panels[id] = { label = label, control = panel, onShow = onShow }
end

-- Show one panel, hide rest, mark active btn
function this.SelectTab(id, skipOnShow)
  local active = dashboard.panels[id]
  if not active then
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
  if active.onShow and not skipOnShow then
    active.onShow()
  end
end

-- Re-run the active tab's onShow (when dashboard opened)
function this.RefreshCurrentTab()
  local entry = dashboard.current and dashboard.panels[dashboard.current]
  if entry and entry.onShow then
    entry.onShow()
  end
end

local TAB_WIDTH = 112
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

-------------------------
-- Search tabs (Achievements, Zones)
-------------------------

local ROW_HEIGHT = 24
local PAGE_SIZE = 100

local searchTabs = {
  achievements = {
    list = "FurCDevControl_AchievementsList",
    pager = "FurCDevControl_AchievementsPager",
    search = "FurCDevControl_AchievementsSearch",
    source = function()
      return this.Achievements
    end,
    -- lazy build achievements
    ensure = function()
      if NonContiguousCount(this.Achievements) < 1 then
        this.Internal.BuildAchievementTable()
      end
    end,
    rows = {},
    matches = {},
    page = 1,
  },
  zones = {
    list = "FurCDevControl_ZonesList",
    pager = "FurCDevControl_ZonesPager",
    search = "FurCDevControl_ZonesSearch",
    source = function()
      return this.Zones
    end,
    -- lazy build zones
    ensure = function()
      if NonContiguousCount(this.Zones) < 1 then
        this.Internal.BuildZoneTable()
      end
    end,
    rows = {},
    matches = {},
    page = 1,
  },
}

-- Row clicks and dumps append to the scratchpad
local function appendToOutput(text)
  local box = this.textbox
  if box then
    box:SetText((box:GetText() or "") .. text)
  end
end

-- Reused row btn
local function acquireRow(cfg, index, parent)
  local row = cfg.rows[index]
  if not row then
    row = WINDOW_MANAGER:CreateControlFromVirtual(parent:GetName() .. "_Row" .. index, parent, "ZO_DefaultButton")
    row:SetHeight(ROW_HEIGHT)
    row:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    cfg.rows[index] = row
  end
  return row
end

-- Render current page
local function renderPage(cfg)
  local list = _G[cfg.list]
  local child = list and list:GetNamedChild("ScrollChild")
  if not child then
    return
  end

  for _, row in ipairs(cfg.rows) do
    row:SetHidden(true)
    row:ClearAnchors()
  end

  local total = #cfg.matches
  local pages = math.max(1, math.ceil(total / PAGE_SIZE))
  cfg.page = math.max(1, math.min(cfg.page, pages))

  local rowWidth = math.max(200, (list:GetWidth() or 0) - 24)
  local first = (cfg.page - 1) * PAGE_SIZE + 1
  local last = math.min(first + PAGE_SIZE - 1, total)

  local predecessor
  for i = first, last do
    local m = cfg.matches[i]
    local index = i - first + 1
    local row = acquireRow(cfg, index, child)
    row:SetWidth(rowWidth)
    row:SetText(string.format("%d   %s", m.id, m.name))
    row:ClearAnchors()
    if predecessor then
      row:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
    else
      row:SetAnchor(TOPLEFT, child, TOPLEFT, 0, 0)
    end
    row:SetHandler("OnClicked", function()
      appendToOutput(string.format("%d, -- %s\n", m.id, m.name))
    end)
    row:SetHidden(false)
    predecessor = row
  end

  if ZO_Scroll_ResetToTop then
    ZO_Scroll_ResetToTop(list)
  end
  if ZO_Scroll_UpdateScrollBar then
    ZO_Scroll_UpdateScrollBar(list)
  end

  if cfg.pageLabel then
    cfg.pageLabel:SetText(string.format("page %d / %d   (%d)", cfg.page, pages, total))
  end
  if cfg.prevBtn then
    cfg.prevBtn:SetEnabled(cfg.page > 1)
  end
  if cfg.nextBtn then
    cfg.nextBtn:SetEnabled(cfg.page < pages)
  end
end

-- Filter source table (empty query = full list)
function this.OnSearch(editControl, tabId)
  local cfg = searchTabs[tabId]
  if not cfg then
    return
  end
  cfg.ensure()
  local query = LocaleAwareToLower((editControl and editControl:GetText()) or "")

  local matches = {}
  for id, name in pairs(cfg.source()) do
    if type(name) == "string" and (query == "" or string.find(LocaleAwareToLower(name), query, 1, true)) then
      matches[#matches + 1] = { id = id, name = name }
    end
  end
  table.sort(matches, function(a, b)
    return a.id < b.id
  end)
  cfg.matches = matches
  cfg.page = 1
  renderPage(cfg)
end

function this.Page(tabId, delta)
  local cfg = searchTabs[tabId]
  if not cfg then
    return
  end
  cfg.page = cfg.page + delta
  renderPage(cfg)
end

-- Re-run search tab's filter
local function refreshSearchTab(tabId)
  local cfg = searchTabs[tabId]
  return function()
    this.OnSearch(_G[cfg.search], tabId)
  end
end

-- Build pager bar (prev / page label / next) for a search tab
local PAGER_BTN_WIDTH = 30
local function buildPager(tabId)
  local cfg = searchTabs[tabId]
  local bar = _G[cfg.pager]
  if not bar then
    return
  end

  local prevBtn = WINDOW_MANAGER:CreateControlFromVirtual(bar:GetName() .. "_Prev", bar, "ZO_DefaultButton")
  prevBtn:SetDimensions(PAGER_BTN_WIDTH, 24)
  prevBtn:SetText("<")
  prevBtn:SetAnchor(LEFT, bar, LEFT, 0, 0)
  prevBtn:SetHandler("OnClicked", function()
    this.Page(tabId, -1)
  end)

  local nextBtn = WINDOW_MANAGER:CreateControlFromVirtual(bar:GetName() .. "_Next", bar, "ZO_DefaultButton")
  nextBtn:SetDimensions(PAGER_BTN_WIDTH, 24)
  nextBtn:SetText(">")
  nextBtn:SetAnchor(RIGHT, bar, RIGHT, 0, 0)
  nextBtn:SetHandler("OnClicked", function()
    this.Page(tabId, 1)
  end)

  local label = WINDOW_MANAGER:CreateControl(bar:GetName() .. "_Label", bar, CT_LABEL)
  label:SetFont("ZoFontGame")
  label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
  label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
  label:SetAnchor(LEFT, prevBtn, RIGHT, 4, 0)
  label:SetAnchor(RIGHT, nextBtn, LEFT, -4, 0)

  cfg.prevBtn, cfg.nextBtn, cfg.pageLabel = prevBtn, nextBtn, label
end

-- Responsive: left pane ~33%, scratchpad takes rest
local LEFT_FRACTION = 0.33
local LEFT_MIN = 300
local PANE_GAP = 12
function this.ApplyPaneSplit()
  local content = FurCDevControl_Content
  if not content then
    return
  end
  local left = content:GetNamedChild("_Left")
  local right = content:GetNamedChild("_Right")
  if not left or not right then
    return
  end
  local w = content:GetWidth() or 0
  if w <= 0 then
    return
  end
  local leftW = math.max(LEFT_MIN, math.floor(w * LEFT_FRACTION))
  leftW = math.min(leftW, w - 220) -- leave room for scratchpad
  left:SetWidth(leftW)
  right:SetWidth(w - leftW - PANE_GAP)
end

local MAX_OUTPUT_CHARS = 200000
function this.InitDashboard()
  this.textbox = this.textbox or FurCDevControlBox
  if this.textbox then
    this.textbox:SetMaxInputChars(MAX_OUTPUT_CHARS)
  end

  local content = FurCDevControl_Content
  if content then
    content:SetHandler("OnResize", function()
      this.ApplyPaneSplit()
    end)
  end
  this.ApplyPaneSplit()

  -- Output is a permanent right pane (Scratchpad)
  this.RegisterTab("achievements", "Achievements", FurCDevControl_Achievements, refreshSearchTab("achievements"))
  this.RegisterTab("zones", "Zones", FurCDevControl_Zones, refreshSearchTab("zones"))
  buildTabButtons()
  buildPager("achievements")
  buildPager("zones")
  this.SelectTab("achievements", true)
  this.RefreshHeader()
end
