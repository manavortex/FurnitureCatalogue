local db    = FurnitureCatalogue.settings["data"]

local p     = FurC.DebugOut


function FurC.PrintCraftingStation(itemId, recipeArray)
  local craftingType = FurC.GetCraftingSkillType(itemId, recipeArray)
  if not craftingType or not GetCraftingSkillName(craftingType) then return "" end
  return string.format(" (%s)", GetCraftingSkillName(craftingType))
end

local function prefillChatBox(output, refresh)

  output = zo_strformat(output)
  if nil == output or FURC_EMPTY_STRING == output then return end
  local editControl = CHAT_SYSTEM.textEntry.editControl

  if not refresh then
    output = editControl:GetText() .. output
  elseif CHAT_SYSTEM.textEntry.editControl:HasFocus() then
    editControl:Clear()
  end

  -- trying to get rid of that double click error...
  if IsProtectedFunction("StartChatInput") then
    CallSecureProtected("StartChatInput", output)
  else
    StartChatInput(output)
  end
end

function FurC.ToChat(output, refresh)
  if type(output) == "number" then
    output = FurC.GetItemLink(output)
  end
  prefillChatBox(output, refresh)
end

local function stripColor(aString)
  if nil == aString then return "" end
  return aString:gsub("|%l%l%d%d%d%d%d", ""):gsub("|%l%l%d%l%l%d%d", ""):gsub("|c25C31E", ""):gsub("|r", "")
end

local function getNameFromEntry(recipeArray)
  if nil == recipeArray then return "" end
  if nil == recipeArray.itemName and nil ~= recipeArray.itemId then
    recipeArray.itemName = GetItemLinkName(recipeArray.itemId)
  end
  return recipeArray.itemName or ""
end

function FurC.PrintSource(itemLink, recipeArray)
  if nil == recipeArray then recipeArray = FurC.Find(itemLink) end
  if nil == recipeArray then return end

  local source = FurC.GetItemDescription(FurC.GetItemId(itemLink), recipeArray, true)
  local output = string.format("%s: %s", itemLink, source)
  if recipeArray.achievement and recipeArray.achievement ~= "" then
    output = string.format("%s, requires %s", output, recipeArray.achievement)
  end

  FurC.ToChat(output, true)
end

function FurC.FindByName(namePart)
  local ret = {}
  local itemName = ""
  -- d(zo_strformat("Looking for <<1>>... \n", namePart))
  for itemId, recipeArray in pairs(FurC.settings["data"]) do
    -- d(zo_strformat("<<1>>: <<2>> (<<3>>)", recipeArray.itemId, getNameFromEntry(recipeArray), string.match(string.lower(getNameFromEntry(recipeArray)), string.lower(namePart))))
    if nil ~= string.match(string.lower(getNameFromEntry(recipeArray)), string.lower(namePart)) then
      table.insert(ret, recipeArray)
    end
  end
  return ret
end

local function capitalise(str)
  str = str:gsub("^(%l)(%w*)", function(a,b) return string.upper(a)..b end)
  return str
end

