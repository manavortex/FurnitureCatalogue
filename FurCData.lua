local lastLink = nil
local recipeArray = nil

local LFC = LibFurnitureCatalogue
local src = LFC.Internal.Constants.ItemSources

local getItemId = LFC.Internal.Format.GetItemId
local getItemLink = LFC.Internal.Format.GetItemLink
local stripTxt = LFC.Internal.Format.stripTxt

local parseFurnitureItem = LFC.Internal.Build.ParseFurnitureItem
local parseBlueprint = LFC.Internal.Build.ParseBlueprint

-- DB-content query table
FurC.DBQuery = FurC.DBQuery or {}
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

local SOURCE_PRIORITY = LFC.Internal.Constants.SOURCE_PRIORITY

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

-- Description string for each source
local function describeSource(recipeKey, recipeArray, source, stripColor)
  if source == src.CRAFTING or source == src.WRIT_VENDOR then
    -- where blueprint is bought, if we know (otherwise just material list)
    local recipeSource = this.GetRecipeSource(recipeKey, recipeArray)
    if recipeSource and #recipeSource > 0 then
      return (stripColor and stripTxt(recipeSource)) or recipeSource
    end
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
  if nil == next(recipeArray) then
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
