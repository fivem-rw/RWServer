local wingSuit = false
incircle = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z

		if GetDistanceBetweenCoords(-72.92,-832.75,322.38,px,py,pz,true) <= 150 then
			DrawMarker(40,-72.92,-832.75,322.38+0.5,0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 130,200,255,200,0,0,0,true)
			DrawMarker(6,-72.92,-832.75,322.38+0.5,0, 0, 0, 0, 0, 0, 2.0,2.0,2.0,255,255,255,200,0,0,0,true)
		end
		if(Vdist(-72.92,-832.75,322.38,px,py,pz) < 2)then
			if (incircle == true) then
				DisplayHelpText("~g~스카이 다이빙~w~을 하시려면\n~INPUT_CONTEXT~ 키를 눌러주세요.")
			end
			incircle = true
			if IsControlJustReleased(1, 51) then
				TriggerServerEvent('pay:skydive')
		elseif(Vdist(-72.92,-832.75,322.38,px,py,pz) > 2)then
			incircle = false
		end
  end
  end
end)


RegisterNetEvent("wingSuit:start")
AddEventHandler('wingSuit:start', function()
	if not wingSuit then
		wingSuit = true
		
		CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)

			GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)

			DoScreenFadeOut(1000)

			while not IsScreenFadedOut() do
				Wait(0)
			end

			SetEntityCoords(playerPed, -72.92, -832.75, 322.38+88.0)

			DoScreenFadeIn(1000)

			Wait(2000)

			DisplayHelpText('~g~안전~w~에 유의하세요!')

			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)

			while true do
				if wingSuit then			
					if IsPedInParachuteFreeFall(playerPed) and not HasEntityCollidedWithAnything(playerPed) then
						ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						wingSuit = false
					end
				else

					break
				end

				Wait(0)
			end

			RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))

			Wait(3000)

			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
end)