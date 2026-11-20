-- Sublists: paths, parents, order, and the text format shared with the LFC webinterface

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  -- every test starts with no lists and no favourites, and leaves the account's own as they were
  local function withEmptyStore(fn)
    local settings = FurC.settings
    local savedLists, savedFaves = settings.customLists, settings.favorites
    settings.customLists, settings.favorites = nil, {}
    local ok, err = pcall(fn)
    settings.customLists, settings.favorites = savedLists, savedFaves
    FurC.ApplyListChoices(FurC.DropdownData.ChoicesSource)
    if FurC.RefreshSourceDropdown then
      FurC.RefreshSourceDropdown()
    end
    if not ok then
      error(err, 0)
    end
  end

  local function names()
    local out = {}
    for i, list in ipairs(FurC.GetLists()) do
      out[i] = list.name
    end
    return out
  end

  local function idOf(name)
    local listId = FurC.FindListByName(name)
    assert.is_not_nil(listId, "no list " .. name)
    return listId
  end

  -- the webinterface's manual test data, as its "All lists" export writes it
  local GOLDEN_LISTS = {
    "FURC LIST Guildhall: 87709,94091,94092",
    "FURC LIST Guildhall > Stripper Poles: 94093,94094,94095,94096,94097",
    "FURC LIST Guildhall > Stripper Poles > Daedric: 94098,94099",
    "FURC LIST Guildhall > Entrance:",
    "FURC LIST Kitchen: 94100,94101,94102,94103",
  }
  local GOLDEN_FAVES = "FURC FAVES: 94104,94105,94106"

  local MALFORMED = table.concat({
    "# expected result per line is in README.md",
    "FURC LIST A > B > C > D > E: 87709",
    "FURC LIST   Spaces>around   >  parts  : 94091",
    "FURC LIST > > Empty parts > : 94092",
    "FURC LIST " .. string.rep("x", 40) .. " > " .. string.rep("ä", 40) .. ": 94093",
    "FURC LIST Hall: west wing: 94094",
    "FURC LIST Dupes: 94095,94095, 94096,,",
    "FURC LIST Unknown ids: 1,2,99999999,94097",
    "FURC LIST Not numbers: abc,94098",
    "FURC LIST Favorites: 94099",
    "FURC LIST Favourites > Sub: 94099",
    "FURC LIST: Old colon spelling: 94100",
    "[FURC LIST] Old bracket spelling: 94101",
    "FURC LIST 1: Old version one: 94102",
    "FURC LIST 2: Unknown version: 94103",
    "FURC LISTS: Wrong prefix: 94104",
    "FURC LIST : 5",
    "FURC LIST No colon",
    "furc faves 94105",
    "just some text",
    "",
    "94106,94107",
  }, "\n")

  describe("FurC lists: sublists", function()
    it("makes a sublist with every missing parent, below the parent's last sublist", function()
      withEmptyStore(function()
        assert.is_not_nil(FurC.CreateList("Kitchen"))
        local entrance = FurC.CreateList("Guildhall > Entrance")
        assert.is_not_nil(FurC.CreateList("Guildhall>Poles >  Daedric"))
        assert.same(
          { "Kitchen", "Guildhall", "Guildhall > Entrance", "Guildhall > Poles", "Guildhall > Poles > Daedric" },
          names()
        )
        local info = FurC.GetListInfo(entrance)
        assert.equals("Entrance", info.leaf)
        assert.equals(2, info.depth)
        -- an existing parent keeps its spelling, and the same path is the same list
        assert.is_not_nil(FurC.CreateList("GUILDHALL > Cellar"))
        assert.equals("Guildhall > Cellar", names()[6])
        assert.is_nil(FurC.CreateList("guildhall > entrance"))
        assert.is_nil(FurC.CreateList(" > "))
      end)
    end)

    it("folds a fourth level into the third, drops empty parts and cuts each part to 32 bytes", function()
      withEmptyStore(function()
        FurC.CreateList("A > B > C > D > E")
        FurC.CreateList("> > Solo > ")
        FurC.CreateList(string.rep("x", 40) .. " > " .. string.rep("ä", 40))
        assert.same({
          "A",
          "A > B",
          "A > B > C / D / E",
          "Solo",
          string.rep("x", 32),
          string.rep("x", 32) .. " > " .. string.rep("ä", 16),
        }, names())
      end)
    end)

    it("refuses a root list called like the favourites, as the webinterface does, and no other name", function()
      withEmptyStore(function()
        assert.is_nil(FurC.CreateList("Favorites"))
        assert.is_nil(FurC.CreateList("favourites"))
        assert.is_nil(FurC.CreateList(GetString(SI_FURC_FILTER_SRC_FAVE))) -- in the client's language
        assert.is_not_nil(FurC.CreateList(GetString(SI_FURC_FILTER_SRC_RUMOUR)))
        assert.is_not_nil(FurC.CreateList(GetString(SI_FURC_FILTER_SRC_CRAFTING) .. " > Sub"))
        assert.is_true(FurC.RenameList(FurC.CreateList("Plain"), GetString(SI_FURC_FILTER_SRC_OTHER)))
        assert.is_nil(FurC.CreateList("Favorites > Sub"))
        assert.is_not_nil(FurC.CreateList("Guildhall > Favorites"))
      end)
    end)

    it("tells two sublists of the same name apart by their label, and nests them under their parents", function()
      withEmptyStore(function()
        local a = FurC.CreateList("Guildhall > Entrance")
        local b = FurC.CreateList("Manor > Entrance")
        local choices = {}
        FurC.ApplyListChoices(choices)
        assert.equals("Guildhall > Entrance", choices[FurC.ListSourceId(a)])
        assert.equals("Manor > Entrance", choices[FurC.ListSourceId(b)])
        local nodes = FurC.GetListTreeNodes()
        assert.equals(2, #nodes)
        assert.equals(FurC.ListSourceId(a), nodes[1].children[1].id)
        assert.equals(FurC.ListSourceId(b), nodes[2].children[1].id)
        assert.is_true(nodes[1].noRollup and nodes[1].children[1].noRollup)
      end)
    end)

    it("renames a list for everything below it, with > in the new name read as /", function()
      withEmptyStore(function()
        FurC.CreateList("Guildhall > Poles > Daedric")
        FurC.CreateList("Guildhall > Entrance")
        local deep = idOf("Guildhall > Poles > Daedric")
        assert.is_true(FurC.RenameList(idOf("Guildhall"), "Hall > West"))
        assert.same(
          { "Hall / West", "Hall / West > Poles", "Hall / West > Poles > Daedric", "Hall / West > Entrance" },
          names()
        )
        assert.equals(deep, idOf("Hall / West > Poles > Daedric"))
        assert.is_true(FurC.RenameList(idOf("Hall / West > Poles"), "poles")) -- its own name in another case
        assert.is_false(FurC.RenameList(idOf("Hall / West > poles"), "Entrance"))
        assert.is_false(FurC.RenameList(idOf("Hall / West"), "  "))
      end)
    end)

    it("empties a list that has sublists and removes one that has none", function()
      withEmptyStore(function()
        FurC.ImportBareIds(FurC.CreateList("Guildhall"), "87709,94091")
        FurC.CreateList("Guildhall > Entrance")
        local parent = idOf("Guildhall")
        assert.is_true(FurC.ListHasSublists(parent))
        FurC.DeleteList(parent)
        assert.same({ "Guildhall", "Guildhall > Entrance" }, names())
        assert.equals(0, FurC.GetListCount(parent))
        FurC.DeleteList(idOf("Guildhall > Entrance"))
        assert.is_false(FurC.ListHasSublists(parent))
        FurC.DeleteList(parent)
        assert.same({}, names())
      end)
    end)

    it("moves a list among its siblings with everything below it, and not past either end", function()
      withEmptyStore(function()
        for _, name in ipairs({ "A", "A > One", "A > One > Deep", "A > Two", "B", "C" }) do
          FurC.CreateList(name)
        end
        assert.is_false(FurC.CanMoveList(idOf("A"), -1))
        assert.is_false(FurC.CanMoveList(idOf("C"), 1))
        assert.is_false(FurC.CanMoveList(idOf("A > Two"), 1)) -- B is not its sibling
        assert.is_false(FurC.MoveList(idOf("A > One > Deep"), -1))
        assert.is_true(FurC.MoveList(idOf("A"), 1))
        assert.same({ "B", "A", "A > One", "A > One > Deep", "A > Two", "C" }, names())
        assert.is_true(FurC.MoveList(idOf("A > Two"), -1))
        assert.same({ "B", "A", "A > Two", "A > One", "A > One > Deep", "C" }, names())
        assert.is_true(FurC.MoveList(idOf("C"), -1))
        assert.same({ "B", "C", "A", "A > Two", "A > One", "A > One > Deep" }, names())
      end)
    end)

    local function createAll(list)
      for _, name in ipairs(list) do
        FurC.CreateList(name)
      end
    end

    it("moves a root list into the list above as its last sublist, and out again to where it was", function()
      withEmptyStore(function()
        local start = { "A", "A > X", "B", "B > Sub", "C" }
        createAll(start)
        local b, sub = idOf("B"), idOf("B > Sub")
        FurC.ImportBareIds(b, "87709,94091")
        FurC.ImportBareIds(sub, "94092")
        assert.is_true(FurC.CanShiftList(b, 1))
        assert.is_true(FurC.ShiftList(b, 1))
        assert.same({ "A", "A > X", "A > B", "A > B > Sub", "C" }, names())
        assert.equals(b, idOf("A > B"))
        assert.equals(sub, idOf("A > B > Sub"))
        assert.equals(2, FurC.GetListCount(b))
        assert.equals(1, FurC.GetListCount(sub))
        assert.is_true(FurC.ShiftList(b, -1))
        assert.same(start, names())
        assert.equals(b, idOf("B"))
        assert.is_true(FurC.IsInListById(sub, 94092))
      end)
    end)

    it("moves a middle sublist out after its parent's whole subtree, the later sublists staying", function()
      withEmptyStore(function()
        createAll({ "P", "P > One", "P > Two", "P > Two > Deep", "P > Three", "P > Three > Low", "Q" })
        local two = idOf("P > Two")
        assert.is_true(FurC.ShiftList(two, -1))
        assert.same({ "P", "P > One", "P > Three", "P > Three > Low", "Two", "Two > Deep", "Q" }, names())
        assert.equals(two, idOf("Two"))
      end)
    end)

    it("refuses a shift with nothing to shift into or out of, a fourth level, or a taken or reserved path", function()
      withEmptyStore(function()
        createAll({ "A", "A > b", "B", "C", "C > Sub", "C > Sub > Deep", "H > Favorites" })
        local before = names()
        local function refused(name, delta, reason)
          local ok, why = FurC.CanShiftList(idOf(name), delta)
          assert.is_false(ok, name .. " " .. delta)
          assert.equals(reason, why, name .. " " .. delta)
          assert.is_false(FurC.ShiftList(idOf(name), delta))
          assert.same(before, names())
        end
        refused("A", -1) -- a root list
        refused("A", 1) -- nothing above
        refused("A > b", 1) -- its parent is above, no sibling
        refused("C", 1) -- B is above, but Deep would land on a fourth level
        refused("B", 1, zo_strformat(GetString(SI_FURC_LIST_SHIFT_TAKEN), "A > B")) -- "A > b", without case
        refused("H > Favorites", -1, zo_strformat(GetString(SI_FURC_LIST_SHIFT_RESERVED), "Favorites"))
      end)
    end)

    it("deletes every list and leaves the favourites, with nothing pointing at a list any more", function()
      local savedSource, additive = FurC.DropdownChoices["Source"], FurC.AdditiveSources
      local savedAdditive = ZO_ShallowTableCopy(additive)
      local src = LibFurnitureCatalogue.API.GetSourceTypes()
      local ok, err = pcall(withEmptyStore, function()
        createAll({ "A", "A > One", "A > One > Deep", "B" })
        FurC.ImportBareIds(idOf("A > One"), "87709")
        FurC.ImportBareIds("faves", "94091,94092")
        local deep = FurC.ListSourceId(idOf("A > One > Deep"))
        FurC.DropdownChoices["Source"] = deep
        additive[deep], additive[src.FAVE] = true, true
        FurC.DeleteAllLists()
        assert.same({}, names())
        assert.same({ [94091] = true, [94092] = true }, FurC.settings.favorites)
        assert.equals(src.NONE, FurC.GetDropdownChoice("Source"))
        assert.is_nil(additive[deep])
        assert.is_true(additive[src.FAVE]) -- not a list
        assert.is_not_nil(FurC.CreateList("A")) -- the name is free again
      end)
      FurC.DropdownChoices["Source"] = savedSource
      ZO_ClearTable(additive)
      ZO_ShallowTableCopy(savedAdditive, additive)
      if not ok then
        error(err, 0)
      end
    end)

    it("groups a store from before sublists, keeping the ids of its lists", function()
      withEmptyStore(function()
        FurC.settings.customLists = {
          nextId = 4,
          order = { 1, 2, 3 },
          byId = {
            [1] = { name = "Guildhall > Entrance", items = { [87709] = true } },
            [2] = { name = "Kitchen", items = {} },
            [3] = { name = "Guildhall", items = { [94091] = true } },
          },
        }
        assert.same({ "Guildhall", "Guildhall > Entrance", "Kitchen" }, names())
        assert.equals(1, idOf("Guildhall > Entrance"))
        assert.same({ 87709 }, FurC.GetListItemIds(1))
        assert.same({ 94091 }, FurC.GetListItemIds(idOf("Guildhall")))
      end)
    end)
  end)

  describe("FurC lists: text format", function()
    it("takes the webinterface's export with its grouping and order, and writes it back unchanged", function()
      withEmptyStore(function()
        local report = FurC.Transfer.ImportText(table.concat(GOLDEN_LISTS, "\n") .. "\n" .. GOLDEN_FAVES)
        assert.equals(0, report.unreadable)
        assert.same({}, report.errors)
        assert.equals(6, #report.entries)
        local added = 0
        for _, entry in ipairs(report.entries) do
          added = added + entry.added
          assert.equals(0, entry.duplicates + entry.unknown)
        end
        assert.equals(17, added)
        assert.same({
          "Guildhall",
          "Guildhall > Stripper Poles",
          "Guildhall > Stripper Poles > Daedric",
          "Guildhall > Entrance",
          "Kitchen",
        }, names())
        -- the add-on writes the favourites first; the lists follow in display order
        assert.equals(GOLDEN_FAVES .. "\n" .. table.concat(GOLDEN_LISTS, "\n"), (FurC.ListExportText()))
        -- one list is its own line alone, not the lists below it
        assert.equals(GOLDEN_LISTS[2], (FurC.ListExportText(idOf("Guildhall > Stripper Poles"))))
      end)
    end)

    it(
      "reads the malformed test data as its README names: 11 lists, 7 lines skipped, the reserved name reported",
      function()
        withEmptyStore(function()
          local report = FurC.Transfer.ImportText(MALFORMED, function(idText)
            return FurC.ImportBareIds("all", idText)
          end)
          assert.equals(11, #report.entries)
          assert.equals(7, report.unreadable)
          assert.same({ GetString(SI_FURC_LIST_ERR_TAKEN), GetString(SI_FURC_LIST_IMPORT_NO_TARGET) }, report.errors)
          assert.same({
            "A",
            "A > B",
            "A > B > C / D / E",
            "Spaces",
            "Spaces > around",
            "Spaces > around > parts",
            "Empty parts",
            string.rep("x", 32),
            string.rep("x", 32) .. " > " .. string.rep("ä", 16),
            "Hall: west wing",
            "Dupes",
            "Unknown ids",
            "Old colon spelling",
            "Old bracket spelling",
            "Old version one",
          }, names())
          local byLabel = {}
          for _, entry in ipairs(report.entries) do
            byLabel[entry.label] = entry
          end
          assert.equals(2, byLabel["Dupes"].added)
          assert.equals(1, byLabel["Dupes"].duplicates)
          assert.equals(1, byLabel["Unknown ids"].added)
          assert.equals(3, byLabel["Unknown ids"].unknown)
          assert.is_true(FurC.settings.favorites[94105])
        end)
      end
    )

    it("replaces a list by its line, adds by an add line or a line of ids, and leaves unnamed lists alone", function()
      withEmptyStore(function()
        local import = FurC.Transfer.ImportText
        import("FURC LIST Hall: 87709,94091,94092\nFURC LIST Kitchen: 94100\nFURC FAVES: 94104,94105")
        local hall = idOf("Hall")
        local bare = function(idText, ctx)
          return FurC.ImportBareIds(hall, idText, ctx)
        end

        -- a check counts and changes nothing, also for a list that does not exist yet
        local check = import("FURC LIST Hall: 94091,94093\nFURC LIST New: 94094", bare, { check = true })
        assert.equals(2, check.removed)
        assert.same({ 87709, 94091, 94092 }, FurC.GetListItemIds(hall))
        assert.is_nil(FurC.FindListByName("New"))

        local report = import("FURC LIST Hall: 94091,94093\nFURC LIST+ Hall: 94094\nFURC LIST Hall: 94095")
        assert.same({ 94091, 94093, 94094, 94095 }, FurC.GetListItemIds(hall))
        local entry = report.entries[1]
        -- 94091 stayed, so it is no addition
        assert.same({ 3, 1, 2 }, { entry.added, entry.duplicates, entry.removed })
        assert.equals(2, report.removed)
        assert.same({ 94100 }, FurC.GetListItemIds(idOf("Kitchen")))
        assert.is_true(FurC.settings.favorites[94104])

        -- an add line, a line of ids and a merging import remove nothing
        assert.equals(0, import("FURC LIST+ Hall: 94096\nFURC FAVES+: 94106\n\n94097", bare).removed)
        assert.equals(0, import("FURC LIST Hall: 94098\nFURC FAVES: 94107", bare, { merge = true }).removed)
        assert.same({ 94091, 94093, 94094, 94095, 94096, 94097, 94098 }, FurC.GetListItemIds(hall))
        assert.is_true(
          FurC.settings.favorites[94104] and FurC.settings.favorites[94106] and FurC.settings.favorites[94107]
        )

        -- the plus belongs to the prefix: apart from it, it starts the list's name
        import("FURC LIST + odd: 94099")
        assert.same({ 94099 }, FurC.GetListItemIds(idOf("+ odd")))
        assert.same({ 94091, 94093, 94094, 94095, 94096, 94097, 94098 }, FurC.GetListItemIds(hall))

        assert.equals(3, import("FURC FAVES: 94104").removed)
        assert.is_nil(FurC.settings.favorites[94106])
      end)
    end)

    it("puts a line of ids alone into the selected list or the favourites", function()
      withEmptyStore(function()
        local listId = FurC.CreateList("Guildhall > Entrance")
        local report = FurC.Transfer.ImportText(MALFORMED, function(idText)
          return FurC.ImportBareIds(listId, idText)
        end)
        assert.equals(12, #report.entries)
        assert.same({ 94106, 94107 }, FurC.GetListItemIds(listId))
        assert.equals(GetString(SI_FURC_FILTER_SRC_FAVE), FurC.ImportBareIds("faves", "94100").label)
        assert.is_true(FurC.settings.favorites[94100])
        assert.is_nil(FurC.ImportBareIds("craft_known", "94100"))
      end)
    end)
  end)
end)
