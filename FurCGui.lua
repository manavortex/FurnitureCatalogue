FurC.SlotTemplate = "FurC_SlotTemplate"
FurC.KnowledgeFilter = "All (Accountwide)"
FurC.SearchString = ""
FurC.ScrollSortUp = true
local task = LibAsync:Create("FurnitureCatalogue_updateLineVisibility")
local otherTask = LibAsync:Create("FurnitureCatalogue_ToggleGui")

local src = FurC.Constants.ItemSources
local lib = FurC.Internal

-- LCK char list can change, we might have to manually update list if they don't show up
function FurC.RefreshCharacterChoices()
  local dd = FurC.DropdownData
  local choices, tooltips = dd.ChoicesCharacter, dd.TooltipsCharacter
  for i = #choices, 1, -1 do
    choices[i] = nil
  end
  for i = #tooltips, 1, -1 do
    tooltips[i] = nil
  end
  choices[1] = GetString(SI_FURC_FILTER_CHAR_OFF)
  tooltips[1] = GetString(SI_FURC_FILTER_CHAR_OFF_TT)
  local names = (lib.LCKAvailable() and lib.GetCharacterNames()) or {}
  for _, name in ipairs(names) do
    choices[#choices + 1] = name
    tooltips[#tooltips + 1] = zo_strformat(GetString(SI_FURC_STRING_RECIPESFORCHAR), name)
  end
  return choices, tooltips
end

function FurC.CalculateMaxLines()
  if not FurCGui_Header then
    return
  end
  FurCGui_ListHolder:SetHeight(FurCGui:GetHeight() - FurCGui_Header:GetHeight())
  FurCGui_ListHolder.maxLines = math.floor((FurCGui_ListHolder:GetHeight()) / FurCGui_ListHolder.lines[1]:GetHeight())
  return FurCGui_ListHolder.maxLines
end

function FurC.CenterFilterBars()
  local bar2 = FurCGui_Header_Bar2
  if bar2 and FurC_QualityFilter and FurC_DropdownSource and FurC_DropdownVersion then
    local barW = bar2:GetWidth()
    local leftEdge = FurC_DropdownSource:GetRight() - bar2:GetLeft()
    local rightEdge = FurC_DropdownVersion:GetLeft() - bar2:GetLeft()
    local filterW = FurC_QualityFilter:GetWidth()
    if filterW == 0 then
      -- resizeToFitDescendents hasn't resolved yet; measure children directly
      local numChildren = FurC_QualityFilter:GetNumChildren()
      for i = 1, numChildren do
        filterW = filterW + FurC_QualityFilter:GetChild(i):GetWidth() + 4
      end
    end
    -- centre sandwiched between left+rigth ctrls
    local minX = leftEdge + 8
    local maxX = rightEdge - filterW - 8
    if maxX < minX then
      maxX = minX
    end
    local centerX = math.max(minX, math.min((barW - filterW) / 2, maxX))
    FurC_QualityFilter:ClearAnchors()
    FurC_QualityFilter:SetAnchor(LEFT, bar2, LEFT, centerX)
  end

  local bar3 = FurCGui_Header_Bar3
  if bar3 and FurC_TypeFilter and FurC_DropdownCharacter and FurC_SearchBox and FurC_ShowRumours then
    local leftEdge = FurC_DropdownCharacter:GetRight() - bar3:GetLeft()
    local rightEdge = FurC_SearchBox:GetLeft() - bar3:GetLeft()
    local filterW = FurC_TypeFilter:GetWidth()
    if filterW == 0 then
      local numChildren = FurC_TypeFilter:GetNumChildren()
      for i = 1, numChildren do
        filterW = filterW + FurC_TypeFilter:GetChild(i):GetWidth() + 4
      end
    end
    local minX = leftEdge + 8
    local maxX = rightEdge - filterW - 8
    if maxX < minX then
      maxX = minX
    end
    local centerX = math.max(minX, math.min((bar3:GetWidth() - filterW) / 2, maxX))
    FurC_TypeFilter:ClearAnchors()
    FurC_TypeFilter:SetAnchor(LEFT, bar3, LEFT, centerX)
  end
end

local function updateLineVisibility()
  local function fillLine(curLine, curData, lineIndex)
    if nil == curLine then
      return
    end

    local dataLines = FurCGui_ListHolder.dataLines
    local maxLines = FurCGui_ListHolder.maxLines

    local hidden = lineIndex > #dataLines or lineIndex > maxLines
    curLine:SetHidden(hidden)
    if nil == curData or curLine:IsHidden() then
      curLine.itemLink = ""
      curLine.itemId = 0
      curLine.blueprint = 0
      curLine.icon:SetTexture(nil)
      curLine.icon:SetAlpha(0)
      curLine.text:SetText("")
      curLine.mats:SetText("")
    else
      local recipeArray = FurC.Find(curData.itemLink)
      if FurC.showBlueprints and recipeArray and recipeArray.blueprint then
        curLine.itemLink = FurC.Utils.GetItemLink(recipeArray.blueprint)
      else
        curLine.itemLink = curData.itemLink
      end
      curLine.itemId = curData.itemId
      curLine.blueprint = curData.blueprint
      curLine.icon:SetTexture(GetItemLinkIcon(curData.itemLink))
      curLine.icon:SetAlpha(1)
      local text = string.gsub(curData.itemLink, "H1", "H0")
      curLine.text:SetText(((FurC.IsFavoriteById(curData.itemId) and "* ") or "") .. text)
      local mats = FurC.GetItemDescription(curData.itemId, curData)
      curLine.mats:SetText(mats)
    end
  end

  local isEmpty = #FurCGui_ListHolder.dataLines == 0

  FurCGui_ListHolder:SetHidden(isEmpty)
  FurCGui_Empty:SetHidden(not isEmpty)

  if isEmpty then
    return
  end

  FurC.CalculateMaxLines()

  local function redrawList()
    local maxLines = FurCGui_ListHolder.maxLines
    local dataLines = FurCGui_ListHolder.dataLines

    local offset = FurCGui_ListHolder_Slider:GetValue()
    if offset > #dataLines then
      offset = 0
    end
    FurCGui_ListHolder_Slider:SetValue(offset)

    local curLine, curData

    for i = 1, FurCGui_ListHolder:GetNumChildren() do
      curLine = FurCGui_ListHolder.lines[i]
      curData = FurCGui_ListHolder.dataLines[offset + i]
      fillLine(curLine, curData, i)
    end
    FurCGui_ListHolder_Slider:SetMinMax(0, #dataLines)
  end

  if nil ~= task then
    task:Call(redrawList)
  else
    redrawList()
  end
end
FurC.UpdateLineVisibility = updateLineVisibility

function FurC.IsLoading(isBuffering)
  if not FurC.guiInitialized then
    return -- GUI not built yet
  end
  FurCGui_Wait:SetHidden(not isBuffering)

  local isEmpty = #FurCGui_ListHolder.dataLines == 0

  FurCGui_ListHolder:SetHidden(isBuffering or isEmpty)
  FurCGui_Empty:SetHidden(isBuffering or not isEmpty)
end

-- Sort index only once (not for each filter)
-- need to rebuild only when sort order changes or DB has itemchanges
local sortedIndex
local sortedIndexKey
FurC.sortIndexDirty = true

-- Sorting 8.4k names costs ~370 ms, mostly for strcoll
-- TODO: revisit if performance sucks too much (numeric/hashed was not a good option because of locale byte order)
local function buildSortedIndex(sortName, sortUp)
  local data = FurC.DB
  local ids, vals = {}, {}
  for itemId, recipeArray in pairs(data) do
    ids[#ids + 1] = itemId
    if sortName == "itemName" then
      vals[itemId] = GetItemLinkName(FurC.Utils.GetItemLink(itemId))
    else
      vals[itemId] = recipeArray[sortName]
    end
  end
  table.sort(ids, function(a, b)
    local va, vb = vals[a], vals[b]
    if nil == va then
      return false
    elseif nil == vb then
      return true
    elseif sortUp then
      return va > vb
    else
      return va < vb
    end
  end)
  return ids
end

local function ensureSortedIndex()
  local sortName, sortDirection = FurC.GetSortParams()
  sortName = sortName or "itemName"
  local sortUp = ((ZO_SORT_ORDER_UP and sortDirection == "up") or ZO_SORT_ORDER_DOWN)
  local key = tostring(sortName) .. "|" .. tostring(sortUp)
  if sortedIndex and key == sortedIndexKey and not FurC.sortIndexDirty then
    return sortedIndex
  end
  sortedIndex = buildSortedIndex(sortName, sortUp)
  sortedIndexKey = key
  FurC.sortIndexDirty = false
  return sortedIndex
end

local function updateScrollDataLinesData()
  local dataLines = {}
  local data = FurC.DB
  local order = ensureSortedIndex()
  for i = 1, #order do
    local itemId = order[i]
    local recipeArray = data[itemId]
    if recipeArray and FurC.MatchFilter(itemId, recipeArray) then
      local itemLink = FurC.Utils.GetItemLink(itemId)
      if itemLink then
        local tempDataLine = ZO_ShallowTableCopy(recipeArray)
        tempDataLine.itemId = itemId
        tempDataLine.itemLink = itemLink
        tempDataLine.blueprint = recipeArray.blueprint
        tempDataLine.itemName = GetItemLinkName(itemLink)
        dataLines[#dataLines + 1] = tempDataLine
      end
    end
  end
  FurCGui_ListHolder.dataLines = dataLines
  FurC_RecipeCount:SetText(tostring(#dataLines))
end

local cachedDefaults
local function startLoading()
  FurC.LastFilter = cachedDefaults
  FurC.SetFilter(cachedDefaults, true)
end
local function stopLoading()
  FurC.IsLoading(false)
  updateLineVisibility()
end

function FurC.UpdateGui(useDefaults)
  if not FurC.guiInitialized or FurCGui:IsHidden() then
    return -- GUI not built yet, or hidden
  end
  FurC.EnsureDB() -- covers windows shown without FurnitureCatalogue_Toggle (benchmarks and stuff)
  cachedDefaults = useDefaults

  if nil ~= otherTask then
    otherTask:Call(startLoading):Then(updateScrollDataLinesData):Then(stopLoading)
  else
    startLoading()
    updateScrollDataLinesData()
    stopLoading()
  end
end

function FurC.UpdateInventoryScroll()
  FurCGui_ListHolder.dataOffset = FurCGui_ListHolder.dataOffset or 0
  FurCGui_ListHolder.dataOffset = math.max(FurCGui_ListHolder.dataOffset, 0)

  FurC.CalculateMaxLines()

  local total = #FurCGui_ListHolder.dataLines - FurCGui_ListHolder.maxLines
  if total > 0 then
    FurCGui_ListHolder_Slider:SetMinMax(0, total)
  end

  updateLineVisibility()
end

function FurC.SetLineHeight(applyTemplate)
  local curLine
  local size = FurC.GetFontSize()

  local nameFont =
    string.format("$(%s)|$(KB_%s)|soft-shadow-thin", (FurC.GetTinyUi() and "MEDIUM_FONT") or "BOLD_FONT", size)
  local matsFont = string.format("$(MEDIUM_FONT)|$(KB_%s)|soft-shadow-thin", size)

  local useTinyUi = FurC.GetTinyUi()
  local lineHeight = size + (useTinyUi and 8 or 20)

  for i = 1, #FurCGui_ListHolder.lines do
    curLine = FurCGui_ListHolder.lines[i]
    if applyTemplate then
      WINDOW_MANAGER:ApplyTemplateToControl(curLine, FurC.SlotTemplate)
    end

    curLine:GetNamedChild("Name"):SetFont(nameFont)
    curLine:GetNamedChild("Mats"):SetFont(matsFont)
    curLine:SetHeight(lineHeight)
    local btnHeight = (useTinyUi and 0 or lineHeight + 3)
    curLine:GetNamedChild("Button"):SetDimensions(btnHeight, btnHeight)
  end
  FurC.CalculateMaxLines()
end

function FurC.ApplyLineTemplate()
  local function resizeDropdowns(controlSize)
    local contRolist = {
      [1] = FurC_DropdownSource,
      [2] = FurC_DropdownCharacter,
      [3] = FurC_DropdownVersion,
      [4] = FurC_Search,
    }
    for _, control in pairs(contRolist) do
      control:SetWidth(controlSize)
    end
  end

  if FurC.GetTinyUi() then
    FurC.SlotTemplate = "FurC_SlotTemplateTiny"
    resizeDropdowns(230)
    FurCGui_Header_SortBar_Description:ClearAnchors()
    FurCGui_Header_SortBar_Description:SetAnchor(TOPLEFT, FurCGui_Header_SortBar_Name, TOPRIGHT, -82)
  else
    FurC.SlotTemplate = "FurC_SlotTemplate"
    resizeDropdowns(300)
    FurCGui_Header_SortBar_Description:ClearAnchors()
    FurCGui_Header_SortBar_Description:SetAnchor(TOPLEFT, FurCGui_Header_SortBar_Name, TOPRIGHT, 0)
  end

  FurC.SetLineHeight(true)

  local categoryBarWidth = FurC_CategoryFilter:GetWidth()
  local minWidth =
    math.max(2 * (FurC_DropdownCharacter:GetWidth()) + FurC_TypeFilter:GetWidth() + 40, categoryBarWidth + 60)
  local minHeight = 2 * FurCGui_Header:GetHeight()
  FurCGui:SetDimensionConstraints(minWidth, minHeight)

  if nil ~= task then
    task:Call(updateLineVisibility)
  else
    updateLineVisibility()
  end
end

local function createGui()
  local function createInventoryScroll()
    FurC.Logger:Debug("CreateInventoryScroll")

    local function createLine(i, predecessor)
      predecessor = predecessor or FurCGui_ListHolder

      ---@type Control
      local line = WINDOW_MANAGER:CreateControlFromVirtual("FurC_ListItem_" .. i, FurCGui_ListHolder, FurC.SlotTemplate)

      line.icon = line:GetNamedChild("Button"):GetNamedChild("Icon")
      line.text = line:GetNamedChild("Name")
      line.mats = line:GetNamedChild("Mats")

      line:SetHidden(false)
      line:SetMouseEnabled(true)

      if i == 1 then
        line:SetAnchor(TOPLEFT, FurCGui_ListHolder, TOPLEFT, 0, 4)
        line:SetAnchor(TOPRIGHT, FurCGui_ListHolder, TOPRIGHT, 0, 0)
      else
        line:SetAnchor(TOPLEFT, predecessor, BOTTOMLEFT, 0, 0)
        line:SetAnchor(TOPRIGHT, predecessor, BOTTOMRIGHT, 0, 0)
      end
      return line
    end

    FurCGui_ListHolder.dataOffset = 0
    FurCGui_ListHolder.maxLines = 60
    FurCGui_ListHolder.dataLines = {}
    FurCGui_ListHolder.lines = {}
    FurCGui_ListHolder.NameSort = FurCGui_Header_SortBar:GetNamedChild("_Name")
    FurCGui_ListHolder.NameSort.icon = FurCGui_ListHolder.NameSort:GetNamedChild("_Button")

    local predecessor
    for i = 1, FurCGui_ListHolder.maxLines do
      FurCGui_ListHolder.lines[i] = createLine(i, predecessor)
      predecessor = FurCGui_ListHolder.lines[i]
    end

    -- setup slider
    FurCGui_ListHolder_Slider:SetMinMax(0, #FurCGui_ListHolder.dataLines - FurCGui_ListHolder.maxLines)

    return FurCGui_ListHolder.lines
  end

  local function createQualityFilters()
    local buttons = {}
    local function createQualityFilter(name, quality, tooltip)
      local parent = FurC_QualityFilter

      local predecessor = buttons[#buttons] or parent
      local controlType = "FurC_QualityFilterButton"

      local button = WINDOW_MANAGER:CreateControlFromVirtual(parent:GetName() .. name, parent, controlType)
      local ctrlName = string.lower(name)
      button:SetNormalTexture(string.format("FurnitureCatalogue/textures/%s_up.dds", ctrlName))
      button:SetMouseOverTexture(string.format("FurnitureCatalogue/textures/%s_over.dds", ctrlName))
      button:SetPressedTexture(string.format("FurnitureCatalogue/textures/%s_down.dds", ctrlName))
      button.quality = quality
      button.tooltip = tooltip

      local otherAnchor = ((predecessor == parent) and LEFT) or RIGHT
      local xOffset = ((predecessor == parent) and 0) or 6
      button:SetAnchor(LEFT, predecessor, otherAnchor, xOffset)

      return button
    end

    buttons[1] = createQualityFilter("All", ITEM_FUNCTIONAL_QUALITY_TRASH, "All Items")
    buttons[2] = createQualityFilter("White", ITEM_FUNCTIONAL_QUALITY_NORMAL, "White quality")
    buttons[3] = createQualityFilter("Magic", ITEM_FUNCTIONAL_QUALITY_MAGIC, "Magic quality")
    buttons[4] = createQualityFilter("Arcane", ITEM_FUNCTIONAL_QUALITY_ARCANE, "Superior quality")
    buttons[5] = createQualityFilter("Artifact", ITEM_FUNCTIONAL_QUALITY_ARTIFACT, "Epic quality")
    buttons[6] = createQualityFilter("Legendary", ITEM_FUNCTIONAL_QUALITY_LEGENDARY, "Legendary quality")

    FurC.GuiElements.qualityButtons = buttons
  end

  local function createCraftingTypeFilters()
    local buttons = {}

    local function createCraftingTypeFilter(craftingType, textureName)
      local parent = FurC_TypeFilter
      local predecessor = buttons[#buttons] or parent

      local name = parent:GetName() .. "Button" .. tostring(craftingType)

      local button = WINDOW_MANAGER:CreateControlFromVirtual(name, parent, "FurC_CraftingTypeFilterButton")

      button:SetNormalTexture(string.format("%s%s", textureName, "_up.dds"))
      button:SetMouseOverTexture(string.format("%s%s", textureName, "_over.dds"))
      button:SetPressedTexture(string.format("%s%s", textureName, "_down.dds"))
      button.craftingType = craftingType
      button.tooltip = (craftingType > 0 and GetCraftingSkillName(craftingType))
        or GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALL)

      local otherAnchor = ((predecessor == parent) and TOPLEFT) or TOPRIGHT
      button:SetAnchor(TOPLEFT, predecessor, otherAnchor, 0)

      return button
    end

    buttons[CRAFTING_TYPE_INVALID] =
      createCraftingTypeFilter(CRAFTING_TYPE_INVALID, "esoui/art/inventory/inventory_tabicon_all")
    buttons[CRAFTING_TYPE_BLACKSMITHING] = createCraftingTypeFilter(
      CRAFTING_TYPE_BLACKSMITHING,
      "esoui/art/inventory/inventory_tabicon_craftbag_blacksmithing"
    )
    buttons[CRAFTING_TYPE_CLOTHIER] =
      createCraftingTypeFilter(CRAFTING_TYPE_CLOTHIER, "esoui/art/inventory/inventory_tabicon_craftbag_clothing")
    buttons[CRAFTING_TYPE_ENCHANTING] =
      createCraftingTypeFilter(CRAFTING_TYPE_ENCHANTING, "esoui/art/inventory/inventory_tabicon_craftbag_enchanting")
    buttons[CRAFTING_TYPE_ALCHEMY] =
      createCraftingTypeFilter(CRAFTING_TYPE_ALCHEMY, "esoui/art/inventory/inventory_tabicon_craftbag_alchemy")
    buttons[CRAFTING_TYPE_WOODWORKING] =
      createCraftingTypeFilter(CRAFTING_TYPE_WOODWORKING, "esoui/art/inventory/inventory_tabicon_craftbag_woodworking")
    buttons[CRAFTING_TYPE_JEWELRYCRAFTING] = createCraftingTypeFilter(
      CRAFTING_TYPE_JEWELRYCRAFTING,
      "esoui/art/inventory/inventory_tabicon_craftbag_jewelrycrafting"
    )
    buttons[CRAFTING_TYPE_PROVISIONING] = createCraftingTypeFilter(
      CRAFTING_TYPE_PROVISIONING,
      "esoui/art/inventory/inventory_tabicon_craftbag_provisioning"
    )

    FurC.GuiElements.craftingTypeFilters = buttons
  end

  local function createCategoryFilters()
    local buttons = {}
    local ordered = {} -- sequential list purely for left-to-right anchoring

    local function createCategoryFilter(categoryId, textureName, tooltipText)
      local parent = FurC_CategoryFilter
      local predecessor = ordered[#ordered] or parent

      local name = parent:GetName() .. "Button" .. tostring(categoryId)
      local button = WINDOW_MANAGER:CreateControlFromVirtual(name, parent, "FurC_CategoryFilterButton")

      button:SetNormalTexture(string.format("%s_up.dds", textureName))
      button:SetMouseOverTexture(string.format("%s_over.dds", textureName))
      button:SetPressedTexture(string.format("%s_down.dds", textureName))
      button.categoryId = categoryId
      button.tooltip = tooltipText

      local otherAnchor = ((predecessor == parent) and TOPLEFT) or TOPRIGHT
      button:SetAnchor(TOPLEFT, predecessor, otherAnchor, 4)

      buttons[categoryId] = button
      ordered[#ordered + 1] = button
      return button
    end

    local iconBase = "/esoui/art/treeicons/housing_indexicon_"

    -- categoryId 0 = "All" sentinel, must be first
    createCategoryFilter(
      0,
      "esoui/art/inventory/inventory_tabicon_all",
      GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALL)
    )

    createCategoryFilter(25, "/esoui/art/treeicons/collection_indexicon_assistants", "Services")
    createCategoryFilter(12, iconBase .. "conservatory", "Conservatory")
    createCategoryFilter(6, iconBase .. "courtyard", "Courtyard")
    createCategoryFilter(5, iconBase .. "dining", "Dining")
    createCategoryFilter(9, iconBase .. "gallery", "Gallery")
    createCategoryFilter(8, iconBase .. "hearth", "Hearth")
    createCategoryFilter(4, iconBase .. "library", "Library")
    createCategoryFilter(11, iconBase .. "shrine", "Lighting")
    createCategoryFilter(14, iconBase .. "misc", "Miscellaneous")
    createCategoryFilter(3, iconBase .. "parlor", "Parlor")
    createCategoryFilter(13, iconBase .. "structures", "Structures")
    createCategoryFilter(2, iconBase .. "suite", "Suite")
    createCategoryFilter(7, iconBase .. "undercroft", "Undercroft")
    createCategoryFilter(10, iconBase .. "workshop", "Workshop")

    FurC.GuiElements.categoryFilters = buttons
  end

  local function createInventoryDropdown(dropdownName)
    local controlName = string.format("%s%s", "FurC_Dropdown", dropdownName)
    local control = _G[controlName]
    local dropdownData = FurC.DropdownData
    local validChoices = dropdownData[string.format("%s%s", "Choices", dropdownName)]
    local choicesTooltips = dropdownData[string.format("%s%s", "Tooltips", dropdownName)]
    local comboBox

    control.comboBox = control.comboBox or ZO_ComboBox_ObjectFromContainer(control)
    comboBox = control.comboBox

    local function HideTooltip()
      ClearTooltip(InformationTooltip)
    end

    -- ruthlessly stolen from LAM
    local function SetupTooltips(comboBox, choicesTooltips)
      local function ShowTooltip(control)
        InitializeTooltip(InformationTooltip, control, TOPRIGHT, -10, 0, TOPLEFT)
        SetTooltipText(InformationTooltip, control.tooltip)
        InformationTooltipTopLevel:BringWindowToTop()
      end

      -- allow for tooltips on the drop down entries
      local originalShow = comboBox.ShowDropdownInternal
      comboBox.ShowDropdownInternal = function(comboBox)
        originalShow(comboBox)
        local entries = ZO_Menu.items
        for key, entry in pairs(entries) do
          local control = entry.item
          control.tooltip = choicesTooltips[key]
          if control.tooltip then
            entry.onMouseEnter = control:GetHandler("OnMouseEnter")
            entry.onMouseExit = control:GetHandler("OnMouseExit")
            ZO_PreHookHandler(control, "OnMouseEnter", ShowTooltip)
            ZO_PreHookHandler(control, "OnMouseExit", HideTooltip)
          end
        end
      end

      local originalHide = comboBox.HideDropdownInternal
      comboBox.HideDropdownInternal = function(self)
        local entries = ZO_Menu.items
        for key, entry in pairs(entries) do
          local control = entry.item
          control:SetHandler("OnMouseEnter", entry.onMouseEnter)
          control:SetHandler("OnMouseExit", entry.onMouseExit)
          control.tooltip = nil
        end
        HideTooltip()
        originalHide(self)
      end
    end

    function OnItemSelect(control, choiceText, somethingElse)
      local dropdownName = tostring(control.m_name):gsub("FurC_Dropdown", "")
      FurC.SetDropdownChoice(dropdownName, choiceText)
      HideTooltip()
      PlaySound(SOUNDS.POSITIVE_CLICK)
    end

    comboBox:SetSortsItems(false)

    if dropdownName == "Character" then
      validChoices = FurC.RefreshCharacterChoices()
    end

    comboBox:ClearItems()
    for _, val in pairs(validChoices) do
      comboBox:AddItem(comboBox:CreateItemEntry(val, OnItemSelect))
      if val == FurC.GetDropdownChoiceTextual(dropdownName) then
        comboBox:SetSelectedItem(val)
      end
    end

    SetupTooltips(comboBox, dropdownData["Tooltips" .. dropdownName])

    if dropdownName == "Character" then
      local available = lib.LCKAvailable()
      comboBox:SetEnabled(available)
      local hint = (available and SI_FURC_STRING_CHARACTER_USES_LCK) or SI_FURC_STRING_CHARACTER_NEEDS_LCK
      control:SetMouseEnabled(true)
      control:SetHandler("OnMouseEnter", function(self)
        InitializeTooltip(InformationTooltip, self, TOPRIGHT, -10, 0, TOPLEFT)
        SetTooltipText(InformationTooltip, GetString(hint))
      end)
      control:SetHandler("OnMouseExit", function()
        ClearTooltip(InformationTooltip)
      end)
    end

    return control
  end

  createInventoryScroll()
  createQualityFilters()
  createCraftingTypeFilters()
  createCategoryFilters()
  createInventoryDropdown("Source")
  createInventoryDropdown("Version")
  createInventoryDropdown("Character")
  FurC.RefreshCharacterDropdown = function()
    createInventoryDropdown("Character")
    -- keep the settings default char dropdown in sync
    if FurC_DefaultCharDropdown then
      FurC_DefaultCharDropdown:UpdateChoices(
        FurC.DropdownData.ChoicesCharacter,
        nil,
        FurC.DropdownData.TooltipsCharacter
      )
    end
  end
  FurC.ChangeTemplateFromButton(FurC.GetTinyUi())
  FurC.SetFontSize(FurC.GetFontSize())
  FurC.LoadFrameInfo()
  FurC.InitFilters()
  FurC.UpdateDropdowns()

  -- reanchor it once
  FurC.SetHideUIButton(src.RUMOUR, FurC.GetHideUIButton(src.RUMOUR))
  FurC.UpdateHeader()
end

function FurC.UpdateHeader()
  local hideRumourButton = FurC.GetHideUIButton(src.RUMOUR)
  local showRumours = FurC.GetShowRumours()

  FurC_ShowRumours:SetHidden(hideRumourButton)
  FurC_ShowRumoursGlow:SetHidden(not showRumours or hideRumourButton)

  if not hideRumourButton then
    FurC_ShowRumours:SetState((showRumours and BSTATE_PRESSED) or BSTATE_NORMAL, false)
  end

  local hideCrownButton = FurC.GetHideUIButton(src.CROWN)

  FurC_ShowCrowns:SetHidden(hideCrownButton)
  if hideCrownButton then
    return
  end

  FurC_ShowCrowns:SetState((FurC.GetShowCrownstore() and BSTATE_PRESSED) or BSTATE_NORMAL, false)
end

function FurnitureCatalogue_Toggle()
  SCENE_MANAGER:ToggleTopLevel(FurCGui)
  if FurCGui:IsHidden() then
    return
  end

  FurC.EnsureDB()
  FurCGui_Empty:SetHidden(true)
  zo_callLater(function()
    FurC.UpdateGui(FurC.GetResetDropdownChoice())
  end, 500)
end

function FurnitureCatalogue_ToggleRecipeDisplay()
  FurC.showBlueprints = not FurC.showBlueprints
  local currentLine = moc()
  if not currentLine then
    return
  end
  FurC.GuiLineOnMouseExit(currentLine)
  updateLineVisibility()
  FurC.GuiLineOnMouseEnter(currentLine)
end

function FurC.InitGui()
  local control = FurCGui
  local settings = FurC.settings["gui"]
  FurC.GuiElements = {}
  if nil ~= control then
    control:SetHeight(settings.height)
    control:SetWidth(settings.width)
  end

  createGui()
  FurC.guiInitialized = true -- NOW it exists

  local slider = FurCGui_ListHolder_Slider
  slider:SetMinMax(1, #FurCGui_ListHolder.dataLines)

  FurC.UpdateGui(FurC.GetResetDropdownChoice())

  FurC_Label:GetNamedChild("_2"):SetText(GetString(SI_FURC_LABEL_ENTRIES))

  SCENE_MANAGER:RegisterTopLevel(FurCGui, false)
end
