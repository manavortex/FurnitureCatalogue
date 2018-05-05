
local vendorColor 	= "d68957"
local goldColor 	= "e5da40"
local apColor 		= "25C31E"
local tvColor		= "5EA4FF"
local voucherColor	= "82BCFF"
local p 			= FurC.DebugOut -- debug function calling zo_strformat with up to 10 args 

local function colorise(str, col, ret)
	str = tostring(str)
	if str:find("%d000$") then str = str:gsub("000$", "k") end
	if ret then return str end
	return string.format("|c%s%s|r", col, str)
end
local requires = GetString(SI_FURC_REQUIRES_ACHIEVEMENT)
local psijicRank = GetString(SI_FURC_PSIJIC_RANK)
local function rank(aNumber)
    return requires .. psijicRank .. aNumber
end

local function soldBy(vendorName, locationName, price, requirement)
    return zo_strformat(
        GetString(SI_FURC_STRING_VENDOR), 
        colorise(vendorName, 	vendorColor, stripColor), 
        colorise(locationName, 	vendorColor, stripColor), 
        colorise(price, 	    goldColor, stripColor),
        requirement
    )
end
local artaeum = GetString(FURC_AV_ARTAEUM)
local nalirsewen = GetString(FURC_AV_NAL)

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