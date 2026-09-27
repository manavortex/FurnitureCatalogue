if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local api = LibFurnitureCatalogue.API
  local src = api.GetSourceTypes()

  describe("blueprint acquisition records", function()
    it("resolve each confirmed blueprint to its furnishing", function()
      local checked = 0
      for _, id in ipairs(api.GetItemIds()) do
        local entry = api.GetEntry(id)
        if entry.blueprint and not entry.sources[src.RUMOUR] then
          assert.equals(id, api.GetEntry(entry.blueprint).id)
          assert.is_true(entry.sources[src.CRAFTING])
          assert.same(api.GetSourceDetails(id), api.GetSourceDetails(entry.blueprint))
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0)
    end)

    it("keep vendor and quest details on crafting records", function()
      local vendors, quests = 0, 0
      for _, id in ipairs(api.GetItemIds()) do
        local entry = api.GetEntry(id)
        if entry.blueprint then
          for _, record in ipairs(api.GetSourceDetails(id)) do
            local source = record.source
            if source.type == src.CRAFTING and (source.vendor or source.quest) then
              local text = LibFurnitureCatalogue.Internal.Query.RenderRecord(record)
              assert.equals("string", type(text))
              assert.is_true(#text > 0)
              assert.is_not_nil(source.locations)
              if source.vendor then
                vendors = vendors + 1
                assert.is_not_nil(
                  text:find(LibFurnitureCatalogue.Internal.Constants.Resolvers.Npc(source.vendor), 1, true)
                )
              else
                quests = quests + 1
              end
            end
          end
        end
      end
      assert.is_true(vendors > 0)
      assert.is_true(quests > 0)
    end)

    it("sell a folio blueprint only through its folio", function()
      local records = api.GetSourceDetails(139091)
      local counts = {}
      for _, record in ipairs(records) do
        local source = record.source
        if source.type == src.ROLIS or source.type == src.CRAFTING then
          counts[source.type] = (counts[source.type] or 0) + 1
          assert.is_not_nil(source.partOf)
          assert.is_not_nil(record.cost)
          assert.equals(CURT_WRIT_VOUCHERS, record.cost.currency)
        end
      end
      assert.equals(1, counts[src.ROLIS])
      assert.equals(1, counts[src.CRAFTING])
    end)
  end)
end)
