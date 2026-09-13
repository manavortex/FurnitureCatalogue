-- LibFurnitureCatalogue.API v1 contract: endpoint + return shapes

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
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
      assert.equals("string", type(api.Events.SCAN_COMPLETE))
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
          "GetDataVersionKeys",
          "GetDataVersions",
          "GetEntry",
          "GetEntryCount",
          "GetFurnitureCategories",
          "GetIngredients",
          "GetItemDescription",
          "GetItemId",
          "GetItemIds",
          "GetItemLink",
          "GetMiscItemPrice",
          "GetSourceDetails",
          "GetSourceTypeInfo",
          "GetSourceTypes",
          "GetSources",
          "GetState",
          "GetVersion",
          "Has",
          "IsReady",
          "OnReady",
          "RegisterCallback",
          "SourceType",
          "State",
          "UnregisterCallback",
        }),
        Test.keySet(api)
      )
      -- three moments, not five names for three: READY and CHANGE were a duplicate
      -- and a subset of SCAN_COMPLETE, both firing on the same tick with the same payload
      assert.same(Test.nameSet({ "SCAN_COMPLETE", "SCAN_FAILED", "SCAN_STARTED" }), Test.keySet(api.Events))
    end)

    it("OnReady calls subscribers immediately", function()
      FurC.EnsureDB(true)
      local returned = false
      local observed = {}

      -- payload only: the API table is reachable as a global, so passing it bought
      -- nothing and cost two possible callback shapes
      local accepted = api.OnReady(function(revision)
        observed.revision = revision
        observed.beforeReturn = not returned
      end)
      returned = true

      assert.is_true(accepted)
      assert.equals(api.GetDBRevision(), observed.revision)
      assert.is_true(observed.beforeReturn)
      assert.is_false(api.OnReady(nil))

      -- takes the same optional arg RegisterCallback does, so a method-style
      -- callback needs no closure on either endpoint
      local self = {}
      local gotSelf, gotRevision
      api.OnReady(function(observedSelf, revision)
        gotSelf, gotRevision = observedSelf, revision
      end, self)
      assert.equals(self, gotSelf)
      assert.equals(api.GetDBRevision(), gotRevision)
    end)

    it("properly runs the full callback lifecycle", function()
      local stateDuringBuild
      local readyCalls, readyCallsDuringBuild = 0, 0
      local readyRevision
      local accepted, duplicateAccepted
      local sequence = {}

      local function onReady(revision)
        readyCalls = readyCalls + 1
        readyRevision = revision
        sequence[#sequence + 1] = "ready"
      end

      -- queued rather than run immediately, which is the other half of OnReady's arg
      local queuedArg = {}
      local queuedSelf, queuedRevision
      local function onQueuedReady(observedSelf, revision)
        queuedSelf, queuedRevision = observedSelf, revision
      end

      local function onScanStarted()
        stateDuringBuild = api.GetState()
        readyCallsDuringBuild = readyCalls
        accepted = api.OnReady(onReady)
        duplicateAccepted = api.OnReady(onReady)
        api.OnReady(onQueuedReady, queuedArg)
      end

      local badCalls = 0
      local function badCompleteCallback()
        badCalls = badCalls + 1
        sequence[#sequence + 1] = "bad"
        error("expected public callback failure")
      end

      local completeArg = {}
      local completeCalls = 0
      local completeRevision
      -- registered with an arg, so this one sees (arg, payload...)
      local function onComplete(arg, revision)
        completeCalls = completeCalls + 1
        completeRevision = revision
        sequence[#sequence + 1] = arg == completeArg and "complete" or "wrong-arg"
      end

      local reentrantCalls = 0
      local function onReentrantComplete()
        reentrantCalls = reentrantCalls + 1
        sequence[#sequence + 1] = "reentrant"
        api.UnregisterCallback(api.Events.SCAN_COMPLETE, onReentrantComplete)
        FurC.RebuildDB(true)
      end

      api.RegisterCallback(api.Events.SCAN_STARTED, onScanStarted)
      local registeredBad = api.RegisterCallback(api.Events.SCAN_COMPLETE, badCompleteCallback)
      local registered = api.RegisterCallback(api.Events.SCAN_COMPLETE, onComplete, completeArg)
      local duplicateRegistered = api.RegisterCallback(api.Events.SCAN_COMPLETE, onComplete, completeArg)
      api.RegisterCallback(api.Events.SCAN_COMPLETE, onReentrantComplete)
      local beforeRevision = api.GetDBRevision()
      local ok, err = pcall(FurC.RebuildDB, true)

      api.UnregisterCallback(api.Events.SCAN_STARTED, onScanStarted)
      local removedBad = api.UnregisterCallback(api.Events.SCAN_COMPLETE, badCompleteCallback)
      local removed = api.UnregisterCallback(api.Events.SCAN_COMPLETE, onComplete, completeArg)
      api.UnregisterCallback(api.Events.SCAN_COMPLETE, onReentrantComplete)
      local removedTwice = api.UnregisterCallback(api.Events.SCAN_COMPLETE, onComplete, completeArg)

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
      assert.equals(1, completeCalls)
      assert.equals(1, reentrantCalls)
      assert.equals(api.GetDBRevision(), readyRevision)
      assert.equals(api.GetDBRevision(), completeRevision)
      assert.equals(queuedArg, queuedSelf)
      assert.equals(api.GetDBRevision(), queuedRevision)
      assert.is_true(api.GetDBRevision() > beforeRevision)
      assert.same({ "ready", "bad", "complete", "reentrant" }, sequence)
      assert.is_true(removedBad)
      assert.is_true(removed)
      assert.is_false(removedTwice)
      assert.equals(api.State.READY, api.GetState())
      assert.is_true(api.IsReady())
    end)

    it("reports build failures and recovers only on explicit rebuild", function()
      local compat = LibFurnitureCatalogue.Internal.Compat
      local originalCloseOver = compat.CloseOverAncestors
      local sentinel = "expected lifecycle build failure"
      local completeCalls = 0
      local readyCalls = 0
      local failedEventCalls = 0

      local function onComplete()
        completeCalls = completeCalls + 1
      end
      local function onReady()
        readyCalls = readyCalls + 1
      end
      local function onFailed()
        failedEventCalls = failedEventCalls + 1
        FurC.RebuildDB()
      end

      api.RegisterCallback(api.Events.SCAN_COMPLETE, onComplete)
      api.RegisterCallback(api.Events.SCAN_FAILED, onFailed)
      compat.CloseOverAncestors = function()
        error(sentinel)
      end
      local failedOk, failedErr = pcall(FurC.RebuildDB, true)
      compat.CloseOverAncestors = originalCloseOver
      api.UnregisterCallback(api.Events.SCAN_FAILED, onFailed)

      local failedState, buildError = api.GetState()
      local accepted = api.OnReady(onReady)
      local stateAfterSubscribe = api.GetState()
      local readyAfterFailure = api.IsReady()
      local readyCallsAfterFailure = readyCalls
      local completeCallsAfterFailure = completeCalls
      FurC.RescanFiles()
      local stateAfterRejectedRescan = api.GetState()
      local recoveredOk, recoveredErr = pcall(FurC.RebuildDB, true)
      -- a waiter registered after recovery is accepted and runs, so the refusal
      -- above is about the FAILED state and not a permanently dead endpoint
      local acceptedAfterRecovery = api.OnReady(onReady)
      api.UnregisterCallback(api.Events.SCAN_COMPLETE, onComplete)

      assert.is_false(failedOk)
      assert.is_not_nil(string.find(tostring(failedErr), sentinel, 1, true))
      assert.equals(api.State.FAILED, failedState)
      assert.is_not_nil(string.find(tostring(buildError), sentinel, 1, true))
      assert.equals(1, failedEventCalls)
      -- refused rather than queued: a waiter accepted in FAILED could never run,
      -- because a failed build never publishes readiness
      assert.is_false(accepted)
      assert.equals(api.State.FAILED, stateAfterSubscribe)
      assert.equals(api.State.FAILED, stateAfterRejectedRescan)
      assert.is_false(readyAfterFailure)
      assert.equals(0, readyCallsAfterFailure)
      assert.equals(0, completeCallsAfterFailure)
      assert.is_true(recoveredOk, tostring(recoveredErr))
      local recoveredState, recoveredError = api.GetState()
      assert.equals(api.State.READY, recoveredState)
      assert.is_nil(recoveredError)
      assert.is_true(api.IsReady())
      assert.is_true(acceptedAfterRecovery)
      assert.equals(1, readyCalls)
      assert.equals(1, completeCalls)
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
      -- identifiers, not rendered text: the record hands back the vocabulary's own
      -- id and the consumer resolves it, so the record reads the same in every
      -- client language. Asserted against the constants rather than by type, because
      -- a locale string id is a number in the client and a string under the stubs
      assert.equals(FurC.Constants.NpcIds.LUXF, lux.source.vendor)
      assert.equals(FurC.Constants.ZoneIds.COLDH, lux.source.location)
      assert.equals("number", type(lux.source.location))
      assert.is_true(#GetString(lux.source.vendor) > 0)
      assert.is_true(#GetZoneNameById(lux.source.location) > 0)
      assert.equals("number", type(lux.cost.amount))
      assert.equals(CURT_MONEY, lux.cost.currency)

      assert.same({}, api.GetSourceDetails(UNKNOWN_ID))
    end)

    it("GetSourceDetails carries what a crown-store row knows", function()
      FurC.EnsureDB(true)
      local srcEnum = FurC.Constants.ItemSources

      local function recordFor(itemId, sourceType)
        for _, rec in ipairs(api.GetSourceDetails(itemId)) do
          if rec.source.type == sourceType then
            return rec
          end
        end
      end

      -- a crate row: the season, and no price of its own
      local crate = recordFor(224739, srcEnum.CROWN) -- Aetherean Rupture, Liminal
      assert.is_not_nil(crate)
      assert.equals(FurC.Constants.CrownCrateIds.ANU_PAD, crate.source.crate)
      assert.is_nil(crate.cost)

      -- a pack row: the pack's item id, resolvable to a link
      local pack = recordFor(224853, srcEnum.CROWN) -- A Hero Strides Forth Painting, Gold
      assert.is_not_nil(pack)
      assert.equals(FurC.Constants.ItemPacks.DARIEN, pack.source.pack)

      -- a multi-source row answers with every source it has, on the one record
      local both = recordFor(223178, srcEnum.EDITOR) -- Worm Cult Winch, Chain
      assert.is_not_nil(both)
      assert.equals(CURT_CROWNS, both.cost.currency)
      assert.equals(2800, both.cost.amount)
      assert.same({ 13881 }, both.source.houses)
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

    it("enumerates its vocabularies so a consumer never transcribes one", function()
      local sourceType = api.GetSourceTypes()
      local info = api.GetSourceTypeInfo()

      -- every enum value is described, which is what stops an export degrading
      -- to a raw key when a source is added
      for key, value in pairs(sourceType) do
        local described = info[value]
        assert.equals("table", type(described), "no info for " .. key)
        assert.equals(value, sourceType[described.key], "info names no source key: " .. tostring(described.key))
        assert.equals("string", type(described.label))
        assert.is_true(#described.label > 0)
      end
      assert.equals("Luxury Furnisher", info[sourceType.LUXURY].label)

      -- a renamed source keeps its old key as a deprecated alias
      assert.equals(sourceType.STEAL_CONTAINER, sourceType.CONTAINER)
      assert.equals("STEAL_CONTAINER", info[sourceType.CONTAINER].key)

      -- LATEST shares a value with the update it points at, so the naive inverse
      -- of GetDataVersions loses a name; the endpoint does not
      local versions = api.GetDataVersions()
      local versionKeys = api.GetDataVersionKeys()
      assert.equals("string", type(versionKeys[versions.ALTMER]))
      -- LATEST and ZERO2 are aliases sharing a value, so the key comes back as the
      -- update itself; naming the update here would need editing every release
      local latestKey = versionKeys[versions.LATEST]
      assert.is_true(latestKey ~= "LATEST" and latestKey ~= "ZERO2", "alias won the inverse: " .. tostring(latestKey))
      assert.equals(versions.LATEST, versions[latestKey])

      -- categories come from the client, so a consumer filters without an id
      local categories = api.GetFurnitureCategories()
      local seen = 0
      for id, category in pairs(categories) do
        assert.equals("number", type(id))
        assert.equals("string", type(category.name))
        assert.equals("number", type(category.parent))
        seen = seen + 1
      end
      assert.is_true(seen > 0)
      -- a fresh copy per call, so a consumer cannot edit ours
      categories[next(categories)].name = "mutated"
      assert.is_true(api.GetFurnitureCategories()[next(categories)].name ~= "mutated")
    end)

    it("GetMiscItemPrice reads the whole amount off the row, or nothing", function()
      FurC.EnsureDB(true)
      local sourceType = api.GetSourceTypes()

      -- a single crown-store source: { itemPrice = 2000 }
      local crownCurrency, crownAmount = api.GetMiscItemPrice(134686, 6, sourceType.CROWN) -- Sithis, The Dread Father
      assert.equals(CURT_CROWNS, crownCurrency)
      assert.equals(2000, crownAmount)

      -- the price sits on one source of a list: { { itemPrice = 65 }, { category = ... } }
      local editorCurrency, prefixedAmount = api.GetMiscItemPrice(87709, 2, sourceType.EDITOR) -- Imperial Brazier, Spiked
      assert.equals(CURT_CROWNS, editorCurrency)
      assert.equals(65, prefixedAmount)

      -- strBazaar(2000): txt first, price after
      -- `<label>: |c<hex><amount>|r|u...:currency:|u<icon>`
      local bazaarCurrency, bazaarAmount =
        api.GetMiscItemPrice(212186, FurC.Constants.Versioning.BASE44, sourceType.BAZAAR) -- Statue, Breton Hero
      assert.equals(CURT_TRADE_BARS, bazaarCurrency)
      assert.equals(2000, bazaarAmount)

      -- a crate is not sold for a price of its own
      local crateCurrency, crateAmount = api.GetMiscItemPrice(125654, 3, sourceType.CROWN) -- Tapestry, Clavicus Vile
      assert.is_nil(crateCurrency)
      assert.is_nil(crateAmount)
    end)
  end)
end)
