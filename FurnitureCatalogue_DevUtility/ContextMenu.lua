local UNITTAG_PLAYER = "player"
local this                                      = FurCDevUtility or {}

local isDev = this.isDev()
if not isDev then return end

FurCDevControl_LinkHandlerBackup_OnLinkMouseUp  = nil
this.textbox                                    = this.textbox or FurCDevControlBox
local textbox                                   = this.textbox

local cachedItemLink
local cachedAchievementName
local cachedName
local cachedPrice
local cachedCanBuy
local cachedIsLetter

local LAM = LibAddonMenu2

local p = this.p

local cachedItemIds = {}


local function showTextbox()
    if not isDev   then return end
    this.control:SetHidden(false)
end
function this.clearControl()
    if not isDev   then return end
    this.textbox:Clear()
    cachedItemIds = {}
    this.control:SetHidden(true)
end
function this.selectEntireTextbox()
    if (not isDev) or this.control:IsHidden() then return end
    local text = textbox:GetText() or ""
    textbox:SetSelection(0, #text)
end
function this.onTextboxTextChanged()
    if not isDev   then return end
    if this.control:IsHidden() then return end
    local text = textbox:GetText() or ""
    if #text > 0 then return end
    this.clearControl()
end

local function getAchievementId(achievementName)
	local results = {}
	if AchievementFinder and achievementName and "" ~= achievementName then
		results = AchievementFinder.FindAchieve(achievementName)
	end
	return (#results == 0 and 0) or results[1]
end

local s2             = "\t"
local s4             = "\t\t"
-- local s_default            = (s2 .. "[%d] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET)," .. s2 .. "-- %s\n")
local s_default            = (s2 .. "[%d] = getCrownPrice(99)," .. s4 .. "   " .. "-- %s")
local s_letter             = (s2 .. "[%d] = rumourSource," .. s4 .. "   " .. "-- %s")
local s_withPrice          = (s2 .. "[%d] = {" .. s4 .. "-- %s\n" .. s4 .. 
	"itemPrice   = %d,\n" .. s2 .. 
"},")
local s_withAchievement    = (s2 .. "[%d] = {" .. s4 .. "--%s\n" .. s4 .. 
	"itemPrice   = %d,\n" .. s4 .. 
	"achievement = %d," .. s4 .. "-- %s\n" .. s2 .. 
"},")
local s_forRecipe          = (s2 .. "%d, -- %s")

local function makeOutput()
    if not cachedItemLink  or not isDev   then return end
	
    local isRecipe      = IsItemLinkFurnitureRecipe(cachedItemLink)
    local debugString   = (isRecipe and s_forRecipe) or s_default
    
    cachedName          = cachedName or GetItemLinkName(cachedItemLink)
    cachedPrice         = cachedPrice or 0 
    
    if 0 < cachedPrice then debugString = s_withPrice end
    if cachedAchievementName and "" ~= cachedAchievementName then debugString = s_withAchievement end
    
    local achievementId = getAchievementId(cachedAchievementName)
    
    if cachedIsLetter then debugString = s_letter end
    if #(textbox:GetText() or "") == 0 then 
        debugString = debugString:sub(#s2+1, #debugString)
	end
    
    return string.format(debugString .. "\n", tonumber(FurC.GetItemId(cachedItemLink)), cachedName, tonumber(cachedPrice), tonumber(achievementId), cachedAchievementName)
end

local function isItemIdCached()
	local itemId = FurC.GetItemId(cachedItemLink) 
    if not itemId then return end
    if cachedItemIds[itemId] then return true end
    cachedItemIds[itemId] = true
    return false
end

local function concatToTextbox()
    if (not isDev) or isItemIdCached() then return end
    local textSoFar = this.textbox:GetText() or ""
    this.textbox:SetText(textSoFar .. makeOutput(itemId))
    showTextbox()
end
function this.concatToTextbox(itemId)
    if itemId then
        cachedItemLink  = FurC.GetItemLink(itemId)
        cachedName      = GetItemLinkName(cachedItemLink)
        cachedPrice     = 0
        concatToTextbox()
	end
end


local function doNothing() return end

local S_ADD_TO_BOX  = "Add data to textbox"
local S_DIVIDER     = "-"
local function addMenuItems()
	AddCustomMenuItem(S_DIVIDER,    doNothing, MENU_ADD_OPTION_LABEL)
	AddCustomMenuItem(S_ADD_TO_BOX, concatToTextbox, MENU_ADD_OPTION_LABEL)
end


function FurCDevControl_HandleClickEvent(itemLink, button, control)    -- button being mouseButton here
    if not isDev   then return end
    
    if (type(itemLink) == 'string' and #itemLink > 0) then
		currentSceneName  = SCENE_MANAGER:GetCurrentScene().name
		cachedCanBuy      = currentSceneName == "store"
		cachedIsLetter    = currentSceneName == "mailInbox"
		cachedItemLink    = itemLink
		cachedName        = GetItemLinkName(cachedItemLink)
		
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
    if not isDev   then return end
    control = control or moc()
	
    local icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToEquip, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, entryType, buyStoreFailure, buyErrorStringId
    
	local st = ZO_InventorySlot_GetType(control)
    cachedItemLink = nil
    if st == SLOT_TYPE_ITEM
		or st == SLOT_TYPE_BANK_ITEM
		or st == SLOT_TYPE_GUILD_BANK_ITEM    
		or st == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then
        local bagId, slotId = ZO_Inventory_GetBagAndIndex(control)
        cachedItemLink = GetItemLink(bagId, slotId, linkStyle)
        name     = GetItemLinkName(cachedItemLink)
        price    = 0
        canBuy   = true
		elseif st == SLOT_TYPE_STORE_BUY then
        local storeEntryIndex = control.index or 0    
        -- _, name, _, price, _, canBuy, _, _, _, 
        -- _, currencyQuantity1, _, currencyQuantity2 = GetStoreEntryInfo(storeEntryIndex)
		
        icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToEquip, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, entryType, buyStoreFailure, buyErrorStringId = GetStoreEntryInfo(storeEntryIndex)
        cachedAchievementName = GetErrorString(buyErrorStringId):gsub("Requires ", ""):gsub(" Achievement to purchase.", "")
		
        cachedItemLink = GetStoreItemLink(storeEntryIndex)
	end
    
    cachedName      = name
    cachedPrice     = price or 0
    cachedCanBuy    = meetsRequirementsToBuy 
    
    if not FurC.Find(cachedItemLink) then return end
    
	zo_callLater(function()
		addMenuItems()
		ShowMenu()
	end, 80)
	
	
end

function this.OnControlMouseUp(control, button)
    if not isDev   then return end
    
	if (not control) or button ~= 2 then return end
	
	if not control.itemLink or #control.itemLink == 0 then return end
    
    cachedItemLink  = control.itemLink
	cachedHasAchievement = ItemTooltip and ItemTooltip:GetNamedChild("Condition") 
	
	zo_callLater(function()
		ItemTooltip:SetHidden(true)
		ClearMenu()
		addMenuItems()
		ShowMenu()
	end, 50)
	
end

function this.InitRightclickMenu()
    if not isDev   then return end
	FurCDevControl_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control)
        FurCDevControl_HandleClickEvent(itemLink, button, control) 
	end
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function(rowControl)
		FurCDevControl_HandleInventoryContextMenu(rowControl)
	end)

	-- TODO Code from Siri, check out
	-- local function UpdateSlotActions(inventorySlot, slotActions)
        -- if IsThisSlotASearchTabItemSlot(inventorySlot) then
            -- slotActions:AddCustomSlotAction(SI_TRADING_HOUSE_REMOVE_PENDING_POST, function()
                -- -- do something
            -- end, "")
        -- end
        -- return false
    -- end

    -- local LCM = LibCustomMenu
    -- LCM:RegisterContextMenu(UpdateSlotActions, LCM.CATEGORY_EARLY)
	
	
end
