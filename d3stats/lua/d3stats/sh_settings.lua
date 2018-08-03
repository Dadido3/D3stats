--[[

Settings and level definitions are stored in here

]]

-- Permissions
--  - Everything not in this list will be allowed by default
--	- AllowIfLessThan: If the amount of players who have the permission is lower than this number, allow it anyway
--  - Team: AllowIfLessThan only counts the specified team. In ZS: TEAM_SURVIVOR = 4,
D3stats.Permissions = {
	--["Buy_Hammer"] = {AllowIfLessThan = 4, Team = 4},
	--["Use_Hammer"] = {AllowIfLessThan = 4, Team = 4},
}

-- Levels, please sort by XP
D3stats.Levels = {
	{ XP_needed =    500, Name = "Kleiner" },
	{ XP_needed =   1370, Name = "Survivor" },
	{ XP_needed =   2612, Name = "Helper" },
	{ XP_needed =   4225, Name = "Engineer", Permissions = { ["Buy_Hammer"] = true, ["Use_Hammer"] = true } },
	{ XP_needed =   6209, Name = "Scout" },
	{ XP_needed =   8564, Name = "Officer" },
	{ XP_needed =  11290, Name = "Guardian" },
	{ XP_needed =  14387, Name = "Fighter" },
	{ XP_needed =  17854, Name = "Brawler" },
	{ XP_needed =  21693, Name = "Scrapper" },
	{ XP_needed =  25903, Name = "Skirmisher" },
	{ XP_needed =  30483, Name = "Battler" },
	{ XP_needed =  35435, Name = "Marauder" },
	{ XP_needed =  40758, Name = "Slayer" },
	{ XP_needed =  46451, Name = "Mercenary" },
	{ XP_needed =  52516, Name = "Swordsman" },
	{ XP_needed =  58951, Name = "Freelancer" },
	{ XP_needed =  65758, Name = "Swashbuckler" },
	{ XP_needed =  72935, Name = "Vanquisher" },
	{ XP_needed =  80483, Name = "Exemplar" },
	{ XP_needed =  88403, Name = "Conqueror" },
	{ XP_needed =  96693, Name = "Specialist" },
	{ XP_needed = 105354, Name = "Lieutenant" },
	{ XP_needed = 114387, Name = "Captain" },
	{ XP_needed = 123790, Name = "Major" },
	{ XP_needed = 133564, Name = "Colonel" },
	{ XP_needed = 143709, Name = "General" },
	{ XP_needed = 154225, Name = "Champion" },
	{ XP_needed = 165112, Name = "Hero" },
	{ XP_needed = 176370, Name = "Legend" },
	{ XP_needed = 188000, Name = "Demigod" },
	{ XP_needed = 200000, Name = "God" },
}

-- Human reward settings
D3stats.PlayerPointsAdded_Limit = 200		-- Ignore all "PlayerPointsAdded" callbacks above this XP value

-- Zombie reward is calculated as follows:	Reward = math.clamp(Static + Fraction * Human_Points, Min, Max)
D3stats.ZombieKilledHuman_Fraction = 1.0	-- Amount of XP a zombie gets of the killed humans points
D3stats.ZombieKilledHuman_Static = 100		-- Amount of XP a zombie gets for killing a human
D3stats.ZombieKilledHuman_Max = 1000		-- Upper XP reward clamp
D3stats.ZombieKilledHuman_Min = 0			-- Lower XP reward clamp

-- Messages TODO: Multilanguage
D3stats.Message = {}
D3stats.Message.Level_Ascended = "You ascended to level %i \"%s\""
D3stats.Message.Level_Changed = "Your level changed to level %i \"%s\""
D3stats.Message.Disallow_Hold_Hammer = "You can't use the hammer until you have reached level %i"
D3stats.Message.MapStats_Zero = "We are playing %s."									-- Message to players who just joined
D3stats.Message.MapStats = "We are playing %s. Humans won %i of %i times (%.1f%%)"		-- Message to players who just joined (With statistics)
D3stats.Message.MapStats_End = "%s has been won %i of %i times (%.1f%%)"				-- Message to all players at the end of the round (With statistics)

if CLIENT then
	-- Overlay positions
	D3stats.Overlay_X = 0
	D3stats.Overlay_Y = 80 * math.Clamp(ScrH() / 1080, 0.6, 1) -- This needs to be redone
	
	-- Fonts
	surface.CreateFont("D3stats_OverlayFont_XP", {
		font = "Ghoulish Fright AOE",
		extended = false,
		size = 22,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
	surface.CreateFont("D3stats_OverlayFont_Level", {
		font = "Haunt AOE",
		extended = false,
		size = 26,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true,
	})
	
	D3stats.Font_Overlay_XP = "D3stats_OverlayFont_XP"
	D3stats.Font_Overlay_Level = "D3stats_OverlayFont_Level"
	D3stats.Font_TargetID = "ZSHUDFontTiny"			-- Use ZS Font
end