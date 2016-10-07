-- Calculate the level from the given XP
function d3stats.CalculateLevel( XP )
	local Level = 1
	
	for key, value in pairs(d3stats.Levels) do
		if value.XP_needed <= XP then
			Level = key
		else
			break
		end
	end
	
	return Level
end

-- Check if the level has the given permission
function d3stats.LevelCheckPermission( Level, Permission )
	local Granted = false
	
	for key, value in pairs(d3stats.Levels) do
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

-- Count the amount of online players who have the permission
if SERVER then
	function d3stats.CountPermissionPlayers( Permission, Team )
		local Counter = 0
		
		local players = player.GetAll()
		for key, ply in pairs( players ) do
			if Team == nil or pl:Team() == Team then
				if d3stats.LevelCheckPermission( ply:D3Stats_GetLevel(), Permission ) == true then
					Counter = Counter + 1
				end
			end
		end
		
		return Counter
	end
end