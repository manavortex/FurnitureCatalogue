local control   = FurCDevControl
FurCDevUtility  = {}
local this      = FurCDevUtility

this.name       = "FurnitureCatalogue_DevUtility"
this.control    = control
this.textbox    = FurCDevControlBox
local active 	= string.find(GetWorldName(), "PTS")

FurCDevUtility.playersWithDevAccess = {
	["@manavortex"] = true,		-- the real me
	["@Manorin"] = true,		-- alt account
	["@tïm'99"] = true,	 		-- let's hope the ï doesn't destroy everything
	["@tïm&#39;99"] = true,	-- Called it
}

local UNITTAG_PLAYER = "player"
local displayName
function FurCDevUtility.isDev()
	if FurC.isDev then return FurC.isDev() end
	displayName = displayName or GetUnitDisplayName(UNITTAG_PLAYER)
	return FurCDevUtility.playersWithDevAccess[displayName]
end

if not FurCDevUtility.isDev() then return end




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

    if arg1 == activeStr then return set_active(true) end
    if arg1 == showStr then return setHidden(false) end
    if arg1 == hideStr then return setHidden(true) end
	d("/furcdev -> active to set active, show to show, hide to hide")
    
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

