--[[
    bScript™ vrp_revokelic (https://www.bareungak.com/)
    
    Sort : Serverside
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

    라이선스와 관련하여 중대한 사건으로 인해 개발자 또는 판매자에게 재산상의 손상이 발생한 경우
    개발자 또는 판매자는 해당 구매자에게 손해배상을 청구하고, 소송시 개발자 또는 판매자 소재지 근처의 관할 법원으로 지정한다.

    해당 스크립트를 적용한 이후 부터 해당 약관의 효력이 발생한다.

]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_licrevoked")

local function ch_setrevokelic(player, choice)
    local user_id = vRP.getUserId({player})
    vRPclient.getNearestPlayers(
        player,
        {15},
        function(nplayers)
            local user_list = ""
            for k, v in pairs(nplayers) do
                user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
            end
            if user_list ~= "" then
                vRP.prompt(
                    {
                        player,
                        "가까운 플레이어 : " .. user_list,
                        "",
                        function(player, target_id)
                            local target_id = parseInt(target_id)
                            local target_source = vRP.getUserSource({target_id})
                            local target_name = GetPlayerName(target_source)
                            local my_id = vRP.getUserId({player})
                            local my_name = GetPlayerName(player)
                            if target_id ~= nil and target_id ~= "" then
                                if vRP.getLicenseStatus({target_id}) == 0 then
                                    vRP.setLicenseStatus({target_id, 1})
                                    vRPclient.notify(player, {"~g~해당 유저의 면허를 성공적으로 정지했습니다!"})
                                    bScript_Discord_License(4097941, "❎ 면허정지 로그", "처리자 : " .. my_name .. " - " .. my_id .. "번\n\n 정지 대상 : " .. target_name .. " - " .. target_id .. "번\n\n처리 일시 : " .. os.date("%Y년 %m월 %d일, %H시 %M분 %S초"))
                                    TriggerClientEvent("chatMessage", -1, "[ ❎ 정지안내 ] " .. target_name .. "님의 면허가 정지 되었습니다! | 처리 담당자 : " .. my_name, {254, 240, 27})
                                else
                                    vRPclient.notify(player, {"~r~해당 유저는 이미 면허 정지 상태입니다!"})
                                end
                            else
                                vRPclient.notify(player, {"~r~정확한 고유번호를 기입하세요!"})
                            end
                        end
                    }
                )
            else
                vRPclient.notify(player, {"~r~주변에 플레이어가 없습니다!"})
            end
        end
    )
end

local function ch_removerevokelic(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and user_id ~= "" then
        vRP.prompt(
            {
                player,
                "고유번호를 입력해주세요",
                "",
                function(player, target_id)
                    local target_id = parseInt(target_id)
                    local target_source = vRP.getUserSource({target_id})
                    local target_name = GetPlayerName(target_source)
                    local my_id = vRP.getUserId({player})
                    local my_name = GetPlayerName(player)
                    if target_id ~= nil and target_id ~= "" then
                        if vRP.getLicenseStatus({target_id}) == 1 then
                            vRP.setLicenseStatus({target_id, 0})
                            vRPclient.notify(player, {"~g~해당 유저의 면허를 성공적으로 해제했습니다!"})
                            bScript_Discord_License(4097941, "✅ 면허정지 해제 로그", "처리자 : " .. my_name .. " - " .. my_id .. "번\n\n 정지 대상 : " .. target_name .. " - " .. target_id .. "번\n\n처리 일시 : " .. os.date("%Y년 %m월 %d일, %H시 %M분 %S초"))
                            TriggerClientEvent("chatMessage", -1, "[ ✅ 해제안내 ] " .. target_name .. "님의 면허 정지가 해제 처리되었습니다! | 처리 담당자 : " .. my_name, {254, 240, 27})
                        else
                            vRPclient.notify(player, {"~r~해당 유저는 면허가 정지되있지 않습니다!"})
                        end
                    else
                        vRPclient.notify(player, {"~r~정확한 고유번호를 기입하세요!"})
                    end
                end
            }
        )
    end
end

local function ch_checklic(player, choice)
    local user_id = vRP.getUserId({player})
    vRPclient.getNearestPlayers(
        player,
        {15},
        function(nplayers)
            local user_list = ""
            for k, v in pairs(nplayers) do
                user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
            end
            if user_list ~= "" then
                vRP.prompt(
                    {
                        player,
                        "가까운 플레이어 : " .. user_list,
                        "",
                        function(player, target_id)
                            local target_id = parseInt(target_id)
                            if target_id ~= nil and target_id ~= "" then
                                if vRP.getLicenseStatus({target_id}) == 0 then
                                    vRPclient.notify(player, {"~g~ 해당 유저는 면허 정상 상태입니다!"})
                                else
                                    vRPclient.notify(player, {"~r~해당 유저는 면허 정지 상태입니다!"})
                                end
                            else
                                vRPclient.notify(player, {"~r~정확한 고유번호를 기입하세요!"})
                            end
                        end
                    }
                )
            else
                vRPclient.notify(player, {"~r~주변에 플레이어가 없습니다!"})
            end
        end
    )
end

vRP.registerMenuBuilder(
    {
        "police",
        function(add, data)
            local user_id = vRP.getUserId({data.player})
            if user_id ~= nil then
                local choices = {}

                if vRP.hasPermission({user_id, "lic.police"}) then
                    choices["*면허 정지하기❎"] = {ch_setrevokelic}
                    choices["*면허 정지해제✅"] = {ch_removerevokelic}
                    choices["*면허 조회하기🔎"] = {ch_checklic}
                end

                add(choices)
            end
        end
    }
)

function bScript_Discord_License(color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "" .. name .. "",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer
            }
        }
    }
    PerformHttpRequest(
        "https://discordapp.com/api/webhooks/688893999695790092/kntHoeKlf5heFp4dAfyrvKGYL9SbxAAaNt82SXIXUz4LDotEWIm4k_MgrR2Kz3t80EuW",
        function(err, text, headers)
        end,
        "POST",
        json.encode({embeds = embed}),
        {["Content-Type"] = "application/json"}
    )
end

RegisterNetEvent("proxy_vrp_licrevoked:action")
AddEventHandler(
    "proxy_vrp_licrevoked:action",
    function(type)
        local player = source
        local user_id = vRP.getUserId({player})
        if not user_id then
            return
        end
        if type == "vrp_licrevoked_ch_setrevokelic" then
            if vRP.hasPermission({user_id, "lic.police"}) then
                ch_setrevokelic(source, "")
            end
        elseif type == "vrp_licrevoked_ch_removerevokelic" then
            if vRP.hasPermission({user_id, "lic.police"}) then
                ch_removerevokelic(source, "")
            end
        elseif type == "vrp_licrevoked_ch_checklic" then
            if vRP.hasPermission({user_id, "lic.police"}) then
                ch_checklic(source, "")
            end
        end
    end
)