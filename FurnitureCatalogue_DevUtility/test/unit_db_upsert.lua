-- Test DB insertions

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local src = FurC.Constants.ItemSources
  -- the row stores its sources as a mask; GetEntry is what hands out the set
  local hasSource = LibFurnitureCatalogue.Internal.Build.HasSource
  -- the best-ranked source is derived on demand now; the row does not carry it
  local originOf = LibFurnitureCatalogue.Internal.Query.OriginOf

  local TEST_ID = 99000001
  local function clear()
    FurC.DB[TEST_ID] = nil
  end

  describe("legacy alias FurC.DB", function()
    it("resolves to the lib runtime table", function()
      assert.equals(LibFurnitureCatalogue.Internal.DB, FurC.DB)
    end)
  end)

  describe("FurC.Upsert", function()
    it("stores a single source, and it ranks as the best one", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, version = 1 })
      local e = FurC.DB[TEST_ID]
      assert.is_not_nil(e)
      assert.is_true(hasSource(e.sources, src.VENDOR))
      assert.equals(src.VENDOR, originOf(e))
      clear()
    end)

    it("merges additional sources instead of replacing", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      FurC.Upsert(TEST_ID, { origin = src.LUXURY })
      local e = FurC.DB[TEST_ID]
      assert.is_true(hasSource(e.sources, src.VENDOR))
      assert.is_true(hasSource(e.sources, src.LUXURY))
      clear()
    end)

    it("keeps RUMOUR only as the sole source", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      assert.is_true(hasSource(FurC.DB[TEST_ID].sources, src.RUMOUR))
      assert.equals(src.RUMOUR, originOf(FurC.DB[TEST_ID]))
      clear()
    end)

    it("drops the RUMOUR fallback once a real source is known (either order)", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      local e = FurC.DB[TEST_ID]
      assert.is_false(hasSource(e.sources, src.RUMOUR))
      assert.is_true(hasSource(e.sources, src.VENDOR))
      assert.equals(src.VENDOR, originOf(e))
      clear()

      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR })
      e = FurC.DB[TEST_ID]
      assert.is_false(hasSource(e.sources, src.RUMOUR))
      assert.is_true(hasSource(e.sources, src.VENDOR))
      assert.equals(src.VENDOR, originOf(e))
      clear()
    end)

    it("picks primary by rank, regardless of write order", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.RUMOUR }) -- rank 99
      FurC.Upsert(TEST_ID, { origin = src.VENDOR }) -- rank 20 -> wins
      assert.equals(src.VENDOR, originOf(FurC.DB[TEST_ID]))
      FurC.Upsert(TEST_ID, { origin = src.CRAFTING }) -- rank 10 -> wins
      assert.equals(src.CRAFTING, originOf(FurC.DB[TEST_ID]))
      clear()
    end)

    it("merges non-source fields, last writer wins", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 111 })
      FurC.Upsert(TEST_ID, { origin = src.VENDOR, blueprint = 222 })
      assert.equals(222, FurC.DB[TEST_ID].blueprint)
      clear()
    end)

    it("keeps updated fields when updating an existing id", function()
      clear()
      FurC.Upsert(TEST_ID, { origin = src.VENDOR })
      FurC.Upsert(TEST_ID, { origin = src.LUXURY, blueprint = 333 })
      assert.equals(333, FurC.DB[TEST_ID].blueprint)
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

    -- a malformed data block can leave a vendor or zone name behind as a key
    it("is keyed by item id only", function()
      FurC.EnsureDB()
      local api = LibFurnitureCatalogue.API
      local offenders = {}
      for id in pairs(FurC.DB) do
        if type(id) ~= "number" then
          offenders[#offenders + 1] = tostring(id)
        end
      end
      assert.same({}, offenders)

      local ids = api.GetItemIds()
      table.sort(ids) -- mixed key types raise here
      assert.equals(api.GetEntryCount(), #ids)
    end)

    -- find() memoises last lookup, a rebuild clears it
    it("the internal lookup hands out the current row after a rebuild", function()
      local id = FurCDev.Test.dataset().dbItem
      local find = LibFurnitureCatalogue.Internal.Query.Find
      assert.equals(LibFurnitureCatalogue.Internal.DB[id], find(id))
      local ok, err = pcall(FurC.RebuildDB, true)
      assert.is_true(ok, tostring(err))
      assert.equals(LibFurnitureCatalogue.Internal.DB[id], find(id))
    end)
  end)
end)
