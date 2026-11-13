-- Export/import window, shared by everything that wants to hand the user a string to copy (or take one pasted back).
-- A string is one or more lines. Each line is `<PREFIX>:<payload>`, PREFIX being what a feature registered with
-- FurC.Transfer.Register (e.g. FURC LIST). Import hands every line to the handler of its prefix, so one paste may
-- carry several kinds, and a new kind needs no change here.

FurC.Transfer = FurC.Transfer or {}
local T = FurC.Transfer

local handlers = {}

-- what the edit box accepts. ~7 characters per furnishing id, so this is well beyond any list
local MAX_CHARS = 20000

---@alias FurCTransferHandler { import: fun(payload: string, version: integer): boolean, string? } returns ok + a line of feedback

---@param prefix string e.g. "FURC LIST"; a line may carry a format version after it ("FURC LIST 2"), none means 1
---@param handler FurCTransferHandler
function T.Register(prefix, handler)
  handlers[zo_strtrim(prefix):upper()] = handler
end

---Hand each line of text to the handler of its prefix
---@param text string
---@return integer imported, integer skipped, string[] messages
function T.ImportText(text)
  local imported, skipped, messages = 0, 0, {}
  for rawLine in tostring(text or ""):gmatch("[^\r\n]+") do
    local line = zo_strtrim(rawLine)
    if line ~= "" then
      local prefix, payload = line:match("^(FURC[^:]*):%s*(.*)$")
      local handler, version
      if prefix then
        -- "FURC LIST 2" is kind "FURC LIST", version 2; without a number it is version 1
        prefix = zo_strtrim(prefix):gsub("%s+", " "):upper()
        local kind, number = prefix:match("^(.-) (%d+)$")
        handler = handlers[kind or prefix]
        version = tonumber(number) or 1
      end
      local ok, message = false, nil
      if handler then
        ok, message = handler.import(payload, version)
      end
      if ok then
        imported = imported + 1
      else
        skipped = skipped + 1
      end
      if message then
        messages[#messages + 1] = message
      end
    end
  end
  return imported, skipped, messages
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

local window, editBox, titleLabel, hintLabel, statusLabel, importButton, prevButton, nextButton
local pages, page = {}, 1

local function showPage(delta)
  page = math.max(1, math.min(#pages, page + delta))
  editBox:SetText(pages[page] or "")
  statusLabel:SetText(#pages > 1 and zo_strformat(GetString(SI_FURC_TRANSFER_PAGE), page, #pages) or "")
  prevButton:SetHidden(#pages < 2)
  nextButton:SetHidden(#pages < 2)
  editBox:TakeFocus()
  editBox:SelectAll()
end

local function build()
  local wm = WINDOW_MANAGER
  window = wm:CreateTopLevelWindow("FurC_TransferWindow")
  window:SetDimensions(540, 430)
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

  local function button(name, text, anchorPoint, offsetX, onClick)
    local b = wm:CreateControlFromVirtual("$(parent)" .. name, window, "ZO_DefaultButton")
    b:SetText(text)
    b:SetDimensions(140, 28)
    b:SetAnchor(anchorPoint, window, anchorPoint, offsetX, -16)
    b:SetHandler("OnClicked", onClick)
    return b
  end

  button("SelectAll", GetString(SI_FURC_TRANSFER_SELECT_ALL), BOTTOMLEFT, 16, function()
    editBox:TakeFocus()
    editBox:SelectAll()
  end)
  importButton = button("Import", GetString(SI_FURC_TRANSFER_IMPORT), BOTTOM, 0, function()
    local text = editBox:GetText()
    -- a long-ass paste may be cut-off
    local capped = ZoUTF8StringLength(text) >= editBox:GetMaxInputChars()
    if capped then
      text = text:match("^(.*)\n") or ""
    end
    local imported, skipped, messages = T.ImportText(text)
    local summary = zo_strformat(GetString(SI_FURC_TRANSFER_RESULT), imported, skipped)
    if capped then
      table.insert(messages, 1, GetString(SI_FURC_TRANSFER_CAPPED))
    end
    statusLabel:SetText(#messages > 0 and (summary .. " " .. table.concat(messages, " ")) or summary)
  end)
  prevButton = button("Prev", "<", BOTTOM, -40, function()
    showPage(-1)
  end)
  nextButton = button("Next", ">", BOTTOM, 40, function()
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

---@param opts { title: string, text?: string, hint?: string, canImport?: boolean }
function T.Open(opts)
  if not window then
    build()
  end
  titleLabel:SetText(opts.title or "")
  hintLabel:SetText(opts.hint or "")
  importButton:SetHidden(opts.canImport == false)
  SCENE_MANAGER:ShowTopLevel(window)
  window:BringWindowToTop()

  local lines = {}
  for line in tostring(opts.text or ""):gmatch("[^\r\n]+") do
    lines[#lines + 1] = line
  end
  pages = T.Paginate(lines, editBox:GetMaxInputChars())
  page = 1
  showPage(0)
end
