local trees = {
    {-488.45736694336, 6051.029296875, 30.108934402466},
    {-491.697265625, 6047.5224609375, 30.426809310913},
    {-498.63369750977, 6031.6811523438, 32.071685791016},
    {-502.62271118164, 6028.4541015625, 32.411987304688},
    {-517.38842773438, 6029.1274414063, 32.179512023926},
    {-518.0029296875, 6023.1826171875, 32.547199249268},
    {-523.49584960938, 6012.1005859375, 32.927639007568},
    {-521.97064208984, 6005.8852539063, 33.553234100342},
    {-543.78186035156, 6015.2705078125, 30.465713500977},
    {-536.79730224609, 5997.6489257813, 33.419410705566},
    {-526.29522705078, 5987.4013671875, 35.304981231689},
    {-555.99035644531, 5993.7998046875, 32.324672698975},
    {-565.82873535156, 6003.7490234375, 29.534063339233},
    {-565.21789550781, 6008.4423828125, 28.367679595947},
    {-578.26696777344, 6038.7524414063, 19.324167251587},
    {-594.54223632813, 6035.1538085938, 18.174043655396},
    {-594.92303466797, 6030.4301757813, 19.202423095703},
    {-602.50518798828, 6010.7426757813, 19.42223739624},
    {-596.29223632813, 5984.38671875, 17.277906417847},
    {-603.9150390625, 6065.1748046875, 9.7637815475464},
    {-607.17138671875, 6065.3803710938, 9.5901336669922},
    {297.72103881836, 4368.228515625, 50.811393737793},
    {307.75814819336, 4350.5390625, 50.382106781006},
    {285.61727905273, 4379.892578125, 49.251071929932},
    {322.77810668945, 4342.7294921875, 50.031455993652},
    {338.57116699219, 4339.7587890625, 49.737308502197},
    {350.38232421875, 4322.8159179688, 48.077342987061},
    {336.11938476563, 4322.1044921875, 48.191898345947},
    {311.8669128418, 4326.3227539063, 48.438110351563},
    {288.49853515625, 4340.9091796875, 48.441558837891},
    {266.69137573242, 4335.3193359375, 46.148956298828},
    {282.1643371582, 4317.2939453125, 46.088642120361},
    {298.31820678711, 4311.5947265625, 46.612201690674},
    {318.17401123047, 4306.2587890625, 47.15279006958},
    {337.53970336914, 4293.0380859375, 44.239753723145},
    {373.44067382813, 4324.3305664063, 46.300537109375},
    {318.7497253418, 4280.615234375, 43.571731567383},
    {298.37194824219, 4292.9287109375, 44.542808532715},
    {270.11602783203, 4297.1279296875, 42.958759307861},
    {286.35940551758, 4277.1811523438, 41.370975494385},
    {359.75360107422, 4306.1552734375, 44.45202255249},
    {307.79598999023, 4271.556640625, 42.265033721924},
    {253.20137023926, 4313.9174804688, 43.997352600098},
    ---
    {1889.2888183594,251.5152130127,161.98887634277},
    {1904.3358154297,276.86483764648,162.17100524902},
    {1889.5703125,291.3486328125,162.9104309082},
    {1882.9078369141,301.75665283203,162.75698852539},
    {1873.1513671875,301.18948364258,163.00103759766},
    {1843.6350097656,321.65084838867,161.48403930664}
}

local alreadyCut = {}

local processLoc = {
    {1074.4689941406, 2085.4860839844, 53.387767791748},
    {1125.2193603516, 2076.4226074219, 55.310928344727},
    {1143.8284912109, 2111.0385742188, 55.794990539551}
}

local isProcessing = false

--[[Citizen.CreateThread(function()
    for k,v in pairs(trees) do
        local x,y,z = table.unpack(v)
        z = z-2
        local tree = CreateObject(RWO,GetHashKey("prop_tree_cedar_02"), x, y, z, true, true, false)
        NetworkRequestControlOfEntity(tree)
        FreezeEntityPosition(tree, true)
    end
end)]]
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            for k, v in pairs(trees) do
                local x, y, z = table.unpack(v)
                z = z - 1
                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
                local alpha = math.floor(255 - (distance * 30))
                if alreadyCut[k] ~= nil then
                    local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
                    if timeDiff < 50000 then
                        if distance < 5.0 then
                            local seconds = math.ceil(60 - timeDiff / 1000)
                            DrawText3d(x, y, z + 1.5, "~w~ ~r~" .. tostring(seconds) .. "~w~초 남음", alpha)
                        end
                    else
                        alreadyCut[k] = nil
                    end
                else
                    if distance < 2.0 then
                        DrawText3d(x, y, z + 1.5, " ~g~[E]~w~장작패기", alpha)
                        if (IsControlJustPressed(1, 38)) then
                            if alreadyCut[k] ~= nil then
                                if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
                                    alreadyCut[k] = GetGameTimer()
                                    TriggerEvent("lenhador:cutTree")
                                end
                            else
                                alreadyCut[k] = GetGameTimer()
                                TriggerEvent("lenhador:cutTree")
                            end
                        end
                    elseif distance < 5.0 then
                        DrawText3d(x, y, z + 1.5, "~w~장작 패는 곳", alpha)
                    end
                end
            end
        end
    end
)

local lastProcess = 0

Citizen.CreateThread(
    function()
        while true do
            if isProcessing then
                if GetTimeDifference(GetGameTimer(), lastProcess) > 4000 then
                    for k, v in pairs(processLoc) do
                        local x, y, z = table.unpack(v)
                        local pCoords = GetEntityCoords(GetPlayerPed(-1))
                        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
                        if distance < 2.0 then
                            lastProcess = GetGameTimer()
                            TriggerServerEvent("lenhador:processWood")
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end
)

Citizen.CreateThread(
    function()
        FreezeEntityPosition(GetPlayerPed(-1), false)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        while true do
            Citizen.Wait(1)
            for k, v in pairs(processLoc) do
                local x, y, z = table.unpack(v)
                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
                local alpha = math.floor(255 - (distance * 30))

                DrawMarker(29, x, y, z, 0, 0, 0, 0.0, 0, 0, 1.3, 1.3, 1.3, 220, 120, 0, 255, 0, 0, 0, true)

                if isProcessing then
                    if distance < 2.0 then
                        DrawText3d(x, y, z + 1.8, " ~r~[E]~w~자동판매취소", alpha)
                        if (IsControlJustPressed(1, 38)) then
                            TriggerEvent("lenhador:enableProcess")
                        end
                    elseif distance < 8.0 then
                        DrawText3d(x, y, z + 1.8, "~w~장작판매", alpha)
                    end
                else
                    if distance < 2.0 then
                        DrawText3d(x, y, z + 1.8, "~g~[E]~w~자동판매하기", alpha)
                        if (IsControlJustPressed(1, 38)) then
                            TriggerEvent("lenhador:enableProcess")
                        end
                    elseif distance < 8.0 then
                        DrawText3d(x, y, z + 1.8, "~w~장작판매", alpha)
                    end
                end
            end
        end
    end
)

local isProcess = false

RegisterNetEvent("lenhador:cutTree")
AddEventHandler(
    "lenhador:cutTree",
    function(tree)
        if isProcess then
            TriggerServerEvent("lenhador:reject")
            return
        end
        isProcess = true
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        while (not HasAnimDictLoaded("amb@world_human_hammering@male@base")) do
            RequestAnimDict("amb@world_human_hammering@male@base")
            Citizen.Wait(5)
        end
        propaxe = CreateObject(RWO, GetHashKey("prop_tool_fireaxe"), x, y, z + 0.2, true, true, true)
        AttachEntityToEntity(propaxe, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
        TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_hammering@male@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        FreezeEntityPosition(GetPlayerPed(-1), true)
        math.randomseed(math.random(2000, 5000))
        local rand = math.random(2000, 5000)
        exports["progressBars"]:startUI(rand, "도끼질만이 살길이다..")
        Citizen.Wait(rand)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerServerEvent("lenhador:rewardWood")
        Citizen.Wait(2000)
        DetachEntity(propaxe, 1, 1)
        DeleteObject(propaxe)
        isProcess = false
    end
)

RegisterNetEvent("lenhador:enableProcess")
AddEventHandler(
    "lenhador:enableProcess",
    function()
        isProcessing = not isProcessing
        if isProcessing then
            --TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WINDOW_SHOP_BROWSE", 0, true)
            --FreezeEntityPosition(GetPlayerPed(-1),true)
            Citizen.Wait(100)
        elseif not isProcessing then
            FreezeEntityPosition(GetPlayerPed(-1), false)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    end
)

function DrawText3d(x, y, z, text, alpha)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x, y, z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end
