---------------------------------------------------------
------------ VRP FlatbedControl, RealWorld MAC ----------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_flatbed_controlC = {}
Tunnel.bindInterface("vrp_flatbed_control", vrp_flatbed_controlC)
Proxy.addInterface("vrp_flatbed_control", vrp_flatbed_controlC)
vRP = Proxy.getInterface("vRP")
vrp_flatbed_controlS = Tunnel.getInterface("vrp_flatbed_control", "vrp_flatbed_control")

local blips = {title = "차량압류센터", colour = 51, id = 460}
local cancelMarkers = {
  {-47.103500366211, -1078.9169921875, 26.916316223145, 8.0},
  {1846.8862304688, 2534.9111328125, 45.672332763672, 8.0},
  {-141.80860900879, 6352.0390625, 31.490657806396, 10.0}
}

function DrawText3D(x, y, z, text, r, g, b, a, s, bg)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  if not s then
    s = 2.5
  end

  local scale = (1 / dist) * s
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 150)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    if bg then
      local factor = (string.len(text)) / 300
      DrawRect(_x, _y + 0.01, 0.015 + factor, 0.025, 0, 0, 0, 50)
    end
  end
end

function BigDelete(entity)
  local playerPed = PlayerPedId()
  carModel = GetEntityModel(entity)
  carName = GetDisplayNameFromVehicleModel(carModel)
  if (NetworkGetNetworkIdFromEntity(entity) ~= nil and NetworkGetNetworkIdFromEntity(entity) > 0) then
    NetworkRequestControlOfEntity(entity)

    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
      Wait(100)
      timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)

    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
      Wait(100)
      timeout = timeout - 100
    end

    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))

    if (DoesEntityExist(entity)) then
      DeleteEntity(entity)
    end
  end
end

function vrp_flatbed_controlC.confirmProcess(pveh, veh)
  DetachEntity(veh, 0, 1)
  DecorSetInt(pveh, "flatbed3_car", 0)
  DecorSetBool(pveh, "flatbed3_attached", false)
  BigDelete(veh)
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      for _, cancelMarker in pairs(cancelMarkers) do
        DrawText3D(cancelMarker[1], cancelMarker[2], cancelMarker[3] - 0.4, "차량 압류 센터", 0, 255, 255, 150, 2.0)
        if cancelMarker[5] and cancelMarker[5] ~= 0 then
          DrawMarker(1, cancelMarker[1], cancelMarker[2], cancelMarker[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cancelMarker[4], cancelMarker[4], 0.5, 0, 255, 0, 200, 0, 0, 0, 0)
        else
          DrawMarker(1, cancelMarker[1], cancelMarker[2], cancelMarker[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cancelMarker[4], cancelMarker[4], 0.2, 255, 255, 255, 150, 0, 0, 0, 0)
        end
      end
    end
  end
)

local lastVeh = nil

Citizen.CreateThread(
  function()
    local modelHash = GetHashKey("flatbed3")
    while true do
      Citizen.Wait(1000)
      local ped = GetPlayerPed(-1)
      if IsPedInAnyVehicle(ped, false) then
        lastVeh = GetVehiclePedIsIn(ped)
      end
      local lastVehCoords = GetEntityCoords(lastVeh)

      for _, cancelMarker in pairs(cancelMarkers) do
        local dist = Vdist(lastVehCoords, vector3(cancelMarker[1], cancelMarker[2], cancelMarker[3]))
        if dist < 1 then
          cancelMarker[5] = lastVeh
        else
          cancelMarker[5] = nil
        end
      end
    end
  end
)

local isPendingCheck = false
local isEnableVeh = nil

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      isEnableVeh = nil
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped)
      local vehNet = DecorGetInt(veh, "flatbed3_car")
      if vehNet and vehNet ~= 0 then
        local veh = NetToVeh(vehNet)
        if veh and veh ~= 0 then
          local vehPlate = GetVehicleNumberPlateText(veh)
          if vehPlate then
            isEnableVeh = veh
          end
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      local pos = GetEntityCoords(isEnableVeh, true)
      if isEnableVeh then
        DrawText3D(pos.x, pos.y, pos.z + 2.0, "~g~압류 가능", 255, 255, 255, 255, 2.5)
      else
        DrawText3D(pos.x, pos.y, pos.z + 2.0, "~r~압류 불가", 255, 255, 255, 255, 2.5)
      end
    end
  end
)

Citizen.CreateThread(
  function()
    ClearPedTasks(GetPlayerPed(-1))
    while true do
      Citizen.Wait(0)
      local ped = GetPlayerPed(-1)
      local playerPos = GetEntityCoords(ped, true)
      local px, py, pz = playerPos.x, playerPos.y, playerPos.z
      local inVeh = IsPedInAnyVehicle(ped, false)

      for _, cancelMarker in pairs(cancelMarkers) do
        local dist = Vdist(playerPos.x, playerPos.y, playerPos.z, cancelMarker[1], cancelMarker[2], cancelMarker[3])
        if dist < cancelMarker[4] / 2 then
          DrawText3D(px, py, pz + 1.0, "~r~[ALT]~w~키를 눌러 차량~g~압류", 255, 255, 255, 255, 1.5)
          if IsControlJustReleased(1, 19) and not isPendingCheck and not inVeh then
            isPendingCheck = true

            ClearPedTasks(ped)
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_YOGA", 0, true)

            exports["progressBars"]:startUI(3000, "압류 진행중..")
            Citizen.Wait(3000)

            local pveh = GetClosestVehicle(cancelMarker[1], cancelMarker[2], cancelMarker[3], cancelMarker[4], 0, 8192 + 4096 + 4 + 2 + 1)
            if not IsEntityAVehicle(pveh) then
              pveh = GetClosestVehicle(cancelMarker[1], cancelMarker[2], cancelMarker[3], cancelMarker[4], 0, 4 + 2 + 1)
            end

            if pveh then
              local vehNet = DecorGetInt(pveh, "flatbed3_car")
              if vehNet and vehNet ~= 0 then
                local veh = NetToVeh(vehNet)
                if veh and veh ~= 0 then
                  local vehPlate = GetVehicleNumberPlateText(veh)
                  if vehPlate then
                    vrp_flatbed_controlS.process({pveh, veh, vehPlate})
                  end
                else
                  vRP.notify({"~r~차량을 압류할 수 없습니다."})
                end
              else
                vRP.notify({"~r~압류할 차량이 없습니다."})
              end
            else
              vRP.notify({"~r~렉카가 주변에 없습니다."})
            end

            ClearPedTasks(ped)
            Citizen.Wait(5000)
            isPendingCheck = false
          end
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    for _, info in pairs(cancelMarkers) do
      local blip = AddBlipForCoord(info[1], info[2], info[3])
      SetBlipSprite(blip, blips.id)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 0.9)
      SetBlipColour(blip, blips.colour)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(blips.title)
      EndTextCommandSetBlipName(blip)
      Citizen.Wait(0)
    end
  end
)
