-- Stored row contract: what a row keeps, and what it derives
--
-- The library stores only what the game cannot answer. Three fields that used to sit on
-- every row are derived through one shared metatable instead, and released
-- FurnitureCatalogue reads all three off the raw row - the source filter, the tooltip,
-- the context menu and the category filter. So "the row is lean" and "the raw row still
-- answers" are one contract, not two, and this file holds both halves.

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local api = LFC.API
  local compat = LFC.Internal.Compat
  local src = LFC.Internal.Constants.ItemSources
  local Test = FurCDev.Test
  local DS = Test.dataset()

  describe("stored row shape", function()
    ---A row straight out of the DB, not a copy
    local function rawRow(itemId)
      return FurC.DB[itemId]
    end

    it("stores only what the game cannot answer for us", function()
      Test.ensureDB()
      local row = rawRow(DS.craftable)
      assert.is_not_nil(row)

      -- rawget goes past the metatable, so this is what the row actually costs
      assert.is_nil(rawget(row, "origin"))
      assert.is_nil(rawget(row, "furnCategory"))
      assert.is_nil(rawget(row, "furnSubcategory"))
      assert.is_nil(rawget(row, "craftingSkill"))

      -- and what it keeps
      assert.equals(DS.craftable, rawget(row, "id"))
      assert.equals("table", type(rawget(row, "sources")))
      assert.equals("number", type(rawget(row, "version")))
    end)

    it("answers origin and category off the raw row, which released consumers read", function()
      Test.ensureDB()
      -- FurC.Find hands back the internal row rather than a copy, and that is what
      -- FurnitureCatalogue 7.0.0's filter, tooltip and context menu are holding
      local row = FurC.Find(DS.craftable)
      assert.is_true(rawequal(row, rawRow(DS.craftable)))

      assert.equals("number", type(row.origin))
      assert.is_true(row.sources[row.origin] == true)

      -- the category filter reads both and treats nil as 0, which matches nothing,
      -- so the filter fails closed rather than open if this ever stops answering
      assert.equals("number", type(row.furnCategory))
      assert.equals("number", type(row.furnSubcategory))

      -- and the metatable does not invent anything else
      assert.is_nil(row.somethingNobodyStores)
    end)

    it("derives the same category the game does", function()
      Test.ensureDB()
      local row = FurC.Find(DS.craftable)
      local dataId = GetItemLinkFurnitureDataId(Test.link(DS.craftable))
      if not dataId or dataId == 0 then
        return -- the game knows no furnishing for it, nothing to compare against
      end
      local categoryId, subcategoryId = GetFurnitureDataCategoryInfo(dataId)
      assert.equals(categoryId or 0, row.furnCategory)
      assert.equals(subcategoryId or 0, row.furnSubcategory)
    end)

    it("loses the derived fields through a shallow copy, and the renderer survives it", function()
      Test.ensureDB()
      -- the AddOn's list builds its display rows with a shallow copy and then asks for
      -- the description off that copy. pairs cannot see a derived field, so the copy
      -- has no origin and the description path has to derive it again
      local copy = ZO_ShallowTableCopy(FurC.Find(DS.luxItem))
      assert.is_nil(rawget(copy, "origin"))
      assert.is_nil(copy.origin)

      local described = api.GetItemDescription(DS.luxItem, copy, true)
      assert.equals("string", type(described))
      assert.is_true(#described > 0)
      assert.equals(api.GetItemDescription(DS.luxItem, api.GetEntry(DS.luxItem), true), described)
    end)

    it("stamps origin onto the copy GetEntry hands out", function()
      Test.ensureDB()
      local entry = api.GetEntry(DS.craftable)
      assert.equals(FurC.Find(DS.craftable).origin, rawget(entry, "origin"))
      -- not stamped: the game answers these, and an item-category endpoint is the
      -- intended route rather than a field on every entry
      assert.is_nil(rawget(entry, "furnCategory"))
    end)

    it("marks compat-injected sources with a bitmask, absent when nothing was injected", function()
      Test.ensureDB()
      local withInjection, without
      for id, row in pairs(FurC.DB) do
        if type(row) == "table" and rawget(row, "sources") then
          if rawget(row, "compatSources") then
            withInjection = withInjection or id
          else
            without = without or id
          end
        end
        if withInjection and without then
          break
        end
      end

      assert.is_not_nil(without, "every row carries a compat marker, which is the cost this removed")
      assert.is_false(compat.IsInjected(rawRow(without).compatSources, src.DROP))

      if not withInjection then
        return -- no injected source in this data set
      end
      local mask = rawRow(withInjection).compatSources
      assert.equals("number", type(mask))
      assert.is_true(mask > 0)

      -- the marked members are exactly the ones GetSourceDetails leaves out
      local injected, described = {}, {}
      for source in pairs(rawRow(withInjection).sources) do
        if compat.IsInjected(mask, source) then
          injected[source] = true
          -- an injected member is in sources, which is what makes 7.0.0's filter work
          assert.is_true(rawRow(withInjection).sources[source])
        end
      end
      assert.is_true(next(injected) ~= nil)
      for _, record in ipairs(api.GetSourceDetails(withInjection)) do
        described[record.source.type] = true
      end
      for source in pairs(injected) do
        assert.is_nil(described[source], "an injected source got its own record")
      end
    end)
  end)
end)
