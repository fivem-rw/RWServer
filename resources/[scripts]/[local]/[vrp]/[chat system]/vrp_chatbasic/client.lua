RegisterNetEvent("sendProximityMessage")
AddEventHandler(
	"sendProximityMessage",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {255, 255, 255}, "^*" .. name .. "^0^r:  " .. message, "ic", "ic", "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageB")
AddEventHandler(
	"sendProximityMessageB",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 9.999 then
			TriggerEvent("chatMessage", "", {150, 150, 150}, name .. ":  " .. "^0  " .. message .. "", nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageMe")
AddEventHandler(
	"sendProximityMessageMe",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {255, 0, 0}, " ^6^* * " .. name .. " 이(가) " .. "^6  " .. message, nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageW")
AddEventHandler(
	"sendProximityMessageW",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {255, 255, 255}, "─────────────────────────────────────", nil, "ic")
			TriggerEvent("chatMessage", "", {255, 255, 255}, " ^* 📜 " .. name .. " 이(가) " .. "  " .. message, nil, "ic")
			TriggerEvent("chatMessage", "", {255, 255, 255}, "─────────────────────────────────────", nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageSt")
AddEventHandler(
	"sendProximityMessageSt",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {150, 150, 150}, "^*🙍 " .. name .. "^r의 상태 | " .. "" .. message, nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageTh")
AddEventHandler(
	"sendProximityMessageTh",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {180, 180, 180}, "^*💡 " .. name .. "^r의 생각 | " .. "" .. message,  nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageSh")
AddEventHandler(
	"sendProximityMessageSh",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 49.999 then
			TriggerEvent("chatMessage", "", {255, 0, 0}, "^3^* " .. name .. "의 외침 | " .. message .. " ! ! !",  nil, "ic")
		end
	end
)

RegisterNetEvent("sendProximityMessageMiranda")
AddEventHandler(
	"sendProximityMessageMiranda",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
			TriggerEvent("chatMessage", "", {180, 180, 255}, "👮 | " .. name .. " | 당신은 묵비권을 행사할 수 있고, 변호인을 선임 할 권리가 있으며, 당신이 하는 모든 말은 법정에서 불리하게 작용할 수 있습니다.",  nil, "ic")
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if IsControlJustPressed(0, 246) then
				if GetVehiclePedIsUsing(GetPlayerPed(-1)) ~= 0 then
					TriggerServerEvent("vrp_chatbasic:sendkeys", -1)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if IsControlJustPressed(0, 246) then
				if GetVehiclePedIsUsing(GetPlayerPed(-1)) ~= 0 then
					TriggerServerEvent("vrp_chatbasic:sendkeysrk", -1)
				end
			end
		end
	end
)

RegisterNetEvent("vrp_chatbasic:sendProximityMessagePm1")
AddEventHandler(
	"vrp_chatbasic:sendProximityMessagePm1",
	function(id, name)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		local veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(id)), false)
		local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
		local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
		local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
		local a, b, c, d, e = GetShapeTestResult(frontcar)
		local myplate = GetVehicleNumberPlateText(veh)
		local fplate = GetVehicleNumberPlateText(e)
		if fplate ~= nil then
			if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 49.999 then
				local myplate = GetVehicleNumberPlateText(veh)
				TriggerEvent("chatMessage", "", {0, 165, 255}, "🚨 경찰관 " .. name .. "님의 메가폰🚨\n^7[ ! ! ! ! ! ^1전방 " .. fplate .. " 번 ^7차량 ^1정차^7하세요 ! ! ! ! ! ]", nil, "ic")
			end
		else
			if sonid == monid then
				TriggerEvent("chatMessage", "", {230, 0, 70}, "^*[알림] 전방에 차량이 없습니다." )
			end
		end
	end
)

RegisterNetEvent("vrp_chatbasic:sendProximityMessageRPm1")
AddEventHandler(
	"vrp_chatbasic:sendProximityMessageRPm1",
	function(id, name)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		--local user_id = vRP.getUserId({source})
  	--local player = vRP.getUserSource({user_id})
		if sonid == -1 then
			return
		end
		local veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(id)), false)
		local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
		local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
		local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
		local a, b, c, d, e = GetShapeTestResult(frontcar)
		local myplate = GetVehicleNumberPlateText(veh)
		local fplate = GetVehicleNumberPlateText(e)
		if fplate ~= nil then
			if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 49.999 then
				local myplate = GetVehicleNumberPlateText(veh)
				TriggerEvent("chatMessage","", {255, 155, 255}, "📣 퍼스트렉카 소속" .. name .. "님의 알림사항 ^7차량번호^1[" .. fplate .. "번] ^7차량 차주님 ^1잠시 후^7 견인이 될 예정 입니다.")
				--TriggerClientEvent("chatMessage", -1, "🚨 퍼스트렉카 " .. name .. "님의 메가폰 : ", {255, 255, 255}, "\n^7차량번호" ..fplate .."번 차량 차주" .. GetPlayerName(player) .. " ^*( " .. user_id .. " )님 잠시 후^7 차량이 견인이 될 예정 입니다.")
			end
		else
			if sonid == monid then
				TriggerEvent("chatMessage", "", {230, 0, 70}, "^*[알림] 전방에 차량이 없습니다." )
			end
		end
	end
)

RegisterNetEvent("sendProximityMessagePolice")
AddEventHandler(
	"sendProximityMessagePolice",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if IsPedInAnyPoliceVehicle(GetPlayerPed(GetPlayerFromServerId(id)), false) then
			if sonid == monid or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 49.999 then
				TriggerEvent("chatMessage", "", {0, 230, 255}, "^*🚨 L S P D | " .. name .. "의 메가폰: " .. message .. " ! ! !",  nil, "ic")
			end
		else
			if sonid == monid then
				TriggerEvent("chatMessage", "", {0, 230, 255}, "^*[알림] 경찰차 안이 아닙니다.")
			end
		end
	end
)

RegisterNetEvent("sendProximityMessageError")
AddEventHandler(
	"sendProximityMessageError",
	function(id, name, message)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == -1 then
			return
		end
		if sonid == monid then
			TriggerEvent("chatMessage", "", {255, 255, 0}, "사용할 권한이 없습니다!")
		end
	end
)
