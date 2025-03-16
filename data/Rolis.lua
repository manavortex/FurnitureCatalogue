FurC.Rolis = FurC.Rolis or {}
FurC.RolisRecipes = FurC.RolisRecipes or {}

FurC.Faustina = FurC.Faustina or {}
FurC.FaustinaRecipes = FurC.FaustinaRecipes or {}

local ver = FurC.Constants.Versioning

FurC.Faustina[ver.FALLBAN] = {
  [212567] = 125, -- Sketch: Guardian Key, Replica
  [212566] = 125, -- Praxis: Ayleid Sconce, Winged Floor
  [212565] = 125, -- Diagram: Ayleid Window, Turquoise Glass
  [212564] = 125, -- Formula: Dawnwood Hut, Partial
  [212563] = 125, -- Design: Colovian Grape Vat, Large
  [212562] = 125, -- Blueprint: Colovian Wine Press
  [212561] = 125, -- Pattern: Wood Elf Tent, Saplings
}

FurC.Faustina[ver.BASE43] = {
  [211039] = 125, -- Blueprint: Colovian Keg, Gigantic Wine
  [211037] = 125, -- Sketch: Colovian Mirror, Standing
}

-- 28 Secrets of the Telvanni
FurC.Faustina[ver.ENDLESS] = {
  [203556] = 1500, -- Grandmaster Jewelry Station
  [203555] = 1500, -- Grandmaster Blacksmithing Station
  [203553] = 1500, -- Grandmaster Clothing Station
  [203554] = 1500, -- Grandmaster Woodworking Station
}

-- 18 Flames of Ambition
FurC.RolisRecipes[ver.FLAMES] = {
  [171803] = 125, -- Blueprint: Solitude Well, Noble
  [171806] = 125, -- Design: Provisioning Station, Solitude Grill
  [171801] = 125, -- Diagram: Dwarven Minecart, Ornate
  [171805] = 125, -- Formula: Vampiric Cauldron, Distilled Coagulant
  [171802] = 125, -- Pattern: Solitude Yarn Rack, Colorful
  [171804] = 125, -- Praxis: Solitude Hearth, Rounded Tall
  [171807] = 125, -- Sketch: Dwarven Crystal Sconce, Mirror
}

-- 14 Harrowstorm
FurC.FaustinaRecipes[ver.HARROW] = {
  [159501] = 125, -- Praxis: Khajiit Sigil, Moon Cycle
  [159499] = 125, -- Pattern: Elsweyr Bed, Senche-Raht
  [159502] = 125, -- Formula: Elsweyr Mortar and Pestle, Engraved
  [159498] = 125, -- Diagram: Elsweyr Gong, Ornate
  [159503] = 125, -- Design: Elsweyr Bread Basket, Feast-Day
  [159500] = 125, -- Blueprint: Elsweyr Well, Covered
}

-- 10 Wrathstone
FurC.RolisRecipes[ver.WOTL] = {
  [147656] = 125, -- Dark Elf Tent, Canopy,
  [147657] = 125, -- Hlaalu Stove, Chiminea,
  [147651] = 125, -- Silver Kettle, Masterworked,
  [147652] = 125, -- Frog-Caller, Untuned,
  [147653] = 125, -- Pottery Wheel, Ever-Turning,
  [147654] = 125, -- Alchemical Apparatus, Condens
  [147655] = 125, -- Hlaalu Salt Lamp, Enchanted,
}

-- 6 Dragon Bones
FurC.FaustinaRecipes[ver.DRAGONS] = {
  [141904] = 100, -- Blueprint: Alinor Bookshelf, Grand Full,
  [141905] = 100, -- Praxis: Alinor Gaming Table, Punctilious Conflict,
  [141906] = 100, -- Formula: Artist's Palette, Pigment,
  [141907] = 100, -- Design: Alinor Grape Stomping Tub,
  [141901] = 100, -- Pattern: Psijic Banner, Long,
  [141903] = 100, -- Pattern: Alinor Bed, Levitating,
  [141902] = 100, -- Schematic: Relic Vault, Impenetrable,
}

-- 6 Dragon Bones
FurC.FaustinaRecipes[ver.DRAGONS] = {
  [121200] = 100, -- Blueprint: Cabinet, Poisonmaker's
  [121166] = 100, -- Blueprint: Podium, Skinning
  [132195] = 100, -- Blueprint: Telvanni Candelabra, Masterwork
  [121168] = 100, -- Blueprint: Tools, Case
  [132194] = 100, -- Design: Mammoth Cheese, Mastercrafted
  [121199] = 100, -- Design: Mortar and Pestle
  [121214] = 100, -- Design: Orcish Skull Goblet, Full
  [121163] = 100, -- Diagram: Apparatus, Boiler
  [121165] = 100, -- Diagram: Apparatus, Gem Calipers
  [132191] = 100, -- Diagram: Dwarven Gyroscope, Masterwork
  [121197] = 100, -- Formula: Bottle, Poison Elixir
  [121164] = 100, -- Formula: Case of Vials
  [132190] = 100, -- Formula: Mages Apparatus, Master
  [132192] = 100, -- Pattern: Dres Sewing Kit, Master's
  [121209] = 100, -- Pattern: Orcish Tapestry, Spear
  [132193] = 100, -- Praxis: Hlaalu Bath Tub, Masterwork
  [121207] = 100, -- Praxis: Orcish Table with Fur
  [134982] = 100, -- Formula: Alchemical Apparatus, Master
  [134985] = 100, -- Praxis: Hlaalu Trinket Box, Curious Turtle
  [134987] = 100, -- Blueprint: Hlaalu Gaming Table, "Foxes & Felines"
  [134986] = 100, -- Design: Miniature Garden, Bottled
  [134983] = 100, -- Diagram: Hlaalu Gong
  [134984] = 100, -- Pattern: Clothier's Form, Brass
  [139486] = 100, -- Sketch: High Elf Ancestor Clock, Celestial
}

-- 6 Dragon Bones
FurC.Faustina[ver.DRAGONS] = {
  [134675] = 500, -- Outfit station
  [137870] = 125, -- Jewelry Station
  [137947] = 250, -- Attunable Jewelry Station
  [139391] = 10, -- Master Crafter's Banner, Hanging,
}

-- 6 Dragon Bones
FurC.Rolis[ver.DRAGONS] = {
  [133576] = 1250,
}

-- 2 Homestead
FurC.Rolis[ver.HOMESTEAD] = {
  -- Alchemy station
  [118328] = 35,
  -- Blacksmithing station
  [119781] = 35,
  -- Clothing station
  [119707] = 35,
  -- Dye Station
  [118329] = 35,
  -- Enchanting station
  [118330] = 35,
  -- Provisioning station
  [118327] = 35,
  -- Woodworking station
  [119744] = 35,

  -- Attunable Blacksmithing station
  [119594] = 250,
  -- Attunable Clothing station
  [119821] = 250,
  -- Attunable Woodworking station
  [119822] = 250,
}

-- 2 Homestead
FurC.RolisRecipes[ver.HOMESTEAD] = {
  [126582] = 275, -- Praxis: Target Centurion, Dwarf-Brass
  [126583] = 450, -- Praxis: Target Centurion, Robust Refabricated
  [119592] = 125, -- Praxis: Target Skeleton, Humanoid
  [121315] = 200, -- Praxis: Target Skeleton, Robust Humanoid
}
