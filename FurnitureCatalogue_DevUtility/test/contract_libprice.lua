-- Check if we're still compatible with ESO-LibPrice

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
    end)

    -- CanFurCPrice just checks if API table exists, so it must be there without waiting for readiness
    it("publishes the API table LibPrice checks", function()
      assert.equals("table", type(LibFurnitureCatalogue.API))
    end)

    -- GetEntry: nil means "not a furnishing", anything else goes on to pricing
    it("GetEntry answers a table for a link and nil on a miss", function()
      local api = LibFurnitureCatalogue.API
      assert.equals("table", type(api.GetEntry(Test.link(DS.luxItem))))
      assert.is_nil(api.GetEntry(Test.link(999999999)))
    end)

    it("GetSourceTypes has the two keys LibPrice branches on", function()
      local types = LibFurnitureCatalogue.API.GetSourceTypes()
      assert.equals("number", type(types.CRAFTING))
      assert.equals("number", type(types.IGNORED))
    end)

    -- LibPrice takes records[1] as the preferred source
    it("source records keep the fields LibPrice reads", function()
      FurC.EnsureDB(true)
      local api = LibFurnitureCatalogue.API
      local function optionalNumber(value)
        return value == nil or type(value) == "number"
      end

      local priced, unpriced, placed = 0, 0, 0
      for id in pairs(FurC.DB) do
        if type(id) == "number" then
          local records = api.GetSourceDetails(Test.link(id))
          assert.equals("table", type(records))
          for _, record in ipairs(records) do
            local source = record.source
            assert.equals("table", type(source))
            assert.equals("number", type(source.type))
            assert.is_true(optionalNumber(source.vendor), "vendor is not a string id on " .. id)
            if source.locations then
              local placement = source.locations[1]
              assert.equals("table", type(placement))
              assert.is_true(optionalNumber(placement.location), "location is not a zone id on " .. id)
              assert.is_true(optionalNumber(placement.place), "place is not a string id on " .. id)
              placed = placed + 1
            end
            if record.cost then
              assert.equals("number", type(record.cost.currency))
              assert.equals("number", type(record.cost.amount))
              priced = priced + 1
            else
              unpriced = unpriced + 1
            end
          end
        end
        if priced > 0 and unpriced > 0 and placed > 0 then
          break
        end
      end
      -- every branch was exercised, or the assertions above proved nothing
      assert.is_true(priced > 0)
      assert.is_true(unpriced > 0)
      assert.is_true(placed > 0)
      assert.same({}, api.GetSourceDetails(Test.link(999999999)))
    end)

    -- the crafting branch passes the GetEntry result as the second argument and sums the map.
    -- Quantities come from the game's recipe data, so the map is empty headless and filled in-game
    it("GetIngredients takes the entry and answers link -> quantity", function()
      local api = LibFurnitureCatalogue.API
      local link = Test.link(DS.craftable)
      local ingredients = api.GetIngredients(link, api.GetEntry(link))
      assert.equals("table", type(ingredients))
      for ingredientLink, quantity in pairs(ingredients) do
        assert.equals("string", type(ingredientLink))
        assert.equals("number", type(quantity))
        assert.is_true(quantity >= 1)
      end
    end)

    -- only runs where the real library is installed
    it("LibPrice prices furnishings without erroring", function()
      if not (LibPrice and LibPrice.FurCPrice) then
        return
      end
      for _, id in ipairs({ DS.luxItem, DS.craftable }) do
        local link = Test.link(id)
        local ok, result = pcall(LibPrice.FurCPrice, link)
        assert.is_true(ok, "LibPrice.FurCPrice raised: " .. tostring(result))
        assert.equals("table", type(result), "LibPrice found no FurC price for " .. id)
        local pricedOk, gold = pcall(LibPrice.ItemLinkToPriceGold, link)
        assert.is_true(pricedOk, "LibPrice.ItemLinkToPriceGold raised: " .. tostring(gold))
      end
    end)
  end)
end)
