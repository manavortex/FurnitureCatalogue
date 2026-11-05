-- Custom favourite lists: named, account-wide item lists shown as children of the Favorites source.
-- A list never rolls up into Favorites (and Favorites never into a list): an item may sit on any number of lists.

local LIST_ID_BASE = -1000 -- list n -> source id (-1000 - n): FurC.SourceFilters uses -1..-7, library sources are positive
local MAX_NAME_LENGTH = 32

local revision = 0

local function store()
  local settings = FurC.settings
  settings.customLists = settings.customLists or {}
  local s = settings.customLists
  s.nextId = s.nextId or 1 -- never reused, so a stale id can't point at a newer list
  s.order = s.order or {}
  s.byId = s.byId or {}
  return s
end

---@param listId integer
---@return integer sourceId id the list has as a Source selection
function FurC.ListSourceId(listId)
  return LIST_ID_BASE - listId
end

---@param sourceId integer any Source selection
---@return integer? listId nil when the selection is not a list
function FurC.ListIdFromSource(sourceId)
  if type(sourceId) == "number" and sourceId < LIST_ID_BASE then
    return LIST_ID_BASE - sourceId
  end
end

---Bumped on every change to the set of lists or their names, so SourceTabs knows to rebuild
function FurC.GetListsRevision()
  return revision
end

---@return { id: integer, sourceId: integer, name: string }[] lists in display order
function FurC.GetLists()
  local s = store()
  local lists = {}
  for _, listId in ipairs(s.order) do
    local list = s.byId[listId]
    if list then
      lists[#lists + 1] = { id = listId, sourceId = FurC.ListSourceId(listId), name = list.name }
    end
  end
  return lists
end

---Fresh tree nodes for SourceTabs, one per list. Not rolled into the parent (see indexNode).
function FurC.GetListTreeNodes()
  local nodes = {}
  for _, list in ipairs(FurC.GetLists()) do
    nodes[#nodes + 1] = { id = list.sourceId, noRollup = true }
  end
  return nodes
end

---Keep ChoicesSource (label per source id) in step with the lists
---@param choices table<integer, string> FurC.DropdownData.ChoicesSource
function FurC.ApplyListChoices(choices)
  for sourceId in pairs(choices) do
    if FurC.ListIdFromSource(sourceId) then
      choices[sourceId] = nil
    end
  end
  for _, list in ipairs(FurC.GetLists()) do
    choices[list.sourceId] = list.name
  end
end

local function changed()
  revision = revision + 1
  if FurC.DropdownData and FurC.DropdownData.ChoicesSource then
    FurC.ApplyListChoices(FurC.DropdownData.ChoicesSource)
  end
  if FurC.RefreshSourceDropdown then
    FurC.RefreshSourceDropdown()
  end
end

---@param name string
---@param ownId? integer list being renamed, allowed to keep its own name
---@return string? cleaned, string? errorText
local function validateName(name, ownId)
  name = zo_strtrim(tostring(name or ""))
  if name == "" then
    return nil, GetString(SI_FURC_LIST_ERR_EMPTY)
  end
  if #name > MAX_NAME_LENGTH then
    name = name:sub(1, MAX_NAME_LENGTH)
  end
  -- labels are what the dropdown matches its selection by, so a name must not equal any other label
  local lower = LocaleAwareToLower(name)
  for sourceId, label in pairs(FurC.DropdownData.ChoicesSource) do
    local isOwnLabel = ownId ~= nil and sourceId == FurC.ListSourceId(ownId)
    if not isOwnLabel and LocaleAwareToLower(label) == lower then
      return nil, GetString(SI_FURC_LIST_ERR_TAKEN)
    end
  end
  return name
end

---@return integer? listId, string? errorText
function FurC.CreateList(name)
  local cleaned, err = validateName(name)
  if not cleaned then
    return nil, err
  end
  local s = store()
  local listId = s.nextId
  s.nextId = listId + 1
  s.byId[listId] = { name = cleaned, items = {} }
  s.order[#s.order + 1] = listId
  changed()
  return listId
end

---@return boolean ok, string? errorText
function FurC.RenameList(listId, name)
  local s = store()
  local list = s.byId[listId]
  if not list then
    return false
  end
  local cleaned, err = validateName(name, listId)
  if not cleaned then
    return false, err
  end
  local wasSelected = FurC.GetDropdownChoice("Source") == FurC.ListSourceId(listId)
  list.name = cleaned
  changed()
  if wasSelected then
    FurC.UpdateDropdownChoice("Source")
  end
  return true
end

function FurC.DeleteList(listId)
  local s = store()
  if not s.byId[listId] then
    return
  end
  local sourceId = FurC.ListSourceId(listId)
  s.byId[listId] = nil
  for i = #s.order, 1, -1 do
    if s.order[i] == listId then
      table.remove(s.order, i)
    end
  end
  -- nothing may keep pointing at a list that is gone
  if FurC.AdditiveSources then
    FurC.AdditiveSources[sourceId] = nil
  end
  local selectionGone = FurC.GetDropdownChoice("Source") == sourceId
  changed()
  if selectionGone then
    local src = LibFurnitureCatalogue.API.GetSourceTypes()
    FurC.SetDropdownChoice("Source", FurC.DropdownData.ChoicesSource[src.NONE], src.NONE)
    FurC.UpdateDropdownChoice("Source")
  end
  FurC.UpdateGui()
end

---@param listId integer
---@param itemId integer? furnishing id, as FurC.FaveKey gives it
function FurC.IsInListById(listId, itemId)
  local list = store().byId[listId]
  return itemId ~= nil and list ~= nil and list.items[itemId] == true
end

function FurC.IsItemInList(listId, itemLink)
  return FurC.IsInListById(listId, FurC.FaveKey(itemLink))
end

---@return boolean? nowInList nil if nothing changed
function FurC.ToggleListItem(listId, itemLink)
  local list = store().byId[listId]
  local itemId = FurC.FaveKey(itemLink)
  if not list or itemId == nil then
    return
  end
  if list.items[itemId] then
    list.items[itemId] = nil
  else
    list.items[itemId] = true
  end
  FurC.UpdateGui()
  return list.items[itemId] == true
end

---@return integer count items on the list
function FurC.GetListCount(listId)
  local list = store().byId[listId]
  return list and NonContiguousCount(list.items) or 0
end

--[[ Dialogs ]]
-- The only part of this file that talks to ZO_Dialogs; kept in one place

local NAME_DIALOG = "FURC_LIST_NAME"
local nameDialogRegistered = false

local function registerNameDialog()
  if nameDialogRegistered then
    return
  end
  nameDialogRegistered = true
  ZO_Dialogs_RegisterCustomDialog(NAME_DIALOG, {
    gamepadInfo = { dialogType = GAMEPAD_DIALOGS.BASIC },
    canQueue = true,
    title = { text = SI_FURC_LIST_DIALOG_TITLE },
    mainText = { text = SI_FURC_LIST_DIALOG_BODY },
    editBox = { textType = TEXT_TYPE_ALL, maxInputChars = MAX_NAME_LENGTH },
    buttons = {
      {
        requiresTextInput = true,
        text = SI_DIALOG_ACCEPT,
        callback = function(dialog)
          local text = ZO_Dialogs_GetEditBoxText(dialog)
          local ok, err = dialog.data.onAccept(text)
          if ok == false and err then
            FurC.Logger:Info(err)
          end
        end,
      },
      { text = SI_DIALOG_CANCEL },
    },
  })
end

---@param hint string? extra line for the prompt text ("" for none)
---@param onAccept fun(name: string): any, string? return false + error text to report a refusal
local function promptName(hint, onAccept)
  registerNameDialog()
  ZO_Dialogs_ShowDialog(NAME_DIALOG, { onAccept = onAccept }, { mainTextParams = { hint or "" } })
end

---@param itemLink string? when given, the new list starts with this item on it
function FurC.PromptNewList(itemLink)
  promptName(nil, function(name)
    local listId, err = FurC.CreateList(name)
    if not listId then
      return false, err
    end
    if itemLink then
      FurC.ToggleListItem(listId, itemLink)
    end
  end)
end

function FurC.PromptRenameList(listId)
  local list = store().byId[listId]
  if not list then
    return
  end
  promptName(zo_strformat(GetString(SI_FURC_LIST_RENAME_HINT), list.name), function(name)
    return FurC.RenameList(listId, name)
  end)
end

function FurC.ConfirmDeleteList(listId)
  local list = store().byId[listId]
  local LAM = LibAddonMenu2
  if not list or not (LAM and LAM.util) then
    return
  end
  LAM.util.ShowConfirmationDialog(
    GetString(SI_FURC_LIST_DELETE_HEADER),
    zo_strformat(GetString(SI_FURC_LIST_DELETE_BODY), list.name),
    function()
      FurC.DeleteList(listId)
    end
  )
end

--[[ Export / import ]]
-- One line per list: FURC LIST: <name>: <id>,<id>,... (the name runs to the last colon, so it may contain colons)

local LIST_PREFIX = "FURC LIST"

---@return integer[] itemIds ascending
function FurC.GetListItemIds(listId)
  local list = store().byId[listId]
  local ids = {}
  for itemId in pairs(list and list.items or {}) do
    ids[#ids + 1] = itemId
  end
  table.sort(ids)
  return ids
end

---@return integer? listId
function FurC.FindListByName(name)
  local lower = LocaleAwareToLower(zo_strtrim(tostring(name or "")))
  for _, list in ipairs(FurC.GetLists()) do
    if LocaleAwareToLower(list.name) == lower then
      return list.id
    end
  end
end

---@param listId integer
---@return string? line nil if the list does not exist
function FurC.GetListExportLine(listId)
  local list = store().byId[listId]
  if not list then
    return
  end
  local name = list.name:gsub("[\r\n]", " ")
  return string.format("%s: %s: %s", LIST_PREFIX, name, table.concat(FurC.GetListItemIds(listId), ","))
end

---@param payload string everything after the prefix
---@param version integer format version of the line, 1 when it carries none
local function importListLine(payload, version)
  if version ~= 1 then
    return false, GetString(SI_FURC_LIST_IMPORT_BAD)
  end
  local name, idText = payload:match("^(.*):%s*([%d,%s]*)$")
  name = name and zo_strtrim(name)
  if not name or name == "" then
    return false, GetString(SI_FURC_LIST_IMPORT_BAD)
  end
  local listId = FurC.FindListByName(name)
  if not listId then
    local err
    listId, err = FurC.CreateList(name)
    if not listId then
      return false, err
    end
  end
  local items, added = store().byId[listId].items, 0
  for idString in idText:gmatch("%d+") do
    local id = tonumber(idString)
    if id and id > 0 and not items[id] then
      items[id] = true
      added = added + 1
    end
  end
  FurC.UpdateGui()
  return true, zo_strformat(GetString(SI_FURC_LIST_IMPORTED), store().byId[listId].name, added)
end
FurC.Transfer.Register(LIST_PREFIX, { import = importListLine })

---@param listId integer? nil exports every list, one line each
function FurC.OpenListExport(listId)
  local lines = {}
  for _, list in ipairs(FurC.GetLists()) do
    if listId == nil or list.id == listId then
      lines[#lines + 1] = FurC.GetListExportLine(list.id)
    end
  end
  if #lines == 0 then
    return
  end
  FurC.Transfer.Open({
    title = GetString(SI_FURC_TRANSFER_TITLE_EXPORT),
    hint = GetString(SI_FURC_TRANSFER_HINT_EXPORT),
    text = table.concat(lines, "\n"),
    canImport = false,
  })
end

function FurC.OpenImport()
  FurC.Transfer.Open({
    title = GetString(SI_FURC_TRANSFER_TITLE_IMPORT),
    hint = GetString(SI_FURC_TRANSFER_HINT_IMPORT),
  })
end