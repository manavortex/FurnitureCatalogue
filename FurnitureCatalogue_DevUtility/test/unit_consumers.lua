-- FurnitureCatalogue_DevUtility
--
-- consumer probe is what answers "does the released AddOn still work against this library"

if not Taneth then
  return
end

Taneth("FurC:Unit", function()
  describe("unit: FurCDev.Consumers", function()
    local probe = FurCDev.Probe

    ---Run with its output captured instead of printed
    ---@param section string
    ---@return string[] lines
    local function capture(section)
      local realReport, realSay = probe.Report, probe.Say
      local lines = {}
      probe.Report = function(_, reported)
        lines = reported
      end
      probe.Say = function(text)
        lines[#lines + 1] = text
      end
      local ok, err = pcall(FurCDev.Consumers.Run, section)
      probe.Report, probe.Say = realReport, realSay
      assert.is_true(ok, tostring(err))
      return lines
    end

    it("FSL reaches the library instead of reporting it missing", function()
      local text = table.concat(capture("fsl"), "\n")
      assert.is_true(#text > 0)
      assert.is_nil(text:find("the API endpoints the ported FSL calls are missing", 1, true), text)
      -- it got far enough to name the samples it walked
      assert.is_not_nil(text:find("craftable", 1, true), text)
      assert.is_not_nil(text:find("plain", 1, true), text)
    end)

    it("LibPrice finds every endpoint the release calls", function()
      local text = table.concat(capture("libprice"), "\n")
      assert.is_not_nil(text:find("endpoints it calls: ", 1, true), text)
    end)
  end)
end)
