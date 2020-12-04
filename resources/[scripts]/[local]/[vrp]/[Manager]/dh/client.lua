----------------- Detect Hack
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
dhC = {}
Tunnel.bindInterface("dh", dhC)
Proxy.addInterface("dh", dhC)
dhS = Tunnel.getInterface("dh", "dh")

local showInfoCount = 0
local isFreeze = false

function dhC.freeze()
	isFreeze = true
end

function dhC.printEntity(entity)
	local model = GetEntityModel(entity)
	local displaytext = GetDisplayNameFromVehicleModel(model)
	local name = GetLabelText(displaytext)
	dhS.printEntity({displaytext})
end

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName("[" .. showInfoCount .. "]" .. text)
	DrawNotification(false, false)
	showInfoCount = showInfoCount + 1
end

function scenrionahoi(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)
end

local function SpectatePlayerSet(id, set)
	local player = GetPlayerPed(id)
	RequestCollisionAtCoord(GetEntityCoords(player))
	NetworkSetInSpectatorMode(set, player)
end

Citizen.CreateThread(
	function()
		local player = PlayerId()
		while false do
			--SetRunSprintMultiplierForPlayer(player, 1.0)
			--SetSwimMultiplierForPlayer(player, 1.0)
			Citizen.Wait(0)
		end
	end
)

-- 무적핵
local getHealthValue = 2000
local newHealthValue = 0
Citizen.CreateThread(
	function()
		while false do
			local ped = PlayerPedId()
			local healthValue = GetEntityHealth(ped)
			if (healthValue <= 200) then
				if HasEntityBeenDamagedByAnyPed(ped) or HasEntityBeenDamagedByAnyObject(ped) or HasEntityBeenDamagedByAnyVehicle(ped) then
					--scenrionahoi("----------------------------")
					newHealthValue = GetEntityHealth(ped)
					if getHealthValue <= newHealthValue then
						--dhS.NotifyHack({"god"})
						getHealthValue = 2000
						ClearEntityLastDamageEntity(ped)
					end
				else
					--scenrionahoi("normal")
					getHealthValue = GetEntityHealth(ped)
				end
			else
				--dhS.NotifyHack({"god"})
			end
			Citizen.Wait(50)
		end
	end
)

-- 스피드핵
local maxSpeed = 0.0
local isNotOnFoot = false
local getPos = 0.0
local oldPos = 0.0

Citizen.CreateThread(
	function()
		local ped = PlayerPedId()
		while false do
			local speed = GetEntitySpeed(ped)
			if IsPedOnFoot(ped) then
				maxSpeed = 8.1
			else
				maxSpeed = 100.1
				isNotOnFoot = true
			end
			if isNotOnFoot then
				if speed < 1 then
					isNotOnFoot = false
				end
			else
				getPos = GetEntityCoords(ped, true)
				if oldPos == 0.0 then
					oldPos = getPos
				end
				local dist = math.abs(oldPos.x - getPos.x) + math.abs(oldPos.y - getPos.y)
				if speed > maxSpeed and oldPos ~= 0.0 and dist > 0.5 then
				--dhS.NotifyHack({"speed"})
				end
				oldPos = getPos
			end
			Citizen.Wait(10)
		end
	end
)

-- 점프핵
local isJumping = false
local isJumpingHigh = false
local isJumpingHighSet = false
local setPos = 0
local curZ = 0

function dhC.addE()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	AddExplosion(RWE, 235.5, -879.1, 30.2, 1, 0.1, 1, 0, 0.0)
end

Citizen.CreateThread(
	function()
		--SetPedConfigFlag(ped,35,true)
		while false do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			--SetRunSprintMultiplierForPlayer(PlayerId(-1), 1.0)
			--SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
			SetStuntJumpsCanTrigger(false)
			if IsPedJumping(ped) then
				if isJumping == false then
					setPos = GetEntityCoords(ped, true)
					isJumping = true
					isJumpingHigh = false
					isJumpingHighSet = false
				end
				if not isJumpingHighSet then
					curZ = GetEntityCoords(ped, true)[3]
					if curZ - setPos.z > 2 then
						isJumpingHigh = true
					end
					if isJumpingHigh then
						isJumpingHighSet = true
						SetEntityCoords(ped, setPos)
					--dhS.NotifyHack({"jump"})
					end
				end
			else
				isJumping = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		local ped = GetPlayerPed(-1)
		local get = GetEntityAttachedTo(ped)
		while true do
			if NetworkIsInSpectatorMode() then
				dhS.NotifyHack({"monitor"})
				Citizen.Wait(5000)
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		local ped = GetPlayerPed(-1)
		while false do
			if isFreeze then
				FreezeEntityPosition(ped, true)
				ClearPedTasksImmediately(ped)
			else
				FreezeEntityPosition(ped, false)
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		local ped = GetPlayerPed(-1)
		while false do
			if isFreeze then
				Citizen.Wait(30000)
				isFreeze = false
			end
			Citizen.Wait(0)
		end
	end
)
