local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRPcs = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_stationaryRadars")
Tunnel.bindInterface("vRP_casino", vRPcs)

function vRPcs.cobrarMulta()
    local user_id = vRP.getUserId({source})
    local multa = 2000000
    if vRP.hasGroup({user_id, "ems"}) then
        TriggerClientEvent(
            "pNotify:SendNotification",
            source,
            {
                text = "공무원은 과속 벌금이 면제됩니다.",
                type = "error",
                queue = "left",
                timeout = 5000,
                layout = "centerLeft"
            }
        )
    elseif vRP.hasGroup({user_id, "cop"}) then
        TriggerClientEvent(
            "pNotify:SendNotification",
            source,
            {
                text = "공무원은 과속 벌금이 면제됩니다.",
                type = "error",
                queue = "left",
                timeout = 5000,
                layout = "centerLeft"
            }
        )
    else
        TriggerClientEvent(
            "pNotify:SendNotification",
            source,
            {
                text = "당신은 과속하여 벌금 $2000000을 지불했습니다.",
                type = "error",
                queue = "left",
                timeout = 5000,
                layout = "centerLeft"
            }
        )
        local bank = vRP.getBankMoney({user_id})
        local value = bank - multa
        vRP.setBankMoney({user_id, value})
    end
end
