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
  local src = LFC.Internal.Constants.ItemSources
  local hasSource, eachSource = LFC.Internal.Build.HasSource, LFC.Internal.Build.EachSource
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
      assert.equals("number", type(rawget(row, "sources")))
      assert.equals("number", type(rawget(row, "version")))
    end)

    it("answers the two category fields off the raw row, which the filter reads", function()
      Test.ensureDB()
      local row = rawRow(DS.craftable)

      -- the category filter reads both and treats nil as 0, which matches nothing
      assert.equals("number", type(row.furnCategory))
      assert.equals("number", type(row.furnSubcategory))

      -- which source ranks best is no longer a field at all: ask for the ranked records
      assert.is_nil(row.origin)
      local best = LFC.Internal.Query.OriginOf(row)
      assert.equals("number", type(best))
      assert.is_true(hasSource(row.sources, best))
      assert.equals(best, api.GetSourceDetails(DS.craftable)[1].source.type)

      -- and the metatable does not invent anything else
      assert.is_nil(row.somethingNobodyStores)
    end)

    it("derives the same category the game does", function()
      Test.ensureDB()
      local row = rawRow(DS.craftable)
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

      local copy = ZO_ShallowTableCopy(rawRow(DS.luxItem))
      assert.is_nil(rawget(copy, "furnCategory"))
      assert.is_nil(copy.furnCategory)

      local described = api.GetItemDescription(DS.luxItem, copy, true)
      assert.equals("string", type(described))
      assert.is_true(#described > 0)
      assert.equals(api.GetItemDescription(DS.luxItem, api.GetEntry(DS.luxItem), true), described)
    end)

    it("hands out a copy carrying only what the row stores", function()
      Test.ensureDB()
      local entry = api.GetEntry(DS.craftable)
      -- game answers the categories, and ranked records answer which source is "best"
      assert.is_nil(rawget(entry, "origin"))
      assert.is_nil(rawget(entry, "furnCategory"))
      assert.equals(DS.craftable, entry.id)
      assert.equals("number", type(entry.version))
    end)

    it("carries no marker field, and every source it names has a record", function()
      Test.ensureDB()
      local checked = 0
      for id, row in pairs(FurC.DB) do
        if type(id) == "number" and type(row) == "table" then
          assert.is_nil(rawget(row, "compatSources"), id .. " still carries a compat marker")
          if checked < 200 then
            local named, described = {}, {}
            for source in eachSource(rawget(row, "sources")) do
              named[source] = true
            end
            for _, record in ipairs(api.GetSourceDetails(id)) do
              described[record.source.type] = true
            end
            assert.same(named, described)
            checked = checked + 1
          end
        end
      end
      assert.is_true(checked > 0)
    end)
  end)
end)
