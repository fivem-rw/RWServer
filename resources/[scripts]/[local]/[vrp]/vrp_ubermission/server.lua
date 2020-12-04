local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_ubermission")


local price = 5000

RegisterServerEvent("dropOff")
AddEventHandler("dropOff", function(vehPrice)
    local source = source
    local player = vRP.getUserSource({user_id})
    local user_id = vRP.getUserId({source})
        vRP.giveMoney({user_id,price})
        TriggerClientEvent('chatMessage', source, "", {0, 200, 60}, "택시비를 받았습니다. ^2" .. price)
        CancelEvent()
end)
