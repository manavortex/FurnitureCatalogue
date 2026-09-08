-- FurnitureCatalogue_DevUtility
--
-- LibFurnitureCatalogue /lfc chat commands: registration, answers and chat safety
-- Runs headless and in game, so the rendered output is checked on a real client too

if not Taneth then
  return
end

-- Taneth runs every test body in a sandbox where _G is the sandbox itself,
-- so the real global table has to be taken here, at file scope
local GLOBALS = _G

Taneth("FurC:Lib", function()
  describe("LibFurnitureCatalogue chat commands", function()
    local LFC = LibFurnitureCatalogue
    local chat = LFC.Internal.Chat
    local Test = FurCDev.Test
    local DS = Test.dataset()

    -- collect what the command wrote instead of printing it
    local function capture(fn, ...)
      local lines = {}
      local realD = GLOBALS.d
      GLOBALS.d = function(msg)
        lines[#lines + 1] = tostring(msg)
      end
      local ok, err = pcall(fn, ...)
      GLOBALS.d = realD
      if not ok then
        error(err)
      end
      return lines
    end

    local function run(args)
      return capture(chat.HandleSlash, args)
    end

    it("claims both casings of the prefix", function()
      assert.equals("function", type(SLASH_COMMANDS["/lfc"]))
      assert.equals("function", type(SLASH_COMMANDS["/LFC"]))
      assert.equals(SLASH_COMMANDS["/lfc"], SLASH_COMMANDS["/LFC"])
    end)

    -- the LFC warning this prints to chat is the behaviour under test, not a failure
    it("does not take a prefix another add-on already holds", function()
      local held = function() end
      SLASH_COMMANDS["/lfc_taken_by_someone_else"] = held
      assert.is_false(chat.Claim("/lfc_taken_by_someone_else"))
      assert.equals(held, SLASH_COMMANDS["/lfc_taken_by_someone_else"])
      SLASH_COMMANDS["/lfc_taken_by_someone_else"] = nil
    end)

    it("no answer carries a line break or unrenderable markup", function()
      local args = {
        tostring(DS.dbItem),
        Test.link(DS.dbItem),
        "raw " .. DS.dbItem,
        "raw " .. (DS.craftable or DS.dbItem),
        "db",
        "",
        "not-an-item",
        "99123456",
      }
      for _, arg in ipairs(args) do
        local lines = run(arg)
        assert.is_true(#lines > 0)
        for _, text in ipairs(lines) do
          assert.is_nil(text:find("[\r\n]"))
          assert.is_nil(text:find("|u"))
        end
      end
    end)

    it("answers a bare id and an item link the same way", function()
      assert.same(run(tostring(DS.dbItem)), run(Test.link(DS.dbItem)))
    end)

    it("names the item and its sources", function()
      local lines = run(tostring(DS.dbItem))
      assert.is_true(#lines >= 2)
      -- a hit reads "<id>: <link>", so the id is readable and the link clickable
      assert.is_not_nil(lines[1]:find(DS.dbItem .. ": ", 1, true))
      assert.is_not_nil(lines[1]:find("|H", 1, true))
    end)

    it("reports database status without needing an item", function()
      local lines = run("db")
      assert.equals(1, #lines)
      assert.is_not_nil(lines[1]:find(tostring(LFC.API.GetVersion()), 1, true))
      assert.is_not_nil(lines[1]:find("state=" .. tostring(LFC.API.GetState()), 1, true))
      assert.is_not_nil(lines[1]:find("items=" .. tostring(LFC.API.GetEntryCount()), 1, true))
    end)

    it("raw names the enums instead of numbering them", function()
      local lines = run("raw " .. DS.luxItemInDB)
      assert.is_true(#lines >= 4)
      assert.is_not_nil(lines[2]:find("origin=%u%u"))
      -- a version value is a sequence position, so it is named, never numbered
      assert.is_not_nil(lines[2]:find("version=%u%u"))
      assert.is_not_nil(lines[3]:find("sources=%u%u"))
      -- the record line names the source type rather than printing its value
      assert.is_not_nil(lines[4]:find("%[1%] type=%u%u"))
      assert.is_not_nil(lines[4]:find("cost=%d+/%d+"))
      -- a locale string id is session-local, so the key replaces it entirely
      for _, text in ipairs(lines) do
        assert.is_nil(text:find("vendor=%d"))
        assert.is_nil(text:find("note=%d"))
        assert.is_nil(text:find("place=%d"))
      end
    end)

    it("raw says where a placed source is, not only a zoned one", function()
      -- location and place are exclusive on a record and mean the same thing to a
      -- reader. A record carrying a place used to print no "where" at all, while the
      -- rendered line for the same source had it, so the diagnostic said less than
      -- the thing it exists to diagnose
      local placed
      for _, id in ipairs(LibFurnitureCatalogue.API.GetItemIds()) do
        for _, record in ipairs(LibFurnitureCatalogue.API.GetSourceDetails(id)) do
          if record.source.place and not record.source.location then
            placed = id
            break
          end
        end
        if placed then
          break
        end
      end
      assert.is_not_nil(placed, "no item in the data set has a placed source")

      local seen
      for _, text in ipairs(run("raw " .. placed)) do
        if text:find("%[%d+%] type=") and text:find("place=%u") then
          seen = true
        end
      end
      assert.is_true(seen, "raw printed no place for item " .. tostring(placed))
    end)

    it("lists mats for a craftable item, a few links per line", function()
      local entry = DS.craftable and LFC.API.GetEntry(DS.craftable)
      -- the recipe APIs are client-side, so headless has no ingredients to list
      if not entry or (GetItemLinkRecipeNumIngredients(Test.link(entry.blueprint)) or 0) == 0 then
        return
      end
      local lines = run(tostring(DS.craftable))
      local mats
      for _, text in ipairs(lines) do
        if text:find(GetString(SI_FURC_CHAT_MATS), 1, true) then
          mats = text
        end
      end
      assert.is_not_nil(mats)
      -- chat truncates a long line, so a link never appears more than three times over
      local links = select(2, mats:gsub("|H", ""))
      assert.is_true(links <= 3)
    end)

    it("answers for the furnishing when given its recipe", function()
      local entry = DS.craftable and LFC.API.GetEntry(DS.craftable)
      if not entry or not entry.blueprint then
        return
      end
      -- typing the recipe answers for what it crafts, not for itself
      local byRecipe = run(tostring(entry.blueprint))
      assert.same(run(tostring(DS.craftable)), byRecipe)
      assert.is_not_nil(byRecipe[1]:find(DS.craftable .. ": ", 1, true))
      assert.is_not_nil(byRecipe[1]:find("(" .. entry.blueprint .. ": ", 1, true))
    end)

    it("does not claim a craftable item has no known source", function()
      local craftOnly
      local CRAFTING = LFC.Internal.Constants.ItemSources.CRAFTING
      for id, arr in pairs(FurC.DB) do
        if type(arr) == "table" and arr.sources and arr.sources[CRAFTING] then
          local others = 0
          for source in pairs(arr.sources) do
            if source ~= CRAFTING and not LFC.Internal.Compat.IsInjected(arr.compatSources, source) then
              others = others + 1
            end
          end
          if others == 0 then
            craftOnly = id
            break
          end
        end
      end
      assert.is_not_nil(craftOnly)
      -- crafting is filtered out of the ranked view, so its mats are the answer
      for _, text in ipairs(run(tostring(craftOnly))) do
        assert.is_nil(text:find(GetString(SI_FURC_CHAT_NO_SOURCE), 1, true))
      end
    end)

    it("shows the recipe next to a craftable furnishing", function()
      local entry = DS.craftable and LFC.API.GetEntry(DS.craftable)
      if not entry or not entry.blueprint then
        return
      end
      local lines = run(tostring(DS.craftable))
      assert.is_not_nil(lines[1]:find(tostring(entry.blueprint), 1, true))
    end)

    it("reports no mats for an item that is not craftable", function()
      local plain
      for id, arr in pairs(FurC.DB) do
        if type(arr) == "table" and not (arr.blueprint or (arr.recipeListIndex and arr.recipeIndex)) then
          plain = id
          break
        end
      end
      assert.is_not_nil(plain)
      -- the recipe APIs answer for an unrelated recipe when asked with no indices
      assert.same({}, LibFurnitureCatalogue.API.GetIngredients(Test.link(plain), LFC.API.GetEntry(plain)))
      for _, text in ipairs(run(tostring(plain))) do
        assert.is_nil(text:find(GetString(SI_FURC_CHAT_MATS), 1, true))
      end
    end)

    it("says an unknown item is unknown rather than answering empty", function()
      local lines = run("99123456")
      assert.equals(1, #lines)
      assert.is_not_nil(lines[1]:find(zo_strformat(GetString(SI_FURC_CHAT_UNKNOWN), ""), 1, true))
    end)

    -- a valid non-furniture item still renders, so it keeps its link; an id the
    -- client knows nothing about must not leave the link markup behind
    it("gives an unknown item a link only when the client can render it", function()
      local byId = run("99123456")
      local byLink = run(Test.link(99123456))
      assert.same(byId, byLink)

      for _, lines in ipairs({ byId, byLink }) do
        assert.equals(1, #lines)
        assert.is_not_nil(lines[1]:find("99123456", 1, true))
        if lines[1]:find("|H", 1, true) then
          assert.is_not_nil(lines[1]:find("99123456: ", 1, true))
        end
      end
    end)

    it("rejects an argument that is neither link nor id", function()
      local lines = run("not-an-item")
      assert.equals(1, #lines)
      assert.is_not_nil(lines[1]:find("not-an-item", 1, true))
    end)

    it("prints usage when given nothing", function()
      local lines = run("")
      assert.is_true(#lines >= 4)
      assert.is_not_nil(lines[1]:find(GetString(SI_FURC_CHAT_USAGE), 1, true))
    end)

    it("strips line breaks out of a source string that has them", function()
      assert.equals("a b", chat.Line("a\nb"))
      assert.equals("a b", chat.Line("a\r\n  b"))
      assert.is_nil(chat.Line(GetString(SI_FURC_SRC_EMPTY)):find("[\r\n]"))
    end)
  end)
end)
