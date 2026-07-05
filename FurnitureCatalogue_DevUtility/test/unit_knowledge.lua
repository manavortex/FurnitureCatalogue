-- Recipe knowledge + LCK

if not Taneth then
  return
end

-- Real global table, to override game stubs
local G = _G

Taneth("FurC:Unit", function()
  local blueprintId = 207872 -- Formula: Dawnwood Lantern, Hanging (resultItem: 204688)
  local blueprintLink = FurC.Utils.GetItemLink(blueprintId)

  -- LCK tracks other accounts on the same server, we currently ignore those
  local ACCOUNT = GetDisplayName()
  local OTHER_ACCOUNT = "@SomeoneElse"

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
      UnregisterForCallback = function(_, eventCode)
        callbacks[eventCode] = nil
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

  -- guard references, so we don't break them when testing in-game
  local function guarded(fn)
    local saved = {
      lck = G.LibCharacterKnowledge,
      known = G.IsItemLinkRecipeKnown,
      updateGui = FurC.UpdateGui,
      refresh = FurC.RefreshCharacterDropdown,
    }
    FurC.UpdateGui = function() end
    FurC.RefreshCharacterDropdown = function() end
    local ok, err = pcall(fn)
    G.LibCharacterKnowledge = saved.lck
    G.IsItemLinkRecipeKnown = saved.known
    FurC.UpdateGui = saved.updateGui
    FurC.RefreshCharacterDropdown = saved.refresh
    FurC.Lib.InitLCK(nil)
    if not ok then
      error(err, 0)
    end
  end

  describe("FurC.Lib LCK seam", function()
    it("waves everything through when no LCK", function()
      guarded(function()
        G.LibCharacterKnowledge = nil -- hide the real global
        FurC.Lib.InitLCK(nil)
        assert.is_false(FurC.Lib.LCKAvailable())
        assert.is_true(FurC.Lib.CharKnows(12345))
        assert.is_true(FurC.Lib.AccountKnows(12345))
        assert.is_nil(FurC.Lib.IsKnownByName(12345, nil))
        assert.is_nil(FurC.Lib.GetCrafterNames(12345))
        assert.same({}, FurC.Lib.GetCharacterNames())
      end)
    end)

    it("InitLCK(nil) binds the installed LCK", function()
      guarded(function()
        G.LibCharacterKnowledge = makeFakeLCK({ knowledge = { [111] = 1, [222] = 2 } })
        FurC.Lib.InitLCK(nil)
        assert.is_true(FurC.Lib.LCKAvailable())
        assert.is_true(FurC.Lib.CharKnows(111))
        assert.is_false(FurC.Lib.CharKnows(222))
      end)
    end)

    it("re-init does not add duplicate callbacks", function()
      guarded(function()
        local fires = 0
        local fake = makeFakeLCK({})
        FurC.RefreshCharacterDropdown = function()
          fires = fires + 1
        end
        FurC.Lib.InitLCK(fake)
        FurC.Lib.InitLCK(fake)
        fake.fire(fake.EVENT_INITIALIZED)
        assert.equals(1, fires)
      end)
    end)

    it("respects character knowledge when LCK", function()
      guarded(function()
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
      end)
    end)

    it("AccountKnows true if any tracked character know", function()
      guarded(function()
        FurC.Lib.InitLCK(makeFakeLCK({
          list = {
            [111] = { { account = ACCOUNT, knowledge = 2 }, { account = ACCOUNT, knowledge = 1 } }, -- one char knows
            [222] = { { account = ACCOUNT, knowledge = 2 }, { account = ACCOUNT, knowledge = 2 } }, -- nobody knows
            [333] = { { account = OTHER_ACCOUNT, knowledge = 1 } }, -- only foreign account knows
          },
        }))
        assert.is_true(FurC.Lib.AccountKnows(111))
        assert.is_false(FurC.Lib.AccountKnows(222))
        assert.is_false(FurC.Lib.AccountKnows(333))
      end)
    end)

    it("GetCharacterNames lists the roster", function()
      guarded(function()
        FurC.Lib.InitLCK(makeFakeLCK({
          roster = {
            { id = 1, name = "Licks-Frogs", account = ACCOUNT },
            { id = 3, name = "Nose-Stealer", account = OTHER_ACCOUNT },
            { id = 2, name = "Eats-Pants", account = ACCOUNT },
          },
        }))
        assert.same({ "Licks-Frogs", "Eats-Pants" }, FurC.Lib.GetCharacterNames())
      end)
    end)

    it("IsKnownByName resolves the character by name", function()
      guarded(function()
        FurC.Lib.InitLCK(makeFakeLCK({
          roster = {
            { id = 1, name = "Licks-Frogs", account = ACCOUNT },
            { id = 2, name = "Eats-Pants", account = ACCOUNT },
          },
          byChar = {
            [1] = { [777] = 1 }, -- Licks-Frogs KNOWS 777
            [2] = { [777] = 2 }, -- Eats-Pants doesn't
          },
          list = {
            [777] = { { account = ACCOUNT, knowledge = 1 }, { account = ACCOUNT, knowledge = 2 } }, -- account: one knows
            [888] = { { account = ACCOUNT, knowledge = 0 }, { account = ACCOUNT, knowledge = 2 } }, -- account: nobody knows
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
      end)
    end)

    it("EVENT_INITIALIZED invalidates roster", function()
      guarded(function()
        local cfg = { roster = {} }
        local fake = makeFakeLCK(cfg)
        FurC.Lib.InitLCK(fake)
        assert.same({}, FurC.Lib.GetCharacterNames()) -- caches empty roster

        cfg.roster = { { id = 1, name = "Licks-Frogs", account = ACCOUNT } }
        fake.fire(fake.EVENT_INITIALIZED) -- must drop stale cache
        assert.same({ "Licks-Frogs" }, FurC.Lib.GetCharacterNames())
      end)
    end)

    it("GetCrafterNames returns only chars that know it", function()
      guarded(function()
        FurC.Lib.InitLCK(makeFakeLCK({
          list = {
            [777] = {
              { account = ACCOUNT, name = "Licks-Frogs", knowledge = 1 }, -- KNOWN
              { account = ACCOUNT, name = "Eats-Pants", knowledge = 2 }, -- UNKNOWN
              { account = OTHER_ACCOUNT, name = "Nose-Stealer", knowledge = 1 }, -- KNOWN, foreign account
            },
          },
        }))
        assert.same({ "Licks-Frogs" }, FurC.Lib.GetCrafterNames(777))
        assert.same({}, FurC.Lib.GetCrafterNames(999))
      end)
    end)
  end)

  describe("FurC knowledge readers (live game API + LCK)", function()
    -- TODO: drop this after 2-3 major updates
    it("PurgeLegacySavedVars drops the persisted DB and char-scan flags", function()
      local savedData = FurC.settings.data
      local savedChars = FurC.settings.accountCharacters
      FurC.settings.data = { [118306] = { origin = 1, characters = { Someone = true } } }
      FurC.settings.accountCharacters = { Someone = true }

      FurC.PurgeLegacySavedVars()
      assert.is_nil(FurC.settings.data)
      assert.is_nil(FurC.settings.accountCharacters)

      FurC.settings.data = savedData
      FurC.settings.accountCharacters = savedChars
    end)

    it("CanCraft reflects the current character's knowledge", function()
      guarded(function()
        G.IsItemLinkRecipeKnown = function(link)
          return link == blueprintLink
        end
        assert.is_true(FurC.CanCraft(nil, { blueprint = blueprintId }))
        assert.is_false(FurC.CanCraft(nil, { blueprint = 999999 })) -- different link
        assert.is_false(FurC.CanCraft(nil, { origin = 1 })) -- no blueprint
      end)
    end)

    it("IsAccountKnown falls back to current char without LCK", function()
      guarded(function()
        G.LibCharacterKnowledge = nil -- hide the real global so the fallback path runs
        FurC.Lib.InitLCK(nil)
        G.IsItemLinkRecipeKnown = function(link)
          return link == blueprintLink
        end
        assert.is_true(FurC.IsAccountKnown(nil, { blueprint = blueprintId }))
        assert.is_false(FurC.IsAccountKnown(nil, { blueprint = 999999 }))
      end)
    end)

    it("IsAccountKnown uses LCK (any character) when present", function()
      guarded(function()
        -- current char doesn't know, but another does
        G.IsItemLinkRecipeKnown = function()
          return false
        end
        FurC.Lib.InitLCK(makeFakeLCK({
          list = { [blueprintLink] = { { account = ACCOUNT, knowledge = 2 }, { account = ACCOUNT, knowledge = 1 } } },
        }))
        assert.is_true(FurC.IsAccountKnown(nil, { blueprint = blueprintId }))
        assert.is_false(FurC.IsAccountKnown(nil, { blueprint = 999999 }))
      end)
    end)
  end)
end)
