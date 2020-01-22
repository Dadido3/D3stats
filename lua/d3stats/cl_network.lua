-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

net.Receive("D3stats_UpdateXP", function()
	local XP = net.ReadUInt(32)
	
	--print("XP update: " .. tostring(XP))
	
	if D3stats and D3stats.D3statsOverlay then
		D3stats.D3statsOverlay:StatsUpdate(XP, D3stats.CalculateLevel(XP))
	end
end)