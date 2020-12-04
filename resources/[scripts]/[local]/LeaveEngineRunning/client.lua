keepDoorOpen = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = GetPlayerPed(-1)
            local veh = GetVehiclePedIsIn(ped, false)

            if IsPedInAnyVehicle(ped, false) and IsControlPressed(0, 75) and not IsEntityDead(ped) then
                if GetIsVehicleEngineRunning(veh) then
                    Citizen.Wait(150)
                    SetVehicleEngineOn(veh, true, true, false)
                end
                if keepDoorOpen then
                    TaskLeaveVehicle(ped, veh, 256)
                else
                    TaskLeaveVehicle(ped, veh, 0)
                end
            end
        end
    end
)
