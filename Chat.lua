-- Chat output: post item sources / crafting stations to chat

local sFormat = zo_strformat

local LFC = LibFurnitureCatalogue
local sourceFormat = FurC.SourceFormat
local stripTxt = sourceFormat.Strip
local getEntry = LFC.API.GetEntry
local getItemId = LFC.API.GetItemId
local getItemLink = LFC.API.GetItemLink
local query = FurC.DBQuery

-- What the chat input takes. Anything past it is cut off when the message is sent
local CHAT_LIMIT = 350

---Does this text survive being sent as one chat message
---@param text string
---@return boolean
function FurC.ChatFits(text)
  return #tostring(text or "") <= CHAT_LIMIT
end

---An item's material list for the chat input: item links while they fit, plain names when they do not
---@param itemOrLink string|integer
---@param entry FurCEntry|nil
---@return string
function FurC.MaterialsForChat(itemOrLink, entry)
  local text = sourceFormat.FormatMaterials(itemOrLink, entry)
  if FurC.ChatFits(text) then
    return text
  end
  return sourceFormat.FormatMaterials(itemOrLink, entry, true)
end

function FurC.PrintCraftingStation(itemId, recipeArray)
  local craftingType = query.GetCraftingSkillType(itemId, recipeArray)
  if not craftingType or not GetCraftingSkillName(craftingType) then
    return ""
  end
  return sFormat(" (<<1>>)", GetCraftingSkillName(craftingType))
end

function FurC.ToChat(output, refresh)
  if type(output) == "number" then
    output = getItemLink(output)
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

function FurC.PrintSource(itemLink, recipeArray)
  if nil == recipeArray then
    recipeArray = getEntry(itemLink)
  end
  if nil == recipeArray then
    return
  end

  local source =
    sourceFormat.FormatDescription(getItemId(itemLink), recipeArray, true, { dateFormat = FurC.GetDateFormat() })
  local output = string.format("%s: %s", itemLink, source)
  if recipeArray.achievement and recipeArray.achievement ~= "" then
    output = string.format("%s, requires %s", output, recipeArray.achievement)
  end

  FurC.ToChat(output, true)
end
