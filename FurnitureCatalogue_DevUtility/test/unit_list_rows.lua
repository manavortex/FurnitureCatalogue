-- The item list's row: what the list hands the formatter.

if not Taneth then
  return
end

local GLOBALS = _G

Taneth("FurC:Unit", function()
  local api = LibFurnitureCatalogue.API
  local src = api.GetSourceTypes()
  local format = FurC.SourceFormat
  local Test = FurCDev.Test

  ---Two craftable examples: one that can only be crafted, and one that is craftable but ranks another source first
  local picks
  local function picked()
    if picks then
      return picks
    end
    Test.ensureDB()
    picks = {}
    for itemId, row in pairs(FurC.DB) do
      if type(itemId) == "number" and type(row) == "table" then
        local crafted, other = false, false
        local types, numTypes = {}, 0
        for _, record in ipairs(api.GetSourceDetails(itemId)) do
          if record.source.type == src.CRAFTING then
            crafted = true
          else
            other = true
            if not types[record.source.type] then
              types[record.source.type], numTypes = true, numTypes + 1
            end
          end
        end
        if numTypes >= 2 then
          picks.multiSource = picks.multiSource or itemId
        end
        if crafted and not other then
          picks.craftOnly = picks.craftOnly or itemId
        elseif crafted and other then
          picks.alsoSold = picks.alsoSold or itemId
        end
      end
      if picks.craftOnly and picks.alsoSold and picks.multiSource then
        break
      end
    end
    return picks
  end

  local function displayRow(itemId)
    return FurC.BuildDisplayRow(itemId, FurC.DB[itemId], api.GetItemLink(itemId))
  end

  ---We don't see ingredients headless, so a material list is empty here unless a recipe is fed in
  ---@param run fun()
  local function withIngredients(run)
    local function ingredientLink(index)
      return string.format("|H0:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", 4000 + index)
    end
    local stubs = {
      GetItemLinkRecipeNumIngredients = function()
        return 2
      end,
      GetItemLinkRecipeIngredientInfo = function(_, index)
        return "ingredient " .. index, 0, index
      end,
      GetItemLinkRecipeIngredientItemLink = function(_, index)
        return ingredientLink(index)
      end,
      GetRecipeInfo = function()
        return true, "recipe", 2
      end,
      GetRecipeIngredientItemInfo = function(_, _, index)
        return "ingredient " .. index, 0, index
      end,
      GetRecipeIngredientItemLink = function(_, _, index)
        return ingredientLink(index)
      end,
    }
    local saved = {}
    for name, stub in pairs(stubs) do
      saved[name], GLOBALS[name] = GLOBALS[name], stub
    end
    local ok, err = pcall(run)
    for name, original in pairs(saved) do
      GLOBALS[name] = original
    end
    -- Taneth's assertions take no message, so the failure has to be the compared value
    assert.equals("", (ok and "") or tostring(err))
  end

  describe("item list rows", function()
    -- the row carries only what it stores and a plain copy describes the same
    it("carry only stored fields, and describe the same as the row they copy", function()
      local itemId = picked().craftOnly
      assert.is_not_nil(itemId)

      local row = displayRow(itemId)
      assert.is_nil(rawget(row, "origin"))
      assert.is_not_nil(FurC.DB[itemId].blueprint)
      assert.equals(FurC.DB[itemId].blueprint, row.blueprint)

      withIngredients(function()
        assert.equals(
          format.FormatDescription(itemId, row),
          format.FormatDescription(itemId, ZO_ShallowTableCopy(FurC.DB[itemId]))
        )
      end)
    end)

    it("describe a craft-only furnishing with its material list", function()
      local itemId = picked().craftOnly
      assert.is_not_nil(itemId)
      local row = displayRow(itemId)

      withIngredients(function()
        local described = format.FormatDescription(itemId, row)
        assert.are_not.equals("", described)
        assert.equals(format.CraftingLine(itemId, row, false), described)

        -- the copy the list builds from describes identically: nothing derived is needed
        assert.equals(described, format.FormatDescription(itemId, ZO_ShallowTableCopy(FurC.DB[itemId])))
      end)
    end)

    it("describe a craftable that ranks another source with that source's line", function()
      local itemId = picked().alsoSold
      if not itemId then
        return -- no such item in this data set
      end
      local row = displayRow(itemId)

      -- the best-ranked line describes the item; nothing consults a derived origin to find it
      local ranked = format.FormatItem(itemId, row, nil, true)
      assert.is_true(#ranked > 0)
      assert.equals(ranked[1].text, format.FormatDescription(itemId, row))
    end)

    -- the window shows every source, not only the best one
    it("list every source of a multi-source item, the selected source first", function()
      local itemId = picked().multiSource
      if not itemId then
        return
      end
      local row = displayRow(itemId)
      local ranked = format.FormatItem(itemId, row, nil, true)
      local text = format.FormatListText(itemId, row)
      local lastSource
      for _, line in ipairs(ranked) do
        if line.source ~= src.CRAFTING then
          assert.is_true(text:find(line.text, 1, true) ~= nil)
          lastSource = line
        end
      end

      local preferred = format.FormatListText(itemId, row, nil, { [lastSource.source] = true })
      assert.equals(1, (preferred:find(lastSource.text, 1, true)))
    end)

    it("read a parent Source tab as every record type below it", function()
      local saved = FurC.DropdownChoices["Source"]
      FurC.DropdownChoices["Source"] = src.VENDOR
      local types = FurC.GetSelectedSourceTypes()
      FurC.DropdownChoices["Source"] = src.NONE
      local none = FurC.GetSelectedSourceTypes()
      FurC.DropdownChoices["Source"] = saved
      for _, type_ in ipairs({ src.VENDOR, src.ACHIEVEMENT, src.HOME_GOODS, src.LUXURY }) do
        assert.is_true(types[type_] == true)
      end
      assert.is_nil(types[FurC.SourceFilters.ACHIEVEMENT])
      assert.is_nil(next(none))
    end)

    it("show a material list only when nothing else describes the item", function()
      local p = picked()
      withIngredients(function()
        local craftOnly = displayRow(p.craftOnly)
        assert.equals(format.FormatMaterials(p.craftOnly, craftOnly), format.FormatListText(p.craftOnly, craftOnly))
        if p.alsoSold then
          local row = displayRow(p.alsoSold)
          local text = format.FormatListText(p.alsoSold, row)
          assert.is_nil(text:find(format.FormatMaterials(p.alsoSold, row), 1, true))
        end
      end)
    end)
  end)
end)
