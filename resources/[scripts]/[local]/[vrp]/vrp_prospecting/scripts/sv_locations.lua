local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_Prospecting")
Tunnel.bindInterface("vRP_Prospecting", vRPpsc)

local blip_location = cfg.base_location
local area_size = cfg.area_size

RegisterCommand(
    "detect",
    function(source)
        ActivateProspecting(source)
    end
)

function GetNewRandomItem(rand)
    local item = cfg.item_pool[math.random(#cfg.item_pool)]
    return {id = item.id, amount = item.amount, name = item.name, valuable = item.valuable}
end

function GetNewRandomLocation()
    local offsetX = math.random(-cfg.area_size, cfg.area_size)
    local offsetY = math.random(-cfg.area_size, cfg.area_size)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #(pos) > cfg.area_size then
        return GetNewRandomLocation()
    end
    return cfg.base_location + pos
end

function GenerateNewTarget()
    local newPos = GetNewRandomLocation()
    local newData = GetNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

function ActivateProspecting(player)
    local pos = GetEntityCoords(GetPlayerPed(player))
    local dist = #(pos - blip_location)
    if dist < area_size then
        local user_id = vRP.getUserId({player})

        if vRP.tryGetInventoryItem({user_id, "metaldetector", 1, true}) then
            Prospecting.StartProspecting(player)
        else
            vRPclient.notify(player, {"~r~금속 탐지기가 없어 탐지를 시작할 수 없습니다!"})
        end
    end
end

RegisterServerEvent("prospecting-vrp:activateProspecting")
AddEventHandler(
    "prospecting-vrp:activateProspecting",
    function()
        ActivateProspecting(source)
    end
)

CreateThread(
    function()
        Prospecting.SetDifficulty(1.0)
        Prospecting.AddTargets(cfg.locations)

        for n = 0, 10 do
            GenerateNewTarget()
        end

        Prospecting.SetHandler(
            function(player, data, x, y, z)
                local user_id = vRP.getUserId({player})

                for k, v in pairs(data) do
                    --print(k, ":", v)
                end

                if data.valuable then
                    vRP.giveInventoryItem({user_id, data.id, data.amount})
                    vRPclient.notify(player, {"~y~" .. data.name .. " ~w~아이템을 ~r~" .. data.amount .. "~g~개 ~w~만큼 획득했습니다!"})
                    TriggerClientEvent("chatMessage", player, "^1[보물찾기] ^1 " .. data.name .. "^7 아이템을 찾았습니다!")
                else
                    vRP.giveInventoryItem({user_id, data.id, data.amount})
                    vRPclient.notify(player, {"~y~" .. data.name .. " ~w~아이템을 ~r~" .. data.amount .. "~g~개 ~w~만큼 획득했습니다!"})
                    TriggerClientEvent("chatMessage", player, "^1" .. data.name .. "^4 아이템을 찾았습니다!")
                end

                TriggerEvent("vrp_eventbox2:getItem", player, 2, {"eventitem_event2_vivestone2", "eventitem_event2_vivestone3"})

                GenerateNewTarget()
            end
        )

        Prospecting.OnStart(
            function(player)
                vRPclient.notify(player, {"~g~[ON] ~w~금속탐지기를 켰습니다!"})
                TriggerClientEvent("chatMessage", player, "[시스템] 금속탐지를 시작합니다")
            end
        )

        Prospecting.OnStop(
            function(player, time)
                vRPclient.notify(player, {"~r~[OFF] ~w~금속탐지기를 껐습니다!"})
                TriggerClientEvent("chatMessage", player, "[시스템] 금속탐지를 종료합니다")
            end
        )
    end
)
