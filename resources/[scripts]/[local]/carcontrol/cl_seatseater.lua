local doors = {
	{"seat_dside_f", -1},
	{"seat_pside_f", 0},
	{"seat_dside_r", 1},
	{"seat_pside_r", 2}
}

function VehicleInFront(ped)
	local pos = GetEntityCoords(ped)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
	local _, _, _, _, result = GetRaycastResult(rayHandle)

	return result
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local ped = PlayerPedId()

			if IsControlPressed(0, 21) and IsControlJustReleased(0, 23) and running ~= true and GetVehiclePedIsIn(ped, false) == 0 then
				local vehicle = VehicleInFront(ped)

				running = true

				if vehicle ~= nil then
					local plyCoords = GetEntityCoords(ped, false)
					local doorDistances = {}

					for k, door in pairs(doors) do
						local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
						local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
						local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, doorPos.x, doorPos.y, doorPos.z)

						table.insert(doorDistances, distance)
					end

					local key, min = 1, doorDistances[1]

					for k, v in ipairs(doorDistances) do
						if doorDistances[k] < min then
							key, min = k, v
						end
					end

					TaskEnterVehicle(ped, vehicle, -1, doors[key][2], 1.5, 1, 0)
				end

				running = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(100)
			local ped = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(ped, false)
			local passenger = GetPedInVehicleSeat(vehicle, 0)

			if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
				if (IsPedSittingInAnyVehicle(ped)) then
					if IsVehicleSeatFree(vehicle, -1) then
						if ped == passenger then
							SetPedIntoVehicle(ped, vehicle, 0)
						end
					end
				end
			end
		end
	end
)
