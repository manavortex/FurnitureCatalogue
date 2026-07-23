FurC.Fishing = FurC.Fishing or {}

local ver = FurC.Constants.Versioning
local src = FurC.Constants.ItemSources
local loc = FurC.Constants.Locations

local strGeneric = FurC.Utils.FmtGeneric

local srcFish = GetString(SI_FURC_SRC_FISH)

-- Furnishings obtained via fishing
local fishing = strGeneric(srcFish)
local fishing_summerset = strGeneric(srcFish, nil, nil, loc.SUMMERSET)
local fishing_swamp = strGeneric(srcFish, nil, "loc", loc.MURKMIRE)
local fishing_solstice = strGeneric(srcFish, nil, nil, loc.SOLSTICE)

-- Seasons of the Worm Cult Part 2
FurC.Fishing[ver.WORMS2] = {
  [src.FISHING] = {
    [223162] = fishing_solstice, -- Kelp Shelf, Small Brown
    [223163] = fishing_solstice, -- Kelp Shelf, Medium Brown
    [223164] = fishing_solstice, -- Kelp, Small Brown Pile
    [223165] = fishing_solstice, -- Kelp, Long Brown Pile
    [223167] = fishing_solstice, -- Argonian Paddle, Wooden
    [223166] = fishing_solstice, -- Knife, Fishing
  },
}

-- Seasons of the Worm Cult // Solstice
FurC.Fishing[ver.WORMS] = {
  [src.FISHING] = {
    [214461] = fishing_solstice, -- Shrimp, Display
    [214460] = fishing_solstice, -- Seahorse, Display
    [214459] = fishing_solstice, -- Oyster, Display
    [214458] = fishing_solstice, -- Mussel, Display
    [214457] = fishing_solstice, -- Lobster Claw, Display
    [214456] = fishing_solstice, -- Conch Flute, Ceremonial
    [214463] = fishing_solstice, -- Crab, Display
    [214462] = fishing_solstice, -- Snail, Display
    [214452] = fishing_solstice, -- Solstice Shell, Fossilized Nautilus
    [214453] = fishing_solstice, -- Solstice Shell, Fossilized Turritella
    [214455] = fishing_solstice, -- Solstice Shell, Fossilized Conch
  },
}

-- 8 Murkmire
FurC.Fishing[ver.SLAVES] = {
  [src.FISHING] = {
    [145402] = fishing_swamp, -- Fish, Black Marsh
  },
}

-- 6 Dragon Bones
FurC.Fishing[ver.DRAGONS] = {
  [src.FISHING] = {
    [139082] = fishing_summerset, -- Plants, Ruby Glasswort Patch
    [139080] = fishing_summerset, -- Coral Formation, Ancient Pillar Polyps
    [139079] = fishing_summerset, -- Coral Formation, Fan Cluster
    [139081] = fishing_summerset, -- Plant, Sea Grapes
    [139084] = fishing_summerset, -- Plants, Pearlwort Cluster
    [139085] = fishing_summerset, -- Plant, Pearlwort
    [139077] = fishing_summerset, -- Coral Formation, Bulwark
    [139078] = fishing_summerset, -- Coral Formation, Pillar Polyps
    [139083] = fishing_summerset, -- Plants, Glasswort Patch
  },
}

-- 2 Homestead
FurC.Fishing[ver.HOMESTEAD] = {
  [src.FISHING] = {
    [118902] = fishing, -- Coral, Sun
    [118903] = fishing, -- Coral, Crown
    [118896] = fishing, -- Seashell, Sandcake
    [118901] = fishing, -- Sea sponge
    [118338] = fishing, -- Fish, Bass
    [118339] = fishing, -- Fish, Salmon
    [118337] = fishing, -- Fish, Trout
    [120753] = fishing, -- Kelp, Green Pile
    [120755] = fishing, -- Kelp, Lush Pile
    [120754] = fishing, -- Kelp, Small Pile
    [118897] = fishing, -- Seashell, Pink Scallop
    [118898] = fishing, -- Seashell, White Scallop
    [118899] = fishing, -- Seashell, Starfish
    [118900] = fishing, -- Seashell, Noble Starfish
  },
}