vrp_sitchairC = {}
Tunnel.bindInterface("vrp_sitchair", vrp_sitchairC)
Proxy.addInterface("vrp_sitchair", vrp_sitchairC)
vRP = Proxy.getInterface("vRP")
vrp_sitchairS = Tunnel.getInterface("vrp_sitchair", "vrp_sitchair")

local debugProps, sitting, lastPos, currentSitCoords, currentScenario = {}

function DrawText3D(coords, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 370
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function getObjects()
	local objects = {}

	for object in Enumerator.EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

function getClosestObject(filter, coords)
	local objects = getObjects()
	local closestDistance, closestObject = -1, -1
	local filter, coords = filter, coords

	if type(filter) == "string" then
		if filter ~= "" then
			filter = {filter}
		end
	end

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for i = 1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == "table" and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j = 1, #filter, 1 do
				if objectModel == tonumber(filter[j]) or objectModel == GetHashKey(filter[j]) then
					foundObject = true
					break
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance = #(objectCoords - coords)

			if closestDistance == -1 or closestDistance > distance then
				closestObject = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end

if Config.Debug then
	Citizen.CreateThread(
		function()
			while true do
				Citizen.Wait(0)

				for i = 1, #debugProps, 1 do
					local coords = GetEntityCoords(debugProps[i])
					local hash = GetEntityModel(debugProps[i])
					local id = coords.x .. coords.y .. coords.z
					local model = "unknown"

					for i = 1, #Config.Interactables, 1 do
						local seat = Config.Interactables[i]

						if hash == GetHashKey(seat) then
							model = seat
							break
						end
					end

					local text = ("ID: %s~n~Hash: %s~n~Model: %s"):format(id, hash, model)

					DrawText3D(
						{
							x = coords.x,
							y = coords.y,
							z = coords.z + 2.0
						},
						text,
						0.5
					)
				end

				if #debugProps == 0 then
					Citizen.Wait(500)
				end
			end
		end
	)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
				wakeup()
			end

			if IsControlJustPressed(0, 38) and IsControlPressed(0, 21) and IsInputDisabled(0) and IsPedOnFoot(playerPed) then
				if sitting then
					wakeup()
				else
					local object, distance = getClosestObject(Config.Interactables)

					if Config.Debug then
						table.insert(debugProps, object)
					end

					if distance < 1.5 then
						local hash = GetEntityModel(object)

						for k, v in pairs(Config.Sitable) do
							if tonumber(k) == hash or GetHashKey(k) == hash then
								sit(object, k, v)
								break
							end
						end
					end
				end
			end
		end
	end
)

function wakeup()
	local playerPed = PlayerPedId()
	ClearPedTasks(playerPed)

	sitting = false

	SetEntityCoords(playerPed, lastPos)
	FreezeEntityPosition(playerPed, false)

	TriggerServerEvent("esx_sit:leavePlace", currentSitCoords)
	currentSitCoords, currentScenario = nil, nil
end

function sit(object, modelName, data)
	local pos = GetEntityCoords(object)
	local objectCoords = pos.x .. pos.y .. pos.z

	vrp_sitchairS.getPlace(
		{},
		function(occupied)
			if occupied then
				--ShowNotification("Cette place est prise...")
			else
				local playerPed = PlayerPedId()
				lastPos, currentSitCoords = GetEntityCoords(playerPed), objectCoords

				TriggerServerEvent("esx_sit:takePlace", objectCoords)
				FreezeEntityPosition(object, true)

				currentScenario = data.scenario
				data.headingOffset = data.headingOffset or 0.0
				TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z - data.verticalOffset, GetEntityHeading(object) + 180.0 - data.headingOffset, 3600000, true, true)
				Citizen.Wait(1000)
				sitting = true
			end
		end
	)
end
