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

  ---Can the client make anything of this id? Filter checks isValidItemType() and drops it when the answer is "nothing"
  ---@param itemId integer
  ---@return boolean
  local function clientResolves(itemId)
    local itemLink = LFC.API.GetItemLink(itemId)
    if not itemLink or itemLink == "" then
      return false
    end
    local itemType, specializedItemType = GetItemLinkItemType(itemLink)
    return not (0 == itemType and 0 == specializedItemType)
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
      if LFC.Internal.Build.HasSource(entry.sources, source) then
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

      -- "only a rumour" is the whole source set being that one bit, which is what the filter tests
      local onlyRumour = LFC.Internal.Build.SourceMask({ [src.RUMOUR] = true })
      local rumours = 0
      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        if LFC.Internal.Query.Find(itemId).sources == onlyRumour then
          rumours = rumours + 1
        end
      end
      assert.is_true(rumours > 0, "no item is only a rumour, so the exclusion is untested")
      assert.equals(LFC.API.GetEntryCount() - rumours - count(withSource(src.IGNORED)), count(all))
    end)

    it("hides ignored items by default but permits an explicit source query", function()
      FurC.EnsureDB(true)
      assert.is_nil(keptBy(src.NONE)[191611])
      assert.is_true(keptBy(src.IGNORED)[191611])
      for _, id in ipairs(FurC.GetSourceOrder()) do
        assert.is_false(id == src.IGNORED, "FC must not offer an ignored source tab")
      end
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

    it("leaves no resolvable item unreachable: every one shows under at least one tab", function()
      FurC.EnsureDB(true)
      local ids = LFC.API.GetItemIds()
      local order = FurC.GetSourceOrder()

      -- The rumour rows are the ones this check most needs
      local hasRumourTab = false
      for _, ddSource in ipairs(order) do
        hasRumourTab = hasRumourTab or ddSource == src.RUMOUR
      end
      assert.is_true(hasRumourTab, "no Rumour tab in the tree, so the rumour rows are not covered here")

      local seen = {}
      for _, ddSource in ipairs(order) do
        if ddSource ~= src.NONE and ddSource ~= src.FAVE then
          for itemId in pairs(keptBy(ddSource)) do
            seen[itemId] = true
          end
        end
      end

      local ignored = withSource(src.IGNORED)
      local unreachable, unresolvable = {}, 0
      for _, itemId in ipairs(ids) do
        if not seen[itemId] and not ignored[itemId] then
          if clientResolves(itemId) then
            unreachable[#unreachable + 1] = itemId
          else
            unresolvable = unresolvable + 1
          end
        end
      end

      FurCDev.Probe.Say(
        string.format("source tabs: %d of %d row(s) the client cannot resolve, shown by no tab", unresolvable, #ids)
      )

      assert.equals(
        0,
        #unreachable,
        string.format("%d resolvable item(s) show under no tab, e.g. %s", #unreachable, tostring(unreachable[1]))
      )
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

    it("a tab keeps everything the tabs below it keep, at every level", function()
      FurC.EnsureDB(true)
      local kept = {}
      for _, ddSource in ipairs(FurC.GetSourceOrder()) do
        kept[ddSource] = keptBy(ddSource)
      end

      local groups = FurC.GetSourceGroupIds()
      assert.is_true(#groups > 0, "no tab has children, so the level rule is untested")

      local pairsChecked = 0
      for _, groupId in ipairs(groups) do
        local node = FurC.GetSourceTreeNode(groupId)
        for _, child in ipairs((node and node.children) or {}) do
          if child.id and kept[child.id] then
            for itemId in pairs(kept[child.id]) do
              assert.is_true(
                kept[groupId][itemId] == true,
                string.format("item %d shows under tab %d but not under its group %d", itemId, child.id, groupId)
              )
            end
            pairsChecked = pairsChecked + 1
          end
        end
      end
      assert.is_true(pairsChecked > 0, "no group/child pair was compared")
    end)

    it("a multi-source item shows under the tab of each source it carries", function()
      FurC.EnsureDB(true)
      local kept = {}
      for _, ddSource in ipairs(FurC.GetSourceOrder()) do
        kept[ddSource] = keptBy(ddSource)
      end

      local checked = 0
      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        local entry = LFC.Internal.Query.Find(itemId)
        local carried = {}
        for s in LFC.Internal.Build.EachSource(entry.sources) do
          carried[#carried + 1] = s
        end
        if #carried > 1 then
          for _, s in ipairs(carried) do
            -- a tab named after a source must keep the rows carrying it (a tab that means something narrower has its own id)
            if kept[s] then
              assert.is_true(
                kept[s][itemId] == true,
                string.format("item %d carries source %d and is not kept by that tab", itemId, s)
              )
              local root = FurC.GetSourceFamilyRoot(s)
              if root and kept[root] then
                assert.is_true(
                  kept[root][itemId] == true,
                  string.format("item %d carries source %d and is not kept by its top-level tab %d", itemId, s, root)
                )
              end
              checked = checked + 1
            end
          end
        end
      end
      assert.is_true(checked > 0, "no multi-source item has a tab of its own, so nothing was checked")
    end)

    it("every source with a label has a place in the tree, and the tree invents none", function()
      local choices = FurC.DropdownData.ChoicesSource or {}
      FurC.GetSourceOrder() -- resolves the tree

      local isSource = {}
      for _, id in pairs(src) do
        isSource[id] = true
      end

      local labelled = 0
      for name, id in pairs(src) do
        if choices[id] then
          labelled = labelled + 1
          assert.is_not_nil(
            FurC.GetSourceTreeNode(id),
            string.format("%s (%d) is offered in the dropdown but sits in no tab", name, id)
          )
        end
      end
      assert.is_true(labelled > 0, "no source carries a label, so the tree covers nothing")

      -- the other direction: a tab is a source, or one of the filter-only ids
      for _, ddSource in ipairs(FurC.GetSourceOrder()) do
        assert.is_true(
          isSource[ddSource] == true or ddSource < 0,
          string.format("tab %d is neither a source nor a filter-only id", ddSource)
        )
      end

      -- A source with no label cannot be offered at all (label it, or keep it deliberately hidden)
      local HIDDEN = { IGNORED = true, ROLIS = true, GUILDSTORE = true, COLL_MERCH = true }
      for name, id in pairs(src) do
        if not choices[id] then
          assert.is_true(
            HIDDEN[name] == true,
            string.format("%s (%d) has no label, so no tab can offer it - label it or list it here", name, id)
          )
        end
      end
      for name in pairs(HIDDEN) do
        assert.is_nil(choices[src[name]], string.format("%s is listed as hidden but now carries a label", name))
      end
    end)
  end)
end)
