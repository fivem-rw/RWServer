--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]
------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "AntiCheat")

RegisterServerEvent("AntiCheat:Cars")
AddEventHandler(
	"AntiCheat:Cars",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local name = GetPlayerName(source)
		local cfg = getConfig()
		print(cfg.anticheat.name .. " | " .. name .. "[" .. user_id .. "] " .. cfg.cars.desc .. " (" .. cfg.cars.reason .. ")!")
		TriggerClientEvent("chatMessage", -1, "^3" .. cfg.anticheat.name, {255, 0, 0}, "^1" .. name .. "^3[ID:" .. user_id .. "]^1 " .. cfg.cars.desc .. " ^3(" .. cfg.anticheat.reason .. ": " .. cfg.cars.reason .. ")!")
		DropPlayer(source, cfg.anticheat.name .. " | " .. cfg.cars.kick .. "! (" .. cfg.cars.reason .. ")")
	end
)

RegisterServerEvent("AntiCheat:Jump")
AddEventHandler(
	"AntiCheat:Jump",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local name = GetPlayerName(source)
		local cfg = getConfig()
		print(cfg.anticheat.name .. " | " .. name .. "[" .. user_id .. "] " .. cfg.jump.desc .. " (" .. cfg.jump.reason .. ")!")
		TriggerClientEvent("chatMessage", -1, "^3" .. cfg.anticheat.name, {255, 0, 0}, "^1" .. name .. "^3[ID:" .. user_id .. "]^1 " .. cfg.jump.desc .. " ^3(" .. cfg.anticheat.reason .. ": " .. cfg.jump.reason .. ")!")
		DropPlayer(source, cfg.anticheat.name .. " | " .. cfg.jump.kick .. "! (" .. cfg.jump.reason .. ")")
	end
)

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, first_spawn)
		local resourceName = "" .. GetCurrentResourceName() .. ""
		local cfg = getConfig()
		vRPclient.notifyPicture(source, {"CHAR_ANTONIA", 1, cfg.anticheat.name, false, cfg.anticheat.protect})
	end
)

AddEventHandler(
	"playerConnecting",
	function(playerName, kick)
		local mysource = source
		local identifiers = GetPlayerIdentifiers(mysource)
		local steamid = identifiers[1]
		local cfg = getConfig()
		if cfg.anticheat.steam_require then
			if steamid:sub(1, 6) == "steam:" then
			else
				kick(cfg.anticheat.name .. "" .. cfg.anticheat.steam)
				CancelEvent()
			end
		end
	end
)

RegisterCommand(
	"ac",
	function(source)
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local name = GetPlayerName(source)
		local cfg = getConfig()
		if vRP.hasPermission({user_id, cfg.anticheat.perm}) then
			TriggerClientEvent("AntiCheat:Toggle", -1, 1)
		else
			vRPclient.notifyPicture(source, {"CHAR_ANTONIA", 1, cfg.anticheat.name, false, cfg.anticheat.no_perm})
		end
	end
)
--[[
PerformHttpRequest(
	"https://www.hackergeo.com/anticheat.txt",
	function(err, text, headers)
		Citizen.Wait(1000)
		local resourceName = "(" .. GetCurrentResourceName() .. ")"
		local cfg = getConfig()
		RconPrint("\n" .. cfg.version.current .. ": " .. cfg.version.version)
		RconPrint("\n" .. cfg.version.new .. ": " .. text)

		if (text ~= cfg.version.version) then
			RconPrint("\n\n\t|||||||||||||||||||||||||||||||||\n\t|| " .. resourceName .. " " .. cfg.version.outdated .. "! ||\n\t|| " .. cfg.version.download .. " ||\n\t||    " .. cfg.version.from .. "   ||\n\t|||||||||||||||||||||||||||||||||\n\n")
		else
			RconPrint("\n\n\t|||||||||||||||||||||||||||||||||\n\t||                             ||\n\t||" .. resourceName .. " " .. cfg.version.updated .. "!||\n\t||                             ||\n\t|||||||||||||||||||||||||||||||||\n\n")
		end
	end,
	"GET",
	"",
	{what = "this"}
)
]]
