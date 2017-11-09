local db		= FurnitureCatalogue.settings["data"]
--	data recipeArray structure: 
--	[itemId] = {
--		["itemName"]		= name,
--		["blueprint"]		= itemLink,
--		["characters"]		= {},
--		["itemLink"]		= itemLink,
--		["numIngredients"]	= number,
--		["tradeskillType"]	= number,
--		["recipeListIndex"]	= number,
--		["recipeIndex"]		= number,
--		["source"]			= constant,
--		["ingredients"]	= {
--			[i1ItemLink]		= count,		
--			[i2ItemLink]		= count,		
--		},		
--	}

local function p(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	FurC.DebugOut(output, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
end

local function prefillChatBox(output, refresh)
	
	output = zo_strformat(output)
	if nil == output or "" == output then return end
	local editControl = CHAT_SYSTEM.textEntry.editControl
	
	if not refresh then 
		output = editControl:GetText() .. output	
	elseif CHAT_SYSTEM.textEntry.editControl:HasFocus() then
	editControl:Clear()		
	end
	
	
	-- trying to get rid of that double click error...
	if IsProtectedFunction("StartChatInput") then
		CallSecureProtected("StartChatInput", output)
	else
		StartChatInput(output)
	end
	
		
end
function FurC.ToChat(output, refresh)
	prefillChatBox(output, refresh)
end

local function stripColor(aString)
	if nil == aString then return "" end
	return aString:gsub("|%l%l%d%d%d%d%d", ""):gsub("|%l%l%d%l%l%d%d", ""):gsub("|c25C31E", ""):gsub("|r", "")
end

local function getNameFromEntry(recipeArray)	
	if nil == recipeArray then return "" end
	if nil == recipeArray.itemName and nil ~= recipeArray.itemLink then 
		recipeArray.itemName = GetItemLinkName(recipeArray.itemLink)
	end
	return recipeArray.itemName or ""
end

function FurC.PrintSource(itemLink, recipeArray)
	if nil == recipeArray then recipeArray = FurC.Find(itemLink) end
	if nil == recipeArray then return end
	
	local source = stripColor(recipeArray["source"])
	local output = zo_strformat("<<1>>: <<2>>", itemLink, source)
	if recipeArray.achievement and recipeArray.achievement ~= "" then
		output = output .. ", requires " .. recipeArray["achievement"]
	end	
		
	FurC.ToChat(output, true)
end

function FurC.FindByName(namePart)
	local ret = {}
	local itemName = ""
	-- d(zo_strformat("Looking for <<1>>... \n", namePart))
	for itemId, recipeArray in pairs(FurC.settings["data"]) do
		-- d(zo_strformat("<<1>>: <<2>> (<<3>>)", recipeArray.itemLink, getNameFromEntry(recipeArray), string.match(string.lower(getNameFromEntry(recipeArray)), string.lower(namePart))))
		if nil ~= string.match(string.lower(getNameFromEntry(recipeArray)), string.lower(namePart)) then 
			table.insert(ret, recipeArray)  
		end
	end
	return ret
end

local function capitalise(str)
	str = str:gsub("^(%l)(%w*)", function(a,b) return string.upper(a)..b end)
	return str
end

function FurC.GetMats(itemLink, forcePlaintext, forceItemLinks, recipeArray, matsOnly)
	recipeArray = recipeArray or FurC.Find(itemLink)

	local ingredients = ""
	
	if recipeArray.origin == FURC_CRAFTING then 
		
		local numIngredients 	= recipeArray.numIngredients or 0
		local ingredientArray 	= recipeArray.ingredients or {}
		
		forcePlaintext = (not forceItemLinks) and (forcePlaintext or NonContiguousCount(ingredientArray) > ((matsOnly and 3) or 4))
		
		
		for ingredientItemLink, qty in pairs(ingredientArray) do
			if forcePlaintext then ingredientItemLink = capitalise(GetItemLinkName(ingredientItemLink)) end
			ingredients = ingredients .. zo_strformat("<<1>>: <<2>>, ", ingredientItemLink, qty)
		end
		ingredients = ingredients:sub(1, -3)
	else
		ingredients = recipeArray["source"] 
	end
	return ingredients
end
local function getMats(itemLink, forcePlaintext, forceItemLinks, recipeArray, matsOnly) 
	return FurC.GetMats(itemLink, forcePlaintext, forceItemLinks, recipeArray, matsOnly) 
end

function FurC.PrintMats(itemLink, forcePlaintext, forceItemLinks, recipeArray, matsOnly)
	local mats = getMats(itemLink, forcePlaintext, forceItemLinks, recipeArray, matsOnly)
	if not mats or mats == "" then return end
	prefillChatBox(mats)	
end


function FurC.PrintRecipe(itemLink, recipeArray)	
	if nil == recipeArray then recipeArray = FurC.Find(itemLink) end
	if nil == recipeArray then 
		return prefillChatBox(itemLink)
	end
	
	local ingredients = getMats(itemLink, false, false, recipeArray)
	if not recipeArray.craftable then ingredients = stripColor(ingredients) end
	
	prefillChatBox(zo_strformat("<<1>>: <<2>>", recipeArray.itemLink, ingredients))
end