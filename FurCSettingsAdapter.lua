local task     = LibAsync:Create("FurnitureCatalogue_Settings")
local p     = FurC.DebugOut -- debug function calling zo_strformat with up to 10 args

function FurC.GetEnableDebug()
  return FurC.settings["enableDebug"]
end
function FurC.SetEnableDebug(value)
  FurC.settings["enableDebug"] = value
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
  if not buttonIdentifier == FURC_RUMOUR then return end
  
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

function FurC.GetSkipDivider()
  return FurC.settings["skipDivider"]
end
function FurC.SetSkipDivider(value)
  FurC.settings["skipDivider"] = value
end

function FurC.GetFilterAllOnTextNoBooks()
  return FurC.settings["filterAllOnTextNoBooks"]
end
function FurC.GetFilterAllOnTextNoBooks(value)
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
  if nil == value then value = FurC.GetFontSize() end
  if value == 0 then value = 18 end
  FurC.settings["fontSize"] = value

  local size = tostring(value)


  FurC.SetLineHeight()

  task:Call(function()  FurC.UpdateGui() end)
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

---------------------------
-------- /Tooltip ---------
---------------------------


---------------------------
------- IconDisplay -------
---------------------------

function FurC.GetShowIconOnLeft()
  return FurC.settings["showIconOnLeft"] == nil or
       FurC.settings["showIconOnLeft"] == true
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
    if value then return true end
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
    for key, value in pairs (filterArray) do
      FurC.settings.filterQuality[key] = false
    end
  else
    filterArray[quality] = not filterArray[quality]
  end
  FurC.settings.filterQualityAll = not containsTrue(filterArray)

  for key, control in pairs (controls) do
    control:SetState((filterArray[key-1] and BSTATE_PRESSED) or BSTATE_NORMAL)
  end
  FurC.GuiOnScroll(nil, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end

function FurC.GetFilterCraftingType()
  return FurC.settings.filterCraftingType
end
function FurC.SetFilterCraftingType(craftingType)

  local controls     =   FurC.GuiElements.craftingTypeFilters
  local filterArray   =   FurC.settings.filterCraftingType

  if craftingType == 0 then
    for key, value in pairs (filterArray) do
      filterArray[key] = false
    end
  else
    filterArray[craftingType] = not filterArray[craftingType]
  end

  FurC.settings.filterCraftingTypeAll = not containsTrue(filterArray)

  for key, control in pairs (controls) do
    control:SetState((filterArray[key] and BSTATE_PRESSED) or BSTATE_NORMAL)
  end

  FurC.GuiOnScroll(FurCGui_ListHolder_Slider, 0)
  FurC.SetFilter()
  FurC.UpdateGui()
end


local FURC_S_FILTERDEFAULT = GetString(SI_FURC_TEXTBOX_FILTER_DEFAULT)

function FurC.GetSearchFilter()
  if (not FurC.SearchFilter) or FurC.SearchFilter == FURC_S_FILTERDEFAULT then
    FurC.SearchFilter = FurC_SearchBox:GetText() or ""
  end
  return FurC.SearchFilter or ""
end

local alreadySearching  = false
local alreadyReset      = false
local function resetSearch()
    alreadySearching = false
    alreadyReset     = false
end 
local lastText = ""
local function doSearchOnUpdate()
    
    if alreadyReset then return end
    if alreadySearching then 
        zo_callLater(resetSearch, 200)
        return   
    end
    local text = FurC_SearchBox:GetText()
    if #lastText ~= #text then
      lastText = text
      FurC.SearchFilter = text

      FurC.GuiOnSliderUpdate(FurCGui_ListHolder_Slider, 0)
      FurC.UpdateGui()
    end
end

function FurC.GuiSetSearchboxTextFrom(control)
    control = control or FurC_SearchBox
  -- call asynchronely to prevent lagging. Praise votan.
  
  task:Call(doSearchOnUpdate)
  
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
  FurC_ShowRumours:SetState((value and BSTATE_PRESSED) or BSTATE_DISABLED)
  FurC_ShowRumoursGlow:SetHidden(not value)
  FurC.UpdateGui()
end

function FurC.GetShowCrownstore()
  return FurC.settings["showCrowns"]
end
function FurC.SetShowCrownstore(value)
  FurC.settings["showCrowns"] = value
  FurC_ShowCrowns:SetState((value and BSTATE_PRESSED) or BSTATE_DISABLED)
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
  local dropdown = FurC.DropdownData["Choices"..dropdownName]
  for listKey, listValue in pairs(dropdown) do
    if listValue == value then return listKey end
  end
  dropdown[#dropdown+1] = value
  return #dropdown
end


local dropdownData = FurC.DropdownData

-- Source: All, All (craftable), Craftable (known), craftable (unknown), purchaseable
-- Character: Accountwide, crafter1, crafter2...
-- Version: All, Homestead, Morrowind
function FurC.SetDropdownChoice(dropdownName, textValue, dropdownIndex)
  textValue = textValue or FurC.GetDefaultDropdownChoice(dropdownName)
  local dropdownIndex = dropdownIndex or getDropdownIndex(dropdownName, textValue) or 0

  -- p("FurC.SetDropdownChoice(<<1>>, <<2>> (Index: <<3>>))", dropdownName, textValue, dropdownIndex)

  -- if we're setting the dropdown menu "source" to "purchaseable", set "character" to "All"
  FurC.DropdownChoices[dropdownName] = dropdownIndex

  if dropdownName == "Source" then
    if dropdownIndex > FURC_CRAFTING_UNKNOWN or dropdownIndex < FURC_CRAFTING then
      FurC.DropdownChoices["Character"] = 1
      FurC_DropdownCharacter:GetNamedChild("SelectedItemText"):SetText(FurnitureCatalogue.DropdownData.ChoicesCharacter[1])
    end
  end
  -- if we're setting the characters array to something other than 1, we can't use source 1 or 5
  if dropdownName == "Character" and (dropdownIndex > 1) then
    if FurC.DropdownChoices["Source"] > FURC_CRAFTING_UNKNOWN or FurC.DropdownChoices["Source"] < FURC_CRAFTING then
      local knownIndex = FURC_CRAFTING_KNOWN
      FurC.DropdownChoices["Source"] = knownIndex
      FurC_DropdownSource:GetNamedChild("SelectedItemText"):SetText(FurnitureCatalogue.DropdownData.ChoicesSource[knownIndex])
    end
  end

  FurC.DropdownChoices[dropdownName] = dropdownIndex

  zo_callLater(function() FurC.UpdateGui() end, 500)

end

function FurC.GetDefaultDropdownChoiceText(dropdownName)
  return FurC.DropdownData["Choices"..dropdownName][FurC.GetDefaultDropdownChoice(dropdownName)]
end

function FurC.GetDefaultDropdownChoice(dropdownName)
  return FurC.settings.dropdownDefaults[dropdownName]
end
function FurC.SetDefaultDropdownChoice(dropdownName, value)
  local dropdownIndex = getDropdownIndex(dropdownName, value)
  local dropdown = FurC.DropdownData["Choices"..dropdownName]
  FurC.settings.dropdownDefaults[dropdownName] = dropdownIndex
  -- FurC.UpdateDropdownChoice(dropdownName, value, dropdownIndex)
  -- FurC.UpdateGui()
end
function FurC.GetResetDropdownChoice()
  return FurC.settings["resetDropdownChoice"]
end
function FurC.SetResetDropdownChoice(value)
  FurC.settings["resetDropdownChoice"] = value
end

function FurC.GetDropdownChoiceTextual(dropdownName)
  local value = FurC.GetDropdownChoice(dropdownName)
  local dropdown = FurC.DropdownData["Choices"..dropdownName]
  return FurC.DropdownData["Choices"..dropdownName][value]
end
function FurC.GetDefaultDropdownChoiceTextual()
  return FurC.DropdownData["Choices"..dropdownName][FurC.GetDefaultDropdownChoice(dropdownName)]
end

function FurC.GetAccountCrafters()
  local ret = {}
  for characterName, isCrafter in pairs(FurC.settings.accountCharacters) do
    if isCrafter then table.insert(ret, characterName) end
  end
  return ret
end
function FurC.GetAccountCharacters()
  local ret = {}
  for characterName, isCrafter in pairs(FurC.settings.accountCharacters) do
    table.insert(ret, characterName)
  end
  return ret
end

function FurC.GetSkipInitialScan()
  return FurC.settings["skipInitialScan"]
end
function FurC.SetSkipInitialScan(value)
  FurC.settings["skipInitialScan"] = value
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
  FurC.settings["useTinyUi"]   = value
  FurC.SlotTemplate       = "FurC_SlotTemplate" .. ((value and "Tiny") or "")
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
  FurC.settings.data = {}
  FurC.settings.accountCharacters = {}
  FurC.settings.excelExport = {}
  FurC.ScanRecipes(true, true)
  -- d("FurnitureCatalogue: Scan complete")
end

function FurC.DeleteCharacter(characterName)

  d("Now deleting recipe knowledge for " .. characterName)

  for key, value in pairs(FurC.settings.accountCharacters) do
    if value == characterName then
      FurC.settings.accountCharacters[key] = false
    end
  end

  for recipeKey, recipeArray in pairs(FurC.settings.data) do
    if recipeArray.craftable then
      recipeArray.characters[characterName] = nil
    end
  end

  local guiDropdownEntries = FurC_Dropdown.comboBox.m_sortedItems
  if nil == guiDropdownEntries then return end
  for index, data in pairs(guiDropdownEntries) do
    if data.name == characterName then
      FurC_Dropdown.comboBox.m_sortedItems[index] = nil
      return
    end
  end
  d(zo_strformat("<<1>> deleted from |c2266ffFurniture Catalogue|r database. Entry will disappear from settings dropdown after the next reloadui.", characterName))

end

function FurC.GetCurrentCharacterName()
  if nil == FurC.CharacterName then FurC.CharacterName = zo_strformat(GetUnitName('player')) end
  return FurC.CharacterName
end

