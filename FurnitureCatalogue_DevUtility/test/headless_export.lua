-- /furcexport: craftables land in known/unknown, read from the row's sources bitmask

if not Taneth then
  return
end

-- Real global table, to override game stubs
local G = _G

Taneth("FurC:Unit", function()
  describe("export", function()
    it("splits craftables into known and unknown", function()
      local src = FurC.Constants.ItemSources
      local build = LibFurnitureCatalogue.Internal.Build
      local savedDB, savedReload, savedKnown = FurC.DB, G.ReloadUI, FurC.IsAccountKnown
      local savedEx, savedCmd = FurCEx, SLASH_COMMANDS["/furcexport"]
      local savedMakeSettings = FurCEx and FurCEx.makeSettings

      dofile(FurCDev.repoRoot .. "/FurnitureCatalogue_Export/FurCDataExport.lua")
      FurCEx.settings = {}
      local reloaded = false
      G.ReloadUI = function()
        reloaded = true
      end
      FurC.DB = {
        [204688] = { blueprint = 207872, sources = build.SourceMask({ [src.CRAFTING] = true }) },
        [204689] = { blueprint = 207873, sources = build.SourceMask({ [src.CRAFTING] = true, [src.VENDOR] = true }) },
        [204690] = { sources = build.SourceMask({ [src.VENDOR] = true }) },
      }
      FurC.IsAccountKnown = function(_, entry)
        return entry.blueprint == 207872
      end

      local _, err = pcall(FurCEx.Export)
      local known, unknown = FurCEx.settings.known, FurCEx.settings.unknown
      FurC.DB, G.ReloadUI, FurC.IsAccountKnown = savedDB, savedReload, savedKnown
      FurCEx, SLASH_COMMANDS["/furcexport"] = savedEx, savedCmd
      if FurCEx then
        FurCEx.makeSettings = savedMakeSettings
      end
      assert.is_nil(err)

      assert.is_true(next(known) ~= nil, "a known craftable is exported")
      assert.is_true(next(unknown) ~= nil, "an unknown craftable is exported")
      assert.is_true(reloaded)
    end)
  end)
end)
