--[[
	HOW TO UPDATE FURNITURE CATALOGUE FUR A NEW GAME VERSION

	1. 	Create the file data\$(APIVersion).lua. You can see the API version for the current patch
		by calling `GetAPIVersion()` ingame

	2. A
}}

local tblIndex = FURC_KITTY

FurC.Recipes[tblIndex] = {
  152064,  -- Elsweyr Table, Low Square,
  152065,  -- Elsweyr Desk, Elegant Wooden,
}

FurC.MiscItemSources[tblIndex]  = {
  [FURC_RUMOUR]   = {

  },

  [FURC_JUSTICE] = {

  },

  [FURC_DROP]    = {

  },

  [FURC_CROWN]  = {


  },
  [FURC_FISHING]   = {

  },

}
-- ]]
