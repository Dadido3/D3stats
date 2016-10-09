-- Delete HUD and redo if already existent. This will reset the displayed values until the next update from the server
if d3stats.D3StatsOverlay then
	d3stats.D3StatsOverlay:Remove()
	d3stats.Overlay_Init()
end

-- HUD on the left top of the screen
function d3stats.Overlay_Init()
	d3stats.D3StatsOverlay = vgui.Create( "D3StatsOverlay" )
	d3stats.D3StatsOverlay:SetPos( d3stats.Overlay_X, d3stats.Overlay_Y )
	d3stats.D3StatsOverlay:SetSize( 350, 100 )
end

-- Call this function from cl_targetid.lua in the gamemode. Works for ZS, needs adjustments for other gamemodes.
local colTemp = Color(255, 255, 255)
function d3stats.DrawTargetID( ent, fade, x, y )
	
	colTemp.a = fade * 255
	--util.ColorCopy(COLOR_FRIENDLY, colTemp)
	
	local Level = ent:GetNWInt( "D3Stats_Level", 0 )
	if Level > 0 and d3stats.Levels[Level] then
		draw.SimpleTextBlur("Level " .. tostring(Level) .. " \"" .. d3stats.Levels[Level].Name .. "\"", d3stats.Font_TargetID, x, y, colTemp, TEXT_ALIGN_CENTER)
		y = y + draw.GetFontHeight(d3stats.Font_TargetID) + 4
	end
	
	return x, y
end