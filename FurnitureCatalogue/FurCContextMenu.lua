FurC_LinkHandlerBackup_OnLinkMouseUp = nil

local FURC_S_SHOPPINGLIST_1 = GetString(SI_FURC_ONE_TO_SHOPPINGLIST)
local FURC_S_SHOPPINGLIST_5 = GetString(SI_FURC_FIVE_TO_SHOPPINGLIST)
local FURC_S_TOGGLE_SL = GetString(SI_FURC_TOGGLE_SHOPPINGLIST)

function AddFurnitureShoppingListMenuEntry(itemId, calledFromFurC)
	if calledFromFurC then
		if (not FurC.GetEnableShoppingList()) then return end
		if (nil ==	moc()) or (nil == FurnitureShoppingListAdd) then return end
		local controlName = moc():GetName() or ""
		if nil == moc():GetName():match("_ListItem_") then return end
	end
	local itemLink = FurC.GetItemLink(itemId)
	if nil == FurC.Find(itemLink) then return end
	AddCustomMenuItem(FURC_S_SHOPPINGLIST_1, 
		function() 
			FurnitureShoppingListAdd(itemLink) 			
		end,	
	MENU_ADD_OPTION_LABEL)
	AddCustomMenuItem(FURC_S_SHOPPINGLIST_5, 
		function() 
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
		end,	
	MENU_ADD_OPTION_LABEL)
	AddCustomMenuItem(FURC_S_TOGGLE_SL, 
		function() 
			FurnitureShoppingListWindow_Toggle()			
		end,	
	MENU_ADD_OPTION_LABEL)	

end

local function addMenuItems(itemLink, recipeArray)
	
	recipeArray = recipeArray or FurC.Find(itemLink)
	if (nil == recipeArray) then return end
	-- ClearMenu()
	
	AddCustomMenuItem(GetString(SI_FURC_MENU_HEADER), 
		function() FurC.ToChat(itemLink) end, 
		MENU_ADD_OPTION_LABEL
	)
	local faveText = FurC.IsFavorite(itemLink, recipeArray) and GetString(SI_FURC_REMOVE_FAVE) or GetString(SI_FURC_ADD_FAVE)
	AddCustomMenuItem(faveText, 
		function() FurC.Fave(itemLink, recipeArray) end, 
		MENU_ADD_OPTION_LABEL
	)
	
	if recipeArray.origin ~= FURC_CRAFTING then		
		AddCustomMenuItem(GetString(SI_FURC_POST_ITEMSOURCE), 
			function() FurC.PrintSource(itemLink, recipeArray) end,	
			MENU_ADD_OPTION_LABEL
		)		
	else
		if nil ~= recipeArray.blueprint then 
			AddCustomMenuItem(GetString(SI_FURC_POST_RECIPE), 
			function() FurC.ToChat(FurC.GetItemLink(recipeArray.blueprint)) end,	
				MENU_ADD_OPTION_LABEL
			)		
		end
		AddCustomMenuItem(GetString(SI_FURC_POST_MATERIAL), 
			function() FurC.ToChat(itemLink .. ": " .. FurC.GetMats(itemLink, recipeArray, true)) end, 
			MENU_ADD_OPTION_LABEL
		)
		AddFurnitureShoppingListMenuEntry(itemLink, true)
	end
	-- ShowMenu() 
	
end

function FurC_HandleClickEvent(itemLink, button, control)		-- button being mouseButton here
	if (type(itemLink) == 'string' and #itemLink > 0) then
		local handled = LINK_HANDLER:FireCallbacks(LINK_HANDLER.LINK_MOUSE_UP_EVENT, itemLink, button, ZO_LinkHandler_ParseLink(itemLink))
		if (not handled) then	
			FurC_LinkHandlerBackup_OnLinkMouseUp(itemLink, button, control)		
			if (button == 2 and itemLink ~= '') then
				addMenuItems(itemLink, FurC.Find(itemLink))			            
			end 			
			ShowMenu(control)
        end
    end	
end


function FurC_HandleMouseEnter(inventorySlot)
	local inventorySlot = moc()
	
	if nil == inventorySlot or nil == inventorySlot.dataEntry then return end
	local data = inventorySlot.dataEntry.data
	if nil == data then return end	
	
	local bagId, slotIndex = data.bagId, data.slotIndex
	FurC.CurrentLink = GetItemLink(bagId, slotIndex)
	if nil == FurC.CurrentLink then return end
	
end


-- thanks Randactyl for helping me with the handler :)
function FurC_HandleInventoryContextMenu(control)
	
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
	FurC_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control) FurC_HandleClickEvent(itemLink, button, control) end
	ZO_PreHook('ZO_InventorySlot_OnMouseEnter', FurC_HandleMouseEnter)
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function(rowControl) 
		FurC_HandleInventoryContextMenu(rowControl) 
	end)
end

