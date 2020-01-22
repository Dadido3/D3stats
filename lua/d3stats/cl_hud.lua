-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Delete HUD and redo if already existent. This will reset the displayed values until the next update from the server
if D3stats.D3statsOverlay then
	D3stats.D3statsOverlay:Remove()
	D3stats.Overlay_Init()
end

-- HUD on the left top of the screen
function D3stats.Overlay_Init()
	D3stats.D3statsOverlay = vgui.Create("D3statsOverlay")
	D3stats.D3statsOverlay:SetPos(D3stats.Overlay_X, D3stats.Overlay_Y)
	D3stats.D3statsOverlay:SetSize(350, 100)
end

-- Call this function from cl_targetid.lua in the gamemode. Works for ZS, needs adjustments for other gamemodes.
local colTemp = Color(255, 255, 255)
function D3stats.DrawTargetID(ent, fade, x, y)
	
	colTemp.a = fade * 255
	--util.ColorCopy(COLOR_FRIENDLY, colTemp)
	
	local Level = ent:GetNWInt("D3stats_Level", 0)
	if Level > 0 and D3stats.Levels[Level] then
		draw.SimpleTextBlur("Level " .. tostring(Level) .. " \"" .. D3stats.Levels[Level].Name .. "\"", D3stats.Font_TargetID, x, y, colTemp, TEXT_ALIGN_CENTER)
		y = y + draw.GetFontHeight(D3stats.Font_TargetID) + 4
	end
	
	return x, y
end
