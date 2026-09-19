-- Context menu: only known items get FurC menu entries

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  -- id far outside any real item range; FurC.Find must miss
  local UNKNOWN_ID = 99999999 -- TODO: or maybe id = 1?

  describe("miss contracts", function()
    it("the published lookup answers nil for an unknown id", function()
      FurCDev.Test.ensureDB()
      assert.is_nil(LibFurnitureCatalogue.API.GetEntry(UNKNOWN_ID))
    end)

    it("the internal lookup answers an empty table on a miss, never nil", function()
      FurCDev.Test.ensureDB()
      local entry = LibFurnitureCatalogue.Internal.Query.Find(UNKNOWN_ID)
      assert.equals("table", type(entry))
      assert.is_nil(next(entry))
      -- published, and empty: a consumer that never migrated must not call a nil value
      assert.equals("function", type(FurC.Find), "the landing pad is gone")
      assert.is_nil(next(FurC.Find(UNKNOWN_ID)), "the landing pad answers data")
      assert.is_nil(next(FurC.Find(FurCDev.Test.dataset().dbItem)), "the landing pad reads the DB")
    end)

    it("gives an empty description for unknown ids", function()
      assert.equals("", LibFurnitureCatalogue.API.GetItemDescription(UNKNOWN_ID))
    end)
  end)

  describe("shopping list menu entries", function()
    local function countMenuEntries(itemId)
      -- Taneth sandboxes tests (env._G = env), so we stub via the real global table
      local realG = getmetatable(_G).__index
      local added = 0
      local orig = realG.AddCustomMenuItem
      realG.AddCustomMenuItem = function()
        added = added + 1
      end
      local ok = pcall(AddFurnitureShoppingListMenuEntry, itemId)
      realG.AddCustomMenuItem = orig
      assert.is_true(ok)
      return added
    end

    it("adds none for a non-furnishing item", function()
      FurCDev.Test.ensureDB()
      assert.equals(0, countMenuEntries(UNKNOWN_ID))
    end)

    it("adds entries for a known catalogue item", function()
      FurCDev.Test.ensureDB()
      local knownId = next(FurC.DB)
      assert.is_not_nil(knownId)
      assert.is_true(countMenuEntries(knownId) > 0)
    end)
  end)
end)
