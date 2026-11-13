-- Export/import window, shared by everything that wants to hand the user a string to copy (or take one pasted back).
-- A string is one or more lines. Each line is `<PREFIX>:<payload>`, PREFIX being what a feature registered with
-- FurC.Transfer.Register (e.g. FURC LIST). Import hands every line to the handler of its prefix, so one paste may
-- carry several kinds, and a new kind needs no change here.

FurC.Transfer = FurC.Transfer or {}
local T = FurC.Transfer

local handlers = {}

-- 1000 ids with 6-7 digits plus commas stay under 8000 bytes a line, well inside one page (20000)
local IDS_PER_LINE = 1000

-- what the edit box accepts. ~7 characters per furnishing id, so this is well beyond any list
local MAX_CHARS = 20000

---@alias FurCTransferResult { label: string, added: integer, duplicates: integer, unknown: integer } counts only, never ids
---@alias FurCTransferHandler { import: fun(payload: string, version: integer): FurCTransferResult?, string? } nil + reason refuses the line

---@param prefix string e.g. "FURC LIST"; a line may carry a format version after it ("FURC LIST 2"), none means 1
---@param handler FurCTransferHandler
function T.Register(prefix, handler)
  handlers[zo_strtrim(prefix):upper()] = handler
end

---@param line string trimmed
---@return FurCTransferHandler? handler, string? payload, integer? version nil when no registered prefix starts the line
local function parse(line)
  local prefix, payload = line:match("^(FURC[^:]*):%s*(.*)$")
  if not prefix then
    return
  end
  -- "FURC LIST 2" is kind "FURC LIST", version 2; without a number it is version 1
  prefix = zo_strtrim(prefix):gsub("%s+", " "):upper()
  local kind, number = prefix:match("^(.-) (%d+)$")
  local handler = handlers[kind or prefix]
  return handler, handler and payload, handler and (tonumber(number) or 1)
end

---Hand each line of text to the handler of its prefix. Lines with the same label (one list in several lines) add up
---to one entry
---@param text string
---@return { entries: FurCTransferResult[], unreadable: integer, errors: string[] } report
function T.ImportText(text)
  -- The game breaks a pasted line after 9996 characters with a line break and loses nothing (measured 2026-11-13:
  -- 16722 characters arrived as 16724). So a prefix-less line of ids continues the prefixed line before it.
  local lines, last = {}, nil
  for rawLine in tostring(text or ""):gmatch("[^\r\n]+") do
    local line = zo_strtrim(rawLine)
    if line ~= "" then
      if last and not parse(line) and line:match("^[%d,%s]+$") then
        lines[last] = lines[last] .. line
      else
        lines[#lines + 1] = line
        last = parse(line) and #lines or nil
      end
    end
  end

  local report, byLabel, seenError = { entries = {}, unreadable = 0, errors = {} }, {}, {}
  for _, line in ipairs(lines) do
    local handler, payload, version = parse(line)
    local result, err
    if handler then
      result, err = handler.import(payload, version)
    end
    if result then
      local key = LocaleAwareToLower(result.label)
      local entry = byLabel[key]
      if entry then
        entry.added = entry.added + result.added
        entry.duplicates = entry.duplicates + result.duplicates
        entry.unknown = entry.unknown + result.unknown
      else
        byLabel[key] = result
        report.entries[#report.entries + 1] = result
      end
    else
      report.unreadable = report.unreadable + 1
      if err and not seenError[err] then
        seenError[err] = true
        report.errors[#report.errors + 1] = err
      end
    end
  end
  return report
end

---Furnishing ids as export lines under one header, at most IDS_PER_LINE ids each
---@param header string e.g. "FURC FAVES" or "FURC LIST: <name>"
---@param ids integer[]
---@return string[] lines at least one, so an empty set still names itself
function T.IdLines(header, ids)
  local lines = {}
  for first = 1, math.max(#ids, 1), IDS_PER_LINE do
    local last = math.min(first + IDS_PER_LINE - 1, #ids)
    lines[#lines + 1] = string.format("%s: %s", header, table.concat(ids, ",", first, last))
  end
  return lines
end

---Pack lines into pages for the edit box, splitting only between lines
---@param lines string[]
---@param maxBytes integer bytes: a page within it is within any character limit of the same size
---@return string[] pages lines joined by "\n", each at most maxBytes
function T.Paginate(lines, maxBytes)
  local pages, chunk, size = {}, {}, 0
  local function add(line)
    local separator = #chunk > 0 and 1 or 0
    if #chunk > 0 and size + separator + #line > maxBytes then
      pages[#pages + 1] = table.concat(chunk, "\n")
      chunk, size, separator = {}, 0, 0
    end
    chunk[#chunk + 1] = line
    size = size + separator + #line
  end
  for _, line in ipairs(lines) do
    -- a line over maxBytes gets a page of its own and the box will cut it
    add(line)
  end
  if #chunk > 0 then
    pages[#pages + 1] = table.concat(chunk, "\n")
  end
  return pages
end

--[[ Window ]]
-- Only part of this file that touches controls. Virtual templates used (not in the addon's own XML, so worth
-- checking against ESOUI): ZO_MultiLineEditBackdrop_Keyboard, ZO_DefaultEditMultiLineForBackdrop, ZO_DefaultButton

local window, editBox, titleLabel, hintLabel, statusLabel, prevButton, nextButton, importButton, selectAllButton
local exportTab, importTab
local pages, page = {}, 1
local getText -- the export text of what the window was opened for, read again on every switch to Export

-- one line, cut with an ellipsis so it never runs into the buttons; the whole text is its tooltip
local function setStatus(text)
  statusLabel:SetText(text)
  statusLabel.fullText = text
end

---@param report table T.ImportText's
---@return string
local function formatReport(report)
  local parts = {}
  if #report.entries > 0 then
    local entries = {}
    for i, e in ipairs(report.entries) do
      entries[i] = zo_strformat(GetString(SI_FURC_TRANSFER_ENTRY), e.label, e.added, e.duplicates, e.unknown)
    end
    parts[1] = zo_strformat(GetString(SI_FURC_TRANSFER_LISTS), #entries) .. " " .. table.concat(entries, "; ")
  end
  if report.unreadable > 0 then
    parts[#parts + 1] = zo_strformat(GetString(SI_FURC_TRANSFER_UNREADABLE), report.unreadable)
  end
  for _, err in ipairs(report.errors) do
    parts[#parts + 1] = err
  end
  return #parts > 0 and table.concat(parts, " ") or GetString(SI_FURC_TRANSFER_NOTHING)
end

local showPage

---@param export boolean true: the paged export, false: an empty box to paste into
local function showTab(export)
  exportTab:SetEnabled(not export)
  importTab:SetEnabled(export)
  importButton:SetHidden(export)
  selectAllButton:SetHidden(not export)
  hintLabel:SetText(GetString(export and SI_FURC_TRANSFER_HINT_EXPORT or SI_FURC_TRANSFER_HINT_IMPORT))
  local lines = {}
  if export then
    for line in tostring(getText() or ""):gmatch("[^\r\n]+") do
      lines[#lines + 1] = line
    end
  end
  pages = T.Paginate(lines, editBox:GetMaxInputChars())
  page = 1
  showPage(0)
end

function showPage(delta)
  page = math.max(1, math.min(#pages, page + delta))
  editBox:SetText(pages[page] or "")
  setStatus(#pages > 1 and zo_strformat(GetString(SI_FURC_TRANSFER_PAGE), page, #pages) or "")
  prevButton:SetHidden(#pages < 2)
  nextButton:SetHidden(#pages < 2)
  editBox:TakeFocus()
  editBox:SelectAll()
end

local function build()
  local wm = WINDOW_MANAGER
  window = wm:CreateTopLevelWindow("FurC_TransferWindow")
  window:SetDimensions(640, 430) -- room for Select all, <, Import, >, Close in one row
  window:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
  window:SetMovable(true)
  window:SetMouseEnabled(true)
  window:SetClampedToScreen(true)
  window:SetHidden(true)

  local bg = wm:CreateControlFromVirtual("$(parent)Bg", window, "ZO_DefaultBackdrop")
  bg:SetAnchor(TOPLEFT, window, TOPLEFT, 0, 0)
  bg:SetAnchor(BOTTOMRIGHT, window, BOTTOMRIGHT, 0, 0)

  titleLabel = wm:CreateControl("$(parent)Title", window, CT_LABEL)
  titleLabel:SetFont("$(STONE_TABLET_FONT)|26|soft-shadow-thick")
  titleLabel:SetAnchor(TOPLEFT, window, TOPLEFT, 16, 22)
  titleLabel:SetAnchor(TOPRIGHT, window, TOPRIGHT, -320, 22) -- clear of the tabs; a long list name ends in "..."
  titleLabel:SetMaxLineCount(1)
  titleLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)

  hintLabel = wm:CreateControl("$(parent)Hint", window, CT_LABEL)
  hintLabel:SetFont("ZoFontGame")
  hintLabel:SetAnchor(TOPLEFT, window, TOPLEFT, 16, 68)
  hintLabel:SetAnchor(TOPRIGHT, window, TOPRIGHT, -16, 68)

  local editBg = wm:CreateControlFromVirtual("$(parent)EditBg", window, "ZO_MultiLineEditBackdrop_Keyboard")
  editBg:SetAnchor(TOPLEFT, hintLabel, BOTTOMLEFT, 0, 12)
  editBg:SetAnchor(BOTTOMRIGHT, window, BOTTOMRIGHT, -16, -82)

  editBox = wm:CreateControlFromVirtual("$(parent)Edit", editBg, "ZO_DefaultEditMultiLineForBackdrop")
  editBox:SetAnchor(TOPLEFT, editBg, TOPLEFT, 4, 4)
  editBox:SetAnchor(BOTTOMRIGHT, editBg, BOTTOMRIGHT, -4, -4)
  editBox:SetMaxInputChars(MAX_CHARS)

  statusLabel = wm:CreateControl("$(parent)Status", window, CT_LABEL)
  statusLabel:SetFont("ZoFontGame")
  statusLabel:SetAnchor(TOPLEFT, editBg, BOTTOMLEFT, 0, 8)
  statusLabel:SetAnchor(TOPRIGHT, editBg, BOTTOMRIGHT, 0, 8)
  statusLabel:SetMaxLineCount(1)
  statusLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
  statusLabel:SetMouseEnabled(true)
  statusLabel:SetHandler("OnMouseEnter", function(control)
    if control.fullText and control.fullText ~= "" then
      InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -4, TOP)
      SetTooltipText(InformationTooltip, control.fullText)
    end
  end)
  statusLabel:SetHandler("OnMouseExit", function()
    ClearTooltip(InformationTooltip)
  end)

  local function button(name, text, anchorPoint, offsetX, onClick, offsetY)
    local b = wm:CreateControlFromVirtual("$(parent)" .. name, window, "ZO_DefaultButton")
    b:SetText(text)
    b:SetDimensions(140, 28)
    b:SetAnchor(anchorPoint, window, anchorPoint, offsetX, offsetY or -16)
    b:SetHandler("OnClicked", onClick)
    return b
  end

  -- tabs: two buttons, the one showing is disabled
  exportTab = button("ExportTab", GetString(SI_FURC_TRANSFER_TITLE_EXPORT), TOPRIGHT, -164, function()
    showTab(true)
  end, 22)
  importTab = button("ImportTab", GetString(SI_FURC_TRANSFER_TITLE_IMPORT), TOPRIGHT, -16, function()
    showTab(false)
  end, 22)

  selectAllButton = button("SelectAll", GetString(SI_FURC_TRANSFER_SELECT_ALL), BOTTOMLEFT, 16, function()
    editBox:TakeFocus()
    editBox:SelectAll()
  end)
  importButton = button("Import", GetString(SI_FURC_TRANSFER_IMPORT), BOTTOM, 0, function()
    -- an id is known only once the catalogue is built; before that every id would read as unknown
    if not LibFurnitureCatalogue.API.IsReady() then
      FurC.EnsureDB()
      setStatus(GetString(SI_FURC_CHAT_BUILDING))
      return
    end
    local text = editBox:GetText()
    -- a long-ass paste may be cut-off
    local capped = ZoUTF8StringLength(text) >= editBox:GetMaxInputChars()
    if capped then
      text = text:match("^(.*)\n") or ""
    end
    local report = T.ImportText(text)
    if capped then
      table.insert(report.errors, 1, GetString(SI_FURC_TRANSFER_CAPPED))
    end
    if #report.entries > 0 then
      -- imported: the paste goes, so pressing Import again cannot count it twice
      editBox:SetText("")
      FurC.UpdateGui()
    end
    setStatus(formatReport(report))
  end)
  prevButton = button("Prev", "<", BOTTOM, -120, function()
    showPage(-1)
  end)
  nextButton = button("Next", ">", BOTTOM, 120, function()
    showPage(1)
  end)
  prevButton:SetDimensions(60, 28)
  nextButton:SetDimensions(60, 28)
  button("Close", GetString(SI_DIALOG_CLOSE), BOTTOMRIGHT, -16, function()
    T.Close()
  end)

  SCENE_MANAGER:RegisterTopLevel(window, false)
end

function T.Close()
  if window then
    SCENE_MANAGER:HideTopLevel(window)
  end
end

---Export tab: the text to copy, paged. Import tab: a box to paste into. Opens on Export
---@param opts { title: string, getText: fun(): string }
function T.Open(opts)
  if not window then
    build()
  end
  titleLabel:SetText(opts.title or "")
  getText = opts.getText
  SCENE_MANAGER:ShowTopLevel(window)
  window:BringWindowToTop()
  showTab(true)
end
