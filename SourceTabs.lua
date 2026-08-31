-- Source-tab tree: top-level tabs, optionally with child tabs that only
-- apply within their parent. Selecting a parent with children still just
-- sets ddSource to the parent's own id.

local LFC = LibFurnitureCatalogue
local src = LFC.API.GetSourceTypes()

-- id: the src.* value this tab sets as ddSource when clicked
-- children: optional list of child nodes, same shape
local SOURCE_TREE = {
  { id = src.NONE, label = GetString(SI_FURC_FILTER_SRC_NONE) },
  { id = src.FAVE, label = GetString(SI_FURC_FILTER_SRC_FAVE) },
  {
    id = src.CRAFTING,
    label = GetString(SI_FURC_FILTER_SRC_CRAFTING),
    children = {
      { id = src.CRAFTING_KNOWN, label = GetString(SI_FURC_FILTER_SRC_CRAFTING_KNOWN) },
      { id = src.CRAFTING_UNKNOWN, label = GetString(SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN) },
    },
  },
  -- Currency, Master Writ Vendor, Other, Rumour: next pass
}
FurC.SourceTree = SOURCE_TREE

-- srcId -> its top-level tab's srcId (a top-level id maps to itself)
local familyRoot, nodeById = {}, {}
local function indexNode(node, rootId)
  rootId = rootId or node.id
  familyRoot[node.id] = rootId
  nodeById[node.id] = node
  for _, child in ipairs(node.children or {}) do
    indexNode(child, rootId)
  end
end
for _, node in ipairs(SOURCE_TREE) do
  indexNode(node)
end

---@param srcId integer any ddSource value
---@return integer? rootId the top-level tab it belongs to, nil if untracked
function FurC.GetSourceFamilyRoot(srcId)
  return familyRoot[srcId]
end

function FurC.GetSourceTreeNode(srcId)
  return nodeById[srcId]
end

-- Crafting-profession row: visible under these top-level families.
-- Favorites included tentatively per your "maybe" — confirm before I wire it up.
local CRAFT_BUTTON_FAMILIES = {
  [src.NONE] = true,
  [src.CRAFTING] = true,
  [src.FAVE] = true,
}

---@param ddSource integer current Source selection
function FurC.ShouldShowCraftingTypeButtons(ddSource)
  local root = familyRoot[ddSource] or ddSource
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
    for id, label in pairs(choices) do
      local root = FurC.GetSourceFamilyRoot(id)
      if not root or root == id then -- skip children, they live in their parent's submenu
        local node = FurC.GetSourceTreeNode(id)
        if node and node.children then
		  local entries = {}
		  for _, child in ipairs(node.children) do
			entries[#entries + 1] = {
			  label = choices[child.id],
			  tooltip = tooltips and tooltips[child.id],
			  callback = function() selectSource(choices, child.id) end,
			}
		  end
		  AddCustomSubMenuItem(label, entries, nil, nil, nil, nil, function()
			selectSource(choices, id)
		  end)
		else
          AddCustomMenuItem(label, function() selectSource(choices, id) end)
        end
        if tooltips and tooltips[id] then
          AddCustomMenuTooltip(tooltips[id])
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