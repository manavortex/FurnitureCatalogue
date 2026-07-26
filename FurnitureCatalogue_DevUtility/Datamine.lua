-- Datamining helpers

local getItemId = FurC.Utils.GetItemId
local getItemLink = FurC.Utils.GetItemLink

local function printItemLink(itemId)
  if nil == itemId then
    return
  end
  itemId = tostring(itemId)
  local itemLink = nil
  if #itemId > 55 then
    itemLink = itemId
  end
  itemLink = itemLink or zo_strformat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", itemId)
  FurC.Logger:Info("[%s] = '',\t\t-- %s", itemId, GetItemLinkName(itemLink))
end
FurC.PrintItemLink = printItemLink

function FurC.ShouldBeInFurC(link)
  link = getItemLink(link)
  if not link then
    return false
  end
  FurC.EnsureDB()

  if IsItemLinkPlaceableFurniture(link) then
    return nil == FurC.DB[getItemId(link)]
  end

  -- if not IsItemLinkFurnitureRecipe(link) then	return false end

  local resultLink = GetItemLinkRecipeResultItemLink(link, LINK_STYLE_BRACKETS)
  if not resultLink then
    return false
  end

  local resultId = getItemId(resultLink)
  local recipeId = getItemId(link)
  if not resultId or not recipeId or not IsItemLinkPlaceableFurniture(resultLink) then
    return false
  end

  for _, versionData in pairs(FurC.Recipes) do
    for _, id in ipairs(versionData) do
      if id == recipeId then
        return false
      end
    end
  end
  for _, versionData in pairs(FurC.FaustinaRecipes) do
    if versionData[recipeId] then
      return false
    end
  end
  for _, versionData in pairs(FurC.RolisRecipes) do
    if versionData[recipeId] then
      return false
    end
  end

  -- yeah okay, it should actually return false, but this is a util function for datamining
  return nil == FurC.DB[resultId]
end
