local cooltime = 120
local ragdoll_chance = 0
local drill = false

function LocalPed()
  return GetPlayerPed(-1)
end

local attached_weapons = {}
local incircle = false

local nodongjang = {
  {1651.6258544922, 2539.3308105469, 45.56489944458},
  {1655.3977050781, 2544.2788085938, 45.56489944458},
  {1658.1962890625, 2542.4572753906, 45.56489944458},
  {1660.5666503906, 2540.3430175781, 45.56489944458},
  {1656.6994628906, 2535.6284179688, 45.56489944458},
  {1654.0760498047, 2537.4763183594, 45.56489944458}
}

local oldmodelRock = nil
local alreadyCut = {}
local CanLeaveBox = false
local DrillObj = 1360563376
local HashKeyBox = 1835700637
local myCoords = {}
local coords = {}

modelRock = {
  [1] = 1835700637
}

local TIM = cooltime * 1000
local props = CreateObject(RWO, DrillObj, x, y, z, true, true, true)

function getdrill()
  if incircle == true and drill == false then
    drawTxt("드릴을 대여하시려면 ~g~E~s~를 누르세요.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    if (IsControlJustReleased(1, 38)) then
      TriggerServerEvent("nodong:checkper")
    end
  end
end

RegisterNetEvent("nodong:continue")
AddEventHandler(
  "nodong:continue",
  function()
    drill = true
    props = CreateObject(RWO, DrillObj, x, y, z, true, true, true)
    AttachEntityToEntity(props, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xdd1c), 0.0, -0.22, 0.39, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    StartBlip = AddBlipForCoord(1657.6324462891, 2542.1264648438, 45.564895629883)
    SetBlipSprite(StartBlip, 441)
    SetBlipColour(StartBlip, 75)
    SetBlipScale(StartBlip, 1.0)
    SetBlipAsShortRange(StartBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("노역 위치")
    EndTextCommandSetBlipName(StartBlip)
    help_message("지도에 표시된 오프화이트 위치로 가세요!")
    FinishBlip = AddBlipForCoord(1768.753, 2563.388, 45.565)
    SetBlipSprite(FinishBlip, 478)
    SetBlipColour(FinishBlip, 5)
    SetBlipScale(FinishBlip, 1.0)
    SetBlipAsShortRange(FinishBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("돌 운반 위치")
    EndTextCommandSetBlipName(FinishBlip)
  end
)

function outdrill()
  if incircle == true and drill == true then
    drawTxt("드릴을 반납하시려면 ~g~E~s~를 누르세요.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    if (IsControlJustReleased(1, 38)) then
      drill = false
      DetachEntity(props, true, false)
      DeleteEntity(props)
      TriggerServerEvent("re:drillp")
      RemoveBlip(StartBlip)
      RemoveBlip(FinishBlip)
    end
  end
end

-- 드릴 대여
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      DrawMarker(1, 1755.44, 2566.65, 45.57 - 1.5, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 255, 0, 0, 100, 0, 0, 0, 0) --- The GoPostal depot location
      if GetDistanceBetweenCoords(1755.44, 2566.65, 45.57, GetEntityCoords(LocalPed())) < 1.0 then
        incircle = true
        if drill == false then
          getdrill()
        elseif drill == true then
          outdrill()
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      for i = 1, #modelRock do
        local x = 1755.44
        local y = 2566.65
        local z = 45.57
        local objectCoords = GetEntityCoords(GetPlayerPed(-1))
        if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
          Draw3dText3(x, y, z + 0.2, "드릴 대여")
        end
      end
      Citizen.Wait(0)
    end
  end
)

-- 돌 내려두기
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      DrawMarker(1, 1768.753, 2563.388, 45.565 - 1.5, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 255, 165, 0, 100, 0, 0, 0, 0) --- The GoPostal depot location
      if GetDistanceBetweenCoords(1768.753, 2563.388, 45.565, GetEntityCoords(LocalPed())) < 1.0 then
        incircle = true
        basiccheck()
      else
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      for i = 1, #modelRock do
        local x = 1768.753
        local y = 2563.388
        local z = 45.565
        local objectCoords = GetEntityCoords(GetPlayerPed(-1))
        if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
          Draw3dText2(x, y, z + 0.2, "돌 운반 완료")
        end
      end
      Citizen.Wait(0)
    end
  end
)

-- 티켓 판매
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      DrawMarker(1, 1788.570, 2598.784, 45.798 - 1.7, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 255, 255, 100, 0, 0, 0, 0) --- The GoPostal depot location
      if GetDistanceBetweenCoords(1788.570, 2598.784, 45.798, GetEntityCoords(LocalPed())) < 1.0 then
        incircle = true
        sellticket()
      end
    end
  end
)

function sellticket()
  if incircle == true then
    drawTxt("티켓을 정산하시려면 ~g~E~s~를 누르세요.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    drawTxt("정산은 10장씩 가능합니다.", 1, 1, 0.5, 0.90, 0.6, 255, 255, 255, 255)
    if (IsControlJustReleased(1, 38)) then
      TriggerServerEvent("ticket:sell")
      Citizen.Wait(1000)
    end
  end
end

Citizen.CreateThread(
  function()
    while true do
      for i = 1, #modelRock do
        local x = 1788.570
        local y = 2598.784
        local z = 45.798
        local objectCoords = GetEntityCoords(GetPlayerPed(-1))
        if (GetDistanceBetweenCoords(x, y, z, objectCoords["x"], objectCoords["y"], objectCoords["z"], true) < 10) then
          Draw3dText(x, y, z + 0.2, "티켓 정산")
        end
      end
      Citizen.Wait(0)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)

      local myCoords = GetEntityCoords(GetPlayerPed(-1))

      for i = 1, #modelRock do
        closestRock = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.0, modelRock[i], false, false)
        if closestRock ~= nil and closestRock ~= 0 then
          coords = GetEntityCoords(closestRock)
          local distance = GetDistanceBetweenCoords(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z, true)
          if distance < 1.5 then
            nearRock = true
            openMenuRock(nearRock, closestRock)
          elseif distance >= 1.50 then
            nearRock = false
          end
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      for k, v in pairs(nodongjang) do
        local x, y, z = table.unpack(v)
        z = z - 1
        local pCoords = GetEntityCoords(GetPlayerPed(-1))
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
        local alpha = math.floor(255 - (distance * 30))
        if alreadyCut[k] ~= nil then
          local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
          if timeDiff < TIM then
            if distance < 5.0 then
              local seconds = math.ceil(cooltime - timeDiff / 1000)
              DrawText3d(x, y, z + 1.5, "~w~ ~r~" .. tostring(seconds) .. "~w~", alpha)
            end
          else
            alreadyCut[k] = nil
          end
        else
          if distance < 1.5 then
            DrawText3d(x, y, z + 1.5, "~c~ ~b~[E]~c~를 눌러 돌을 캐세요!", alpha)
            if (IsControlJustPressed(1, 38)) and drill == true then
              if alreadyCut[k] ~= nil then
                if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
                  alreadyCut[k] = GetGameTimer()
                  TriggerServerEvent("nodong:getminnerOnPalet")
                end
              else
                alreadyCut[k] = GetGameTimer()
                TriggerServerEvent("nodong:getminnerOnPalet")
              end
            elseif drill == false then
              drawTxt("~r~드릴을 대여하세요.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
            end
          elseif distance < 10.0 then
            DrawText3d(x, y, z + 1.5, "~r~채석 구역", alpha)
          end
        end
      end
    end
  end
)

RegisterNetEvent("nodong:getminnerOnPalet")
AddEventHandler(
  "nodong:getminnerOnPalet",
  function()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
    local randomp = math.random(0, 2)
    while (not HasAnimDictLoaded("mp_common")) do
      RequestAnimDict("mp_common")
      Citizen.Wait(5)
    end
    DetachEntity(props, true, false)
    DeleteEntity(props)
    Citizen.Wait(5)
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CONST_DRILL", 0, true)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Citizen.Wait(10000)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    local hash = GetHashKey("prop_rock_5_d")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
      Citizen.Wait(0)
    end
    goobject = CreateObject(RWO, hash, x + randomp, y + randomp, z - 1, true, false)
    Citizen.Wait(300)
    props = CreateObject(RWO, DrillObj, x, y, z, true, true, true)
    AttachEntityToEntity(props, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xdd1c), 0.0, -0.22, 0.39, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    help_message("5초 후 돌이 제거됩니다!")
    Citizen.Wait(5000)
    DeleteEntity(goobject)
  end
)

function openMenuRock(nearRock, modelRock)
  if nearRock == true then
    drawTxt("돌을 주우려면 ~g~E~s~ 를 누르세요!", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    if (IsControlJustPressed(1, 38)) then
      help_message("확인 중")
      Citizen.Wait(200)
      TriggerServerEvent("check:human")
      Citizen.Wait(100000)
    end
  end
  return
end

RegisterNetEvent("continue:human")
AddEventHandler(
  "continue:human",
  function(openMenuRock)
    if modelRock then
      help_message("지도에 표시된 상자로 가세요!")
      while not HasAnimDictLoaded("anim@heists@box_carry@") do
        RequestAnimDict("anim@heists@box_carry@")
        Citizen.Wait(100)
      end
      TaskPlayAnim(GetPlayerPed(PlayerId()), "anim@heists@box_carry@", "idle", 1.0, -1, -1, 50, 0, 0, 0, 0)
      animset = "MOVE_M@DRUNK@SLIGHTLYDRUNK"
      RequestAnimSet(animset)
      while not HasAnimSetLoaded(animset) do
        Citizen.Wait(0)
      end
      SetPedMovementClipset(GetPlayerPed(-1), animset, 1.0)
      ragdoll_chance = 1
      Citizen.Wait(100)
      oldmodelRock = modelRock
      Wait(1000)
      SetEntityCoords(oldmodelRock, 0.0, 0.0, 0.0, false, false, false, true)
      CanLeaveBox = true
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    if CanLeaveBox then
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
      local prop = CreateObject(RWO, HashKeyBox, x, y, z, true, true, true)
      AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x6F06), -0.08, -0.15, -0.22, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
      RequestAnimDict("anim@heists@box_carry@")
      while not HasAnimDictLoaded("anim@heists@box_carry@") do
        Wait(0)
      end
      TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
      repeat
        Citizen.Wait(100)
        if CanLeaveBox == false then
          DeleteEntity(prop)
        end
      until (CanLeaveBox == false)
    end
  end
)

function basiccheck()
  if incircle == true and nearRock == true then
    drawTxt("돌을 내려놓으려면 ~g~E~s~를 누르세요.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    if (IsControlJustReleased(1, 38)) then
      DetachEntity(prop, true, false)
      DeleteEntity(prop)
      --	SetEntityCoords(prop, 0.0, 0.0, 0.0, false, false, false, true)
      CanLeaveBox = false
      RequestAnimDict("anim@heists@box_carry@")
      while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(0)
      end
      TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
      Wait(1000)
      StopAnimTask(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 1.0)
      ResetPedMovementClipset(GetPlayerPed(-1))
      ragdoll_chance = 0
      nearRock = false
      TriggerServerEvent("reward:ticket")
    end
  else
    drawTxt("~r~돌을 들고있지 않습니다.", 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
  end
end

Citizen.CreateThread(
  function()
    while true do
      if ragdoll_chance == 1 then
        DisableControlAction(0, 21, true)
        DisableControlAction(0, 22, true)
        DisableControlAction(0, 69, true)
        DisableControlAction(0, 70, true)
        drawTxt("~r~돌을 운반하는 도중에는 달리기와 점프를 하실 수 없습니다!", 1, 1, 0.5, 0.93, 0.6, 255, 255, 255, 255)
      end
      Citizen.Wait(0)
    end
  end
)

Citizen.CreateThread(
  function()
    local ped = "ig_prolsec_02"
    local model = GetHashKey(ped)

    RequestModel(model)
    while (not HasModelLoaded(model)) do
      Citizen.Wait(1)
    end

    local thePed = CreatePed(RWP, 4, model, 1769.54, 2561.77, 45.56 - 1.0, 130, false, false)

    SetModelAsNoLongerNeeded(model)
    SetEntityHeading(thePed, 98.14)
    FreezeEntityPosition(thePed, true)
    SetEntityInvincible(thePed, true)
    SetBlockingOfNonTemporaryEvents(thePed, true)
  end
)

function DrawText3d(x, y, z, text, alpha)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())

  if onScreen then
    SetTextScale(0.5, 0.5)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, alpha)
    SetTextDropshadow(0, 0, 0, 0, alpha)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
  end
end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
  SetTextFont(6)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

function Draw3dText(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(80, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function Draw3dText2(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(255, 165, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function Draw3dText3(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(255, 0, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function help_message(msg)
  SetTextComponentFormat("STRING")
  AddTextComponentString(msg)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DisplayHelpText(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--MADE IN REALWORLD 2020 MODERATOR @EUNYUL
