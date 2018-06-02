FurCDevControl_LinkHandlerBackup_OnLinkMouseUp  = nil
local this                                      = FurCDevUtility
local S_ADD_TO_BOX                              = "Add to textbox"
local S_SET_TO_BOX                              = "Set textbox to"
this.textbox                                    = this.textbox or FurCDevControlBox
local textbox                                   = this.textbox

function this.clearTextbox()
    this.textbox:Clear()
end

function this.selectEntireTextbox()
    if this.control:IsHidden() then return end
    local text = textbox:GetText() or ""
    textbox:SetSelection(0, #text)
end

local defaultDebugString = "[<<1>>] = <<2>>, -- <<3>>"
local debugStringWithPrice = "[<<1>>] = { -- <<3>>\n\titemPrice = <<2>>,\n\t--achievement = 0, \n},"
local function makeOutput(itemLink, control)
    if not this.active or not FurC.Find(itemLink) then return end
    local itemId = FurC.GetItemId(itemLink)
    local price = 0
    control = control or moc()
    local debugString = defaultDebugString
    if control and control.dataEntry then
        local data = control.dataEntry.data or {}
        if 0 == data.currencyQuantity1 then
            price = data.stackBuyPrice
            debugString = debugStringWithPrice
        else
            price = data.currencyQuantity1
        end
    end
    return zo_strformat(debugString, itemId, price, GetItemLinkName(itemLink))
end

local linebreak = "\n"
local function concatToTextbox(itemLink, control)
    local textSoFar = this.textbox:GetText()
    local entry = linebreak .. makeOutput(itemLink, control)
    this.textbox:SetText(textSoFar .. entry)
end

local function setTextboxTo(itemLink, control)
    this.textbox:Clear()
    this.textbox.setText(makeOutput(itemLink, control))
end


local function addMenuItems(itemLink, control)

	recipeArray = recipeArray or FurC.Find(itemLink)
	if (nil == recipeArray) then return end
	-- ClearMenu()

	AddCustomMenuItem(S_SET_TO_BOX,
		function() concatToTextbox(itemLink, control) end,
		MENU_ADD_OPTION_LABEL
	)
	
	AddCustomMenuItem(S_SET_TO_BOX,
		function() setTextboxTo(itemLink, control) end,
		MENU_ADD_OPTION_LABEL
	)


end

function FurCDevControl_HandleClickEvent(itemLink, button, control)		-- button being mouseButton here
	if (type(itemLink) == 'string' and #itemLink > 0) then
		local handled = LINK_HANDLER:FireCallbacks(LINK_HANDLER.LINK_MOUSE_UP_EVENT, itemLink, button, ZO_LinkHandler_ParseLink(itemLink))
		if (not handled) then
			FurCDevControl_LinkHandlerBackup_OnLinkMouseUp(itemLink, button, control)
			if (button == 2 and itemLink and #itemLink > 0) then
				addMenuItems(itemLink, control)
			end
			ShowMenu(control)
        end
    end
end


function FurCDevControl_HandleMouseEnter(inventorySlot)
	local inventorySlot = moc()

	if nil == inventorySlot or nil == inventorySlot.dataEntry then return end
	local data = inventorySlot.dataEntry.data
	if nil == data then return end

	local bagId, slotIndex = data.bagId, data.slotIndex
	FurC.CurrentLink = GetItemLink(bagId, slotIndex)
	if nil == FurC.CurrentLink then return end

end


-- thanks Randactyl for helping me with the handler :)
function FurCDevControl_HandleInventoryContextMenu(control)

	local st = ZO_InventorySlot_GetType(control)
    local itemLink = nil
    if st == SLOT_TYPE_ITEM
	or st == SLOT_TYPE_BANK_ITEM
	or st == SLOT_TYPE_GUILD_BANK_ITEM
	or st == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then
        local bagId, slotId = ZO_Inventory_GetBagAndIndex(control)
        itemLink = GetItemLink(bagId, slotId, linkStyle)
    end
    if st == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then
        itemLink = GetTradingHouseSearchResultItemLink(ZO_Inventory_GetSlotIndex(control), linkStyle)
    end
    if st == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
        itemLink = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(control), linkStyle)
    end

	local recipeArray = FurC.Find(itemLink)
	-- d(recipeArray)
	if nil == recipeArray then return end

	zo_callLater(function()
		addMenuItems(itemLink, recipeArray)
		ShowMenu()
	end, 50)


end


function FurC.OnControlMouseUp(control, button)

	if nil == control then return end

	if button ~= 2 then return end
	local itemLink = control.itemLink

	if nil == itemLink then return end
	local recipeArray = FurC.Find(itemLink)
	if nil == recipeArray then return end
	zo_callLater(function()
		ItemTooltip:SetHidden(true)
		ClearMenu()
		addMenuItems(itemLink, recipeArray)
		ShowMenu()
	end, 50)

end

function FurC.InitRightclickMenu()
	FurCDevControl_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control) FurCDevControl_HandleClickEvent(itemLink, button, control) end
	ZO_PreHook('ZO_InventorySlot_OnMouseEnter', FurCDevControl_HandleMouseEnter)
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function(rowControl)
		FurCDevControl_HandleInventoryContextMenu(rowControl)
	end)
end
