-- periodic player state update

local state_ready = false

AddEventHandler(
  "playerSpawned",
  function()
    Citizen.CreateThread(
      function()
        SetCanAttackFriendly(GetPlayerPed(-1), true, false)
        NetworkSetFriendlyFireOption(true)

        state_ready = false
        SetEntityVisible(PlayerPedId(), false, false)
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.Wait(10000)
        SetEntityVisible(PlayerPedId(), true, false)
        FreezeEntityPosition(PlayerPedId(), false)
        state_ready = true
      end
    )
  end
)

Citizen.CreateThread(
  function()
    while true do
      if state_ready then
        Citizen.Wait(10000)
        if IsPlayerPlaying(PlayerId()) then
          local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
          vRPserver.updatePlayerState({x, y, z, tvRP.getWeapons(), tvRP.getCustomization(), tvRP.getHealth()})
        end
      end
      Citizen.Wait(100)
    end
  end
)

-- WEAPONS

-- def
local weapon_types = {
  "WEAPON_KNIFE",
  "WEAPON_NIGHTSTICK",
  "WEAPON_HAMMER",
  "WEAPON_BAT",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_PISTOL",
  "WEAPON_COMBATPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_MICROSMG",
  "WEAPON_SMG",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_CARBINERIFLE",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_MG",
  "WEAPON_COMBATMG",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_STUNGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
  "WEAPON_RPG",
  "WEAPON_MINIGUN",
  "WEAPON_GRENADE",
  "WEAPON_STICKYBOMB",
  "WEAPON_SMOKEGRENADE",
  "WEAPON_BZGAS",
  "WEAPON_MOLOTOV",
  "WEAPON_FIREEXTINGUISHER",
  "WEAPON_PETROLCAN",
  "WEAPON_FLARE",
  "WEAPON_SNSPISTOL",
  "WEAPON_SPECIALCARBINE",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_BULLPUPRIFLE",
  "WEAPON_HOMINGLAUNCHER",
  "WEAPON_PROXMINE",
  "WEAPON_SNOWBALL",
  "WEAPON_VINTAGEPISTOL",
  "WEAPON_DAGGER",
  "WEAPON_FIREWORK",
  "WEAPON_MUSKET",
  "WEAPON_MARKSMANRIFLE",
  "WEAPON_HEAVYSHOTGUN",
  "WEAPON_GUSENBERG",
  "WEAPON_HATCHET",
  "WEAPON_RAILGUN",
  "WEAPON_COMBATPDW",
  "WEAPON_KNUCKLE",
  "WEAPON_MARKSMANPISTOL",
  "WEAPON_FLASHLIGHT",
  "WEAPON_MACHETE",
  "WEAPON_MACHINEPISTOL",
  "WEAPON_SWITCHBLADE",
  "WEAPON_REVOLVER",
  "WEAPON_COMPACTRIFLE",
  "WEAPON_DBSHOTGUN",
  "WEAPON_FLAREGUN",
  "WEAPON_AUTOSHOTGUN",
  "WEAPON_BATTLEAXE",
  "WEAPON_COMPACTLAUNCHER",
  "WEAPON_MINISMG",
  "WEAPON_PIPEBOMB",
  "WEAPON_POOLCUE",
  "WEAPON_SWEEPER",
  "WEAPON_WRENCH",
  "WEAPON_HATCHETX",
  "WEAPON_CAPSHIELD",
  "WEAPON_GCLUBS",
  "WEAPON_LIGHTSABER",
  "WEAPON_MACHETTE_LR_RED",
  "WEAPON_MACHETTE_LRX_YELLOW",
  "WEAPON_SMG_MK2",
  "WEAPON_CARBINERIFLE_MK2",
  "WEAPON_PUMPSHOTGUN_MK2",
  "WEAPON_ASSAULTRIFLE_MK2",
  "WEAPON_BFG9000",
  "WEAPON_FLAMETHROWER",
  "WEAPON_KIRIBAT",
  "WEAPON_THANOSCROWBAR",
  "WEAPON_KNIFE_01",
  "WEAPON_KNIFE_02",
  "WEAPON_VIVEHAMMER",
  "WEAPON_VIVEBAT",
  "WEAPON_AXEBAT",
  "WEAPON_BRICK",
  "WEAPON_BRICKBALL",
  "WEAPON_NIGHTSTICK2"
}

function tvRP.setArmour(armour, vest)
  local player = GetPlayerPed(-1)
  if vest then
    if (GetEntityModel(player) == GetHashKey("mp_m_freemode_01")) then
      SetPedComponentVariation(player, 9, 4, 1, 2)
    else
      if (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
        SetPedComponentVariation(player, 9, 6, 1, 2)
      end
    end
  else
    SetPedComponentVariation(player, 9, 0, 0, 0)
  end
  local n = math.floor(armour)
  SetPedArmour(player, n)
end

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k, v in pairs(weapon_types) do
    local hash = GetHashKey(v[1])
    if HasPedGotWeapon(player, hash) then
      local weapon = {}
      weapons[v[1]] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player, hash)
      else
        weapon.ammo = 0
      end
      if v[2] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[2]))) == 1 then
          weapon.supressor = tostring(v[2])
        else
          weapon.supressor = "nu"
        end
      end
      if v[3] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[3]))) == 1 then
          weapon.flash = tostring(v[3])
        else
          weapon.flash = "nu"
        end
      end
      if v[4] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[4]))) == 1 then
          weapon.yusuf = tostring(v[4])
        else
          weapon.yusuf = "nu"
        end
      end
      if v[5] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[5]))) == 1 then
          weapon.grip = tostring(v[5])
        else
          weapon.grip = "nu"
        end
      end
      if v[6] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[6]))) == 1 then
          weapon.holografik = tostring(v[6])
        else
          weapon.holografik = "nu"
        end
      end
      if v[7] ~= nil then
        if HasPedGotWeaponComponent(player, hash, GetHashKey(tostring(v[7]))) == 1 then
          weapon.powiekszonymagazynek = tostring(v[7])
        else
          weapon.powiekszonymagazynek = "nu"
        end
      end
    end
  end

  return weapons
end

function tvRP.giveWeapons(weapons, clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player, true)
  end

  for k, weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0
    GiveWeaponToPed(player, hash, ammo, false)
    if weapon.supressor ~= "nu" and weapon.supressor ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.supressor))
    end
    if weapon.flash ~= "nu" and weapon.flash ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.flash))
    end
    if weapon.yusuf ~= "nu" and weapon.yusuf ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.yusuf))
    end
    if weapon.grip ~= "nu" and weapon.grip ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.grip))
    end
    if weapon.holografik ~= "nu" and weapon.holografik ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.holografik))
    end
    if weapon.powiekszonymagazynek ~= "nu" and weapon.powiekszonymagazynek ~= nil then
      GiveWeaponComponentToPed(GetPlayerPed(-1), hash, GetHashKey(weapon.powiekszonymagazynek))
    end
  end
end

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k, v in pairs(weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player, hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player, hash)
      else
        weapon.ammo = 0
      end
    end
  end

  return weapons
end

function tvRP.giveWeapons(weapons, clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player, true)
  end

  for k, weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0

    GiveWeaponToPed(player, hash, ammo, false)
  end
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(GetPlayerPed(-1))
end
--]]
-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key, 1, 1) == "p" then
    return true, tonumber(string.sub(key, 2))
  else
    return false, tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), index)
  else
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), index)
  end
end

function tvRP.getDrawableTextures(part, drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), index, drawable)
  else
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1), index, drawable)
  end
end

function tvRP.getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}
  local valid = false
  valid = not IsEntityAttached(ped)

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i = 0, 20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped, i), GetPedTextureVariation(ped, i), GetPedPaletteVariation(ped, i)}
  end

  -- props
  for i = 0, 10 do -- index limit to 10
    custom["p" .. i] = {GetPedPropIndex(ped, i), math.max(GetPedPropTextureIndex(ped, i), 0)}
  end

  return custom, valid
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  if IsEntityAttached(GetPlayerPed(-1)) then
    exit({})
    return
  end

  Citizen.CreateThread(
    function()
      -- new thread
      if custom then
        local ped = GetPlayerPed(-1)
        local mhash = nil

        -- model
        if custom.modelhash ~= nil then
          mhash = custom.modelhash
        elseif custom.model ~= nil then
          mhash = GetHashKey(custom.model)
        end

        if mhash ~= nil then
          local i = 0
          while not HasModelLoaded(mhash) and i < 10000 do
            RequestModel(mhash)
            Citizen.Wait(10)
          end

          if HasModelLoaded(mhash) then
            local weapons = tvRP.getWeapons()
            SetPlayerModel(PlayerId(), mhash)
            tvRP.giveWeapons(weapons, true)
            SetModelAsNoLongerNeeded(mhash)
          end
        end

        ped = GetPlayerPed(-1)

        -- parts
        for k, v in pairs(custom) do
          if k ~= "model" and k ~= "modelhash" then
            local isprop, index = parse_part(k)
            if isprop then
              if v[1] < 0 then
                ClearPedProp(ped, index)
              else
                SetPedPropIndex(ped, index, v[1], v[2], v[3] or 2)
              end
            else
              SetPedComponentVariation(ped, index, v[1], v[2], v[3] or 2)
            end
          end
        end
      end

      exit({})
    end
  )
end

local smaskOn = false
local smaskEntity = nil
local smaskEntityNetId = nil

function tvRP.setSpecialMaskOn(custom)
  if custom == nil or custom.id == nil then
    return false
  end
  local maskId = custom.id
  local exit = TUNNEL_DELAYED()

  Citizen.CreateThread(
    function()
      tvRP.setSpecialMaskOff()
      Citizen.Wait(1000)
      local playerPed = GetPlayerPed(-1)
      local hash = GetHashKey("prop_smask_" .. maskId)
      RequestModel(hash)
      while not HasModelLoaded(hash) do
        Citizen.Wait(100)
      end
      smaskEntity = CreateObject(RWO, hash, 0, 0, 0, true, true, true)
      if smaskEntity then
        NetworkRequestControlOfEntity(smaskEntity)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(smaskEntity) do
          Wait(100)
          timeout = timeout - 100
        end

        SetEntityAsMissionEntity(smaskEntity, true, true)
        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(smaskEntity) do
          Wait(100)
          timeout = timeout - 100
        end

        NetworkRegisterEntityAsNetworked(smaskEntity)
        Citizen.Wait(1000)
        if NetworkGetEntityIsNetworked(smaskEntity) then
          smaskEntityNetId = ObjToNet(smaskEntity)
          if smaskEntityNetId then
            SetNetworkIdExistsOnAllMachines(smaskEntityNetId, true)
            NetworkSetNetworkIdDynamic(smaskEntityNetId, true)
            SetNetworkIdCanMigrate(smaskEntityNetId, false)
          end
        end

        smaskOn = true
      end
      exit({})
    end
  )
end

function tvRP.setSpecialMaskOff()
  local exit = TUNNEL_DELAYED()

  if IsEntityAttached(GetPlayerPed(-1)) then
    exit({})
    return
  end

  Citizen.CreateThread(
    function()
      if smaskOn and smaskEntityNetId then
        smaskOn = false
        Citizen.Wait(100)
        DetachEntity(NetToObj(smaskEntityNetId), 1, 1)
        DeleteEntity(NetToObj(smaskEntityNetId))
        smaskEntity = nil
        smaskEntityNetId = nil
      end
      exit({})
    end
  )
end

Citizen.CreateThread(
  function()
    while true do
      if smaskOn and smaskEntity and smaskEntityNetId then
        if not IsEntityAttached(smaskEntity) then
          AttachEntityToEntity(smaskEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.15, 0.0, 0.0, 0, 90.0, 180.0, true, true, false, true, 1, true)
        end
      end
      Citizen.Wait(10)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      local ped = PlayerPedId()
      SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 0.2)
      SetEntityCanBeDamaged(ped, true)
      SetEntityInvincible(ped, false)
      SetEntityProofs(ped, false, false, false, false, false)
      SetPedCanRagdoll(ped, true)
      if IsPedArmed(ped, 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
      end
      Citizen.Wait(0)
    end
  end
)

RegisterNetEvent("alex:supp")
AddEventHandler(
  "alex:supp",
  function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SR_SUPP_03"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    end
  end
)

RegisterNetEvent("alex:flashlight")
AddEventHandler(
  "alex:flashlight",
  function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    end
  end
)

RegisterNetEvent("alex:grip")
AddEventHandler(
  "alex:grip",
  function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
    end
  end
)

RegisterNetEvent("alex:yusuf")
AddEventHandler(
  "alex:yusuf",
  function(duration)
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))
    end
  end
)

RegisterNetEvent("alex:holografik")
AddEventHandler(
  "alex:holografik",
  function(duration)
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_SIGHTS_SMG"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
    end
  end
)

RegisterNetEvent("alex:powiekszonymagazynek")
AddEventHandler(
  "alex:powiekszonymagazynek",
  function(duration)
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_SMG_MK2_CLIP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CLIP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_CARBINERIFLE_MK2_CLIP_02"))
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"))
    end
  end
)
