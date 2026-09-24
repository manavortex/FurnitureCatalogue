-- In-game reference metadata for the JSONL pipeline.
local this = FurCDev
local LINK_STYLE = LINK_STYLE_BRACKETS or 1
local META_FORMAT = "furniture-meta-v1"

local function currentLocale()
  -- "Language.2" is the CVar name for the UI language "en", "de", and so on
  local locale = GetCVar and GetCVar("Language.2")
  if type(locale) ~= "string" or locale == "" then
    return "unknown"
  end
  return locale
end

---SavedVariables only reach disk on reload or logout
local function promptReload()
  local LAM = LibAddonMenu2
  if LAM and LAM.util then
    LAM.util.ShowConfirmationDialog("Reload UI?", "Reload to write the dump to disk.", function()
      ReloadUI("ingame")
    end)
  else
    d("|cFF3333FurCDev|r: reload the UI to write the dump to disk.")
  end
end
this.PromptReload = promptReload

---Fresh SavedVariables root: one export per file, no leftovers
local function savedVars()
  FurCDev_SavedVariables = {}
  return FurCDev_SavedVariables
end

---Show text in the dev window's output box, or chat when there is no window
local function showOutput(text)
  if this.textbox and this.control then
    this.textbox:SetText(text .. "\n")
    this.control:SetHidden(false)
  else
    d(text)
  end
end

-------------------------
-- Shape: meta
-------------------------

---Furniture data id for item or recipe link. A recipe resolves to the furnishing it produces
---@param itemLink any item or recipe link
---@return integer dataId 0 when no furnishing resolved
---@return boolean viaRecipe true if id came from recipe->result resolve
local function furnitureDataIdFor(itemLink)
  local dataId = GetItemLinkFurnitureDataId(itemLink)
  if dataId ~= 0 then
    return dataId, false
  end
  local resultLink = GetItemLinkRecipeResultItemLink(itemLink, LINK_STYLE)
  if resultLink and resultLink ~= "" and resultLink ~= itemLink then
    return GetItemLinkFurnitureDataId(resultLink), true
  end
  return 0, false
end

-- Category vocabulary comes from the library, which reads the client's own
-- enumeration; categories and subcategories share one id space
local function buildTaxonomy()
  return LibFurnitureCatalogue.API.GetFurnitureCategories()
end

local function buildMeta()
  FurC.EnsureDB(true) -- we need FurC.DB ready, so no LibAsync here
  local getLink = FurC.Utils.GetItemLink
  local getName = FurC.Utils.GetItemName

  local meta = {}
  local stats = { items = 0, furniture = 0, recipesResolved = 0, blueprints = 0 }

  for id, entry in pairs(FurC.DB or {}) do
    if type(id) == "number" and id > 9999 then
      stats.items = stats.items + 1
      local itemLink = getLink(id)
      local rec = { name = getName(id), quality = GetItemLinkFunctionalQuality(itemLink) or 0 }

      -- The blueprint this furnishing is made from.
      local blueprint = type(entry) == "table" and entry.blueprint or nil
      if type(blueprint) == "number" and blueprint > 0 and blueprint ~= id then
        rec.blueprint = blueprint
        stats.blueprints = (stats.blueprints or 0) + 1
      end

      local icon = GetItemLinkIcon(itemLink)
      if type(icon) == "string" and icon ~= "" then
        rec.icon = icon
      end

      local dataId, viaRecipe = furnitureDataIdFor(itemLink)
      if dataId ~= 0 then
        rec.cat, rec.sub, rec.theme = GetFurnitureDataInfo(dataId)
        stats.furniture = stats.furniture + 1
        if viaRecipe then
          stats.recipesResolved = stats.recipesResolved + 1
        end
      end

      meta[id] = rec
    end
  end

  return meta, buildTaxonomy(), stats
end

-- Build the meta dataset, store it in SavedVars
function this.DumpMeta(skipReloadPrompt)
  local metaItems, categories, stats = buildMeta()

  local numCats = NonContiguousCount(categories)
  savedVars().meta = {
    format = META_FORMAT,
    locale = currentLocale(),
    apiVersion = GetAPIVersion and GetAPIVersion() or 0,
    items = metaItems,
    categories = categories,
  }

  if FurC.Logger then
    FurC.Logger:Info(
      "|cFF3333FurCDev|r meta dump: %d items, %d furniture, %d blueprints, %d categories.",
      stats.items,
      stats.furniture,
      stats.blueprints,
      numCats
    )
  end

  showOutput(
    string.format(
      "FurCDev meta dump\n  items:      %d\n  furniture:  %d (of which %d resolved via recipe)\n  blueprints: %d\n  categories: %d\n\nReload the UI to write SavedVariables to disk.",
      stats.items,
      stats.furniture,
      stats.recipesResolved,
      stats.blueprints,
      numCats
    )
  )

  if not skipReloadPrompt then
    promptReload()
  end
end

-------------------------
-- Dump tab
-------------------------

local BUTTON_WIDTH = 190
local BUTTON_HEIGHT = 28
local ROW_GAP = 34

---@param panel table parent control
---@param index integer row, top to bottom
---@param label string caption
---@param hint string tooltip text
---@param onClicked function
local function addButton(panel, index, label, hint, onClicked)
  local name = "FurCDevControl_Dump_" .. label:gsub("%W", "")
  local button = WINDOW_MANAGER:CreateControlFromVirtual(name, panel, "ZO_DefaultButton")
  button:SetDimensions(BUTTON_WIDTH, BUTTON_HEIGHT)
  button:SetAnchor(TOPLEFT, panel, TOPLEFT, 0, (index - 1) * ROW_GAP)
  button:SetText(label)
  button:SetHandler("OnClicked", onClicked)

  button:SetHandler("OnMouseEnter", function(control)
    InitializeTooltip(InformationTooltip, control, RIGHT, -8, 0, LEFT)
    SetTooltipText(InformationTooltip, hint)
  end)
  button:SetHandler("OnMouseExit", function()
    ClearTooltip(InformationTooltip)
  end)
  return button
end

function this.BuildDumpTab()
  local sibling = FurCDevControl_Achievements
  local parent = sibling and sibling.GetParent and sibling:GetParent()
  if
    not parent
    or not WINDOW_MANAGER
    or not WINDOW_MANAGER.CreateControl
    or not WINDOW_MANAGER.CreateControlFromVirtual
  then
    return
  end

  local panel = WINDOW_MANAGER:CreateControl("FurCDevControl_Dump", parent, CT_CONTROL)
  panel:SetAnchorFill(parent)
  panel:SetHidden(true)

  addButton(
    panel,
    1,
    "Meta dump",
    "Names, quality, category, icon path and the category tree.\nWrites FurCDev_SavedVariables.meta.\nReload to write it to disk.",
    function()
      this.DumpMeta(true)
    end
  )
  addButton(panel, 2, "Reload UI", "Flushes SavedVariables to disk.\nAsks first.", promptReload)
  this.RegisterTab("dump", "Dump", panel)
end
