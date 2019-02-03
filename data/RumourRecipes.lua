FurC.RumourRecipes = {  
  121198, -- Formula: Shelf, Poison
  119441, -- Design: Steak, Display
  119442, -- Diagram: Teapot, Common
  121208, -- Praxis: Orcish Table with Furs
  121210, -- Praxis: Orcish Throne, Skull
  121212, -- Praxis: Orcish Effigy, Bear
  121213, -- Diagram: Orcish Skull Goblet, Empty
  119454, -- Blueprint: Plaque, Large
  119455, -- Blueprint: Plaque, Standard
  119466, -- Blueprint: Podium, Engraved
  119437, -- Design: Pie, Display
  121161, -- Design: Ram Horns, Mounted
  121216, -- Blueprint: Redguard Divider, Gilded
  121203, -- Praxis: Khajiit Brazier, Enchanted
  121217, -- Formula: Redguard Lamp, Oil
  121215, -- Pattern: Redguard Canopy, Dusk
  119426, -- Design: Bread, Plain
  121102, -- Design: Chicken Dinner, Display
  121103, -- Design: Chicken Meal, Display
  119426, -- Bread, Plain
  119448, -- Minecart, Empty
  119449, -- Minecart, Push
  119450, -- Knife, Carving
  121100, -- Common Stewpot, Hanging
  119428, -- Common Bowl, Serving
  121201, -- Sack of Beans
  121101, -- Sack of Millet
  121111, -- Simple Red Banner
  121110, -- Simple Purple Banner
  121109, -- Simple Gray Banner
  121108, -- Simple Brown Banner
  119355, -- Garlic String, Display
  121203, -- Khajiit Brazier, Enchanted
  121091, -- Stool, Carved
  119447, -- Candles, Lasting 
}
local function getCrownStorePriceString(price)
    return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end


FurC.MiscItemSources[FURC_ALTMER] = FurC.MiscItemSources[FURC_ALTMER] or {}
FurC.MiscItemSources[FURC_ALTMER][FURC_RUMOUR] = {  
    
    [139137] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Tapestry, Nocturnal
    [139138] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Banner, Nocturnal
    [139139] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Nocturnal, Mistress of Shadows
    
    [139147] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Plants, Scarlet Sawleaf
    [139149] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Plant, Scarlet Fleshfrond        
 
    [139351] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Alinor Monument, Marble
    
    [139366] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Alinor Fountain, Regal        
    [139367] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Regal Sauna Pool, Two Person
    
    [139369] = GetString(SI_FURC_DATAMINED_UNCLEAR), -- Abyssal Pearl, Sealed
        
}
 
-- Removed with Murkmire Live Release, RIP
-- [126154] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Azura with Moon and Star
-- [126155] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Lord Vivec, Warrior-Poet
-- [126156] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Clavicus Vile, Unmasked
 

