vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(
	function()
		while true do
			Wait(0)

			local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)

			-- 대마초
			DrawMarker(1, -93.267166137695, 6236.7827148438, 31.089908599854 - 1.0001, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, -93.267166137695, 6236.7827148438, 31.089908599854, true) <= 5.0 then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("probar:permisos")
				end
			end

			-- LSD
			DrawMarker(1, -106.98876190186, 6211.2700195313, 31.025024414063 - 1.0001, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, -106.98876190186, 6211.2700195313, 31.025024414063, true) <= 5.0 then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("meta:permisos")
				end
			end

			-- 코카인
			DrawMarker(1, -99.36750793457, 6197.408203125, 31.025047302246 - 1.0001, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, -99.36750793457, 6197.408203125, 31.025047302246, true) <= 5.0 then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("coke:permisos")
				end
			end

			--[[
			-- 돈세탁
			DrawMarker(1, 639.78234863282, 2773.1804199218, 42.025310516358 - 1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 639.78234863282, 2773.1804199218, 42.025310516358, true) <= 5.0 then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("blanqueo:permisos")
				end
			end
			]]
			-- 창고
			--[[
			--DrawMarker(1, 964.48321533204,-1027.0417480468,40.847507476806-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 3.0, 2.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 964.48321533204, -1027.0417480468, 40.847507476806, true) <= 5.0 then
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("motero:permisos")
				end
			end
			]]
			-- 대마초
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1065.3829345703, -3183.4711914063, -39.163501739502, true) <= 5.0 then
				-- TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
				if IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1500)

					SetEntityCoords(GetPlayerPed(-1), -93.267166137695, 6236.7827148438, 31.089908599854)

					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
				end
			end

			-- LSD
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 997.77288818359, -3200.6901855469, -36.393634796143, true) <= 1.0 then
				-- TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
				if IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1500)

					SetEntityCoords(GetPlayerPed(-1), -106.98876190186, 6211.2700195313, 31.025024414063)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
				end
			end

			-- 코카인
			if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 1088.7963867188, -3188.2531738281, -38.993465423584, true) <= 1.0 then
				-- TriggerEvent("fs_freemode:displayHelp", i18n.translate("exit_warehouse"))
				if IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1500)

					SetEntityCoords(GetPlayerPed(-1), -99.36750793457, 6197.408203125, 31.025047302246)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
				end
			end
		end
	end
)

RegisterNetEvent("tiene:permisos")
AddEventHandler(
	"tiene:permisos",
	function()
		loadWeed()
	end
)

RegisterNetEvent("blanqueo:permisos")
AddEventHandler(
	"blanqueo:permisos",
	function()
		loadBlanqueo()
	end
)

RegisterNetEvent("meta:permisos")
AddEventHandler(
	"meta:permisos",
	function()
		loadMeta()
	end
)

RegisterNetEvent("coke:permisos")
AddEventHandler(
	"coke:permisos",
	function()
		loadCoke()
	end
)

RegisterNetEvent("motero:permisos")
AddEventHandler(
	"motero:permisos",
	function()
		loadMotero()
	end
)

RegisterNetEvent("notiene:permisos")
AddEventHandler(
	"notiene:permisos",
	function()
		vRP.notify({"~r~No puedes entrar."})
	end
)

function loadWeed()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), 1063.445, -3183.618, -39.164)
	DoScreenFadeIn(1000)
end

function loadBlanqueo()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), 1118.683, -3193.319, -40.391)
	DoScreenFadeIn(1000)
end

function loadMeta()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), 996.8969116211, -3200.6459960938, -36.39372253418)
	DoScreenFadeIn(1000)
end

function loadCoke()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), 1088.803, -3188.257, -38.993)
	DoScreenFadeIn(1000)
end

function loadMotero()
	local ped = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), 996.97509765625, -3157.9213867188, -38.907146453858)
	DoScreenFadeIn(1000)
end
