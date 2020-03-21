FurC.MiscItemSources        = FurC.MiscItemSources or {}

-- constants save performance on string handling
local questRewardString     = GetString(SI_FURC_QUESTREWARD)

local pickpocket_ww         = GetString(SI_FURC_CANBEPICKED) .. " from woodworkers"
local pickpocket_ass        = GetString(SI_FURC_CANBEPICKED) .. " from outlaws and assassins"
local pickpocket_guard      = GetString(SI_FURC_CANBEPICKED) .. " from guards"

local automaton_loot_cc     = GetString(SI_FURC_AUTOMATON) .. " in Clockwork City"
local automaton_loot_vv     = GetString(SI_FURC_AUTOMATON) .. " on Vvardenfell"


local scambox_string        = GetString(SI_FURC_SCAMBOX)
local scambox_newmoon       = zo_strformat("<<1>> (<<2>>)", scambox_string, "New Moon")

local sinister_hollowjack   = "Sinister Hollowjack Items"

local itemPackMoonBishop    = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Moon Bishop’s Sanctuary")
local itemPackOasis         = zo_strformat(GetString(SI_FURC_ITEMSOURCE_ITEMPACK), "Moons-Blessed Oasis")

local elsewhere             = " in Elsweyr" 

local fishing_elsewhere     = GetString(SI_FURC_CANBEFISHED)  .. elsewhere
local drop_elsewhere        = GetString(SI_FURC_DROP)         .. elsewhere
local stealable_elsewhere   = GetString(SI_FURC_CANBESTOLEN)  .. elsewhere

local rumourSource          = GetString(SI_FURC_RUMOUR_SOURCE_ITEM)
local dataminedUnclear      = GetString(SI_FURC_DATAMINED_UNCLEAR)

local daily_reward          = GetString(SI_FURC_DAILY_ELSWEYR)
local elsweyr_event         = GetString(SI_FURC_EVENT_ELSWEYR)
local priceUnknown          = "?"

local crownstoresource      = GetString(SI_FURC_CROWNSTORESOURCE)
local function getCrownPrice(price)
  return ( price < 0 and priceUnknown) or string.format("%s (%u)", crownstoresource, price)
end

local housesource = GetString(SI_FURC_HOUSE)
local function getHouseString(houseId1, houseId2)
  local houseName = GetCollectibleName(houseId1)
  if houseId2 then houseName = houseName .. ", " .. GetCollectibleName(houseId2) end
  return zo_strformat(housesource, houseName)
end

FurC.MiscItemSources[FURC_KITTY]  = {
  
  [FURC_CROWN]   = {
    [153630] = scambox_newmoon .. " (55 gems)", 
  }
  [FURC_RUMOUR]   = {
    [151851] = rumourSource, -- Boulder, Lunar Spine,
    [151852] = rumourSource, -- Boulder, Lunar Spire,
    [151853] = rumourSource, -- Cactus, Lunar Fan,
    [151854] = rumourSource, -- Cactus, Banded Lunar Multihued Trio,
    [151855] = rumourSource, -- Elsweyr Sarcophagus, Lunar Champion,
    [151856] = rumourSource, -- Elsweyr Sarcophagus Lid, Lunar Champion,
    [151858] = rumourSource, -- Elsweyr Altar, Dark Moons,
    [151859] = rumourSource, -- Alinor Greenhouse, Summer,
    [151860] = rumourSource, -- Sapling, Blue Wisteria,
    [151861] = rumourSource, -- Tree, Purple Wisteria,
    [151862] = rumourSource, -- Tree, Blue Wisteria,
    [151863] = rumourSource, -- Alinor Windmill, Decorative,
    [151864] = rumourSource, -- Alinor Maple, Diminutive,
    [151865] = rumourSource, -- Alinor Maple, Purple,
    [151866] = rumourSource, -- Alinor Maple, Sinuous,
    [151872] = rumourSource, -- Boulder, Towering Lunar Spire,
    [151873] = rumourSource, -- Boulder, Lunar Crag,
    [151879] = rumourSource, -- Cactus, Lunar Tendrils,
    [151880] = rumourSource, -- Cactus, Lunar Branching,
    [151881] = rumourSource, -- Cactus, Lunar Branching Tall,
    [151882] = rumourSource, -- Cactus, Banded Lunar Violet Trio,
    [151884] = rumourSource, -- Tree, Giant Ficus,
    [151885] = rumourSource, -- Tree, Massive Ficus,
    [152145] = rumourSource, -- Orcish Tapestry, War,    
    [152149] = rumourSource, -- Orcish Brazier, Pillar,
    [151904] = rumourSource, -- Glowgrass, Patch,
    [151909] = rumourSource, -- Music Box, Scalesong,
    [151910] = rumourSource, -- Music Box, Sweetblossom,
    [151913] = rumourSource, -- Rock, Slate,
    [151915] = rumourSource, -- Daedric Key, Coldharbour,
    [151944] = rumourSource, -- Daedric Sconce, Coldharbour,
    [151945] = rumourSource, -- Plant, Spore Pod,
    [151946] = rumourSource, -- Flower, Coda,
    [151949] = rumourSource, -- Hlaalu Path Marker, Almsivi,
    [151950] = rumourSource, -- Khajiit Path Marker, Lion, 
    [147926] = rumourSource, -- Target Iron Atronach, Trial,
    [152148] = rumourSource, -- Orcish Tapestry, Hunt,
    [152147] = rumourSource, -- Orcish Statue, Strength,
    [152146] = rumourSource, -- Orcish Chandelier, Spiked,
    [152141] = rumourSource, -- Orcish Brazier, Bordered,
    [152144] = rumourSource, -- Orcish Mirror, Peaked,
    [152143] = rumourSource, -- Orcish Sconce, Scrolled,
    [152142] = rumourSource, -- Orcish Sconce, Bordered,
    [150774] = rumourSource, -- Banner of Vaermina,
    [150775] = rumourSource, -- Banner of Jyggalag,
    [151589] = rumourSource, -- Baandari Lunar Compass,
    [151611] = rumourSource, -- The Mane, Moons-Blessed,
    [151612] = rumourSource, -- Pile of Dubious Riches,
    
    }, 
  
  [FURC_JUSTICE] = {
    [151892] = stealable_elsewhere, -- Elsweyr Fragrance Bottle, Moons-Blessed
    [151889] = stealable_elsewhere, -- Elsweyr Comb, Grooming    
    [151893] = stealable_elsewhere, -- Elsweyr Fragrance Bottle, Moonlit Tryst 
    [151899] = stealable_elsewhere, -- Elsweyr Pillow, Night Blues Wide,
    [151898] = stealable_elsewhere, -- Elsweyr Pillow, Gold-Ruby Roll,
    [151900] = stealable_elsewhere, -- Elsweyr Pillow, Gold-Ruby Throw,
    [151895] = stealable_elsewhere, -- Elsweyr Cloth, Rolled,
    [151643] = stealable_elsewhere, -- Elsweyr Rolling Pin, Well-Worn,
    [151890] = stealable_elsewhere, -- Elsweyr Hand Mirror, Bronze Oval,
    [151891] = stealable_elsewhere, -- Elsweyr Hand Mirror, Rectangular,
    [151897] = stealable_elsewhere, -- Elsweyr Fabric, Display,
    [151886] = stealable_elsewhere, -- Elsweyr Fan, Handheld,
    [151887] = stealable_elsewhere, -- Elsweyr Brush, Body,
    [151888] = stealable_elsewhere, -- Elsweyr Brush, Head,
    [151894] = stealable_elsewhere, -- Elsweyr Mirror, Carved Wall
  }, 
  
  [FURC_DROP]    = {
    [121203]    = daily_reward ,    -- Praxis: Khajiit Brazier, Enchanted
    [117906]    = elsweyr_event ,    -- Redguard Urn, Gilded
    [153563]    = elsweyr_event ,    -- Target Bone Goliath, Reanimated
  },
  
  [FURC_CROWN]  = {   
  
    [151838] = itemPackOasis, -- Elsweyr Fountain, Moons-Blessed,
    [151840] = itemPackOasis, -- Plant, Desert Fan,
    [151841] = itemPackOasis, -- Plant, Tall Desert Fan,
    [151842] = itemPackOasis, -- Plant, Cask Palm,
    [151843] = itemPackOasis, -- Cactus, Flowering Cluster,
    [151844] = itemPackOasis, -- Cactus, Bilberry,
    [151845] = itemPackOasis, -- Elsweyr Potted Cactus, Flowering,
    [151846] = itemPackOasis, -- Elsweyr Potted Plant, Cask Palm,
    [151835] = itemPackOasis, -- Cathay-Raht Statue, Warrior,
    [151836] = itemPackOasis, -- Tojay Statue, Dancer,
    [151837] = itemPackOasis, -- Ohmes-Raht Statue, Trickster,
    [151847] = itemPackOasis, -- Plant, Flowering Desert Aloe,
    [151848] = itemPackOasis, -- Trees, Sunset Palm Cluster,
    [151849] = itemPackOasis, -- Cactus, Lily Flower,
    [151850] = itemPackOasis, -- Tree, Anequina Bonsai,
  
    [151906] = itemPackMoonBishop, -- Robust Target Dro-m'Athra,
    [151829] = itemPackMoonBishop, -- Suthay Statue, Nimble Bishop,
    [151824] = itemPackMoonBishop, -- Lunar Tapestry, The Open Path,
    [151825] = itemPackMoonBishop, -- Lunar Tapestry, The Gathering,
    [151826] = itemPackMoonBishop, -- Lunar Tapestry, The Dance,
    [151827] = itemPackMoonBishop, -- Lunar Tapestry, The Gate,
    [151828] = itemPackMoonBishop, -- Lunar Tapestry, The Demon,
    [151830] = itemPackMoonBishop, -- Elsweyr Divider, Elegant Wooden,
    [151832] = itemPackMoonBishop, -- Elsweyr Ceremonial Lantern, Jone,
    [151833] = itemPackMoonBishop, -- Elsweyr Ceremonial Lantern, Jode,
    
    [151808] = getCrownPrice(10), -- Tree, Fan Palm,
    [151813] = getCrownPrice(10), -- Sapling, Desert Acacia,
    [151816] = getCrownPrice(10), -- Plant, Flowering Thorned Succulent,
    [151820] = getCrownPrice(10), -- Desert Grass, Tall,
    [151821] = getCrownPrice(15), -- Desert Grass, Patch,
    [151831] = getCrownPrice(290), -- Elsweyr Sugar Pipe, Ceremonial,
    [151834] = getCrownPrice(90), -- Tree, Desert Acacia Shade,
    [151857] = getCrownPrice(150), -- Elsweyr Gazebo, Ancient Stone,
    [151867] = getCrownPrice(340), -- Hakoshae Lanterns, Festival,
    [151868] = getCrownPrice(180), -- Hakoshae Banners, Festival,
    [151869] = getCrownPrice(300), -- Elsweyr Wagon, Covered,
    [151870] = getCrownPrice(560), -- Elsweyr Wagon, Pedlar,
    [151871] = getCrownPrice(300), -- Elsweyr Dais, Temple,
    [151874] = getCrownPrice(300), -- Elsweyr Shrine, Ancient Stone,
    [151875] = getCrownPrice(560), -- Elsweyr Bridge, Ancient Stone,
    [151876] = getCrownPrice(590), -- Elsweyr Tent, Caravan,
    [151877] = getCrownPrice(590), -- Elsweyr Canopy, Bazaar,
    [151878] = getCrownPrice(450), -- Elsweyr Canopy, Peaked,
    [151883] = getCrownPrice(240), -- Tree, Towering Iroko, 
    [151901] = getCrownPrice(20), -- Elsweyr Bowl, Moon-Sugar,
    [151902] = getCrownPrice(200), -- Elsweyr Sarcophagus, Ancient,
    [151903] = getCrownPrice(200), -- Elsweyr Sarcophagus Lid, Ancient,
    [151905] = getCrownPrice(10), -- Rock, Wide Flat Slate,
    [151911] = getCrownPrice(5), -- Rock, Flat Slate,
    [151912] = getCrownPrice(10), -- Stepping Stones, Slate,
    [151914] = getCrownPrice(25), -- Tree, Desert Acacia Tall,
    [151804] = getCrownPrice(30), -- Elsweyr Pillar, Rough Wooden,
    [151806] = getCrownPrice(5), -- Rubble Pile, Ancient Stone,
    [151807] = getCrownPrice(5), -- Rock Field, Ancient Stone,
    [151703] = getCrownPrice(-1), -- Elsweyr Wardrobe, Wide Elegant Wooden,
  },
  [FURC_FISHING]   = {
     
  },
    
}
