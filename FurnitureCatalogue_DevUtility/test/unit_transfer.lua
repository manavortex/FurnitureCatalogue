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
end)
