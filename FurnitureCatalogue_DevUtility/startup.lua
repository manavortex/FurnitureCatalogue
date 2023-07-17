FurCDev = {}

local this = FurCDev

local control = FurCDevControl

this.name = "FurnitureCatalogue_DevUtility"
this.control = control
this.textbox = FurCDevControlBox

local function toggleEditBox()
  control:SetHidden(not control:IsHidden())
end
this.ToggleEditBox = toggleEditBox
SLASH_COMMANDS["/furcdev"] = this.ToggleEditBox

local function init(_, addonName)
  if addonName ~= this.name then
    return
  end
  this.textbox = FurCDevControlBox
  this.textbox:SetMaxInputChars(3000)
  this.InitRightclickMenu()

  EVENT_MANAGER:UnregisterForEvent(FurCDev.name, EVENT_ADD_ON_LOADED)
end

function FurnitureCatalogueDevUtility_AddToTextbox()
  FurCDevControl_HandleInventoryContextMenu(moc())
end

ZO_CreateStringId("SI_BINDING_NAME_FURC_CONCAT_TO_TEXTBOX", "Add to |cFF3333FurCDev|r text box")
EVENT_MANAGER:RegisterForEvent(this.name, EVENT_ADD_ON_LOADED, init)
