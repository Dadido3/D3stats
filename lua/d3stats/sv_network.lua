util.AddNetworkString( "D3Stats_UpdateXP" )

local meta = FindMetaTable( "Player" )
if not meta then return end

-- Send the XP of this (self) player to itself
function meta:D3Stats_Net_UpdateXP()
	net.Start( "D3Stats_UpdateXP" )
	net.WriteUInt( self:D3Stats_GetXP(), 32 )
	net.Send( self )
end
