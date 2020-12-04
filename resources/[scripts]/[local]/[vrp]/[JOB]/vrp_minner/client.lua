local tempoEmSegundos = 60

local minnerFarm = {
	{2952.7182617188, 2768.4162597656, 39.990772247314},
	{2948.09765625, 2766.6821289063, 39.17525100708},
	{2938.458984375, 2772.1625976563, 39.255451202393},
	{2934.0773925781, 2783.8842773438, 39.7666015625},
	{2934.0773925781, 2783.8842773438, 39.7666015625},
	{2927.8142089844, 2789.2863769531, 40.622589111328},
	{2925.9934082031, 2792.44140625, 41.294620513916},
	{2922.4404296875, 2798.7800292969, 41.204208374023},
	{2968.3676757813, 2775.2160644531, 39.025520324707},
	{2963.365234375, 2774.1164550781, 39.596683502197},
	{2973.4682617188, 2775.4790039063, 38.221347808838},
	{2980.7431640625, 2782.3063964844, 39.937694549561},
	{2981.669921875, 2785.611328125, 40.44017791748},
	{2979.1845703125, 2789.8752441406, 40.56787109375},
	{2976.0959472656, 2792.7355957031, 41.184711456299},
	{2973.3354492188, 2797.8178710938, 41.27710723877},
	{2956.0500488281, 2820.1162109375, 43.194641113281},
	{2949.3149414063, 2820.9448242188, 43.342212677002},
	{2937.6005859375, 2813.3620605469, 43.397956848145},
	{2957.0051269531, 2772.7553710938, 40.157314300537},
	{2937.6369628906, 2774.6052246094, 39.705127716064},
	{2930.1254882813, 2787.6127929688, 39.708808898926},
	{2925.6391601563, 2795.6772460938, 41.089698791504},
	{2944.9970703125, 2819.2490234375, 42.850875854492},
	{2959.3566894531, 2820.0139160156, 43.738399505615},
	{2951.1723632813, 2816.5732421875, 42.608829498291},
	{2931.1616210938, 2816.6166992188, 45.38081741333},
	{2926.2487792969, 2812.92578125, 45.38081741333},
	{2942.36328125, 2760.759765625, 42.482830047607},
	---
	{1866.0765380859, 212.94004821777, 162.16961669922},
	{1861.1619873047, 213.4270324707, 162.3023223877},
	{1855.5673828125, 214.98899841309, 162.69137573242},
	{1850.5712890625, 216.23028564453, 163.7193145752},
	{1849.2708740234, 223.73707580566, 163.35935974121},
	{1852.3481445313, 229.73495483398, 162.59962463379},
	{1876.7941894531, 266.85275268555, 162.53874206543},
	{1835.9320068359, 246.18598937988, 163.68411254883},
	{1830.9576416016, 252.81066894531, 164.50912475586},
	{1826.9794921875, 271.3215637207, 163.93650817871},
	{1824.953125, 282.16000366211, 163.66522216797},
	{1823.1440429688, 292.96304321289, 163.21575927734},
	{1835.3227539063, 315.12451171875, 161.34014892578},
	{1861.8513183594, 308.35336303711, 162.96994018555},
	{1902.1884765625, 316.15255737305, 163.37724304199},
	{1906.5192871094, 307.62866210938, 162.69595336914}
}

local alreadyCut = {}

local tempoEmMilssegundos = tempoEmSegundos * 1000

local isProcessing = false

local alphaRate = 255
local alphaRateDir = false

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		while true do
			Citizen.Wait(1)
			for k, v in pairs(minnerFarm) do
				local x, y, z = table.unpack(v)
				z = z - 1
				local pCoords = GetEntityCoords(GetPlayerPed(-1))
				local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
				if alphaRateDir then
					alphaRate = alphaRate + 1
				else
					alphaRate = alphaRate - 1
				end
				local alpha = math.floor(alphaRate - (distance * 30))
				if alpha < 0 then
					alpha = 0
				end
				if alphaRate < 0 then
					alphaRateDir = true
				end
				if alphaRate > 255 then
					alphaRateDir = false
				end
				if alreadyCut[k] ~= nil then
					local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
					if timeDiff < tempoEmMilssegundos then
						if distance < 5.0 then
							local seconds = math.ceil(tempoEmSegundos - timeDiff / 1000)
							DrawText3d(x, y, z + 1.5, "~w~ ~r~" .. tostring(seconds) .. "~w~초 남음", 200)
						end
					else
						alreadyCut[k] = nil
					end
				else
					if distance < 1.5 then
						DrawText3d(x, y, z + 1.5, "~b~[E]~w~드릴작동", 200)
						if (IsControlJustPressed(1, 38)) then
							if alreadyCut[k] ~= nil then
								if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
									alreadyCut[k] = GetGameTimer()
									TriggerServerEvent("minner:getminnerOnPalet")
								end
							else
								alreadyCut[k] = GetGameTimer()
								TriggerServerEvent("minner:getminnerOnPalet")
							end
						end
					elseif distance < 5.0 then
						DrawText3d(x, y, z + 1.5, "~y~반짝반짝", alpha)
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			DeleteJackhammer()
		end
	end
)

local lastProcess = 0
local isProcess = false

RegisterNetEvent("minner:getminnerOnPalet")
AddEventHandler(
	"minner:getminnerOnPalet",
	function(tree)
		if isProcess then
			TriggerServerEvent("minner:reject")
			return
		end
		isProcess = true
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		while (not HasAnimDictLoaded("mp_common")) do
			RequestAnimDict("mp_common")
			Citizen.Wait(5)
		end
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CONST_DRILL", 0, true)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		math.randomseed(math.random(2000, 5000))
		local rand = math.random(2000, 5000)
		exports["progressBars"]:startUI(rand, "광질만이 살길이다..")
		Citizen.Wait(rand)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerServerEvent("minner:getminnerItem")
		isProcess = false
		Citizen.Wait(2000)
		DeleteJackhammer()
	end
)

function DeleteJackhammer()
	local ped = GetPlayerPed(PlayerId())
	if not IsEntityAttached(ped) then
		local position = GetEntityCoords(ped, false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, 1360563376, false, false, false)
		if object ~= 0 then
			if not IsEntityAttached(object) then
				SetEntityAsMissionEntity(object)
				DetachEntity(object, true, true)
				DeleteObject(object)
			end
		end
	end
end

function DrawText3d(x, y, z, text, alpha)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.5, 0.5)
		SetTextFont(1)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, alpha)
		SetTextDropshadow(0, 0, 0, 0, alpha)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x, y, z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
