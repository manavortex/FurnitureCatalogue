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
    ---@param has fun(source: table): boolean
    local function firstDetailWhere(has)
      for itemId, record in pairs(exportRecords()) do
        for index, detail in pairs(record.info or {}) do
          local sourceType = record.sources[index]
          for _, rec in ipairs(api.GetSourceDetails(itemId)) do
            if rec.source.type == sourceType and has(rec.source) then
              return detail, itemId, sourceType
            end
          end
        end
      end
    end

    local function firstDetailWith(field)
      return firstDetailWhere(function(source)
        return source[field] ~= nil
      end)
    end

    local function firstPlacementDetail(part)
      return firstDetailWhere(function(source)
        for _, placement in ipairs(source.locations or {}) do
          if placement[part] ~= nil then
            return true
          end
        end
        return false
      end)
    end

    it("resolves the library's identifiers to text rather than exporting the ids", function()
      -- vendor and location columns, which is the defect this pins
      local vendorDetail = firstDetailWith("vendor")
      assert.is_not_nil(vendorDetail, "no exported record carries a vendor")
      assert.equals("string", type(vendorDetail.vendor))
      assert.is_true(#vendorDetail.vendor > 0)
      assert.is_nil(tonumber(vendorDetail.vendor), "vendor exported as a bare id: " .. tostring(vendorDetail.vendor))

      local zoneDetail = firstPlacementDetail("location")
      assert.is_not_nil(zoneDetail, "no exported record carries a location")
      assert.equals("string", type(zoneDetail.location))
      assert.is_true(#zoneDetail.location > 0)
      assert.is_nil(tonumber(zoneDetail.location), "location exported as a bare id: " .. tostring(zoneDetail.location))
    end)

    it("gives a place the same column a zone gets, so the artifact keeps one 'where'", function()
      local placeDetail, itemId, sourceType = firstPlacementDetail("place")
      if not placeDetail then
        return -- no placed source in this data set, nothing to assert
      end
      local placeId
      for _, rec in ipairs(api.GetSourceDetails(itemId)) do
        if rec.source.type == sourceType then
          for _, placement in ipairs(rec.source.locations or {}) do
            placeId = placeId or placement.place
          end
        end
      end
      assert.is_not_nil(placeId)
      -- the export strips ESO's gender/pluralisation suffix, so compare against the
      -- resolved place with the same suffix removed
      local resolved = constants.Resolvers.Place(placeId):gsub("%^%a[%a,]*", "")
      assert.equals(resolved, placeDetail.location)
    end)

    it("exports the container containing the item contained within", function()
      local seen = false
      for itemId, record in pairs(exportRecords()) do
        for index, detail in pairs(record.info or {}) do
          local sourceType = record.sources[index]
          for _, rec in ipairs(api.GetSourceDetails(itemId)) do
            if rec.source.type == sourceType and rec.source.container then
              seen = true
              assert.equals(rec.source.container, detail.fromItem)
            end
          end
        end
      end
      assert.is_true(seen, "no source in the database carries a container")
    end)
  end)
end)
