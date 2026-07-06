local task = LibAsync:Create("FurnitureCatalogue_Settings")
local src = FurC.Constants.ItemSources

function FurC.GetEnableDebug()
  return FurC.settings["enableDebug"]
end

function FurC.SetEnableDebug(value)
  FurC.settings["enableDebug"] = value
  FurC.Logger = FurC.getOrCreateLogger()
  if value then
    FurC.Logger:SetMinLevelOverride(FurC.Logger.LOG_LEVEL_DEBUG)
    FurC.Logger:Info("Debug on")
  else
    FurC.Logger:SetMinLevelOverride(FurC.Logger.LOG_LEVEL_INFO)
  end
end

function FurC.GetHideRumourRecipes()
  return FurC.settings["hideDoubtfuls"]
end

function FurC.SetHideRumourRecipes(value)
  FurC.settings["hideDoubtfuls"] = value
  FurC.UpdateDropdowns()
  FurC.UpdateGui()
end

function FurC.GetHideCrownStoreItems()
  return FurC.settings["hideCrownstore"]
end

function FurC.SetHideCrownStoreItems(value)
  FurC.settings["hideCrownstore"] = value
  FurC.UpdateDropdowns()
  FurC.UpdateGui()
end

function FurC.GetHideUIButton(buttonIdentifier)
  return FurC.settings.hideUiButtons[buttonIdentifier]
end

function FurC.SetHideUIButton(buttonIdentifier, value)
  FurC.settings.hideUiButtons[buttonIdentifier] = value
  FurC.UpdateHeader()
  if not buttonIdentifier == src.RUMOUR then
    return
  end

  -- reanchor crownstore button
  FurC_ShowCrowns:ClearAnchors()
  if value then
    FurC_ShowCrowns:SetAnchor(RIGHT, FurC_Search, RIGHT, 3, 3)
  else
    FurC_ShowCrowns:SetAnchor(RIGHT, FurC_ShowRumours, LEFT, 8, 0)
  end
end

function FurC.GetFilterAllOnText()
  return FurC.settings["filterAllOnText"]
end

function FurC.SetFilterAllOnText(value)
  FurC.settings["filterAllOnText"] = value
  FurC.UpdateGui()
end

function FurC.GetFilterAllOnTextNoRumour()
  return FurC.settings["filterAllOnTextNoRumour"]
end

function FurC.SetFilterAllOnTextNoRumour(value)
  FurC.settings["filterAllOnTextNoRumour"] = value
  FurC.UpdateGui()
end

function FurC.GetHideInventoryMenu()
  return FurC.settings["hideInventoryMenu"]
end

function FurC.SetHideInventoryMenu(value)
  FurC.settings["hideInventoryMenu"] = value
end

function FurC.GetSkipDivider()
  return FurC.settings["skipDivider"]
end

function FurC.SetSkipDivider(value)
  FurC.settings["skipDivider"] = value
end

function FurC.GetFilterAllOnTextNoBooks(value)
  return FurC.settings["filterAllOnTextNoBooks"]
end

function FurC.SetFilterAllOnTextNoBooks(value)
  FurC.settings["filterAllOnTextNoBooks"] = value
  FurC.UpdateGui()
end

function FurC.GetFilterAllOnTextNoCrown()
  return FurC.settings["filterAllOnTextNoCrown"]
end

function FurC.SetFilterAllOnTextNoCrown(value)
  FurC.settings["filterAllOnTextNoCrown"] = value
  FurC.UpdateGui()
end

function FurC.GetFontSize()
  if FurC.settings["fontSize"] < 10 then
    FurC.settings["fontSize"] = 10
  end
  return FurC.settings["fontSize"]
end

function FurC.SetFontSize(value)
  if nil == value then
    value = FurC.GetFontSize()
  end
  if value == 0 then
    value = 18
  end
  FurC.settings["fontSize"] = value

  local size = tostring(value)

  FurC.SetLineHeight()

  if nil ~= task then
    task:Call(FurC.UpdateGui)
  else
    FurC.UpdateGui()
  end
end

---------------------------
--------- Tooltip ---------
---------------------------
function FurC.GetDisableTooltips()
  return FurC.settings["disableTooltips"]
end

function FurC.SetDisableTooltips(value)
  FurC.settings["disableTooltips"] = value
end

function FurC.GetColouredTooltips()
  return FurC.settings["coloredTooltips"]
end

function FurC.SetColouredTooltips(value)
  FurC.settings["coloredTooltips"] = value
end

function FurC.GetDateFormatChoices()
  return {
    choices = {
      [1] = "2012-12-31", -- ISO
      [2] = "31.12.2012",
      [3] = "12/31/2012",
    },
    values = {
      [1] = "YYYY-MM-DD",
      [2] = "DD.MM.YYYY",
      [3] = "MM/DD/YYYY",
    },
  }
end

function FurC.GetDateFormat()
  return FurC.settings["dateFormat"]
end

function FurC.SetDateFormat(value)
  FurC.settings["dateFormat"] = value
end

function FurC.GetHideKnowledge()
  return FurC.settings["hideKnowledge"]
end

function FurC.SetHideKnowledge(value)
  FurC.settings["hideKnowledge"] = value
end

function FurC.GetHideUnknown()
  return FurC.settings["hideUnknown"]
end

function FurC.SetHideUnknown(value)
  FurC.settings["hideUnknown"] = value
end

function FurC.GetHideMats()
  return FurC.settings["hideMats"]
end

function FurC.SetHideMats(value)
  FurC.settings["hideMats"] = value
end

function FurC.GetHideSource()
  return FurC.settings["hideSource"]
end

function FurC.SetHideSource(value)
  FurC.settings["hideSource"] = value
end

function FurC.GetHideCraftingStation()
  return FurC.settings["hideCraftingStation"]
end

function FurC.SetHideCraftingStation(value)
  FurC.settings["hideCraftingStation"] = value
end

function FurC.GetEnableShoppingList()
  return FurC.settings["enableShoppingList"]
end

function FurC.SetEnableShoppingList(value)
  FurC.settings["enableShoppingList"] = value
end

-- Tooltip source blacklist
do
  local S = FurC.Constants.ItemSources
  local CATEGORIES = {
    { key = "purch_gold", name = SI_FURC_FILTER_SRC_SOLD_GOLD, raw = { S.VENDOR } },
    { key = "writ_vendor", name = SI_FURC_FILTER_SRC_SOLD_WRIT, raw = { S.ROLIS } },
    { key = "purch_ap", name = SI_FURC_FILTER_SRC_SOLD_AP, raw = { S.PVP } },
    { key = "purch_tbars", name = SI_FURC_FILTER_SRC_SOLD_TBARS, raw = { S.BAZAAR } },
    { key = "luxury", name = SI_FURC_FILTER_SRC_LUX, raw = { S.LUXURY } },
    { key = "crownstore", name = SI_FURC_FILTER_SRC_CROWN, raw = { S.CROWN } },
    { key = "rumour", name = SI_FURC_FILTER_SRC_RUMOUR, raw = { S.RUMOUR } },
    {
      key = "other",
      name = SI_FURC_FILTER_SRC_OTHER,
      raw = { S.FESTIVAL_DROP, S.DROP, S.FISHING, S.JUSTICE, S.GUILDSTORE, S.TOMES, S.OTHER, S.COLL_MERCH },
    },
  }

  -- raw stored source -> category key
  local rawToKey = {}
  for _, category in ipairs(CATEGORIES) do
    for _, rawSource in ipairs(category.raw) do
      rawToKey[rawSource] = category.key
    end
  end

  -- True if tooltip should suppress category
  function FurC.IsTooltipSourceHidden(source)
    local hidden = FurC.settings.tooltipHiddenSources
    if not hidden then
      return false
    end
    local key = rawToKey[source]
    return key ~= nil and hidden[key] == true
  end

  function FurC.BuildTooltipSourceOptions()
    local controls = {}
    for _, category in ipairs(CATEGORIES) do
      local key = category.key
      controls[#controls + 1] = {
        type = "checkbox",
        name = GetString(category.name),
        width = "half",
        disabled = function()
          return FurC.GetDisableTooltips() or FurC.GetHideSource()
        end,
        getFunc = function()
          local hidden = FurC.settings.tooltipHiddenSources
          return not (hidden and hidden[key]) -- checked = shown
        end,
        setFunc = function(show)
          FurC.settings.tooltipHiddenSources = FurC.settings.tooltipHiddenSources or {}
          FurC.settings.tooltipHiddenSources[key] = (not show) or nil
        end,
      }
    end
    return controls
  end
end

---------------------------
-------- /Tooltip ---------
---------------------------

---------------------------
------- IconDisplay -------
---------------------------

function FurC.GetShowIconOnLeft()
  return FurC.settings["showIconOnLeft"] == nil or FurC.settings["showIconOnLeft"] == true
end

function FurC.SetShowIconOnLeft(value)
  FurC.settings["showIconOnLeft"] = value
end

---------------------------
------ /IconDisplay -------
---------------------------

---------------------------
--------- Filters ---------
---------------------------

local function containsTrue(ary)
  for key, value in pairs(ary) do
    if value then
      return true
    end
  end
end

function FurC.GetFilterQuality()
  return FurC.settings.filterQuality
end

function FurC.SetFilterQuality(quality)
  local controls = FurC.GuiElements.qualityButtons
  local filterArray = FurC.settings.filterQuality

  quality = quality or 0

  if quality == 0 then
    for key, value in pairs(filterArray) do
      FurC.settings.filterQuality[key] = false
    end
  else
    filterArray[quality] = not filterArray[quality]
  end
  FurC.settings.filterQualityAll = not containsTrue(filterArray)

  for key, control in pairs(controls) do
    control:SetState((filterArray[key - 1] and BSTATE_PRESSED) or BSTATE_NORMAL)
  end
  FurC.GuiOnScroll(nil, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end

function FurC.GetFilterCraftingType()
  return FurC.settings.filterCraftingType
end

function FurC.SetFilterCraftingType(craftingType)
  local controls = FurC.GuiElements.craftingTypeFilters
  local filterArray = FurC.settings.filterCraftingType

  if craftingType == 0 then
    for key, value in pairs(filterArray) do
      filterArray[key] = false
    end
  else
    filterArray[craftingType] = not filterArray[craftingType]
  end

  FurC.settings.filterCraftingTypeAll = not containsTrue(filterArray)

  for key, control in pairs(controls) do
    control:SetState((filterArray[key] and BSTATE_PRESSED) or BSTATE_NORMAL)
  end

  FurC.GuiOnScroll(FurCGui_ListHolder_Slider, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end

function FurC.GetSearchFilter()
  if (not FurC.SearchFilter) or FurC.SearchFilter == GetString(SI_FURC_TEXTBOX_FILTER_DEFAULT) then
    FurC.SearchFilter = FurC_SearchBox:GetText() or ""
  end
  return FurC.SearchFilter or ""
end

local alreadySearching = false
local alreadyReset = false
local function resetSearch()
  alreadySearching = false
  alreadyReset = false
end

local lastText = ""
local function doSearchOnUpdate()
  if alreadyReset then
    return
  end
  if alreadySearching then
    zo_callLater(resetSearch, 200)
    return
  end
  local text = FurC_SearchBox:GetText()
  if #text > 0 and #text < 3 then
    return
  end
  if LocaleAwareToLower(lastText) ~= LocaleAwareToLower(text) then
    FurC.Logger:Verbose("Search changed: '%s' --> '%s'", lastText, text)
    lastText = text
    FurC.SearchFilter = text

    FurC.GuiOnSliderUpdate(FurCGui_ListHolder_Slider, 0)
    FurC.UpdateGui()
  end
end

function FurC.GuiSetSearchboxTextFrom(control)
  control = control or FurC_SearchBox
  if nil ~= task then
    task:Call(doSearchOnUpdate)
  else
    doSearchOnUpdate()
  end
end

function FurC.GetHideBooks()
  return FurC.settings["hideBooks"]
end

function FurC.SetHideBooks(value)
  FurC.settings["hideBooks"] = value
  FurC.UpdateGui()
end

function FurC.GetMergeLuxuryAndSales()
  return FurC.settings["mergeLuxuryAndSales"]
end

function FurC.SetMergeLuxuryAndSales(value)
  FurC.settings["mergeLuxuryAndSales"] = value
  FurC.UpdateGui()
end

function FurC.GetShowRumours()
  return FurC.settings["showRumours"]
end

function FurC.SetShowRumours(value)
  FurC.settings["showRumours"] = value
  FurC_ShowRumours:SetState((value and BSTATE_PRESSED) or BSTATE_DISABLED, false)
  FurC_ShowRumoursGlow:SetHidden(not value)
  FurC.UpdateGui()
end

function FurC.GetShowCrownstore()
  return FurC.settings["showCrowns"]
end

function FurC.SetShowCrownstore(value)
  FurC.settings["showCrowns"] = value
  FurC_ShowCrowns:SetState((value and BSTATE_PRESSED) or BSTATE_DISABLED, false)
  FurC.UpdateGui()
end

---------------------------
--------- Dropdown --------
---------------------------
FurC.DropdownChoices = {
  ["Source"] = nil,
  ["Version"] = nil,
  ["Character"] = nil,
}

function FurC.GetDropdownChoice(dropdownName)
  return (FurC.DropdownChoices[dropdownName] or FurC.GetDefaultDropdownChoice(dropdownName))
end

function FurC.GetDropdownText(dropdownName)
  local dropdown = FurC.DropdownData[dropdownName]
  local key = FurC.GetDropdownChoice(dropdownName)
  return dropdown[key]
end

local function getDropdownIndex(dropdownName, value)
  local dropdown = FurC.DropdownData["Choices" .. dropdownName]
  for listKey, listValue in pairs(dropdown) do
    if listValue == value then
      return listKey
    end
  end
  dropdown[#dropdown + 1] = value
  return #dropdown
end

local dropdownData = FurC.DropdownData

-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
-- Character: Accountwide, crafter1, crafter2...
-- Version: All, Homestead, Morrowind
function FurC.SetDropdownChoice(dropdownName, textValue, dropdownIndex)
  textValue = textValue or FurC.GetDefaultDropdownChoice(dropdownName)
  local dropdownIndex = dropdownIndex or getDropdownIndex(dropdownName, textValue) or 0

  FurC.Logger:Verbose("SetDropdownChoice(%s, %s (Index: %s))", dropdownName, textValue, dropdownIndex)

  FurC.DropdownChoices[dropdownName] = dropdownIndex

  if
    dropdownName == "Source"
    and (dropdownIndex == src.CRAFTING or dropdownIndex == src.CRAFTING_KNOWN or dropdownIndex == src.CRAFTING_UNKNOWN)
  then
    FurC.DropdownChoices["Character"] = FurC.GetDefaultDropdownChoice("Character")
    FurC_DropdownCharacter:GetNamedChild("SelectedItemText"):SetText(FurC.GetDropdownChoiceTextual("Character"))
  end

  FurC.DropdownChoices[dropdownName] = dropdownIndex

  zo_callLater(function()
    FurC.UpdateGui()
  end, 500)
end

-- Re-apply default dropdown char once LCK is ready
function FurC.ApplyDefaultCharacter()
  if FurC.RefreshCharacterChoices then
    FurC.RefreshCharacterChoices() -- ensure the list reflects current LCK state
  end
  local source = FurC.GetDropdownChoice("Source")
  if source ~= src.CRAFTING and source ~= src.CRAFTING_KNOWN and source ~= src.CRAFTING_UNKNOWN then
    return
  end
  if FurC.GetDropdownChoice("Character") ~= 1 then
    return -- don't override if specific char is already selected
  end
  local default = FurC.GetDefaultDropdownChoice("Character")
  if default ~= 1 then
    FurC.DropdownChoices["Character"] = default
  end
end

function FurC.GetDefaultDropdownChoiceText(dropdownName)
  return FurC.DropdownData["Choices" .. dropdownName][FurC.GetDefaultDropdownChoice(dropdownName)]
end

---@param dropdownName string
---@return integer
function FurC.GetDefaultDropdownChoice(dropdownName)
  local choices = FurC.DropdownData["Choices" .. dropdownName]
  -- Character stored by NAME, so choice doesn't break when the LCK list changes
  if dropdownName == "Character" then
    local name = FurC.settings.dropdownDefaults.Character
    for i, choice in ipairs(choices or {}) do
      if choice == name then
        return i
      end
    end
    return 1
  end
  local index = FurC.settings.dropdownDefaults[dropdownName]
  if not (index and choices and choices[index]) then
    return 1
  end
  return index
end

function FurC.SetDefaultDropdownChoice(dropdownName, value)
  if dropdownName == "Character" then
    FurC.settings.dropdownDefaults.Character = value
    return
  end
  FurC.settings.dropdownDefaults[dropdownName] = getDropdownIndex(dropdownName, value)
end

function FurC.GetResetDropdownChoice()
  return FurC.settings["resetDropdownChoice"]
end

function FurC.SetResetDropdownChoice(value)
  FurC.settings["resetDropdownChoice"] = value
end

function FurC.GetDropdownChoiceTextual(dropdownName)
  local choices = FurC.DropdownData["Choices" .. dropdownName]
  return choices[FurC.GetDropdownChoice(dropdownName)] or choices[1]
end

function FurC.GetSkipInitialScan()
  return FurC.settings["skipInitialScan"]
end

function FurC.SetSkipInitialScan(value)
  FurC.settings["skipInitialScan"] = value
end

---------------------------------
--- Furnishing Category Filter ---
---------------------------------

local function containsTrue_fc(ary)
  for _, v in pairs(ary) do
    if v then
      return true
    end
  end
end

function FurC.GetFilterFurnCategory()
  return FurC.settings.filterFurnCategory
end

-- categoryId: integer ESO furnitureCategoryId, or 0 to clear/reset
function FurC.SetFilterFurnCategory(categoryId)
  local filterArray = FurC.settings.filterFurnCategory

  if categoryId == 0 then
    for k in pairs(filterArray) do
      filterArray[k] = false
    end
    -- Also clear subcategory when resetting the category
    for k in pairs(FurC.settings.filterFurnSubcategory) do
      FurC.settings.filterFurnSubcategory[k] = false
    end
    FurC.settings.filterFurnCategoryAll = true
    FurC.settings.filterFurnSubcategoryAll = true
  else
    filterArray[categoryId] = not filterArray[categoryId]
    FurC.settings.filterFurnCategoryAll = not containsTrue_fc(filterArray)
  end

  local controls = FurC.GuiElements.categoryFilters
  if controls then
    for key, control in pairs(controls) do
      local isPressed = (key == 0) and FurC.settings.filterFurnCategoryAll or (filterArray[key] == true)
      control:SetState(isPressed and BSTATE_PRESSED or BSTATE_NORMAL)
    end
  end

  FurC.GuiOnScroll(FurCGui_ListHolder_Slider, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end

function FurC.GetFilterFurnSubcategory()
  return FurC.settings.filterFurnSubcategory
end

-- subcategoryId: integer ESO furnitureCategoryId (subcategories share the same ID space), or 0 to clear/reset
function FurC.SetFilterFurnSubcategory(subcategoryId)
  local filterArray = FurC.settings.filterFurnSubcategory

  if subcategoryId == 0 then
    for k in pairs(filterArray) do
      filterArray[k] = false
    end
    FurC.settings.filterFurnSubcategoryAll = true
  else
    filterArray[subcategoryId] = not filterArray[subcategoryId]
    FurC.settings.filterFurnSubcategoryAll = not containsTrue_fc(filterArray)
  end

  FurC.GuiOnScroll(FurCGui_ListHolder_Slider, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end

---------------------------
-------- /Dropdown --------
-------- /Filters  --------
---------------------------

function FurC.GetUseInventoryIcons()
  return FurC.settings["useInventoryIcons"]
end

function FurC.SetUseInventoryIcons(value)
  FurC.settings["useInventoryIcons"] = value
end

function FurC.GetUseInventoryIconsOnChar()
  return FurC.settings["useInventoryIconsOnChar"]
end

function FurC.SetUseInventoryIconsOnChar(value)
  FurC.settings["useInventoryIconsOnChar"] = value
end

function FurC.GetHideKnownInventoryIcons()
  return FurC.settings["hideKnownInventoryIcons"]
end

function FurC.SetHideKnownInventoryIcons(value)
  FurC.settings["hideKnownInventoryIcons"] = value
end

function FurC.GetTinyUi()
  return FurC.settings["useTinyUi"]
end

function FurC.SetTinyUi(value)
  FurC.settings["useTinyUi"] = value
  FurC.SlotTemplate = "FurC_SlotTemplate" .. ((value and "Tiny") or "")
  FurC.ApplyLineTemplate()
end

function FurC.GetListOffset()
  return FurC.ListOffset or 0
end

function FurC.SetListOffset(value)
  FurC.ListOffset = value
end

function FurC.WipeDatabase()
  d("resetting Furniture Catalogue data...")
  FurC.RebuildDB()
end
