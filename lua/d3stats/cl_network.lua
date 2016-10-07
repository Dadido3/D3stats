net.Receive( "D3Stats_UpdateXP", function()
	local XP = net.ReadUInt( 32 )
	
	--print( "XP update: " .. tostring(XP))
	
	if d3stats and d3stats.D3StatsOverlay then
		d3stats.D3StatsOverlay:StatsUpdate( XP, d3stats.CalculateLevel( XP ) )
	end
end )