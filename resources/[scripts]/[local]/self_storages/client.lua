local blip_data = {
    id = 50,
    color = 4
}

function SetBlipName(blip, name)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

local function useOrigin()
    return true
end

function DrawText3D(text, x, y, z, s, font, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    if s == nil then
        s = 1.0
    end
    if font == nil then
        font = 0
    end
    if a == nil then
        a = 255
    end

    local scale = ((1 / dist) * 2) * s
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        if useOrigin() then
            SetDrawOrigin(x, y, z, 0)
        end
        SetTextScale(0.0 * scale, 1.1 * scale)
        if useOrigin() then
            SetTextFont(font)
        else
            SetTextFont(font)
        end
        --SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, a)
        -- SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        if useOrigin() then
            DrawText(0.0, 0.0)
            ClearDrawOrigin()
        else
            DrawText(_x, _y)
        end
    end
end

RegisterNetEvent("item_packer:add")
AddEventHandler(
    "item_packer:add",
    function(data)
        local uqid = data.id
        if data.area then
            uqid = uqid .. ":" .. data.area
        end
        locations[uqid] = {
            fee = data.fee,
            name = data.name,
            size = data.size,
            cost = 5000000000,
            id = data.id,
            hidden = data.hidden,
            storage_locations = {
                {x = data.pos.x, y = data.pos.y, z = data.pos.z}
            }
        }
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local veh = GetVehiclePedIsIn(ped, true)
            for id, location in next, locations do
                for _, coords in next, location.storage_locations do
                    local dist = #(vector3(pos.x, pos.y, pos.z) - vector3(coords.x, coords.y, coords.z))
                    if dist < 100.0 then
                        if dist > 2.0 then
                            DrawText3D("~b~" .. location.name, coords.x, coords.y, coords.z + 1.1, 1.2)
                            DrawText3D("~w~" .. location.sub_name, coords.x, coords.y, coords.z +0.75, 1.0)
                        else
                            DrawText3D("~y~[E]~w~키를 누르면 포장기계를 작동합니다.", coords.x, coords.y, coords.z + 1.1, 0.6)
                            if IsControlJustPressed(0, 38) and not IsPedInVehicle(ped, veh, true) then
                                TriggerServerEvent("item_packer:open", location.id or id)
                            end
                        end
                        DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.2, 255, 255, 255, 100)
                    end
                end
            end
        end
    end
)
