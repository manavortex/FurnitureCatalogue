-- LibFurnitureCatalogue.API v1 contract: endpoint + return shapes

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local api = LibFurnitureCatalogue.API

  describe("LibFurnitureCatalogue.API v1 contract", function()
    local UNKNOWN_ID = 99123456

    it("metadata endpoints report sane values", function()
      FurC.EnsureDB(true)
      assert.equals("number", type(api.GetVersion()))
      assert.equals("number", type(api.GetDBRevision()))
      assert.is_true(api.IsReady())
      assert.is_true(api.GetEntryCount() > 0)
    end)

    it("GetEntry returns a snapshot, nil on miss", function()
      FurC.EnsureDB(true)
      assert.is_nil(api.GetEntry(UNKNOWN_ID))
      assert.is_false(api.Has(UNKNOWN_ID))

      local ids = api.GetItemIds()
      assert.equals(api.GetEntryCount(), #ids)
      local id = ids[1]
      assert.is_true(api.Has(id))
      local entry = api.GetEntry(id)
      assert.equals("table", type(entry))
      assert.is_false(rawequal(entry, FurC.DB[id])) -- copy, not the live reference
      assert.equals("table", type(entry.sources))
    end)

    it("GetSources returns ranked schema-shaped records", function()
      FurC.EnsureDB(true)
      local srcEnum = FurC.Constants.ItemSources

      -- luxury items produce fully populated records
      local luxId
      for _, versionData in pairs(FurC.LuxuryFurnisher) do
        for itemId in pairs(versionData) do
          if FurC.DB[itemId] then
            luxId = itemId
            break
          end
        end
        if luxId then
          break
        end
      end
      assert.is_not_nil(luxId)

      local records = api.GetSources(luxId)
      assert.is_true(#records > 0)
      for _, rec in ipairs(records) do
        assert.equals("number", type(rec.source.type))
        assert.equals("table", type(rec.cost))
        assert.equals("table", type(rec.availability))
        assert.equals("number", type(rec.availability.version))
      end

      local lux
      for _, rec in ipairs(records) do
        if rec.source.type == srcEnum.LUXURY then
          lux = rec
        end
      end
      assert.is_not_nil(lux)
      assert.equals("string", type(lux.source.vendor))
      assert.equals("string", type(lux.source.location))
      assert.equals("number", type(lux.cost[1].amount))
      assert.equals(CURT_MONEY, lux.cost[1].currency)

      assert.same({}, api.GetSources(UNKNOWN_ID))
    end)
  end)
end)
