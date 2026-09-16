-- Every published field is declared, and every declared field is published (nothing unaccounted for)
--
-- Headless only: it reads the library's own source, which the game's Lua cannot do.

if not Taneth then
  return
end

Taneth("FurC:Lib", function()
  local api = LibFurnitureCatalogue.API

  describe("published record declarations", function()
    it("declares every field it publishes, and publishes every field it declares", function()
      FurC.EnsureDB(true)

      local libRoot = FurCDev.libRoot or (FurCDev.repoRoot .. "/LibFurnitureCatalogue")
      local handle = io.open(libRoot .. "/Api.lua", "r")
      assert.are_not.equals(nil, handle)
      local text = handle:read("*a")
      handle:close()

      local declared = {}
      local block = text:match("---@class LFCSourceOrigin(.-)\n[^-]") or ""
      for field in block:gmatch("---@field%s+([%a_][%w_]*)") do
        declared[field] = true
      end
      assert.are_not.equals(nil, next(declared))

      local published = {}
      for itemId in pairs(FurC.DB) do
        if type(itemId) == "number" then
          for _, record in ipairs(api.GetSourceDetails(itemId)) do
            for field in pairs(record.source) do
              published[field] = (published[field] or 0) + 1
            end
          end
        end
      end
      assert.are_not.equals(nil, next(published))

      local problems = {}
      for field in pairs(declared) do
        if not published[field] then
          problems[#problems + 1] = field .. ": declared, carried by no record"
        end
      end
      for field, count in pairs(published) do
        if not declared[field] then
          problems[#problems + 1] = string.format("%s: published on %d records, declared nowhere", field, count)
        end
      end
      table.sort(problems)
      assert.equals("", table.concat(problems, " | "))
    end)
  end)
end)
