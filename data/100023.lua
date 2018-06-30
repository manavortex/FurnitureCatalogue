local function getCrownStorePriceString(price)
    return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end

FurC.MiscItemSources[FURC_ALTMER] = FurC.MiscItemSources[FURC_ALTMER] or {}
FurC.MiscItemSources[FURC_ALTMER][FURC_RUMOUR] = {  
    
    [139093] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dwarven Centurion Hammer, Detached
    
    [139095] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Drinking Bowl, Ritual
    [139096] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Daedric Urn, Sealed        
    
    [139098] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Darkshade Glowstalks, Inquisitive
    [139099] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Brazier, Ancestral Tomb
    [139100] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Dark Elf Ash Garden, Familial     
    
    [139101] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Cluster, Large
    [139102] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Blue Crystal Spire, Large
    
    [139103] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Display Case, Sealed
    [139104] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Craglorn Relief, Serpent
    
    [139105] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Grinding Stones, Nirncrux        
    [139106] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Reach Briarheart, Corpse Blue
    
    [139137] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Tapestry, Nocturnal
    [139138] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Banner, Nocturnal
    [139139] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Nocturnal, Mistress of Shadows
    
    [139147] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plants, Scarlet Sawleaf
    [139149] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Plant, Scarlet Fleshfrond        
 
    [139351] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Monument, Marble
    
    [139366] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Alinor Fountain, Regal        
    [139367] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Regal Sauna Pool, Two Person
    
    [139369] = GetString(SI_FURC_ITEMSOURCE_UNKNOWN_YET), -- Abyssal Pearl, Sealed
        
}

FurC.EventItems[FURC_ALTMER] = {}


FurC.Books[FURC_ALTMER] = {}



