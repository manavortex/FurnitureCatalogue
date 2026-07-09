-- Stubs and fake data for headless only

-- create missing functions
if not string.lower then
  string.lower = function(s)
    return (s:gsub("%u", function(c)
      return string.char(string.byte(c) + 32)
    end))
  end
end
if not string.upper then
  string.upper = function(s)
    return (s:gsub("%l", function(c)
      return string.char(string.byte(c) - 32)
    end))
  end
end
_G.zo_strlower = _G.zo_strlower or string.lower
_G.zo_strupper = _G.zo_strupper or string.upper

-- ---------------------------
-- ESO events
-- ---------------------------
do
  local nextId = 65536
  for _, name in ipairs({
    "EVENT_ADD_ON_LOADED",
    "EVENT_PLAYER_ACTIVATED",
    "EVENT_PLAYER_DEACTIVATED",
    "EVENT_INTERFACE_SETTING_CHANGED",
    "EVENT_INVENTORY_SINGLE_SLOT_UPDATE",
    "EVENT_INVENTORY_FULL_UPDATE",
    "EVENT_CRAFT_COMPLETED",
    "EVENT_END_CRAFTING_STATION_INTERACT",
  }) do
    if not _G[name] then
      _G[name] = nextId
    end
    nextId = nextId + 1
  end
end

-- ---------------------------
-- ESO API
-- (not 100% functionality, just prevents crashes)
-- ---------------------------

-- need it for zo_strformat °__°
if not _G.LocalizeString then
  _G.LocalizeString = function(fmt, ...)
    if type(fmt) ~= "string" then
      return tostring(fmt)
    end
    local args, i = { ... }, 0
    -- won't work on most substitutions.. just test against english strings if at all
    return (fmt:gsub("<<%a?%d>>", function()
      i = i + 1
      return tostring(args[i])
    end))
  end
end
_G.GetDisplayName = _G.GetDisplayName or function()
  return "@EatsYourBugs"
end

if not _G.zo_strsplit then
  _G.zo_strsplit = function(sep, str)
    if type(str) ~= "string" then
      return str
    end
    local parts, pat = {}, "(.-)" .. sep:gsub("(%p)", "%%%1")
    for piece in (str .. sep):gmatch(pat) do
      parts[#parts + 1] = piece
    end
    return unpack(parts)
  end
end

-- placeholder name returner
local function name_api(name)
  return function(id)
    return name .. "(" .. tostring(id) .. ")"
  end
end
for _, name in ipairs({
  "GetCrownCrateName",
  "GetSkillLineNameById",
  "GetCollectibleName",
  "GetQuestName",
  "GetUnitName",
  "GetAchievementLink",
  "GetZoneNameById",
}) do
  if not _G[name] then
    _G[name] = name_api(name)
  end
end

_G.ZO_CreateStringId = _G.ZO_CreateStringId or function(id, value)
  _G[id] = value
end

-- Just in case those are not available in ESOLUA
for _, name in ipairs({
  "IsItemLinkFurnitureRecipe",
  "IsItemLinkRecipeKnown",
  "IsFurniture",
  "IsAccountKnown",
  "IsCharKnown",
  "IsProtectedFunction",
}) do
  if not _G[name] then
    _G[name] = function()
      return false
    end
  end
end

-- need link parser so headless can build DB
local function link_id(link)
  if type(link) == "number" then
    return link
  end
  if type(link) ~= "string" then
    return nil
  end
  return tonumber(link:match(":item:(%d+)"))
end

local function make_link(itemId)
  return string.format("|H1:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", itemId)
end

do
  _G.GetItemLinkItemId = function(link)
    return link_id(link) or 0
  end
  _G.GetItemLinkName = function(link)
    local id = link_id(link)
    return id and ("Item#" .. id) or ""
  end
  _G.IsItemLinkPlaceableFurniture = function(link)
    return link_id(link) ~= nil
  end
  _G.GetItemLinkItemType = function(link)
    return link_id(link) and (ITEMTYPE_FURNISHING or 61) or 0
  end
end

-- furnishing category lookup
_G.GetItemLinkFurnitureDataId = _G.GetItemLinkFurnitureDataId or function()
  return 0
end
_G.GetFurnitureDataCategoryInfo = _G.GetFurnitureDataCategoryInfo or function()
  return 0, 0
end

-- recipe/count (no recipe DB)
for _, name in ipairs({
  "GetNumRecipeLists",
  "GetNumRecipes",
  "GetItemLinkRecipeNumIngredients",
  "GetItemLinkRecipeCraftingSkillType",
  "GetItemLinkCraftingSkillType",
}) do
  if not _G[name] then
    _G[name] = function()
      return 0
    end
  end
end
_G.GetRecipeInfo = _G.GetRecipeInfo or function()
  return nil, nil, 0
end
_G.GetItemLinkGrantedRecipeIndices = _G.GetItemLinkGrantedRecipeIndices or function()
  return nil, nil
end
for _, name in ipairs({
  "GetItemLinkRecipeIngredientInfo",
  "GetItemLinkRecipeIngredientItemLink",
  "GetRecipeIngredientItemInfo",
  "GetRecipeIngredientItemLink",
}) do
  if not _G[name] then
    _G[name] = function()
      return "", 0, 0
    end
  end
end

_G.ClearTooltip = _G.ClearTooltip or function() end
_G.SLASH_COMMANDS = _G.SLASH_COMMANDS or {}

-- Furniture recipes craft a *different* item, so fake should be different too
-- recipeId + FURC_TEST_RESULT_OFFSET.
FURC_TEST_RESULT_OFFSET = 500000

local recipeIds
local function isRecipeId(itemId)
  if nil == itemId then
    return false
  end
  if nil == recipeIds then
    -- data files are loaded after the stubs, so populate on first use
    if nil == FurC or nil == FurC.Recipes then
      return false
    end
    recipeIds = {}
    for _, versionData in pairs(FurC.Recipes) do
      for _, id in ipairs(versionData) do
        recipeIds[id] = true
      end
    end
    for _, tbl in ipairs({ FurC.RolisRecipes or {}, FurC.FaustinaRecipes or {} }) do
      for _, versionData in pairs(tbl) do
        for id in pairs(versionData) do
          recipeIds[id] = true
        end
      end
    end
    for _, folioData in pairs(FurC.FurnishingFolios or {}) do
      for _, id in ipairs(folioData.contents or {}) do
        recipeIds[id] = true
      end
    end
    for _, id in pairs(FurC.RumourRecipes or {}) do
      recipeIds[id] = true
    end
  end
  return recipeIds[itemId] == true
end
_G.FurCTest_IsRecipeId = isRecipeId

_G.IsItemLinkFurnitureRecipe = function(link)
  return isRecipeId(link_id(link))
end

_G.GetItemLinkRecipeResultItemLink = function(link)
  local itemId = link_id(link)
  if not isRecipeId(itemId) then
    return ""
  end
  return make_link(itemId + FURC_TEST_RESULT_OFFSET)
end

_G.SafeAddVersion = _G.SafeAddVersion or function() end

-- if formatter used during DB build
_G.ZO_Currency_FormatKeyboard = _G.ZO_Currency_FormatKeyboard or function(_, amount)
  return tostring(amount or 0)
end
_G.ZO_CURRENCY_FORMAT_AMOUNT_ICON = _G.ZO_CURRENCY_FORMAT_AMOUNT_ICON or 1

_G.GetNumZones = _G.GetNumZones or function()
  return 0
end

-- ---------------------------
-- Libraries
-- ---------------------------
-- LibAsync: queue, don't run
do
  local Task = {}
  Task.__index = Task
  function Task:Call(fn, ...)
    if fn then
      self._queue = self._queue or {}
      self._queue[#self._queue + 1] = fn
    end
    return self
  end
  Task.Then, Task.Finally = Task.Call, Task.Call
  function Task:GetName()
    return self._name
  end
  function Task:Do(fn)
    if fn then
      fn()
    end
    return self
  end
  for _, m in ipairs({ "Cancel", "Suspend", "Resume", "For", "StopTimer" }) do
    Task[m] = function(self)
      return self
    end
  end
  _G.LibAsync = _G.LibAsync
    or {
      Create = function(_, name)
        return setmetatable({ _name = name }, Task)
      end,
    }
end

-- LibAddonMenu
if not _G.LibAddonMenu2 then
  local function ctrl()
    return setmetatable({}, {
      __index = function()
        return ctrl
      end,
    })
  end
  _G.LibAddonMenu2 = {
    RegisterAddonPanel = function()
      return ctrl()
    end,
    RegisterOptionControls = function()
      return ctrl()
    end,
    RegisterWidget = function()
      return true
    end,
    util = setmetatable({}, {
      __index = function()
        return function() end
      end,
    }),
  }
end

-- LibCustomMenu
if not _G.LibCustomMenu then
  _G.LibCustomMenu = setmetatable({
    CATEGORY_EARLY = 1,
    CATEGORY_PRIMARY = 2,
    CATEGORY_SECONDARY = 3,
    CATEGORY_LATE = 4,
  }, {
    __index = function()
      return function() end
    end,
  })
end

-- ---------------------------
-- XML/GUI
-- (have to catch all of that stuff to avoid errors, oof)
-- ---------------------------
do
  local function fake_ctrl()
    local ctrl = {}
    setmetatable(ctrl, {
      __index = function(_, k)
        if k == "IsHidden" or k == "IsControlHidden" then
          return function()
            return true
          end
        end
        return ctrl
      end,
      __call = function()
        return ctrl
      end,
    })
    return ctrl
  end
  for _, name in ipairs({
    "PLAYER_INVENTORY",
    -- FurCDev
    "FurCDevControl",
    "FurCDevControlBox",
    -- FurC
    "FurCGui",
    "FurCGui_Empty",
    "FurCGui_Header",
    "FurCGui_Header_SortBar",
    "FurCGui_Header_SortBar_Name",
    "FurCGui_Header_SortBar_Name_Button",
    "FurCGui_Header_SortBar_Description",
    "FurCGui_ListHolder",
    "FurCGui_ListHolder_Slider",
    "FurCGui_Wait",
    "FurCGui_Header_Bar1_TemplateLarge",
    "FurCGui_Header_Bar1_TemplateTiny",
    "FurC_CraftingTypeFilterButton",
    "FurC_DropdownCharacter",
    "FurC_DropdownSource",
    "FurC_DropdownVersion",
    "FurC_Label",
    "FurC_QualityFilter",
    "FurC_QualityFilterButton",
    "FurC_RecipeCount",
    "FurC_Search",
    "FurC_SearchBox",
    "FurC_ShowCrowns",
    "FurC_ShowRumours",
    "FurC_ShowRumoursGlow",
    "FurC_SlotIconKnownNo",
    "FurC_SlotIconKnownYes",
    "FurC_SlotTemplate",
    "FurC_SlotTemplateTiny",
    "FurC_TypeFilter",
  }) do
    if not _G[name] then
      _G[name] = fake_ctrl()
    end
  end
end
