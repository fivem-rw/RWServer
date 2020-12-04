vrp_firecrackerC = {}
Tunnel.bindInterface("vrp_firecracker", vrp_firecrackerC)
Proxy.addInterface("vrp_firecracker", vrp_firecrackerC)
vRP = Proxy.getInterface("vRP")
vrp_firecrackerS = Tunnel.getInterface("vrp_firecracker", "vrp_firecracker")

local pos = {0, 0, 0}
local area = {0, 0}
local delay = 0
local isSetOn = false

local asset1 = "proj_indep_firework"
local asset2 = "proj_indep_firework_v2"
local asset3 = "scr_indep_fireworks"

function vrp_firecrackerC.setOn(p, a, v)
    RequestNamedPtfxAsset(asset1)
    while not HasNamedPtfxAssetLoaded(asset1) do
        Citizen.Wait(1)
    end
    RequestNamedPtfxAsset(asset2)
    while not HasNamedPtfxAssetLoaded(asset2) do
        Citizen.Wait(1)
    end
    RequestNamedPtfxAsset(asset3)
    while not HasNamedPtfxAssetLoaded(asset3) do
        Citizen.Wait(1)
    end

    if p then
        pos[1] = p[1]
        pos[2] = p[2]
        pos[3] = p[3]
        isSetOn = true
    end
    if a then
        area = {-a, a}
    end
    if v then
        delay = 1000 - (v * 100)
    end
end

function vrp_firecrackerC.setOff()
    isSetOn = false
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if isSetOn then
                Citizen.Wait(delay)
                UseParticleFxAssetNextCall(asset1)
                local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_air_burst", pos[1] + math.random(area[1], area[2]), pos[2] + math.random(area[1], area[2]), pos[3] + 25 + math.random(100, 150), 0.0, 0.0, 0.0, 2.0, false, false, false, false)

                Citizen.Wait(delay)
                UseParticleFxAssetNextCall(asset2)
                local part = StartParticleFxNonLoopedAtCoord("scr_firework_indep_spiral_burst_rwb", pos[1] + math.random(area[1], area[2]), pos[2] + math.random(area[1], area[2]), pos[3] + 25 + math.random(100, 200), 0.0, 0.0, 0.0, 5.0, false, false, false, false)

                Citizen.Wait(delay)
                UseParticleFxAssetNextCall(asset2)
                local part = StartParticleFxNonLoopedAtCoord("scr_firework_indep_repeat_burst_rwb", pos[1] + math.random(area[1], area[2]), pos[2] + math.random(area[1], area[2]), pos[3] + 25 + math.random(100, 200), 0.0, 0.0, 0.0, 5.0, false, false, false, false)

                Citizen.Wait(delay)
                UseParticleFxAssetNextCall(asset3)
                local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_starburst", pos[1] + math.random(area[1], area[2]), pos[2] + math.random(area[1], area[2]), pos[3] + 25 + math.random(50, 100), 0.0, 0.0, 0.0, 5.0, false, false, false, false)

                Citizen.Wait(delay)
                UseParticleFxAssetNextCall(asset3)
                local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_shotburst", pos[1] + math.random(area[1], area[2]), pos[2] + math.random(area[1], area[2]), pos[3] + 25 + math.random(50, 200), 0.0, 0.0, 0.0, 5.0, false, false, false, false)
            end
        end
    end
)
