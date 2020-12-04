---------------------------------------------------------
------------- VRP Teleport, RealWorld MAC ---------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_teleportC = {}
Tunnel.bindInterface("vrp_teleport", vrp_teleportC)
Proxy.addInterface("vrp_teleport", vrp_teleportC)
vRP = Proxy.getInterface("vRP")
vrp_teleportS = Tunnel.getInterface("vrp_teleport", "vrp_teleport")

local playerNamesDist = 15
local arrIds = {}
local tpSet = {}
local oldCoords = nil
local initMarkerHeight = 0.5

local function teleport(ped, x, y, z)
	local ground
	local groundFound = false
	local groundCheckHeights = {100.0, 150.0, 50.0, 0.0, 200.0, 250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}

	for i, height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)
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

	SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end

function vrp_teleportC.set(serverId, range)
	tpSet[serverId] = {range = range, height = initMarkerHeight, isAnim = false}
end

function vrp_teleportC.unset(serverId)
	tpSet[serverId] = nil
end

function vrp_teleportC.getTPCoords()
	if IsWaypointActive() then
		local x, y, z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector()))
		return {x, y, z}
	end
	return false
end

function vrp_teleportC.goback(serverId)
	if tpSet[serverId] then
		tpSet[serverId].isAnim = true
		Wait(3000)
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped, true)
		local dist = Vdist(tpSet[serverId].coords, coords)
		if dist <= (tpSet[serverId].range / 2) and oldCoords ~= nil then
			SetEntityCoordsNoOffset(ped, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 1)
			oldCoords = coords
		end
		tpSet[serverId].isAnim = false
		tpSet[serverId].height = initMarkerHeight
	end
end

function vrp_teleportC.go(serverId, x, y, z, ext)
	if tpSet[serverId] then
		tpSet[serverId].isAnim = true
		Wait(3000)
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped, true)
		local dist = Vdist(tpSet[serverId].coords, coords)
		if dist <= (tpSet[serverId].range / 2) then
			if ext then
				SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
			else
				teleport(ped, x, y, z)
			end
			oldCoords = coords
		end
		tpSet[serverId].isAnim = false
		tpSet[serverId].height = initMarkerHeight
	end
end

function vrp_teleportC.go2(serverId, ind, ar1, ar2, ar3)
	if tpSet[serverId] then
		local ped = GetPlayerPed(-1)
		local model = GetEntityModel(ped)
		if not (model == GetHashKey("mp_m_freemode_01") or model == GetHashKey("mp_f_freemode_01")) then
			return
		end
		local coords = GetEntityCoords(ped, true)
		local dist = Vdist(tpSet[serverId].coords, coords)
		if dist <= (tpSet[serverId].range / 2) then
			SetPedComponentVariation(ped, ind, ar1, ar2, ar3)
		end
	end
end

function vrp_teleportC.go3(serverId, model)
	if tpSet[serverId] then
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped, true)
		local dist = Vdist(tpSet[serverId].coords, coords)
		if dist <= (tpSet[serverId].range / 2) then
			if model == "default" then
				vRP.setCustomization(
					{
						{
							model = "mp_m_freemode_01",
							[0] = {0, 0, 0},
							[1] = {0, 0, 0},
							[2] = {0, 0, 0},
							[3] = {0, 0, 0},
							[4] = {4, 0, 2},
							[5] = {0, 0, 0},
							[6] = {5, 2, 2},
							[7] = {0, 0, 0},
							[8] = {0, 0, 2},
							[9] = {0, 1, 2},
							[10] = {0, 0, 0},
							[11] = {0, 3, 2},
							[12] = {0, 0, 0},
							[13] = {0, 0, 0},
							[14] = {0, 0, 255},
							[15] = {0, 0, 100},
							[16] = {131072, 2, 255},
							[17] = {50331904, 0, 255},
							[18] = {0, 2, 255},
							[19] = {131074, 0, 255},
							[20] = {33554946, 2, 255}
						}
					}
				)
				Wait(1000)
				TriggerServerEvent("proxy_vrp_basic_menu:action", "ch_fixhair")
			else
				vRP.setCustomization(
					{
						{
							model = model
						}
					}
				)
			end
		end
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			for _, player in ipairs(GetActivePlayers()) do
				local ped = GetPlayerPed(player)
				if ped ~= 0 then
					arrIds[player] = {ped = ped}
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(100)
			local mPed = GetPlayerPed(-1)
			local mCoords = GetEntityCoords(mPed, true)
			for k, v in pairs(arrIds) do
				if arrIds[k] then
					local coords = GetEntityCoords(v.ped, true)
					arrIds[k].coords = vector3(coords.x, coords.y, coords.z)
					arrIds[k].serverId = GetPlayerServerId(k)
				end
			end
		end
	end
)

local printMarkers = {}

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			for id, value in pairs(arrIds) do
				if value.coords then
					local ss = value.serverId
					if tpSet[ss] then
						tpSet[ss].coords = value.coords
						if printMarkers[ss] then
							printMarkers[ss].coords = tpSet[ss].coords
							printMarkers[ss].range = tpSet[ss].range
							printMarkers[ss].isAnim = tpSet[ss].isAnim
							if not printMarkers[ss].isAnim then
								printMarkers[ss].height = tpSet[ss].height
							end
						else
							printMarkers[ss] = {
								coords = tpSet[ss].coords,
								range = tpSet[ss].range,
								height = tpSet[ss].height,
								isAnim = tpSet[ss].isAnim
							}
						end
					else
						printMarkers[ss] = nil
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			for k, v in pairs(printMarkers) do
				if k and v then
					if v.isAnim then
						v.height = v.height + 0.1
					end
					local ext = parseInt(v.height * 5)
					DrawMarker(25, v.coords.x, v.coords.y, v.coords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.range + 0.0001, v.range + 0.0001, v.height, 255, 255, 255, 100 + ext, 0, 0, 0, 0)
					DrawMarker(25, v.coords.x, v.coords.y, v.coords.z + 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.range + 0.0001, v.range + 0.0001, v.height, 255, 255, 255, 100 + ext, 0, 0, 0, 0)
					DrawMarker(25, v.coords.x, v.coords.y, v.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.range + 0.0001, v.range + 0.0001, v.height, 255, 255, 255, 100 + ext, 0, 0, 0, 0)
					DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.range + 0.0001, v.range + 0.0001, v.height, 255 - ext, 255, 255 - ext, 100 + ext, 0, 0, 0, 0)
				end
			end
		end
	end
)
