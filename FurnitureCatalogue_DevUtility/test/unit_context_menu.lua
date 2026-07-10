-- Context menu: only known items get FurC menu entries

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  -- id far outside any real item range; FurC.Find must miss
  local UNKNOWN_ID = 99999999 -- TODO: or maybe id = 1?

  describe("FurC.Find miss contract", function()
    it("returns an empty table (never nil) for unknown ids", function()
      FurCDev.Test.ensureDB()
      local entry = FurC.Find(UNKNOWN_ID)
      assert.equals("table", type(entry))
      assert.is_nil(next(entry))
    end)

    it("gives an empty description for unknown ids", function()
      assert.equals("", FurC.GetItemDescription(UNKNOWN_ID))
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
