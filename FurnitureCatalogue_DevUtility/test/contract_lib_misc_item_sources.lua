-- FurC.MiscItemSources data contract: rows should have records of ids, not formatted text

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local constants = LFC.Internal.Constants
  local query = LFC.Internal.Query
  local src = constants.ItemSources

  local OWNED = {
    [src.BAZAAR] = true,
    [src.CHEST] = true,
    [src.DROP] = true,
    [src.DUNGEON] = true,
    [src.HARVEST] = true,
    [src.QUEST] = true,
    [src.TOMES] = true,
  }

  local function isFrom(idTable, value)
    for _, id in pairs(idTable) do
      if id == value then
        return true
      end
    end
    return false
  end

  ---Every row this file owns, as { version, source, itemId, row }
  local function ownedRows()
    local rows = {}
    for version, versionData in pairs(FurC.MiscItemSources) do
      for source, bucket in pairs(versionData) do
        if OWNED[source] then
          for itemId, row in pairs(bucket) do
            rows[#rows + 1] = { version = version, source = source, itemId = itemId, row = row }
          end
        end
      end
    end
    return rows
  end

  describe("FurC.MiscItemSources rows", function()
    it("are records, not formatted source lines", function()
      local rows = ownedRows()
      assert.is_true(#rows > 0, "no rows in the buckets this file owns")
      for _, found in ipairs(rows) do
        assert.equals(
          "table",
          type(found.row),
          string.format("row %s in source %s is %s", found.itemId, found.source, type(found.row))
        )
      end
    end)

    it("carry ids from the vocabularies, and a location of exactly one kind", function()
      for _, found in ipairs(ownedRows()) do
        local row, where = found.row, string.format("row %s", found.itemId)
        if type(row) ~= "table" then
        else
          if row.location ~= nil then
            assert.is_true(isFrom(constants.ZoneIds, row.location), where .. ": location is not a ZoneIds value")
          end
          if row.place ~= nil then
            assert.is_true(isFrom(constants.PlaceIds, row.place), where .. ": place is not a PlaceIds value")
          end
          for _, zoneId in ipairs(row.locations or {}) do
            assert.is_true(isFrom(constants.ZoneIds, zoneId), where .. ": locations holds a non-ZoneIds value")
          end
          -- `locations` is one source covering several zones
          assert.is_true(row.locations == nil or row.location == nil, where .. ": has both location and locations")
          assert.is_true(
            row.locations == nil or row.place == nil,
            where .. ": a place nests into one location, not into several"
          )
          if row.itemPack ~= nil then
            assert.is_true(isFrom(constants.TomesPacks, row.itemPack), where .. ": itemPack is not a TomesPacks value")
          end
          -- a note is a string id, a literal, a `{ npc = }`-style part, or a list
          for _, value in ipairs((type(row.note) == "table" and row.note[1] ~= nil and row.note) or { row.note }) do
            if type(value) ~= "table" then
              assert.is_false(isFrom(constants.ZoneIds, value), where .. ": note holds a zone id")
            end
          end
          assert.is_nil(row.text, where .. ": carries a finished sentence instead of a source")
          for _, field in ipairs({ "quest", "reward", "itemPrice" }) do
            if row[field] ~= nil then
              assert.equals("number", type(row[field]), where .. ": " .. field)
            end
          end
          -- a price without a currency silently reads as gold
          if row.itemPrice ~= nil then
            assert.equals("number", type(row.currency), where .. ": itemPrice without a currency")
          end
        end
      end
    end)

    it("render a line naming the zone the row points at", function()
      local checked = 0
      for _, found in ipairs(ownedRows()) do
        local row = found.row
        if type(row) == "table" and row.location ~= nil then
          local line = query.GetMiscItemSource(found.itemId, { version = found.version }, false, found.source)
          local zoneName = constants.Resolvers.Zone(row.location)
          assert.is_true(
            line:find(zoneName, 1, true) ~= nil,
            string.format("row %s renders %q, which does not name %s", found.itemId, line, zoneName)
          )
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0, "no row carries a location")
    end)

    -- A list inside one qualifier field is alternatives ("A or B"), additional qualifiers are concatenated
    it("render a further qualifier after a list of alternatives, not inside it", function()
      local conjunction = string.format(" %s ", GetString(SI_FURC_GRAMMAR_CONJ_OR))
      local checked = 0
      for _, found in ipairs(ownedRows()) do
        local row = found.row
        local alternatives = type(row) == "table" and type(row.note) == "table" and row.note[1] ~= nil
        if alternatives and row.rarity ~= nil then
          local line = query.GetMiscItemSource(found.itemId, { version = found.version }, false, found.source)
          local where = string.format("row %s renders %q", found.itemId, line)
          local joinAt = line:find(conjunction, 1, true)
          local rarityAt = line:find(GetString(row.rarity), 1, true)
          assert.is_true(joinAt ~= nil, where .. ", which does not join its alternatives")
          assert.is_true(rarityAt ~= nil, where .. ", which drops the rarity")
          assert.is_true(joinAt < rarityAt, where .. ", making the rarity one of the alternatives")
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0, "no row carries both a list of alternatives and a rarity")
    end)

    it("render every row to a line of its own", function()
      for _, found in ipairs(ownedRows()) do
        if type(found.row) == "table" then
          local line = query.GetMiscItemSource(found.itemId, { version = found.version }, false, found.source)
          assert.equals("string", type(line), string.format("row %s rendered %s", found.itemId, type(line)))
          assert.is_true(#line > 0, string.format("row %s rendered empty", found.itemId))
          assert.is_true(
            line ~= GetString(SI_FURC_SRC_EMPTY),
            string.format("row %s fell through to the unknown-source text", found.itemId)
          )
        end
      end
    end)
  end)
end)
