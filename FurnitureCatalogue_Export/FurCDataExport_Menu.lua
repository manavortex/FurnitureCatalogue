function FurCExport.makeSettings()
  
  local settings = FurCExport.settings

  local LAM = LibAddonMenu2
  local panelData = {
    type = "panel",
    name = "FurnitureCatalogue_Export",
    displayName = "FurnitureCatalogue Export",
     author = "manavortex",
    version = "1.0.0",
    registerForRefresh = true,
    registerForDefaults = true,
  }

  LAM:RegisterAddonPanel("FurnitureCatalogueExport_OptionsPanel", panelData)
  local optionsData = { -- optionsData
  
  
    { -- description
      type = "description",
      name = "FurnitureCatalogue Export",
      text = (
        "After an UI reload, FurnitureCatalogue's database can be found in your \n" ..
        "SavedVariables folder inside  FurnitureCatalogue_Export.lua \n"
      ),
    },
    { -- button: Reset database
      type = "button",
      name = "Export data",
      warning = "This will reload the UI",      
      func = function() 
        FurCExport.Export()
      end,
    },    
  }
  
  
  LAM:RegisterOptionControls("FurnitureCatalogueExport_OptionsPanel", optionsData)

end