-- use constants because it's a huge performance gain due to how LUA handles strings... at least unless siri lied :P

local FURC_CANBEPICKED_WW    = GetString(SI_FURC_CANBEPICKED) .. " from woodworkers"
local FURC_CANBEPICKED_ASS       = GetString(SI_FURC_CANBEPICKED) .. " from outlaws and assassins"
local FURC_CANBEPICKED_GUARD  = GetString(SI_FURC_CANBEPICKED) .. " from guards"

local FURC_CANBESTOLENINCC     = GetString(SI_FURC_CANBESTOLEN) .. " in Clockwork City"
local FURC_CANBESTOLEN_SCHOLARS = GetString(SI_FURC_CANBESTOLEN) .. " from scholars"
local FURC_CANBESTOLEN_NERDS  = FURC_CANBESTOLEN_SCHOLARS      .. " and mages"
local FURC_CANBESTOLEN_RELIG  = GetString(SI_FURC_CANBESTOLEN) .. " from priests and pilgrims"
local FURC_CANBESTOLEN_THIEF  = GetString(SI_FURC_CANBESTOLEN) .. " from thieves"
local FURC_CANBESTOLEN_WW      = GetString(SI_FURC_CANBESTOLEN) .. " from woodworkers"
local FURC_CANBESTOLEN_DRUNK    = GetString(SI_FURC_CANBESTOLEN) .. " from drunkards"

local FURC_PLANTS_VVARDENFELL   = GetString(FURC_PLANTS)      .. " on Vvardenfell"
local FURC_CANBESTOLEN_WROTHGAR  = GetString(SI_FURC_CANBESTOLEN) .. " in Wrothgar"

local FURC_AUTOMATON_CC      = GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local FURC_AUTOMATON_VV      = GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"

local FURC_HARVEST_CHARBOR    = GetString(SI_FURC_HARVEST) .. " in Coldharbour"

local FURC_SCAMBOX_F_ATRO    = zo_strformat("<<1>> (<<2>>)", GetString(SI_FURC_SCAMBOX), GetString(SI_FURC_FLAME_ATRONACH))
local FURC_SCAMBOX_DWEMER    = zo_strformat("<<1>> (<<2>>)", GetString(SI_FURC_SCAMBOX), GetString(SI_FURC_DWEMER))

local FURC_DB_POISON      = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_POISON))
local FURC_DB_SNEAKY      = zo_strformat("<<1>> <<2>>", GetString(SI_FURC_DB), GetString(SI_FURC_DB_STEALTH))

local onSummerset               = " on Summerset"

local FURC_FISHING_SUMMERSET    = GetString(SI_FURC_CANBEFISHED) .. onSummerset
local FURC_DROP_ALTMER          = GetString(SI_FURC_DROP) .. onSummerset

local function getCrownPrice(price)
  return string.format("%s (%u)", GetString(SI_FURC_CROWNSTORESOURCE), price)
end

local function getHouseString(houseId1, houseId2)
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then houseName = houseName .. ", " .. GetCollectibleName(houseId2) end
  return zo_strformat(GetString(SI_FURC_HOUSE), houseName)
end

FurC.MiscItemSources[FURC_WEREWOLF] = {
  [FURC_DROP] = {
    [141851] = GetString(SI_FURC_WW_DUNGEON_DROP),         -- Bear Skull, Fresh
    [141850] = GetString(SI_FURC_WW_DUNGEON_DROP),       -- Bear Skeleton, Picked Clean
    [141847] = GetString(SI_FURC_WW_DUNGEON_DROP),       -- Animal Bones, Gnawed
    [141848] = GetString(SI_FURC_WW_DUNGEON_DROP),       -- Animal Bones, Jumbled
    [141849] = GetString(SI_FURC_WW_DUNGEON_DROP),       -- Animal Bones, Fresh
	
	
    [141921] = GetString(SI_FURC_SLAVES_PREQUEST),       -- Murkmire Bowl, Geometric Pattern
    
  },
  [FURC_RUMOUR] = {  
    [141832] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Robust Fig
    [141833] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Ancient Fig
    [141834] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Towering Fig
    [141835] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Whorled Fig
    [141836] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Monolith, Lord Hircine Ritual
    [141841] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree Ferns, Cluster
    [141842] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree Ferns, Juvenile Cluster
    [141843] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Plants, Yellow Frond Cluster
    [141844] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Plants, Amber Spadeleaf Cluster
    [141845] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Mushrooms, Climbing Ambershine
    [141846] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Mushrooms, Ambershine Cluster
    
    [141853] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Statue of Hircine's Bitter Mercy
    [141854] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Decorative Hollowjack Flame-Skull
    [141855] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Decorative Hollowjack Wraith-Lantern
    [141856] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Decorative Hollowjack Daedra-Skull
    [141869] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Alinor Potted Plant, Cypress
    [141870] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Raven-Perch Cemetery Wreath
    [141875] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Witches Festival Scarecrow
    [142004] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Specimen Jar, Spare Brain
    [142005] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Specimen Jar, Monstrous Remains
    [141752] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Plant, Cerulean Spadeleaf
    [141753] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Plants, Cerulean Spadeleaf Cluster
    [141754] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Skull Totem, Hircine Worship
    [141755] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Mushrooms, Aether Cup Ring
    [141756] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Mushrooms, Aether Cup Cluster
    [141757] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Mushrooms, Climbing Aether Cup
    [141758] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Orcish Wagon, Merchant
    [141759] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Orcish Gazebo, Orsinium
    [141760] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Witch's Tree, Charred
    [141761] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Reach Sapling, Contorted Briarheart
    [141762] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Animal Trap, Welded Open
    [141763] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Banner, Outfit
    [141764] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Banner, Outfit Small
    [141765] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Banner, Transmute
    [141766] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Banner, Transmute Small
    [141767] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Ayleid Constellation Stele, The Lady
    [141778] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Target Wraith-of-Crows
    [141920] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Brazier, Ceremonial
    [141922] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Dish, Geometric Pattern
    [141923] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Amphora, Seed Pattern
    [141924] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Vase, Scale Pattern
    [141925] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Hearth Shrine, Sithis Relief
    [141926] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Murkmire Hearth Shrine, Sithis Figure
    [142003] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Specimen Jar, Eyes
    [141939] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Grave, Grasping
    [141976] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Pumpkin Patch, Display
    [141967] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Hollowjack Lantern, Ouroboros
    [141966] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Hollowjack Lantern, Toothy Grin
    [141965] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Hollowjack Lantern, Soaring Dragon
    [141816] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Ginkgo
    [141817] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Tree, Ancient Ginkgo
    [141818] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Shrubs, Dormant Sunbird Cluster
    [141819] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Shrub, Blooming Sunbird
    [141768] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Ayleid Constellation Stele, The Lover
    [141769] = GetString(SI_FURC_DATAMINED_UNCLEAR),   -- Ayleid Constellation Stele, The Atronach
    
    [134251] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Coldharbour Bookshelf, Filled
    [134252] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Coldharbour Bookshelf, Black Laboratory      
    [120873] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Coffin
    [120871] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Deadric Vase, Spiked
    [120867] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Pike, Clannfear Head
    [120866] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Brazier, Tabletop
    [120865] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Table
    [120863] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Light Pillar
    
    [120984] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Plant, Goldenrod Cluster
    [120985] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dark Elf Lightpost, Single
    [120987] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dark Elf Lightpost, Capped
    
    [126114] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Azura, Queen of Dawn and Dusk
    [126115] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Azura's Moon
    [126116] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Azura's Sun
    [120997] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner, Tattered Blue
    [126118] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner of Azura
    [130215] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Witches' Cauldron, Provisioning
    [130353] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Sheogorath, the Mad God
    [126128] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- The Five Points of the Star
    [126132] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Resplendent Sweetroll
    [121015] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Shrub, Sparse Green
    [120000] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Broken Chain
    
    [126136] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dwarven Lantern, Powered
    [126138] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- A Guide to Dwemer Mega-Structures
    [126140] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vivec's Grand Bed
    [126141] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vivec's Grand Throne
    [126142] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vivec's Divination Pool
    [126143] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue, Vivec's Triumph
    [126145] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Sigil of Vivec
    [126146] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner, Vivec
    [126149] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tapestry, Vivec
    [126150] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tribunal Tablet of Sotha Sil
    [126154] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Azura with Moon and Star
    [126155] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Lord Vivec, Warrior-Poet
    [126156] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Clavicus Vile, Unmasked
    [126152] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- The Cliff-Strider Song
    [121046] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Cheeses of Tamriel
    [121049] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Parcels, Wrapped
    [134475] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Malacath, Orc-Father
    [131424] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Fogs of the Hag Fen
    
    
    [134686] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Sithis, The Dread Father
    [125480] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner, Clavicus Vile
    [125489] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Brazier, Flaming
    
    [134853] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Peryite, The Taskmaster
    [134854] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tapestry of Peryite
    [134855] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner of Peryite
    [134856] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Skeleton, Mid-Flight
    [134861] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- The History of Zaan The Scalecaller
    
    [134857] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Priest Frieze: Triumph
    [134858] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Priest Frieze: Exodus
    [134859] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Priest Frieze: Restoration
    [134860] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Priest Frieze: Ascension
    
    [134864] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dragon Cranium, Ancient
    [134865] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Unidentified Bones, Gargantuan
    [134866] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Lamia Cranium, Ancient
    [134867] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Argonian Skull, Complete
    [134868] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Khajiit Skull, Complete
    [134869] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Orc Skull, Complete
    [125654] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tapestry, Clavicus Vile
    
    [134871] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Urn, Dragon Crest
    [134873] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Bookshelf, Wide
    [134874] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Bookshelf, Narrow
    [134875] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Funerary Jar, Linked Rings
    [134876] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Funerary Jar, Crimson Sash
    [134877] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Funerary Jar, Dragon Figure
    [134862] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Runestone, Memorial
    [134870] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Chest, Dragon Crest
    [134878] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Nord Funerary Jar, Dragon Crest
    
    [134879] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hubalajad's Reflection
    [134881] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- In Defense of Prince Hubalajad
    [134882] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gold Drakes, Pristine
    
    [134880] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Reliquary, Miniature Palace
    [134883] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Funerary Statue, Stone Cat
    [134884] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Funerary Statue, Gilded Cat
    [134885] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Funerary Statue, Gilded Ibis
    [134886] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Funerary Statue, Gilded Servant
    [134887] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Guardian Statue, Lion Ibis
    [134888] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Guardian Statue, Winged Bull
    [134889] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ra Gada Guardian Statue, Riding Camel
    
    [125680] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vines, Ashen Moss
    [125681] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vines, Volcanic Roses
    
    [134898] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flowers, Midnight Sage
    [134899] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flower Spray, Crimson Daisies
    [134900] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flowers, Red Poppy
    [134901] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flower Spray, Starlight Daisies
    [134902] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flowers, Violet Bellflower
    [134903] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flowers, Midnight Glory
    
    [134961] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dibella's Mysteries and Revelations
    [126771] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Velothi Podium of Illumination
    [126776] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Indoril Tapestry, House
    [126107] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Display Wild Hunt Crown Crate
    [126117] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tapestry of Azura
    [126144] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Vivec
    [125592] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Lavaburster
    [130212] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedra Worship: The Ayleids
    [130228] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- The Witches of Hag Fen
    [130088] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Fragment, Coldharbour
    [134248] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Grand Mnemograph
    [134249] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Sotha Sil, The Clockwork God
    
    [134460] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Riekling Lean-To, Boar Pelt
    [134464] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Riekling Bonfire, Ceremonial
    [130090] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Sconce, Molag Bal
    [121023] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tree, Strong Olive
    [121022] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Bush, Green Forest
    [121016] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Bush, Red Berry
    [121013] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Saplings, Fragile Autumn Birch
    [121010] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tree, Young Green Birch
    [121008] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tree, Autumn Maple
    [121007] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tree, Strong Maple
    
    [121004] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hedge, Solid Arc
    [121000] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Shrub, Trimmed Green
    [120485] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Cactus, Columnar
    [126109] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Display Death Crown Crate
    [126108] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Display Atronach Crown Crate
    [120986] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dark Elf Lightpost, Full
    [132198] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Death Skeleton, Wrapped
    [134823] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Target Mournful Aegis
    [125537] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dwarven Piston Cylinder
    [125532] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dwarven Pipeline, Fan
    [130092] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Molag Bal, Grand
    [120878] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gravestone, Ornamented
    [120875] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gravestone, Clover Engraving
    [120862] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ancient Patriarch Banner
    [120859] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Wall Embellishment
    [120855] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Collected Wanted Poster
    [120854] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Guard Lamppost
    [130093] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Coldharbour Compact
    [134890] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dibella, Lady of Love
  },
  
  [FURC_CROWN] = {
    
    
    [134904] = getCrownPrice(260),  -- Seal of Dibella
    [134905] = getCrownPrice(260),  -- Ritual Stone, Dibella
    [134906] = getCrownPrice(240),  -- Ritual Brazier, Gilded
    [134921] = getCrownPrice(520),  -- Redguard Lamppost, Stone
    [134922] = getCrownPrice(250),  -- Redguard Pillar, Tiered
    [134923] = getCrownPrice(2000),  -- Redguard Trellis, Peaked
    [134924] = getCrownPrice(380),  -- Redguard Fence, Brass Capped
    [134925] = getCrownPrice(2200),  -- Redguard Fountain, Pillar
    [134926] = getCrownPrice(1200),  -- Redguard Awning, Wall
    [134927] = getCrownPrice(1200),  -- Wedding Pergola, Double
    [134928] = getCrownPrice(1200),  -- Wedding Pergola, Triple
    [134929] = getCrownPrice(45),  -- Trees, Savanna Cluster
    [134930] = getCrownPrice(30),  -- Bushes, Swordgrass Cluster
    [134931] = getCrownPrice(50),  -- Boulder, Weathered Desert
    [134932] = getCrownPrice(50),  -- Boulder, Tiered Desert
    [134933] = getCrownPrice(90),  -- Cranium, Jawless
    [134934] = getCrownPrice(10),  -- Rocks, Basalt Chunks
    [134936] = getCrownPrice(110),  -- Cave Deposit, Tall Stalagmite Cluster
    [134938] = getCrownPrice(110),  -- Cave Deposit, Stalagmite Group
    [134945] = getCrownPrice(200),  -- Cave Deposit, Extended Spire
    [134973] = getCrownPrice(200),  -- Cave Deposit, Stalactite Cone Cluster
    [134939] = getCrownPrice(110),  -- Cave Deposit, Stalactite Cone
    [134941] = getCrownPrice(110),  -- Cave Deposit, Spire
    [120603] = getCrownPrice(20),  -- Boulder, Flat Mossy
    [120604] = getCrownPrice(20),  -- Rock, Slanted Mossy
    [120605] = getCrownPrice(20),  -- Rocks, Deep Mossy
    [120606] = getCrownPrice(20),  -- Stones, Mossy Cluster
    [134943] = getCrownPrice(1000),  -- Brotherhood Banner, Long
    [134944] = getCrownPrice(340),  -- Brotherhood Column, Tall Ornate
    [134946] = getCrownPrice(340),  -- Brotherhood Column, Ornate
    [120612] = getCrownPrice(10),  -- Plant, Tall Mammoth Ear
    [120613] = getCrownPrice(10),  -- Plant, Towering Mammoth Ear
    [120614] = getCrownPrice(10),  -- Plant Cluster, Jungle Leaf
    [134951] = getCrownPrice(30),  -- Mushrooms, Assorted Cluster
    [134952] = getCrownPrice(30),  -- Mushrooms, Sporous Browncap
    [134953] = getCrownPrice(340),  -- Brotherhood Carpet, Large Worn
    [139061] = getCrownPrice(20),  -- Giant Clam, Sealed
    [126774] = getCrownPrice(510),  -- Dres Tapestry, House
    [126775] = getCrownPrice(510),  -- Hlaalu Tapestry, House
    [126777] = getCrownPrice(510),  -- Redoran Tapestry, House
    [126778] = getCrownPrice(510),  -- Telvanni Tapestry, House
    [134974] = getCrownPrice(340),  -- Brotherhood Carpet, Worn
    [130069] = getCrownPrice(2000),  -- Daedric Spout, Block
    [130070] = getCrownPrice(2000),  -- Daedric Spout, Arched
    [130201] = getCrownPrice(170),  -- Ayleid Grate, Small
    [130213] = getCrownPrice(430),  -- Ayleid Cage, Hanging
    [130224] = getCrownPrice(180),  -- Reachmen Rug, Smooth Skin
    [126830] = getCrownPrice(10),  -- Mushrooms, Volcanic Cluster
    [120658] = getCrownPrice(70),  -- Tree, Forked Sturdy
    [120631] = getCrownPrice(5),  -- Pebble, Stacked Mossy
    [134326] = getCrownPrice(260),  -- Clockwork Pump, Horizontal
    [134330] = getCrownPrice(490),  -- Clockwork Control Panel, Double
    [134337] = getCrownPrice(1800),  -- Clockwork Somnolostation, Octet
    [134250] = getCrownPrice(750),  -- Fabrication Sphere, Inactive
    [121036] = getCrownPrice(30),  -- Shrub, Sparse Violet
    [121035] = getCrownPrice(30),  -- Plant, Paired Verdant Hosta
    [121034] = getCrownPrice(10),  -- Shrub, Delicate Forest
    [121032] = getCrownPrice(25),  -- Saplings, Young Laurel
    [121031] = getCrownPrice(45),  -- Topiary, Paired Cypress
    [121030] = getCrownPrice(54),  -- Topiary, Young Cypress
    [121029] = getCrownPrice(45),  -- Topiary, Strong Cypress
    [120709] = getCrownPrice(70),  -- Tree, Sturdy Young Birch
    [121026] = getCrownPrice(45),  -- Hedge, Dense High Wall
    [121025] = getCrownPrice(70),  -- Trees, Sprawling Juniper Cluster
    [121024] = getCrownPrice(70),  -- Trees, Paired Leaning Juniper
    [121021] = getCrownPrice(10),  -- Plants, Dry Underbrush
    [121020] = getCrownPrice(10),  -- Plants, Sparse Underbrush
    [121018] = getCrownPrice(10),  -- Plant, Forest Sprig
    [121014] = getCrownPrice(20),  -- Topiary, Sparse
    [121012] = getCrownPrice(70),  -- Trees, Fragile Autumn Birch
    [121009] = getCrownPrice(70),  -- Tree, Young Healthy Birch
    [120726] = getCrownPrice(20),  -- Rock, Jagged Algae Coated
    [120727] = getCrownPrice(5),  -- Stone, Angled Mossy
    [120728] = getCrownPrice(20),  -- Rock, Jagged Lichen
    [121006] = getCrownPrice(45),  -- Flower Patch, Violets
    [120730] = getCrownPrice(45),  -- Topiary, Lush Evergreen
    [120731] = getCrownPrice(25),  -- Tree, Mossy Summer
    [120732] = getCrownPrice(70),  -- Tree, Mossy Forest
    [120733] = getCrownPrice(70),  -- Tree, Gnarled Forest
    [120734] = getCrownPrice(25),  -- Saplings, Squat Desert
    [120735] = getCrownPrice(52),  -- Saplings, Young Desert
    [120736] = getCrownPrice(290),  -- Tree, Gentle Weeping Willow
    [120737] = getCrownPrice(150),  -- Tree, Weeping Willow
    [120738] = getCrownPrice(70),  -- Tree, Towering Willow
    [120743] = getCrownPrice(70),  -- Tree, Strong Cypress
    [120996] = getCrownPrice(120),  -- Banner, Tattered Red
    [120745] = getCrownPrice(60),  -- Tree, Water Palm
    [120483] = getCrownPrice(30),  -- Cactus, Lemon Bulbs
    [120748] = getCrownPrice(70),  -- Tree, Leaning Swamp
    [120749] = getCrownPrice(10),  -- Grass, Tall Bamboo Shoots
    [120750] = getCrownPrice(10),  -- Grass, Drying Bamboo Shoots
    [120751] = getCrownPrice(10),  -- Grass, Twin Bamboo Shoots
    [120752] = getCrownPrice(10),  -- Grass, Young Bamboo Shoots
    [120471] = getCrownPrice(25),  -- Tree, Wilted Palm
    [120756] = getCrownPrice(10),  -- Plant, Palm Fronds
    [120463] = getCrownPrice(20),  -- Boulder, Weathered Flat
    [120456] = getCrownPrice(5),  -- Stone, Smooth Desert
    [134579] = getCrownPrice(5),  -- Rubble Pile, Worked Stone
    [120760] = getCrownPrice(50),  -- Flower, Red Honeysuckle
    [125544] = getCrownPrice(30),  -- Fern, Strong Dusky
    [125547] = getCrownPrice(85),  -- Flower, Healthy Purple Bat Bloom
    [125546] = getCrownPrice(85),  -- Flower Patch, Lava Blooms
    [120765] = getCrownPrice(15),  -- Breton Cup, Empty
    [120766] = getCrownPrice(15),  -- Breton Cup, Full
    [134891] = getCrownPrice(2500),  -- Pergola, Festive Flowers
    [134892] = getCrownPrice(85),  -- Tree, Pale Gold
    [134893] = getCrownPrice(85),  -- Tree, Argent Blue
    [134894] = getCrownPrice(20),  -- Wildflowers, Yellow and Orange
    [134895] = getCrownPrice(1800),  -- Redguard Fountain, Mosaic
    [134896] = getCrownPrice(45),  -- Flower, Lover's Lily
    [134897] = getCrownPrice(45),  -- Vine Curtain, Festive Flowers
    [134942] = getCrownPrice(10),  -- Bushes, Withered Cluster
    [134950] = getCrownPrice(31),  -- Mushrooms, Flapjack Stack
    [139238] = getCrownPrice(190),  -- Alinor Wall Mirror, Ornate
    [139239] = getCrownPrice(190),  -- Alinor Wall Mirror, Verdant
    [139389] = getCrownPrice(200),  -- Crystal, Crimson Cluster
    [139184] = getCrownPrice(200),  -- Alinor Plinth, Sarcophagus
  }
}

local questRewardLilandril = GetString(SI_FURC_QUESTREWARD) .. "Lilandril"
local mephalaItemSet = GetString(SI_FURC_ITEMSOURCE_ITEMPACK) .. "'Trappings of Mephala Worship'"
FurC.MiscItemSources[FURC_ALTMER] = {
  [FURC_CROWN] = {
    [130206] = getCrownPrice(370),               -- Ayleid Apparatus, Welkynd
    [139064] = getCrownPrice(20),               -- Flowers, Hummingbird Mint
    [139065] = getCrownPrice(20),               -- Flowers, Lizard Tail
    [139066] = getCrownPrice(30),               -- Plant, Redtop Grass
    [139067] = getCrownPrice(20),               -- Flower, Yellow Oleander
    [139068] = getCrownPrice(20),               -- Plants, Springwheeze
    
    [139069] = getCrownPrice(410),              -- Painting of Griffin Nest, Refined
    [139070] = getCrownPrice(410),              -- Painting of College of the Sapiarchs, Refined
    [139071] = getCrownPrice(410),              -- Painting of High Elf Tower, Refined
    [139073] = getCrownPrice(410),              -- Painting of Summerset Coast, Refined  
    [139074] = getCrownPrice(410),              -- Painting of Aldmeri Ruins, Refined
    [139075] = getCrownPrice(410),              -- Painting of Sinkhole, Refined
    [139076] = getCrownPrice(410),              -- Painting of Ancient Road, Refined
    
    [139078] = getCrownPrice(20),               -- Coral Formation, Tree Antler
    
    [139083] = getCrownPrice(30),               -- Plants, Grasswort Patch
    
    
    [139088] = getCrownPrice(50),               -- Alinor Table Runner, Verdant
    [139089] = getCrownPrice(50),               -- Alinor Table Runner, Coiled
    [139090] = getCrownPrice(100),              -- Alinor Table Runner, Cloth of Silver
    
    [139097] = mephalaItemSet,                  -- Spiral Skein Glowstalks, Sprouts
    
    [139126] = getCrownPrice(50),               -- Sapling, Ginkgo
    
    [139140] = getCrownPrice(340),              -- Crystals, Crimson Spray
    [139141] = getCrownPrice(310),              -- Crystals, Crimson Bed
    [139142] = getCrownPrice(380),              -- Crystals, Crimson Spikes
    [139143] = getCrownPrice(310),              -- Crystals, Midnight Cluster
    [139144] = getCrownPrice(400),              -- Crystals, Midnight Spire
    [139145] = getCrownPrice(430),              -- Crystals, Midnight Tower
    [139146] = getCrownPrice(490),              -- Crystals, Midnight Bloom
    
    [139147] = getCrownPrice(30),               -- Plants, Scarlet Sawleaf
    [139148] = getCrownPrice(70),               -- Mushroom, Nettlecap
    
    [139150] = getCrownPrice(70),               -- Mushrooms, Midnight Cluster
    [139151] = getCrownPrice(140),              -- Mushrooms, Shadowpalm Cluster
    
    [139152] = getCrownPrice(360),              -- Cocoon, Enormous Empty
    [139153] = getCrownPrice(40),               -- Cocoon, Dormant
    [139154] = getCrownPrice(40),               -- Cocoons, Dormant Cluster
    [139155] = getCrownPrice(80),               -- Cocoon, Food Storage
    [139156] = getCrownPrice(360),              -- Cocoon, Skeleton
    [139157] = getCrownPrice(90),               -- Webs, Thick Sheet
    
    [139158] = getCrownPrice(150),              -- Daedric Candelabra, Tall
    [139159] = getCrownPrice(920),              -- Daedric Chandelier, Gruesome
    [139160] = getCrownPrice(200),              -- Daedric Armchair, Severe
    [139161] = getCrownPrice(1500),             -- Daedric Table, Grand Necropolis
    [139162] = getCrownPrice(140),               -- Webs, Cone
    
    [139198] = getCrownPrice(190),              -- Alinor Lantern, Hanging
    [139199] = getCrownPrice(190),              -- Alinor Lantern, Stationary
    [139201] = getCrownPrice(220),              -- Alinor Sconce, Arched Glass
    [139202] = getCrownPrice(220),              -- Alinor Sconce, Lantern
    [139203] = getCrownPrice(140),              -- Alinor Brazier, Standing Coals
    [139204] = getCrownPrice(260),              -- Alinor Brazier, Noble
    [139205] = getCrownPrice(110),              -- Alinor Candelabra, Wrought Iron
    [139206] = getCrownPrice(25),               -- Alinor Sconce, Candles
    [139207] = getCrownPrice(25),               -- Alinor Sconce, Candles Tall
    [139208] = getCrownPrice(60),               -- Alinor Candles, Tall Stand
    [139209] = getCrownPrice(60),               -- Alinor Candles, Tall
    [139210] = getCrownPrice(140),              -- Alinor Brazier, Hanging Coals
    [139212] = getCrownPrice(410),              -- Alinor Streetlight, Wrought Iron        
    
    [139163] = mephalaItemSet,                  -- Mephala, The Webspinner (statue)
    
    [139293] = getCrownPrice(30),               -- Alinor Chalice, Silver Ornate
    
    [139237] = getCrownPrice(190),              -- Alinor Wall Mirror, Noble
    
    [139329] = getCrownPrice(45),               -- Coral Formation, Heart
    [139330] = getCrownPrice(45),               -- Coral Formation, Waving Hands
    [139331] = getCrownPrice(45),               -- Coral Formation, Tree Antler
    [139332] = getCrownPrice(45),               -- Coral Formation, Tree Shelf
    [139333] = getCrownPrice(45),               -- Coral Formation, Trees Capped
    [139334] = getCrownPrice(20),               -- Coral Formation, Tree Capped (green)
    
    [139335] = getCrownPrice(310),              -- Tree, Shade Ancient
    [139336] = getCrownPrice(90),               -- Trees, Shade Interwoven
    [139337] = getCrownPrice(580),              -- Tree, Ancient Blooming Ginkgo       
    
    [139338] = getCrownPrice(25),               -- Vines, Sun-Bronzed Ivy Swath
    [139339] = getCrownPrice(25),               -- Vines, Sun-Bronzed Ivy Climber
    
    [139340] = getCrownPrice(310),              -- Tree, Ancient Summerset Spruce
    [139341] = getCrownPrice(310),              -- Tree, Towering Poplar        
    [139342] = getCrownPrice(45),               -- Tree, Vibrant Pink
    [139343] = getCrownPrice(45),               -- Tree, Cloud White
    
    [139344] = getCrownPrice(45),               -- Flowers, Hummingbird Mint Cluster
    [139345] = getCrownPrice(45),               -- Flowers, Lizard Tail Cluster
    [139346] = getCrownPrice(45),               -- Flowers, Lizard Tail Patch
    [139347] = getCrownPrice(45),               -- Flowers, Yellow Oleander Cluster
    
    [139348] = getCrownPrice(940),              -- Alinor Pergola, Purple Wisteria
    [139349] = getCrownPrice(940),              -- Alinor Pergola, Blue Wisteria Peaked
    [139350] = getCrownPrice(940),              -- Alinor Pergola, Purple Wisteria Overhang
    
    [139351] = getCrownPrice(200),              -- Alinor Monument, Marble        
    [139352] = getCrownPrice(1000),             -- Alinor Tomb, Ornate       
    
    [139353] = getCrownPrice(340),              -- Mind Trap Coral Spire, Branched
    [139354] = getCrownPrice(340),              -- Mind Trap Coral Spire, Bulbous
    [139355] = getCrownPrice(340),              -- Mind Trap Coral Formation, Heart
    [139356] = getCrownPrice(340),              -- Mind Trap Coral Formation, Waving Hands
    [139357] = getCrownPrice(340),              -- Mind Trap Coral Formation, Tree Antler
    [139358] = getCrownPrice(340),              -- Mind Trap Coral Formation, Tree Capped
    [139359] = getCrownPrice(340),              -- Mind Trap Coral Formation, Trees Capped
    [139360] = getCrownPrice(510),              -- Mind Trap Kelp, Cluster
    [139361] = getCrownPrice(270),              -- Mind Trap Kelp, Young
    
    [139362] = getCrownPrice(340),              -- Sload Astral Nodule, Small
    [139363] = getCrownPrice(340),              -- Sload Astral Nodule, Large
    [139364] = getCrownPrice(1500),             -- Sload Neural Tree, Active
    
    [139365] = getCrownPrice(370),              -- Psijic Lighting Globe, Framed
    
    [139366] = getCrownPrice(2000),             -- Alinor Fountain, Regal        
    [139368] = getCrownPrice(100),              -- Alinor Bathing Robes, Decorative
    
    [139376] = getCrownPrice(260),              -- Alinor Banner, Hanging                    
    
    [139481] = getCrownPrice(200),              -- Alinor Column, Jagged Timeworn
    [139482] = getCrownPrice(200),              -- Alinor Column, Huge Timeworn
    [139483] = getCrownPrice(90),               -- Alinor Column, Tumbled Timeworn
    
    [139480] = getCrownPrice(30),               -- Plants, Redtop Grass Tuft
    [139650] = getCrownPrice(30),               -- Bushes, Ivy Cluster
    
    [140220] = mephalaItemSet,                  -- Rumours of the Spiral Skein
    
    [130071] = getCrownPrice(300),  -- Daedric Torch, Coldharbour",
    [130075] = getCrownPrice(380),  -- Daedric Altar, Molag Bal
    [130078] = getCrownPrice(380),  -- Soul Gem, Single
    [130079] = getCrownPrice(380),  -- Soul Gems, Pile
    [130082] = getCrownPrice(640),  -- Soul-Shriven, Robed
    [130094] = getCrownPrice(170),  -- Daedric Chains, Hanging
    [130095] = getCrownPrice(640),  -- Daedric Torture Device, Chained
    [139327] = getCrownPrice(45),   -- Coral Spire, Sturdy
    [139328] = getCrownPrice(45),   -- Coral Spire, Branched
    [132165] = getCrownPrice(750),  -- Hlaalu Bath Tub, Empty Basin
    [126034] = getCrownPrice(4000),  -- The Lord
    [125451] = getCrownPrice(4000),  -- The Apprentice
    [125452] = getCrownPrice(4000),  -- The Lady
    [125453] = getCrownPrice(4000),  -- The Warrior
    [125454] = getCrownPrice(4000),  -- The Tower
    [125455] = getCrownPrice(4000),  -- The Thief
    [125456] = getCrownPrice(4000),  -- The Steed
    [125457] = getCrownPrice(4000),  -- The Shadow
    [125458] = getCrownPrice(4000),  -- The Serpent
    [125459] = getCrownPrice(4000),  -- The Ritual
    [125460] = getCrownPrice(4000),  -- The Mage
    [125461] = getCrownPrice(4000),  -- The Lover
    [126037] = getCrownPrice(4000),  -- Target Centurion, Lambent
    [126038] = getCrownPrice(4000),  -- Target Centurion, Robust Lambent
    [134247] = getCrownPrice(190),  -- Soul Gem Module, Experimental
    [134263] = getCrownPrice(410),  -- Orcish Throne, Ancient
    [134264] = getCrownPrice(190),  -- Daedric Brazier, Cold-Flame
    [134267] = getCrownPrice(380),  -- Orcish Table, Grand Furs
    [134268] = getCrownPrice(570),  -- Orcish Brazier, Column
    [134269] = getCrownPrice(220),  -- Orcish Dais, Raised
    [134270] = getCrownPrice(85),  -- Cave Deposit, Large Double-Sided
    [134271] = getCrownPrice(85),  -- Cave Deposit, Tall Stalagmite
    [134273] = getCrownPrice(200),  -- Daedric Plinth, Sacrificial
    [134274] = getCrownPrice(200),  -- Coldharbour Crate, Black Soul Gem
    [134275] = getCrownPrice(200),  -- Coldharbour Bin, Black Soul Gem
    [130197] = getCrownPrice(170),  -- Ayleid Bookcase, Filled
    [130199] = getCrownPrice(170),  -- Ayleid Bookshelf, Bare
    
  }, 
  [FURC_DROP] = {
    
    [139059] = GetString(SI_FURC_DROP),         -- Ivory, Polished - drops from Echatere, and probably alot else
    [139066] = GetString(SI_FURC_HARVEST),      -- Plant, Redtop Grass
    
    [139060] = GetString(SI_FURC_GIANT_CLAM),   -- Giant Clam, Ancient
    [139062] = GetString(SI_FURC_GIANT_CLAM),   -- Pearl, Large
    [139063] = GetString(SI_FURC_GIANT_CLAM),   -- Pearl, Enormous
    
    [139073] = questRewardLilandril,            -- Painting of Summerset Coast, Refined
    [139072] = GetString(SI_FURC_ELF_PIC),    	-- Painting of Monastery of Serene Harmony, Refined
	
	 [87709] = GetString(SI_FURC_LEVELUP),		-- Imperial Brazier, Spiked
	 [94098] = GetString(SI_FURC_LEVELUP),		-- Imperial Bed, Single
	
    
  },
  [FURC_FISHING] = {
    [139080] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Ancient Pillar Polyps
    [139079] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Fan Cluster
    [139081] = FURC_FISHING_SUMMERSET,  -- Plant, Sea Grapes  
    [139084] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
    [139085] = FURC_FISHING_SUMMERSET,  -- Plants, Pearlwort Cluster
    [139068] = FURC_FISHING_SUMMERSET,  -- Plants, Springwheeze
    [139077] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Bulwark
    [139078] = FURC_FISHING_SUMMERSET,  -- Coral Formation, Pillar Polyps   
    [139067] = FURC_FISHING_SUMMERSET,   -- Flower, Yellow Oleander
    [139082] = FURC_FISHING_SUMMERSET,   -- Plants, Ruby Glasswort Patch
    [139068] = FURC_FISHING_SUMMERSET,   -- Plants, Springwheeze  
  },
  [FURC_RUMOUR] = {
    [130193] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Robust Target Minotaur Handler
    [130194] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Target Stone Atronach
    [130195] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Target Iron Atronach
    [130189] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tapestry of Sheogorath
    [130190] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner of Sheogorath
    [134287] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Projector TBD
    [130192] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Sheogorath, the Madgod
    [130187] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Hircine, the Huntsman
    [130188] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statuette of Molag Bal, Lord of Brutality
    [134272] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Cave Deposit, Stalagmite Cluster
    [134257] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedra Dossier: Cold-Flame Atronach
    [134258] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Prayer to the Furious One
    [134259] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Malacath, God of Oaths and Curses
    [134260] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Orcish Bas-Relief, Axe
    [134261] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Orcish Bas-Relief, Sword
    [134262] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Orcish Bas-Relief, Spear
    [134255] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Transliminal Rupture
    [134256] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Coldharbour Bookshelf, Filled Pillar
    [134253] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Coldharbour Bookshelf, Filled Wide
    [134254] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Molag Bal
    [132200] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Imperial Well, Akatosh
    [132201] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tree, Kvatch Nut
    [132202] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Rock, Anvil Limestone
    [132203] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Stone, Anvil Limestone
    [132204] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Imperial Statue, Truth
    [132197] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Death Skeleton, Shrouded
    [134246] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- The Law of Gears
    [140297] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Replica Throne of Alinor,
    [120851] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gallows,
    [120852] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Holding Cell,
    [120853] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Stockade,
    [130070] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Spout, Arched,
    [120856] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Sarcophagus
    [120857] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Sarcophagus Lid
    [120858] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Tapestry
    [120860] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Throne
    [120861] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Yokudan Sitting Griffin Statue
    [130080] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Soul Gems, Scattered
    [130081] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Soul-Shriven, Armored
    [130083] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Block, Seat
    [130084] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Tapestry, Molag Bal
    [130085] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Banner, Molag Bal
    [130086] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Pennant, Molag Bal
    [130089] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Brazier, Molag Bal
    [130087] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Shards, Coldharbour
    [120872] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Pike, Daedroth Head
    [120874] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Coffin, Lid
    [130091] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Statue of Molag Bal, God of Schemes
    [120876] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gravestone, Imp Engraving
    [120877] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Gravestone, Cracked
    [120880] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tombstone, Engraved, Decorative
    [120881] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tombstone, Engraved, Order of the Hour
    [120882] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Tombstone, Small
    [132156] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Briarheart Tree, Replica
    [132166] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Death Skeleton, Robed
    [134447] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Bagrakh, Metal
    [134448] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Fharun, Metal
    [134454] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Morkul, Metal
    [134455] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Shatul, Metal
    [134456] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Tumnosh, Metal
    [134449] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Seal of Clan Igrun, Metal
    [134468] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Ayleid Switch, Ancient
    [134474] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Banner, Malacath
  }
} -- Reach
FurC.MiscItemSources[FURC_DRAGONS] = { -- Reach
  [FURC_DROP] = {
    [134909] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushrooms, Puspocket Group
    [134910] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushrooms, Puspocket Cluster
    [134911] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushroom, Puspocket Sporecap
    [134912] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushroom, Large Puspocket
    [134913] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushroom, Tall Puspocket
    [134914] = GetString(SI_FURC_DRAGON_DUNGEON_DROP),   -- Mushrooms, Large Puspocket Cluster
  },
  [FURC_JUSTICE]   = {},
  [FURC_CROWN]   = {
    [134970] = getCrownPrice(100),   -- Mushrooms, Glowing Sprawl
    [134947] = getCrownPrice(100),   -- Mushrooms, Glowing Field
    [134948] = getCrownPrice(400),  -- Mushrooms, Glowing Cluster
    [134971] = getCrownPrice(400),  -- Candles, Votive Group
    [134872] = getCrownPrice(400),  -- Ancient Nord Brazier, Dragon Crest
    [134863] = getCrownPrice(400),  -- Ancient Nord Sconce, Dragon Crest
    [134972] = getCrownPrice(400),  -- Brotherhood Brazier, Wrought Iron
    [134849] = getCrownPrice(400),  -- Monarch Butterfly Flock
    [134848] = getCrownPrice(400),  -- Blue Butterfly Flock
    [94100]  = getCrownPrice(50),  -- Imperial BookCase, Swirled
    [130211] = getCrownPrice(50),  -- Books, Ordered Row
    [130210] = getCrownPrice(50),  -- Books, Scattered Row
  }
}

FurC.MiscItemSources[FURC_CLOCKWORK] = { -- Reach
  [FURC_DROP] = {
    [134407] = FURC_AUTOMATON_CC,      -- Factotum Torso, Obsolete
    [134404] = FURC_AUTOMATON_CC,      -- Factotum Knee, Obsolete
    [134408] = FURC_AUTOMATON_CC,      -- Factotum Elbow, Obsolete
    [134405] = FURC_AUTOMATON_CC,      -- Factotum Arm, Obsolete
    [134409] = FURC_AUTOMATON_CC,      -- Factotum Head, Obsolete
    [134406] = FURC_AUTOMATON_CC,      -- Factotum Body, Obsolete
    
    [132348] = GetString(SI_FURC_QUESTREWARD) .. "the Brass Citadel",  -- The Precursor
  },
  [FURC_JUSTICE]   = {
    [134410] = FURC_CANBESTOLENINCC,         -- Clockwork Crank, Miniature
    [134411] = FURC_CANBESTOLENINCC,         -- Clockwork Gear Shaft, Miniature
    [134412] = FURC_CANBESTOLENINCC,         -- Clockwork Piston, Miniature
    [134413] = FURC_CANBESTOLENINCC,         -- Clockwork Magnifier, Handheld
    [134414] = FURC_CANBESTOLENINCC,         -- Clockwork Micrometer, Handheld
    [134415] = FURC_CANBESTOLENINCC,         -- Clockwork Dial Calipers, Handheld
    [134416] = FURC_CANBESTOLENINCC,         -- Clockwork Slide Calipers, Handheld
    [134402] = GetString(SI_FURC_CANBESTOLEN),   -- Spool, Empty
    [134400] = GetString(SI_FURC_CANBESTOLEN),   -- Soft Leather, Stacked
    [134401] = GetString(SI_FURC_CANBESTOLEN),   -- Soft Leather, Folded
    [134417] = GetString(SI_FURC_CANBESTOLEN),   -- Calipers, Handheld
    [134399] = GetString(SI_FURC_CANBESTOLEN),   -- Quality Fabric, Folded
    [117939] = FURC_CANBESTOLEN_WW,         -- Rough Axe, Practical
  },
  [FURC_CROWN]   = {
    [134266] = getCrownPrice(80),   -- Daedric Books, Stacked
    [134265] = getCrownPrice(80),   -- Daedric Books, Piled
    [134373] = getCrownPrice(410),      -- Clockwork Wall Machinery, Rectangular
    [134374] = getCrownPrice(410),      -- Clockwork Wall Machinery, Circular
    [134382] = getCrownPrice(7),        -- Fabricant Tree, Beryl Cypress
    [134383] = getCrownPrice(870),      -- Fabricant Tree, Towering Maple
    [134385] = getCrownPrice(870),      -- Fabricant Tree, Brass Swamp
    [134387] = getCrownPrice(870),      -- Fabricant Tree, Tall Cobalt Spruce
    [134388] = getCrownPrice(870),      -- Fabricant Tree, Cobalt Oak
    [134390] = getCrownPrice(140),      -- Clockwork Junk Heap, Large
    [134391] = getCrownPrice(510),      -- Clockwork Sequence Spool, Column
    [134392] = getCrownPrice(260),      -- Clockwork Recharging Column, Octet
    [134393] = getCrownPrice(270),      -- Clockwork Workbench, Spacious
    [134394] = getCrownPrice(460),      -- Clockwork Illuminator, Capsule Chandelier
    [134395] = getCrownPrice(150),      -- Clockwork Illuminator, Wall Capsule
    [134396] = getCrownPrice(410),      -- Clockwork Wall Machinery, Tall
    [134397] = getCrownPrice(410),      -- Clockwork Wall Machinery, Ovoid
    [134398] = getCrownPrice(1300),     -- Clockwork Gazebo, Copper and Basalt
  }, 
  [FURC_RUMOUR] = {
    
    [134422] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Clockwork Sextant, Surveyor's
    [134403] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Spool, Red Thread
    [134427] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Clockwork Orrery, Intricate
    [134437] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Clockwork Spinning Wheel, Sturdy
    [134441] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Animo Core, Full
    
    [134384] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Fabricant Tree, Decorative Electrum
    [134386] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Fabricant Tree, Forked Cherry Blossom
    [134389] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Fabricant Tree, Decorative Brass
    [134427] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Clockwork Orrery, Intricate
    [134437] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Clockwork Spinning Wheel, Sturdy
    [134441] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Animo Core, Full
    [125509] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Replica Dwarven Crown Crate
    [125516] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Dwarven Gear Assembly, Grinding
    
    
  }
}


FurC.MiscItemSources[FURC_REACH] = { -- Reach
  [FURC_JUSTICE]   = {
    [130191] = GetString(SI_FURC_CANBESTOLEN),       -- Shivering Cheese
    [118206] = FURC_CANBESTOLEN_THIEF,                 -- Gaming dice
  },
  [FURC_CROWN]   = {
    [131423] = getCrownPrice(750),
  },
  [FURC_DROP]   = {
    -- Coldharbour items
    [130284] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Seedlings
    [131422] = GetString(SI_FURC_HARVEST),          -- Flower Patch, Glowstalks
    [130283] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Sprout
    [130285] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Young
    [131420] = GetString(SI_FURC_HARVEST),          -- Shrub, Glowing Thistle
    [130281] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Towering
    [130282] = GetString(SI_FURC_HARVEST),          -- Glowstalk, Strong
    
    [130067] = GetString(SI_FURC_DAEDRA_SOURCE),   -- Daedric Chain Segment
  },
}

local questRewardSuran = GetString(SI_FURC_QUESTREWARD) .. " Suran"
FurC.MiscItemSources[FURC_MORROWIND]  = {             -- Morrowind
  [FURC_DROP]   = {
    
    -- Dwemer parts
    [126660] = FURC_AUTOMATON_VV,               -- Dwemer Gear, Tiered
    [126659] = FURC_AUTOMATON_VV,               -- Dwemer Gear, Flat
    
    -- lootable in tombs
    [126754] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Seeker
    [126705] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Wisdom
    [126704] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Majesty
    [126706] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Knowledge
    [126701] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Nerevar
    [126764] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Prowess
    [126702] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Reverance
    [126700] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Honor
    [126703] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Mysteries
    [126752] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Discovery
    [126755] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Change
    [126756] = GetString(SI_FURC_TOMBS),       -- Velothi Shroud, Mercy
    
    [126773] = GetString(SI_FURC_TOMBS),       -- Velothi Caisson, Crypt
    [126753] = GetString(SI_FURC_TOMBS),      -- Velothi Cerecloth, Austere
    [126758] = GetString(SI_FURC_TOMBS),      -- Velothi Mat, Prayer
    [126757] = GetString(SI_FURC_TOMBS),
    
    [126462] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Volcanic
    [126463] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Forest
    [126464] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Oversized Valley
    
    [126465] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Volcanic
    [126466] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Forest
    [126467] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Modest Valley
    
    [126468] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Volcanic
    [126469] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Forest
    [126470] = GetString(SI_FURC_CHEST_VV),         -- Telvanni Painting, Classic Valley
    
    [126592] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Volcano
    [126593] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Volcano
    [126594] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Volcano
    [126595] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Volcano
    [126596] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Volcano
    [126597] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Volcano
    
    [126605] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Waterfall
    [126606] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Waterfall
    [126607] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Waterfall
    [126608] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Waterfall
    [126609] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Waterfall
    [126598] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Waterfall
    [126599] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tryptich, Geyser
    [126600] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Tapestry, Geyser
    [126601] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Oversized Geyser
    [126602] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Classic Geyser
    [126603] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Painting, Modest Geyser
    [126604] = GetString(SI_FURC_VV_PAINTING),      -- Velothi Panels, Geyser
    
    -- Ashlander dailies
    [126119] = GetString(SI_FURC_DAILY_ASH),       -- Crimson Shard of Moonshadow
    [126393] = GetString(SI_FURC_DAILY_ASH),     -- Crimson Shard of Moonshadow
    
    -- drops from plants
    [125631] = FURC_PLANTS_VVARDENFELL,         -- Plants, Ash Frond
    [125647] = FURC_PLANTS_VVARDENFELL,         -- Plants, Ash Frond
    [131420] = FURC_PLANTS_VVARDENFELL,         -- Plants, Ash Frond
    [125553] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage Stalks
    [125551] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage
    [125552] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage Patch
    [125543] = FURC_PLANTS_VVARDENFELL,         -- Fern, Ashen
    [125633] = FURC_PLANTS_VVARDENFELL,         -- Plants, Hanging Pitcher Pair
    
    [125551] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage      
    [125552] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage Patch  
    [125553] = FURC_PLANTS_VVARDENFELL,         -- Flowers, Netch Cabbage Stalks  
    [125562] = FURC_PLANTS_VVARDENFELL,         -- Grass, Foxtail Cluster      
    [125595] = FURC_PLANTS_VVARDENFELL,         -- Mushroom, Poison Pax Shelf    
    [125596] = FURC_PLANTS_VVARDENFELL,         -- Mushroom, Poison Pax Stool    
    [125600] = FURC_PLANTS_VVARDENFELL,         -- Mushroom, Spongecap Patch    
    [125606] = FURC_PLANTS_VVARDENFELL,         -- Mushroom, Young Milkcap      
    [125608] = FURC_PLANTS_VVARDENFELL,         -- Mushrooms, Buttercake Cluster  
    [125609] = FURC_PLANTS_VVARDENFELL,         -- Mushrooms, Buttercake Stack    
    [125613] = FURC_PLANTS_VVARDENFELL,         -- Mushrooms, Lavaburst Sprouts  
    [125590] = FURC_PLANTS_VVARDENFELL,         -- Mushrooms, Lavaburst Cluster  
    [125617] = FURC_PLANTS_VVARDENFELL,         -- Plant, Bitter Stalk        
    [125618] = FURC_PLANTS_VVARDENFELL,         -- Plant, Golden Lichen      
    [125619] = FURC_PLANTS_VVARDENFELL,         -- Plant, Hanging Pitcher      
    [125620] = FURC_PLANTS_VVARDENFELL,         -- Plant, Hefty Elkhorn      
    [125621] = FURC_PLANTS_VVARDENFELL,         -- Plant, Lava Brier        
    [125622] = FURC_PLANTS_VVARDENFELL,         -- Plant, Lava Leaf        
    [125630] = FURC_PLANTS_VVARDENFELL,         -- Plant, Young Elkhorn      
    [125631] = FURC_PLANTS_VVARDENFELL,         -- Plants, Ash Frond        
    [125632] = FURC_PLANTS_VVARDENFELL,         -- Plants, Hanging Pitcher Cluster  
    [125633] = FURC_PLANTS_VVARDENFELL,         -- Plants, Hanging Pitcher Pair  
    [125634] = FURC_PLANTS_VVARDENFELL,         -- Plants, Lava Pitcher Cluster  
    [125635] = FURC_PLANTS_VVARDENFELL,         -- Plants, Lava Pitcher Shoots    
    [125636] = FURC_PLANTS_VVARDENFELL,         -- Plants, Swamp Pitcher Cluster  
    [125637] = FURC_PLANTS_VVARDENFELL,         -- Plants, Swamp Pitcher Shoots  
    [125647] = FURC_PLANTS_VVARDENFELL,         -- Shrub, Bitter Brush        
    [125648] = FURC_PLANTS_VVARDENFELL,         -- Shrub, Bitter Cluster      
    [125649] = FURC_PLANTS_VVARDENFELL,         -- Shrub, Flowering Dusk      
    [125650] = FURC_PLANTS_VVARDENFELL,         -- Shrub, Golden Lichen      
    [125670] = FURC_PLANTS_VVARDENFELL,         -- Toadstool, Bloodtooth      
    [125671] = FURC_PLANTS_VVARDENFELL,         -- Toadstool, Bloodtooth Cap    
    [125672] = FURC_PLANTS_VVARDENFELL,         -- Toadstool, Bloodtooth Cluster    
    
    [125649] = FURC_PLANTS_VVARDENFELL,         -- Shrub, Flowering Dusk
    
    [126759] = questRewardSuran,                    -- Sir Sock's Ball of Yarn
    
    [126592] = GetString(SI_FURC_PLANTS),       -- Plants, Hanging Pitcher Pair
    
    [126039] = FURC_SCAMBOX_DWEMER,         -- Statue of masked Clavicus Vile with Barbas
    
  },
  [FURC_CROWN]   = {
    [125566] = getHouseString(1243),                -- Hlaalu Shed, Enclosed
    [125568] = getHouseString(1243),                -- Hlaalu Sidewalk, Sillar Stone
    [125577] = getHouseString(1243),                -- Hlaalu Wall Post, Sillar Stone
    [125579] = getHouseString(1243),                -- Hlaalu Well, Braced Sillar Stone
    [125573] = getHouseString(1243, 1244),          -- Hlaalu Streetlamp, Paper
    [125565] = getHouseString(1244),                -- Hlaalu Lantern, Hanging Paper
    [125567] = getHouseString(1244),                -- Hlaalu Shed, Open
    [125580] = getHouseString(1244),                -- Hlaalu Well, Covered Sillar Stone
    [118663] = getHouseString(1078, 1079),          -- Dark Elf Bed of Coals
    
    [126475] = getCrownPrice(260),                  -- Telvanni Lantern, Organic Amber
    [126476] = getCrownPrice(200),                  -- Telvanni Lamp, Organic Amber
    [126477] = getCrownPrice(560),                  -- Telvanni Streetlight, Organic Amber
    [126478] = getCrownPrice(560),                  -- Telvanni Arched Light, Organic Amber
    [126479] = getCrownPrice(310),                  -- Telvanni Sconce, Organic Amber
    [130202] = getCrownPrice(170),  -- Ayleid Grate, Tall
    [130204] = getCrownPrice(410),  -- Welkynd Stones, Glowing
    [130205] = getCrownPrice(680),  -- Ayleid Statue, Pious Priest
    [130207] = getCrownPrice(270),  -- Ayleid Plinth, Engraved
    [130216] = getCrownPrice(510),  -- Witches' Basin, Scrying
    [130219] = getCrownPrice(240),  -- Witches' Brazier, Beast Skull
    [121001] = getCrownPrice(45),  -- Flowers, Golden Prairie
    [121002] = getCrownPrice(45),  -- Flowers, Violet Prairie
    [130220] = getCrownPrice(3300),  -- Hagraven Altar, Alchemical
    [130221] = getCrownPrice(430),  -- Reachmen Cage, Sturdy
    [130222] = getCrownPrice(260),  -- Hagraven Totem, Skull
    [130223] = getCrownPrice(340),  -- Reachmen Rug, Mottled Skin
    [130225] = getCrownPrice(340),  -- Skulls, Heap
    [130226] = getCrownPrice(85),  -- Carcass, Hanging Deer
    [130227] = getCrownPrice(850),  -- Witches' Tent, Lean-To
    [130229] = getCrownPrice(290),  -- Tree, Wretched Cypress
    [130230] = getCrownPrice(90),  -- Stump, Wretched Cypress
    [121017] = getCrownPrice(10),  -- Bush, Dense Forest
    [121019] = getCrownPrice(10),  -- Plants, Dense Underbrush
    [121027] = getCrownPrice(45),  -- Hedge, Dense Low Arc
    [130247] = getCrownPrice(290),  -- Tree, Fetid Cypress
    [121033] = getCrownPrice(25),  -- Sapling, Sparse Laurel
    [121037] = getCrownPrice(30),  -- Shrub, Sparse Pink
    [121038] = getCrownPrice(30),  -- Plant, Paired White Hosta
    [121039] = getCrownPrice(30),  -- Plant, Blooming White Hosta
    [121040] = getCrownPrice(30),  -- Plant, Verdant Hosta
    [121041] = getCrownPrice(10),  -- Plant, Young Verdant Hosta
    [121042] = getCrownPrice(10),  -- Plant, Young Summer Hosta
    [121043] = getCrownPrice(30),  -- Plant, Summer Hosta
    [121044] = getCrownPrice(30),  -- Plant, Healthy White Hosta
    [121045] = getCrownPrice(25),  -- Book Row, Decorative
    [121047] = getCrownPrice(25),  -- Book Row, Long
    [121052] = getCrownPrice(100),  -- Vase, Gilded Offering
    [121053] = getCrownPrice(170),  -- Jar, Gilded Canopic
    [121054] = getCrownPrice(30),  -- Breton Mug, Empty
    [121056] = getCrownPrice(25),  -- Book Stack, Decorative
    [134379] = getCrownPrice(50),  -- Boulder, Large Metallic Shard
    [134380] = getCrownPrice(110),  -- Rocks, Sintered Arch
    [134381] = getCrownPrice(110),  -- Rocks, Sintered Outcropping
    [130316] = getCrownPrice(25),  -- Pumpkin, Frail
    [130317] = getCrownPrice(25),  -- Pumpkin, Sickly
    [130318] = getCrownPrice(10),  -- Crop, Wheat Pile
    [130319] = getCrownPrice(10),  -- Crop, Wheat Stack
    [130322] = getCrownPrice(90),  -- Tool, Harvest Scythe
    [130329] = getCrownPrice(240),  -- Primal Brazier, Rock Slab
    [131425] = getCrownPrice(360),  -- Orcish Tent, Soldier's
    [131426] = getCrownPrice(680),  -- Orcish Tent, Officer's
    [131427] = getCrownPrice(1700),  -- Orcish Tent, General's
    [134565] = getCrownPrice(130),  -- Fabrication Tank, Reinforced
    [134566] = getCrownPrice(30),  -- Shrub Cluster, Snowswept
    [134567] = getCrownPrice(10),  -- Bush Cluster, Snowswept
    [134568] = getCrownPrice(40),  -- Tree, Snowswept Evergreen
    [134569] = getCrownPrice(40),  -- Trees, Snowswept Pair
    [134570] = getCrownPrice(110),  -- Snow Pile
    [134571] = getCrownPrice(120),  -- Snow Pile, Large
    [134572] = getCrownPrice(5),  -- Stones, Snowswept Cluster
    [134573] = getCrownPrice(5),  -- Stone, Snowswept Shard
    [134574] = getCrownPrice(50),  -- Boulder, Snowswept Peak
    [134575] = getCrownPrice(50),  -- Boulder, Snowswept Crag
    [134576] = getCrownPrice(190),  -- Orcish Brazier, Snowswept Column
    [134577] = getCrownPrice(50),  -- Ice Floe, Thin
    [134578] = getCrownPrice(110),  -- Ice Floe, Thick
    [125482] = getCrownPrice(50),  -- Boulder, Volcanic Crag
    [125484] = getCrownPrice(30),  -- Bush, Lush Laurel
    [121399] = getCrownPrice(2000),  -- Target Skeleton, Robust Khajiit
    [121400] = getCrownPrice(2000),  -- Target Skeleton, Robust Argonian
    [120408] = getCrownPrice(25),  -- Argonian Fish in a Basket
    [120409] = getCrownPrice(100),  -- Argonian Rack, Woven
    [120412] = getCrownPrice(50),  -- Noble's Chalice
    [120413] = getCrownPrice(30),  -- Breton Pitcher, Clay
    [120414] = getCrownPrice(30),  -- Breton Tankard, Empty
    [120415] = getCrownPrice(30),  -- Breton Tankard, Full
    [120416] = getCrownPrice(40),  -- Common Cloak on a Hook
    [120420] = getCrownPrice(140),  -- Plaque, Bolted Deer Antlers
    [125545] = getCrownPrice(30),  -- Fern, Young Dusky
    [120426] = getCrownPrice(1500),  -- Target Skeleton, Khajiit
    [120427] = getCrownPrice(1500),  -- Target Skeleton, Argonian
    [125548] = getCrownPrice(85),  -- Flower, Towering Purple Bat Bloom
    [125549] = getCrownPrice(85),  -- Flowers, Double Purple Bat Blooms
    [125554] = getCrownPrice(85),  -- Flowers, Opposing Purple Bat Blooms
    [125555] = getCrownPrice(85),  -- Flowers, Sullen Purple Bat Blooms
    [120464] = getCrownPrice(20),  -- Rocks, Stacked Cracked
    [120465] = getCrownPrice(5),  -- Stone, Tapered Rough
    [120466] = getCrownPrice(5),  -- Pebble, Stacked Desert
    [120470] = getCrownPrice(25),  -- Tree, Leaning Palm
    [120472] = getCrownPrice(25),  -- Tree, Young Palm
    [120473] = getCrownPrice(60),  -- Sapling, Thin Palm
    [120475] = getCrownPrice(70),  -- Trees, Paired Wax Palms4
    [120482] = getCrownPrice(30),  -- Cactus, Golden Bulbs
    [125603] = getCrownPrice(40),  -- Mushroom, Stinkhorn Spore
    [120484] = getCrownPrice(30),  -- Cactus, Golden Barrel
    [125605] = getCrownPrice(10),  -- Mushroom, Young Erupted Stinkcap
    [120486] = getCrownPrice(30),  -- Cactus, Stocky Columnar
    [125607] = getCrownPrice(10),  -- Mushroom, Young Netch Shield
    [125610] = getCrownPrice(25),  -- Mushrooms, Cave Bracket Cluster
    [120491] = getCrownPrice(30),  -- Fern, Hearty Autumn
    [125616] = getCrownPrice(5),  -- Pebble, Volcanic Chunk
    [125628] = getCrownPrice(70),  -- Plant, Rosetted Sundew      
    [126686] = getCrownPrice(400),  -- Dwarven Chest, Relic
    [120481] = getCrownPrice(150),  -- Tree, Ancient Juniper
  },
  [FURC_JUSTICE]   = {
    [126481] = FURC_CANBESTOLEN_RELIG .. " on Vvardenfell", -- Indoril Incense, Burning
    [126772] = FURC_CANBESTOLEN_THIEF             -- Khajiiti Ponder sphere
  },
  [FURC_RUMOUR] = {    
    [132531] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hlaalu Planter, Tall
    [120411] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Noble's Chalice of Wine
    [120417] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Redguard Barrel, Corded
    [126568] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Daedric Urn, Ritual
    [125550] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Flowers, Lava Blooms
    [126588] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vvardenfell Pitcher Plants, Hanging Bunch
    [126589] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vvardenfell Mushrooms, Bloodtooth
    [126590] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Vvardenfell Mushrooms, Lavaburst
    [125569] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hlaalu Sidewalk, Sillar Stone Corner
    [125570] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hlaalu Stairs, Sillar Stone
    [125576] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Hlaalu Wall Pillar, Sillar Stone
    [125581] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Buttercake
    [125583] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Cave Bracket
    [125589] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Lavaburst Bud
    [125591] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Lavaburst Patch
    [125597] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Polyp Stinkhorn
    [125598] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Mushroom, Emerging Stinkhorn
    [127149] = GetString(SI_FURC_DATAMINED_UNCLEAR),  -- Morrowind Banner of the 6th House
  }
}
FurC.MiscItemSources[FURC_HOMESTEAD]  = {
  [FURC_JUSTICE]   = {
    -- stealing
    [118489] = FURC_CANBESTOLEN_SCHOLARS,          -- Papers, Stack
    [118528] = GetString(SI_FURC_CANBESTOLEN),     -- Signed Contract
    [118890] = GetString(SI_FURC_CANBESTOLEN),     -- Skull, Human
    [118487] = FURC_CANBESTOLEN_SCHOLARS,          -- Letter, Personal
    [120008] = FURC_CANBESTOLEN_NERDS,             -- Lesser Soul Gem, Empty
    [120005] = FURC_CANBESTOLEN_NERDS,             -- Papers, Stack
    
    -- Bounty Sheets
    [118711] = FURC_CANBEPICKED_GUARD,         -- Argonian Male
    [118709] = FURC_CANBEPICKED_GUARD,         -- Breton Male
    [118712] = FURC_CANBEPICKED_GUARD,         -- Breton Woman
    [118715] = FURC_CANBEPICKED_GUARD,         -- Colovian Man
    [118710] = FURC_CANBEPICKED_GUARD,         -- High Elf Male
    [118714] = FURC_CANBEPICKED_GUARD,         -- Imperial Man
    [118713] = FURC_CANBEPICKED_GUARD,         -- Khajiiti Male
    [118716] = FURC_CANBEPICKED_GUARD,         -- Orc Female
    [118717] = FURC_CANBEPICKED_GUARD,         -- Orc Male
    
    [121055] = FURC_CANBESTOLEN_DRUNK,           -- Breton Mug, Full
    
    [116512] = FURC_CANBESTOLEN_WROTHGAR,        -- Orcish Carpet Blood
    
  },
  [FURC_FISHING]   = {
    -- fishing
    [118902] = GetString(SI_FURC_CANBEFISHED),     -- Coral, Sun
    [118903] = GetString(SI_FURC_CANBEFISHED),     -- Coral, Crown
    [118896] = GetString(SI_FURC_CANBEFISHED),     -- Seashell, Sandcake
    [118901] = GetString(SI_FURC_CANBEFISHED),     -- Sea sponge
    [118338] = GetString(SI_FURC_CANBEFISHED),     -- Fish, Bass
    [118339] = GetString(SI_FURC_CANBEFISHED),     -- Fish, Salmon
    [118337] = GetString(SI_FURC_CANBEFISHED),     -- Fish, Trout
    [120753] = GetString(SI_FURC_CANBEFISHED),     -- Kelp, Green Pile
    [120755] = GetString(SI_FURC_CANBEFISHED),     -- Kelp, Lush Pile
    [120754] = GetString(SI_FURC_CANBEFISHED),     -- Kelp, Small Pile
    [118897] = GetString(SI_FURC_CANBEFISHED),     -- Seashell, Pink Scallop
    [118898] = GetString(SI_FURC_CANBEFISHED),     -- Seashell, White Scallop
    [118899] = GetString(SI_FURC_CANBEFISHED),     -- Seashell, Starfish
    [118900] = GetString(SI_FURC_CANBEFISHED),     -- Seashell, Noble Starfish
    
  },
  [FURC_DROP]    = {
    [121058] = FURC_DB_SNEAKY,             -- Candles of Silence
    
    [119936] = FURC_DB_POISON,             -- Poisoned Blood
    [119938] = FURC_DB_POISON,             -- Light and Shadow
    [119952] = FURC_DB_POISON,             -- Sacrificial Heart
    
    -- Paintings
    [118216] = GetString(SI_FURC_CHESTS),         -- Painting of Spring, Sturdy
    [118217] = GetString(SI_FURC_CHESTS),         -- Painting of Pasture, Sturdy
    [118218] = GetString(SI_FURC_CHESTS),         -- Painting of Creek, Sturdy
    [118219] = GetString(SI_FURC_CHESTS),         -- Painting of Lakes, Sturdy
    [118220] = GetString(SI_FURC_CHESTS),         -- Painting of Crags, Sturdy
    [118221] = GetString(SI_FURC_CHESTS),         -- Painting of Summer, Sturdy
    [118222] = GetString(SI_FURC_CHESTS),         -- Painting of Jungle, Sturdy
    [118223] = GetString(SI_FURC_CHESTS),         -- Painting of Palms, Sturdy
    [118265] = GetString(SI_FURC_CHESTS),         -- Painting of Winter, Bolted
    [118266] = GetString(SI_FURC_CHESTS),         -- Painting of Bridge, Bolted
    [118267] = GetString(SI_FURC_CHESTS),         -- Painting of Autumn, Bolted
    [118268] = GetString(SI_FURC_CHESTS),         -- Painting of Great Ruins, Bolted
    
  },
  [FURC_CROWN]  = {
    [118096] = getCrownPrice(10),               -- Bread, Plain
    [118098] = getCrownPrice(10),               -- Common Bowl, Serving
    [118061] = getCrownPrice(15),               -- Chicken Dinner, Display
    [118062] = getCrownPrice(15),               -- Chicken Meal, Display
    [118056] = getCrownPrice(15),               -- Common Stewpot, Hanging
    [118121] = getCrownPrice(15),               -- Knife, Carving
    [118066] = getCrownPrice(15),               -- Steak Dinner
    
    [118057] = getCrownPrice(20),             -- Sack of Beans
    [118060] = getCrownPrice(20),             -- Sack of Grain
    [118059] = getCrownPrice(20),             -- Sack of Millet,
    [118058] = getCrownPrice(20),             -- Sack of Rice
    [118351] = getCrownPrice(25),                   -- Box of Peaches
    
    
    [134473] = FURC_SCAMBOX_F_ATRO,        -- Tapestry,  Malacath
    
    [118064] = getCrownPrice(45),       -- Common Barrel, Dry
    [118065] = getCrownPrice(45),       -- Common Cargo Crate, Dry
    [118064] = getCrownPrice(45),       -- Common Barrel, Dry
    
    [118054] = getCrownPrice(80),           -- Common Firepit, Outdoor
    [118055] = getCrownPrice(80),       -- Common Firepit, Piled
    [118126] = getCrownPrice(95),       -- Plaque, Standard
    
    [118068] = getCrownPrice(120),       -- Simple Brown Banner
    [118069] = getCrownPrice(120),       -- Simple Gray Banner
    [118071] = getCrownPrice(120),       -- Simple Red Banner
    [118070] = getCrownPrice(120),       -- Simple Purple Banner
    
    
    [94098] = getCrownPrice(95),            -- Imperial Bed, Single
    
    [120607] = getCrownPrice(50),       -- Sapling, Lanky Ash
    
    
    [115698] = getCrownPrice(1100),     -- Khajiit Statue, Guardian
    
    [120413] = getCrownPrice(30), -- Breton Pitcher, Clay",
  },
  [FURC_RUMOUR]   = {
    
    [118290] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Antlers, Wall Mount
    [118299] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Bottle, Beaker
    [118300] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Bottle, Poison
    [118291] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Durzog Head, Wall Mount
    [118294] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Echatere Horns, Wall Mount
    [118293] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Echatere, Wall Mount
    [118295] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Haj Mota Head, Wall Mount
    [118289] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Haj Mota Shell, Wall Mount
    [118284] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Horn, Display, Cracked
    [118283] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Horn, Display, Huge
    [118296] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Mantikora Head, Wall Mount
    [118297] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Mantikora Horns, Wall Mount
    [118242] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Rug, Bearskin
    [116473] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Orcish Effigy, Mammoth
    [116474] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Orcish Effigy, Bear
    [116433] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Orcish Desk with Furs
    [118065] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Common Cargo Crate, Dry
    [118054] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Common Firepit, Outdoor
    [118055] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Common Firepit, Piled
    [118000] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Garlic String, Display
    [118119] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Minecart, Empty
    [118120] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Minecart, Push
    [117991] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Stool, Carved
    [118278] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Plaque, Bordered Deer Antlers
    [118304] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Shelf, Poison
    [118118] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Candles, Lasting
    [115395] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Nord Drinking Horn, Display
    [118127] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Plaque, Small
    [118288] = GetString(SI_FURC_RUMOUR_SOURCE_ITEM),           -- Deer Carcass, Hanging
  }
}
