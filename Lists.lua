-- Custom favourite lists: named, account-wide item lists shown as children of the Favorites source.
-- A list never rolls up into Favorites (and Favorites never into a list): an item may sit on any number of lists.
--
-- Sublists: a list keeps its whole path as its name ("Guildhall > Entrance"), three levels max.
-- Every parent is a list of its own with its own items.

local LIST_ID_BASE = -1000 -- list n -> source id (-1000 - n): FurC.SourceFilters uses -1..-7, library sources are positive
local MAX_NAME_LENGTH = 32 -- bytes, for each part of a path
local MAX_DEPTH = 3
local SEP = " > "
-- the webinterface refuses these as the name of a root list, so an export has to stay clear of them in any language
local RESERVED = { favorites = true, favourites = true }

local lower = LocaleAwareToLower
local revision = 0
local regroup, regrouped

local function store()
  local settings = FurC.settings
  settings.customLists = settings.customLists or {}
  local s = settings.customLists
  s.nextId = s.nextId or 1 -- never reused, so a stale id can't point at a newer list
  s.order = s.order or {}
  s.byId = s.byId or {}
  if s ~= regrouped then
    regrouped = s
    regroup(s)
    revision = revision + 1 -- other lists than the tree was built for
  end
  return s
end

--[[ Paths ]]

---@return string name on one line, trimmed, at most MAX_NAME_LENGTH bytes without cutting a character in half
local function fitName(raw)
  local name = zo_strtrim((tostring(raw or ""):gsub("[\r\n]+", " ")))
  if #name > MAX_NAME_LENGTH then
    local cut = MAX_NAME_LENGTH
    while cut > 0 and name:byte(cut + 1) >= 0x80 and name:byte(cut + 1) < 0xC0 do
      cut = cut - 1
    end
    name = zo_strtrim(name:sub(1, cut))
  end
  return name
end

---The written form of a path: parts trimmed and cut to length, empty ones dropped, " > " between them. Levels beyond
---the third are folded into the third part's name ("A > B > C > D" is "C / D" under "A > B")
---@return string path "" when nothing is left
local function normPath(raw)
  local parts = {}
  for part in (tostring(raw or ""):gsub("[\r\n]+", " ") .. ">"):gmatch("(.-)>") do
    part = zo_strtrim(part)
    if part ~= "" then
      parts[#parts + 1] = part
    end
  end
  if #parts > MAX_DEPTH then
    parts[MAX_DEPTH] = table.concat(parts, " / ", MAX_DEPTH)
    for i = #parts, MAX_DEPTH + 1, -1 do
      parts[i] = nil
    end
  end
  local fitted = {}
  for _, part in ipairs(parts) do
    part = fitName(part)
    if part ~= "" then
      fitted[#fitted + 1] = part
    end
  end
  return table.concat(fitted, SEP)
end

---@param name string a written path
---@return string[] parts
local function partsOf(name)
  local parts = {}
  for part in (name .. SEP):gmatch("(.-)" .. SEP) do
    parts[#parts + 1] = part
  end
  return parts
end

local function isUnder(name, parentName)
  local prefix = lower(parentName) .. SEP
  return lower(name):sub(1, #prefix) == prefix
end

---@return integer? listId of the list at a written path, compared without case
local function findByPath(path)
  local s, wanted = store(), lower(path)
  for _, listId in ipairs(s.order) do
    if lower(s.byId[listId].name) == wanted then
      return listId
    end
  end
end

---@return integer? index of the list in the display order
local function indexOf(s, listId)
  for i, id in ipairs(s.order) do
    if id == listId then
      return i
    end
  end
end

local function depthAt(s, i)
  return #partsOf(s.byId[s.order[i]].name)
end

---@return integer index after the last list below the one at i
local function subtreeEnd(s, i)
  local name, j = s.byId[s.order[i]].name, i + 1
  while s.order[j] and isUnder(s.byId[s.order[j]].name, name) do
    j = j + 1
  end
  return j
end

---The list at a written path, made together with every missing parent. A new sublist goes below its parent's last
---one, a new root list to the end; a parent that exists keeps its spelling
---@param ownId? integer id the last part takes when it has to be made, instead of a new one
---@return integer listId
local function ensure(path, ownId)
  local s = store()
  local parts = partsOf(path)
  local listId, name
  for depth, part in ipairs(parts) do
    local parentId = listId
    name = name and (name .. SEP .. part) or part
    listId = findByPath(name)
    if listId then
      name = s.byId[listId].name
    else
      listId = depth == #parts and ownId or s.nextId
      s.nextId = math.max(s.nextId, listId + 1)
      s.byId[listId] = { name = name, items = {} }
      table.insert(s.order, parentId and subtreeEnd(s, indexOf(s, parentId)) or #s.order + 1, listId)
    end
  end
  return listId
end

-- Lists from before sublists (or a hand-edited file) are placed anew once per session: a name with ">" in it
-- becomes a sublist and gets its parents, two lists that end at the same path become one
function regroup(s)
  local old, byId = s.order, s.byId
  s.order, s.byId = {}, {}
  for _, listId in ipairs(old) do
    local list = byId[listId]
    if list then
      local path = normPath(list.name)
      local intoId = ensure(path ~= "" and path or "/", listId)
      local into = s.byId[intoId]
      if intoId == listId then
        -- the stored table itself stays in place, under the name it was placed at
        list.name, list.items = into.name, list.items or {}
        s.byId[listId] = list
      else
        for itemId in pairs(list.items or {}) do
          into.items[itemId] = true
        end
      end
    end
  end
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

---Bumped on every change to the set of lists, their names or their order, so SourceTabs knows to rebuild
function FurC.GetListsRevision()
  return revision
end

---@alias FurCListInfo { id: integer, sourceId: integer, name: string, leaf: string, depth: integer } name: the whole path; leaf: its last part

---@param listId integer
---@return FurCListInfo? info nil when there is no such list
function FurC.GetListInfo(listId)
  local list = store().byId[listId]
  if not list then
    return
  end
  local parts = partsOf(list.name)
  return { id = listId, sourceId = FurC.ListSourceId(listId), name = list.name, leaf = parts[#parts], depth = #parts }
end

---@return FurCListInfo[] lists in display order, a parent before its sublists
function FurC.GetLists()
  local lists = {}
  for _, listId in ipairs(store().order) do
    lists[#lists + 1] = FurC.GetListInfo(listId)
  end
  return lists
end

---Fresh tree nodes for SourceTabs, a sublist as a child of its parent
function FurC.GetListTreeNodes()
  local roots, open = {}, {}
  for _, list in ipairs(FurC.GetLists()) do
    local node = { id = list.sourceId, noRollup = true }
    local parent = open[list.depth - 1]
    if parent then
      parent.children = parent.children or {}
      parent.children[#parent.children + 1] = node
    else
      roots[#roots + 1] = node
    end
    open[list.depth] = node
  end
  return roots
end

---Keep ChoicesSource (label per source id) in step with the lists. A list's label is its whole path.
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

---@param reshow? boolean the content of a list changed as well, so the list manager shows its export anew
local function changed(reshow)
  revision = revision + 1
  if FurC.DropdownData and FurC.DropdownData.ChoicesSource then
    FurC.ApplyListChoices(FurC.DropdownData.ChoicesSource)
  end
  if FurC.RefreshSourceDropdown then
    FurC.RefreshSourceDropdown() -- also writes the selection's label again, should it have been renamed
  end
  if FurC.ListManager then
    FurC.ListManager.Refresh(reshow)
  end
end

-- A list may be called like a filter ("Rumour"): the selection goes by id, and filter names differ by language and
-- change between versions, so refusing them would turn a valid list invalid
-- The favourites stand right beside the lists, so their name stays refused, in the client's language as well
---@return boolean taken
local function rootTaken(root)
  local wanted = lower(root)
  return RESERVED[wanted] == true or wanted == lower(GetString(SI_FURC_FILTER_SRC_FAVE))
end

---A name with ">" in it makes the sublist and every missing list above it: "Guildhall > Entrance" makes two
---@param name string a name or a path
---@return integer? listId, string? errorText
function FurC.CreateList(name)
  local path = normPath(name)
  if path == "" then
    return nil, GetString(SI_FURC_LIST_ERR_EMPTY)
  end
  local root = partsOf(path)[1]
  if findByPath(path) or (not findByPath(root) and rootTaken(root)) then
    return nil, GetString(SI_FURC_LIST_ERR_TAKEN)
  end
  local listId = ensure(path)
  changed()
  return listId
end

---Changes the last part of the list's path, for everything below it as well. ">" in the name becomes "/"
---@return boolean ok, string? errorText
function FurC.RenameList(listId, name)
  local s = store()
  local list = s.byId[listId]
  if not list then
    return false
  end
  local leaf = fitName((tostring(name or ""):gsub(">", "/")))
  if leaf == "" then
    return false, GetString(SI_FURC_LIST_ERR_EMPTY)
  end
  local old = list.name
  local parts = partsOf(old)
  parts[#parts] = leaf
  local path = table.concat(parts, SEP)
  local takenBy = findByPath(path)
  if (takenBy and takenBy ~= listId) or (#parts == 1 and lower(path) ~= lower(old) and rootTaken(path)) then
    return false, GetString(SI_FURC_LIST_ERR_TAKEN)
  end
  for _, otherId in ipairs(s.order) do
    local other = s.byId[otherId]
    if isUnder(other.name, old) then
      other.name = path .. other.name:sub(#old + 1)
    end
  end
  list.name = path
  changed()
  return true
end

---@return boolean hasSublists
function FurC.ListHasSublists(listId)
  local s = store()
  local i = indexOf(s, listId)
  return i ~= nil and subtreeEnd(s, i) > i + 1
end

---A list with sublists is emptied and stays, as their parent; it goes once they are gone
function FurC.DeleteList(listId)
  local s = store()
  local list = s.byId[listId]
  if not list then
    return
  end
  if FurC.ListHasSublists(listId) then
    list.items = {}
    changed(true)
    FurC.UpdateGui()
    return
  end
  local sourceId = FurC.ListSourceId(listId)
  local i = indexOf(s, listId)
  s.byId[listId] = nil
  if i then
    table.remove(s.order, i)
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

---What moving a list, with everything below it, past the sibling before (-1) or after (+1) it comes to
---@return integer? from, integer? count, integer? to the span to take out and where it goes; nil at either end
local function moveSpan(s, listId, delta)
  local i = indexOf(s, listId)
  if not i then
    return
  end
  local depth, stop = depthAt(s, i), subtreeEnd(s, i)
  if delta < 0 then
    local j = i - 1
    while j >= 1 and depthAt(s, j) > depth do
      j = j - 1
    end
    if j >= 1 and depthAt(s, j) == depth then
      return i, stop - i, j
    end
  elseif s.order[stop] and depthAt(s, stop) == depth then
    return stop, subtreeEnd(s, stop) - stop, i
  end
end

---@param delta integer -1 up, +1 down
---@return boolean canMove
function FurC.CanMoveList(listId, delta)
  return moveSpan(store(), listId, delta) ~= nil
end

---Move a list among its siblings and its sublists along with it
---@param delta integer -1 up, +1 down
---@return boolean moved
function FurC.MoveList(listId, delta)
  local s = store()
  local from, count, to = moveSpan(s, listId, delta)
  if not from then
    return false
  end
  local span = {}
  for _ = 1, count do
    span[#span + 1] = table.remove(s.order, from)
  end
  for k = #span, 1, -1 do
    table.insert(s.order, to, span[k])
  end
  changed()
  return true
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
    -- room for a whole path; each part is cut to its length afterwards
    editBox = { textType = TEXT_TYPE_ALL, maxInputChars = MAX_DEPTH * (MAX_NAME_LENGTH + #SEP) },
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
---@param parentId integer? when given, the new list is a sublist of this one
function FurC.PromptNewList(itemLink, parentId)
  local parent = parentId and store().byId[parentId]
  local hint = parent and zo_strformat(GetString(SI_FURC_LIST_SUB_HINT), parent.name)
  promptName(hint, function(name)
    local listId, err = FurC.CreateList(parent and (parent.name .. SEP .. name) or name)
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
    zo_strformat(
      GetString(FurC.ListHasSublists(listId) and SI_FURC_LIST_EMPTY_BODY or SI_FURC_LIST_DELETE_BODY),
      list.name
    ),
    function()
      FurC.DeleteList(listId)
    end
  )
end

-- Export / import
-- FURC LIST <path>: <id>,<id>,... (the path runs to the last colon, so a name may contain colons)
-- FURC LIST Guildhall > Entrance: 321
-- FURC FAVES: <id>,<id>,...
-- Every line stands alone and carries its full path; the order of the lines is the order of the lists.
-- Both wrap at FurC.Transfer.IdLines' ids per line. A line whose path exists merges into that list.
-- A line of ids alone goes into the list selected in the list manager.

local LIST_PREFIX = "FURC LIST"
local FAVES_PREFIX = "FURC FAVES"

---@param set table<integer, true>
---@return integer[] itemIds ascending
local function sortedIds(set)
  local ids = {}
  for itemId in pairs(set or {}) do
    ids[#ids + 1] = itemId
  end
  table.sort(ids)
  return ids
end

---@return integer[] itemIds ascending
function FurC.GetListItemIds(listId)
  local list = store().byId[listId]
  return sortedIds(list and list.items)
end

---@param name string a name or a path, in any spelling normPath accepts
---@return integer? listId
function FurC.FindListByName(name)
  return findByPath(normPath(name))
end

---A list as export lines
---@param name string
---@param ids integer[]
---@return string[] lines
function FurC.ListExportLines(name, ids)
  return FurC.Transfer.IdLines(LIST_PREFIX .. " " .. name:gsub("[\r\n]", " "), ids)
end

---The favourites as export lines, none when there are none
---@param ids integer[]
---@return string[] lines
function FurC.FavesExportLines(ids)
  return #ids > 0 and FurC.Transfer.IdLines(FAVES_PREFIX, ids) or {}
end

---@param items table<integer, true> a list's items or the favourites
---@return FurCTransferResult
local function importInto(items, label, idText)
  local added, duplicates, unknown = FurC.AddImportedIds(items, idText, FurC.KnownFurnishingId)
  return { label = label, added = added, duplicates = duplicates, unknown = unknown }
end

---@param payload string everything after the prefix
---@return FurCTransferResult?, string?
local function importListLine(payload)
  local name, idText = payload:match("^(.*):%s*([%d,%s]*)$")
  -- brought into its written form first, so an over-long or over-deep path merges into the list it became
  local path = name and normPath(name)
  if not path or path == "" then
    return
  end
  local listId = findByPath(path)
  if not listId then
    local err
    listId, err = FurC.CreateList(path)
    if not listId then
      return nil, err
    end
  end
  local list = store().byId[listId]
  return importInto(list.items, list.name, idText)
end
FurC.Transfer.Register(LIST_PREFIX, { import = importListLine })

---@return FurCTransferResult?
local function importFavesLine(payload)
  local idText = payload:match("^[%d,%s]*$")
  return idText and importInto(FurC.settings.favorites, GetString(SI_FURC_FILTER_SRC_FAVE), idText)
end
FurC.Transfer.Register(FAVES_PREFIX, { import = importFavesLine })

---A line of ids that names no list goes into the selected one
---@param what any the list manager's selection: a list id, "faves", or something that holds no ids
---@param idText string
---@return FurCTransferResult?, string?
function FurC.ImportBareIds(what, idText)
  if what == "faves" then
    return importInto(FurC.settings.favorites, GetString(SI_FURC_FILTER_SRC_FAVE), idText)
  end
  local list = type(what) == "number" and store().byId[what]
  if not list then
    return nil, GetString(SI_FURC_LIST_IMPORT_NO_TARGET)
  end
  return importInto(list.items, list.name, idText)
end

---Export lines of a list (its own, not those of its sublists), the favourites, or (nil) the favourites and every
---list in display order
---@param what integer|"faves"|nil
---@return string text, string title
function FurC.ListExportText(what)
  local lines, title = {}, GetString(SI_FURC_LISTS)
  local function append(more)
    for _, line in ipairs(more) do
      lines[#lines + 1] = line
    end
  end
  if what == nil or what == "faves" then
    append(FurC.FavesExportLines(sortedIds(FurC.settings.favorites)))
    title = what and GetString(SI_FURC_FILTER_SRC_FAVE) or title
  end
  for _, list in ipairs(FurC.GetLists()) do
    if what == nil or list.id == what then
      append(FurC.ListExportLines(list.name, FurC.GetListItemIds(list.id)))
      title = what and list.name or title
    end
  end
  return table.concat(lines, "\n"), title
end

---The list manager, with this entry selected
---@param what integer|"faves"|nil a list id, the favourites, or nil for "All"
function FurC.OpenListTransfer(what)
  FurC.ListManager.Open(what or "all")
end
