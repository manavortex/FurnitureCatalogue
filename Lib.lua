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

-- Core LCK API we call unconditionally.
local LCK_REQUIRED_FUNS = {
  "RegisterForCallback",
  "GetServerList",
  "GetCharacterList",
  "GetItemKnowledgeForCharacter",
  "GetItemKnowledgeList",
}

local function lckIsUsable(lck)
  if not lck then
    return false
  end
  for _, name in ipairs(LCK_REQUIRED_FUNS) do
    if type(lck[name]) ~= "function" then
      return false
    end
  end
  return lck.KNOWLEDGE_KNOWN ~= nil
    and lck.KNOWLEDGE_UNKNOWN ~= nil
    and lck.EVENT_INITIALIZED ~= nil
    and lck.EVENT_UPDATE_REFRESH ~= nil
end

function FurC.Lib.InitLCK(lck)
  _charCache = nil
  -- prevent duplicate callback registrations
  if _lck and _lck.UnregisterForCallback then
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_INITIALIZED)
    _lck.UnregisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH)
  end
  _lck = lck or LibCharacterKnowledge
  if not lckIsUsable(_lck) then
    _lck = nil -- incompatible/old LCK, falling back
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
  -- Regenerate char dropdown when LCK changes char ordering or tracking
  _lck.RegisterForCallback("FurnitureCatalogue", _lck.EVENT_UPDATE_REFRESH, function(invalidateCharacterList)
    if invalidateCharacterList then
      _charCache = nil
      if FurC.RefreshCharacterDropdown then
        FurC.RefreshCharacterDropdown()
      end
    end
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

-- LCK blueprint tracking is "plans" category
-- 1 == "Do not track"
-- 2...4 == track by quality
-- 0 == use default
local LCK_PLANS_KEY = "plans"
local LCK_TRACKING_OFF = 1

local function tracksFurnishing(server, charId)
  if not _lck.GetRawCharacterSettings then
    return true -- fallback: don't hide any char
  end
  local settings = _lck.GetRawCharacterSettings(server, charId)
  local tracking = settings and settings.tracking and settings.tracking[LCK_PLANS_KEY]
  return tracking ~= LCK_TRACKING_OFF
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
    if char.account == account and tracksFurnishing(server, char.id) then
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
