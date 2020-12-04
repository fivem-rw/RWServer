vRPpescarC = {}
Tunnel.bindInterface("vRP_fishing_animations", vRPpescarC)
Proxy.addInterface("vRP_fishing_animations", vRPpescarC)
vRP = Proxy.getInterface("vRP")
vRPSpescar = Tunnel.getInterface("vRP_fishing_animations", "vRP_fishing_animations")

local StartFishing_KEY = 246 -- F3
local Caught_KEY = 246 -- ENTER
local SuccessLimit = 0.07 -- Maxim 0.1 (high value, low success chances)
local AnimationSpeed = 0.0025
local ShowChatMSG = true -- or false
local blips = true -- criar blips area de pesca
local isRest = false

function vRPpescarC.pestele(player)
	RequestModel(GetHashKey("a_c_fish"))
	while (not HasModelLoaded(GetHashKey("a_c_fish"))) do
		Citizen.Wait(1)
	end
	local pos = GetEntityCoords(GetPlayerPed(-1))

	local ped = CreatePed(RWP, 29, 0x2FD800B7, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Wait(5000)
	DeleteEntity(ped)
end
function vRPpescarC.pestele2(player)
	RequestModel(GetHashKey("a_c_stingray"))
	while (not HasModelLoaded(GetHashKey("a_c_stingray"))) do
		Citizen.Wait(1)
	end
	local pos = GetEntityCoords(GetPlayerPed(-1))

	local ped = CreatePed(RWP, 29, 0xA148614D, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Wait(5000)
	DeleteEntity(ped)
end
function vRPpescarC.pestele3(player)
	RequestModel(GetHashKey("a_c_seagull"))
	while (not HasModelLoaded(GetHashKey("a_c_seagull"))) do
		Citizen.Wait(1)
	end
	local pos = GetEntityCoords(GetPlayerPed(-1))

	local ped = CreatePed(RWP, 29, 0xD3939DFD, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Wait(5000)
	DeleteEntity(ped)
end
function vRPpescarC.pestele4(player)
	RequestModel(GetHashKey("a_c_sharktiger"))
	while (not HasModelLoaded(GetHashKey("a_c_sharktiger"))) do
		Citizen.Wait(1)
	end
	local pos = GetEntityCoords(GetPlayerPed(-1))

	local ped = CreatePed(RWP, 29, 0x06C3F072, pos.x + 2, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Wait(5000)
	DeleteEntity(ped)
end

----------------
-- C  O  D  E --
----------------

-- V A R S
local IsFishing = false
local CFish = false
local hasPole = false
local BarAnimation = 0
local Faketimer = 0
local RunCodeOnly1Time = true
local PosX = 0.5
local PosY = 0.1
local TimerAnimation = 0.1

RegisterNetEvent("hasFishingPole")
AddEventHandler(
	"hasFishingPole",
	function()
		hasPole = true
	end
)

RegisterNetEvent("cancel")
AddEventHandler(
	"cancel",
	function()
		hasPole = false
		IsFishing = false
	end
)

function painelNovo_txt(x, y, width, height, scale, text, r, g, b, a, font)
	SetTextFont(6)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

local areas = {
	{name = "동부해안가", id = 68, color = 1, x = -2338.1730957031, y = -1329.3078613281, z = 0},
	{name = "북부해안가", id = 68, color = 1, x = 4224.3237304688, y = 4593.4858398438, z = 0},
	{name = "성", id = 68, color = 1, x = 1884.4443359375, y = 226.18081665039, z = 160.18644714355, r = 25}
}
-- -279.02966308594,6637.2514648438,7.550573348999
function perto()
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	for _, item in pairs(areas) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		local rd = item.r or 50
		if (distance <= rd) then
			return true
		end
	end
end

Citizen.CreateThread(
	function()
		if blips then
			for k, v in ipairs(areas) do
				local blip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(blip, v.id)
				SetBlipScale(blip, 0.8)
				SetBlipAsShortRange(blip, true)
				SetBlipColour(blip, v.color)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(tostring(v.name))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
)

-- T H R E A D
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if not isRest and not IsFishing and IsControlJustReleased(1, Caught_KEY) then
				if not IsPedInAnyVehicle(GetPed(), false) then
					if not IsPedSwimming(GetPed()) then
						--	if IsEntityInWater(GetPed()) then
						if perto() then
							TriggerServerEvent("fishing:item")
							if hasPole then
								IsFishing = true
								if ShowChatMSG then
									notify("~y~낚시를 시작합니다.")
								end
								RunCodeOnly1Time = true
								BarAnimation = 0
							end
						else
							if ShowChatMSG then
							end
						end
					else
						notify("~r~낚시가 불가능한 구역 입니다.")
					end
				--	end
				end
			end

			if perto() then
				painelNovo_txt(0.885, 0.9, 1.0, 1.0, 0.3, "~y~[Y]~w~키를 눌러 낚시를 시작합니다!", 255, 255, 255, 250, 1)
			end

			while IsFishing do
				local time = 4 * 3000
				TaskStandStill(GetPed(), time + 7000)
				FishRod = AttachEntityToPed("prop_fishing_rod_01", 60309, 0, 0, 0, 0, 0, 0)
				PlayAnim(GetPed(), "amb@world_human_stand_fishing@base", "base", 4, 3000)
				Citizen.Wait(time)
				CFish = true
				IsFishing = false
			end
			while CFish do
				Citizen.Wait(1)
				FishGUI(true)
				if RunCodeOnly1Time then
					Faketimer = 3
					RunCodeOnly1Time = false
					PlayAnim(GetPed(), "amb@world_human_stand_fishing@idle_a", "idle_c", Faketimer, 0) -- 10sec
				end
				if TimerAnimation <= 0 then
					CFish = false
					TimerAnimation = 0.1
					StopAnimTask(GetPed(), "amb@world_human_stand_fishing@idle_a", "idle_c", 2.0)
					Citizen.Wait(200)

					SetEntityAsMissionEntity(FishRod)
					Citizen.Wait(100)
					DetachEntity(FishRod, true, true)
					DeleteObject(FishRod)

					notify("~r~물고기를 놓쳤습니다!")
				end
				if not isRest and IsControlJustReleased(1, Caught_KEY) then
					if BarAnimation >= SuccessLimit then
						CFish = false
						TimerAnimation = 0.1
						notify("~g~무언가 낚시대에 걸렸습니다!")
						TriggerServerEvent("fishing:reward")
						StopAnimTask(GetPed(), "amb@world_human_stand_fishing@idle_a", "idle_c", 2.0)
						Citizen.Wait(200)

						SetEntityAsMissionEntity(FishRod)
						Citizen.Wait(100)
						DetachEntity(FishRod, true, true)
						DeleteObject(FishRod)
					else
						CFish = false
						TimerAnimation = 0.1
						notify("~r~물고기를 놓쳤습니다!")
						StopAnimTask(GetPed(), "amb@world_human_stand_fishing@idle_a", "idle_c", 2.0)
						Citizen.Wait(200)

						SetEntityAsMissionEntity(FishRod)
						Citizen.Wait(100)
						DetachEntity(FishRod, true, true)
						DeleteObject(FishRod)
					end
				end
			end
		end
	end
)
Citizen.CreateThread(
	function()
		-- Thread for  timer
		while true do
			Citizen.Wait(500)
			Faketimer = Faketimer + 1
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			isRest = vRP.isInComa({}) or vRP.isInDie({})
		end
	end
)

-- F  U  N  C  T  I  O  N  S
function GetCar()
	return GetVehiclePedIsIn(GetPlayerPed(-1), false)
end
function GetPed()
	return GetPlayerPed(-1)
end
function FishGUI(bool)
	if not bool then
		return
	end
	painelNovo_txt(0.89, 0.9, 1.0, 1.0, 0.3, "~y~[Y]~w~키를 눌러 물고기를 잡습니다.", 255, 255, 255, 250, 1)
	DrawRect(PosX, PosY + 0.005, TimerAnimation, 0.005, 255, 255, 0, 255)
	DrawRect(PosX, PosY, 0.1, 0.01, 0, 0, 0, 255)
	TimerAnimation = TimerAnimation - 0.0001025
	if BarAnimation >= SuccessLimit then
		DrawRect(PosX, PosY, BarAnimation, 0.01, 102, 255, 102, 150)
	else
		DrawRect(PosX, PosY, BarAnimation, 0.01, 255, 51, 51, 150)
	end
	if BarAnimation <= 0 then
		up = true
	end
	if BarAnimation >= PosY then
		up = false
	end
	if not up then
		BarAnimation = BarAnimation - AnimationSpeed
	else
		BarAnimation = BarAnimation + AnimationSpeed
	end
end
function PlayAnim(ped, base, sub, nr, time)
	Citizen.CreateThread(
		function()
			RequestAnimDict(base)
			while not HasAnimDictLoaded(base) do
				Citizen.Wait(1)
			end
			if IsEntityPlayingAnim(ped, base, sub, 3) then
				ClearPedSecondaryTask(ped)
			else
				for i = 1, nr do
					TaskPlayAnim(ped, base, sub, 8.0, -8, -1, 16, 0, 0, 0, 0)
					Citizen.Wait(time)
				end
			end
		end
	)
end
function AttachEntityToPed(prop, bone_ID, x, y, z, RotX, RotY, RotZ)
	BoneID = GetPedBoneIndex(GetPed(), bone_ID)
	obj = CreateObject(RWO, GetHashKey(prop), 1729.73, 6403.90, 34.56, true, true, true)
	vX, vY, vZ = table.unpack(GetEntityCoords(GetPed()))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(GetPed(), 2))
	AttachEntityToEntity(obj, GetPed(), BoneID, x, y, z, RotX, RotY, RotZ, false, false, false, false, 2, true)
	return obj
end

function notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
