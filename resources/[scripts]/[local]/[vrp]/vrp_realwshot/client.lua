local sh = GetEntityHealth(ply)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ply = GetPlayerPed(-1)
            if HasEntityBeenDamagedByAnyPed(ply) then
                dam = sh - GetEntityHealth(ply)
                if (dam > 0) and (GetPedArmour(ply) <= 25) then
                    if (dam >= 0) and (dam <= 5) then
                        hurtMedium(ply, dam)
                    elseif (dam >= 6) and (dam <= 10) then
                        hurtMediumBad(ply, dam)
                    elseif (dam >= 11) and (dam <= 16) then
                        hurtPainful(ply, dam)
                    elseif dam >= 17 then
                        hurtPainful(ply, dam)
                    end
                end

                sh = GetEntityHealth(ply)
            end
            ClearEntityLastDamageEntity(ply)
        end
    end
)

function hurtMedium(ped, r)
    if IsEntityDead(ped) then
        return false
    end
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
end
function hurtMediumBad(ped, r)
    if IsEntityDead(ped) then
        return false
    end
    SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
    --Citizen.SetTimeout( 4000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 30000, function() SetPedIsDrunk(ped, false) end)
end
function hurtBad(ped, r)
    if IsEntityDead(ped) then
        return false
    end
    SetPedToRagdoll(GetPlayerPed(-1), 3000, 3000, 0, 0, 0, 0)
    --Citizen.SetTimeout( 5000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
end
function hurtPainful(ped, r)
    if IsEntityDead(ped) then
        return false
    end
    SetPedToRagdoll(GetPlayerPed(-1), 10000, 10000, 0, 0, 0, 0)
    --Citizen.SetTimeout( 15000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
end
