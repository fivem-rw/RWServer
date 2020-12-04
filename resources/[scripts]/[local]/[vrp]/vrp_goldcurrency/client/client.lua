--------------------------------
----- Converting By. 알고리즘 -----
--------------------------------

local PlayerData = nil
local converting = false
local meltingGold = false
local exchangingGold = false

function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.32, 0.32)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 500
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(
	function()
		if Config.EnableSmelteryBlip == true then
			for k, v in ipairs(Config.GoldSmeltery) do
				local blip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(blip, 618)
				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, 0.7)
				SetBlipColour(blip, 5)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("금 제련소")
				EndTextCommandSetBlipName(blip)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		if Config.EnableExchangeBlip == true then
			for k, v in ipairs(Config.GoldExchange) do
				local blip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(blip, 500)
				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, 0.7)
				SetBlipColour(blip, 5)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("금 거래소")
				EndTextCommandSetBlipName(blip)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(5)
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			for k, v in pairs(Config.GoldSmeltery) do
				local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, false)
				if distance <= 10.0 then
					DrawMarker(Config.SmelteryMarker, v.x, v.y, v.z - 0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, Config.SmelteryMarkerColor.r, Config.SmelteryMarkerColor.g, Config.SmelteryMarkerColor.b, Config.SmelteryMarkerColor.a, false, true, 2, true, false, false, false)
				else
					Citizen.Wait(500)
				end
				if distance <= 1.5 and meltingGold == false then
					DrawText3Ds(v.x, v.y, pos.z, "~g~[E]~s~키를 눌러 ~y~금을 융해하십시오")
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("esx_goldCurrency:goldMelting")
						meltingGold = true
						meltingGold = false
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(5)
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			for k, v in pairs(Config.GoldExchange) do
				local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, false)
				if distance <= 5.0 then
					DrawMarker(Config.ExchangeMarker, v.x, v.y, v.z - 0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.25, 1.25, Config.ExchangeMarkerColor.r, Config.ExchangeMarkerColor.g, Config.ExchangeMarkerColor.b, Config.ExchangeMarkerColor.a, false, true, 2, true, false, false, false)
				else
					Citizen.Wait(500)
				end
				if distance <= 0.6 then
					DrawText3Ds(v.x, v.y, pos.z, "~g~[E]~s~키를 눌러 ~g~현금~w~으로 바꾸십시오!")
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("esx_goldCurrency:goldExchange")
						exchangingGold = true
					end
				end
			end
		end
	end
)

RegisterNetEvent("GoldWatchToGoldBar")
AddEventHandler(
	"GoldWatchToGoldBar",
	function()
		FreezeEntityPosition(GetPlayerPed(-1), true)
		if converting then
			return
		end

		converting = true

		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
		exports["progressBars"]:startUI(120 * 1000, "금 시계 > 금괴 융해중...")
		Citizen.Wait((Config.SmelteryTime * 1000))
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(GetPlayerPed(-1), false)
		meltingGold = false
		converting = false
		ShowNotification("~r~[융해 시작]\n~g~금 시계~w~를 금괴로 융해를 시작합니다.")
	end
)

RegisterNetEvent("GoldBarToCash")
AddEventHandler(
	"GoldBarToCash",
	function()
		FreezeEntityPosition(GetPlayerPed(-1), true)
		if converting then
			return
		end

		converting = true
		exports["progressBars"]:startUI(10 * 1000, "금괴 > 현금 상자 교환중...")
		Citizen.Wait((Config.ExchangeTime * 1000))
		FreezeEntityPosition(GetPlayerPed(-1), false)

		exchangingGold = false
		converting = false
		ShowNotification("~r~[쿨타임 시작]\n~w~5분 후 ~g~현금 상자~w~를 다시 교환할 수 있습니다.")
	end
)

function ShowNotification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end
