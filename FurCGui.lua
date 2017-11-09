FurC.SlotTemplate		= "FurC_SlotTemplate"
FurC.KnowledgeFilter 	= "All (Accountwide)"
FurC.SearchString 		= ""
FurC.ScrollSortUp 		= true
local checkWasUpdated	= false
local task = LibStub("LibAsync"):Create("FurnitureCatalogue_ScanDataFiles")

local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end




local function matchFilter(recipeArray)		
	return FurC.MatchFilter(recipeArray)
end

-- ruthlessly stolen from TextureIt
local function sortTable(tTable, sortKey, SortOrderUp)
	local keys = {}
	for k in pairs(tTable) do table.insert(keys, k) end
	table.sort(keys, function(a, b)  
		if nil == tTable[a] or nil == tTable[b] then
			
		elseif nil == tTable[a][sortKey] then
			d(tTable[a])
		elseif nil == tTable[b][sortKey] then
			d(tTable[b])
		else
		if SortOrderUp then 
			return tTable[a][sortKey] > tTable[b][sortKey] 
		else
			return tTable[a][sortKey] < tTable[b][sortKey] 
		end
		end
		
	end)
	
	local ret = {}
	local scannedLinks = {}
	local itemLink, entry
	for _, k in ipairs(keys) do 
		entry = tTable[k]
		-- d(entry)
		itemLink = entry["itemLink"]
		ingredients = entry["ingredients"]
		local index = scannedLinks[itemLink] or k
		
		table.insert(ret, entry)		
	end
	
	return ret
end

function FurC.SortTable(tTable, sortKey, SortOrderUp)
	return sortTable(tTable, sortKey, SortOrderUp)
end

function FurC.Sort(myTable)	
	local sortName, sortDirection = FurC.GetSortParams()	
	sortName = sortName or "itemName"
	local sortUp = ((ZO_SORT_ORDER_UP and sortDirection == "up") or ZO_SORT_ORDER_DOWN)	
	return sortTable(myTable, sortName, sortUp)		
end


local headerHeight = FurCGui_Header:GetHeight()

function FurC.CalculateMaxLines()
	FurCGui_ListHolder:SetHeight(FurCGui:GetHeight() - headerHeight)
	FurCGui_ListHolder.maxLines = math.floor((FurCGui_ListHolder:GetHeight()) / FurCGui_ListHolder.lines[1]:GetHeight() ) 
	return FurCGui_ListHolder.maxLines
end

local function updateLineVisibility()
	FurC.CalculateMaxLines()
	
	local function fillLine(curLine, curData, lineIndex)
	
		if nil == curLine then return end
		
		curLine:SetHidden(lineIndex > FurCGui_ListHolder.maxLines)
		
		if curData == nil then
			curLine.itemLink = ""
			curLine.icon:SetTexture(nil)
			curLine.icon:SetAlpha(0)
			curLine.text:SetText("")
			curLine.mats:SetText("")
		else
			local r, g, b, a = 255, 255, 255, 1
			if (curData.itemQuality) then
				color = GetItemQualityColor(curData.itemQuality)
				r, g, b, a = color:UnpackRGBA()
			end
			curLine.itemLink = curData.itemLink
			curLine.icon:SetTexture(curData.icon)
			curLine.icon:SetAlpha(1)
			local text = zo_strformat(SI_TOOLTIP_ITEM_NAME, curData.itemName)
			local mats = zo_strformat(curData.itemMats)
			curLine.text:SetText((curData.isFavorite and "* " or "").. text)
			curLine.text:SetColor(r, g, b, a)
			curLine.mats:SetText(mats)
		end
	end
	
	local offset = FurCGui_ListHolder.dataOffset or 0
	local curLine, curData
	
	for i=1, FurCGui_ListHolder:GetNumChildren() do
		curLine = FurCGui_ListHolder.lines[i]
		curData = FurCGui_ListHolder.dataLines[offset + i]
		fillLine(curLine, curData, i)			
	end
	FurCGui_ListHolder_Slider:SetMinMax(1, #FurCGui_ListHolder.dataLines)
	FurC.IsLoading(false)
end
function FurC.UpdateLineVisibility()
	updateLineVisibility()
end

function FurC.IsLoading(isBuffering)
	FurCGui_ListHolder:SetHidden(isBuffering)
	FurCGui_Wait:SetHidden(not isBuffering)
end
-- fill the shown item list with items that match current filter(s)
local function updateScrollDataLinesData(useDefaults, calledRecursively)
	task:Call(function() 
		FurC.IsLoading(true)
	end)
	:Then(function() 
		
		local index = 0
		
		FurC.LastFilter = useDefaults
		FurC.SetFilter(useDefaults)
	
		local seenLinks = {}
		
		data = FurC.settings.data
		
		local dataLines = {}
		-- async:For(pairs(data)):Do( function(itemId, item)
		for itemId, item in pairs(data) do
			seenLinks[item.itemLink] = item.itemLink
			if FurC.MatchFilter(item, refreshedControl) then			
				tempDataLine = {
					itemLink	= item.itemLink, 	
					icon 		= item.iconFile,
					itemName 	= item.itemName or GetItemLinkName(iLink),					
					itemMats	= FurC.GetMats(iLink, false, true, item),
					itemQuality	= item.itemQuality,
					filter		= filterType,
					isFavorite	= item.favorite
				}			
				table.insert(dataLines, tempDataLine)		
			end
		end
		-- end)
		
		if dataLines == {} and FurC.GetDropdownChoice("Character") > 1 and not calledRecursively then
			FurC.ScanRecipeFile()
			return updateScrollDataLinesData(useDefaults, true)
		end
				
		dataLines = FurC.Sort(dataLines)
		FurCGui_ListHolder.dataLines = dataLines
		FurC_RecipeCount:SetText(#dataLines)
		if #dataLines < FurCGui_ListHolder.maxLines then 
			FurCGui_ListHolder.dataOffset = 0
		else
			FurCGui_ListHolder.dataOffset = math.min(FurCGui_ListHolder_Slider:GetValue(), (#dataLines - FurCGui_ListHolder.maxLines))
		end		
		if refreshFilter then 		
			FurCGui_Empty:SetHidden(#dataLines > 0)			
		end			
	end)
	:Then(function() updateLineVisibility() end)
end

function FurC.UpdateGui(useDefaults)
	if FurCGui:IsHidden() then return end
	updateScrollDataLinesData(useDefaults)	
end

function FurC.UpdateInventoryScroll()
	local index = 0
	
	FurCGui_ListHolder.dataOffset = math.max((FurCGui_ListHolder.dataOffset or 0), FurCGui_ListHolder.dataOffset)
	------------------------------------------------------
	if (FurCGui_ListHolder.dataOffset < 0) then 
		FurCGui_ListHolder.dataOffset = 0
	end
	
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
		
	local nameFont = "$(".. ((FurC.GetTinyUi() and "MEDIUM_FONT") or "BOLD_FONT") ..")|$(KB_"..size..")|soft-shadow-thin"
	local matsFont = "$(MEDIUM_FONT)|$(KB_"..size..")|soft-shadow-thin" 

	for i = 1, #FurCGui_ListHolder.lines do	
		curLine = FurCGui_ListHolder.lines[i]
		if applyTemplate then
			WINDOW_MANAGER:ApplyTemplateToControl(curLine, FurC.SlotTemplate)
		end
		curLine:GetNamedChild("Name"):SetFont(nameFont)
		curLine.mats:SetFont(matsFont)
		curLine:SetHeight( size + (FurC.GetTinyUi() and 8 or 20))
	end
	FurC.CalculateMaxLines()
end

function FurC.ApplyLineTemplate()	

	local function resizeDropdowns(controlSize)
		local controlList = {
			[1] = FurC_DropdownSource,
			[2] = FurC_DropdownCharacter,
			[3] = FurC_DropdownVersion
		}
		for _, control in pairs(controlList) do
			control:SetWidth(controlSize)
		end
		FurC_Search:SetWidth(controlSize-19)
	end
	if FurC.GetTinyUi() then 
		FurC.SlotTemplate = "FurC_SlotTemplateTiny"
		resizeDropdowns(230) -- first column width: 230
		FurCGui_Header_SortBar_Quality:ClearAnchors()
		FurCGui_Header_SortBar_Quality:SetAnchor(TOPLEFT, FurCGui_Header_SortBar_Name, TOPRIGHT, -82)			
	else
		FurC.SlotTemplate = "FurC_SlotTemplate"
		resizeDropdowns(300) -- first column width: 280
		FurCGui_Header_SortBar_Quality:ClearAnchors()
		FurCGui_Header_SortBar_Quality:SetAnchor(TOPLEFT, FurCGui_Header_SortBar_Name, TOPRIGHT, 0)		
	end	
	
	FurC.SetLineHeight(true)
	
	local minWidth 	= 2*(FurC_DropdownCharacter:GetWidth()) + FurC_TypeFilter:GetWidth() + 40
	local minHeight = 2*FurCGui_Header:GetHeight()
	FurCGui:SetDimensionConstraints(minWidth, minHeight)
	
	task:Call(function() updateLineVisibility() end)
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

local addedDropdownCharacterNames = {}

local function createInventoryDropdown(dropdownName)
	local controlName 		= "FurC_Dropdown"..dropdownName
	local control 			= _G[tostring(controlName)]
	local dropdownData 		= FurnitureCatalogue.DropdownData
	local validChoices 		= dropdownData["Choices"..dropdownName]
	local choicesTooltips 	= dropdownData["Tooltips"..dropdownName]
	local comboBox	
	if control.comboBox ~= nil then
		comboBox = control.comboBox
	else
		comboBox = ZO_ComboBox_ObjectFromContainer(control)
		control.comboBox = comboBox
	end
	
	-- ruthlessly stolen from LAM
	local function SetupTooltips(comboBox, choicesTooltips)
		local function ShowTooltip(control)
			InitializeTooltip(InformationTooltip, control, TOPRIGHT, -10, 0, TOPLEFT)
			SetTooltipText(InformationTooltip, control.tooltip)
			InformationTooltipTopLevel:BringWindowToTop()
		end
		local function HideTooltip(control)
			ClearTooltip(InformationTooltip)
		end

		-- allow for tooltips on the drop down entries
		local originalShow = comboBox.ShowDropdownInternal
		comboBox.ShowDropdownInternal = function(comboBox)
			originalShow(comboBox)
			local entries = ZO_Menu.items
			for i = 1, #entries do
				local entry = entries[i]
				local control = entries[i].item
				control.tooltip = choicesTooltips[i]
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
			for i = 1, #entries do
				local entry = entries[i]
				local control = entries[i].item
				control:SetHandler("OnMouseEnter", entry.onMouseEnter)
				control:SetHandler("OnMouseExit", entry.onMouseExit)
				control.tooltip = nil
			end
			originalHide(self)
		end
	end

	function OnItemSelect(control, choiceText, somethingElse)
		local dropdownName = tostring(control.m_name):gsub("FurC_Dropdown", "")
		FurC.SetDropdownChoice(dropdownName, choiceText)
	  	PlaySound(SOUNDS.POSITIVE_CLICK)
	end

	comboBox:SetSortsItems(false)
	local originalShow = comboBox.ShowDropdownInternal	

	if dropdownName == "Character" then
		for _, characterName in ipairs(FurC.GetAccountCrafters()) do		
			addedDropdownCharacterNames[characterName] = true
			table.insert(validChoices, characterName)
			table.insert(dropdownData["Tooltips"..dropdownName], zo_strformat("<<1>>'s recipes", characterName))
		end
	end

	for i = 1, #validChoices do 
		entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect)
		comboBox:AddItem(entry)
		if validChoices[i] == FurC.GetDropdownChoiceTextual(dropdownName) then
			comboBox:SetSelectedItem(validChoices[i])
		end
	end
	
	SetupTooltips(comboBox, dropdownData["Tooltips"..dropdownName])
	
	return control
end

function FurC.RefreshGuiDropdown()

	local validChoices = FurC.DropdownChoices
	local comboBox = FurC_Dropdown.comboBox

	local characters = FurC.GetAccountCrafters()
	if nil ~= characters then
		for _, characterName in ipairs(characters) do    	
			if characterName and not addedDropdownCharacterNames[characterName] then
				entry = comboBox:CreateItemEntry(validChoices[i], OnItemSelect)		
				comboBox:AddItem(entry)
			end
		end	
	end	
	
end

local function createQualityFilters()
	local buttons = {}
	local quality = 0
	local function createQualityFilter(name, color, tooltip)
		local parent 		= FurC_QualityFilter
		
		local predecessor 	= buttons[#buttons] or parent
		local controlType	= "FurC_QualityFilterButton"
		
		local button 		= WINDOW_MANAGER:CreateControlFromVirtual(parent:GetName()..name, parent, controlType)
		button:SetNormalTexture(	"FurnitureCatalogue/textures/" .. string.lower(name) .. "_up.dds")
		button:SetMouseOverTexture(	"FurnitureCatalogue/textures/" .. string.lower(name) .. "_over.dds")
		button:SetPressedTexture(	"FurnitureCatalogue/textures/" .. string.lower(name) .. "_down.dds")
		button.quality 		= quality
		button.tooltip 		= tooltip	
		

		local otherAnchor 		= ((predecessor == parent) and LEFT) or RIGHT
		local xOffset		= ((predecessor == parent) and 0) or 6
		button:SetAnchor(LEFT, predecessor, otherAnchor, xOffset)
		quality = quality +1
		
		return button
		
	end

	
	buttons[quality+1]	= createQualityFilter("All", 		nil, 					"All Items")
	
	buttons[quality+1]	= createQualityFilter("White", 		ITEM_QUALITY_NORMAL, 	"White quality")
	buttons[quality+1]	= createQualityFilter("Magic", 		ITEM_QUALITY_MAGIC, 	"Magic quality")
	buttons[quality+1]	= createQualityFilter("Arcane", 	ITEM_QUALITY_ARCANE, 	"Superior quality")
	buttons[quality+1]	= createQualityFilter("Artifact",	ITEM_QUALITY_ARTIFACT, 	"Epic quality")
	buttons[quality+1]	= createQualityFilter("Legendary",  ITEM_QUALITY_LEGENDARY, "Legendary qualiry")
	
	FurC.GuiElements.qualityButtons = buttons
	
end

local function createCraftingTypeFilters()
	local buttons = {}
	
	local function createCraftingTypeFilter(craftingType, textureName)
		local parent 				= FurC_TypeFilter
		local predecessor 			= buttons[#buttons] or parent
		
		local name 					= parent:GetName() .. "Button" .. tostring(craftingType)
		
		local button 				= WINDOW_MANAGER:CreateControlFromVirtual(name, parent, "FurC_CraftingTypeFilterButton")
		
		button:SetNormalTexture(	textureName .. "_up.dds")
		button:SetMouseOverTexture(	textureName .. "_over.dds")
		button:SetPressedTexture(	textureName .. "_down.dds")
		button.craftingType 		= craftingType	
		button.tooltip 				= craftingType > 0 and GetCraftingSkillName(craftingType) or GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALL)
		
		local otherAnchor 			= ((predecessor == parent) and TOPLEFT) or TOPRIGHT
		button:SetAnchor(TOPLEFT, predecessor, otherAnchor, 0)
		
		return button
		
	end
	
	buttons[CRAFTING_TYPE_INVALID]			= createCraftingTypeFilter(CRAFTING_TYPE_INVALID, 			"esoui/art/inventory/inventory_tabicon_all")	
	buttons[CRAFTING_TYPE_BLACKSMITHING]	= createCraftingTypeFilter(CRAFTING_TYPE_BLACKSMITHING, 	"esoui/art/inventory/inventory_tabicon_craftbag_blacksmithing")
	buttons[CRAFTING_TYPE_CLOTHIER]			= createCraftingTypeFilter(CRAFTING_TYPE_CLOTHIER, 			"esoui/art/inventory/inventory_tabicon_craftbag_clothing")
	buttons[CRAFTING_TYPE_WOODWORKING]		= createCraftingTypeFilter(CRAFTING_TYPE_WOODWORKING, 		"esoui/art/inventory/inventory_tabicon_craftbag_woodworking")
	buttons[CRAFTING_TYPE_ENCHANTING]		= createCraftingTypeFilter(CRAFTING_TYPE_ENCHANTING,		"esoui/art/inventory/inventory_tabicon_craftbag_enchanting")
	buttons[CRAFTING_TYPE_ALCHEMY]			= createCraftingTypeFilter(CRAFTING_TYPE_ALCHEMY, 			"esoui/art/inventory/inventory_tabicon_craftbag_alchemy")
	buttons[CRAFTING_TYPE_PROVISIONING]		= createCraftingTypeFilter(CRAFTING_TYPE_PROVISIONING, 		"esoui/art/inventory/inventory_tabicon_craftbag_provisioning")
	
	FurC.GuiElements.craftingTypeFilters 	= buttons
	
end

local function createLine(i, predecessor)
	
	predecessor = predecessor or FurCGui_ListHolder
	
	local line = WINDOW_MANAGER:CreateControlFromVirtual("FurC_ListItem_".. i, FurCGui_ListHolder, FurC.SlotTemplate)
	line.icon 	= line:GetNamedChild("Button"):GetNamedChild("Icon")
	line.text 	= line:GetNamedChild("Name")
	line.mats 	= line:GetNamedChild("Mats")

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

local function createInventoryScroll()
	-- FurC.DebugOut("CreateInventoryScroll")

	FurCGui_ListHolder.dataOffset = 0
	FurCGui_ListHolder.maxLines = 60
	FurCGui_ListHolder.dataLines = {}
	FurCGui_ListHolder.lines = {}
	FurCGui_ListHolder.NameSort = FurCGui_Header_SortBar:GetNamedChild("_Name")
	FurCGui_ListHolder.NameSort.icon = FurCGui_ListHolder.NameSort:GetNamedChild("_Button")
	FurCGui_ListHolder.QualitySort = FurCGui_Header_SortBar:GetNamedChild("_Quality")
	FurCGui_ListHolder.QualitySort.icon = FurCGui_ListHolder.QualitySort:GetNamedChild("_Button")

	--local width = 250 -- FurCGui_ListHolder:GetWidth()
	local text = "       No Collected Data"

	for i=1, FurCGui_ListHolder.maxLines do
		FurCGui_ListHolder.lines[i] = createLine(i, predecessor)
		predecessor = FurCGui_ListHolder.lines[i]
	end

	-- setup slider
	FurCGui_ListHolder_Slider:SetMinMax(0, #FurCGui_ListHolder.dataLines - FurCGui_ListHolder.maxLines)

	return FurCGui_ListHolder.lines
end

function FurnitureCatalogue_Toggle()
	SCENE_MANAGER:ToggleTopLevel(FurCGui)
	if FurCGui:IsHidden() then return end
	FurC.UpdateGui(FurC.GetResetDropdownChoice())
	FurCGui_ListHolder_Slider:SetValue(1)
end


function FurC.InitGui()
		
	local control = FurCGui 
	local settings = FurC.settings["gui"]
	FurC.GuiElements = {}
	if nil ~= control then 		
		control:SetHeight(settings.height)
		control:SetWidth(settings.width)		
	end

	createInventoryScroll()
	createQualityFilters()
	createCraftingTypeFilters()
	createInventoryDropdown("Source")	
	createInventoryDropdown("Version")	
	createInventoryDropdown("Character")
	FurC.ChangeTemplateFromButton(FurC.GetTinyUi())
	FurC.SetFontSize(FurC.GetFontSize())
	FurC.LoadFrameInfo()
	FurC.InitFilters()
	
	local slider = FurCGui_ListHolder_Slider
	slider:SetMinMax(1, #FurCGui_ListHolder.dataLines)
	
	
	SCENE_MANAGER:RegisterTopLevel(FurCGui, false)
end