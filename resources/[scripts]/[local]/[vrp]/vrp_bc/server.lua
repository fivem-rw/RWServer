----------------- vRP Broadcast Player
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_videocontrolS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_videocontrol")
vrp_videocontrolC = Tunnel.getInterface("vrp_videocontrol", "vrp_videocontrol")
Tunnel.bindInterface("vrp_videocontrol", vrp_videocontrolS)

local isPlay = true
local playerInfo = {}

RegisterNetEvent("proxy_vrp_bc:resume")
AddEventHandler(
	"proxy_vrp_bc:resume",
	function(p_index)
		if not p_index then
			return
		end
		if not playerInfo[p_index] then
			return
		end
		playerInfo[p_index].isPlay = true
		local selPlayerInfo = playerInfo[p_index]
		vrp_videocontrolC.setPlay(-1, {p_index, selPlayerInfo.type, selPlayerInfo.url, selPlayerInfo.volume, selPlayerInfo.time})
	end
)

RegisterNetEvent("proxy_vrp_bc:pause")
AddEventHandler(
	"proxy_vrp_bc:pause",
	function(p_index)
		if not p_index then
			return
		end
		if not playerInfo[p_index] then
			return
		end
		playerInfo[p_index].isPlay = false
		vrp_videocontrolC.setStop(-1, {p_index})
	end
)

RegisterCommand(
	"bc",
	function(source, args)
		local selPlayerIndex = nil
		local coords = GetEntityCoords(GetPlayerPed(source))
		for k, v in pairs(playerInfo) do
			local dist = #(coords - v.coords)
			if dist < v.dist then
				selPlayerIndex = k
			end
		end
		if not selPlayerIndex then
			return
		end
		local selPlayerInfo = playerInfo[selPlayerIndex]
		local user_id = vRP.getUserId({source})
		if user_id then
			if vRP.hasPermission({user_id, "admin.godmode"}) then
				local cmd = args[1]
				if cmd == "play" then
					if args[2] then
						selPlayerInfo.type = args[2]
						selPlayerInfo.url = args[3] or ""
						selPlayerInfo.time = 0
					end
					selPlayerInfo.isPlay = true
					vrp_videocontrolC.setPlay(-1, {selPlayerIndex, selPlayerInfo.type, selPlayerInfo.url, selPlayerInfo.volume, selPlayerInfo.time})
				elseif cmd == "pause" then
					selPlayerInfo.isPlay = false
					vrp_videocontrolC.setStop(-1, {selPlayerIndex})
				elseif cmd == "stop" then
					selPlayerInfo.url = ""
					selPlayerInfo.time = 0
					selPlayerInfo.isPlay = false
					vrp_videocontrolC.setStop(-1, {selPlayerIndex})
				elseif cmd == "volume" then
					selPlayerInfo.volume = args[2]
					vrp_videocontrolC.setPlay(-1, {selPlayerIndex, selPlayerInfo.type, selPlayerInfo.url, selPlayerInfo.volume, selPlayerInfo.time})
				elseif cmd == "time" then
					selPlayerInfo.time = tonumber(args[2])
					vrp_videocontrolC.setPlay(-1, {selPlayerIndex, selPlayerInfo.type, selPlayerInfo.url, selPlayerInfo.volume, selPlayerInfo.time})
				end
			end
		end
	end
)

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, last_login)
		Citizen.Wait(10000)
		for k, v in pairs(playerInfo) do
			if v.isPlay then
				vrp_videocontrolC.setPlay(source, {k, v.type, v.url, v.volume, v.time})
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		for k, v in pairs(Config.screens) do
			local pi = {
				coords = v[3],
				dist = v[4],
				isPlay = false,
				type = "y",
				url = "",
				volume = 20,
				time = 0
			}
			table.insert(playerInfo, pi)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			for k, v in pairs(playerInfo) do
				if v.isPlay then
					v.time = v.time + 1
				end
			end
		end
	end
)
