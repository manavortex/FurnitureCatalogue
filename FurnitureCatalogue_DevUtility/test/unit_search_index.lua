-- Search index feeds text filter with localised constants

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local index = FurC.SearchIndex
  local npc = FurC.Constants.NPC
  local loc = FurC.Constants.Locations

  -- strip `^xyz` control suffix, then lowercase
  local function lower(s)
    return LocaleAwareToLower(FurC.Utils.stripTxt(s, FurC.Utils.STRIP_CONTROL))
  end

  --- first folio content id that resolves to furnishing, plus its folio
  local function anyFolioContent()
    for folioId, folioData in pairs(FurC.FurnishingFolios or {}) do
      for _, contentId in ipairs(folioData.contents or {}) do
        local itemId = FurC.DBQuery.ResolveRecipe(contentId)
        if itemId then
          return itemId, folioId
        end
      end
    end
  end

  describe("FurC.SearchIndex resolvers", function()
    it("resolves an achievement id to a name, once per id", function()
      local first = index.GetAchievementName(1801)
      assert.equals("string", type(first))
      assert.is_true(#first > 0)
      assert.equals(first, index.GetAchievementName(1801))
    end)

    it("ignores free-text achievement fields", function()
      assert.is_nil(index.GetAchievementName("some description"))
      assert.is_nil(index.GetAchievementName(nil))
    end)

    it("resolves a container item link to a name", function()
      local name = index.GetItemName(FurC.Constants.Containers.NEWLIFEBOX)
      assert.equals("string", type(name))
      assert.is_true(#name > 0)
    end)
  end)

  describe("FurC.SearchIndex terms", function()
    it("indexes master writ furnishings, not the blueprint", function()
      FurCDev.Test.ensureDB()
      local blueprintId = next(FurC.FaustinaRecipes[next(FurC.FaustinaRecipes)])
      local itemId = FurC.DBQuery.ResolveRecipe(blueprintId)
      assert.is_not_nil(itemId)

      local terms = index.GetTerms(itemId)
      assert.is_not_nil(terms)
      assert.is_not_nil(string.find(terms, lower(npc.FAUSTINA), 1, true))
      assert.is_not_nil(string.find(terms, lower(loc.ANY_CAPITAL), 1, true))
      -- blueprint itself carries no search terms (not a DB row)
      assert.is_nil(index.GetTerms(blueprintId))
    end)

    it("indexes a folio's name against the furnishing its contents craft", function()
      FurCDev.Test.ensureDB()
      local itemId, folioId = anyFolioContent()
      assert.is_not_nil(itemId)

      local terms = index.GetTerms(itemId)
      assert.is_not_nil(terms)
      assert.is_not_nil(string.find(terms, index.GetItemName(folioId), 1, true))
    end)

    it("indexes every book of a collection by its container's name", function()
      FurCDev.Test.ensureDB()
      for containerId, collection in pairs(FurC.BookCollections) do
        local containerName = index.GetItemName(containerId)
        assert.is_not_nil(containerName)
        for _, bookId in ipairs(collection.contents) do
          local terms = index.GetTerms(bookId)
          assert.is_not_nil(terms, string.format("book %d of container %d has no terms", bookId, containerId))
          assert.is_not_nil(string.find(terms, containerName, 1, true))
        end
      end
    end)

    it("generates a source string for books from their container", function()
      FurCDev.Test.ensureDB()
      local bc = FurC.Constants.BookContainers
      local collection = FurC.BookCollections[bc.NOTHING_EYES]
      local misc = FurC.MiscItemSources[collection.version][FurC.Constants.ItemSources.DROP]
      for _, bookId in ipairs(collection.contents) do
        local sourceText = misc[bookId]
        assert.equals("string", type(sourceText))
        assert.is_not_nil(string.find(sourceText, tostring(bc.NOTHING_EYES), 1, true)) -- itemlink of the container
      end
    end)

    it("indexes luxury furnishings under the luxury vendor and Coldharbour", function()
      FurCDev.Test.ensureDB()
      local itemId
      for _, luxItems in pairs(FurC.LuxuryFurnisher) do
        itemId = next(luxItems) -- some versions have no lux
        if itemId then
          break
        end
      end
      assert.is_not_nil(itemId)

      local terms = index.GetTerms(itemId)
      assert.is_not_nil(terms)
      assert.is_not_nil(string.find(terms, lower(npc.LUXF), 1, true))
      assert.is_not_nil(string.find(terms, lower(loc.COLDH), 1, true))
    end)

    it("never indexes item ids or prices", function()
      FurCDev.Test.ensureDB()
      local itemId = FurC.DBQuery.ResolveRecipe(203322) -- Pattern: Apocrypha Book Press (resultItem 203280)
      local terms = index.GetTerms(itemId)
      assert.is_not_nil(terms)
      assert.is_nil(string.find(terms, "|H", 1, true)) -- no raw links
      assert.is_nil(string.find(terms, "700", 1, true)) -- no voucher price
    end)

    it("returns nil for an item with no source terms", function()
      FurCDev.Test.ensureDB()
      assert.is_nil(index.GetTerms(99000003))
    end)

    -- user might already be typing search while index is still building, so the DB scan has to invalidate it
    it("is invalidated by the DB scan, which mutates the tables it reads", function()
      local realInvalidate = index.Invalidate
      local calls = 0
      index.Invalidate = function()
        calls = calls + 1
        realInvalidate()
      end

      local ok, err = pcall(function()
        FurC.RebuildDB(true)
      end)

      index.Invalidate = realInvalidate
      assert.is_true(ok, tostring(err))
      assert.is_true(calls > 0)
    end)

    it("indexes the vendor stock merged in during the scan", function()
      FurCDev.Test.ensureDB()
      local terms = index.GetTerms(120998) -- Block, Wood Cutting (sold by HGF in most cities)
      assert.is_not_nil(terms)
      local n = 0
      for _ in terms:gmatch("[^\n]+") do
        n = n + 1
      end
      -- Exact count is currently imprecise (islands/DLC/all-capitals varies)
      assert.is_true(n >= 9)
    end)
  end)
end)
