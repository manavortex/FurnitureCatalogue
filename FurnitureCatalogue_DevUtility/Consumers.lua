-- What the released consumers see, run against whatever library is loaded
--   /furcdev consumers          both, read-only
--   /furcdev consumers fsl      FurnitureShoppingList's calls
--   /furcdev consumers libprice LibPrice's furniture price path
--
-- Each leg walks the same calls the shipped add-on makes, in the same order, so a
-- failure here is the failure a player would get. Nothing is mutated: the shopping
-- list is not written to and no price cache is filled.

if not FurCDev then
  return
end

local this = FurCDev
local probe = this.Probe
if not probe then
  return
end

local consumers = {}
this.Consumers = consumers

local SAMPLE_LIMIT = 400

local function lib()
  return LibFurnitureCatalogue
end

local function api()
  return lib() and lib().API
end

---A craftable and a plain item out of the live DB, so the probe never hardcodes an id
---@return integer? craftable has a blueprint
---@return integer? plain has none
local function samples()
  local craftable, plain
  local seen = 0
  for itemId, row in pairs(probe.Database()) do
    if type(row) == "table" then
      seen = seen + 1
      if row.blueprint then
        craftable = craftable or itemId
      else
        plain = plain or itemId
      end
      if (craftable and plain) or seen > SAMPLE_LIMIT then
        break
      end
    end
  end
  return craftable, plain
end

---An item whose top-ranked source carries a structured price
---This is the branch that matters: it is the only one where LibPrice reads the
---record's own vendor and location, and those are identifiers now. The two obvious
---samples never reach it, because crafting and the baked-string fallback go elsewhere
---@return integer? itemId
local function pricedSample()
  local a = api()
  if not a then
    return nil
  end
  local seen = 0
  for itemId, row in pairs(probe.Database()) do
    if type(row) == "table" then
      seen = seen + 1
      local ok, records = pcall(a.GetSources, itemId)
      if ok then
        for _, rec in ipairs(records) do
          if rec.cost and rec.cost[1] then
            return itemId
          end
        end
      end
      if seen > SAMPLE_LIMIT then
        return nil
      end
    end
  end
end

local function link(itemId)
  local a = api()
  return itemId and a and a.GetItemLink(itemId) or nil
end

local function countPairs(t)
  local n = 0
  for _ in pairs(t or {}) do
    n = n + 1
  end
  return n
end

-- ---------------------------------------------------------------------------
-- FurnitureShoppingList
-- ---------------------------------------------------------------------------

-- FSL waits for IsReady (or queues itself with OnReady), then for an item or its blueprint calls GetEntry and
-- GetIngredients(entry.id, entry). It stores entry.id - the furnishing, so a blueprint lands as what it makes - and
-- refuses an item whose ingredient map is empty. OnReady is only checked for, not called: it would queue a callback.
local function fslLeg(lines)
  lines[#lines + 1] = "-- FurnitureShoppingList"
  local a = api()
  if not (a and a.IsReady and a.OnReady and a.GetEntry and a.GetIngredients) then
    lines[#lines + 1] = "  the API endpoints FSL calls (IsReady, OnReady, GetEntry, GetIngredients) are missing"
    return
  end
  local fsl = FurnitureShoppingList
  lines[#lines + 1] = string.format(
    "  loaded: %s  version: %s  ready: %s",
    tostring(FurnitureShoppingListAdd ~= nil),
    tostring(type(fsl) == "table" and fsl.version or "none"),
    tostring(a.IsReady())
  )

  local craftable, plain = samples()
  for _, case in ipairs({ { "craftable", craftable, true }, { "plain", plain, false } }) do
    local label, itemId, wantMats = case[1], case[2], case[3]
    if not itemId then
      lines[#lines + 1] = string.format("  %-9s no sample in the DB", label)
    else
      local itemLink = link(itemId)
      local ok, entry = pcall(a.GetEntry, itemLink)
      if not ok then
        lines[#lines + 1] = string.format("  %-9s %d GetEntry ERRORED: %s", label, itemId, tostring(entry))
      else
        local id = entry and entry.id
        local gotMats, mats = pcall(a.GetIngredients, id, entry)
        if not gotMats then
          lines[#lines + 1] = string.format("  %-9s %d GetIngredients ERRORED: %s", label, itemId, tostring(mats))
        else
          local count = countPairs(mats)
          local verdict = (count > 0) == wantMats and id == itemId and "as expected" or "UNEXPECTED"
          lines[#lines + 1] = string.format(
            "  %-9s %d  entry=%s id=%s mats=%d  %s (FSL would %s)",
            label,
            itemId,
            entry and "hit" or "nil",
            tostring(id),
            count,
            verdict,
            count > 0 and "list it" or "refuse it"
          )
        end
      end
    end
  end
end

-- ---------------------------------------------------------------------------
-- LibPrice
-- ---------------------------------------------------------------------------

-- The shipped release prices furniture through the library API: the entry, its
-- the best-ranked record, the description, then the deprecated GetSources whose cost is a list.
local function libPriceLeg(lines, explicit)
  lines[#lines + 1] = "-- LibPrice"
  local a = api()
  if not a then
    lines[#lines + 1] = "  library API missing"
    return
  end

  local missing = {}
  for _, name in ipairs({
    "SourceType",
    "GetEntry",
    "GetItemId",
    "GetItemDescription",
    "GetSources",
    "GetMiscItemPrice",
  }) do
    if a[name] == nil then
      missing[#missing + 1] = name
    end
  end
  lines[#lines + 1] = "  endpoints it calls: "
    .. (#missing == 0 and "all present" or ("MISSING " .. table.concat(missing, ", ")))
  lines[#lines + 1] = "  SourceType is a " .. type(a.SourceType) .. " (it indexes it, so a function would break it)"
  lines[#lines + 1] = "  installed: " .. tostring(LibPrice ~= nil)

  local craftable, plain = samples()
  local cases = { plain, craftable, explicit or pricedSample() }
  for _, itemId in ipairs(cases) do
    if itemId then
      local itemLink = link(itemId)
      local entry = a.GetEntry(itemLink)
      local ok, records = pcall(a.GetSources, itemLink)
      if not ok then
        lines[#lines + 1] = string.format("  %d GetSources ERRORED: %s", itemId, tostring(records))
      else
        -- the records arrive ranked, so the best source is simply the first
        local primary = records[1]
        -- the whole point of the bridge: cost is a list here and indexing [1] is
        -- safe even when the source has no price
        local cost = primary and primary.cost and primary.cost[1]
        lines[#lines + 1] = string.format(
          "  %d primary=%s records=%d found=%s cost[1]=%s",
          itemId,
          tostring(primary and primary.source.type),
          #records,
          primary and "yes" or "no",
          cost and (tostring(cost.amount) .. "/" .. tostring(cost.currency)) or "nil"
        )
        -- the raw record values, to compare against whatever note LibPrice builds
        -- from them. A shipped consumer that resolves them shows text; one that
        -- concatenates them straight shows these numbers
        if primary then
          local parts = {}
          for _, field in ipairs({ "vendor", "location", "event" }) do
            if primary.source[field] then
              parts[#parts + 1] = primary.source[field]
            end
          end
          if #parts > 0 then
            lines[#lines + 1] = "    record ids for the note: " .. table.concat(parts, " in ")
          end
        end
      end

      -- and the real thing, when it is installed
      if LibPrice and LibPrice.FurCPrice then
        local gotPrice, priced = pcall(LibPrice.FurCPrice, itemLink)
        if not gotPrice then
          lines[#lines + 1] = "    LibPrice.FurCPrice ERRORED: " .. tostring(priced)
        elseif type(priced) ~= "table" then
          lines[#lines + 1] = "    LibPrice.FurCPrice returned " .. tostring(priced)
        else
          lines[#lines + 1] = string.format(
            "    LibPrice.FurCPrice -> ct=%s type=%s notes=%s",
            tostring(priced.currency_ct),
            tostring(priced.currency_type),
            tostring(priced.notes)
          )
        end
      end
    end
  end
end

-- ---------------------------------------------------------------------------

function consumers.Run(section)
  section = (section or ""):lower()
  if next(probe.Database()) == nil and FurC and FurC.EnsureDB then
    FurC.EnsureDB(true)
  end

  local lines = {}
  if section == "" or section == "fsl" then
    fslLeg(lines)
  end
  if section == "" or section:find("^libprice") then
    -- "/furcdev consumers libprice 203600" prices one item you name
    libPriceLeg(lines, tonumber(section:match("(%d+)")))
  end
  if #lines == 0 then
    probe.Say("consumers: unknown section '" .. section .. "', try fsl or libprice")
    return
  end
  probe.Report("consumers - what the released add-ons see", lines)
end
