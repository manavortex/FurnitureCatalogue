-- LibFurnitureCatalogue - Furniture Catalogue database library

local MAJOR, MINOR = "LibFurnitureCatalogue", 10000 -- TODO: generate version from bump

if _G[MAJOR] and _G[MAJOR].version and _G[MAJOR].version >= MINOR then
  return
end

local lib = _G[MAJOR] or {}
lib.version = MINOR
lib.name = MAJOR
_G[MAJOR] = lib

lib.API = lib.API or {}
