-- LibFurnitureCatalogue.API v1 contract: endpoint + return shapes

if not Taneth then
  return
end

Taneth("FurC:Regression", function()
  local api = LibFurnitureCatalogue.API
  local Test = FurCDev.Test
  local DS = Test.dataset()

  describe("LibFurnitureCatalogue.API v1 contract", function()
    local UNKNOWN_ID = 99123456

    it("metadata endpoint shows valid values", function()
      FurC.EnsureDB(true)
      assert.equals("number", type(api.GetVersion()))
      assert.equals("number", type(api.GetDBRevision()))
      assert.equals("table", type(api.State))
      assert.equals("table", type(api.Events))
      assert.equals("string", type(api.Events.CHANGE))
      assert.equals(api.State.READY, api.GetState())
      assert.is_true(api.IsReady())
      assert.is_true(api.GetEntryCount() > 0)
    end)

    -- Adding or dropping an endpoint could break third party addons, so we have to check only those endpoints are there
    it("publishes exactly the v1 endpoint and event set", function()
      assert.same(
        Test.nameSet({
          "Events",
          "GetDBRevision",
          "GetDataVersions",
          "GetEntry",
          "GetEntryCount",
          "GetIngredients",
          "GetItemDescription",
          "GetItemId",
          "GetItemIds",
          "GetItemLink",
          "GetMiscItemPrice",
          "GetSourceDetails",
          "GetSourceTypes",
          "GetState",
          "GetVersion",
          "Has",
          "IsReady",
          "OnReady",
          "RegisterCallback",
          "State",
          "UnregisterCallback",
        }),
        Test.keySet(api)
      )
      assert.same(
        Test.nameSet({ "CHANGE", "READY", "SCAN_COMPLETE", "SCAN_FAILED", "SCAN_STARTED" }),
        Test.keySet(api.Events)
      )
    end)

    it("OnReady calls subscribers immediately", function()
      FurC.EnsureDB(true)
      local returned = false
      local observed = {}

      local accepted = api.OnReady(function(readyApi, revision)
        observed.api = readyApi
        observed.revision = revision
        observed.beforeReturn = not returned
      end)
      returned = true

      assert.is_true(accepted)
      assert.equals(api, observed.api)
      assert.equals(api.GetDBRevision(), observed.revision)
      assert.is_true(observed.beforeReturn)
      assert.is_false(api.OnReady(nil))
    end)

    it("properly runs the full callback lifecycle", function()
      local stateDuringBuild
      local readyCalls, readyCallsDuringBuild = 0, 0
      local readyApi, readyRevision
      local accepted, duplicateAccepted
      local sequence = {}

      local function onReady(observedApi, revision)
        readyCalls = readyCalls + 1
        readyApi = observedApi
        readyRevision = revision
        sequence[#sequence + 1] = "ready"
      end

      local function onScanStarted()
        stateDuringBuild = api.GetState()
        readyCallsDuringBuild = readyCalls
        accepted = api.OnReady(onReady)
        duplicateAccepted = api.OnReady(onReady)
      end

      local badCalls = 0
      local function badChangeCallback()
        badCalls = badCalls + 1
        sequence[#sequence + 1] = "bad"
        error("expected public callback failure")
      end

      local changeArg = {}
      local changeCalls = 0
      local changeApi, changeRevision
      local function onChange(arg, observedApi, revision)
        changeCalls = changeCalls + 1
        changeApi = observedApi
        changeRevision = revision
        sequence[#sequence + 1] = arg == changeArg and "change" or "wrong-arg"
      end

      local reentrantCalls = 0
      local function onReentrantChange()
        reentrantCalls = reentrantCalls + 1
        sequence[#sequence + 1] = "reentrant"
        api.UnregisterCallback(api.Events.CHANGE, onReentrantChange)
        FurC.RebuildDB(true)
      end

      api.RegisterCallback(api.Events.SCAN_STARTED, onScanStarted)
      local registeredBad = api.RegisterCallback(api.Events.CHANGE, badChangeCallback)
      local registered = api.RegisterCallback(api.Events.CHANGE, onChange, changeArg)
      local duplicateRegistered = api.RegisterCallback(api.Events.CHANGE, onChange, changeArg)
      api.RegisterCallback(api.Events.CHANGE, onReentrantChange)
      local beforeRevision = api.GetDBRevision()
      local ok, err = pcall(FurC.RebuildDB, true)

      api.UnregisterCallback(api.Events.SCAN_STARTED, onScanStarted)
      local removedBad = api.UnregisterCallback(api.Events.CHANGE, badChangeCallback)
      local removed = api.UnregisterCallback(api.Events.CHANGE, onChange, changeArg)
      api.UnregisterCallback(api.Events.CHANGE, onReentrantChange)
      local removedTwice = api.UnregisterCallback(api.Events.CHANGE, onChange, changeArg)

      assert.is_true(ok, tostring(err))
      assert.is_true(registeredBad)
      assert.is_true(registered)
      assert.is_true(duplicateRegistered)
      assert.is_true(accepted)
      assert.is_true(duplicateAccepted)
      assert.equals(api.State.BUILDING, stateDuringBuild)
      assert.equals(0, readyCallsDuringBuild)
      assert.equals(1, readyCalls)
      assert.equals(1, badCalls)
      assert.equals(1, changeCalls)
      assert.equals(1, reentrantCalls)
      assert.equals(api, readyApi)
      assert.equals(api, changeApi)
      assert.equals(api.GetDBRevision(), readyRevision)
      assert.equals(api.GetDBRevision(), changeRevision)
      assert.is_true(api.GetDBRevision() > beforeRevision)
      assert.same({ "ready", "bad", "change", "reentrant" }, sequence)
      assert.is_true(removedBad)
      assert.is_true(removed)
      assert.is_false(removedTwice)
      assert.equals(api.State.READY, api.GetState())
      assert.is_true(api.IsReady())
    end)

    it("reports build failures and recovers only on explicit rebuild", function()
      local originalInit = FurC.InitAchievementVendorList
      local sentinel = "expected lifecycle build failure"
      local changeCalls = 0
      local readyCalls = 0
      local failedEventCalls = 0

      local function onChange()
        changeCalls = changeCalls + 1
      end
      local function onReady()
        readyCalls = readyCalls + 1
      end
      local function onFailed()
        failedEventCalls = failedEventCalls + 1
        FurC.RebuildDB()
      end

      api.RegisterCallback(api.Events.CHANGE, onChange)
      api.RegisterCallback(api.Events.SCAN_FAILED, onFailed)
      FurC.InitAchievementVendorList = function()
        error(sentinel)
      end
      local failedOk, failedErr = pcall(FurC.RebuildDB, true)
      FurC.InitAchievementVendorList = originalInit
      api.UnregisterCallback(api.Events.SCAN_FAILED, onFailed)

      local failedState, buildError = api.GetState()
      local accepted = api.OnReady(onReady)
      local stateAfterSubscribe = api.GetState()
      local readyAfterFailure = api.IsReady()
      local readyCallsAfterFailure = readyCalls
      local changeCallsAfterFailure = changeCalls
      FurC.RescanFiles()
      local stateAfterRejectedRescan = api.GetState()
      local recoveredOk, recoveredErr = pcall(FurC.RebuildDB, true)
      api.UnregisterCallback(api.Events.CHANGE, onChange)

      assert.is_false(failedOk)
      assert.is_not_nil(string.find(tostring(failedErr), sentinel, 1, true))
      assert.equals(api.State.FAILED, failedState)
      assert.is_not_nil(string.find(tostring(buildError), sentinel, 1, true))
      assert.equals(1, failedEventCalls)
      assert.is_true(accepted)
      assert.equals(api.State.FAILED, stateAfterSubscribe)
      assert.equals(api.State.FAILED, stateAfterRejectedRescan)
      assert.is_false(readyAfterFailure)
      assert.equals(0, readyCallsAfterFailure)
      assert.equals(0, changeCallsAfterFailure)
      assert.is_true(recoveredOk, tostring(recoveredErr))
      local recoveredState, recoveredError = api.GetState()
      assert.equals(api.State.READY, recoveredState)
      assert.is_nil(recoveredError)
      assert.is_true(api.IsReady())
      assert.equals(1, readyCalls)
      assert.equals(1, changeCalls)
    end)

    it("GetEntry returns a snapshot, nil on miss", function()
      FurC.EnsureDB(true)
      assert.is_nil(api.GetEntry(UNKNOWN_ID))
      assert.is_false(api.Has(UNKNOWN_ID))

      local ids = api.GetItemIds()
      assert.equals(api.GetEntryCount(), #ids)
      local id = ids[1]
      assert.is_true(api.Has(id))
      local entry = api.GetEntry(id)
      assert.equals("table", type(entry))
      assert.is_false(rawequal(entry, FurC.DB[id])) -- copy, not the live reference
      assert.equals("table", type(entry.sources))
    end)

    it("GetSourceDetails returns ranked schema-shaped records", function()
      FurC.EnsureDB(true)
      local srcEnum = FurC.Constants.ItemSources

      -- luxury items produce fully populated records
      assert.is_not_nil(DS.luxItemInDB)
      local records = api.GetSourceDetails(DS.luxItemInDB)
      assert.is_true(#records > 0)
      for _, rec in ipairs(records) do
        assert.equals("number", type(rec.source.type))
        assert.equals("table", type(rec.availability))
        assert.equals("number", type(rec.availability.version))
      end

      local lux
      for _, rec in ipairs(records) do
        if rec.source.type == srcEnum.LUXURY then
          lux = rec
        end
      end
      assert.is_not_nil(lux)
      assert.equals("string", type(lux.source.vendor))
      assert.equals("string", type(lux.source.location))
      assert.equals("number", type(lux.cost.amount))
      assert.equals(CURT_MONEY, lux.cost.currency)

      assert.same({}, api.GetSourceDetails(UNKNOWN_ID))
    end)

    it("endpoints and deprecated aliases keep stable shapes", function()
      FurC.EnsureDB(true)
      local itemId = DS.dbItem
      local itemLink = api.GetItemLink(itemId)
      assert.equals("string", type(itemLink))
      assert.is_true(#itemLink > 0)
      assert.equals(api.GetItemId, FurC.GetItemId)
      assert.equals(api.GetItemLink, FurC.GetItemLink)
      assert.equals(api.GetIngredients, FurC.GetIngredients)
      assert.equals(api.GetItemDescription, FurC.GetItemDescription)
      assert.equals(itemId, api.GetItemId(itemId))
      assert.equals(itemId, api.GetItemId(itemLink))
      assert.equals(itemLink, api.GetItemLink(itemLink))

      local sourceType = api.GetSourceTypes()
      assert.equals("number", type(sourceType.CROWN))
      assert.equals(FurC.Constants.ItemSources.CROWN, sourceType.CROWN)

      local entry = api.GetEntry(DS.luxItem)
      assert.equals("string", type(api.GetItemDescription(DS.luxItem, entry)))
      assert.equals("table", type(api.GetIngredients(Test.link(DS.craftable), api.GetEntry(DS.craftable))))

      -- an entry with a blueprint renders a list, one without falls back to the re-scan notice
      local mats = FurC.GetMats(Test.link(DS.craftable), api.GetEntry(DS.craftable))
      assert.equals("string", type(mats))
      assert.is_true(mats ~= FurC.GetMats(UNKNOWN_ID))

      local missingCurrency, missingAmount = api.GetMiscItemPrice(UNKNOWN_ID, 1, sourceType.CROWN)
      assert.is_nil(missingCurrency)
      assert.is_nil(missingAmount)
    end)

    it("GetMiscItemPrice reads the whole amount out of baked strings, or nothing", function()
      FurC.EnsureDB(true)
      local sourceType = api.GetSourceTypes()

      -- strCrown(2000): colourised and number-grouped
      local crownCurrency, crownAmount = api.GetMiscItemPrice(134686, 6, sourceType.CROWN) -- Sithis, The Dread Father
      assert.equals(CURT_CROWNS, crownCurrency)
      assert.equals(2000, crownAmount)

      -- price first, txt after: strMultiple(strCrown(65),...)
      local editorCurrency, prefixedAmount = api.GetMiscItemPrice(87709, 2, sourceType.EDITOR) -- Imperial Brazier, Spiked
      assert.equals(CURT_MONEY, editorCurrency)
      assert.is_true(editorCurrency ~= crownCurrency)
      assert.equals(65, prefixedAmount)

      -- strBazaar(2000): txt first, price after
      -- `<label>: |c<hex><amount>|r|u...:currency:|u<icon>`
      local bazaarCurrency, bazaarAmount =
        api.GetMiscItemPrice(212186, FurC.Constants.Versioning.BASE44, sourceType.BAZAAR) -- Statue, Breton Hero
      assert.equals(CURT_TRADE_BARS, bazaarCurrency)
      assert.equals(2000, bazaarAmount)

      -- "<<Cal:1>> (Crown Crate^n,from)" carries no price
      local crateCurrency, crateAmount = api.GetMiscItemPrice(125654, 3, sourceType.CROWN) -- Tapestry, Clavicus Vile
      assert.is_nil(crateCurrency)
      assert.is_nil(crateAmount)
    end)
  end)
end)
