Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            local ped = GetPlayerPed(-1)
            local Health = GetEntityHealth(ped)
            if Health <= 120 then
                help_message("~INPUT_RELOAD~ 키를 눌러 의료국을 호출하세요")
                if IsControlJustReleased(1, 45) then
                    TriggerServerEvent("check:ems")
                end
            end
        end
    end
)

RegisterNetEvent("knb:medic")
AddEventHandler(
    "knb:medic",
    function()
        local player = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(player)

        local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0)

        local targetVeh = GetPlayerPed(-1)

        GetMechPed()

        local driverhash = GetHashKey(mechPedPick.model)
        RequestModel(driverhash)
        local vehhash = GetHashKey(mechPedPick.vehicle)
        RequestModel(vehhash)

        loadAnimDict("cellphone@")

        while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
            RequestModel(driverhash)
            RequestModel(vehhash)
            Citizen.Wait(0)
        end

        if DoesEntityExist(player) then
            if DoesEntityExist(mechVeh) then
                DeleteVeh(mechVeh, mechPed)
                SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
            else
                SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
            end
            playRadioAnim(player)
            GoToTarget(GetEntityCoords(targetVeh).x, GetEntityCoords(targetVeh).y, GetEntityCoords(targetVeh).z, mechVeh, mechPed, vehhash, targetVeh)
        end
    end
)

function SpawnVehicle(x, y, z, vehhash, driverhash)
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(x + math.random(-spawnRadius, spawnRadius), y + math.random(-spawnRadius, spawnRadius), z, 0, 3, 0)

    if found and HasModelLoaded(vehhash) and HasModelLoaded(vehhash) then
        mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false)
        SetVehicleOnGroundProperly(mechVeh)
        SetVehicleColours(mechVeh, mechPedPick.colour, mechPedPick.colour)

        mechPed = CreatePedInsideVehicle(mechVeh, 26, driverhash, -1, true, false)
        mechBlip = AddBlipForEntity(mechVeh)
        SetBlipFlashes(mechBlip, true)
        SetBlipColour(mechBlip, 3)
        SetEntityInvincible(mechPed, true)
        SetVehicleDoorsLockedForAllPlayers(mechVeh, true)
        SetVehicleSiren(mechVeh, true)
    end
end

function DeleteVeh(vehicle, driver)
    SetEntityAsMissionEntity(vehicle, false, false)
    DeleteEntity(vehicle)
    SetEntityAsMissionEntity(driver, false, false)
    DeleteEntity(driver)
    RemoveBlip(mechBlip)
end

function GoToTarget(x, y, z, vehicle, driver, vehhash, target)
    TaskVehicleDriveToCoord(driver, vehicle, x, y, z, 17.0, 0, vehhash, drivingStyle, 1, true)
    ShowAdvancedNotification(companyIcon, companyName, "", "~w~[소방청] ~g~구급대원이 출발했습니다 ~y~" .. companyName)
    enroute = true
    while enroute do
        Citizen.Wait(500)
        distanceToTarget = GetDistanceBetweenCoords(GetEntityCoords(target), GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z, true)
        if simplerRepair then
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                Citizen.Wait(3000)
                TriggerServerEvent("heal:user")
            end
        else
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                SetVehicleUndriveable(vehicle, true)
                GoToTargetWalking(target, vehicle, driver)
            end
        end
    end
end

function GoToTargetWalking(player, vehicle, driver)
    while enroute do
        Citizen.Wait(500)
        engine = GetEntityCoords(player)
        TaskGoToCoordAnyMeans(driver, engine, 2.0, 0, 0, 786603, 0xbf800000)
        distanceToTarget = GetDistanceBetweenCoords(engine, GetEntityCoords(driver).x, GetEntityCoords(driver).y, GetEntityCoords(driver).z, true)
        norunrange = false
        if distanceToTarget <= 10 and not norunrange then -- stops ai from sprinting when close
            TaskGoToCoordAnyMeans(driver, engine, 1.0, 0, 0, 786603, 0xbf800000)
            norunrange = true
        end
        if distanceToTarget <= 2 then
            SetVehicleUndriveable(player, true)
            TaskTurnPedToFaceCoord(driver, GetEntityCoords(player), -1)
            RequestAnimDict("mini@cpr@char_a@cpr_str")
            while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
                Citizen.Wait(1000)
            end
            TaskPlayAnim(driver, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
            SetVehicleDoorOpen(player, 4, false, false)
            Citizen.Wait(10000)
            ClearPedTasks(driver)
            RepairVehicle(player, vehicle, driver)
        end
    end
end

function RepairVehicle(player, vehicle, driver)
    enroute = false
    norunrange = false
    FreezeEntityPosition(driver, false)
    Citizen.Wait(500)
    ShowAdvancedNotification(mechPedPick.icon, mechPedPick.name, "응급처치가 완료되었습니다", mechPedPick.lines[math.random(#mechPedPick.lines)])
    SetEntityHealth(player, 500)
    SetVehicleSiren(mechVeh, false)
    Citizen.Wait(5000)
    LeaveTarget(vehicle, driver)
end

function LeaveTarget(vehicle, driver)
    TaskVehicleDriveWander(driver, vehicle, 17.0, drivingStyle)
    SetEntityAsNoLongerNeeded(vehicle)
    SetPedAsNoLongerNeeded(driver)
    SetEntityInvincible(mechPed, true)
    SetVehicleDoorsLockedForAllPlayers(mechVeh, false)
    RemoveBlip(mechBlip)
    mechVeh = nil
    mechPed = nil
    targetVeh = nil
end

function GetTargetVehicle(player, dir)
    if IsPedSittingInAnyVehicle(player) then
        dmgVeh = GetPlayerPed(-1)
    else
        dmgVeh = GetVehicleInDirection(GetEntityCoords(player), dir)
    end

    if DoesEntityExist(dmgVeh) then
        return dmgVeh
    else
        ShowNotification("")
    end
end

function GetMechPed()
    mechPedPick = mechPeds[math.random(#mechPeds)]
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function playRadioAnim(player)
    Citizen.CreateThread(
        function()
            RequestAnimDict(arrests)
            TaskPlayAnim(player, "cellphone@", "cellphone_call_in", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0)
            Citizen.Wait(6000)
            ClearPedTasks(player)
        end
    )
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end
