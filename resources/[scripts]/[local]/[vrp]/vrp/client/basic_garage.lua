local vehicles = {}
local rentVeh = {}

function tvRP.spawnGarageVehicle(vtype, name, pos) -- vtype is the vehicle type (one vehicle per type allowed at the same time)
  local vehicle = vehicles[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3], false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
    vehicles[vtype] = nil
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    tvRP.notify("차량을 불러오는 중..")

    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i + 1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x, y, z = tvRP.getPosition()
      if pos then
        x, y, z = table.unpack(pos)
      end

      local nveh = CreateVehicle(RWV, mhash, x, y, z + 0.5, 0.0, true, false)
      vehicles[vtype] = {vtype, name, nveh}
      SetEntityVisible(nveh, false)
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh, false)
      SetVehicleNumberPlateText(nveh, "P " .. tvRP.getRegistrationNumber())
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh, true)

      --Network vehicle set to allow migration by default
      if NetworkGetEntityIsNetworked(nveh) then
        local nid = VehToNet(nveh)
        SetNetworkIdCanMigrate(nid, cfg.vehicle_migration)
      end
      SetVehicleRadioEnabled(nveh, false)
      SetVehicleRadioLoud(nveh, false)
      --SetVehicleColours(nveh, 64, 64)
      SetVehicleDirtLevel(nveh, 0.0)
      WashDecalsFromVehicle(nveh, 1.0)

      SetModelAsNoLongerNeeded(mhash)

      TriggerServerEvent("LSC:applyModifications", name, nveh)
      Wait(100)
      SetEntityVisible(nveh, true)
      SetPedIntoVehicle(GetPlayerPed(-1), nveh, -1)
      tvRP.notify("차량 불러오기 완료.")
    else
      tvRP.notify("차량 불러오기 실패.")
    end
  else
    tvRP.notify("차량 소환은 " .. vtype .. "한대만 가능합니다.")
  end
end

function tvRP.despawnGarageVehicle(vtype, max_range)
  local vehicle = vehicles[vtype]
  if vehicle then
    local x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
    local px, py, pz = tvRP.getPosition()

    if GetDistanceBetweenCoords(x, y, z, px, py, pz, true) < max_range then -- check distance with the vehicule
      -- remove vehicle
      SetVehicleHasBeenOwnedByPlayer(vehicle[3], false)
      Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
      vehicles[vtype] = nil
      tvRP.notify("차량을 보관하였습니다.")
    else
      tvRP.notify("차량에서 너무 멀리떨어져 있습니다.")
    end
  end
  if rentVeh and rentVeh.entity and DoesEntityExist(rentVeh.entity) then
    SetVehicleHasBeenOwnedByPlayer(rentVeh.entity, false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, rentVeh.entity, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(rentVeh.entity))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(rentVeh.entity))
    rentVeh = {}
    tvRP.notify("~g~시승 차량이 반납되었습니다.")
  end
end

function tvRP.spawnRentVehicle(vtype, name, time) -- vtype is the vehicle type (one vehicle per type allowed at the same time)
  tvRP.notify("차량을 렌트하는 중..")

  local mhash = GetHashKey(name)

  local i = 0
  while not HasModelLoaded(mhash) and i < 10000 do
    RequestModel(mhash)
    Citizen.Wait(10)
    i = i + 1
  end

  if HasModelLoaded(mhash) then
    local x, y, z = tvRP.getPosition()
    local nveh = CreateVehicle(RWV, mhash, x, y, z + 0.5, 0.0, true, false)
    if rentVeh and rentVeh.entity and DoesEntityExist(rentVeh.entity) then
      SetVehicleHasBeenOwnedByPlayer(rentVeh.entity, false)
      Citizen.InvokeNative(0xAD738C3085FE7E11, rentVeh.entity, false, true) -- set not as mission entity
      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(rentVeh.entity))
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(rentVeh.entity))
      rentVeh = {}
    end
    rentVeh = {
      entity = nveh,
      time = time * 60
    }
    SetEntityVisible(nveh, false)
    SetVehicleOnGroundProperly(nveh)
    SetEntityInvincible(nveh, false)
    SetVehicleNumberPlateText(nveh, "RENT")
    Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
    SetVehicleHasBeenOwnedByPlayer(nveh, true)

    if NetworkGetEntityIsNetworked(nveh) then
      local nid = VehToNet(nveh)
      SetNetworkIdCanMigrate(nid, cfg.vehicle_migration)
    end
    SetVehicleRadioEnabled(nveh, false)
    SetVehicleRadioLoud(nveh, false)
    --SetVehicleColours(nveh, 64, 64)
    SetVehicleDirtLevel(nveh, 0.0)
    WashDecalsFromVehicle(nveh, 1.0)

    SetModelAsNoLongerNeeded(mhash)

    Wait(100)
    SetEntityVisible(nveh, true)
    SetPedIntoVehicle(GetPlayerPed(-1), nveh, -1)
    tvRP.notify("차량 렌트 완료.")
  else
    tvRP.notify("차량 렌트 실패.")
  end
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      if rentVeh and rentVeh.entity then
        Citizen.Wait(1000)
        if DoesEntityExist(rentVeh.entity) then
          if rentVeh.time > 0 then
            if rentVeh.time == 120 then
              tvRP.notify("~w~시승 시간이 ~r~2분 ~w~남았습니다.")
            elseif rentVeh.time == 60 then
              tvRP.notify("~w~시승 시간이 ~r~1분 ~w~남았습니다.")
            elseif rentVeh.time == 30 then
              tvRP.notify("~w~시승 시간이 ~r~30초 ~w~남았습니다.")
            elseif rentVeh.time == 10 then
              tvRP.notify("~y~시승 차량이 잠시후 반납됩니다.")
            end
            rentVeh.time = rentVeh.time - 1
          else
            SetVehicleHasBeenOwnedByPlayer(rentVeh.entity, false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, rentVeh.entity, false, true) -- set not as mission entity
            SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(rentVeh.entity))
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(rentVeh.entity))
            rentVeh = {}
            tvRP.notify("~g~시승 차량이 반납되었습니다.")
          end
        else
          rentVeh = {}
          tvRP.notify("~g~시승 차량이 반납되었습니다.")
        end
      end
    end
  end
)

-- check vehicles validity
--[[
Citizen.CreateThread(function()
  Citizen.Wait(30000)

  for k,v in pairs(vehicles) do
    if IsEntityAVehicle(v[3]) then -- valid, save position
      v.pos = {table.unpack(GetEntityCoords(vehicle[3],true))}
    elseif v.pos then -- not valid, respawn if with a valid position
      print("[vRP] invalid vehicle "..v[1]..", respawning...")
      tvRP.spawnGarageVehicle(v[1], v[2], v.pos)
    end
  end
end)
--]]
-- (experimental) this function return the nearest vehicle
-- (don't work with all vehicles, but aim to)
function tvRP.getNearestVehicle(radius)
  local x, y, z = tvRP.getPosition()
  local ped = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ped) then
    return GetVehiclePedIsIn(ped, true)
  else
    -- flags used:
    --- 8192: boat
    --- 4096: helicos
    --- 4,2,1: cars (with police)

    local veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 8192 + 4096 + 4 + 2 + 1) -- boats, helicos
    if not IsEntityAVehicle(veh) then
      veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 4 + 2 + 1)
    end -- cars
    return veh
  end
end

function tvRP.fixeNearestVehicle(radius)
  local veh = tvRP.getNearestVehicle(radius)
  if IsEntityAVehicle(veh) then
    SetVehicleFixed(veh)
  end
end

function tvRP.replaceNearestVehicle(radius)
  local veh = tvRP.getNearestVehicle(radius)
  if IsEntityAVehicle(veh) then
    SetVehicleOnGroundProperly(veh)
  end
end

-- try to get a vehicle at a specific position (using raycast)
function tvRP.getVehicleAtPosition(x, y, z)
  x = x + 0.0001
  y = y + 0.0001
  z = z + 0.0001

  local ray = CastRayPointToPoint(x, y, z, x, y, z + 4, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, ent = GetRaycastResult(ray)
  return ent
end

-- return ok,vtype,name
function tvRP.getNearestOwnedVehicle(radius)
  local px, py, pz = tvRP.getPosition()
  for k, v in pairs(vehicles) do
    local x, y, z = table.unpack(GetEntityCoords(v[3], true))
    local dist = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
    if dist <= radius + 0.0001 then
      return true, v[1], v[2]
    end
  end

  return false, "", ""
end

-- return ok,x,y,z
function tvRP.getAnyOwnedVehiclePosition()
  for k, v in pairs(vehicles) do
    if IsEntityAVehicle(v[3]) then
      local x, y, z = table.unpack(GetEntityCoords(v[3], true))
      return true, x, y, z
    end
  end

  return false, 0, 0, 0
end

-- return x,y,z
function tvRP.getOwnedVehiclePosition(vtype)
  local vehicle = vehicles[vtype]
  local x, y, z = 0, 0, 0

  if vehicle then
    x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
  end

  return x, y, z
end

-- return ok, vehicule network id
function tvRP.getOwnedVehicleId(vtype)
  local vehicle = vehicles[vtype]
  if vehicle and NetworkGetEntityIsNetworked(vehicle[3]) then
    return true, VehToNet(vehicle[3])
  else
    return false, 0
  end
end

-- eject the ped from the vehicle
function tvRP.ejectVehicle()
  local ped = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ped) then
    local veh = GetVehiclePedIsIn(ped, false)
    TaskLeaveVehicle(ped, veh, 4160)
  end
end

-- vehicle commands
function tvRP.vc_openDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorOpen(vehicle[3], door_index, 0, false)
  end
end

function tvRP.vc_closeDoor(vtype, door_index)
  local vehicle = vehicles[vtype]
  if vehicle then
    SetVehicleDoorShut(vehicle[3], door_index)
  end
end

function tvRP.vc_detachTrailer(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    DetachVehicleFromTrailer(vehicle[3])
  end
end

function tvRP.vc_detachTowTruck(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetEntityAttachedToTowTruck(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromTowTruck(vehicle[3], ent)
    end
  end
end

function tvRP.vc_detachCargobob(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local ent = GetVehicleAttachedToCargobob(vehicle[3])
    if IsEntityAVehicle(ent) then
      DetachVehicleFromCargobob(vehicle[3], ent)
    end
  end
end

function tvRP.vc_toggleEngine(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local running = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle[3]) -- GetIsVehicleEngineRunning
    SetVehicleEngineOn(vehicle[3], not running, true, true)
    if running then
      SetVehicleUndriveable(vehicle[3], true)
    else
      SetVehicleUndriveable(vehicle[3], false)
    end
  end
end

function tvRP.vc_toggleLock(vtype)
  local vehicle = vehicles[vtype]
  if vehicle then
    local veh = vehicle[3]
    local locked = GetVehicleDoorLockStatus(veh) >= 2
    if locked then -- unlock
      SetVehicleDoorsLockedForAllPlayers(veh, false)
      SetVehicleDoorsLocked(veh, 1)
      SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
      tvRP.notify("차량이 열렸습니다.")
    else -- lock
      SetVehicleDoorsLocked(veh, 2)
      SetVehicleDoorsLockedForAllPlayers(veh, true)
      tvRP.notify("차량이 잠겼습니다.")
    end
  end
end
