-- this module define some police tools and functions

local handcuffed = false
local cuffed = false
local cop = false
local isHandcuffering = false

-- set player as cop (true or false)
function tvRP.setCop(flag)
  cop = flag
  SetPedAsCop(GetPlayerPed(-1), flag)
end

-- HANDCUFF

function tvRP.toggleHandcuff(isCuffSet)
  handcuffed = not handcuffed

  if isCuffSet ~= nil then
    handcuffed = isCuffSet
  end

  SetEnableHandcuffs(GetPlayerPed(-1), handcuffed)
  if handcuffed then
    tvRP.playAnim(false, {{"mp_arrest_paired", "crook_p2_back_right", 1}}, true)
    Citizen.Wait(3760)
    tvRP.stopAnim(false)
    tvRP.playAnim(true, {{"mp_arresting", "idle", 1}}, true)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Cuff", 0.1)
  else
    tvRP.playAnim(false, {{"mp_arresting", "b_uncuff"}}, true)
    Citizen.Wait(4500)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Uncuff", 0.1)
    Citizen.Wait(1500)
    tvRP.stopAnim(false)
    SetPedStealthMovement(GetPlayerPed(-1), false, "")
  end
end

function tvRP.Handcuffer(isCuffSet)
  if isHandcuffering then
    return
  end
  isHandcuffering = true
  cuffed = not cuffed
  if isCuffSet ~= nil then
    cuffed = isCuffSet
  end
  if cuffed then
    tvRP.progressBars(3500, "수갑을 채우는 중")
    tvRP.playAnim(false,{{"mp_arrest_paired","cop_p2_back_right",1}},true)
    Citizen.Wait(3500)
    tvRP.stopAnim(false)
    isHandcuffering = false
  else
    tvRP.progressBars(5500, "수갑을 푸는 중")
    tvRP.playAnim(false,{{"mp_arresting","a_uncuff",1}},true)
    Citizen.Wait(5500)
    tvRP.stopAnim(false)
    isHandcuffering = false
  end
end

function tvRP.setHandcuffed(flag)
  if handcuffed ~= flag then
    tvRP.toggleHandcuff()
  end
end

function tvRP.isHandcuffed()
  return handcuffed
end

-- (experimental, based on experimental getNearestVehicle)
function tvRP.putInNearestVehicleAsPassenger(radius)
  local veh = tvRP.getNearestVehicle(radius)

  if IsEntityAVehicle(veh) then
    for i = 1, math.max(GetVehicleMaxNumberOfPassengers(veh), 3) do
      if IsVehicleSeatFree(veh, i) then
        SetPedIntoVehicle(GetPlayerPed(-1), veh, i)
        return true
      end
    end
  end

  return false
end

function tvRP.putInNetVehicleAsPassenger(net_veh)
  local veh = NetToVeh(net_veh)
  if IsEntityAVehicle(veh) then
    for i = 1, GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh, i) then
        SetPedIntoVehicle(GetPlayerPed(-1), veh, i)
        return true
      end
    end
  end
end

function tvRP.putInVehiclePositionAsPassenger(x, y, z)
  local veh = tvRP.getVehicleAtPosition(x, y, z)
  if IsEntityAVehicle(veh) then
    for i = 1, GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh, i) then
        SetPedIntoVehicle(GetPlayerPed(-1), veh, i)
        return true
      end
    end
  end
end

-- keep handcuffed animation
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(15000)
      if handcuffed then
        tvRP.playAnim(true, {{"mp_arresting", "idle", 1}}, true)
      end
    end
  end
)

-- force stealth movement while handcuffed (prevent use of fist and slow the player)
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if handcuffed then
        SetPedStealthMovement(GetPlayerPed(-1), true, "")
        DisableControlAction(0, 20, true) -- disable sprint
        DisableControlAction(0, 22, true) -- disable sprint
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 29, true) -- Point
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(0, 44, true) -- Q
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 75, true) -- disable exit vehicle
        DisableControlAction(27, 75, true) -- disable exit vehicle
        DisableControlAction(0, 166, true) -- F5
        DisableControlAction(0, 167, true) -- F6
        DisableControlAction(0, 168, true) -- F7
        DisableControlAction(0, 303, true) -- U
        DisableControlAction(0, 123, true)
        DisableControlAction(0, 124, true)
        DisableControlAction(0, 125, true)
        DisableControlAction(0, 126, true)
        DisableControlAction(0, 127, true)
        DisableControlAction(0, 128, true)
        DisableControlAction(0, 311, true) -- K
        DisableControlAction(0, 182, true) -- L
        DisableControlAction(0, 82, true) -- ,
        DisableControlAction(0, 38, true) -- E
        DisableControlAction(0, 243, true) -- `
        DisableControlAction(0, 288, true) -- F1
      end
    end
  end
)

-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder
function tvRP.jail(x, y, z, radius)
  tvRP.teleport(x, y, z) -- teleport to center
  jail = {x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001}
end

-- unjail the player
function tvRP.unjail()
  jail = nil
end

function tvRP.isJailed()
  return jail ~= nil
end

Citizen.CreateThread(
  function()
    while false do
      Citizen.Wait(5)
      if jail then
        local x, y, z = tvRP.getPosition()

        local dx = x - jail[1]
        local dy = y - jail[2]
        local dist = math.sqrt(dx * dx + dy * dy)

        if dist >= jail[4] then
          local ped = GetPlayerPed(-1)
          SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

          -- normalize + push to the edge + add origin
          dx = dx / dist * jail[4] + jail[1]
          dy = dy / dist * jail[4] + jail[2]

          -- teleport player at the edge
          SetEntityCoordsNoOffset(ped, dx, dy, z, true, true, true)
        end
      end
    end
  end
)

local rtalk = nil

-- jail the player in a no-top no-bottom cylinder
function tvRP.rtalk()
  rtalk = true
end

-- unjail the player
function tvRP.unrtalk()
  rtalk = nil
end

function tvRP.isRTalked()
  return rtalk ~= nil
end

-- WANTED

-- wanted level sync
local wanted_level = 0

function tvRP.applyWantedLevel(new_wanted)
  Citizen.CreateThread(
    function()
      local old_wanted = GetPlayerWantedLevel(PlayerId())
      local wanted = math.max(old_wanted, new_wanted)
      ClearPlayerWantedLevel(PlayerId())
      SetPlayerWantedLevelNow(PlayerId(), false)
      Citizen.Wait(10)
      SetPlayerWantedLevel(PlayerId(), wanted, false)
      SetPlayerWantedLevelNow(PlayerId(), false)
    end
  )
end

-- update wanted level
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(2000)

      -- if cop, reset wanted level
      if cop then
        ClearPlayerWantedLevel(PlayerId())
        SetPlayerWantedLevelNow(PlayerId(), false)
      end

      -- update level
      local nwanted_level = GetPlayerWantedLevel(PlayerId())
      if nwanted_level ~= wanted_level then
        wanted_level = nwanted_level
        vRPserver.updateWantedLevel({wanted_level})
      end
    end
  end
)

-- detect vehicle stealing
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      local ped = GetPlayerPed(-1)
      if IsPedTryingToEnterALockedVehicle(ped) or IsPedJacking(ped) then
        Citizen.Wait(2000) -- wait x seconds before setting wanted
        local ok, vtype, name = tvRP.getNearestOwnedVehicle(5)
        if not ok then -- prevent stealing detection on owned vehicle
          for i = 0, 4 do -- keep wanted for 1 minutes 30 seconds
            tvRP.applyWantedLevel(2)
            Citizen.Wait(15000)
          end
        end
        Citizen.Wait(15000) -- wait 15 seconds before checking again
      end
    end
  end
)
