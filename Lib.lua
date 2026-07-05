-- FurC.Lib internal helper namespace. Not an API!

FurC = FurC or {}
FurC.Lib = FurC.Lib or {}

-- LCK reference, nil when no LCK loaded
---@type LibCharacterKnowledge
local _lck = nil

-- character names for filter
local _charCache = nil

function FurC.Lib.LCKAvailable()
  return _lck ~= nil
end

function FurC.Lib.InitLCK(lck)
  _charCache = nil
  -- prevent duplicate callback registrations
  if _lck and _lck.UnregisterForCallback then
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_INITIALIZED)
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH)
  end
  _lck = lck or LibCharacterKnowledge
  if not _lck then
    return
  end
  -- chars + knowledge empty until LCK has the info
  _lck.RegisterForCallback("FurnitureCatalogue", _lck.EVENT_INITIALIZED, function()
    _charCache = nil
    if FurC.RefreshCharacterDropdown then
      FurC.RefreshCharacterDropdown()
    end
    if FurC.UpdateGui then
      zo_callLater(FurC.UpdateGui, 50)
    end
  end)
  -- On recipe update: refilter, charlist unchanged
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
  local account = GetDisplayName()
  for _, entry in ipairs(_lck.GetItemKnowledgeList(item)) do
    if entry.account == account and entry.knowledge == _lck.KNOWLEDGE_KNOWN then
      return true
    end
  end
  return false
end

local function ensureCharCache()
  if _charCache then
    return _charCache
  end
  if not _lck then
    return nil
  end
  local server = _lck.GetServerList()[1] -- current server is always first
  local account = GetDisplayName() -- LCK tracks other accounts too, so we filter those out
  local names, idByName = {}, {}
  for _, char in ipairs(_lck.GetCharacterList(server)) do
    if char.account == account then
      names[#names + 1] = char.name
      idByName[char.name] = char.id
    end
  end
  _charCache = { server = server, names = names, idByName = idByName }
  return _charCache
end

-- Char names for filter dropdown, empty when no LCK
function FurC.Lib.GetCharacterNames()
  local cache = ensureCharCache()
  return (cache and cache.names) or {}
end

function FurC.Lib.IsKnownByName(item, name)
  if not _lck then
    return nil
  end
  if not name then
    return FurC.Lib.AccountKnows(item)
  end
  local cache = ensureCharCache()
  local charId = cache and cache.idByName[name]
  if not charId then
    return FurC.Lib.AccountKnows(item)
  end
  return _lck.GetItemKnowledgeForCharacter(item, cache.server, charId) == _lck.KNOWLEDGE_KNOWN
end

function FurC.Lib.GetCrafterNames(item)
  if not _lck then
    return nil
  end
  local account = GetDisplayName()
  local names = {}
  for _, entry in ipairs(_lck.GetItemKnowledgeList(item)) do
    if entry.account == account and entry.knowledge == _lck.KNOWLEDGE_KNOWN then
      names[#names + 1] = entry.name
    end
  end
  return names
end
