---------------------------------------------------------
-------------- SpecialMask, RealWorld MAC ---------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local maskList = {
    GetHashKey("prop_smask_arnold"),
    GetHashKey("prop_smask_buttercup_girls"),
    GetHashKey("prop_smask_cj"),
    GetHashKey("prop_smask_dr_neo"),
    GetHashKey("prop_smask_fallout_vault"),
    GetHashKey("prop_smask_flutterbat"),
    GetHashKey("prop_smask_fluttershy"),
    GetHashKey("prop_smask_homer_simpson"),
    GetHashKey("prop_smask_ironman"),
    GetHashKey("prop_smask_jack_frost_smt"),
    GetHashKey("prop_smask_james"),
    GetHashKey("prop_smask_jinx"),
    GetHashKey("prop_smask_joker"),
    GetHashKey("prop_smask_kamen_rider"),
    GetHashKey("prop_smask_kamen_rider2"),
    GetHashKey("prop_smask_lemon"),
    GetHashKey("prop_smask_marty_mcfly"),
    GetHashKey("prop_smask_mechanist_fallout"),
    GetHashKey("prop_smask_ninja_donatello"),
    GetHashKey("prop_smask_ninja_leonardo"),
    GetHashKey("prop_smask_ninja_michelangelo"),
    GetHashKey("prop_smask_ninja_raphael"),
    GetHashKey("prop_smask_robocop"),
    GetHashKey("prop_smask_runescape"),
    GetHashKey("prop_smask_skull"),
    GetHashKey("prop_smask_smallville"),
    GetHashKey("prop_smask_solid_sparkle"),
    GetHashKey("prop_smask_spiderman"),
    GetHashKey("prop_smask_steve"),
    GetHashKey("prop_smask_tolalan"),
    GetHashKey("prop_smask_tommy_vercetti"),
    GetHashKey("prop_smask_twilight_sparkle"),
    GetHashKey("prop_smask_undertale_sans")
}

function DeleteObjects(object, detach)
    if DoesEntityExist(object) then
        SetEntityAsMissionEntity(object, true, true)

        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(object) do
            Wait(100)
            timeout = timeout - 100
        end

        if detach then
            DetachEntity(object, 0, false)
        end

        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        DeleteEntity(object)
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local ped = GetPlayerPed(-1)
            for entity in Enumerator.EnumerateObjects() do
                if IsEntityAttachedToAnyPed(entity) then
                    local modelHash = GetEntityModel(entity)
                    for k, v in pairs(maskList) do
                        if v == modelHash then
                            local p_entity = GetEntityAttachedTo(entity)
                            if (p_entity ~= ped and IsEntityVisible(p_entity)) or (p_entity == ped and GetEntityAlpha(p_entity) > 60) then
                                SetEntityVisible(entity, true)
                                SetEntityAlpha(entity, 255)
                            else
                                if p_entity == ped then
                                    SetEntityAlpha(entity, 60)
                                else
                                    SetEntityVisible(entity, false)
                                    SetEntityAlpha(entity, 0)
                                end
                            end
                            if p_entity == ped and GetFollowPedCamViewMode() == 4 then
                                SetEntityVisible(entity, false)
                                SetEntityAlpha(entity, 0)
                            end
                        end
                    end
                    Citizen.Wait(0)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(60000)
            local ped = GetPlayerPed(-1)
            for entity in Enumerator.EnumerateObjects() do
                if Vdist(GetEntityCoords(entity), GetEntityCoords(ped), true) < 10 then
                    local modelHash = GetEntityModel(entity)
                    for k, v in pairs(maskList) do
                        if v == modelHash then
                            local p_entity = GetEntityAttachedTo(entity)
                            if p_entity == 0 or not DoesEntityExist(p_entity) then
                                DeleteObjects(entity, true)
                            end
                        end
                    end
                    Citizen.Wait(0)
                end
            end
        end
    end
)
