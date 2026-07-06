-- Tooltip sources and blacklists

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  local src = FurC.Constants.ItemSources

  describe("tooltip source blacklist", function()
    local function set(hidden)
      FurC.settings.tooltipHiddenSources = hidden
    end

    it("shows everything by default", function()
      set({})
      assert.is_false(FurC.IsTooltipSourceHidden(src.VENDOR))
      assert.is_false(FurC.IsTooltipSourceHidden(src.LUXURY))
      assert.is_false(FurC.IsTooltipSourceHidden(src.RUMOUR))
    end)

    it("hides raw source when category key is set", function()
      set({ luxury = true })
      assert.is_true(FurC.IsTooltipSourceHidden(src.LUXURY))
      assert.is_false(FurC.IsTooltipSourceHidden(src.VENDOR))
    end)

    it("maps WRIT_VENDOR dropdown category to the stored ROLIS source", function()
      set({ writ_vendor = true })
      assert.is_true(FurC.IsTooltipSourceHidden(src.ROLIS))
    end)

    it("CRAFTING is never hidden by blacklist (own toggles)", function()
      set({ purch_gold = true, other = true, rumour = true })
      assert.is_false(FurC.IsTooltipSourceHidden(src.CRAFTING))
    end)

    it("generates checkbox descriptors: checked = shown", function()
      local controls = FurC.BuildTooltipSourceOptions()
      assert.is_true(#controls > 0)
      local box
      for _, c in ipairs(controls) do
        assert.equals("checkbox", c.type)
        assert.equals("function", type(c.getFunc))
        assert.equals("function", type(c.setFunc))
        box = box or c
      end
      set({})
      assert.is_true(box.getFunc()) -- shown by default
      box.setFunc(false) -- hide
      assert.is_false(box.getFunc())
      box.setFunc(true) -- show again
      assert.is_true(box.getFunc())
    end)
  end)
end)
