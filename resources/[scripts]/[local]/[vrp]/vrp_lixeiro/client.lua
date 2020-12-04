
--[[Script original vrp-fourgon by NENE(mikou)]]--

vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP", "lixeiro")
function LocalPed()
	return GetPlayerPed(-1)
end

local tempo = 300 --TEMPO DE RENOVAÇÃO DO ESTOQUE EM SEGUNDOS
local oldTrashModel = nil
local visits = 1
local l = 0
local area = 0
local onjob = false
local CanLeaveBox = false
local veh
local HashKeyBox = 600967813

modelTrash = {
	[1] = -2096124444,
	--[2] = 600967813,
	[2] = 1388308576,
	[3] = 1948359883,
	[4] = 897494494,
	[5] = 1098827230,
	[6] = -1681329307,
}



local myCoords = {}
local coords = {}

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)

		local myCoords = GetEntityCoords(GetPlayerPed(-1))
		
		for i = 1, #modelTrash do
			closestTrashMachine = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.0, modelTrash[i], false, false)
			if closestTrashMachine ~= nil and closestTrashMachine ~= 0 then
				coords    = GetEntityCoords(closestTrashMachine)
				local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x,coords.y,coords.z, true)
				if distance < 1.50 and onjob then
					nearTrash = true
					openMenuTrash(nearTrash, closestTrashMachine)
				elseif distance >= 1.50 and onjob then
					nearTrash = false
					openMenuTrash(nearTrash)
				end
			end
		end	
	end	
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
		local myCoords = GetEntityCoords(GetPlayerPed(-1))
		veh = getNearVeh(10)
		local model = GetEntityModel(veh)
		
		if model == 1917016601 then
		coordsCar = GetOffsetFromEntityInWorldCoords(veh, 0.0, -3.75, 0.0)	
		local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coordsCar.x,coordsCar.y,coordsCar.z, true)
			if distance < 2.0 and onjob then
				nearTrashCar = true
				openMenuTrashCar(nearTrashCar)
			elseif distance >= 2.25 and onjob then
				nearTrashCar = false
				openMenuTrashCar(nearTrashCar)
			end
		end		
	end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(23, -616.43872070313, -1593.7189941406, 26.751134872437 - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0, 50, 0, 0, 0,0) --- The GoPostal depot location
		if GetDistanceBetweenCoords(-616.43872070313, -1593.7189941406, 26.751134872437, GetEntityCoords(LocalPed())) < 2.0 then
			basiccheck()
		end
	end
end)

RegisterNetEvent('lixeiro:uniforme')
AddEventHandler('lixeiro:uniforme', function()
	Citizen.Wait(1000)
	if GetEntityModel(GetPlayerPed(-1)) == 1885233650 then
		SetPedPropIndex(GetPlayerPed(-1), 0, 121)
		SetPedComponentVariation(GetPlayerPed(-1), 1, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 64)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 53)
		SetPedComponentVariation(GetPlayerPed(-1), 5, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 6, 27)
		SetPedComponentVariation(GetPlayerPed(-1), 7, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15)
		SetPedComponentVariation(GetPlayerPed(-1), 10, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 71)
	elseif GetEntityModel(GetPlayerPed(-1)) == -1667301416 then
		SetPedComponentVariation(GetPlayerPed(-1), 1, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 75)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 55)
		SetPedComponentVariation(GetPlayerPed(-1), 5, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 6, 26)
		SetPedComponentVariation(GetPlayerPed(-1), 7, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 8, 14)
		SetPedComponentVariation(GetPlayerPed(-1), 9, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 10, 0)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 67)
	end
end)

RegisterNetEvent("spawnTrashCAr")
AddEventHandler("spawnTrashCAr", function()
	SpawnTrashCar()
	TriggerEvent('lixeiro:uniforme')
end)

RegisterNetEvent("notrashman")
AddEventHandler("notrashman", function()
  SetNotificationTextEntry("STRING");
  AddTextComponentString("~r~환경미화원만 할 수 있습니다." );
  DrawNotification(false, true);
end)

function openMenuTrash(nearTrash, trashModel)
	if nearTrash then
		drawTxt('쓰레기를 수거하려면 ~g~E~s~ 를 누르세요!', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
		if (IsControlJustPressed(1, 38)) and trashModel ~= oldTrashModel then
			while not HasAnimDictLoaded("missfbi4prepp1") do
				RequestAnimDict("missfbi4prepp1")
				Citizen.Wait(100)
			end
			TaskPlayAnim(GetPlayerPed(PlayerId()), "missfbi4prepp1", "_bag_pickup_garbage_man", 1.0, -1, -1, 50, 0, 0, 0, 0)
			Citizen.Wait(100)	
			oldTrashModel = trashModel
			Wait(1000)
			SetEntityCoords(oldTrashModel, 0.0, 0.0, 0.0, false, false, false, true)
			CanLeaveBox = true	
			ClearPedTasksImmediately(GetPlayerPed(-1))
		end
		if CanLeaveBox then
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
			local prop = CreateObject(RWO, GetHashKey(prop1), x, y, z + 0.2, true, true, true)
			AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x6F06), 0.00, 0.0, -0.7, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('missfbi4prepp1')
			while not HasAnimDictLoaded('missfbi4prepp1') do
				Wait(0)
			end
			TaskPlayAnim(GetPlayerPed(-1), 'missfbi4prepp1', '_bag_walk_garbage_man', 8.0, -8, -1, 49, 0, 0, 0, 0)
			repeat
			Citizen.Wait(100)
			if CanLeaveBox == false then
				DeleteEntity(prop)
			end
			until(CanLeaveBox == false)
		end
	end
end

function openMenuTrashCar(nearTrashCar)
	if nearTrashCar and CanLeaveBox then
		drawTxt('쓰레기를 트럭에 실으려면 ~g~Z~s~ 를 누르세요!', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
		if (IsControlJustPressed(1, 20)) then
			local pid = PlayerPedId()
			SetVehicleDoorOpen(veh,5,false,true)
			DetachEntity(prop, true, false)
			SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
			CanLeaveBox = false
			RequestAnimDict("missfbi4prepp1")
			while (not HasAnimDictLoaded("missfbi4prepp1")) do
				Citizen.Wait(0) 
			end
			TaskPlayAnim(pid,"missfbi4prepp1","_bag_throw_garbage_man",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			Wait(2000)
			StopAnimTask(pid, "missfbi4prepp1","_bag_throw_garbage_man", 1.0)
			TriggerServerEvent("lixeiro:rewardTrash")
			SetVehicleDoorsShut(veh, true)
		end
	end
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function basiccheck()
	if onjob == false then 
		if (IsInVehicle()) then
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("trash")) then
				drawTxt('쓰레기수거를 시작하려면 ~g~E~s~를 누르십시오', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if (IsControlJustReleased(1, 38)) then
					TriggerServerEvent('lixeiro:checkjob')
				end
			else
				drawTxt('쓰레기수거를 시작할려면  ~g~E~s~를 누르십시오', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if (IsControlJustReleased(1, 38)) then
				TriggerServerEvent('lixeiro:checkjob')
				end
			end	
		else
			drawTxt('트럭을 탄 상태에서 ~g~E~s~를 누르십시오', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
			if (IsControlJustReleased(1, 38)) then
				TriggerServerEvent('lixeiro:checkjob')
			end
		end
	else
		drawTxt('쓰레기수거를 그만하실려면 ~g~H~s~를 누르십시오', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
		if (IsControlJustReleased(1, 74)) then
			--TriggerServerEvent('bank:withdrawAmende', destination[l].money)
			--TriggerServerEvent('bank:withdrawAmende', l)
			onjob = false
			RemoveBlip(deliveryblip)
			DeleteEntity(getNearVeh(2))
			SetWaypointOff()
			visits = 1
		end
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function SpawnTrashCar()
	if (IsInVehicle()) then
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("trash")) then
			TriggerEvent('chatMessage', '', {255, 0, 0}, "쓰레기 수거를 시작합니다.", {255,255,255,1.0,'',0, 100, 0, 0.5})
			startjob()
		end
	else
		Citizen.Wait(0)
		TriggerEvent('chatMessage', '', {255, 0, 0}, "차고에 가서 쓰레기 수거트럭을 꺼내십시오..", {255,255,255,1.0,'',0, 100, 0, 0.5})
		startjob()
	end
end

function startjob()

	onjob = true

end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(6)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function getNearVeh(radius)
	local playerPed = GetPlayerPed(-1)
	local coordA = GetEntityCoords(playerPed, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, radius+0.00001, 0.0)
	local nearVehicle = getVehicleInDirection(coordA, coordB)

	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordA)
	    if IsPedSittingInAnyVehicle(playerPed) then
	        local veh = GetVehiclePedIsIn(playerPed, true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 8192+4096+4+2+1)  -- boats, helicos
	        if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 4+2+1) end -- cars
	        return veh
	    end
	end
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end