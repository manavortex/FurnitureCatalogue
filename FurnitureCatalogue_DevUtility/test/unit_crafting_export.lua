-- Crafting knowledge: craftables split into known and unknown, as export lines of their own and as the saved-variables dump

if not Taneth then
  return
end

-- Real global table, to override game stubs
local G = _G

Taneth("FurC:Unit", function()
  describe("FurC.CraftingExport", function()
    local C = FurC.CraftingExport

    local api = LibFurnitureCatalogue.API

    -- two craftables and one furnishing that is not, from the catalogue itself
    local function pick()
      local crafting = api.GetSourceTypes().CRAFTING
      local ids, craftable, other = api.GetItemIds(), {}, nil
      table.sort(ids)
      for _, id in ipairs(ids) do
        local isCraftable = api.GetEntry(id).sources[crafting]
        if isCraftable and #craftable < 2 then
          craftable[#craftable + 1] = id
        elseif not isCraftable then
          other = other or id
        end
      end
      return craftable[1], craftable[2], other
    end

    -- the account knows exactly one plan
    local function knowingOnly(knownId, fn)
      local savedKnown = FurC.IsAccountKnown
      FurC.IsAccountKnown = function(itemLink)
        return api.GetItemId(itemLink) == knownId
      end
      local ok, err = pcall(fn)
      FurC.IsAccountKnown = savedKnown
      if not ok then
        error(err, 0)
      end
    end

    local function idSet(text)
      local set = {}
      -- one line per 1000 ids, each after its own "FURC KNOWN p/n: "
      for line in text:gmatch("[^\n]+") do
        for id in line:match(":%s*([%d,]*)$"):gmatch("%d+") do
          set[tonumber(id)] = true
        end
      end
      return set
    end

    it("exports known and unknown craftables under their own fixed prefix, each line with its page", function()
      local knownId, unknownId, otherId = pick()
      knowingOnly(knownId, function()
        assert.equals("FURC KNOWN 1/1: " .. knownId, C.ExportText(true))
        local unknown = C.ExportText(false)
        for line in unknown:gmatch("[^\n]+") do
          assert.is_true(line:match("^FURC UNKNOWN %d/%d: [%d,]+$") ~= nil, line:sub(1, 40))
        end
        local ids = idSet(unknown)
        assert.is_true(ids[unknownId], "a craftable without its plan is unknown")
        assert.is_nil(ids[knownId])
        assert.is_nil(ids[otherId], "a furnishing that cannot be crafted is on neither list")
      end)
    end)

    it("still writes one line for an empty set", function()
      knowingOnly(nil, function()
        assert.equals("FURC KNOWN 1/1:", C.ExportText(true))
      end)
    end)

    it("numbers the lines with the pages the export window splits them into", function()
      knowingOnly(nil, function()
        local lines = {}
        for line in C.ExportText(false):gmatch("[^\n]+") do
          lines[#lines + 1] = line
        end
        local pages = FurC.Transfer.Paginate(lines, FurC.Transfer.MAX_CHARS)
        assert.is_true(#pages > 1, "every craftable unknown should need more than one page")
        for page, text in ipairs(pages) do
          for line in text:gmatch("[^\n]+") do
            assert.equals("FURC UNKNOWN " .. page .. "/" .. #pages .. ":", line:match("^[^:]+:"))
          end
        end
      end)
    end)

    it("refuses to import knowledge, changes no list and says why once", function()
      local before = FurC.ListExportText()
      local report = FurC.Transfer.ImportText("FURC KNOWN 1/2: 123,456\nFURC KNOWN 2/2: 789\nFURC UNKNOWN 1/1:")
      assert.same({}, report.entries)
      assert.equals(0, report.unreadable)
      assert.same({ GetString(SI_FURC_CRAFT_NOT_IMPORTED) }, report.errors)
      assert.equals(before, FurC.ListExportText())
    end)

    it("writes known and unknown by name to the saved variables, then reloads", function()
      local savedReload, savedNew = G.ReloadUI, ZO_SavedVars.NewAccountWide
      local written, reloaded = {}, false
      G.ReloadUI = function()
        reloaded = true
      end
      ZO_SavedVars.NewAccountWide = function(_, name)
        written.name = name
        return written
      end
      local ok, err = pcall(knowingOnly, (pick()), C.SaveToFile)
      G.ReloadUI, ZO_SavedVars.NewAccountWide = savedReload, savedNew
      assert.is_true(ok, tostring(err))

      assert.equals("FurnitureCatalogue_Export", written.name)
      assert.is_true(next(written.known) ~= nil, "a known craftable is written")
      assert.is_true(next(written.unknown) ~= nil, "an unknown craftable is written")
      assert.is_true(reloaded)
    end)
  end)
end)
