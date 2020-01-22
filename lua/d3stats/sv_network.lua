-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

util.AddNetworkString("D3stats_UpdateXP")

local meta = FindMetaTable("Player")
if not meta then return end

-- Send the XP of this (self) player to itself
function meta:D3stats_Net_UpdateXP()
	net.Start("D3stats_UpdateXP")
	net.WriteUInt(self:D3stats_GetXP(), 32)
	net.Send(self)
end
