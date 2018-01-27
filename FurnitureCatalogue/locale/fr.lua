local filterDisabled = "disables this filter"
local strings = {

	-- Furniture Shopping List
	SI_FURC_ONE_TO_SHOPPINGLIST = 				"Add 1 to shopping list",
	SI_FURC_FIVE_TO_SHOPPINGLIST = 				"Add 5 to shopping list",
	SI_FURC_TOGGLE_SHOPPINGLIST = 				" Toggle shopping list",
	
	-- GUI and debug
	SI_FURC_MENU_HEADER = 						"- |cD3B830Furniture|r:",
	SI_FURC_REMOVE_FAVE = 						" Remove Favorite",
	SI_FURC_ADD_FAVE = 							" Add Favorite",
	SI_FURC_POST_ITEMSOURCE = 					" Post item source",
	SI_FURC_POST_RECIPE = 						" Post recipe",
	SI_FURC_POST_MATERIAL = 					" Post material",
	SI_FURC_DIALOGUE_RESET_DB_HEADER = 			"Really re-create furniture database?",
	SI_FURC_DIALOGUE_RESET_DB_BODY = 			"This will re-create the FurnitureCatalogue database from scratch",
	SI_FURC_TEXTBOX_FILTER_DEFAULT = 			"Filter by text search",
	SI_FURC_DEBUG_CHARSCANCOMPLETE = 			"|c2266ffFurniture Catalogue|r|cffffff: Character scan complete...|r",
	SI_FURC_VERBOSE_STARTUP = 					"|c2266ffFurniture Catalogue|r|cffffff: |cffffffIf you miss any recipes, please trigger a scan on your furniture crafter by clicking the refresh button in the UI.|r",
	SI_FURC_VERBOSE_DB_UPTODATE = 				"|c2266ffFurniture Catalogue|r|cffffff: The database is up-to-date.|r",
	SI_FURC_VERBOSE_SCANNING_DATA_FILE =		"|c2266ffFurniture Catalogue|r|cffffff: Scanning data files...|r",
	SI_FURC_VERBOSE_SCANNING_CHARS =			"Not scanning files, scanning character knowledge now...",
	SI_FURC_ITEMSOURCE_EMPTY =					"Item source unknown.\nTry to re-scan files (refresh button right click).\nIf still unknown after, please send a mail with the item link and -source to @manavortex",
	SI_FURC_RUMOUR_SOURCE_RECIPE =				"This recipe has been datamined, but not seen in-game",
	SI_FURC_RUMOUR_SOURCE_ITEM =				"This item has been datamined, but not seen in-game",
	SI_FURC_STRING_CRAFTABLE_BY =				"Can be crafted by ",
	SI_FURC_STRING_CANNOT_CRAFT =				"You cannot craft this yet",
	SI_FURC_STRING_VENDOR = 					"sold by <<1>> in <<2>> (<<3>><<4>>)",
	SI_FURC_STRING_AP =							" AP",
	SI_FURC_STRING_ASSHOLE = 					"Zanil Theran",
	SI_FURC_STRING_HC = 						"Hollow City",
	SI_FURC_STRING_WASSOLDBY = 					"Was sold by <<1>> in <<2>> (<<3>>) <<4>>",
	SI_FURC_STRING_WEEKEND_AROUND = 			"(around <<1>>)",
	
	SI_FURC_STRING_ROLLIS = 					"Sold by |cd68957Rollis Hlaalu|r<<1>><<2>><<3>>",
	SI_FURC_STRING_FAUSTINA = 					"Sold by |cd68957Faustina Curio|r<<1>><<2>><<3>>",
	SI_FURC_STRING_FOR_VOUCHERS =				" for |ce5da40<<1>>|h vouchers",
	
	SI_FURC_FESTIVAL_DROP = 					"can be acquired during <<1>> (<<2>>)",
	SI_FURC_STRING_RECIPELEARNED = 				"Recipe learned: <<1>> <<2>> <<3>>",
	SI_FURC_STRING_RECIPESFORCHAR = 			"recipes for <<1>>",
	SI_FURC_STRING_VENDOR =						"Sold by <<1>> (<<2>><<3>>)",
	SI_FURC_STRING_VOUCHER_VENDOR =				"Sold by either Rollis Hlaalu or Faustina Curio",
	
	-- =============================== --
	-- ============ MENU ============= -- 
	-- =============================== --

	SI_FURC_STRING_MENU_DEBUG = 				"Enable debug output",
	SI_FURC_STRING_MENU_RESET_DB_NAME = 		"|cFF0000Reset database|r",
	SI_FURC_STRING_MENU_RESET_DB_TT = 			"This will reset the furniture database.",
	SI_FURC_STRING_MENU_RESET_DB_WARNING =		"All your data will be reset. Only recipe knowledge for this character will be considered.",
	SI_FURC_STRING_MENU_RESCAN_RUMOUR_NAME =  	"Re-scan Rumour recipes",
	SI_FURC_STRING_MENU_RESCAN_RUMOUR_TT = 		"Will update the rumour recipes against the updated list",
	SI_FURC_STRING_MENU_SCAN_FILES_NAME =		"Scan files",
	SI_FURC_STRING_MENU_SCAN_FILES_TT = 		"Will run a full scan of the data in Furniture Catalogue's files",
	SI_FURC_STRING_MENU_SCAN_CHAR_NAME = 		"Scan character",
	SI_FURC_STRING_MENU_SCAN_CHAR_TT = 			"Will run a full scan of your known furniture recipes and update the database accordingly",
	SI_FURC_STRING_MENU_DELETE_CHAR_NAME =	"delete character",
	SI_FURC_STRING_MENU_DELETE_CHAR_TT =		"Deletes all knowledge for this character from the database. \nCharacter will be scanned again the next time they log in with the add-on enabled. \n Character name won't show up in the dropdown if they don't know any recipes!",
	SI_FURC_STRING_MENU_DELETE_CHAR_WARNING =	"Character knowledge will be wiped immediately",
	SI_FURC_STRING_MENU_ENABLE_SHOPPINGLIST =	"Enable integration?",
	SI_FURC_STRING_MENU_SKIP_INITIALSCAN =		"Skip Initial Scan?",
	SI_FURC_STRING_MENU_SKIP_INITIALSCAN_TT =	"Check this to not scan your character's recipes on login. \nThanks to votan's awesome LibAsync the lag is gone now in any case..",
	SI_FURC_STRING_MENU_HEADER_ICONS =			"Inventory and bank icons",
	SI_FURC_STRING_MENU_ADD_ITEMS_NAME = 		"Add items to known/unknown recipes?",
	SI_FURC_STRING_MENU_ADD_ITEMS_TT = 			"You shouldn't notice any lag",
	SI_FURC_STRING_MENU_IT_UNKNOWN_NAME = 		"Only mark unknown recipes?",
	SI_FURC_STRING_MENU_IT_THIS_ONLY = 			"Only for this character?",
	SI_FURC_STRING_MENU_IT_THIS_ONLY_TT = 		"Will be accountwide otherwise.",
	SI_FURC_STRING_MENU_USETINY = 	 			"Use tiny interface?",
	SI_FURC_STRING_MENU_USETINY_TT = 	 		"Use a smaller interface (Craft Store like). \nYou can toggle this from the UI by clicking the +/- button.",		

	SI_FURC_STRING_MENU_STARTSILENT = 	 		"Start silently?",
	SI_FURC_STRING_MENU_STARTSILENT_TT = 	 	"Suppress startup message",
	SI_FURC_STRING_MENU_FONTSIZE = 	 			"Font size",
	SI_FURC_STRING_MENU_FONTSIZE_TT = 	 		"adjust font size for FurnitureCatalogue here",
	SI_FURC_STRING_MENU_DEFAULT_DD = 	 		"Default dropdown values",
	SI_FURC_STRING_MENU_DEFAULT_DD_USE = 	 	"Will be set on initial launch",
	SI_FURC_STRING_MENU_DEFAULT_DD_USE_TT = 	"These will not reset if you open and close the UI",
	SI_FURC_STRING_MENU_DEFAULT_DD_RESET = 		"Reset filters when closing UI?",
	SI_FURC_STRING_MENU_DEFAULT_DD_RESET_TT = 	"If you check this, opening and closing will cause the filters to reset to whatever you set below.",
	SI_FURC_STRING_MENU_DEFAULT_DD_SOURCE = 	"default source filter",
	SI_FURC_STRING_MENU_DEFAULT_DD_CHAR = 		"default character filter",
	SI_FURC_STRING_MENU_DEFAULT_DD_VERSION = 	"default version filter",
	SI_FURC_STRING_MENU_FILTERING = 			"Catalogue filtering",
	SI_FURC_STRING_MENU_FILTER_BOOKS = 			"Mages guild books",
	SI_FURC_STRING_MENU_FILTER_BOOKS_N = 		"Hide books?",
	SI_FURC_STRING_MENU_FILTER_BOOKS_TT = 		"A real book lover knows where everything is by heart. Hide books from Furniture Catalogue?",
	SI_FURC_STRING_MENU_LUXURY = 				"Luxury Furnishings",
	SI_FURC_STRING_MENU_LUXURY_N = 				"Treat luxury items as purchaseables?",
	SI_FURC_STRING_MENU_LUXURY_TT = 			"This will show everything that was sold by Zanil Theran under 'purchaseable' and deactvates the custom filter",
	SI_FURC_STRING_MENU_LUXURY_WARN = 			"Hiding the dropdown entry requires UI reload (won't happen automatically for your convenience)",
	SI_FURC_STRING_MENU_RUMOUR = 				"Rumour recipes",
	SI_FURC_STRING_MENU_RUMOUR_DESC = 		 	"The furniture database contains a list of recipes that I have datamined.\nHowever, not all of those have been seen in-game.\nEnable this option to exclude them from the default filters.\nYou can still view them with their own filter, which you can disable below.",

	SI_FURC_STRING_MENU_RUMOUR_N = 				"Hide rumour recipes?",
	SI_FURC_STRING_MENU_CROWN = 				"Crown store items",
	SI_FURC_STRING_MENU_CROWN_N = 				"Hide crown store items?",
	SI_FURC_STRING_MENU_CROWN_DESC = 			"The furniture database will update whenever the tooltip shows a furniture item. \nSome items can only be acquired via crown store. \nCheck this box to exclude them from the default filters (disable crown store filter below).",
						
	SI_FURC_STRING_MENU_HIDE_MENU = 				"Hide menu entries?",
	SI_FURC_STRING_MENU_HIDE_MENU_TT = 				"Hides \"Crown store\" and \"Rumour recipes\" from the dropdown \nactivated for crown store by default, as there aren't any items yet",
	SI_FURC_STRING_MENU_HIDE_MENU_RUMOUR = 			"Hide \"Rumour recipes\" drop down entry?",
	SI_FURC_STRING_MENU_HIDE_MENU_CROWN = 			"Hide \"Crown Store\" drop down entry?",
	SI_FURC_STRING_MENU_HIDE_MENU_TT =				"Requires UI reload (won't happen automatically for your convenience)",
	SI_FURC_STRING_MENU_TOOLTIP =					"Enable tooltips?",
	SI_FURC_STRING_MENU_TOOLTIP_COLOR =	 			"Colorize tooltips for clarity?",
	SI_FURC_STRING_MENU_TOOLTIP_COLOR_TT = 			"Will colour 'can' and 'cannot'",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN =  		"Hide if item is known",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN_TT = 	"Hides 'can be crafted by...' from tooltip",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN =  	"Hide if item is unknown",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN_TT =	"Hides 'you cannot craft this yet'",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_SOURCE =  		"Hide item source?",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_STATION =  	"Hide crafting station?",
	SI_FURC_STRING_MENU_TOOLTIP_HIDE_MATERIAL =  	"Hide material?",
	
	-- =============================== --
	-- ==== GUI: Dropdown entries ==== -- 
	-- =============================== --

	SI_FURC_NONE 									= "Source filter: off", 
	SI_FURC_FAVE 									= "Favorites", 
	SI_FURC_CRAFTING								= "Craftable: All", 
	SI_FURC_CRAFTING_KNOWN							= "Craftable: Known", 
	SI_FURC_CRAFTING_UNKNOWN						= "Craftable: Unknown", 
	SI_FURC_VENDOR									= "Purchaseable (gold)",
	SI_FURC_PVP										= "Purchaseable (AP)",
	SI_FURC_CROWN									= "Crown Store",
	SI_FURC_RUMOUR									= "Rumour items",
	SI_FURC_LUXURY									= "Luxury items",
	SI_FURC_OTHER									= "Other",
						
	SI_FURC_FILTER_VERSION_OFF						= "Version filter: off", 
	SI_FURC_FILTER_VERSION_HS						= "Homestead", 
	SI_FURC_FILTER_VERSION_M						= "Morrowind", 
	SI_FURC_FILTER_VERSION_R						= "Horns of the Reach", 
	SI_FURC_FILTER_VERSION_CC						= "Clockwork City", 
	SI_FURC_FILTER_VERSION_DRAGON					= "Dragon Bones", 
	
	-- =============================== --
	-- = GUI: Dropdown entry tooltip = -- 
	-- =============================== --
	
	SI_FURC_NONE_TT 								= "disables this filter", 
	SI_FURC_FAVE_TT 								= "Shows your favorites", 
	SI_FURC_CRAFTING_TT								= "Shows all craftable items", 
	SI_FURC_CRAFTING_KNOWN_TT						= "Shows only known craftable items", 
	SI_FURC_CRAFTING_UNKNOWN_TT						= "Shows only unknown craftable items", 
	SI_FURC_VENDOR_TT								= "Shows only items that cannot be crafted",
	SI_FURC_PVP_TT									= "Items that are sold for alliance points",
	SI_FURC_CROWN_TT								= "Shows items that can only be acquired from crown store",
	SI_FURC_RUMOUR_TT								= "Items and recipes that have been datamined, but haven't been confirmed existing",
	SI_FURC_LUXURY_TT								= "Items that at some point were sold by Zanil Theran, Cicero's General Goods, Coldharbour",
	SI_FURC_OTHER_TT								= "Shows items that can be farmed/stolen/found",
				
	SI_FURC_FILTER_VERSION_OFF_TT					= filterDisabled, 	
	SI_FURC_FILTER_VERSION_HS_TT					= "Items released in Homestead update", 
	SI_FURC_FILTER_VERSION_M_TT						= "YOU N\'WAH!", 
	SI_FURC_FILTER_VERSION_R_TT						= "Because all we needed were more Reachmen", 
	SI_FURC_FILTER_VERSION_CC_TT					= "Where the flywheels churn and the brass is pretty", 
	SI_FURC_FILTER_VERSION_DRAGON_TT				= "If you got this from Narsis Dren, well...", 
	
	
	SI_FURC_FILTER_CHAR_OFF							= "Character filter: off", 
	SI_FURC_FILTER_CHAR_OFF_TT						= filterDisabled, 
	
	-- =============================== --
	-- ========= GUI: Heading ======== -- 
	-- =============================== --
	
	SI_FURC_LABEL_ENTRIES							= " entries -", 
}


for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 2)
end