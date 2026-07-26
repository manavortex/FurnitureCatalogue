-- User/character state: favourites, SavedVars migrations, knowledge checks, tooltip source-line assembly

local LFC = LibFurnitureCatalogue
local src = LFC.Internal.Constants.ItemSources

local getItemId = LFC.Internal.Format.GetItemId
local getItemLink = LFC.Internal.Format.GetItemLink

-- DB-content query table, published by the lib (GetSourceLines is still main-side)
local this = FurC.DBQuery
local lib = FurC.Internal

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
        entries = entries + NonContiguousCount(aw.data)
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

-- Tooltip source lines: applies user's source blacklist over lib GetRankedSources
-- Always shows at least one line if any non-crafting sources exist
---@param recipeKey string|integer item link or id
---@param recipeArray? FurCEntry
---@param stripColor? boolean
---@return string[] lines one per source, ranked (honours tooltip blacklist)
local function getSourceLines(recipeKey, recipeArray, stripColor)
  recipeArray = recipeArray or this.Find(recipeKey)
  local ranked = this.GetRankedSources(recipeKey, recipeArray, stripColor)

  local lines = {}
  for _, entry in ipairs(ranked) do
    if not (FurC.IsTooltipSourceHidden and FurC.IsTooltipSourceHidden(entry.source)) then
      lines[#lines + 1] = entry.text
    end
  end

  -- even if hiding every source: show at least 1 line (the primary origin)
  if #lines == 0 and recipeArray and recipeArray.origin and recipeArray.origin ~= src.CRAFTING then
    for _, entry in ipairs(ranked) do
      if entry.source == recipeArray.origin then
        lines[1] = entry.text
        break
      end
    end
  end
  return lines
end
FurC.GetSourceLines = getSourceLines

---@deprecated alias, use FurC.GetSourceLines (presentation, not a DB query)
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
