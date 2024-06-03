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
FURC_AV_ADO = "Adosa Veralor"
FURC_AV_ALC = "alchemists"
FURC_AV_ALI = "Alinor, Riverside Market"
FURC_AV_ARTAEUM = "Artaeum"
FURC_AV_ATH = "Athragor"
FURC_AV_AVERIO = "Averio Brassac"
FURC_AV_BALFOYEN = "Dhalmora, Bal Foyen"
FURC_AV_BARNABE = "Barnabe Cariveau"
FURC_AV_BELKARTH_WOOD = "Craglorn, Belkarth Woodworking store"
FURC_AV_BETNIKH_TAVERN = "Bethnikh, near tavern"
FURC_AV_BRELDA = "Brelda Ofemalen"
FURC_AV_BSM = "blacksmiths"
FURC_AV_CAPITAL = "any capital city"
FURC_AV_CAR = "carpenters"
FURC_AV_CC_CITADEL = "The Brass Citadel, Market"
FURC_AV_CITY = "any city"
FURC_AV_CLO = "clothiers"
FURC_AV_COO = "cooks"
FURC_AV_CORIMONT = "Shadowfen, Alten Corimont"
FURC_AV_CUR = "Curininwe"
FURC_AV_DAGGERFALL_RL = "Glenumbra, Daggerfall, The Rosy Lion"
FURC_AV_DNG = "Drops-No-Glass"
FURC_AV_DNG_COLL = "Drops-No-Glass, Temple Doctrine Collection"
FURC_AV_DRAGONHOLD = "Dragonhold Armoury"
FURC_AV_EASTMARCH = "Eastmarch"
FURC_AV_EBONHEART = "Stonefalls, Ebonheart"
FURC_AV_ENC = "enchanters"
FURC_AV_ENDLESS = "Endless Archive"
FURC_AV_EVERMORE = "Bangkorai, Evermore"
FURC_AV_FARGRAVE_FF = "Fargrave, Felicitous Furnishings"
FURC_AV_FIGHTERS = "the Fighters' guild"
FURC_AV_FIGHTERS_STEWARD = "Hall Steward"
FURC_AV_FORTAMOL = "Eastmarch, Fort Amol"
FURC_AV_FRO = "Frohilde Snow-Hair"
FURC_AV_GONFALON_FOFF = "Gonfalon Bay, Furnishings of Fine Finesse"
FURC_AV_HAR = "Harnwulf"
FURC_AV_HER = "Heralda Garscroft"
FURC_AV_HEW = "Hew's Bane"
FURC_AV_HOLLOW_CICERO = "Coldharbour, Hollow City, Cicero's General Good"
FURC_AV_IC_EVENT = "Imperial City Event"
FURC_AV_IDRENIE = "Idrenie Beren"
FURC_AV_IMPRESS = "Impressario"
FURC_AV_JERAN = "Jeran Antieve"
FURC_AV_KOZANZET_SWI = "Alik'r, Kozanzet, Sweetwater Inn"
FURC_AV_KRR = "Krrztrrb"
FURC_AV_KVATCH = "Gold Coast, Kvatch"
FURC_AV_LEGERDEMAIN_20 = "Legerdemain Rank 20"
FURC_AV_LEYAWIIN_DBF = "Leyawiin, Domestic Bliss Furnishings"
FURC_AV_LLIVAS = "Llivas Driler"
FURC_AV_LOT = "Lozotusk"
FURC_AV_LTS = "Listens-To-Sea"
FURC_AV_MAGES = "the Mages' guild"
FURC_AV_MAGES_MYSTIC = "the Mystic"
FURC_AV_MAGES_MYSTIC_COLL = "the Mystic as part of a collection"
FURC_AV_MAL = "Maladdiq"
FURC_AV_MARBRUK = "Greenshade, Marbruk"
FURC_AV_MARKARTH_MM = "Markarth, Markarth Mercantile"
FURC_AV_MARTINA = "Martina Ocella"
FURC_AV_MIRASO = "Miraso Marvayn"
FURC_AV_MIRUZA = "Miruza"
FURC_AV_MISTRAL = "Khenarthi's Roost, Mistral"
FURC_AV_MOURNHOLDBANK = "Mournhold Bank"
FURC_AV_MUL = "Mulvise Valyn"
FURC_AV_MUR = "Murkholg"
FURC_AV_MURKMIRE = "Murkmire"
FURC_AV_NAL = "Nalirsewen"
FURC_AV_NAR = "Narwaawende"
FURC_AV_NECROM_FRF = "Necrom, Final Rest Furnishings"
FURC_AV_NIF = "Nif"
FURC_AV_ORMAX = "Ormax Lemaitre"
FURC_AV_ORSINIUM = "Orsinium"
FURC_AV_OUT = "Outlaw Refuge, Merchant"
FURC_AV_QUEST_ABDUCTION = "Quest: Riverhold Abduction"
FURC_AV_QUEST_LAMENT = "Lauriel's Lament"
FURC_AV_QUEST_LILMURDER = "Murder in Lilandril"
FURC_AV_QUEST_LOST = "That which was lost quest completion"
FURC_AV_QUEST_LUNACY = "Quest: The lunacy of the two moons"
FURC_AV_QUEST_MASQUES = "Manor of Masques"
FURC_AV_QUEST_NISSWO = "Art of the Nisswo quest completion"
FURC_AV_QUEST_POTENTATE = "Quest: Descendant of the Potentate"
FURC_AV_RAWLKHA_MARKET = "Reaper's March, Rawl'Kha, Market"
FURC_AV_RAZ = "Razoufa"
FURC_AV_RAZ_COLL = "Razoufa as part of a collection"
FURC_AV_REDFUR = "Grahtwood, Redfur Trading Post"
FURC_AV_RIFTEN_ARMORER = "Riften, Market, Armorer"
FURC_AV_ROH = "Rohzika"
FURC_AV_SENCHAL_MARKET = "Senchal, Marketplace"
FURC_AV_SHORNHELM_DW = "Rivenspire, Shornhelm, Dead Wolf Inn"
FURC_AV_SKYWATCH = "Skywatch, Auridon"
FURC_AV_SOLITUDE_DH = "Solitude, Dragon's Hearth"
FURC_AV_TAR = "Tarmimn"
FURC_AV_TEZ = "Filer Tezurs"
FURC_AV_TIRUDILMO = "Tirudilmo"
FURC_AV_ULZ = "Ulz"
FURC_AV_UNDAUNTED = "Undaunted Quartermaster"
FURC_AV_UNDAUNTED_ENCL = "the Undaunted Enclaves"
FURC_AV_UNW = "Unwotil"
FURC_AV_UZI = "Uzipa"
FURC_AV_VAS = "Vasei"
FURC_AV_VASTYR_TOHF = "Vastyr, Touch of Home Furnshings"
FURC_AV_VIVEC_GQ = "Vivec City, Gladiator's Quarters"
FURC_AV_VIVEC_SDI = "Vivec City, Saint Delyn Inn"
FURC_AV_VULKWAESTEN_TAVERN = "Malabal Tor, Vulkwaesten, tavern"
FURC_AV_WAYREST_MERCHANT = "Stormhaven, Wayrest, Merchant district"
FURC_AV_ZAD = "Zadraska"
FURC_KITTY_LATHA = "Lathathim"
FURC_KITTY_YATAVA = "Yatava"
FURC_SKYRIM_MASELA = "Masela"
FURC_SKYRIM_NETINDELL = "Netindell"
SI_FURC_ADD_FAVE = " Add Favorite"
SI_FURC_AUTOMATON = "from automatons"
SI_FURC_CANBEFISHED = "can be fished"
SI_FURC_CANBEPICKED = "can be pickpocketed"
SI_FURC_CANBESCRYED = "from scrying"
SI_FURC_CANBESTOLEN = "can be stolen"
SI_FURC_CHEST_VV = "Extremely rarely from chests on Vvardenfell"
SI_FURC_CHESTS = "from treasure chests"
SI_FURC_CRAFTING = "Craftable: All"
SI_FURC_CRAFTING_KNOWN = "Craftable: Known"
SI_FURC_CRAFTING_KNOWN_TT = "Shows only known craftable items"
SI_FURC_CRAFTING_TT = "Shows all craftable items"
SI_FURC_CRAFTING_UNKNOWN = "Craftable: Unknown"
SI_FURC_CRAFTING_UNKNOWN_TT = "Shows only unknown craftable items"
SI_FURC_CRATE_ALLMAKER = "All-Maker"
SI_FURC_CRATE_ARMIGER = "Buoyant Armiger"
SI_FURC_CRATE_AYLEID = "Ayleid"
SI_FURC_CRATE_BAANDARI = "Baandari Pedlar"
SI_FURC_CRATE_CARNIVALE = "Carnivale"
SI_FURC_CRATE_CELESTIAL = "Celestial"
SI_FURC_CRATE_DARK = "Dark Chivalry"
SI_FURC_CRATE_DB = "Dark Brotherhood"
SI_FURC_CRATE_DIAMOND = "Diamond Anniversary"
SI_FURC_CRATE_DRAGONSCALE = "Dragonscale"
SI_FURC_CRATE_DWEMER = "Dwarven"
SI_FURC_CRATE_FEATHER = "Unfeathered"
SI_FURC_CRATE_FIREATRO = "Flame Atronach"
SI_FURC_CRATE_FROSTY = "Frost Atronach"
SI_FURC_CRATE_GLOOMSPORE = "Gloomspore"
SI_FURC_CRATE_HARLEQUIN = "Grim Harlequin"
SI_FURC_CRATE_HOLLOWJACK = "Hollowjack"
SI_FURC_CRATE_IRONY = "Iron Atronach"
SI_FURC_CRATE_LAMP = "Order of the Lamp"
SI_FURC_CRATE_MIRROR = "Mirrormoor"
SI_FURC_CRATE_NEWMOON = "New Moon"
SI_FURC_CRATE_NIGHTFALL = "Nightfall"
SI_FURC_CRATE_PSIJIC = "Psijic"
SI_FURC_CRATE_POTENTATE = "Akaviri Potentate"
SI_FURC_CRATE_RAGE = "Ragebound"
SI_FURC_CRATE_REAPER = "Reaper's Harvest"
SI_FURC_CRATE_SCALECALLER = "Scalecaller"
SI_FURC_CRATE_SOVNGARDE = "Sovngarde"
SI_FURC_CRATE_STONELORE = "Stonelore"
SI_FURC_CRATE_SUNKEN = "Sunken Trove"
SI_FURC_CRATE_WILDHUNT = "Wild Hunt"
SI_FURC_CRATE_WRAITH = "Wraithtide"
SI_FURC_CRATE_XANMEER = "Xanmeer"
SI_FURC_CROWN = "Crown Store"
SI_FURC_CROWN_TT = "Shows items that can only be acquired from crown store"
SI_FURC_CROWNSTORESOURCE = "Crown Store "
SI_FURC_DAEDRA_SOURCE = "from Daedra and Dolmen chests"
SI_FURC_DAILY_ASH = "Ashlander daily quest rewards"
SI_FURC_DAILY_ELSWEYR = "Elsweyr daily quest rewards"
SI_FURC_DATAMINED_UNCLEAR = "This item has been seen in-game, but it's not yet known where you can get it."
SI_FURC_DB = "The Dark Brotherhood supplies vendor hands these out "
SI_FURC_DB_EQUIP = "with equipment"
SI_FURC_DB_POISON = "with poison"
SI_FURC_DB_STEALTH = "as a way to be less obtrusive"
SI_FURC_DEBUG_CHARSCANCOMPLETE = "Furniture Catalogue: Character scan complete..."
SI_FURC_DIALOGUE_RESET_DB_BODY = "This will re-create the FurnitureCatalogue database from scratch"
SI_FURC_DIALOGUE_RESET_DB_HEADER = "Really re-create furniture database?"
SI_FURC_DOM_DUNGEON_DROP = "Drops in Depth of Malatar"
SI_FURC_DRAGON_DUNGEON_DROP = "Fang Lair/Scalecaller Peak"
SI_FURC_DROP = "This item is a drop "
SI_FURC_DROP_ALTMER = "This item is a drop on Summerset"
SI_FURC_ELF_PIC = "Drops rarely from treasure chests on Summerset"
SI_FURC_EVENT_BLACKWOOD = "From participating in the Bounties of Blackwood event"
SI_FURC_EVENT_ELSWEYR = "Elsweyr dragon event"
SI_FURC_EVENT_HOLLOWJACK = "Sinister Hollowjack Items"
SI_FURC_FAVE = "Favorites"
SI_FURC_FAVE_TT = "Shows your favorites"
SI_FURC_FESTIVAL_DROP = "can be acquired during <<1>> (<<2>>)"
SI_FURC_FILTER_CHAR_OFF = "Character filter: off"
SI_FURC_FILTER_CHAR_OFF_TT = "disables this filter"
SI_FURC_FILTER_VERSION_ALTMER = "Summerset"
SI_FURC_FILTER_VERSION_ALTMER_TT = "Still think the Dunmer are bad?"
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
SI_FURC_FILTER_VERSION_DRAGON_TT = "If you got this from Narsis Dren, well..."
SI_FURC_FILTER_VERSION_DRAGON2 = "Dragonhold"
SI_FURC_FILTER_VERSION_DRAGON2_TT = "Now with more dragons"
SI_FURC_FILTER_VERSION_DRUID = "Firesong"
SI_FURC_FILTER_VERSION_DRUID_TT = "Remember when we could block?"
SI_FURC_FILTER_VERSION_ENDLESS = "Secrets of the Telvanni"
SI_FURC_FILTER_VERSION_ENDLESS_TT = "Now with infinite tentacles"
SI_FURC_FILTER_VERSION_FLAMES = "Flames of Ambition"
SI_FURC_FILTER_VERSION_FLAMES_TT = "Mildly flammable"
SI_FURC_FILTER_VERSION_HARROW = "Harrowstorm"
SI_FURC_FILTER_VERSION_HARROW_TT = "Climate change is real"
SI_FURC_FILTER_VERSION_HS = "Homestead"
SI_FURC_FILTER_VERSION_HS_TT = "Items released in Homestead update"
SI_FURC_FILTER_VERSION_KITTY = "Elsweyr"
SI_FURC_FILTER_VERSION_KITTY_TT = "Khajiit has furniture, if you have coin!"
SI_FURC_FILTER_VERSION_M = "Morrowind"
SI_FURC_FILTER_VERSION_M_TT = "YOU N'WAH!"
SI_FURC_FILTER_VERSION_MARKAT = "Markarth"
SI_FURC_FILTER_VERSION_MARKAT_TT = "With Dwemer Plumbing"
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
SI_FURC_FILTER_VERSION_WEREWOLF = "Wolfhunter"
SI_FURC_FILTER_VERSION_WEREWOLF_TT = "In Soviet Hunting Ground, werewolf hunt you"
SI_FURC_FILTER_VERSION_WOTL = "Wrathstone"
SI_FURC_FILTER_VERSION_WOTL_TT = "Wrathstone!"
SI_FURC_FIVE_TO_SHOPPINGLIST = "Add 5 to shopping list"
SI_FURC_GEYSER = "Drops from geyser reward clams on Summerset"
SI_FURC_GIANT_CLAM = "Drops from giant clams and geyser reward clams on Summerset"
SI_FURC_HARVEST = "from harvesting nodes"
SI_FURC_HIDE_CROWN_TT = "Showing crown store. Click to hide."
SI_FURC_HIDE_RUMOUR_TT = "Showing rumour (unconfirmed) items. Click to hide."
SI_FURC_HOUSE = "From a furnished purchase of <<1>>"
SI_FURC_ITEMSOURCE_EMPTY =
  "Item source unknown.\nTry to re-scan files (refresh button right click).\nIf the item is still unknown - and not part of the weekend furnisher's current inventory - please send a mail with the item link and -source to @berylbones."
SI_FURC_ITEMSOURCE_ITEMPACK = "Part of the Crown Store item pack [<<1>>] "
SI_FURC_ITEMSOURCE_MISCHOUSE = "From select house purchases"
SI_FURC_ITEMSOURCE_SAFEBOX = "extremely rarely from safeboxes"
SI_FURC_LABEL_ENTRIES = " entries -"
SI_FURC_LEVELUP = "Can be gained as levelup reward"
SI_FURC_LOC_BLACKWOOD = "in Blackwood"
SI_FURC_LOC_ELSWEYR = "in Elsweyr"
SI_FURC_LOC_GOLDCOAST = "in the Gold Coast"
SI_FURC_LOC_LILANDRIL = "Lilandril"
SI_FURC_LOC_MURKMIRE = "in Murkmire"
SI_FURC_LOC_NECROM = "in Telvanni Peninsula or Apocrypha"
SI_FURC_LOC_NELSWEYR = "in Northern Elsweyr"
SI_FURC_LOC_SELSWEYR = "in Southern Elsweyr"
SI_FURC_LOC_SKYRIM = "in Western Skyrim"
SI_FURC_LOC_SUMMERSET = "on Summerset"
SI_FURC_LOC_SURAN = "Suran"
SI_FURC_LOC_VVARDENFELL = "on Vvardenfell"
SI_FURC_LOC_WROTHGAR = "in Wrothgar"
SI_FURC_LUXURY = "Luxury items"
SI_FURC_LUXURY_TT = "Items that at some point were sold by Zanil Theran, Cicero's General Goods, Coldharbour"
SI_FURC_MENU_HEADER = "- |cD3B830Furniture|r:"
SI_FURC_NONE = "Source filter: off"
SI_FURC_NONE_TT = "disables this filter"
SI_FURC_ONE_TO_SHOPPINGLIST = "Add 1 to shopping list"
SI_FURC_OR = "or"
SI_FURC_OTHER = "Other"
SI_FURC_OTHER_TT = "Shows items that can be farmed/stolen/found"
SI_FURC_PLANTS = "from harvesting plants"
SI_FURC_PLUNDERSKULL = "Drops from Plunder Skulls during Witches' Festival"
SI_FURC_POST_ITEM = " Post item"
SI_FURC_POST_ITEMSOURCE = " Post item source"
SI_FURC_POST_MATERIAL = " Post material"
SI_FURC_POST_RECIPE = " Post recipe"
SI_FURC_PSIJIC_RANK = "Psijic Order Rank "
SI_FURC_PVP = "Purchaseable (AP)"
SI_FURC_PVP_TT = "Items that are sold for alliance points"
SI_FURC_QUESTREWARD = "Reward for a quest in "
SI_FURC_REMOVE_FAVE = " Remove Favorite"
SI_FURC_REQUIRES_ACHIEVEMENT = ", requires "
SI_FURC_RUMOUR = "Rumour items"
SI_FURC_RUMOUR_SOURCE_ITEM = "This item has been datamined, but not seen in-game"
SI_FURC_RUMOUR_SOURCE_RECIPE = "This recipe has been datamined, but not seen in-game"
SI_FURC_RUMOUR_TT = "Items and recipes that have been datamined, but haven't been confirmed existing"
SI_FURC_SCAMBOX = "Crown Crates"
SI_FURC_SCAMBOX_GEMS = "Crown Crate Gems"
SI_FURC_SEEN_IN_GUILDSTORE = "Seen in Guild Store"
SI_FURC_SHOW_CROWN_TT = "Hiding crown store. Click to show."
SI_FURC_SHOW_RUMOUR_TT = "Confirmed items only. Click to show rumour items."
SI_FURC_SLAVES_DAILY = "from Murkmire daily quest reward boxes"
SI_FURC_STRING_AP = " AP"
SI_FURC_STRING_ASSHOLE = "Zanil Theran"
SI_FURC_STRING_CANNOT_CRAFT = "You cannot craft this yet"
SI_FURC_STRING_CONTEXTMENU_DIVIDER = "Don't use divider in context menu?"
SI_FURC_STRING_CONTEXTMENU_DIVIDER_TT =
  "Adds a divider to the context menu above the - Furniture entry. Check to disable"
SI_FURC_STRING_CONTEXTMENU_INVENTORY = "Disable context menu in inventory?"
SI_FURC_STRING_CONTEXTMENU_INVENTORY_TT =
  "Disables the context for inventory items like posting material and adding to favourites."
SI_FURC_STRING_CRAFTABLE_BY = "Can be crafted by "
SI_FURC_STRING_FAUSTINA = "Sold by |cd68957Faustina Curio|r <<1>>"
SI_FURC_STRING_FOR_VOUCHERS = "for <<1>> vouchers"
SI_FURC_STRING_HC = "Hollow City"
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
SI_FURC_STRING_MENU_F_ALL_ON_TEXT = "Configure this filter"
SI_FURC_STRING_MENU_FALL_HIDE_BOOKS = "Hide books anyway"
SI_FURC_STRING_MENU_FALL_HIDE_BOOKS_TT = "Even when filtering all items, still hide books?"
SI_FURC_STRING_MENU_FALL_HIDE_CROWN = "Hide crown store items anyway"
SI_FURC_STRING_MENU_FALL_HIDE_CROWN_TT = "Even when filtering all items, still hide crown store items?"
SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR = "Hide rumour items anyway"
SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR_TT = "Even when filtering all items, still hide rumour items?"
SI_FURC_STRING_MENU_FALL_HIDE_UI_BUTTON = "Hide UI button in search box?"
SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT = "Search filtered items when doing a text search with no dropdown filters set?"
SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT_TT = "When doing a text search without any dropdown "
SI_FURC_STRING_MENU_FILTER_BOOKS = "Mages guild books"
SI_FURC_STRING_MENU_FILTER_BOOKS_N = "Hide books?"
SI_FURC_STRING_MENU_FILTER_BOOKS_TT =
  "A real book lover knows where everything is by heart. Hide books from Furniture Catalogue?"
SI_FURC_STRING_MENU_FILTERING = "Catalogue filtering"
SI_FURC_STRING_MENU_FONTSIZE = "Font size"
SI_FURC_STRING_MENU_FONTSIZE_TT = "adjust font size for FurnitureCatalogue here"
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
SI_FURC_STRING_RECIPELEARNED = "Recipe learned: <<1>> <<2>> <<3>>"
SI_FURC_STRING_RECIPESFORCHAR = "recipes for <<1>>"
SI_FURC_STRING_ROLIS = "Sold by |cd68957Rolis Hlaalu|r <<1>>"
SI_FURC_STRING_VENDOR = "sold by <<1>> in <<2>> (<<3>><<4>>)"
SI_FURC_STRING_VOUCHER_VENDOR = "Sold by either Rolis Hlaalu or Faustina Curio"
SI_FURC_STRING_WASSOLDBY = "Was sold by <<1>> in <<2>> (<<3>>) <<4>>"
SI_FURC_STRING_WEEKEND_AROUND = "(around <<1>>)"
SI_FURC_STRING_WRIT_VENDOR = "Master Writ Vendor"
SI_FURC_STRING_WRIT_VENDOR_TT = "Obtainable for Master Writs in your alliance's capital"
SI_FURC_TEXTBOX_FILTER_DEFAULT = "Filter by text search"
SI_FURC_TOGGLE_SHOPPINGLIST = " Toggle shopping list"
SI_FURC_TOMBS = "Ancestor tombs and ruins on Vvardenfell"
SI_FURC_TRIBUTE = "From Tales of Tribute reward coffers"
SI_FURC_TRIBUTE_RANKED = "From Tales of Tribute ranked matches (system mail reward)"
SI_FURC_VENDOR = "Purchaseable (gold)"
SI_FURC_VENDOR_TT = "Shows only items that cannot be crafted"
SI_FURC_VERBOSE_DB_UPTODATE = "Furniture Catalogue: The database is up-to-date."
SI_FURC_VERBOSE_SCANNING_CHARS = "Not scanning files, scanning character knowledge now..."
SI_FURC_VERBOSE_SCANNING_DATA_FILE = "Furniture Catalogue: Scanning data files..."
SI_FURC_VERBOSE_STARTUP =
  "Furniture Catalogue: If you miss any recipes, please trigger a scan on your furniture crafter by clicking the refresh button in the UI."
SI_FURC_VV_PAINTING = "Extremely rarely from chests or lockboxes on Vvardenfell"
SI_FURC_WW = "occasionally found in wood nodes"
SI_FURC_WW_DUNGEON_DROP = "Drops in Monster Hunter Keep/March of the Sacrifices"
-- ////// END   : GENERATED FROM locale/en.lua

-- ////// START   : Manual entries and overrides
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
