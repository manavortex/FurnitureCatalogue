-- SavedVars migrations: drop/convert legacy settings across accounts

-- SavedVars migrations: old settings / properties
local LEGACY_DROP = {
  "data", -- old persisted DB, not in SavedVars anymore
  "accountCharacters", -- per-char knowledge -> LCK
  "excelExport", -- old export table? -> FurnitureCatalogue_Export
  "emptyItemSources", -- datamining aid -> FurCDev
  "startupSilently", -- not used anymore, debug stuff now
  "visibility", -- window toggled by hotkey or slash cmd now
  "useIconsThisChar", -- renamed -> useInventoryIconsOnChar
}

---@type { name: string, run: fun(aw: table) }[] aw: account wide
FurC.Migrations = {
  {
    -- old embedded `data[id].favorite`
    name = "favorites_from_data",
    run = function(aw)
      if type(aw.data) ~= "table" then
        return
      end
      aw.favorites = aw.favorites or {}
      for id, entry in pairs(aw.data) do
        if type(entry) == "table" and entry.favorite then
          aw.favorites[id] = true
          entry.favorite = nil
        end
      end
    end,
  },
  {
    -- `favourites` -> `favorites` (so we don't mix spellings)
    name = "favourites_spelling",
    run = function(aw)
      if type(aw.favourites) ~= "table" then
        return
      end
      aw.favorites = aw.favorites or {}
      for id, known in pairs(aw.favourites) do
        if known then
          aw.favorites[id] = true
        end
      end
      aw.favourites = nil
    end,
  },
  {
    -- explicitly drop legacy tables
    name = "drop_legacy",
    run = function(aw)
      for _, key in ipairs(LEGACY_DROP) do
        aw[key] = nil
      end
    end,
  },
}

---Get accounts from SavedVars
--- For testing purposes a fake table can be passed.
--- defaults to `FurnitureCatalogue_Settings["Default"]`
---@param test? table test table to skip real SavedVars
---@return table
local function accountBranches(test)
  local root = test or (FurnitureCatalogue_Settings and FurnitureCatalogue_Settings["Default"])
  local out = {}
  for _, branch in pairs(root or {}) do
    local aw = branch["$AccountWide"]
    if type(aw) == "table" then
      out[#out + 1] = aw
    end
  end
  return out
end

---Run SavedVars migrations on current acc (default) or every account
---@param opts? { allAccounts?: boolean, migrations?: string[], test?: table } # migrations nil/empty = all, in order; `test` supplies a fake table
---@return integer accountsMigrated
function FurC.Migrate(opts)
  opts = opts or {}
  local only
  if opts.migrations and #opts.migrations > 0 then
    only = {}
    for _, name in ipairs(opts.migrations) do
      only[name] = true
    end
  end
  local targets = opts.allAccounts and accountBranches(opts.test) or { opts.test or FurC.settings }
  for _, aw in ipairs(targets) do
    for _, step in ipairs(FurC.Migrations) do
      if not only or only[step.name] then
        step.run(aw)
      end
    end
  end
  return #targets
end

-- Count stale DB entries across every account
---@param test? table injects a source for CI/headless (see FurC.Migrate)
---@return { accounts: integer, entries: integer }
function FurC.GetLegacyStats(test)
  local accounts, entries = 0, 0
  for _, aw in ipairs(accountBranches(test)) do
    if aw.data ~= nil or aw.accountCharacters ~= nil or aw.excelExport ~= nil then
      accounts = accounts + 1
      if type(aw.data) == "table" then
        entries = entries + NonContiguousCount(aw.data)
      end
    end
  end
  return { accounts = accounts, entries = entries }
end
