g_peds = {}
g_zombieAmount = {0, 0, 0}
total = 0

function IsCheckZombieBoss(ped)
    local relationshipGroup = GetPedRelationshipGroupHash(ped)
    if relationshipGroup == ZOMBIE_GROUP1_BOSS then
        return true
    elseif relationshipGroup == ZOMBIE_GROUP2_BOSS then
        return true
    elseif relationshipGroup == ZOMBIE_GROUP3_BOSS then
        return true
    end
    return false
end

function FetchPeds()
    local zombieAmount = {0, 0, 0}
    local untilPause = 10

    g_peds = {}
    total = 0

    for ped in EntityEnum.EnumeratePeds() do
        total = total + 1
        local relationshipGroup = GetPedRelationshipGroupHash(ped)
        local isZombiePlayer = relationshipGroup == ZOMBIE_PLAYER_GROUP
        local isZombie1 = relationshipGroup == ZOMBIE_GROUP1
        local isZombie1_Boss = relationshipGroup == ZOMBIE_GROUP1_BOSS
        local isZombie2 = relationshipGroup == ZOMBIE_GROUP2
        local isZombie2_Boss = relationshipGroup == ZOMBIE_GROUP2_BOSS
        local isZombie3 = relationshipGroup == ZOMBIE_GROUP3
        local isZombie3_Boss = relationshipGroup == ZOMBIE_GROUP3_BOSS
        local isGuard = relationshipGroup == SAFEZONE_GUARD_GROUP
        local combatTarget

        local isZombie = isZombiePlayer or isZombie1 or isZombie1_Boss or isZombie2 or isZombie2_Boss or isZombie3 or isZombie3_Boss
        local isZombieBoss = IsCheckZombieBoss(ped)

        if isZombie and not IsPedAPlayer(ped) then
            if isZombie1 or isZombie1_Boss then
                zombieAmount[1] = zombieAmount[1] + 1
            elseif isZombie2 or isZombie2_Boss then
                zombieAmount[2] = zombieAmount[2] + 1
            elseif isZombie3 or isZombie3_Boss then
                zombieAmount[3] = zombieAmount[3] + 1
            end

            for ped2 in EntityEnum.EnumeratePeds() do
                if IsPedAPlayer(ped2) and IsPedInCombat(ped, ped2) then
                    combatTarget = ped2
                    break
                end
            end
        end

        local group = 0
        if isZombie1 or isZombie1_Boss then
            group = 1
        end
        if isZombie2 or isZombie2_Boss then
            group = 2
        end
        if isZombie3 or isZombie3_Boss then
            group = 3
        end

        g_peds[ped] = {
            IsZombie = isZombie,
            IsZombieBoss = isZombieBoss,
            RelationshipGroup = relationshipGroup,
            ZombieCombatTarget = combatTarget,
            IsGuard = isGuard
        }
    end

    g_zombieAmount[1] = zombieAmount[1]
    g_zombieAmount[2] = zombieAmount[2]
    g_zombieAmount[3] = zombieAmount[3]
end

local SPAWN_POINTS = Config.Spawning.Zombies.SPAWN_POINTS

Citizen.CreateThread(
    function()
        TriggerEvent("vrp_zombie:remove_ped")
        while true do
            Wait(3000)
            for ped, pedData in pairs(g_peds) do
                local model = GetEntityModel(ped)
                local isZombieModel = false
                for k, v in pairs(Config.Spawning.Zombies.ZOMBIE_MODELS) do
                    if model == v then
                        isZombieModel = true
                        break
                    end
                end
                if isZombieModel and DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                    local pedPos = GetEntityCoords(ped)
                    local isChecked = false
                    for k, v in pairs(SPAWN_POINTS) do
                        local dist = Vdist(pedPos.x, pedPos.y, pedPos.z, v[1], v[2], v[3], true)
                        local group = pedData.RelationshipGroup
                        if k == 1 and (group == ZOMBIE_GROUP1 or group == ZOMBIE_GROUP1_BOSS) and dist > v[4] / 2 then
                            isChecked = true
                            break
                        end
                        if k == 2 and (group == ZOMBIE_GROUP2 or group == ZOMBIE_GROUP2_BOSS) and dist > v[4] / 2 then
                            isChecked = true
                            break
                        end
                        if k == 3 and (group == ZOMBIE_GROUP3 or group == ZOMBIE_GROUP3_BOSS) and dist > v[4] / 2 then
                            isChecked = true
                            break
                        end
                    end
                    if isChecked then
                        SetEntityAsMissionEntity(ped, true, true)
                        DeleteEntity(ped)
                        RemoveAllPedWeapons(ped, true)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(5000)
            for ped, pedData in pairs(g_peds) do
                local model = GetEntityModel(ped)
                local isZombieModel = false
                for k, v in pairs(Config.Spawning.Zombies.ZOMBIE_MODELS) do
                    if model == v then
                        isZombieModel = true
                        break
                    end
                end
                if isZombieModel and DoesEntityExist(ped) and not IsPedAPlayer(ped) and (not pedData.IsZombie or IsPedDeadOrDying(ped, 1)) then
                    SetEntityAsMissionEntity(ped, true, true)
                    DeleteEntity(ped)
                    RemoveAllPedWeapons(ped, true)
                end
            end
        end
    end
)

RegisterNetEvent("vrp_zombie:remove_ped")
AddEventHandler(
    "vrp_zombie:remove_ped",
    function()
        for ped in EntityEnum.EnumeratePeds() do
            local model = GetEntityModel(ped)
            local isZombieModel = false
            for k, v in pairs(Config.Spawning.Zombies.ZOMBIE_MODELS) do
                if model == v then
                    isZombieModel = true
                    break
                end
            end
            if isZombieModel and DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(ped))
                DeleteEntity(ped)
                RemoveAllPedWeapons(ped, true)
            end
        end
    end
)

function DrawText3D(x, y, z, text, r, g, b, a, s)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * s
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
