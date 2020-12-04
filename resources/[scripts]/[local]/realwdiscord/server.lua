local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vRP:Discord")
AddEventHandler(
    "vRP:Discord",
    function()
        local user_id = vRP.getUserId({source})
        if user_id == nil then
            return
        end
        local faction = vRP.getUserGroupByType({user_id, "job"})
        local name = vRP.getPlayerName({source})
        if false then
            TriggerClientEvent("vRP:Discord-rich", source, user_id, faction, name)
        end
    end
)
