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
	if Level > oldLevel then
		ply:CenterNotify( Color( 0, 255, 255 ), string.format( d3stats.Message.Level_Ascended, Level, d3stats.Levels[Level].Name ) )
	else
		ply:CenterNotify( Color( 0, 255, 255 ), string.format( d3stats.Message.Level_Changed, Level, d3stats.Levels[Level].Name ) )
	end
end )

-- Handle "Use_Hammer" permission. TODO: Only prevent that the person can nail things
hook.Add( "PlayerSwitchWeapon", "D3Stats_ZS_EquipHammer", function( ply, oldWeapon, newWeapon )
	local Class = newWeapon:GetClass()
	
	if Class == "weapon_zs_hammer" or Class == "weapon_zs_electrohammer" then
		if not ply:D3Stats_HasPermission( "Use_Hammer" ) then
			ply:CenterNotify( Color( 255, 0, 0 ), string.format( d3stats.Message.Disallow_Hold_Hammer, d3stats.GetPermissionLevel( "Use_Hammer" ) ) )
			return true
		end
	end
end )

-- Handle EndRound events for statistics
hook.Add( "EndRound", "D3Stats_ZS_EndRound", function( team )
	local won = ( TEAM_SURVIVORS == team ) and true or false
	
	d3stats.Map_End( won )
end )

-- Display map statistic message when the player joined
hook.Add( "PlayerReady", "D3Stats_Map_PlayerReady", function ( ply )
	d3stats.Map_Message( false, ply )
end )