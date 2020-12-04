Key = 201 -- ENTER
mycie = false

vehicleWashStation = {
	{26.5906, -1392.0261, 27.3634},
	{167.1034, -1719.4704, 27.2916},
	{-74.5693, 6427.8715, 29.4400},
	{-699.6325, -932.7043, 17.0139},
	{253.63720703125, -770.7294921875, 29.734275817871}
}

vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(
	function()
		Citizen.Wait(0)
		for i = 1, #vehicleWashStation do
			garageCoords = vehicleWashStation[i]
			stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
			SetBlipSprite(stationBlip, 100) -- 100 = carwash
			SetBlipAsShortRange(stationBlip, true)
		end
		return
	end
)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
				for i = 1, #vehicleWashStation do
					garageCoords2 = vehicleWashStation[i]
					DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 3.5, 3.5, 0.2, 255, 255, 255, 100, 0, 0, 2, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true) < 5 then
						DrawSpecialText("[~g~ENTER~s~] 키를 눌러서 세차하기")
						if IsControlJustPressed(1, Key) and not mycie then
							TriggerServerEvent("carwash:checkmoney", GetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
						end
					end
				end
			end
		end
	end
)

RegisterNetEvent("carwash:success")
AddEventHandler(
	"carwash:success",
	function(payAmount)
		local car = GetVehiclePedIsUsing(PlayerPedId())
		local coords = GetEntityCoords(PlayerPedId())
		mycie = true
		if payAmount ~= nil and tonumber(payAmount) > 0 then
			TriggerEvent("pNotify:SendNotification", {text = "" .. payAmount .. "원 세차비용을 지불했습니다.", type = "success", queue = "global", timeout = 5000, layout = "centerLeft"})
		end
		TriggerEvent("pNotify:SendNotification", {text = "세차중 입니다. (소요시간 15초)", type = "warning", queue = "global", timeout = 15000, layout = "centerLeft"})
		FreezeEntityPosition(car, true)
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Wait(1)
			end
		end
		UseParticleFxAssetNextCall("core")
		particles = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		UseParticleFxAssetNextCall("core")
		particles2 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x + 2, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		timer = 15
		timer2 = true
		Citizen.CreateThread(
			function()
				while timer2 do
					Citizen.Wait(0)
					Citizen.Wait(1000)
					if (timer > 0) then
						timer = timer - 1
					elseif (timer == 0) then
						mycie = false
						WashDecalsFromVehicle(car, 1.0)
						SetVehicleDirtLevel(car)
						SetVehicleUndriveable(car, false)
						FreezeEntityPosition(car, false)
						TriggerEvent("pNotify:SendNotification", {text = "세차가 완료되었습니다.", type = "success", queue = "global", timeout = 5000, layout = "centerLeft"})
						StopParticleFxLooped(particles, 0)
						StopParticleFxLooped(particles2, 0)
						timer2 = false
					end
				end
			end
		)
		Citizen.CreateThread(
			function()
				while true do
					Citizen.Wait(0)
					if mycie == true then
						for i = 1, #vehicleWashStation do
							garageCoords3 = vehicleWashStation[i]
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), garageCoords3[1], garageCoords3[2], garageCoords3[3], true) < 4 then
								DrawText3D(garageCoords3[1], garageCoords3[2], garageCoords3[3] + 3, "~b~세차중... ~s~남은시간:~b~ " .. timer .. " ~s~초")
							end
						end
					end
				end
			end
		)
	end
)
RegisterNetEvent("carwash:notenough")
AddEventHandler(
	"carwash:notenough",
	function()
		vRP.notify({"~r~세차할 비용이 부족합니다."})
	end
)
RegisterNetEvent("carwash:alreadyclean")
AddEventHandler(
	"carwash:alreadyclean",
	function()
		vRP.notify({"~g~차량이 이미 세차되었습니다."})
	end
)

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.5, 0.5)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
end
