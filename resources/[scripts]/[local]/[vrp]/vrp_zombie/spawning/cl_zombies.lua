----------------- vRP Zombie
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vrp_zombieC = {}
Tunnel.bindInterface("vrp_zombie", vrp_zombieC)
Proxy.addInterface("vrp_zombie", vrp_zombieC)
vrp_zombieS = Tunnel.getInterface("vrp_zombie", "vrp_zombie")

local ZOMBIE_IGNORE_COMBAT_TIMEOUT_DECOR = "_ZOMBIE_IGNORE_COMBAT_TIMEOUT"
DecorRegister(ZOMBIE_IGNORE_COMBAT_TIMEOUT_DECOR, 3)

local ZOMBIE_TARGET_DECOR = "_ZOMBIE_TARGET"
DecorRegister(ZOMBIE_TARGET_DECOR, 3)

local ZOMBIE_TIME_UNTIL_SOUND_DECOR = "_ZOMBIE_SOUND_TIMEOUT"
DecorRegister(ZOMBIE_TIME_UNTIL_SOUND_DECOR, 3)

local ZOMBIE_TASK_DECOR = "_ZOMBIE_TASK"
DecorRegister(ZOMBIE_TASK_DECOR, 3)

local SPAWN_POINTS = Config.Spawning.Zombies.SPAWN_POINTS
local ZOMBIE_MODELS = Config.Spawning.Zombies.ZOMBIE_MODELS
local USER_SPAWN_MODELS = Config.Spawning.Zombies.USER_SPAWN_MODELS

local function AttrRollTheDice()
    return math.random(100) <= Config.Spawning.Zombies.ATTR_CHANCE
end

local function ZombifyPed(ped, zoneNum, isBoss)
    if zoneNum == 1 then
        if isBoss then
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP1_BOSS)
        else
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP1)
        end
    elseif zoneNum == 2 then
        if isBoss then
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP2_BOSS)
        else
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP2)
        end
    elseif zoneNum == 3 then
        if isBoss then
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP3_BOSS)
        else
            SetPedRelationshipGroupHash(ped, ZOMBIE_GROUP3)
        end
    end

    SetPedAccuracy(ped, 25)
    SetPedSeeingRange(ped, 1000000.0)
    SetPedHearingRange(ped, 1000000.0)

    SetPedConfigFlag(ped, 224, true)
    SetPedConfigFlag(ped, 281, true)
    SetPedCombatAttributes(ped, 16, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAttributes(ped, 5, true)
    SetPedCombatAttributes(ped, 1, false)
    SetPedCombatAttributes(ped, 0, false)
    SetPedCombatAbility(ped, 2)
    SetPedCombatRange(ped, 2)
    SetAmbientVoiceName(ped, "ALIENS")
    DisablePedPainAudio(ped, true)

    SetAiMeleeWeaponDamageModifier(9999.0)
    SetPedRagdollBlockingFlags(ped, 4)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedPathAvoidFire(ped, false)
    SetPedKeepTask(ped, true)
    TaskWanderStandard(ped, 10.0, 10)
    ApplyPedDamagePack(ped, "Fall", 100, 100)

    if isBoss then
        SetEntityHealth(ped, math.random(200, Config.Spawning.Zombies.MAX_HEALTH * 10))
        SetPedArmour(ped, math.random(100, Config.Spawning.Zombies.MAX_ARMOR * 10))
    else
        SetEntityHealth(ped, math.random(200, Config.Spawning.Zombies.MAX_HEALTH))
        SetPedArmour(ped, math.random(0, Config.Spawning.Zombies.MAX_ARMOR))
        if not HasAnimSetLoaded("move_m@drunk@verydrunk") then
            RequestAnimSet("move_m@drunk@verydrunk")
        end
        SetPedMovementClipset(ped, "move_m@drunk@verydrunk", 0.5)
    end

    if AttrRollTheDice() then
        SetPedRagdollOnCollision(ped, true)
    end

    if AttrRollTheDice() then
        SetPedSuffersCriticalHits(ped, false)
    end
end

local function TrySpawnRandomZombie(zone, zoneNum)
    local pos = GetRandomPosByArea(zone[1], zone[2], zone[3], zone[4])
    local spawnPos = vector3(pos[1], pos[2], pos[3])
    local models = zone[5]

    if spawnPos then
        math.randomseed(math.random(1, 99999))
        local n = math.random(1, #models)
        local selectModel = models[n]

        math.randomseed(math.random(1, 99999))
        local bossN = math.random(1, 1000)
        local isBoss = false
        if bossN < Config.Spawning.Zombies.BOSS_SPAWN_RATE * 10 then
            isBoss = true
            selectModel = zone[6][1]
        end
        local zombie = Utils.CreatePed(selectModel, 25, vector3(spawnPos.x, spawnPos.y, spawnPos.z), 0.0)
        ZombifyPed(zombie, zoneNum, isBoss)
    end
end

local dpeds = {}
local isInfectZombi = false
local isInfectZombiApply = false
local isRecSkin = false
local isDie = false
local isMedProcess = false

local isInZone = false
local isChangeCam = false

local function isZombieSkin(modelhash)
    for k, v in pairs(ZOMBIE_MODELS) do
        if modelhash == v then
            return true
        end
    end
    return false
end

local function RecSkin(force)
    if not isRecSkin or force then
        if isInfectZombi == false then
            if isInfectZombiApply == false then
                isRecSkin = true
                local custom = vRP.getCustomization()
                if isZombieSkin(custom.modelhash) then
                    vrp_zombieS.recZombieSkin()
                end
            end
        end
    end
end

local function ChangeRelationship()
    local mPlayerPed = PlayerPedId()
    if isInfectZombi then
        SetPedRelationshipGroupHash(mPlayerPed, ZOMBIE_PLAYER_GROUP)
    else
        SetPedRelationshipGroupHash(mPlayerPed, PLAYER_GROUP)
    end
end

local function HandleExistingZombies()
    local mPlayerPed = PlayerPedId()
    local currentCloudTime = GetCloudTimeAsInt()
    local untilPause = 10
    local targetPed = nil
    local PlayerCoords = GetEntityCoords(mPlayerPed)
    SetEntityCanBeDamaged(mPlayerPed, true)
    if not isDie then
        if isInfectZombi and isInfectZombiApply then
            if vRP.isInComa({}) or vRP.isInDie({}) then
                isDie = true
                vRP.killComa({})
                ChangeRelationship()
            end
        else
            targetPed = GetPedSourceOfDeath(mPlayerPed)
        end
    end
    for ped, pedData in pairs(g_peds) do
        if pedData.IsZombie then
            local zombieCoords = GetEntityCoords(ped)
            if not isDie then
                if isInfectZombi and isInfectZombiApply then
                else
                    if mPlayerPed ~= ped and targetPed == ped then
                        isInfectZombi = true
                        isChangeCam = true
                        SetEntityHealth(mPlayerPed, math.random(200, Config.Spawning.Zombies.MAX_HEALTH))
                        SetPedArmour(mPlayerPed, math.random(0, Config.Spawning.Zombies.MAX_ARMOR))
                        ClearPedTasksImmediately(mPlayerPed)
                        ChangeRelationship()
                        NetworkResurrectLocalPlayer(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 0.0, true, true, false)
                    end
                end
            end
            if IsPedDeadOrDying(ped, 1) and GetPedSourceOfDeath(ped) == mPlayerPed and dpeds[ped] == nil then
                dpeds[ped] = true
                local isBoss = IsCheckZombieBoss(ped)
                vrp_zombieS.kill({isBoss})
                if isBoss then
                    Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비보스를 죽였습니다!", 1)
                else
                    Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비를 죽였습니다!")
                end
            end

            if Player.IsSpawnHost() and (IsPedDeadOrDying(ped, 1) or not Utils.IsPosNearAPlayer(zombieCoords, Config.Spawning.Zombies.DESPAWN_DISTANCE)) then
                SetPedAsNoLongerNeeded(ped)
            else
                local zombieCombatTimeout = DecorGetInt(ped, ZOMBIE_IGNORE_COMBAT_TIMEOUT_DECOR)

                SetAmbientVoiceName(ped, "ALIENS")
                DisablePedPainAudio(ped, true)
                --SetBlockingOfNonTemporaryEvents(ped, zombieCombatTimeout > currentCloudTime)

                if Config.Spawning.Zombies.ENABLE_SOUNDS and DecorGetInt(ped, ZOMBIE_TIME_UNTIL_SOUND_DECOR) <= currentCloudTime then
                    DisablePedPainAudio(ped, false)
                    PlayPain(ped, 27)
                    DecorSetInt(ped, ZOMBIE_TIME_UNTIL_SOUND_DECOR, currentCloudTime + math.random(5, 60))
                end

                local zombieGameTarget = pedData.ZombieCombatTarget

                if zombieGameTarget and zombieCombatTimeout <= currentCloudTime and Utils.GetDistanceBetweenCoords(GetEntityCoords(zombieGameTarget), zombieCoords) > 2.0 then
                    DecorSetInt(ped, ZOMBIE_IGNORE_COMBAT_TIMEOUT_DECOR, currentCloudTime + 20)
                    DecorSetInt(ped, ZOMBIE_TARGET_DECOR, zombieGameTarget)
                    DecorSetInt(ped, ZOMBIE_TASK_DECOR, 0)

                --SetBlockingOfNonTemporaryEvents(ped, true)
                end

                local zombieDecorTarget = DecorGetInt(ped, ZOMBIE_TARGET_DECOR)
                if zombieDecorTarget ~= 0 then
                    local curTask = DecorGetInt(ped, ZOMBIE_TASK_DECOR)
                    local zombieDecorTargetPos = GetEntityCoords(zombieDecorTarget)

                    if Utils.GetDistanceBetweenCoords(zombieDecorTargetPos, zombieCoords) > 45.0 then
                        if IsPedOnVehicle(zombieDecorTarget) then
                            if curTask ~= 2 then
                                TaskCombatPed(ped, zombieDecorTarget, 0, 16)

                                DecorSetInt(ped, ZOMBIE_TASK_DECOR, 2)
                            end
                        elseif curTask ~= 1 then
                            TaskGoToEntity(ped, zombieDecorTarget, -1, 2.0, Config.Spawning.Zombies.WALK_SPEED)

                            DecorSetInt(ped, ZOMBIE_TASK_DECOR, 1)
                        end
                    else
                        DecorSetInt(ped, ZOMBIE_TASK_DECOR, 0)

                        if not IsPedOnVehicle(ped) and IsPedOnVehicle(zombieDecorTarget) then
                            TaskClimb(ped)
                        elseif not IsPedInCombat(ped, zombieDecorTarget) then
                            TaskCombatPed(ped, zombieDecorTarget, 0, 16)
                        end
                    end
                end
            end
            untilPause = untilPause - 1
            if untilPause == 0 then
                untilPause = 10
                Wait(0)
            end
        end
    end
end

function GetRandomNum(v, r)
    local min = v - (r / 2)
    math.randomseed(math.random(1, r))
    return min + math.random(1, r)
end

function GetRandomPosByArea(x, y, z, r)
    return {GetRandomNum(x, r), GetRandomNum(y, r), z}
end

Citizen.CreateThread(
    function()
        while true do
            Wait(250)
            FetchPeds()

            math.randomseed(math.random(1, 99999))
            local spn = math.random(1, #SPAWN_POINTS)

            if SPAWN_POINTS[spn] ~= nil then
                --print("test", PlayerId(), Player.IsSpawnHostZone(SPAWN_POINTS[spn]), spn, g_zombieAmount[spn], Config.Spawning.Zombies.MAX_AMOUNT)
                --print(spn, g_zombieAmount[spn])
                if Player.IsSpawnHostZone(SPAWN_POINTS[spn]) and g_zombieAmount[spn] <= Config.Spawning.Zombies.MAX_AMOUNT then
                    TrySpawnRandomZombie(SPAWN_POINTS[spn], spn)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(500)
            HandleExistingZombies()
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10000)

            local untilPause = 10
            for ped, pedData in pairs(g_peds) do
                if not pedData.IsZombie then
                    local relationshipGroup = pedData.RelationshipGroup

                    SetRelationshipBetweenGroups(5, ZOMBIE_PLAYER_GROUP, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_PLAYER_GROUP)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP1, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP1)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP1_BOSS, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP1_BOSS)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP2, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP2)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP2_BOSS, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP2_BOSS)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP3, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP3)

                    SetRelationshipBetweenGroups(5, ZOMBIE_GROUP3_BOSS, relationshipGroup)
                    SetRelationshipBetweenGroups(5, relationshipGroup, ZOMBIE_GROUP3_BOSS)

                    untilPause = untilPause - 1
                    if untilPause == 0 then
                        untilPause = 10

                        Wait(0)
                    end
                end
            end
        end
    end
)

function vrp_zombieC.Medkit()
    if not isMedProcess then
        isMedProcess = true
        local pped = PlayerPedId()
        Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비바이러스 제거를 ~b~시작~w~합니다.")
        Wait(500)
        SetEntityHealth(pped, 200)
        SetPedArmour(pped, 0)
        exports["progressBars"]:startUI(5000, "좀비바이러스 제거중")
        Wait(5000)
        if isInfectZombi and not isDie and not vRP.isInComa() and not vRP.isInDie() then
            isInfectZombi = false
            isInfectZombiApply = true
            isMedProcess = false
            Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비바이러스 제거 ~g~완료!")
        else
            Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비바이러스 제거 ~r~실패!")
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            for _, v in pairs(SPAWN_POINTS) do
                DrawMarker(1, v[1], v[2], v[3] - 5, 0, 0, 0, 0, 0, 0, v[4] * 1.0, v[4] * 1.0, 10.0, 255, 0, 0, 50, 0, 0, 2, 0, 0, 0, 0)
                DrawMarker(1, v[1], v[2], v[3] - 5, 0, 0, 0, 0, 0, 0, v[4] * 1.2, v[4] * 1.2, 7.0, 255, 255, 255, 200, 0, 0, 2, 0, 0, 0, 0)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            local PlayerPed = GetPlayerPed(-1)
            local PlayerCoords = GetEntityCoords(PlayerPed)
            for ped, pedData in pairs(g_peds) do
                if pedData.IsZombie then
                    local zombieCoords = GetEntityCoords(ped)
                    local distance = math.floor(GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, zombieCoords.x, zombieCoords.y, zombieCoords.z, true))
                    if distance < 20 then
                        local health = GetEntityHealth(ped)
                        local icon = "👿"
                        if pedData.IsZombieBoss then
                            icon = "👹"
                        end
                        DrawText3D(zombieCoords.x, zombieCoords.y, zombieCoords.z + 1.35, icon .. " " .. health, 255, 0, 0, 255, 1.5)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local mPlayerPed = GetPlayerPed(-1)
        while true do
            Citizen.Wait(0)
            if isInfectZombi and not isMedProcess then
                if IsControlJustReleased(0, 20) and not isDie and not vRP.isInComa() and not vRP.isInDie() then
                    vrp_zombieS.Medkit()
                end
            end
            if isInfectZombi then
                DisableControlAction(2, 37, true)
                --DisablePlayerFiring(mPlayerPed, true)
                DisableControlAction(0, 106, true)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 2.5)
            end
        end
    end
)

local isAuth = false
local isAuthProcess = false
local authTimer = 0
local inZoneGroup = 0

function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function vrp_zombieC.authTicket(status)
    if status then
        isAuth = true
        authTimer = 600
    else
        if SPAWN_POINTS[inZoneGroup] then 
            SetEntityCoords(GetPlayerPed(-1), SPAWN_POINTS[inZoneGroup][7])
        end
    end
    Citizen.Wait(1000)
    isAuthProcess = false
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if isAuth and authTimer > 0 then
                if authTimer > 5 then
                    DrawTxt(0.40, 0.05, 0.00, 0.00, 0.41, "~w~좀비존 남은시간: ~r~" .. parseInt(authTimer) .. "초", 255, 255, 255, 255)
                else
                    DrawTxt(0.40, 0.05, 0.00, 0.00, 0.41, "~w~좀비존 남은시간: ~r~잠시후 좀비존 밖으로 이동됩니다.", 255, 255, 255, 255)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3000)
            if isInZone then
                if not isAuth and not isAuthProcess then
                    isAuthProcess = true
                    vrp_zombieS.checkTicket()
                end
            else
                isAuth = false
                authTimer = 0
            end
            if isAuth then
                if authTimer > 0 then
                    authTimer = authTimer - 1
                else
                    isAuth = false
                    authTimer = 0
                    if SPAWN_POINTS[inZoneGroup] then 
                        SetEntityCoords(GetPlayerPed(-1), SPAWN_POINTS[inZoneGroup][7])
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            local pedPos = GetEntityCoords(GetPlayerPed(-1))
            local isInZoneCurrent = false
            if isInZone then
                isInZoneCurrent = true
            end
            isInZone = false
            inZoneGroup = 0
            for k, v in pairs(SPAWN_POINTS) do
                if GetDistanceBetweenCoords(pedPos.x, pedPos.y, pedPos.z, v[1], v[2], v[3], true) < (v[4] / 2) * 1.2 then
                    inZoneGroup = k
                    isInZone = true
                    isChangeCam = true
                    break
                end
            end
            if isInZone ~= isInZoneCurrent then
                if isInZone then
                    vRP.setSurvival({false})
                else
                    vRP.setSurvival({true})
                end
            end
            if Config.FIRST_PERSON_LOCK and isInZone and not isInfectZombi then
                SetFollowPedCamViewMode(4)
                SetFollowVehicleCamViewMode(4)
                DisableControlAction(0, 0, true)
            else
                if isChangeCam then
                    isChangeCam = false
                    SetFollowPedCamViewMode(1)
                    SetFollowVehicleCamViewMode(1)
                    DisableControlAction(0, 0, false)
                end
            end
            if not isDie then
                if isInfectZombi then
                    if isInfectZombiApply == false then
                        isInfectZombiApply = true

                        math.randomseed(math.random(1, 99999))
                        local spn = math.random(1, #USER_SPAWN_MODELS)
                        local mhash = USER_SPAWN_MODELS[spn]

                        if mhash ~= nil then
                            local i = 0
                            while not HasModelLoaded(mhash) and i < 10000 do
                                RequestModel(mhash)
                                Citizen.Wait(10)
                            end

                            if HasModelLoaded(mhash) then
                                local custom = vRP.getCustomization()
                                vrp_zombieS.infectZombieSkin({mhash, custom, not isZombieSkin(custom.modelhash)})
                                SetModelAsNoLongerNeeded(mhash)
                                isRecSkin = false
                            end
                        end

                        if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
                            RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
                            while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
                                Citizen.Wait(0)
                            end
                        end
                        ApplyPedDamagePack(GetPlayerPed(-1), "Fall", 100, 100)
                        Utils.SendNotification("CHAR_LESTER_DEATHWISH", 1, "알림", "", "좀비바이러스 감염\n해독제 사용: ~r~[Z]~w~키")
                    end

                    vRP.playScreenEffect({"DeathFailMPIn", -1})
                    SetPedIsDrunk(GetPlayerPed(-1), true)
                    ShakeGameplayCam("DRUNK_SHAKE", 2.0)
                    SetPedConfigFlag(GetPlayerPed(-1), 100, true)
                    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
                else
                    if isInfectZombiApply == true then
                        isInfectZombiApply = false
                        vRP.stopScreenEffect({"DeathFailMPIn"})
                        vRP.stopScreenEffect({"DeathFailOut"})
                        SetPedIsDrunk(GetPlayerPed(-1), false)
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                        SetPedConfigFlag(GetPlayerPed(-1), 100, false)
                        SetPedMovementClipset(GetPlayerPed(-1), "move_m@multiplayer", 1.0)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            RecSkin(true)
            ChangeRelationship()
        end
    end
)

Citizen.CreateThread(
    function()
        for k, v in pairs(SPAWN_POINTS) do
            local blip = AddBlipForCoord(v[1], v[2], v[3])

            SetBlipSprite(blip, 437)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 1.1)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("좀비존")
            EndTextCommandSetBlipName(blip)
        end
    end
)

Citizen.CreateThread(
    function()
        vRP.setSurvival({true})
        isDie = false
        isRecSkin = false
        isInfectZombi = false
        isInfectZombiApply = true
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        vRP.setSurvival({true})
        isDie = false
        isRecSkin = false
        isInfectZombi = false
        isInfectZombiApply = true
    end
)
