-- The published record's shape rule, over every record the library publishes.

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local api = LibFurnitureCatalogue.API
  local Test = FurCDev.Test

  -- Fields that may take more than one shape, and why each survives
  local MULTI_SHAPE = {
    -- a string id, a literal, a tagged part, or a list of any of those
    note = "a note is a tagged value",
  }

  -- `location` beside `locations` is the plural twin the convention forbids
  local PLURAL_TWINS = {
    location = "locations",
    place = "locations",
  }

  -- A placement names a zone, a place, or both: ONE shape with optional members
  local PLACEMENT_KEYS = { location = true, place = true }
  local function isPlacement(value)
    local named = 0
    for key in pairs(value) do
      if not PLACEMENT_KEYS[key] then
        return false
      end
      named = named + 1
    end
    return named > 0
  end

  local function shapeOf(value)
    if type(value) ~= "table" then
      return type(value)
    end
    if value[1] ~= nil then
      return "list[" .. shapeOf(value[1]) .. "]"
    end
    -- an empty table is the empty-list sentinel, not a record with no tag
    if next(value) == nil then
      return "list[]"
    end
    if isPlacement(value) then
      return "placement"
    end
    return "record{" .. tostring(next(value)) .. "}"
  end

  ---The shapes a field takes, with the empty list folded into the list it belongs to (ex. `houses = {}` says "houses)
  local function shapesOf(by)
    local shapes, lists = {}, 0
    for shape in pairs(by) do
      if shape:find("^list%[") and shape ~= "list[]" then
        lists = lists + 1
      end
    end
    for shape in pairs(by) do
      if not (shape == "list[]" and lists > 0) then
        shapes[#shapes + 1] = shape
      end
    end
    return shapes
  end

  local scan
  local function shapes()
    if scan then
      return scan
    end
    Test.ensureDB()
    scan = { fields = {}, records = 0 }
    local function note(field, value)
      local by = scan.fields[field] or {}
      scan.fields[field] = by
      local shape = shapeOf(value)
      by[shape] = (by[shape] or 0) + 1
    end
    for itemId in pairs(FurC.DB) do
      if type(itemId) == "number" then
        for _, record in ipairs(api.GetSourceDetails(itemId)) do
          scan.records = scan.records + 1
          for field, value in pairs(record.source) do
            note(field, value)
          end
          for field, value in pairs(record.cost or {}) do
            note("cost." .. field, value)
          end
          if record.lastSeen ~= nil then
            note("lastSeen", record.lastSeen)
          end
        end
      end
    end
    return scan
  end

  local function written(by)
    local parts = {}
    for shape, count in pairs(by) do
      parts[#parts + 1] = string.format("%s=%d", shape, count)
    end
    table.sort(parts)
    return table.concat(parts, " ")
  end

  local function report(problems)
    table.sort(problems)
    return table.concat(problems, " | ")
  end

  describe("published record shape", function()
    it("writes every field one way", function()
      local found = shapes()
      assert.is_true(found.records > 1000)

      local problems = {}
      for field, by in pairs(found.fields) do
        local count = #shapesOf(by)
        if count > 1 and not MULTI_SHAPE[field] then
          problems[#problems + 1] = string.format("%s is written %d ways (%s)", field, count, written(by))
        end
      end
      assert.equals("", report(problems))
    end)

    it("gives no field a plural twin", function()
      local found = shapes()
      local problems = {}
      for field in pairs(found.fields) do
        local plural = field .. "s"
        if found.fields[plural] and PLURAL_TWINS[field] ~= plural then
          problems[#problems + 1] = string.format("%s beside %s", field, plural)
        end
      end
      assert.equals("", report(problems))
    end)
  end)
end)
