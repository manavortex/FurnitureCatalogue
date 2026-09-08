-- Check if we're still compatible with ESO-LibPrice
-- we need some stuff from the DB here

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local Test = FurCDev.Test
  local DS = Test.dataset()

  describe("contract: ESO-LibPrice", function()
    it("builds DB from data set", function()
      assert.is_not_nil(DS.dbItem)
      assert.is_not_nil(DS.craftable)
      assert.is_not_nil(DS.luxItem)
      assert.is_not_nil(DS.rolisItem)
    end)

    it("GetItemId passes ids and parses them from links", function()
      assert.equals(DS.dbItem, FurC.GetItemId(DS.dbItem))
      assert.equals(DS.dbItem, FurC.GetItemId(Test.link(DS.dbItem)))
    end)

    -- LibPrice calls deprecated FurC.GetItemLink, just alias now but have to keep it
    it("FurC.GetItemLink alias exists", function()
      assert.is_not_nil(FurC.GetItemLink)
      if type(FurC.GetItemLink) == "function" then
        local link = FurC.GetItemLink(DS.dbItem)
        assert.equals("string", type(link))
        assert.is_true(#link > 0)
      end
    end)

    it("Find returns table with origin on hit or empty on miss", function()
      local hit = FurC.Find(DS.luxItem)
      assert.equals("table", type(hit))
      assert.is_not_nil(hit.origin)
      local miss = FurC.Find(Test.link(999999999))
      assert.equals("table", type(miss))
      assert.is_nil(next(miss))
    end)

    it("GetItemDescription returns string", function()
      local arr = FurC.Find(DS.luxItem)
      assert.equals("string", type(FurC.GetItemDescription(DS.luxItem, arr)))
    end)

    -- Direct index access like this might turn into an issue for LibPrice if we change DB or globals.
    -- But have to support it for now.

    it("raw data tables exist and can be queried by version", function()
      for _, name in ipairs({
        "Rolis",
        "Faustina",
        "LuxuryFurnisher",
        "AchievementVendors",
        "PVP",
        "MiscItemSources",
      }) do
        assert.equals("table", type(FurC[name]))
      end
      assert.equals("table", type(FurC.LuxuryFurnisher[DS.luxVersion]))
      assert.is_not_nil(FurC.LuxuryFurnisher[DS.luxVersion][DS.luxItem])
    end)

    -- LibPrice.FurCPrice reads the enum as a FIELD and calls the OLD endpoint name,
    -- then indexes cost[1] on whichever record matches the entry's origin without
    -- checking cost first. Both names live in the deprecated block for exactly this
    -- consumer, so a cleanup pass that drops either one breaks furniture pricing.
    it("LibPrice reaches the enum and the old endpoint the way it actually calls them", function()
      FurC.EnsureDB(true)
      local api = LibFurnitureCatalogue.API

      -- a table on the API, not the function that returns one
      assert.equals("table", type(api.SourceType))
      for _, key in ipairs({ "CRAFTING", "RUMOUR", "FESTIVAL_DROP" }) do
        assert.equals("number", type(api.SourceType[key]))
        assert.equals(api.GetSourceTypes()[key], api.SourceType[key])
      end

      -- takes an item link, and a miss must stay safe to walk with ipairs
      assert.equals("table", type(api.GetSources(Test.link(DS.luxItemInDB))))
      assert.same({}, api.GetSources(Test.link(999999999)))

      -- cost is a LIST here and is never nil, so cost[1] is nil rather than an
      -- index-nil error on a source that has no price. GetSourceDetails is the
      -- other shape: cost is the record itself, absent when there is no price.
      local priced, unpriced = 0, 0
      for id in pairs(FurC.DB) do
        if type(id) == "number" then
          local details, bridged = api.GetSourceDetails(id), api.GetSources(id)
          assert.equals(#details, #bridged)
          for i, record in ipairs(bridged) do
            assert.equals("table", type(record.cost))
            if details[i].cost then
              assert.same(details[i].cost, record.cost[1])
              priced = priced + 1
            else
              assert.is_nil(record.cost[1])
              unpriced = unpriced + 1
            end
          end
        end
        if priced > 0 and unpriced > 0 then
          break
        end
      end
      -- both branches were exercised, or the assertions above proved nothing
      assert.is_true(priced > 0)
      assert.is_true(unpriced > 0)
    end)

    it("source globals are ints", function()
      for _, k in ipairs({
        "FURC_CRAFTING",
        "FURC_VENDOR",
        "FURC_PVP",
        "FURC_CROWN",
        "FURC_LUXURY",
        "FURC_ROLIS",
        "FURC_DROP",
        "FURC_JUSTICE",
        "FURC_RUMOUR",
        "FURC_FESTIVAL_DROP",
      }) do
        assert.equals("number", type(_G[k]))
      end
    end)
  end)
end)
