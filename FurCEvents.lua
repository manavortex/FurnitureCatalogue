local em	= EVENT_MANAGER
local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end

local function onRecipeLearned(eventCode, recipeListIndex, recipeIndex)
	p("Recipe learned: <<1>>, <<2>>, <<3>>", GetRecipeResultItemLink(recipeListIndex, recipeIndex, LINK_STYLE_BRACKETS), recipeListIndex, recipeIndex)
	FurC.TryCreateRecipeEntry(recipeListIndex, recipeIndex)
	FurC.UpdateGui()
end

local wm = WINDOW_MANAGER

local function createIcon(control)
	local icon = wm:CreateControlFromVirtual(control:GetName().."FurCIcon", control, "FurC_SlotIconKnownYes")
	icon:SetAnchor(BOTTOMLEFT, control:GetNamedChild("Button"), BOTTOMLEFT, -15, -10)
	icon:SetHidden(true)
	control.icon = icon
	return icon
end

local function getItemKnowledge(itemLink)
	local canCraft = FurC.CanCraft(FurC.GetItemId(itemLink)) 
	return (FurC.GetUseInventoryIconsOnChar() and canCraft) or not canCraft
	
end

local function updateItemInInventory(control)
	if 'listSlot' ~= control.slotControlType then return end
	local icon = control.icon or createIcon(control)
	local data = control.dataEntry.data
	
	local bagId = data.bagId
	local slotId = data.slotIndex
	local itemLink = GetItemLink(bagId, slotId)
	
	if not IsItemLinkFurnitureRecipe(itemLink) then 
		icon:SetHidden(true)
		return
	end
		local known = getItemKnowledge(itemLink)
	
		local hidden = known and FurC.GetHideKnownInventoryIcons() or (not FurC.GetUseInventoryIcons())
		icon:SetHidden(hidden)
		
		local templateName = "FurC_SlotIconKnown" .. ((known and "Yes") or "No")
		WINDOW_MANAGER:ApplyTemplateToControl(icon, templateName) 
	
end

function FurC.SetupInventoryRecipeIcons(calledRecursively)
	if nil ~= ResearchAssistant then return end
	local function isValidBag(bagId, inventory)
		if bagId == BAG_WORN 				then return false end
		if bagId == BAG_VIRTUAL 			then return false end
		local listView = inventory.listView
		if not listView 					then return false end
		if not listView.dataTypes 			then return false end
		if not listView.dataTypes[1] 		then return false end
		return nil ~= listView.dataTypes[1].setupCallback
	end
	
	local inventories = PLAYER_INVENTORY.inventories
	if not inventories and not calledRecursively then 
		return zo_callLater(function() FurC.SetupInventoryRecipeIcons(true) end, 1000)
	end
	-- ruthlessly stolen from Dryzler's Inventory, then tweaked
	for bagId, inventory in pairs(inventories) do
		if isValidBag(bagId, inventory) then
			
			ZO_PreHook( inventory.listView.dataTypes[1], "setupCallback", 
				function(control, slot) updateItemInInventory(control) end
			)
			
		end
	end	
end



function FurC.RegisterEvents()	
	em:RegisterForEvent("FurnitureCatalogue", EVENT_RECIPE_LEARNED, onRecipeLearned)	
end