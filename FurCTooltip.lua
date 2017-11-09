local async = LibStub("LibAsync")
local task = async:Create("FurnitureCatalogue_Tooltip")

local function p(...)
	FurC.DebugOut(...)
end

local function tryColorize(text)
	if (not FurC.GetColouredTooltips()) or not text then return text end
	return text:gsub("cannot craft", "|cFF0000cannot craft|r"):gsub("Can be crafted", "|c00FF00Can be crafted|r")
end


local function addTooltipData(control, itemOrBlueprintLink)
	if FurC.GetDisableTooltips() then return end
	
	if nil == itemOrBlueprintLink then return end

	local recipeArray = FurC.Find(itemOrBlueprintLink)		
	
	if (not recipeArray) or ({} == recipeArray) then return end			-- Find does not return nil, empty table instead

	
	local itemLink 	= recipeArray.itemLink
	local isRecipe 	= (itemOrBlueprintLink ~= itemLink)
	local unknown 	= FurC.IsUnknown(itemLink, recipeArray)
	local stringTable = { }


	
	local function add(t, arg)
		if nil ~= arg then t[#t + 1] = arg end
		return t
	end
	-- if craftable:
	if recipeArray.craftable then
		-- check for known/unknown
		if unknown then 
			if (not FurC.GetHideUnknown()) then
				stringTable = add(stringTable, tryColorize(recipeArray["source"]))
			end
		else
			if (not FurC.GetHideKnowledge()) then
				stringTable = add(stringTable, tryColorize(recipeArray["source"]))
			end
		end
		
		if not isRecipe and (not FurC.GetHideCraftingStation()) then
			stringTable = add(stringTable, FurC.PrintCraftingStation(recipeArray))
		end
		-- check if we should show mats
		if not(FurC.GetHideMats() or isRecipe) then
			stringTable = add(stringTable, FurC.GetMats(itemLink, true, false, recipeArray):gsub(", ", "\n"))
		end
	else
		if not FurC.GetHideSource() then
			stringTable = add(stringTable, recipeArray.source)
		end
		stringTable = add(stringTable, recipeArray.achievement)

	end
	stringTable = add(stringTable, recipeArray.comment)

	if #stringTable == 0 then return end

	control:AddVerticalPadding(8)
	ZO_Tooltip_AddDivider(control)

	for i = 1, #stringTable do
		control:AddLine(zo_strformat("<<C:1>>", stringTable[i]))
	end

end

local function TooltipHook(tooltipControl, method, linkFunc)
	local origMethod = tooltipControl[method]
	
	tooltipControl[method] = function(self, ...)
		origMethod(self, ...)
		task:Call(addTooltipData(self, linkFunc(...)))		
	end
end

local function ReturnItemLink(itemLink)
	return itemLink
end

do
	local identifier = FurC.name .. "Tooltips"
	-- hook real late
	local function HookToolTips()
		EVENT_MANAGER:UnregisterForUpdate(identifier)
		TooltipHook(ItemTooltip, "SetBagItem", GetItemLink)
		TooltipHook(ItemTooltip, "SetTradeItem", GetTradeItemLink)
		TooltipHook(ItemTooltip, "SetBuybackItem", GetBuybackItemLink)
		TooltipHook(ItemTooltip, "SetStoreItem", GetStoreItemLink)
		TooltipHook(ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink)
		TooltipHook(ItemTooltip, "SetLootItem", GetLootItemLink)
		TooltipHook(ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink)
		TooltipHook(ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink)
		TooltipHook(ItemTooltip, "SetLink", ReturnItemLink)
		TooltipHook(PopupTooltip, "SetLink", ReturnItemLink)
	end
	-- hook late
	local function DeferHookToolTips()
		EVENT_MANAGER:UnregisterForEvent(identifier, EVENT_PLAYER_ACTIVATED)
		EVENT_MANAGER:RegisterForUpdate(identifier, 100, HookToolTips)
	end
	function FurC.CreateTooltips()
		EVENT_MANAGER:RegisterForEvent(identifier, EVENT_PLAYER_ACTIVATED, DeferHookToolTips)
	end
	
	
end