local function getCrownStorePriceString(price)
    return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end	

FurC.MiscItemSources[FURC_ALTMER] 	= {
    [FURC_DROP] = {},
    [FURC_RUMOUR] = {
    
        [139265] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fountain, Four-Way Timeworn",
        [139292] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Chalice, Ornate",
        [139171] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Table, Six-fold Symmetry",
        [139113] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Pebbles",
        [139353] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Spire, Bulbous",
        [139149] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Scarlet Fleshfrond",
        [139252] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw Jewelry Box, Verdant Oval",
        [139139] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Nocturnal, Mistress of Shadows",
        [139093] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dwarven Centurion Hammer, Detached",
        [139329] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Heart",
        [139180] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Floor, Ballroom Timeworn",
        [139268] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table, Decorative Marble",
        [139145] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Tower",
        [139212] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Streetlight, Wrought Iron",
        [139110] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Shelf, Large",
        [139275] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Amphora, Embossed",
        
        [139201] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Arched Glass",
        [139296] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Meal, Individual",
        [139116] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Retaining Wall, Long",
        [139255] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw, Octopus",
        [139210] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Brazier, Hanging Coals",
        [139168] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Lighting Globe, Small",
        [139289] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Goblet, Silver Plain",
        [139202] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Lantern",
        [139169] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Table, Scalloped",
        [139343] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Cloud White",
        [139141] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Bed",
        [139229] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Desk, Polished",
        [139178] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bookshelf Wall, Timeworn",
        [139158] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Candelabra, Tall",
        [139270] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table, Noble Intimate",
        [139230] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Desk, Mirrored",
        [139081] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Sea Grapes",
        [139324] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Statue, Kinlord",
        [139282] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pot, Limestone",
        [139135] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Young Poplar",
        [139263] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Fireplace Tools, Wrought Iron",
        [139185] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sarcophagus, Open",
        [139087] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pew, Polished",
        [139065] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail",
        [139161] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Table, Grand Necropolis",
        [139197] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Crenellated",
        [139075] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Sinkhole, Refined",
        [139195] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Archway, Tall",
        [139258] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pot, Hanging Stamped",
        [139366] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fountain, Regal",
        [139391] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Master Craftsman's Banner, Hanging",
        [139257] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw Jewelry Box, Floral",
        [139125] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Blooming Ginkgo",
        [139220] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wardrobe, Polished",
        [139323] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Tapestry, Royal Gryphons",
        
        [139182] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sarcophagus, Wedge",
        [139120] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Young Shade",
        [139215] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Overhang Full",
        [139083] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Glasswort Patch",
        [139196] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Arched",
        [139303] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Display Case, Standing Arched",
        [139209] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Candles, Stand",
        [139157] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Webs, Thick Sheet",
        [139143] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Cluster",
        [139092] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dwarven Engine, Fused",
        [139132] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Sea Grapes",
        [139234] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Winerack, Polished",
        [139117] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Stairway, Natural",
        [139063] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Pearl, Enormous",
        [139280] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Shrine, Limestone",
        [139321] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Tapestry, Alinor Dawn",
        [139350] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pergola, Purple Wisteria Overhang",
        [139227] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Armchair, Polished",
        [139241] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Trunk, Engraved",
        [139208] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Candles, Tall Stand",
        [139299] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bowl, Carved Wood",
        [139119] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Upstretched Shade",
        [139332] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Tree Shelf",
        [139062] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Pearl, Large",
        [139108] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Shelf, Large",
        [139266] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fountain, Timeworn",
        [139312] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Curtains, Tall Drawn",
        [139190] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall, Stone",
        [139146] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Bloom",
        [139243] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Trunk, Spired",
        [139245] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Jewelry Box, Polished",
        [139244] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Jewelry Box, Noble",
        [139362] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Astral Nodule, Small",
        [139221] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bench, Verdant",
        [139097] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Spiral Skein Glowstalks, Sprouts",
        [139261] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Divider, Polished",
        
        [139096] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Urn, Sealed",
        [139186] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Stairway, Timeworn",
        [139253] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw, Sea Monster",
        [139059] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Ivory, Polished",
        
        [139191] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall, Stone Long",
        [139211] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Streetlight, Paired Wrought Iron",
        [139076] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Ancient Road, Refined",
        [139363] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Astral Nodule, Large",
        [139142] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Spikes",
        [139111] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Stones",
        [139333] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Trees Capped",
        [139334] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Tree Capped",
        [139099] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Brazier, Ancestral Tomb",
        [139278] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bowl, Stemmed Limestone",
        [139136] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Twin Poplar",
        [139226] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Chair, Polished",
        [139310] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Windowbox, Purple Wisteria",
        [139194] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fence, Tall Long",
        [139176] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Heavy Timeworn",
        [139331] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Tree Antler",
        [139236] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Counter, Polished Corner",
        [139259] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pot, Patterned",
        [139481] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Jagged Timeworn",
        [139114] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Retaining Wall, Curved",
        [139337] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Ancient Blooming Ginkgo",
        [139137] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tapestry, Nocturnal",
        [139348] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pergola, Purple Wisteria",
        [139199] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Lantern, Stationary",
        [139070] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of College of the Sapiarchs, Refined",
        [139217] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Polished Full",
        [139155] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Food Storage",
        [139098] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Darkshade Glowstalks, Inquisitive",
        [139126] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Ginkgo",
        [139298] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pie Dish, Cherry Pie",
        [139231] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Nightstand, Scalloped",
        [139150] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushrooms, Midnight Cluster",
        [139247] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Jewelry Box, Octagonal",
        [139085] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Pearlwort",
        [139318] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Rug, Alinor Seal",
        [139293] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Chalice, Silver Ornate",
        [139078] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Pillar Polyps",
        [139295] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Platter, Scalloped",
        [139181] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Timeworn",
        [139159] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Chandelier, Gruesome",
        [139060] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Giant Clam, Ancient",
        [139483] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Tumbled Timeworn",
        [139104] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Relief, Serpent",
        [139153] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Dormant",
        [139127] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Hedge, Overgrown",
        [139118] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Wide-Trunked Shade",
        [139090] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table Runner, Cloth of Silver",
        [139166] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Chair, Arched",
        [139198] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Lantern, Hanging",
        [139361] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Kelp, Young",
        [139160] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Armchair, Severe",
        [139260] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Divider, Noble",
        [139172] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Lighting Globe, Large",
        [139287] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Meal, Complete Setting",
        [139084] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Pearlwort Cluster",
        [139340] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Ancient Summerset Spruce",
        [139174] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Table, Grand",
        [139152] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Enormous Empty",
        [139276] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Urn, Bronze",
        [139347] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Yellow Oleander Cluster",
        [139130] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Saplings, Mangrove",
        [139213] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Noble Full",
        [139144] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Spire",
        [139319] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Runner, Royal",
        [140220] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Rumors of the Spiral Skein",
        [139284] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Display Stand, Marble",
        [139203] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Brazier, Standing Coals",
        [139086] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Writing Desk, Noble",
        
        [139311] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Windowbox, Blue Wisteria",
        [139272] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Amphora, Delicate",
        [139207] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Candles Tall",
        [139115] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Retaining Wall, Short",
        [139077] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Bulwark",
        [139480] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Redtop Grass Tuft",
        [139162] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Webs, Cone",
        
        
        [139390] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Cabinet, Noble",
        [139147] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Scarlet Sawleaf",
        [139205] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Candelabra, Wrought Iron",
        [139389] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystal, Crimson Cluster",
        [139188] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall, Stone Corner",
        [139315] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Carpet, Alinor Crescent",
        [139233] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Nightstand, Noble",
        
        [139074] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Aldmeri Ruins, Refined",
        [139251] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw Jewelry Box, Vineyard",
        [139320] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Carpet, Intricate",
        
        
        [139254] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw, Ship",
        [139381] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Evergloam Wispstone",
        [139294] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Plate, Embossed",
        [139242] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Trunk, Noble",
        [139240] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Trunk, Peaked",
        [139224] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Armchair, Noble",
        
        [139095] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Drinking Bowl, Ritual",
        [139274] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Urn, Stemmed",
        
        [139239] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall Mirror, Verdant",
        [139375] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Amphora, Portrait",
        [139376] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Banner, Hanging",
        
        
        
        [139112] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Boulders",
        [139369] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Abyssal Pearl, Sealed",
        [139368] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bathing Robes, Decorative",
        [139200] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Wrought Glass",
        [139367] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Regal Sauna Pool, Two Person",
        [139248] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Figurine, The Sea-Monster's Surprise",
        [139328] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Spire, Branched",
        [139107] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Shelf, Flat",
        
        [139327] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Spire, Sturdy",
        [139357] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Tree Antler",
        [139193] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fence, Tall",
        [139273] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Amphora, Slender",
        [139264] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Fireplace, Ornate",
        [139342] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Vibrant Pink",
        [139358] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Trees Capped",
        [139360] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Kelp, Cluster",
        [139356] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Waving Hands",
        [139355] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Heart",
        [139109] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Shelf, Curved",
        [139354] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Spire, Branched",
        [139290] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Chalice, Delicate",
        [139082] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Ruby Glasswort Patch",
        [139352] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Tomb, Ornate",
        [139351] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Monument, Marble",
        [139349] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pergola, Blue Wisteria Peaked",
        [139072] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Monastery of Serene Harmony, Refined",
        [139336] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Trees, Shade Interwoven",
        [139134] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Seagrapes",
        [139345] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail Cluster",
        [139344] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Hummingbird Mint Cluster",
        [139256] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Scrimshaw, Ancient Vessel",
        [139306] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Potted Plant, Perpetual Bloom",
        [139322] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Tapestry, Alinor Dusk",
        [139297] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bread Basket, Wrought Iron",
        [139359] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Tree Capped",
        [139262] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Fireplace Grate, Wrought Iron",
        [139341] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Towering Poplar",
        [139269] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table, Noble Grand",
        [139192] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Post, Tall Fence",
        [139071] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of High Elf Tower, Refined",
        [139128] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Hedge, Overgrown Long",
        [139279] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Urn, Limestone Large",
        [139338] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Vines, Sun-Bronzed Ivy Swath",
        [139106] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Briarheart, Corpse Blue",
        [139129] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Young Mangrove",
        [139091] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Ancestor Clock, Celestial",
        [139364] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Neural Tree, Active",
        
        [139219] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bookshelf, Polished",
        [139325] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Statue, Orator",
        [139317] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Carpet, Vibrant",
        [139148] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushroom, Nettlecap",
        [139316] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Carpet, Verdant",
        [139314] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Drapes, Noble",
        [139103] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Display Case, Sealed",
        [139218] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Noble Single",
        [139313] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Curtains, Drawn",
        [139067] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flower, Yellow Oleander",
        [139177] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Pedestal, Timeworn",
        [139238] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall Mirror, Ornate",
        [139232] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Nightstand, Octagonal",
        [139228] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Armchair, Backless Polished",
        [139173] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Banner, Large",
        [139154] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoons, Dormant Cluster",
        [139308] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Potted Plant, Double Tiered",
        [139079] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Fan Cluster",
        [139225] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Armchair, Overhang",
        [139305] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Display Case, Large",
        [139304] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Display Case, Specimen",
        [139183] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sarcophagus, Peaked",
        [139069] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Gryphon Nest, Elegant",
        [139167] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Table, Small",
        [139301] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Display Case, Standing",
        [139222] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Armchair, Backless Verdant",
        [139138] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Banner, Nocturnal",
        [139249] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Figurine, The Taming of the Gryphon",
        [139133] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Young Sea Grapes",
        [139237] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall Mirror, Noble",
        [139216] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Polished Single",
        [139283] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Display Stand, Marble Wide",
        [139089] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table Runner, Coiled",
        [139365] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Lighting Globe, Framed",
        [139309] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Potted Plant, Twin Saplings",
        [139170] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Banner",
        [139291] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Goblet, Silver Stamped",
        [139156] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Skeleton",
        [139094] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Altar, Peryite",
        [139286] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table Setting, Complete",
        [139100] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Ash Garden, Familial",
        [139285] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Wall Shrine, Marble",
        [139650] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Bushes, Ivy Cluster",
        [139123] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Summerset Spruce",
        [139179] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Slender Timeworn",
        [139102] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Spire, Large",
        [139482] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Column, Huge Timeworn",
        [139184] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Plinth, Sarcophagus",
        [139277] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bowl, Shallow Limestone",
        [139330] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Waving Hands",
        [139151] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushrooms, Shadowpalm Cluster",
        [139121] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Growing Shade",
        [139339] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Vines, Sun-Bronzed Ivy Climber",
        [139267] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table, Round Marble",
        [139187] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Stairway, Timeworn Wide",
        [139235] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Counter, Polished Drawers",
        [139105] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Grinding Stones, Nirncrux",
        [139307] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Potted Plant, Triple Tiered",
        [139101] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Cluster, Large",
        [139061] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Giant Clam, Sealed",
        [139068] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Springwheeze",
        [139288] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Goblet, Simple",
        [139223] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bench, Marble",
        [139073] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Summerset Coast, Refined",
        [139131] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Solitary Mangrove",
        [139066] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Redtop Grass",
        [139250] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Figurine, The Fish and the Unicorn",
        [139246] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Jewelry Box, Peaked",
        [139080] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Ancient Pillar Polyps",
        [139064] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Hummingbird Mint",
        [139214] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bed, Canopy Full",
        
        [139271] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Urn, Gilded",
        [139346] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail Patch",
        [139300] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Bowl, Millet",
        [139175] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Archway, Timeworn",
        [139281] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Shrine,  Limestone Raised",
        [139140] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Spray",
        [139204] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Brazier, Noble",
        [139206] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Sconce, Candles",
        [139335] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Shade Ancient",
        [139088] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Table Runner, Verdant",
        
        [139189] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- High Elf Post, Stone Wall",
        [139163] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mephala, The Webspinner",
        [139124] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Summerset Spruce",
    },
        
    [FURC_JUSTICE] 	= {},
    [FURC_CROWN] 	= {
      [140220] = GetString(SI_FURC_ITEMSOURCE_ITEMPACK) .. "'Trappings of Mephala Worship'"    
    }
}

FurC.EventItems[FURC_ALTMER] = {}

FurC.AchievementVendors[FURC_ALTMER] = {

    [GetString(FURC_AV_ALI)] = {
		[GetString(FURC_AV_UNW)] = {
			[139122] = { -- Bush, Summerset Spruce
				itemPrice 	= 100, 
			},	
			[139107] = { -- Coral Shelf, Flat
				itemPrice 	= 100, 
			},	
			[139108] = { --  Coral Shelf, Large
				itemPrice 	= 250, 
			},	
			[139127] = { -- Hedge, Overgrown
				itemPrice 	= 100, 
			},	
			[139128] = { -- Hedge, Overgrown long
				itemPrice 	= 100,
			},
			[139112] = { -- Limestone Border, Boulders 
				itemPrice 	= 100,
			},
			[139113] = { -- Limestone Border, Pebbles 
				itemPrice 	= 100,
			},
			[139111] = { -- Limestone Border, Stones 
				itemPrice 	= 100,
			},
			[139114] = { -- Limestone Retaining Wall, Curved
				itemPrice 	= 100,
			},	
			[139116] = { -- Limestone Retaining Wall, Long
				itemPrice 	= 100,
			},	
			[139115] = { -- Limestone Retaining Wall, Short
				itemPrice 	= 100,
			},	
			[139109] = { -- Limestone Shelf, Curved
				itemPrice 	= 100,
			},	
			[139110] = { -- Limestone Shelf, Large
				itemPrice 	= 250,
			},	
			[139117] = { -- Limestone Stairway, Natural
				itemPrice 	= 100,
			},	
			[139126] = { -- Sapling, Gingko
				itemPrice 	= 100,
			},
			[139121] = { -- Sapling, Growing Shade 
				itemPrice 	= 100,
			},
			[139132] = { -- Sapling, Sea Grapes
				itemPrice 	= 100,
			},
			[139124] = { -- Sapling, Summerset Spruce
				itemPrice 	= 100,
			},
			[139120] = { -- Sapling, Young Shade
				itemPrice 	= 100,
			},
			[139130] = { -- Saplings, Mangrove 
				itemPrice 	= 100,
			},
			[139125] = { -- Tree, Blooming Gingko
				itemPrice 	= 2000,
			},
			[139131] = { -- Tree, Solitary Mangrove
				itemPrice 	= 250,
			},
			[139134] = { -- Tree, Seagrapes
				itemPrice 	= 100,
			},
			[139136] = { -- Tree, Twin Poplar
				itemPrice 	= 100,
			},
			[139123] = { -- Tree, Summerset Spruce
				itemPrice 	= 250,
			},
			[139119] = { -- Tree, Upstretched Shade
				itemPrice 	= 250,
			},
			[139118] = { -- Tree, Wide-Trunked Shade
				itemPrice 	= 250,
			},
			[139129] = { -- Tree, Young Mangrove
				itemPrice 	= 100,
			},
			[139135] = { -- Tree, Young Poplar 
				itemPrice 	= 100,
			},
			[139133] = { -- Tree, Young Sea Grapes
				itemPrice 	= 100,
			},
        },	
    
        [GetString(FURC_AV_TAR)] = {
            [139369] = { -- Abyssal Pearl, Sealed
                itemPrice 	= 75000, 
                achievement = 2101, -- Back to the Abyss
            },	
            [139388] = { -- Banner of the House of Reveries, Hanging 
                itemPrice 	= 10000, 
                achievement = "Manor of Masques", -- 
            },	
            [139377] = { -- Banner of the Sapiarchs, Hanging 
                itemPrice 	= 10000, 
                achievement = 2204, -- Resolute Guardian
            },	
            [139393] = { -- Cloudrest Banner, hanging
                itemPrice 	= 10000, 
                achievement = 2131, -- Cloudrest Completed
            },	
            [139379] = { -- Coral Formation, Luminescent
                itemPrice 	= 15000, 
                achievement = 2202, -- Precious Pearl
            },	
            [139380] = { -- Crystal Tower Key, Replica
                itemPrice 	= 150000, 
                achievement = 2208, -- What Must Be Done
            },	
            [139371] = { -- Crystal Tower Stand
                itemPrice 	= 50000, 
                achievement = 2193, -- Savior of Summerset
            },	 
            [139386] = { -- Direnni Banner, Hanging
                itemPrice 	= 10000, 
                achievement = "Lauriel's Lament", -- 
            },	
            [139302] = { -- Display Case, Exhibit 
                itemPrice 	= 25000, 
                achievement = 2203, -- Mind Games
            },	
            [139374] = { -- Enchanted Text, Illusory Forest
                itemPrice 	= 100000, 
                achievement = 2209, -- Summerset Grand Adventurer
            },	
            [139381] = { -- Evergloam Wispstone
                itemPrice 	= 75000, 
                achievement = 2207, -- Enemy of my enemy
            },	
            [139326] = { -- High Elf Statue, Kinlady
                itemPrice 	= 20000, 
                achievement = 2204, -- Resolute Guardian
            },	
            [139373] = { -- High Elf Wine Press, Display
                itemPrice 	= 50000, 
                achievement = 2007, -- Summerset Cave Delver
            },
            [139387] = { -- Lillandril Banner 
                itemPrice 	= 10000, 
                achievement = "Murder in Lilandril", 
            },
            [139372] = { -- Mind Trap Kelp, Adult 
                itemPrice 	= 20000, 
                achievement = 2203, -- Mind Games
            },
            [139383] = { -- Psijic Control Globe, Inactive 
                itemPrice 	= 50000, 
                achievement = 2206, -- Unreliable Narrator
            },
            [139370] = { -- Replica of the Transparent Law 
                itemPrice 	= 100000, 
                achievement = 2193, -- Saviour of Summerset
            },
            [139378] = { -- Shimmerene Banner, Hanging 
                itemPrice 	= 10000, 
                achievement = 2194, -- The Good of Many
            },
            [139446] = { -- Spiral Skein Coral, Brittle-Vein 
                itemPrice 	= 10000, 
                achievement = 2008, -- Summerset Pathfinder
            },
            [139382] = { -- Spiral Skein Coral, Elkhorn 
                itemPrice 	= 1000, 
                achievement = 2205, -- Sweet Dreams
            },
            [139392] = { -- Sunhold Banner, Hanging 
                itemPrice 	= 10000, 
                achievement = 2095, -- Sunhold Group Event
            },
            [139385] = { -- The Keeper's Oath 
                itemPrice 	= 75000, 
                achievement = 2099, -- Relics of Summerset
            },
            [139384] = { -- Waterfall, Small Everlasting 
                itemPrice 	= 75000, 
                achievement = 2197, -- Divine Magistrate
            },
        },
    },	
    
}

FurC.Books[FURC_ALTMER] = {}

FurC.Recipes[FURC_ALTMER] = {
    139573, --Sketch: Figurine, the Fish and the Unicorn
    139571, --Sketch: Figurine, the Sea-Monster's Surprise
    139572, --Sketch: Figurine, the Taming of the Gryphon
    139486, --Sketch: High Elf Ancestor Clock, Celestial
    139613, --Sketch: High Elf Chalice, Delicate 
    139615, --Sketch: High Elf Chalice, Ornate
    139616, --Sketch: High Elf Goblet, Silver Ornate
    139612, --Sketch: High Elf Goblet, Silver Plain
    139614, --Sketch: High Elf Goblet, Silver Stamped 
    139611, --Sketch: High Elf Goblet, Simple
    139257, --Sketch: Scrimshaw Jewelery Box, Floral 
    139252, --Sketch: Scrimshaw Jewelery Box, Verdant Oval 
    139251, --Sketch: Scrimshaw Jewelery Box, Vineyard
    139256, --Sketch: Scrimshaw, Ancient Vessel
    139255, --Sketch: Scrimshaw, Octopus
    139253, --Sketch: Scrimshaw, Sea Monster
    139254, --Sketch: Scrimshaw, Ship
    
    139514, -- Praxis: High Elf Wall, Stone Long",
    139546, -- Praxis: High Elf Bench, Marble",
    139556, -- Blueprint: High Elf Nightstand, Noble",
    139538, -- Blueprint: High Elf Bed, Overhang Full",
    139640, -- Pattern: High Elf Rug, Alinor Seal",
    139524, -- Diagram: High Elf Sconce, Arched Glass",
    139565, -- Blueprint: High Elf Trunk, Noble",
    139540, -- Blueprint: High Elf Bed, Polished Full",
    139550, -- Blueprint: High Elf Armchair, Polished",
    139631, -- Praxis: High Elf Potted Plant, Twin Saplings",
    139512, -- Praxis: High Elf Post, Stone Wall",
    139511, -- Praxis: High Elf Wall, Stone Corner",
    139609, -- Diagram: High Elf Table Setting, Complete",
    139536, -- Blueprint: High Elf Bed, Noble Full",
    139585, -- Diagram: Fireplace Grate, Wrought Iron",
    139604, -- Praxis: High Elf Shrine,  Limestone Raised",
    139575, -- Sketch: Scrimshaw Jewelry Box, Verdant Oval",
    139588, -- Praxis: High Elf Fountain, Four-Way Timeworn",
    139608, -- Praxis: High Elf Wall Shrine, Marble",
    139569, -- Blueprint: High Elf Jewelry Box, Peaked",
    139541, -- Blueprint: High Elf Bed, Noble Single",
    139601, -- Praxis: High Elf Bowl, Stemmed Limestone",
    139574, -- Sketch: Scrimshaw Jewelry Box, Vineyard",
    139579, -- Sketch: Scrimshaw, Ancient Vessel",
    139548, -- Blueprint: High Elf Armchair, Overhang",
    139632, -- Praxis: High Elf Windowbox, Purple Wisteria",
    139587, -- Praxis: High Elf Fireplace, Ornate",
    139577, -- Sketch: Scrimshaw, Ship",
    139582, -- Diagram: High Elf Pot, Patterned",
    139486, -- Sketch: High Elf Ancestor Clock, Celestial",
    139581, -- Diagram: High Elf Pot, Hanging Stamped",
    139558, -- Blueprint: High Elf Counter, Polished Drawers",
    139622, -- Blueprint: High Elf Bowl, Carved Wood",
    139498, -- Praxis: High Elf Archway, Timeworn",
    139593, -- Blueprint: High Elf Table, Noble Intimate",
    139637, -- Pattern: High Elf Carpet, Alinor Crescent",
    139634, -- Pattern: High Elf Curtains, Tall Drawn",
    139534, -- Diagram: High Elf Streetlight, Paired Wrought Iron",
    139503, -- Praxis: High Elf Floor, Ballroom Timeworn",
    139544, -- Blueprint: High Elf Bench, Verdant",
    139649, -- Blueprint: High Elf Cabinet, Noble",
    139559, -- Blueprint: High Elf Counter, Polished Corner",
    139490, -- Blueprint: Psijic Table, Small",
    139520, -- Diagram: High Elf Sconce, Crenellated",
    139487, -- Praxis: Book Row, Levitating",
    139485, -- Blueprint: High Elf Pew, Polished",
    139647, -- Praxis: High Elf Statue, Orator",
    139603, -- Praxis: High Elf Shrine, Limestone",
    139529, -- Diagram: High Elf Sconce, Candles",
    139532, -- Blueprint: High Elf Candles, Stand",
    139494, -- Praxis: Psijic Table, Six-fold Symmetry",
    139525, -- Diagram: High Elf Sconce, Lantern",
    139627, -- Blueprint: Display Case, Large",
    139516, -- Praxis: High Elf Fence, Tall",
    139572, -- Sketch: Figurine, The Taming of the Gryphon",
    139557, -- Blueprint: High Elf Winerack, Polished",
    139617, -- Diagram: High Elf Plate, Embossed",
    139518, -- Praxis: High Elf Archway, Tall",
    139630, -- Praxis: High Elf Potted Plant, Double Tiered",
    139620, -- Diagram: High Elf Bread Basket, Wrought Iron",
    139613, -- Sketch: High Elf Chalice, Delicate",
    139519, -- Diagram: High Elf Sconce, Arched",
    139505, -- Praxis: High Elf Sarcophagus, Wedge",
    139545, -- Blueprint: High Elf Armchair, Backless Verdant",
    139586, -- Diagram: Fireplace Tools, Wrought Iron",
    139506, -- Praxis: High Elf Sarcophagus, Peaked",
    139497, -- Praxis: Psijic Table, Grand",
    139642, -- Pattern: High Elf Carpet, Intricate",
    139625, -- Blueprint: Display Case, Standing Arched",
    139612, -- Sketch: High Elf Goblet, Silver Plain",
    139598, -- Design: High Elf Amphora, Embossed",
    139507, -- Praxis: High Elf Plinth, Sarcophagus",
    139599, -- Diagram: High Elf Urn, Bronze",
    139638, -- Pattern: High Elf Carpet, Verdant",
    139583, -- Blueprint: High Elf Divider, Noble",
    139639, -- Pattern: High Elf Carpet, Vibrant",
    139619, -- Design: High Elf Meal, Individual",
    139614, -- Sketch: High Elf Goblet, Silver Stamped",
    139495, -- Praxis: Psijic Lighting Globe, Large",
    139646, -- Praxis: High Elf Statue, Kinlord",
    139645, -- Pattern: High Elf Tapestry, Royal Gryphons",
    139595, -- Design: High Elf Amphora, Delicate",
    139542, -- Blueprint: High Elf Bookshelf, Polished",
    139644, -- Pattern: High Elf Tapestry, Alinor Dusk",
    139643, -- Pattern: High Elf Tapestry, Alinor Dawn",
    139571, -- Sketch: Figurine, The Sea-Monster's Surprise",
    139530, -- Diagram: High Elf Sconce, Candles Tall",
    139605, -- Praxis: High Elf Pot, Limestone",
    139566, -- Blueprint: High Elf Trunk, Spired",
    139624, -- Blueprint: Display Case, Standing",
    139513, -- Praxis: High Elf Wall, Stone",
    139635, -- Pattern: High Elf Curtains, Drawn",
    139539, -- Blueprint: High Elf Bed, Polished Single",
    139567, -- Blueprint: High Elf Jewelry Box, Noble",
    139629, -- Praxis: High Elf Potted Plant, Triple Tiered",
    139628, -- Praxis: High Elf Potted Plant, Perpetual Bloom",
    139626, -- Blueprint: Display Case, Specimen",
    139636, -- Pattern: High Elf Drapes, Noble",
    139543, -- Blueprint: High Elf Wardrobe, Polished",
    139493, -- Pattern: Psijic Banner",
    139623, -- Design: High Elf Bowl, Millet",
    139584, -- Blueprint: High Elf Divider, Polished",
    139510, -- Praxis: High Elf Stairway, Timeworn Wide",
    139488, -- Praxis: Book Stack, Levitating",
    139621, -- Design: High Elf Pie Dish, Cherry Pie",
    139618, -- Diagram: High Elf Platter, Scalloped",
    139564, -- Blueprint: High Elf Trunk, Engraved",
    139526, -- Diagram: High Elf Brazier, Standing Coals",
    139501, -- Praxis: High Elf Bookshelf Wall, Timeworn",
    139535, -- Diagram: High Elf Streetlight, Wrought Iron",
    139615, -- Sketch: High Elf Chalice, Ornate",
    139537, -- Blueprint: High Elf Bed, Canopy Full",
    139533, -- Diagram: High Elf Brazier, Hanging Coals",
    139492, -- Praxis: Psijic Table, Scalloped",
    139594, -- Design: High Elf Urn, Gilded",
    139528, -- Diagram: High Elf Candelabra, Wrought Iron",
    139633, -- Praxis: High Elf Windowbox, Blue Wisteria",
    139531, -- Blueprint: High Elf Candles, Tall Stand",
    139504, -- Praxis: High Elf Column, Timeworn",
    139641, -- Pattern: High Elf Runner, Royal",
    139611, -- Sketch: High Elf Goblet, Simple",
    139610, -- Design: High Elf Meal, Complete Setting",
    139554, -- Blueprint: High Elf Nightstand, Scalloped",
    139551, -- Blueprint: High Elf Armchair, Backless Polished",
    139521, -- Diagram: High Elf Lantern, Hanging",
    139499, -- Praxis: High Elf Column, Heavy Timeworn",
    139607, -- Praxis: High Elf Display Stand, Marble",
    139500, -- Praxis: High Elf Pedestal, Timeworn",
    139606, -- Praxis: High Elf Display Stand, Marble Wide",
    139527, -- Diagram: High Elf Brazier, Noble",
    139602, -- Praxis: High Elf Urn, Limestone Large",
    139547, -- Blueprint: High Elf Armchair, Noble",
    139508, -- Praxis: High Elf Sarcophagus, Open",
    139573, -- Sketch: Figurine, The Fish and the Unicorn",
    139553, -- Blueprint: High Elf Desk, Mirrored",
    139597, -- Design: High Elf Urn, Stemmed",
    139517, -- Praxis: High Elf Fence, Tall Long",
    139491, -- Praxis: Psijic Lighting Globe, Small",
    139489, -- Blueprint: Psijic Chair, Arched",
    139596, -- Design: High Elf Amphora, Slender",
    139600, -- Praxis: High Elf Bowl, Shallow Limestone",
    139509, -- Praxis: High Elf Stairway, Timeworn",
    139515, -- Praxis: High Elf Post, Tall Fence",
    139591, -- Praxis: High Elf Table, Decorative Marble",
    139590, -- Praxis: High Elf Table, Round Marble",
    139589, -- Praxis: High Elf Fountain, Timeworn",
    139592, -- Blueprint: High Elf Table, Noble Grand",
    139552, -- Blueprint: High Elf Desk, Polished",
    139578, -- Sketch: Scrimshaw, Octopus",
    139580, -- Sketch: Scrimshaw Jewelry Box, Floral",
    139549, -- Blueprint: High Elf Chair, Polished",
    139496, -- Pattern: Psijic Banner, Large",
    139576, -- Sketch: Scrimshaw, Sea Monster",
    139502, -- Praxis: High Elf Column, Slender Timeworn",
    139568, -- Blueprint: High Elf Jewelry Box, Polished",
    139523, -- Diagram: High Elf Sconce, Wrought Glass",
    139616, -- Sketch: High Elf Goblet, Silver Ornate",
    139563, -- Blueprint: High Elf Trunk, Peaked",
    139522, -- Diagram: High Elf Lantern, Stationary",
    139555, -- Blueprint: High Elf Nightstand, Octagonal",
    139570, -- Blueprint: High Elf Jewelry Box, Octagonal",
    139648, -- Design: High Elf Amphora, Portrait",
    139484, -- Blueprint: High Elf Writing Desk, Noble",
    
    
}

FurC.LuxuryFurnisher = FurC.LuxuryFurnisher or {}
FurC.LuxuryFurnisher[FURC_ALTMER] = {

}


FurC.Faustina[FURC_ALTMER] = {
    [139391] = 10, -- Master Craftsman's Banner, Hanging
	[137870] = 125, -- Basic Jewelry Crafting Station
}