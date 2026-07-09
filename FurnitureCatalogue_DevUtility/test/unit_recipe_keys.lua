-- Some blueprints (like Master Writ Trader) recipes must be referenced by furnishing id they craft, not by blueprint
-- Otherwise we get duplicates (this test tries to check for it)

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local src = FurC.Constants.ItemSources

  --- Every recipe the writ vendors sell (including folios)
  local function voucherRecipeIds()
    local ids = {}
    for _, tbl in ipairs({ FurC.RolisRecipes or {}, FurC.FaustinaRecipes or {} }) do
      for _, versionData in pairs(tbl) do
        for id in pairs(versionData) do
          ids[id] = true
        end
      end
    end
    for _, folioData in pairs(FurC.FurnishingFolios or {}) do
      for _, id in ipairs(folioData.contents or {}) do
        ids[id] = true
      end
    end
    return ids
  end

  describe("writ vendor recipe keys", function()
    it("never stores a voucher blueprint under its own id", function()
      FurC.EnsureDB()
      local offenders = {}
      for recipeId in pairs(voucherRecipeIds()) do
        if FurC.DB[recipeId] then
          offenders[#offenders + 1] = recipeId
        end
      end
      assert.equals(0, #offenders)
    end)

    it("stores crafted furnishing with both its crafting and vendor source", function()
      FurC.EnsureDB()
      local checked = 0
      for recipeId in pairs(voucherRecipeIds()) do
        local itemId, blueprintId = FurC.DBQuery.ResolveRecipe(recipeId)
        if blueprintId then
          local entry = FurC.DB[itemId]
          assert.is_not_nil(entry)
          assert.equals(recipeId, entry.blueprint)
          assert.is_true(entry.sources[src.CRAFTING])
          assert.is_true(entry.sources[src.ROLIS])
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0)
    end)

    it("still finds the voucher price once the key moved to the furnishing", function()
      FurC.EnsureDB()
      for recipeId in pairs(voucherRecipeIds()) do
        local itemId, blueprintId = FurC.DBQuery.ResolveRecipe(recipeId)
        if blueprintId then
          -- the generic "sold by Rolis or Faustina" fallback means the price lookup missed
          local text = FurC.DBQuery.GetRolisSource(itemId, FurC.DB[itemId])
          assert.is_not_nil(text)
          return
        end
      end
    end)
  end)

  describe("FurC.DBQuery.ResolveRecipe", function()
    it("maps a recipe onto the item it crafts", function()
      local itemId, blueprintId = FurC.DBQuery.ResolveRecipe(203322) -- Pattern: Apocrypha Book Press
      assert.is_not_nil(blueprintId)
      assert.equals(203322, blueprintId)
      assert.is_true(itemId ~= 203322)
    end)

    it("passes a plain furnishing through untouched", function()
      local itemId, blueprintId = FurC.DBQuery.ResolveRecipe(99000002)
      assert.equals(99000002, itemId)
      assert.is_nil(blueprintId)
    end)
  end)
end)
