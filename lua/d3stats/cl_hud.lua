-- Delete HUD and redo if already existent. This will reset the values until the next update from the server
if d3stats.D3StatsOverlay then
	d3stats.D3StatsOverlay:Remove()
	d3stats.Overlay_Init()
end

-- HUD on the left top of the screen
function d3stats.Overlay_Init()
	local screenscale = BetterScreenScale()
	
	d3stats.D3StatsOverlay = vgui.Create( "D3StatsOverlay" )
	d3stats.D3StatsOverlay:SetPos( 0, screenscale * 80 )
	d3stats.D3StatsOverlay:SetSize( 350, 100 )
	
end

-- Call this function from cl_targetid.lua in the gamemode
local colTemp = Color(255, 255, 255)
function d3stats.DrawTargetID( ent, fade, x, y )
	
	colTemp.a = fade * 255
	--util.ColorCopy(COLOR_FRIENDLY, colTemp)
	
	if ent.D3Stats_Level and d3stats.Levels[ent.D3Stats_Level] then
		draw.SimpleTextBlur("Level " .. tostring(ent.D3Stats_Level) .. " \"" .. d3stats.Levels[ent.D3Stats_Level].Name .. "\"", "ZSHUDFontTiny", x, y, colTemp, TEXT_ALIGN_CENTER)
		y = y + draw.GetFontHeight("ZSHUDFontTiny") + 4
	end
	
	return x, y
end