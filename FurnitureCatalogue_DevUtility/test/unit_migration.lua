-- Unified SavedVars migration (FurC.Migrate + registry)
-- live SavedVars are never touched, so it should be save to run ingame

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("FurC.Migrate", function()
    it("favourites_spelling merges British spelling then drops it", function()
      local sv = { favourites = { [111] = true, [222] = true }, favorites = { [333] = true } }
      FurC.Migrate({ migrations = { "favourites_spelling" }, test = sv })
      assert.is_true(sv.favorites[111])
      assert.is_true(sv.favorites[222])
      assert.is_true(sv.favorites[333])
      assert.is_nil(sv.favourites)
    end)

    it("favorites_from_data lifts the embedded favourite flag", function()
      local sv = { data = { [111] = { origin = 1, favorite = true }, [222] = { origin = 1 } } }
      FurC.Migrate({ migrations = { "favorites_from_data" }, test = sv })
      assert.is_true(sv.favorites[111])
      assert.is_nil(sv.favorites[222])
      assert.is_nil(sv.data[111].favorite)
    end)

    it("drop_legacy nils every legacy key, keeps current ones", function()
      local sv = {
        data = {},
        accountCharacters = {},
        excelExport = {},
        emptyItemSources = {},
        startupSilently = true,
        visibility = {},
        useIconsThisChar = true,
        hideMats = true, -- current setting must survive
      }
      FurC.Migrate({ migrations = { "drop_legacy" }, test = sv })
      for _, k in ipairs({
        "data",
        "accountCharacters",
        "excelExport",
        "emptyItemSources",
        "startupSilently",
        "visibility",
        "useIconsThisChar",
      }) do
        assert.is_nil(sv[k])
      end
      assert.is_true(sv.hideMats)
    end)

    it("default run does all steps in order (extract before drop)", function()
      local sv = { data = { [111] = { favorite = true } }, favourites = { [222] = true } }
      FurC.Migrate({ test = sv })
      assert.is_true(sv.favorites[111]) -- lifted from data
      assert.is_true(sv.favorites[222]) -- merged from favourites
      assert.is_nil(sv.data) -- then dropped
      assert.is_nil(sv.favourites)
    end)

    it("allAccounts walks every $AccountWide branch (injected root)", function()
      local root = {
        ["@a"] = { ["$AccountWide"] = { data = { [1] = {}, [2] = {} }, hideMats = true } },
        ["@b"] = { ["$AccountWide"] = { data = { [3] = {} }, favourites = { [9] = true } } },
      }
      local n = FurC.Migrate({ allAccounts = true, test = root })
      assert.equals(2, n)
      local a, b = root["@a"]["$AccountWide"], root["@b"]["$AccountWide"]
      assert.is_nil(a.data)
      assert.is_true(a.hideMats) -- untouched
      assert.is_nil(b.data)
      assert.is_true(b.favorites[9]) -- favourites merged per-branch
    end)

    it("GetLegacyStats counts stale accounts + DB entries", function()
      local root = {
        ["@a"] = { ["$AccountWide"] = { data = { [1] = {}, [2] = {}, [3] = {} } } },
        ["@b"] = { ["$AccountWide"] = { hideMats = true } }, -- clean
        ["@c"] = { ["$AccountWide"] = { accountCharacters = {} } },
      }
      local s = FurC.GetLegacyStats(root)
      assert.equals(2, s.accounts) -- @a + @c
      assert.equals(3, s.entries) -- @a's data entries
    end)
  end)
end)
