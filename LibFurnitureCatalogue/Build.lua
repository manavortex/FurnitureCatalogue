-- runtime DB build

local LFC = LibFurnitureCatalogue

local this = {}
LFC.Internal.Build = this

local db = LFC.Internal.DB
local src = LFC.Internal.Constants.ItemSources
local SOURCE_PRIORITY = LFC.Internal.Constants.SOURCE_PRIORITY

local getItemId = LFC.Internal.Format.GetItemId
local getItemLink = LFC.Internal.Format.GetItemLink

--- Maps recipe id onto furnishing it crafts
--- Plain furnishings pass through unchanged
---@param recipeId integer
---@return integer? itemId to store under, nil to skip
---@return integer? blueprintId set only when recipeId was a resolved recipe
local function resolveRecipe(recipeId)
  local recipeLink = getItemLink(recipeId)
  if nil == recipeLink or not IsItemLinkFurnitureRecipe(recipeLink) then
    return recipeId, nil
  end
  -- game returns "" when recipe has no result
  local resultLink = GetItemLinkRecipeResultItemLink(recipeLink, LINK_STYLE_BRACKETS)
  if nil == resultLink or #resultLink == 0 then
    return nil, nil
  end
  local resultId = getItemId(resultLink)
  if nil == resultId or resultId == recipeId then
    return nil, nil
  end
  return resultId, recipeId
end
this.ResolveRecipe = resolveRecipe

-- Looks up furniture category and subcategory for item link
local function cacheFurnishingCategory(itemLink, recipeArray)
  if not recipeArray then
    return
  end
  -- Skip if already cached
  if recipeArray.furnCategory ~= nil then
    return
  end

  local dataId = GetItemLinkFurnitureDataId(itemLink)
  if not dataId or dataId == 0 then
    recipeArray.furnCategory = 0
    recipeArray.furnSubcategory = 0
    return
  end

  local categoryId, subcategoryId = GetFurnitureDataCategoryInfo(dataId)
  recipeArray.furnCategory = categoryId or 0
  recipeArray.furnSubcategory = subcategoryId or 0
end
this.CacheFurnishingCategory = cacheFurnishingCategory

local function primarySource(sources)
  local best, bestRank
  for s in pairs(sources) do
    local rank = SOURCE_PRIORITY[s] or math.huge
    if not bestRank or rank < bestRank or (rank == bestRank and s < best) then
      best, bestRank = s, rank
    end
  end
  return best
end

-- partial update or full overwrite
local function addDatabaseEntry(recipeKey, partial)
  if not (recipeKey and partial and next(partial) ~= nil) then
    return
  end

  local stored = db[recipeKey]
  if stored == nil then
    stored = partial
    db[recipeKey] = stored
  else
    for k, v in pairs(partial) do
      if k ~= "origin" and k ~= "sources" then
        stored[k] = v -- last writer wins
      end
    end
  end

  local sources = stored.sources or {}
  stored.sources = sources
  if partial.sources then
    for s in pairs(partial.sources) do
      sources[s] = true
    end
  end
  if partial.origin ~= nil then
    sources[partial.origin] = true
  end
  -- RUMOUR is fallback: datamined but unknown src
  -- Sometimes we have leftover rumour items in DB
  -- We should auto drop rumour category if a src exists
  if sources[src.RUMOUR] then
    for s in pairs(sources) do
      if s ~= src.RUMOUR then
        sources[src.RUMOUR] = nil
        break
      end
    end
  end
  if next(sources) ~= nil then
    stored.origin = primarySource(sources)
  end

  -- Cache furnishing category IDs onto the stored entry
  local itemLink = getItemLink(recipeKey)
  if itemLink then
    cacheFurnishingCategory(itemLink, stored)
  end

  LFC.Internal.DBRevision = LFC.Internal.DBRevision + 1
end
this.Upsert = addDatabaseEntry

-- Wipes runtime DB in place
local function clear()
  for itemId in pairs(db) do
    db[itemId] = nil
  end
  LFC.Internal.DBRevision = LFC.Internal.DBRevision + 1
end
this.Clear = clear

-- Legacy alias
FurC = FurC or {}
FurC.DBQuery = FurC.DBQuery or {}
FurC.DBQuery.ResolveRecipe = resolveRecipe
