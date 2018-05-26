local function getCrownStorePriceString(price)
    return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end

FurC.MiscItemSources[FURC_ALTMER] 	= {
    [FURC_DROP] = {
        [139292] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Alinor Chalice, Ornate
        [139290] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Alinor Chalice, Delicate
        [139110] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Limestone Shelf, Large
        [139109] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Limestone Shelf, Curved
        [139117] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Limestone Stairway, Natural
        [139113] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Pebbles
        [139065] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail
        [139083] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Plants, Glasswort Patch
        [139132] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Sea Grapes
        [139063] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Pearl, Enormous
        [139062] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Pearl, Large
        [139119] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Tree, Upstretched Shade
        [139237] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Alinor Wall Mirror, Noble
        [139146] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Bloom
        [139145] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Tower
        [139077] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Bulwark
        [139059] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Ivory, Polished
        [139076] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Painting of Ancient Road, Refined
        [139333] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Trees Capped
        [139334] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Tree Capped
        [139136] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Tree, Twin Poplar
        [139157] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Webs, Thick Sheet
        [139162] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Webs, Cone
        [139163] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Mephala, The Webspinner
        [139070] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Painting of College of the Sapiarchs, Refined
        [139126] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Ginkgo
        [139067] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Flower, Yellow Oleander
        [139082] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Plants, Ruby Glasswort Patch
        [139068] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Plants, Springwheeze    
        [139073] = GetString(SI_FURC_EXISITING_ITEMSOURCE_UNKNOWN_YET), -- Painting of Summerset Coast, Refined
        
    }
    [FURC_RUMOUR] = {

        [139353] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Spire, Bulbous
        [139149] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Scarlet Fleshfrond
        [139139] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Nocturnal, Mistress of Shadows
        [139093] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dwarven Centurion Hammer, Detached
        [139329] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Heart
        [139145] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Tower
        [139201] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Sconce, Arched Glass
        [139343] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Cloud White
        [139141] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Bed
        [139158] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Candelabra, Tall
        [139135] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Young Poplar        
        [139161] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Table, Grand Necropolis
        [139075] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Sinkhole, Refined
        [139366] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Fountain, Regal        
        [139125] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Blooming Ginkgo
        [139120] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sapling, Young Shade
        [139103] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Display Case, Sealed
        [139143] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Cluster
        [139092] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dwarven Engine, Fused        
        [139369] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Abyssal Pearl, Sealed
        [139350] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Pergola, Purple Wisteria Overhang
        [139145] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Tower
        [139141] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Bed
        [139143] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Cluste
        [139142] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Spikes
        [139144] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Midnight Spire
        [139140] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystals, Crimson Spray
        [139362] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Astral Nodule, Small
        [139097] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Spiral Skein Glowstalks, Sprouts
        [140220] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Rumors of the Spiral Skein
        [139363] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Astral Nodule, Large
        [139364] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Sload Neural Tree, Active
        [139096] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Urn, Sealed
        [139111] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Stones
        [139099] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Brazier, Ancestral Tomb
        [139293] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Chalice, Silver Ornate
        [139331] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Tree Antler
        [139389] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Crystal, Crimson Cluster
        [139481] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Column, Jagged Timeworn
        [139483] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Column, Tumbled Timeworn
        [139482] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Column, Huge Timeworn
        [139337] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Ancient Blooming Ginkgo
        [139137] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tapestry, Nocturnal
        [139348] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Pergola, Purple Wisteria
        [139155] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Food Storage
        [139153] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Dormant
        [139152] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Enormous Empty
        [139154] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoons, Dormant Cluster
        [139156] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Cocoon, Skeleton
        [139098] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Darkshade Glowstalks, Inquisitive
        [139069] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Gryphon Nest, Elegant
        [139078] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Pillar Polyps
        [139150] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushrooms, Midnight Cluster  
        [139159] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Chandelier, Gruesome
        [139104] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Relief, Serpent
        [139361] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Kelp, Young
        [139357] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Tree Antler
        [139358] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Trees Capped
        [139360] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Kelp, Cluster
        [139356] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Waving Hands
        [139355] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Heart
        [139354] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Spire, Branched
        [139365] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Psijic Lighting Globe, Framed
        [139089] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Table Runner, Coiled
        [139090] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Table Runner, Cloth of Silver
        [139088] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Table Runner, Verdant
        [139160] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Armchair, Severe
        [139203] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Brazier, Standing Coals
        [139095] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Drinking Bowl, Ritual
        [139376] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Banner, Hanging
        [139112] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Limestone Border, Boulders
        [139368] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Bathing Robes, Decorative
        [139367] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Regal Sauna Pool, Two Person
        [139340] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Ancient Summerset Spruce
        [139480] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Redtop Grass Tuft
        [139066] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Redtop Grass
        [139328] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Spire, Branched
        [139327] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Spire, Sturdy
        [139352] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Tomb, Ornate
        [139351] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Monument, Marble
        [139359] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mind Trap Coral Formation, Tree Capped
        [139347] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Yellow Oleander Cluster        
        [139147] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Scarlet Sawleaf
        [139349] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Pergola, Blue Wisteria Peaked
        [139342] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Vibrant Pink
        [139074] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Aldmeri Ruins, Refined
        [139072] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Monastery of Serene Harmony, Refined
        [139336] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Trees, Shade Interwoven
        [139134] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Seagrapes
        [139345] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail Cluster
        [139344] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Hummingbird Mint Cluster
        [139071] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Painting of Alinor Tower, Refined
        [139341] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Towering Poplar        
        [139338] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Vines, Sun-Bronzed Ivy Swath
        [139106] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Briarheart, Corpse Blue
        [139148] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushroom, Nettlecap        
        [139138] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Banner, Nocturnal
        [139094] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Altar, Peryite
        [139100] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Ash Garden, Familial        
        [139650] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Bushes, Ivy Cluster
        [139102] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Spire, Large        
        [139330] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Coral Formation, Waving Hands        
        [139151] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Mushrooms, Shadowpalm Cluster
        [139339] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Vines, Sun-Bronzed Ivy Climber
        [139105] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Grinding Stones, Nirncrux        
        [139101] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Cluster, Large
        [139061] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Giant Clam, Sealed            
        [139064] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Hummingbird Mint
        [139346] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Flowers, Lizard Tail Patch
        [139335] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tree, Shade Ancient
    }
    [FURC_JUSTICE] 	= {}
    [FURC_CROWN] 	= {
      [140220] = GetString(SI_FURC_ITEMSOURCE_ITEMPACK) .. "'Trappings of Mephala Worship'"
    }
}

FurC.EventItems[FURC_ALTMER] = {}


FurC.Books[FURC_ALTMER] = {}



