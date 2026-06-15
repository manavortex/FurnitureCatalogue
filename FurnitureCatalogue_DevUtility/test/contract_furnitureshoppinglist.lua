-- Check if we're still compatible with FurnitureShoppingList
-- need DB stuff for that

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local Test = FurCDev.Test
  local DS = Test.dataset()

  describe("contract: FurnitureShoppingList", function()
    it("Find on craftable returns recipeArray", function()
      local arr = FurC.Find(DS.craftable)
      assert.equals("table", type(arr))
      assert.is_not_nil(arr.origin)
      assert.is_not_nil(arr.blueprint)
    end)

    it("GetIngredients returns correct tbl", function()
      local link = Test.link(DS.craftable)
      local mats = FurC.GetIngredients(link, FurC.Find(link))
      assert.equals("table", type(mats))
      for matLink, qty in pairs(mats) do
        assert.equals("string", type(matLink))
        assert.equals("number", type(qty))
        assert.is_true(qty >= 1)
      end
    end)

    it("GetIngredients on empty/invalid link returns empty tbl", function()
      local mats = FurC.GetIngredients("", {})
      assert.equals("table", type(mats))
      assert.is_nil(next(mats))
    end)

    it("Find:GetIngredients always returns same values", function()
      local link = Test.link(DS.craftable)
      local function size(t)
        local n = 0
        for _ in pairs(t) do
          n = n + 1
        end
        return n
      end
      local a1 = FurC.GetIngredients(link, FurC.Find(link))
      local a2 = FurC.GetIngredients(link, FurC.Find(link))
      assert.equals(size(a1), size(a2))
    end)
  end)
end)
