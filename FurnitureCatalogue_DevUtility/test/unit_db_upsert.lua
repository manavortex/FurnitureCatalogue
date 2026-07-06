-- Test DB insertions

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local src = FurC.Constants.ItemSources

  local TEST_ID = 99000001
  local function clear()
    FurC.DB[TEST_ID] = nil
  end

  describe("FurC.Upsert", function()
    it("stores a single source and mirrors it onto origin", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, version = 1 })
      local e = FurC.DB[TEST_ID]
      assert.is_not_nil(e)
      assert.is_true(e.sources[src.VENDOR])
      assert.equals(src.VENDOR, e.origin)
      clear()
    end)

    it("merges additional sources instead of replacing", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      FurC.Upsert(TEST_ID, { origin = src.LUXURY })
      local e = FurC.DB[TEST_ID]
      assert.is_true(e.sources[src.VENDOR])
      assert.is_true(e.sources[src.LUXURY])
      clear()
    end)

    it("keeps RUMOUR only as the sole source", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      assert.is_true(FurC.DB[TEST_ID].sources[src.RUMOUR])
      assert.equals(src.RUMOUR, FurC.DB[TEST_ID].origin)
      clear()
    end)

    it("drops the RUMOUR fallback once a real source is known (either order)", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      local e = FurC.DB[TEST_ID]
      assert.is_nil(e.sources[src.RUMOUR])
      assert.is_true(e.sources[src.VENDOR])
      assert.equals(src.VENDOR, e.origin)
      clear()

      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      e = FurC.DB[TEST_ID]
      assert.is_nil(e.sources[src.RUMOUR])
      assert.is_true(e.sources[src.VENDOR])
      assert.equals(src.VENDOR, e.origin)
      clear()
    end)

    it("picks primary by rank, regardless of write order", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR }) -- rank 99
      FurC.Upsert(TEST_ID, { origin = src.VENDOR }) -- rank 20 -> wins
      assert.equals(src.VENDOR, FurC.DB[TEST_ID].origin)
      FurC.Upsert(TEST_ID, { origin = src.CRAFTING }) -- rank 10 -> wins
      assert.equals(src.CRAFTING, FurC.DB[TEST_ID].origin)
      clear()
    end)

    it("merges non-source fields, last writer wins", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 111 })
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 222 })
      assert.equals(222, FurC.DB[TEST_ID].blueprint)
      clear()
    end)
  end)

  describe("runtime DB", function()
    it("builds FurC.DB from data files, SavedVars stay clean", function()
      FurC.EnsureDB()
      assert.is_true(next(FurC.DB) ~= nil)
      assert.is_nil(FurC.settings.data)
      assert.is_nil(FurC.settings.accountCharacters)
    end)

    it("EnsureDB: multiple calls, same result", function()
      FurC.EnsureDB()
      local before = FurCDev.Test.dbSize()
      FurC.EnsureDB()
      assert.equals(before, FurCDev.Test.dbSize())
    end)
  end)
end)
