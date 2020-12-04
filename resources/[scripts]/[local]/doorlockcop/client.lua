----------------- DoorLock System
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
local doorList = cfg.list
local LockHotkey = {0, 38}
local playerCoords = vector3(0, 0, 0)
local firstLoad = false
local minShowTextDist = 1.5

function DrawText3d(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.2, 0.2)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
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

Citizen.CreateThread(
    function()
        Citizen.Wait(100)
        firstLoad = true
        TriggerServerEvent("door:load")
        for i = 1, #doorList do
            if doorList[i]["ishash"] == 0 then
                doorList[i]["objNameHash"] = GetHashKey(doorList[i]["objName"])
            end
        end
        while true do
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            for i = 1, #doorList do
                doorList[i].dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3], true)
            end
            Citizen.Wait(100)
        end
    end
)

RegisterNetEvent("door:statusSend")
AddEventHandler(
    "door:statusSend",
    function(i, status)
        doorList[i]["locked"] = status
    end
)

RegisterNetEvent("door:loadSend")
AddEventHandler(
    "door:loadSend",
    function(list)
        for k, v in pairs(doorList) do
            doorList[k].locked = list[k]
        end
    end
)

local isProcess = false
local processNo = nil
local processRequestType = nil

RegisterNetEvent("door:process")
AddEventHandler(
    "door:process",
    function(i, status)
        if status == true then
        else
            vRP.playAnim({false, {{"mp_arresting", "a_uncuff", 1}}, true})
            FreezeEntityPosition(GetPlayerPed(-1), true)
            exports["progressBars"]:startUI(1000, "문을 여는중..")
            Citizen.Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            vRP.stopAnim({false})
        end
        TriggerServerEvent("door:status", i, status)
        isProcess = false
    end
)

RegisterNetEvent("door:reject")
AddEventHandler(
    "door:reject",
    function(i, status)
        isProcess = false
    end
)

Citizen.CreateThread(
    function()
        while true do
            if isProcess and processNo ~= nil and processRequestType ~= nil then
                TriggerServerEvent("door:check", processNo, processRequestType)
                processNo = nil
                processRequestType = nil
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #doorList do
                local setDist = doorList[i].area or minShowTextDist
                setDist = setDist / 3
                if setDist < minShowTextDist then
                    setDist = minShowTextDist
                end
                if doorList[i].dist ~= nil and doorList[i].dist < setDist then
                    if doorList[i].isHideLabel ~= true then
                        if doorList[i]["locked"] == true then
                            DrawText3d(doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3] + 1, "~h~~b~문이 ~r~잠겨있습니다.")
                        else
                            DrawText3d(doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3] + 1, "~h~~b~문이 ~g~열렸습니다.")
                        end
                    end
                    if IsControlJustPressed(0, 38) and not isProcess then
                        isProcess = true
                        processNo = i
                        processRequestType = not doorList[i]["locked"]
                    end
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #doorList do
                if doorList[i]["ishash"] == 0 then
                    hash = doorList[i]["objNameHash"]
                else
                    hash = doorList[i]["objName"]
                end
                if doorList[i].dist ~= nil and doorList[i].dist < (doorList[i].area or 5.0) then
                    local closeDoor = GetClosestObjectOfType(doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3], doorList[i]["area"] or 1.0, hash, false, false, false)
                    local locked, heading = GetStateOfClosestDoorOfType(hash, doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3], locked, heading)
                    if closeDoor then
                        local ratio = 1
                        if doorList[i].isSlide ~= nil then
                            ratio = 3
                        end
                        if not IsDoorRegisteredWithSystem(closeDoor) then
                            AddDoorToSystem(closeDoor, hash, doorList[i].coords[1], doorList[i].coords[2], doorList[i].coords[3], true, true, true)
                        end
                        if doorList[i]["locked"] then
                            DoorSystemSetDoorState(closeDoor, 1, 0, 1)
                        end
                        if heading > (-0.02 * ratio) and heading < (0.02 * ratio) then
                            if firstLoad == true then
                                firstLoad = false
                                SetEntityHealth(closeDoor, 1000)
                                ClearEntityLastDamageEntity(closeDoor)
                                SetEntityCanBeDamaged(closeDoor, false)
                            end
                            NetworkRequestControlOfEntity(closeDoor)
                            FreezeEntityPosition(closeDoor, doorList[i]["locked"])
                        end
                    end
                end
            end
            Citizen.Wait(500)
        end
    end
)
