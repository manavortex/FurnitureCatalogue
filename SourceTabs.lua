-- Source-tab tree: top-level tabs, optionally with child tabs that only
-- apply within their parent. Selecting a parent with children still just
-- sets ddSource to the parent's own id.

local LFC = LibFurnitureCatalogue
local src = LFC.API.GetSourceTypes()

-- Node shapes:
--   { id = src.X }                      selectable leaf
--   { id = src.X, children = { ... } }  selectable, with a submenu
--   { key = "name", children = { ... } } group header, not selectable itself
--   { id = src.X, catchAll = true }     children filled by subtraction, so there are no orphans
--
-- Labels and tooltips come from DropdownData at build time
local SOURCE_TREE = {
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
  { id = src.VENDOR },
  { id = src.PVP },
  { id = src.TELVAR },
  { id = src.BAZAAR },
  { id = src.CROWN },
  { id = src.ANTIQUITY },
  { id = src.RUMOUR },
  { id = src.LUXURY },
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
    local copy = { id = node.id, key = node.key, children = node.children }
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

function FurC.InitSourceMenu(control)
  local function selectSource(choices, id)
    FurC.SetDropdownChoice("Source", choices[id], id)
    FurC.UpdateDropdownChoice("Source")
    PlaySound(SOUNDS.POSITIVE_CLICK)
  end

  local function buildMenu()
    local choices = FurC.DropdownData.ChoicesSource
    local tooltips = FurC.DropdownData.TooltipsSource

    ClearMenu()
    -- ipairs so it's declaration order, not pairs order
    for _, node in ipairs(getResolvedTree()) do
      local label = (node.id and choices[node.id]) or (node.key and GetString(node.key))
      if label then
        if node.children then
          local entries = {}
          for _, child in ipairs(node.children) do
            if choices[child.id] then
              entries[#entries + 1] = {
                label = choices[child.id],
                tooltip = tooltips and tooltips[child.id],
                callback = function()
                  selectSource(choices, child.id)
                end,
              }
            end
          end
          --TODO: do we need those or is every parent also a filter?
          -- Parent without an id has no filter but opens submenu
          local onSelect = node.id and function()
            selectSource(choices, node.id)
          end
          AddCustomSubMenuItem(label, entries, nil, nil, nil, nil, onSelect)
        else
          AddCustomMenuItem(label, function()
            selectSource(choices, node.id)
          end)
        end
        if node.id and tooltips and tooltips[node.id] then
          AddCustomMenuTooltip(tooltips[node.id])
        end
      end
    end
    ShowMenu(control)
  end

  control:SetHandler("OnMouseUp", function(self, button, upInside)
    if button == MOUSE_BUTTON_INDEX_LEFT and upInside then
      if ZO_Menu:IsHidden() then
        buildMenu()
      else
        ClearMenu()
      end
    end
  end)
end
