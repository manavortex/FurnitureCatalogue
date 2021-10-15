-- This file goes into the sidTools directory as Custom.lua

local recipeResultIds = {}

local function addItemLink(data)
	
	if not FurC then return end
	
	local itemLink = FurC.GetItemLink(data.id)
	if not ShouldBeInFurC(itemLink) then return end	
	
	if data.itemType == ITEMTYPE_FURNISHING then
		if data.specializedType == SPECIALIZED_ITEMTYPE_FURNISHING_CRAFTING_STATION then return end
		if string.find(data.name, " Station ") then d(data) end
		sidTools_SaveData.furniture[data.id] = string.format("rumourSource, -- %s", data.name)
		sidTools.furniture[data.id] = data.name
	else
		-- should be in furC, but isn't furniture: gonna be a recipe
		if IsItemLinkFurnitureRecipe(itemLink) then -- this check might be obsolete, but what can I say, I'm too lazy to check
			local recipeResultItemLink     	= GetItemLinkRecipeResultItemLink(itemLink, LINK_STYLE_BRACKETS)
			local recipeKey   				= FurC.GetItemId(recipeResultItemLink)
			if recipeKey then
			sidTools_SaveData.furnitureRecipes[data.id] = string.format("%s, -- %s", data.id, data.name)
			
			sidTools_SaveData.furniture[recipeKey] = string.format("rumourSource, -- %s", GetItemLinkName(recipeResultItemLink))
			
			table.insert(recipeResultIds, recipeKey)	
			end
		end	
	end	
	
end

SLASH_COMMANDS["/dumpfurniture"] = function()

	local masterList = sidTools.itemViewer.masterList
	sidTools_SaveData.furniture = {}
	sidTools_SaveData.furnitureRecipes = {}
	recipeResultIds = {}
	sidTools.furniture = {}
	for i = 1, #masterList do
		addItemLink(masterList[i])		
	end
	
	for idx, itemId in pairs(recipeResultIds) do 
		sidTools_SaveData.furniture[itemId] = nil
	end
end
