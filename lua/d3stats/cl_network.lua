net.Receive( "D3Stats_UpdateXP", function()
	local XP = net.ReadUInt( 32 )
	
	--print( "XP update: " .. tostring(XP))
	
	if d3stats and d3stats.D3StatsOverlay then
		d3stats.D3StatsOverlay:StatsUpdate( XP, d3stats.CalculateLevel( XP ) )
	end
end )

net.Receive( "D3Stats_UpdateLevels", function()
	local players = net.ReadUInt( 16 )
	
	for i = 1, players do
		local ply = net.ReadEntity()
		local Level = net.ReadUInt( 16 )
		ply.D3Stats_Level = Level
		--print( "Level update: " .. tostring(ply) .." --> " .. tostring(Level))
	end
end )

net.Receive( "D3Stats_BroadcastLevel", function()
	local ply = net.ReadEntity()
	local Level = net.ReadUInt( 16 )
	
	ply.D3Stats_Level = Level
	
	--print( "Level broadcast: " .. tostring(ply) .." --> " .. tostring(Level))
end )