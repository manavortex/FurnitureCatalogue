-- Crafting knowledge of the account, for the list manager and /furcexport: craftables are split into known and unknown, shown in list manager and exported as their own line kinds, can be written to the saved variables (what the FurnitureCatalogue_Export AddOn did)

FurC.CraftingExport = FurC.CraftingExport or {}
local C = FurC.CraftingExport

local api = LibFurnitureCatalogue.API
local SAVED_VARS = "FurnitureCatalogue_Export"
local KNOWN_PREFIX, UNKNOWN_PREFIX = "FURC KNOWN", "FURC UNKNOWN"

---@return table<integer, boolean>? knownById every craftable furnishing id, true when the account knows its plan;
---nil while the catalogue is still building (which this starts)
local function craftables()
  if not api.IsReady() then
    FurC.EnsureDB()
    return nil
  end
  local crafting = api.GetSourceTypes().CRAFTING
  local knownById = {}
  for _, itemId in ipairs(api.GetItemIds()) do
    local entry = api.GetEntry(itemId)
    if entry and entry.sources[crafting] then
      knownById[itemId] = FurC.IsAccountKnown(api.GetItemLink(itemId), entry) == true
    end
  end
  return knownById
end

---@param known boolean
---@return string name of the list, also its row in the list manager
function C.ListName(known)
  local which = known and SI_FURC_FILTER_SRC_CRAFTING_KNOWN or SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN
  return zo_strformat(GetString(SI_FURC_CRAFT_LIST), GetString(which))
end

---The known or the unknown craftables as export lines of one list
---@param known boolean
---@return string text
function C.ExportText(known)
  local knownById = craftables()
  if not knownById then
    return GetString(SI_FURC_CHAT_BUILDING)
  end
  local ids = {}
  for itemId, isKnown in pairs(knownById) do
    if isKnown == known then
      ids[#ids + 1] = itemId
    end
  end
  table.sort(ids)
  -- One line a page of the export window, each naming its part ("1/2")
  local header = (known and KNOWN_PREFIX or UNKNOWN_PREFIX) .. " "
  local lines = FurC.Transfer.IdLines(header .. "0/0", ids, nil, zo_floor((FurC.Transfer.MAX_CHARS - 40) / 8))
  for part, line in ipairs(lines) do
    lines[part] = line:gsub(header .. "0/0:", header .. part .. "/" .. #lines .. ":")
  end
  return table.concat(lines, "\n")
end

---Write { known = { [name] = "crafters: materials" }, unknown = { [name] = "materials" } } to the saved variables
---and reload the UI, which is what puts them on disk
function C.SaveToFile()
  local knownById = craftables()
  if not knownById then
    d(GetString(SI_FURC_CHAT_BUILDING))
    return
  end
  local craftedBy = GetString(SI_FURC_STRING_CRAFTABLE_BY)
  local known, unknown = {}, {}
  for itemId, isKnown in pairs(knownById) do
    local itemLink = api.GetItemLink(itemId)
    local entry = api.GetEntry(itemId)
    local text = FurC.SourceFormat.FormatMaterials(itemLink, entry, true)
    if isKnown then
      local crafters = FurC.GetCrafterList(itemLink, entry)
      if crafters:sub(1, #craftedBy) == craftedBy then
        crafters = crafters:sub(#craftedBy + 1)
      end
      text = crafters .. ": " .. text
    end
    (isKnown and known or unknown)[GetItemLinkName(itemLink)] = text
  end
  local saved = ZO_SavedVars:NewAccountWide(SAVED_VARS, nil, nil, {})
  saved.known, saved.unknown = known, unknown
  ReloadUI("ingame")
end

SLASH_COMMANDS["/furcexport"] = function()
  FurC.ListManager.Open("craft_unknown")
end

-- game knows knowledge better than whatever is imported
local function refuseImport()
  return nil, GetString(SI_FURC_CRAFT_NOT_IMPORTED)
end
FurC.Transfer.Register(KNOWN_PREFIX, { import = refuseImport })
FurC.Transfer.Register(UNKNOWN_PREFIX, { import = refuseImport })
