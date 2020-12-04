local heat_front = 0.0
local glow_front = 0
local heat_rear = 0.0
local glow_rear = 0
local enabled = 1
rearvehicles = {}
frontvehicles = {}

TriggerEvent('chat:addSuggestion', '/brakediscs', 'Toggle glowing brakediscs.', {})
RegisterCommand("brakediscs", function()
	if(enabled == 1) then
		enabled = 0
		TriggerEvent("chatMessage", "Bot", {255, 255, 255}, "^*Glowing brakediscs disabled.")
	else
		enabled = 1
		TriggerEvent("chatMessage", "Bot", {255, 255, 255}, "^*Glowing brakediscs enabled.")
	end
end)

local players_string
Citizen.CreateThread(function()
	while true do
		Wait(10)
		if(IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyHeli(GetPlayerPed(-1)) and not IsPedInAnyPlane(GetPlayerPed(-1)) and not IsPedInAnyBoat(GetPlayerPed(-1)) and not IsPedInAnySub(GetPlayerPed(-1))) then
			if(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
				if((GetVehicleHandbrake(GetVehiclePedIsIn(GetPlayerPed(-1), 0))) and (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) > 2.0)) then
					Wait(5)
					if(heat_rear < 300) then
						heat_rear = heat_rear + 2
					end
				end
				if(IsVehicleInBurnout(GetVehiclePedIsIn(GetPlayerPed(-1), 0))) then
					if(heat_rear < 300) then
						heat_rear = heat_rear + 2
					end
				end
				if(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) > 2.0) and not (GetVehicleCurrentGear(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) == 0) then
					if(IsControlPressed(27, 72)) then
						if(heat_rear < 300) then
							heat_rear = heat_rear + 2
						end
						if(heat_front < 300) then
							heat_front = heat_front + 2
						end
					end
				end
				if(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) > 2.0) and (GetVehicleCurrentGear(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) == 0) then
					if(IsControlPressed(27, 71)) then
						if(heat_rear < 300) then
							heat_rear = heat_rear + 2
						end
						if(heat_front < 300) then
							heat_front = heat_front + 2
						end
					end
				end
			else
				glow_rear = 0
				glow_front = 0
				heat_rear = 0.0
				heat_front = 0.0
			end
		end
		if(glow_rear == 0) then
			if(heat_rear > 30) then
				GetClosestPlayers()
				while players_string == "-" do
					Wait(100)
				end
				glow_rear = 1
				TriggerServerEvent("brakes:add_rear", VehToNet(GetVehiclePedIsIn(GetPlayerPed(-1), 0)), players_string)
			end
		else
			if(heat_rear < 30) then
				glow_rear = 0
				TriggerServerEvent("brakes:rem_rear", VehToNet(GetVehiclePedIsIn(GetPlayerPed(-1), 0)))
			end
		end
		if(glow_front == 0) then
			if(heat_front > 30) then
				GetClosestPlayers()
				while players_string == "-" do
					Wait(100)
				end
				glow_front = 1
				TriggerServerEvent("brakes:add_front", VehToNet(GetVehiclePedIsIn(GetPlayerPed(-1), 0)), players_string)
			end
		else
			if(heat_front < 30) then
				glow_front = 0
				TriggerServerEvent("brakes:rem_front", VehToNet(GetVehiclePedIsIn(GetPlayerPed(-1), 0)))
			end
		end
		if(heat_rear > 1) then
			heat_rear = heat_rear - 1
		end
		if(heat_front > 1) then
			heat_front = heat_front - 1
		end
	end
end)

function GetClosestPlayers()
    local players1 = GetActivePlayers()
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)
	players_string = "-"
	local calculating = "-"
	Citizen.CreateThread(function()
		for i in pairs(players1) do
            playercoords = GetEntityCoords(GetPlayerPed(players1[i]))
            if(GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, playercoords.x, playercoords.y, playercoords.z, 1) < 80) then
				calculating = calculating .. GetPlayerServerId(players1[i]) .. "-"
            end
		end
		players_string = calculating
	end)
end

RegisterNetEvent("cBrakes:add_rear")
AddEventHandler("cBrakes:add_rear", function(vehicle, players)
	if(enabled) then
		if(players:find("%-" .. tostring(GetPlayerServerId(PlayerId())) .. "%-")) then
			table.insert(rearvehicles, NetToVeh(vehicle))
		end
	end
end)
RegisterNetEvent("cBrakes:add_front")
AddEventHandler("cBrakes:add_front", function(vehicle, players)
	if(enabled) then
		if(players:find("%-" .. tostring(GetPlayerServerId(PlayerId())) .. "%-")) then
			table.insert(frontvehicles, NetToVeh(vehicle))
		end
	end
end)
RegisterNetEvent("cBrakes:rem_rear")
AddEventHandler("cBrakes:rem_rear", function(vehicle)
	for i in pairs(rearvehicles) do
		if(rearvehicles[i] == NetToVeh(vehicle)) then
			table.remove(rearvehicles, i)
			break
		end
	end
end)
RegisterNetEvent("cBrakes:rem_front")
AddEventHandler("cBrakes:rem_front", function(vehicle)
	for i in pairs(frontvehicles) do
		if(frontvehicles[i] == NetToVeh(vehicle)) then
			table.remove(frontvehicles, i)
			break
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		for IR in pairs(rearvehicles) do
			if(IsVehicleSeatFree(rearvehicles[IR], -1)) then
				table.remove(rearvehicles, IR)
			else
				UseParticleFxAsset("core")
				disc_LR = StartParticleFxLoopedOnEntityBone("veh_exhaust_afterburner", rearvehicles[IR], 0.0 - 0.03, 0.0, 0.0, 0.0, 0.0, 90.0, GetEntityBoneIndexByName(rearvehicles[IR], "wheel_lr"), 0.45, 0.0, 0.0, 0.0)
				StopParticleFxLooped(disc_LR, 1)
				UseParticleFxAsset("core")
				disc_RR = StartParticleFxLoopedOnEntityBone("veh_exhaust_afterburner", rearvehicles[IR], 0.0 - 0.03, 0.0, 0.0, 0.0, 0.0, 90.0, GetEntityBoneIndexByName(rearvehicles[IR], "wheel_rr"), 0.45, 0.0, 0.0, 0.0)
				StopParticleFxLooped(disc_RR, 1)	
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		for IF in pairs(frontvehicles) do
			if(IsVehicleSeatFree(frontvehicles[IF], -1)) then
				table.remove(frontvehicles, IF)
			else
				UseParticleFxAsset("core")
				disc_LF = StartParticleFxLoopedOnEntityBone("veh_exhaust_afterburner", frontvehicles[IF], 0.0 - 0.03, 0.0, 0.0, 0.0, 0.0, 90.0, GetEntityBoneIndexByName(frontvehicles[IF], "wheel_lf"), 0.45, 0.0, 0.0, 0.0)
				StopParticleFxLooped(disc_LF, 1)
				UseParticleFxAsset("core")
				disc_RF = StartParticleFxLoopedOnEntityBone("veh_exhaust_afterburner", frontvehicles[IF], 0.0 - 0.03, 0.0, 0.0, 0.0, 0.0, 90.0, GetEntityBoneIndexByName(frontvehicles[IF], "wheel_rf"), 0.45, 0.0, 0.0, 0.0)
				StopParticleFxLooped(disc_RF, 1)
			end
		end
	end
end)