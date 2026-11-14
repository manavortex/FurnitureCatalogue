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
    -- FSL waits for the catalogue with these two before any lookup
    it("IsReady answers a boolean and OnReady exists", function()
      assert.equals("boolean", type(api.IsReady()))
      assert.equals("function", type(api.OnReady))
    end)

    -- FSL stores entry.id and passes it to GetIngredients, so a blueprint is listed as the furnishing it makes
    it("an entry carries the furnishing id, also when looked up by its blueprint", function()
      local entry = api.GetEntry(DS.craftable)
      assert.equals(DS.craftable, entry.id)
      assert.equals(DS.craftable, api.GetEntry(entry.blueprint).id)
      -- by id, as FSL calls it (headless stubs know no recipe ingredients, so only the shape is checked here)
      assert.equals("table", type(api.GetIngredients(entry.id, entry)))
    end)

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

    it("the flat aliases it used to call answer empty", function()
      assert.same({}, FurC.Find(DS.craftable))
      assert.same({}, FurC.GetIngredients(Test.link(DS.craftable)))
      assert.equals("", FurC.GetMats(Test.link(DS.craftable)))
      assert.equals("", FurC.GetItemDescription(DS.craftable, api.GetEntry(DS.craftable), true))
      -- except id and link translation
      assert.equals(DS.craftable, FurC.GetItemId(Test.link(DS.craftable)))
      assert.equals("string", type(FurC.GetItemLink(DS.craftable)))
    end)
  end)
end)
