function d3stats.Map_Message( roundend, ply )
	local map = game.GetMap()
	local count, wins, avg_players = d3stats.Storage.Map_Get( map )
	
	local Message
	if count > 0 then
		if roundend == true then
			Message = string.format( d3stats.Message.MapStats_End, map, wins, count, wins / count * 100 )
		else
			Message = string.format( d3stats.Message.MapStats, map, wins, count, wins / count * 100 )
		end
	else
		Message = string.format( d3stats.Message.MapStats_Zero, map )
	end
		
	if ply then
		ply:ChatPrint( Message )
	else
		PrintMessage( HUD_PRINTTALK, Message )
	end
end

function d3stats.Map_End( won )
	local map = game.GetMap()
	local players = #player.GetAll()
	
	if players > 0 then
		d3stats.Storage.Map_AddOutcome( map, won, players )
		d3stats.Map_Message( true )
	end
end

--d3stats.Map_End( false )

--d3stats.Map_Message( false, player.GetByID(1) )