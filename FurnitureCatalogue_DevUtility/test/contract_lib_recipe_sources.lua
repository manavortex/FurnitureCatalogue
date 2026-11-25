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

  -- An item the game knows never disappears: without a blueprint or a source it is still a rumour
  describe("rumours and blueprints this client does not have", function()
    local lib = LibFurnitureCatalogue
    local build, data = lib.Internal.Build, LFCGeneratedDatabase

    -- rebuild while this client lacks the given blueprints, then rebuild the real catalogue
    local function withoutBlueprints(dead, check)
      local real = build.ResolveRecipe
      build.ResolveRecipe = function(id)
        if dead[id] then
          return nil, nil
        end
        return real(id)
      end
      local ok, err = pcall(function()
        FurC.RebuildDB(true)
        check()
      end)
      build.ResolveRecipe = real
      FurC.RebuildDB(true)
      if not ok then
        error(err, 0)
      end
    end

    local rumourBlueprint, rumourFurnishing
    for blueprint in pairs(data.rumours) do
      local furnishing = data.blueprints[blueprint]
      if furnishing and furnishing ~= 0 then
        rumourBlueprint, rumourFurnishing = blueprint, furnishing
        break
      end
    end

    it("list a rumour recipe under its furnishing, with the blueprint", function()
      assert.is_not_nil(rumourBlueprint)
      local entry = api.GetEntry(rumourFurnishing)
      assert.is_true(entry.sources[src.RUMOUR])
      assert.equals(rumourBlueprint, entry.blueprint)
      assert.equals(rumourFurnishing, api.GetEntry(rumourBlueprint).id)
      assert.is_nil(lib.Internal.DB[rumourBlueprint])
    end)

    it("keep a rumour furnishing when its blueprint points at nothing", function()
      withoutBlueprints({ [rumourBlueprint] = true }, function()
        local entry = api.GetEntry(rumourFurnishing)
        assert.is_not_nil(entry)
        assert.is_true(entry.sources[src.RUMOUR])
        assert.is_nil(entry.blueprint)
        assert.is_nil(lib.Internal.DB[rumourBlueprint])
      end)
    end)

    it("keep a crafted item whose blueprint this client lacks, as a rumour if nothing else is left", function()
      local crafted, blueprint
      for _, id in ipairs(api.GetItemIds()) do
        local entry = api.GetEntry(id)
        if entry.blueprint and entry.sources[src.CRAFTING] and next(entry.sources, next(entry.sources)) == nil then
          crafted, blueprint = id, entry.blueprint
          break
        end
      end
      assert.is_not_nil(crafted)
      withoutBlueprints({ [blueprint] = true }, function()
        local entry = api.GetEntry(crafted)
        assert.is_not_nil(entry)
        assert.is_true(entry.sources[src.RUMOUR])
        assert.is_nil(entry.blueprint)
      end)
    end)

    it("keep a rumour that names only a blueprint", function()
      local orphan = 999001
      data.rumours[orphan], data.blueprints[orphan] = data.rumours[rumourBlueprint], 0
      local ok, err = pcall(function()
        FurC.RebuildDB(true)
        assert.is_true(lib.Internal.DB[orphan].sources ~= nil)
      end)
      data.rumours[orphan], data.blueprints[orphan] = nil, nil
      FurC.RebuildDB(true)
      if not ok then
        error(err, 0)
      end
    end)
  end)
end)
