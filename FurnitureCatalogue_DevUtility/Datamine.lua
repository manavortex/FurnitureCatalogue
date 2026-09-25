-- Direct game discovery. No writes to the catalogue or SavedVariables
local this = FurCDev
local LFC = LibFurnitureCatalogue
local PAGE_BYTES = 24000
local pages, page = {}, 1
local running = false
local cancelled = false
local controls = {}
local status = "Choose an item ID range, then Scan."

local function refreshControls()
  if not controls.scan then
    return
  end
  controls.first:SetEditEnabled(not running)
  controls.last:SetEditEnabled(not running)
  controls.scan:SetEnabled(not running)
  controls.cancel:SetEnabled(running and not cancelled)
  controls.prev:SetEnabled(not running and page > 1 and #pages > 0)
  controls.next:SetEnabled(not running and page < #pages)
  controls.page:SetText(#pages > 0 and string.format("Page %d / %d", page, #pages) or "No output")
  controls.status:SetText(status)
end

local function report(text, summary)
  status = text
  refreshControls()
  this.SetScanSummary(summary or (running and "Datamine: scanning" or "Datamine: stopped"))
end

function this.CancelDiscovery()
  if running then
    cancelled = true
    report("Cancelling discovery...")
  end
end

local function quote(text)
  return '"'
    .. tostring(text):gsub('[%z\1-\31\\"]', function(c)
      return string.format("\\u%04x", string.byte(c))
    end)
    .. '"'
end

local function object(values)
  local keys, out = {}, {}
  for key in pairs(values) do
    keys[#keys + 1] = key
  end
  table.sort(keys)
  for _, key in ipairs(keys) do
    local value = values[key]
    out[#out + 1] = quote(key) .. ":" .. (type(value) == "number" and tostring(value) or quote(value))
  end
  return "{" .. table.concat(out, ",") .. "}"
end

function this.DiscoveryLine(id, blueprint)
  local link = FurC.Utils.GetItemLink(id)
  local dataId = GetItemLinkFurnitureDataId(link)
  local cat, sub, theme = 0, 0, 0
  if dataId and dataId ~= 0 then
    cat, sub, theme = GetFurnitureDataInfo(dataId)
  end
  local meta = {
    id = id,
    name = zo_strformat("<<1>>", GetItemLinkName(link)),
    quality = GetItemLinkFunctionalQuality(link),
    icon = GetItemLinkIcon(link),
    cat = cat,
    sub = sub,
    theme = theme,
  }
  local record = '{"id":' .. id
  if blueprint then
    record = record .. ',"blueprint":' .. blueprint
  end
  record = record .. ',"source":{"type":"rumour"},"cost":[],"availability":{"version":"NONE"}}'
  return '{"format":"furniture-discovery-v1","locale":'
    .. quote(GetCVar("Language.2"))
    .. ',"apiVersion":'
    .. GetAPIVersion()
    .. ',"record":'
    .. record
    .. ',"meta":'
    .. object(meta)
    .. "}"
end

function this.ShowDiscoveryPage(delta)
  if #pages == 0 then
    return
  end
  page = math.max(1, math.min(#pages, page + (delta or 0)))
  this.SelectTab("datamine", true)
  this.textbox:SetText(pages[page])
  if this.textbox:GetText() ~= pages[page] then
    this.textbox:SetText("")
    report("The textbox could not hold this page. Output kept; copying disabled.", "Datamine: output too large")
    return
  end
  this.control:SetHidden(false)
  this.selectAllOutput()
  refreshControls()
end

function this.ScanFurniture(first, last)
  if running then
    report("Discovery is already running. Use Cancel to stop it.")
    return
  end
  if
    not first
    or not last
    or first < 1
    or last < first
    or last - first > 1000000
    or first % 1 ~= 0
    or last % 1 ~= 0
  then
    report("Enter a valid first and last item ID (at most 1,000,001 IDs).")
    return
  end
  if not LFC.API.IsReady() then
    LFC.Internal.Build.EnsureDB()
    report("Catalogue is not ready. Wait for it to load, then Scan again.")
    return
  end
  local known, recipes, ignored = {}, {}, {}
  local ignoredSource = LFC.API.GetSourceTypes().IGNORED
  -- Only bundled rows have a version (that way we don't skip items that may have been resolved but are not part of the DB)
  for id, entry in pairs(LFC.Internal.DB) do
    if entry.version ~= nil then
      known[id] = true
      if LFC.Internal.Build.HasSource(entry.sources, ignoredSource) then
        ignored[id] = true
      end
    end
  end
  for _, ids in pairs(FurC.Recipes or {}) do
    for _, id in ipairs(ids) do
      recipes[id] = true
    end
  end
  for _, name in ipairs({ "RolisRecipes", "FaustinaRecipes", "Rolis", "Faustina" }) do
    for _, ids in pairs(FurC[name] or {}) do
      for id in pairs(ids) do
        recipes[id] = true
      end
    end
  end
  for id in pairs(FurC.RecipeSources or {}) do
    recipes[id] = true
  end
  for _, id in pairs(FurC.RumourRecipes or {}) do
    recipes[id] = true
  end

  running, cancelled = true, false
  local items, blueprints, results = {}, {}, {}
  local cursor = first
  local function batch()
    if cancelled then
      running = false
      report("Discovery cancelled. Previous output kept.")
      return
    end
    local ok, err = pcall(function()
      for id = cursor, math.min(last, cursor + 249) do
        local link = FurC.Utils.GetItemLink(id)
        if not ignored[id] and IsItemLinkFurnitureRecipe(link) then
          local result = GetItemLinkRecipeResultItemLink(link, LINK_STYLE_BRACKETS)
          if result and result ~= "" and IsItemLinkPlaceableFurniture(result) and not recipes[id] then
            local made = GetItemLinkItemId(result)
            if made and made > 0 and not ignored[made] then
              blueprints[id] = made
              results[made] = true
            end
          end
        elseif
          not ignored[id]
          and not known[id]
          and (IsItemLinkPlaceableFurniture(link) or GetItemLinkItemType(link) == ITEMTYPE_FURNISHING)
        then
          if GetItemLinkName(link) ~= "" then
            items[id] = true
          end
        end
      end
    end)
    if not ok then
      running = false
      report("Discovery failed: " .. tostring(err))
      return
    end
    cursor = cursor + 250
    if cursor <= last then
      report(string.format("Scanning IDs: %d / %d", cursor - first, last - first + 1))
      zo_callLater(batch, 10)
      return
    end
    local rows = {}
    for id in pairs(items) do
      if not results[id] then
        rows[#rows + 1] = { id = id }
      end
    end
    for blueprint, id in pairs(blueprints) do
      rows[#rows + 1] = { id = id, blueprint = blueprint }
    end
    table.sort(rows, function(a, b)
      if a.id ~= b.id then
        return a.id < b.id
      end
      return (a.blueprint or 0) < (b.blueprint or 0)
    end)
    local output, chunk, size = {}, {}, 0
    local built, failure = pcall(function()
      for _, row in ipairs(rows) do
        local line = this.DiscoveryLine(row.id, row.blueprint)
        if #line + 1 > PAGE_BYTES then
          error("a discovery exceeds the copy page limit")
        end
        if (size + #line + 1 > PAGE_BYTES or #chunk == 100) and #chunk > 0 then
          output[#output + 1] = table.concat(chunk, "\n") .. "\n"
          chunk, size = {}, 0
        end
        chunk[#chunk + 1] = line
        size = size + #line + 1
      end
      if #chunk > 0 then
        output[#output + 1] = table.concat(chunk, "\n") .. "\n"
      end
    end)
    running = false
    if not built then
      report("Export failed: " .. tostring(failure))
      return
    end
    pages, page = output, 1
    report(
      string.format("Scanned %d-%d: %d discoveries. Copy each page into the website.", first, last, #rows),
      string.format("Datamine: %d items", #rows)
    )
    if #pages > 0 then
      this.ShowDiscoveryPage()
    else
      this.textbox:SetText("")
    end
  end
  this.control:SetHidden(false)
  this.SelectTab("datamine")
  report(string.format("Scanning IDs %d-%d...", first, last))
  batch()
end

-- Uses the shared output pane
function this.BuildDiscoveryTab()
  local sibling = FurCDevControl_Achievements
  local parent = sibling and sibling:GetParent()
  if not parent or not WINDOW_MANAGER or not WINDOW_MANAGER.CreateControlFromVirtual then
    return
  end
  local panel = WINDOW_MANAGER:CreateControl("FurCDevControl_Items", parent, CT_CONTROL)
  panel:SetAnchorFill(parent)
  panel:SetHidden(true)

  local function label(suffix, text, x, y, width)
    local control = WINDOW_MANAGER:CreateControl("FurCDevControl_Items_" .. suffix, panel, CT_LABEL)
    control:SetFont("ZoFontGame")
    control:SetAnchor(TOPLEFT, panel, TOPLEFT, x, y)
    control:SetDimensions(width, 24)
    control:SetText(text)
    return control
  end
  local function input(suffix, x, value)
    local backdrop =
      WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Items_" .. suffix .. "Bg", panel, "ZO_DefaultBackdrop")
    backdrop:SetAnchor(TOPLEFT, panel, TOPLEFT, x, 26)
    backdrop:SetDimensions(132, 30)
    local box =
      WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Items_" .. suffix, backdrop, "ZO_DefaultEditForBackdrop")
    box:SetMaxInputChars(10)
    box:SetText(value)
    -- Replace the existing ID when typing
    box:SetHandler("OnFocusGained", function(control)
      control:SelectAll()
    end)
    return box
  end
  local function button(suffix, text, x, y, width, callback)
    local control =
      WINDOW_MANAGER:CreateControlFromVirtual("FurCDevControl_Items_" .. suffix, panel, "ZO_DefaultButton")
    control:SetAnchor(TOPLEFT, panel, TOPLEFT, x, y)
    control:SetDimensions(width, 28)
    control:SetText(text)
    control:SetHandler("OnClicked", callback)
    return control
  end

  label("FirstLabel", "First item ID", 0, 0, 132)
  label("LastLabel", "Last item ID", 144, 0, 132)
  controls.first = input("First", 0, "1")
  controls.last = input("Last", 144, "300000")
  controls.scan = button("Scan", "Scan", 0, 66, 132, function()
    this.ScanFurniture(tonumber(controls.first:GetText()), tonumber(controls.last:GetText()))
  end)
  controls.cancel = button("Cancel", "Cancel", 144, 66, 132, this.CancelDiscovery)
  controls.prev = button("Previous", "Previous", 0, 106, 80, function()
    this.ShowDiscoveryPage(-1)
  end)
  controls.page = label("Page", "No output", 84, 108, 108)
  controls.page:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
  controls.next = button("Next", "Next", 196, 106, 80, function()
    this.ShowDiscoveryPage(1)
  end)
  controls.status = label("Status", status, 0, 146, 276)
  controls.status:SetHeight(96)
  this.RegisterTab("datamine", "Datamine", panel, function()
    refreshControls()
    if #pages > 0 and not running then
      this.ShowDiscoveryPage()
    end
  end)
  refreshControls()
end
