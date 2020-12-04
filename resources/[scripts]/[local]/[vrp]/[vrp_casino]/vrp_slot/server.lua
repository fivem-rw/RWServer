local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_slotS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_slot")
vrp_slotC = Tunnel.getInterface("vrp_slot", "vrp_slot")
Tunnel.bindInterface("vrp_slot", vrp_slotS)

local chipName = "real_chipc"
local blackjackTables = {}

function vrp_slotS.BetsAndMoney(bets)
    local _source = source
    local user_id = vRP.getUserId({_source})
    if user_id then
        local amount = vRP.getInventoryItemAmount({user_id, chipName})
        if amount < 10 then
            vrp_slotC.notify(_source, {"칩이 최소 10개 이상 필요합니다."})
        else
            vrp_slotC.UpdateSlots(_source, {amount})
            vRP.tryGetInventoryItem({user_id, chipName, amount, true, false, true})
        end
    end
end

function vrp_slotS.updateCoins(bets)
    local _source = source
    local user_id = vRP.getUserId({_source})
    print(bets)
end

function vrp_slotS.PayOutRewards(amount)
    local _source = source
    local user_id = vRP.getUserId({_source})
    if user_id then
        amount = math.floor(tonumber(amount))
        if amount > 0 then
            vRP.giveInventoryItem({user_id, chipName, amount})
        end
    end
end
