vRP = Proxy.getInterface("vRP")

local piggyBackInProgress = false
local piggyBackInProgressTarget = false
local piggyBackInProgressTargetPlayer = nil
local piggyBackAnimNamePlaying = ""
local piggyBackAnimDictPlaying = ""
local piggyBackControlFlagPlaying = 0
local isSyncing = false
local isEnableFree = false
local isRestControl = false

lib = "anim@arena@celeb@flat@paired@no_props@"
anim1 = "piggyback_c_player_a"
anim2 = "piggyback_c_player_b"
distans = -0.07
distans2 = 0.0
height = 0.45
spin = 0.0
length = 100000
controlFlagMe = 49
controlFlagTarget = 33
animFlagTarget = 1

RegisterNetEvent("cmg2_animations:syncTarget")
AddEventHandler(
	"cmg2_animations:syncTarget",
	function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
		local playerPed = GetPlayerPed(-1)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
		RequestAnimDict(animationLib)

		piggyBackInProgressTarget = true
		piggyBackInProgressTargetPlayer = GetPlayerFromServerId(target)

		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		if spin == nil then
			spin = 180.0
		end
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
		if controlFlag == nil then
			controlFlag = 0
		end
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		piggyBackAnimNamePlaying = animation2
		piggyBackAnimDictPlaying = animationLib
		piggyBackControlFlagPlaying = controlFlag

		Citizen.Wait(1000)

		if piggyBackInProgressTarget then
			isEnableFree = true
		end
	end
)

RegisterNetEvent("cmg2_animations:syncMe")
AddEventHandler(
	"cmg2_animations:syncMe",
	function(animationLib, animation, length, controlFlag, animFlag)
		local playerPed = GetPlayerPed(-1)
		RequestAnimDict(animationLib)

		while not HasAnimDictLoaded(animationLib) do
			Citizen.Wait(10)
		end
		Wait(500)
		if controlFlag == nil then
			controlFlag = 0
		end
		TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		piggyBackAnimNamePlaying = animation
		piggyBackAnimDictPlaying = animationLib
		piggyBackControlFlagPlaying = controlFlag

		isSyncing = false
	end
)

RegisterNetEvent("cmg2_animations:cl_stop")
AddEventHandler(
	"cmg2_animations:cl_stop",
	function()
		piggyBackInProgressTarget = false
		piggyBackInProgressTargetPlayer = nil
		piggyBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		isSyncing = false
		isEnableFree = false
	end
)

RegisterNetEvent("cmg2_animations:kill")
AddEventHandler(
	"cmg2_animations:kill",
	function()
		Wait(1000)
		SetEntityHealth(GetPlayerPed(-1), 0)
	end
)

lastClosestPlayer = nil

Citizen.CreateThread(
	function()
		Wait(100)
		DetachEntity(GetPlayerPed(-1), true, false)
		ClearPedSecondaryTask(GetPlayerPed(-1))
		while true do
			if not isRestControl and not isSyncing and not IsControlPressed(0, 21) and IsControlJustReleased(0, 303) then
				if piggyBackInProgress then
					if lastClosestPlayer ~= nil then
						if not IsEntityAttached(GetPlayerPed(-1)) then
							ClearPedSecondaryTask(GetPlayerPed(-1))
							DetachEntity(GetPlayerPed(-1), true, false)
						end
						target = GetPlayerServerId(lastClosestPlayer)
						if target ~= 0 then
							TriggerServerEvent("cmg2_animations:stop", target)
						end
						piggyBackInProgress = false
						lastClosestPlayer = nil
					end
				else
					local closestPlayer = GetClosestPlayer(1.0)
					lastClosestPlayer = closestPlayer
					if closestPlayer ~= -1 and closestPlayer ~= nil and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer), false) then
						target = GetPlayerServerId(closestPlayer)
						if not IsEntityAttached(GetPlayerPed(closestPlayer)) and not IsEntityAttached(GetPlayerPed(-1)) then
							local player = PlayerPedId()
							piggyBackInProgress = true
							isSyncing = true
							TriggerServerEvent("cmg2_animations:sync", closestPlayer, lib, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
						end
					end
				end
			end
			if isEnableFree and piggyBackInProgressTarget == true and piggyBackInProgressTargetPlayer ~= nil then
				if not isRestControl and not isSyncing and IsControlPressed(0, 21) and IsControlJustReleased(0, 303) then
					isSyncing = true
					TriggerServerEvent("cmg2_animations:stop", GetPlayerServerId(piggyBackInProgressTargetPlayer))
					TriggerEvent("cmg2_animations:cl_stop")
				end
			end
			if piggyBackInProgress then
				count = 100
				while not IsEntityPlayingAnim(GetPlayerPed(-1), piggyBackAnimDictPlaying, piggyBackAnimNamePlaying, 3) and count > 0 do
					TaskPlayAnim(GetPlayerPed(-1), piggyBackAnimDictPlaying, piggyBackAnimNamePlaying, 8.0, -8.0, 100000, piggyBackControlFlagPlaying, 0, false, false, false)
					count = count - 1
					Citizen.Wait(0)
				end
			end
			Wait(0)
		end
	end
)

function GetPlayers()
	local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		table.insert(players, player)
	end
	return players
end

function GetClosestPlayer(radius)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for index, value in ipairs(players) do
		local target = GetPlayerPed(value)
		if (target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if (closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function drawNativeNotification(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
