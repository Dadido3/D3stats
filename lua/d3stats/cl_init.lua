d3stats = d3stats or {}

-- Includes
include( "sh_settings.lua" )
include( "sh_level.lua" )
include( "sh_concommand.lua" )

include( "cl_network.lua" )
include( "cl_hud.lua" )

include( "vgui/overlay.lua" )

-- Initialisation
hook.Add( "Initialize", "D3Stats_Init", function ()
	d3stats.Overlay_Init()
end )
