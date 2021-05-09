if CLIENT then

	-- CONFIG OPTIONS --
	
	bar_hud = {}
	
	bar_hud.ServerName = "Chr"
	bar_hud.WebName = "omeRP.net"
	
	bar_hud.NameTextColor = Color( 255, 255, 255, 255)
	bar_hud.JobTextColor = Color( 255, 255, 255, 255)
	bar_hud.SalaryTextColor = Color(255, 255, 255, 255)
	bar_hud.MoneyTextColor = Color( 255, 255, 255, 255)
	bar_hud.HealthTextColor = Color( 255, 255, 255, 255)
	bar_hud.ArmorTextColor = Color( 255, 255, 255, 255)
	bar_hud.ServerNameTextColor = Color(156, 8, 30 )
	bar_hud.WebNameTextColor = Color( 255, 255, 255, 255)
	
	-- CONFIG OPTIONS -- 
	
	local itemPos = {}
	
	surface.CreateFont( "BarText", { 
		font = "Roboto",
		size = 20, 
		weight = 500, 
		antialias = true, 

	})
	surface.CreateFont( "BarTitle", { 
		font = "Roboto", 
		size = 23, 
		weight = 500, 
		antialias = true, 
		outline = true,
	})
	
	local Materials = {
		
		["Name"] = Material("materials/bar_hud/name.png"),
		["Health"] = Material("materials/bar_hud/health.png"),
		["Armor"] = Material("materials/bar_hud/armor.png"),
		["Job"] = Material("materials/bar_hud/suitcase.png"),
		["Wallet"] = Material("materials/bar_hud/wallet.png"),
		["Logo"] = Material("materials/bar_hud/scoreboard.png"),
		["Hunger"] = Material("materials/bar_hud/food.png"),
		["GunLicense"] = Material("materials/bar_hud/gun.png"),
		["Blur"] = Material("pp/blurscreen"),	
	}
	
	local function sizes()
		
		local w = ScrW()
		local h = 28
		
		local ISize = 24
		local IPadd = 16
		
		return w, h, ISize, IPadd
		
	end
	
	local function setBarPositions()
		
		local w, h, ISize, IPadd = sizes()
		
		local name = {
			
			["Icon"] = { 6, 2, 24, 24}
			
		}
		
	end
	
	local function DrawBlurRect(x, y, w, h, amount, heavyness)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(Materials["Blur"])

		for i = 1, heavyness do
			Materials["Blur"]:SetFloat("$blur", (i / 3) * (amount or 6))
			Materials["Blur"]:Recompute()

			render.UpdateScreenEffectTexture()

			render.SetScissorRect(x, y, x + w, y + h, true)
				surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
		
	end
	
	hook.Add( "HUDPaint", "BarHud_Paint", function()
		local w, h, ISize, IPadd = sizes()
		local posx = 6
		local name = ""
		local job = ""
		local salary = 0
		local money = 0
		local license = false
		local health = 0
		local armor = 0
		local food = 0
		
		if LocalPlayer():IsValid() then
			name = LocalPlayer():getDarkRPVar("rpname")
			job = LocalPlayer():getDarkRPVar("job")
			salary = DarkRP.formatMoney(LocalPlayer():getDarkRPVar("salary"))
			money = DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money"))
			health = LocalPlayer():Health()
			armor = LocalPlayer():Armor()
			food = LocalPlayer():getDarkRPVar("Energy") 
		end

		-- Blur Behind Text -- 

		DrawBlurRect(0, 0, w, h, 5, 2)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 200))
		draw.RoundedBox( 0, 0, h, w, 2,Color(156,8,30) )
		
		-- Job Icon --

		draw.NoTexture()
		surface.SetMaterial( Materials["Job"] )
		surface.SetDrawColor( Color( 255, 255, 255, 255) )
		surface.DrawTexturedRect( posx, 5, 16, 16  )
		posx = posx + ( 16 + 4 )

		-- Job Text --

		draw.DrawText( job or "", "BarText", posx, 3, team.GetColor(LocalPlayer():Team()), TEXT_ALIGN_LEFT, 1 )	
		surface.SetFont( "BarText" )
		local message = job
		local width, height = surface.GetTextSize( message or "" )
		
		posx = posx + ( width + IPadd)

		-- Wallet Icon -- 

		draw.NoTexture()
		surface.SetMaterial( Materials["Wallet"] )
		surface.SetDrawColor( Color( 255, 255, 255, 255) )
		surface.DrawTexturedRect( posx, 5, 18, 18  )
		
		posx = posx + ( 18 + 4)
		
		-- Wallet Text --

		draw.DrawText( money or "", "BarText", posx, 3, bar_hud.WalletTextColor, TEXT_ALIGN_LEFT, 1 )
		surface.SetFont( "BarText" )
		local message = money
		local width, height = surface.GetTextSize( message or "" )
		
		posx = posx + ( width + IPadd)


		-- Health Icon --
		
		draw.NoTexture()
		surface.SetMaterial( Materials["Health"] )
		surface.SetDrawColor( Color( 255, 255, 255, 255) )
		surface.DrawTexturedRect( posx, 6, 16, 16  )
				
		posx = posx + ( 16 + 4)
				
		-- Health Text --

		draw.DrawText( health or "", "BarText", posx, 3, bar_hud.HealthTextColor, TEXT_ALIGN_LEFT, 1 )		
		surface.SetFont( "BarText" )	
		local message = health
		local width, height = surface.GetTextSize( message or "" )
				
		posx = posx + ( width + IPadd)

		-- Armor Icon --

		draw.NoTexture()
		surface.SetMaterial( Materials["Armor"] )
		surface.SetDrawColor( Color( 255, 255, 255, 255) )
		surface.DrawTexturedRect( posx, 4, 20, 20  )
		posx = posx + ( 22 + 4)

		-- Armor Text --

		draw.DrawText( armor or "", "BarText", posx, 3, bar_hud.ArmorTextColor, TEXT_ALIGN_LEFT, 1 )		
		surface.SetFont( "BarText" )
		local message = armor
		local width, height = surface.GetTextSize( message or "" )
		surface.SetFont( "BarText" )

		posx = posx + (width + IPadd)

		-- Hunger Icon --

		draw.NoTexture()
		surface.SetMaterial( Materials["Hunger"] )
		surface.SetDrawColor( Color( 255, 255, 255, 255) )
		surface.DrawTexturedRect( posx, 4, 20, 20  )
		
		posx = posx + ( 22 + 4)

		-- Hunger Text --

		draw.DrawText( food or "", "BarText", posx, 3, bar_hud.ArmorTextColor, TEXT_ALIGN_LEFT, 1 )
		surface.SetFont( "BarText" )	
		local message = armor
		local width, height = surface.GetTextSize( message or "" )
		
		posx = posx + (width + IPadd)

		-- Gun License icon --

		if LocalPlayer():getDarkRPVar("HasGunlicense") == true then
			draw.NoTexture()
			surface.SetMaterial( Materials["GunLicense"] )
			surface.SetDrawColor( Color( 255, 255, 255, 255) )
			surface.DrawTexturedRect( posx, 4, 20, 20  )
			posx = posx + ( 22 + 4)
		end
		
		-- Servername + Webname  -- 

		draw.DrawText( bar_hud.ServerName, "BarTitle", w - (width + 129), 3, bar_hud.ServerNameTextColor, TEXT_ALIGN_LEFT, 1 )
		draw.DrawText( bar_hud.WebName, "BarTitle", w - (width + 100), 3, bar_hud.WebNameTextColor, TEXT_ALIGN_LEFT, 1 )
	
	end )
end


function hidehud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "DarkRP_Hungermod", "DarkRP_HUD", "CHudSecondaryAmmo", "DarkRP_LocalPlayerHUD", "DarkRP_EntityDisplay"})do
        if name == v then return false end
    end
end
hook.Add("HUDShouldDraw", "hide", hidehud)