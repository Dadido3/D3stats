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

include( "gamemodes/sv_zombiesurvival.lua" )
include( "sv_network.lua" )

hook.Add( "PlayerInitialSpawn", "D3Stats_PlayerSpawn", function ( ply )
	-- Send its own XP
	ply:D3Stats_Net_UpdateXP()
	
	-- Store level as network and local player variable
	ply.D3Stats_Level = d3stats.CalculateLevel( ply:D3Stats_GetXP() )
	ply:SetNWInt( "D3Stats_Level", ply.D3Stats_Level )
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
	
	-- Update network variable and send message on level change
	local Level = d3stats.CalculateLevel( XP )
	if self.D3Stats_Level and self.D3Stats_Level ~= Level then
		self:SetNWInt( "D3Stats_Level", Level )
		hook.Call( "D3Stats_LevelChanged" , nil, self, self.D3Stats_Level, Level )
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
	return self.D3Stats_Level
end

-- Check if the players level has the permission
function meta:D3Stats_HasPermission( Permission )
	
	-- If there are too few players with this permission, allow it
	if d3stats.Permissions[Permission] and d3stats.Permissions[Permission].AllowIfLessThan and d3stats.Permissions[Permission].AllowIfLessThan > d3stats.CountPermissionPlayers( Permission, d3stats.Permissions[Permission].Team ) then
		return true
	end
	
	return d3stats.LevelCheckPermission( self:D3Stats_GetLevel(), Permission )
end