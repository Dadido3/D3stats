-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

D3stats = D3stats or {}

-- Includes
include("sh_settings.lua")
include("sh_level.lua")
include("sh_concommand.lua")

include("cl_network.lua")
include("cl_hud.lua")

include("vgui/overlay.lua")

-- Initialization
hook.Add("Initialize", "D3stats_Init", function ()
	D3stats.Overlay_Init()
end)
