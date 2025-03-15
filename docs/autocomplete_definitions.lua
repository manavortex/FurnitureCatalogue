--[[
This file can be used in your IDE or language server to enable autocomplete and Intellisense functionality.

Do not load it in the AddOn manifest file. Instead add it as an external or additional library in your IDE.

This file contains FurnitureCatalogue specific components that the IDE is not smart enough to know by itself.

This includes:
- global localisation strings that are defined locally
- GUI controls, that are composed of XML and Strings

It should not include:
- undocumented or overwritten functions
  - try to use documentation instead
  - try to avoid overwriting existing functions
- ESO globals
  - use a mix of Baertrams generated ESOAPI files and your own custom files instead
  - see https://github.com/Baertram/IntelliJ_ESOUI_AutoCompletion
--]]
--

-- ////// START : GENERATED FROM xml/FurnitureCatalogue.xml
---------- LVL: 00 ----------
---------- LVL: 01 ----------
---------- LVL: 02 ----------
FurCGui = Control
FurC_QualityFilterButton = ButtonControl
FurC_CraftingTypeFilterButton = ButtonControl
FurC_SlotTemplate = Control
FurC_SlotTemplateTiny = Control
FurC_SlotIconKnownNo = TextureControl
FurC_SlotIconKnownYes = TextureControl
---------- LVL: 03 ----------
---------- LVL: 04 ----------
FurCGui_BG = BackdropControl
FurCGui_Header = Control
FurCGui_Wait = LabelControl
FurCGui_Empty = LabelControl
FurCGui_ListHolder = Control
FurC_SlotTemplateBg = TextureControl
FurC_SlotTemplateButton = ButtonControl
FurC_SlotTemplateName = LabelControl
FurC_SlotTemplateMats = LabelControl
FurC_SlotTemplateTinyBg = TextureControl
FurC_SlotTemplateTinyButton = ButtonControl
FurC_SlotTemplateTinyName = LabelControl
FurC_SlotTemplateTinyMats = LabelControl
---------- LVL: 05 ----------
---------- LVL: 06 ----------
FurCGui_Header_Bar1 = Control
FurCGui_Header_Bar2 = Control
FurCGui_Header_Bar3 = Control
FurCGui_Header_SortBar = Control
FurCGui_ListHolder_Slider = SliderControl
---------- LVL: 07 ----------
---------- LVL: 08 ----------
FurCGui_Header_Bar1_Feedback = ButtonControl
FurC_Label = Control
FurCGui_Header_Bar1_Hide = ButtonControl
FurCGui_Header_Bar1_Reload = ButtonControl
FurCGui_Header_Bar1_TemplateTiny = ButtonControl
FurCGui_Header_Bar1_TemplateLarge = ButtonControl
FurC_DropdownSource = Control
FurC_QualityFilter = Control
FurC_DropdownVersion = Control
FurC_DropdownCharacter = Control
FurC_TypeFilter = Control
FurC_Search = Control
FurC_ShowRumours = ButtonControl
FurC_ShowCrowns = ButtonControl
FurC_ShowRumoursGlow = TextureControl
FurCGui_Header_SortBar_Name = LabelControl
FurCGui_Header_SortBar_Quality = LabelControl
---------- LVL: 09 ----------
---------- LVL: 10 ----------
FurC_Label_1 = LabelControl
FurC_RecipeCount = LabelControl
FurC_Label_2 = LabelControl
FurC_SearchBox = EditControl
FurCGui_Header_SortBar_Name_Button = ButtonControl
FurCGui_Header_SortBar_Quality_Button = ButtonControl
---------- LVL: 11 ----------
---------- LVL: 12 ----------
FurC_SearchBoxBackdrop = BackdropControl
---------- LVL: 13 ----------
-- ////// END   : GENERATED FROM xml/FurnitureCatalogue.xml
-- ////// START : GENERATED FROM FurnitureCatalogue_DevUtility/xml.xml
---------- LVL: 00 ----------
---------- LVL: 01 ----------
---------- LVL: 02 ----------
FurCDevControl = Control
---------- LVL: 03 ----------
---------- LVL: 04 ----------
FurCDevControl_BG = BackdropControl
FurCDevControl_hide = ButtonControl
FurCDevControl_clear = ButtonControl
FurCDevControlBox = EditControl
---------- LVL: 05 ----------
-- ////// END   : GENERATED FROM FurnitureCatalogue_DevUtility/xml.xml

-- ////// START : GENERATED FROM locale/en.lua
SI_FURC_ADD_FAVE = " Add Favorite"
SI_FURC_DATAMINED_UNCLEAR = "This item has been seen in-game, but it's not yet known where you can get it."
SI_FURC_DB = "The Dark Brotherhood supplies vendor hands these out "
SI_FURC_DB_EQUIP = "with equipment"
SI_FURC_DB_POISON = "with poison"
SI_FURC_DB_STEALTH = "as a way to be less obtrusive"
SI_FURC_DEBUG_CHARSCANCOMPLETE = "Furniture Catalogue: Character scan complete..."
SI_FURC_DIALOGUE_RESET_DB_BODY = "This will re-create the FurnitureCatalogue database from scratch"
SI_FURC_DIALOGUE_RESET_DB_HEADER = "Really re-create furniture database?"
SI_FURC_DUNG = "dungeon"
SI_FURC_EVENT = "event"
SI_FURC_EVENT_ANNIVERSARY = "Anniversary Jubilee"
SI_FURC_EVENT_BLACKWOOD = "Bounties of Blackwood"
SI_FURC_EVENT_ELSWEYR = "Season of the Dragon"
SI_FURC_EVENT_HOLLOWJACK = "Sinister Hollowjack"
SI_FURC_EVENT_IC = "Imperial City Celebration"
SI_FURC_EVENT_JESTER = "Jester's Festival"
SI_FURC_EVENT_MAYHEM = "Whitestrake's Mayhem"
SI_FURC_EVENT_NEWLIFE = "New Life Festival"
SI_FURC_EVENT_UNDAUNTED = "Undaunted Celebration"
SI_FURC_EVENT_WITCHES = "Witches Festival"
SI_FURC_EVENT_ZENITHAR = "Zeal of Zenithar"
SI_FURC_FILTER_CHAR_OFF = "Character filter: off"
SI_FURC_FILTER_CHAR_OFF_TT = "disables this filter"
SI_FURC_FILTER_CROWN_HIDE_TT = "Showing crown store. Click to hide."
SI_FURC_FILTER_RUMOUR_HIDE_TT = "Showing rumour (unconfirmed) items. Click to hide."
SI_FURC_FILTER_SRC_CRAFTING = "Craftable: All"
SI_FURC_FILTER_SRC_CRAFTING_KNOWN = "Craftable: Known"
SI_FURC_FILTER_SRC_CRAFTING_KNOWN_TT = "Shows only known craftable items"
SI_FURC_FILTER_SRC_CRAFTING_TT = "Shows all craftable items"
SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN = "Craftable: Unknown"
SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN_TT = "Shows only unknown craftable items"
SI_FURC_FILTER_SRC_CROWN = "Crown Store"
SI_FURC_FILTER_SRC_CROWN_TT = "Shows items that can only be acquired from crown store"
SI_FURC_FILTER_SRC_FAVE = "Favorites"
SI_FURC_FILTER_SRC_FAVE_TT = "Shows your favorites"
SI_FURC_FILTER_SRC_LUX = "Luxury items"
SI_FURC_FILTER_SRC_LUX_TT = "Items that at some point were sold by Zanil Theran, Cicero's General Goods, Coldharbour"
SI_FURC_FILTER_SRC_NONE = "Source filter: off"
SI_FURC_FILTER_SRC_NONE_TT = "disables this filter"
SI_FURC_FILTER_SRC_OTHER = "Other"
SI_FURC_FILTER_SRC_OTHER_TT = "Shows items that can be farmed/stolen/found"
SI_FURC_FILTER_SRC_RUMOUR = "Rumour items"
SI_FURC_FILTER_SRC_RUMOUR_TT = "Items and recipes that have been datamined, but haven't been confirmed existing"
SI_FURC_FILTER_SRC_SOLD_AP = "Purchaseable (AP)"
SI_FURC_FILTER_SRC_SOLD_AP_TT = "Items that are sold for alliance points"
SI_FURC_FILTER_SRC_SOLD_GOLD = "Purchaseable (gold)"
SI_FURC_FILTER_SRC_SOLD_GOLD_TT = "Shows only items that cannot be crafted"
SI_FURC_FILTER_SRC_SOLD_WRIT = "Master Writ Vendor"
SI_FURC_FILTER_SRC_SOLD_WRIT_TT = "Obtainable for Master Writs in your alliance's capital"
SI_FURC_FILTER_VERSION_ALTMER = "Summerset"
SI_FURC_FILTER_VERSION_ALTMER_TT = "Still think the Dunmer are bad?"
SI_FURC_FILTER_VERSION_BASE43 = "Base Game Update 43"
SI_FURC_FILTER_VERSION_BASE43_TT = "Home tours are here"
SI_FURC_FILTER_VERSION_BASE44 = "Base Game Update 44"
SI_FURC_FILTER_VERSION_BASE44_TT = "2-sided BGs"
SI_FURC_FILTER_VERSION_BASED = "Base Game Patch"
SI_FURC_FILTER_VERSION_BASED_TT = "When you run out of names"
SI_FURC_FILTER_VERSION_BLACKW = "Blackwood"
SI_FURC_FILTER_VERSION_BLACKW_TT = "Mehrunes will never learn"
SI_FURC_FILTER_VERSION_BRETON = "High Isle"
SI_FURC_FILTER_VERSION_BRETON_TT = "Here be pirates"
SI_FURC_FILTER_VERSION_CC = "Clockwork City"
SI_FURC_FILTER_VERSION_CC_TT = "Where the flywheels churn and the brass is pretty"
SI_FURC_FILTER_VERSION_DEADL = "Deadlands"
SI_FURC_FILTER_VERSION_DEADL_TT = "What is this place with the sparkly meat?"
SI_FURC_FILTER_VERSION_DEPTHS = "Lost Depths"
SI_FURC_FILTER_VERSION_DEPTHS_TT = "What the heck is a Pangrit?"
SI_FURC_FILTER_VERSION_DRAGON = "Dragon Bones"
SI_FURC_FILTER_VERSION_DRAGON2 = "Dragonhold"
SI_FURC_FILTER_VERSION_DRAGON2_TT = "Now with more dragons"
SI_FURC_FILTER_VERSION_DRAGON_TT = "If you got this from Narsis Dren, well..."
SI_FURC_FILTER_VERSION_DRUID = "Firesong"
SI_FURC_FILTER_VERSION_DRUID_TT = "Remember when we could block?"
SI_FURC_FILTER_VERSION_ENDLESS = "Secrets of the Telvanni"
SI_FURC_FILTER_VERSION_ENDLESS_TT = "Now with infinite tentacles"
SI_FURC_FILTER_VERSION_FALLBAN = "Fallen Banners"
SI_FURC_FILTER_VERSION_FALLBAN_TT = "Fallen Banners + Visual update"
SI_FURC_FILTER_VERSION_FLAMES = "Flames of Ambition"
SI_FURC_FILTER_VERSION_FLAMES_TT = "Mildly flammable"
SI_FURC_FILTER_VERSION_HARROW = "Harrowstorm"
SI_FURC_FILTER_VERSION_HARROW_TT = "Climate change is real"
SI_FURC_FILTER_VERSION_HS = "Homestead"
SI_FURC_FILTER_VERSION_HS_TT = "Items released in Homestead update"
SI_FURC_FILTER_VERSION_KITTY = "Elsweyr"
SI_FURC_FILTER_VERSION_KITTY_TT = "Khajiit has furniture, if you have coin!"
SI_FURC_FILTER_VERSION_M = "Morrowind"
SI_FURC_FILTER_VERSION_MARKAT = "Markarth"
SI_FURC_FILTER_VERSION_MARKAT_TT = "With Dwemer Plumbing"
SI_FURC_FILTER_VERSION_M_TT = "YOU N'WAH!"
SI_FURC_FILTER_VERSION_NECROM = "Necrom"
SI_FURC_FILTER_VERSION_NECROM_TT = "So many tentacles"
SI_FURC_FILTER_VERSION_OFF = "Version filter: off"
SI_FURC_FILTER_VERSION_OFF_TT = "disables this filter"
SI_FURC_FILTER_VERSION_R = "Horns of the Reach"
SI_FURC_FILTER_VERSION_R_TT = "Because all we needed were more Reachmen"
SI_FURC_FILTER_VERSION_SCALES = "Scalebreaker"
SI_FURC_FILTER_VERSION_SCALES_TT = "Fus Ro Dah?"
SI_FURC_FILTER_VERSION_SCIONS = "Scions of Ithelia"
SI_FURC_FILTER_VERSION_SCIONS_TT = "Yeah Mr White, Scions!"
SI_FURC_FILTER_VERSION_SCRIBE = "Scribes of Fate"
SI_FURC_FILTER_VERSION_SCRIBE_TT = "Books and things"
SI_FURC_FILTER_VERSION_SKYRIM = "Greymoor"
SI_FURC_FILTER_VERSION_SKYRIM_TT = "They're selling Skyrim *again*!"
SI_FURC_FILTER_VERSION_SLAVES = "Murkmire"
SI_FURC_FILTER_VERSION_SLAVES_TT = "What do Argonian kids learn at school? Hist-Tree."
SI_FURC_FILTER_VERSION_STONET = "Stonethorn"
SI_FURC_FILTER_VERSION_STONET_TT = "It's not really stone"
SI_FURC_FILTER_VERSION_TIDES = "Ascending Tide"
SI_FURC_FILTER_VERSION_TIDES_TT = "Redguard. Structural. Furnishings. (Kinda?)"
SI_FURC_FILTER_VERSION_WEALD = "Gold Road"
SI_FURC_FILTER_VERSION_WEALD_TT = "We forgot about...who?"
SI_FURC_FILTER_VERSION_WEREWOLF = "Wolfhunter"
SI_FURC_FILTER_VERSION_WEREWOLF_TT = "In Soviet Hunting Ground, werewolf hunt you"
SI_FURC_FILTER_VERSION_WOTL = "Wrathstone"
SI_FURC_FILTER_VERSION_WOTL_TT = "Wrathstone!"
SI_FURC_GRAMMAR_CONJ_OR = "or"
SI_FURC_GRAMMAR_PREP_LOC_DEFAULT = "in"
SI_FURC_GRAMMAR_PREP_SRC_DEFAULT = "from"
SI_FURC_GUILD_FIGHTERS = "the Fighters' guild"
SI_FURC_GUILD_FIGHTERS_STEWARD = "Hall Steward"
SI_FURC_GUILD_MAGES = "the Mages' guild"
SI_FURC_GUILD_MAGES_MYSTIC = "Mystic^n"
SI_FURC_GUILD_MAGES_MYSTIC_COLL = "the Mystic as part of a collection"
SI_FURC_GUILD_PSIJIC_NALIRSEWEN = "Nalirsewen"
SI_FURC_GUILD_THIEVES_MERCH = "Outlaw Refuge, Merchant"
SI_FURC_GUILD_UNDAUNTED_QM = "Quartermaster"
SI_FURC_HOUSE = "From a furnished purchase of <<1>>"
SI_FURC_ITEMPACK_ALCHEMIST = "Mad Alchemist"
SI_FURC_ITEMPACK_AMBITIONS = "Daedric Ambitions"
SI_FURC_ITEMPACK_AQUATIC = "Aquatic Splendor"
SI_FURC_ITEMPACK_ASTULA = "Shad Astula Scolars Bundle"
SI_FURC_ITEMPACK_AYLEID = "Ayleid"
SI_FURC_ITEMPACK_AZURA = "Daedric Set of Azura"
SI_FURC_ITEMPACK_COLDHARBOUR = "Coldharbour Arcanaeum"
SI_FURC_ITEMPACK_COVEN = "Witches' Coven"
SI_FURC_ITEMPACK_CRAGKNICKS = "Craglorn Multicultural Knick-Knacks"
SI_FURC_ITEMPACK_CURIOSITIES = "Apocryphal Curiosities"
SI_FURC_ITEMPACK_DEEPMIRE = "Deepmire Expedition"
SI_FURC_ITEMPACK_DIBELLA = "Dibella's Garden"
SI_FURC_ITEMPACK_DWEMER = "Dwemer"
SI_FURC_ITEMPACK_FARGRAVE = "Fargrave Bazaar"
SI_FURC_ITEMPACK_FORGE = "Forge-Lord's Great Works"
SI_FURC_ITEMPACK_HEART = "Heart's Day Retreat"
SI_FURC_ITEMPACK_HUBTREASURE = "Hubalajad's Final Treasure"
SI_FURC_ITEMPACK_KHAJIIT = "Khajiiti Life"
SI_FURC_ITEMPACK_MALACATH = "Malacath's Chosen"
SI_FURC_ITEMPACK_MAORMER = "Maormer Boarding Party"
SI_FURC_ITEMPACK_MEPHALA = "Trappings of Mephala Worship"
SI_FURC_ITEMPACK_MERMAID = "Steam Bath Serenity"
SI_FURC_ITEMPACK_MOLAG = "Molag Bal"
SI_FURC_ITEMPACK_MOONBISHOP = "Moon Bishop's Sanctuary"
SI_FURC_ITEMPACK_NEWLIFE2018 = "New Life Festival"
SI_FURC_ITEMPACK_OASIS = "Moons-Blessed Oasis"
SI_FURC_ITEMPACK_SOTHA = "The Clockwork God's Domain"
SI_FURC_ITEMPACK_SWAMP = "Shadow and Stone"
SI_FURC_ITEMPACK_TYRANTS = "Tyrants of the Merethic Era"
SI_FURC_ITEMPACK_VAMPIRE = "Vampiric Libations"
SI_FURC_ITEMPACK_VIVEC = "Lord Vivec"
SI_FURC_ITEMPACK_WINDOWS = "Windows of the Divines"
SI_FURC_ITEMPACK_ZENI = "Chapel of Zenithar"
SI_FURC_LABEL_ENTRIES = " entries -"
SI_FURC_LOC_ANY = "anywhere^X"
SI_FURC_LOC_ANY_CAPITAL = "any capital city"
SI_FURC_LOC_ANY_CITY = "any city"
SI_FURC_LOC_LILANDRIL = "Lilandril"
SI_FURC_LOC_MURKMIRE_LIL = "Lilmoth"
SI_FURC_LOC_PLACE_ORSINIUM = "Orsinium"
SI_FURC_LOC_REACH_MARKARTH_MM = "Markarth Mercantile"
SI_FURC_LOC_REAPER_RAWL_MARKET = "Reaper's March, Rawl'Kha, Market"
SI_FURC_LOC_RIFTEN_ARMOR = "Riften, Market, Armorer"
SI_FURC_LOC_RIVENSPIRE_SHORN_DWI = "Rivenspire, Shornhelm, Dead Wolf Inn"
SI_FURC_LOC_SELSWEYR_DHA = "Dragonhold Armoury"
SI_FURC_LOC_SELSWEYR_SENCHAL_MARKET = "Senchal, Marketplace"
SI_FURC_LOC_SHADOWFEN_CORIMONT = "Alten Corimont"
SI_FURC_LOC_STONEFALLS_EBONHEART = "Ebonheart"
SI_FURC_LOC_STORMHAVEN_WAY_MERCH = "Stormhaven, Wayrest, Merchant district"
SI_FURC_LOC_SUMMERSET_ALINOR = "Alinor"
SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE = "Riverside Market"
SI_FURC_LOC_UNDAUNTED = "Undaunted Enclaves^p,in"
SI_FURC_LOC_VVARDENFELL_ALDRUHN = "Ald'ruhn"
SI_FURC_LOC_VVARDENFELL_SURAN = "Suran"
SI_FURC_LOC_VVARDENFELL_VIVEC = "Vivec City"
SI_FURC_LOC_VVARDENFELL_VIVEC_GQ = "Gladiator's Quarters"
SI_FURC_LOC_VVARDENFELL_VIVEC_SDI = "Saint Delyn Inn"
SI_FURC_LOC_WSKYRIM_SOLI_DH = "Solitude, Dragon's Hearth"
SI_FURC_LOOT_HARVEST = "from harvesting nodes"
SI_FURC_LOOT_HARVEST_WOOD = "occasionally found in wood nodes"
SI_FURC_MENU_HEADER = "- |cD3B830Furniture|r:"
SI_FURC_NPC_AUTOMATON = "automaton^n"
SI_FURC_PART_OF = "Part of item <<1>>"
SI_FURC_PLUGIN_SL_ADD_FIVE = "Add 5 to shopping list"
SI_FURC_PLUGIN_SL_ADD_ONE = "Add 1 to shopping list"
SI_FURC_POST_ITEM = " Post item"
SI_FURC_POST_ITEMSOURCE = " Post item source"
SI_FURC_POST_MATERIAL = " Post material"
SI_FURC_POST_RECIPE = " Post recipe"
SI_FURC_RANK = "rank <<1>>"
SI_FURC_RARITY_EXTREMELYRARE = "extremely rare"
SI_FURC_RARITY_RARE = "rare"
SI_FURC_RARITY_VERYRARE = "very rare"
SI_FURC_REMOVE_FAVE = " Remove Favorite"
SI_FURC_REQUIRES_ACHIEVEMENT = "requires <<1>>"
SI_FURC_REWARD_RANKED_MAIL = "ranked, in mailbox"
SI_FURC_RUINS = "ruins^p"
SI_FURC_SEEN_IN_GUILDSTORE = "Seen in Guild Store"
SI_FURC_SHOW_CROWN_TT = "Hiding crown store. Click to show."
SI_FURC_SHOW_RUMOUR_TT = "Confirmed items only. Click to show rumour items."
SI_FURC_SRC_CHESTS = "treasure chests^P,from"
SI_FURC_SRC_CLAM_GIANT = "giant clams^p,from"
SI_FURC_SRC_CRAFTING = "crafting^N,by"
SI_FURC_SRC_CROWNSTORE = "Crown Store^n,from"
SI_FURC_SRC_DOLMEN = "Dolmen^P,from"
SI_FURC_SRC_DROP = "drop^n,from"
SI_FURC_SRC_DUNG = "dungeon^n,from"
SI_FURC_SRC_EMPTY =
  "Item source unknown.\nTry to re-scan files (refresh button right click).\nIf the item is still unknown - and not part of the weekend furnisher's current inventory - please send a mail with the item link and -source to @berylbones."
SI_FURC_SRC_FISH = "fishing^N,by"
SI_FURC_SRC_GEYSER = "geysers^p,from"
SI_FURC_SRC_HARVEST = "harvesting^N,from"
SI_FURC_SRC_ITEMPACK = "Part of the Crown Store item pack [<<1>>] "
SI_FURC_SRC_LVLUP = "levelup reward^n,from"
SI_FURC_SRC_MISCHOUSE = "From select house purchases"
SI_FURC_SRC_PICK = "pickpocketing^N,from"
SI_FURC_SRC_QUEST = "quest^n,from"
SI_FURC_SRC_QUEST_DAILY = "daily quests^p,from"
SI_FURC_SRC_RNDMOB = "random mobs^p,from"
SI_FURC_SRC_RUMOUR_ITEM = "This item has been datamined, but not seen in-game"
SI_FURC_SRC_RUMOUR_RECIPE = "This recipe has been datamined, but not seen in-game"
SI_FURC_SRC_SAFEBOX = "safeboxes^P,from"
SI_FURC_SRC_SCAMBOX = "Crown Crate^n,from"
SI_FURC_SRC_SCRYING = "scrying^N,from"
SI_FURC_SRC_STEAL = "stealing^N,from"
SI_FURC_SRC_TOT = "Tales of Tribute^P,from"
SI_FURC_STRING_CANNOT_CRAFT = "You cannot craft this yet"
SI_FURC_STRING_CONTEXTMENU_DIVIDER = "Don't use divider in context menu?"
SI_FURC_STRING_CONTEXTMENU_DIVIDER_TT =
  "Adds a divider to the context menu above the - Furniture entry. Check to disable"
SI_FURC_STRING_CONTEXTMENU_INVENTORY = "Disable context menu in inventory?"
SI_FURC_STRING_CONTEXTMENU_INVENTORY_TT =
  "Disables the context for inventory items like posting material and adding to favourites."
SI_FURC_STRING_CRAFTABLE_BY = "Can be crafted by "
SI_FURC_STRING_DUNG = "dungeon"
SI_FURC_STRING_MENU_ADD_ITEMS_NAME = "Add items to known/unknown recipes?"
SI_FURC_STRING_MENU_ADD_ITEMS_TT = "You shouldn't notice any lag"
SI_FURC_STRING_MENU_CROWN = "Crown store items"
SI_FURC_STRING_MENU_CROWN_DESC =
  "The furniture database will update whenever the tooltip shows a furniture item. \nSome items can only be acquired via crown store. \nCheck this box to exclude them from the default filters (you can still see them by selecting 'Crown Store' from source dropdown)."
SI_FURC_STRING_MENU_CROWN_N = "Hide crown store items?"
SI_FURC_STRING_MENU_DEBUG = "Enable debug output"
SI_FURC_STRING_MENU_DEBUG_TT = "Only has an effect if a debug logger is enabled"
SI_FURC_STRING_MENU_DEFAULT_DD = "Default dropdown values"
SI_FURC_STRING_MENU_DEFAULT_DD_CHAR = "default character filter"
SI_FURC_STRING_MENU_DEFAULT_DD_RESET = "Reset filters when closing UI?"
SI_FURC_STRING_MENU_DEFAULT_DD_RESET_TT =
  "If you check this, opening and closing will cause the filters to reset to whatever you set below."
SI_FURC_STRING_MENU_DEFAULT_DD_SOURCE = "default source filter"
SI_FURC_STRING_MENU_DEFAULT_DD_USE = "Will be set on initial launch"
SI_FURC_STRING_MENU_DEFAULT_DD_USE_TT = "These will not reset if you open and close the UI"
SI_FURC_STRING_MENU_DEFAULT_DD_VERSION = "default version filter"
SI_FURC_STRING_MENU_DELETE_CHAR_NAME = "delete character"
SI_FURC_STRING_MENU_DELETE_CHAR_TT =
  "Deletes all knowledge for this character from the database. \nCharacter will be scanned again the next time they log in with the add-on enabled. \n Character name won't show up in the dropdown if they don't know any recipes!"
SI_FURC_STRING_MENU_DELETE_CHAR_WARNING = "Character knowledge will be wiped immediately"
SI_FURC_STRING_MENU_ENABLE_SHOPPINGLIST = "Enable integration?"
SI_FURC_STRING_MENU_FALL_HIDE_BOOKS = "Hide books anyway"
SI_FURC_STRING_MENU_FALL_HIDE_BOOKS_TT = "Even when filtering all items, still hide books?"
SI_FURC_STRING_MENU_FALL_HIDE_CROWN = "Hide crown store items anyway"
SI_FURC_STRING_MENU_FALL_HIDE_CROWN_TT = "Even when filtering all items, still hide crown store items?"
SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR = "Hide rumour items anyway"
SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR_TT = "Even when filtering all items, still hide rumour items?"
SI_FURC_STRING_MENU_FALL_HIDE_UI_BUTTON = "Hide UI button in search box?"
SI_FURC_STRING_MENU_FILTERING = "Catalogue filtering"
SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT = "Search filtered items when doing a text search with no dropdown filters set?"
SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT_TT = "When doing a text search without any dropdown "
SI_FURC_STRING_MENU_FILTER_BOOKS = "Mages guild books"
SI_FURC_STRING_MENU_FILTER_BOOKS_N = "Hide books?"
SI_FURC_STRING_MENU_FILTER_BOOKS_TT =
  "A real book lover knows where everything is by heart. Hide books from Furniture Catalogue?"
SI_FURC_STRING_MENU_FONTSIZE = "Font size"
SI_FURC_STRING_MENU_FONTSIZE_TT = "adjust font size for FurnitureCatalogue here"
SI_FURC_STRING_MENU_F_ALL_ON_TEXT = "Configure this filter"
SI_FURC_STRING_MENU_HEADER_F_ALL_DESC =
  "Configure filter settings for text search with disabled dropdowns. \nThese settings will only take effect when you have not set a source, character or version filter."
SI_FURC_STRING_MENU_HEADER_F_ALL_ON_TEXT = "Filter settings for text search"
SI_FURC_STRING_MENU_HEADER_ICONS = "Inventory and bank icons"
SI_FURC_STRING_MENU_HIDE_MENU = "Hide menu entries?"
SI_FURC_STRING_MENU_HIDE_MENU_CROWN = 'Hide "Crown Store" drop down entry?'
SI_FURC_STRING_MENU_HIDE_MENU_RUMOUR = 'Hide "Rumour recipes" drop down entry?'
SI_FURC_STRING_MENU_HIDE_MENU_TT =
  'Hides "Crown store" and "Rumour recipes" from the dropdown \nactivated for crown store by default, as there aren\'t any items yet\nRequires UI reload (won\'t happen automatically for your convenience)'
SI_FURC_STRING_MENU_IT_THIS_ONLY = "Only for this character?"
SI_FURC_STRING_MENU_IT_THIS_ONLY_TT = "Will be accountwide otherwise."
SI_FURC_STRING_MENU_IT_UNKNOWN_NAME = "Only mark unknown recipes?"
SI_FURC_STRING_MENU_LUXURY = "Luxury Furnishings"
SI_FURC_STRING_MENU_LUXURY_N = "Treat luxury items as purchaseables?"
SI_FURC_STRING_MENU_LUXURY_TT =
  "This will show everything that was sold by Zanil Theran under 'purchaseable' and deactvates the custom filter"
SI_FURC_STRING_MENU_LUXURY_WARN =
  "Hiding the dropdown entry requires UI reload (won't happen automatically for your convenience)"
SI_FURC_STRING_MENU_RESCAN_RUMOUR_NAME = "Re-scan Rumour recipes"
SI_FURC_STRING_MENU_RESCAN_RUMOUR_TT = "Will update the rumour recipes against the updated list"
SI_FURC_STRING_MENU_RESET_DB_NAME = "|cFF0000Reset database"
SI_FURC_STRING_MENU_RESET_DB_TT = "This will reset the furniture database."
SI_FURC_STRING_MENU_RESET_DB_WARNING =
  "All your data will be reset. Only recipe knowledge for this character will be considered."
SI_FURC_STRING_MENU_RUMOUR = "Rumour recipes"
SI_FURC_STRING_MENU_RUMOUR_DESC =
  "The furniture database contains a list of recipes that I have datamined.\nHowever, not all of those have been seen in-game.\nEnable this option to exclude them from the default filters.\nYou can still view them with their own filter, which you can disable below."
SI_FURC_STRING_MENU_RUMOUR_N = "Hide rumour recipes?"
SI_FURC_STRING_MENU_SCAN_CHAR_NAME = "Scan character"
SI_FURC_STRING_MENU_SCAN_CHAR_TT =
  "Will run a full scan of your known furniture recipes and update the database accordingly"
SI_FURC_STRING_MENU_SCAN_FILES_NAME = "Scan files"
SI_FURC_STRING_MENU_SCAN_FILES_TT = "Will run a full scan of the data in Furniture Catalogue's files"
SI_FURC_STRING_MENU_SHOWICONONLEFT = "Show Known/Unknown icon on left?"
SI_FURC_STRING_MENU_SHOWICONONLEFT_TT =
  "Show Green Check/Red X icon on left or right of the inventory item (requires reloadui)"
SI_FURC_STRING_MENU_SKIP_INITIALSCAN = "Skip Initial Scan?"
SI_FURC_STRING_MENU_SKIP_INITIALSCAN_TT =
  "Check this to not scan your character's recipes on login. \nThanks to votan's awesome LibAsync the lag is gone now in any case.."
SI_FURC_STRING_MENU_STARTSILENT = "Start silently?"
SI_FURC_STRING_MENU_STARTSILENT_TT = "Suppress startup message"
SI_FURC_STRING_MENU_TOOLTIP = "Enable tooltips?"
SI_FURC_STRING_MENU_TOOLTIP_COLOR = "Colorize tooltips for clarity?"
SI_FURC_STRING_MENU_TOOLTIP_COLOR_TT = "Will colour 'can' and 'cannot'"
SI_FURC_STRING_MENU_TOOLTIP_DATEFORMAT = "Preferred date format"
SI_FURC_STRING_MENU_TOOLTIP_DATEFORMAT_TT = "Affects luxury furnishing info"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN = "Hide item knowledge from tooltip"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN_TT = "Hides 'can be crafted by...' from tooltip"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_MATERIAL = "Hide material?"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_SOURCE = "Hide item source?"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_STATION = "Hide crafting station?"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN = "Hide if item is unknown"
SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN_TT = "Hides 'you cannot craft this yet'"
SI_FURC_STRING_MENU_USETINY = "Use tiny interface?"
SI_FURC_STRING_MENU_USETINY_TT =
  "Use a smaller interface (Craft Store like). \nYou can toggle this from the UI by clicking the +/- button."
SI_FURC_STRING_PART_OF_COLL = "part of a collection"
SI_FURC_STRING_PIECES = "<<1>> pieces"
SI_FURC_STRING_RECIPELEARNED = "Recipe learned: <<1>> <<2>> <<3>>"
SI_FURC_STRING_RECIPESFORCHAR = "recipes for <<1>>"
SI_FURC_STRING_REWARD = "reward^n,from"
SI_FURC_STRING_REWARD_FOR = "reward for <<1>>"
SI_FURC_STRING_TRADER = "Trader"
SI_FURC_STRING_WEEKEND_AROUND = "around <<1>>"
SI_FURC_TELVANNI_NECROM_FRF = "Necrom, Final Rest Furnishings"
SI_FURC_TEXTBOX_FILTER_DEFAULT = "Filter by text search"
SI_FURC_TOGGLE_SHOPPINGLIST = " Toggle shopping list"
SI_FURC_TOMBS = "tombs^p"
SI_FURC_TRADERS_AF = "Achievement Furnisher^n,from"
SI_FURC_TRADERS_ALCHEMISTS = "alchemists"
SI_FURC_TRADERS_BGF = "Battlegrounds Furnishers^p,from"
SI_FURC_TRADERS_BLACKSMITHS = "blacksmiths"
SI_FURC_TRADERS_CAF = "Capital Achievement Furnisher^n,from"
SI_FURC_TRADERS_CARPENTERS = "carpenters"
SI_FURC_TRADERS_CLOTHIERS = "clothiers"
SI_FURC_TRADERS_COOKS = "cooks"
SI_FURC_TRADERS_DROPSNOGLASS_COLL = "Drops-No-Glass, Temple Doctrine Collection"
SI_FURC_TRADERS_ENCHANTERS = "enchanters"
SI_FURC_TRADERS_EVENT = "Impressario^Nd,from"
SI_FURC_TRADERS_FAUSTINA = "Faustina Curio"
SI_FURC_TRADERS_HGF = "Home Goods Furnisher^n,from"
SI_FURC_TRADERS_HOLIDAY = "Holiday Furnisher^n,from"
SI_FURC_TRADERS_LUXF = "Luxury Furnisher^Nd,from"
SI_FURC_TRADERS_RAZOUFA_COLL = "Razoufa as part of a collection"
SI_FURC_TRADERS_ROLIS = "Rolis Hlaalu"
SI_FURC_VERBOSE_DB_UPTODATE = "Furniture Catalogue: The database is up-to-date."
SI_FURC_VERBOSE_SCANNING_CHARS = "Not scanning files, scanning character knowledge now..."
SI_FURC_VERBOSE_SCANNING_DATA_FILE = "Furniture Catalogue: Scanning data files..."
SI_FURC_VERBOSE_STARTUP =
  "Furniture Catalogue: If you miss any recipes, please trigger a scan on your furniture crafter by clicking the refresh button in the UI."
-- ////// END   : GENERATED FROM locale/en.lua

-- ////// START   : Manual entries and overrides

-- ESOAPI

---Get localised quest name by id
---@param questId integer
---@return string name or empty string
function GetQuestName(questId)
  return ""
end

--- @param currencyType number
--- @param isSingular bool|nil
--- @param isLower bool|nil
--- @return string name
function GetCurrencyName(currencyType, isSingular, isLower)
  return ""
end

--- @param unitTag string
--- @return string name
function GetUnitName(unitTag)
  return ""
end

---@class LinkStyle : number
LinkStyle = nil

--- @param achievementId integer
--- @param linkStyle LinkStyle
--- @return string link
function GetAchievementLink(achievementId, linkStyle)
  return ""
end

--[[ NUMBER FORMATTING

Formatting and Localizing Numbers:
The ZO_LocalizeDecimalNumber function in libraries/globals/localization.lua provides this function to format numbers nicely for humans.

  Usage is simple: call this function on your number, and then pass the result through the `zo_strformat` function to localize it. If you do not, you will use English localization even in foreign languages.

```lua
zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(1000000))
-- in English: 1,000,000
-- in German: 1.000.000
```

This also correctly handles decimals:
```lua
zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(1000.987))
-- in English: 1,000.987
-- in German: 1.000,987
```

You should always use this method to format numbers that people will read.

Additional number formatting functions, which abbreviate the value (e.g. 10000 => 10k) are:
- `ZO_AbbreviateNumber(amount, precision, useUppercaseSuffixes)`
- `ZO_AbbreviateAndLocalizeNumber(amount, precision, useUppercaseSuffixes)`

]]

--- Formats a string using the provided arguments.
---
--- The syntax `<<n>>` is used as placeholder for the replacement value, where the number `n` is the position of the argument, with a maximum of 7 positional arguments.
---
--- <h2>Sentence Pluralisation</h2>
---
--- - handled with special syntax like `<<1[no examples/one example/$d examples]>>`
--- - multi layer example:
---   - `<<1[no <<m:2>>/one <<2>>/$d <<m:2>>]>>`
---   - `fun(expr, 0, "Dungeon^n")` => `no Dungeons`
---   - `fun(expr, 1, "Dungeon^n")` => `one Dungeon`
---   - `fun(expr, 9, "Dungeon^n")` => `9 Dungeons`
---
---<h2>Control Characters</h2>
---
--- Control characters added to the end of a string can determine the transormations performed with format modifiers.
---
--- - unique words, people or places (big letters)
---   - `^F` : feminine name (`Ayrenn^F`)
---   - `^M` : masculine name (`Jorunn^M`)
---   - `^N` : neuter name (`Nchuleft^N`)
---   - `^P` : plural name (`Faroe^P`) - "the Faroe (islands)"
--- - common nouns (small letters)
---   - `^f` : feminine gender (`Wand^f` => `die Wand`) - "the wall"
---   - `^m` : masculine gender (`Boden^m` => `der Boden`) -"the floor"
---   - `^n` : neuter gender (`Dach^n` => `das Dach`) - "the roof"
---   - `^p` : plural
--- - other modifiers
---   - `^c` : capitalise the word before the noun (`endloses Archiv^nc` => `Endloses Archiv`)
---   - `^d` : forces definitive article for unique names???
---     - `Archiv^nd` => `das Archiv`
---     - `Archiv^n` => `Archiv`
---   - `^f:m`: supply separate modifiers for colon separated words (formatting converts colon expressions into a sentence structure)
---     - `Blaupause: Tisch^fd:m` => `die Blaupause für einen Tisch` - "the blueprint for a table"
---
--- Formatting adds articles, when handling lowercase gender in English! Use uppercase genders like `name^P` in the translations for any languages, that need to avoid those articles:
--- - `<<l:1>> guards^p,from` => `from the guards`
--- - `<<l:1>> guards^P,from` => `from guards`
---
---<h1>Format Modifiers</h1>
---
--- Can be used in two forms: `<<Z:1>>` or `<<1{Z}>>`
---
--- <h2>Articles</h2>
---
--- - `a` : indefinite article ("a/an")
---   - `<<a:1>> Dungeon^n,in` => `ein Dungeon`
---   - `m` adds "some" quantifier
---   - `l` adds "at/in/on" propositions for locations
--- - `A`: definite article
---   - `"<<IA:1>>", "Dungeon^n,in"` => `im Dungeon` ("in the dungeon")
---
--- <h2>Locations</h2>
---
--- - `l` : location propositions ("in the/on the/..")
---   - `<<l:1>> Dungeon^n,in` => `im Dungeon` ("in the dungeon")
--- - `L` : location propositions ("to the/..")
---   - `<<L:1>> Dungeon^n,in` => `in das Dungeon` ("into the dungeon")
---
--- <h2>Pronouns</h2>
---
--- - `d` : demonstrative pronoun ("this/these/...")
---   - `<<d:1>> Dungeon^n,in` => `dieses Dungeon`
--- - `D` : just the pronoun ("this/these/...")
---   - `<<D:1>> Dungeon^n,in` => `dieses` ("this")
--- - `g` : append possessive form ("'s"/"'") or "of a"
---   - `<<g:1>> Dungeon^n,in` => `eines Dungeons` ("of a dungeon")
--- - `G` : append possessive form ("'s"/"") or "of the"
---   - `<<G:1>> Dungeon^n,in` => `des Dungeons` ("of the dungeon")
--- - `p` : personal pronoun ("he/she/it")
---   - `<<p:1>> Wand^f,auf` => `sie`
---   - `<<p:1>> Boden^m,auf` => `er`
---   - `<<p:1>> Dungeon^n,in` => `es`
--- - `P` : personal pronoun ("him/her/it")
---   - `<<P:1>> Wand^f,auf` => `ihr` ("her")
---   - `<<P:1>> Boden^m,auf` => `ihm` ("him")
---   - `<<P:1>> Dungeon^n,in` => `ihm` ("it")
--- - `r` : reflexive ("himself","herself","itself")
---   - `<<r:1>> Dungeon^n` => `sich` ("itself")
--- - `o` : possessive pronoun subject ("his","her","its") - NOT IMPLEMENTED?
--- - `O` : possessive pronoun object ("his","hers","its") - NOT IMPLEMENTED?
---
--- <h2>Formatting</h2>
---
--- - `c` : `ABC DE F` => `aBC DE F` (lowercase first letter)
--- - `C` : `abc de f` => `Abc de f` (uppercase first letter)
--- - `t` : `abc de f` => `Abc De f` (uppercase 1st each word)
--- - `T` : `abc de f` => `Abc De F` (uppearcase 1st each string)
--- - `n` : `3` => `three` (number to text)
--- - `N` : `3` => `Three` (number to text, capitalised)
--- - `i`/`I` : `1` => `1st` (number to ordinal)
--- - `R` : `12` => `XII` (number to roman)
--- - `X` : `Dungeon^n,in` => `Dungeon^n,in` (no formatting)
--- - `z` : `AÖÄẞ` => `aöäß` (to lowercase)
--- - `Z` : `aöäß` => `AÖÄẞ` (to uppercase)
---
--- <h2>Multiples</h2>
---
--- - `m` : pluralises a word
---   - `<<m:1>> Dungeon^n,in` => `Dungeons`
---
--- <h2>Combinations</h2>
---
--- All modifiers can be combined, for example. Incompatible ones are ignored.
--- - `<<al:1>> Dungeon^n,in` => `in einem Dungeon` ("in a dungeon")
--- - `<<m:1>> Dungeon^n,in` => `Dungeons`
--- - `<<ml:1>> Dungeon^n,in` => `in den Dungeons` ("in the dungeons")
--- - `<<mL:1>> Dungeon^n,in` => `in die Dungeons` ("into the dungeons")
--- - `<<ma:1>> Dungeon^n,in` => `einige Dungeons` ("some dungeons")
---
---@param format string The format of the string like "Hello <<1>>"

---@param arg1 string|number positional arg
---@param arg2? string|number positional arg
---@param arg3? string|number positional arg
---@param arg4? string|number positional arg
---@param arg5? string|number positional arg
---@param arg6? string|number positional arg
---@param arg7? string|number positional arg

---@return string formatted result
---@see esoui [ESOUI-Documentation](https://wiki.esoui.com/How_to_format_strings_with_zo_strformat)
function zo_strformat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
  return ""
end

---table.concat but with custom separator as first argument
---@param separator string glue
---@param ... string items
---@return string
function zo_strjoin(separator, ...)
  return ""
end

--- @alias CurrencyType : number
---| 0 # CURT_NONE (No currency)
---| 1 # CURT_MONEY (Gold)
---| 2 # CURT_ALLIANCE_POINTS (AP)
---| 3 # CURT_TELVAR_STONES (TelVar)
---| 4 # CURT_WRIT_VOUCHERS (Writ Vouchers)
---| 5 # CURT_CHAOTIC_CREATIA (Transmutation Crystal)
---| 6 # CURT_CROWN_GEMS (Crown Gems)
---| 7 # CURT_CROWNS (Crowns)
---| 8 # CURT_STYLE_STONES (Style Mimic Stones)
---| 9 # CURT_EVENT_TICKETS (Event Tickets)
---| 10 # CURT_UNDAUNTED_KEYS (Undaunted Keys)
---| 11 # CURT_ENDEAVOR_SEALS (Seals of Endeavor)
---| 12 # CURT_ENDLESS_DUNGEON (Infinite Archive)

---@type CurrencyType
CURT_NONE = 0
---@type CurrencyType
CURT_MONEY = 1
---@type CurrencyType
CURT_ALLIANCE_POINTS = 2
---@type CurrencyType
CURT_TELVAR_STONES = 3
---@type CurrencyType
CURT_WRIT_VOUCHERS = 4
---@type CurrencyType
CURT_CHAOTIC_CREATIA = 5
---@type CurrencyType
CURT_CROWN_GEMS = 6
---@type CurrencyType
CURT_CROWNS = 7
---@type CurrencyType
CURT_STYLE_STONES = 8
---@type CurrencyType
CURT_EVENT_TICKETS = 9
---@type CurrencyType
CURT_UNDAUNTED_KEYS = 10
---@type CurrencyType
CURT_ENDEAVOR_SEALS = 11
---@type CurrencyType
CURT_ENDLESS_DUNGEON = 12

---@alias FormatType : number
---| 1 # ZO_CURRENCY_FORMAT_AMOUNT_NAME
---| 2 # ZO_CURRENCY_FORMAT_WHITE_AMOUNT_WHITE_NAME
---| 3 # ZO_CURRENCY_FORMAT_PARENTHETICAL_AMOUNT
---| 4 # ZO_CURRENCY_FORMAT_AMOUNT_ICON
---| 5 # ZO_CURRENCY_FORMAT_WHITE_AMOUNT_ICON
---| 6 # ZO_CURRENCY_FORMAT_ERROR_AMOUNT_ICON
---| 7 # ZO_CURRENCY_FORMAT_PLURAL_NAME_ICON
---| 8 # ZO_CURRENCY_FORMAT_STRIKETHROUGH_AMOUNT_ICON

---@type FormatType
ZO_CURRENCY_FORMAT_AMOUNT_NAME = 1
---@type FormatType
ZO_CURRENCY_FORMAT_WHITE_AMOUNT_WHITE_NAME = 2
---@type FormatType
ZO_CURRENCY_FORMAT_PARENTHETICAL_AMOUNT = 3
---@type FormatType
ZO_CURRENCY_FORMAT_AMOUNT_ICON = 4
---@type FormatType
ZO_CURRENCY_FORMAT_WHITE_AMOUNT_ICON = 5
---@type FormatType
ZO_CURRENCY_FORMAT_ERROR_AMOUNT_ICON = 6
---@type FormatType
ZO_CURRENCY_FORMAT_PLURAL_NAME_ICON = 7
---@type FormatType
ZO_CURRENCY_FORMAT_STRIKETHROUGH_AMOUNT_ICON = 8

---Format currency string for PC/Keyboard
---<br>Example:
---<br>    ZO_Currency_FormatKeyboard(CURT_TELVAR_STONES, 12345, ZO_CURRENCY_FORMAT_PLURAL_NAME_ICON)
---<br> --> "12,345 Tel Var Stones [ICON]"
---@param currencyType CurrencyType
---@param currencyAmount integer like 12345
---@param formatType FormatType like ZO_CURRENCY_FORMAT_PLURAL_NAME_ICON
---@param extraOptions table|nil {showCap, currencyLocation, color, iconInheritColor}
---@return string
function ZO_Currency_FormatKeyboard(currencyType, currencyAmount, formatType, extraOptions)
  return ""
end

--- @param zoneId integer
--- @return string names
function GetZoneNameById(zoneId)
  return ""
end

--- @param stringVariablePrefix string
--- @param contextId integer
--- @overload fun(contextId: integer|string): string
--- @return string
function GetString(stringVariablePrefix, contextId)
  return ""
end

--- @param skillLineId integer
--- @return string name
function GetSkillLineNameById(skillLineId)
  return ""
end

---@class MonsterSocialClass : number

---@type MonsterSocialClass Alchemist
SI_MONSTERSOCIALCLASS2 = 1021
---@type MonsterSocialClass Artisan
SI_MONSTERSOCIALCLASS3 = 1022
---@type MonsterSocialClass Assassin
SI_MONSTERSOCIALCLASS4 = 1023
---@type MonsterSocialClass Bard
SI_MONSTERSOCIALCLASS5 = 1024
---@type MonsterSocialClass Beggar
SI_MONSTERSOCIALCLASS6 = 1025
---@type MonsterSocialClass Chef
SI_MONSTERSOCIALCLASS7 = 1026
---@type MonsterSocialClass Civil Servant
SI_MONSTERSOCIALCLASS8 = 1027
---@type MonsterSocialClass Clothier
SI_MONSTERSOCIALCLASS9 = 1028
---@type MonsterSocialClass Commoner
SI_MONSTERSOCIALCLASS10 = 1029
---@type MonsterSocialClass Crafter
SI_MONSTERSOCIALCLASS11 = 1030
---@type MonsterSocialClass Cultist
SI_MONSTERSOCIALCLASS12 = 1031
---@type MonsterSocialClass Drunkard
SI_MONSTERSOCIALCLASS13 = 1032
---@type MonsterSocialClass Farmer
SI_MONSTERSOCIALCLASS14 = 1033
---@type MonsterSocialClass Fighter
SI_MONSTERSOCIALCLASS15 = 1034
---@type MonsterSocialClass Fisher
SI_MONSTERSOCIALCLASS16 = 1035
---@type MonsterSocialClass Gatherer
SI_MONSTERSOCIALCLASS17 = 1036
---@type MonsterSocialClass Ghost
SI_MONSTERSOCIALCLASS18 = 1037
---@type MonsterSocialClass Guard
SI_MONSTERSOCIALCLASS19 = 1038
---@type MonsterSocialClass Healer
SI_MONSTERSOCIALCLASS20 = 1039
---@type MonsterSocialClass Hunter
SI_MONSTERSOCIALCLASS21 = 1040
---@type MonsterSocialClass Laborer
SI_MONSTERSOCIALCLASS22 = 1041
---@type MonsterSocialClass Mage
SI_MONSTERSOCIALCLASS23 = 1042
---@type MonsterSocialClass Merchant
SI_MONSTERSOCIALCLASS24 = 1043
---@type MonsterSocialClass Noble
SI_MONSTERSOCIALCLASS25 = 1044
---@type MonsterSocialClass Nude
SI_MONSTERSOCIALCLASS26 = 1045
---@type MonsterSocialClass Ordinator
SI_MONSTERSOCIALCLASS27 = 1046
---@type MonsterSocialClass Outlaw
SI_MONSTERSOCIALCLASS28 = 1047
---@type MonsterSocialClass Pilgrim
SI_MONSTERSOCIALCLASS29 = 1048
---@type MonsterSocialClass Priest
SI_MONSTERSOCIALCLASS30 = 1049
---@type MonsterSocialClass Prisoner
SI_MONSTERSOCIALCLASS31 = 1050
---@type MonsterSocialClass Provisioner
SI_MONSTERSOCIALCLASS32 = 1051
---@type MonsterSocialClass Sailor
SI_MONSTERSOCIALCLASS33 = 1052
---@type MonsterSocialClass Scholar
SI_MONSTERSOCIALCLASS34 = 1053
---@type MonsterSocialClass Servant
SI_MONSTERSOCIALCLASS35 = 1054
---@type MonsterSocialClass Skeleton
SI_MONSTERSOCIALCLASS36 = 1055
---@type MonsterSocialClass Slave
SI_MONSTERSOCIALCLASS37 = 1056
---@type MonsterSocialClass Smith
SI_MONSTERSOCIALCLASS38 = 1057
---@type MonsterSocialClass Soldier
SI_MONSTERSOCIALCLASS39 = 1058
---@type MonsterSocialClass Student
SI_MONSTERSOCIALCLASS40 = 1059
---@type MonsterSocialClass Thief
SI_MONSTERSOCIALCLASS41 = 1060
---@type MonsterSocialClass Vampire
SI_MONSTERSOCIALCLASS42 = 1061
---@type MonsterSocialClass Warrior
SI_MONSTERSOCIALCLASS43 = 1062
---@type MonsterSocialClass Watchmen
SI_MONSTERSOCIALCLASS44 = 1063
---@type MonsterSocialClass Werewolf
SI_MONSTERSOCIALCLASS45 = 1064
---@type MonsterSocialClass Woodwoker
SI_MONSTERSOCIALCLASS46 = 1065
---@type MonsterSocialClass Daedra
SI_MONSTERSOCIALCLASS47 = 1066

-- LIBS

---@class LibDebugLogger
---@field Create fun(tag: string): Logger
---@field ClearLog fun(self: LibDebugLogger): self
---@field SetMinLogLevel fun(self, level: string): self
---@field SetMinLevelOverride fun(self, level: string): self
LibDebugLogger = nil
LibDebugLogger.LOG_LEVEL_VERBOSE = "V"
LibDebugLogger.LOG_LEVEL_DEBUG = "D"
LibDebugLogger.LOG_LEVEL_INFO = "I"
LibDebugLogger.LOG_LEVEL_WARNING = "W"
LibDebugLogger.LOG_LEVEL_ERROR = "E"

---@class Logger:LibDebugLogger
---@field Verbose fun(...)
---@field Debug fun(...)
---@field Info fun(...)
---@field Warn fun(...)
---@field Error fun(...)
Logger = nil

---@class LibCharacterKnowledge
---@field GetServerList fun(): table
---@field GetCharacterList fun(server: any): table
---@field GetItemLinkFromItemId fun(itemId: any): any
---@field GetItemName fun(item: any): string
---@field GetItemCategory fun(item: any): number
---@field GetItemKnowledgeForCharacter fun(item: any, server: any, charId: any): any
---@field GetItemKnowledgeList fun(item: any, server: any, includedCharIds: any): table
---@field IsKnowledgeUsable fun(knowledge: any): boolean
---@field GetItemIdsForCategory fun(category: any): table
---@field GetMotifStyles fun(): any
---@field GetStyleAndChapterFromMotif fun(item: any): any
---@field GetMotifItemsFromStyle fun(styleId: any): any
---@field GetMotifChapterNames fun(): table
---@field GetMotifStyleQuality fun(styleId: any): number
---@field GetMotifKnowledgeForCharacter fun(styleId: any, chapterId: any, ...): any
---@field GetLastScanTime fun(server: any, charId: any): number
---@field RegisterForCallback fun(name: string, eventCode: number, callback: function): boolean
---@field UnregisterForCallback fun(name: string, eventCode: number): boolean
LibCharacterKnowledge = {}

LibCharacterKnowledge.ITEM_CATEGORY_NONE = 0
LibCharacterKnowledge.ITEM_CATEGORY_RECIPE = 1
LibCharacterKnowledge.ITEM_CATEGORY_PLAN = 2
LibCharacterKnowledge.ITEM_CATEGORY_MOTIF = 3
LibCharacterKnowledge.ITEM_CATEGORIES = {}
LibCharacterKnowledge.KNOWLEDGE_INVALID = -1
LibCharacterKnowledge.KNOWLEDGE_NODATA = 0
LibCharacterKnowledge.KNOWLEDGE_KNOWN = 1
LibCharacterKnowledge.KNOWLEDGE_UNKNOWN = 2
LibCharacterKnowledge.PRIORITY_CLASSES = 13
LibCharacterKnowledge.EVENT_INITIALIZED = 1
LibCharacterKnowledge.EVENT_UPDATE_REFRESH = 2

-- ////// END   : Manual entries and overrides
