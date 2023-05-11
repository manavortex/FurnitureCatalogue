local lib = LibFurniture
local internal = lib.internal
local logger = internal.Logger

-- Constants


-- Database queries

function lib:GetSomeData()
  -- todo
end

-- ToDo: Stuff for LibPrice

function lib.GetItemId(item_link)
  -- Code to get item ID
end

function lib.GetItemDescription(item_id, recipe_array)
  -- Code to get item description
end

function lib.GetItemOrigin(item_link)
  -- Code to get item origin
end

function lib.GetItemLinkFromRecipeArray(recipe_array)
  -- Code to get item link
end

function lib.GetRecipeIngredients(item_link)
  -- Code to get ingredients of a recipe
end

-- More complex functions
function lib.GetItemCraftingCost(item_link)
  -- Code to calculate crafting cost
end

function lib.GetItemVendorCost(item_link)
  -- Code to get cost from vendors
end

function lib.GetItemPVPCost(item_link)
  -- Code to get cost from PvP rewards
end

function lib.GetItemCrownCost(item_link)
  -- Code to get cost in crowns
end

function lib.GetItemMiscCost(item_link)
  -- Code to get cost from miscellaneous sources
end

lib.CURRENCY_TYPE_GOLD = 1
lib.CURRENCY_TYPE_CROWNS = 2
lib.CURRENCY_TYPE_WRIT_VOUCHERS = 3
lib.CURRENCY_TYPE_ALLIANCE_POINTS = 4
