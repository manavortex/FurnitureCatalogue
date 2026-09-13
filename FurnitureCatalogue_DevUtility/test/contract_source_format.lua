-- For every item in the database, the line the AddOn generates from a record is the line the library used to write from its rows
-- We check if the data files still carry all the infos we need (a missing field shows up here)
--
-- Exceptions are listed, each with the reason it is allowed to differ

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local query = LFC.Internal.Query
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

    ---itemId -> { [sourceType] = text } for one renderer
    local function libLines(itemId, entry)
      local lines = {}
      for _, line in ipairs(query.GetRankedSources(itemId, entry, false)) do
        lines[line.source] = line.text
      end
      return lines
    end

    local function addonLines(itemId, entry)
      local lines = {}
      for _, line in ipairs(FurC.SourceFormat.FormatItem(itemId, entry)) do
        lines[line.source] = line.text
      end
      return lines
    end

    it("reads the same as the library's own renderer, for every item in the database", function()
      FurC.EnsureDB(true)
      local books = collectionBooks()
      local moved, compared = {}, 0

      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        local entry = FurC.Find(itemId)
        local lib, addon = libLines(itemId, entry), addonLines(itemId, entry)
        for source, text in pairs(lib) do
          -- a collection book used to report no source at all; it names its container now
          local allowed = books[itemId] and source == src.VENDOR
          if not allowed then
            compared = compared + 1
            if addon[source] ~= text then
              if #moved < 10 then
                moved[#moved + 1] = string.format("%d/%d: %s ~= %s", itemId, source, tostring(addon[source]), text)
              end
            end
          end
        end
        for source in pairs(addon) do
          if lib[source] == nil and not books[itemId] then
            if #moved < 10 then
              moved[#moved + 1] = string.format("%d/%d: the add-on writes a line the library does not", itemId, source)
            end
          end
        end
      end

      assert.is_true(compared > 4000)
      assert.same({}, moved)
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
