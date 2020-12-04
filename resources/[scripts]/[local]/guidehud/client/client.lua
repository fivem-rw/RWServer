Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
        end
    end
)
RegisterNUICallback(
    "openGuideHud",
    function(data, cb)
        SetNuiFocus(true, true)
    end
)
RegisterNUICallback(
    "closeGuideHud",
    function(data, cb)
        SetNuiFocus(false, false)
    end
)

local Ran = false

AddEventHandler(
    "playerSpawned",
    function()
        if not Ran then
            ShutdownLoadingScreenNui()
            Ran = true
        end
    end
)
