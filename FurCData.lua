local task = LibAsync:Create("FurnitureCatalogue_ScanDataFiles")

local lastLink = nil
local recipeArray = nil

local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources

local getItemId = FurC.Utils.GetItemId
local getItemLink = FurC.Utils.GetItemLink

-- DB-content query table
FurC.DBQuery = FurC.DBQuery or {}
local this = FurC.DBQuery
local lib = FurC.Lib

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

-- Looks up the ESO furniture category and subcategory for an item link
-- and caches the integer IDs onto the recipeArray. Safe to call multiple
-- times; skips the API call if already cached.
local function cacheFurnishingCategory(itemLink, recipeArray)
  if not recipeArray then
    return
  end
  -- Skip if already cached (0 is a valid "uncategorised" result from the API)
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
FurC.CacheFurnishingCategory = cacheFurnishingCategory

local SOURCE_PRIORITY = FurC.Constants.SOURCE_PRIORITY
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

  local stored = FurC.DB[recipeKey]
  if stored == nil then
    stored = partial
    FurC.DB[recipeKey] = stored
  else
    for k, v in pairs(partial) do
      if k ~= "origin" and k ~= "sources" then
        stored[k] = v -- last writer wins
      end
    end
  end
  FurC.sortIndexDirty = true

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
end
FurC.Upsert = addDatabaseEntry

local function makeMaterial(recipeKey, recipeArray, tryPlaintext, forcePlaintext)
  if
    nil == recipeArray
    or (nil == recipeArray.blueprint and nil == recipeArray.recipeIndex and nil == recipeArray.recipeListIndex)
  then
    return "couldn't get material list, please re-scan character knowledge"
  end
  local ret = ""
  local ingredients = FurC.GetIngredients(recipeKey, recipeArray)
  forcePlaintext = forcePlaintext or tryPlaintext and NonContiguousCount(ingredients) > 4
  for ingredientLink, qty in pairs(ingredients) do
    -- auto-capitalize because for some reason the ZOS API doesn't
    local itemText = (
      forcePlaintext and string.gsub(" " .. GetItemLinkName(ingredientLink), "%W%l", string.upper):sub(2)
    ) or ingredientLink
    ret = zo_strformat("<<1>> <<2>>x <<3>>, ", ret, qty, itemText)
  end
  return ret:sub(0, -3)
end
this.GetMats = makeMaterial

---@deprecated alias for DBQuery.GetMats
FurC.GetMats = makeMaterial

local function getIngredients(itemLink, recipeArray)
  recipeArray = recipeArray or FurC.Find(itemLink)
  local ingredients = {}
  if not recipeArray or next(recipeArray) == nil then
    return ingredients
  end
  if recipeArray.blueprint then
    local blueprintLink = getItemLink(recipeArray.blueprint)
    local numIngredients = GetItemLinkRecipeNumIngredients(blueprintLink)
    for ingredientIndex = 1, numIngredients do
      local name, _, qty = GetItemLinkRecipeIngredientInfo(blueprintLink, ingredientIndex)
      local ingredientLink = GetItemLinkRecipeIngredientItemLink(blueprintLink, ingredientIndex, LINK_STYLE_DEFAULT)
      ingredients[ingredientLink] = qty
    end
  else
    local _, name, numIngredients = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
    for ingredientIndex = 1, numIngredients do
      local name, _, qty =
        GetRecipeIngredientItemInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex, ingredientIndex)
      local ingredientLink = GetRecipeIngredientItemLink(
        recipeArray.recipeListIndex,
        recipeArray.recipeIndex,
        ingredientIndex,
        LINK_STYLE_DEFAULT
      )
      ingredients[ingredientLink] = qty
    end
  end
  return ingredients
end
this.GetIngredients = getIngredients

---@deprecated alias for DBQuery.GetIngredients
FurC.GetIngredients = getIngredients

local function parseFurnitureItem(itemLink, override) -- saves to DB, returns recipeArray
  if
    not (override or IsItemLinkPlaceableFurniture(itemLink) or GetItemLinkItemType(itemLink) == ITEMTYPE_FURNISHING)
  then
    return
  end

  local recipeKey = GetItemLinkItemId(itemLink)
  local recipeArray = FurC.DB[recipeKey]
  if nil ~= recipeArray then
    return recipeArray
  end

  recipeArray = {}

  addDatabaseEntry(recipeKey, recipeArray)

  return recipeArray
end

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

  local recipeArray = FurC.DB[recipeKey] or {}
  recipeArray.origin = recipeArray.origin or src.CRAFTING
  recipeArray.craftingSkill = recipeArray.craftingSkill or GetItemLinkCraftingSkillType(blueprintLink)
  recipeArray.blueprint = recipeArray.blueprint or getItemId(blueprintLink)

  addDatabaseEntry(recipeKey, recipeArray)
  return recipeArray
end

---DB entry for an item/blueprint, builds DB on first use
---@param itemOrBlueprintLink string|integer item link, blueprint link, or itemId
---@return FurCEntry entry the entry, or `{}` if unknown
local function find(itemOrBlueprintLink)
  FurC.EnsureDB()
  if tonumber(itemOrBlueprintLink) == itemOrBlueprintLink then
    itemOrBlueprintLink = getItemLink(itemOrBlueprintLink)
  end
  -- do not return empty arrays. If this returns nil, abort!
  if nil == itemOrBlueprintLink or #itemOrBlueprintLink == 0 then
    return {}
  end

  if itemOrBlueprintLink == lastLink and nil ~= recipeArray then
    return recipeArray
  else
    recipeArray = nil
    lastLink = itemOrBlueprintLink
  end

  if IsItemLinkFurnitureRecipe(itemOrBlueprintLink) then
    recipeArray = parseBlueprint(itemOrBlueprintLink)
  elseif IsItemLinkPlaceableFurniture(itemOrBlueprintLink) then
    recipeArray = parseFurnitureItem(itemOrBlueprintLink)
  else
    itemId = getItemId(itemOrBlueprintLink)
    if itemId ~= nil and tonumber(itemId) > 0 then
      recipeArray = FurC.DB[itemId]
    end
  end

  return recipeArray or {}
end
this.Find = find

---@deprecated alias for DBQuery.Find
FurC.Find = find

function FurC.GetEntry(itemOrBlueprintLink)
  local itemLink = (IsItemLinkFurnitureRecipe(itemOrBlueprintLink) and GetRecipeResultItemLink(itemOrBlueprintLink))
    or itemOrBlueprintLink
  local recipeArray = FurC.Find(itemLink)
  FurC.Logger:Debug("Trying to get entry for %s: %s", itemLink, recipeArray)
  if not recipeArray then
    return
  end
  local itemId = getItemId(itemOrBlueprintLink)
  if recipeArray.blueprint then
    itemId = getItemId(GetItemLinkRecipeResultItemLink(blueprintLink))
  end
  return itemId, recipeArray
end

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

function FurC.IsFavoriteById(itemId)
  return itemId ~= nil and FurC.settings.favorites[itemId] == true
end

function FurC.IsFavorite(itemLink, recipeArray)
  return FurC.IsFavoriteById(faveKey(itemLink))
end

-- fav toggle
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

-- SavedVars migrations: old settings / properties
local LEGACY_DROP = {
  "data", -- old persisted DB, not in SavedVars anymore
  "accountCharacters", -- per-char knowledge -> LCK
  "excelExport", -- old export table? -> FurnitureCatalogue_Export
  "emptyItemSources", -- datamining aid -> FurCDev
  "startupSilently", -- not used anymore, debug stuff now
  "visibility", -- window toggled by hotkey or slash cmd now
  "useIconsThisChar", -- renamed -> useInventoryIconsOnChar
}

---@type { name: string, run: fun(aw: table) }[] aw: account wide
FurC.Migrations = {
  {
    -- old embedded `data[id].favorite`
    name = "favorites_from_data",
    run = function(aw)
      if type(aw.data) ~= "table" then
        return
      end
      aw.favorites = aw.favorites or {}
      for id, entry in pairs(aw.data) do
        if type(entry) == "table" and entry.favorite then
          aw.favorites[id] = true
          entry.favorite = nil
        end
      end
    end,
  },
  {
    -- `favourites` -> `favorites` (so we don't mix spellings)
    name = "favourites_spelling",
    run = function(aw)
      if type(aw.favourites) ~= "table" then
        return
      end
      aw.favorites = aw.favorites or {}
      for id, known in pairs(aw.favourites) do
        if known then
          aw.favorites[id] = true
        end
      end
      aw.favourites = nil
    end,
  },
  {
    -- explicitly drop legacy tables
    name = "drop_legacy",
    run = function(aw)
      for _, key in ipairs(LEGACY_DROP) do
        aw[key] = nil
      end
    end,
  },
}

---Get accounts from SavedVars
--- For testing purposes a fake table can be passed.
--- defaults to `FurnitureCatalogue_Settings["Default"]`
---@param test? table test table to skip real SavedVars
---@return table
local function accountBranches(test)
  local root = test or (FurnitureCatalogue_Settings and FurnitureCatalogue_Settings["Default"])
  local out = {}
  for _, branch in pairs(root or {}) do
    local aw = branch["$AccountWide"]
    if type(aw) == "table" then
      out[#out + 1] = aw
    end
  end
  return out
end

---Run SavedVars migrations on current acc (default) or every account
---@param opts? { allAccounts?: boolean, migrations?: string[], test?: table } # migrations nil/empty = all, in order; `test` supplies a fake table
---@return integer accountsMigrated
function FurC.Migrate(opts)
  opts = opts or {}
  local only
  if opts.migrations and #opts.migrations > 0 then
    only = {}
    for _, name in ipairs(opts.migrations) do
      only[name] = true
    end
  end
  local targets = opts.allAccounts and accountBranches(opts.test) or { opts.test or FurC.settings }
  for _, aw in ipairs(targets) do
    for _, step in ipairs(FurC.Migrations) do
      if not only or only[step.name] then
        step.run(aw)
      end
    end
  end
  return #targets
end

-- Count stale DB entries across every account
---@param test? table injects a source for CI/headless (see FurC.Migrate)
---@return { accounts: integer, entries: integer }
function FurC.GetLegacyStats(test)
  local accounts, entries = 0, 0
  for _, aw in ipairs(accountBranches(test)) do
    if aw.data ~= nil or aw.accountCharacters ~= nil or aw.excelExport ~= nil then
      accounts = accounts + 1
      if type(aw.data) == "table" then
        for _ in pairs(aw.data) do
          entries = entries + 1
        end
      end
    end
  end
  return { accounts = accounts, entries = entries }
end

-- Current character: live game data, no persistence needed.
function FurC.CanCraft(recipeKey, recipeArray)
  if recipeKey == nil and recipeArray == nil then
    return false
  end
  if recipeArray == nil then
    FurC.EnsureDB()
    recipeArray = FurC.DB[recipeKey]
  end
  if nil == recipeArray or nil == recipeArray.blueprint then
    return false
  end
  return IsItemLinkRecipeKnown(getItemLink(recipeArray.blueprint)) == true
end

-- Any character on the account: LCK when present, else the current character.
function FurC.IsAccountKnown(recipeKey, recipeArray)
  if recipeKey == nil and recipeArray == nil then
    return false
  end
  if recipeArray == nil then
    FurC.EnsureDB()
    recipeArray = FurC.DB[recipeKey]
  end
  if nil == recipeArray then
    return false
  end
  if lib.LCKAvailable() and recipeArray.blueprint then
    return lib.IsKnownByName(getItemLink(recipeArray.blueprint), nil) == true
  end
  return FurC.CanCraft(recipeKey, recipeArray)
end

local function getCraftingSkillType(recipeKey, recipeArray)
  local itemLink = getItemLink(recipeKey)
  local craftingSkillType = GetItemLinkCraftingSkillType(itemLink)

  if 0 == craftingSkillType and recipeArray.blueprint then
    craftingSkillType = GetItemLinkRecipeCraftingSkillType(getItemLink(recipeArray.blueprint))
  elseif 0 == craftingSkillType and recipeArray.recipeListIndex and recipeArray.recipeIndex then
    _, _, _, _, _, _, craftingSkillType = GetRecipeInfo(recipeArray.recipeListIndex, recipeArray.recipeIndex)
  end

  return craftingSkillType
end
this.GetCraftingSkillType = getCraftingSkillType

local recipeArray
local isBuilding = false
local function scanFromFiles()
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
        local recipeLink = getItemLink(recipeId)
        local itemLink = GetItemLinkRecipeResultItemLink(recipeLink) or getItemLink(recipeId)
        recipeArray = FurC.Find(itemLink) or parseBlueprint(recipeLink) or parseFurnitureItem(itemLink)
        if nil == recipeArray then
          FurC.Logger:Debug("scanRecipeFile: error for ID %s - %s", recipeId, itemLink)
        else
          addDatabaseEntry(getItemId(itemLink), { origin = origin, version = versionNumber, blueprint = recipeId })
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
    for versionNumber, versionData in pairs(FurC.Rolis) do
      for itemId in pairs(versionData) do
        addDatabaseEntry(itemId, { origin = src.ROLIS, version = versionNumber })
      end
    end
    for versionNumber, versionData in pairs(FurC.Faustina) do
      for itemId in pairs(versionData) do
        addDatabaseEntry(itemId, { origin = src.ROLIS, version = versionNumber })
      end
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
            FurC.Logger:Debug("invalid rumour item: %s (%s)", itemId, itemLink)
          else
            FurC.Logger:Debug("scanMiscItemFile: Error when scanning item ID %s (origin %s)", itemId, origin)
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
      local existing = parseBlueprint(blueprintLink) or parseFurnitureItem(itemLink) or FurC.DB[itemId]
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
    FurC.Logger:Debug(
      "DB build finished: %d entries in %d ms",
      NonContiguousCount(FurC.DB),
      GetGameTimeMilliseconds() - buildStarted
    )
    FurC.UpdateGui()
  end

  isBuilding = true
  FurC.IsLoading(true)

  if nil ~= task then
    task
      :Call(scanRecipeFile)
      :Then(scanMiscItemFile)
      :Then(scanVendorFiles)
      :Then(scanRolis)
      :Then(scanFestivalFiles)
      :Then(scanRumours)
      :Then(finish)
  else
    scanRecipeFile()
    scanMiscItemFile()
    scanVendorFiles()
    scanRolis()
    scanFestivalFiles()
    scanRumours()
    finish()
  end
end

--- Builds runtime DB from bundled data files if empty
function FurC.EnsureDB()
  if isBuilding or next(FurC.DB) ~= nil then
    return
  end
  FurC.Logger:Debug(GetString(SI_FURC_VERBOSE_SCANNING_DATA_FILE))
  scanFromFiles()
end

--- Applies bundled data files over current DB again
function FurC.RescanFiles()
  if isBuilding then
    return
  end
  FurC.Logger:Debug(GetString(SI_FURC_VERBOSE_SCANNING_DATA_FILE))
  scanFromFiles()
end

--- Wipes runtime DB and rebuilds it from bundled data
function FurC.RebuildDB()
  if isBuilding then
    return
  end
  for itemId in pairs(FurC.DB) do
    FurC.DB[itemId] = nil
  end
  FurC.sortIndexDirty = true
  FurC.Logger:Debug(GetString(SI_FURC_VERBOSE_SCANNING_DATA_FILE))
  scanFromFiles()
end

-- Description string for each source
local function describeSource(recipeKey, recipeArray, source, stripColor)
  if source == src.CRAFTING or source == src.WRIT_VENDOR then
    return FurC.GetMats(recipeKey, recipeArray, stripColor)
  end
  if source == src.ROLIS then
    return this.GetRolisSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.LUXURY then
    return this.GetLuxurySource(recipeKey, recipeArray, stripColor)
  end
  if source == src.GUILDSTORE then
    return GetString(SI_FURC_SEEN_IN_GUILDSTORE)
  end
  if source == src.VENDOR then
    return this.GetAchievementVendorSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.FESTIVAL_DROP then
    return this.GetEventDropSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.PVP then
    return this.GetPvpSource(recipeKey, recipeArray, stripColor)
  end
  if source == src.RUMOUR then
    return this.GetRumourSource(recipeKey, recipeArray, stripColor)
  end
  return this.GetMiscItemSource(recipeKey, recipeArray, stripColor, source)
end
this.DescribeSource = describeSource

-- Single-string description for primary origin (by ranking)
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry looked up via FurC.Find if omitted
---@param stripColor? boolean strip colour control chars
---@return string
local function getItemDescription(recipeKey, recipeArray, stripColor)
  recipeKey = getItemId(recipeKey)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  if {} == recipeArray then
    return ""
  end
  return describeSource(recipeKey, recipeArray, recipeArray.origin, stripColor)
end
this.GetItemDescription = getItemDescription

---@deprecated alias for DBQuery.GetItemDescription
FurC.GetItemDescription = getItemDescription

-- Ranked lines for every item source (except crafting)
-- Always shows at least one line if any sources exist
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry
---@param stripColor? boolean
---@return string[] lines one per source, ranked (honours tooltip blacklist)
local function getSourceLines(recipeKey, recipeArray, stripColor)
  recipeKey = getItemId(recipeKey)
  recipeArray = recipeArray or FurC.Find(recipeKey)
  local sources = recipeArray and recipeArray.sources
  if not sources then
    return {}
  end

  local ranked = {}
  for s in pairs(sources) do
    if s ~= src.CRAFTING then
      ranked[#ranked + 1] = s
    end
  end
  table.sort(ranked, function(a, b)
    return (SOURCE_PRIORITY[a] or math.huge) < (SOURCE_PRIORITY[b] or math.huge)
  end)

  local lines = {}
  for _, s in ipairs(ranked) do
    if not (FurC.IsTooltipSourceHidden and FurC.IsTooltipSourceHidden(s)) then
      local text = describeSource(recipeKey, recipeArray, s, stripColor)
      if text and #text > 0 then
        lines[#lines + 1] = text
      end
    end
  end

  -- even if hiding every source: show at least 1 line
  if #lines == 0 and recipeArray.origin and recipeArray.origin ~= src.CRAFTING then
    local text = describeSource(recipeKey, recipeArray, recipeArray.origin, stripColor)
    if text and #text > 0 then
      lines[#lines + 1] = text
    end
  end
  return lines
end
this.GetSourceLines = getSourceLines

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
