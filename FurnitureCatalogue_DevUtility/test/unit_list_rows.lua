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
        for _, record in ipairs(api.GetSourceDetails(itemId)) do
          if record.source.type == src.CRAFTING then
            crafted = true
          else
            other = true
          end
        end
        if crafted and not other and row.origin == src.CRAFTING then
          picks.craftOnly = picks.craftOnly or itemId
        elseif crafted and other and row.origin ~= src.CRAFTING and row.origin ~= src.WRIT_VENDOR then
          picks.alsoSold = picks.alsoSold or itemId
        end
      end
      if picks.craftOnly and picks.alsoSold then
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
    it("carry the origin a copy of the stored row cannot", function()
      local itemId = picked().craftOnly
      assert.is_not_nil(itemId)

      -- the defect, pinned: a plain copy of the row has no origin at all
      assert.is_nil(ZO_ShallowTableCopy(FurC.DB[itemId]).origin)
      assert.equals(FurC.DB[itemId].origin, displayRow(itemId).origin)

      -- the contrast, and why only origin is restated: blueprint is stored, so
      -- the copy already carries it
      assert.is_not_nil(FurC.DB[itemId].blueprint)
      assert.equals(FurC.DB[itemId].blueprint, ZO_ShallowTableCopy(FurC.DB[itemId]).blueprint)
      assert.equals(FurC.DB[itemId].blueprint, displayRow(itemId).blueprint)
    end)

    it("describe a craft-only furnishing with its material list", function()
      local itemId = picked().craftOnly
      assert.is_not_nil(itemId)
      local row = displayRow(itemId)

      withIngredients(function()
        local described = format.FormatDescription(itemId, row)
        assert.are_not.equals("", described)
        assert.equals(format.CraftingLine(itemId, row, false), described)

        -- and the copy the list used to build describes as nothing at all
        assert.equals("", format.FormatDescription(itemId, ZO_ShallowTableCopy(FurC.DB[itemId])))
      end)
    end)

    it("describe a craftable that ranks another source with that source's line", function()
      local itemId = picked().alsoSold
      if not itemId then
        return -- no such item in this data set
      end
      local row = displayRow(itemId)

      local expected
      for _, line in ipairs(format.FormatItem(itemId, row)) do
        if line.source == row.origin then
          expected = line.text
        end
      end
      assert.is_not_nil(expected)
      assert.equals(expected, format.FormatDescription(itemId, row))
    end)
  end)
end)
