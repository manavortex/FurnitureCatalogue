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
      assert.is_true(Test.dbSize() > 0)
      assert.is_not_nil(DS.dbItem)
      assert.is_not_nil(DS.craftable)
      assert.is_not_nil(DS.luxItem)
      assert.is_not_nil(DS.rolisItem)
    end)

    it("FurC global exists", function()
      assert.equals("table", type(FurC))
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
