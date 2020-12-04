POS_actual = 1
PED_hasBeenTeleported = false

function DrawText3D(x, y, z, text, size, color)
    if size == nil then
        size = 2
    end
    if color == nil then
        color = {
            255,
            255,
            255,
            255
        }
    end
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * size
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.6 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(color[1], color[2], color[3], color[4])
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

function teleport(pos)
    Citizen.CreateThread(
        function()
            local ped = GetPlayerPed(-1)
            PED_hasBeenTeleported = true
            NetworkFadeOutEntity(ped, true, false)
            Citizen.Wait(500)

            SetEntityCoords(ped, pos.coords.x, pos.coords.y, pos.coords.z, 1, 0, 0, 1)
            SetEntityHeading(ped, pos.h)
            NetworkFadeInEntity(ped, 0)

            Citizen.Wait(500)

            PED_hasBeenTeleported = false

            ClearPedTasksImmediately(ped)

            if pos.freeze == true then
                FreezeEntityPosition(ped, true)
                Citizen.Wait(2000)
                FreezeEntityPosition(ped, false)
            end
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped, true)

            for i, v in pairs(INTERIORS) do
                --DrawMarker(25, v.coords.x, v.coords.y, v.coords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 0.2, 255, 255, 255, 100, 0, 0, 0, 0)
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 0.2, 255, 255, 255, 100, 0, 0, 0, 0)

                local dist = Vdist(coords.x, coords.y, coords.z, v.coords.x, v.coords.y, v.coords.z)
                if (dist <= 0.8) and (not PED_hasBeenTeleported) then
                    POS_actual = v.id
                    if not gui_interiors.opened then
                        gui_interiors_OpenMenu()
                    end
                end
                if dist >= 0.8 and dist <= 20 then
                    if v.text ~= nil and v.text ~= "" then
                        if v.text_size == nil then
                            v.text_size = 2.5
                        end
                        if v.text_color == nil then
                            v.text_color = {255, 255, 255, 255}
                        end
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z + 0.5, v.text, v.text_size, v.text_color)
                        if v.sub_text ~= nil and v.sub_text ~= "" then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z + 0.3, v.sub_text, v.text_size * 0.7, {255, 255, 255, 255})
                        end
                    end
                end
            end
        end
    end
)
