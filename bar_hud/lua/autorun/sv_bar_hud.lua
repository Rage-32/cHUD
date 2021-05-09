if SERVER then

	AddCSLuaFile("cl_bar_hud.lua")
	util.AddNetworkString("yc_laws_toggle")
	
	--[[
		
		-----------------
		|				|
		| Add Resources |
		|				|
		-----------------
	
	]]
	
	local files = file.Find( "materials/bar_hud/*", "GAME")
	local fonts = file.Find( "resource/fonts/*", "GAME")
	
	for k,v in pairs(fonts) do

		resource.AddFile("resource/fonts/" .. v)
	
	end
	
	for k,v in pairs(files) do

		resource.AddFile("materials/bar_hud/" .. v)

	end
	
	--[[/////////////////////////////////////
	Nom: Hook PlayerInitialSpawn
	Fonction: First spawn of the player
	Parametre entree: /
	Parametre sortie: /
	Sources de donnees: /
	--/////////////////////////////////////]]
	hook.Add( "PlayerInitialSpawn", "Hook_PlayerInitialSpawn_ToggleLawsBoard", function( ply )
		timer.Simple( 4, function()
			if ( !IsValid( ply ) ) then return end
			net.Start("yc_laws_toggle")
			net.Send(ply)
		end )
	end)
	

end