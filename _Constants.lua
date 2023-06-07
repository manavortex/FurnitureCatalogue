-- constants for filtering
-- item sources
FURC_NONE				= 1
FURC_RUMOUR				= FURC_NONE +1				 -- 2
FURC_FAVE				= FURC_RUMOUR +1              -- 3
FURC_CRAFTING			= FURC_FAVE +1				 -- 4
FURC_CRAFTING_KNOWN		= FURC_CRAFTING +1            -- 5
FURC_CRAFTING_UNKNOWN	= FURC_CRAFTING_KNOWN +1      -- 6
FURC_VENDOR				= FURC_CRAFTING_UNKNOWN +1    -- 7
FURC_PVP				= FURC_VENDOR +1              -- 8
FURC_CROWN				= FURC_PVP +1				  -- 9
FURC_LUXURY				= FURC_CROWN +1				-- 10
FURC_OTHER				= FURC_LUXURY +1              -- 12
FURC_ROLIS				= FURC_OTHER +1				-- 13
FURC_DROP				= FURC_ROLIS +1				-- 14
FURC_WRIT_VENDOR		= FURC_DROP +1				 -- 15
FURC_JUSTICE			= FURC_WRIT_VENDOR +1         -- 16
FURC_FISHING			= FURC_JUSTICE +1             -- 17
FURC_GUILDSTORE			= FURC_FISHING +1             -- 18
FURC_FESTIVAL_DROP		= FURC_GUILDSTORE +1          -- 19
FURC_EMPTY_STRING		= ""

-- versioning
FURC_HOMESTEAD			= 2				          -- 2
FURC_MORROWIND			= FURC_HOMESTEAD  +1        -- 3
FURC_REACH				= FURC_MORROWIND  +1        -- 4
FURC_CLOCKWORK			= FURC_REACH      +1        -- 5
FURC_DRAGONS			= FURC_CLOCKWORK  +1        -- 6
FURC_ALTMER				= FURC_DRAGONS    +1        -- 7
FURC_WEREWOLF			= FURC_ALTMER     +1        -- 8
FURC_SLAVES				= FURC_WEREWOLF   +1        -- 9
FURC_WOTL				= FURC_SLAVES     +1        -- 10
FURC_KITTY				= FURC_WOTL       +1        -- 11
FURC_SCALES				= FURC_KITTY      +1        -- 12
FURC_DRAGON2			= FURC_SCALES     +1        -- 13
FURC_HARROW				= FURC_DRAGON2    +1        -- 14
FURC_SKYRIM				= FURC_HARROW     +1        -- 15
FURC_STONET				= FURC_SKYRIM     +1        -- 16
FURC_MARKAT				= FURC_STONET     +1        -- 17
FURC_FLAMES				= FURC_MARKAT     +1        -- 18
FURC_BLACKW				= FURC_FLAMES     +1        -- 19
FURC_DEADL				= FURC_BLACKW     +1        -- 20
FURC_TIDES				= FURC_DEADL	  +1		-- 21
FURC_BRETON				= FURC_TIDES	  +1		-- 22
FURC_DEPTHS				= FURC_BRETON	  +1		-- 23
FURC_DRUID				= FURC_DEPTHS	  +1		-- 24
FURC_SCRIBE				= FURC_DRUID	  +1		-- 25
FURC_NECROM				= FURC_SCRIBE	  +1		-- 26

FURC_LATEST				= FURC_NECROM