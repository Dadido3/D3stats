local PANEL = {}

function PANEL:Init()
	
	self.Progress = vgui.Create( "DProgress", self )
	self.Progress:SetPos( 10, 10 )
	self.Progress:SetSize( 200, 10 )
	
	self.Label = vgui.Create( "DLabel", self )
	self.Label:SetFont(d3stats.Font_Overlay)
	self.Label:SetPos( 10, 25 ) -- Set the position of the label
	self:StatsUpdate( 0, 1 )
	--self.Label:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
	
	--timer.Create( "D3StatsOverlay_Timer", 0.1, 0, function() self.Progress:SetFraction( math.random() ) end )
	
	
end

function PANEL:Paint( aWide, aTall )
	-- Nothing for now
end

function PANEL:StatsUpdate( XP, Level )
	local Text
	local Fraction
	
	if d3stats.Levels[Level+1] then
		Text = "XP: " .. tostring( XP ) .. " / " .. d3stats.Levels[Level+1].XP_needed .. "\nLevel: " .. tostring( Level ) .. " \"" .. d3stats.Levels[Level].Name .. "\""
		Fraction = ( XP - d3stats.Levels[Level].XP_needed ) / ( d3stats.Levels[Level+1].XP_needed - d3stats.Levels[Level].XP_needed )
	else
		Text = "XP: " .. tostring( XP ) .. "\nLevel: " .. tostring( Level ) .. " \"" .. d3stats.Levels[Level].Name .. "\""
		Fraction = 1
	end
	
	self.Label:SetText( Text ) -- Set the text of the label
	self.Label:SizeToContents() -- Size the label to fit the text in it
	
	self.Progress:SetFraction( Fraction )
	
end

function PANEL:SetText( aText ) self.Text = tostring( aText ) end
function PANEL:GetText() return self.Text or "" end

vgui.Register( "D3StatsOverlay", PANEL, "DPanel" )