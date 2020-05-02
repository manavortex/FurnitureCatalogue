

local UNITTAG_PLAYER = "player"
local function whoami()
    return GetUnitDisplayName(UNITTAG_PLAYER)
end

local isMana    = string.find(whoami(), "@manavortex") or string.find(whoami(), "@Manorin") 
if not isMana   then return end


local control   = FurCDevControl
FurCDevUtility  = {}
local this      = FurCDevUtility
this.name       = "FurnitureCatalogue_DevUtility"
this.control    = control
this.textbox    = FurCDevControlBox
local active = string.find(GetWorldName(), "PTS")
local logger = LibDebugLogger(this.name)

local function set_active(status)
    if nil == status then status = not this.active  end
    this.active = status
end
FurCDevUtility.set_active = set_active

local function setHidden(status)
    if nil == status then status = not control:IsHidden() end
    control:SetHidden(status)
end
FurCDevUtility.setHidden = setHidden

local activeStr = "active"
local showStr   = "show"
local hideStr   = "hide"
function slash_cmd(arg1)

    if arg1 == activeStr then 
        set_active(true)
    elseif arg1 == showStr then
        setHidden(false)
    elseif arg1 == hideStr then
        setHidden(true)
    else
        d("/furcdev -> active to set active, show to show, hide to hide")
    end
end
SLASH_COMMANDS["/furcdev"] = slash_cmd

function FurCDevUtility_Initialize(eventCode, addonName)

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

