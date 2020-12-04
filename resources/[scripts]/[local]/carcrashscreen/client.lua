local status = nil
local InAction = true
local isRendering = false
local isActive = false

AddEventHandler(
    "playerSpawned",
    function()
        isActive = true
    end
)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieFunctionParameterString("~r~WASTED")
    PushScaleformMovieFunctionParameterString("")
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function startScaleform()
    isRendering = true
end

function stopScaleform()
    isRendering = false
end

function renderScaleform(scaleform)
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
end

Citizen.CreateThread(
    function()
        local initalizedScaleform = Initialize("mp_big_message_freemode")
        while true do
            if isRendering then
                renderScaleform(initalizedScaleform)
            end
            Citizen.Wait(1)
        end
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(1)
        isActive = true
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isActive then
                Citizen.Wait(1000)
                local ped = GetPlayerPed(-1)
                SendNUIMessage(
                    {
                        show = IsPauseMenuActive(),
                        health = 100,
                        armor = 100,
                        stamina = 100,
                        st = status,
                        getvehicle = IsPedInAnyVehicle(ped),
                        carhealth = GetVehicleEngineHealth(GetVehiclePedIsIn(ped), false)
                    }
                )
            end
        end
    end
)
