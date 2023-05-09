function FurC.CreateSettings(savedVars, defaults)
  local LAM = LibAddonMenu2
  local panelData = {
    type = "panel",
    name = FurC.name,
    displayName = FurC.name,
    author = FurC.author,
    version = FurC.version,
    registerForRefresh = true,
    registerForDefaults = true,
    slashCommand = "/furc",
  }
  LAM:RegisterAddonPanel("FurC_OptionsPanel", panelData)
  local optionsData = { -- optionsData

    -- first section
    {
      -- checkbox: Debug output
      type = "checkbox",
      name = GetString(SI_FURC_STRING_MENU_DEBUG),
      tooltip = "",
      getFunc = function() return FurC.GetEnableDebug() end,
      setFunc = function(value) FurC.SetEnableDebug(value) end
    },
    {
      -- button: Reset database
      type    = "button",
      name    = GetString(SI_FURC_STRING_MENU_RESET_DB_NAME),
      tooltip = GetString(SI_FURC_STRING_MENU_RESET_DB_TT),
      warning = GetString(SI_FURC_STRING_MENU_RESET_DB_WARNING),
      func    = function()
        FurC.WipeDatabase()
      end,
    },
    {
      -- button: Reset database
      type    = "button",
      name    = GetString(SI_FURC_STRING_MENU_RESCAN_RUMOUR_NAME),
      width   = "half",
      tooltip = GetString(SI_FURC_STRING_MENU_RESCAN_RUMOUR_TT),
      func    = function() FurC.RescanRumourRecipes() end,
    },
    {
      -- button: Re-scan data
      type    = "button",
      name    = GetString(SI_FURC_STRING_MENU_SCAN_FILES_NAME),
      tooltip = GetString(SI_FURC_STRING_MENU_SCAN_FILES_TT),
      width   = "half",
      func    = function()
        FurC.ScanRecipes(true, false)
        FurC.UpdateGui()
      end,
    },
    {
      -- button: Re-scan data
      type    = "button",
      name    = GetString(SI_FURC_STRING_MENU_SCAN_CHAR_NAME),
      tooltip = GetString(SI_FURC_STRING_MENU_SCAN_CHAR_TT),
      width   = "half",
      func    = function()
        FurC.ScanRecipes(false, true)
        FurC.UpdateGui()
      end,
    },
    {
      -- dropdown: delete character
      type = "dropdown",
      name = GetString(SI_FURC_STRING_MENU_DELETE_CHAR_NAME),
      tooltip = GetString(SI_FURC_STRING_MENU_DELETE_CHAR_TT),
      warning = GetString(SI_FURC_STRING_MENU_DELETE_CHAR_WARNING),
      choices = FurC.GetAccountCharacters(),
      getFunc = function() return end,
      setFunc = function(value)
        FurC.DeleteCharacter(value)
      end,
    },

    -- =======================================================================================
    -- header: Furniture Shopping List integration
    -- =======================================================================================
    {
      -- header: Furniture Shopping List integration
      type = "header",
      name = "Furniture Shopping List",
    },
    {
      -- checkbox: Enable
      type    = "checkbox",
      name    = GetString(SI_FURC_STRING_MENU_ENABLE_SHOPPINGLIST),
      getFunc = function() return (FurC.GetEnableShoppingList()) end,
      setFunc = function(value) FurC.SetEnableShoppingList(value) end
    },

    -- =======================================================================================
    -- header: UI and performance
    -- =======================================================================================
    {
      -- header: UI and performance
      type = "header",
      name = "Performance",
    },

    {
      -- checkbox: Skip Initial Scan
      type    = "checkbox",
      name    = GetString(SI_FURC_STRING_MENU_SKIP_INITIALSCAN),
      tooltip = GetString(SI_FURC_STRING_MENU_SKIP_INITIALSCAN_TT),
      getFunc = function() return FurC.GetSkipInitialScan() end,
      setFunc = function(value) FurC.SetSkipInitialScan(value) end
    },
    -- =======================================================================================
    -- header: Inventory and bank
    -- =======================================================================================
    {
      -- header: Inventory and bank
      type = "submenu", -- Inventory and bank icons
      name = GetString(SI_FURC_STRING_MENU_HEADER_ICONS),
      controls = {
        {
          -- checkbox: Add items to known/unknown recipes?
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_ADD_ITEMS_NAME),
          tooltip = GetString(SI_FURC_STRING_MENU_ADD_ITEMS_TT),
          getFunc = function() return FurC.GetUseInventoryIcons() end,
          setFunc = function(value) FurC.SetUseInventoryIcons(value) end
        },
        {
          -- checkbox: Only mark unknown recipes
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_IT_UNKNOWN_NAME),
          getFunc = function() return FurC.GetHideKnownInventoryIcons() end,
          setFunc = function(value) FurC.SetHideKnownInventoryIcons(value) end
        },
        {
          -- checkbox: Add items to known/unknown recipes?
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_IT_THIS_ONLY),
          tooltip = GetString(SI_FURC_STRING_MENU_IT_THIS_ONLY_TT),
          getFunc = function() return FurC.GetUseInventoryIconsOnChar() end,
          setFunc = function(value) FurC.SetUseInventoryIconsOnChar(value) end
        },
      },
    },
    -- =======================================================================================
    -- header: UI and performance
    -- =======================================================================================
    {
      -- header: UI and performance
      type = "header",
      name = "User Interface",
    },
    {
      -- checkbox: use small interface?
      type    = "checkbox",
      name    = GetString(SI_FURC_STRING_MENU_USETINY),
      tooltip = GetString(SI_FURC_STRING_MENU_USETINY_TT),
      getFunc = function() return FurC.GetTinyUi() end,
      setFunc = function(value) FurC.SetTinyUi(value) end
    },
    {
      -- checkbox: show Icon on left of items?
      type           = "checkbox",
      name           = GetString(SI_FURC_STRING_MENU_SHOWICONONLEFT),
      tooltip        = GetString(SI_FURC_STRING_MENU_SHOWICONONLEFT_TT),
      getFunc        = function() return FurC.GetShowIconOnLeft() end,
      setFunc        = function(value) FurC.SetShowIconOnLeft(value) end,
      requiresReload = true
    },
    {
      -- slider: font size
      type    = "slider",
      name    = GetString(SI_FURC_STRING_MENU_FONTSIZE),
      tooltip = GetString(SI_FURC_STRING_MENU_FONTSIZE_TT),
      min     = 10,
      max     = 28,
      getFunc = function() return FurC.GetFontSize() end,
      setFunc = function(value) FurC.SetFontSize(value) end
    },
    {
      -- checkbox: show inventory context menu?
      type           = "checkbox",
      name           = GetString(SI_FURC_STRING_CONTEXTMENU_INVENTORY),
      tooltip        = GetString(SI_FURC_STRING_CONTEXTMENU_INVENTORY_TT),
      getFunc        = function() return FurC.GetHideInventoryMenu() end,
      setFunc        = function(value) FurC.SetHideInventoryMenu(value) end,
      requiresReload = true
    },
    {
      -- checkbox: use right click menu divider?
      type           = "checkbox",
      name           = GetString(SI_FURC_STRING_CONTEXTMENU_DIVIDER),
      tooltip        = GetString(SI_FURC_STRING_CONTEXTMENU_DIVIDER_TT),
      getFunc        = function() return FurC.GetSkipDivider() end,
      setFunc        = function(value) FurC.SetSkipDivider(value) end,
      requiresReload = true
    },
    {
      type = "submenu", -- Default dropdown values
      name = GetString(SI_FURC_STRING_MENU_DEFAULT_DD),
      controls = {
        {
          -- description: Default dropdown
          type = "description",
          name = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_USE),
          text = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_USE_TT),
        },

        {
          -- checkbox: Persistent?
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_RESET),
          tooltip = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_RESET_TT),
          getFunc = function() return FurC.GetResetDropdownChoice() end,
          setFunc = function(value) FurC.SetResetDropdownChoice(value) end
        },
        {
          -- dropdown: default source
          type    = "dropdown",
          name    = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_SOURCE),
          choices = FurC.GetChoicesSource(),
          getFunc = function() return FurC.GetDefaultDropdownChoiceText("Source") end,
          setFunc = function(value) FurC.SetDefaultDropdownChoice("Source", value) end
        },
        {
          -- dropdown: default character
          type    = "dropdown",
          name    = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_CHAR),
          choices = FurC.DropdownData.ChoicesCharacter,
          getFunc = function() return FurC.GetDefaultDropdownChoiceText("Character") end,
          setFunc = function(value) FurC.SetDefaultDropdownChoice("Character", value) end
        },
        {
          -- dropdown: default version
          type    = "dropdown",
          name    = GetString(SI_FURC_STRING_MENU_DEFAULT_DD_VERSION),
          choices = FurC.DropdownData.ChoicesVersion,
          getFunc = function() return FurC.GetDefaultDropdownChoiceText("Version") end,
          setFunc = function(value) FurC.SetDefaultDropdownChoice("Version", value) end
        },
      },
    },

    -- =======================================================================================
    -- submenu: Catalogue filtering
    -- =======================================================================================
    {
      type = "submenu", -- Catalogue filtering
      name = GetString(SI_FURC_STRING_MENU_FILTERING),
      controls = {
        {
          type = "submenu",
          name = GetString(SI_FURC_STRING_MENU_HEADER_F_ALL_ON_TEXT),
          controls = {
            {
              -- description: Default dropdown
              type = "description",
              name = GetString(SI_FURC_STRING_MENU_F_ALL_ON_TEXT),
              text = GetString(SI_FURC_STRING_MENU_HEADER_F_ALL_DESC),
            },

            {
              -- checkbox: Filter everything when text searching without dropdown
              type    = "checkbox",
              name    = GetString(SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT),
              tooltip = GetString(SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT_TT),
              getFunc = function() return FurC.GetFilterAllOnText() end,
              setFunc = function(value) FurC.SetFilterAllOnText(value) end
            },
            {
              -- checkbox: Exclude books from these
              type     = "checkbox",
              name     = GetString(SI_FURC_STRING_MENU_FALL_HIDE_BOOKS),
              tooltip  = GetString(SI_FURC_STRING_MENU_FALL_HIDE_BOOKS_TT),
              getFunc  = function() return FurC.GetFilterAllOnTextNoBooks() end,
              setFunc  = function(value) FurC.SetFilterAllOnTextNoBooks(value) end,
              disabled = not FurC.GetFilterAllOnText()
            },
            {
              -- checkbox: Exclude crown store items from these
              type     = "checkbox",
              name     = GetString(SI_FURC_STRING_MENU_FALL_HIDE_CROWN),
              tooltip  = GetString(SI_FURC_STRING_MENU_FALL_HIDE_CROWN_TT),
              getFunc  = function() return FurC.GetFilterAllOnTextNoCrown() end,
              setFunc  = function(value) FurC.SetFilterAllOnTextNoCrown(value) end,
              disabled = not FurC.GetFilterAllOnText()
            },
            {
              -- checkbox: Exclude crown store items from these
              type     = "checkbox",
              name     = GetString(SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR),
              tooltip  = GetString(SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR_TT),
              getFunc  = function() return FurC.GetFilterAllOnTextNoRumour() end,
              setFunc  = function(value) FurC.SetFilterAllOnTextNoRumour(value) end,
              disabled = not FurC.GetFilterAllOnText()
            },
          },
        },

        -- ===============================================================================
        -- header: Mages guild books
        -- ===============================================================================
        {
          -- header: Mages guild books
          type = "header",
          name = GetString(SI_FURC_STRING_MENU_FILTER_BOOKS),
        },
        {
          -- checkbox: Hide Mages' guild books
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_FILTER_BOOKS_N),
          tooltip = GetString(SI_FURC_STRING_MENU_FILTER_BOOKS_TT),
          getFunc = function() return FurC.GetHideBooks() end,
          setFunc = function(value) FurC.SetHideBooks(value) end
        },

        {
          -- header: Luxury items
          type = "header",
          name = GetString(SI_FURC_STRING_MENU_LUXURY),
        },
        {
          -- checkbox: Hide Mages' guild books
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_LUXURY_N),
          tooltip = GetString(SI_FURC_STRING_MENU_LUXURY_TT),
          warning = GetString(SI_FURC_STRING_MENU_LUXURY_WARN),
          getFunc = function() return FurC.GetMergeLuxuryAndSales() end,
          setFunc = function(value) FurC.SetMergeLuxuryAndSales(value) end
        },

        -- ===============================================================================
        -- header: Rumour Recipes
        -- ===============================================================================
        {
          -- header: rumour recipes
          type = "header",
          name = "Rumour Recipes",
        },
        {
          -- checkbox: Hide doubtful recipes
          type = "description",
          name = GetString(SI_FURC_STRING_MENU_RUMOUR),
          text = GetString(SI_FURC_STRING_MENU_RUMOUR_DESC),
        },
        {
          -- checkbox: Hide doubtful recipes
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_RUMOUR_N),
          getFunc = function() return FurC.GetHideRumourRecipes() end,
          setFunc = function(value) FurC.SetHideRumourRecipes(value) end
        },

        {
          -- checkbox: Show UI button in search box?
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_FALL_HIDE_UI_BUTTON),
          getFunc = function() return FurC.GetHideUIButton(FURC_RUMOUR) end,
          setFunc = function(value) FurC.SetHideUIButton(FURC_RUMOUR, value) end
        },

        {
          -- Crown store items
          type = "header",
          name = "Crown store",
        },
        {
          -- The furniture database contains a list of recipes that I have...
          type = "description",
          name = GetString(SI_FURC_STRING_MENU_CROWN),
          text = GetString(SI_FURC_STRING_MENU_CROWN_DESC),
        },
        {
          -- checkbox: Hide crown stuff
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_CROWN_N),
          getFunc = function() return FurC.GetHideCrownStoreItems() end,
          setFunc = function(value) FurC.SetHideCrownStoreItems(value) end
        },
        {
          -- checkbox: Show UI button in search box?
          type    = "checkbox",
          name    = GetString(SI_FURC_STRING_MENU_FALL_HIDE_UI_BUTTON),
          getFunc = function() return FurC.GetHideUIButton(FURC_CROWN) end,
          setFunc = function(value) FurC.SetHideUIButton(FURC_CROWN, value) end
        },
      },
    },

    -- =======================================================================================
    -- header: Tooltip
    -- =======================================================================================
    {
      -- header: Tooltip
      type = "header",
      name = "Tooltip",
    },
    {
      -- checkbox: Disable
      type    = "checkbox",
      name    = GetString(SI_FURC_STRING_MENU_TOOLTIP),
      getFunc = function() return (not FurC.GetDisableTooltips()) end,
      setFunc = function(value) FurC.SetDisableTooltips(not value) end
    },
    {
      -- checkbox: Colorize tooltips for clarity?
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_COLOR),
      tooltip  = GetString(SI_FURC_STRING_MENU_TOOLTIP_COLOR_TT),
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return FurC.GetColouredTooltips() end,
      setFunc  = function(value) FurC.SetColouredTooltips(value) end
    },
    {
      -- checkbox: Hide 'known by' from tooltip
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN),
      tooltip  = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN_TT),
      width    = "half",
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return (FurC.GetHideKnowledge()) end,
      setFunc  = function(value) FurC.SetHideKnowledge(value) end
    },
    {
      -- checkbox: Hide 'known by' from tooltip
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN),
      tooltip  = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN_TT),
      width    = "half",
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return (FurC.GetHideUnknown()) end,
      setFunc  = function(value) FurC.SetHideUnknown(value) end
    },
    {
      -- checkbox: Hide item source
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_SOURCE),
      tooltip  = "",
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return (FurC.GetHideSource()) end,
      setFunc  = function(value) FurC.SetHideSource(value) end
    },
    {
      -- checkbox: Hide item source
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_STATION),
      tooltip  = "",
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return (FurC.GetHideCraftingStation()) end,
      setFunc  = function(value) FurC.SetHideCraftingStation(value) end
    },
    {
      -- checkbox: Hide materials from tooltip
      type     = "checkbox",
      name     = GetString(SI_FURC_STRING_MENU_TOOLTIP_HIDE_MATERIAL),
      tooltip  = "",
      disabled = FurC.GetDisableTooltips(),
      getFunc  = function() return (FurC.GetHideMats()) end,
      setFunc  = function(value) FurC.SetHideMats(value) end
    },
  } -- optionsData end

  LAM:RegisterOptionControls("FurC_OptionsPanel", optionsData)
end
