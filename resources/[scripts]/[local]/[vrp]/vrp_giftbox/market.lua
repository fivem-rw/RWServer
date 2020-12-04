function giftbox_DisplayText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawTxt(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

	local scale = (1 / dist) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.7 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			local px, py, pz = playerPos.x, playerPos.y, playerPos.z

			if GetDistanceBetweenCoords(216.41899108887, -816.20581054688, -1300.635202407837, px, py, pz, true) <= 150 then
				DrawTxt(216.41899108887, -816.20581054688, -1300.635202407837, tostring("~w~[~g~랜덤박스~w~]\n~g~랜덤박스~w~ 구매가격 : ~g~50만원"))
				DrawMarker(-239.27465820313, -816.56665039063, -1300.170219421387 + 0.5, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 130, 0, 0, 0, true)
				DrawMarker(-239.27465820313, -816.56665039063, -1300.170219421387 + 0.5, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 255, 255, 130, 0, 0, 0, true)
			end
			if (Vdist(218.26165771484, -816.43231201172, -1631.997968673706, px, py, pz) < 2) then
				if (incircle == false) then
					giftbox_DisplayText("랜덤박스를 구매하시려면 ~g~E~w~를 눌러주세요!")
				end
				incircle = true
				if (IsControlJustReleased(1, 51)) then
					TriggerServerEvent("vRP:moneygift")
				end
			elseif (Vdist(218.26165771484, -816.43231201172, -1300.997968673706, px, py, pz) > 2) then
				incircle = false
			end
		end
	end
)
