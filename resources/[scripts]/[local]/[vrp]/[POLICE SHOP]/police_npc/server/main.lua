local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","qualle_policearmory")

local CachedPedState = false

RegisterServerEvent("Police:pedExists")
AddEventHandler("Police:pedExists", function()
    if CachedPedState then
        TriggerClientEvent('Police:pedExists', source, true)
    else
        CachedPedState = true
        TriggerClientEvent('Police:pedExists', source, false)
    end
end)

RegisterServerEvent("Police:giveWeapon")
AddEventHandler("Police:giveWeapon", function(weapon)
    local player = source

    if player then
        vRPclient.giveWeapons(player,{{
		  [weapon] = {ammo=Config.ReceiveAmmo}
		}, false})
    end
end)