-- Check if we're still compatible with FurnitureShoppingList
-- need DB stuff for that

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local api = LibFurnitureCatalogue.API
  local Test = FurCDev.Test
  local DS = Test.dataset()

  describe("contract: FurnitureShoppingList", function()
    it("GetEntry on a craftable answers with its stored fields", function()
      local entry = api.GetEntry(DS.craftable)
      assert.equals("table", type(entry))
      assert.is_not_nil(entry.sources)
      assert.is_not_nil(entry.blueprint)
      assert.is_nil(api.GetEntry(99123456))
    end)

    it("GetIngredients returns correct tbl", function()
      local link = Test.link(DS.craftable)
      local mats = api.GetIngredients(link, api.GetEntry(link))
      assert.equals("table", type(mats))
      for matLink, qty in pairs(mats) do
        assert.equals("string", type(matLink))
        assert.equals("number", type(qty))
        assert.is_true(qty >= 1)
      end
    end)

    it("GetIngredients on empty/invalid link returns empty tbl", function()
      local mats = api.GetIngredients("", {})
      assert.equals("table", type(mats))
      assert.is_nil(next(mats))
    end)

    it("the flat aliases it used to call are gone", function()
      for _, name in ipairs({ "Find", "GetItemId", "GetItemLink", "GetIngredients", "GetMats" }) do
        assert.is_nil(FurC[name], "FurC." .. name .. " is still published")
      end
    end)
  end)
end)
