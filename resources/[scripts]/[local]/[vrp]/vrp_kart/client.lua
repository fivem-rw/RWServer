vRP = Proxy.getInterface("vRP")
vrp_kartC = {}
Tunnel.bindInterface("vrp_kart", vrp_kartC)
Proxy.addInterface("vrp_kart", vrp_kartC)
vrp_kartS = Tunnel.getInterface("vrp_kart", "vrp_kart")

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

function vrp_kartC.spawnRentCar(carId, x, y, z, time)
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
      vrp_kartS.rentDone({netId, carId, time})
    end
  end
end

function vrp_kartC.deleteRentCar(netId)
  local veh = NetToVeh(netId)
  if veh ~= nil then
    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)
    DeleteEntity(veh)
    rentedCar = nil
  end
end

addMarker(1, -1739.1336669922, -1133.0308837891, 11.998779296875, 2.0, 2.0, 0.2, 255, 255, 255, 125, 50, "[카트 반납]", "차량을 반납하세요.", 3, {r = 255, g = 255, b = 0, a = 255})
setArea(
  "rent_return",
  -1739.1336669922,
  -1133.0308837891,
  12.998779296875,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
      local veh = GetVehiclePedIsIn(ped, false)
      if NetworkGetEntityIsNetworked(veh) then
        local netId = VehToNet(veh)
        if netId ~= nil then
          vrp_kartS.rentReturn({netId})
        end
      end
    else
      vRP.notify({"~r~차량에 탑승한 상태에서 반납해주세요."})
    end
  end
)
addMarker(1, -1736.5024414063, -1129.8117675781, 11.998778343201, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[람보 카트]", "10분 20만원", 3)
setArea(
  "kart_rent1",
  -1736.5024414063,
  -1129.8117675781,
  12.998778343201,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent1", -1736.5024414063, -1129.8117675781, 12.998778343201})
    end
  end
)
addMarker(1, -1733.6793212891, -1132.3793945313, 11.998779296875, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[레이싱 카트3]", "10분 50만원", 3)
setArea(
  "kart_rent2",
  -1733.6793212891,
  -1132.3793945313,
  12.998779296875,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent2", -1733.6793212891, -1132.3793945313, 12.998779296875})
    end
  end
)
addMarker(1, -1731.0422363281, -1134.6076660156, 11.998779296875, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[레이싱 카트20]", "10분 50만원", 3)
setArea(
  "kart_rent3",
  -1731.0422363281,
  -1134.6076660156,
  12.998779296875,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent3", -1731.0422363281, -1134.6076660156, 12.998779296875})
    end
  end
)
addMarker(1, -1728.3079833984, -1136.8482666016, 11.998779296875, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[쉬프터 카트]", "10분 60만원", 3)
setArea(
  "kart_rent4",
  -1728.3079833984,
  -1136.8482666016,
  12.998779296875,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent4", -1728.3079833984, -1136.8482666016, 12.998779296875})
    end
  end
)

addMarker(1, -1895.3278808594, -3112.212890625, 13.735702514648, 2.0, 2.0, 0.2, 255, 255, 255, 125, 50, "[카트 반납]", "차량을 반납하세요.", 3, {r = 255, g = 255, b = 0, a = 255})
setArea(
  "rent_return",
  -1895.3278808594,
  -3112.212890625,
  14.735702514648,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
      local veh = GetVehiclePedIsIn(ped, false)
      if NetworkGetEntityIsNetworked(veh) then
        local netId = VehToNet(veh)
        if netId ~= nil then
          vrp_kartS.rentReturn({netId})
        end
      end
    else
      vRP.notify({"~r~차량에 탑승한 상태에서 반납해주세요."})
    end
  end
)
addMarker(1, -1890.4044189453, -3115.275390625, 13.490140914917, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[람보 카트]", "10분 20만원", 3)
setArea(
  "kart_rent1",
  -1890.4044189453,
  -3115.275390625,
  14.490140914917,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent1", -1890.4044189453, -3115.275390625, 14.490140914917})
    end
  end
)
addMarker(1, -1888.2546386719, -3111.748046875, 13.485640525818, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[레이싱 카트3]", "10분 50만원", 3)
setArea(
  "kart_rent2",
  -1888.2546386719,
  -3111.748046875,
  14.485640525818,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent2", -1888.2546386719, -3111.748046875, 14.485640525818})
    end
  end
)
addMarker(1, -1886.32421875, -3108.2856445313, 13.488381385803, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[레이싱 카트20]", "10분 50만원", 3)
setArea(
  "kart_rent3",
  -1886.32421875,
  -3108.2856445313,
  14.488381385803,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent3", -1886.32421875, -3108.2856445313, 14.488381385803})
    end
  end
)
addMarker(1, -1884.5283203125, -3104.900390625, 13.494752883911, 2.0, 2.0, 0.2, 0, 255, 0, 125, 50, "[쉬프터 카트]", "10분 60만원", 3)
setArea(
  "kart_rent4",
  -1884.5283203125,
  -3104.900390625,
  14.494752883911,
  1.0,
  1.5,
  function()
    local ped = PlayerPedId()
    if not IsPedSittingInAnyVehicle(ped) then
      vrp_kartS.rent({"kart_rent4", -1884.5283203125, -3104.900390625, 14.494752883911})
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
          vrp_kartS.rentReturn({rentedCar.netId})
          rentedCar = nil
        end
        Citizen.Wait(1000)
      end
    end
  end
)
