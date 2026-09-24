-- Deliberate exclusions are known entries, visible to callers but hidden by FC.
if not Taneth then
  return
end
local GLOBALS = _G
Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local api, build = LFC.API, LFC.Internal.Build
  local src = api.GetSourceTypes()
  describe("ignored catalogue entries", function()
    it("publishes an exclusion through the ordinary API", function()
      FurC.EnsureDB(true)
      local entry = api.GetEntry(191611)
      assert.is_not_nil(entry)
      assert.is_true(entry.sources[src.IGNORED])
      assert.is_not_nil(entry.version)
      assert.is_true(api.Has(191611))
      local records = api.GetSourceDetails(191611)
      assert.equals(1, #records)
      assert.equals(src.IGNORED, records[1].source.type)
      assert.is_nil(records[1].source.note)
      local lines = FurC.GetSourceLines(191611, entry, true)
      assert.equals(GetString(SI_FURC_SRC_IGNORED), lines[1])
    end)
    it("keeps the exclusion when an old source is added", function()
      build.Upsert(191611, { origin = src.RUMOUR })
      build.Upsert(191611, { origin = src.CROWN })
      assert.same({ [src.IGNORED] = true }, api.GetEntry(191611).sources)
    end)
    it("explains the exclusion in raw chat output", function()
      local lines, old = {}, GLOBALS.d
      GLOBALS.d = function(text)
        lines[#lines + 1] = text
      end
      local ok, err = pcall(LFC.Internal.Chat.HandleSlash, "raw 191611")
      GLOBALS.d = old
      if not ok then
        error(err)
      end
      local text = table.concat(lines, "\n")
      assert.is_not_nil(text:find("primary=IGNORED", 1, true))
      assert.is_not_nil(text:find("sources=IGNORED", 1, true))
      assert.is_not_nil(text:find("type=IGNORED", 1, true))
    end)
  end)
end)
