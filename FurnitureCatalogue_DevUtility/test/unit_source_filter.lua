-- Source dropdown: does a tab select the rows it claims to?

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local LFC = LibFurnitureCatalogue
  local src = LFC.API.GetSourceTypes()
  local filters = FurC.SourceFilters

  ---Run one source selection over the whole DB
  ---@param ddSource integer a source id or a FurC.SourceFilters value
  ---@return table<integer, boolean> kept item ids the selection shows
  local function openEveryOtherFilter()
    FurC.settings.filterCraftingTypeAll = true
    FurC.settings.filterQualityAll = true
    FurC.settings.filterFurnCategoryAll = true
    FurC.settings.filterFurnSubcategoryAll = true
    FurC.settings.hideBooks = false
    FurC.DropdownChoices["Version"] = 1
    FurC.DropdownChoices["Character"] = 1
    FurC.SearchFilter = ""
  end

  local function keptBy(ddSource)
    local previous = FurC.GetDropdownChoice("Source")
    openEveryOtherFilter()
    FurC.DropdownChoices["Source"] = ddSource
    FurC.SetFilter(false, true) -- skipRefresh: no GUI to refresh

    local kept = {}
    for _, itemId in ipairs(LFC.API.GetItemIds()) do
      if FurC.MatchFilter(itemId, LFC.Internal.Query.Find(itemId)) then
        kept[itemId] = true
      end
    end

    FurC.DropdownChoices["Source"] = previous
    FurC.SetFilter(false, true)
    return kept
  end

  ---@param ids table<integer, boolean>
  ---@return integer
  local function count(ids)
    local n = 0
    for _ in pairs(ids) do
      n = n + 1
    end
    return n
  end

  ---Every item the DB says carries this source
  ---@param source integer
  ---@return table<integer, boolean>
  local function withSource(source)
    local ids = {}
    for _, itemId in ipairs(LFC.API.GetItemIds()) do
      local entry = LFC.Internal.Query.Find(itemId)
      if entry.sources and entry.sources[source] then
        ids[itemId] = true
      end
    end
    return ids
  end

  describe("FurC source filter", function()
    it("All shows every item except the rumours, which only their own tab shows", function()
      FurC.EnsureDB(true)
      local all = keptBy(src.NONE)
      assert.is_true(count(all) > 0, "All kept nothing, so nothing below means anything")

      local rumours = 0
      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        if LFC.Internal.Query.Find(itemId).origin == src.RUMOUR then
          rumours = rumours + 1
        end
      end
      assert.is_true(rumours > 0, "no item has a rumour origin, so the exclusion is untested")
      assert.equals(LFC.API.GetEntryCount() - rumours, count(all))
    end)

    it("Housing Editor keeps exactly the items the editor sells", function()
      FurC.EnsureDB(true)
      local editorItems = withSource(src.EDITOR)
      assert.is_true(count(editorItems) > 0, "no item carries src.EDITOR, so the tab has nothing to find")

      local kept = keptBy(src.EDITOR)
      assert.equals(count(editorItems), count(kept))
      for itemId in pairs(editorItems) do
        assert.is_true(kept[itemId] == true, string.format("editor item %d is filtered out", itemId))
      end
    end)

    it("Crowns is the union of its two children, not one of them", function()
      FurC.EnsureDB(true)
      local crowns = keptBy(src.CROWN)
      local store = keptBy(filters.CROWN_STORE)
      local editor = keptBy(src.EDITOR)

      for itemId in pairs(store) do
        assert.is_true(crowns[itemId] == true, string.format("crown-store item %d is not under Crowns", itemId))
      end
      for itemId in pairs(editor) do
        assert.is_true(crowns[itemId] == true, string.format("editor item %d is not under Crowns", itemId))
      end
      -- and nothing else: the parent adds no row its children do not have
      for itemId in pairs(crowns) do
        assert.is_true(
          store[itemId] == true or editor[itemId] == true,
          string.format("item %d is under Crowns but under neither child", itemId)
        )
      end
      -- both halves are non-empty, or the union rule is untested
      assert.is_true(count(store) > 0, "the Crown Store tab keeps nothing")
      assert.is_true(count(editor) > 0, "the Housing Editor tab keeps nothing")
    end)

    it("Home Goods keeps the Home Goods Furnisher's stock", function()
      FurC.EnsureDB(true)
      local homeGoods = keptBy(filters.HOME_GOODS)
      assert.is_true(count(homeGoods) > 0, "the Home Goods tab keeps nothing")
      assert.is_nil(homeGoods[next(keptBy(filters.ACHIEVEMENT))], "an Achievement item is under Home Goods")
    end)

    it("Achievement keeps items that require one, and nothing else", function()
      FurC.EnsureDB(true)
      local kept = keptBy(filters.ACHIEVEMENT)
      assert.is_true(count(kept) > 0, "the Achievement tab keeps nothing")

      local gated = {}
      for _, versionData in pairs(FurC.AchievementVendors) do
        for _, locationData in pairs(versionData) do
          for _, vendorData in pairs(locationData) do
            for itemId, row in pairs(vendorData) do
              if type(row) == "table" and row.achievement then
                gated[itemId] = true
              end
            end
          end
        end
      end
      for itemId in pairs(kept) do
        assert.is_true(
          gated[itemId] == true,
          string.format("item %d is shown without requiring an achievement", itemId)
        )
      end

      local books = 0
      for _, versionData in pairs(FurC.Books or {}) do
        for itemId in pairs(versionData) do
          books = books + 1
          assert.is_nil(kept[itemId], string.format("book %d requires no achievement but is shown", itemId))
        end
      end
      assert.is_true(books > 0, "no books in FurC.Books, so their exclusion is untested")
    end)
  end)
end)
