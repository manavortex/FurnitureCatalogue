-- Export/import window, shared by everything that wants to hand the user a string to copy (or take one pasted back).
-- A string is one or more lines. Each line is `<PREFIX> <payload>`, PREFIX being what a feature registered with
-- FurC.Transfer.Register (e.g. FURC LIST). Import hands every line to the handler of its prefix, so one paste may
-- carry several kinds, and a new kind needs no change here.

FurC.Transfer = FurC.Transfer or {}
local T = FurC.Transfer

local handlers = {}

-- 1000 ids with 6-7 digits plus commas stay under 8000 bytes a line, well inside one page (20000)
local IDS_PER_LINE = 1000

-- what the edit box accepts. ~7 characters per furnishing id, so this is well beyond any list
T.MAX_CHARS = 20000

---@alias FurCTransferResult { label: string, added: integer, duplicates: integer, unknown: integer, removed: integer? } counts only, never ids
---@alias FurCTransferContext { check: boolean?, merge: boolean?, work: table, replaced: table, finish: function[] } one import: check counts without changing anything, merge never removes; the rest is the handlers' to keep
---@alias FurCTransferHandler { import: fun(payload: string, ctx: FurCTransferContext): FurCTransferResult?, string? } nil: not a line of this kind (counted as unreadable); nil + reason: refused (the reason is reported)

---@param prefix string e.g. "FURC LIST". A line carries no version, so an incompatible format takes a new prefix
---@param handler FurCTransferHandler
function T.Register(prefix, handler)
  handlers[zo_strtrim(prefix):upper()] = handler
end

---@param line string trimmed
---@param kind string a registered prefix
---@return string? rest what follows the prefix, written in any case and spacing; nil when the line starts otherwise
local function restAfter(line, kind)
  local pos = 1
  for word in kind:gmatch("%S+") do
    local at = line:find("%S", pos)
    if not at or (pos > 1 and at == pos) or line:sub(at, at + #word - 1):upper() ~= word then
      return
    end
    pos = at + #word
  end
  local rest = line:sub(pos)
  if rest == "" or rest:match("^[%s:]") then
    return rest
  end
end

-- The spellings from before the format was settled are still read: "FURC LIST: name: ids", "[FURC LIST] name: ids"
-- and a version 1 before the colon ("FURC LIST 1: name: ids"). Any other version is not ours to read.
---@param line string trimmed
---@return FurCTransferHandler? handler nil when no registered prefix starts the line
---@return string? payload what follows the prefix and version
local function parse(line)
  local inner, after = line:match("^%[%s*(.-)%s*%]%s*:?%s*(.*)$")
  if inner then
    local kind = inner:gsub("%s+", " "):upper()
    local base, number = kind:match("^(.-) (%d+)$")
    local handler = handlers[base or kind]
    if handler and (number or "1") == "1" then
      return handler, after
    end
    return
  end
  for kind, handler in pairs(handlers) do
    local rest = restAfter(line, kind)
    if rest then
      -- a number is the version only right before the colon: "FURC LIST 2 chairs: ..." is a list called "2 chairs"
      local number, versioned = rest:match("^%s+(%d+)%s*:%s*(.*)$")
      if number then
        if number == "1" then
          return handler, versioned
        end
        return
      end
      return handler, (rest:gsub("^%s*:?%s*", ""))
    end
  end
end

---Hand each line of text to the handler of its prefix. Lines with the same label (one list in several lines) add up
---to one entry
---@param text string
---@param importBare? fun(idText: string, ctx: FurCTransferContext): FurCTransferResult?, string? takes a line of ids that names no list
---@param mode? { check: boolean?, merge: boolean? } check: count only, change nothing; merge: add, never remove
---@return { entries: FurCTransferResult[], unreadable: integer, errors: string[], removed: integer } report
function T.ImportText(text, importBare, mode)
  local ctx = { check = mode and mode.check, merge = mode and mode.merge, work = {}, replaced = {}, finish = {} }
  -- The game breaks a pasted line after 9996, also in the middle of an id. That's why we split into safe chunks
  local lines, open = {}, nil
  for rawLine in (tostring(text or ""):gsub("\r\n?", "\n") .. "\n"):gmatch("(.-)\n") do
    local line = zo_strtrim(rawLine)
    local bare = line:match("^[%d,%s]*%d[%d,%s]*$") ~= nil
    if line == "" then
      open = nil
    elseif bare and open then
      open.text = open.text .. line
    else
      open = { text = line, bare = bare }
      lines[#lines + 1] = open
      if not bare and not parse(line) then
        open = nil
      end
    end
  end

  local report, byLabel, seenError = { entries = {}, unreadable = 0, errors = {}, removed = 0 }, {}, {}
  local results = {}
  for _, line in ipairs(lines) do
    local result, err
    if line.bare then
      if importBare then
        result, err = importBare(line.text, ctx)
      end
    else
      local handler, payload = parse(line.text)
      if handler then
        result, err = handler.import(payload, ctx)
      end
    end
    if result then
      results[#results + 1] = result
    elseif not err then
      report.unreadable = report.unreadable + 1
    elseif not seenError[err] then
      seenError[err] = true
      report.errors[#report.errors + 1] = err
    end
  end
  -- what a replaced set lost is only known after its last line
  for _, finish in ipairs(ctx.finish) do
    finish()
  end
  for _, result in ipairs(results) do
    local key = LocaleAwareToLower(result.label)
    local entry = byLabel[key]
    if entry then
      entry.added = entry.added + result.added
      entry.duplicates = entry.duplicates + result.duplicates
      entry.unknown = entry.unknown + result.unknown
      entry.removed = (entry.removed or 0) + (result.removed or 0)
    else
      byLabel[key] = result
      report.entries[#report.entries + 1] = result
    end
    report.removed = report.removed + (result.removed or 0)
  end
  return report
end

---Furnishing ids as export lines under one header, at most IDS_PER_LINE ids each
---@param header string e.g. "FURC FAVES" or "FURC LIST <name>"
---@param ids integer[]
---@param moreHeader string? header of every line after the first, e.g. "FURC LIST+ <name>"; default: header
---@param perLine integer? ids a line; default 1000, which the game's box takes pasted without breaking the line
---@return string[] lines at least one, so an empty set still names itself ("FURC LIST <name>:")
function T.IdLines(header, ids, moreHeader, perLine)
  perLine = perLine or IDS_PER_LINE
  local lines = {}
  for first = 1, math.max(#ids, 1), perLine do
    local last = math.min(first + perLine - 1, #ids)
    local idText = table.concat(ids, ",", first, last)
    lines[#lines + 1] = (first == 1 and header or moreHeader or header) .. ":" .. (idText ~= "" and " " .. idText or "")
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

-- Window
-- Only part of this file that touches controls.
-- One box for both directions: it shows the export, and whatever is in it when Import is pressed gets imported.
local window, editBox, titleLabel, helpButton, statusLabel, prevButton, nextButton
local importButton, addOnlyButton, closeButton
local pending -- a paste that would remove items, until Replace, Add only or Cancel is pressed: { text, capped }
local editBg, side
local SIDE_WIDTH = 220
local BOX_TOP = 62 -- below the title
local SIZE = { [false] = { 640, 430, 480, 300 }, [true] = { 640 + SIDE_WIDTH + 12, 520, 700, 400 } }
local savedFrame, onResize -- the caller's, see T.Open
local pages, page = {}, 1
local getText, onImport, importBare -- what the window was opened with; the export is read again after every import

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
      if (e.removed or 0) > 0 then
        entries[i] = entries[i] .. " " .. zo_strformat(GetString(SI_FURC_TRANSFER_REMOVED), e.removed)
      end
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

-- the bottom row asks Replace / Add only / Cancel while a paste waits for that answer
local function setPending(waiting)
  pending = waiting
  importButton:SetText(GetString(waiting and SI_FURC_TRANSFER_REPLACE or SI_FURC_TRANSFER_IMPORT))
  closeButton:SetText(GetString(waiting and SI_DIALOG_CANCEL or SI_DIALOG_CLOSE))
  addOnlyButton:SetHidden(not waiting)
  -- the page buttons would sit under the third button in a narrow window
  prevButton:SetHidden(waiting ~= nil or #pages < 2)
  nextButton:SetHidden(waiting ~= nil or #pages < 2)
end

local function showPage(delta)
  setPending(nil)
  page = math.max(1, math.min(#pages, page + delta))
  editBox:SetText(pages[page] or "")
  setStatus(#pages > 1 and zo_strformat(GetString(SI_FURC_TRANSFER_PAGE), page, #pages) or "")
  prevButton:SetHidden(#pages < 2)
  nextButton:SetHidden(#pages < 2)
  editBox:TakeFocus()
  editBox:SelectAll()
end

-- the export, paged, from its first page
local function showExport()
  local lines = {}
  for line in tostring(getText() or ""):gmatch("[^\r\n]+") do
    lines[#lines + 1] = line
  end
  pages = T.Paginate(lines, editBox:GetMaxInputChars())
  page = 1
  showPage(0)
end

---@param merge boolean? add only, remove nothing
local function runImport(text, capped, merge)
  local report = T.ImportText(text, importBare, { merge = merge })
  if capped then
    table.insert(report.errors, 1, GetString(SI_FURC_TRANSFER_CAPPED))
  end
  if #report.entries > 0 then
    -- the paste goes for the fresh export, so pressing Import again cannot count it twice
    FurC.UpdateGui()
    if onImport then
      onImport()
    end
    showExport()
  end
  setPending(nil)
  setStatus(formatReport(report))
end

local function import()
  if pending then
    return runImport(pending.text, pending.capped)
  end
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
  -- replacing a list is only asked about when it would lose items
  local removed = T.ImportText(text, importBare, { check = true }).removed
  if removed > 0 then
    setPending({ text = text, capped = capped })
    setStatus(zo_strformat(GetString(SI_FURC_TRANSFER_CONFIRM), removed))
    return
  end
  runImport(text, capped)
end

local function build()
  local wm = WINDOW_MANAGER
  window = wm:CreateTopLevelWindow("FurC_TransferWindow")
  window:SetDimensions(640, 430)
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
  titleLabel:SetAnchor(TOPRIGHT, window, TOPRIGHT, -124, 22) -- clear of the icon buttons
  titleLabel:SetMaxLineCount(1)
  titleLabel:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)

  local function saveFrame()
    if savedFrame then
      savedFrame.left, savedFrame.top = window:GetLeft(), window:GetTop()
      savedFrame.width, savedFrame.height = window:GetDimensions()
    end
  end
  window:SetResizeHandleSize(10)
  window:SetHandler("OnMoveStop", saveFrame)
  -- hide text during resize, so your CPU doesn't explode
  window:SetHandler("OnResizeStart", function()
    editBox:SetHidden(true)
  end)
  window:SetHandler("OnResizeStop", function()
    editBox:SetHidden(false)
    saveFrame() -- dragging left or top edge moves it too
    if onResize then
      onResize()
    end
  end)

  -- a column left of the box for whoever opens the window with side = true (the list manager); empty otherwise
  side = wm:CreateControl("$(parent)Side", window, CT_CONTROL)
  side:SetAnchor(TOPLEFT, window, TOPLEFT, 16, BOX_TOP)
  side:SetAnchor(BOTTOMLEFT, window, BOTTOMLEFT, 16, -56)
  side:SetWidth(SIDE_WIDTH)
  side:SetHidden(true)

  editBg = wm:CreateControlFromVirtual("$(parent)EditBg", window, "ZO_MultiLineEditBackdrop_Keyboard")

  editBox = wm:CreateControlFromVirtual("$(parent)Edit", editBg, "ZO_DefaultEditMultiLineForBackdrop")
  editBox:SetAnchor(TOPLEFT, editBg, TOPLEFT, 4, 4)
  editBox:SetAnchor(BOTTOMRIGHT, editBg, BOTTOMRIGHT, -4, -4)
  editBox:SetMaxInputChars(T.MAX_CHARS)

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

  -- icon buttons on the box's top edge, as in the FurCDev window
  local function iconButton(name, texture, tooltip, anchorTo, onClick)
    local b = wm:CreateControlFromVirtual("$(parent)" .. name, window, "ZO_ButtonBehaviorClickSound")
    b:SetDimensions(28, 28)
    b:SetNormalTexture(texture .. "_up.dds")
    b:SetPressedTexture(texture .. "_down.dds")
    b:SetMouseOverTexture(texture .. "_over.dds")
    if anchorTo then
      b:SetAnchor(RIGHT, anchorTo, LEFT, -8, 0)
    else
      b:SetAnchor(BOTTOMRIGHT, editBg, TOPRIGHT, 0, -4)
    end
    b:SetHandler("OnClicked", onClick)
    b:SetHandler("OnMouseEnter", function(control)
      InitializeTooltip(InformationTooltip, control, TOP, 0, 5, BOTTOM)
      SetTooltipText(InformationTooltip, control.tooltip)
    end)
    b:SetHandler("OnMouseExit", function()
      ClearTooltip(InformationTooltip)
    end)
    b.tooltip = tooltip
    return b
  end
  local clearButton = iconButton(
    "Clear",
    "EsoUI/Art/Dye/dyes_toolIcon_erase",
    GetString(SI_FURC_TRANSFER_CLEAR),
    nil,
    function()
      editBox:SetText("")
      editBox:TakeFocus()
    end
  )
  local selectAllButton = iconButton(
    "SelectAll",
    "EsoUI/Art/Buttons/edit",
    GetString(SI_FURC_TRANSFER_SELECT_ALL),
    clearButton,
    function()
      editBox:TakeFocus()
      editBox:SelectAll()
    end
  )
  -- Instruction tooltip on how to use the manager
  helpButton = iconButton("Help", "EsoUI/Art/MenuBar/menuBar_help", "", selectAllButton, function() end)

  local function button(name, text, anchorPoint, offsetX, onClick)
    local b = wm:CreateControlFromVirtual("$(parent)" .. name, window, "ZO_DefaultButton")
    b:SetText(text)
    b:SetDimensions(140, 28)
    b:SetAnchor(anchorPoint, window, anchorPoint, offsetX, -16)
    b:SetHandler("OnClicked", onClick)
    return b
  end

  -- bottom row with pagination
  prevButton = button("Prev", "<", BOTTOMLEFT, 16, function()
    showPage(-1)
  end)
  nextButton = button("Next", ">", BOTTOMLEFT, 84, function()
    showPage(1)
  end)
  for i, b in ipairs({ prevButton, nextButton }) do
    b:SetDimensions(60, 28)
    b:ClearAnchors()
    b:SetAnchor(TOPLEFT, editBg, BOTTOMLEFT, (i - 1) * 68, 38) -- 82 - 38 - 28 = the 16 of the other buttons
  end
  addOnlyButton = button("AddOnly", GetString(SI_FURC_TRANSFER_ADD_ONLY), BOTTOMRIGHT, -312, function()
    if pending then
      runImport(pending.text, pending.capped, true)
    end
  end)
  addOnlyButton:SetHidden(true)
  importButton = button("Import", GetString(SI_FURC_TRANSFER_IMPORT), BOTTOMRIGHT, -164, import)
  closeButton = button("Close", GetString(SI_DIALOG_CLOSE), BOTTOMRIGHT, -16, function()
    if pending then
      setPending(nil)
      setStatus("")
    else
      T.Close()
    end
  end)

  SCENE_MANAGER:RegisterTopLevel(window, false)
end

function T.Close()
  if window then
    SCENE_MANAGER:HideTopLevel(window)
  end
end

---The column left of the box, for a caller to fill; shown when T.Open is called with side = true
---@return Control
function T.SidePanel()
  if not window then
    build()
  end
  return side
end

---@return boolean
function T.IsOpen()
  return window ~= nil and not window:IsHidden()
end

---Show getText's export in the box, paged; Import reads whatever the box holds then
---@param opts { title: string, getText: fun(): string, side: boolean?, onImport: fun()?, importBare: (fun(idText: string): FurCTransferResult?, string?)?, hint: string?, frame: table?, onResize: fun()? }
---importBare: see T.ImportText
---hint: additional text for help icon's tooltip
---frame: window dimensions and position (saved vars)
function T.Open(opts)
  if not window then
    build()
  end
  side:SetHidden(not opts.side)
  local width, height, minWidth, minHeight = unpack(SIZE[opts.side == true])
  savedFrame, onResize = opts.frame, opts.onResize
  local frame = savedFrame or {}
  window:SetDimensionConstraints(minWidth, minHeight)
  window:SetDimensions(math.max(minWidth, frame.width or width), math.max(minHeight, frame.height or height))
  if frame.left and frame.top then
    window:ClearAnchors()
    window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, frame.left, frame.top)
  end
  editBg:ClearAnchors()
  if opts.side then
    editBg:SetAnchor(TOPLEFT, side, TOPRIGHT, 12, 0)
  else
    editBg:SetAnchor(TOPLEFT, window, TOPLEFT, 16, BOX_TOP)
  end
  editBg:SetAnchor(BOTTOMRIGHT, window, BOTTOMRIGHT, -16, -82)
  titleLabel:SetText(opts.title or "")
  helpButton.tooltip = GetString(SI_FURC_TRANSFER_HINT) .. (opts.hint and "\n" .. opts.hint or "")
  getText, onImport, importBare = opts.getText, opts.onImport, opts.importBare
  SCENE_MANAGER:ShowTopLevel(window)
  window:BringWindowToTop()
  showExport()
end
