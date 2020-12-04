local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPtunerchipS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_tunerchip")
vRPtunerchipC = Tunnel.getInterface("vRP_tunerchip", "vRP_tunerchip")
Tunnel.bindInterface("vRP_tunerchip", vRPtunerchipS)

local item_name = "tunerchip"
local error_message = "~r~튜닝도구가 부족합니다."

RegisterCommand(
    "tuner",
    function(source, args, rawCommand)
        local user_id = vRP.getUserId({source})
        if vRP.tryGetInventoryItem({user_id, item_name, 1, false}) then
            vRPtunerchipC.AbrirChipTuner(source)
            vRP.giveInventoryItem({user_id, item_name, 1})
        else
            --TriggerClientEvent("Notify", source, "negado", error_message)
            vRPclient.notify(source, {error_message})
        end
    end
)
