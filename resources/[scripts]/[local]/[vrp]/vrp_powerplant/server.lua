--------------------------------
----- Converting By. 알고리즘 -----
-------------------------------- 
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_powerplant")

local info = {stage = 0, style = nil, locked = false}
local blackoutstatus = false
local blackoutdur = 7000 -- 정전 시간 (초) 예시) 5초
local cooldown = 7200 -- 발전소를 다시 시작 하는 시간 (초) 예시) 6초

RegisterServerEvent("utk_pb:updateUTK")
RegisterServerEvent("utk_pb:lock")
RegisterServerEvent("utk_pb:handlePlayers")
RegisterServerEvent("utk_pb:blackout")
RegisterServerEvent("utk_pb:checkblackout")

RegisterServerEvent('utk_pb:GetData')
AddEventHandler('utk_pb:GetData', function()
    TriggerClientEvent('utk_pb:GetData', source, info, true)
end)

RegisterServerEvent('utk_pb:normal_c4_checkItem')
AddEventHandler('utk_pb:normal_c4_checkItem', function()
	local user_id = vRP.getUserId({source})
	local item = vRP.getInventoryItemAmount({user_id, "normal_c4"})

    if item >= 1 then
	TriggerClientEvent('utk_pb:normal_c4_checkItem', source, true)
    else
	TriggerClientEvent('utk_pb:normal_c4_checkItem', source, false)
    end
end)

RegisterServerEvent('utk_pb:laptop_h_checkItem')
AddEventHandler('utk_pb:laptop_h_checkItem', function()
	local user_id = vRP.getUserId({source})
	local item = vRP.getInventoryItemAmount({user_id, "laptop_h"})

    if item >= 1 then
	TriggerClientEvent('utk_pb:laptop_h_checkItem', source, true)
    else
	TriggerClientEvent('utk_pb:laptop_h_checkItem', source, false)
    end
end)

RegisterServerEvent('utk_pb:mini_c4_checkItem')
AddEventHandler('utk_pb:mini_c4_checkItem', function()
	local user_id = vRP.getUserId({source})
	local item = vRP.getInventoryItemAmount({user_id, "mini_c4"})

    if item >= 1 then
	TriggerClientEvent('utk_pb:mini_c4_checkItem', source, true)
    else
	TriggerClientEvent('utk_pb:mini_c4_checkItem', source, false)
    end
end)

AddEventHandler("utk_pb:updateUTK", function(table)
    info = {stage = table.info.stage, style = table.info.style, locked = table.info.locked}
    local xPlayers = vRP.getUsers({})
	for k,v in pairs(xPlayers) do
    TriggerClientEvent("utk_pb:upUTK", v, table)
	end
end)

RegisterServerEvent("utk_pb:normal_c4_removeItem")
AddEventHandler("utk_pb:normal_c4_removeItem", function()
    local user_id = vRP.getUserId({source})
	vRP.tryGetInventoryItem({user_id, "normal_c4", 1, true})
end)

RegisterServerEvent("utk_pb:mini_c4_removeItem")
AddEventHandler("utk_pb:mini_c4_removeItem", function()
    local user_id = vRP.getUserId({source})
	vRP.tryGetInventoryItem({user_id, "mini_c4", 1, true})
end)

RegisterServerEvent("utk_pb:laptop_h_removeItem")
AddEventHandler("utk_pb:laptop_h_removeItem", function()
    local user_id = vRP.getUserId({source})
	vRP.tryGetInventoryItem({user_id, "laptop_h", 1, true})
end)

AddEventHandler("utk_pb:lock", function(targetCoords, streetName)
local xPlayers = vRP.getUsers({})
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})

	for k,v in pairs(xPlayers) do
        if v ~= source then
    TriggerClientEvent("utk_pb:lock_c",v)
    --TriggerClientEvent("chatMessage", -1, "🚨 ^1속보 ", {255, 255, 255}, "^2" .. GetPlayerName(player) .. " ^*( " .. user_id .. " )님이 ^1발전소 습격 미션 RP^0를 시작 하였습니다!")
    TriggerClientEvent("vrp_powerplant:missionComplete", source)
end
end
end)

AddEventHandler("utk_pb:handlePlayers", function()
local xPlayers = vRP.getUsers({})
	for k,v in pairs(xPlayers) do
    TriggerClientEvent("utk_pb:handlePlayers_c", v)
	end
end)

AddEventHandler("utk_pb:checkblackout", function()
    if blackoutstatus == true then
        TriggerClientEvent("utk_pb:power", source, true)
    end
end)

AddEventHandler("utk_pb:blackout", function(status)
    blackoutstatus = true
	local xPlayers = vRP.getUsers({})
	for k,v in pairs(xPlayers) do
        TriggerClientEvent("utk_pb:power", v, status)
    end
    BlackoutTimer()
end)

RegisterServerEvent('utk_pb:chackPlayers')
AddEventHandler('utk_pb:chackPlayers', function()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id,"cop.whitelist"}) then
		TriggerClientEvent('utk_pb:chackPlayers', source, true)
	else
		TriggerClientEvent('utk_pb:chackPlayers', source, false)
	end
end)

function BlackoutTimer()
    local timer = blackoutdur
    repeat
        Citizen.Wait(1000)
        timer = timer - 1
    until timer == 0
    blackoutstatus = false
	local xPlayers = vRP.getUsers({})
	for k,v in pairs(xPlayers) do
    TriggerClientEvent("utk_pb:power", v, false)
	end
    Cooldown()
end
function Cooldown()
    local timer = cooldown
    repeat
        Citizen.Wait(1000)
        timer = timer - 1
    until timer == 0
    info = {stage = 0, style = nil}
	local xPlayers = vRP.getUsers({})
	for k,v in pairs(xPlayers) do
        TriggerClientEvent("utk_pb:reset", v)
    end
end

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		while false do
			NPC = math.random(1, #Config.MissionNPC)
			Citizen.Wait(7200000 * 2)
		end
	end
)

AddEventHandler(
	"vRP:playerSpawn",
	function(source)
		if NPC ~= 0 and Config.MissionNPC[NPC] ~= nil then
		end
	end
)