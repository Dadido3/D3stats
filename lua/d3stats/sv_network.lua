util.AddNetworkString( "D3Stats_UpdateXP" )
util.AddNetworkString( "D3Stats_UpdateLevels" )
util.AddNetworkString( "D3Stats_BroadcastLevel" )

local meta = FindMetaTable( "Player" )
if not meta then return end

-- Send the XP of this (self) player to itself
function meta:D3Stats_Net_UpdateXP()
	net.Start( "D3Stats_UpdateXP" )
	net.WriteUInt( self:D3Stats_GetXP(), 32 )
	net.Send( self )
end

-- Send all player levels to this (self) player
function meta:D3Stats_Net_UpdateLevels()
	net.Start( "D3Stats_UpdateLevels" )
	
	local players = player.GetAll()
	
	net.WriteUInt( table.getn( players ), 16 )
	for k, ply in pairs( players ) do
		net.WriteEntity( ply )
		net.WriteUInt( ply:D3Stats_GetLevel(), 16 )
	end
	net.Send( self )
end

-- Send the current level of this (self) player to everyone
function meta:D3Stats_Net_BroadcastLevel( Level )
	net.Start( "D3Stats_BroadcastLevel" )
	net.WriteEntity( self )
	net.WriteUInt( Level, 16 )
	net.Broadcast()
end