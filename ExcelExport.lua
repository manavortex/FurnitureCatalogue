require "luacom"

excel = luacom.CreateObject("Excel.Application")

local book  = excel.Workbooks:Add()
local sheet = book.Worksheets(1)

excel.Visible = true

for row=1, 30 do
  for col=1, 30 do
    sheet.Cells(row, col).Value2 = math.floor(math.random() * 100)
  end
end


local range = sheet:Range("A1")

for row=1, 30 do
  for col=1, 30 do
    local v = sheet.Cells(row, col).Value2

    if v > 50 then
        local cell = range:Offset(row-1, col-1)

        cell:Select()
        excel.Selection.Interior.Color = 65535
    end
  end
end

excel.DisplayAlerts = false
excel:Quit()
excel = nil 

Another example, could add a graph chart.

require "luacom"

excel = luacom.CreateObject("Excel.Application")

local book  = excel.Workbooks:Add()
local sheet = book.Worksheets(1)

excel.Visible = true

for row=1, 30 do
  sheet.Cells(row, 1).Value2 = math.floor(math.random() * 100)
end

local chart = excel.Charts:Add()
chart.ChartType = 4 — xlLine

local range = sheet:Range("A1:A30")
chart:SetSourceData(range) 
