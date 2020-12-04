local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","qualle_huwonarmory")

local CachedPedState = false

RegisterServerEvent("KhaichiPed:pedExists")
AddEventHandler("KhaichiPed:pedExists", function()
    if CachedPedState then
        TriggerClientEvent('KhaichiPed:pedExists', source, true)
    else
        CachedPedState = true
        TriggerClientEvent('KhaichiPed:pedExists', source, false)
    end
end)

RegisterServerEvent("KhaichiPed:giveWeapon")
AddEventHandler("KhaichiPed:giveWeapon", function(weapon)
    local player = source

    if player then
        vRPclient.giveWeapons(player,{{
		  [weapon] = {ammo=Config.ReceiveAmmo}
		}, false})
    end
end)