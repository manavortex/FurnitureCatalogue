local strings = {
  -- ////// START : DON'T REMOVE THIS LINE
  SI_FURC_ADD_FAVE = " Ajouter un favori",
  SI_FURC_CHEST_VV = "Extrêmement rarement dans les coffres à Vvardenfell",
  SI_FURC_CRATE_DWEMER = "Dwemer",
  SI_FURC_CRATE_FIREATRO = "Atronach de Flamme ",
  SI_FURC_CRATE_REAPER = "de la Moisson de la Faucheuse",
  SI_FURC_DAEDRA_SOURCE = "Des Daedra et Coffres des Dolmen ",
  SI_FURC_DAILY_ASH = "Récompenses des quêtes quotidiennes d'Ashlander au Camp d'Ald’ruhn ",
  SI_FURC_DAILY_ELSWEYR = "Récompenses des quêtes quotidiennes d'Elsweyr ",
  SI_FURC_DATAMINED_UNCLEAR = "Cet élément a été confirmé comme existant, mais son origine n'est pas encore connue.",
  SI_FURC_DB = "Le vendeur de fournitures de la Confrérie noire les distribue ",
  SI_FURC_DB_POISON = "Avec du poison ",
  SI_FURC_DB_STEALTH = "Comme moyen d'être moins voyant ",
  SI_FURC_DEBUG_CHARSCANCOMPLETE = "Furniture Catalogue: Analyse des caractères terminée...",
  SI_FURC_DIALOGUE_RESET_DB_BODY = "Cela recréera la base de données de FurnitureCatalogue à partir de zéro",
  SI_FURC_DIALOGUE_RESET_DB_HEADER = "Recréez la base de données de meubles?",
  SI_FURC_DROP = "Cet article se ramasse ",
  SI_FURC_DROP_ALTMER = "Cet article se ramasse à Summerset ",
  SI_FURC_DUNG = "dungeon;dungeons",
  SI_FURC_ELF_PIC = "Tombe rarement dans les coffres au trésor à Summerset",
  SI_FURC_EVENT = "event;events",
  SI_FURC_EVENT_BLACKWOOD = "From participating in the Bounties of Blackwood event",
  SI_FURC_EVENT_ELSWEYR = "Événement de Dragon d'Elsweyr ",
  SI_FURC_FILTER_CHAR_OFF = "Filtre de Personnages: désactivé",
  SI_FURC_FILTER_CHAR_OFF_TT = "Filtre Désactivé",
  SI_FURC_FILTER_CROWN_HIDE_TT = "Montrer la boutique à couronne. Cliquez pour cacher.",
  SI_FURC_FILTER_RUMOUR_HIDE_TT = "Affichage des éléments signalé (Rumeur, non confirmés). Cliquez pour cacher.",
  SI_FURC_FILTER_SRC_CRAFTING = "Fabriquable: Tous",
  SI_FURC_FILTER_SRC_CRAFTING_KNOWN = "Fabriquable: connu",
  SI_FURC_FILTER_SRC_CRAFTING_KNOWN_TT = "Affiche uniquement les objets fabriquable connus",
  SI_FURC_FILTER_SRC_CRAFTING_TT = "Affiche tous les objets à fabriquer",
  SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN = "Fabriquable: inconnu",
  SI_FURC_FILTER_SRC_CRAFTING_UNKNOWN_TT = "Affiche uniquement les objets fabriquable inconnus",
  SI_FURC_FILTER_SRC_CROWN = "Boutique à Couronnes",
  SI_FURC_FILTER_SRC_CROWN_TT = "Affiche les articles qui ne peuvent être achetés que dans la boutique à couronnes",
  SI_FURC_FILTER_SRC_FAVE = "Favoris",
  SI_FURC_FILTER_SRC_FAVE_TT = "Affiche vos favoris",
  SI_FURC_FILTER_SRC_LUX = "Articles de luxe",
  SI_FURC_FILTER_SRC_LUX_TT = "Articles qui à un moment donné ont été vendus par Zanil Theran, Havreglace",
  SI_FURC_FILTER_SRC_NONE = "Filtre source: désactivé",
  SI_FURC_FILTER_SRC_NONE_TT = "Désactive ce filtre",
  SI_FURC_FILTER_SRC_OTHER = "Autre",
  SI_FURC_FILTER_SRC_OTHER_TT = "Affiche les objets qui peuvent être ramassées/volés/trouvés",
  SI_FURC_FILTER_SRC_RUMOUR = "Articles signalé (Rumeur)",
  SI_FURC_FILTER_SRC_RUMOUR_TT = "Articles et recettes qui ont été dataminés, mais qui n'ont pas été confirmés existants",
  SI_FURC_FILTER_SRC_SOLD_AP = "Achetable (PA)",
  SI_FURC_FILTER_SRC_SOLD_AP_TT = "Objets vendus contre des points d'alliance",
  SI_FURC_FILTER_SRC_SOLD_GOLD = "Achetable (OR)",
  SI_FURC_FILTER_SRC_SOLD_GOLD_TT = "Affiche uniquement les objets qui ne peuvent pas être fabriqués",
  SI_FURC_FILTER_SRC_SOLD_WRIT = "Vendeur commandes de maîtres",
  SI_FURC_FILTER_SRC_SOLD_WRIT_TT = "Obtenable par les commandes de maîtres dans la capitale de votre alliance",
  SI_FURC_FILTER_VERSION_ALTMER_TT = "Je pense toujours que les Dunmer sont mauvais?",
  SI_FURC_FILTER_VERSION_CC_TT = "Où les volants tournent et le laiton est joli",
  SI_FURC_FILTER_VERSION_DRAGON2_TT = "Maintenant avec plus de dragons",
  SI_FURC_FILTER_VERSION_DRAGON_TT = "Si vous avez ça de Narsis Dren, eh bien...",
  SI_FURC_FILTER_VERSION_HARROW_TT = "Le changement climatique est réel",
  SI_FURC_FILTER_VERSION_HS_TT = "Articles publiés dans la mise à jour Homestead",
  SI_FURC_FILTER_VERSION_KITTY_TT = "Khajiit a des meubles, si vous avez de la monnaie!",
  SI_FURC_FILTER_VERSION_M_TT = "VOUS N'WAH!",
  SI_FURC_FILTER_VERSION_OFF = "Filtre de version: désactivé",
  SI_FURC_FILTER_VERSION_OFF_TT = "Filtre Désactivé",
  SI_FURC_FILTER_VERSION_R_TT = "Parce que tout ce dont nous avions besoin était plus de Reachmen",
  SI_FURC_FILTER_VERSION_SKYRIM_TT = "Ils vendent encore Skyrim!",
  SI_FURC_FILTER_VERSION_SLAVES_TT = "Qu'est-ce que les enfants argoniens apprennent à l'école? Arbre-Hist.",
  SI_FURC_FILTER_VERSION_STONET_TT = "Ce n'est pas vraiment de la pierre",
  SI_FURC_FILTER_VERSION_WEREWOLF_TT = "Dans le terrain de chasse soviétique, le loup-garou vous chasse",
  SI_FURC_GEYSER = "Ramasser dans les palourdes et récompense de geyser à Summerset",
  SI_FURC_GIANT_CLAM = "Ramasser dans les palourdes géantes et récompense de geyser à Summerset",
  SI_FURC_GRAMMAR_OBTAINABLE = "Peut être acquis pendant <<1>> (<<2>>)",
  SI_FURC_HOUSE = "À partir d'un achat meublé de <<1>>",
  SI_FURC_LABEL_ENTRIES = " entrées -",
  SI_FURC_LOC_ALIKR_KOZANZET_SWI = "Alik'r, Kozanzet, Sweetwater Inn",
  SI_FURC_LOC_ANY_CAPITAL = "N'importe quelle capitale",
  SI_FURC_LOC_AURIDON_SKYWATCH = "Skywatch, Auridon",
  SI_FURC_LOC_BALFOYEN_DHALMORA = "Dhalmora, Bal Foyen",
  SI_FURC_LOC_BETHNIKH_LTT = "Bethnikh, Loose Tooth Tavern",
  SI_FURC_LOC_BLACKWOOD_LEYAWIIN_DBF = "Leyawiin, Domestic Bliss Furnishings",
  SI_FURC_LOC_COLDH_HOLLOW = "Cité Creuse",
  SI_FURC_LOC_COLDH_HOLLOW_CGG = "Coldharbour, Hollow City, Cicero's General Good",
  SI_FURC_LOC_CRAGLORN_BELKARTH_WOOD = "Craglorn, Belkarth Woodworking store",
  SI_FURC_LOC_DESHAAN_MH_BANK = "Mournhold Bank",
  SI_FURC_LOC_EASTMARCH_AMOL = "Eastmarch, Fort Amol",
  SI_FURC_LOC_ELSWEYR = "in Elsweyr",
  SI_FURC_LOC_GALEN_VAS_TOHF = "Vastyr, Touch of Home Furnshings",
  SI_FURC_LOC_GLENUMBRA_DF_RL = "Glenumbra, Daggerfall, The Rosy Lion",
  SI_FURC_LOC_GOLDCOAST_KVATCH = "Gold Coast, Kvatch",
  SI_FURC_LOC_GREENSHADE_MARBRUK = "Greenshade, Marbruk",
  SI_FURC_LOC_HIGHISLE_GFB_FOFF = "Gonfalon Bay, Furnishings of Fine Finesse",
  SI_FURC_LOC_KHENARTHI_MISTRAL = "Khenarthi's Roost, Mistral",
  SI_FURC_LOC_REACH_MARKARTH_MM = "Markarth, Markarth Mercantile",
  SI_FURC_LOC_SHADOWFEN_CORIMONT = "Shadowfen, Alten Corimont",
  SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE = "Alinor, Marché de la Rivière",
  SI_FURC_LOC_UNDAUNTED = "the Undaunted Enclaves",
  SI_FURC_LOOT_CHESTS = "Des Cassetes",
  SI_FURC_LOOT_FISH = "Peut être pêché ",
  SI_FURC_LOOT_HARVEST = "Des nœuds de récolte ",
  SI_FURC_LOOT_HARVEST_WOOD = "Parfois trouvé dans les nœuds de bois ",
  SI_FURC_LOOT_PICKPOCKET = "Peut être volé à la tire ",
  SI_FURC_LOOT_PLANTS = "De la récolte des plantes ",
  SI_FURC_LOOT_SCRYING = "A partir des Pistes ",
  SI_FURC_LOOT_STEALING = "Peut être volé ",
  SI_FURC_MENU_HEADER = "- |cD3B830Meubles|r:",
  SI_FURC_NPC_AUTOMATON = "Des automates ",
  SI_FURC_NPC_DRUNKARD = "drunkard;drunkards",
  SI_FURC_NPC_GUARD = "guard;guards",
  SI_FURC_NPC_MAGE = "mage;mages",
  SI_FURC_NPC_PILGRIM = "pilgrim;pilgrims",
  SI_FURC_NPC_PRIEST = "priest;priests",
  SI_FURC_NPC_SCHOLAR = "scholar;scholars",
  SI_FURC_NPC_THIEF = "thief;thieves",
  SI_FURC_NPC_WOODWORKER = "woodworker;woodworkers",
  SI_FURC_PLUGIN_SL_ADD_FIVE = " Ajouter 5 à la liste de courses",
  SI_FURC_PLUGIN_SL_ADD_ONE = " Ajouter 1 à la liste de courses",
  SI_FURC_PLUNDERSKULL = "Ramasser dans les Crânes, pendant le festival des sorcières ",
  SI_FURC_POST_ITEM = " Publier l'article",
  SI_FURC_POST_ITEMSOURCE = " Publier la source de l'article",
  SI_FURC_POST_MATERIAL = " Publier le Matériel",
  SI_FURC_POST_RECIPE = " Publier la recette",
  SI_FURC_PSIJIC_RANK = "Rang De l'ordre Psijique ",
  SI_FURC_QUESTREWARD = "Récompense pour une quête en ",
  SI_FURC_REMOVE_FAVE = " Supprimer le favori",
  SI_FURC_REQUIRES_ACHIEVEMENT = ", A besoin ",
  SI_FURC_SCAMBOX = "Caisses à Couronne ",
  SI_FURC_SEEN_IN_GUILDSTORE = "Vu dans le magasin de guilde",
  SI_FURC_SHOW_CROWN_TT = "Cacher la boutique à couronne. Cliquez pour montrer.",
  SI_FURC_SHOW_RUMOUR_TT = "Articles confirmés uniquement. Cliquez pour afficher les éléments signalé (Rumeur).",
  SI_FURC_SLAVES_DAILY = "Des boîtes de récompense de la préquête de Murkmire",
  SI_FURC_SRC_CROWNSTORE = "Boutique à Couronnes ",
  SI_FURC_SRC_EMPTY = "Source de l'article inconnue.\nEssayez de réanalyser les fichiers (bouton d'actualisation clic droit).\nSi toujours inconnu après, veuillez envoyer un e-mail avec le lien de l'article et -source à @BerylBones",
  SI_FURC_SRC_ITEMPACK = "Fait partie du pack d'objets de la Boutique à Couronnes [<<1>>] ",
  SI_FURC_SRC_LVLUP = "Peut être gagné comme récompense de niveau supérieur",
  SI_FURC_SRC_RUMOUR_ITEM = "Cet objet a été dataminé, mais pas vu dans le jeu",
  SI_FURC_SRC_RUMOUR_RECIPE = "Cette recette a été dataminée, mais pas vue dans le jeu",
  SI_FURC_SRC_SAFEBOX = "Extrêmement rarement dans les Cassetes",
  SI_FURC_STRING_AP = " PA",
  SI_FURC_STRING_CANNOT_CRAFT = "Vous ne pouvez pas encore créer cela",
  SI_FURC_STRING_CONTEXTMENU_DIVIDER = "N'utilisez pas le diviseur dans le menu contextuel?",
  SI_FURC_STRING_CONTEXTMENU_DIVIDER_TT = "Ajoute un séparateur au menu contextuel au-dessus de l'entrée - Meubles. Cochez pour désactiver",
  SI_FURC_STRING_CRAFTABLE_BY = "Peut être fabriqué par ",
  SI_FURC_STRING_DUNG = "dungeon;dungeons",
  SI_FURC_STRING_FAUSTINA = "Vendu par |cd68957Faustina Curio|r <<1>>",
  SI_FURC_STRING_FOR_VOUCHERS = "Pour <<1>> Assignats",
  SI_FURC_STRING_MENU_ADD_ITEMS_NAME = "Ajouter des éléments à des recettes connues/inconnues?",
  SI_FURC_STRING_MENU_ADD_ITEMS_TT = "Vous ne devriez remarquer aucun retard",
  SI_FURC_STRING_MENU_CROWN = "Articles de la Boutique à Couronnes",
  SI_FURC_STRING_MENU_CROWN_DESC = "La base de données de meubles sera mise à jour chaque fois que l'info-bulle affiche un meuble. \nCertains articles ne peuvent être achetés que via la boutique à couronnes. \nCochez cette case pour les exclure des filtres par défaut (vous pouvez toujours les voir en sélectionnant 'Boutique à Couronnes' dans la liste déroulante des sources).",
  SI_FURC_STRING_MENU_CROWN_N = "Masquer les articles de la Boutique de la Couronne?",
  SI_FURC_STRING_MENU_DEBUG = "Activer le débeugage",
  SI_FURC_STRING_MENU_DEFAULT_DD = "Valeurs déroulantes par défaut",
  SI_FURC_STRING_MENU_DEFAULT_DD_CHAR = "Filtre de personnages par défaut",
  SI_FURC_STRING_MENU_DEFAULT_DD_RESET = "Réinitialiser les filtres lors de la fermeture de l'UI?",
  SI_FURC_STRING_MENU_DEFAULT_DD_RESET_TT = "Si vous cochez cette case, l'ouverture et la fermeture entraîneront la réinitialisation des filtres à ce que vous avez défini ci-dessous.",
  SI_FURC_STRING_MENU_DEFAULT_DD_SOURCE = "Filtre source par défaut",
  SI_FURC_STRING_MENU_DEFAULT_DD_USE = "Sera défini lors du lancement initial",
  SI_FURC_STRING_MENU_DEFAULT_DD_USE_TT = "Ceux-ci ne seront pas réinitialisés si vous ouvrez et fermez l'UI",
  SI_FURC_STRING_MENU_DEFAULT_DD_VERSION = "Filtre de version par défaut",
  SI_FURC_STRING_MENU_DELETE_CHAR_NAME = "supprimer un caractère",
  SI_FURC_STRING_MENU_DELETE_CHAR_TT = "Supprime toutes les connaissances pour ce personnage de la base de données. \nLe personnage sera à nouveau scanné la prochaine fois qu'il se connectera avec le module complémentaire activé. \n Le nom du personnage n'apparaîtra pas dans la liste déroulante s'il ne connaît aucune recette!",
  SI_FURC_STRING_MENU_DELETE_CHAR_WARNING = "La connaissance du personnage sera immédiatement effacée",
  SI_FURC_STRING_MENU_ENABLE_SHOPPINGLIST = "Activer l'intégration?",
  SI_FURC_STRING_MENU_FALL_HIDE_BOOKS = "Cacher quand même les livres",
  SI_FURC_STRING_MENU_FALL_HIDE_BOOKS_TT = "Même lorsque vous filtrez tous les éléments, masquez toujours les livres?",
  SI_FURC_STRING_MENU_FALL_HIDE_CROWN = "Cacher quand même les articles de la Boutique à Couronnes",
  SI_FURC_STRING_MENU_FALL_HIDE_CROWN_TT = "Même lorsque vous filtrez tous les articles, masquez toujours les articles de la boutique?",
  SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR = "Cacher quand même les éléments signalé (Rumeur)",
  SI_FURC_STRING_MENU_FALL_HIDE_RUMOUR_TT = "Même lorsque vous filtrez tous les éléments, masquez toujours les éléments signalé (Rumeur)?",
  SI_FURC_STRING_MENU_FALL_HIDE_UI_BUTTON = "Masquer le bouton de l'UI dans la zone de recherche?",
  SI_FURC_STRING_MENU_FILTERING = "Filtrage de catalogue",
  SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT = "Rechercher des éléments filtrés lors d'une recherche de texte sans jeu de filtres déroulants?",
  SI_FURC_STRING_MENU_FILTER_ALL_ON_TEXT_TT = "Lorsque vous effectuez une recherche de texte sans aucune liste déroulante ",
  SI_FURC_STRING_MENU_FILTER_BOOKS = "Livres de guilde des mages",
  SI_FURC_STRING_MENU_FILTER_BOOKS_N = "Masquer les livres?",
  SI_FURC_STRING_MENU_FILTER_BOOKS_TT = "Un vrai amateur de livres sait où tout est par cœur. Masquer les livres du catalogue de meubles?",
  SI_FURC_STRING_MENU_FONTSIZE = "Taille de polices",
  SI_FURC_STRING_MENU_FONTSIZE_TT = "Ajustez la taille de la police pour FurnitureCatalogue ici",
  SI_FURC_STRING_MENU_F_ALL_ON_TEXT = "Configurer ce filtre",
  SI_FURC_STRING_MENU_HEADER_F_ALL_DESC = "Configurer les paramètres de filtre pour la recherche de texte avec des listes déroulantes désactivées. \nCes paramètres ne prendront effet que si vous n'avez pas défini de filtre de source, de personnage ou de version.",
  SI_FURC_STRING_MENU_HEADER_F_ALL_ON_TEXT = "Paramètres de filtre pour la recherche de texte",
  SI_FURC_STRING_MENU_HEADER_ICONS = "Icônes d'inventaire et de banque",
  SI_FURC_STRING_MENU_HIDE_MENU = "Masquer les entrées de menu?",
  SI_FURC_STRING_MENU_HIDE_MENU_CROWN = "Masquer l'entrée du menu déroulant 'Boutique à Couronnes'?",
  SI_FURC_STRING_MENU_HIDE_MENU_RUMOUR = "Masquer l'entrée déroulante ''Recettes signalé''(Rumeur)?",
  SI_FURC_STRING_MENU_HIDE_MENU_TT = "Masque 'Boutique à couronne' et 'Recettes Signalé (Rumeur)' dans la liste déroulante \nactivée par défaut pour la boutique de la couronne, car il n'y a pas encore d'objets\nNécessite le rechargement de l'interface utilisateur (ne se produira pas automatiquement pour votre commodité)",
  SI_FURC_STRING_MENU_IT_THIS_ONLY = "Seulement pour ce personnage?",
  SI_FURC_STRING_MENU_IT_THIS_ONLY_TT = "Sera à l'échelle du compte autrement.",
  SI_FURC_STRING_MENU_IT_UNKNOWN_NAME = "Ne marquer que les recettes inconnues?",
  SI_FURC_STRING_MENU_LUXURY = "Mobilier de luxe",
  SI_FURC_STRING_MENU_LUXURY_N = "Traitez les articles de luxe comme des objets achetables?",
  SI_FURC_STRING_MENU_LUXURY_TT = "Cela montrera tout ce qui a été vendu par Zanil Theran sous ''achetable''  et désactive le filtre personnalisé",
  SI_FURC_STRING_MENU_LUXURY_WARN = "Le masquage de l'entrée du menu déroulant nécessite le rechargement de l'interface utilisateur (ne se fera pas automatiquement pour votre commodité)",
  SI_FURC_STRING_MENU_RESCAN_RUMOUR_NAME = "Re-scan des (Rumeur)",
  SI_FURC_STRING_MENU_RESCAN_RUMOUR_TT = "Mettra à jour les recettes signalé (Rumeur) par rapport à la liste mise à jour",
  SI_FURC_STRING_MENU_RESET_DB_NAME = "|cFF0000Réinitialiser la base de données",
  SI_FURC_STRING_MENU_RESET_DB_TT = "Cela réinitialisera la base de données de meubles.",
  SI_FURC_STRING_MENU_RESET_DB_WARNING = "Toutes vos données seront réinitialisées. Seule la connaissance des recettes de ce personnage sera prise en compte.",
  SI_FURC_STRING_MENU_RUMOUR = "Recettes signalé (Rumeur)",
  SI_FURC_STRING_MENU_RUMOUR_DESC = "La base de données de meubles contient une liste de recettes que j'ai dataminées.\nCependant, tous n'ont pas été vus dans le jeu.\nActivez cette option pour les exclure des filtres par défaut.\nVous pouvez toujours les afficher avec leur propre filtre, que vous pouvez désactiver ci-dessous.",
  SI_FURC_STRING_MENU_RUMOUR_N = "Masquer les recettes signalé (Rumeur)?",
  SI_FURC_STRING_MENU_SCAN_CHAR_NAME = "Analyser le Personnage",
  SI_FURC_STRING_MENU_SCAN_CHAR_TT = "Exécute une analyse complète de vos recettes de meubles connues et met à jour la base de données en conséquence",
  SI_FURC_STRING_MENU_SCAN_FILES_NAME = "Analyser les fichiers",
  SI_FURC_STRING_MENU_SCAN_FILES_TT = "Exécute une analyse complète des données dans les fichiers du catalogue de meubles",
  SI_FURC_STRING_MENU_SHOWICONONLEFT = "Afficher l'icône Connu / Inconnu à gauche?",
  SI_FURC_STRING_MENU_SHOWICONONLEFT_TT = "Afficher l'icône Coche verte / X rouge à gauche ou à droite de l'élément d'inventaire (nécessite un rechargement)",
  SI_FURC_STRING_MENU_SKIP_INITIALSCAN = "Ignorer l'analyse initiale?",
  SI_FURC_STRING_MENU_SKIP_INITIALSCAN_TT = "Cochez ceci pour ne pas scanner les recettes de votre personnage lors de la connexion. \nGrâce à l'impressionnant LibAsync de votan, le retard a disparu dans tous les cas..",
  SI_FURC_STRING_MENU_STARTSILENT = "Démarrer en silence?",
  SI_FURC_STRING_MENU_STARTSILENT_TT = "Supprimer le message de démarrage",
  SI_FURC_STRING_MENU_TOOLTIP = "Activer les info-bulles?",
  SI_FURC_STRING_MENU_TOOLTIP_COLOR = "Coloriser les info-bulles pour plus de clarté?",
  SI_FURC_STRING_MENU_TOOLTIP_COLOR_TT = "Est-ce que la couleur 'peut' et 'ne peut pas'",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN = "Masquer les éléments connus de l'info-bulle",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_KNOWN_TT = "Masque 'peuvent être fabriquées par ...' dans l'info-bulle",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_MATERIAL = "Masquer les matériaux?",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_SOURCE = "Masquer la source de l'article?",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_STATION = "Masquer la station d'artisanat?",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN = "Masquer si l'élément est inconnu",
  SI_FURC_STRING_MENU_TOOLTIP_HIDE_UNKNOWN_TT = "Masque 'vous ne pouvez pas encore fabriquer ceci'",
  SI_FURC_STRING_MENU_USETINY = "Utilisez une petite interface?",
  SI_FURC_STRING_MENU_USETINY_TT = "Utilisez une interface plus petite (comme Craft Store). \nVous pouvez basculer cela depuis l'interface utilisateur en cliquant sur le bouton +/-.",
  SI_FURC_STRING_RECIPELEARNED = "Recette apprise: <<1>> <<2>> <<3>>",
  SI_FURC_STRING_RECIPESFORCHAR = "Recettes pour <<1>>",
  SI_FURC_STRING_ROLIS = "Vendu par |cd68957Rolis Hlaalu|r <<1>>",
  SI_FURC_STRING_VENDOR = "Vendu par <<1>> à <<2>> (<<3>><<4>>)",
  SI_FURC_STRING_VOUCHER_VENDOR = "Vendu par l'un ou l'autre Rolis Hlaalu ou Faustina Curio",
  SI_FURC_STRING_WASSOLDBY = "A été vendu par <<1>> à <<2>> (<<3>>) <<4>>",
  SI_FURC_STRING_WEEKEND_AROUND = "(autour <<1>>)",
  SI_FURC_TEXTBOX_FILTER_DEFAULT = "Filtrer par recherche de texte",
  SI_FURC_TOGGLE_SHOPPINGLIST = " Basculer la liste de courses",
  SI_FURC_TOMBS = "Tombes et ruines ancestral à Vvardenfell",
  SI_FURC_TRADERS_ALCHEMISTS = "Alchimistes",
  SI_FURC_TRADERS_BLACKSMITHS = "Forgerons",
  SI_FURC_TRADERS_CARPENTERS = "Charpentiers",
  SI_FURC_TRADERS_CLOTHIERS = "Tailleurs",
  SI_FURC_TRADERS_COOKS = "Cuisiniers",
  SI_FURC_TRADERS_ENCHANTERS = "Enchanteurs",
  SI_FURC_TRADERS_FROHILDE = "Frohilde Blanpel",
  SI_FURC_TRADERS_LTS = "Écoute la mer",
  SI_FURC_TRADERS_MULVISE = "Mulvisë Valyn",
  SI_FURC_TRADERS_NARWAAWENDE = "Narwaawendë",
  SI_FURC_TRADERS_OUTLAW = "Refuge hors-la-loi, Marchand",
  SI_FURC_VERBOSE_DB_UPTODATE = "Furniture Catalogue: La base de données est à jour.",
  SI_FURC_VERBOSE_SCANNING_CHARS = "Ne pas analyser les fichiers, scanner la connaissance des personnages maintenant...",
  SI_FURC_VERBOSE_SCANNING_DATA_FILE = "Furniture Catalogue: Analyse des fichiers de données...",
  SI_FURC_VERBOSE_STARTUP = "Furniture Catalogue: Si vous manquez de recettes, veuillez déclencher une analyse de votre artisan de meubles en cliquant sur le bouton Actualiser dans l'UI.",
  SI_FURC_VV_PAINTING = "Extrêmement rarement dans les coffres ou des Cassetes à Vvardenfell ",
  -- 202 ENTRIES THE SAME IN BOTH LANGUAGES
  FURC_AV_LEGERDEMAIN_20 = "Legerdemain Rank 20",
  FURC_AV_RAWLKHA_MARKET = "Reaper's March, Rawl'Kha, Market",
  FURC_AV_RIFTEN_ARMORER = "Riften, Market, Armorer",
  FURC_AV_SENCHAL_MARKET = "Senchal, Marketplace",
  FURC_AV_SHORNHELM_DW = "Rivenspire, Shornhelm, Dead Wolf Inn",
  FURC_AV_SOLITUDE_DH = "Solitude, Dragon's Hearth",
  FURC_AV_VIVEC_GQ = "Vivec City, Gladiator's Quarters",
  FURC_AV_VIVEC_SDI = "Vivec City, Saint Delyn Inn",
  FURC_AV_VULKWAESTEN_TAVERN = "Malabal Tor, Vulkwaesten, tavern",
  FURC_AV_WAYREST_MERCHANT = "Stormhaven, Wayrest, Merchant district",
  FURC_SKYRIM_MASELA = "Masela",
  FURC_SKYRIM_NETINDELL = "Netindell",
  SI_FURC_CRATE_ALLMAKER = "All-Maker",
  SI_FURC_CRATE_ARMIGER = "Buoyant Armiger",
  SI_FURC_CRATE_AYLEID = "Ayleid",
  SI_FURC_CRATE_BAANDARI = "Baandari Pedlar",
  SI_FURC_CRATE_CARNIVALE = "Carnivale",
  SI_FURC_CRATE_CELESTIAL = "Celestial",
  SI_FURC_CRATE_DARK = "Dark Chivalry",
  SI_FURC_CRATE_DB = "Dark Brotherhood",
  SI_FURC_CRATE_DIAMOND = "Diamond Anniversary",
  SI_FURC_CRATE_DRAGONSCALE = "Dragonscale",
  SI_FURC_CRATE_FEATHER = "Unfeathered",
  SI_FURC_CRATE_FROSTY = "Frost Atronach",
  SI_FURC_CRATE_GLOOMSPORE = "Gloomspore",
  SI_FURC_CRATE_HARLEQUIN = "Grim Harlequin",
  SI_FURC_CRATE_HOLLOWJACK = "Hollowjack",
  SI_FURC_CRATE_IRONY = "Iron Atronach",
  SI_FURC_CRATE_LAMP = "Order of the Lamp",
  SI_FURC_CRATE_MIRROR = "Mirrormoor",
  SI_FURC_CRATE_NEWMOON = "New Moon",
  SI_FURC_CRATE_NIGHTFALL = "Nightfall",
  SI_FURC_CRATE_POTENTATE = "Akaviri Potentate",
  SI_FURC_CRATE_PSIJIC = "Psijic",
  SI_FURC_CRATE_RAGE = "Ragebound",
  SI_FURC_CRATE_SCALECALLER = "Scalecaller",
  SI_FURC_CRATE_SOVNGARDE = "Sovngarde",
  SI_FURC_CRATE_STONELORE = "Stonelore",
  SI_FURC_CRATE_SUNKEN = "Sunken Trove",
  SI_FURC_CRATE_WILDHUNT = "Wild Hunt",
  SI_FURC_CRATE_WRAITH = "Wraithtide",
  SI_FURC_CRATE_XANMEER = "Xanmeer",
  SI_FURC_DB_EQUIP = "with equipment",
  SI_FURC_DROP_MURKMIRE = "Random mobs in Murkmire",
  SI_FURC_EVENT_HOLLOWJACK = "Sinister Hollowjack Items",
  SI_FURC_EVENT_IC = "Imperial City Event",
  SI_FURC_FILTER_VERSION_ALTMER = "Summerset",
  SI_FURC_FILTER_VERSION_BASED = "Base Game Patch",
  SI_FURC_FILTER_VERSION_BASED_TT = "When you run out of names",
  SI_FURC_FILTER_VERSION_BLACKW = "Blackwood",
  SI_FURC_FILTER_VERSION_BLACKW_TT = "Mehrunes will never learn",
  SI_FURC_FILTER_VERSION_BRETON = "High Isle",
  SI_FURC_FILTER_VERSION_BRETON_TT = "Here be pirates",
  SI_FURC_FILTER_VERSION_CC = "Clockwork City",
  SI_FURC_FILTER_VERSION_DEADL = "Deadlands",
  SI_FURC_FILTER_VERSION_DEADL_TT = "What is this place with the sparkly meat?",
  SI_FURC_FILTER_VERSION_DEPTHS = "Lost Depths",
  SI_FURC_FILTER_VERSION_DEPTHS_TT = "What the heck is a Pangrit?",
  SI_FURC_FILTER_VERSION_DRAGON = "Dragon Bones",
  SI_FURC_FILTER_VERSION_DRAGON2 = "Dragonhold",
  SI_FURC_FILTER_VERSION_DRUID = "Firesong",
  SI_FURC_FILTER_VERSION_DRUID_TT = "Remember when we could block?",
  SI_FURC_FILTER_VERSION_ENDLESS = "Secrets of the Telvanni",
  SI_FURC_FILTER_VERSION_ENDLESS_TT = "Now with infinite tentacles",
  SI_FURC_FILTER_VERSION_FLAMES = "Flames of Ambition",
  SI_FURC_FILTER_VERSION_FLAMES_TT = "Mildly flammable",
  SI_FURC_FILTER_VERSION_HARROW = "Harrowstorm",
  SI_FURC_FILTER_VERSION_HS = "Homestead",
  SI_FURC_FILTER_VERSION_KITTY = "Elsweyr",
  SI_FURC_FILTER_VERSION_M = "Morrowind",
  SI_FURC_FILTER_VERSION_MARKAT = "Markarth",
  SI_FURC_FILTER_VERSION_MARKAT_TT = "With Dwemer Plumbing",
  SI_FURC_FILTER_VERSION_NECROM = "Necrom",
  SI_FURC_FILTER_VERSION_NECROM_TT = "So many tentacles",
  SI_FURC_FILTER_VERSION_R = "Horns of the Reach",
  SI_FURC_FILTER_VERSION_SCALES = "Scalebreaker",
  SI_FURC_FILTER_VERSION_SCALES_TT = "Fus Ro Dah?",
  SI_FURC_FILTER_VERSION_SCIONS = "Scions of Ithelia",
  SI_FURC_FILTER_VERSION_SCIONS_TT = "Yeah Mr White, Scions!",
  SI_FURC_FILTER_VERSION_SCRIBE = "Scribes of Fate",
  SI_FURC_FILTER_VERSION_SCRIBE_TT = "Books and things",
  SI_FURC_FILTER_VERSION_SKYRIM = "Greymoor",
  SI_FURC_FILTER_VERSION_SLAVES = "Murkmire",
  SI_FURC_FILTER_VERSION_STONET = "Stonethorn",
  SI_FURC_FILTER_VERSION_TIDES = "Ascending Tide",
  SI_FURC_FILTER_VERSION_TIDES_TT = "Redguard. Structural. Furnishings. (Kinda?)",
  SI_FURC_FILTER_VERSION_WEREWOLF = "Wolfhunter",
  SI_FURC_FILTER_VERSION_WOTL = "Wrathstone",
  SI_FURC_FILTER_VERSION_WOTL_TT = "Wrathstone!",
  SI_FURC_GRAMMAR_CONJ_OR = "or",
  SI_FURC_GRAMMAR_ORDER_LOC = "<<1>> <<2>>",
  SI_FURC_GRAMMAR_PREP_LOC_DEFAULT = "in",
  SI_FURC_GRAMMAR_PREP_SRC_DEFAULT = "from",
  SI_FURC_GUILD_FIGHTERS = "the Fighters' guild",
  SI_FURC_GUILD_FIGHTERS_STEWARD = "Hall Steward",
  SI_FURC_GUILD_MAGES = "the Mages' guild",
  SI_FURC_ITEMPACK_ALCHEMIST = "Mad Alchemist",
  SI_FURC_ITEMPACK_AMBITIONS = "Daedric Ambitions",
  SI_FURC_ITEMPACK_AQUATIC = "Aquatic Splendor",
  SI_FURC_ITEMPACK_ASTULA = "Shad Astula Scolars Bundle",
  SI_FURC_ITEMPACK_AYLEID = "Ayleid",
  SI_FURC_ITEMPACK_AZURA = "Daedric Set of Azura",
  SI_FURC_ITEMPACK_COLDHARBOUR = "Coldharbour Arcanaeum",
  SI_FURC_ITEMPACK_COVEN = "Witches' Coven",
  SI_FURC_ITEMPACK_CRAGKNICKS = "Craglorn Multicultural Knick-Knacks",
  SI_FURC_ITEMPACK_DEEPMIRE = "Deepmire Expedition",
  SI_FURC_ITEMPACK_DIBELLA = "Dibella's Garden",
  SI_FURC_ITEMPACK_DWEMER = "Dwemer",
  SI_FURC_ITEMPACK_FARGRAVE = "Fargrave Bazaar",
  SI_FURC_ITEMPACK_FORGE = "Forge-Lord's Great Works",
  SI_FURC_ITEMPACK_HEART = "Heart's Day Retreat",
  SI_FURC_ITEMPACK_HUBTREASURE = "Hubalajad's Final Treasure",
  SI_FURC_ITEMPACK_KHAJIIT = "Khajiiti Life",
  SI_FURC_ITEMPACK_MALACATH = "Malacath's Chosen",
  SI_FURC_ITEMPACK_MAORMER = "Maormer Boarding Party",
  SI_FURC_ITEMPACK_MEPHALA = "Trappings of Mephala Worship",
  SI_FURC_ITEMPACK_MERMAID = "Steam Bath Serenity",
  SI_FURC_ITEMPACK_MOLAG = "Molag Bal",
  SI_FURC_ITEMPACK_MOONBISHOP = "Moon Bishop's Sanctuary",
  SI_FURC_ITEMPACK_NEWLIFE2018 = "New Life Festival",
  SI_FURC_ITEMPACK_OASIS = "Moons-Blessed Oasis",
  SI_FURC_ITEMPACK_SOTHA = "The Clockwork God's Domain",
  SI_FURC_ITEMPACK_SWAMP = "Shadow and Stone",
  SI_FURC_ITEMPACK_TYRANTS = "Tyrants of the Merethic Era",
  SI_FURC_ITEMPACK_VAMPIRE = "Vampiric Libations",
  SI_FURC_ITEMPACK_VIVEC = "Lord Vivec",
  SI_FURC_ITEMPACK_WINDOWS = "Windows of the Divines",
  SI_FURC_ITEMPACK_ZENI = "Chapel of Zenithar",
  SI_FURC_LOC_ANY = "anywhere",
  SI_FURC_LOC_ANY_CITY = "any city",
  SI_FURC_LOC_BANG_EVERMORE = "Bangkorai, Evermore",
  SI_FURC_LOC_BLACKWOOD_LEYAWIIN = "Leyawiin",
  SI_FURC_LOC_CRAGLORN_BELKARTH = "Belkarth",
  SI_FURC_LOC_CWC_CITADEL_MARKET = "The Brass Citadel, Market",
  SI_FURC_LOC_FARGRAVE_FF = "Fargrave, Felicitous Furnishings",
  SI_FURC_LOC_GALEN_VAS = "Vastyr",
  SI_FURC_LOC_GRAHTWOOD_REDFUR = "Grahtwood, Redfur Trading Post",
  SI_FURC_LOC_HIGHISLE_GFB = "Gonfalon Bay",
  SI_FURC_LOC_LILANDRIL = "Lilandril",
  SI_FURC_LOC_MURKMIRE_LIL = "Lilmoth",
  SI_FURC_LOC_PLACE_ORSINIUM = "Orsinium",
  SI_FURC_LOC_SELSWEYR_DHA = "Dragonhold Armoury",
  SI_FURC_LOC_STONEFALLS_EBONHEART = "Ebonheart",
  SI_FURC_LOC_SUMMERSET_ALINOR = "Alinor",
  SI_FURC_LOC_VVARDENFELL_SURAN = "Suran",
  SI_FURC_PART_OF = "Part of item <<1>>",
  SI_FURC_SCAMBOX_GEMS = "Crown Crate Gems",
  SI_FURC_SRC_DROP = "Drops <<1>>",
  SI_FURC_SRC_DROP_DUNG = "Dungeon drop",
  SI_FURC_SRC_MISCHOUSE = "From select house purchases",
  SI_FURC_SRC_QUEST = "Quest",
  SI_FURC_SRC_TOT = "From Tales of Tribute reward coffers",
  SI_FURC_SRC_TOT_RANKED = "From Tales of Tribute ranked matches (system mail reward)",
  SI_FURC_STRING_CONTEXTMENU_INVENTORY = "Disable context menu in inventory?",
  SI_FURC_STRING_CONTEXTMENU_INVENTORY_TT = "Disables the context for inventory items like posting material and adding to favourites.",
  SI_FURC_STRING_MENU_DEBUG_TT = "Only has an effect if a debug logger is enabled",
  SI_FURC_STRING_MENU_TOOLTIP_DATEFORMAT = "Preferred date format",
  SI_FURC_STRING_MENU_TOOLTIP_DATEFORMAT_TT = "Affects luxury furnishing info",
  SI_FURC_STRING_PART_OF_COLL = "part of a collection",
  SI_FURC_STRING_PIECES = "<<1[ / /($d pieces)]>>",
  SI_FURC_STRING_TRADER = "Trader",
  SI_FURC_TELVANNI_NECROM_FRF = "Necrom, Final Rest Furnishings",
  SI_FURC_TRADERS_ADOSA = "Adosa Veralor",
  SI_FURC_TRADERS_ATHRAGOR = "Athragor",
  SI_FURC_TRADERS_AVERIO = "Averio Brassac",
  SI_FURC_TRADERS_BARNABE = "Barnabe Cariveau",
  SI_FURC_TRADERS_BRELDA = "Brelda Ofemalen",
  SI_FURC_TRADERS_DROPSNOGLASS = "Drops-No-Glass",
  SI_FURC_TRADERS_DROPSNOGLASS_COLL = "Drops-No-Glass, Temple Doctrine Collection",
  SI_FURC_TRADERS_HARNWULF = "Harnwulf",
  SI_FURC_TRADERS_HERALDA = "Heralda Garscroft",
  SI_FURC_TRADERS_IDRENIE = "Idrenie Beren",
  SI_FURC_TRADERS_IMPRESS = "Impressario",
  SI_FURC_TRADERS_JERAN = "Jeran Antieve",
  SI_FURC_TRADERS_KRRZTRRB = "Krrztrrb",
  SI_FURC_TRADERS_LATHAHIM = "Lathahim",
  SI_FURC_TRADERS_LLIVAS = "Llivas Driler",
  SI_FURC_TRADERS_LOZOTUSK = "Lozotusk",
  SI_FURC_TRADERS_MALADDIQ = "Maladdiq",
  SI_FURC_TRADERS_MARTINA = "Martina Ocella",
  SI_FURC_TRADERS_MIRASO = "Miraso Marvayn",
  SI_FURC_TRADERS_MIRUZA = "Miruza",
  SI_FURC_TRADERS_MURKHOLG = "Murkholg",
  SI_FURC_TRADERS_MYSTIC = "the Mystic",
  SI_FURC_TRADERS_MYSTIC_COLL = "the Mystic as part of a collection",
  SI_FURC_TRADERS_NALIRSEWEN = "Nalirsewen",
  SI_FURC_TRADERS_NIF = "Nif",
  SI_FURC_TRADERS_ORMAX = "Ormax Lemaitre",
  SI_FURC_TRADERS_RAZOUFA = "Razoufa",
  SI_FURC_TRADERS_RAZOUFA_COLL = "Razoufa as part of a collection",
  SI_FURC_TRADERS_ROHZIKA = "Rohzika",
  SI_FURC_TRADERS_TARMIMN = "Tarmimn",
  SI_FURC_TRADERS_TEZURS = "Filer Tezurs",
  SI_FURC_TRADERS_TIRUDILMO = "Tirudilmo",
  SI_FURC_TRADERS_ULZ = "Ulz",
  SI_FURC_TRADERS_UNDAUNTEDQM = "Undaunted Quartermaster",
  SI_FURC_TRADERS_UNWOTIL = "Unwotil",
  SI_FURC_TRADERS_UZIPA = "Uzipa",
  SI_FURC_TRADERS_VASEI = "Vasei",
  SI_FURC_TRADERS_YATAVA = "Yatava",
  SI_FURC_TRADERS_ZADRASKA = "Zadraska",
  SI_FURC_TRADERS_ZANIL = "Zanil Theran",
  -- 28 LEFTOVER TRANSLATIONS, PLEASE CHECK!
  SI_FURC_DOM_DUNGEON_DROP = "Drops in Depth of Malatar",
  SI_FURC_DUNG_DOM = "Depths of Malatar",
  SI_FURC_DUNG_FL = "Repaire du Croc",
  SI_FURC_DUNG_MHK = "Monster Hunter Keep",
  SI_FURC_DUNG_MOS = "March of the Sacrifices",
  SI_FURC_DUNG_SCP = "Pic de la Mandécailles",
  SI_FURC_LOC_APOCRYPHA = "Apocrypha",
  SI_FURC_LOC_ARTAEUM = "Artaeum",
  SI_FURC_LOC_BALFOYEN = "Bal Foyen^in",
  SI_FURC_LOC_BLACKWOOD = "in Blackwood",
  SI_FURC_LOC_CC = "Clockwork City",
  SI_FURC_LOC_CC_CITADEL_MARKET = "The Brass Citadel, Market",
  SI_FURC_LOC_CRAGLORN = "Craglorn^in",
  SI_FURC_LOC_EASTMARCH = "Eastmarch",
  SI_FURC_LOC_GOLDCOAST = "in the Gold Coast",
  SI_FURC_LOC_HEW = "Hew's Bane^in",
  SI_FURC_LOC_MURKMIRE = "Murkmire^in",
  SI_FURC_LOC_NELSWEYR = "in Northern Elsweyr",
  SI_FURC_LOC_SELSWEYR = "in Southern Elsweyr",
  SI_FURC_LOC_SHADOWFEN = "Shadowfen",
  SI_FURC_LOC_STONEFALLS__EBONHEART = "Stonefalls, Ebonheart",
  SI_FURC_LOC_SUMMERSET = "Summerset^on",
  SI_FURC_LOC_TELVANNI = "in Telvanni Peninsula or Apocrypha",
  SI_FURC_LOC_VVARDENFELL = "on Vvardenfell",
  SI_FURC_LOC_WROTHGAR = "in Wrothgar",
  SI_FURC_LOC_WSKYRIM = "in Western Skyrim",
  SI_FURC_LOOT_HARVEST_WOOD_DUNGEON_DROP = "Trouvez sur les Monstres à Le Fort du Chasseur Lunaire/La Procession des Sacrifiés",
  -- ////// END   : DON'T REMOVE THIS LINE
}

for stringId, stringValue in pairs(strings) do
  ZO_CreateStringId(stringId, stringValue)
  SafeAddVersion(stringId, 1)
end
