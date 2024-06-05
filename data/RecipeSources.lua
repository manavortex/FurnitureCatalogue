local colours = FurC.Constants.Colours
local loc = FurC.Constants.Locations
local npc = FurC.Constants.NPC
local skillLine = FurC.Constants.SkillLines

local sFormat = zo_strformat

local strRank = FurC.Utils.FmtRank
local strFurnisher = FurC.Utils.FormatFurnisher

local skillPsijic = skillLine.PSIJIC

local daily_reward_elswhere = GetString(SI_FURC_DAILY_ELSWEYR)
local artaeum = loc.ARTAEUM
local nalirsewen = npc.PSIJIC_NALIRSEWEN

FurC.RecipeSources = {
  [139489] = strFurnisher(nalirsewen, artaeum, 5000, nil, strRank(skillPsijic, 2)), -- Blueprint: Psijic Chair, Arched
  [139490] = strFurnisher(nalirsewen, artaeum, 10000, nil, strRank(skillPsijic, 3)), -- Blueprint: Psijic Table, Small
  [139493] = strFurnisher(nalirsewen, artaeum, 10000, nil, strRank(skillPsijic, 6)), -- Blueprint: Psijic Banner
  [139496] = strFurnisher(nalirsewen, artaeum, 20000, nil, strRank(skillPsijic, 9)), -- Blueprint: Psijic Banner, Large
  [141822] = strFurnisher(nalirsewen, artaeum, 25000, nil, strRank(skillPsijic, 9)), -- Blueprint: Psijic Banner, Long
  [139487] = strFurnisher(nalirsewen, artaeum, 5000, nil, strRank(skillPsijic, 1)), -- Praxis: Book Row, Levitating
  [139488] = strFurnisher(nalirsewen, artaeum, 5000, nil, strRank(skillPsijic, 1)), -- Praxis: Book Stack, Levitating
  [139495] = strFurnisher(nalirsewen, artaeum, 20000, nil, strRank(skillPsijic, 8)), -- Praxis: Psijic Lighting Globe, Large
  [139491] = strFurnisher(nalirsewen, artaeum, 10000, nil, strRank(skillPsijic, 4)), -- Praxis: Psijic Lighting Globe, Small
  [139497] = strFurnisher(nalirsewen, artaeum, 100000, nil, strRank(skillPsijic, 10)), -- Praxis: Psijic Table, Grand
  [139492] = strFurnisher(nalirsewen, artaeum, 20000, nil, strRank(skillPsijic, 5)), -- Praxis: Psijic Table, Scalloped
  [139494] = strFurnisher(nalirsewen, artaeum, 20000, nil, strRank(skillPsijic, 7)), -- Praxis: Psijic Table, Six-Fold Symmetry
  [121203] = daily_reward_elswhere, -- Praxis: Khajiit Brazier, Enchanted
}

for versionNo, rolisRecipes in pairs(FurC.RolisRecipes) do
  for recipeId, itemPrice in pairs(rolisRecipes) do
    FurC.RecipeSources[recipeId] = strFurnisher(npc.ROLIS, loc.ANY_CAPITAL, itemPrice, CURT_WRIT_VOUCHERS)
  end
end

for versionNo, faustinaRecipes in pairs(FurC.FaustinaRecipes) do
  for recipeId, itemPrice in pairs(faustinaRecipes) do
    FurC.RecipeSources[recipeId] = strFurnisher(npc.FAUSTINA, loc.ANY_CAPITAL, itemPrice, CURT_WRIT_VOUCHERS, 1801)
  end
end
