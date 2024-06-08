local db = FurC.settings["data"]

local sFormat = zo_strformat

local stripTxt = FurC.Utils.stripTxt
local getItemId = FurC.Utils.GetItemId

function FurC.PrintCraftingStation(itemId, recipeArray)
  local craftingType = FurC.GetCraftingSkillType(itemId, recipeArray)
  if not craftingType or not GetCraftingSkillName(craftingType) then
    return ""
  end
  return sFormat(" (<<1>>)", GetCraftingSkillName(craftingType))
end

function FurC.ToChat(output, refresh)
  if type(output) == "number" then
    output = FurC.Utils.GetItemLink(output)
  end

  output = sFormat(output)
  output = stripTxt(output) -- remove chat incompatible parts
  if nil == output or "" == output then
    return
  end
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

local function getNameFromEntry(recipeArray)
  if nil == recipeArray then
    return ""
  end
  if nil == recipeArray.itemName and nil ~= recipeArray.itemId then
    recipeArray.itemName = GetItemLinkName(recipeArray.itemId)
  end
  return recipeArray.itemName or ""
end

function FurC.PrintSource(itemLink, recipeArray)
  if nil == recipeArray then
    recipeArray = FurC.Find(itemLink)
  end
  if nil == recipeArray then
    return
  end

  local source = FurC.GetItemDescription(getItemId(itemLink), recipeArray, true)
  local output = string.format("%s: %s", itemLink, source)
  if recipeArray.achievement and recipeArray.achievement ~= "" then
    output = string.format("%s, requires %s", output, recipeArray.achievement)
  end

  FurC.ToChat(output, true)
end

function FurC.FindByName(namePart)
  local ret = {}
  local itemName = ""
  FurC.Logger:Debug("Looking for %s... ", namePart)
  for itemId, recipeArray in pairs(FurC.settings["data"]) do
    local m = string.match(string.lower(getNameFromEntry(recipeArray)), string.lower(namePart))
    FurC.Logger:Verbose("%s: %s (%s)", recipeArray.itemId, getNameFromEntry(recipeArray), m, string.lower(namePart))
    if nil ~= m then
      table.insert(ret, recipeArray)
    end
  end
  return ret
end
