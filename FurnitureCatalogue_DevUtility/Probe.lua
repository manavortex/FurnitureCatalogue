-- Measurement helpers for in-game probes
--   FurCDev.Probe.Measure(build)    allocation and retention of whatever build() returns
--   FurCDev.Probe.Time(fn, runs)    wall clock over n runs
--   FurCDev.Probe.Walk(pred, opts)  count and sample rows of the runtime DB
--   FurCDev.Probe.Scoped(t)         run a mutating probe with a guaranteed teardown
--   FurCDev.Probe.Say(lines)        chat output without the caller formatting it

if not FurCDev then
  return
end

local this = FurCDev
local probe = {}
this.Probe = probe

local PREFIX = "|cFF3333FurCDev|r: "

-- collectgarbage is restricted on some clients, so every option is optional
local function gc(opt, arg)
  local ok, res = pcall(collectgarbage, opt, arg)
  if ok then
    return res
  end
  return nil
end
probe.Gc = gc

-- one pass leaves the objects freed by that pass uncollected
local function fullCollect()
  gc("collect")
  gc("collect")
end
probe.FullCollect = fullCollect

--- Heap size in KB after a full collection
---@return number
local function heapKB()
  fullCollect()
  return gc("count") or 0
end
probe.HeapKB = heapKB

--- Measures what a builder allocates and what it keeps.
--- The collector is stopped across the build, so an incremental step cannot
--- run between the two readings and report memory falling while it rises.
---@param build fun(): any value to keep alive for the retention reading
---@return table result allocatedKB, retainedKB, residualKB, ms
local function measure(build)
  fullCollect()
  local stopped = gc("stop") ~= nil
  local before = gc("count") or 0

  local started = GetGameTimeMilliseconds()
  local held = build()
  local ms = GetGameTimeMilliseconds() - started
  local allocated = (gc("count") or 0) - before

  if stopped then
    gc("restart")
  end
  fullCollect()
  local retained = (gc("count") or 0) - before

  held = nil
  fullCollect()
  local residual = (gc("count") or 0) - before

  return {
    allocatedKB = allocated,
    retainedKB = retained,
    residualKB = residual,
    ms = ms,
    collectorStopped = stopped,
  }
end
probe.Measure = measure

--- Wall clock for n runs, returning the total and the per-run mean
---@param fn fun(run: integer): any
---@param runs? integer default 1
---@return number totalMs, number meanMs, any lastResult
local function timeIt(fn, runs)
  runs = runs or 1
  local last
  local started = GetGameTimeMilliseconds()
  for run = 1, runs do
    last = fn(run)
  end
  local total = GetGameTimeMilliseconds() - started
  return total, total / runs, last
end
probe.Time = timeIt

--- The runtime DB, whichever namespace is loaded
---@return table<integer, table>
local function database()
  local lib = LibFurnitureCatalogue
  return (lib and lib.Internal and lib.Internal.DB) or (FurC and FurC.DB) or {}
end
probe.Database = database

--- Walks the runtime DB and counts what a predicate accepts.
---@param pred? fun(itemId: integer, row: table): boolean nil counts every row
---@param opts? table sample = how many matching ids to keep (default 5), db = table to walk
---@return table result total, matched, sample
local function walk(pred, opts)
  opts = opts or {}
  local db = opts.db or database()
  local sampleSize = opts.sample or 5
  local total, matched, sample = 0, 0, {}
  for itemId, row in pairs(db) do
    total = total + 1
    if not pred or pred(itemId, row) then
      matched = matched + 1
      if #sample < sampleSize then
        sample[#sample + 1] = itemId
      end
    end
  end
  return { total = total, matched = matched, sample = sample }
end
probe.Walk = walk

--- Runs body between a setup and a teardown, and tears down even on error.
---@param t table setup, body, teardown
---@return boolean ok, any resultOrError
local function scoped(t)
  local state
  if t.setup then
    state = t.setup()
  end
  local ok, res = pcall(t.body, state)
  if t.teardown then
    local torn, tearErr = pcall(t.teardown, state)
    if not torn then
      d(PREFIX .. "teardown failed: " .. tostring(tearErr))
    end
  end
  return ok, res
end
probe.Scoped = scoped

--- Prints lines to chat, one d() per line, with the addon prefix on the first
---@param lines string|table
local function say(lines)
  if type(lines) == "string" then
    lines = { lines }
  end
  for i = 1, #lines do
    d((i == 1 and PREFIX or "  ") .. lines[i])
  end
end
probe.Say = say

--- Puts text in the dev window's output box
---@param text string
---@param append? boolean keep what the box already holds
---@return boolean shown false when there is no window
local function showOutput(text, append)
  if not (this.textbox and this.control) then
    return false
  end
  local existing = (append and this.textbox:GetText()) or ""
  this.textbox:SetText(existing .. text)
  this.control:SetHidden(false)
  return true
end
probe.ShowOutput = showOutput

local reportOpen = false

--- Starts a fresh report, so a run does not append to the last one
local function resetReport()
  reportOpen = false
end
probe.ResetReport = resetReport

--- One section of a probe run: box, SavedVariables and a line in chat.
--- The box holds the readable copy; SavedVariables is what survives a reload,
--- for a collector on the host to pick up.
---@param title string
---@param lines table
local function report(title, lines)
  -- Each report carries its own timestamp, because the store is keyed by title and
  -- survives a reload: running two sections today leaves last week's third section
  -- beside them, and the file's single `written` stamp cannot tell them apart. That
  -- has already misled once - an export held a census of the current row next to a
  -- shape table describing the row before it, and the stale half read as current
  local stamp = (GetTimeStamp and GetTimeStamp()) or 0
  local text = title .. "\n" .. string.format("run %s\n", tostring(stamp)) .. table.concat(lines, "\n") .. "\n\n"
  local shown = showOutput(text, reportOpen)
  reportOpen = true

  -- additive: a probe report must not discard a dump export
  FurCDev_SavedVariables = FurCDev_SavedVariables or {}
  local store = FurCDev_SavedVariables.probe
  if not store then
    store = { export = "FurCDevProbe_Export", reports = {} }
    FurCDev_SavedVariables.probe = store
  end
  store.reports[title] = text
  store.reportsWritten = store.reportsWritten or {}
  store.reportsWritten[title] = stamp
  store.written = stamp
  store.apiVersion = (GetAPIVersion and GetAPIVersion()) or 0

  if shown then
    d(PREFIX .. title .. " - in the FurCDev box, and in FurCDev_SavedVariables.probe after a reload")
  else
    say(lines)
  end
end
probe.Report = report

--- Right-aligned KB, so a column of numbers stays readable in chat
---@param kb number
---@return string
local function kb(value)
  return string.format("%8.1f KB", value or 0)
end
probe.FormatKB = kb

--- Smallest power of two that holds n hash keys, which is what Lua allocates
---@param n integer
---@return integer
local function slotsFor(n)
  if n <= 0 then
    return 0
  end
  local size = 1
  while size < n do
    size = size * 2
  end
  return size
end
probe.SlotsFor = slotsFor
