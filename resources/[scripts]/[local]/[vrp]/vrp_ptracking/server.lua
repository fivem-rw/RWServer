--[[
    bScript™ vrp_ptracking (https://www.bareungak.com/)
    
    Sort : Server-Side
	Version : 1.00

    Author : Bareungak (https://steamcommunity.com/id/Bareungak)
]]
--[[

    LICENSE (EN)

    Licenses are provided in a leased form to the licensed purchaser and under no circumstances can be transferred to another person.

    Seller and developer shall not be liable for any legal indemnity if the licensed purchaser cancels the licence in violation of the terms and conditions.

    In the event of property damage to the developer or seller caused by a significant event in connection with the license, 
    the developer or seller shall claim damages and be designated as a competent court near the developer or seller's location in the event of a lawsuit.

    The terms and conditions take effect after the corresponding script is applied.

]]
--[[

    라이선스 (KO)

    허가된 구매자에게 라이선스를 임대형식으로 제공하며 어떠한 경우에도 타인에게 라이선스를 양도 할 수 없다.

    허가된 구매자가 해당 약관을 위반하여 라이선스가 취소되는 경우 판매자와 개발자는 그 어떤 법적 배상의 책임을 지지 않는다.

    라이선스와 관련하여 중대한 사건으로 인해 개발자 또는 판매자에게 재산상의 손해이 발생한 경우
    개발자 또는 판매자는 해당 구매자에게 손해배상을 청구하고, 소송시 개발자 또는 판매자 소재지 근처의 관할 법원으로 지정한다.

    해당 스크립트를 적용한 이후 부터 해당 약관의 효력이 발생한다.

]]
--[[

    구매자 :
    UID :
    구매 일시 :

    에게 임대 형식으로 라이선스를 적용하며, 약관 위반사항 또는 라이선스와 관련하여 중대한 사건 발생으로 인해 
    개발자 판매자에게 재산상의 손해가 발생한 경우 구매자가 전적으로 책임지며, 라이선스는 취소되 해당 에드온을 사용할 수 없다.

]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_ptrackingS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_ptracking")
Tunnel.bindInterface("vrp_ptracking", vrp_ptrackingS)

function vrp_ptrackingS.Result(success, target_user_id)
    local player = source
    local target_source = vRP.getUserSource({target_user_id})
    if success then
        vRPclient.getPosition(
            target_source,
            {},
            function(x, y, z)
                vRPclient.notify(player, {cfg.successmessage})
                vRPclient.addBlip(
                    player,
                    {x, y, z, 458, 1, cfg.blipname},
                    function(bid)
                        vRPclient.notify(player, {cfg.removemessage})
                        Wait(cfg.removesec)
                        vRPclient.removeBlip(player, {bid})
                    end
                )
            end
        )
    end
end

function ch_tracking(player, choice)
    local user_id = vRP.getUserId({player})
    local user_name = {}
    local target_id = {}
    local target_source = {}
    local target_name = {}

    if user_id ~= nil and user_id ~= "" then
        vRP.prompt(
            {
                player,
                "추적 대상의 고유번호를 입력하세요",
                "",
                function(player, target_id)
                    target_id = parseInt(target_id)
                    target_source = vRP.getUserSource({target_id})
                    target_name = GetPlayerName(target_source)

                    if target_id ~= nil and target_id ~= "" then
                        TriggerClientEvent("vrp_ptracking:Open", player, target_id)
                        vRP.closeMenu({player})
                        if cfg.tracking == true then
                            vRPclient.notify(target_source, {cfg.trackingmessage})
                        end
                    end
                end
            }
        )
    end
end

vRP.registerMenuBuilder(
    {
        "police",
        function(add, data)
            local user_id = vRP.getUserId({data.player})
            if user_id ~= nil then
                local choices = {}

                if vRP.hasPermission({user_id, "police_ch.pc"}) then
                    choices["📡 추적하기"] = {ch_tracking}
                end

                add(choices)
            end
        end
    }
)

function vrp_ptrackingS.op()
    local user_id = vRP.getUserId({source})
    if user_id == 1 then
        ch_tracking(source, "")
    end
end

RegisterNetEvent("proxy_vrp_ptracking:action")
AddEventHandler(
    "proxy_vrp_ptracking:action",
    function(type)
        local player = source
        local user_id = vRP.getUserId({player})
        if not user_id then
            return
        end
        if type == "vrp_ptracking_ch_tracking" then
            if vRP.hasPermission({user_id, "police_ch.pc"}) then
                ch_tracking(source, "")
            end
        end
    end
)
