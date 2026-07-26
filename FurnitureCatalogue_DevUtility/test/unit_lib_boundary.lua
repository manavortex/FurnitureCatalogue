-- Lib/main boundary tests: lib must not read main state, main must not write lib DB directly
-- Headless test only, just to prevent the addons from touching each other in inappropriate ways

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("lib/main boundary", function()
    local function readFile(rel)
      local fh = io.open(FurCDev.repoRoot .. "/" .. rel, "r")
      if not fh then
        return nil
      end
      local content = fh:read("*a")
      fh:close()
      return content
    end

    -- manifest .lua entries, path-normalised, $(language) skipped
    local function manifestFiles(manifestRel, prefix)
      local files = {}
      local content = readFile(manifestRel) or ""
      for line in (content .. "\n"):gmatch("([^\n]*)\n") do
        local entry = line:gsub("\\", "/"):gsub("%s+$", "")
        local first = entry:sub(1, 1)
        if first ~= "#" and first ~= ";" and entry ~= "" and entry:sub(-4) == ".lua" and not entry:find("%$%(") then
          files[#files + 1] = prefix .. entry
        end
      end
      return files
    end

    -- blank out comments, keep line numbers intact
    local function stripComments(src)
      src = src:gsub("%-%-%[%[(.-)%]%]", function(body)
        return (body:gsub("[^\n]", ""))
      end)
      return src:gsub("%-%-[^\n]*", "")
    end

    -- legacy FurC.*: symbols the lib may touch. Everything else on FurC belongs to the main addon and is bad touch.
    --  TODO: Shrink list as we migrate
    local LIB_OWNED = {
      -- runtime + namespaces
      DB = true,
      DBQuery = true,
      Constants = true,
      Utils = true,
      -- deprecated flat function aliases published by the lib
      GetItemLink = true,
      GetItemId = true,
      Find = true,
      GetIngredients = true,
      GetMats = true,
      GetItemDescription = true,
      Upsert = true,
      EnsureDB = true,
      RescanFiles = true,
      RebuildDB = true,
      -- data tables
      Recipes = true,
      RolisRecipes = true,
      FaustinaRecipes = true,
      Rolis = true,
      Faustina = true,
      FurnishingFolios = true,
      EventItems = true,
      MiscItemSources = true,
      CrownStore = true,
      Antiquities = true,
      Justice = true,
      Fishing = true,
      AchievementVendors = true,
      LuxuryFurnisher = true,
      PVP = true,
      Rumours = true,
      RumourRecipes = true,
      RecipeSources = true,
      Books = true,
      BookCollections = true,
      -- functions still defined in data files
      InitAchievementVendorList = true,
      InitHomeGoodsFurnisherList = true,
    }

    local function isGlobalInit(line)
      return line:match("^%s*local%s+FurC%s*=%s*FurC%s*or%s*{%s*}%s*$") ~= nil
        or line:match("^%s*FurC%s*=%s*FurC%s*or%s*{%s*}%s*$") ~= nil
    end

    it("lib sources touch only lib-owned FurC.* symbols", function()
      if not (io and FurCDev.repoRoot) then
        return -- run test headless only
      end
      local violations, checked = {}, 0
      local libFiles = manifestFiles("LibFurnitureCatalogue/LibFurnitureCatalogue.txt", "LibFurnitureCatalogue/")
      for _, rel in ipairs(libFiles) do
        local src = readFile(rel)
        if src then
          checked = checked + 1
          local n = 0
          for line in (stripComments(src) .. "\n"):gmatch("([^\n]*)\n") do
            n = n + 1
            for suffix in line:gmatch("%f[%w]FurC(%.?[%w_]*)") do
              local name = suffix:match("^%.([%w_]+)$")
              local ok = (name and LIB_OWNED[name]) or (suffix == "" and isGlobalInit(line))
              if not ok then
                violations[#violations + 1] = rel .. ":" .. n .. ": " .. line:gsub("^%s+", "")
                break
              end
            end
          end
        end
      end
      assert.is_true(checked > 5)
      assert.same({}, violations)
    end)

    it("no main source writes the lib runtime DB directly", function()
      if not (io and FurCDev.repoRoot) then
        return -- run test headless only
      end
      local WRITE_PATTERNS = {
        "Internal%.DB[%w_]*%s*=[^=]", -- reassign DB table / bump revision
        "Internal%.DB%s*%[.-%]%s*=[^=]", -- write a DB slot
        "%f[%w]FurC%.DB%s*=[^=]", -- reassign the legacy alias (breaks table identity)
        "%f[%w]FurC%.DB%s*%[.-%]%s*=[^=]", -- write a DB slot through the alias
      }
      local violations, checked = {}, 0
      for _, rel in ipairs(manifestFiles("FurnitureCatalogue.txt", "")) do
        local src = readFile(rel)
        if src then
          checked = checked + 1
          local n = 0
          for line in (stripComments(src) .. "\n"):gmatch("([^\n]*)\n") do
            n = n + 1
            for _, pattern in ipairs(WRITE_PATTERNS) do
              if line:find(pattern) then
                violations[#violations + 1] = rel .. ":" .. n .. ": " .. line:gsub("^%s+", "")
                break
              end
            end
          end
        end
      end
      assert.is_true(checked > 5)
      assert.same({}, violations)
    end)
  end)
end)
