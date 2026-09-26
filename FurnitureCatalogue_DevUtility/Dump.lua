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
-- Shape: names
-------------------------

-- Id -> name tables the website shows beside the ids in the data. The game needs none of them.
local NAMES_FORMAT = "furniture-names-v1"
local PAGE_BYTES = 24000 -- what the output box can hand to the clipboard in one go

---Every zone now, where the search tab builds them over several seconds
local function buildAllZones()
  local numZones, found = GetNumZones(), 0
  for id = 1, numZones * 100 do
    local name = this.Internal.FormatName(GetZoneNameById(id))
    if name ~= "" then
      this.Zones[id] = name
      found = found + 1
      if found >= numZones then
        break
      end
    end
  end
end

-- builders are looked up when used, so this file does not depend on Internal.lua loading first
local NAME_KINDS = {
  { key = "houses", label = "Houses", source = "Houses", build = "BuildHouseTable" },
  { key = "quests", label = "Quests", source = "Quests", build = "BuildQuestTable" },
  { key = "achievements", label = "Achievements", source = "Achievements", build = "BuildAchievementTable" },
  { key = "zones", label = "Zones", source = "Zones", build = buildAllZones },
}

---@return table<integer, string> names a copy, so a later rebuild cannot change a dump
local function namesOf(kind)
  local names = this[kind.source]
  if NonContiguousCount(names) < 1 or kind.key == "zones" then
    if type(kind.build) == "function" then
      kind.build()
    else
      this.Internal[kind.build]()
    end
  end
  local copy = {}
  for id, name in pairs(names) do
    copy[id] = name
  end
  return copy
end

local namePages, namePage, nameControls = {}, 1, {}

local function refreshNamePager()
  if not nameControls.page then
    return
  end
  nameControls.prev:SetEnabled(namePage > 1)
  nameControls.next:SetEnabled(namePage < #namePages)
  nameControls.page:SetText(#namePages > 0 and string.format("Page %d / %d", namePage, #namePages) or "No output")
end

local function showNamePage(delta)
  if #namePages == 0 then
    return
  end
  namePage = math.max(1, math.min(#namePages, namePage + (delta or 0)))
  showOutput(namePages[namePage])
  if this.selectAllOutput then
    this.selectAllOutput()
  end
  refreshNamePager()
end

---One Lua table, split into pages that concatenate back into it
---@return string[] pages
function this.NamePages(kind, names, pageBytes)
  pageBytes = pageBytes or PAGE_BYTES
  local ids = {}
  for id in pairs(names) do
    ids[#ids + 1] = id
  end
  table.sort(ids)
  local lines = {
    string.format("-- %s, %s, API %s, %d names", kind, currentLocale(), GetAPIVersion and GetAPIVersion() or 0, #ids),
    kind .. " = {",
  }
  for _, id in ipairs(ids) do
    lines[#lines + 1] = string.format("  [%d] = %q,", id, names[id])
  end
  lines[#lines + 1] = "}"

  local pages, chunk, size = {}, {}, 0
  for _, line in ipairs(lines) do
    -- room for the page label added below
    if size + #line + 1 > pageBytes - 64 and #chunk > 0 then
      pages[#pages + 1] = table.concat(chunk, "\n")
      chunk, size = {}, 0
    end
    chunk[#chunk + 1] = line
    size = size + #line + 1
  end
  pages[#pages + 1] = table.concat(chunk, "\n")
  -- a page pasted on its own still says which table it belongs to; a comment keeps the joined pages valid Lua
  for i = 2, #pages do
    pages[i] = string.format("-- %s, page %d of %d\n%s", kind, i, #pages, pages[i])
  end
  return pages
end

function this.DumpNames(key)
  for _, kind in ipairs(NAME_KINDS) do
    if kind.key == key then
      namePages, namePage = this.NamePages(key, namesOf(kind)), 1
      showNamePage()
      return
    end
  end
end

-- One file with all four, for when the pages get too many to copy
function this.DumpAllNames(skipReloadPrompt)
  local dump = { format = NAMES_FORMAT, locale = currentLocale(), apiVersion = GetAPIVersion and GetAPIVersion() or 0 }
  local counts = {}
  for _, kind in ipairs(NAME_KINDS) do
    dump[kind.key] = namesOf(kind)
    counts[#counts + 1] = string.format("  %-13s %d", kind.key .. ":", NonContiguousCount(dump[kind.key]))
  end
  savedVars().names = dump
  showOutput(
    "FurCDev names dump\n" .. table.concat(counts, "\n") .. "\n\nReload the UI to write SavedVariables to disk."
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

  for i, kind in ipairs(NAME_KINDS) do
    addButton(
      panel,
      3 + i,
      kind.label .. " names",
      '[id] = "name" as Lua, shown in the output box.\nCopy it page by page. No reload needed.',
      function()
        this.DumpNames(kind.key)
      end
    )
  end
  local pagerY = (3 + #NAME_KINDS) * ROW_GAP
  nameControls.prev =
    WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Dump_NamesPrev", panel, "ZO_DefaultButton")
  nameControls.prev:SetDimensions(50, BUTTON_HEIGHT)
  nameControls.prev:SetAnchor(TOPLEFT, panel, TOPLEFT, 0, pagerY)
  nameControls.prev:SetText("<")
  nameControls.prev:SetHandler("OnClicked", function()
    showNamePage(-1)
  end)
  nameControls.page = WINDOW_MANAGER:CreateControl("FurCDevControl_Dump_NamesPage", panel, CT_LABEL)
  nameControls.page:SetFont("ZoFontGame")
  nameControls.page:SetDimensions(BUTTON_WIDTH - 100, BUTTON_HEIGHT)
  nameControls.page:SetAnchor(TOPLEFT, panel, TOPLEFT, 50, pagerY + 2)
  nameControls.page:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
  nameControls.next =
    WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Dump_NamesNext", panel, "ZO_DefaultButton")
  nameControls.next:SetDimensions(50, BUTTON_HEIGHT)
  nameControls.next:SetAnchor(TOPLEFT, panel, TOPLEFT, BUTTON_WIDTH - 50, pagerY)
  nameControls.next:SetText(">")
  nameControls.next:SetHandler("OnClicked", function()
    showNamePage(1)
  end)
  addButton(
    panel,
    5 + #NAME_KINDS,
    "All names to file",
    "Houses, quests, achievements and zones together.\nWrites FurCDev_SavedVariables.names.\nReload to write it to disk.",
    function()
      this.DumpAllNames()
    end
  )
  refreshNamePager()
  this.RegisterTab("dump", "Dump", panel)
end
