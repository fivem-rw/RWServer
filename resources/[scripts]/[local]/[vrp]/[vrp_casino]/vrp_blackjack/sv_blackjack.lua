local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_blackjackS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_blackjack")
vrp_blackjackC = Tunnel.getInterface("vrp_blackjack", "vrp_blackjack")
Tunnel.bindInterface("vrp_blackjack", vrp_blackjackS)

local blackjackTables = {
    --[chairId] == false or source if taken
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false,
    [9] = false,
    [10] = false,
    [11] = false,
    [12] = false,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = false,
    [18] = false,
    [19] = false,
    [20] = false,
    [21] = false,
    [22] = false,
    [23] = false
}

local blackjackGameInProgress = {}
local blackjackGameData = {}
local chipName = "real_chip_n"

function tryTakeChips(source, amount)
    local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem({user_id, chipName, amount, true, false, true}) then
        return true
    end
    return false
end

function giveChips(source, amount)
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id, chipName, amount, true, false, true})
end

AddEventHandler(
    "playerDropped",
    function(reason)
        local source = source
        for k, v in pairs(blackjackTables) do
            if v == source then
                blackjackTables[k] = false
            end
        end
    end
)

function vrp_blackjackS.requestBlackjackTableData()
    return blackjackTables
end

function vrp_blackjackS.requestSitAtBlackjackTable(chairId)
    local source = source
    if source == nil or chairId == nil then
        vrp_blackjackC.notify(source, {"이 의자는 앉을 수 없습니다.", "error"})
        return
    end
    if chairId % 4 ~= 0 then
        vrp_blackjackC.notify(source, {"이 의자는 관전 좌석이므로 앉을 수 없습니다.", "error"})
        return
    end
    for k, v in pairs(blackjackTables) do
        if v == source then
            blackjackTables[k] = false
            return
        end
    end
    blackjackTables[chairId] = source
    vrp_blackjackC.sendBlackjackTableData(-1, {blackjackTables})
    vrp_blackjackC.sitAtBlackjackTable(source, {chairId})
end

function vrp_blackjackS.leaveBlackjackTable(chairId)
    local source = source

    if source ~= nil then
        for k, v in pairs(blackjackTables) do
            if v == source then
                blackjackTables[k] = false
            end
        end
        vrp_blackjackC.sendBlackjackTableData(-1, {blackjackTables})
    end
end

function vrp_blackjackS.setBlackjackBet(gameId, betAmount, chairId)
    local source = source
    local user_id = vRP.getUserId({player})

    if gameId ~= nil and betAmount ~= nil and chairId ~= nil then
        if blackjackGameData[gameId] == nil then
            blackjackGameData[gameId] = {}
        end
        if not blackjackGameInProgress[gameId] then
            if tonumber(betAmount) then
                betAmount = tonumber(betAmount)
                if betAmount > 0 then
                    if betAmount <= 1000 then
                        if tryTakeChips(source, betAmount) then
                            --sendToDiscord_batting(65280, "카지노 배팅기록", "고유번호 : " .. user_id .. "번\n\n배팅한 칩 : " .. tostring(betAmount) .. "개\n","", os.date("거래일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
                            --print("Taken",betAmount,"chips from id",source)
                            if blackjackGameData[gameId][source] == nil then
                                blackjackGameData[gameId][source] = {}
                            end
                            blackjackGameData[gameId][source][1] = betAmount
                            --print("GameId: " .. tostring(gameId) .. " source: " .. tostring(source) .. " has placed a bet of " .. tostring(betAmount))
                            vrp_blackjackC.successBlackjackBet(source)
                            vrp_blackjackC.syncChipsPropBlackjack(-1, {betAmount, chairId})
                            vrp_blackjackC.notify(source, {"칩 " .. tostring(betAmount) .. "개를 베팅 했습니다.", "warning"})
                        else
                            vrp_blackjackC.notify(source, {"베팅할 칩이 부족합니다!", "error"})
                        end
                    else
                        vrp_blackjackC.notify(source, {"최대 1000개까지 베팅 가능합니다.", "error"})
                    end
                end
            end
        end
    else
        vrp_blackjackC.notify(source, {"지금은 베팅할 수 없습니다.", "error"})
    end
end

function sendToDiscord_batting(color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer
            }
        }
    }
    PerformHttpRequest(
        "https://discordapp.com/api/webhooks/685781157735956563/nc28jvui2TgCaHRP0Flt5DP9ouvEnNOWVt53Fy9G4SmpIkhlqqMjnDsfLsBwDrpv2KHV",
        function(err, text, headers)
        end,
        "POST",
        json.encode({embeds = embed}),
        {["Content-Type"] = "application/json"}
    )
end

function vrp_blackjackS.hitBlackjack(gameId, nextCardCount)
    local source = source
    blackjackGameData[gameId][source][2][nextCardCount] = true
end

function vrp_blackjackS.standBlackjack(gameId, nextCardCount)
    local source = source
    blackjackGameData[gameId][source][2][nextCardCount] = false
end

for i = 0, 5, 1 do
    Citizen.CreateThread(
        function()
            math.randomseed(os.clock() * 100000000000)
            while true do --blackjack game management thread
                math.random()
                math.random()
                math.random()
                local game_ready = false
                local players_ready = {}
                local tableId = i
                local chairIdInitial = i * 4 --0-3,4-7,8-11,12-15
                local chairIdFinal = (i * 4) + 3
                for chairID = chairIdInitial, chairIdFinal do
                    --print("checking chairID[" .. tostring(chairID) .. "] = " .. tostring(blackjackTables[chairID]))
                    if blackjackTables[chairID] then
                        table.insert(players_ready, blackjackTables[chairID])
                        game_ready = true
                    end
                end
                if game_ready then
                    local gameId = math.random(1000, 10000000)
                    --print("generated gameId", gameId)
                    blackjackGameData[gameId] = {} --init game data
                    blackjackGameInProgress[gameId] = false
                    for k, v in pairs(players_ready) do
                        local source = v
                        blackjackGameData[gameId][v] = {}
                        if source ~= nil then
                            vrp_blackjackC.beginBetsBlackjack(source, {gameId, tableId})
                        end
                    end
                    Wait(10000) --Wait 20 seconds for everyone to put bets up
                    if blackjackGameData[gameId] ~= nil then
                        for k, v in pairs(blackjackGameData[gameId]) do
                            if v ~= nil then
                                local playerBetted = false
                                betAmount = v[1]
                                -- print("betAmount: " .. tostring(betAmount))
                                -- print("v: " .. tostring(v))
                                -- print("vdump: " .. dump(blackjackGameData[gameId][k]))
                                if betAmount ~= nil and betAmount > 0 then
                                    playerBetted = true
                                end
                                if not playerBetted then
                                    blackjackGameData[gameId][k] = nil
                                end
                            end
                        end
                        if not isTableEmpty(blackjackGameData[gameId]) then
                            blackjackGameInProgress[gameId] = true
                            --generate random cards here to send? in round "1"
                            for cardIndex = 0, 1, 1 do
                                for chairID = chairIdInitial, chairIdFinal do
                                    if blackjackTables[chairID] ~= false then
                                        local source = blackjackTables[chairID]
                                        if blackjackGameData[gameId] == nil then
                                            blackjackGameData[gameId] = {}
                                        end
                                        if blackjackGameData[gameId][source] == nil then
                                            blackjackGameData[gameId][source] = {}
                                        end
                                        if blackjackGameData[gameId][source][1] ~= nil then
                                            if blackjackGameData[gameId][source][1] > 0 then
                                                if blackjackGameData[gameId][source]["cardData"] == nil then
                                                    blackjackGameData[gameId][source]["cardData"] = {}
                                                end
                                                local randomCard = math.random(1, 52)
                                                table.insert(blackjackGameData[gameId][source]["cardData"], randomCard)
                                                vrp_blackjackC.beginCardGiveOut(-1, {gameId, blackjackGameData[gameId][source]["cardData"], chairID, cardIndex, getCurrentHand(gameId, source), tableId})
                                                Wait(3500)
                                            else
                                                blackjackGameData[gameId][source] = nil
                                            end
                                        else
                                            blackjackGameData[gameId][source] = nil
                                        end
                                    end
                                end
                                if blackjackGameData[gameId]["dealer"] == nil then
                                    blackjackGameData[gameId]["dealer"] = {}
                                end
                                if blackjackGameData[gameId]["dealer"]["cardData"] == nil then
                                    blackjackGameData[gameId]["dealer"]["cardData"] = {}
                                end
                                if cardIndex == 0 then
                                    local randomCard = math.random(1, 52)
                                    --print("randomDealerCard: " .. tostring(randomCard))
                                    table.insert(blackjackGameData[gameId]["dealer"]["cardData"], randomCard)
                                    vrp_blackjackC.beginCardGiveOut(-1, {gameId, blackjackGameData[gameId]["dealer"]["cardData"], gameId, cardIndex, getCurrentHand(gameId, "dealer"), tableId})
                                end
                                Wait(1500) --Wait between each initial give out card
                            end
                            --Wait(6000) --Wait for dealer to check own card
                            for chairID = chairIdInitial, chairIdFinal do
                                if blackjackTables[chairID] ~= false then
                                    local source = blackjackTables[chairID]
                                    if blackjackGameData[gameId][source] ~= nil then
                                        local nextCardCount = 1
                                        local currentHand = getCurrentHand(gameId, source)
                                        if currentHand < 21 then
                                            vrp_blackjackC.standOrHit(-1, {gameId, chairID, nextCardCount, tableId})
                                            blackjackGameData[gameId][source][2] = {}
                                            --print("initialize card count = 1")
                                            while nextCardCount >= 1 do
                                                --print("while card count >= 1 waiting for a response... cardCount is: " .. tostring(nextCardCount))
                                                secondsWaited = 0
                                                --print("error debug #1")
                                                --print("gameId",gameId)
                                                --print(dump(blackjackGameData[gameId]))
                                                --print("=======")
                                                while blackjackGameData[gameId][source][2][nextCardCount] == nil and secondsWaited < 20 do
                                                    Wait(100)
                                                    secondsWaited = secondsWaited + 0.1
                                                    ----print("response to stand or hit is still false")
                                                end
                                                --print("response received! [ok]")
                                                if blackjackGameData[gameId][source][2][nextCardCount] == true then --if hit
                                                    --print("response was hit")
                                                    nextCardCount = nextCardCount + 1
                                                    local randomCard = math.random(1, 52)
                                                    table.insert(blackjackGameData[gameId][source]["cardData"], randomCard)
                                                    vrp_blackjackC.singleCard(-1, {gameId, randomCard, chairID, nextCardCount, getCurrentHand(gameId, source), tableId})
                                                    Wait(2000)
                                                    local currentHand = getCurrentHand(gameId, source)
                                                    --print("Checking for bust... currentHand: " .. tostring(currentHand))
                                                    if currentHand > 21 then
                                                        --print("currentHand > 21")
                                                        vrp_blackjackC.bustBlackjack(-1, {chairID, tableId})
                                                        nextCardCount = 0
                                                        blackjackGameData[gameId][source]["status"] = "bust"
                                                        local lostAmount = blackjackGameData[gameId][source][1]
                                                        vrp_blackjackC.notify(source, {"패배했습니다. 칩 " .. tostring(lostAmount) .. "개를 잃었습니다.", "error"})
                                                        if lostAmount > 10000000 then
                                                        --TriggerClientEvent("chatMessage", -1, "Diamond Casino | " .. GetPlayerName(source) .. " has LOST " .. tostring(getMoneyStringFormatted(lostAmount)) .. " chips!")
                                                        end
                                                    elseif currentHand < 21 then
                                                        --print("currentHand < 21")
                                                        vrp_blackjackC.standOrHit(-1, {gameId, chairID, nextCardCount, tableId})
                                                    else
                                                        --print("currentHand == 21")
                                                        --print("got 21 auto-standing")
                                                        nextCardCount = 0
                                                        blackjackGameData[gameId][source]["status"] = "stand"
                                                    end
                                                elseif blackjackGameData[gameId][source][2][nextCardCount] == false then --if stand
                                                    --print("response was false")
                                                    nextCardCount = 0
                                                    blackjackGameData[gameId][source]["status"] = "stand"
                                                else
                                                    --print("response was false")
                                                    nextCardCount = 0
                                                    blackjackGameData[gameId][source]["status"] = "stand"
                                                end
                                            end
                                        else
                                            --print("got 21 auto-standing")
                                            blackjackGameData[gameId][source]["status"] = "stand"
                                        end
                                    end
                                    vrp_blackjackC.endStandOrHitPhase(-1, {chairID, tableId})
                                end
                            end
                            local randomCard = math.random(1, 52)
                            --print("randomDealerCard: " .. tostring(randomCard))
                            table.insert(blackjackGameData[gameId]["dealer"]["cardData"], randomCard)
                            vrp_blackjackC.beginCardGiveOut(-1, {gameId, blackjackGameData[gameId]["dealer"]["cardData"], gameId, 1, getCurrentHand(gameId, "dealer"), tableId})
                            Wait(2800)
                            dealerHand = getCurrentHand(gameId, "dealer")
                            vrp_blackjackC.flipDealerCard(-1, {dealerHand, tableId, gameId})
                            Wait(2800)
                            --Dealer hit til 17 logic
                            local allPlayersHaveBusted = true
                            --print("allPlayersHaveBusted loop")
                            for k, v in pairs(blackjackGameData[gameId]) do
                                local betStatus = v["status"]
                                --print("betStatus: " .. tostring(betStatus))
                                if betStatus ~= nil then
                                    if betStatus == "stand" then
                                        allPlayersHaveBusted = false
                                    --print("allPlayersHaveBusted!")
                                    end
                                end
                            end
                            dealerHand = getCurrentHand(gameId, "dealer")
                            if not allPlayersHaveBusted then
                                --print("dealing hand is: " .. tostring(dealerHand))
                                if dealerHand >= 17 then
                                    --print("dealing hand is: " .. tostring(dealerHand) .. " so standing")
                                else
                                    --print("dealing hand is: " .. tostring(dealerHand) .. " so hitting")
                                    local nextCardCount = 2
                                    local highestPlayerHand = 0
                                    --print("highestPlayerHand",highestPlayerHand)
                                    for k, v in pairs(blackjackGameData[gameId]) do
                                        if k ~= "dealer" then
                                            playerHand = getCurrentHand(gameId, k)
                                            --print("================")
                                            --print("playerHand",playerHand)
                                            --print("highestPlayerHand",highestPlayerHand)
                                            --print("================")
                                            if playerHand ~= nil then
                                                if playerHand > highestPlayerHand and playerHand <= 21 then
                                                    highestPlayerHand = playerHand
                                                --print("highestPlayerHand",highestPlayerHand,"= playerHand",playerHand)
                                                end
                                            end
                                        end
                                    end
                                    if highestPlayerHand < dealerHand then
                                        --print("ending game early, dealer has higher than all players")
                                    else
                                        while dealerHand < 17 do
                                            local randomCard = math.random(1, 52)
                                            --print("randomDealerCard: " .. tostring(randomCard))
                                            table.insert(blackjackGameData[gameId]["dealer"]["cardData"], randomCard)
                                            vrp_blackjackC.singleDealerCard(-1, {gameId, randomCard, nextCardCount, getCurrentHand(gameId, "dealer"), tableId})
                                            Wait(2800)
                                            nextCardCount = nextCardCount + 1
                                            dealerHand = getCurrentHand(gameId, "dealer")
                                        end
                                    end
                                end
                            end
                            for k, v in pairs(blackjackGameData[gameId]) do
                                if k ~= "dealer" then
                                    local source = k
                                    if blackjackGameData[gameId][source] ~= nil then
                                        --print("Checking source: " .. tostring(source) .. " for bust when final checks are doing")
                                        --print("result: " .. tostring(blackjackGameData[gameId][source]["status"]))
                                        --print("table dump:")
                                        --print(dump(blackjackGameData[gameId][source]))
                                        if blackjackGameData[gameId][source]["status"] ~= "bust" then
                                            local currentHand = getCurrentHand(gameId, source)
                                            --print("Checking for bust... currentHand: " .. tostring(currentHand))
                                            --print("dealerHand: " .. tostring(dealerHand))
                                            if currentHand ~= nil then
                                                if currentHand <= 21 then
                                                    local potentialWinAmount = blackjackGameData[gameId][source][1] * 2
                                                    local potentialPushAmount = blackjackGameData[gameId][source][1]
                                                    local playerPing = GetPlayerPing(source)
                                                    if dealerHand > 21 then
                                                        --print("source: " .. tostring(source) .. " wins!")
                                                        giveChips(source, potentialWinAmount)
                                                        if playerPing ~= nil then
                                                            if playerPing > 0 then
                                                                vrp_blackjackC.blackjackWin(source, {tableId})
                                                                vrp_blackjackC.notify(source, {"승리했습니다. 칩 " .. tostring(potentialWinAmount) .. "개를 받았습니다."})
                                                                if potentialPushAmount > 10000000 then
                                                                --TriggerClientEvent("chatMessage", -1, "리얼월드 카지노 | " .. GetPlayerName(source) .. " 님이 " .. tostring(getMoneyStringFormatted(potentialPushAmount)) .. " 칩을 획득!")
                                                                end
                                                            end
                                                        end
                                                        vrp_blackjackC.dealerBusts(-1, {tableId})
                                                    elseif currentHand > dealerHand and currentHand <= 21 then
                                                        --print("source: " .. tostring(source) .. " wins!")
                                                        giveChips(source, potentialWinAmount)
                                                        if playerPing ~= nil then
                                                            if playerPing > 0 then
                                                                vrp_blackjackC.blackjackWin(source, {tableId})
                                                                vrp_blackjackC.notify(source, {"승리했습니다. 칩 " .. tostring(potentialWinAmount) .. "개를 받았습니다."})
                                                                if potentialPushAmount > 10000000 then
                                                                --TriggerClientEvent("chatMessage", -1, "리얼월드 카지노 | " .. GetPlayerName(source) .. " 님이 " .. tostring(getMoneyStringFormatted(potentialPushAmount)) .. " 칩을 획득!")
                                                                end
                                                            end
                                                        end
                                                    elseif currentHand == dealerHand then
                                                        --print("source: " .. tostring(source) .. " pushes!")
                                                        giveChips(source, potentialPushAmount)
                                                        if playerPing ~= nil then
                                                            if playerPing > 0 then
                                                                vrp_blackjackC.blackjackPush(source, {tableId})
                                                                vrp_blackjackC.notify(source, {"무승부 입니다.", "warning"})
                                                            end
                                                        end
                                                    else
                                                        --print("source: " .. tostring(source) .. " loses!")
                                                        if playerPing ~= nil then
                                                            if playerPing > 0 then
                                                                vrp_blackjackC.blackjackLose(source, {tableId})
                                                                vrp_blackjackC.notify(source, {"패배했습니다. 칩 " .. tostring(potentialPushAmount) .. "개를 잃었습니다.", "error"})
                                                                if potentialPushAmount > 10000000 then
                                                                --TriggerClientEvent("chatMessage", -1, "리얼월드 카지노 | " .. GetPlayerName(source) .. " 님이 " .. tostring(getMoneyStringFormatted(potentialPushAmount)) .. " 칩을 손실!")
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            for chairID = chairIdInitial, chairIdFinal do
                                if blackjackTables[chairID] ~= false then
                                    local source = blackjackTables[chairID]
                                    if blackjackGameData[gameId][source] ~= nil then
                                        vrp_blackjackC.chipsCleanup(-1, {chairID, tableId})
                                        vrp_blackjackC.chipsCleanup(-1, {tostring(chairID) .. "chips", tableId})
                                        --print("chips cleanup for chairID, waiting 2 seconds....")
                                        Wait(3500)
                                    end
                                end
                            end
                            --print("chips cleanup for dealer")
                            vrp_blackjackC.chipsCleanup(-1, {gameId, tableId})
                            for chairID = chairIdInitial, chairIdFinal do
                                vrp_blackjackC.chipsCleanupNoAnim(-1, {chairID, tableId})
                                vrp_blackjackC.chipsCleanupNoAnim(-1, {tostring(chairID) .. "chips", tableId})
                            end
                            blackjackGameInProgress[gameId] = false
                        else
                            --print("Game not started")
                        end
                    else
                        --print("No one betted :(")
                    end
                else
                    Wait(1000)
                end
                Wait(1000) --Check ever second if anyones sitting at the table
            end
        end
    )
end

--1,1,3,6
function getCurrentHand(gameId, userId)
    --print("error debug #2")
    --print("gameId",gameId)
    --print("userId",userId)
    --print(dump(blackjackGameData[gameId]))
    --print("=======")
    if blackjackGameData[gameId][userId]["cardData"] ~= nil then
        local hand = 0
        local numberOfAces = 0
        for k, v in pairs(blackjackGameData[gameId][userId]["cardData"]) do
            local nextCard = getCardNumberFromCardId(v)
            if nextCard == 11 then
                numberOfAces = numberOfAces + 1
            else
                hand = hand + nextCard
            end
        end
        for i = 1, numberOfAces, 1 do
            if i == 1 then
                if hand + 11 > 21 then
                    nextCard = 1
                else
                    nextCard = 11
                end
            else
                nextCard = 1
            end
            hand = hand + nextCard
        end
        return hand
    end
end

function chairIdToTableId(chairId)
    if chairId <= 3 then
        return 0
    end
    if chairId <= 7 then
        return 1
    end
    if chairId <= 11 then
        return 2
    end
    if chairId <= 15 then
        return 3
    end
    if chairId <= 19 then
        return 4
    end
    if chairId <= 23 then
        return 5
    end
end

function getCardNumberFromCardId(cardId)
    if cardId == 1 then
        return 11
    elseif cardId == 2 then
        return 2
    elseif cardId == 3 then
        return 3
    elseif cardId == 4 then
        return 4
    elseif cardId == 5 then
        return 5
    elseif cardId == 6 then
        return 6
    elseif cardId == 7 then
        return 7
    elseif cardId == 8 then
        return 8
    elseif cardId == 9 then
        return 9
    elseif cardId == 10 then
        return 10
    elseif cardId == 11 then
        return 10
    elseif cardId == 12 then
        return 10
    elseif cardId == 13 then
        return 10
    elseif cardId == 14 then
        return 11
    elseif cardId == 15 then
        return 2
    elseif cardId == 16 then
        return 3
    elseif cardId == 17 then
        return 4
    elseif cardId == 18 then
        return 5
    elseif cardId == 19 then
        return 6
    elseif cardId == 20 then
        return 7
    elseif cardId == 21 then
        return 8
    elseif cardId == 22 then
        return 9
    elseif cardId == 23 then
        return 10
    elseif cardId == 24 then
        return 10
    elseif cardId == 25 then
        return 10
    elseif cardId == 26 then
        return 10
    elseif cardId == 27 then
        return 11
    elseif cardId == 28 then
        return 2
    elseif cardId == 29 then
        return 3
    elseif cardId == 30 then
        return 4
    elseif cardId == 31 then
        return 5
    elseif cardId == 32 then
        return 6
    elseif cardId == 33 then
        return 7
    elseif cardId == 34 then
        return 8
    elseif cardId == 35 then
        return 9
    elseif cardId == 36 then
        return 10
    elseif cardId == 37 then
        return 10
    elseif cardId == 38 then
        return 10
    elseif cardId == 39 then
        return 10
    elseif cardId == 40 then
        return 11
    elseif cardId == 41 then
        return 2
    elseif cardId == 42 then
        return 3
    elseif cardId == 43 then
        return 4
    elseif cardId == 44 then
        return 5
    elseif cardId == 45 then
        return 6
    elseif cardId == 46 then
        return 7
    elseif cardId == 47 then
        return 8
    elseif cardId == 48 then
        return 9
    elseif cardId == 49 then
        return 10
    elseif cardId == 50 then
        return 10
    elseif cardId == 51 then
        return 10
    elseif cardId == 52 then
        return 10
    end
end

function isTableEmpty(self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

function getMoneyStringFormatted(cashString)
    local i, j, minus, int, fraction = tostring(cashString):find("([-]?)(%d+)([.]?%d*)")

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

-- RegisterCommand("debugtableserver",function()
--     print("blackjackTables")
--     print("===============")
--     print(dump(blackjackTables))
--     print("blackjackGameData")
--     print("===============")
--     print(dump(blackjackGameData))
-- end)

-- RegisterCommand("debugcarddata",function()
--     print("carddata")
--     print("===============")
--     print(dump(blackjackGameData[1024]))
-- end)