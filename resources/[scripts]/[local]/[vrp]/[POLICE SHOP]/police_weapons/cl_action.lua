--[[------------------------------------------------------------------------

	ActionMenu - v1.0.1
	Created by WolfKnight
	Additional help from lowheartrate, TheStonedTurtle, and Briglair. 

------------------------------------------------------------------------]]--


-- Define the variable used to open/close the menu 
local menuEnabled = false 

local blackMarket = {
	{452.20751953125,-980.24371337891,30.689323425293},
}

--[[------------------------------------------------------------------------
	ActionMenu Toggle
	Calling this function will open or close the ActionMenu. 
------------------------------------------------------------------------]]--
function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true 
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end 

RegisterNetEvent("police:CombatPistol")
AddEventHandler("police:CombatPistol", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_PISTOL","pistol")
end)

RegisterNetEvent("police:APPistol")
AddEventHandler("police:APPistol", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_APPISTOL","pistol")
end)

RegisterNetEvent("police:Tazer")
AddEventHandler("police:Tazer", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_STUNGUN","pistol")
end)

RegisterNetEvent("police:Nightstick")
AddEventHandler("police:Nightstick", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_NIGHTSTICK","pistol")
end)

RegisterNetEvent("police:Sniperrifle")
AddEventHandler("police:Sniperrifle", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_SNIPERRIFLE","rifle")
end)

RegisterNetEvent("police:AssaultShotgun")
AddEventHandler("police:AssaultShotgun", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_ASSAULTSHOTGUN","rfle")
end)

RegisterNetEvent("police:Carbine")
AddEventHandler("police:Carbine", function(source)
  TriggerEvent("Police:getWeapon", "WEAPON_CARBINERIFLE","rifle")
end)

--[[------------------------------------------------------------------------
	ActionMenu HTML Callbacks
	This will be called every single time the JavaScript side uses the
	sendData function. The name of the data-action is passed as the parameter
	variable data. 
------------------------------------------------------------------------]]--
RegisterNUICallback( "ButtonClick", function( data, cb ) 
	if ( data == "c_combatpistol" ) then 
		TriggerServerEvent("Police:PSP", data)
	elseif ( data == "c_carbine" ) then 
		TriggerServerEvent("Police:PSP", data)	
	elseif ( data == "c_assaultshotgun" ) then 
		TriggerServerEvent("Police:PSP", data)	
	elseif ( data == "c_sniperrifle" ) then 
		TriggerServerEvent("Police:PSP", data)	
	elseif ( data == "c_tazer" ) then 
		TriggerServerEvent("Police:PSP", data)	
	elseif ( data == "c_appistol" ) then 
		TriggerServerEvent("Police:PSP", data)	
	elseif ( data == "c_nightstick" ) then 
		TriggerServerEvent("Police:PSP", data)	
		
		-----------------------------------------------------------
		
		
	elseif ( data == "exit" ) then 
		-- We toggle the ActionMenu and return here, otherwise the function 
		-- call below would be executed too, which would just open the menu again 
		ToggleActionMenu()
		return 
	end 		

	-- This will only be called if any button other than the exit button is pressed
	--ToggleActionMenu()
end )


--[[------------------------------------------------------------------------
	ActionMenu Control and Input Blocking 
	This is the main while loop that opens the ActionMenu on keypress. It 
	uses the input blocking found in the ES Banking resource, credits to 
	the authors.
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
	-- This is just in case the resources restarted whilst the NUI is focused. 
	SetNuiFocus( false )

	while true do 
		-- Control ID 20 is the 'Z' key by default 
		-- Use https://wiki.fivem.net/wiki/Controls to find a different key 
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(blackMarket) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 3.0 and menuEnabled == false  then
				DisplayHelpText(" ~INPUT_CONTEXT~ 키를 눌러 무기 선택 메뉴를 엽니다")
				if (IsControlJustPressed(1, 38)) then
					ToggleActionMenu()
				end
			end
		end 

	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	

            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end

		Citizen.Wait( 0 )
	end 
end )

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end