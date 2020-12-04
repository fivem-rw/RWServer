vRP = Proxy.getInterface("vRP")
vRP_pizzaS = Tunnel.getInterface("vRP_pizza", "vRP_pizza")

--{"domino",-1533.0656738281, -423.15625, 35.591945648193},
local pizzeria = {x = -1533.0552978516, y = -423.16159057617, z = 34.587196350098}
--local spawnfaggio = { x = -1278.39, y = -1386.84, z = 3.38 }
local spawnfaggio = {x = -1529.8806152344, y = -419.03216552734, z = 35.591934204102}

local propina = 0

local casas = {
  [1] = {name = "바인우드 힐즈", x = -1220.50, y = 666.95, z = 143.10},
  [2] = {name = "바인우드 힐즈", x = -1338.97, y = 606.31, z = 133.37},
  [3] = {name = "락포드 힐즈", x = -1051.85, y = 431.66, z = 76.06},
  [4] = {name = "락포드 힐즈", x = -904.04, y = 191.49, z = 68.44},
  [5] = {name = "락포드 힐즈", x = -21.58, y = -23.70, z = 72.24},
  [6] = {name = "하윅", x = -904.04, y = 191.49, z = 68.44},
  [7] = {name = "알타 스트리트", x = 225.39, y = -283.63, z = 28.25},
  [8] = {name = "필박스 힐", x = 5.62, y = -707.72, z = 44.97},
  [9] = {name = "미션 로우", x = 284.50, y = -938.50, z = 28.35},
  [10] = {name = "랜초", x = 411.59, y = -1487.54, z = 29.14},
  [11] = {name = "데이비스", x = 85.19, y = -1958.18, z = 20.12},
  [12] = {name = "Chamberlain Hills", x = -213.00, y = -1617.35, z = 37.35},
  [13] = {name = "라 푸에르타", x = -1015.65, y = -1515.05, z = 5.51}
}

local isInJobPizz = false
local sigcasa = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToDoor = false
local isPizza = false
local isMotteruPizza = false -- 초기선언
local multiplicador_De_dinero = 100
local paga = 0

local px = 0
local py = 0
local pz = 0

local blips = {
  {title = "도미노피자", colour = 66, id = 267, x = -1533.0552978516, y = -423.16159057617, z = 35.587196350098}
}

-------------------------------------------
--------------------BLIPS------------------
-------------------------------------------

Citizen.CreateThread(
  function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
  end
)

function Iracasa(casas, sigcasa)
  blip_casa = AddBlipForCoord(casas[sigcasa].x, casas[sigcasa].y, casas[sigcasa].z)
  SetBlipSprite(blip_casa, 1)
  SetNewWaypoint(casas[sigcasa].x, casas[sigcasa].y)
end

function DoAction(index)
  Citizen.CreateThread(
    function()
      RequestModel(GetHashKey(config.actions[index].animObjects.name))
      while not HasModelLoaded(GetHashKey(config.actions[index].animObjects.name)) do
        Citizen.Wait(100)
      end

      RequestAnimDict(config.actions[index].animDictionary)
      while not HasAnimDictLoaded(config.actions[index].animDictionary) do
        Citizen.Wait(100)
      end

      local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
      local objSpawned = CreateObject(RWO, GetHashKey(config.actions[index].animObjects.name), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
      Citizen.Wait(100)
      local netid = ObjToNet(objSpawned)
      SetNetworkIdExistsOnAllMachines(netid, true)
      NetworkSetNetworkIdDynamic(netid, true)
      SetNetworkIdCanMigrate(netid, false)
      AttachEntityToEntity(objSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), config.actions[index].animObjects.xoff, config.actions[index].animObjects.yoff, config.actions[index].animObjects.zoff, config.actions[index].animObjects.xrot, config.actions[index].animObjects.yrot, config.actions[index].animObjects.zrot, 1, 1, 0, 1, 0, 1)
      TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
      TaskPlayAnim(GetPlayerPed(PlayerId()), config.actions[index].animDictionary, config.actions[index].animationName, 1.0, -1, -1, 50, 0, 0, 0, 0)
      obj_net = netid
      currentAction = index

      --[[if index == "give_item" then
			local distance = GetClosestPlayer()
			if (distance ~= -1 and distance < 3) then
				local one = GetPlayerServerId(GetClosestPlayer())
				TriggerServerEvent("arm:GiveItem", one, currentAction)
				ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
				DetachEntity(NetToObj(obj_net), 1, 1)
				DeleteEntity(NetToObj(obj_net))
				obj_net = nil
				currentAction = "none"
				return
			else
				TriggerEvent('chatMessage', "^1[SYSTEM]:^0 No players are near you.")
				return
			end
        end
        if currentAction ~= "none" then
			ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
			DetachEntity(NetToObj(obj_net), 1, 1)
			DeleteEntity(NetToObj(obj_net))
			obj_net = nil
			currentAction = "none"
        end
        if index == "none" then
			ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
			DetachEntity(NetToObj(obj_net), 1, 1)
			DeleteEntity(NetToObj(obj_net))
			obj_net = nil
            currentAction = "none"
            return
        end]]
      --
    end
  )
end

function DrawText3D(x, y, z, text, r, g, b) -- some useful function, use it if you want!
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(r, g, b, 255)
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

-------------------------------------------
------------------CITIZENS-----------------
-------------------------------------------

RegisterNetEvent("okpizza")
AddEventHandler(
  "okpizza",
  function()
    DoAction("pizza_delivery")
    isMotteruPizza = true
    isInJobPizz = true
    spawn_faggio()
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if isInJobPizz == false then
        DrawMarker(1, pizzeria.x, pizzeria.y, pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 255, 255, 51, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1), true)) < 1.5 then
          --drawTxt("[E] 키를 눌러 배달을 시작합니다.",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
          TriggerEvent("mt:missiontext", "~b~Z~w~ 키를 눌러 배달을 시작합니다", 3000)
          -- 오토바이에 3D 텍스트
          if IsControlJustPressed(1, 20) then
            vRP_pizzaS.checkjob({})
          end
        end
      end

      if isMotteruPizza == true then
        TriggerEvent("mt:missiontext", "~b~E~w~ 키를 눌러 오토바이에 피자를 보관하세요", 3000)
        -- 오토바이에 3D 텍스트
        if IsControlJustPressed(1, 38) then
          if GetDistanceBetweenCoords(spawnfaggio.x, spawnfaggio.y, spawnfaggio.z, GetEntityCoords(GetPlayerPed(-1), true)) < 2 then
            -- 만약 E키 누르면 피자 사라짐, 오토바이에 가까이 갔는가
            DetachEntity(NetToObj(obj_net), 1, 1)
            DeleteEntity(NetToObj(obj_net))
            ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
            sigcasa = math.random(1, 13)
            -- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, sigcasa)
            px = casas[sigcasa].x
            py = casas[sigcasa].y
            pz = casas[sigcasa].z
            distancia = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px, py, pz))
            paga = distancia * multiplicador_De_dinero
            -- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, distancia)
            Iracasa(casas, sigcasa)

            destinol = casas[sigcasa].name
            TriggerEvent("mt:missiontext", "~b~" .. destinol .. "~w~ 지점에 배달하세요", 3000)
            isMotteruPizza = false
            Citizen.Wait(2000)
            isToHouse = true
          else
            vRP.notify({"~r~오토바이에 더 가까이 가세요!"})
          end
        end
      end

      if isToHouse == true then
        DrawMarker(1, casas[sigcasa].x, casas[sigcasa].y, casas[sigcasa].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 255, 255, 51, 200, 0, 0, 0, 0)
        if IsControlJustPressed(1, 38) then
          if isPizza == false then
            if IsInVehicle() then
              vRP.notify({"~r~피자를 다시 꺼내려면\n오토바이에서 내려야 합니다!"})
            else
              vRP.notify({"~g~피자를 다시 꺼냈습니다"})
              DoAction("pizza_delivery") -- 모션 열고tmax
              isPizza = true
            end
          else
            if IsInVehicle() then
              vRP.notify({"~r~피자를 다시 보관하려면\n오토바이에서 내려야 합니다!"})
            else
              if GetDistanceBetweenCoords(PizzaPos.x, PizzaPos.y, PizzaPos.z, GetEntityCoords(GetPlayerPed(-1), true)) < 1.5 then
                vRP.notify({"~g~피자를 다시 넣었습니다"})
                DetachEntity(NetToObj(obj_net), 1, 1) -- 모션 닫고
                DeleteEntity(NetToObj(obj_net))
                ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
                isPizza = false
              else
                vRP.notify({"~r~오토바이에 더 가까이 가세요!"})
              end
            end
          end
        end
      end

      if isPizza == true then
        if GetDistanceBetweenCoords(px, py, pz, GetEntityCoords(GetPlayerPed(-1), true)) < 3 then
          TriggerEvent("mt:missiontext", "~b~Z~w~ 키를 눌러 미션을 완료하세요!", 3000)
          if IsControlJustPressed(1, 20) then
            --Citizen.Wait(2000)
            propina = math.random(100000, 300000)
            vRP.notify({"~g~" .. propina .. "  ~w~받음"})
            vRP_pizzaS.propina({propina})

            DetachEntity(NetToObj(obj_net), 1, 1) -- 모션 닫고
            DeleteEntity(NetToObj(obj_net))
            ClearPedSecondaryTask(GetPlayerPed(PlayerId()))

            isToPizzaria = true
            isToHouse = false
            isPizza = false
            RemoveBlip(blip_casa)
            SetNewWaypoint(pizzeria.x, pizzeria.y)
          end
        end
      else
        if px ~= 0 and GetDistanceBetweenCoords(px, py, pz, GetEntityCoords(GetPlayerPed(-1), true)) < 2 then
          TriggerEvent("mt:missiontext", "~r~보관된 피자를 꺼내오세요!", 3000)
        end
      end

      if isToPizzaria == true then
        TriggerEvent("mt:missiontext", "오토바이를 반납하세요!", 3000)
        DrawMarker(1, pizzeria.x, pizzeria.y, pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001, 255, 255, 51, 200, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1), true)) < 3 then
          TriggerEvent("mt:missiontext", "~b~E~w~ 키를 눌러 오토바이를 반납합니다", 3000)
          if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("tmax")) then
            if IsControlJustPressed(1, 38) then
              if IsInVehicle() then
                vRP.notify({"거리 배달료\n~g~" .. paga .. "  ~w~받음"})
                vRP_pizzaS.propina({paga})
                isToHouse = false
                isToDoor = false
                isToPizzaria = false
                isInJobPizz = false
                isMotteruPizza = false
                paga = 0
                px = 0
                py = 0
                pz = 0
                local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                SetEntityAsMissionEntity(vehicleu, true, true)
                deleteCar(vehicleu)
              else
                --TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"I will not pay you if you do not give me my bike, I'm sorry.")
                vRP.notify({"~r~오토바이에 타고 있어야 합니다!"})
              end
            end
          else
            --TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"I will not pay you if you do not give me my bike, I'm sorry.")
            vRP.notify({"~r~오토바이에 타고 있어야 합니다!"})
          end
        end
      end
      if IsEntityDead(GetPlayerPed(-1)) then
        isInJobPizz = false
        isMotteruPizza = false
        sigcasa = 0
        isToHouse = false
        isToPizzaria = false
        isToDoor = false
        paga = 0
        px = 0
        py = 0
        pz = 0
      end
    end
  end
)

-------------------------------------------
----------------FUNCIONES------------------
-------------------------------------------

function spawn_faggio()
  Citizen.Wait(0)

  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey("tmax")

  RequestModel(vehicle)

  while not HasModelLoaded(vehicle) do
    Wait(1)
  end

  local plate = math.random(100, 900)
  local spawned_car = CreateVehicle(RWV, vehicle, spawnfaggio.x, spawnfaggio.y, spawnfaggio.z, 431.436, -996.786, 25.1887, true, false)

  local plate = "CTZN" .. math.random(100, 300)
  SetVehicleNumberPlateText(spawned_car, plate)
  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleLivery(spawned_car, 2)
  --SetPedIntoVehicle(myPed, spawned_car, - 1)
  SetModelAsNoLongerNeeded(vehicle)
  Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function round(num, numDecimalPlaces)
  local mult = 5 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function deleteCar(entity)
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-------------------------------------------
----------FUNCIONES ADICIONALES------------
-------------------------------------------

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
  SetTextFont(font)
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
