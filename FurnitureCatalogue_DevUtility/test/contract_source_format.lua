-- Behaviour of the lines the AddOn composes from published records
--

if not Taneth then
  return
end

-- Taneth runs every test body in a sandbox where _G is the sandbox itself, so the real global table has to be taken here
local GLOBALS = _G

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local src = LFC.Internal.Constants.ItemSources

  describe("source lines composed by the add-on", function()
    ---Every book sold only as part of a collection
    local function collectionBooks()
      local books = {}
      for containerId, collection in pairs(FurC.BookCollections or {}) do
        for _, bookId in ipairs(collection.contents or {}) do
          books[bookId] = containerId
        end
      end
      return books
    end

    it("writes a line for every source every item publishes", function()
      FurC.EnsureDB(true)
      local silent, compared = {}, 0

      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        local entry = FurC.Find(itemId)
        local written = {}
        for _, line in ipairs(FurC.SourceFormat.FormatItem(itemId, entry)) do
          written[line.source] = line.text
        end
        for _, record in ipairs(LFC.API.GetSourceDetails(itemId)) do
          local sourceType = record.source.type
          -- crafting is its own line, not one of the ranked ones
          if sourceType ~= src.CRAFTING then
            compared = compared + 1
            local text = written[sourceType]
            if text == nil or text == "" then
              if #silent < 10 then
                silent[#silent + 1] = string.format("%d/%d: a published record reaches no line", itemId, sourceType)
              end
            end
          end
        end
      end

      assert.is_true(compared > 4000)
      assert.same({}, silent)
    end)

    it("writes a craftable's line from its own record, or from what it is made of", function()
      FurC.EnsureDB(true)
      local silent, compared, fromRecord = {}, 0, 0

      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        local entry = FurC.Find(itemId)
        if entry.sources and entry.sources[src.CRAFTING] then
          compared = compared + 1
          local blueprint = FurC.SourceFormat.RecipeSource(itemId)
          if blueprint then
            fromRecord = fromRecord + 1
            -- the crafting line is the blueprint's line whenever a record names one
            if FurC.SourceFormat.CraftingLine(itemId, entry, false) ~= blueprint and #silent < 10 then
              silent[#silent + 1] = string.format("%d: the crafting line is not the blueprint's", itemId)
            end
          end
        end
      end

      assert.is_true(compared > 3000)
      assert.is_true(fromRecord > 0, "no craftable has a record naming its blueprint")
      assert.same({}, silent)
    end)

    -- Feeding a recipe in is the only way to see the material half of a crafting line at all
    it("writes the material list as links, and as names when they are not wanted or will not fit", function()
      local craftable = FurCDev.Test.dataset().craftable
      local entry = FurC.Find(craftable)

      -- three is enough to see an order and a separator, and already crowds a chat message
      local INGREDIENTS = 3
      -- LINK_STYLE_DEFAULT, which is what a material list wants: no brackets around the name
      local function ingredientLink(index)
        return string.format("|H0:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", 4000 + index)
      end
      local stubs = {
        GetItemLinkRecipeNumIngredients = function()
          return INGREDIENTS
        end,
        GetItemLinkRecipeIngredientInfo = function(_, index)
          return "ingredient " .. index, 0, index
        end,
        GetItemLinkRecipeIngredientItemLink = function(_, index)
          return ingredientLink(index)
        end,
        GetRecipeInfo = function()
          return true, "recipe", INGREDIENTS
        end,
        GetRecipeIngredientItemInfo = function(_, _, index)
          return "ingredient " .. index, 0, index
        end,
        GetRecipeIngredientItemLink = function(_, _, index)
          return ingredientLink(index)
        end,
      }
      local saved = {}
      for name, stub in pairs(stubs) do
        saved[name], GLOBALS[name] = GLOBALS[name], stub
      end

      local ok, err = pcall(function()
        assert.equals(INGREDIENTS, NonContiguousCount(LFC.API.GetIngredients(craftable, entry)))

        local linked = FurC.SourceFormat.FormatMaterials(craftable, entry)
        -- every ingredient, as an un-bracketed link, with its quantity
        assert.equals(INGREDIENTS, select(2, linked:gsub("|H0:item:", "")))
        assert.is_nil(linked:find("|H1:item:", 1, true), linked)
        for index = 1, INGREDIENTS do
          assert.is_true(linked:find(index .. "x ", 1, true) ~= nil, linked)
        end
        -- we want a fixed order, so the same item does not list them differently twice
        local lastId = 0
        for id in linked:gmatch("|H0:item:(%d+):") do
          assert.is_true(tonumber(id) > lastId, "ingredients are not in a stable order: " .. linked)
          lastId = tonumber(id)
        end

        local named = FurC.SourceFormat.FormatMaterials(craftable, entry, true)
        assert.is_nil(named:find("|H", 1, true), named)
        assert.is_true(#named < #linked)

        -- an entry that names no recipe at all says so rather than rendering an empty list
        assert.equals(FurC.SourceFormat.NoMaterials, FurC.SourceFormat.FormatMaterials(craftable, {}))
      end)

      for name in pairs(stubs) do
        GLOBALS[name] = saved[name]
      end
      assert.equals("ok", (ok and "ok") or tostring(err))
    end)

    -- The formatter renders what it is asked for
    it("posts names to chat once the links would not fit one message", function()
      local craftable = FurCDev.Test.dataset().craftable
      local entry = FurC.Find(craftable)

      local MANY = 8
      local stubs = {
        GetItemLinkRecipeNumIngredients = function()
          return MANY
        end,
        GetItemLinkRecipeIngredientInfo = function(_, index)
          return "ingredient " .. index, 0, index
        end,
        GetItemLinkRecipeIngredientItemLink = function(_, index)
          return string.format("|H0:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", 4000 + index)
        end,
      }
      local saved = {}
      for name, stub in pairs(stubs) do
        saved[name], GLOBALS[name] = GLOBALS[name], stub
      end

      local ok, err = pcall(function()
        -- the formatter still hands out links: it was asked for links
        local linked = FurC.SourceFormat.FormatMaterials(craftable, entry)
        assert.is_true(linked:find("|H0:item:", 1, true) ~= nil)
        assert.is_false(FurC.ChatFits(linked))

        -- the chat path is the one that notices and asks again
        local posted = FurC.MaterialsForChat(craftable, entry)
        assert.is_nil(posted:find("|H", 1, true), posted)
        assert.is_true(FurC.ChatFits(posted))

        -- and leaves the links alone while they do fit
        stubs.GetItemLinkRecipeNumIngredients = function()
          return 1
        end
        GLOBALS.GetItemLinkRecipeNumIngredients = stubs.GetItemLinkRecipeNumIngredients
        local short = FurC.MaterialsForChat(craftable, entry)
        assert.is_true(short:find("|H0:item:", 1, true) ~= nil, short)
      end)

      for name in pairs(stubs) do
        GLOBALS[name] = saved[name]
      end
      assert.equals("ok", (ok and "ok") or tostring(err))
    end)

    it("measures a chat message by what the input takes", function()
      assert.is_true(FurC.ChatFits(string.rep("x", 350)))
      assert.is_false(FurC.ChatFits(string.rep("x", 351)))
      assert.is_true(FurC.ChatFits(nil))
    end)

    it("a book sold only inside a collection names its container, its vendor and its price", function()
      FurC.EnsureDB(true)
      local books = collectionBooks()
      assert.is_true(next(books) ~= nil)

      for bookId, containerId in pairs(books) do
        local entry = FurC.Find(bookId)
        local line
        for _, candidate in ipairs(FurC.SourceFormat.FormatItem(bookId, entry)) do
          if candidate.source == src.VENDOR then
            line = candidate.text
          end
        end
        assert.is_not_nil(line, string.format("book %d has no vendor line", bookId))
        -- the container as a link, the vendor, and a price the line cannot be read without
        assert.is_true(
          line:find(tostring(containerId), 1, true) ~= nil,
          string.format("book %d does not name container %d: %s", bookId, containerId, line)
        )
        assert.is_true(line:find("|H", 1, true) ~= nil)
        assert.is_true(line:find(":currency:", 1, true) ~= nil, string.format("book %d names no price", bookId))
      end
    end)

    it("a collection container says how many furnishings it holds", function()
      FurC.EnsureDB(true)
      for containerId, collection in pairs(FurC.BookCollections or {}) do
        local text = FurC.SourceFormat.FormatContents(containerId)
        assert.is_not_nil(text, string.format("container %d lists no contents", containerId))
        assert.is_true(
          text:find(tostring(#collection.contents), 1, true) ~= nil,
          string.format("container %d does not say it holds %d: %s", containerId, #collection.contents, text)
        )
        -- and the count reaches the line the item list shows
        local entry = FurC.Find(containerId)
        local description = FurC.SourceFormat.FormatDescription(containerId, entry)
        assert.is_true(description:find(text, 1, true) ~= nil, description)
      end
    end)
  end)
end)
