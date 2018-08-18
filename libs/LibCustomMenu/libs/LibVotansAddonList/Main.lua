
local LIB_NAME = "LibVotansAddonList"
local addon = LibStub:NewLibrary(LIB_NAME, 1)

if not addon then
	return
	-- already loaded and no upgrade necessary
end

local em = GetEventManager()
local AddOnManager = GetAddOnManager()

function addon:Initialize()
	ZO_ClearTable(ADD_ON_MANAGER.list.dataTypes)
	ZO_ScrollList_AddDataType(ADD_ON_MANAGER.list, 1, "ZO_AddOnRow", 30, ADD_ON_MANAGER:GetRowSetupFunction())
	ADD_ON_MANAGER.isDirty = true
end

local function setupHeaderFunction(control, data)
	control:SetText(data.text)
	control:SetMouseEnabled(false)
end

local function setupDividerFunction(control, data)
	control:SetHeight(30)
end

do
	local LIB_ROW_ID = 2
	local orgSort
	local orgSortScrollList = ZO_AddOnManager.SortScrollList
	local scrollData
	local function newSort(...)
		scrollData = ...
		table.sort = orgSort
	end
	local function sortBySortable(a, b)
		return a.data.sortableName < b.data.sortableName
	end
	local function sortByLib(a, b)
		return a.data.isLibrary == b.data.isLibrary and sortBySortable(a, b) or(not a.data.isLibrary and b.data.isLibrary)
	end
	function ZO_AddOnManager:SortScrollList()
		ZO_ScrollList_AddDataType(self.list, LIB_ROW_ID, "ZO_GameMenu_LabelHeader", 30, setupHeaderFunction)
		ZO_ScrollList_AddDataType(self.list, LIB_ROW_ID + 1, "ZO_DynamicHorizontalDivider", 30, setupDividerFunction)
		orgSort, table.sort = table.sort, newSort
		orgSortScrollList(self)
		table.sort(scrollData, sortByLib)
		local hasLibs = false
		for i = #scrollData, 1, -1 do
			if scrollData[i].data.isLibrary then
				hasLibs = true
			else
				if hasLibs then
					table.insert(scrollData, i + 1, ZO_ScrollList_CreateDataEntry(LIB_ROW_ID, { text = GetString(SI_VOTANS_ADDONLIST_LIBS) }))
					table.insert(scrollData, i + 1, ZO_ScrollList_CreateDataEntry(LIB_ROW_ID + 1, { }))
				end
				break
			end
		end
	end
end

do
	local orgBuildMasterList = ZO_AddOnManager.BuildMasterList
	local function isLibrary(item)
		-- ZOS could know/call this "nested manifest". All nested manifests are libs. Never seen a main addon nesting a main addon.
		-- In case of having the "nested" information: isPatch = depends on one non-nested addon. Else: isLibrary = isNested and not depends on non-nested.
		local data = item.data
		if data.isLibrary == nil then
			data.isLibrary =(LibStub(data.addOnFileName, LibStub.SILENT) or data.addOnFileName:match("^[Ll]ib[%u%d]%a")) ~= nil
		end
	end
	function ZO_AddOnManager:BuildMasterList()
		orgBuildMasterList(self)
		local scrollData = ZO_ScrollList_GetDataList(self.list)
		self.masterList = self.masterList or { }
		local masterList = self.masterList
		ZO_ClearNumericallyIndexedTable(masterList)

		local nameToLib = { }
		local data
		for i = 1, #scrollData do
			isLibrary(scrollData[i])
			data = scrollData[i].data
			masterList[i] = data
			nameToLib[data.addOnFileName] = data
			data.sortableName = data.strippedAddOnName:upper()
			data.expandable = false
		end
		local name, i, dependency, depCount, isPatchFor
		for index = 1, #masterList do
			data = masterList[index]
			i = data.index
			name, depCount = nil, 0
			for j = 1, AddOnManager:GetAddOnNumDependencies(i) do
				dependency = AddOnManager:GetAddOnDependencyInfo(i, j)
				dependency = nameToLib[dependency]
				if dependency and not dependency.isLibrary then
					if not name then
						name = dependency.sortableName
						isPatchFor = dependency
					end
					depCount = depCount + 1
				end
			end

			data.isPatch = depCount >= 1
			if data.isPatch then
				data.isLibrary = false
				data.isPatchFor = isPatchFor
				data.sortableName = string.format("%s-%s", name, data.sortableName)
			end
		end
	end
end

do
	local orgGetRowSetupFunction = ZO_AddOnManager.GetRowSetupFunction
	local WARNING_COLOR = ZO_ColorDef:New("C5C23E")
	local attentionIcon = zo_iconFormatInheritColor(ZO_KEYBOARD_NEW_ICON, 28, 28)

	local function AddLine(tooltip, text, color, alignment)
		local r, g, b = color:UnpackRGB()
		tooltip:AddLine(text, "", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, alignment, alignment ~= TEXT_ALIGN_LEFT)
	end

	local function AddLineCenter(tooltip, text, color)
		if not color then color = ZO_TOOLTIP_DEFAULT_COLOR end
		AddLine(tooltip, text, color, TEXT_ALIGN_CENTER)
	end

	local function AddLineTitle(tooltip, text, color)
		if not color then color = ZO_SELECTED_TEXT end
		local r, g, b = color:UnpackRGB()
		tooltip:AddLine(text, "ZoFontHeader3", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true)
	end

	local function AddLineSubTitle(tooltip, text, color)
		if not color then color = ZO_SELECTED_TEXT end
		local r, g, b = color:UnpackRGB()
		tooltip:AddLine(text, "ZoFontWinH5", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true)
	end

	-- zo_strformat converts the dot in version numbers into comma (localization of decimal numbers, but wrong here)
	local formatDep = GetString(SI_ADDON_MANAGER_DEPENDENCIES):gsub("<<1>>", "%%s")
	local function onMouseEnter(control)
		local data = ZO_ScrollList_GetData(control)
		if not data then return end
		InitializeTooltip(ItemTooltip, control, LEFT, -7, -30, BOTTOMRIGHT)

		ZO_ItemIconTooltip_OnAddGameData(ItemTooltip, TOOLTIP_GAME_DATA_ITEM_ICON, data.isLibrary and "esoui/art/journal/journal_tabicon_cadwell_up.dds" or "esoui/art/inventory/inventory_tabicon_misc_up.dds")

		if data.isLibrary then
			ItemTooltip:AddHeaderLine(zo_strformat(SI_ITEM_FORMAT_STR_TEXT1, GetString(SI_VOTANS_ADDONLIST_LIB)), "ZoFontWinH5", 1, TOOLTIP_HEADER_SIDE_LEFT, ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
		end
		ItemTooltip:AddVerticalPadding(14)
		AddLineTitle(ItemTooltip, data.addOnName)
		ItemTooltip:AddVerticalPadding(-9)
		ZO_Tooltip_AddDivider(ItemTooltip)

		if data.addOnAuthorByLine ~= "" then
			AddLineSubTitle(ItemTooltip, data.addOnAuthorByLine)
		end

		if data.addOnDescription ~= "" then
			AddLineCenter(ItemTooltip, data.addOnDescription)
		end

		if data.isOutOfDate then
			AddLineCenter(ItemTooltip, GetString(SI_VOTANS_ADDONLIST_OUTDATED), WARNING_COLOR)
		end

		if data.hasDependencyError then
			local dependencyText = { }
			local i = data.index
			local dependencyName, dependencyActive
			for j = 1, AddOnManager:GetAddOnNumDependencies(i) do
				dependencyName, dependencyActive = AddOnManager:GetAddOnDependencyInfo(i, j)
				if dependencyName ~= "" and not dependencyActive then
					dependencyName = ZO_ERROR_COLOR:Colorize(dependencyName)
				end
				dependencyText[#dependencyText + 1] = dependencyName
			end
			table.sort(dependencyText)
			AddLineCenter(ItemTooltip, formatDep:format(table.concat(dependencyText, ", ")))
		end

		ZO_ItemIconTooltip_OnAddGameData(ItemTooltip, TOOLTIP_GAME_DATA_STOLEN, false)
	end
	local function onMouseExit(control)
		ClearTooltip(ItemTooltip)
	end

	function ZO_AddOnManager:GetRowSetupFunction()
		local orgSetup = orgGetRowSetupFunction(self)
		local function modify(control, data)
			local indent = data.isPatch and 12 or 0
			local expandButton = control:GetNamedChild("ExpandButton")
			expandButton:SetHidden(true)
			local enableButton = control:GetNamedChild("Enabled")
			enableButton:SetAnchor(TOPLEFT, nil, TOPLEFT, 7 + indent, 7)

			local state = control:GetNamedChild("State")
			state:SetDimensions(28, 28)
			state:ClearAnchors()
			state:SetAnchor(TOPRIGHT, nil, TOPRIGHT, -7, 1)
			local stateText
			-- out-dated libs coming from out-dated main-addons. If an out-dated lib is used by an up-to-date addon, it is still working.
			-- if it is a patch, but its parent is not enabled, show out-of-date warning only.
			if (data.isOutOfDate and not data.isLibrary) or(data.hasDependencyError and(not data.isPatch or(data.isPatch and data.isPatchFor.addOnEnabled))) then
				stateText = attentionIcon
				if not data.hasDependencyError and AddOnManager:GetLoadOutOfDateAddOns() or(data.isPatch and not data.isPatchFor.addOnEnabled) then
					stateText = WARNING_COLOR:Colorize(stateText)
				else
					stateText = ZO_ERROR_COLOR:Colorize(stateText)
				end
			else
				stateText = ""
			end
			state:SetText(stateText)

			local name = control:GetNamedChild("Name")
			name:SetWidth(385 - indent)
			local author = control:GetNamedChild("Author")
			author:SetWidth(372)

			if data.isPatch and not data.isPatchFor.addOnEnabled then
				local color = ZO_DEFAULT_DISABLED_COLOR
				name:SetColor(color:UnpackRGBA())
				author:SetColor(color:UnpackRGBA())
			end

			if not control.votanAddonLib then
				control.votanAddonLib = true
				ZO_PreHookHandler(control, "OnMouseEnter", onMouseEnter)
				ZO_PreHookHandler(control, "OnMouseExit", onMouseExit)
				control:SetMouseEnabled(true)
			end
		end
		local function setupAddonRow(...)
			orgSetup(...)
			return modify(...)
		end
		return setupAddonRow
	end
end

function ZO_AddOnManager:OnExpandButtonClicked(row)
	-- Disabled.
end

ZO_AddOnsLoadOutOfDateAddOnsText:SetText(GetString(SI_ADDON_MANAGER_LOAD_OUT_OF_DATE_ADDONS))

do
	ZO_AddOnsLoadOutOfDateAddOnsText:SetMouseEnabled(true)

	local function showOutOfDateAddonsTooltip()
		ZO_Tooltips_ShowTextTooltip(ZO_AddOnsLoadOutOfDateAddOns, BOTTOM, GetString(SI_VOTANS_ADDONLIST_LOAD_OUT_OF_DATE_ADDONS_DESC))
	end
	ZO_AddOnsLoadOutOfDateAddOns:SetHandler("OnMouseEnter", showOutOfDateAddonsTooltip)
	ZO_AddOnsLoadOutOfDateAddOnsText:SetHandler("OnMouseEnter", showOutOfDateAddonsTooltip)
	ZO_AddOnsLoadOutOfDateAddOns:SetHandler("OnMouseExit", ZO_Tooltips_HideTextTooltip)
	ZO_AddOnsLoadOutOfDateAddOnsText:SetHandler("OnMouseExit", ZO_Tooltips_HideTextTooltip)
end

local function OnAddonLoaded(event, name)
	if name ~= LIB_NAME and name ~= "AddonSelector" then return end
	em:UnregisterForEvent(addon.name, EVENT_ADD_ON_LOADED)
	if name == LIB_NAME then addon:Initialize() end
end

em:RegisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
