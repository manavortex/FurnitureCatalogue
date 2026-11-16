-- List manager: "All", Favorites, every list and the crafting knowledge in a column beside the Transfer window's
-- box. Picking an entry shows its export; right-click opens it in the catalogue. New, Rename and Delete reuse the
-- prompts in Lists.lua.

FurC.ListManager = FurC.ListManager or {}
local M = FurC.ListManager

local ROW, DIVIDER = 1, 2
local FAVE_ICON = zo_iconFormat("EsoUI/Art/Collections/Favorite_StarOnly.dds", 16, 16) .. " "
local CRAFT_ICON = zo_iconFormat("EsoUI/Art/Inventory/inventory_tabIcon_crafting_up.dds", 20, 20) .. " "
-- #lists does nothing yet, it's there for later, pls leave in
local WEB_URL = "https://wookiefriseur.github.io/LFC/#lists"
local WEB_COLOR, WEB_HOVER_COLOR = ZO_ColorDef:New("5FB4FF"), ZO_ColorDef:New("FFFFFF")

-- account's crafting knowledge: read-only rows after lists; true = holds the known ones
local CRAFT_KEYS = { craft_unknown = false, craft_known = true }

local list, renameButton, deleteButton, saveButton
local selected = "all" -- "all", "faves", a list id or a key of CRAFT_KEYS
local shownTitle

---@return { key: integer|string|nil, label: string? }[] a row without key is a divider
local function entries()
  -- "all" is the favourites and every list, so it stands apart from them, as do the crafting rows
  local rows = {
    { key = "all", label = GetString(SI_FURC_LIST_ALL) },
    {},
    { key = "faves", label = FAVE_ICON .. GetString(SI_FURC_FILTER_SRC_FAVE) },
  }
  for _, l in ipairs(FurC.GetLists()) do
    rows[#rows + 1] = { key = l.id, label = l.name }
  end
  rows[#rows + 1] = {}
  for _, key in ipairs({ "craft_unknown", "craft_known" }) do
    rows[#rows + 1] = { key = key, label = CRAFT_ICON .. FurC.CraftingExport.ListName(CRAFT_KEYS[key]) }
  end
  return rows
end

---@return string text what the box shows for an entry
local function export(key)
  local known = CRAFT_KEYS[key]
  if known ~= nil then
    return FurC.CraftingExport.ExportText(known)
  end
  return (FurC.ListExportText(key ~= "all" and key or nil))
end

---@return string title changes when the entry is renamed
local function titleOf(key)
  if CRAFT_KEYS[key] ~= nil then
    return key
  end
  local _, title = FurC.ListExportText(key ~= "all" and key or nil)
  return title
end

local highlight

---@return table frame place and size of the window, kept in the saved variables
local function frameSettings()
  local gui = FurC.settings.gui
  gui.listManager = gui.listManager or {}
  return gui.listManager
end

local function show(key)
  selected = key
  shownTitle = titleOf(key)
  FurC.Transfer.Open({
    title = GetString(SI_FURC_LISTS),
    hint = GetString(SI_FURC_LIST_MANAGER_HINT),
    side = true,
    frame = frameSettings(),
    onResize = function()
      ZO_ScrollList_Commit(list) -- more or fewer rows fit
      highlight()
    end,
    getText = function()
      return export(key)
    end,
    onImport = M.Refresh,
  })
  local isList, isCraft = type(key) == "number", CRAFT_KEYS[key] ~= nil
  renameButton:SetEnabled(isList)
  deleteButton:SetEnabled(isList)
  -- a crafting row can be neither renamed nor deleted; Delete's place holds its dump to the saved variables
  deleteButton:SetHidden(isCraft)
  saveButton:SetHidden(not isCraft)
end

local function confirmSaveToFile()
  local LAM = LibAddonMenu2
  if LAM and LAM.util then
    LAM.util.ShowConfirmationDialog(
      GetString(SI_FURC_CRAFT_SAVE),
      GetString(SI_FURC_CRAFT_SAVE_BODY),
      FurC.CraftingExport.SaveToFile
    )
  end
end

function highlight()
  for _, entry in ipairs(ZO_ScrollList_GetDataList(list)) do
    if entry.data.key == selected then
      ZO_ScrollList_SelectData(list, entry.data)
      return
    end
  end
end

local function build()
  local side = FurC.Transfer.SidePanel()
  local wm = WINDOW_MANAGER

  list = wm:CreateControlFromVirtual("$(parent)Lists", side, "ZO_ScrollList")
  list:SetAnchor(TOPLEFT, side, TOPLEFT, 0, 0)
  list:SetAnchor(BOTTOMRIGHT, side, BOTTOMRIGHT, 0, -104)
  ZO_ScrollList_AddDataType(list, ROW, "ZO_SelectableLabel", 26, function(control, data)
    control:SetFont("ZoFontGame")
    control:SetWidth(side:GetWidth() - 20) -- clear of the scroll bar
    control:SetMaxLineCount(1)
    control:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
    control:SetText(data.label)
    control:SetHandler("OnMouseUp", function(_, button, upInside)
      if upInside and button == MOUSE_BUTTON_INDEX_LEFT then
        show(data.key)
        highlight()
      elseif upInside and button == MOUSE_BUTTON_INDEX_RIGHT and data.key ~= "all" then
        local src = LibFurnitureCatalogue.API.GetSourceTypes()
        local known = CRAFT_KEYS[data.key]
        if known ~= nil then
          FurC.ShowSource(known and src.CRAFTING_KNOWN or src.CRAFTING_UNKNOWN)
        else
          FurC.ShowSource(data.key == "faves" and src.FAVE or FurC.ListSourceId(data.key))
        end
      end
    end)
  end)
  ZO_ScrollList_AddDataType(list, DIVIDER, "FurC_ListManagerDivider", 10, function() end)
  ZO_ScrollList_EnableSelection(list, "ZO_ThinListHighlight")

  local function button(name, stringId, offsetY, onClick)
    local b = wm:CreateControlFromVirtual("$(parent)" .. name, side, "ZO_DefaultButton")
    b:SetText(GetString(stringId))
    b:SetAnchor(BOTTOMLEFT, side, BOTTOMLEFT, 0, offsetY)
    b:SetAnchor(BOTTOMRIGHT, side, BOTTOMRIGHT, 0, offsetY)
    b:SetHeight(28)
    b:SetHandler("OnClicked", onClick)
    return b
  end
  button("New", SI_FURC_LIST_NEW, -68, function()
    FurC.PromptNewList()
  end)
  renameButton = button("Rename", SI_FURC_LIST_RENAME, -34, function()
    FurC.PromptRenameList(selected)
  end)
  deleteButton = button("Delete", SI_FURC_LIST_DELETE, 0, function()
    FurC.ConfirmDeleteList(selected)
  end)
  saveButton = button("Save", SI_FURC_CRAFT_SAVE, 0, confirmSaveToFile)
  saveButton:SetHidden(true)

  local web = wm:CreateControl("$(parent)Web", side, CT_LABEL)
  web:SetFont("ZoFontGameBold")
  web:SetText(GetString(SI_FURC_LIST_WEB))
  web:SetColor(WEB_COLOR:UnpackRGBA())
  web:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
  web:SetVerticalAlignment(TEXT_ALIGN_CENTER)
  web:SetAnchor(BOTTOMLEFT, side, BOTTOMLEFT, 0, 40)
  web:SetAnchor(BOTTOMRIGHT, side, BOTTOMRIGHT, 0, 40)
  web:SetHeight(28)
  web:SetMouseEnabled(true)
  web:SetHandler("OnMouseUp", function(_, mouseButton, upInside)
    if upInside and mouseButton == MOUSE_BUTTON_INDEX_LEFT then
      RequestOpenUnsafeURL(WEB_URL)
    end
  end)
  web:SetHandler("OnMouseEnter", function(control)
    control:SetColor(WEB_HOVER_COLOR:UnpackRGBA())
    InitializeTooltip(InformationTooltip, control, TOP, 0, 5, BOTTOM)
    SetTooltipText(InformationTooltip, GetString(SI_FURC_LIST_WEB_TOOLTIP))
  end)
  web:SetHandler("OnMouseExit", function(control)
    control:SetColor(WEB_COLOR:UnpackRGBA())
    ClearTooltip(InformationTooltip)
  end)
end

---Rebuild the column; Lists.lua calls it whenever a list is created, renamed or deleted
function M.Refresh()
  if not list then
    return
  end
  ZO_ScrollList_Clear(list)
  local data, stillThere = ZO_ScrollList_GetDataList(list), false
  for _, row in ipairs(entries()) do
    data[#data + 1] = ZO_ScrollList_CreateDataEntry(row.key and ROW or DIVIDER, row)
    stillThere = stillThere or row.key == selected
  end
  ZO_ScrollList_Commit(list)
  if FurC.Transfer.IsOpen() then
    -- re-show only when what is shown changed (deleted or renamed), so an import's report stays on screen
    if not stillThere or titleOf(selected) ~= shownTitle then
      show(stillThere and selected or "all")
    end
  end
  highlight()
end

---@param key integer|string "all", "faves", a list id, "craft_unknown" or "craft_known"
function M.Open(key)
  if not list then
    build()
  end
  selected = key
  M.Refresh()
  show(key)
  highlight()
end
