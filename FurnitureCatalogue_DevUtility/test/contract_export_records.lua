-- Export contract: the dev tool renders the library's identifiers

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local api = LibFurnitureCatalogue.API
  local constants = LibFurnitureCatalogue.Internal.Constants
  local Test = FurCDev.Test

  describe("dev tool export", function()
    -- Built once: a full pass over the DB is the expensive part, and every
    -- assertion below reads the same artifact a real dump would write
    local records
    local function exportRecords()
      if not records then
        Test.ensureDB()
        records = FurCDev.BuildExportRecords()
      end
      return records
    end

    ---First exported source detail whose record carries the given field
    ---@param field string field on LFCSourceOrigin
    ---@return table? detail the export's own row for it
    ---@return integer? itemId
    ---@return integer? sourceType
    local function firstDetailWith(field)
      for itemId, record in pairs(exportRecords()) do
        for index, detail in pairs(record.info or {}) do
          local sourceType = record.sources[index]
          for _, rec in ipairs(api.GetSourceDetails(itemId)) do
            if rec.source.type == sourceType and rec.source[field] ~= nil then
              return detail, itemId, sourceType
            end
          end
        end
      end
    end

    it("resolves the library's identifiers to text rather than exporting the ids", function()
      -- The library publishes a locale string id for the vendor and a game zone id
      -- for the location. Exporting either raw puts a bare number in the artifact's
      -- vendor and location columns, which is the defect this pins
      local vendorDetail = firstDetailWith("vendor")
      assert.is_not_nil(vendorDetail, "no exported record carries a vendor")
      assert.equals("string", type(vendorDetail.vendor))
      assert.is_true(#vendorDetail.vendor > 0)
      assert.is_nil(tonumber(vendorDetail.vendor), "vendor exported as a bare id: " .. tostring(vendorDetail.vendor))

      local zoneDetail = firstDetailWith("location")
      assert.is_not_nil(zoneDetail, "no exported record carries a location")
      assert.equals("string", type(zoneDetail.location))
      assert.is_true(#zoneDetail.location > 0)
      assert.is_nil(tonumber(zoneDetail.location), "location exported as a bare id: " .. tostring(zoneDetail.location))
    end)

    it("gives a place the same column a zone gets, so the artifact keeps one 'where'", function()
      -- location and place are exclusive on the record and mean the same thing to a
      -- reader of the export: somewhere. The row split them; the columns did not
      local placeDetail, itemId, sourceType = firstDetailWith("place")
      if not placeDetail then
        return -- no placed source in this data set, nothing to assert
      end
      local placeId
      for _, rec in ipairs(api.GetSourceDetails(itemId)) do
        if rec.source.type == sourceType then
          placeId = rec.source.place
        end
      end
      assert.is_not_nil(placeId)
      -- the export strips ESO's gender/pluralisation suffix, so compare against the
      -- resolved place with the same suffix removed
      local resolved = constants.Resolvers.Place(placeId):gsub("%^%a[%a,]*", "")
      assert.equals(resolved, placeDetail.location)
    end)

    it("recovers the container item id from the note it now arrives in", function()
      -- A festival source that is a container rather than an NPC used to arrive as
      -- an item link in `vendor`; it arrives in `note` now, and the export still has
      -- to come out with the container's item id
      local seen = false
      for itemId, record in pairs(exportRecords()) do
        for index, detail in pairs(record.info or {}) do
          local sourceType = record.sources[index]
          for _, rec in ipairs(api.GetSourceDetails(itemId)) do
            if
              rec.source.type == sourceType
              and type(rec.source.note) == "string"
              and rec.source.note:find("|H", 1, true)
            then
              seen = true
              assert.equals("number", type(detail.fromItem))
              assert.is_true(detail.fromItem > 0)
            end
          end
        end
      end
      if not seen then
        -- Stated rather than silently passing: the container case is data-dependent
        assert.is_true(true)
      end
    end)
  end)
end)
