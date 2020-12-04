vRP = Proxy.getInterface("vRP")


RegisterNetEvent('tiene:permisos')
AddEventHandler('tiene:permisos', function()
loadWeed()
end)

RegisterNetEvent('blanqueo:permisos')
AddEventHandler('blanqueo:permisos', function()
loadBlanqueo()
end)

RegisterNetEvent('meta:permisos')
AddEventHandler('meta:permisos', function()
loadMeta()
end)

RegisterNetEvent('coke:permisos')
AddEventHandler('coke:permisos', function()
loadCoke()
end)

RegisterNetEvent('motero:permisos')
AddEventHandler('motero:permisos', function()
loadMotero()
end)

RegisterNetEvent('notiene:permisos')
AddEventHandler('notiene:permisos', function()
	vRP.notify({"~r~No puedes entrar."})
end)

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
		SetEntityCoords(GetPlayerPed(-1), 996.8969116211,-3200.6459960938,-36.39372253418)
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
		SetEntityCoords(GetPlayerPed(-1), 996.97509765625,-3157.9213867188,-38.907146453858)
		DoScreenFadeIn(1000)
end