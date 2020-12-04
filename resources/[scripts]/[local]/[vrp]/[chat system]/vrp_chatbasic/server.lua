local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_Chatbasic")

RegisterServerEvent("vrp_chatbasic:sendkeys")
AddEventHandler(
    "vrp_chatbasic:sendkeys",
    function()
        local user_id = vRP.getUserId({source})
        local name = GetPlayerName(source)

        if vRP.hasPermission({user_id, "police.megaphone"}) then
            TriggerClientEvent("vrp_chatbasic:sendProximityMessagePm1", -1, source, name)
            CancelEvent()
        end
    end
)

RegisterServerEvent("vrp_chatbasic:sendkeysrk")
AddEventHandler("vrp_chatbasic:sendkeysrk",
    function()
        local user_id = vRP.getUserId({source})
        local name = GetPlayerName(source)

        if vRP.hasPermission({user_id, "rekcar.megaphone"}) then
            TriggerClientEvent("vrp_chatbasic:sendProximityMessageRPm1", -1, source, name)
            --TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^6[리얼박스] ^2" .. GetPlayerName(player) .. "^0님이^2 ^1" .. selectRewards[4] .. "^0차량을 획득하였습니다.")
            CancelEvent()
        end
    end
)

RegisterServerEvent("vrp_chatbasic:first")
AddEventHandler(
    "vrp_chatbasic:first",
    function()
        local user_id = vRP.getUserId({source})
        local name = GetPlayerName(source)

        if vRP.hasPermission({user_id, "rekcar.megaphone"}) then
            --TriggerClientEvent("chatMessage", "", {255, 155, 255}, "📣 퍼스트렉카 소속" .. name .. "님의 알림사항 ^7차량번호^1[" .. fplate .. "번] ^7차량 차주님 ^1잠시 후^7 견인이 될 예정 입니다.")
            TriggerClientEvent("chatMessage", -1, "", {255, 155, 255}, "📣 퍼스트렉카 소속" .. name .. "님의 알림사항 ^7차량번호^1[" .. fplate .. "번] ^7차량 차주님 ^1잠시 후^7 견인이 될 예정 입니다.")
            CancelEvent()
        end
    end
)

local function lookupify(t)
    local r = {}
    for _, v in pairs(t) do
        r[v] = true
    end
    return r
end

local blockedRanges = {
    {0x0001F601, 0x0001F64F},
    {0x00002702, 0x000027B0},
    {0x0001F680, 0x0001F6C0},
    --{0x000024C2, 0x0001F251},
    {0x0001F300, 0x0001F5FF},
    {0x00002194, 0x00002199},
    {0x000023E9, 0x000023F3},
    {0x000025FB, 0x000026FD},
    {0x0001F300, 0x0001F5FF},
    {0x0001F600, 0x0001F636},
    {0x0001F681, 0x0001F6C5},
    {0x0001F30D, 0x0001F567}
}

local blockedSingles =
    lookupify {
    0x000000A9,
    0x000000AE,
    0x0000203C,
    0x00002049,
    0x000020E3,
    0x00002122,
    0x00002139,
    0x000021A9,
    0x000021AA,
    0x0000231A,
    0x0000231B,
    0x000025AA,
    0x000025AB,
    0x000025B6,
    0x000025C0,
    0x00002934,
    0x00002935,
    0x00002B05,
    0x00002B06,
    0x00002B07,
    0x00002B1B,
    0x00002B1C,
    0x00002B50,
    0x00002B55,
    0x00003030,
    0x0000303D,
    0x00003297,
    0x00003299,
    0x0001F004,
    0x0001F0CF,
    0x0001F985
}

function removeEmoji(str)
    local codepoints = {}
    for _, codepoint in utf8.codes(str) do
        local insert = true
        if blockedSingles[codepoint] then
            insert = false
        else
            for _, range in ipairs(blockedRanges) do
                if range[1] <= codepoint and codepoint <= range[2] then
                    insert = false
                    break
                end
            end
        end
        if insert then
            table.insert(codepoints, codepoint)
        end
    end
    return utf8.char(table.unpack(codepoints))
end

local user_title = vRP.getUserTitle()
user_title.titleColors = {
    ["basic"] = "^7",
    ["advanced"] = "^2",
    ["rare"] = "^3",
    ["unique"] = "^1",
    ["god"] = "",
    ["zombie"] = "^8",
    ["gold"] = "^3",
    ["supporter1"] = "^1",
    ["supporter2"] = "^5",
    ["supporter3"] = "^3",
    ["supporter4"] = "^6",
    ["supporter5"] = "^5",
    ["supporter6"] = "^5",
    ["supporter7"] = "^6",
    ["supporter8"] = "^3",
    ["supporter9"] = "^3",
    ["supporter10"] = "^8"
}

local restChars = {
    "병신",
    "씨발",
    "시발",
    "개새끼",
    "섹스",
    "애미",
    "갤럭시",
    "창년"
}
local restMatchChars = {
    {"갤", "럭", "시"},
    {"갤", "럭", "쉬"},
    {"g", "a", "l", "a", "x", "y"}
}
local restDelayTimer = 20
local restUserIds = {}

Citizen.CreateThread(
    function()
        while true do
            for k, v in pairs(restUserIds) do
                if v and v < os.time() - restDelayTimer then
                    local player = vRP.getUserSource({k})
                    if player then
                        restUserIds[k] = nil
                        vRP.ban({player, "금지어 사용"})
                    end
                end
            end
            Citizen.Wait(5000)
        end
    end
)

TriggerEvent(
    "es:addCommand",
    "pm",
    function(source, args, user)
        if (GetPlayerName(tonumber(args[2])) or GetPlayerName(tonumber(args[3]))) then
            local player = tonumber(args[2])

            table.remove(args, 2)
            table.remove(args, 1)

            TriggerEvent(
                "es:getPlayerFromId",
                player,
                function(target)
                    TriggerClientEvent("chatMessage", player, "PM", {214, 214, 214}, "^2 From ^5" .. GetPlayerName(source) .. " [" .. source .. "]: ^7" .. table.concat(args, " "), nil, "ic")
                    TriggerClientEvent("chatMessage", source, "PM", {214, 214, 214}, "^3 Sent to ^5" .. GetPlayerName(player) .. ": ^7" .. table.concat(args, " "), nil, "ic")
                end
            )
        else
            TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!", nil, "ic")
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!", nil, "ic")
    end
)

local sourceByTime = {}
local sourceByTime_ad = {}
local delayTime = 2
local delayTime_ad = 120

AddEventHandler(
    "chatMessage",
    function(source, name, message, custom)
        local player = source

        if sourceByTime[player] and sourceByTime[player] + delayTime > os.time() then
            CancelEvent()
            return
        else
            sourceByTime[player] = os.time()
        end

        local user_id = vRP.getUserId({source})

        print("^5", user_id, name, message, "^0")

        if not user_id then
            CancelEvent()
            return
        end
        if restUserIds[user_id] then
            CancelEvent()
            return
        end
        local name = removeEmoji(GetPlayerName(source))

        local sm = stringsplit(message, " ")

        local messageF = string.lower(message)
        local isRestChat = false
        if not isRestChat then
            for k, v in pairs(restChars) do
                if string.find(messageF, v) ~= nil then
                    isRestChat = true
                    break
                end
            end
        end
        if not isRestChat then
            for k, v in pairs(restMatchChars) do
                local isNotMatch = false
                if v then
                    for k2, v2 in pairs(v) do
                        if string.find(messageF, v2) == nil then
                            isNotMatch = true
                        end
                    end
                    if not isNotMatch then
                        isRestChat = true
                        break
                    end
                end
            end
        end
        if isRestChat then
            TriggerClientEvent("chatMessage", -1, name .. "이(가) 금지어를 사용하여 차단될 예정 입니다.", {255, 100, 0}, "" .. " - " .. name .. " - ", nil, "all")
            TriggerEvent("proxy_showimg:show", user_id, "https://mblogthumb-phinf.pstatic.net/MjAxOTA0MDhfMjY0/MDAxNTU0NjY2Nzk2MDU2.h1Le9Rvd6kDDcLFDAYgj0Kg4C4CSq4bsYY9UojGf53Yg.MGWF6ngJGXvrtiCrdGvROb_g1OGUH56soEKGgG-dHMgg.JPEG.bloodyice/HAo54c9953871944.jpg?type=w2", restDelayTimer)
            if user_id and not restUserIds[user_id] then
                restUserIds[user_id] = os.time()
                print("RestChat", user_id)
            end
            CancelEvent()
            return
        end

        if string.sub(message, 1, string.len("/")) == "/" then
            if sm[1] == "/행동" then
                TriggerClientEvent("sendProximityMessageMe", -1, source, name, string.sub(message, sm[1]:len() + 1))
                vRP.log("logs/chatlog.txt", user_id .. "ㅣ" .. name .. "이(가) " .. string.sub(message, sm[1]:len() + 1) .. "")
                CancelEvent()
            elseif sm[1] == "/me" then
                CancelEvent()
            elseif sm[1] == "/상태" then
                CancelEvent()
                TriggerClientEvent("sendProximityMessageSt", -1, source, name, string.sub(message, sm[1]:len() + 1))
                vRP.log("logs/chatlog.txt", user_id .. "ㅣ" .. name .. "의 상태 : " .. string.sub(message, sm[1]:len() + 1) .. "")
            elseif sm[1] == "/생각" then
                TriggerClientEvent("sendProximityMessageTh", -1, source, name, string.sub(message, sm[1]:len() + 1))
                vRP.log("logs/chatlog.txt", user_id .. "ㅣ" .. name .. "의 생각 : " .. string.sub(message, sm[1]:len() + 1) .. "")
                CancelEvent()
            elseif sm[1] == "/외치기" then
                CancelEvent()
                TriggerClientEvent("sendProximityMessageSh", -1, source, name, string.sub(message, sm[1]:len() + 1))
                vRP.log("logs/chatlog.txt", "외치기ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. " ! ! !")
            elseif sm[1] == "/작게" then
                CancelEvent()
                TriggerClientEvent("sendProximityMessageB", -1, source, name, string.sub(message, sm[1]:len() + 1))
                vRP.log("logs/chatlog.txt", user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
            elseif sm[1] == "/메가폰" or sm[1] == "/mega" then
                local user_id = vRP.getUserId({source})
                if vRP.hasPermission({user_id, "police.megaphone"}) then
                    TriggerClientEvent("sendProximityMessagePolice", -1, source, name, string.sub(message, sm[1]:len() + 1))
                    CancelEvent()
                else
                    vRPclient.notify(source, {"~r~당신은 경찰이 아닙니다!"})
                    CancelEvent()
                end
            elseif sm[1] == "/메가폰1" or sm[1] == "/mega1" then
                local user_id = vRP.getUserId({source})
                if vRP.hasPermission({user_id, "police.megaphone"}) then
                    TriggerClientEvent("sendProximityMessagePm1", -1, source, name, string.sub(message, sm[1]:len() + 1))
                    CancelEvent()
                else
                    vRPclient.notify(source, {"~r~당신은 경찰이 아닙니다!"})
                    CancelEvent()
                end
            elseif sm[1] == "/렉카메가폰" or sm[1] == "/rmega" then
                local user_id = vRP.getUserId({source})
                if vRP.hasPermission({user_id, "rekcar.megaphone"}) then
                    TriggerClientEvent("sendProximityMessageRPm1", -1, source, name, string.sub(message, sm[1]:len() + 1))
                    --TriggerClientEvent("chatMessage", "", {255, 155, 255}, "📣 퍼스트렉카 소속" .. name .. "님의 알림사항 ^7차량번호^1[" .. fplate .. "번] ^7차량 차주님 ^1잠시 후^7 견인이 될 예정 입니다.", nil, "ic")
                    CancelEvent()
                else
                    vRPclient.notify(source, {"~r~당신은 퍼스트렉카 직원이 아닙니다!"})
                    CancelEvent()
                end
            elseif sm[1] == "/미란다" or sm[1] == "/miranda" then
                local user_id = vRP.getUserId({source})
                if vRP.hasPermission({user_id, "police.vehicle"}) then
                    TriggerClientEvent("sendProximityMessageMiranda", -1, source, name, string.sub(message, sm[1]:len() + 1))
                    CancelEvent()
                else
                    vRPclient.notify(source, {"~r~당신은 경찰이 아닙니다!"})
                    CancelEvent()
                end
            elseif sm[1] == "/전체" or sm[1] == "/ooc" then
                local user_id = vRP.getUserId({source})
                if vRP.hasGroup({user_id, "title.enable"}) then
                    for k, v in pairs(user_title.titles) do
                        if vRP.hasGroup({user_id, v.group}) then
                            local color = user_title.titleColors[v.div]
                            if string.find(v.div, "supporter") == nil then
                                TriggerClientEvent("chatMessage", -1, "^*" .. color .. "🌟 전체ㅣ" .. user_id .. "ㅣ" .. v.title .. "ㅣ" .. name .. "", {0, 0, 0}, string.sub(message, sm[1]:len() + 1), v.div .. " box-light", "ooc")
                            else
                                TriggerClientEvent(
                                    "chat:addMessage",
                                    -1,
                                    {
                                        template = "^*" .. color .. '<div class="default-template">🌟 전체ㅣ' .. user_id .. 'ㅣ<span class="title-span {0}">{1}</span>ㅣ<span>' .. name .. "</span>: <span>^0{2}<span></div>",
                                        args = {v.div, v.title, string.sub(message, sm[1]:len() + 1)},
                                        class = v.div .. " box-light mualtiline",
                                        channelId = "ooc"
                                    }
                                )
                            end
                        end
                    end
                else
                    if vRP.hasPermission({user_id, "chatrules.rpadmin"}) then
                        TriggerClientEvent("chatMessage", -1, "^*🌟 전체ㅣ" .. user_id .. "ㅣ^8 관 리 자ㅣ" .. name, {255, 0, 0}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    elseif vRP.hasPermission({user_id, "chatrules.subadmin"}) then
                        TriggerClientEvent("chatMessage", -1, "^*🌟 전체ㅣ" .. user_id .. "ㅣ^8 관 리 자ㅣ" .. name, {255, 0, 0}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    elseif vRP.hasPermission({user_id, "chatrules.superadmin"}) then
                        TriggerClientEvent("chatMessage", -1, "^*🌟 전체ㅣ" .. user_id .. "ㅣ^9 관 리 자^8ㅣ" .. name, {255, 0, 0}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    elseif vRP.hasPermission({user_id, "chatrules.helper"}) then
                        TriggerClientEvent("chatMessage", -1, "^*🌟 전체ㅣ" .. user_id .. "ㅣ스 태 프ㅣ" .. name, {169, 255, 0}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    elseif vRP.hasPermission({user_id, "chatrules.engineer"}) then
                        TriggerClientEvent("chatMessage", -1, "^*🌟 전체ㅣ" .. user_id .. "ㅣ서 버 관 리 자ㅣ" .. name, {0, 255, 255}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    else
                        CancelEvent()
                        TriggerClientEvent("chatMessage", -1, "🌟 전체ㅣ" .. user_id .. "ㅣ" .. name, {200, 200, 200}, string.sub(message, sm[1]:len() + 1), "box-light", "ooc")
                        vRP.log("logs/chatlog.txt", "전체ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
                    end
                end
            elseif sm[1] == "/트윗" or sm[1] == "/twit" then
                CancelEvent()
                if vRP.hasGroup({user_id, "title.enable"}) then
                    for k, v in pairs(user_title.titles) do
                        if vRP.hasGroup({user_id, v.group}) then
                            local color = user_title.titleColors[v.div]
                            if string.find(v.div, "supporter") == nil then
                                TriggerClientEvent("chatMessage", -1, "🐤 트윗ㅣ" .. user_id .. "ㅣ" .. v.title .. "ㅣ" .. name .. "님의 트윗 ", {85, 172, 238}, string.sub(message, sm[1]:len() + 1), v.div .. " box-light", "twit")
                            else
                                TriggerClientEvent(
                                    "chat:addMessage",
                                    -1,
                                    {
                                        template = "^*" .. color .. '<div class="default-template" style="color: rgb(85, 172, 238)">🐤 트윗ㅣ' .. user_id .. 'ㅣ<span class="title-span {0}">{1}</span>ㅣ<span style="color: rgb(85, 172, 238)">' .. name .. "</span>님의 트윗: <span>^0{2}<span></div>",
                                        args = {v.div, v.title, string.sub(message, sm[1]:len() + 1)},
                                        class = v.div .. " box-light",
                                        channelId = "twit"
                                    }
                                )
                            end
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", -1, "🐤 트윗ㅣ" .. user_id .. "ㅣ" .. name .. "님의 트윗 ", {85, 172, 238}, string.sub(message, sm[1]:len() + 1), "box-light", "twit")
                end
                vRP.log("logs/chatlog.txt", "트윗ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
            elseif sm[1] == "/공지" or sm[1] == "/nc" or sm[1] == "/ncb" or sm[1] == "/ncy" or sm[1] == "/ncg" or sm[1] == "/nci" then
                local addClass = ""
                if sm[1] == "/ncb" then
                    addClass = "blue"
                elseif sm[1] == "/ncy" then
                    addClass = "yellow"
                elseif sm[1] == "/ncg" then
                    addClass = "green"
                elseif sm[1] == "/nci" then
                    addClass = "starlight"
                end
                if vRP.hasPermission({user_id, "player.group.add"}) then
                    TriggerClientEvent(
                        "chat:addMessage",
                        -1,
                        {
                            template = '<div class="notice-box ' .. addClass .. '"><span class="title">{0}</span><span>{1}<span></div>',
                            args = {"공지", string.sub(message, sm[1]:len() + 1)},
                            channelId = "all"
                        }
                    )

                    CancelEvent()
                else
                    vRPclient.notify(source, {"~r~당신은 권한이 없습니다"})
                    CancelEvent()
                end
            elseif sm[1] == "/광고" or sm[1] == "/ad" then
                CancelEvent()
                if sourceByTime_ad[player] and sourceByTime_ad[player] + delayTime_ad > os.time() then
                    local remainTime_ad = (sourceByTime_ad[player] + delayTime_ad) - os.time()
                    if remainTime_ad < 0 then
                        remainTime_ad = 0
                    end
                    TriggerClientEvent("chatMessage", player, "알림 ", {255, 50, 50}, "^0광고는 ^1" .. parseInt(delayTime_ad / 60) .. "^0분 마다 할 수 있습니다. (남은시간:" .. remainTime_ad .. "초)", "box-light", "system")
                    return
                else
                    sourceByTime_ad[player] = os.time()
                end
                if vRP.hasGroup({user_id, "title.enable"}) then
                    for k, v in pairs(user_title.titles) do
                        if vRP.hasGroup({user_id, v.group}) then
                            local color = user_title.titleColors[v.div]
                            if string.find(v.div, "supporter") == nil then
                                TriggerClientEvent("chatMessage", -1, "📛 광고ㅣ" .. user_id .. "ㅣ" .. v.title .. "ㅣ" .. name .. "님의 광고 ", {255, 50, 50}, string.sub(message, sm[1]:len() + 1), v.div .. " box-light", "twit")
                            else
                                TriggerClientEvent(
                                    "chat:addMessage",
                                    -1,
                                    {
                                        template = "^*" .. color .. '<div class="default-template">📛 광고ㅣ' .. user_id .. 'ㅣ<span class="title-span {0}">{1}</span>ㅣ<span>' .. name .. "</span>님의 광고 :<span>^0{2}<span></div>",
                                        args = {v.div, v.title, string.sub(message, sm[1]:len() + 1)},
                                        class = v.div .. " box-light",
                                        channelId = "twit"
                                    }
                                )
                            end
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", -1, "📛 광고ㅣ" .. user_id .. "ㅣ" .. name .. "님의 광고 ", {255, 50, 50}, string.sub(message, sm[1]:len() + 1), "box-light", "twit")
                end
                vRP.log("logs/chatlog.txt", "광고ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, sm[1]:len() + 1) .. "")
            elseif sm[1] == "/알림" or sm[1] == "/notify" then
                local user_id = vRP.getUserId({source})
                if vRP.hasPermission({user_id, "chatrules.emssnr"}) or vRP.hasPermission({user_id, "chatrules.paramedic"}) or vRP.hasPermission({user_id, "chatrules.lieutenant"}) or vRP.hasPermission({user_id, "chatrules.emscheif2"}) or vRP.hasPermission({user_id, "chatrules.emscheif1"}) then
                    TriggerClientEvent("chatMessage", -1, "🔥 EMS본부알림", {255, 100, 0}, "응급상황엔 EMS를 불러주세요. 다만 중복신고 또는 구급대원 재촉시 출동을 거부할 수 있습니다." .. " - " .. name .. " - ", nil, "all")
                    CancelEvent()
                elseif vRP.hasPermission({user_id, "police.vehicle"}) then
                    TriggerClientEvent("chatMessage", -1, "👮 경찰본부알림", {120, 120, 255}, "범죄현장을 목격했거나 폭행을 당했나요? 경찰을 불러주세요. 경찰이 신속하게 해결 해드리겠습니다." .. " - " .. name .. " - ", nil, "all")
                    CancelEvent()
                end
            end
        else
            if vRP.hasGroup({user_id, "title.enable"}) then
                for k, v in pairs(user_title.titles) do
                    if vRP.hasGroup({user_id, v.group}) then
                        local color = user_title.titleColors[v.div]
                        TriggerClientEvent("sendProximityMessage", -1, source, "일반ㅣ" .. user_id .. "ㅣ" .. v.title .. "ㅣ" .. name, message)
                    end
                end
            else
                TriggerClientEvent("sendProximityMessage", -1, source, "일반ㅣ" .. user_id .. "ㅣ" .. name, message)
            end
            vRP.log("logs/chatlog.txt", "일반ㅣ" .. user_id .. "ㅣ" .. name .. ": " .. string.sub(message, 0) .. "")
        end
        CancelEvent()
    end
)
function vRP.log(file, info)
    if true then
        return
    end
    file = io.open(file, "a")
    if file then
        file:write(os.date("%c") .. " => " .. info .. "\n")
    end
    file:close()
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end
-- end Functions
