---------------------------------------------------------
------------ VRP VideoCasino, RealWorld MAC -------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_vcC = {}
Tunnel.bindInterface("vrp_vc", vrp_vcC)
Proxy.addInterface("vrp_vc", vrp_vcC)
vRP = Proxy.getInterface("vRP")
vrp_vcS = Tunnel.getInterface("vrp_vc", "vrp_vc")

local coordonate = {
    {170.52, -924.82, 30.95, "이파산", "회생/파산 장인", 329.21, "s_m_y_waiter_01", true, true, true},
    {183.54, -933.9, 30.95, "김복구", "복구 장인", 335.01, "s_m_m_highsec_01", true, true, true},
    {175.22369384766, -905.06182861328, 31.528566360474, "육구선", "카지노바 알바생", 240.01, "a_f_y_beach_01", true, true, true},
    {176.06730651855, -902.74176025391, 31.528566360474, "팔미선", "카지노바 관리인", 240.01, "a_f_y_bevhills_01", true, true, true},
    {192.55096435547, -925.90472412109, 30.686679840088, "임동탁", "카지노 경비", 150.01, "a_m_m_soucent_02", true, true, true},
    {175.5550994873, -914.36590576172, 30.686677932739, "구공탄", "카지노 경비", 150.01, "a_m_y_surfer_01", true, true, true},
    {227.02705383301, -876.29254150391, 30.491376876831, "블륀", "페스티벌 노예", 0.01, "a_m_m_soucent_02", true, true, true}, --페스티벌 전용 NPC(09.04 삭제)
    {245.71868896484, -883.18359375, 30.491376876831, "구공순", "추첨박스 관리인", 0.01, "a_f_y_juggalo_01", true, true, true}
}
coordonate = {}

local propNameList = {
    ["cash_1"] = "prop_anim_cash_note",
    ["cash_2"] = "prop_anim_cash_pile_01",
    ["cash_3"] = "prop_anim_cash_pile_02",
    ["cash_4"] = "prop_poly_bag_money",
    ["cash_5"] = "prop_money_bag_01",
    ["cash_6"] = "prop_cash_case_02",
    ["cash_7"] = "prop_cash_case_01",
    ["_"] = "p_ld_bs_bag_01"
}

local baseCoords = vector3(184.22076416016, -918.13372802734, 30.875654220581)
local cancelMarker = {184.67294311523, -932.24627685547, 30.68673324585, 2.0}
local reviveMarker = {171.59669494629, -923.0751953125, 30.686735153198, 2.0}
local activeMarkers = {}

local setRoundCount = 25
local currentRoundCount = setRoundCount

function notify(msg, type, timer)
    TriggerEvent(
        "pNotify:SendNotification",
        {
            text = msg,
            type = type or "success",
            timeout = timer or 3000,
            layout = "centerleft",
            queue = "global"
        }
    )
end

function DrawText3D(x, y, z, text, r, g, b, a, s, bg)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    if not s then
        s = 2.5
    end

    local scale = (1 / dist) * s
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropShadow(0, 0, 0, 0, 150)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        if bg then
            local factor = (string.len(text)) / 300
            DrawRect(_x, _y + 0.01, 0.015 + factor, 0.025, 0, 0, 0, 50)
        end
    end
end

function vrp_vcC.removeDropMoney(netIds)
    for k, v in pairs(netIds) do
        local obj = NetToObj(v)
        SetEntityAsMissionEntity(obj, true, true)
        DeleteObject(obj)
    end
end

function vrp_vcC.createDropMoney(amount)
    local propName = propNameList["_"]
    local item = ""
    if amount >= 100000000 then
        item = "cash_7"
    elseif amount >= 10000000 then
        item = "cash_6"
    elseif amount >= 1000000 then
        item = "cash_5"
    elseif amount >= 500000 then
        item = "cash_4"
    elseif amount >= 100000 then
        item = "cash_3"
    elseif amount >= 10000 then
        item = "cash_2"
    else
        item = "cash_1"
    end
    if propNameList[item] ~= nil then
        propName = propNameList[item]
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local Bag = GetHashKey(propName)
    RequestModel(Bag)
    while not HasModelLoaded(Bag) do
        Citizen.Wait(1)
    end
    local object = CreateObject(RWO, Bag, x, y, z - 2, true, true, true)
    PlaceObjectOnGroundProperly(object)

    return ObjToNet(object)
end

function vrp_vcC.showWinningMarker(oddIds)
    activeMarkers = {}
    for k, v in pairs(oddIds) do
        if markers[v] then
            activeMarkers[v] = markers[v]
        end
    end
    SetTimeout(
        10000,
        function()
            activeMarkers = {}
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            currentRoundCount = currentRoundCount - 1
            if currentRoundCount < 0 then
                currentRoundCount = 0
            end

            local mCoords = GetEntityCoords(GetPlayerPed(-1))
            local dist = GetDistanceBetweenCoords(mCoords, baseCoords, 1)
            if dist < 25 then
                vrp_vcS.getGameInfo(
                    {},
                    function(data)
                        if gameInfo.round ~= data.round then
                            currentRoundCount = setRoundCount
                        end
                        gameInfo = data
                    end
                )
            end
        end
    end
)

local selectMarker = nil

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        while true do
            Citizen.Wait(1)
            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
            local isSelect = false
            for k, v in pairs(markers) do
                v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
                if activeMarkers[k] == nil then
                    DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v[4], v[4], 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
                end
                if v.dist < 10 then
                    if selectMarker == nil then
                        DrawText3D(v[1], v[2], v[3] - 0.2, v[6][1], 255, 255, 255, 255, v[6][2])
                    else
                        if selectMarker == k then
                            DrawText3D(v[1], v[2], v[3] - 0.2, v[7][1], 255, 255, 255, 255, v[7][2])
                        else
                            DrawText3D(v[1], v[2], v[3] - 0.2, v[6][1], 255, 255, 255, 150, v[6][2])
                        end
                    end

                    if gameInfo.odds[k][3] == true then
                        if selectMarker == nil then
                            DrawText3D(v[1], v[2], v[3] - 0.4, "배당: x" .. gameInfo.odds[k][1], 255, 255, 0, 255, 2.0)
                        else
                            if selectMarker == k then
                                DrawText3D(v[1], v[2], v[3] - 0.4, "배당: x" .. gameInfo.odds[k][1], 255, 255, 0, 255, 2.0)
                            else
                                DrawText3D(v[1], v[2], v[3] - 0.4, "배당: x" .. gameInfo.odds[k][1], 255, 255, 255, 100, 2.0)
                            end
                        end

                        if currentRoundCount < 5 then
                            DrawText3D(v[1], v[2], v[3] - 0.57, "(곧 마감)", 255, 255, 255, 150, 1.2)
                        else
                            DrawText3D(v[1], v[2], v[3] - 0.57, "(남은시간: " .. currentRoundCount .. "초)", 255, 255, 255, 150, 1.2)
                        end
                    else
                        DrawText3D(v[1], v[2], v[3] - 0.4, "마감", 255, 255, 255, 150, 2.0)
                    end
                end
            end
            for k, v in pairs(markers) do
                if v.dist < v[4] / 1.5 then
                    selectMarker = k
                    isSelect = true
                    DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~r~[ALT]~w~키를 눌러 ~y~베팅하기", 255, 255, 255, 255, 1.5)
                    if IsControlJustReleased(1, 19) then
                        vrp_vcS.bet({k})
                    end
                end
                if not isSelect then
                    selectMarker = nil
                end
            end
        end
    end
)

local num = 0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for k, v in pairs(activeMarkers) do
                DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v[4], v[4], num / 150, 0, 255, 0, num, 0, 0, 0, 0)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for k, v in pairs(activeMarkers) do
                local dir = false
                for c = 0, 1 do
                    if dir then
                        num = 200
                    end
                    for i = 0, 20 do
                        if dir then
                            num = num - 5
                        else
                            num = num + 5
                        end
                        Citizen.Wait(0)
                    end
                    dir = not dir
                end
            end
        end
    end
)

local isPendingCheck = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            local playerPos = GetEntityCoords(ped, true)
            local px, py, pz = playerPos.x, playerPos.y, playerPos.z

            local dist = Vdist(playerPos.x, playerPos.y, playerPos.z, cancelMarker[1], cancelMarker[2], cancelMarker[3])
            if dist < cancelMarker[4] / 2 then
                DrawText3D(px, py, pz + 1.0, "~r~[ALT]~w~키를 눌러 ~y~복구하기", 255, 255, 255, 255, 1.5)
                if IsControlJustReleased(1, 19) and not isPendingCheck then
                    isPendingCheck = true

                    ClearPedTasks(ped)
                    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

                    exports["progressBars"]:startUI(1000, "카지노 미정산금액 검색중..")
                    Citizen.Wait(1000)
                    vrp_vcS.cancelBet()

                    Citizen.Wait(1000)

                    exports["progressBars"]:startUI(1000, "카지노 미수령금액 검색중..")
                    Citizen.Wait(1000)
                    vrp_vcS.getPayErrorBets2()

                    ClearPedTasks(ped)

                    Citizen.Wait(5000)

                    isPendingCheck = false
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            local playerPos = GetEntityCoords(ped, true)
            local px, py, pz = playerPos.x, playerPos.y, playerPos.z

            local dist = Vdist(playerPos.x, playerPos.y, playerPos.z, reviveMarker[1], reviveMarker[2], reviveMarker[3])
            if dist < reviveMarker[4] / 2 then
                DrawText3D(px, py, pz + 1.0, "~r~[ALT]~w~키를 눌러 ~g~회생하기", 255, 255, 255, 255, 1.5)
                if IsControlJustReleased(1, 19) and not isPendingCheck then
                    isPendingCheck = true

                    ClearPedTasks(ped)
                    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_YOGA", 0, true)

                    exports["progressBars"]:startUI(2000, "카지노 내역 확인중..")
                    Citizen.Wait(2500)
                    exports["progressBars"]:startUI(3000, "개인회생 진행중..")
                    Citizen.Wait(3000)
                    vrp_vcS.reviveBet()

                    ClearPedTasks(ped)

                    Citizen.Wait(5000)

                    isPendingCheck = false
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            DrawText3D(cancelMarker[1], cancelMarker[2], cancelMarker[3] - 0.4, "복구 센터", 255, 255, 255, 150, 2.0)
            DrawMarker(1, cancelMarker[1], cancelMarker[2], cancelMarker[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cancelMarker[4], cancelMarker[4], 0.2, 255, 255, 255, 150, 0, 0, 0, 0)
            DrawText3D(reviveMarker[1], reviveMarker[2], reviveMarker[3] - 0.4, "개인회생/파산", 255, 255, 255, 150, 2.0)
            DrawMarker(1, reviveMarker[1], reviveMarker[2], reviveMarker[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, reviveMarker[4], reviveMarker[4], 0.2, 255, 255, 255, 150, 0, 0, 0, 0)
        end
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        dealerAnimDict = "mini@strip_club@idles@bouncer@base"
        RequestAnimDict(dealerAnimDict)
        while not HasAnimDictLoaded(dealerAnimDict) do
            RequestAnimDict(dealerAnimDict)
            Wait(0)
        end
        for _, v in pairs(coordonate) do
            local modelHash = GetHashKey(v[7])
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                RequestModel(modelHash)
                Wait(0)
            end
            local dealerEntity = CreatePed(RWP, 26, modelHash, v[1], v[2], v[3], v[6], false, true)
            SetModelAsNoLongerNeeded(modelHash)
            SetEntityCanBeDamaged(dealerEntity, 0)
            SetPedAsEnemy(dealerEntity, 0)
            SetBlockingOfNonTemporaryEvents(dealerEntity, 1)
            SetPedResetFlag(dealerEntity, 249, 1)
            SetPedConfigFlag(dealerEntity, 185, true)
            SetPedConfigFlag(dealerEntity, 108, true)
            SetPedCanEvasiveDive(dealerEntity, 0)
            SetPedCanRagdollFromPlayerImpact(dealerEntity, 0)
            SetPedConfigFlag(dealerEntity, 208, true)
            SetEntityCoordsNoOffset(dealerEntity, v[1], v[2], v[3], 0, 0, 1)
            SetEntityHeading(dealerEntity, v[6])
            SetEntityInvincible(dealerEntity, v[9])

            if v[11] then
                GiveWeaponToPed(dealerEntity, v[11], math.random(20, 100), false, true)
                SetCurrentPedWeapon(dealerEntity, v[11], true)
                if v[12] then
                    SetBlockingOfNonTemporaryEvents(dealerEntity, 0)
                    SetPedCombatAbility(dealerEntity, 100)
                    SetPedAsEnemy(dealerEntity, 1)
                end
            else
                TaskPlayAnim(dealerEntity, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            end

            Citizen.Wait(1000)
            FreezeEntityPosition(dealerEntity, v[8])
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            local pos = GetEntityCoords(GetPlayerPed(-1), true)
            Citizen.Wait(0)
            for _, v in pairs(coordonate) do
                x = v[1]
                y = v[2]
                z = v[3]
                if (Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0) then
                    DrawText3D(x, y, z + 1.15, v[4], 0, 255, 0, 150, 2.0)
                    DrawText3D(x, y, z + 1.00, v[5], 255, 255, 255, 150, 1.5)
                end
            end
        end
    end
)
