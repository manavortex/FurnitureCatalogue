-- Lib namespace contents: each internal namespace publishes only its own symbols
-- Runs in game too, it only reads live tables

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("lib namespaces", function()
    it("lib internal namespaces carry only their own symbols", function()
      local internal = LibFurnitureCatalogue.Internal
      assert.same({
        "DescribeSource",
        "Find",
        "GetAchievementVendorSource",
        "GetCraftingSkillType",
        "GetEventDropSource",
        "GetIngredients",
        "GetItemDescription",
        "GetLuxurySource",
        "GetMats",
        "GetMiscItemPrice",
        "GetMiscItemSource",
        "GetPvpSource",
        "GetRankedSources",
        "GetRecipeSource",
        "GetRolisSource",
        "GetRumourSource",
        "GetSourceRecords",
        "ResolveRecipe",
      }, FurCDev.Test.sortedKeys(internal.Query))
      assert.same({
        "ClearLinkCache",
        "Colourise",
        "FmtCrownCrate",
        "FmtDungeon",
        "FmtGeneric",
        "FmtQuest",
        "FmtRank",
        "FmtScrying",
        "FmtSources",
        "FormatAchievement",
        "FormatEvent",
        "FormatFurnisher",
        "FormatHouses",
        "FormatPartOf",
        "FormatPieces",
        "FormatPrice",
        "GetItemId",
        "GetItemLink",
        "GetItemName",
        "JoinSources",
        "MergeTable",
        "STRIP_CONTROL",
        "SourceSeparator",
        "SplitFirstSource",
        "stripTxt",
      }, FurCDev.Test.sortedKeys(internal.Format))
    end)
  end)
end)
