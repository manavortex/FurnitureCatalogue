-- FurC.Lib LCK

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local function makeFakeLCK(cfg)
    cfg = cfg or {}
    local callbacks = {}
    return {
      KNOWLEDGE_INVALID = -1,
      KNOWLEDGE_NODATA = 0,
      KNOWLEDGE_KNOWN = 1,
      KNOWLEDGE_UNKNOWN = 2,
      EVENT_INITIALIZED = 1,
      EVENT_UPDATE_REFRESH = 2,
      RegisterForCallback = function(_, eventCode, callback)
        callbacks[eventCode] = callbacks[eventCode] or {}
        table.insert(callbacks[eventCode], callback)
      end,
      fire = function(eventCode)
        for _, cb in ipairs(callbacks[eventCode] or {}) do
          cb()
        end
      end,
      GetServerList = function()
        return { "EU" }
      end,
      GetCharacterList = function()
        return cfg.roster or {}
      end,
      GetItemKnowledgeForCharacter = function(item, server, charId)
        local byChar = charId and cfg.byChar and cfg.byChar[charId]
        if byChar and byChar[item] ~= nil then
          return byChar[item]
        end
        return (cfg.knowledge and cfg.knowledge[item]) or 0 -- default NODATA
      end,
      GetItemKnowledgeList = function(item)
        return (cfg.list and cfg.list[item]) or {}
      end,
    }
  end

  describe("FurC.Lib LCK seam", function()
    it("passes everything when LCK is absent", function()
      FurC.Lib.InitLCK(nil)
      assert.is_false(FurC.Lib.LCKAvailable())
      assert.is_true(FurC.Lib.CharKnows(12345))
      assert.is_true(FurC.Lib.AccountKnows(12345))
      assert.is_nil(FurC.Lib.IsKnownByName(12345, nil))
      assert.is_nil(FurC.Lib.GetCrafterNames(12345))
      assert.same({}, FurC.Lib.GetCharacterNames())
    end)

    it("respects current-character knowledge when LCK is present", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        knowledge = {
          [111] = 1, -- KNOWN
          [222] = 2, -- UNKNOWN
          [333] = 0, -- NODATA -> pass
        },
      }))
      assert.is_true(FurC.Lib.LCKAvailable())
      assert.is_true(FurC.Lib.CharKnows(111))
      assert.is_false(FurC.Lib.CharKnows(222))
      assert.is_true(FurC.Lib.CharKnows(333))
      FurC.Lib.InitLCK(nil)
    end)

    it("AccountKnows true if any tracked character knows it", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        list = {
          [111] = { { knowledge = 2 }, { knowledge = 1 } }, -- one char knows
          [222] = { { knowledge = 2 }, { knowledge = 2 } }, -- nobody knows
        },
      }))
      assert.is_true(FurC.Lib.AccountKnows(111))
      assert.is_false(FurC.Lib.AccountKnows(222))
      FurC.Lib.InitLCK(nil)
    end)

    it("GetCharacterNames lists the roster", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        roster = {
          { id = 1, name = "Licks-Frogs", account = "@FAKE" },
          { id = 2, name = "Eats-Pants", account = "@FAKE" },
        },
      }))
      assert.same({ "Licks-Frogs", "Eats-Pants" }, FurC.Lib.GetCharacterNames())
      FurC.Lib.InitLCK(nil)
    end)

    it("IsKnownByName resolves the character by name", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        roster = {
          { id = 1, name = "Licks-Frogs", account = "@FAKE" },
          { id = 2, name = "Eats-Pants", account = "@FAKE" },
        },
        byChar = {
          [1] = { [777] = 1 }, -- Licks-Frogs KNOWS 777
          [2] = { [777] = 2 }, -- Eats-Pants doesn't
        },
        list = {
          [777] = { { knowledge = 1 }, { knowledge = 2 } }, -- account: one knows
          [888] = { { knowledge = 0 }, { knowledge = 2 } }, -- account: nobody knows
        },
      }))
      -- acc-wide: KNOWN across characters
      assert.is_true(FurC.Lib.IsKnownByName(777, nil))
      assert.is_false(FurC.Lib.IsKnownByName(888, nil))
      -- char-wide: NODATA/UNKNOWN are not known
      assert.is_true(FurC.Lib.IsKnownByName(777, "Licks-Frogs"))
      assert.is_false(FurC.Lib.IsKnownByName(777, "Eats-Pants"))
      -- unknown char falls back to account-wide
      assert.is_true(FurC.Lib.IsKnownByName(777, "NoBody"))
      FurC.Lib.InitLCK(nil)
    end)

    it("EVENT_INITIALIZED invalidates roster", function()
      local cfg = { roster = {} }
      local fake = makeFakeLCK(cfg)
      local savedUpdateGui = FurC.UpdateGui
      FurC.UpdateGui = function() end

      FurC.Lib.InitLCK(fake)
      assert.same({}, FurC.Lib.GetCharacterNames()) -- caches empty roster

      cfg.roster = { { id = 1, name = "Licks-Frogs", account = "@FAKE" } }
      fake.fire(fake.EVENT_INITIALIZED) -- must drop stale cache
      assert.same({ "Licks-Frogs" }, FurC.Lib.GetCharacterNames())

      FurC.UpdateGui = savedUpdateGui
      FurC.Lib.InitLCK(nil)
    end)

    it("GetCrafterNames returns only chars that know it", function()
      FurC.Lib.InitLCK(makeFakeLCK({
        list = {
          [777] = {
            { name = "Licks-Frogs", knowledge = 1 }, -- KNOWN
            { name = "Eats-Pants", knowledge = 2 }, -- UNKNOWN
          },
        },
      }))
      assert.same({ "Licks-Frogs" }, FurC.Lib.GetCrafterNames(777))
      assert.same({}, FurC.Lib.GetCrafterNames(999))
      FurC.Lib.InitLCK(nil)
    end)
  end)
end)
