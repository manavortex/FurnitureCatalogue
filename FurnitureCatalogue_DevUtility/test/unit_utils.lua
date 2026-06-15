-- FurnitureCatalogue_DevUtility
--
-- Unit tests for FurC.Utils helpers
-- Function tests, no DB or game state needed

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("unit: FurC.Utils.MergeTable", function()
    local MergeTable = FurC.Utils.MergeTable

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

  describe("unit: FurC.Utils.IsFurniture", function()
    local IsFurniture = FurC.Utils.IsFurniture

    -- ingame this uses ESO link API
    -- headless it runs stub
    local furniture = {
      "|H0:item:126559:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
      "|H0:item:147647:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
      "|H0:item:118206:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h",
    }

    for i = 1, #furniture do
      it("recognises furnishing link #" .. i, function()
        assert.is_true(IsFurniture(furniture[i]))
      end)
    end
  end)
end)
