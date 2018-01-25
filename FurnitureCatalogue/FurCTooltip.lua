local async = LibStub("LibAsync")
local task = async:Create("FurnitureCatalogue_Tooltip")

local p 		= FurC.DebugOut -- debug function calling zo_strformat with up to 10 args

local function tryColorize(text, datInteger)
	if nil == text then text = datInteger end
	if (not FurC.GetColouredTooltips()) or not text then return text end
	return text:gsub("cannot craft", "|cFF0000cannot craft|r"):gsub("Can be crafted", "|c00FF00Can be crafted|r")
end

local function addTooltipData(control, itemLink)

	
	if FurC.GetDisableTooltips() then return end
	local itemId, recipeArray = nil
	if nil == itemLink or FURC_EMPTY_STRING == itemLink then return end
	local isRecipe = IsItemLinkFurnitureRecipe(itemLink)
	
	itemLink = (isRecipe and GetItemLinkRecipeResultItemLink(itemLink)) or itemLink
	
	itemId 		= FurC.GetItemId(itemLink)
	recipeArray = FurC.Find(itemLink)
	
	-- |H0:item:118206:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h

	if not recipeArray then return end			-- Find does not return nil, empty table instead
	
	local unknown 	= not FurC.CanCraft(itemId, recipeArray)
	local stringTable = {}


	local function add(t, arg)
		if nil ~= arg then t[#t + 1] = arg end
		return t
	end
	
	-- if craftable:
	if isRecipe or recipeArray.origin == FURC_CRAFTING then		
		if unknown and not FurC.GetHideUnknown() or not FurC.GetHideKnowledge() then
			stringTable = add(stringTable, tryColorize(FurC.GetCrafterList(recipeArray)))
		end		
		if not isRecipe and (not FurC.GetHideCraftingStation()) then
			stringTable = add(stringTable, FurC.PrintCraftingStation(itemId, recipeArray))
		end
		-- check if we should show mats
		if not (FurC.GetHideMats() or isRecipe) then
			stringTable = add(stringTable, FurC.GetMats(itemLink, recipeArray, true):gsub(", ", "\n"))
		end
	else
		if not FurC.GetHideSource() then
			stringTable = add(stringTable, FurC.GetItemDescription(itemId, recipeArray))
		end
		stringTable = add(stringTable, recipeArray.achievement)
	end	
	
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
		addTooltipData(self, linkFunc(...))
	end
end

local function ReturnItemLink(itemLink)
	return FurC.GetItemLink(itemLink)
end

do
	local identifier = FurC.name .. "Tooltips"
	-- hook real late
	local function HookToolTips()
		EVENT_MANAGER:UnregisterForUpdate(identifier)
		TooltipHook(ItemTooltip, 	"SetBagItem", 				GetItemLink)
		TooltipHook(ItemTooltip, 	"SetTradeItem", 			GetTradeItemLink)
		TooltipHook(ItemTooltip, 	"SetBuybackItem",			GetBuybackItemLink)
		TooltipHook(ItemTooltip, 	"SetStoreItem", 			GetStoreItemLink)
		TooltipHook(ItemTooltip, 	"SetAttachedMailItem", 		GetAttachedItemLink)
		TooltipHook(ItemTooltip, 	"SetLootItem", 				GetLootItemLink)
		TooltipHook(ItemTooltip, 	"SetTradingHouseItem", 		GetTradingHouseSearchResultItemLink)
		TooltipHook(ItemTooltip, 	"SetTradingHouseListing", 	GetTradingHouseListingItemLink)
		TooltipHook(ItemTooltip, 	"SetLink", 					ReturnItemLink)
		TooltipHook(PopupTooltip, 	"SetLink", 					ReturnItemLink)
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