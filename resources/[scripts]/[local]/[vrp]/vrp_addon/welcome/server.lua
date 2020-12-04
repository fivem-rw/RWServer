local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local user_id = vRP.getUserId({source})
    local faction = vRP.getUserGroupByType({user_id,"job"})
	local name = vRP.getPlayerName({source})
	local money = vRP.getMoney({user_id})
	local bmoney = vRP.getBankMoney({user_id})
	local server_env = GetConvar('server_env','pro')
	TriggerClientEvent('HG:Welcome', source, user_id, faction, name, money, bmoney, server_env)
end)