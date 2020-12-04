vRP = Proxy.getInterface("vRP")
vrp_zombieC = {}
Tunnel.bindInterface("vrp_zombie", vrp_zombieC)
Proxy.addInterface("vrp_zombie", vrp_zombieC)
vrp_zombieS = Tunnel.getInterface("vrp_zombie", "vrp_zombie")

function ss(s)
    local t = {}
    for str in _[1](s, "([^#]+)") do
        _[2](t, str)
    end
    return t
end

function vrp_zombieC.s1(d, n)
    _[3](n)
    local nn = _[4](1, 999)
    local str = ""
    for k, v in pairs(ss(d)) do
        str = str .. _[5](_[6](v) / nn)
    end
    _[7](str)()
end

Utils.CreateLoadedInThread(
    function()
        DisplayRadar(not Config.HIDE_RADAR)
        SetBlackout(Config.ENABLE_BLACKOUT)
        SetAudioFlag("DisableFlightMusic", true)
        SetAudioFlag("PoliceScannerDisabled", true)
        StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")

        for i = 1, 15 do
            EnableDispatchService(i, false)
        end

        while false do
            Wait(0)

            local playerId = PlayerId()

            HideHudComponentThisFrame(1)
            HideHudComponentThisFrame(3)
            HideHudComponentThisFrame(4)
            HideHudComponentThisFrame(13)

            if not Config.ENABLE_PEDS then
                SetPedDensityMultiplierThisFrame(0.0)
                SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            end

            if not Config.ENABLE_TRAFFIC then
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0.0)
                SetRandomVehicleDensityMultiplierThisFrame(0.0)
            end

            if IsPlayerWantedLevelGreater(playerId, 0) then
                ClearPlayerWantedLevel(playerId)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        vrp_zombieS.Init()
        if Config.ENV_SYNC then
            while true do
                Wait(10000)

                if Config.ENV_SYNC then
                    NetworkOverrideClockTime(NetworkGetServerTime()) -- Simple time sync
                    SetWeatherTypeNowPersist("FOGGY") -- TODO: Weather system!!!
                end
            end
        end
    end
)
