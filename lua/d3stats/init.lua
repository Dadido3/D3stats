--[[

XP and statistics addon for the "Zombie Survival" gamemode
by David Vogel (Dadido3)

]]

d3stats = d3stats or {}

AddCSLuaFile( "sh_settings.lua" )
AddCSLuaFile( "sh_level.lua" )
AddCSLuaFile( "sh_concommand.lua" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_network.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "vgui/overlay.lua" )

include( "sh_settings.lua" )
include( "sh_level.lua" )
include( "sh_concommand.lua" )

include( "sv_network.lua" )

-- XP rewards for players getting points
hook.Add( "PlayerPointsAdded", "D3Stats_PlayerPointsAdded", function ( ply, points )
	if points <= d3stats.PlayerPointsAdded_Limit then
		ply:D3Stats_AddXP( points )
	end
end )

-- XP rewards for zombies killing humans
hook.Add( "PostZombieKilledHuman", "D3Stats_PostZombieKilledHuman", function ( ply, attacker, dmginfo, headshot, wassuicide )
	local reward = d3stats.ZombieKilledHuman_Static + d3stats.ZombieKilledHuman_Fraction * ply:GetPoints()
	
	reward = math.Clamp( reward, d3stats.ZombieKilledHuman_Min, d3stats.ZombieKilledHuman_Max )
	
	attacker:D3Stats_AddXP( reward )
end )

hook.Add( "PlayerReady", "D3Stats_PlayerReady", function ( ply ) -- TODO: Find a better method than using the PlayerReady hook
	-- Send all the levels of the other players to ply
	ply:D3Stats_Net_UpdateLevels()
end )

hook.Add( "PlayerSpawn", "D3Stats_PlayerSpawn", function ( ply )
	-- Send its own XP
	ply:D3Stats_Net_UpdateXP()
	
	-- Broadcast the own level to others
	ply.D3Stats_Level = ply:D3Stats_GetLevel()
	ply:D3Stats_Net_BroadcastLevel( ply.D3Stats_Level )
end )

local meta = FindMetaTable( "Player" )
if not meta then return end

function meta:D3Stats_GetXP()
	local XP = tonumber( self:GetPData( "D3Stats_XP", "0" ) )
	
	if not XP then
		XP = 0
	end
	
	return XP
end

function meta:D3Stats_SetXP( XP )
	if not XP then
		XP = 0
	end
	
	self:SetPData( "D3Stats_XP", tostring( XP ) )
	
	self:D3Stats_Net_UpdateXP()
	
	-- Broadcast on level change
	local Level = self:D3Stats_GetLevel()
	if self.D3Stats_Level and self.D3Stats_Level ~= Level then
		self.D3Stats_Level = Level
		self:D3Stats_Net_BroadcastLevel( Level )
		self:CenterNotify( Color( 0, 255, 255 ), "You ascended to level " .. tostring( Level ) .. " \"" .. d3stats.Levels[Level].Name .. "\"")
	end
	self.D3Stats_Level = Level
end

function meta:D3Stats_AddXP( XP )
	if not XP then
		XP = 0
	end
	
	self:D3Stats_SetXP( self:D3Stats_GetXP() + XP )
end

function meta:D3Stats_GetLevel()
	return d3stats.CalculateLevel( self:D3Stats_GetXP() )
end

-- Check if the players level has the permission
function meta:D3Stats_HasPermission( Permission )
	
	-- If no one else has this permission, allow it
	if d3stats.Permissions[Permission] and d3stats.Permissions[Permission].AllowIfLessThan and d3stats.Permissions[Permission].AllowIfLessThan > d3stats.CountPermissionPlayers( Permission ) then
		return true
	end
	
	return d3stats.LevelCheckPermission( self:D3Stats_GetLevel(), Permission )
end