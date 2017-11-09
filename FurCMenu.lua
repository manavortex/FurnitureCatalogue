function FurC.CreateSettings(savedVars, defaults)

	local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")
	local panelData = {
		type = "panel",
		name = FurC.name,
		displayName = name,
	 	author = FurC.author,
		version = FurC.version,
		registerForRefresh = true,
		slashCommand = "/furc",	}

	LAM:RegisterAddonPanel("FurnitureCatalogue_OptionsPanel", panelData)
	local optionsData = { -- optionsData

		-- first section
		{ -- checkbox: Debug output
			type = "checkbox",
			name = "Enable debug output",
			tooltip = "",
			getFunc = function() return FurC.GetEnableDebug() end,
			setFunc = function(value) FurC.SetEnableDebug(value) end
		},		
		{ -- button: Reset database
			type = "button",
			name = "|cFF0000Reset database|r",
			tooltip = "This will reset the furniture database.",
			warning = "All your data will be reset. Only recipe knowledge for this character will be considered.",			
			func = function() 
				FurC.WipeDatabase()
			end,
		},	
		{ -- button: Reset database
			type = "button",
			name = "Re-scan Rumour recipes",
			width= "half",
			tooltip = "Will update the rumour recipes against the updated list",	
			func = function() 
				FurC.RescanRumourRecipes()
			end,
		},	
		{ -- button: export
			type = "button",
			name = "Export",
			width = "half",
			tooltip = ("Will create an alphabetically sorted list of the item names you can craft.\n" ..
						"You can find this list in the savedVars file, search for [\"export\"]."),
			warning = "Will reload UI when done",
			func = function() 
				FurC.Export()
				d(	"|c2266ffFurniture catalogue|r|cFFFFFF export complete |r\n"..
					"|cFFFFFFYou can find the generated data in |rElder Scrolls Online\live\SavedVariables \n" .. 
					"|cFFFFFFFind |r|c2266ffFurnitureCatalogue.lua |cFFFFFFand search for |r[\"export\"]")
			end,
		},				
		{ -- button: Re-scan data
			type = "button",
			name = "Scan files",
			tooltip = "Will run a full scan of the data in Furniture Catalogue's files",
			width = "half",
			func = function() 
				FurC.ScanRecipes(true, false)
				FurC.UpdateGui()
			end,
		},		
		{ -- button: Re-scan data
			type = "button",
			name = "Scan character",
			tooltip = "Will run a full scan of your known furniture recipes and update the database accordingly",
			width = "half",
			func = function() 
				FurC.ScanRecipes(false, true)
				FurC.UpdateGui()
			end,
		},	
		{ -- dropdown: delete character
			type = "dropdown",
			name = "delete character",
			tooltip = ("Deletes all knowledge for this character from the database. \n" .. 
				"Character will be scanned again the next time they log in with the add-on enabled. \n" ..
				"Character name won't show up in the dropdown if they don't know any recipes!"),
			warning = "Character knowledge will be wiped immediately",
			choices = FurC.GetAccountCharacters(),
			getFunc = function() return end,
			setFunc = function(value) 
				FurC.DeleteCharacter(value)
			end, 
		},		
		
		
		-- =======================================================================================
		-- header: Furniture Shopping List integration
		-- =======================================================================================
		{	-- header: Furniture Shopping List integration
			type = "header",
			name = "Furniture Shopping List",
		},
		{ -- checkbox: Enable
			type = "checkbox",
			name = "Enable integration?",
			getFunc = function() return (FurC.GetEnableShoppingList()) end,
			setFunc = function(value) FurC.SetEnableShoppingList(value) end
		},		
		
		
		-- =======================================================================================
		-- header: UI and performance
		-- =======================================================================================
		{	-- header: UI and performance
			type = "header",
			name = "Performance",
		},		
		
		{ -- checkbox: Skip Initial Scan
			type = "checkbox",
			name = "Skip Initial Scan?",
			tooltip = "Check this to not scan your character's recipes on login. \nThanks to votan's awesome LibAsync the lag is gone now in any case..",
			getFunc = function() return FurC.GetSkipInitialScan() end,
			setFunc = function(value) FurC.SetSkipInitialScan(value) end
		},		
		-- =======================================================================================
		-- header: Inventory and bank
		-- =======================================================================================
		{	-- header: Inventory and bank
			type = "submenu",
			name = "Inventory and bank icons",
			controls = {
				{ -- checkbox: Add items to known/unknown recipes?
					type = "checkbox",
					name = "Add items to known/unknown recipes?",
					tooltip = "This might cause a slight lag upon opening inventory..",
					getFunc = function() return FurC.GetUseInventoryIcons() end,
					setFunc = function(value) FurC.SetUseInventoryIcons(value) end
				},
				{ -- checkbox: Only mark unknown recipes
					type = "checkbox",
					name = "Only mark unknown recipes?",
					getFunc = function() return FurC.GetHideKnownInventoryIcons() end,
					setFunc = function(value) FurC.SetHideKnownInventoryIcons(value) end
				},
				{ -- checkbox: Add items to known/unknown recipes?
					type = "checkbox",
					name = "Only for this character?",
					tooltip = "Will be accountwide otherwise.",
					getFunc = function() return FurC.GetUseInventoryIconsOnChar() end,
					setFunc = function(value) FurC.SetUseInventoryIconsOnChar(value) end
				},	
			},
		},
		-- =======================================================================================
		-- header: UI and performance
		-- =======================================================================================
		{	-- header: UI and performance
			type = "header",
			name = "User Interface",
		},
		{ -- checkbox: use small interface?
			type = "checkbox",
			name = "Use tiny interface?",
			tooltip = (
				"Use a smaller interface (Craft Store like). \n" ..
				"You can toggle this from the UI by clicking the +/- button."
			),
			getFunc = function() return FurC.GetTinyUi() end,
			setFunc = function(value) FurC.SetTinyUi(value) end
		},
		{ -- checkbox: use small interface?
			type = "checkbox",
			name = "Start silently?",
			tooltip = "Suppress startup message",
			getFunc = function() return FurC.GetStartupSilently() end,
			setFunc = function(value) FurC.SetStartupSilently(value) end
		},
		{ -- slider: font size
			type = "slider",
			name = "Font size",
			tooltip = "adjust font size for FurnitureCatalogue here",
			min 	= 10, 
			max 	= 28,
			getFunc = function() return FurC.GetFontSize() end,
			setFunc = function(value) FurC.SetFontSize(value) end
		},
		{	type = "submenu",
			name = "Default dropdown values",
			controls = {
				{ -- description: Default dropdown
					type = "description",
					name = "Will be set on initial launch",
					text = ("These will not reset if you open and close the UI" ),
				},
				
				{ -- checkbox: Persistent?
					type = "checkbox",
					name = "Reset filters when closing UI?",
					tooltip = "If you check this, opening and closing will cause the filters to reset to whatever you set below.",
					getFunc = function() return FurC.GetResetDropdownChoice() end,
					setFunc = function(value) FurC.SetResetDropdownChoice(value) end
				},
				
				{ -- dropdown: default source
					type = "dropdown",
					name = "default source filter",
					choices = FurnitureCatalogue.DropdownData.ChoicesSource,
					getFunc = function() return FurC.GetDefaultDropdownChoiceText("Source") end,
					setFunc = function(value) FurC.SetDefaultDropdownChoice("Source", value) end
				},	
				{ -- dropdown: default character
					type = "dropdown",
					name = "default character filter",
					choices = FurnitureCatalogue.DropdownData.ChoicesCharacter,
					getFunc = function() return FurC.GetDefaultDropdownChoiceText("Character") end,
					setFunc = function(value) FurC.SetDefaultDropdownChoice("Character", value) end
				},		
				{ -- dropdown: default version
					type = "dropdown",
					name = "default version filter",
					choices = FurnitureCatalogue.DropdownData.ChoicesVersion,
					getFunc = function() return FurC.GetDefaultDropdownChoiceText("Version") end,
					setFunc = function(value) FurC.SetDefaultDropdownChoice("Version", value) end
				},
			},
		},

		
		-- =======================================================================================
		-- submenu: Catalogue filtering
		-- =======================================================================================
		{	type = "submenu",
			name = "Catalogue filtering",
			controls = {
			
				-- ===============================================================================
				-- header: Mages guild books
				-- ===============================================================================
				{	-- header: Mages guild books
					type = "header",
					name = "Mages guild books",
				},		
				{ -- checkbox: Hide Mages' guild books
					type = "checkbox",
					name = "Hide books?",
					tooltip = "A real book lover knows where everything is by heart. Hide books from Furniture Catalogue?",
					getFunc = function() return FurC.GetHideBooks() end,
					setFunc = function(value) FurC.SetHideBooks(value) end
				},
				
				{	-- header: Luxury items
					type = "header",
					name = "Luxury Furnishings",
				},		
				{ -- checkbox: Hide Mages' guild books
					type = "checkbox",
					name = "Treat luxury items as purchaseables?",
					tooltip = "This will show everything that was sold by Zanil Theran under 'purchaseable' and deactvates the custom filter",
					warning = "Hiding the dropdown entry requires UI reload (won't happen automatically for your convenience)",
					getFunc = function() return FurC.GetMergeLuxuryAndSales() end,
					setFunc = function(value) FurC.SetMergeLuxuryAndSales(value) end
				},
				
				
				-- ===============================================================================
				-- header: Rumour Recipes
				-- ===============================================================================
				{	-- header: rumour recipes
					type = "header",
					name = "Rumour Recipes",
				},
				{ -- checkbox: Hide doubtful recipes
					type = "description",
					name = "Rumour Recipes",
					text = (
						"The furniture database contains a list of recipes that I have datamined.\n" .. 
						"However, not all of those have been seen in-game.\n " ..
						"Enable this option to exclude them from the default filters.\n" .. 
						"You can still view them with their own filter, which you can disable below."
						),
				},
				{ -- checkbox: Hide doubtful recipes
					type = "checkbox",
					name = "Hide rumour recipes?",
					getFunc = function() return FurC.GetHideRumourRecipes() end,
					setFunc = function(value) FurC.SetHideRumourRecipes(value) end
				},
				{	-- header: rumour recipes
					type = "header",
					name = "Crown store",
				},
				{ -- checkbox: Hide doubtful recipes
					type = "description",
					name = "Crown store items",
					text = (
						"The furniture database will update whenever the tooltip shows a furniture item. \n" ..
						"Some items can only be acquired via crown store. \n"..
						"Check this box to exclude them from the default filters (disable crown store filter below)."
					),
				},
				{ -- checkbox: Hide doubtful recipes
					type = "checkbox",
					name = "Hide crown store items?",
					getFunc = function() return FurC.GetHideCrownStoreItems() end,
					setFunc = function(value) FurC.SetHideCrownStoreItems(value) end
				},
				{	-- header: rumour recipes
					type = "header",
					name = "Hide menu entries?",
				},
				{ -- checkbox: Hide doubtful recipes
					type = "description",
					name = "Hide menu entries",
					text = (
						"Hides \"Crown store\" and \"Rumour recipes\" from the dropdown\n"
						.. "activated for crown store by default, as there aren't any items yet"
					),
				},
				{ -- checkbox: Hide rumour recipes menu entry
					type = "checkbox",
					name = "Hide \"Rumour recipes\"",
					warning = "Requires UI reload (won't happen automatically for your convenience)",
					getFunc = function() return FurC.GetHideRumourRecipesEntry() end,
					setFunc = function(value) FurC.SetHideRumourRecipesEntry(value) end
				},
				{ -- checkbox: Hide doubtful recipes
					type = "checkbox",
					name = "Hide crown store drop down entry?",
					warning = "Requires UI reload (won't happen automatically for your convenience)",
					getFunc = function() return FurC.GetHideCrownStoreEntry() end,
					setFunc = function(value) FurC.SetHideCrownStoreEntry(value) end
				},
			},
		},		
		
		-- =======================================================================================
		-- header: Tooltip
		-- =======================================================================================
		{	-- header: Tooltip
			type = "header",
			name = "Tooltip",
		},		
		{ -- checkbox: Disable
			type = "checkbox",
			name = "Enable tooltips?",
			getFunc = function() return (not FurC.GetDisableTooltips()) end,
			setFunc = function(value) FurC.SetDisableTooltips(not value) end
		},
		{ -- checkbox: Colorize tooltips for clarity?
			type 		= "checkbox",
			name 		= "Colorize tooltips for clarity?",
			tooltip 	= "Will colour 'can' and 'cannot'",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return FurC.GetColouredTooltips() end,
			setFunc 	= function(value) FurC.SetColouredTooltips(value) end
		},
		{ -- checkbox: Hide 'known by' from tooltip
			type 		= "checkbox",
			name 		= "Hide if item is known",
			tooltip 	= "Hides 'can be crafted by...' from tooltip",
			width		= "half",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return (FurC.GetHideKnowledge()) end,
			setFunc 	= function(value) FurC.SetHideKnowledge(value) end
		},
		{ -- checkbox: Hide 'known by' from tooltip
			type 		= "checkbox",
			name 		= "Hide if item is unknown",
			tooltip 	= "Hides 'you cannot craft this yet'",
			width		= "half",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return (FurC.GetHideUnknown()) end,
			setFunc 	= function(value) FurC.SetHideUnknown(value) end
		},
		{ -- checkbox: Hide item source
			type 		= "checkbox",
			name 		= "Hide item source?",
			tooltip 	= "",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return (FurC.GetHideSource()) end,
			setFunc 	= function(value) FurC.SetHideSource(value) end
		},
		{ -- checkbox: Hide item source
			type 		= "checkbox",
			name 		= "Hide crafting station?",
			tooltip 	= "",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return (FurC.GetHideCraftingStation()) end,
			setFunc 	= function(value) FurC.SetHideCraftingStation(value) end
		},		
		{ -- checkbox: Hide materials from tooltip
			type 		= "checkbox",
			name 		= "Hide material on tooltip?",
			tooltip 	= "",
			disabled 	= FurC.GetDisableTooltips(), 
			getFunc 	= function() return (FurC.GetHideMats()) end,
			setFunc 	= function(value) FurC.SetHideMats(value) end
		}, 
	} -- optionsData end

	LAM:RegisterOptionControls("FurnitureCatalogue_OptionsPanel", optionsData)
end
