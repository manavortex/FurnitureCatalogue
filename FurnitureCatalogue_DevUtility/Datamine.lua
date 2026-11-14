-- Direct game discovery. No writes to the catalogue or SavedVariables
local this = FurCDev
local LFC = LibFurnitureCatalogue
local PAGE_BYTES = 24000
local pages, page = {}, 1
local running = false
local cancelled = false
local controls = {}
local status =
  "Choose an item ID range, then Scan. For a request from the website, paste its ids into the text box, then Item list."

local function refreshControls()
  if not controls.scan then
    return
  end
  controls.first:SetEditEnabled(not running)
  controls.last:SetEditEnabled(not running)
  controls.scan:SetEnabled(not running)
  controls.request:SetEnabled(not running)
  controls.cancel:SetEnabled(running and not cancelled)
  controls.prev:SetEnabled(not running and page > 1 and #pages > 0)
  controls.next:SetEnabled(not running and page < #pages)
  controls.page:SetText(#pages > 0 and string.format("Page %d / %d", page, #pages) or "No output")
  controls.status:SetText(status)
end

local function report(text, summary)
  status = text
  refreshControls()
  -- progress stays where it is; a result or refusal brings the window up
  if not running then
    this.ShowWindow()
  end
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

local function isFurnishing(link)
  return IsItemLinkPlaceableFurniture(link)
end

---A blueprint stands for the furnishing it makes
---@param id integer? any item id
---@return integer? furnishingId nil for no id, or a blueprint that makes nothing
---@return integer? blueprintId
local function furnishingOf(id)
  if not id or id <= 0 then
    return
  end
  local link = FurC.Utils.GetItemLink(id)
  if IsItemLinkFurnitureRecipe(link) then
    local made = GetItemLinkItemId(GetItemLinkRecipeResultItemLink(link, LINK_STYLE_BRACKETS))
    if not made or made == 0 then
      return
    end
    return made, id
  end
  return id
end

---@param id integer furnishing id
---@param blueprint integer?
---@param offer { currency: string, amount: integer, achievement: integer? }? what a store asks for it
---@return string? line nil when the id is not a furnishing on this client
function this.DiscoveryLine(id, blueprint, offer)
  local link = FurC.Utils.GetItemLink(id)
  if not isFurnishing(link) then
    return nil
  end
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
    .. (offer and (',"offer":' .. object(offer)) or "")
    .. "}"
end

---Append lines to the output box, skipping any it already holds
---@param lines string[]
---@return integer added
local function appendLines(lines)
  local text, added = this.textbox:GetText() or "", 0
  for _, line in ipairs(lines) do
    if not text:find(line, 1, true) then
      if text ~= "" and text:sub(-1) ~= "\n" then
        text = text .. "\n"
      end
      text = text .. line .. "\n"
      added = added + 1
    end
  end
  if added > 0 then
    this.textbox:SetText(text)
  end
  this.ShowWindow()
  return added
end

local currencyKeys
---The library's currency vocabulary key for a game currency. EVENT_TICKETS is left out: the library maps it to the
---same game currency as TRADE_BARS, so a store price in that currency reads as TRADE_BARS
---@param currencyType integer CURT_*
---@return string? key
local function currencyKey(currencyType)
  if not currencyKeys then
    currencyKeys = {}
    local function add(curt, key)
      if curt then
        currencyKeys[curt] = key
      end
    end
    add(CURT_MONEY, "GOLD")
    add(CURT_ALLIANCE_POINTS, "AP")
    add(CURT_TELVAR_STONES, "TEL_VAR")
    add(CURT_WRIT_VOUCHERS, "WRIT_VOUCHERS")
    add(CURT_CROWNS, "CROWNS")
    add(CURT_CROWN_GEMS, "CROWN_GEMS")
    add(CURT_ENDEAVOR_SEALS, "SEALS")
    add(CURT_UNDAUNTED_KEYS, "UNDAUNTED_KEYS")
    add(CURT_ARCHIVAL_FORTUNES, "ARCHIVAL_FORTUNES")
    add(CURT_TRADE_BARS, "TRADE_BARS")
  end
  return currencyKeys[currencyType]
end

---Achievement name in a store's "requires" text: EN "Requires <name> [Achievement] to purchase.", DE „<name>“
---@param text string?
---@return string? name
function this.GateAchievementName(text)
  text = tostring(text or "")
  return text:match("„(.-)“")
    or text:match("^Requires (.-) Achievement to purchase")
    or text:match("^Requires (.-) to purchase")
end

---What a store entry asks for, in the offer shape of a trader line
---@param price integer gold price, 0 when the entry costs another currency
---@param currencyType integer? CURT_* of the other currency
---@param quantity integer? amount of it
---@param achievement integer? id of the achievement that gates the entry, 0 or nil for none
---@return table? offer nil when the entry costs nothing or its currency has no vocabulary key
---@return string? reason "currency" when the currency has no key
function this.Offer(price, currencyType, quantity, achievement)
  local offer
  if price and price > 0 then
    offer = { currency = "GOLD", amount = price }
  elseif quantity and quantity > 0 then
    local key = currencyKey(currencyType)
    if not key then
      return nil, "currency"
    end
    offer = { currency = key, amount = quantity }
  else
    return nil
  end
  if achievement and achievement > 0 then
    offer.achievement = achievement
  end
  return offer
end

---@param index integer store entry
local function storeOffer(index)
  local _, _, _, price, _, canBuy, _, _, _, currencyType, quantity, _, _, _, _, errorStringId = GetStoreEntryInfo(index)
  local achievement
  -- the store names its gate only to a character who has not met it
  if not canBuy and errorStringId and errorStringId ~= 0 then
    achievement = this.GetAchievementId(this.GateAchievementName(GetErrorString(errorStringId)))
  end
  return this.Offer(price, currencyType, quantity, achievement)
end

---Discovery lines with an offer for every furnishing the open store sells, catalogued or not
function this.AddAllFromTrader()
  local count = GetNumStoreItems()
  if IsStoreEmpty() or count == 0 then
    FurC.Logger:Info("|cFF3333FurCDev|r: no store open, or trader has no items.")
    return
  end
  local lines, noKey = {}, 0
  for index = 1, count do
    local id, blueprint = furnishingOf(GetItemLinkItemId(GetStoreItemLink(index)))
    if id then
      local offer, reason = storeOffer(index)
      local line = this.DiscoveryLine(id, blueprint, offer)
      if line then
        lines[#lines + 1] = line
        noKey = noKey + (reason == "currency" and 1 or 0)
      end
    end
  end
  local added = appendLines(lines)
  FurC.Logger:Info(
    "|cFF3333FurCDev|r: %d furnishing(s) of %d store item(s), %d new; %d without offer (currency has no key).",
    #lines,
    count,
    added,
    noKey
  )
end

---The bags the keyboard inventory shows now, read from the scene fragments the ESOUI inventory shows them with.
---At a bank the deposit side is the backpack; the gamepad UI uses other fragments and always reads as the backpack
---@return integer[] bagIds
---@return string name
local function shownBags()
  local function showing(fragment)
    return fragment ~= nil and fragment:IsShowing()
  end
  if showing(GUILD_BANK_FRAGMENT) then
    return { BAG_GUILDBANK }, "guild bank"
  elseif showing(HOUSE_BANK_FRAGMENT) then
    return { GetBankingBag() }, "house storage"
  elseif showing(FURNITURE_VAULT_FRAGMENT) then
    return { BAG_FURNITURE_VAULT }, "furniture vault"
  elseif showing(BANK_FRAGMENT) then
    return { BAG_BANK, BAG_SUBSCRIBER_BANK }, "bank"
  end
  return { BAG_BACKPACK }, "backpack"
end

---Discovery lines, without an offer, for every furnishing in the bag the player looks at
function this.AddAllFromBag()
  local bags, name = shownBags()
  local lines = {}
  for _, bagId in ipairs(bags) do
    -- guild bank and furniture vault slot ids have gaps, so walk them the way ESOUI does
    for slot in ZO_IterateBagSlots(bagId) do
      local id, blueprint = furnishingOf(GetItemLinkItemId(GetItemLink(bagId, slot)))
      local line = id and this.DiscoveryLine(id, blueprint)
      if line then
        lines[#lines + 1] = line
      end
    end
  end
  local added = appendLines(lines)
  FurC.Logger:Info("|cFF3333FurCDev|r: %d furnishing(s) in the %s, %d new.", #lines, name, added)
end

---One item's line appended to the output box, whether the catalogue knows it or not: the menu asks about this item, where a scan looks for new ones
---@param id integer furnishing or blueprint id
---@return boolean added
function this.AppendDiscovery(id)
  local furnishing, blueprint = furnishingOf(id)
  local line = furnishing and this.DiscoveryLine(furnishing, blueprint)
  return line ~= nil and appendLines({ line }) > 0
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
  this.ShowWindow()
  this.selectAllOutput()
  refreshControls()
end

-- Pages small enough for the textbox to hold and the clipboard to copy
local function paginate(lines)
  local output, chunk, size = {}, {}, 0
  for _, line in ipairs(lines) do
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
  return output
end

local function showPages(output)
  pages, page = output, 1
  if #pages > 0 then
    this.ShowDiscoveryPage()
  else
    this.textbox:SetText("")
  end
end

---A request from the website: discovery lines for exactly the listed ids, catalogued or not, so the website can refresh their names and metadata
---@param text string item ids separated by anything that is not a digit
function this.RequestItems(text)
  if running then
    report("Discovery is running. Wait for it or Cancel it first.")
    return
  end
  -- every number in the box counts as an id, so stray numbers from a dump would turn into ids
  if tostring(text or ""):find('[{}"]') then
    report("The text box holds discovery output, not item ids. Clear it, paste the requested ids, then Item list.")
    return
  end
  local seen, lines, unknown = {}, {}, 0
  local built, failure = pcall(function()
    for number in tostring(text or ""):gmatch("%d+") do
      local requested = tonumber(number)
      if requested > 0 and not seen[requested] then
        seen[requested] = true
        local id, blueprint = furnishingOf(requested)
        local line = id and GetItemLinkName(FurC.Utils.GetItemLink(id)) ~= "" and this.DiscoveryLine(id, blueprint)
        if line then
          lines[#lines + 1] = line
        else
          unknown = unknown + 1
        end
      end
    end
  end)
  if not built then
    report("Item list failed: " .. tostring(failure))
    return
  end
  local paged, output = pcall(paginate, lines)
  if not paged then
    report("Export failed: " .. tostring(output))
    return
  end
  if #lines == 0 and unknown == 0 then
    report("Paste the requested item ids into the text box first, then Item list.")
    return
  end
  report(
    string.format("Item list: %d new discoveries. Copy each page into the website.", #lines, unknown),
    string.format("Datamine: %d requested items", #lines)
  )
  showPages(output)
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
  for _, id in ipairs(LFC.API.GetItemIds()) do
    local entry = LFC.API.GetEntry(id)
    if entry and entry.version ~= nil then
      known[id] = true
      ignored[id] = entry.sources[ignoredSource] or nil
      if entry.blueprint then
        recipes[entry.blueprint] = true
      end
    end
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
          if result and result ~= "" and IsItemLinkPlaceableFurniture(result) then
            local made = GetItemLinkItemId(result)
            if made and made > 0 then
              if recipes[id] or known[id] then
                -- A catalogued blueprint also covers the furnishing it makes (a rumour kept under its blueprint has no entry for that furnishing)
                results[made] = true
              elseif not ignored[made] then
                blueprints[id] = made
                results[made] = true
              end
            end
          end
        elseif not ignored[id] and not known[id] and isFurnishing(link) then
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
    local output
    local built, failure = pcall(function()
      local lines = {}
      for _, row in ipairs(rows) do
        lines[#lines + 1] = this.DiscoveryLine(row.id, row.blueprint) -- skips non-furnishings
      end
      output = paginate(lines)
    end)
    running = false
    if not built then
      report("Export failed: " .. tostring(failure))
      return
    end
    report(
      string.format("Scanned %d-%d: %d discoveries. Copy each page into the website.", first, last, #rows),
      string.format("Datamine: %d items", #rows)
    )
    showPages(output)
  end
  this.ShowWindow()
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
  controls.request = button("Request", "Item list", 0, 146, 276, function()
    this.RequestItems(this.textbox:GetText())
  end)
  controls.status = label("Status", status, 0, 186, 276)
  controls.status:SetHeight(96)
  this.RegisterTab("datamine", "Datamine", panel, function()
    refreshControls()
    if #pages > 0 and not running then
      this.ShowDiscoveryPage()
    end
  end)
  refreshControls()
end
