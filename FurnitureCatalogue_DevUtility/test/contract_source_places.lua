-- Where a record says the item is: the four zone/place combinations, rendered.

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local constants = LFC.Internal.Constants
  local src = constants.ItemSources
  local zones, places = constants.ZoneIds, constants.PlaceIds
  local fmt = FurC.SourceFormat
  local strip = fmt.Strip

  -- a bucket with no vendor and no cost, so the record renders through the category path
  local function record(source)
    source.type = src.DROP
    return { source = source }
  end

  local function rendered(source)
    return strip(fmt.FormatRecord(record(source), 1, nil))
  end

  describe("a record's places, rendered", function()
    local ZONE, OTHER = zones.WSKYRIM, zones.MURKMIRE
    local PLACE = places.ANY

    -- the renderer strips the gender/plural control suffix off each name, so the expectations do too
    local function bare(name)
      return (fmt.Strip(name, fmt.STRIP_CONTROL))
    end
    local zoneName = bare(constants.Resolvers.Zone(ZONE))
    local otherName = bare(constants.Resolvers.Zone(OTHER))
    local placeName = bare(constants.Resolvers.Place(PLACE))

    it("names the zone when the record carries only a location", function()
      local line = rendered({ locations = { { location = ZONE } } })
      assert.is_true(#line > 0)
      assert.is_true(line:find(zoneName, 1, true) ~= nil, line .. " does not name " .. zoneName)
    end)

    it("names the place when the record carries only a place", function()
      local line = rendered({ locations = { { place = PLACE } } })
      assert.is_true(#line > 0)
      assert.is_true(line:find(placeName, 1, true) ~= nil, line .. " does not name " .. placeName)
    end)

    it("renders a zone and a place inside it as ONE location, joined by a comma", function()
      local line = rendered({ locations = { { location = ZONE, place = PLACE } } })
      assert.is_true(line:find(zoneName, 1, true) ~= nil)
      assert.is_true(line:find(placeName, 1, true) ~= nil)
      -- the pair is nested: the two names sit in one slot, so the comma joins them
      assert.is_true(
        line:find(zoneName .. ", " .. placeName, 1, true) ~= nil,
        line .. " does not nest the place inside the zone"
      )
      -- and it is not two peer locations
      assert.is_nil(line:find(" \\ ", 1, true), line .. " renders the pair as two locations")
    end)

    it("renders several zones as peer locations, joined by a backslash", function()
      local line = rendered({ locations = { { location = ZONE }, { location = OTHER } } })
      assert.is_true(line:find(zoneName, 1, true) ~= nil)
      assert.is_true(line:find(otherName, 1, true) ~= nil)
      assert.is_true(
        line:find(zoneName .. " \\ " .. otherName, 1, true) ~= nil,
        line .. " does not join the zones as peers"
      )
    end)

    it("renders a one-element list the way the scalar it replaced did", function()
      local one = rendered({ locations = { { location = ZONE } } })
      local two = rendered({ locations = { { location = ZONE }, { location = OTHER } } })
      assert.is_true(one:find(zoneName, 1, true) ~= nil)
      assert.is_nil(one:find(" \\ ", 1, true), one .. " reads as a plural")
      assert.is_true(two:find(" \\ ", 1, true) ~= nil)
    end)

    it("publishes a zone and a place inside it as one two-key placement", function()
      FurC.EnsureDB(true)
      local checked = 0
      for _, itemId in ipairs(LFC.API.GetItemIds()) do
        for _, record in ipairs(LFC.API.GetSourceDetails(itemId)) do
          local source = record.source
          assert.is_nil(rawget(source, "location"), itemId .. " still publishes a scalar location")
          assert.is_nil(rawget(source, "place"), itemId .. " still publishes a scalar place")
          for _, placement in ipairs(source.locations or {}) do
            if placement.location and placement.place then
              checked = checked + 1
            end
          end
        end
      end
      assert.is_true(checked > 0, "no record publishes a zone with a place inside it")
    end)

    it("keeps the three shapes apart", function()
      local one = rendered({ locations = { { location = ZONE } } })
      local nested = rendered({ locations = { { location = ZONE, place = PLACE } } })
      local several = rendered({ locations = { { location = ZONE }, { location = OTHER } } })
      assert.is_true(one ~= nested)
      assert.is_true(one ~= several)
      assert.is_true(nested ~= several)
    end)
  end)
end)
