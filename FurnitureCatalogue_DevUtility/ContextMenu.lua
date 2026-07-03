local this = FurCDev or {}

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

local achievementTable = {}
local questTable = {}
local zoneTable = {}

FurCDev.Achievements = achievementTable
FurCDev.Quests = questTable
FurCDev.Zones = zoneTable

-- Inspired by AchievementFinder from Rhyono
local function buildAchievementTable()
  for id = 11, MAX_ACHIEVEMENTS + 11 do
    local achieveName = select(1, GetAchievementInfo(id))
    if achieveName ~= "" then
      -- Save gendered and lowercased achievement name
      achievementTable[id] = LocaleAwareToLower(zo_strformat(achieveName))
    end
  end
end

local function buildQuestTable()
  local MAX_QUESTS = 10000
  for id = 1, MAX_QUESTS do
    local questName = GetQuestName(id)
    if questName ~= "" then
      questTable[id] = questName
    end
  end
end

local NUM_ZONES = GetNumZones() -- 982 as of version 101041
local MAX_INDEX = NUM_ZONES * 100 -- don't iterate higher than that, man
local STEP_SIZE = NUM_ZONES -- "What are you doing, step size?"
local zoneLock = false
local function buildZoneTable(iFrom)
  if zoneLock then
    return
  end
  zoneLock = true -- protect from call conflicts
  iFrom = iFrom or 1
  local iTo = iFrom + STEP_SIZE - 1

  FurC.Logger:Debug("Building Zone Table: %d/%d [%5d...%5d]", NonContiguousCount(FurCDev.Zones), NUM_ZONES, iFrom, iTo)
  for id = iFrom, iTo do
    -- do NOT use `GetZoneNameByIndex` as it's a contiguous version of *ById, means the indices change
    local zoneName = GetZoneNameById(id)
    if zoneName ~= "" then
      zoneTable[id] = zoneName
    end
    iFrom = id
  end

  -- If we haven't found all zones yet, slowly iterate through the rest
  if NonContiguousCount(FurCDev.Zones) < NUM_ZONES and iFrom <= MAX_INDEX then
    zo_callLater(function()
      zoneLock = false
      buildZoneTable(iFrom + 1)
    end, 2000)
  else
    FurC.Logger:Debug("Zones table done: %d/%d [%d]", NonContiguousCount(FurCDev.Zones), NUM_ZONES, iFrom)
    zoneLock = false
  end
end

local function getAchievementId(achievementName)
  if not achievementName or achievementName == "" then
    return 0
  end

  if {} == achievementTable then
    buildAchievementTable()
  end

  -- making sure that the achievement name is the same like in the lookup table
  achievementName = LocaleAwareToLower(zo_strformat(achievementName))
  for id, name in pairs(achievementTable) do
    if name == achievementName then
      return id
    end
  end

  return 0
end
FurCDev.GetAchievementId = getAchievementId

---@param achievementName string part of the achievement name
---@return table results list of achievements that match the given name
local function findAchievement(achievementName)
  local results = {}
  if not achievementName or achievementName == "" then
    return results
  end

  if #achievementTable < 1 then
    buildAchievementTable()
  end

  achievementName = LocaleAwareToLower(zo_strformat(achievementName))
  for id, name in pairs(achievementTable) do
    if string.find(name, achievementName) then
      table.insert(results, zo_strformat("<<1>>: <<2>>", id, name))
    end
  end
  return results
end
FurCDev.FindAchievement = findAchievement

---@param questName string part of the quest name
---@return table results list of quests that match the given name
local function findQuest(questName)
  local results = {}
  if not questName or questName == "" then
    return results
  end

  if NonContiguousCount(questTable) < 1 then
    FurC.Logger:Debug("Have to build quest table, search again")
    buildQuestTable()
    return results
  end

  questName = LocaleAwareToLower(zo_strformat(questName))
  for id, name in pairs(questTable) do
    if string.find(LocaleAwareToLower(name), questName) then
      results[id] = name
    end
  end
  return results
end
FurCDev.FindQuest = findQuest

---@param zoneName string part of the zone name
---@return table results list of zones that match the given name (unformatted)
local function findZone(zoneName)
  local results = {}
  if not zoneName or zoneName == "" then
    return results
  end

  if NonContiguousCount(zoneTable) < 1 then
    FurC.Logger:Debug("Have to build zone table, search again when it's done")
    buildZoneTable()
    return results
  end

  zoneName = LocaleAwareToLower(zo_strformat(zoneName))
  for id, name in pairs(zoneTable) do
    if string.find(LocaleAwareToLower(name), zoneName) then
      results[id] = name
    end
  end
  return results
end
FurCDev.FindZone = findZone

--buildAchievementTable()
--buildQuestTable()
--buildZoneTable()

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

  local achievementId = getAchievementId(cachedAchName)

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
