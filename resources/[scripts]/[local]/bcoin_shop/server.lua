------------------------------------------
------ Real World Battl Coin shop --------
---------- Made By Realworld -------------
------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

bcoinShop = {}
Tunnel.bindInterface("bcoin_shop", bcoinShop)

function bcoin.buyItem(item, zone, section)
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local vendasSection = BcoinShopConf.Zones[zone].Vendas[section]

        for k, v in pairs(vendasSection.Items) do
            if item == v.item then
                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v.item) * v.quantity <= vRP.getInventoryMaxWeight(user_id) then
                    if vRP.tryPaymentCredit(user_id, parseInt(v.price)) then
                        vRP.giveInventoryItem(user_id, v.item, parseInt(v.quantity))
                        TriggerClientEvent("Notify", source, "성공", .. v.quantity .."x " .. vRP.itemNameList(v.item) .. "</b>을 <b>배틀코인 " .. vRP.format(parseInt(v.price)) .. "개에 샀습니다.</b>.")
                    else
                        TriggerClientEvent("Notify", source, "실패", "배틀코인 ".. vRP.format(parseInt(v.price)) .."개가 부족합니다.")
                    end
                else
                    TriggerClientEvent("Notify", source, "실패", "인벤토리 공간이 부족합니다.")
                end
            end
        end
    end
end