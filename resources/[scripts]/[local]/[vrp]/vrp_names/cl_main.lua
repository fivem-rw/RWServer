---------------------------------------------------------
-------------- VRP Names, RealWorld MAC -----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vRP = Proxy.getInterface("vRP")
vrp_namesC = {}
Tunnel.bindInterface("vrp_names", vrp_namesC)
Proxy.addInterface("vrp_names", vrp_namesC)
vrp_namesS = Tunnel.getInterface("vrp_names", "vrp_names")

DrawList = {}
UserList = {}
newbieUserIdGap = 500
newbieStartUserId = nil
visibleMode = 0
local isShowUI = false
local isShowUIRest = false

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

function loadAllIcons()
    for i, v in pairs(custom_icons) do
        local txd = CreateRuntimeTxd(v[1])
        CreateRuntimeTextureFromImage(txd, v[2], "icons/" .. v[2] .. ".png")
    end
end

function getCustomIconInfo(id)
    local selectInfo = nil
    for _, v in pairs(custom_icons) do
        if v[1] == id then
            selectInfo = v
            break
        end
    end
    return selectInfo
end

local isShowName = false

function vrp_namesC.push(users, lastUserId, showName)
    UserList = {}
    if lastUserId then
        newbieStartUserId = lastUserId - newbieUserIdGap
        if newbieStartUserId < 1 then
            newbieStartUserId = 1
        end
    end
    for k, v in pairs(users) do
        v.serverId = GetPlayerFromServerId(v.playerId)
        UserList[k] = v
    end
    isShowName = showName
end

Citizen.CreateThread(
    function()
        loadAllIcons()
        while true do
            Citizen.Wait(500)
            DrawList = {}
            local PlayerPed = GetPlayerPed(-1)
            local PlayerCoords = GetEntityCoords(PlayerPed)
            for k, v in pairs(UserList) do
                local ped = GetPlayerPed(v.serverId)
                local pedCoords = GetEntityCoords(ped)
                local distance = math.floor(GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, pedCoords.x, pedCoords.y, pedCoords.z, true))
                if distance < 30 and v.visibleMode ~= 2 and v.serverId > 0 and IsEntityVisible(ped) and GetEntityAlpha(ped) > 60 then
                    local isInVehicle = IsPedInAnyVehicle(ped, false)
                    if not isInVehicle or (isInVehicle and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped) then
                        local addZ = 0
                        local icon = ""
                        local text = "~g~" .. v.user_id
                        if newbieStartUserId ~= nil and v.user_id >= newbieStartUserId then
                            icon = icon .. icons["newbie"]
                        end
                        if v.jobType and icons[v.jobType] then
                            icon = icon .. icons[v.jobType]
                        else
                            icon = icon .. icons["person"]
                        end         
                        if NetworkIsPlayerTalking(v.serverId) then
                            text = text .. "~b~ | " .. removeEmoji(v.nickname)
                        else
                            text = text .. "~w~ | " .. removeEmoji(v.nickname)
                        end
                        if isInVehicle then
                            addZ = 0.22
                        end
                        if isShowName then
                            DrawList[k] = {
                                ped = ped,
                                data = {
                                    [1] = {0.0, 0.0, 1.22 + addZ, icon, 0, 0, 0, 255, 1.2, false},
                                    [2] = {0.0, 0.0, 1.11 + addZ, text, 0, 0, 0, 255, 1.5, false}
                                },
                                customData = {}
                            }
                        else
                            DrawList[k] = {
                                ped = ped,
                                data = {
                                    [1] = {0.0, 0.0, 1.11 + addZ, icon, 0, 0, 0, 255, 1.2, false}
                                },
                                customData = {}
                            }
                        end
                        if v.visibleMode == 0 and distance < 10 then
                            if v.nameIcon ~= nil then
                                local ci = getCustomIconInfo(v.nameIcon)
                                if ci ~= nil then
                                    table.insert(DrawList[k].customData, {ci[1], ci[2], ci[3], ci[4], ci[5] + addZ, ci[6], ci[7], ci[8], ci[9], ci[10], ci[11], ci[12]})
                                end
                            elseif v.userTitleInfo ~= nil and v.userTitleInfo.group ~= nil then
                                local ci = getCustomIconInfo(v.userTitleInfo.group)
                                if ci ~= nil then
                                    table.insert(DrawList[k].customData, {ci[1], ci[2], ci[3], ci[4], ci[5] + addZ, ci[6], ci[7], ci[8], ci[9], ci[10], ci[11], ci[12]})
                                end
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
            if isShowUI then
                if IsControlJustPressed(0, 249) and IsControlPressed(0, 21) then
                    vrp_namesS.changeVisibleMode(
                        {},
                        function(mode)
                            visibleMode = mode
                        end
                    )
                end
                for k, v in pairs(DrawList) do
                    local pos = GetEntityCoords(v.ped)
                    for _, d in pairs(v.data) do
                        DrawText3D(pos.x + d[1], pos.y + d[2], pos.z + d[3], d[4], d[5], d[6], d[7], d[8], d[9], d[10])
                    end
                    for _, d in pairs(v.customData) do
                        DrawImage3D(d[1], d[2], pos.x + d[3], pos.y + d[4], pos.z + d[5], d[6], d[7], d[8], d[9], d[10], d[11], d[12])
                    end
                end
            end
        end
    end
)

function DrawText3D(x, y, z, text, r, g, b, a, s)
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
    end
end

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)

    if onScreen then
        local width = (1 / dist) * width
        local height = (1 / dist) * height
        local fov = (1 / GetGameplayCamFov()) * 100
        local width = width * fov
        local height = height * fov

        local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
        if (object == 0) or (object == nil) then
            DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
        end
    end
end

RegisterNetEvent("vrp_names_ex:changeShowUI")
AddEventHandler(
    "vrp_names_ex:changeShowUI",
    function(isShow)
        if not isShowUIRest then
            isShowUI = isShow
        end
    end
)

RegisterNetEvent("vrp_names_ex:changeShowUIRest")
AddEventHandler(
    "vrp_names_ex:changeShowUIRest",
    function(isRest)
        isShowUIRest = isRest
    end
)
