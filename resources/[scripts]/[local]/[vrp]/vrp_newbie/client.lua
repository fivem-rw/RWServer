----------------- vRP Newbie
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vrp_newbieC = {}
Tunnel.bindInterface("vrp_newbie", vrp_newbieC)
Proxy.addInterface("vrp_newbie", vrp_newbieC)
vrp_newbieS = Tunnel.getInterface("vrp_newbie", "vrp_newbie")

local markers = {}
local marker_ids = Tools.newIDGenerator()

function DrawTextBottom(x, y, width, height, scale, text, r, g, b, a, outline)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  if (outline) then
    SetTextOutline()
  end
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end

function DrawText3D(x, y, z, text, size, color)
  if size == nil then
    size = 2
  end
  if color == nil then
    color = {
      r = 0,
      g = 255,
      b = 0,
      a = 255
    }
  end
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * size
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(color.r, color.g, color.b, color.a)
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

function addBlip(x, y, z, idtype, idcolor, text)
  local blip = AddBlipForCoord(x + 0.001, y + 0.001, z + 0.001)
  SetBlipSprite(blip, idtype)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip, idcolor)

  if text ~= nil then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
  end

  return blip
end

function addMarker(type, x, y, z, sx, sy, sz, r, g, b, a, visible_distance, text, sub_text, text_size, text_color)
  local marker = {
    type = type,
    x = x,
    y = y,
    z = z,
    sx = sx,
    sy = sy,
    sz = sz,
    r = r,
    g = g,
    b = b,
    a = a,
    visible_distance = visible_distance,
    text = text,
    sub_text = sub_text,
    text_size = text_size,
    text_color = text_color
  }

  -- default values
  if marker.sx == nil then
    marker.sx = 2.0
  end
  if marker.sy == nil then
    marker.sy = 2.0
  end
  if marker.sz == nil then
    marker.sz = 0.7
  end

  if marker.r == nil then
    marker.r = 0
  end
  if marker.g == nil then
    marker.g = 155
  end
  if marker.b == nil then
    marker.b = 255
  end
  if marker.a == nil then
    marker.a = 200
  end

  -- fix gta5 integer -> double issue
  marker.x = marker.x + 0.001
  marker.y = marker.y + 0.001
  marker.z = marker.z + 0.001
  marker.sx = marker.sx + 0.001
  marker.sy = marker.sy + 0.001
  marker.sz = marker.sz + 0.001

  if marker.visible_distance == nil then
    marker.visible_distance = 150
  end

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

function addMarkerEx(type, x, y, z, rx, ry, rz, sx, sy, sz, r, g, b, a, visible_distance, text, sub_text, text_size, text_color)
  local id = addMarker(type, x, y, z, sx, sy, sz, r, g, b, a, visible_distance, text, sub_text, text_size, text_color)
  markers[id].rx = rx
  markers[id].ry = ry
  markers[id].rz = rz
  return id
end

local areas = {}

function setArea(name, x, y, z, radius, height, ch_enter, ch_leave)
  local area = {
    x = x + 0.001,
    y = y + 0.001,
    z = z + 0.001,
    radius = radius,
    height = height,
    ch_enter = ch_enter or function()
      end,
    ch_leave = ch_leave or function()
      end
  }

  -- default values
  if area.height == nil then
    area.height = 6
  end

  areas[name] = area
end

local rentedCar = nil

function vrp_newbieC.spawnRentCar(carId, x, y, z, time)
  local mhash = GetHashKey(carId)
  local i = 0
  while not HasModelLoaded(mhash) and i < 1000 do
    RequestModel(mhash)
    Citizen.Wait(30)
    i = i + 1
  end
  if HasModelLoaded(mhash) then
    local nveh = CreateVehicle(RWV, mhash, x, y, z, 20.0, true, false)
    if NetworkGetEntityIsNetworked(nveh) then
      local netId = VehToNet(nveh)
      SetVehicleNumberPlateText(nveh, "RENT")
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh, false)
      SetPedIntoVehicle(GetPlayerPed(-1), nveh, -1)
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetModelAsNoLongerNeeded(mhash)
      rentedCar = {netId = netId, carId = carId, time = time, curTime = 0}
      vrp_newbieS.rentDone({netId, carId, time})
    end
  end
end

function vrp_newbieC.deleteRentCar(netId)
  local veh = NetToVeh(netId)
  if veh ~= nil then
    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)
    DeleteEntity(veh)
    rentedCar = nil
  end
end

addMarker(0, 251.86781311035, -877.30047607422, 30.55309753418, 1.5, 1.5, 0.8, 0, 255, 255, 0, 50, "리얼월드 디스코드", "discord.gg/realw", 4)
addMarker(1, 254.27828979492, -877.61907958984, 29.292175292969, 1.2, 1.2, 0.2, 255, 255, 0, 100, 50, "1.인증코드받기", "리얼월드 디스코드에 인증코드를 입력하세요.", 2.5)
addMarker(1, 253.42100524902, -875.63323974609, 29.292175292969, 1.2, 1.2, 0.2, 0, 255, 0, 100, 50, "2.지원받기", "인증을 완료하고 지원을 받으세요.", 2.5)

setArea(
  "vrp_newbie:getCode1",
  254.27828979492,
  -877.61907958984,
  30.292175292969,
  0.6,
  1.5,
  function()
    vrp_newbieS.getCode()
  end
)
setArea(
  "vrp_newbie:getBonus1",
  253.42100524902,
  -875.63323974609,
  30.292175292969,
  0.6,
  1.5,
  function()
    vrp_newbieS.getBonus()
  end
)

addMarker(0, -2253.2827148438, 258.01110839844, 173.61552429199, 1.5, 1.5, 0.8, 255, 255, 255, 105, 50, "리얼월드에 오신것을 환영합니다.", "ESC - 설정 - 음성채팅 활성화 - 볼륨 및 감도 최대치로 올려주세요", 3, {r = 255, g = 255, b = 0, a = 255})
addMarker(0, -2247.0119628906, 266.61218261719, 175.00157165527, 1.5, 1.5, 0.8, 0, 255, 255, 0, 50, "리얼월드 디스코드", "discord.gg/realw", 4)
addMarker(1, -2247.3249511719, 264.66632080078, 173.61552429199, 1.2, 1.2, 0.2, 255, 255, 0, 100, 50, "1.인증코드받기", "리얼월드 디스코드에 인증코드를 입력하세요.", 2.5)
addMarker(1, -2245.2958984375, 265.61505126953, 173.6155090332, 1.2, 1.2, 0.2, 0, 255, 0, 100, 50, "2.지원받기", "인증을 완료하고 지원을 받으세요.", 2.5)

setArea(
  "vrp_newbie:getCode2",
  -2247.3249511719,
  264.66632080078,
  174.61552429199,
  0.6,
  1.5,
  function()
    vrp_newbieS.getCode()
  end
)
setArea(
  "vrp_newbie:getBonus2",
  -2245.2958984375,
  265.61505126953,
  174.6155090332,
  0.6,
  1.5,
  function()
    vrp_newbieS.getBonus()
  end
)

addMarker(0, -2236.8283691406, 282.00601196289, 173.60162353516, 1.5, 1.5, 0.8, 255, 255, 255, 125, 50, "모든 준비가 끝나셨나요?", "화살표 따라 택시 호출을 통해 메차로 가세요(지도에 메차 모양 아이콘)", 3, {r = 255, g = 255, b = 0, a = 255})
addMarker(0, -2294.1164550781, 373.24462890625, 173.60179138184, 1.5, 1.5, 0.8, 0, 255, 0, 125, 50, "메차로 가는 택시를 호출하세요.", "원안에서 E키를 누르면 호출됩니다.", 3)
setArea(
  "taxi",
  -2294.1164550781,
  373.24462890625,
  174.60179138184,
  1,
  2,
  function()
    vrp_newbieS.callTaxi({-2294.1164550781, 373.24462890625, 173.60179138184})
  end
)
addMarkerEx(21, -2299.9011230469, 368.76080322266, 173.60176086426, 90.2, -90.2, 0, 1.5, 1.5, 0.8, 255, 255, 255, 0, 50, "택시가 없나요?", "화살표를 따라가면 차량을 렌트할 수 있습니다.", 3, {r = 255, g = 255, b = 0, a = 255})
addMarkerEx(21, -2302.5510253906, 365.21704101563, 174.60159301758, 0, -90.2, 0, 2, 2, 2, 255, 255, 0, 125, 50)
addMarker(0, -2311.88671875, 282.75439453125, 168.46722412109, 1.5, 1.5, 0.8, 255, 255, 255, 125, 50, "뉴비 렌트카", "원하는 차량을 렌트하세요.", 3, {r = 255, g = 255, b = 0, a = 255})
addMarker(1, -2314.8193359375, 290.70059204102, 168.46705627441, 2.0, 2.0, 0.2, 255, 255, 0, 125, 50, "렌트카 반납", "차량을 반납하세요.", 3, {r = 255, g = 255, b = 0, a = 255})
setArea(
  "rent_return",
  -2314.8193359375,
  290.70059204102,
  169.46705627441,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
      local veh = GetVehiclePedIsIn(ped, false)
      if NetworkGetEntityIsNetworked(veh) then
        local netId = VehToNet(veh)
        if netId ~= nil then
          vrp_newbieS.rentReturn({netId})
        end
      end
    else
      vRP.notify({"~r~차량에 탑승한 상태에서 반납해주세요."})
    end
  end
)
addMarker(1, -2316.5029296875, 280.79333496094, 168.46719360352, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "현대 엑센트", "10분 10만원", 3)
setArea(
  "rent1",
  -2316.5029296875,
  280.79333496094,
  169.46719360352,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_newbieS.rent({"rent1", -2316.5029296875, 280.79333496094, 168.46719360352})
    end
  end
)
addMarker(1, -2319.4328613281, 279.3356628418, 168.46722412109, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "기아 포르테쿱", "10분 15만원", 3)
setArea(
  "rent2",
  -2319.4328613281,
  279.3356628418,
  169.46722412109,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_newbieS.rent({"rent2", -2319.4328613281, 279.3356628418, 168.46722412109})
    end
  end
)
addMarker(1, -2322.3132324219, 278.26092529297, 168.46722412109, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "현대 벨로스터N", "10분 30만원", 3)
setArea(
  "rent3",
  -2322.3132324219,
  278.26092529297,
  169.46722412109,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_newbieS.rent({"rent3", -2322.3132324219, 278.26092529297, 168.46722412109})
    end
  end
)
addMarker(1, -2325.2727050781, 277.21209716797, 168.46723937988, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "기아 스팅어GT", "10분 40만원", 3)
setArea(
  "rent4",
  -2325.2727050781,
  277.21209716797,
  169.46723937988,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_newbieS.rent({"rent4", -2325.2727050781, 277.21209716797, 168.46723937988})
    end
  end
)
addMarker(1, -2328.1291503906, 275.99099731445, 168.46723937988, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "현대 제네시스 쿠페", "10분 40만원", 3)
setArea(
  "rent5",
  -2328.1291503906,
  275.99099731445,
  169.46723937988,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_newbieS.rent({"rent5", -2328.1291503906, 275.99099731445, 168.46723937988})
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
      for k, v in pairs(markers) do
        -- check visibility
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, px, py, pz, true)
        if dist <= v.visible_distance then
          DrawMarker(v.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, v.rx, v.ry, v.rz, v.sx, v.sy, v.sz, v.r, v.g, v.b, v.a, 0, 0, 0, 0)
          if dist >= 1.5 and dist <= v.visible_distance / 2 then
            DrawText3D(v.x, v.y, v.z + 1.5, v.text, v.text_size, v.text_color or {r = v.r, g = v.g, b = v.b, a = 255})
            if v.sub_text ~= nil and v.sub_text ~= "" then
              DrawText3D(v.x, v.y, v.z + 1.2, v.sub_text, v.text_size * 0.7, {r = 255, g = 255, b = 255, a = 255})
            end
          end
        end
      end
    end
  end
)

local playerInAreaIndex = nil

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(250)

      local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
      playerInAreaIndex = nil

      for k, v in pairs(areas) do
        local player_in = (GetDistanceBetweenCoords(v.x, v.y, v.z, px, py, pz, true) <= v.radius and math.abs(pz - v.z) <= v.height)

        if player_in then
          playerInAreaIndex = k
        end

        if v.player_in and not player_in then -- was in: leave
          v.ch_leave()
          v.player_in = false
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      if playerInAreaIndex ~= nil then
        DrawTextBottom(1.0, 1.0, 1.0, 1.0, 0.6, "~r~E ~w~키를 눌러주세요.", 255, 255, 255, 255)

        if IsControlJustReleased(1, 51) then
          if areas[playerInAreaIndex].player_in then
            areas[playerInAreaIndex].ch_leave()
          end
          areas[playerInAreaIndex].ch_enter()
          areas[playerInAreaIndex].player_in = true
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(100)
      if rentedCar ~= nil then
        rentedCar.curTime = rentedCar.curTime + 1
        if rentedCar.curTime > rentedCar.time and rentedCar.netId ~= nil then
          vrp_newbieS.rentReturn({rentedCar.netId})
          rentedCar = nil
        end
        Citizen.Wait(1000)
      end
    end
  end
)
