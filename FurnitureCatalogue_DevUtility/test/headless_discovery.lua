-- Run from the addon root: ../esolua/src/lua FurnitureCatalogue_DevUtility/test/headless_discovery.lua
local output, pending, messages = "", {}, {}
local known = { [100] = { version = 1 }, [101] = {}, [102] = { blueprint = 103 }, [110] = { version = 1 } }
local furniture = { [100] = true, [101] = true, [102] = true, [105] = true, [110] = true }
local recipes = { [103] = 102, [104] = 102, [106] = 100, [107] = 110 }
FurCDev = {
  textbox = {
    GetText = function()
      return output
    end,
    SetText = function(_, text)
      output = text
    end,
  },
  control = { SetHidden = function() end },
  selectAllOutput = function() end,
  SelectTab = function() end,
  SetScanSummary = function(text)
    messages[#messages + 1] = text
  end,
  RegisterTab = function() end,
}
LibFurnitureCatalogue = {
  API = {
    IsReady = function()
      return true
    end,
    GetSourceTypes = function()
      return { IGNORED = 31 }
    end,
  },
  Internal = {
    DB = known,
    Build = {
      HasSource = function(sources, source)
        return sources == source
      end,
    },
  },
}
FurC = { Utils = {
  GetItemLink = function(id)
    return id
  end,
}, Recipes = { [1] = { 107 } } }
SLASH_COMMANDS = {}
ITEMTYPE_FURNISHING = 1
LINK_STYLE_BRACKETS = 1
function d(text)
  messages[#messages + 1] = text
end
function zo_callLater(fn)
  pending[#pending + 1] = fn
end
function zo_strformat(_, text)
  return text
end
function GetCVar()
  return "en"
end
function GetAPIVersion()
  return 101051
end
function IsItemLinkPlaceableFurniture(id)
  return furniture[id] and id ~= 105
end
function GetItemLinkItemType(id)
  return furniture[id] and ITEMTYPE_FURNISHING or 0
end
function IsItemLinkFurnitureRecipe(id)
  return recipes[id] ~= nil
end
function GetItemLinkRecipeResultItemLink(id)
  return recipes[id]
end
function GetItemLinkItemId(id)
  return id
end
function GetItemLinkFurnitureDataId(id)
  return id
end
function GetFurnitureDataInfo()
  return 4, 5, 6
end
function GetItemLinkName(id)
  return furniture[id] and 'Chair "new" \\ test\nline\t' or ""
end
function GetItemLinkFunctionalQuality()
  return 3
end
function GetItemLinkIcon()
  return "/esoui/art/icons/chair.dds"
end
dofile("FurnitureCatalogue_DevUtility/Datamine.lua")
FurCDev.ScanFurniture(100, 400)
assert(#pending == 1, "scan must yield between bounded batches")
assert(output == "", "no partial output")
table.remove(pending, 1)()
local count = 0
for _ in output:gmatch('"format"') do
  count = count + 1
end
assert(count == 5, "runtime-only items, stations and new recipes for known furnishings must be included")
assert(output:find('"id":101', 1, true))
assert(output:find('"id":105', 1, true))
assert(not output:find('"blueprint":107', 1, true), "bundled blueprint must be skipped")
assert(output:find('"blueprint":103', 1, true) and output:find('"blueprint":104', 1, true))
assert(not output:find('"record":{"id":102,"source"', 1, true), "recipe result must not also become a bare item")
assert(
  known[101].version == nil and known[102].blueprint == 103 and known[102].version == nil,
  "discovery must not mutate DB"
)
assert(output:sub(-1) == "\n", "pages must end on a newline for consecutive pastes")
local previous = output
FurCDev.ScanFurniture(100, 900)
FurCDev.CancelDiscovery()
table.remove(pending, 1)()
assert(output == previous, "cancel must preserve previous output")
FurCDev.ScanFurniture(900, 100)
assert(output == previous and #pending == 0)
-- Force several pages and prove every JSONL line survives pagination.
GetItemLinkName = function()
  return string.rep("椅", 4500)
end
FurCDev.ScanFurniture(100, 110)
assert(#output < 24000)
local page1 = output
FurCDev.ShowDiscoveryPage(1)
assert(output ~= page1 and #output < 24000)
FurCDev.ShowDiscoveryPage(-1)
assert(output == page1)
-- Simulate the observed engine truncation: never leave malformed JSONL copyable.
local setText = FurCDev.textbox.SetText
FurCDev.textbox.SetText = function(_, text)
  output = text:sub(1, 100)
end
FurCDev.ShowDiscoveryPage()
assert(output == "" and messages[#messages] == "Datamine: output too large")
FurCDev.textbox.SetText = setText
FurCDev.ShowDiscoveryPage()
assert(output == page1, "full output remains available after a failed display")
-- Exclusions cover furnishing IDs, recipe IDs and results outside the range.
furniture[191611] = true
recipes[108] = 191611
recipes[109] = 101
known[109] = { version = 1, sources = 31 }
known[191611] = { version = 1, sources = 31 }
GetItemLinkName = function()
  return "Station"
end
FurCDev.ScanFurniture(108, 109)
assert(output == "", "ignored recipe and ignored recipe result must not be exported")
FurCDev.ScanFurniture(191611, 191611)
assert(output == "", "ignored furnishing must not be exported")
furniture[191611], recipes[108], recipes[109], known[109] = nil, nil, nil, nil
known[191611] = nil
-- The inventory menu must expose discovery even without a catalogue entry.
GetItemLinkName = function()
  return "New chair"
end
local menu = {}
SLOT_TYPE_ITEM, SLOT_TYPE_BANK_ITEM, SLOT_TYPE_GUILD_BANK_ITEM = 1, 2, 3
SLOT_TYPE_TRADING_HOUSE_POST_ITEM, SLOT_TYPE_STORE_BUY = 4, 5
function ZO_InventorySlot_GetType()
  return SLOT_TYPE_ITEM
end
function ZO_Inventory_GetBagAndIndex()
  return 1, 1
end
function GetItemLink()
  return 101
end
function AddCustomMenuItem(label, callback)
  menu[label] = callback
end
function ShowMenu() end
function FurCDev.textbox:TakeFocus() end
function FurCDev.textbox:SelectAll() end
function FurCDev.control:IsHidden()
  return false
end
dofile("FurnitureCatalogue_DevUtility/GUI.lua")
FurCDevControl_HandleInventoryContextMenu({})
table.remove(pending, 1)()
assert(menu["Add JSONL to textbox"], "missing item must have a discovery action")
menu["Add JSONL to textbox"]()
assert(output:find('"id":101', 1, true), "context action must produce discovery JSONL")
-- A catalogued item and a blueprint are added too, after what is already there, and only once.
local before = output
GetItemLink = function()
  return 100
end
FurCDevControl_HandleInventoryContextMenu({})
table.remove(pending, 1)()
menu["Add JSONL to textbox"]()
assert(
  output:sub(1, #before) == before and output:find('"record":{"id":100,"source"', 1, true),
  "known item must append"
)
menu["Add JSONL to textbox"]()
local _, lines = output:gsub("\n", "")
assert(lines == 2, "the same item must not be added twice")
FurCDev.AppendDiscovery(106)
assert(output:find('"record":{"id":100,"blueprint":106', 1, true), "a blueprint adds its furnishing with the blueprint")
output = before

-- Build and exercise the actual Datamine controls, without chat commands.
local widgets = {}
local Widget = {}
Widget.__index = Widget
function Widget:SetText(text)
  self.text = text
end
function Widget:GetText()
  return self.text
end
function Widget:SetEnabled(value)
  self.enabled = value
end
function Widget:SetEditEnabled(value)
  self.editEnabled = value
end
function Widget:SetHandler(event, callback)
  self[event] = callback
end
function Widget:SetHidden(value)
  self.hidden = value
end
function Widget:SetAnchorFill() end
function Widget:SetAnchor() end
function Widget:SetDimensions() end
function Widget:SetFont() end
function Widget:SetMaxInputChars() end
function Widget:SelectAll()
  self.selected = true
end
function Widget:SetHorizontalAlignment() end
function Widget:SetHeight() end
local function widget(name)
  local w = setmetatable({}, Widget)
  widgets[name] = w
  return w
end
WINDOW_MANAGER = {
  CreateControl = function(_, name)
    return widget(name)
  end,
  CreateControlFromVirtual = function(_, name)
    return widget(name)
  end,
}
FurCDevControl_Achievements = {
  GetParent = function()
    return {}
  end,
}
FurCDev.BuildDiscoveryTab()
local function control(suffix)
  return widgets["FurCDevControl_Items_" .. suffix]
end
assert(control("Last"):GetText() == "300000")
control("First").OnFocusGained(control("First"))
assert(control("First").selected)
control("First"):SetText("150000")
control("Last"):SetText("100000")
control("Scan").OnClicked()
assert(control("First"):GetText() == "150000" and control("Last"):GetText() == "100000")
assert(#pending == 0 and control("Status").text:find("valid first and last", 1, true))
assert(control("Scan").enabled and not control("Cancel").enabled)
assert(not control("Previous").enabled and not control("Next").enabled)
control("First"):SetText("100")
control("Last"):SetText("400")
control("Scan").OnClicked()
assert(not control("Scan").enabled and control("Cancel").enabled)
assert(not control("First").editEnabled and not control("Last").editEnabled)
assert(control("Status").text:find("Scanning IDs", 1, true))
control("Cancel").OnClicked()
assert(not control("Cancel").enabled)
table.remove(pending, 1)()
assert(control("Scan").enabled and control("Status").text:find("cancelled", 1, true))
control("First"):SetText("not an ID")
control("Scan").OnClicked()
assert(control("Status").text:find("valid first and last", 1, true))
control("First"):SetText("100")
control("Last"):SetText("110")
GetItemLinkName = function()
  return string.rep("椅", 4500)
end
control("Scan").OnClicked()
assert(control("Page").text == "Page 1 / 5")
assert(control("Next").enabled and not control("Previous").enabled)
local firstPage = output
control("Next").OnClicked()
assert(output ~= firstPage and control("Previous").enabled)
control("Previous").OnClicked()
assert(output == firstPage and not control("Previous").enabled)
assert(FurCDev.Dashboard.current == "datamine")
assert(SLASH_COMMANDS["/dumpfurniture"] == nil, "discovery has no slash command")

-- The retained dump writes reference metadata and taxonomy, not source exports.
FurC.DB = { [200001] = { blueprint = 200002 } }
FurC.EnsureDB = function() end
FurC.Utils.GetItemName = function()
  return "Meta chair"
end
LibFurnitureCatalogue.API.GetFurnitureCategories = function()
  return { [4] = { name = "Seating" } }
end
function NonContiguousCount(t)
  local n = 0
  for _ in pairs(t) do
    n = n + 1
  end
  return n
end
dofile("FurnitureCatalogue_DevUtility/Dump.lua")
FurCDev.BuildDumpTab()
assert(widgets["FurCDevControl_Dump_Metadump"] and widgets["FurCDevControl_Dump_ReloadUI"])
assert(not widgets["FurCDevControl_Dump_Discoveritems"] and not widgets["FurCDevControl_Dump_Verbosedump"])
FurCDev_SavedVariables = { verbose = "old export" }
widgets["FurCDevControl_Dump_Metadump"].OnClicked()
local meta = FurCDev_SavedVariables.meta
assert(meta.format == "furniture-meta-v1" and meta.locale == "en" and meta.apiVersion == 101051)
assert(meta.items[200001].blueprint == 200002 and meta.items[200001].name == "Meta chair")
assert(meta.items[200001].icon == "/esoui/art/icons/chair.dds" and meta.items[200001].cat == 4)
assert(meta.categories[4].name == "Seating" and FurCDev_SavedVariables.verbose == nil)

-- Emit real Lua-generated lines for the web contract check.
if arg[1] then
  local file = assert(io.open(arg[1], "w"))
  file:write(previous)
  file:close()
else
  io.write(previous)
end
