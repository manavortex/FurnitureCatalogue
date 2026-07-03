-- Check for dead FurC.* references in XML

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("XML handler references", function()
    local KNOWN_DEAD = {
      GuiSetupDropdown = true,
    }

    it("every FurC.* mention in xmls exists", function()
      if not (io and FurCDev.repoRoot) then
        return -- run test headless only
      end
      local files = { "xml/FurnitureCatalogue.xml", "xml/Bindings.xml" }
      local missing, seen, checked = {}, {}, 0
      for _, rel in ipairs(files) do
        local fh = io.open(FurCDev.repoRoot .. "/" .. rel, "r")
        if fh then
          local content = fh:read("*a")
          fh:close()
          for name in content:gmatch("FurC%.([A-Za-z_]+)%s*[%(%.]") do
            checked = checked + 1
            if FurC[name] == nil and not KNOWN_DEAD[name] and not seen[name] then
              seen[name] = true
              missing[#missing + 1] = name
            end
          end
        end
      end
      assert.is_true(checked > 0)
      assert.same({}, missing)
    end)
  end)
end)
