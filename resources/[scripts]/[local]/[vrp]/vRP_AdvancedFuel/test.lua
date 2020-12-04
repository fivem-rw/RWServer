function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.6 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(0, 255, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function DrawText3D2(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.6 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 0, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = 217.01892089844
                local y = -901.14886474609
                local z = 30.699987411499
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D(x, y, z + 0.35, "구 인 구 직")
                    DrawText3D(x, y, z + 0.2, "직업을 선택하세요!")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = -2225.587890625
                local y = 267.55401611328
                local z = 174.60163879395
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D(x, y, z + 0.35, "[뉴비복장을 갈아입지 않으면 벌금]")
                    DrawText3D(x, y, z + 0.2, "체크 무늬 및 투명은 금지 입니다")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = -2227.0815429688
                local y = 273.07113647461
                local z = 174.60162353516
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D(x, y, z + 0.35, "[뉴비복장을 갈아입지 않으면 벌금]")
                    DrawText3D(x, y, z + 0.2, "체크 무늬 및 투명은 금지 입니다")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = -2241.0173339844
                local y = 291.20724487305
                local z = 174.60166931152
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D(x, y, z + 0.35, "원할한 게임 진행을 위해 서버규칙 및 시민직 안내는 디스코드를 통해 필독해주세요!")
                    DrawText3D(x, y, z + 0.2, "영상 녹화  미녹화 시 배드rp 논알피 신고가 불가능합니다. 영상녹화를 해주세요")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = 222.62
                local y = -903.1
                local z = 30.7
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D(x, y, z + 0.35, "주민등록증 발급")
                    DrawText3D(x, y, z + 0.2, "리얼월드의 시민이 되신것을 환영합니다!")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = 220.72537231445
                local y = -890.51495361328
                local z = 30.69997215271
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D2(x, y, z + 0.35, "A T M")
                    DrawText3D2(x, y, z + 0.2, "입금 / 출금이 가능합니다!")
                end
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for i = 1, #objectlist do
                local x = 228.22999572754
                local y = -906.48718261719
                local z = 30.699991226196
                local objectCoords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
                    DrawText3D2(x, y, z + 0.35, "자 판 기")
                    DrawText3D2(x, y, z + 0.2, "음식 구입이 가능합니다!")
                end
            end
            Citizen.Wait(0)
        end
    end
)

objectlist = {
    [1] = "prop_bench_01a",
    [2] = "prop_bench_01b",
    [3] = "prop_bench_01c",
    [4] = "prop_bench_02",
    [5] = "prop_bench_03",
    [6] = "prop_bench_04",
    [7] = "prop_bench_05",
    [8] = "prop_bench_06",
    [9] = "prop_bench_05",
    [10] = "prop_bench_08",
    [11] = "prop_bench_09",
    [12] = "prop_bench_10",
    [13] = "prop_bench_11"
}
