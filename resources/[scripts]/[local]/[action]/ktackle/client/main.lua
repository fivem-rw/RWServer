-- 2018 Henric 'Kekke' Johansson

vRP = Proxy.getInterface("vRP")

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

local isRestControl = false

local isTackling = false
local isGettingTackled = false

local tackleLib = "missmic2ig_11"
local tackleAnim = "mic_2_ig_11_intro_goon"
local tackleVictimAnim = "mic_2_ig_11_intro_p_one"

local lastTackleTime = 0
local isRagdoll = false

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

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if isRagdoll then
				SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			end
		end
	end
)

RegisterNetEvent("tackle:getTackled")
AddEventHandler(
	"tackle:getTackled",
	function(target)
		isGettingTackled = true

		local playerPed = GetPlayerPed(-1)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

		RequestAnimDict(tackleLib)

		while not HasAnimDictLoaded(tackleLib) do
			Citizen.Wait(10)
		end

		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
		TaskPlayAnim(playerPed, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

		Citizen.Wait(3000)
		DetachEntity(GetPlayerPed(-1), true, false)

		exports["progressBars"]:startUI(3000, "회복중")

		isRagdoll = true
		Citizen.Wait(3000)
		isRagdoll = false

		isGettingTackled = false
	end
)

RegisterNetEvent("tackle:playTackle")
AddEventHandler(
	"tackle:playTackle",
	function()
		local playerPed = GetPlayerPed(-1)

		RequestAnimDict(tackleLib)

		while not HasAnimDictLoaded(tackleLib) do
			Citizen.Wait(10)
		end

		TaskPlayAnim(playerPed, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

		Citizen.Wait(3000)

		isTackling = false
	end
)

Citizen.CreateThread(
	function()
		while true do
			Wait(0)
			if not isRestControl and IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["Q"]) and not isTackling and GetGameTimer() - lastTackleTime > 10 * 1000 then
				if not isTackling and not isGettingTackled then
					local closestPlayer = GetClosestPlayer(Config.TackleDistance)
					local closestPlayerPed = GetPlayerPed(closestPlayer)
					local playerPed = GetPlayerPed(-1)
					if closestPlayer ~= nil then
						if not IsPedInAnyVehicle(closestPlayerPed) and not IsPedInAnyVehicle(playerPed) then
							if not IsEntityAttached(closestPlayerPed) and not IsEntityAttached(playerPed) then
								if not IsPedRagdoll(closestPlayerPed) and not IsPedRagdoll(playerPed) then
									isTackling = true
									lastTackleTime = GetGameTimer()
									TriggerServerEvent("tackle:tryTackle", GetPlayerServerId(closestPlayer))
								end
							end
						end
					end
				end
			end
		end
	end
)

RegisterNetEvent("vrp_ktackle:changeRestControl")
AddEventHandler(
	"vrp_ktackle:changeRestControl",
	function(value)
		isRestControl = value
	end
)
