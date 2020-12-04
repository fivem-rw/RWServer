vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_hunting")

local Keys = {
	["ESC"] = 322,
	["F1"] = 288,
	["F2"] = 289,
	["F3"] = 170,
	["F5"] = 166,
	["F6"] = 167,
	["F7"] = 168,
	["F8"] = 169,
	["F9"] = 56,
	["F10"] = 57,
	["~"] = 243,
	["1"] = 157,
	["2"] = 158,
	["3"] = 160,
	["4"] = 164,
	["5"] = 165,
	["6"] = 159,
	["7"] = 161,
	["8"] = 162,
	["9"] = 163,
	["-"] = 84,
	["="] = 83,
	["BACKSPACE"] = 177,
	["TAB"] = 37,
	["Q"] = 44,
	["W"] = 32,
	["E"] = 38,
	["R"] = 45,
	["T"] = 245,
	["Y"] = 246,
	["U"] = 303,
	["P"] = 199,
	["["] = 39,
	["]"] = 40,
	["ENTER"] = 18,
	["CAPS"] = 137,
	["A"] = 34,
	["S"] = 8,
	["D"] = 9,
	["F"] = 23,
	["G"] = 47,
	["H"] = 74,
	["K"] = 311,
	["L"] = 182,
	["LEFTSHIFT"] = 21,
	["Z"] = 20,
	["X"] = 73,
	["C"] = 26,
	["V"] = 0,
	["B"] = 29,
	["N"] = 249,
	["M"] = 244,
	[","] = 82,
	["."] = 81,
	["LEFTCTRL"] = 36,
	["LEFTALT"] = 19,
	["SPACE"] = 22,
	["RIGHTCTRL"] = 70,
	["HOME"] = 213,
	["PAGEUP"] = 10,
	["PAGEDOWN"] = 11,
	["DELETE"] = 178,
	["LEFT"] = 174,
	["RIGHT"] = 175,
	["TOP"] = 27,
	["DOWN"] = 173,
	["NENTER"] = 201,
	["N4"] = 108,
	["N5"] = 60,
	["N6"] = 107,
	["N+"] = 96,
	["N-"] = 97,
	["N7"] = 117,
	["N8"] = 61,
	["N9"] = 118
}

local PlayerData = {}

hunt = nil

Citizen.CreateThread(
	function()
		while hunt == true do
			Citizen.Wait(10)
		end
		ScriptLoaded()
	end
)

RegisterNetEvent("playerLoaded")
AddEventHandler(
	"playerLoaded",
	function(player)
		PlayerData = player
	end
)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{x = -1505.2, y = 4887.39, z = 78.38},
	{x = -1164.68, y = 4806.76, z = 223.11},
	{x = -1410.63, y = 4730.94, z = 44.0369},
	{x = -1377.29, y = 4864.31, z = 134.162},
	{x = -1697.63, y = 4652.71, z = 22.2442},
	{x = -1259.99, y = 5002.75, z = 151.36},
	{x = -960.91, y = 5001.16, z = 183.0},
	{x = -967.91, y = 5001.16, z = 183.0},
	{x = -964.91, y = 5001.16, z = 183.0},
	{x = -970.91, y = 5001.16, z = 183.0},
	{x = -978.91, y = 5001.16, z = 183.0}
}

local AnimalsInSession = {}

local Positions = {
	["StartHunting"] = {["text"] = "[E]HUNT START", ["x"] = -1496.7020263672, ["y"] = 4980.9282226563, ["z"] = 63.024227142334},
	["Sell"] = {["text"] = "[E]SELL", ["x"] = -1494.4362792969, ["y"] = 4992.2934570313, ["z"] = 62.712162017822}
}

local OnGoingHuntSession = false

function LoadMarkers()
	Citizen.CreateThread(
		function()
			for index, v in ipairs(Positions) do
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Hunting Spot")
				EndTextCommandSetBlipName(StartBlip)
			end
		end
	)

	LoadModel("a_c_boar")
	LoadAnimDict("amb@medic@standing@kneel@base")
	LoadAnimDict("anim@gangops@facility@servers@bodysearch@")

	Citizen.CreateThread(
		function()
			while true do
				local sleep = 500

				local plyCoords = GetEntityCoords(PlayerPedId())

				for index, value in pairs(Positions) do
					if value.text ~= nil then
						if OnGoingHuntSession and index == "StartHunting" then
							value.text = "[E]HUNT STOP"
						elseif not OnGoingHuntSession and index == "StartHunting" then
							value.text = "[E]HUNT START"
						--DrawText3D(-1496.7020263672, 4980.9282226563, 63.024227142334, "Start Hunting")
						end

						local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

						if distance < 15.0 then
							sleep = 5
							DrawM(value.text, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
							if distance < 1.0 then
								if IsControlJustReleased(0, Keys["E"]) then
									if index == "StartHunting" then
										CheckPermission()
									else
										SellItems()
									end
								end
							end
						end
					end
				end
				Citizen.Wait(sleep)
			end
		end
	)
end

function CheckPermission()
	TriggerServerEvent("koyou:vrphuntingpermission")
end

RegisterNetEvent("koyou:vrphuntingpermission")
AddEventHandler(
	"koyou:vrphuntingpermission",
	function()
		StartHuntingSession()
	end
)

function StartHuntingSession()
	if OnGoingHuntSession then
		OnGoingHuntSession = false

		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)
		hunt = nil

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end
	else
		OnGoingHuntSession = true

		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), 0, true, false)

		--Animals

		Citizen.CreateThread(
			function()
				for index, value in pairs(AnimalPositions) do
					local Animal = CreatePed(RWP, 5, GetHashKey("a_c_boar"), value.x, value.y, value.z, 0.0, true, false)
					TaskWanderStandard(Animal, true, true)
					SetEntityAsMissionEntity(Animal, true, true)
					--Blips

					local AnimalBlip = AddBlipForEntity(Animal)
					SetBlipSprite(AnimalBlip, 141)
					SetBlipColour(AnimalBlip, 1)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("멧돼지")
					EndTextCommandSetBlipName(AnimalBlip)

					table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
				end

				while OnGoingHuntSession do
					local sleep = 500
					for index, value in ipairs(AnimalsInSession) do
						if DoesEntityExist(value.id) then
							local AnimalCoords = GetEntityCoords(value.id)
							local PlyCoords = GetEntityCoords(PlayerPedId())
							local AnimalHealth = GetEntityHealth(value.id)

							local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

							if AnimalHealth <= 0 then
								SetBlipColour(value.Blipid, 3)
								if PlyToAnimal < 2.0 then
									sleep = 5
									x = AnimalCoords.x
									y = AnimalCoords.y
									z = AnimalCoords.z
									DrawText3D(x, y, z + 1.0, "[E]DROP")
									--DrawM({deer.text, 27, x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z - 0.945, 255, 255, 255, 1.5, 15})

									if IsControlJustReleased(0, Keys["E"]) then
										--if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
										if DoesEntityExist(value.id) then
											table.remove(AnimalsInSession, index)
											SlaughterAnimal(value.id)
										--end
										--else
										--vRP.notify({"칼을 이용해야 합니다!"})
										end
									end
								end
							end
						end
					end

					Citizen.Wait(sleep)
				end
			end
		)
	end
end

function SlaughterAnimal(AnimalId)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false, false)

	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	TriggerServerEvent("vrp-koyou-hunting:reward", AnimalWeight)

	DeleteEntity(AnimalId)
end

function SellItems()
	TriggerServerEvent("vrp-koyou-hunting:sell")
end

function LoadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(10)
	end
end

function DrawText3D(x, y, z, text)
	coords = vector3(x, y, z)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	SetTextScale(0.6, 0.6)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	--local factor = (string.len(text)) / 370
	--DrawRect(_x,_y+0.0125, 0.015+factor, 0.03, 41, 41, 41, 68)
	SetDrawOrigin()
	ClearDrawOrigin()
end

function DrawM(text, type, x, y, z)
	DrawText3D(x, y, z + 1.0, text)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end
