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

local function logDebug(...)
  LFC.Internal.GetLogger():Debug(...)
end

local function parseFurnitureItem(itemLink, override) -- saves to DB, returns recipeArray
  if
    not (override or IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING)
  then
    return
  end

  local recipeKey = GetItemLinkItemId(itemLink)
  local recipeArray = db[recipeKey]
  if nil ~= recipeArray then
    return recipeArray
  end

  recipeArray = {}

  addDatabaseEntry(recipeKey, recipeArray)

  return recipeArray
end
this.ParseFurnitureItem = parseFurnitureItem

local function parseBlueprint(blueprintLink) -- saves to DB, returns recipeArray
  local itemLink = GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
  local blueprintId = getItemId(blueprintLink)
  local recipeKey = getItemId(itemLink)
  if
    nil == recipeKey -- we don't have a key to access the database
    or nil == itemLink -- we don't have an item link to parse
    or nil == GetItemLinkName(itemLink) -- we didn't find an item result for our recipe
  then
    return
  end

  local recipeArray = db[recipeKey] or {}
  recipeArray.origin = recipeArray.origin or src.CRAFTING
  recipeArray.craftingSkill = recipeArray.craftingSkill or GetItemLinkCraftingSkillType(blueprintLink)
  recipeArray.blueprint = recipeArray.blueprint or getItemId(blueprintLink)

  addDatabaseEntry(recipeKey, recipeArray)
  return recipeArray
end
this.ParseBlueprint = parseBlueprint

local ver = LFC.Internal.Constants.Versioning
local task -- LibAsync is optional for the lib; resolved lazily at first scan
local isBuilding = false

---@param blocking? boolean scan inline instead of yielding through LibAsync
local function scanFromFiles(blocking)
  task = task or (LibAsync and LibAsync:Create("LibFurnitureCatalogue_ScanDataFiles"))

  local function parseZoneData(zoneName, zoneData, versionNumber, origin)
    for vendorName, vendorData in pairs(zoneData) do
      for itemId in pairs(vendorData) do
        addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
      end
    end
  end

  local function scanRecipeFile()
    local recipeArray

    local function makeKeySet(versionData)
      local keySet = {}
      for k, v in pairs(versionData) do
        table.insert(keySet, k)
      end
      return keySet
    end

    local function scanArray(ary, versionNumber, origin)
      if nil == ary then
        return
      end

      for _, recipeId in ipairs(ary) do
        -- No blueprint means id is not a recipe this client can resolve (PTS vs Live, or invalid/datamine)
        local itemId, blueprintId = resolveRecipe(recipeId)
        if nil == blueprintId then
          logDebug("scanRecipeFile: %s is not a resolvable furniture recipe", recipeId)
        else
          local itemLink = getItemLink(itemId)
          recipeArray = parseFurnitureItem(itemLink) or db[itemId] or parseBlueprint(getItemLink(blueprintId))
          if nil == recipeArray then
            logDebug("scanRecipeFile: error for ID %s - %s", recipeId, itemLink)
          else
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber, blueprint = blueprintId })
          end
        end
      end
    end

    for versionNumber, versionData in pairs(FurC.Recipes) do
      scanArray(versionData, versionNumber, src.CRAFTING)
    end

    for versionNumber, versionData in pairs(FurC.RolisRecipes) do
      scanArray(makeKeySet(versionData), versionNumber, src.CRAFTING)
    end

    for versionNumber, versionData in pairs(FurC.FaustinaRecipes) do
      scanArray(makeKeySet(versionData), versionNumber, src.CRAFTING)
    end
  end

  local function scanRolis()
    -- Both tables mix furnishings with Master Writ recipes
    -- We resolve first, otherwise we get item+blueprint (duplicate)
    local function scanVendorTable(versionData, versionNumber)
      for id in pairs(versionData) do
        local itemId, blueprintId = resolveRecipe(id)
        if nil ~= itemId then
          addDatabaseEntry(itemId, { origin = src.ROLIS, version = versionNumber, blueprint = blueprintId })
        end
      end
    end

    for versionNumber, versionData in pairs(FurC.Rolis) do
      scanVendorTable(versionData, versionNumber)
    end
    for versionNumber, versionData in pairs(FurC.Faustina) do
      scanVendorTable(versionData, versionNumber)
    end
  end

  local function scanFestivalFiles()
    for versionNumber, versionData in pairs(FurC.EventItems) do
      for eventName, eventData in pairs(versionData) do
        for eventItemSource, eventItemData in pairs(eventData) do
          for itemId in pairs(eventItemData) do
            addDatabaseEntry(itemId, { origin = src.FESTIVAL_DROP, version = versionNumber, craftable = false })
          end
        end
      end
    end
  end

  local function scanMiscItemFile()
    for versionNumber, versionData in pairs(FurC.MiscItemSources) do
      for origin, originData in pairs(versionData) do
        for itemId in pairs(originData) do
          local itemLink = getItemLink(itemId)
          if IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING then
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
          elseif origin == src.RUMOUR then
            logDebug("invalid rumour item: %s (%s)", itemId, itemLink)
          else
            logDebug("scanMiscItemFile: Error when scanning item ID %s (origin %s)", itemId, origin)
          end
        end
      end
    end
  end

  local function scanCrownStore()
    for versionNumber, versionData in pairs(FurC.CrownStore) do
      for origin, originData in pairs(versionData) do
        for itemId in pairs(originData) do
          local itemLink = getItemLink(itemId)
          if IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING then
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
          else
            logDebug("scanCrownStore: Error when scanning item ID %s (origin %s)", itemId, origin)
          end
        end
      end
    end
  end

  local function scanAntiquities()
    for versionNumber, versionData in pairs(FurC.Antiquities) do
      for origin, originData in pairs(versionData) do
        for itemId in pairs(originData) do
          local itemLink = getItemLink(itemId)
          if IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING then
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
          else
            logDebug("scanAntiquities: Error when scanning item ID %s (origin %s)", itemId, origin)
          end
        end
      end
    end
  end

  local function scanJustice()
    for versionNumber, versionData in pairs(FurC.Justice) do
      for origin, originData in pairs(versionData) do
        for itemId in pairs(originData) do
          local itemLink = getItemLink(itemId)
          if IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING then
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
          else
            logDebug("scanJustice: Error when scanning item ID %s (origin %s)", itemId, origin)
          end
        end
      end
    end
  end

  local function scanFishing()
    for versionNumber, versionData in pairs(FurC.Fishing) do
      for origin, originData in pairs(versionData) do
        for itemId in pairs(originData) do
          local itemLink = getItemLink(itemId)
          if IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING then
            addDatabaseEntry(itemId, { origin = origin, version = versionNumber })
          else
            logDebug("scanFishing: Error when scanning item ID %s (origin %s)", itemId, origin)
          end
        end
      end
    end
  end

  local function scanVendorFiles()
    FurC.InitAchievementVendorList()

    for versionNumber, versionData in pairs(FurC.AchievementVendors) do
      for zoneName, zoneData in pairs(versionData) do
        parseZoneData(zoneName, zoneData, versionNumber, src.VENDOR)
      end
    end

    for versionNumber, vendorData in pairs(FurC.LuxuryFurnisher) do
      for itemId in pairs(vendorData) do
        addDatabaseEntry(itemId, { origin = src.LUXURY, version = versionNumber })
      end
    end

    for versionNumber, versionData in pairs(FurC.PVP) do
      for zoneName, zoneData in pairs(versionData) do
        parseZoneData(zoneName, zoneData, versionNumber, src.PVP)
      end
    end
  end

  local function scanRumours()
    for versionNumber, items in pairs(FurC.Rumours) do
      for itemId in pairs(items) do
        addDatabaseEntry(itemId, { origin = src.RUMOUR, version = versionNumber })
      end
    end
    for _, blueprintId in pairs(FurC.RumourRecipes) do
      local blueprintLink = getItemLink(blueprintId)
      local itemLink = GetItemLinkRecipeResultItemLink(blueprintLink, LINK_STYLE_BRACKETS)
      if #itemLink == 0 then
        itemLink = blueprintLink
      end
      local itemId = getItemId(itemLink)
      -- derive craftingSkill from blueprint
      local existing = parseBlueprint(blueprintLink) or parseFurnitureItem(itemLink) or db[itemId]
      local recipeListIndex, recipeIndex = GetItemLinkGrantedRecipeIndices(blueprintLink)
      addDatabaseEntry(itemId, {
        origin = src.RUMOUR,
        version = (existing and existing.version) or ver.HOMESTEAD,
        blueprint = (blueprintId ~= itemId) and blueprintId or nil,
        recipeListIndex = recipeListIndex,
        recipeIndex = recipeIndex,
      })
    end
  end

  local buildStarted = GetGameTimeMilliseconds()
  local function finish()
    isBuilding = false
    logDebug("DB build finished: %d entries in %d ms", NonContiguousCount(db), GetGameTimeMilliseconds() - buildStarted)
    LFC.Internal.Callbacks:FireCallbacks(LFC.Internal.Events.SCAN_COMPLETE)
  end

  isBuilding = true
  LFC.Internal.Callbacks:FireCallbacks(LFC.Internal.Events.SCAN_STARTED)

  if nil ~= task and not blocking then
    task
      :Call(scanRecipeFile)
      :Then(scanMiscItemFile)
      :Then(scanCrownStore)
      :Then(scanAntiquities)
      :Then(scanJustice)
      :Then(scanFishing)
      :Then(scanVendorFiles)
      :Then(scanRolis)
      :Then(scanFestivalFiles)
      :Then(scanRumours)
      :Then(finish)
  else
    scanRecipeFile()
    scanMiscItemFile()
    scanCrownStore()
    scanAntiquities()
    scanJustice()
    scanFishing()
    scanVendorFiles()
    scanRolis()
    scanFestivalFiles()
    scanRumours()
    finish()
  end
end

--- Builds runtime DB from bundled data files if empty
---@param blocking? boolean build inline, so the DB is populated on return
local function ensureDB(blocking)
  if isBuilding or next(db) ~= nil then
    return
  end
  logDebug("Scanning data files")
  scanFromFiles(blocking)
end
this.EnsureDB = ensureDB

--- Applies bundled data files over current DB again
local function rescanFiles()
  if isBuilding then
    return
  end
  logDebug("Scanning data files")
  scanFromFiles()
end
this.RescanFiles = rescanFiles

--- Wipes runtime DB and rebuilds it from bundled data
---@param blocking? boolean true=build immediately
local function rebuildDB(blocking)
  if isBuilding then
    return
  end
  clear()
  logDebug("Scanning data files")
  scanFromFiles(blocking)
end
this.RebuildDB = rebuildDB

-- Legacy aliases
FurC = FurC or {}
FurC.DBQuery = FurC.DBQuery or {}
FurC.DBQuery.ResolveRecipe = resolveRecipe
FurC.Upsert = addDatabaseEntry
FurC.EnsureDB = ensureDB
FurC.RescanFiles = rescanFiles
FurC.RebuildDB = rebuildDB
