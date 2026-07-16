local async = LibAsync
local task = async:Create("FurnitureCatalogue_Tooltip")
local src = FurC.Constants.ItemSources
local query = FurC.DBQuery

local function tryColorize(text)
  if not (text and FurC.GetColouredTooltips()) then
    return text
  end
  return text:gsub("cannot craft", "|cFF0000cannot craft"):gsub("Can be crafted", "|c00FF00Can be crafted")
end

--- Populate item tool tip table as set (no dupes)
local function add(t, arg)
  if nil == arg then
    return t
  end
  for i = 1, #t do
    if t[i] == arg then
      return t
    end
  end
  t[#t + 1] = arg
  return t
end

local function addFolioTooltipData(control, itemId, folioData)
  local strPrice = FurC.Utils.FormatPrice(folioData.price, folioData.currency)
  local strVendor = FurC.Utils.Colourise(folioData.vendor, FurC.Constants.Colours.Vendor)
  local strLoc = FurC.Utils.Colourise(folioData.location, FurC.Constants.Colours.Location)
  local header = zo_strformat("<<1>> : <<2>> (<<3>>)", strVendor, strLoc, strPrice)

  local lines = { header }

  if folioData.contents then
    for _, contentId in ipairs(folioData.contents) do
      local link = FurC.Utils.GetItemLink(contentId)
      if link and link ~= "" then
        lines[#lines + 1] = GetItemLinkName(link)
      end
    end
  end

  control:AddVerticalPadding(8)
  ZO_Tooltip_AddDivider(control)
  for i = 1, #lines do
    control:AddLine(zo_strformat("<<C:1>>", lines[i]))
  end
end

local function addBookCollectionTooltipData(control, itemId, collection)
  local lines = {}

  local recipeArray = FurC.Find(itemId)
  if recipeArray and not FurC.GetHideSource() then
    local sourceLines = query.GetSourceLines(itemId, recipeArray, false)
    for i = 1, #sourceLines do
      lines[#lines + 1] = sourceLines[i]
    end
  end

  -- book names comma-joined into one block
  local names = {}
  for i = 1, #collection.contents do
    names[#names + 1] = FurC.Utils.GetItemName(collection.contents[i])
  end
  lines[#lines + 1] = zo_strformat(GetString(SI_FURC_CONTAINS_BOOKS), #names)
  lines[#lines + 1] = table.concat(names, ", ")

  control:AddVerticalPadding(8)
  ZO_Tooltip_AddDivider(control)
  for i = 1, #lines do
    control:AddLine(zo_strformat("<<C:1>>", lines[i]))
  end
end

local function addTooltipData(control, itemLink)
  if FurC.GetDisableTooltips() then
    return
  end
  if nil == itemLink or "" == itemLink then
    return
  end
  local isRecipe = IsItemLinkFurnitureRecipe(itemLink)

  itemLink = (isRecipe and GetItemLinkRecipeResultItemLink(itemLink)) or itemLink

  -- Check if this is a furnishing folio container
  local itemId = GetItemLinkItemId(itemLink)
  local folioData = FurC.FurnishingFolios and FurC.FurnishingFolios[itemId]
  if folioData then
    addFolioTooltipData(control, itemId, folioData)
    return
  end

  -- book containers are not placeable, handle before the furniture check
  local collection = FurC.BookCollections and FurC.BookCollections[itemId]
  if collection then
    addBookCollectionTooltipData(control, itemId, collection)
    return
  end

  if not (isRecipe or IsItemLinkPlaceableFurniture(itemLink)) then
    return
  end
  itemId = GetItemLinkItemId(itemLink)
  recipeArray = FurC.Find(itemLink)

  -- |H0:item:118206:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h

  if not recipeArray then
    return
  end

  local unknown = not FurC.CanCraft(itemId, recipeArray)
  local stringTable = {}
  local isCraftable = isRecipe or (recipeArray.sources and recipeArray.sources[src.CRAFTING]) or false

  if isCraftable then
    if unknown and not FurC.GetHideUnknown() or not FurC.GetHideKnowledge() then
      local crafterList = FurC.GetCrafterList(itemLink, recipeArray)
      if crafterList then
        stringTable = add(stringTable, tryColorize(crafterList))
      end
    end
    if not isRecipe and (not FurC.GetHideCraftingStation()) then
      stringTable = add(stringTable, FurC.PrintCraftingStation(itemId, recipeArray))
    end
    -- craftable items show recipe tooltip, if src available
    if isRecipe or recipeArray.blueprint then
      stringTable = add(stringTable, query.GetRecipeSource(itemId, recipeArray))
    end
    -- check if we should show mats
    if not (FurC.GetHideMats() or isRecipe) then
      stringTable = add(stringTable, FurC.GetMats(itemLink, recipeArray, true):gsub(", ", "\n"))
    end
  end

  -- other sources: every ranked source except crafting, one line each
  if not isRecipe then
    if not FurC.GetHideSource() then
      local lines = query.GetSourceLines(itemId, recipeArray, false)
      for i = 1, #lines do
        stringTable = add(stringTable, lines[i])
      end
    end
    if not isCraftable then
      stringTable = add(stringTable, recipeArray.achievement)
    end
  end

  if #stringTable == 0 then
    return
  end

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
  if FurC.showBlueprints then
    local recipeArray = FurC.Find(itemLink)
    if recipeArray and recipeArray.blueprint then
      return FurC.Utils.GetItemLink(recipeArray.blueprint)
    end
  end
  return FurC.Utils.GetItemLink(itemLink)
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
