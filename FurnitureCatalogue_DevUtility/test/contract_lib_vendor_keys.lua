-- FurC.AchievementVendors key contract: every key is an id, and a location says which vocabulary it belongs to

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local constants = LFC.Internal.Constants
  local query = LFC.Internal.Query

  local function isFrom(idTable, value)
    for _, id in pairs(idTable) do
      if id == value then
        return true
      end
    end
    return false
  end

  ---Every row as { version, location, vendor, itemId, row }
  local function vendorRows()
    local rows = {}
    for version, versionData in pairs(FurC.AchievementVendors) do
      for location, locationData in pairs(versionData) do
        for vendor, vendorData in pairs(locationData) do
          for itemId, row in pairs(vendorData) do
            rows[#rows + 1] = { version = version, location = location, vendor = vendor, itemId = itemId, row = row }
          end
        end
      end
    end
    return rows
  end

  describe("FurC.AchievementVendors keys", function()
    it("are ids from the vocabularies, and a location is a zone or a place", function()
      local rows = vendorRows()
      assert.is_true(#rows > 0, "no rows in the vendor tree")
      local zones, places = 0, 0
      for _, found in ipairs(rows) do
        local where = string.format("row %s", tostring(found.itemId))
        assert.is_true(isFrom(constants.NpcIds, found.vendor), where .. ": vendor key is not an NpcIds value")
        if constants.IsZoneId[found.location] then
          zones = zones + 1
          assert.is_true(isFrom(constants.ZoneIds, found.location), where .. ": IsZoneId disagrees with ZoneIds")
        else
          places = places + 1
          assert.is_true(
            isFrom(constants.PlaceIds, found.location),
            where .. ": location key is in neither ZoneIds nor PlaceIds"
          )
        end
      end
      -- both halves are exercised, or the membership rule is untested
      assert.is_true(zones > 0, "no row is keyed by a zone")
      assert.is_true(places > 0, "no row is keyed by a place")
    end)

    it("give the Mages Guild mystic the book collections on top of her own stock", function()
      local books = FurC.Books[constants.Versioning.HOMESTEAD]
      local bookCount = 0
      for _ in pairs(books) do
        bookCount = bookCount + 1
      end
      assert.is_true(bookCount > 0, "FurC.Books[HOMESTEAD] is empty")

      FurC.EnsureDB(true)
      local mages = FurC.AchievementVendors[constants.Versioning.HOMESTEAD][constants.PlaceIds.GUILD_MAGES]
      local stock = mages[constants.NpcIds.MAGES_MYSTIC]
      for itemId in pairs(books) do
        assert.is_not_nil(stock[itemId], string.format("book %d is not in the mystic's stock", itemId))
      end
    end)

    it("draw zones and places from id spaces that do not overlap", function()
      for key, id in pairs(constants.ZoneIds) do
        assert.is_false(
          constants.IsPlaceId[id] == true,
          string.format("ZoneIds.%s and a PlaceIds member share the value %s", key, tostring(id))
        )
      end
    end)

    it("name the guild that sells them, not only the merchant", function()
      local thievesGuild = constants.SkillLineIds.LEGERDEMAIN
      local sold, byMerchant = {}, {}
      for _, found in ipairs(vendorRows()) do
        if type(found.row) == "table" and found.row.skillLine == thievesGuild then
          sold[found.itemId] = true
        end
        if found.vendor == constants.NpcIds.THIEVES_MERCH then
          byMerchant[found.itemId] = true
        end
      end
      local counted = 0
      for itemId in pairs(byMerchant) do
        counted = counted + 1
        assert.is_true(sold[itemId] == true, string.format("item %d at that merchant names no guild", itemId))
      end
      assert.is_true(counted > 0, "the outlaw refuge merchant sells nothing")

      FurC.EnsureDB(true)
      local itemId = next(byMerchant)
      local named = false
      for _, record in ipairs(LFC.API.GetSourceDetails(itemId)) do
        if record.source.skillLine == thievesGuild then
          named = true
        end
      end
      assert.is_true(named, string.format("GetSourceDetails(%d) names no guild", itemId))
    end)

    it("render a line naming the location the key points at", function()
      local checked = 0
      for _, found in ipairs(vendorRows()) do
        local line = query.GetAchievementVendorSource(found.itemId, { version = found.version }, false)
        local name = constants.IsZoneId[found.location] and constants.Resolvers.Zone(found.location)
          or constants.Resolvers.Place(found.location)
        if line:find(name, 1, true) then
          checked = checked + 1
        end
      end
      assert.is_true(checked > 0, "no vendor row renders its location")
    end)
  end)
end)
