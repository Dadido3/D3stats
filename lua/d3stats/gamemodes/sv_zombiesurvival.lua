--[[

Any "zombie survival" gamemode specific code goes in here

]]

-- XP rewards for players getting points
hook.Add( "PlayerPointsAdded", "D3Stats_ZS_PlayerPointsAdded", function ( ply, points )
	if points <= d3stats.PlayerPointsAdded_Limit then
		ply:D3Stats_AddXP( points )
	end
end )

-- XP rewards for zombies killing humans
hook.Add( "PostZombieKilledHuman", "D3Stats_ZS_PostZombieKilledHuman", function ( ply, attacker, dmginfo, headshot, wassuicide )
	local reward = d3stats.ZombieKilledHuman_Static + d3stats.ZombieKilledHuman_Fraction * ply:Frags()
	
	reward = math.Clamp( reward, d3stats.ZombieKilledHuman_Min, d3stats.ZombieKilledHuman_Max )
	
	attacker:D3Stats_AddXP( reward )
end )

-- Message on levelchange
hook.Add( "D3Stats_LevelChanged", "D3Stats_ZS_LevelChanged", function ( ply, oldLevel, Level )
	ply:CenterNotify( Color( 0, 255, 255 ), "You ascended to level " .. tostring( Level ) .. " \"" .. d3stats.Levels[Level].Name .. "\"")
end )