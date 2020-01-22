-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

--[[

Any "zombie survival" gamemode specific code goes in here

]]

-- XP rewards for players getting points
hook.Add("PlayerPointsAdded", "D3stats_ZS_PlayerPointsAdded", function (ply, points)
	if points <= D3stats.PlayerPointsAdded_Limit then
		ply:D3stats_AddXP(points)
	end
end)

-- XP rewards for zombies killing humans
hook.Add("PostZombieKilledHuman", "D3stats_ZS_PostZombieKilledHuman", function (ply, attacker, dmginfo, headshot, wassuicide)
	local reward = D3stats.ZombieKilledHuman_Static + D3stats.ZombieKilledHuman_Fraction * ply:Frags()
	
	reward = math.Clamp(reward, D3stats.ZombieKilledHuman_Min, D3stats.ZombieKilledHuman_Max)
	
	attacker:D3stats_AddXP(reward)
end)

-- Message on levelchange
hook.Add("D3stats_LevelChanged", "D3stats_ZS_LevelChanged", function (ply, oldLevel, Level)
	if Level > oldLevel then
		ply:CenterNotify(Color(0, 255, 255), string.format(D3stats.Message.Level_Ascended, Level, D3stats.Levels[Level].Name))
	else
		ply:CenterNotify(Color(0, 255, 255), string.format(D3stats.Message.Level_Changed, Level, D3stats.Levels[Level].Name))
	end
end)

-- Handle "Use_Hammer" permission. TODO: Only prevent that the person can nail things
hook.Add("PlayerSwitchWeapon", "D3stats_ZS_EquipHammer", function(ply, oldWeapon, newWeapon)
	local Class = newWeapon:GetClass()
	
	if Class == "weapon_zs_hammer" or Class == "weapon_zs_electrohammer" then
		if not ply:D3stats_HasPermission("Use_Hammer") then
			ply:CenterNotify(Color(255, 0, 0), string.format(D3stats.Message.Disallow_Hold_Hammer, D3stats.GetPermissionLevel("Use_Hammer")))
			return true
		end
	end
end)

-- Handle EndRound events for statistics
hook.Add("EndRound", "D3stats_ZS_EndRound", function(team)
	if D3stats.RoundEnded then return end
	D3stats.RoundEnded = true
	
	local won = (TEAM_SURVIVORS == team) and true or false
	
	D3stats.Map_End(won)
end)

-- Reset stuff on a new game
hook.Add("DoRestartGame", "D3stats_ZS_DoRestartGame", function()
	D3stats.RoundEnded = nil
end)

-- Display map statistics message when a player joins
hook.Add("PlayerReady", "D3stats_Map_PlayerReady", function (ply)
	D3stats.Map_Message(false, ply)
end)