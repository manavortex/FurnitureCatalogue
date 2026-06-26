-- Test DB insertions

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local src = FurC.Constants.ItemSources

  local TEST_ID = 99000001
  local function clear()
    FurC.settings.data[TEST_ID] = nil
  end

  describe("FurC.DB.Upsert", function()
    it("stores a single source and mirrors it onto origin", function()
      clear()
      FurC.DB.Upsert(TEST_ID, { origin = src.VENDOR, version = 1 })
      local e = FurC.settings.data[TEST_ID]
      assert.is_not_nil(e)
      assert.is_true(e.sources[src.VENDOR])
      assert.equals(src.VENDOR, e.origin)
      clear()
    end)

    it("merges additional sources instead of replacing", function()
      clear()
      FurC.DB.Upsert(TEST_ID, { origin = src.RUMOUR })
      FurC.DB.Upsert(TEST_ID, { origin = src.VENDOR })
      local e = FurC.settings.data[TEST_ID]
      assert.is_true(e.sources[src.RUMOUR])
      assert.is_true(e.sources[src.VENDOR])
      clear()
    end)

    it("picks primary by rank, regardless of write order", function()
      clear()
      FurC.DB.Upsert(TEST_ID, { origin = src.RUMOUR }) -- rank 99
      FurC.DB.Upsert(TEST_ID, { origin = src.VENDOR }) -- rank 20 -> wins
      assert.equals(src.VENDOR, FurC.settings.data[TEST_ID].origin)
      FurC.DB.Upsert(TEST_ID, { origin = src.CRAFTING }) -- rank 10 -> wins
      assert.equals(src.CRAFTING, FurC.settings.data[TEST_ID].origin)
      clear()
    end)

    it("merges non-source fields, last writer wins", function()
      clear()
      FurC.DB.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 111 })
      FurC.DB.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 222 })
      assert.equals(222, FurC.settings.data[TEST_ID].blueprint)
      clear()
    end)
  end)
end)
