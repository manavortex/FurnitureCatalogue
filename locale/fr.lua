local strings = {
  -- ////// START : DON'T REMOVE THIS LINE
  SI_FURC_ADD_FAVE = " Ajouter un favori",
  SI_FURC_DATAMINED_UNCLEAR = "Cet élément a été confirmé comme existant, mais son origine n'est pas encore connue.",
  SI_FURC_DB = "Le vendeur de fournitures de la Confrérie noire les distribue ",
  SI_FURC_DB_POISON = "Avec du poison ",
  SI_FURC_DB_STEALTH = "Comme moyen d'être moins voyant ",
  SI_FURC_DEBUG_CHARSCANCOMPLETE = "Furniture Catalogue: Analyse des caractères terminée...",
  SI_FURC_DIALOGUE_RESET_DB_BODY = "Cela recréera la base de données de FurnitureCatalogue à partir de zéro",
  SI_FURC_DIALOGUE_RESET_DB_HEADER = "Recréez la base de données de meubles?",
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
  SI_FURC_GUILD_THIEVES_MERCH = "Refuge hors-la-loi, Marchand",
  SI_FURC_HOUSE = "À partir d'un achat meublé de <<1>>",
  SI_FURC_LABEL_ENTRIES = " entrées -",
  SI_FURC_LOC_ANY_CAPITAL = "N'importe quelle capitale",
  SI_FURC_LOC_SUMMERSET_ALINOR_RIVERSIDE = "Alinor, Marché de la Rivière",
  SI_FURC_LOOT_HARVEST = "Des nœuds de récolte ",
  SI_FURC_LOOT_HARVEST_WOOD = "Parfois trouvé dans les nœuds de bois ",
  SI_FURC_MENU_HEADER = "- |cD3B830Meubles|r:",
  SI_FURC_NPC_AUTOMATON = "Des automates ",
  SI_FURC_PLUGIN_SL_ADD_FIVE = " Ajouter 5 à la liste de courses",
  SI_FURC_PLUGIN_SL_ADD_ONE = " Ajouter 1 à la liste de courses",
  SI_FURC_POST_ITEM = " Publier l'article",
  SI_FURC_POST_ITEMSOURCE = " Publier la source de l'article",
  SI_FURC_POST_MATERIAL = " Publier le Matériel",
  SI_FURC_POST_RECIPE = " Publier la recette",
  SI_FURC_REMOVE_FAVE = " Supprimer le favori",
  SI_FURC_REQUIRES_ACHIEVEMENT = ", A besoin ",
  SI_FURC_SEEN_IN_GUILDSTORE = "Vu dans le magasin de guilde",
  SI_FURC_SHOW_CROWN_TT = "Cacher la boutique à couronne. Cliquez pour montrer.",
  SI_FURC_SHOW_RUMOUR_TT = "Articles confirmés uniquement. Cliquez pour afficher les éléments signalé (Rumeur).",
  SI_FURC_SRC_CHESTS = "Des Cassetes",
  SI_FURC_SRC_CROWNSTORE = "Boutique à Couronnes ",
  SI_FURC_SRC_EMPTY = "Source de l'article inconnue.\nEssayez de réanalyser les fichiers (bouton d'actualisation clic droit).\nSi toujours inconnu après, veuillez envoyer un e-mail avec le lien de l'article et -source à @BerylBones",
  SI_FURC_SRC_FISH = "Peut être pêché ",
  SI_FURC_SRC_HARVEST = "De la récolte des plantes ",
  SI_FURC_SRC_ITEMPACK = "Fait partie du pack d'objets de la Boutique à Couronnes [<<1>>] ",
  SI_FURC_SRC_LVLUP = "Peut être gagné comme récompense de niveau supérieur",
  SI_FURC_SRC_PICK = "Peut être volé à la tire ",
  SI_FURC_SRC_QUEST = "Quest",
  SI_FURC_SRC_RUMOUR_ITEM = "Cet objet a été dataminé, mais pas vu dans le jeu",
  SI_FURC_SRC_RUMOUR_RECIPE = "Cette recette a été dataminée, mais pas vue dans le jeu",
  SI_FURC_SRC_SAFEBOX = "Extrêmement rarement dans les Cassetes",
  SI_FURC_SRC_SCRYING = "A partir des Pistes ",
  SI_FURC_SRC_STEAL = "Peut être volé ",
  SI_FURC_STRING_CANNOT_CRAFT = "Vous ne pouvez pas encore créer cela",
  SI_FURC_STRING_CONTEXTMENU_DIVIDER = "N'utilisez pas le diviseur dans le menu contextuel?",
  SI_FURC_STRING_CONTEXTMENU_DIVIDER_TT = "Ajoute un séparateur au menu contextuel au-dessus de l'entrée - Meubles. Cochez pour désactiver",
  SI_FURC_STRING_CRAFTABLE_BY = "Peut être fabriqué par ",
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
  SI_FURC_STRING_WEEKEND_AROUND = "(autour <<1>>)",
  SI_FURC_TEXTBOX_FILTER_DEFAULT = "Filtrer par recherche de texte",
  SI_FURC_TOGGLE_SHOPPINGLIST = " Basculer la liste de courses",
  SI_FURC_TOMBS = "Tombes et ruines ancestral à Vvardenfell",
  SI_FURC_TRADERS_ALCHEMISTS = "Alchimistes",
  SI_FURC_TRADERS_BGF = "battlegrounds furnishers^P,from",
  SI_FURC_TRADERS_BLACKSMITHS = "Forgerons",
  SI_FURC_TRADERS_CAF = "Main Achievement Furnisher^n,from",
  SI_FURC_TRADERS_CARPENTERS = "Charpentiers",
  SI_FURC_TRADERS_CLOTHIERS = "Tailleurs",
  SI_FURC_TRADERS_COOKS = "Cuisiniers",
  SI_FURC_TRADERS_ENCHANTERS = "Enchanteurs",
  SI_FURC_TRADERS_EVENT = "Impressario",
  SI_FURC_TRADERS_LUXF = "Zanil Theran",
  SI_FURC_VERBOSE_DB_UPTODATE = "Furniture Catalogue: La base de données est à jour.",
  SI_FURC_VERBOSE_SCANNING_CHARS = "Ne pas analyser les fichiers, scanner la connaissance des personnages maintenant...",
  SI_FURC_VERBOSE_SCANNING_DATA_FILE = "Furniture Catalogue: Analyse des fichiers de données...",
  SI_FURC_VERBOSE_STARTUP = "Furniture Catalogue: Si vous manquez de recettes, veuillez déclencher une analyse de votre artisan de meubles en cliquant sur le bouton Actualiser dans l'UI.",
  -- 59 LEFTOVER TRANSLATIONS, PLEASE CHECK!
  SI_FURC_CHEST_VV = "Extrêmement rarement dans les coffres à Vvardenfell",
  SI_FURC_CRATE_FIREATRO = "Atronach de Flamme ",
  SI_FURC_CRATE_REAPER = "de la Moisson de la Faucheuse",
  SI_FURC_DAEDRA_SOURCE = "Des Daedra et Coffres des Dolmen ",
  SI_FURC_DAILY_ASH = "Récompenses des quêtes quotidiennes d'Ashlander au Camp d'Ald’ruhn ",
  SI_FURC_DAILY_ELSWEYR = "Récompenses des quêtes quotidiennes d'Elsweyr ",
  SI_FURC_DROP = "Cet article se ramasse ",
  SI_FURC_DROP_ALTMER = "Cet article se ramasse à Summerset ",
  SI_FURC_ELF_PIC = "Tombe rarement dans les coffres au trésor à Summerset",
  SI_FURC_GEYSER = "Ramasser dans les palourdes et récompense de geyser à Summerset",
  SI_FURC_GIANT_CLAM = "Ramasser dans les palourdes géantes et récompense de geyser à Summerset",
  SI_FURC_GRAMMAR_OBTAINABLE = "Peut être acquis pendant <<1>> (<<2>>)",
  SI_FURC_PLUNDERSKULL = "Ramasser dans les Crânes, pendant le festival des sorcières ",
  SI_FURC_PSIJIC_RANK = "Rang De l'ordre Psijique ",
  SI_FURC_QUESTREWARD = "Récompense pour une quête en ",
  SI_FURC_SCAMBOX = "Caisses à Couronne ",
  SI_FURC_SLAVES_DAILY = "Des boîtes de récompense de la préquête de Murkmire",
  SI_FURC_STRING_FOR_VOUCHERS = "Pour <<1>> Assignats",
  SI_FURC_STRING_VENDOR = "Vendu par <<1>> à <<2>> (<<3>><<4>>)",
  SI_FURC_STRING_VOUCHER_VENDOR = "Vendu par l'un ou l'autre Rolis Hlaalu ou Faustina Curio",
  SI_FURC_STRING_WASSOLDBY = "A été vendu par <<1>> à <<2>> (<<3>>) <<4>>",
  SI_FURC_VV_PAINTING = "Extrêmement rarement dans les coffres ou des Cassetes à Vvardenfell ",
  -- ////// END   : DON'T REMOVE THIS LINE
}

for stringId, stringValue in pairs(strings) do
  ZO_CreateStringId(stringId, stringValue)
  SafeAddVersion(stringId, 1)
end
