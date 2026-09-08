-- FurC.RecipeSources data contract: rows are records of ids, never rendered text

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local constants = LFC.Internal.Constants
  local query = LFC.Internal.Query

  -- A vocabulary value is whatever the Ids table holds: an integer in game, a
  -- string under ESOLua, which defines the SI_* globals as their own text. So
  -- the contract is membership in the vocabulary, never the Lua type.
  local function isFrom(idTable, value)
    for _, id in pairs(idTable) do
      if id == value then
        return true
      end
    end
    return false
  end

  local function rowsByShape()
    local vendorRows, questRows = {}, {}
    for itemId, row in pairs(FurC.RecipeSources) do
      if type(row) ~= "table" then -- reported by the first test
      elseif row.quest then
        questRows[itemId] = row
      else
        vendorRows[itemId] = row
      end
    end
    return vendorRows, questRows
  end

  describe("FurC.RecipeSources rows", function()
    it("are records, not baked source lines", function()
      local count = 0
      for itemId, row in pairs(FurC.RecipeSources) do
        count = count + 1
        assert.equals("table", type(row), string.format("row %s is %s", itemId, type(row)))
      end
      assert.is_true(count > 0)
    end)

    it("name a vendor from the NPC vocabulary, in a place from a location one", function()
      local vendorRows = rowsByShape()
      assert.is_true(NonContiguousCount(vendorRows) > 0)

      for itemId, row in pairs(vendorRows) do
        local where = string.format("row %s", itemId)
        assert.is_true(isFrom(constants.NpcIds, row.vendor), where .. ": vendor is not an NpcIds value")
        assert.is_true(row.location == nil or row.place == nil, where .. ": has both a zone and a place")
        if row.location ~= nil then
          assert.is_true(isFrom(constants.ZoneIds, row.location), where .. ": location is not a ZoneIds value")
        end
        if row.place ~= nil then
          assert.is_true(isFrom(constants.PlaceIds, row.place), where .. ": place is not a PlaceIds value")
        end
        -- a note is a string id or a literal, never a location
        if row.note ~= nil then
          assert.is_false(isFrom(constants.ZoneIds, row.note), where .. ": note holds a zone id")
        end
        if row.skillLine ~= nil then
          assert.is_true(isFrom(constants.SkillLineIds, row.skillLine), where .. ": skillLine is unknown")
          assert.equals("number", type(row.skillRank), where .. ": skillRank")
        end
        for _, field in ipairs({ "itemPrice", "achievement", "partOf" }) do
          if row[field] ~= nil then
            assert.equals("number", type(row[field]), where .. ": " .. field)
          end
        end
        -- a row that names a source is scanned into the DB, so it needs a version
        if row.source ~= nil then
          assert.is_true(isFrom(constants.ItemSources, row.source), where .. ": source is not an ItemSources value")
          assert.is_true(isFrom(constants.Versioning, row.version), where .. ": source without a version")
        end
      end
    end)

    -- the point of `source`: without it the item carries CRAFTING alone, and
    -- GetRankedSources drops CRAFTING, so nothing tells the player where the
    -- blueprint is sold
    it("put a row's own source on the item it crafts", function()
      local resolveRecipe = LFC.Internal.Build.ResolveRecipe
      local checked = 0
      for recipeId, row in pairs(FurC.RecipeSources) do
        if type(row) == "table" and row.source then
          local itemId = resolveRecipe(recipeId)
          local entry = itemId and LFC.API.GetEntry(itemId)
          assert.equals("table", type(entry), string.format("row %s resolved to no entry", recipeId))
          assert.is_true(
            entry.sources[row.source] == true,
            string.format("row %s: item %s does not carry the row's source", recipeId, itemId)
          )
          -- and it has to reach the ranked list, which is what a player reads;
          -- CRAFTING alone is dropped there, so a row without a source is silent
          local ranked = LFC.Internal.Query.GetRankedSources(itemId, entry, false)
          local rendered
          for _, entryLine in ipairs(ranked) do
            if entryLine.source == row.source then
              rendered = entryLine.text
            end
          end
          -- equality, not "non-empty": an unhandled source falls through to the
          -- "item source unknown, please re-scan" text, which is also non-empty
          assert.equals(
            query.GetRecipeSource(recipeId),
            rendered,
            string.format("row %s: item %s does not render its own row", recipeId, itemId)
          )
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0, "no row names a source")
    end)

    it("give quest rows a list of zones", function()
      local _, questRows = rowsByShape()
      assert.is_true(NonContiguousCount(questRows) > 0)

      for itemId, row in pairs(questRows) do
        local where = string.format("row %s", itemId)
        assert.equals("table", type(row.locations), where .. ": locations")
        assert.is_true(#row.locations > 0, where .. ": no locations")
        for _, zoneId in ipairs(row.locations) do
          assert.is_true(isFrom(constants.ZoneIds, zoneId), where .. ": location is not a ZoneIds value")
        end
      end
    end)

    -- Rendered text is in the client's language, so nothing here pins prose or
    -- formatted numbers - see the thousands-separator defect on the writ-vendor
    -- price test. What is pinned is that the id reached the renderer.
    it("render to a source line naming the resolved vendor", function()
      local vendorRows, questRows = rowsByShape()
      for itemId, row in pairs(vendorRows) do
        local line = query.GetRecipeSource(itemId)
        assert.equals("string", type(line), string.format("row %s rendered %s", itemId, type(line)))
        local vendorName = constants.Resolvers.Npc(row.vendor)
        assert.is_true(
          line:find(vendorName, 1, true) ~= nil,
          string.format("row %s line does not name %s", itemId, vendorName)
        )
      end

      for itemId in pairs(questRows) do
        local line = query.GetRecipeSource(itemId)
        assert.equals("string", type(line))
        assert.is_true(#line > 0, string.format("row %s rendered empty", itemId))
      end
    end)
  end)
end)
