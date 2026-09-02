-- Source-tab tree: top-level tabs, optionally with child tabs that only
-- apply within their parent. Selecting a parent with children still just
-- sets ddSource to the parent's own id.

local LFC = LibFurnitureCatalogue
local src = LFC.API.GetSourceTypes()

-- Node shapes:
--   { id = src.X }                      selectable leaf
--   { id = src.X, children = { ... } }  selectable, with a submenu
--   { stringId = SI_X, children = {} }  group header, not selectable itself
--   { stringId = SI_X }                 label-only row, no filter behind it
--   { id = src.X, catchAll = true }     children filled by subtraction, so there are no orphans
--
-- Labels and tooltips come from DropdownData at build time, group headers from stringId
local SOURCE_TREE = {
  -- TODO: make this stuff a custom menu builder so we can add filter callbacks here more easily?
  { id = src.NONE },
  { id = src.FAVE },
  {
    id = src.CRAFTING,
    children = {
      { id = src.CRAFTING_KNOWN },
      { id = src.CRAFTING_UNKNOWN },
    },
  },
  { id = src.WRIT_VENDOR },
  {
    stringId = SI_FURC_FILTER_SRC_CURRENCY,
    children = {
      {
        id = src.CROWN,
        children = {
          { id = FurC.SourceFilters.CROWN_STORE },
          { id = src.EDITOR },
        },
      },
      {
        id = src.VENDOR,
        children = {
          { id = FurC.SourceFilters.ACHIEVEMENT },
          { id = FurC.SourceFilters.HOME_GOODS },
          { id = src.LUXURY },
        },
      },
	  {
        id = src.PVP,
        children = {
          { id = FurC.SourceFilters.ALLIANCE_POINTS },
          { id = src.TELVAR },
        },
      },
      { id = src.BAZAAR },
    },
  },
  { id = src.ANTIQUITY },
  { id = src.RUMOUR },
  { id = src.JUSTICE },
  { id = src.FISHING },
  -- Orphans that didn't get a main category are adopted by the all-loving OTHER
  { id = src.OTHER, catchAll = true },
}
FurC.SourceTree = SOURCE_TREE

-- Resolved view of the tree (with OTHER auto-filled)
local resolved, familyRoot, nodeById, flatOrder
local builtFrom
local warnedUnlabelled = false

---Sources not used in a node, but with a label
---@param placed table<integer, boolean>
---@param choices table<integer, string>
---@return table[] children
local function collectUngrouped(placed, choices)
  local ungrouped, unlabelled = {}, {}
  for _, id in pairs(src) do
    if not placed[id] then
      if choices[id] then
        ungrouped[#ungrouped + 1] = { id = id }
      else
        unlabelled[#unlabelled + 1] = id
      end
    end
  end

  -- Alphabetical by label
  table.sort(ungrouped, function(a, b)
    return choices[a.id] < choices[b.id]
  end)

  if #unlabelled > 0 and not warnedUnlabelled then
    warnedUnlabelled = true
    table.sort(unlabelled)
    FurC.Logger:Debug(
      "SourceTabs: %d source(s) have no label and cannot be shown: %s",
      #unlabelled,
      table.concat(unlabelled, ", ")
    )
  end

  return ungrouped
end

local function indexNode(node, rootId)
  rootId = rootId or node.id
  if node.id then
    familyRoot[node.id] = rootId
    nodeById[node.id] = node
    flatOrder[#flatOrder + 1] = node.id
  end
  for _, child in ipairs(node.children or {}) do
    indexNode(child, rootId)
  end
end

---@return table[] tree resolved copy, catch-all children filled in
local function getResolvedTree()
  local choices = FurC.DropdownData.ChoicesSource or {}
  if resolved and builtFrom == choices then
    return resolved
  end

  -- Everything the tree accounts for, so catch-all can subtract
  local placed = {}
  local function markPlaced(node)
    if node.id then
      placed[node.id] = true
    end
    for _, child in ipairs(node.children or {}) do
      markPlaced(child)
    end
  end
  for _, node in ipairs(SOURCE_TREE) do
    markPlaced(node)
  end

  resolved, familyRoot, nodeById, flatOrder = {}, {}, {}, {}
  builtFrom = choices

  for _, node in ipairs(SOURCE_TREE) do
    local copy = { id = node.id, stringId = node.stringId, children = node.children }
    if node.catchAll then
      local found = collectUngrouped(placed, choices)
      copy.children = #found > 0 and found or nil
    end
    resolved[#resolved + 1] = copy
    indexNode(copy)
  end

  return resolved
end
FurC.GetResolvedSourceTree = getResolvedTree

---Display order of selectable sources, parents before children
---@return integer[] order
function FurC.GetSourceOrder()
  getResolvedTree()
  return flatOrder
end

---@param srcId integer any ddSource value
---@return integer? rootId the top-level tab it belongs to, nil if untracked
function FurC.GetSourceFamilyRoot(srcId)
  getResolvedTree()
  return familyRoot[srcId]
end

function FurC.GetSourceTreeNode(srcId)
  getResolvedTree()
  return nodeById[srcId]
end

-- Crafting-profession row: visible under these top-level families.
local CRAFT_BUTTON_FAMILIES = {
  [src.NONE] = true,
  [src.CRAFTING] = true,
  [src.FAVE] = true,
}

---@param ddSource integer current Source selection
function FurC.ShouldShowCraftingTypeButtons(ddSource)
  local root = FurC.GetSourceFamilyRoot(ddSource) or ddSource
  return CRAFT_BUTTON_FAMILIES[root] == true
end

