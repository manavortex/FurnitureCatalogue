-- Lib namespace contents: each internal namespace publishes only its own symbols
-- Runs in game too, it only reads live tables

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  describe("lib namespaces", function()
    it("lib internal namespaces carry only their own symbols", function()
      local internal = LibFurnitureCatalogue.Internal
      assert.same(
        FurCDev.Test.nameSet({
          -- the per-source renderers are gone: one renderer now reads the published records
          "DescribeSource",
          "Find",
          "FindWithKey",
          "GetCraftingSkillType",
          "GetIngredients",
          "GetItemDescription",
          "GetMats",
          "GetMiscItemPrice",
          "GetRankedSources",
          "GetSourceRecords",
          "OriginOf",
          "RenderRecord",
          "ResolveRecipe",
        }),
        FurCDev.Test.keySet(internal.Query)
      )
      assert.same(
        FurCDev.Test.nameSet({
          "ClearLinkCache",
          "Colourise",
          "FormatPrice",
          "GetItemId",
          "GetItemLink",
          "GetItemName",
          "STRIP_CONTROL",
          "stripTxt",
        }),
        FurCDev.Test.keySet(internal.Format)
      )
    end)
  end)
end)
