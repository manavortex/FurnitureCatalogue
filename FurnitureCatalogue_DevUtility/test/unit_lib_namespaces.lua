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
          "DescribeSource",
          "Find",
          "FindWithKey",
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
          "OriginOf",
          "ResolveRecipe",
        }),
        FurCDev.Test.keySet(internal.Query)
      )
      assert.same(
        FurCDev.Test.nameSet({
          "ClearLinkCache",
          "Colourise",
          "FmtCrownCrate",
          "FmtDungeon",
          "FmtGeneric",
          "FmtQuest",
          "FmtQuestReq",
          "FmtRank",
          "FmtScrying",
          "FmtSources",
          "FormatAchievement",
          "FormatCollectible",
          "FormatEvent",
          "FormatFurnisher",
          "FormatHouses",
          "FormatItemBundle",
          "FormatItemPack",
          "FormatPartOf",
          "FormatPrice",
          "GetItemId",
          "GetItemLink",
          "GetItemName",
          "JoinSources",
          "MergeTable",
          "STRIP_CONTROL",
          "stripTxt",
        }),
        FurCDev.Test.keySet(internal.Format)
      )
    end)
  end)
end)
