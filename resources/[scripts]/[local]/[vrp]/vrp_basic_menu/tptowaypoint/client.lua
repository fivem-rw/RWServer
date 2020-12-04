--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
vRP = Proxy.getInterface("vRP")

local function teleportToWaypoint()
	local targetPed = GetPlayerPed(-1)
	local targetVeh = GetVehiclePedIsUsing(targetPed)
	if (IsPedInAnyVehicle(targetPed)) then
		targetPed = targetVeh
	end

	if (not IsWaypointActive()) then
		vRP.notify({"~r~ Map Marker not found."})
		return
	end

	local waypointBlip = GetFirstBlipInfoId(8) -- 8 = waypoint Id
	local x, y, z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector()))

	-- ensure entity teleports above the ground
	local ground
	local groundFound = false
	local groundCheckHeights = {100.0, 150.0, 50.0, 0.0, 200.0, 250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}

	for i, height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(targetPed, x, y, height, 0, 0, 1)
		Wait(10)

		ground, z = GetGroundZFor_3dCoord(x, y, height)
		if (ground) then
			z = z + 3
			groundFound = true
			break
		end
	end

	if (not groundFound) then
		z = 1000
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- parachute
	end

	SetEntityCoordsNoOffset(targetPed, x, y, z, 0, 0, 1)
	vRP.notify({"~g~ Teleported to waypoint."})
end

local function TeleportToWaypointAdvanced()
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	local success = false
	local blipFound = false
	local blipIterator = GetBlipInfoIdIterator()
	local blip = GetFirstBlipInfoId(8)
	local coords = GetEntityCoords(entity)

	while DoesBlipExist(blip) do
		if GetBlipInfoIdType(blip) == 4 then
			cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
			blipFound = true
			break
		end
		blip = GetNextBlipInfoId(blipIterator)
		Wait(0)
	end

	local stime = 100

	if blipFound then
		local dist = math.abs(#coords - #vector3(cx, cy, cz))
		local time = stime * math.floor(dist / 300)
		if time <= 0 then
			time = stime
		end

		local tx = (cx - coords.x) / time
		local ty = (cy - coords.y) / time
		local tz = (cz - coords.z) / time

		local yaw = GetEntityHeading(entity)

		for i = 0, time, 1 do
			SetEntityCoordsNoOffset(entity, coords.x + (tx * i), coords.y + (ty * i), 0.0, false, false, false, true)
			SetEntityRotation(entity, 0, 0, 0, 0, 0)
			SetEntityHeading(entity, yaw)
			SetGameplayCamRelativeHeading(0)
			Wait(0)
		end

		local groundFound = false
		local yaw = GetEntityHeading(entity)

		for i = 0, 1000, 1 do
			SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false, true)
			SetEntityRotation(entity, 0, 0, 0, 0, 0)
			SetEntityHeading(entity, yaw)
			SetGameplayCamRelativeHeading(0)
			Wait(0)
			if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then
				cz = ToFloat(i)
				groundFound = true
				break
			end
		end
		if not groundFound then
			cz = -300.0
		end
		success = true
	else
		vRP.notify({"~r~지정한 웨이포인트가 없습니다."})
	end

	if success then
		SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true, true)
		SetGameplayCamRelativeHeading(0)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then
			if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
				SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
			end
		end
	end
end

RegisterNetEvent("TpToWaypoint")
AddEventHandler(
	"TpToWaypoint",
	function()
		TeleportToWaypointAdvanced()
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(0, 344) then
				TriggerServerEvent("vrp_basic_menu:TpToWaypoint")
			end
		end
	end
)
