---------------------------------------------------------
------------ VRP Reboot, RealWorld MAC ------------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_rebootS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_reboot")
vrp_rebootC = Tunnel.getInterface("vrp_reboot", "vrp_reboot")
Tunnel.bindInterface("vrp_reboot", vrp_rebootS)

local isTest = false
local testUserId = 1
local applyPlayer = -1
local remainTime = 0
local isEnable = false

RegisterCommand(
	"setlight",
	function(source, args)
		local set = false
		if args[1] == "on" then
			set = true
		elseif args[1] == "off" then
			set = false
		else
			return
		end
		vrp_rebootC.setLight(-1, {set})
	end
)

RegisterNetEvent("reboot:start")
AddEventHandler(
	"reboot:start",
	function(time)
		if isTest then
			applyPlayer = vRP.getUserSource({testUserId})
		else
			applyPlayer = -1
		end
		time = tonumber(time)
		if isEnable or time < 0.1 then
			return
		end
		remainTime = time * 60
		vrp_rebootC.setRebootTime(applyPlayer, {remainTime})
		isEnable = true
		SetConvar("istest", "reboot")
		print("Start Reboot", remainTime)
		TriggerClientEvent("chatMessage", applyPlayer, "", {255, 255, 255}, "^*^1[알림] ^2서버 종료가 예약되었습니다.")
	end
)

RegisterNetEvent("reboot:stop")
AddEventHandler(
	"reboot:stop",
	function()
		if not isEnable then
			return
		end
		isEnable = false
		SetConvar("istest", "false")
		remainTime = 0
		vrp_rebootC.setRebootTime(applyPlayer, {remainTime})
		print("Stop Reboot")
		TriggerClientEvent("chatMessage", applyPlayer, "", {255, 255, 255}, "^*^1[알림] ^2서버 리붓예약이 취소되었습니다.")
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if isEnable then
				if remainTime > 0 then
					print("Reboot Time: " .. remainTime)
					TriggerClientEvent("chatMessage", applyPlayer, "", {255, 255, 255}, "^*^1[알림] ^2" .. remainTime .. "초^1 후에 서버가 종료됩니다. 안전한곳에서 게임 종료바랍니다.")
					remainTime = remainTime - 10
				else
					isEnable = false
					remainTime = 0
					if isTest then
						print(applyPlayer, "리붓합니다. 잠시후 재접바랍니다.")
					else
						for _, v in ipairs(GetPlayers()) do
							--vRP.kick({v, "리붓합니다. 잠시후 재접바랍니다."})
							vRP.kick({v, "서버가 종료되었습니다. 그동안 리얼월드를 사랑해 주신 모든 분들께 감사드립니다."})
						end
					end
				end
				Citizen.Wait(10000)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			local getRebootConfig = GetConvar("reboot", "false")
			if getRebootConfig ~= "false" then
				if not isEnable then
					TriggerEvent("reboot:start", tonumber(getRebootConfig))
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			local getKickConfig = GetConvar("kick", "")
			if getKickConfig ~= "" then
				local user_id = tonumber(getKickConfig)
				if user_id then
					local player = vRP.getUserSource({user_id})
					if player then
						vRP.kick({player, "[시스템 킥]"})
					end
				end
				SetConvar("kick", "")
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(20000)
			local players = GetPlayers()
			print("Current Players: " .. #players)
		end
	end
)
