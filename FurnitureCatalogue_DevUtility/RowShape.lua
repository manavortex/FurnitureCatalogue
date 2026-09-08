-- What a database row costs, and what it would cost in a different shape
--   /furcdev row          every section, in order
--   /furcdev row calib    bytes per table, per hash slot, on this client
--   /furcdev row census   key counts and subtables of the live DB
--   /furcdev row shapes   the live DB rebuilt in each candidate shape, measured
--   /furcdev row read     what deriving the dropped fields costs per pass
--   /furcdev row api      structures assembled through the API, not from the row
--
-- FurCDev.RowShape.Register adds a structure of your own, from Custom.lua.

if not FurCDev then
  return
end

local this = FurCDev
local probe = this.Probe
if not probe then
  return
end

local rowShape = {}
this.RowShape = rowShape

local CALIBRATION_TABLES = 10000
local CALIBRATION_MAX_KEYS = 17
local CALIBRATION_HOLDER_RUNS = 5
local READ_RUNS = 3

local function lib()
  return LibFurnitureCatalogue
end

local function itemLinkFor(itemId)
  local api = lib() and lib().API
  return api and api.GetItemLink(itemId)
end

-- The three sections that walk the DB are useless against an empty one, and a
-- probe run should not depend on the window having been opened first.
local function database()
  local db = probe.Database()
  if next(db) == nil and FurC and FurC.EnsureDB then
    FurC.EnsureDB(true)
    db = probe.Database()
  end
  return db
end

local function sourcePriority()
  local internal = lib() and lib().Internal
  return (internal and internal.Constants and internal.Constants.SOURCE_PRIORITY) or {}
end

-- ---------------------------------------------------------------------------
-- Calibration
-- ---------------------------------------------------------------------------

local calibrationKeys = {}
for i = 1, CALIBRATION_MAX_KEYS do
  calibrationKeys[i] = "key" .. i
end

--- Bytes a table of n keys costs on this client, measured rather than assumed
local function calibrate()
  -- The array holding the batch costs one slot per entry, in every reading. On a
  -- live client other add-ons allocate and free between the two readings, so this
  -- baseline is noisy and is taken as a median; the spread says how far to trust
  -- the absolute column. The delta column is unaffected by a constant offset.
  local samples = {}
  for run = 1, CALIBRATION_HOLDER_RUNS do
    samples[run] = probe.Measure(function()
      local held = {}
      for i = 1, CALIBRATION_TABLES do
        held[i] = i
      end
      return held
    end).retainedKB
  end
  table.sort(samples)
  local holderKB = samples[math.ceil(CALIBRATION_HOLDER_RUNS / 2)]
  local spread = samples[CALIBRATION_HOLDER_RUNS] - samples[1]

  local lines = {
    string.format(
      "table cost, %d tables per row, holder %s deducted (noise %.1f KB, %.1f bytes/table)",
      CALIBRATION_TABLES,
      probe.FormatKB(holderKB),
      spread,
      spread * 1024 / CALIBRATION_TABLES
    ),
    "keys slots   bytes/table   delta",
  }
  local previous
  for keyCount = 0, CALIBRATION_MAX_KEYS do
    local result = probe.Measure(function()
      local held = {}
      for i = 1, CALIBRATION_TABLES do
        local t = {}
        for k = 1, keyCount do
          t[calibrationKeys[k]] = k
        end
        held[i] = t
      end
      return held
    end)
    local bytes = (result.retainedKB - holderKB) * 1024 / CALIBRATION_TABLES
    lines[#lines + 1] = string.format(
      "%4d %5d %13.1f %7s",
      keyCount,
      probe.SlotsFor(keyCount),
      bytes,
      previous and string.format("%+.1f", bytes - previous) or "-"
    )
    previous = bytes
  end
  probe.Report("row calib - table cost on this client", lines)
end
rowShape.Calibrate = calibrate

-- ---------------------------------------------------------------------------
-- Census of the live DB
-- ---------------------------------------------------------------------------

local CENSUS_FIELDS = {
  "id",
  "sources",
  "compatSources",
  "origin",
  "version",
  "blueprint",
  "craftingSkill",
  "furnCategory",
  "furnSubcategory",
  "recipeListIndex",
  "recipeIndex",
}

local function countKeys(t)
  local n = 0
  if t then
    for _ in pairs(t) do
      n = n + 1
    end
  end
  return n
end

local function census()
  local db = database()
  local rows = 0
  local keyHistogram, sourcesHistogram = {}, {}
  local present, other = {}, {}
  local compatPresent, compatEmpty = 0, 0

  for _, row in pairs(db) do
    rows = rows + 1
    local keys = 0
    for field in pairs(row) do
      keys = keys + 1
      present[field] = (present[field] or 0) + 1
    end
    keyHistogram[keys] = (keyHistogram[keys] or 0) + 1

    local sources = countKeys(row.sources)
    sourcesHistogram[sources] = (sourcesHistogram[sources] or 0) + 1

    -- the marker is a bitmask now, and was a subtable before it: count either, so a
    -- census of an older build still reads
    if row.compatSources then
      compatPresent = compatPresent + 1
      local empty = (type(row.compatSources) == "number" and row.compatSources == 0)
        or (type(row.compatSources) == "table" and countKeys(row.compatSources) == 0)
      if empty then
        compatEmpty = compatEmpty + 1
      end
    end
  end

  for field in pairs(present) do
    local known = false
    for _, name in ipairs(CENSUS_FIELDS) do
      known = known or name == field
    end
    if not known then
      other[#other + 1] = field
    end
  end
  table.sort(other)

  local lines = { string.format("census: %d rows", rows) }

  local keyLine = {}
  for keys = 0, 24 do
    local count = keyHistogram[keys]
    if count then
      keyLine[#keyLine + 1] = string.format("%d keys/%d slots: %d", keys, probe.SlotsFor(keys), count)
    end
  end
  lines[#lines + 1] = "rows by key count: " .. table.concat(keyLine, ", ")

  for _, field in ipairs(CENSUS_FIELDS) do
    local count = present[field]
    if count then
      lines[#lines + 1] = string.format("%-16s on %5d rows (%.0f%%)", field, count, count * 100 / rows)
    end
  end
  if #other > 0 then
    lines[#lines + 1] = "unlisted fields: " .. table.concat(other, ", ")
  end

  local sourcesLine = {}
  for count = 0, 12 do
    local rowsWith = sourcesHistogram[count]
    if rowsWith then
      sourcesLine[#sourcesLine + 1] = string.format("%d: %d", count, rowsWith)
    end
  end
  lines[#lines + 1] = "sources per row: " .. table.concat(sourcesLine, ", ")
  lines[#lines + 1] = string.format("compatSources present: %d, of which empty: %d", compatPresent, compatEmpty)

  probe.Report("row census - the live DB as stored", lines)
  return rows
end
rowShape.Census = census

-- ---------------------------------------------------------------------------
-- Candidate shapes
-- ---------------------------------------------------------------------------

-- A table constructor sizes the hash part from the field count, counting a field
-- whose value is nil. Build.lua assigns key by key, so the shapes must too, or a
-- row with an absent blueprint measures a slot band too high.
local function assemble(...)
  local out = {}
  for _, field in ipairs({ ... }) do
    if field[2] ~= nil then
      out[field[1]] = field[2]
    end
  end
  return out
end

local function copySet(set)
  if not set then
    return nil
  end
  local out = {}
  for key, value in pairs(set) do
    out[key] = value
  end
  return out
end

-- exact for source ids up to 53, so no bit library and no sign boundary at 31
---Bitmask of a source set. Passes a mask straight through, so a shape that models
---the marker as an integer reads the same whether the live row already stores one
---@param sources table<integer, boolean>|integer|nil
---@return integer mask
local function maskOf(sources)
  if type(sources) == "number" then
    return sources
  end
  local mask = 0
  if sources then
    for source in pairs(sources) do
      mask = mask + 2 ^ (source - 1)
    end
  end
  return mask
end

local function copyAll(row, extraId)
  local out = {}
  for field, value in pairs(row) do
    if field == "sources" or (field == "compatSources" and type(value) == "table") then
      out[field] = copySet(value)
    else
      out[field] = value
    end
  end
  if extraId then
    out.id = extraId
  end
  return out
end

local function copyWithout(row, dropped, extraId)
  local out = {}
  for field, value in pairs(row) do
    if not dropped[field] then
      if field == "sources" then
        out[field] = copySet(value)
      else
        out[field] = value
      end
    end
  end
  if extraId then
    out.id = extraId
  end
  return out
end

-- One metatable for every row, so a derived field costs the shared table and not a
-- slot per row. Released consumers index origin off the raw row through FurC.Find,
-- so it has to answer there and not only on a GetEntry copy.
local ROW_META = {
  __index = function(row, key)
    if key == "origin" then
      local best, bestRank
      local priority = sourcePriority()
      for source in pairs(row.sources or {}) do
        local rank = priority[source] or math.huge
        if not bestRank or rank < bestRank or (rank == bestRank and source < best) then
          best, bestRank = source, rank
        end
      end
      return best
    end
    return nil
  end,
}

local DROP_COMPAT = { compatSources = true }
local DROP_COMPAT_CAT = { compatSources = true, furnCategory = true, furnSubcategory = true }
local DROP_DERIVED = {
  compatSources = true,
  furnCategory = true,
  furnSubcategory = true,
  craftingSkill = true,
}

local SHAPES = {
  {
    key = "current",
    note = "as stored today",
    build = function(_, row)
      return copyAll(row)
    end,
  },
  {
    key = "current+id",
    note = "today plus id",
    build = function(itemId, row)
      return copyAll(row, itemId)
    end,
  },
  {
    key = "-compat",
    note = "drop compatSources",
    build = function(_, row)
      return copyWithout(row, DROP_COMPAT)
    end,
  },
  {
    key = "-compat-cat",
    note = "also drop furnCategory, furnSubcategory",
    build = function(_, row)
      return copyWithout(row, DROP_COMPAT_CAT)
    end,
  },
  {
    key = "-derived",
    note = "also drop craftingSkill",
    build = function(_, row)
      return copyWithout(row, DROP_DERIVED)
    end,
  },
  {
    key = "lean3",
    note = "sources, version, blueprint",
    build = function(_, row)
      return assemble({ "sources", copySet(row.sources) }, { "version", row.version }, { "blueprint", row.blueprint })
    end,
  },
  {
    key = "lean4",
    note = "lean3 plus id",
    build = function(itemId, row)
      return assemble(
        { "id", itemId },
        { "sources", copySet(row.sources) },
        { "version", row.version },
        { "blueprint", row.blueprint }
      )
    end,
  },
  {
    key = "compat-int",
    note = "today, compatSources as an integer instead of a table",
    build = function(_, row)
      local out = copyWithout(row, DROP_COMPAT)
      out.compatSources = maskOf(row.compatSources)
      return out
    end,
  },
  {
    key = "ci-cat-out",
    note = "compat-int, minus furnCategory and furnSubcategory",
    build = function(_, row)
      local out = copyWithout(row, DROP_COMPAT_CAT)
      out.compatSources = maskOf(row.compatSources)
      return out
    end,
  },
  {
    key = "ci-lean",
    note = "compat-int, minus category and origin, no id",
    build = function(_, row)
      return assemble(
        { "sources", copySet(row.sources) },
        { "version", row.version },
        { "blueprint", row.blueprint },
        { "compatSources", maskOf(row.compatSources) }
      )
    end,
  },
  {
    key = "ci-sparse",
    note = "ci-lean, but the mask is absent when nothing was injected",
    build = function(_, row)
      local mask = maskOf(row.compatSources)
      return assemble(
        { "sources", copySet(row.sources) },
        { "version", row.version },
        { "blueprint", row.blueprint },
        { "compatSources", mask ~= 0 and mask or nil }
      )
    end,
  },
  {
    key = "ci-sparse+id",
    note = "ci-sparse plus id, which is what id costs once the row is lean",
    build = function(itemId, row)
      local mask = maskOf(row.compatSources)
      return assemble(
        { "id", itemId },
        { "sources", copySet(row.sources) },
        { "version", row.version },
        { "blueprint", row.blueprint },
        { "compatSources", mask ~= 0 and mask or nil }
      )
    end,
  },
  {
    key = "ci-sparse+meta",
    note = "ci-sparse, origin served by one shared metatable instead of stored",
    build = function(_, row)
      local mask = maskOf(row.compatSources)
      return setmetatable(
        assemble(
          { "sources", copySet(row.sources) },
          { "version", row.version },
          { "blueprint", row.blueprint },
          { "compatSources", mask ~= 0 and mask or nil }
        ),
        ROW_META
      )
    end,
  },
  {
    key = "mask4",
    note = "lean4, sources as a bitmask, no subtable",
    build = function(itemId, row)
      return assemble(
        { "id", itemId },
        { "sources", maskOf(row.sources) },
        { "version", row.version },
        { "blueprint", row.blueprint }
      )
    end,
  },
}

local function shapes()
  local db = database()
  local rows = 0
  for _ in pairs(db) do
    rows = rows + 1
  end
  if rows == 0 then
    probe.Say("shapes: DB is empty, run a scan first")
    return
  end

  local lines = {
    string.format("shapes: whole DB rebuilt per shape, %d rows", rows),
    "shape           retained     bytes/row   vs current",
  }
  local baseline
  for _, shape in ipairs(SHAPES) do
    local result = probe.Measure(function()
      local copy = {}
      for itemId, row in pairs(db) do
        copy[itemId] = shape.build(itemId, row)
      end
      return copy
    end)
    baseline = baseline or result.retainedKB
    lines[#lines + 1] = string.format(
      "%-14s %s %11.0f %+11.1f KB",
      shape.key,
      probe.FormatKB(result.retainedKB),
      result.retainedKB * 1024 / rows,
      result.retainedKB - baseline
    )
  end
  lines[#lines + 1] = "the outer index table is in every figure, so compare differences, not totals"
  for _, shape in ipairs(SHAPES) do
    lines[#lines + 1] = string.format("%-14s %s", shape.key, shape.note)
  end
  probe.Report("row shapes - the live DB rebuilt per candidate", lines)
end
rowShape.Shapes = shapes

-- ---------------------------------------------------------------------------
-- What deriving the dropped fields costs on read
-- ---------------------------------------------------------------------------

local function primarySource(sources, priority)
  local best, bestRank
  for source in pairs(sources or {}) do
    local rank = priority[source] or math.huge
    if not bestRank or rank < bestRank or (rank == bestRank and source < best) then
      best, bestRank = source, rank
    end
  end
  return best
end

local function readCost()
  local db = database()
  local priority = sourcePriority()
  local rows, craftable = 0, 0
  for _, row in pairs(db) do
    rows = rows + 1
    if row.blueprint then
      craftable = craftable + 1
    end
  end
  if rows == 0 then
    probe.Say("read: DB is empty, run a scan first")
    return
  end

  -- warm the item link cache first, so the timings measure the derivation
  for itemId in pairs(db) do
    itemLinkFor(itemId)
  end

  local passes = {
    -- rawget, so this leg measures a stored field and not the metatable deriving one.
    -- Against the current row both read legs are 0 by construction, which is the
    -- point: the field is gone and the derive column is what a pass now pays
    {
      key = "read furnCategory (stored)",
      fn = function()
        local sink = 0
        for _, row in pairs(db) do
          sink = sink + (rawget(row, "furnCategory") or 0)
        end
        return sink
      end,
    },
    {
      key = "derive furnCategory",
      fn = function()
        local sink = 0
        for itemId in pairs(db) do
          local link = itemLinkFor(itemId)
          local dataId = link and GetItemLinkFurnitureDataId(link)
          if dataId and dataId ~= 0 then
            local categoryId = GetFurnitureDataCategoryInfo(dataId)
            sink = sink + (categoryId or 0)
          end
        end
        return sink
      end,
    },
    {
      key = "read origin (stored)",
      fn = function()
        local sink = 0
        for _, row in pairs(db) do
          sink = sink + (rawget(row, "origin") or 0)
        end
        return sink
      end,
    },
    {
      key = "read origin (via metatable)",
      fn = function()
        local sink = 0
        for _, row in pairs(db) do
          sink = sink + (row.origin or 0)
        end
        return sink
      end,
    },
    {
      key = "derive origin",
      fn = function()
        local sink = 0
        for _, row in pairs(db) do
          sink = sink + (primarySource(row.sources, priority) or 0)
        end
        return sink
      end,
    },
    {
      key = "derive craftingSkill",
      fn = function()
        local sink = 0
        for _, row in pairs(db) do
          if row.blueprint then
            local link = itemLinkFor(row.blueprint)
            sink = sink + (link and GetItemLinkCraftingSkillType(link) or 0)
          end
        end
        return sink
      end,
    },
  }

  local lines = {
    string.format("read: %d rows, %d craftable, %d runs each, item links warm", rows, craftable, READ_RUNS),
    "pass                  mean ms   us/row",
  }
  for _, pass in ipairs(passes) do
    local _, meanMs = probe.Time(pass.fn, READ_RUNS)
    lines[#lines + 1] = string.format("%-20s %9.1f %8.2f", pass.key, meanMs, meanMs * 1000 / rows)
  end
  probe.Report("row read - cost of deriving the dropped fields", lines)
end
rowShape.ReadCost = readCost

-- ---------------------------------------------------------------------------
-- Structures assembled through the public API
-- ---------------------------------------------------------------------------

-- The shapes above transform the stored row, so they can only describe structures
-- the row still carries. These build from the API instead, which prices a structure
-- the DB has never stored - a published record shape, or one being designed.
local API_SHAPES = {
  {
    key = "GetEntry copies",
    note = "holding a copy of every entry, as a consumer would",
    build = function(itemId)
      return lib().API.GetEntry(itemId)
    end,
  },
  {
    key = "GetSourceDetails",
    note = "the structured record list, for every row",
    build = function(itemId)
      return lib().API.GetSourceDetails(itemId)
    end,
  },
}

--- Adds a candidate structure, so one can be priced without editing this file.
--- Custom.lua is the place for a shape that is being designed rather than shipped.
---@param shape table key, note, and build(itemId, row). Set fromApi to build from
---  an item id alone rather than by transforming the stored row.
local function register(shape)
  local target = (shape.fromApi and API_SHAPES) or SHAPES
  target[#target + 1] = shape
end
rowShape.Register = register

local function apiShapes()
  local db = database()
  local rows = 0
  for _ in pairs(db) do
    rows = rows + 1
  end
  if rows == 0 then
    probe.Say("api: DB is empty, run a scan first")
    return
  end

  local lines = {
    string.format("api: structures built per item, %d rows", rows),
    "structure          retained     bytes/row     build",
  }
  for _, shape in ipairs(API_SHAPES) do
    local result = probe.Measure(function()
      local built = {}
      for itemId in pairs(db) do
        built[itemId] = shape.build(itemId)
      end
      return built
    end)
    lines[#lines + 1] = string.format(
      "%-17s %s %11.0f %7d ms",
      shape.key,
      probe.FormatKB(result.retainedKB),
      result.retainedKB * 1024 / rows,
      result.ms
    )
  end
  lines[#lines + 1] = "these allocate far more than they retain, the collector is held off across the build"
  for _, shape in ipairs(API_SHAPES) do
    lines[#lines + 1] = string.format("%-17s %s", shape.key, shape.note)
  end
  probe.Report("row api - structures assembled through the API", lines)
end
rowShape.ApiShapes = apiShapes

-- ---------------------------------------------------------------------------

local SECTIONS = {
  calib = calibrate,
  census = census,
  shapes = shapes,
  read = readCost,
  api = apiShapes,
}

--- @param section? string one of calib, census, shapes, read; all of them when omitted
local function run(section)
  section = (section or ""):lower()
  probe.ResetReport()
  if section ~= "" then
    local fn = SECTIONS[section]
    if not fn then
      probe.Say("row: unknown section '" .. section .. "'. Use calib, census, shapes, read or api.")
      return
    end
    fn()
    return
  end
  calibrate()
  census()
  shapes()
  readCost()
  apiShapes()
end
rowShape.Run = run
