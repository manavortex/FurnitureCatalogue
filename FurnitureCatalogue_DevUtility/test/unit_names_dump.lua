-- The id -> name dumps the website reads beside the ids in the data.

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("names dump", function()
    local names = {}
    for id = 1, 400 do
      names[id * 7] = string.format('Name "%d" with \\ and ümlaut', id)
    end

    it("splits into pages under the limit that join back into one Lua table", function()
      local pages = FurCDev.NamePages("quests", names, 2000)
      assert.is_true(#pages > 1)
      for _, page in ipairs(pages) do
        assert.is_true(#page <= 2000)
      end

      local joined = table.concat(pages, "\n")
      -- the game's Lua has no loader, so there only the entries are counted
      local loader = rawget(_G, "loadstring") or rawget(_G, "load")
      if loader then
        local back = assert(loader(joined .. "\nreturn quests"))()
        assert.equals(NonContiguousCount(names), NonContiguousCount(back))
        for id, name in pairs(names) do
          assert.equals(name, back[id])
        end
      else
        local _, entries = joined:gsub("\n  %[%d+%] = ", "")
        assert.equals(NonContiguousCount(names), entries)
      end
    end)

    it("names its table on every page after the first", function()
      local pages = FurCDev.NamePages("quests", names, 2000)
      for i = 2, #pages do
        assert.equals(1, (pages[i]:find(string.format("-- quests, page %d of %d\n", i, #pages), 1, true)))
      end
    end)

    it("orders the lines by id", function()
      local text = FurCDev.NamePages("houses", { [30] = "c", [10] = "a", [20] = "b" })[1]
      local first, second, third = text:find("%[10%]"), text:find("%[20%]"), text:find("%[30%]")
      assert.is_true(first < second and second < third)
    end)
  end)
end)
