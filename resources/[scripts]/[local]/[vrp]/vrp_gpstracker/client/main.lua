vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_gpstracker")

local deployed = false
local gpstarget = nil
local sounddeploy = false
local soundconnect = false
local soundconnlost = false
local sounddisconnect = false
local standardRangeOutput = 3
local standardVolumeOutput = 1
local trackedveh = nil
local tracking = false

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if (IsControlJustPressed(0, 117) and IsPedInAnyVehicle(GetPlayerPed(-1)) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
				if deployed and trackedveh ~= nil then
					TriggerServerEvent("vrp_gpstracker:removetracker", gpstarget)
					deployed = false
				elseif not deployed and not tracking then
					trackedveh = GetTrackedVeh(GetVehiclePedIsIn(GetPlayerPed(-1)))
					if IsEntityAVehicle(trackedveh) then
						deployed = true
						tracking = false
						showNotification("~w~~o~GPS추적이 시작되었습니다.\n모든 경찰에게 알립니다.")
						sounddeploy = true
						TriggerServerEvent("vrp_gpstracker:sendblip", trackedveh)
					end
				elseif not deployed and tracking then
					showNotification("~w~~o~GPS추적을 종료합니다.")
					sounddisconnect = true
					tracking = false
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if sounddeploy then
				TriggerServerEvent("vrp_gpstracker:findtrackedcar", trackedveh)
				Citizen.Wait(500)
				sounddeploy = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if soundconnect and not sounddeploy then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", standardRangeOutput, "connected", standardVolumeOutput)
					Citizen.Wait(500)
				end
				soundconnect = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if sounddisconnect and not sounddeploy and not soundconnect then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", standardRangeOutput, "disconnected", standardVolumeOutput)
					Citizen.Wait(500)
				end
				sounddisconnect = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if soundconnlost then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerPedId)) then
					TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", standardRangeOutput, "disconnected", standardVolumeOutput)
					Citizen.Wait(500)
					TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", standardRangeOutput, "disconnected", standardVolumeOutput)
					Citizen.Wait(500)
					TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", standardRangeOutput, "disconnected", standardVolumeOutput)
					Citizen.Wait(500)
				end
				soundconnlost = false
			end
		end
	end
)

RegisterNetEvent("vrp_gpstracker:trackerset")
AddEventHandler(
	"vrp_gpstracker:trackerset",
	function(veh)
		gps = AddBlipForEntity(veh)
		SetBlipSprite(gps, 42)

		if not tracking then
			tracking = true
			showNotification("~w~~o~GPS추적이 시작되었습니다.")
			soundconnect = true
			if deployed then
				gpstarget = gps
				SetBlipRoute(gps, true)
				SetEntityAsMissionEntity(veh, true, true)
			end

			while deployed or tracking do
				Citizen.Wait(0)
				if veh ~= nil then
					if not IsEntityAVehicle(veh) then
						showNotification("~w~~o~GPS신호 손실")
						soundconnlost = true
						deployed = false
						tracking = false
					end
				else
					deployed = false
					tracking = false
				end
			end
		end
	end
)

RegisterNetEvent("vrp_gpstracker:trackerremove")
AddEventHandler(
	"vrp_gpstracker:trackerremove",
	function(gps)
		RemoveBlip(gps)
		showNotification("~w~~o~GPS추적기가 비활성화되었습니다.")
		sounddisconnect = true
		tracking = false
	end
)

function GetTrackedVeh(e)
	local coord1 = GetOffsetFromEntityInWorldCoords(e, 0.0, 1.0, 1.0)
	local coord2 = GetOffsetFromEntityInWorldCoords(e, 0.0, 5.0, 0.0)
	local rayresult = StartShapeTestCapsule(coord1, coord2, 3.0, 10, e, 7)
	local a, b, c, d, e = GetShapeTestResult(rayresult)
	if DoesEntityExist(e) then
		return e
	else
		return nil
	end
end

function showNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(false, false)
end

RegisterNetEvent("vrp_gpstracker:playsoundontrackedcar")
AddEventHandler(
	"vrp_gpstracker:playsoundontrackedcar",
	function(searchedveh)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, true) then
			currentcar = GetVehiclePedIsIn(ped, false)
			if searchedveh == currentcar then
				TriggerServerEvent("vrp_gpstracker:PlayWithinDistance", 10, "deployed", standardVolumeOutput)
			end
		end
	end
)

RegisterNetEvent("vrp_gpstracker:playsoundlocal")
AddEventHandler(
	"vrp_gpstracker:playsoundlocal",
	function(playerNetId, maxDistance, soundFile, soundVolume)
		local lCoords = GetEntityCoords(GetPlayerPed(-1))
		local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
		local distIs = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
		if distIs <= maxDistance then
			SendNUIMessage(
				{
					transactionType = "playSound",
					transactionFile = soundFile,
					transactionVolume = soundVolume
				}
			)
		end
	end
)
