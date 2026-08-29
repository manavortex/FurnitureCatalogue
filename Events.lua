-- Reactions to lib scan-lifecycle events

local api = LibFurnitureCatalogue.API

local function onScanStarted()
  FurC.IsLoading(true)
end

local function onScanComplete()
  if FurC.SearchIndex then -- invalidate in case it was partially built already
    FurC.SearchIndex.Invalidate()
  end
  FurC.UpdateGui()
end

api.RegisterCallback(api.Events.SCAN_STARTED, onScanStarted)
api.RegisterCallback(api.Events.SCAN_COMPLETE, onScanComplete)
