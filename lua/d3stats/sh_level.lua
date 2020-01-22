-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Calculate the level from the given XP
function D3stats.CalculateLevel(XP)
	local Level = 1
	
	for key, value in pairs(D3stats.Levels) do
		if value.XP_needed <= XP then
			Level = key
		else
			break
		end
	end
	
	return Level
end

-- Check if the level has the given permission
function D3stats.LevelCheckPermission(Level, Permission)
	local Granted = false
	
	-- If the permission is not on the list, allow it
	if not D3stats.Permissions[Permission] then
		return true
	end
	
	for key, value in pairs(D3stats.Levels) do
		if key <= Level then
			if value.Permissions and value.Permissions[Permission] then
				Granted = value.Permissions[Permission]
			end
		else
			break
		end
	end
	
	return Granted
end

-- Returns what level is needed for the given permission
function D3stats.GetPermissionLevel(Permission)
	local Level
	
	if not D3stats.Permissions[Permission] then
		return 1
	end
	
	for key, value in pairs(D3stats.Levels) do
		if value.Permissions and value.Permissions[Permission] then
			return key
		end
	end
	
	return nil
end

-- Count the amount of online players who have the permission
if SERVER then
	function D3stats.CountPermissionPlayers(Permission, Team)
		local Counter = 0
		
		local players = player.GetAll()
		for key, ply in pairs(players) do
			if Team == nil or ply:Team() == Team then
				if D3stats.LevelCheckPermission(ply:D3stats_GetLevel(), Permission) == true then
					Counter = Counter + 1
				end
			end
		end
		
		return Counter
	end
end