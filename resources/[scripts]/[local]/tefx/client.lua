local config = {}
config.intensity = 12.0
config.timeUntilReload = 30.0

local holdingfthrow = false
local usingfthrow = false
local fthrowModel = "prop_minigun_01"
local animDict = "weapons@heavy@minigun"
local animName = "idle_2_aim_right_med"
local particleDict = "core"
local actionTime = 30
local fthrow_net = nil
local state = 0

RegisterNetEvent("tefx:start")
AddEventHandler(
    "tefx:start",
    function(scale, zoffset, particleName, type)
        local ped = GetPlayerPed(-1)
        if NetworkGetEntityIsNetworked(ped) then
            fthrow_net = PedToNet(ped)
            if not type then
                type = 1
            end
            if fthrow_net then
                TriggerServerEvent("fthrow:SyncStartParticles", fthrow_net, scale, zoffset, particleName, type)
            end
        end
    end
)

RegisterNetEvent("tefx:end")
AddEventHandler(
    "tefx:end",
    function()
        TriggerServerEvent("fthrow:SyncStopParticles", fthrow_net)
    end
)

RegisterNetEvent("fthrow:StartParticles")
AddEventHandler(
    "fthrow:StartParticles",
    function(fthrowid, scale, zoffset, particleName, type)
        local entity = NetToObj(fthrowid)
        RemoveParticleFxFromEntity(entity)

        RequestNamedPtfxAsset(particleDict)
        while not HasNamedPtfxAssetLoaded(particleDict) do
            Citizen.Wait(100)
        end

        local rot = {
            x = 0.0,
            y = 0.0,
            z = 0.0
        }

        type = tonumber(type)

        if type == 1 then
        elseif type == 2 then
            rot.x = 180.0
        elseif type == 3 then
            rot.x = -90.0
            rot.y = 0.0
        elseif type == 4 then
            rot.x = 90.0
        end

        UseParticleFxAssetNextCall(particleDict)
        StartParticleFxLoopedOnEntity(particleName, entity, 0.0, 0.0, zoffset, rot.x, rot.y, rot.z, scale, false, false, false)
    end
)

RegisterNetEvent("fthrow:StopParticles")
AddEventHandler(
    "fthrow:StopParticles",
    function(fthrowid)
        local entity = NetToObj(fthrowid)
        RemoveParticleFxFromEntity(entity)
    end
)
