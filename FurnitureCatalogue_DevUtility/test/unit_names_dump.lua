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

    it("dumps the names of catalogued items", function()
      local db, getName = FurC.DB, FurC.Utils.GetItemName
      local ensure = FurC.EnsureDB
      FurC.EnsureDB = function() end
      FurC.DB = { [120000] = { blueprint = 130000 }, [120001] = {}, [5] = {} }
      FurC.Utils.GetItemName = function(id)
        return (id == 120000 and "Stuhl") or (id == 130000 and "Skizze: Stuhl") or ""
      end
      local ok, err = pcall(function()
        FurCDev.DumpNames("items")
        assert.equals("Stuhl", FurCDev.Items[120000])
        assert.equals("Skizze: Stuhl", FurCDev.Items[130000])
        assert.is_nil(FurCDev.Items[120001])
        assert.is_nil(FurCDev.Items[5])
        local page = FurCDev.NamePages("items", FurCDev.Items)[1]
        assert.equals(1, (page:find("-- items, ", 1, true)))
      end)
      FurC.DB, FurC.Utils.GetItemName, FurC.EnsureDB = db, getName, ensure
      FurCDev.Items[120000], FurCDev.Items[130000] = nil, nil
      if not ok then
        error(err, 0)
      end
    end)

    it("cleans control characters out of a name and leaves UTF-8 bytes alone", function()
      -- の ends in byte 0x81, which Windows counts as a control character
      assert.equals("狂気の 地下室", FurCDev.Internal.FormatName("狂気の\t地下室"))
    end)

    it("orders the lines by id", function()
      local text = FurCDev.NamePages("houses", { [30] = "c", [10] = "a", [20] = "b" })[1]
      local first, second, third = text:find("%[10%]"), text:find("%[20%]"), text:find("%[30%]")
      assert.is_true(first < second and second < third)
    end)
  end)
end)
