local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_paintball")
vRPCpaintball = Tunnel.getInterface("vRP_paintball","vRP_paintball")

vRPpaintball = {}
Tunnel.bindInterface("vRP_paintball",vRPpaintball)
Proxy.addInterface("vRP_paintball",vRPpaintball)


-- Cfg --

local seccondsToWait = 20
local gameDuration = 1200
local startWeapons = {
    ["WEAPON_PISTOL_MK2"] = {ammo = 100},
    ["WEAPON_ASSAULTSMG"] = {ammo = 180}
}
-- put 0 to turn off
local prizeMoney = 500

---------


local blueTeamPlayers = {}
local redTeamPlayers = {}

local teams = {}

local blues = "파랑팀"
local reds = "빨강팀"

local function getMembersInPaint()
    local tbl = {}

    for _, v in pairs(blueTeamPlayers) do
        table.insert(tbl, v)
    end
    for _, v in pairs(redTeamPlayers) do
        table.insert(tbl, v)
    end

    return tbl
end

local secundici = 0

local gameStarted = false
local lobbyStarted = false
local inGame = false

Citizen.CreateThread(function()
    while true do
        Wait(1000)

        if secundici > 0 then
            secundici = secundici - 1
            lobbyStarted = true
        elseif lobbyStarted then
            lobbyStarted = false
            gameStarted = true
        end


        if lobbyStarted then
            local users = getMembersInPaint()

            local secTxt = secundici
            local redMembers = #redTeamPlayers
            local blueMembers = #blueTeamPlayers
            if redMembers + blueMembers < 2 and (redMembers + blueMembers) % 2 == 1 then --- DE MODIFICAT (2 -> 4) (primu' doi)
                secTxt = "인원부족/"
                secundici = seccondsToWait
            end

            for _, src in pairs(users) do
                vRPCpaintball.updateLobbyData(src, {secTxt, redMembers, blueMembers})
            end
        elseif gameStarted then
            local redMembers = #redTeamPlayers
            local blueMembers = #blueTeamPlayers
            if redMembers + blueMembers < 2 and (redMembers + blueMembers) % 2 == 1 then --- DE MODIFICAT (2 -> 4)
                secundici = seccondsToWait
                gameStarted = false
                lobbyStarted = true
            elseif not inGame then
                inGame = true
                startGame()
            end
        end
    end
end)



function vRPpaintball.addInTeam(echipa)
    local user_id = vRP.getUserId({source})
    if echipa ~= nil or echipa ~= "" then
        if not gameStarted and not lobbyStarted then
            secundici = seccondsToWait
        end

        if tostring(echipa) == "빨강팀" then
            teams[user_id] = "빨강팀"
            table.insert(redTeamPlayers, source)
        elseif tostring(echipa) == "파랑팀" then
            teams[user_id] = "파랑팀"
            table.insert(blueTeamPlayers, source)
        end

        local users = getMembersInPaint()
        for _, src in pairs(users) do
            vRPCpaintball.updateLobbyData(src, {secundici, #redTeamPlayers, #blueTeamPlayers})
        end


    end
end

function vRPpaintball.removeTeamMember()
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and user_id ~= "" then
        local echipa = teams[user_id]
        if echipa ~= nil and echipa ~= "" then
            print(#redTeamPlayers..#blueTeamPlayers)
            if tostring(echipa) == "빨강팀" then
                teams[user_id] = nil

                for indx, src in pairs(redTeamPlayers) do
                    if src == source then
                        table.remove(redTeamPlayers, indx)
                        break
                    end
                end
            elseif tostring(echipa) == "파랑팀" then
                teams[user_id] = nil

                for indx, src in pairs(blueTeamPlayers) do
                    if src == source then
                        table.remove(blueTeamPlayers, indx)
                        break
                    end
                end
            end
            print(#redTeamPlayers..#blueTeamPlayers)
        end
    end
end

function startGame()
    lobbyStarted = false
    vRPCpaintball.setGameStat(-1, {true})

    --[[if #blueTeamPlayers ~= #redTeamPlayers then
        local diff = #blueTeamPlayers - #redTeamPlayers

        local higher = "파랑"
        if diff < 0 then
            higher = "빨강"
        end

        while #blueTeamPlayers ~= #redTeamPlayers do
            if higher == "파랑" then
                for indx, v in pairs(blueTeamPlayers) do
                    vRPclient.notify(v, {"팀 균형 시스템 : ~r~빨강팀~w~으로 자동이동 되었습니다."})
                    table.insert(redTeamPlayers, v)
                    table.remove(blueTeamPlayers, indx)
                    teams[vRP.getUserId({v})] = "빨강팀"
                    break
                end
            else
                for indx, v in pairs(redTeamPlayers) do
                    vRPclient.notify(v, {"팀 균형 시스템 : ~b~파랑팀~w~으로 자동이동 되었습니다."})
                    table.insert(blueTeamPlayers, v)
                    table.remove(redTeamPlayers, indx)
                    teams[vRP.getUserId({v})] = "파랑팀"
                    break
                end
            end
        end
    end]]

    Citizen.Wait(500)

    local users = getMembersInPaint()
    for _, src in pairs(users) do
        vRPclient.setHealth(src, {200})
        vRPCpaintball.setGameStat(src, {true, 1, {
            blue = blueTeamPlayers,
            red = redTeamPlayers
        }})
        Citizen.CreateThread(function()
            Wait(1000)
            vRPclient.giveWeapons(src, {startWeapons, true})
        end)
    end

    local secs = gameDuration
    Citizen.CreateThread(function()
        while inGame do
            Wait(1000)
            if secs > 0 then
                secs = secs - 1

                local users2 = getMembersInPaint()
                for _, src in pairs(users2) do
                    vRPCpaintball.updateLobbyData(src, {secs, #redTeamPlayers, #blueTeamPlayers})
                end

                if #redTeamPlayers == 0 then
                    endGame("파랑")
                end
                if #blueTeamPlayers == 0 then
                    endGame("빨강")
                end
            else
                if #blueTeamPlayers > #redTeamPlayers then endGame("파랑")
                elseif #redTeamPlayers > #blueTeamPlayers then endGame("빨강")
                else endGame("무승부") end
            end
        end
    end)
end



RegisterCommand("게임 종료", function(player)
    endGame("무승부")
end)

function endGame(winner)

    if winner == "파랑" then
        for user_id, team in pairs(teams) do
            if team == "빨강팀" then
                vRPCpaintball.drawScale(vRP.getUserSource({user_id}), {false})
            else
                vRPCpaintball.drawScale(vRP.getUserSource({user_id}), {true})
                if prizeMoney > 0 then
                    --vRP.giveMoney({user_id, prizeMoney})
                    --vRPclient.notify(vRP.getUserSource({user_id}), {"전쟁 시스템 : ~g~"..prizeMoney.."원을 받았습니다."})
                end
            end
        end
    elseif winner == "빨강" then
        for user_id, team in pairs(teams) do
            if team == "빨강팀" then
                vRPCpaintball.drawScale(vRP.getUserSource({user_id}), {true})
                if prizeMoney > 0 then
                    --vRP.giveMoney({user_id, prizeMoney})
                    --vRPclient.notify(vRP.getUserSource({user_id}), {"전쟁 시스템: ~g~"..prizeMoney.."원을 받았습니다."})
                end
            else
                vRPCpaintball.drawScale(vRP.getUserSource({user_id}), {false})
            end
        end
    else
        for user_id, team in pairs(teams) do
            vRPCpaintball.drawScale(vRP.getUserSource({user_id}), {"무승부"})
        end
    end

    local users = getMembersInPaint()
    vRPCpaintball.setGameStat(-1, {false})
    for _, src in pairs(users) do
        vRPclient.teleport(src, {847.53863525391,-1019.9995727539,27.674083709717})
        vRPCpaintball.setGameStat(src, {false, 2})
    end
    gameStarted, lobbyStarted = false, false
    redTeamPlayers, blueTeamPlayers, teams = {}, {}, {}
    inGame = false
end

function vRPpaintball.iDied()
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id then
        if teams[user_id] == "파랑팀" then
            for indx, v in pairs(blueTeamPlayers) do
                if v == player then
                    table.remove(blueTeamPlayers, indx)
                    break
                end
            end
        elseif teams[user_id] == "빨강팀" then
            for indx, v in pairs(redTeamPlayers) do
                if v == player then
                    table.remove(redTeamPlayers, indx)
                    break
                end
            end
        end
    end
end


function vRPpaintball.getPlayerTeam()
    local user_id = vRP.getUserId({source})
    return teams[user_id] or false
end

