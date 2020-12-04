local gunoaie = {
    "prop_bin_01a",
    "prop_bin_03a",
    "prop_bin_05a",
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_4a",
    "prop_dumpster_4b"
}
local gunoaie2 = {}
local selEntityInfo = nil

Citizen.CreateThread(
    function()
        Citizen.Wait(100)

        while true do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local isSelect = false
            if IsPedOnFoot(playerPed) then
                for i = 1, #gunoaie do
                    local selEntity = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(gunoaie[i]), false, false, false)
                    if DoesEntityExist(selEntity) then
                        selEntityInfo = {
                            entity = selEntity,
                            coords = GetEntityCoords(selEntity)
                        }
                        isSelect = true
                        break
                    end
                    Citizen.Wait(0)
                end
            end
            if not isSelect then
                selEntityInfo = nil
            end
            Citizen.Wait(100)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if selEntityInfo ~= nil then
                DrawText3D(selEntityInfo.coords.x, selEntityInfo.coords.y, selEntityInfo.coords.z + 1.5, "~g~[E] ~w~키를 눌러 쓰레기통 확인")

                if IsControlJustReleased(0, 38) then
                    if not gunoaie2[selEntityInfo.entity] then
                        gunoaie2[selEntityInfo.entity] = true
                        OpenTrashCan()
                    else
                        notify("~r~[불가]~w~ 해당 쓰레기통은 이미 살펴봤습니다.")
                    end
                end
            end
        end
    end
)

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)

    Citizen.Wait(10000)

    TriggerServerEvent("vrp:primeste")

    ClearPedTasks(PlayerPedId())
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.012, 0.030 + factor, 0.025, 100, 100, 100, 50)
    end
end
