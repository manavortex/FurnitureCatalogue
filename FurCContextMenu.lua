FurC_LinkHandlerBackup_OnLinkMouseUp = nil

function AddFurnitureShoppingListMenuEntry(itemLink, calledFromFurC)
	if calledFromFurC then
		if (not FurC.GetEnableShoppingList()) then return end
		if (nil ==	moc()) or (nil == FurnitureShoppingListAdd) then return end
		local controlName = moc():GetName() or ""
		if nil == moc():GetName():match("_ListItem_") then return end
	end
	if nil == FurC.Find(itemLink) then return end
	AddCustomMenuItem(" Add 1 to shopping list", 
		function() 
			FurnitureShoppingListAdd(itemLink) 			
		end,	
	MENU_ADD_OPTION_LABEL)	
	AddCustomMenuItem(" Add 5 to shopping list", 
		function() 
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
			FurnitureShoppingListAdd(itemLink) 			
		end,	
	MENU_ADD_OPTION_LABEL)
	AddCustomMenuItem(" Toggle shopping list", 
		function() 
			FurnitureShoppingListWindow_Toggle()			
		end,	
	MENU_ADD_OPTION_LABEL)	

end

local function addMenuItems(recipeArray)
	
	if (nil == recipeArray) then return end
	-- ClearMenu()	
	local itemLink = recipeArray.itemLink
	local itemType, sItemType = GetItemLinkItemType(itemLink)
	if not (IsItemLinkPlaceableFurniture(itemLink) or IsItemLinkFurnitureRecipe(itemLink)) then return end
	
	AddCustomMenuItem("- |cD3B830Furniture|r:", 
		function() FurC.ToChat(itemLink) end, 
		MENU_ADD_OPTION_LABEL
	)
	local faveText = FurC.IsFavorite(itemLink, recipeArray) and " Remove Favorite" or " Add Favorite"
	AddCustomMenuItem(faveText, 
		function() FurC.Fave(itemLink, recipeArray) end, 
		MENU_ADD_OPTION_LABEL
	)
	
	if not recipeArray.craftable then		
		AddCustomMenuItem(" Post item source", 
			function() FurC.PrintSource(itemLink, recipeArray) end,	
			MENU_ADD_OPTION_LABEL
		)		
	elseif (recipeArray.craftable) then
		if nil == recipeArray.blueprint then 
			AddCustomMenuItem(" Post recipe", 
			function() FurC.PrintRecipe(itemLink, recipeArray) end,	
				MENU_ADD_OPTION_LABEL
			)
		else
			AddCustomMenuItem(" Post recipe", 
			function() FurC.ToChat(recipeArray.blueprint) end,	
				MENU_ADD_OPTION_LABEL
			)
		end
		AddCustomMenuItem(" Post material only", 
			function() FurC.PrintMats(itemLink, nil, nil, recipeArray, true) end, 
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
				addMenuItems(FurC.Find(itemLink))			            
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
	
	local bagId, slotIndex = data["bagId"], data["slotIndex"]
	if slotIndex == lastSlot then 
		FurC.CurrentLink = nil
		else
		
		FurC.CurrentLink = GetItemLink(bagId, slotIndex)
	end
	if nil == FurC.CurrentLink then return end
	lastSlot = slotIndex
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
	if nil == recipeArray then return end  

	zo_callLater(function() 
		addMenuItems(recipeArray)	
		ShowMenu()
	end, 50)

	
end


function FurC.OnControlMouseUp(control, button)
	
	if nil == control then return end
	if button ~= 2 then return end
	local itemLink = control.itemLink
	if nil == itemLink then return end
	local ary = FurC.Find(itemLink)
	if nil == ary then return end
	zo_callLater(function() 
		ItemTooltip:SetHidden(true)
		ClearMenu()
		addMenuItems(ary)	
		ShowMenu()
	end, 50)	
	
end

function FurC.InitRightclickMenu()
	FurC_LinkHandlerBackup_OnLinkMouseUp = ZO_LinkHandler_OnLinkMouseUp
	ZO_LinkHandler_OnLinkMouseUp = function(itemLink, button, control) FurC_HandleClickEvent(itemLink, button, control) end
	ZO_PreHook('ZO_InventorySlot_OnMouseEnter', FurC_HandleMouseEnter)
	ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function(rowControl) FurC_HandleInventoryContextMenu(rowControl) end)
end

