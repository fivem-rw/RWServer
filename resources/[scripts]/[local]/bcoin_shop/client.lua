------------------------------------------
------ Real World Battl Coin shop --------
---------- Made By Realworld -------------
------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

bcoinShop = Tunnel.getInterface("bcoin_shop")
vRP = Proxy.getInterface("vRP")

local menuactive = false
RegisterNetEvent("bcoinShop:toggleMenu")
AddEventHandler("bcoinShop:toggleMenu", function(open, zone, vendas)
end)

RegisterNUICallback("close", function(data, cb)
    toogleUI(false, "", {})
end)

RegisterNUICallback("buyItem", function(data, cb)
    local item = data.item
    local zone = data.zone
    local section = data.section

    bcoinShop.buyItem(item, zone, section)
end)

function toogleUI(show, zone, vendas)
    menuactive = show

    if menuactive then
        SetNuiFocus(true, true)
        SendNUIMessage({ toogleUi = true, zone = zone, vendas = vendas })
    else
        SetNuiFocus(false)
        SendNUIMessage({ toogleUi = false, zone = zone, vendas = vendas })
    end
end

Citizen.CreateThread(function()
    SetNuiFocus(false,false)
    while true do
        Citizen.Wait(1)
        for keyConfig, valueConfig in pairs(BcoinShopConf.Zones) do
            for k, v in pairs(BcoinShopConf.Zones[keyConfig].Pos) do
                local x, y, z = table.unpack(v)

                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)

                if distance <= 1 then
                    DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                    if IsControlJustPressed(0,38) then
                        toogleUI(true, keyConfig, BcoinShopConf.Zones[keyConfig].Vendas)
                    end
                end
            end
        end
    end
end)