local PANEL = {}

function PANEL:Init()
	self.Progress = vgui.Create("DProgress", self)
	self.Progress:SetPos(10, 10)
	self.Progress:SetSize(200, 20)
	
	self.Label_XP = vgui.Create("DLabel", self)
	self.Label_XP:SetTextColor(color_black)
	self.Label_XP:SetFont(D3stats.Font_Overlay_XP)
	self.Label_XP:SetSize(200, 20)
	self.Label_XP:SetPos(10, 10) -- Set the position of the label
	self.Label_XP:SetContentAlignment(5)
	
	self.Label_Level = vgui.Create("DLabel", self)
	self.Label_Level:SetFont(D3stats.Font_Overlay_Level)
	self.Label_Level:SetPos(10, 35) -- Set the position of the label
	self.Label_Level:SetSize(200, 20)
	self.Label_Level:SetContentAlignment(5)
	
	self:StatsUpdate(0, 1)
	--self.Label:SetDark(1) -- Set the colour of the text inside the label to a darker one
	
	--timer.Create("D3statsOverlay_Timer", 0.1, 0, function() self.Progress:SetFraction(math.random()) end)
end

function PANEL:Paint(aWide, aTall)
	-- Nothing for now
end

function PANEL:StatsUpdate(XP, Level)
	local Text_XP
	local Text_Level
	local Fraction
	
	if D3stats.Levels[Level+1] then
		Text_XP = "XP: " .. tostring(XP) .. " / " .. D3stats.Levels[Level+1].XP_needed
		Fraction = (XP - D3stats.Levels[Level].XP_needed) / (D3stats.Levels[Level+1].XP_needed - D3stats.Levels[Level].XP_needed)
	else
		Text_XP = "XP: " .. tostring(XP)
		Fraction = 1
	end
	
	Text_Level = "Level: " .. tostring(Level) .. " \"" .. D3stats.Levels[Level].Name .. "\""
	
	self.Label_XP:SetText(Text_XP) -- Set the text of the label
	--self.Label_XP:SizeToContents() -- Size the label to fit the text in it
	
	self.Label_Level:SetText(Text_Level) -- Set the text of the label
	--self.Label_Level:SizeToContents() -- Size the label to fit the text in it
	
	self.Progress:SetFraction(Fraction)
	
end

function PANEL:SetText(aText) self.Text = tostring(aText) end
function PANEL:GetText() return self.Text or "" end

vgui.Register("D3statsOverlay", PANEL, "DPanel")