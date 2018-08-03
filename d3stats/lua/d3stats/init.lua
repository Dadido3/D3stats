--[[

XP and statistics addon for the "Zombie Survival" gamemode
by David Vogel (Dadido3)

]]

D3stats = D3stats or {}

AddCSLuaFile("sh_settings.lua")
AddCSLuaFile("sh_level.lua")
AddCSLuaFile("sh_concommand.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_network.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("vgui/overlay.lua")

include("sh_settings.lua")
include("sh_level.lua")
include("sh_concommand.lua")

include("gamemodes/sv_zombiesurvival.lua")
include("sv_storage.lua")
include("sv_map.lua")
include("sv_network.lua")

hook.Add("PlayerInitialSpawn", "D3stats_PlayerSpawn", function (ply)
	-- Send its own XP
	ply:D3stats_Net_UpdateXP()
	
	-- Store level as network and local player variable
	ply.D3stats_Level = D3stats.CalculateLevel(ply:D3stats_GetXP())
	ply:SetNWInt("D3stats_Level", ply.D3stats_Level)
end)

-- Initialisation
hook.Add("Initialize", "D3stats_Init", function ()
	D3stats.Storage.Initialize()
	
	resource.AddFile("resource/fonts/ghoulfriaoe.ttf")
	resource.AddFile("resource/fonts/hauntaoe.ttf")
	resource.AddFile("resource/fonts/nightaoe.ttf")
end)

local meta = FindMetaTable("Player")
if not meta then return end

function meta:D3stats_GetXP()
	local XP = tonumber(self:GetPData("D3stats_XP", "0"))
	
	if not XP then
		XP = 0
	end
	
	return XP
end

function meta:D3stats_SetXP(XP)
	if not XP then
		XP = 0
	end
	
	self:SetPData("D3stats_XP", tostring(XP))
	
	self:D3stats_Net_UpdateXP()
	
	-- Update network variable and send message on level change
	local Level = D3stats.CalculateLevel(XP)
	if self.D3stats_Level and self.D3stats_Level ~= Level then
		self:SetNWInt("D3stats_Level", Level)
		hook.Call("D3stats_LevelChanged" , nil, self, self.D3stats_Level, Level)
	end
	self.D3stats_Level = Level
end

function meta:D3stats_AddXP(XP)
	if not XP then
		XP = 0
	end
	
	self:D3stats_SetXP(self:D3stats_GetXP() + XP)
end

function meta:D3stats_GetLevel()
	return self.D3stats_Level
end

-- Check if the players level has the permission
function meta:D3stats_HasPermission(Permission)
	
	-- If there are too few players with this permission, allow it anyway
	if D3stats.Permissions[Permission] and D3stats.Permissions[Permission].AllowIfLessThan and D3stats.Permissions[Permission].AllowIfLessThan > D3stats.CountPermissionPlayers(Permission, D3stats.Permissions[Permission].Team) then
		return true
	end
	
	return D3stats.LevelCheckPermission(self:D3stats_GetLevel(), Permission)
end
