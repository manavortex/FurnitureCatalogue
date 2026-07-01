-- FurC.Lib internal helper namespace. Not an API!

FurC = FurC or {}
FurC.Lib = FurC.Lib or {}

-- LCK reference, nil when no LCK loaded
---@type LibCharacterKnowledge
local _lck = nil

function FurC.Lib.LCKAvailable()
  return _lck ~= nil
end

function FurC.Lib.InitLCK(lck)
  _lck = lck or LibCharacterKnowledge
  if not _lck then
    return
  end
  -- Hook into LCK knowledge updates, to refresh FurC GUI if open
  _lck.RegisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH, function()
    if FurC.UpdateGui then
      zo_callLater(FurC.UpdateGui, 50)
    end
  end)
end

-- Only explicit UNKNOWN hides item
-- Deliberately shown: never scanned, not learnable, LCK absent
-- item: itemId (number) or itemLink (string)
function FurC.Lib.CharKnows(item)
  if not _lck then
    return true
  end
  return _lck.GetItemKnowledgeForCharacter(item) ~= _lck.KNOWLEDGE_UNKNOWN
end

-- Account-wide: true if any tracked character knows it
function FurC.Lib.AccountKnows(item)
  if not _lck then
    return true
  end
  for _, entry in ipairs(_lck.GetItemKnowledgeList(item)) do
    if entry.knowledge == _lck.KNOWLEDGE_KNOWN then
      return true
    end
  end
  return false
end
