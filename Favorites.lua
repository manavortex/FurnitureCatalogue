-- Favourites: per-account item favourites (SavedVars-backed)

local getItemId = LibFurnitureCatalogue.API.GetItemId

-- treat favourite furniture and recipe as the same item
local function faveKey(itemLink)
  if itemLink and IsItemLinkFurnitureRecipe(itemLink) then
    local resultLink = GetItemLinkRecipeResultItemLink(itemLink)
    if resultLink and #resultLink > 0 then
      itemLink = resultLink
    end
  end
  return getItemId(itemLink)
end

FurC.FaveKey = faveKey

---Import rule for list and favourite ids: a blueprint stands for its furnishing, an id the catalogue lacks is unknown
---@param id integer
---@return integer? itemId furnishing id the catalogue knows, nil if unknown
function FurC.KnownFurnishingId(id)
  local api = LibFurnitureCatalogue.API
  local itemId = id and id > 0 and faveKey(api.GetItemLink(id))
  local entry = itemId and api.GetEntry(itemId)
  -- an ignored item shows in no list, so it is dropped like an id the catalogue lacks
  local ignored = entry and entry.sources and entry.sources[api.GetSourceTypes().IGNORED]
  return entry and not ignored and itemId or nil
end

---Merge imported ids into a set (a list's items, the favourites); never removes anything
---@param items table<integer, true> changed in place
---@param idText string ids separated by anything that is not a digit
---@param resolve fun(id: integer): integer? FurC.KnownFurnishingId, or a stand-in for tests
---@return integer added, integer duplicates, integer unknown
function FurC.AddImportedIds(items, idText, resolve)
  local added, duplicates, unknown = 0, 0, 0
  for idString in tostring(idText or ""):gmatch("%d+") do
    local itemId = resolve(tonumber(idString))
    if not itemId then
      unknown = unknown + 1
    elseif items[itemId] then
      duplicates = duplicates + 1 -- already there, or the same furnishing arrived again as its blueprint
    else
      items[itemId] = true
      added = added + 1
    end
  end
  return added, duplicates, unknown
end

function FurC.IsFavoriteById(itemId)
  return itemId ~= nil and FurC.settings.favorites[itemId] == true
end

function FurC.IsFavorite(itemLink, recipeArray)
  return FurC.IsFavoriteById(faveKey(itemLink))
end

-- fave toggle
function FurC.Fave(itemLink, recipeArray)
  local itemId = faveKey(itemLink)
  if itemId == nil then
    return
  end
  if FurC.settings.favorites[itemId] then
    FurC.settings.favorites[itemId] = nil
  else
    FurC.settings.favorites[itemId] = true
  end
  FurC.UpdateGui()
end
