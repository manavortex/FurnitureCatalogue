-- FurC.Lib LCK

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  -- Minimal fake matching LCK API that FurC.Lib uses
  local function makeFakeLCK(knowledgeById, listById)
    return {
      KNOWLEDGE_INVALID = -1,
      KNOWLEDGE_NODATA = 0,
      KNOWLEDGE_KNOWN = 1,
      KNOWLEDGE_UNKNOWN = 2,
      EVENT_UPDATE_REFRESH = 2,
      RegisterForCallback = function() end,
      GetItemKnowledgeForCharacter = function(item)
        return knowledgeById[item] or 0 -- default NODATA
      end,
      GetItemKnowledgeList = function(item)
        return listById[item] or {}
      end,
    }
  end

  describe("FurC.Lib LCK seam", function()
    it("passes everything when LCK is absent", function()
      FurC.Lib.InitLCK(nil)
      assert.is_false(FurC.Lib.LCKAvailable())
      assert.is_true(FurC.Lib.CharKnows(12345))
      assert.is_true(FurC.Lib.AccountKnows(12345))
    end)

    it("respects current-character knowledge when LCK is present", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        [111] = 1, -- KNOWN
        [222] = 2, -- UNKNOWN
        [333] = 0, -- NODATA -> pass
      }, {}))
      assert.is_true(FurC.Lib.LCKAvailable())
      assert.is_true(FurC.Lib.CharKnows(111))
      assert.is_false(FurC.Lib.CharKnows(222))
      assert.is_true(FurC.Lib.CharKnows(333))
      FurC.Lib.InitLCK(nil) -- reset module state for following tests
    end)

    it("AccountKnows true if any tracked character knows it", function()
      FurC.Lib.InitLCK(makeFakeLCK({}, {
        [111] = { { knowledge = 2 }, { knowledge = 1 } }, -- one char knows
        [222] = { { knowledge = 2 }, { knowledge = 2 } }, -- nobody knows
      }))
      assert.is_true(FurC.Lib.AccountKnows(111))
      assert.is_false(FurC.Lib.AccountKnows(222))
      FurC.Lib.InitLCK(nil)
    end)
  end)
end)
