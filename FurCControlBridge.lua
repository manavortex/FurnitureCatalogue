local FurC 		= FurnitureCatalogue
local control 	= FurnitureCatalogueControl
FurC.Visible	= false

local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")

local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end


function FurC.LoadFrameInfo(calledFrom)
	local settings = FurC.settings.gui

	FurCGui:ClearAnchors()
	FurCGui:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, settings.lastX, settings.lastY)

	FurCGui:SetWidth(settings.width)
	FurCGui:SetHeight(settings.height)

	if calledFrom then return end
	zo_callLater(function() FurC.UpdateInventoryScroll() end, 100)

end

function FurC.SaveFrameInfo(calledFrom)
	local settings = FurC.settings["gui"]

	settings.lastX	= FurCGui:GetLeft()
	settings.lastY	= FurCGui:GetTop()
	settings.width	= FurCGui:GetWidth()
	settings.height	= FurCGui:GetHeight()

  FurC.UpdateInventoryScroll()

end

function FurC.OnResizeStop()

	FurC.SaveFrameInfo()
	FurC.UpdateLineVisibility()
	FurC.UpdateInventoryScroll()

end

function FurC.ChangeTemplateFromButton(value)

	local control = FurCGui_Header_Bar1_TemplateLarge
	local otherControl = FurCGui_Header_Bar1_TemplateTiny

	if value then
		otherControl  = FurCGui_Header_Bar1_TemplateLarge
		control       = FurCGui_Header_Bar1_TemplateTiny
	end
	control:SetHidden(true)
	otherControl:SetHidden(false)

	FurC.SetTinyUi(value)
end

function FurC.GUIButtonHideOnMouseUp()
	FurCGui:SetHidden(true)
end

local function forceRefresh()
	FurC.WipeDatabase()
end

function FurC.GUIButtonRefreshOnMouseUp(control, mouseButton)
	if mouseButton == 1 then
		FurC.ScanRecipes(false, true)
	elseif mouseButton == 2 then
		FurC.ScanRecipes(true, false)
	elseif mouseButton == 3 then
		if LAM and LAM.util then
			LAM.util.ShowConfirmationDialog(
				GetString(SI_FURC_DIALOGUE_RESET_DB_HEADER),
				GetString(SI_FURC_DIALOGUE_RESET_DB_BODY),
				forceRefresh
			)
		end
	end
end

function FurC.GuiShowTooltip(control, tooltiptext, reAnchor)
	InitializeTooltip(InformationTooltip, control, BOTTOM, 0, 0, 0)
	InformationTooltip:SetHidden(false)
	InformationTooltip:ClearLines()
	InformationTooltip:AddLine(tooltiptext)

	if reAnchor then
		InformationTooltip:ClearAnchors()
		InformationTooltip:SetAnchor(TOPRIGHT, control, TOPLEFT, -10)
	end
end
function FurC.GuiHideTooltip(control)
	InformationTooltip:ClearLines()
	InformationTooltip:SetHidden(true)
end

function FurC.GuiOnSearchBoxClick(control, mouseButton, doubleClick)
	FurC_SearchBoxText:SetText("")
	if mouseButton == 2 or doubleClick then
		control:SetText("")
	end
end
function FurC.GuiOnSearchBoxFocusOut(control)
    control = control or FurC_SearchBox
	local text = control:GetText()
    FurC_SearchBoxText:SetText((#text == 0 and FURC_S_FILTERDEFAULT) or "")
	FurC.RefreshFilters()
end

function FurC.GuiOnScroll(control, delta)
	if not delta then return end
	if delta == 0 then return end

	local slider = FurCGui_ListHolder_Slider
	-- negative delta means scrolling down

	local value = (FurCGui_ListHolder.dataOffset - delta)
	local total = #FurCGui_ListHolder.dataLines - FurCGui_ListHolder.maxLines

	if value < 0 then value = 0 end
	if value > total then value = total end
	FurCGui_ListHolder.dataOffset  = value

	FurC.UpdateInventoryScroll()

	slider:SetValue(FurCGui_ListHolder.dataOffset)

	FurC.GuiLineOnMouseEnter(moc())
end

function FurC.GuiOnSliderUpdate(slider, value)
	if not value or slider and slider.locked then return end
	local relativeValue = math.floor(FurCGui_ListHolder.dataOffset - value)
	FurC.GuiOnScroll(slider, relativeValue)
end

function FurC.GuiShowFilterTooltip(control, label)
	label = control.tooltip or label
	FurC.GuiShowTooltip(control, label)
end
local currentLink, currentId


function FurC.GuiLineOnMouseEnter(lineControl)
	currentLink, currentId = nil

	if not lineControl or not lineControl.itemLink or lineControl.itemLink == "" then return end
	currentLink = lineControl.itemLink
	currentId = lineControl.itemId

	if nil == currentLink then return end

	InitializeTooltip(ItemTooltip, lineControl, LEFT, 0, 0, 0)
	ItemTooltip:SetLink(currentLink)
end
function FurC.GuiLineOnMouseExit(lineControl)
	ItemTooltip:SetHidden(true)
end

function FurC.Donate(control, mouseButton)

	local amount = 2000
	if mouseButton == 2 then
		amount = 10000
	elseif mouseButton == 3 then
		amount = 25000
	end

	SCENE_MANAGER:Show('mailSend')
	zo_callLater(function()
	ZO_MailSendToField:SetText("@manavortex")
	ZO_MailSendSubjectField:SetText("Thank you for Furniture Catalogue!")
	QueueMoneyAttachment(amount)
	ZO_MailSendBodyField:TakeFocus() end, 200)
end

function FurC.OnControlDoubleClick(control)
	FurC.ToChat(control.itemLink)
end


function FurC.GuiVirtualMouseOver(control)
	FurC.GuiShowTooltip(control, control.tooltip)
end
function FurC.GuiVirtualMouseOut(control)
	FurC.GuiHideTooltip(control)
end


function FurC.GuiQualityMouseUp(control, button)
if button == 2 then FurC.SetFilterQuality(0) end
	FurC.SetFilterQuality(control.quality)
end
function FurC.GuiCraftingTypeMouseUp(control)
	FurC.SetFilterCraftingType(control.craftingType)
end


local sortBy		= nil
local sortDirection = "down"

local function getButtonTex(key)
	if key ~= sortBy then
		return "esoui/art/miscellaneous/list_sortheader_icon_neutral.dds"
	end
	return "esoui/art/miscellaneous/list_sortheader_icon_sort" .. sortDirection .. ".dds"
end

function FurC.GetSortParams()
	return sortBy, sortDirection
end

function FurC.GuiOnSort(key)

	-- set icon texture
	if sortBy and sortBy == key then
		sortDirection = ((sortDirection == "up" and "down") or "up")
	else
		sortBy = key
		sortDirection = "up"
	end

	FurCGui_Header_SortBar_Name_Button:SetNormalTexture(getButtonTex("itemName"))
	FurCGui_Header_SortBar_Quality_Button:SetNormalTexture(getButtonTex("itemQuality"))

	FurC.UpdateGui()
end


function FurC.UpdateDropdownChoice(dropdownName, value)
	if nil == dropdownName then
		FurC.UpdateDropdownChoice("Version", value)
		FurC.UpdateDropdownChoice("Character", value)
		FurC.UpdateDropdownChoice("Source", value)
		return
	end
	InformationTooltip:SetHidden(true)
	value = value or FurC.GetDropdownChoiceTextual(dropdownName)

	local controlName 	= "FurC_Dropdown"..dropdownName
	local control 		= _G[controlName]
	if nil == control then return end
	control:GetNamedChild("SelectedItemText"):SetText(value)
end

function FurC.RefreshCounter()
	FurC_RecipeCount:SetText(#FurCGui_ListHolder.dataLines)
end
