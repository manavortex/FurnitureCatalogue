FurCDevControl_LinkHandlerBackup_OnLinkMouseUp  = nil
local this                                      = FurCDevUtility
this.textbox                                    = this.textbox or FurCDevControlBox
local textbox                                   = this.textbox

local cachedItemLink
local cachedControl
local cachedName
local cachedPrice
local cachedCanBuy

local p = this.p

local cachedItemIds = {}

local function showTextbox()
    this.textbox:GetParent():SetHidden(false)
    this.textbox:SetHidden(false)
end
function this.clearControl()
    this.textbox:Clear()
    ZO_ClearTable(cachedItemIds)
end

function this.selectEntireTextbox()
    if this.control:IsHidden() then return end
    local text = textbox:GetText() or ""
    textbox:SetSelection(0, #text)
end

local defaultDebugString = "[<<1>>] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- <<3>>"
local debugStringWithPrice = "[<<1>>] = { -- <<3>>\n\titemPrice = <<2>>, \n},"
local debugStringWithAchievement = "[<<1>>] = { -- <<3>>\n\titemPrice = <<2>>,\n\t--achievement = 0, \n},"
local function makeOutput()     

    local debugString = defaultDebugString
    
    if cachedPrice and 0 < cachedPrice then 
        debugString = debugStringWithPrice 
    else
    
    end
    if not cachedCanBuy then debugString = debugStringWithAchievement end    
    return zo_strformat(debugString, FurC.GetItemId(cachedItemLink), cachedPrice, cachedName)
end

local function isItemIdCached()
    local itemId = FurC.GetItemId(cachedItemLink)
    if cachedItemIds[itemId] then return true end
    cachedItemIds[itemId] = true
    return false
end

local linebreak = "\n"
local function concatToTextbox()
    if isItemIdCached() then return end
    local textSoFar = this.textbox:GetText() or ""
    textSoFar = (#textSoFar > 0 and textSoFar .. linebreak) or textSoFar
    this.textbox:SetText(textSoFar .. makeOutput())
    showTextbox()
end

local S_ADD_TO_BOX = "Add data to textbox"
local function addMenuItems()	    
	AddCustomMenuItem(S_ADD_TO_BOX, concatToTextbox, MENU_ADD_OPTION_LABEL)
end

function FurCDevControl_HandleClickEvent(itemLink, button, control)		-- button being mouseButton here
   cachedItemLink = itemLink
    cachedControl = control
    if (type(itemLink) == 'string' and #itemLink > 0) then
		local handled = LINK_HANDLER:FireCallbacks(LINK_HANDLER.LINK_MOUSE_UP_EVENT, itemLink, button, ZO_LinkHandler_ParseLink(itemLink))
		if (not handled) then
			FurCDevControl_LinkHandlerBackup_OnLinkMouseUp(itemLink, button, control)
        -- end
			if (button == 2 and itemLink and #itemLink > 0) then
				addMenuItems()
			end
			ShowMenu(control)
        end
    end
end



-- thanks Randactyl for helping me with the handler :)
function FurCDevControl_HandleInventoryContextMenu(control)
    control = control or moc()
    local name, price, meetsRequirementsToBuy, currencyQuantity1, currencyQuantity2
    
	local st = ZO_InventorySlot_GetType(control)
    cachedItemLink = nil
    if st == SLOT_TYPE_ITEM
	or st == SLOT_TYPE_BANK_ITEM
	or st == SLOT_TYPE_GUILD_BANK_ITEM    
	or st == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then
        local bagId, slotId = ZO_Inventory_GetBagAndIndex(control)
        cachedItemLink = GetItemLink(bagId, slotId, linkStyle)
        name     = GetItemLinkName(cachedItemLink)
        price    = nil
    elseif st == SLOT_TYPE_STORE_BUY then
        local storeEntryIndex = control.index or 0    
        _, name, _, price, _, meetsRequirementsToBuy, _, _, _, 
        _, currencyQuantity1, _, currencyQuantity2 = GetStoreEntryInfo(storeEntryIndex)
        cachedItemLink = GetStoreItemLink(storeEntryIndex)
    end
    
    cachedControl   = control
    cachedName      = name
    cachedPrice     = price
    cachedCanBuy    = meetsRequirementsToBuy
    
    if not FurC.Find(cachedItemLink) then return end
    
	zo_callLater(function()
		addMenuItems()
		ShowMenu()
	end, 50)


end



function FurCDevUtility.OnControlMouseUp(control, button)
    
	if (not control) or button ~= 2 then return end

	if not control.itemLink or #control.itemLink == 0 then return end
    
    cachedItemLink  = control.itemLink
    cachedControl   = control    
    
	zo_callLater(function()
		ItemTooltip:SetHidden(true)
		ClearMenu()
		addMenuItems()
		ShowMenu()
	end, 50)

end

function FurCDevUtility.InitRightclickMenu()
	FurCDevControl_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control)
        FurCDevControl_HandleClickEvent(itemLink, button, control) 
    end
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function(rowControl)
		FurCDevControl_HandleInventoryContextMenu(rowControl)
	end)
end
