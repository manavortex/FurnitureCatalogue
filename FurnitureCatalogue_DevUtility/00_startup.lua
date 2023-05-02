local control  = FurCDevControl
FurCDevUtility = {}
local this     = FurCDevUtility

this.name      = "FurnitureCatalogue_DevUtility"
this.control   = control
this.textbox   = FurCDevControlBox
local active   = string.find(GetWorldName(), "PTS")

local logger   = FurC.Logger




local function set_active(status)
  if nil == status then status = not this.active end
  this.active = status
end
FurCDevUtility.set_active = set_active

local function setHidden(status)
  if nil == status then status = not control:IsHidden() end
  control:SetHidden(status)
end
FurCDevUtility.setHidden = setHidden

local activeStr          = "active"
local showStr            = "show"
local hideStr            = "hide"
local function slash_cmd(arg1)
  if arg1 == activeStr then return set_active(true) end
  if arg1 == showStr then return setHidden(false) end
  if arg1 == hideStr then return setHidden(true) end
  logger:Info("/furcdev -> active to set active, show to show, hide to hide")
end
SLASH_COMMANDS["/furcdev"] = slash_cmd

function FurCDevUtility_Initialize(_, addonName)
  if addonName ~= this.name then return end
  this.textbox = FurCDevControlBox
  this.textbox:SetMaxInputChars(3000)
  this.InitRightclickMenu()

  EVENT_MANAGER:UnregisterForEvent("FurCDevUtility", EVENT_ADD_ON_LOADED)
end

function FurnitureCatalogueDevUtility_AddToTextbox()
  FurCDevControl_HandleInventoryContextMenu(moc())
end

ZO_CreateStringId("FURC_CONCAT_TO_TEXTBOX", "Add to FurC Dev utility control")
EVENT_MANAGER:RegisterForEvent("FurCDevUtility", EVENT_ADD_ON_LOADED, FurCDevUtility_Initialize)
