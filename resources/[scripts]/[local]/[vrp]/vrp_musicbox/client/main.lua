---------------------------------------------------------
------------ VRP Musicbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_musicboxC = {}
Tunnel.bindInterface("vrp_musicbox", vrp_musicboxC)
Proxy.addInterface("vrp_musicbox", vrp_musicboxC)
vRP = Proxy.getInterface("vRP")
vrp_musicboxS = Tunnel.getInterface("vrp_musicbox", "vrp_musicbox")

MBD, PlayerList, playText = nil, nil, nil

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

    local scale = (1 / dist) * s
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 150)
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

function distance(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance = GetDistanceBetweenCoords(lCoords, object, true)
    return distance
end

function vrp_musicboxC.show()
    SendNUIMessage(
        {
            type = "show"
        }
    )
    --print("show")
end

function vrp_musicboxC.hide()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    --print("hide")
end

function vrp_musicboxC.newBox(id, data)
    SendNUIMessage(
        {
            type = "newBox",
            playerId = id
        }
    )
    --print("newBox", id)
end

function vrp_musicboxC.delBox(id)
    SendNUIMessage(
        {
            type = "delBox",
            playerId = id
        }
    )
    --print("delBox", id)
end

function vrp_musicboxC.setDistVolume(id, volume)
    SendNUIMessage(
        {
            type = "volume",
            playerId = id,
            volume = volume
        }
    )
    --print("setDistVolume", id, volume)
end

function vrp_musicboxC.playMusic(id, data)
    PlayerList[id] = data
    SendNUIMessage(
        {
            type = "playSound",
            videoId = data.videoId,
            playerId = id,
            startTime = data.playTime
        }
    )
    --print("playMusic", id)
end

function vrp_musicboxC.stopMusic(id, data)
    PlayerList[id] = data
    SendNUIMessage(
        {
            type = "stopSound",
            playerId = id
        }
    )
    --print("stopMusic", id)
end

function vrp_musicboxC.setVolume(id, volume)
    PlayerList[id].volume = volume
    SendNUIMessage(
        {
            type = "volume",
            playerId = id,
            volume = volume
        }
    )
end

function vrp_musicboxC.updateBoxCoords(id, coords)
    if id and PlayerList[id] ~= nil then
        PlayerList[id].coords = coords
    end
end

function vrp_musicboxC.updatePlayTime(id, time)
    if id and PlayerList[id] ~= nil then
        PlayerList[id].playTime = time
    end
end

function vrp_musicboxC.updatePlayerList(data)
    if PlayerList == nil then
        PlayerList = {}
    end
    if data == nil then
        data = {}
    end
    for k, v in pairs(PlayerList) do
        v.updated = false
    end
    for k, v in pairs(data) do
        if PlayerList[k] == nil then
            PlayerList[k] = {}
        end
        PlayerList[k].user_id = v.user_id
        PlayerList[k].serverStatus = v.serverStatus
        PlayerList[k].playTime = v.playTime
        PlayerList[k].volume = v.volume
        PlayerList[k].range = v.range
        PlayerList[k].videoId = v.videoId
        PlayerList[k].coords = v.coords
        PlayerList[k].updated = true
    end
    for k, v in pairs(PlayerList) do
        if not v.updated then
            PlayerList[k] = nil
        end
    end
end

function deleteBox()
    if MBD.objHash ~= nil then
        SetEntityAsMissionEntity(MBD.objHash)
        DetachEntity(MBD.objHash, true, true)
        DeleteObject(MBD.objHash)
        MBD.objHash = nil
        MBD.objCoords = nil
        MBD.status = 0
    end
end

RegisterCommand(
    "musicbox",
    function(source, args)
        local playerPed = PlayerPedId(-1)
        local cmd = tostring(args[1])
        if cmd == "get" then
            vrp_musicboxS.checkPerm(
                {},
                function(valid)
                    if valid then
                        local playerCoords = GetEntityCoords(playerPed)
                        MBD.objHash = CreateObject(RWO, MBD.propHash, playerCoords.x + 0.5, playerCoords.y + 0.5, playerCoords.z + -1.0, true, true, true)
                        PlaceObjectOnGroundProperly(MBD.objHash)
                        SetEntityAsNoLongerNeeded(MBD.objHash)
                        SetModelAsNoLongerNeeded(MBD.propHash)
                        SetEntityAsMissionEntity(MBD.objHash, true, true)
                        if NetworkGetEntityIsNetworked(MBD.objHash) then
                            MBD.objNetId = ObjToNet(MBD.objHash)
                            vrp_musicboxS.newBox({MBD.objNetId, MBD.volume})
                        end
                    end
                end
            )
        elseif cmd == "play" then
            vrp_musicboxS.checkPerm(
                {},
                function(valid)
                    if valid then
                        MBD.videoId = tostring(args[2])
                        if MBD.isMoving then
                            if MBD.videoId ~= nil then
                                vrp_musicboxS.stop({MBD.objNetId})
                                notify("재생 준비중..", "warning")
                                Wait(1000)
                                vrp_musicboxS.play({MBD.objNetId, MBD.videoId})
                                notify("재생 시작.")
                            end
                        else
                            notify("재생할 뮤직박스가 없습니다.", "error")
                        end
                    end
                end
            )
        elseif cmd == "stop" then
            vrp_musicboxS.checkPerm(
                {},
                function(valid)
                    if valid then
                        if MBD.isMoving then
                            vrp_musicboxS.stop({MBD.objNetId})
                            notify("재생 중단 되었습니다.", "warning")
                        end
                    end
                end
            )
        elseif cmd == "del" then
            vrp_musicboxS.checkPerm(
                {},
                function(valid)
                    if valid then
                        if MBD.isMoving then
                            vrp_musicboxS.stop({MBD.objNetId})
                            notify("재생이 중단 되었습니다.", "warning")
                            deleteBox()
                            vrp_musicboxS.delBox({MBD.objNetId})
                            notify("뮤직박스가 삭제 되었습니다.", "warning")
                        end
                    end
                end
            )
        elseif cmd == "show" then
            vrp_musicboxC.show()
        elseif cmd == "hide" then
            vrp_musicboxC.hide()
        end
    end
)

RegisterNUICallback(
    "showYoutubeList",
    function(data, cb)
        SetNuiFocus(true, true)
    end
)
RegisterNUICallback(
    "hideYoutubeList",
    function(data, cb)
        SetNuiFocus(false, false)
    end
)
RegisterNUICallback(
    "selectVideo",
    function(data, cb)
        MBD.videoId = tostring(data.id)
        if MBD.isMoving then
            if MBD.videoId ~= nil then
                vrp_musicboxS.stop({MBD.objNetId})
                notify("재생 준비중..", "warning")
                Wait(1000)
                vrp_musicboxS.play({MBD.objNetId, MBD.videoId})
                notify("재생 시작.")
            end
        else
            notify("재생할 뮤직박스가 없습니다.", "error")
        end
    end
)
RegisterNUICallback(
    "stopPlay",
    function(data, cb)
        vrp_musicboxS.stop({MBD.objNetId})
        notify("재생이 중단 되었습니다.", "warning")
    end
)

RegisterNUICallback(
    "state",
    function(data, cb)
        if data then
            PlayerList[data.id].status = data.data
        end
        cb("playing")
    end
)

RegisterNUICallback(
    "error",
    function(data, cb)
        if MBD.isMoving then
            notify("해당ID는 재생할 수 없습니다.", "error")
        end
        cb("error")
    end
)

RegisterNUICallback(
    "setPlayTime",
    function(data, cb)
        if data then
            vrp_musicboxS.updatePlayTime({data.id, data.currentTime})
        end
        cb("setPlayTime")
    end
)

Citizen.CreateThread(
    function()
        SetNuiFocus(false, false)
        MBD = {volume = Config.defaultVolume, range = 0, status = 0, propHash = GetHashKey("prop_boombox_01"), isMoving = false}
        PlayerList = {}
        playText = ""
        while true do
            Citizen.Wait(500)
            playText = "🎵 음악 재생중"
            Citizen.Wait(500)
            playText = "🎵 음악 재생중."
            Citizen.Wait(500)
            playText = "🎵 음악 재생중.."
            Citizen.Wait(500)
            playText = "🎵 음악 재생중..."
        end
    end
)

local hideList = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(30000)
            hideList = {}
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed)
            if MBD.isMoving then
                DrawMarker(1, playerCoords.x, playerCoords.y, playerCoords.z - 1.5, 0, 0, 0, 0, 0, 0, MBD.range * 2.01, MBD.range * 2.01, 1.5, 255, 255, 0, MBD.volume * 2, 0, 0, 2, 0, 0, 0, 0)
            end
            for k, v in pairs(PlayerList) do
                if v.status == 1 and v.clientStatus == 1 and v.serverStatus == 1 then
                    text = playText
                else
                    text = "🎵"
                end
                if hideList[k] == nil then
                    local objHash = NetToObj(k)
                    if objHash == 0 then
                        hideList[k] = true
                    else
                        local targetPed = GetEntityAttachedTo(objHash)
                        if targetPed > 0 then
                            local targetCoords = GetEntityCoords(targetPed)
                            if targetCoords ~= nil then
                                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.5, text, 255, 255, 0, 255, 2.1, false)
                            end
                        else
                            local targetCoords = GetEntityCoords(objHash)
                            if targetCoords ~= nil then
                                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 0.5, text, 255, 255, 0, 255, 2.1, false)
                                DrawMarker(1, targetCoords.x, targetCoords.y, targetCoords.z - 0.5, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 2.5, 255, 255, 0, 20, 0, 0, 2, 0, 0, 0, 0)
                            end
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed)
            if MBD.isMoving and (not IsEntityAttached(MBD.objHash) or not DoesEntityExist(MBD.objHash)) then
                MBD.isMoving = false
                deleteBox()
            end
            if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(playerPed, false) then
                if MBD.isMoving then
                    if MBD.objHash and IsEntityAttached(MBD.objHash) and DoesEntityExist(MBD.objHash) then
                        MBD.isMoving = false
                        DetachEntity(MBD.objHash, true, true)
                        Citizen.Wait(1000)
                        local coords = GetEntityCoords(MBD.objHash)
                        if coords ~= nil then
                            vrp_musicboxS.updateBoxCoords({MBD.objNetId, coords})
                        end
                    end
                else
                    MBD.objHash = GetClosestObjectOfType(playerCoords, 1.2, MBD.propHash, false, false, false)
                    if MBD.objHash and NetworkGetEntityIsNetworked(MBD.objHash) then
                        MBD.objNetId = ObjToNet(MBD.objHash)
                        if MBD.objNetId then
                            NetworkRequestControlOfEntity(MBD.objHash)

                            local timeout = 2000
                            while timeout > 0 and not NetworkHasControlOfEntity(MBD.objHash) do
                                Wait(100)
                                timeout = timeout - 100
                            end

                            SetEntityAsMissionEntity(MBD.objHash, true, true)

                            local timeout = 2000
                            while timeout > 0 and not IsEntityAMissionEntity(MBD.objHash) do
                                Wait(100)
                                timeout = timeout - 100
                            end

                            if PlayerId() == NetworkGetEntityOwner(MBD.objHash) then
                                vrp_musicboxS.pickup(
                                    {MBD.objNetId},
                                    function(data)
                                        if data then
                                            MBD.volume = data.volume
                                            MBD.range = data.range
                                            Citizen.Wait(500)
                                            DetachEntity(MBD.objHash, true, true)
                                            AttachEntityToEntity(MBD.objHash, playerPed, GetEntityBoneIndexByName(playerPed, "IK_R_Hand"), 0.25, 0.0, 0.0, -90.1, -20.1, 80.1, false, false, true, false, 0, true)
                                            MBD.isMoving = true
                                        end
                                    end
                                )
                            end
                        end
                    end
                end
            elseif MBD.isMoving and IsControlJustReleased(0, 172) then
                vrp_musicboxS.volumeUp(
                    {MBD.objNetId},
                    function(data)
                        if data ~= false then
                            MBD.volume = data[1]
                            MBD.range = data[2]
                        end
                    end
                )
            elseif MBD.isMoving and IsControlJustReleased(0, 173) then
                vrp_musicboxS.volumeDown(
                    {MBD.objNetId},
                    function(data)
                        if data ~= false then
                            MBD.volume = data[1]
                            MBD.range = data[2]
                        end
                    end
                )
            elseif MBD.isMoving and IsControlJustReleased(0, 174) then
                vrp_musicboxS.rangeDown(
                    {MBD.objNetId},
                    function(data)
                        if data ~= false then
                            MBD.volume = data[1]
                            MBD.range = data[2]
                        end
                    end
                )
            elseif MBD.isMoving and IsControlJustReleased(0, 175) then
                vrp_musicboxS.rangeUp(
                    {MBD.objNetId},
                    function(data)
                        if data ~= false then
                            MBD.volume = data[1]
                            MBD.range = data[2]
                        end
                    end
                )
            elseif MBD.isMoving and IsControlJustReleased(0, 20) then
                vrp_musicboxC.show()
            end

            if MBD.isMoving then
                DisableControlAction(0, 23, true)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k, v in pairs(PlayerList) do
                local distance = Vdist(coords, v.coords, true)
                if distance < 0 or distance > v.range or v.coords == nil then
                    if v.clientStatus == 1 then
                        print("stopMusicFunction")
                        v.clientStatus = 0
                        vrp_musicboxC.stopMusic(k, v)
                    end
                else
                    local per = (v.range - distance) / v.range * 100
                    local volume = parseInt(v.volume / 100 * per)
                    vrp_musicboxC.setDistVolume(k, volume)
                    if v.serverStatus == 1 and v.clientStatus ~= 1 then
                        print("playMusicFunction")
                        v.clientStatus = 1
                        vrp_musicboxC.playMusic(k, v)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if MBD.isMoving then
                local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                vrp_musicboxS.updateBoxCoords({MBD.objNetId, playerCoords})
            end
        end
    end
)
