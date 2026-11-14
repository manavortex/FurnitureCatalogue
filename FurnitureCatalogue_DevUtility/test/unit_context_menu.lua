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
    -- Taneth sandboxes tests (env._G = env), so we stub via the real global table. Resolved here, at describe level:
    -- inside an it() _G is that test's own sandbox, one level further away
    local function realGlobals()
      return getmetatable(_G).__index
    end

    local function countMenuEntries(itemId)
      local realG = realGlobals()
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

    it("adds one entry for a known catalogue item", function()
      FurCDev.Test.ensureDB()
      local knownId = next(FurC.DB)
      assert.is_not_nil(knownId)
      assert.equals(1, countMenuEntries(knownId))
    end)

    it("asks FSL for a quantity when it can, else adds one through the legacy global", function()
      FurCDev.Test.ensureDB()
      local knownId = next(FurC.DB)
      local realG = realGlobals()
      local saved = { realG.AddCustomMenuItem, realG.FurnitureShoppingList, realG.FurnitureShoppingListAdd }
      local callback
      local prompted, legacy = 0, 0
      realG.AddCustomMenuItem = function(_, fn)
        callback = fn
      end
      realG.FurnitureShoppingListAdd = function()
        legacy = legacy + 1
      end
      local added = pcall(AddFurnitureShoppingListMenuEntry, knownId)
      realG.FurnitureShoppingList = {
        PromptAdd = function()
          prompted = prompted + 1
        end,
      }
      local viaPrompt = added and pcall(callback)
      realG.FurnitureShoppingList = nil
      local viaLegacy = added and pcall(callback)
      realG.AddCustomMenuItem, realG.FurnitureShoppingList, realG.FurnitureShoppingListAdd =
        saved[1], saved[2], saved[3]
      assert.is_true(added and viaPrompt and viaLegacy)
      assert.equals(1, prompted)
      assert.equals(1, legacy)
    end)
  end)
end)
