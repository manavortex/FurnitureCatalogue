-- Reactions to lib scan-lifecycle events

local LFC = LibFurnitureCatalogue

local function onScanStarted()
  FurC.IsLoading(true)
end

local function onScanComplete()
  if FurC.SearchIndex then -- invalidate in case it was partially built already
    FurC.SearchIndex.Invalidate()
  end
  FurC.UpdateGui()
end

LFC.Internal.Callbacks:RegisterCallback(LFC.Internal.Events.SCAN_STARTED, onScanStarted)
LFC.Internal.Callbacks:RegisterCallback(LFC.Internal.Events.SCAN_COMPLETE, onScanComplete)
