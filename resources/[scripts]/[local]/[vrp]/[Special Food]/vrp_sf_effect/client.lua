icons = {
    {"diving", "diving", "diving"},
    {"hp", "hp", "hp"},
    {"hungry", "hungry", "hungry"},
    {"Jump", "Jump", "Jump"},
    {"speed", "speed", "speed"},
    {"Thirsty", "Thirsty", "Thirsty"}
}

function loadAllIcons()
    for i, v in pairs(icons) do
        local txd = CreateRuntimeTxd(v[1])
        CreateRuntimeTextureFromImage(txd, v[2], "icons/" .. v[3] .. ".png")
    end
end

Citizen.CreateThread(
    function()
        loadAllIcons()
    end
)

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

function drawtxt(text, font, centre, x, y, scale, r, g, b, a)
    y = y - 0.010
    scale = scale / 2
    y = y + 0.002
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(7)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

----- △ 아이콘
----- ▽ 음식 효과

local speed = false
local scuba = false
local jump = false
local hunger = false
local thirst = false
local timp = 0

RegisterNetEvent("bagaefect")
AddEventHandler(
    "bagaefect",
    function(effect, amount, time)
        if effect == "speed" and not speed then
            speed = true
            SetRunSprintMultiplierForPlayer(PlayerId(), amount) -- 1.49
        elseif effect == "scuba" and not scuba then
            SetPedMaxTimeUnderwater(GetPlayerPed(-1), amount) -- 300.0
            scuba = true
        elseif effect == "hunger" and not hunger then
            hunger = true
        elseif effect == "thirst" and not thirst then
            thirst = true
        elseif effect == "jump" and not jump then
            jump = true
        end
        if amount == nil then
            print("nil")
        end
        startCounting()

        if time == 5 then
            timp = 5
        elseif time == 10 then
            timp = 10
        elseif time == 30 then
            timp = 30
        elseif time == 60 then
            timp = 60
        elseif time == nil then
            timp = 10
        end
    end
)

function plm(x, y, width, height, scale, text, r, g, b, a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(50, 50, 50, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    if (outline) then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function playAlpha()
    alpha1 = 255
    alpha2 = 255
    alpha3 = 255
    alpha4 = 255
    alpha5 = 255
    Citizen.CreateThread(
        function()
            while jump do
                Wait(800)
                alpha1 = alpha1 - 1
                if alpha1 <= 10 then
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while scuba do
                Wait(800)
                alpha2 = alpha2 - 1
                if alpha2 <= 10 then
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while speed do
                Wait(800)
                alpha3 = alpha3 - 1
                if alpha3 <= 10 then
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while speed do
                Wait(800)
                alpha5 = alpha5 - 1
                if alpha5 <= 10 then
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while speed do
                Wait(800)
                alpha5 = alpha5 - 1
                if alpha5 <= 10 then
                    break
                end
            end
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if (jump == true) then
                DrawSprite("Jump", "Jump", 0.05, 0.765, 0.024, 0.044, 0.0, 255, 255, 255, alpha1)
                plm(0.0615, 0.7755, 0.024, 0.020, 0.22, z, 255, 255, 255, alpha1, 1, 7, 1)
            end
            if (scuba == true) then
                DrawSprite("diving", "diving", 0.08, 0.765, 0.024, 0.044, 0.0, 255, 255, 255, alpha2)
                plm(0.0915, 0.7755, 0.024, 0.020, 0.22, x, 255, 255, 255, alpha2, 1, 7, 1)
            end
            if (speed == true) then
                DrawSprite("speed", "speed", 0.1085, 0.765, 0.024, 0.044, 0.0, 255, 255, 255, alpha3)
                plm(0.120, 0.7755, 0.024, 0.020, 0.22, n, 255, 255, 255, alpha3, 1, 7, 1)
            end
            if (hunger == true) then
                DrawSprite("hungry", "hungry", 0.137, 0.765, 0.024, 0.044, 0.0, 255, 255, 255, alpha3)
                plm(0.150, 0.7755, 0.024, 0.020, 0.22, hungertime, 255, 255, 255, alpha4, 1, 7, 1)
            end
            if (thirst == true) then
                DrawSprite("Thirsty", "Thirsty", 0.165, 0.765, 0.024, 0.044, 0.0, 255, 255, 255, alpha3)
                plm(0.177, 0.7755, 0.024, 0.020, 0.22, t, 255, 255, 255, alpha5, 1, 7, 1)
            end
        end
    end
)

function startCounting()
    n = 1
    x = 1
    z = 1
    hungertime = 1
    t = 1
    Citizen.CreateThread(
        function()
            while speed do
                Wait(1000)
                n = n + 1
                print("start counting: speed " .. n)
                playAlpha()
                if timp == 5 and n == 300 then
                    speed = false
                    print("stop")
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                    n = 0
                    break
                elseif timp == 10 and n == 600 then
                    speed = false
                    print("stop")
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                    n = 0
                    break
                elseif timp == 30 and n == 1800 then
                    speed = false
                    print("stop")
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                    n = 0
                    break
                elseif timp == 60 and n == 3600 then
                    speed = false
                    print("stop")
                    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                    n = 0
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while scuba do
                Wait(1000)
                x = x + 1
                playAlpha()
                print("start counting: scuba" .. x)
                if timp == 5 and x == 300 then
                    scuba = false
                    SetPedMaxTimeUnderwater(GetPlayerPed(-1), 15.00)
                    print("stop")
                    x = 0
                    break
                elseif timp == 10 and n == 600 then
                    scuba = false
                    SetPedMaxTimeUnderwater(GetPlayerPed(-1), 15.00)
                    print("stop")
                    x = 0
                    break
                elseif timp == 30 and n == 1800 then
                    scuba = false
                    SetPedMaxTimeUnderwater(GetPlayerPed(-1), 15.00)
                    print("stop")
                    x = 0
                    break
                elseif timp == 60 and n == 3600 then
                    scuba = false
                    SetPedMaxTimeUnderwater(GetPlayerPed(-1), 15.00)
                    print("stop")
                    x = 0
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while jump do
                Wait(1000)
                z = z + 1
                playAlpha()
                SetSuperJumpThisFrame(PlayerId())
                if timp == 5 and z == 300 then
                    jump = false
                    z = 0
                    break
                elseif timp == 10 and z == 600 then
                    jump = false
                    z = 0
                    break
                elseif timp == 30 and z == 1800 then
                    jump = false
                    z = 0
                    break
                elseif timp == 60 and z == 3600 then
                    jump = false
                    z = 0
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while hunger do
                Wait(1000)
                hungertime = hungertime + 1
                playAlpha()
                --      SetSuperJumpThisFrame(PlayerId())
                if timp == 5 and hungertime == 300 then
                    hunger = false
                    hungertime = 0
                    break
                elseif timp == 10 and hungertime == 600 then
                    hunger = false
                    hungertime = 0
                    break
                elseif timp == 30 and hungertime == 1800 then
                    hunger = false
                    hungertime = 0
                    break
                elseif timp == 60 and hungertime == 3600 then
                    hunger = false
                    hungertime = 0
                    break
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while thirst do
                Wait(1000)
                t = t + 1
                playAlpha()
                SetSuperJumpThisFrame(PlayerId())
                if timp == 5 and t == 300 then
                    thirst = false
                    t = 0
                    break
                elseif timp == 10 and t == 600 then
                    thirst = false
                    t = 0
                    break
                elseif timp == 30 and t == 1800 then
                    thirst = false
                    t = 0
                    break
                elseif timp == 60 and t == 3600 then
                    thirst = false
                    t = 0
                    break
                end
            end
        end
    )
end
