-- Benchmark scenarios: Testing if the scenarios still do anything
--
-- Who benches the benchmark?

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local LFC = LibFurnitureCatalogue
  local scenarios = FurCDev.BenchmarkScenarios
  local globals = getfenv(FurCDev.RunAllBenchmarks)

  ---Collect the profiler markers a list of steps emits
  ---@param steps table[] step list as a scenario's steps() returns it
  ---@return string[] labels without the "furcbench|" prefix
  local function markersOf(steps)
    local seen = {}
    local previous = globals.RecordScriptProfilerUserEvent
    globals.RecordScriptProfilerUserEvent = function(label)
      seen[#seen + 1] = (tostring(label):gsub("^furcbench|", ""))
    end
    for _, step in ipairs(steps) do
      step.fn()
    end
    globals.RecordScriptProfilerUserEvent = previous
    return seen
  end

  ---@param labels string[]
  ---@param pattern string
  ---@return string|nil first match
  local function firstMatching(labels, pattern)
    for _, label in ipairs(labels) do
      if label:find(pattern) then
        return label
      end
    end
  end

  ---Items the source dropdown keeps for one selection, through the real filter
  ---@param ddSource integer
  ---@return integer count
  local function keptCount(ddSource)
    local previous = FurC.GetDropdownChoice("Source")
    FurC.settings.filterCraftingTypeAll = true
    FurC.settings.filterQualityAll = true
    FurC.settings.filterFurnCategoryAll = true
    FurC.settings.filterFurnSubcategoryAll = true
    FurC.settings.hideBooks = false
    FurC.DropdownChoices["Version"] = 1
    FurC.DropdownChoices["Character"] = 1
    FurC.SearchFilter = ""
    FurC.DropdownChoices["Source"] = ddSource
    FurC.SetFilter(false, true) -- skipRefresh: no GUI to refresh

    local kept = 0
    for _, itemId in ipairs(LFC.API.GetItemIds()) do
      if FurC.MatchFilter(itemId, LFC.Internal.Query.Find(itemId)) then
        kept = kept + 1
      end
    end

    FurC.DropdownChoices["Source"] = previous
    FurC.SetFilter(false, true)
    return kept
  end

  describe("benchmark scenario table", function()
    it("exports the scenarios", function()
      assert.equals("function", type(scenarios))
      assert.is_true(#scenarios() >= 7)
    end)

    it("every scenario has a label and a steps builder", function()
      for id, scenario in ipairs(scenarios()) do
        assert.is_true(type(scenario.label) == "string" and scenario.label ~= "", "scenario " .. id)
        assert.equals("function", type(scenario.steps), "scenario " .. id)
      end
    end)

    it("every filter scenario picks a choice the dropdown still offers", function()
      for id, scenario in ipairs(scenarios()) do
        local filter = scenario.filter
        if filter then
          local choices = FurC.DropdownData["Choices" .. filter.dropdown]
          assert.is_true(
            choices ~= nil and choices[filter.value] ~= nil,
            string.format(
              "scenario %d selects a %s choice that is not offered: %s",
              id,
              filter.dropdown,
              tostring(filter.value)
            )
          )
        end
      end
    end)

    it("every source-filter scenario matches items, so it does not time an empty list", function()
      for id, scenario in ipairs(scenarios()) do
        local filter = scenario.filter
        if filter and filter.dropdown == "Source" then
          local kept = keptCount(filter.value)
          assert.is_true(kept > 50, string.format("scenario %d (%s) keeps only %d items", id, scenario.label, kept))
        end
      end
    end)

    it("the rebuild scenario runs last, because it invalidates everything before it", function()
      local all = scenarios()
      assert.is_true(all[#all].label:find("rebuild") ~= nil)
    end)
  end)

  describe("benchmark scenario steps", function()
    ---Run a scenario's steps with the dropdown choice restored afterwards
    ---@param scenario table
    ---@return string[] markers
    local function runScenario(scenario)
      local saved = FurC.DropdownChoices["Source"]
      local labels = markersOf(scenario.steps())
      FurC.DropdownChoices["Source"] = saved
      return labels
    end

    it("a filter scenario records how many rows its filter left", function()
      local labels = runScenario(scenarios()[4])
      assert.is_true(
        firstMatching(labels, "result%-count=") ~= nil,
        "no result-count marker: " .. table.concat(labels, " / ")
      )
      assert.is_nil(firstMatching(labels, "SKIPPED"))
    end)

    it("a filter scenario whose choice is gone marks itself skipped instead of passing", function()
      local scenario = scenarios()[4]
      local choices = FurC.DropdownData.ChoicesSource
      local value = scenario.filter.value
      local kept = choices[value]
      choices[value] = nil -- planted: the choice was retired since the scenario was written
      local labels = runScenario(scenario)
      choices[value] = kept

      assert.is_true(firstMatching(labels, "SKIPPED") ~= nil, "no skip marker: " .. table.concat(labels, " / "))
      assert.is_nil(firstMatching(labels, "result%-count="), "a skipped scenario must not report a count")
    end)
  end)

  describe("benchmark scroll scenario", function()
    -- The scroll path itself is GUI: it needs line controls, a slider and a redraw
    local holder, savedScroll, savedUpdate

    local function fakeGui(rows, pageSize)
      holder = FurCGui_ListHolder
      holder.dataLines = {}
      for i = 1, rows do
        holder.dataLines[i] = { itemId = i }
      end
      holder.maxLines = pageSize
      holder.dataOffset = 0

      savedScroll, savedUpdate = FurC.GuiOnScroll, FurC.UpdateInventoryScroll
      FurC.UpdateInventoryScroll = function() end
      FurC.GuiOnScroll = function(_, delta) -- as GuiXmlBridge does it: negative delta scrolls down
        local value = holder.dataOffset - delta
        local total = #holder.dataLines - holder.maxLines
        holder.dataOffset = math.max(0, math.min(value, total))
      end
    end

    local function restoreGui()
      FurC.GuiOnScroll, FurC.UpdateInventoryScroll = savedScroll, savedUpdate
      holder.dataLines, holder.maxLines, holder.dataOffset = nil, nil, nil
    end

    local function scrollScenario()
      for _, scenario in ipairs(scenarios()) do
        if scenario.label:find("scroll") then
          return scenario
        end
      end
    end

    it("exists, and is not the last scenario", function()
      local all = scenarios()
      local found
      for id, scenario in ipairs(all) do
        if scenario.label:find("scroll") then
          found = id
        end
      end
      assert.is_true(found ~= nil, "no scroll scenario")
      assert.is_true(found < #all, "the scroll scenario must run before the rebuild")
    end)

    it("steps a full list by whole pages, marking each one", function()
      fakeGui(2000, 40)
      local scenario = scrollScenario()
      assert.is_true(scenario ~= nil, "no scroll scenario")
      local labels = markersOf(scenario.steps())
      restoreGui()

      local offsets = {}
      for _, label in ipairs(labels) do
        local page, offset = label:match("scroll page=(%d+) offset=(%d+)")
        if page then
          offsets[#offsets + 1] = tonumber(offset)
        end
      end
      assert.is_true(#offsets >= 10, "expected ten scrolled pages, got " .. #offsets)
      for i = 2, #offsets do
        assert.equals(offsets[i - 1] + 40, offsets[i])
      end
      assert.is_nil(firstMatching(labels, "SKIPPED"))
    end)

    it("says the list ran out instead of reading as a fast page", function()
      fakeGui(50, 40) -- one page and a bit: the second step has nowhere to go
      local scenario = scrollScenario()
      assert.is_true(scenario ~= nil, "no scroll scenario")
      local labels = markersOf(scenario.steps())
      restoreGui()

      assert.is_true(firstMatching(labels, "SKIPPED list%-exhausted") ~= nil, table.concat(labels, " / "))
    end)
  end)
end)
