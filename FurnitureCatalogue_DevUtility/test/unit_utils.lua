-- FurnitureCatalogue_DevUtility
--
-- Unit tests for FurC.Utils helpers
-- Function tests, no DB or game state needed

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("unit: LFC.Internal.MergeTable", function()
    -- not a formatter, so it sits on Internal rather than on Internal.Format
    local MergeTable = LibFurnitureCatalogue.Internal.MergeTable

    it("overlapping keys: t2 wins", function()
      local result = MergeTable({ a = "1", b = "3" }, { b = "2" })
      assert.equals("1", result.a)
      assert.equals("2", result.b)
    end)

    it("merging t1 with empty keeps t1", function()
      local result = MergeTable({ a = "1", b = "3" }, {})
      assert.equals("1", result.a)
      assert.equals("3", result.b)
    end)

    it("merging empty with empty yields empty", function()
      assert.is_nil(next(MergeTable({}, {})))
    end)
  end)

  -- FC uses its own formatting helpers now
  describe("unit: FurC.SourceFormat string helpers", function()
    local strip = FurC.SourceFormat.Strip
    local libStrip = LibFurnitureCatalogue.Internal.Format.stripTxt

    local SAMPLES = {
      "|c72DB00Rolis Hlaalu|r : |cCF6D00any capital city|r",
      "|cffd7001,100|r|u0:6%:currency:|u|t16:16:EsoUI/Art/currency/currency_gold.dds|t",
      "|H1:item:134686:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h plain text",
      "Summerset^N,in",
      "",
    }

    it("strips exactly what the library's copy strips", function()
      for _, sample in ipairs(SAMPLES) do
        assert.equals(libStrip(sample), strip(sample), sample)
        assert.equals(libStrip(sample, FurC.SourceFormat.STRIP_CONTROL), strip(sample, FurC.SourceFormat.STRIP_CONTROL))
      end
    end)

    it("keeps an item link and drops the markup a chat input cannot show", function()
      local stripped = strip(SAMPLES[3])
      assert.is_true(stripped:find("|H", 1, true) ~= nil)
      local coloured = strip(SAMPLES[1])
      assert.is_nil(coloured:find("|c", 1, true))
      assert.is_nil(coloured:find("|r", 1, true))
      local priced = strip(SAMPLES[2])
      assert.is_nil(priced:find("|u", 1, true))
      assert.is_nil(priced:find("|t", 1, true))
    end)

    it("drops the grammar suffix under the control pattern, and only then", function()
      assert.equals("Summerset", strip("Summerset^N,in", FurC.SourceFormat.STRIP_CONTROL))
      assert.equals("Summerset^N,in", strip("Summerset^N,in"))
    end)

    it("answers for nothing at all, where the library's copy raises", function()
      assert.equals("", strip(nil))
      assert.equals("", strip(""))
    end)
  end)

  describe("unit: FurC.Utils.IsFurniture", function()
    local IsFurniture = FurC.Utils.IsFurniture

    -- ingame this uses ESO link API
    -- headless it runs stub
    local furniture = {
      "|H0:item:126559:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
      "|H0:item:147647:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
      "|H0:item:118206:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
    }

    it("recognises furnishing links", function()
      for i = 1, #furniture do
        assert.is_true(IsFurniture(furniture[i]))
      end
    end)
  end)
end)
