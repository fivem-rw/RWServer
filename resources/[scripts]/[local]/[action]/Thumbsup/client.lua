Citizen.CreateThread(
    function()
        local dict = "anim@mp_player_intincarthumbs_upbodhi@ps@"

        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
        local thumbsup = false
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(1, 47) then
                if not thumbsup then
                    TaskPlayAnim(GetPlayerPed(-1), dict, "enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                    thumbsup = true
                end
            elseif IsControlJustReleased(0, 47) then
                thumbsup = false
                ClearPedSecondaryTask(GetPlayerPed(-1))
            end
        end
    end
)
