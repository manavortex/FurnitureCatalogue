local LCK = LibCharacterKnowledge


local function getRecipeLinkFromItemLink(itemLink)
  local item = FurC.Find(itemLink)
  -- return unchanged if we have no info
  if not item.blueprint then return itemLink end

  local blueprint = FurC.GetItemLink(item.blueprint)
  return blueprint
end

local function getItemLinkFromRecipeLink(recipeLink)
  return GetItemLinkRecipeResultItemLink(recipeLink)
end

-- CHARACTER KNOWLEDGE --

---@param itemId number recipe or furnishing id
---@return boolean isKnown
function FurC.IsRecipeIdKnownByAccount(itemId)
  local itemLink = LCK.GetItemLinkFromItemId(itemId)
  return FurC.IsRecipeKnownByAccount(itemLink)
end

---@param itemLink string recipe link
---@return boolean isKnown
function FurC.IsRecipeKnownByAccount(itemLink)
  local recipeLink = getRecipeLinkFromItemLink(itemLink)
  local knowledgeList = LCK.GetItemKnowledgeList(recipeLink)

  for _, characterKnowledge in ipairs(knowledgeList) do
    if characterKnowledge.knowledge == LCK.KNOWLEDGE_KNOWN then
      return true
    end
  end

  return false
end

-- FurC.CanCurrentCharacterCraft(166878)
-- FurC.CanCurrentCharacterCraft(119394)
---Check if current character can craft item
---@param itemId number recipe or furnishing id
---@return boolean
function FurC.CanCurrentCharacterCraft_id(itemId)
  local itemLink = LCK.GetItemLinkFromItemId(itemId)
  local recipeLink = getRecipeLinkFromItemLink(itemLink)
  return FurC.CanCurrentCharacterCraft(recipeLink)
end

---@param itemLink string recipe or furnishing link
---@return boolean
function FurC.CanCurrentCharacterCraft(itemLink)
  local recipeLink = getRecipeLinkFromItemLink(itemLink)
  local knowledge = LCK.GetItemKnowledgeForCharacter(recipeLink)
  return knowledge == LCK.KNOWLEDGE_KNOWN
end

---@param itemLink string recipe link
---@return table listOfCrafters
function FurC.GetCraftersForItem(itemLink)
  local recipeLink = getRecipeLinkFromItemLink(itemLink)
  local knowledgeList = LCK.GetItemKnowledgeList(recipeLink)
  local crafters = {}

  for _, characterKnowledge in ipairs(knowledgeList) do
    if characterKnowledge.knowledge == LCK.KNOWLEDGE_KNOWN then
      table.insert(crafters, characterKnowledge.name)
    end
  end

  return crafters
end

-- TABLE UTILS --

--- Merges Table2 into Table1, mutates Table1 inplace and replaces its values if they have the same key. Example: merge({a="1",b="3"},{b="2"}) => {a="1",b="2"}
--- @param t1 any
--- @param t2 any
--- @see ZO_CombineNonContiguousTables (for no entry replacement)
--- @return table
function FurC.MergeTable(t1, t2)
  if nil == t2 and nil == t1 then
    return {}
  elseif nil == t2 then
    return t1
  elseif nil == t1 then
    return t2
  end

  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

-- ruthlessly stolen from TextureIt
-- ToDo: ZO_TableOrderingFunction
--- @return table sortedTable
function FurC.SortTable(tTable, sortKey, SortOrderUp)
  local keys = {}
  for k in pairs(tTable) do table.insert(keys, k) end
  table.sort(keys, function(a, b)
    if nil == tTable[a] or nil == tTable[b] then

    elseif nil == tTable[a][sortKey] then
      return false
    elseif nil == tTable[b][sortKey] then
      return true
    else
      if SortOrderUp then
        return tTable[a][sortKey] > tTable[b][sortKey]
      else
        return tTable[a][sortKey] < tTable[b][sortKey]
      end
    end
    return tTable
  end)

  local ret = {}
  for _, k in ipairs(keys) do
    local entry = tTable[k]
    table.insert(ret, entry)
  end

  return ret
end

-- STRING UTILS --

function FurC.capitalise(str)
  str = str:gsub("^(%l)(%w*)", function(a, b) return string.upper(a) .. b end)
  return str
end

function FurC.stripColor(aString)
  if nil == aString then return "" end
  return aString:gsub("|%l%l%d%d%d%d%d", ""):gsub("|%l%l%d%l%l%d%d", ""):gsub("|c25C31E", ""):gsub("", "")
end
