-- LibFurnitureCatalogue - Furniture Catalogue database library, startup file

local MAJOR, MINOR = "LibFurnitureCatalogue", 10000 -- TODO: generate version from bump

if _G[MAJOR] and _G[MAJOR].version and _G[MAJOR].version >= MINOR then
  return
end

local lib = _G[MAJOR] or {}
lib.version = MINOR
lib.name = MAJOR
_G[MAJOR] = lib

lib.API = lib.API or {} -- public API for DB queries and stuff
lib.Internal = lib.Internal or {} -- internal use only

---Single furniture entry returned by FurC.Find
---@class FurCEntry
---@field sources table<FurCItemSource, boolean> every source this item has
---@field origin FurCItemSource top-ranked source
---@field version integer game version when the item was added
---@field blueprint integer|nil blueprint itemId, when craftable
---@field craftable boolean|nil
---@field craftingSkill integer|nil crafting skill type, when known
---@field furnCategory integer cached ESO furniture category id (0 = no category)
---@field furnSubcategory integer cached ESO furniture subcategory id

-- Runtime furniture database, built per session by the scanner: DB[itemId] = FurCEntry
---@type table<integer, FurCEntry>
lib.Internal.DB = lib.Internal.DB or {}

-- Mark DB dirty after write
lib.Internal.DBRevision = lib.Internal.DBRevision or 0

-- Legacy alias, same table — never reassign either side
FurC = FurC or {}
FurC.DB = lib.Internal.DB
