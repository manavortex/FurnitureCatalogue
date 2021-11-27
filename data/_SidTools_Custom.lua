local recipeResultIds = {}

local function addItemLink(data)
	
	if not FurC then return end
	
	local itemLink = FurC.GetItemLink(data.id)
	if not ShouldBeInFurC(itemLink) then 
		-- d('should not be in FurC: ' .. itemLink)
		return 
	end	
	
	if data.itemType == ITEMTYPE_FURNISHING then
	-- if IsItemLinkPlaceableFurniture(itemLink) then
		-- d('item is furniture ' .. itemLink)
		if data.specializedType == SPECIALIZED_ITEMTYPE_FURNISHING_CRAFTING_STATION then return end
		sidTools_SaveData.furniture[data.id] = string.format("rumourSource, -- %s", data.name)
		sidTools.furniture[data.id] = data.name
	else
	-- should be in furC, but isn't furniture: gonna be a recipe
		local recipeResultItemLink     	= GetItemLinkRecipeResultItemLink(itemLink, LINK_STYLE_BRACKETS)
		local recipeKey   				= FurC.GetItemId(recipeResultItemLink)
		-- d('item is recipe: ' .. itemLink .. ' / ' .. recipeResultItemLink)
		if recipeKey then
			sidTools_SaveData.furnitureRecipes[data.id] = string.format("%s, -- %s", data.id, data.name)			
			sidTools_SaveData.furniture[recipeKey] = string.format("rumourSource, -- %s", GetItemLinkName(recipeResultItemLink))			
			table.insert(recipeResultIds, recipeKey)	
		end
	end
end

SLASH_COMMANDS["/dumpfurniture"] = function()

	if LAM and LAM.util then
      LAM.util.ShowConfirmationDialog(
        "Reset FurC Database?",
		"If you don't, the utility tool will miss any recipes and items that you've seen before (e.g. in guildstore).",
        FurC.WipeDatabase()
      )
    end
	
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
	
	if LAM and LAM.util then
      LAM.util.ShowConfirmationDialog(
        "Reload UI?",
		"You need to write sidTools' saved variables to disk.",
        ReloadUI()
      )
    end
	
end
