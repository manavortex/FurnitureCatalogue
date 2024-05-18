local colours = FurC.ItemLinkColours

local strSoldBy = FurC.Utils.SoldBy

local requires = GetString(SI_FURC_REQUIRES_ACHIEVEMENT)
local requiresPsijicRank = string.format("%s %s", requires, GetString(SI_FURC_PSIJIC_RANK))
local rankFormattingString = requiresPsijicRank .. "%d"

local function rank(aNumber)
  return string.format(requiresPsijicRank, aNumber)
end

local daily_reward_elswhere = GetString(SI_FURC_DAILY_ELSWEYR)
local artaeum = GetString(SI_FURC_LOC_ARTAEUM)
local nalirsewen = GetString(SI_FURC_TRADERS_NALIRSEWEN)

FurC.RecipeSources = {
  [139489] = strSoldBy(nalirsewen, { artaeum }, 5000, rank(2)), -- Blueprint: Psijic Chair, Arched
  [139490] = strSoldBy(nalirsewen, { artaeum }, 10000, rank(3)), -- Blueprint: Psijic Table, Small
  [139493] = strSoldBy(nalirsewen, { artaeum }, 10000, rank(6)), -- Blueprint: Psijic Banner
  [139496] = strSoldBy(nalirsewen, { artaeum }, 20000, rank(9)), -- Blueprint: Psijic Banner, Large
  [141822] = strSoldBy(nalirsewen, { artaeum }, 25000, rank(9)), -- Blueprint: Psijic Banner, Long
  [139487] = strSoldBy(nalirsewen, { artaeum }, 5000, rank(1)), -- Praxis: Book Row, Levitating
  [139488] = strSoldBy(nalirsewen, { artaeum }, 5000, rank(1)), -- Praxis: Book Stack, Levitating
  [139495] = strSoldBy(nalirsewen, { artaeum }, 20000, rank(8)), -- Praxis: Psijic Lighting Globe, Large
  [139491] = strSoldBy(nalirsewen, { artaeum }, 10000, rank(4)), -- Praxis: Psijic Lighting Globe, Small
  [139497] = strSoldBy(nalirsewen, { artaeum }, 100000, rank(10)), -- Praxis: Psijic Table, Grand
  [139492] = strSoldBy(nalirsewen, { artaeum }, 20000, rank(5)), -- Praxis: Psijic Table, Scalloped
  [139494] = strSoldBy(nalirsewen, { artaeum }, 20000, rank(7)), -- Praxis: Psijic Table, Six-Fold Symmetry
  [121203] = daily_reward_elswhere, -- Praxis: Khajiit Brazier, Enchanted
}

for versionNo, rolisRecipes in pairs(FurC.RolisRecipes) do
  for recipeId, itemPrice in pairs(rolisRecipes) do
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, colours.Voucher)
    FurC.RecipeSources[recipeId] = zo_strformat(GetString(SI_FURC_STRING_ROLIS), priceString)
  end
end

for versionNo, faustinaRecipes in pairs(FurC.FaustinaRecipes) do
  for recipeId, itemPrice in pairs(faustinaRecipes) do
    local unsurpassedCrafter = GetAchievementLink(1801, LINK_STYLE_DEFAULT)
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, colours.Voucher)
    local strSoldByFaustinaFor = zo_strformat(GetString(SI_FURC_STRING_FAUSTINA), priceString)
    FurC.RecipeSources[recipeId] = strSoldByFaustinaFor .. requires .. unsurpassedCrafter
  end
end
