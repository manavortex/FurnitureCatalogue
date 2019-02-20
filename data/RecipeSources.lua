local vendorColor   = FurC.Const.vendorColor
local goldColor   = FurC.Const.goldColor
local voucherColor  = FurC.Const.voucherColor

local function colorise(str, col, ret)
  str = tostring(str)
  if str:find("%d000$") then str = str:gsub("000$", "k") end
  if ret then return str end
  return string.format("|c%s%s|r", col, str)
end

local requires = GetString(SI_FURC_REQUIRES_ACHIEVEMENT)
local psijicRank = GetString(SI_FURC_PSIJIC_RANK)

local function rank(aNumber) return requires .. psijicRank .. aNumber end

local function soldBy(vendorName, locationName, price, requirement)
    return zo_strformat(
        GetString(SI_FURC_STRING_VENDOR),
        colorise(vendorName,   vendorColor, stripColor),
        colorise(locationName,   vendorColor, stripColor),
        colorise(price,       goldColor, stripColor),
        requirement
    )
end


local artaeum       = GetString(FURC_AV_ARTAEUM)
local nalirsewen    = GetString(FURC_AV_NAL)

FurC.RecipeSources = {
    [139489] = soldBy(nalirsewen, artaeum, 5000,    rank(2)),  -- Blueprint: Psijic Chair, Arched
    [139490] = soldBy(nalirsewen, artaeum, 10000,   rank(3)),  -- Blueprint: Psijic Table, Small
    [139493] = soldBy(nalirsewen, artaeum, 10000,   rank(6)),  -- Blueprint: Psijic Banner
    [139496] = soldBy(nalirsewen, artaeum, 20000,   rank(9)),  -- Blueprint: Psijic Banner, Large
    [141822] = soldBy(nalirsewen, artaeum, 25000,   rank(9)),  -- Blueprint: Psijic Banner, Long
    [139487] = soldBy(nalirsewen, artaeum, 5000,    rank(1)),  -- Praxis: Book Row, Levitating
    [139488] = soldBy(nalirsewen, artaeum, 5000,    rank(1)),  -- Praxis: Book Stack, Levitating
    [139495] = soldBy(nalirsewen, artaeum, 20000,   rank(8)),  -- Praxis: Psijic Lighting Globe, Large
    [139491] = soldBy(nalirsewen, artaeum, 10000,   rank(4)),  -- Praxis: Psijic Lighting Globe, Small
    [139497] = soldBy(nalirsewen, artaeum, 100000,  rank(10)), -- Praxis: Psijic Table, Grand
    [139492] = soldBy(nalirsewen, artaeum, 20000,   rank(5)),  -- Praxis: Psijic Table, Scalloped
    [139494] = soldBy(nalirsewen, artaeum, 20000,   rank(7)),  -- Praxis: Psijic Table, Six-Fold Symmetry
}


local function getItemLink(itemId)
  return zo_strformat("|H1:item:<<1>>:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", itemId)
end

local function getRecipeResultItemId(recipeId)
  local recipeLink = getItemLink(recipeId)
  local resultLink = GetItemLinkRecipeResultItemLink(recipeLink)
  return GetItemLinkItemId(resultLink)
end

for versionNo, rolisRecipes in pairs(FurC.RolisRecipes) do
for recipeId, itemPrice in pairs(rolisRecipes) do
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, voucherColor)
    FurC.RecipeSources[recipeId] = zo_strformat(GetString(SI_FURC_STRING_Rolis), priceString)
  end
end


for versionNo, faustinaRecipes in pairs(FurC.FaustinaRecipes) do
  for recipeId, itemPrice in pairs(faustinaRecipes) do
    local unsurpassedCrafter = GetAchievementLink(1801)
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, voucherColor)
    local soldByFaustinaFor = zo_strformat(GetString(SI_FURC_STRING_FAUSTINA), priceString)
    FurC.RecipeSources[recipeId] = soldByFaustinaFor .. requires .. unsurpassedCrafter
  end
end

