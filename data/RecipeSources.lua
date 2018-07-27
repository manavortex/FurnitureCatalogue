local vendorColor 	= FurC.Const.vendorColor
local goldColor 	= FurC.Const.goldColor
local voucherColor	= FurC.Const.voucherColor

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
        colorise(vendorName, 	vendorColor, stripColor),
        colorise(locationName, 	vendorColor, stripColor),
        colorise(price, 	    goldColor, stripColor),
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
    [139487] = soldBy(nalirsewen, artaeum, 5000,    rank(1)),  -- Praxis: Book Row, Levitating
    [139488] = soldBy(nalirsewen, artaeum, 5000,    rank(1)),  -- Praxis: Book Stack, Levitating
    [139495] = soldBy(nalirsewen, artaeum, 20000,   rank(8)),  -- Praxis: Psijic Lighting Globe, Large
    [139491] = soldBy(nalirsewen, artaeum, 10000,   rank(4)),  -- Praxis: Psijic Lighting Globe, Small
    [139497] = soldBy(nalirsewen, artaeum, 100000,  rank(10)), -- Praxis: Psijic Table, Grand
    [139492] = soldBy(nalirsewen, artaeum, 20000,   rank(5)),  -- Praxis: Psijic Table, Scalloped
    [139494] = soldBy(nalirsewen, artaeum, 20000,   rank(7)),  -- Praxis: Psijic Table, Six-Fold Symmetry
}

local rolisRecipes = {
    [134987] = 125, -- Blueprint: Hlaalu Gaming Table, "Foxes & Felines"
    [134986] = 125, -- Design: Miniature Garden, Bottled
    [134983] = 125, -- Diagram: Hlaalu Gong
    [134984] = 125, -- Pattern: Clothier's Form, Brass
    [126582] = 275, -- Praxis: Target Centurion, Dwarf-Brass
    [126583] = 450, -- Praxis: Target Centurion, Robust Refabricated
    [119592] = 125, -- Praxis: Target Skeleton, Humanoid
    [121315] = 200, -- Praxis: Target Skeleton, Robust Humanoid
    [139486] = 125, -- Sketch: High Elf Ancestor Clock, Celestial
}
local faustinaRecipes = {
    [121200] = 100, -- Blueprint: Cabinet, Poisonmaker's
    [121166] = 100, -- Blueprint: Podium, Skinning
    [132195] = 100, -- Blueprint: Telvanni Candelabra, Masterwork
    [121168] = 100, -- Blueprint: Tools, Case
    [132194] = 100, -- Design: Mammoth Cheese, Mastercrafted
    [121199] = 100, -- Design: Mortar and Pestle
    [121214] = 100, -- Design: Orcish Skull Goblet, Full
    [121163] = 100, -- Diagram: Apparatus, Boiler
    [121165] = 100, -- Diagram: Apparatus, Gem Calipers
    [132191] = 100, -- Diagram: Dwarven Gyroscope, Masterwork
    [121197] = 100, -- Formula: Bottle, Poison Elixir
    [121164] = 100, -- Formula: Case of Vials
    [132190] = 100, -- Formula: Mages Apparatus, Master
    [132192] = 100, -- Pattern: Dres Sewing Kit, Master's
    [121209] = 100, -- Pattern: Orcish Tapestry, Spear
    [132193] = 100, -- Praxis: Hlaalu Bath Tub, Masterwork
    [121207] = 100, -- Praxis: Orcish Table with Fur
    [134986] = 100, -- Design: Miniature Garden, Bottled
    [134982] = 100, -- Formula: Alchemical Apparatus, Master
    [134984] = 100, -- Pattern: Clothier's Form, Brass
    [134985] = 100, -- Praxis: Hlaalu Trinket Box, Curious Turtle

}

for itemId, itemPrice in pairs(rolisRecipes) do
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, voucherColor)
    FurC.RecipeSources[itemId] = zo_strformat(GetString(SI_FURC_STRING_Rolis), priceString)
end


for itemId, itemPrice in pairs(faustinaRecipes) do
    local unsurpassedCrafter = GetAchievementLink(1801)
    local priceString = zo_strformat(GetString(SI_FURC_STRING_FOR_VOUCHERS), itemPrice, voucherColor)
    local soldByFaustinaFor = zo_strformat(GetString(SI_FURC_STRING_FAUSTINA), priceString)
    FurC.RecipeSources[itemId] = soldByFaustinaFor .. requires .. unsurpassedCrafter
end

