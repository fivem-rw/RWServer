RegisterNetEvent("playradio")
AddEventHandler(
    "playradio",
    function(url)
        SendNUIMessage(
            {
                playradio = true,
                sound = url
            }
        )
    end
)

RegisterNetEvent("changevolume")
AddEventHandler(
    "changevolume",
    function(volume)
        SendNUIMessage(
            {
                changevolume = true,
                volume = tonumber(volume)
            }
        )
    end
)

RegisterNetEvent("stopradio")
AddEventHandler(
    "stopradio",
    function()
        SendNUIMessage(
            {
                stopradio = true
            }
        )
    end
)

POS_actual = 1
PED_hasBeenTeleported = false

function teleport(pos)
    local ped = GetPlayerPed(-1)
    Citizen.CreateThread(
        function()
            PED_hasBeenTeleported = true
            NetworkFadeOutEntity(ped, true, false)
            Citizen.Wait(500)
            SetEntityCoords(ped, pos.x, pos.y, pos.z, 1, 0, 0, 1)
            SetEntityHeading(ped, pos.h)
            NetworkFadeInEntity(ped, 0)
            Citizen.Wait(500)
            PED_hasBeenTeleported = false
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local ped = GetPlayerPed(-1)
            local playerPos = GetEntityCoords(ped, true)

            for i, pos in pairs(INTERIORS) do
                DrawMarker(
                    1,
                    pos.x,
                    pos.y,
                    pos.z - 1,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1.0,
                    1.0,
                    0.5,
                    255,
                    255,
                    255,
                    200,
                    0,
                    0,
                    2,
                    0,
                    0,
                    0,
                    0
                )
                if
                    (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.0) and
                        (not PED_hasBeenTeleported)
                 then
                    POS_actual = pos.id
                    if not gui_interiors.opened then
                        gui_interiors_OpenMenu()
                    end
                end
            end
        end
    end
)

local ch_radioon = function(player, choice)
    TriggerEvent("playradio", "http://218.150.35.59:8000/stream")
end

local ch_radiooff = function(player, choice)
    TriggerEvent("stopradio", p)
end

vRP.registerMenuBuilder(
    {
        "phone",
        function(add) -- phone menu is created on server start, so it has no permissions.
            local choices = {} -- Comment the choices you want to disable by adding -- in front of them.

            choices["라디오 켜기"] = ch_radioon -- transfer money through phone
            choices["라디오 끄기"] = ch_radiooff -- charge money through phone

            add(choices)
        end
    }
)
