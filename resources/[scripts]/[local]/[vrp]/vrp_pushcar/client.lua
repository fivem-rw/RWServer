vRP = Proxy.getInterface("vRP")

Config = {}
Config.DamageNeeded = 1000.0
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end

        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)

            local next = true
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end

local function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function GetVehicles()
    local vehicles = {}

    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end

    return vehicles
end

local function GetClosestVehicle()
    local closestDistance = -1
    local closestVehicle = -1
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)
    local vehicles = GetVehicles()

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
Citizen.CreateThread(
    function()
        Citizen.Wait(200)
        while true do
            local ped = GetPlayerPed(-1)
            local closestVehicle, Distance = GetClosestVehicle()
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
            if Distance < 3.0 and not IsPedInAnyVehicle(ped, false) then
                Vehicle.Coords = vehicleCoords
                Vehicle.Dimensions = dimension
                Vehicle.Vehicle = closestVehicle
                Vehicle.Distance = Distance
                if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                    Vehicle.IsInFront = false
                else
                    Vehicle.IsInFront = true
                end
            else
                Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
            end
            Citizen.Wait(500)
        end
    end
)

local function DrawText3D(coords, text, size)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords = GetGameplayCamCoords()
    local dist = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
    local size = size

    if size == nil then
        size = 1
    end

    local scale = (size / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)

        AddTextComponentString(text)
        DrawText(x, y)
    end
end

isComa = false
isDie = false

Citizen.CreateThread(
    function()
        while true do
            isComa = vRP.isInComa({})
            isDie = vRP.isInDie({})
            Citizen.Wait(500)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            if Vehicle.Vehicle ~= nil and not isComa and not isDie then
                if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and IsControlJustPressed(0, Keys["E"]) and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                    NetworkRequestControlOfEntity(Vehicle.Vehicle)
                    local coords = GetEntityCoords(ped)
                    if Vehicle.IsInFront then
                        AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                    else
                        AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                    end

                    if not HasAnimDictLoaded("missfinale_c2ig_11") then
                        RequestAnimDict("missfinale_c2ig_11")

                        while not HasAnimDictLoaded("missfinale_c2ig_11") do
                            Citizen.Wait(1)
                        end
                    end
                    TaskPlayAnim(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                    Citizen.Wait(200)

                    local currentVehicle = Vehicle.Vehicle
                    while true do
                        Citizen.Wait(5)
                        if IsDisabledControlPressed(0, Keys["A"]) then
                            TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
                        end

                        if IsDisabledControlPressed(0, Keys["D"]) then
                            TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
                        end

                        if Vehicle.IsInFront then
                            SetVehicleForwardSpeed(currentVehicle, -1.0)
                        else
                            SetVehicleForwardSpeed(currentVehicle, 1.0)
                        end

                        if HasEntityCollidedWithAnything(currentVehicle) then
                            SetVehicleOnGroundProperly(currentVehicle)
                        end

                        if not IsDisabledControlPressed(0, Keys["E"]) then
                            DetachEntity(ped, false, false)
                            StopAnimTask(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0)
                            FreezeEntityPosition(ped, false)
                            break
                        end
                    end
                end
            end
        end
    end
)
