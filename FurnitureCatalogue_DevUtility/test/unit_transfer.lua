-- Check the Transfer window's line-boundary paging

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local paginate = FurC.Transfer.Paginate

  -- every line back, in order, each exactly once
  local function unpage(pages)
    local lines = {}
    for _, text in ipairs(pages) do
      for line in text:gmatch("[^\n]+") do
        lines[#lines + 1] = line
      end
    end
    return lines
  end

  describe("FurC.Transfer.Paginate", function()
    it("keeps text that fits on one page unchanged", function()
      local pages = paginate({ "FURC LIST: a: 1,2", "FURC LIST: b: 3" }, 100)
      assert.same({ "FURC LIST: a: 1,2\nFURC LIST: b: 3" }, pages)
    end)

    it("splits only between lines, every line on exactly one page, no page over the limit", function()
      local lines = {}
      for i = 1, 50 do
        lines[i] = string.format("FURC LIST: list %d: %s", i, string.rep("123456,", i % 7 + 1))
      end
      local limit = 90
      local pages = paginate(lines, limit)
      assert.is_true(#pages > 1, "the fixture should need several pages")
      for _, text in ipairs(pages) do
        assert.is_true(#text <= limit, "page over the limit: " .. #text)
      end
      assert.same(lines, unpage(pages))
    end)

    it("fills a page exactly to the limit, the separator counted", function()
      local pages = paginate({ "aaaa", "bbbb", "cccc" }, 9)
      assert.same({ "aaaa\nbbbb", "cccc" }, pages)
    end)

    it("gives a line longer than a page a page of its own instead of dropping it", function()
      local long = string.rep("1", 50)
      local pages = paginate({ "FURC LIST: a: 1", long, "FURC LIST: b: 2" }, 40)
      assert.same({ "FURC LIST: a: 1", long, "FURC LIST: b: 2" }, pages)
    end)

    it("returns no page for no lines", function()
      assert.equals(0, #paginate({}, 100))
    end)
  end)

  describe("FurC.ListExportLines", function()
    it("wraps a long list into lines of the same name, every id once and in order", function()
      local ids = {}
      for i = 1, 2500 do
        ids[i] = 100000 + i
      end
      local lines = FurC.ListExportLines("Big: list", ids)
      assert.equals(3, #lines)
      local seen = {}
      for _, line in ipairs(lines) do
        assert.is_true(#line < 8000, "line over its budget: " .. #line)
        local idText = line:match("^FURC LIST: Big: list: ([%d,]+)$")
        assert.is_not_nil(idText, "not a line of the same list: " .. line:sub(1, 40))
        for id in idText:gmatch("%d+") do
          seen[#seen + 1] = tonumber(id)
        end
      end
      assert.same(ids, seen)
    end)

    it("keeps a short list on one line, and an empty one still names the list", function()
      assert.same({ "FURC LIST: a: 1,2" }, FurC.ListExportLines("a", { 1, 2 }))
      assert.same({ "FURC LIST: a: " }, FurC.ListExportLines("a", {}))
    end)
  end)

  describe("FurC.FavesExportLines", function()
    it("writes no line for no favourites and wraps many at 1000 ids", function()
      assert.same({}, FurC.FavesExportLines({}))
      assert.same({ "FURC FAVES: 7,9" }, FurC.FavesExportLines({ 7, 9 }))
      local ids = {}
      for i = 1, 1001 do
        ids[i] = 200000 + i
      end
      local lines = FurC.FavesExportLines(ids)
      assert.equals(2, #lines)
      assert.equals("FURC FAVES: 201001", lines[2])
    end)
  end)

  describe("FurC.AddImportedIds", function()
    -- 1 and 2 are furnishings, 20 is the blueprint of 2, everything else is unknown
    local function resolve(id)
      return ({ [1] = 1, [2] = 2, [20] = 2 })[id]
    end

    it("maps a blueprint to its furnishing, drops unknown ids and counts repeats as duplicates", function()
      local items = { [1] = true }
      local added, duplicates, unknown = FurC.AddImportedIds(items, "1, 2,20,99, 2", resolve)
      assert.same({ [1] = true, [2] = true }, items)
      assert.equals(1, added)
      assert.equals(3, duplicates) -- 1 was there, 20 is 2 again, 2 twice
      assert.equals(1, unknown)
    end)

    it("counts nothing for text without ids", function()
      local added, duplicates, unknown = FurC.AddImportedIds({}, "", resolve)
      assert.equals(0, added + duplicates + unknown)
    end)
  end)

  describe("FurC.KnownFurnishingId", function()
    it("knows a catalogued furnishing and drops an ignored one, which no list would show", function()
      assert.equals(115647, FurC.KnownFurnishingId(115647))
      assert.is_nil(FurC.KnownFurnishingId(119706)) -- attuned crafting station, ignored on purpose
      assert.is_nil(FurC.KnownFurnishingId(990001))
    end)
  end)

  describe("FurC.Transfer.ImportText", function()
    local PREFIX = "FURC UNITTEST"

    it("adds lines of the same label up to one entry and counts unreadable lines", function()
      FurC.Transfer.Register(PREFIX, {
        import = function(payload)
          local label, n = payload:match("^(%a+) (%d+)$")
          if not label then
            return nil, "bad"
          end
          return { label = label, added = tonumber(n), duplicates = 1, unknown = 0 }
        end,
      })
      local ok, report = pcall(
        FurC.Transfer.ImportText,
        table.concat({
          PREFIX .. ": a 2",
          PREFIX .. ": b 5",
          PREFIX .. ": A 3",
          "not ids at all",
          PREFIX .. ": ???",
          "FURC NOBODY: 1",
        }, "\n")
      )
      FurC.Transfer.Register(PREFIX, nil)
      assert.is_true(ok, tostring(report))
      assert.equals(2, #report.entries)
      assert.equals("a", report.entries[1].label)
      assert.equals(5, report.entries[1].added)
      assert.equals(2, report.entries[1].duplicates)
      assert.equals(5, report.entries[2].added)
      assert.equals(3, report.unreadable)
      assert.same({ "bad" }, report.errors)
    end)

    it("rejoins a line the game broke mid-id, and still refuses a line that is not ids", function()
      local payloads = {}
      FurC.Transfer.Register(PREFIX, {
        import = function(payload)
          payloads[#payloads + 1] = payload
          return { label = "x", added = 0, duplicates = 0, unknown = 0 }
        end,
      })
      local ok, report = pcall(FurC.Transfer.ImportText, PREFIX .. ": x: 101,102,10\r\n3,104\r\nhello, world")
      FurC.Transfer.Register(PREFIX, nil)
      assert.is_true(ok, tostring(report))
      assert.same({ "x: 101,102,103,104" }, payloads)
      assert.equals(1, report.unreadable)
    end)
  end)
end)
