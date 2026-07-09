-- FurnitureCatalogue_DevUtility
--
-- Meta dump: full DB (including metadata only available ingame)
--   id -> { name, quality, cat, sub, theme }
--   categories[catId] -> { name, parent, order }
--
-- Run on ENGLISH client to get correct names etc

local this = FurCDev

local LINK_STYLE = LINK_STYLE_BRACKETS or 1

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

-- Enumerate all furniture categories
local function buildTaxonomy()
  local categories = {}
  for ci = 1, GetNumFurnitureCategories() do
    local catId = GetFurnitureCategoryId(ci)
    if catId and catId ~= 0 and not categories[catId] then
      local name, parent, _, order = GetFurnitureCategoryInfo(catId)
      categories[catId] = { name = name or "", parent = parent or 0, order = order or 0 }
    end
    for si = 1, GetNumFurnitureSubcategories(ci) do
      local subId = GetFurnitureSubcategoryId(ci, si)
      if subId and subId ~= 0 and not categories[subId] then
        local name, parent, _, order = GetFurnitureCategoryInfo(subId)
        categories[subId] = { name = name or "", parent = parent or catId or 0, order = order or 0 }
      end
    end
  end
  return categories
end

local function buildMeta()
  FurC.EnsureDB(true) -- we need FurC.DB ready, so no LibAsync here
  local getLink = FurC.Utils.GetItemLink
  local getName = FurC.Utils.GetItemName

  local meta = {}
  local stats = { items = 0, furniture = 0, recipesResolved = 0 }

  for id in pairs(FurC.DB or {}) do
    if type(id) == "number" and id > 9999 then
      stats.items = stats.items + 1
      local itemLink = getLink(id)
      local rec = { name = getName(id), quality = GetItemLinkFunctionalQuality(itemLink) or 0 }

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
function this.DumpMeta()
  local meta, categories, stats = buildMeta()

  local numCats = NonContiguousCount(categories)
  FurCDev_SavedVariables = FurCDev_SavedVariables or {}
  FurCDev_SavedVariables.meta = {
    format = "furniture-meta-v1",
    -- "Language.2" is the CVar name for the UI language "en", "de", and so on
    locale = GetCVar and GetCVar("Language.2") or "unknown",
    apiVersion = GetAPIVersion and GetAPIVersion() or 0,
    items = meta,
    categories = categories,
  }

  local summary = string.format(
    "FurCDev meta dump\n  items:      %d\n  furniture:  %d (of which %d resolved via recipe)\n  categories: %d\n\nReload the UI to write SavedVariables to disk.",
    stats.items,
    stats.furniture,
    stats.recipesResolved,
    numCats
  )

  if FurC.Logger then
    FurC.Logger:Info(
      "|cFF3333FurCDev|r meta dump: %d items, %d furniture, %d categories.",
      stats.items,
      stats.furniture,
      numCats
    )
  end

  if this.textbox and this.control then
    this.textbox:SetText(summary)
    this.control:SetHidden(false)
  else
    d(summary)
  end

  local LAM = LibAddonMenu2
  if LAM and LAM.util then
    LAM.util.ShowConfirmationDialog("Reload UI?", "Reload to write the dump to disk.", function()
      ReloadUI("ingame")
    end)
  end
end
