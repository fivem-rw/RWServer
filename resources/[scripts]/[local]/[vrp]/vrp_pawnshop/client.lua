---------------------------------------------------------
-------------- VRP Pawnshop, RealWorld MAC --------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local blip_data = {
    id = 50,
    color = 4
}

local isOpened = false

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

function DrawText3D2(x, y, z, text, r, g, b, a, s, bg)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    if not s then
        s = 2.5
    end

    local scale = (1 / dist) * s
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropShadow(0, 0, 0, 0, 150)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropShadow()
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

RegisterNetEvent("pawnshop:add")
AddEventHandler(
    "pawnshop:add",
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

RegisterNetEvent("pawnshop:close")
AddEventHandler(
    "pawnshop:close",
    function()
        isOpened = false
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
                    local dist = #(vector3(pos.x, pos.y, pos.z) - vector3(coords[1], coords[2], coords[3]))
                    if not isOpened and dist < 30.0 then
                        if dist > 1.5 then
                            DrawText3D("~b~" .. location.name, coords[1], coords[2], coords[3] + 1.0, 0.8)
                            DrawText3D("~w~" .. location.sub_name, coords[1], coords[2], coords[3] + 0.75, 0.6)
                        else
                            DrawText3D("~y~[E]~w~키를 눌러주세요.", coords[1], coords[2], coords[3] + 1.0, 0.5)
                            if IsControlJustReleased(0, 38) and not IsPedInVehicle(ped, veh, true) then
                                TriggerServerEvent("pawnshop:open", location.id or id)
                            end
                        end
                        DrawMarker(1, coords[1], coords[2], coords[3] - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.2, 255, 255, 255, 100)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        dealerAnimDict = "mini@strip_club@idles@bouncer@base"
        RequestAnimDict(dealerAnimDict)
        while not HasAnimDictLoaded(dealerAnimDict) do
            RequestAnimDict(dealerAnimDict)
            Wait(0)
        end
        for _, v in pairs(coordonate) do
            local modelHash = GetHashKey(v[7])
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                RequestModel(modelHash)
                Wait(0)
            end
            local dealerEntity = CreatePed(RWP, 26, modelHash, v[1], v[2], v[3], v[6], false, true)
            SetModelAsNoLongerNeeded(modelHash)
            SetEntityCanBeDamaged(dealerEntity, 0)
            SetPedAsEnemy(dealerEntity, 0)
            SetBlockingOfNonTemporaryEvents(dealerEntity, 1)
            SetPedResetFlag(dealerEntity, 249, 1)
            SetPedConfigFlag(dealerEntity, 185, true)
            SetPedConfigFlag(dealerEntity, 108, true)
            SetPedCanEvasiveDive(dealerEntity, 0)
            SetPedCanRagdollFromPlayerImpact(dealerEntity, 0)
            SetPedConfigFlag(dealerEntity, 208, true)
            SetEntityCoordsNoOffset(dealerEntity, v[1], v[2], v[3], 0, 0, 1)
            SetEntityHeading(dealerEntity, v[6])
            SetEntityInvincible(dealerEntity, v[9])

            if v[11] then
                GiveWeaponToPed(dealerEntity, v[11], math.random(20, 100), false, true)
                SetCurrentPedWeapon(dealerEntity, v[11], true)
                if v[12] then
                    SetBlockingOfNonTemporaryEvents(dealerEntity, 0)
                    SetPedCombatAbility(dealerEntity, 100)
                    SetPedAsEnemy(dealerEntity, 1)
                end
            else
                TaskPlayAnim(dealerEntity, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            end

            Citizen.Wait(1000)
            FreezeEntityPosition(dealerEntity, v[8])
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            local pos = GetEntityCoords(GetPlayerPed(-1), true)
            Citizen.Wait(0)
            for _, v in pairs(coordonate) do
                x = v[1]
                y = v[2]
                z = v[3]
                if (Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0) then
                    DrawText3D2(x, y, z + 1.15, v[4], 0, 255, 0, 150, 2.0)
                    DrawText3D2(x, y, z + 1.00, v[5], 255, 255, 255, 150, 1.5)
                end
            end
        end
    end
)
