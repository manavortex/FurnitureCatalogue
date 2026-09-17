-- Published record vocabulary contract: every id a record publishes resolves.
--
-- A de-baked row states ids and the consumer renders them, so an id with nothing behind
-- it is invisible: GetString of an unregistered id is the empty string, and a qualifier
-- that renders as nothing looks exactly like a row that never had one. The static suite
-- checks the data files for a reference no vocabulary declares; this is the other
-- direction, over the records the library actually publishes, where four fields are
-- synthesised at query time and never appear in a data file at all.
--
-- Named exceptions, with the reason each survives:
--   * achievement, quest, houses, collectible are the game's own ids with no vocabulary
--     behind them - only the client can say whether one resolves
--   * npcClass ids belong to the client too, but the library declares their names, so
--     the check is membership of that vocabulary rather than a lookup
--   * two quest reward coffers are stated as raw item ids, see RAW_CONTAINERS
--   * a note may be free text, which is the row contract's one string-valued field
--
-- Taneth's assert.is_true takes no message, so every diagnosis here is carried by the
-- compared value instead: the offenders are collected and compared against nothing.

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local LFC = LibFurnitureCatalogue
  local api = LFC.API
  local constants = LFC.Internal.Constants
  local Test = FurCDev.Test

  -- Reward coffers the Containers vocabulary does not name (raw strings ok at the moment)
  local RAW_CONTAINERS = {
    [126030] = "Ashlander daily reward box",
    [145568] = "Tribal Treasure Crate",
  }

  -- The row contract allows a bare string on `note` only
  local NOTE_LITERALS = 85

  local function valueSet(vocabulary)
    local values = {}
    for _, value in pairs(vocabulary or {}) do
      values[value] = true
    end
    return values
  end

  local zones = valueSet(constants.ZoneIds)
  local places = valueSet(constants.PlaceIds)
  local npcs = valueSet(constants.NpcIds)
  local npcClasses = valueSet(constants.NpcClassIds)
  local npcGroups = valueSet(constants.NpcGroupIds)
  local crates = valueSet(constants.CrownCrateIds)
  local skillLines = valueSet(constants.SkillLineIds)
  local events = valueSet(constants.EventIds)
  local bundles = valueSet(constants.ItemBundles)
  local tomesPacks = valueSet(constants.TomesPacks)
  local itemPacks = valueSet(constants.ItemPacks)
  local books = valueSet(constants.BookContainers)

  -- A Containers entry is a rendered item link; a record publishes the item id out of it
  local containers = {}
  for _, link in pairs(constants.Containers or {}) do
    local itemId = type(link) == "string" and link:match("|H%d:item:(%d+):")
    if itemId then
      containers[tonumber(itemId)] = true
    end
  end

  ---Every source record of every item in the database, with the item it belongs to
  local scan
  local function scanned()
    if scan then
      return scan
    end
    Test.ensureDB()
    scan = {}
    for itemId in pairs(FurC.DB) do
      if type(itemId) == "number" then
        for _, record in ipairs(api.GetSourceDetails(itemId) or {}) do
          scan[#scan + 1] = { item = itemId, source = record.source }
        end
      end
    end
    return scan
  end

  ---Every element of a field that may be one value or a list of alternatives
  local function elements(value)
    if value == nil then
      return {}
    end
    if type(value) == "table" and value[1] ~= nil then
      return value
    end
    return { value }
  end

  ---first few offenders showing nothing and their count
  local function report(problems)
    if #problems == 0 then
      return ""
    end
    local shown = {}
    for index = 1, math.min(#problems, 5) do
      shown[index] = problems[index]
    end
    if #problems > 5 then
      shown[#shown + 1] = string.format("and %d more", #problems - 5)
    end
    return table.concat(shown, " | ")
  end

  ---A field nothing published is a check that inspected nothing
  local function unexercised(seen, fields)
    local missing = {}
    for _, field in ipairs(fields) do
      if (seen[field] or 0) == 0 then
        missing[#missing + 1] = field .. " is published by no record"
      end
    end
    return report(missing)
  end

  describe("published record vocabulary", function()
    it("publishes only string ids the library registered", function()
      local keys = LFC.Internal.StringKeys
      assert.equals("table", type(keys))
      assert.are_not.equals(nil, next(keys))

      local problems, seen = {}, {}
      local function checkString(item, field, id)
        seen[field] = (seen[field] or 0) + 1
        if keys[id] == nil then
          problems[#problems + 1] =
            string.format("item %d: %s = %s is no string this library registered", item, field, tostring(id))
        elseif GetString(id) == "" then
          problems[#problems + 1] = string.format("item %d: %s = %s renders as nothing", item, field, tostring(id))
        end
      end

      for _, found in ipairs(scanned()) do
        for _, field in ipairs({ "vendor", "category", "event", "bundle", "itemPack", "rarity" }) do
          if found.source[field] ~= nil then
            checkString(found.item, field, found.source[field])
          end
        end
        -- a place sits inside a location now, and only some locations name one
        for _, placement in ipairs(found.source.locations or {}) do
          if placement.place ~= nil then
            checkString(found.item, "locations.place", placement.place)
          end
        end
        for _, id in ipairs(elements(found.source.containerKind)) do
          checkString(found.item, "containerKind", id)
        end
      end

      assert.equals("", report(problems))
      assert.equals(
        "",
        unexercised(
          seen,
          { "vendor", "locations.place", "category", "event", "bundle", "itemPack", "rarity", "containerKind" }
        )
      )
    end)

    it("publishes only ids its vocabularies declare", function()
      local problems, seen = {}, {}
      local function check(item, field, id, vocabulary, vocabularyName)
        seen[field] = (seen[field] or 0) + 1
        if vocabulary[id] ~= true then
          problems[#problems + 1] =
            string.format("item %d: %s = %s is in no %s", item, field, tostring(id), vocabularyName)
        end
      end

      for _, found in ipairs(scanned()) do
        local source, item = found.source, found.item
        for _, placement in ipairs(source.locations or {}) do
          if placement.location ~= nil then
            check(item, "locations.location", placement.location, zones, "ZoneIds")
          end
          if placement.place ~= nil then
            check(item, "locations.place", placement.place, places, "PlaceIds")
          end
        end
        if source.vendor ~= nil then
          check(item, "vendor", source.vendor, npcs, "NpcIds")
        end
        if source.event ~= nil then
          check(item, "event", source.event, events, "EventIds")
        end
        if source.bundle ~= nil then
          check(item, "bundle", source.bundle, bundles, "ItemBundles")
        end
        if source.itemPack ~= nil then
          check(item, "itemPack", source.itemPack, tomesPacks, "TomesPacks")
        end
        if source.skillLine ~= nil then
          check(item, "skillLine", source.skillLine, skillLines, "SkillLineIds")
        end
        -- `0` is the sentinel for a crate the data cannot name
        if source.crate ~= nil and source.crate ~= 0 then
          check(item, "crate", source.crate, crates, "CrownCrateIds")
        end
        for _, class in ipairs(elements(source.npcClass)) do
          check(item, "npcClass", class, npcClasses, "NpcClassIds")
        end
        for _, pack in ipairs(source.packs or {}) do
          seen.packs = (seen.packs or 0) + 1
          if not (itemPacks[pack] or tomesPacks[pack]) then
            problems[#problems + 1] =
              string.format("item %d: packs holds %s, which is no declared pack", item, tostring(pack))
          end
        end
        for _, field in ipairs({ "container", "partOf" }) do
          local id = source[field]
          if id ~= nil then
            seen[field] = (seen[field] or 0) + 1
            if not (containers[id] or books[id] or itemPacks[id] or RAW_CONTAINERS[id]) then
              problems[#problems + 1] =
                string.format("item %d: %s = %s is in no container vocabulary", item, field, tostring(id))
            end
          end
        end
      end

      assert.equals("", report(problems))
      assert.equals(
        "",
        unexercised(seen, {
          "locations.location",
          "locations.place",
          "vendor",
          "event",
          "bundle",
          "itemPack",
          "skillLine",
          "crate",
          "npcClass",
          "packs",
          "container",
          "partOf",
        })
      )
    end)

    it("keeps a note to a string id, a tagged part, or the free text the contract allows", function()
      local keys = LFC.Internal.StringKeys
      local problems, seen = {}, {}
      local literals = 0

      for _, found in ipairs(scanned()) do
        for _, element in ipairs(elements(found.source.note)) do
          if type(element) == "number" then
            seen.id = (seen.id or 0) + 1
            if keys[element] == nil then
              problems[#problems + 1] =
                string.format("item %d: note %s is no string this library registered", found.item, tostring(element))
            end
          elseif type(element) == "string" then
            literals = literals + 1
          elseif type(element) == "table" then
            seen.part = (seen.part or 0) + 1
            local tag, value = next(element)
            local resolves = (tag == "npc" and npcs[value])
              or (tag == "npcClass" and npcClasses[value])
              or (tag == "npcGroup" and npcGroups[value])
              or (tag == "item" and type(value) == "number")
            if not resolves then
              problems[#problems + 1] = string.format(
                "item %d: note part {%s = %s} resolves to nothing",
                found.item,
                tostring(tag),
                tostring(value)
              )
            end
          else
            problems[#problems + 1] = string.format("item %d: note holds a %s", found.item, type(element))
          end
        end
      end

      if literals > NOTE_LITERALS then
        problems[#problems + 1] =
          string.format("%d free-text notes, up from %d - the free-text shape only shrinks", literals, NOTE_LITERALS)
      end

      assert.equals("", report(problems))
      assert.equals("", unexercised(seen, { "id", "part" }))
    end)
  end)
end)
