-- Check for dead FurC.* references in XML

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("XML handler references", function()
    local KNOWN_DEAD = {}

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

    -- The inverse of the check above: a handler the XML never names is dead too
    it("the window's resize handler is the one that refreshes the rows", function()
      if not (io and FurCDev.repoRoot) then
        return -- run test headless only
      end
      local fh = io.open(FurCDev.repoRoot .. "/xml/FurnitureCatalogue.xml", "r")
      assert.is_not_nil(fh)
      local content = fh:read("*a")
      fh:close()

      local handler = content:match("<OnResizeStop>%s*(.-)%s*</OnResizeStop>")
      assert.is_not_nil(handler, "the window declares no OnResizeStop handler")
      assert.is_not_nil(
        handler:find("FurC.OnResizeStop", 1, true),
        "resize calls " .. handler .. ", which skips what FurC.OnResizeStop carries"
      )
      assert.equals("function", type(FurC.OnResizeStop))
    end)
  end)
end)
