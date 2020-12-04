incircle = false
giftBox = {220.95143127441, -869.05328369141, 29.492219924927}

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
	local fov = (1 / GetGameplayCamFov()) * 70
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
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			local px, py, pz = playerPos.x, playerPos.y, playerPos.z

			--if GetDistanceBetweenCoords(giftBox.x,giftBox.y,giftBox.z,px,py,pz,true) <= 150 then
			--DrawTxt(giftBox.x,giftBox.y,giftBox.z +2.40, tostring(""))
			--DrawMarker(32,giftBox.x,giftBox.y,giftBox.z+0.5,0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 0,255,0,200,0,0,0,true)
			--DrawMarker(6,giftBox.x,giftBox.y,giftBox.z+0.5,0, 0, 0, 0, 0, 0, 2.0,2.0,2.0,255,255,255,200,0,0,0,true)
			--end
			if (Vdist(giftBox[1], giftBox[2], giftBox[3], px, py, pz) < 1.2) then
				if (incircle == false) then
					giftbox_DisplayText("~r~[E]~w~키를 눌러 ~g~리얼박스 ~w~열기")
				end
				incircle = true
				if (IsControlJustReleased(1, 51)) then
					TriggerServerEvent("vRP:giftboxopen")
				end
			elseif (Vdist(giftBox[1], giftBox[2], giftBox[3], px, py, pz) > 1.2) then
				incircle = false
			end
		end
	end
)

RegisterNetEvent("vRP:giftboxmenuopen")
AddEventHandler(
	"vRP:giftboxmenuopen",
	function()
		TriggerServerEvent("vRP:giftboxopen")
	end
)
