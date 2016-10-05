--[[

Settings and level definitions are stored in here

]]

-- Permissions
--	AllowIfLessThan: If the amount of players who have the permission is lower than this number, allow it anyways
d3stats.Permissions = {
	["Buy_Hammer"] = { AllowIfLessThan = 2 },
	["Use_Hammer"] = { AllowIfLessThan = 2 },
}

-- Levels, please sort by XP
d3stats.Levels = {
	{ XP_needed =       0, Name = "Kleiner" },
	{ XP_needed =     500, Name = "Lesser Kleiner" },
	{ XP_needed =    1000, Name = "Dayfly" },
	{ XP_needed =    2000, Name = "Apprentice", Permissions = { ["Buy_Hammer"] = true, ["Use_Hammer"] = true } },
	{ XP_needed =    3000, Name = "Adventurer" },
	{ XP_needed =    4000, Name = "Scout" },
	{ XP_needed =    5000, Name = "Guardian" },
	{ XP_needed =    6000, Name = "Fighter" },
	{ XP_needed =    7000, Name = "Brawler" },
	{ XP_needed =    8000, Name = "Scrapper" },
	{ XP_needed =    9000, Name = "Skirmisher" },
	{ XP_needed =   10000, Name = "Battler" },
	{ XP_needed =   15000, Name = "Marauder" },
	{ XP_needed =   20000, Name = "Slayer" },
	{ XP_needed =   25000, Name = "Mercenary" },
	{ XP_needed =   30000, Name = "Swordsman" },
	{ XP_needed =   35000, Name = "Freelancer" },
	{ XP_needed =   40000, Name = "Swashbuckler" },
	{ XP_needed =   45000, Name = "Vanquisher" },
	{ XP_needed =   50000, Name = "Exemplar" },
	{ XP_needed =   60000, Name = "Conqueror" },
	{ XP_needed =   70000, Name = "Specialist" },
	{ XP_needed =   80000, Name = "Lieutenant" },
	{ XP_needed =   90000, Name = "Captain" },
	{ XP_needed =  100000, Name = "Major" },
	{ XP_needed =  133333, Name = "Colonel" },
	{ XP_needed =  166666, Name = "General" },
	{ XP_needed =  200000, Name = "Champion" },
	{ XP_needed =  250000, Name = "Hero" },
	{ XP_needed =  300000, Name = "Legend" },
	{ XP_needed =  500000, Name = "Demigod" },
	{ XP_needed = 1000000, Name = "God" },
}

d3stats.PlayerPointsAdded_Limit = 200		-- Ignore all "PlayerPointsAdded" callbacks above this XP value

-- Zombie reward is calculated as follows:	Reward = math.clamp( Static + Fraction * Human_Points, Min, Max )
d3stats.ZombieKilledHuman_Fraction = 1.0	-- Amount of XP a zombie gets of the killed humans points
d3stats.ZombieKilledHuman_Static = 100		-- Amount of XP a zombie gets for killing a human
d3stats.ZombieKilledHuman_Max = 1000		-- Upper XP reward clamp
d3stats.ZombieKilledHuman_Min = 0			-- Lower XP reward clamp