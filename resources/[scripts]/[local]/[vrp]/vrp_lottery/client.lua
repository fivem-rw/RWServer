----------------- vRP Lottery
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vrp_lotteryC = {}
Tunnel.bindInterface("vrp_lottery", vrp_lotteryC)
Proxy.addInterface("vrp_lottery", vrp_lotteryC)
vrp_lotteryS = Tunnel.getInterface("vrp_lottery", "vrp_lottery")

local isProgress = false

local markers = {}
local marker_ids = Tools.newIDGenerator()

function notify(msg, type, timer)
  TriggerEvent(
    "pNotify:SendNotification",
    {
      text = msg,
      type = type or "success",
      timeout = timer or 3000,
      layout = "centerleft",
      queue = "global"
    }
  )
end

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

addMarker(1, 238.93173217773, -878.41479492188, 30.492238998413 - 1, 1.2, 1.2, 0.2, 0, 255, 0, 50, 50, "매일 추첨권 구매", "1장당 십만원", 2.5)
setArea(
  "lottery_buy_basic",
  238.93173217773,
  -878.41479492188,
  30.492238998413,
  0.6,
  6,
  function()
    isProgress = true
    vrp_lotteryS.buyLottery({"basic"})
  end
)
addMarker(1, 239.45745849609, -876.90118408203, 30.492238998413 - 1, 1.2, 1.2, 0.2, 0, 255, 255, 50, 50, "고급 추첨권 구매", "1장당 5백만원", 2.5)
setArea(
  "lottery_buy_advanced",
  239.45745849609,
  -876.90118408203,
  30.492238998413,
  0.6,
  6,
  function()
    isProgress = true
    vrp_lotteryS.buyLottery({"advanced"})
  end
)
addMarker(1, 240.24792480469, -874.708984375, 30.49224281311 - 1, 1.2, 1.2, 0.2, 255, 255, 0, 50, 50, "VIP 추첨권 구매", "1장당 5천만원", 2.5)
setArea(
  "lottery_buy_vip",
  240.24792480469,
  -874.708984375,
  30.49224281311,
  0.6,
  2,
  function()
    isProgress = true
    vrp_lotteryS.buyLottery({"vip"})
  end
)
addMarker(1, 220.95143127441, -869.05328369141, 29.492219924927, 1.2, 1.2, 0.2, 255, 0, 255, 100, 100, "[리얼박스 열기]", "~r~[E]~w~키를 눌러 ~g~리얼박스 ~w~열기", 3)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(10)
      local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
      for k, v in pairs(markers) do
        -- check visibility
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, px, py, pz, true)
        if dist <= v.visible_distance then
          DrawMarker(v.type, v.x, v.y, v.z, 0.0, 0.0, 0.0, v.rx, v.ry, v.rz, v.sx, v.sy, v.sz, v.r, v.g, v.b, v.a, 0, 0, 0, 0)
          if dist >= 1.5 and dist <= v.visible_distance / 2 then
            DrawText3D(v.x, v.y, v.z + 1.8, v.text, v.text_size, v.text_color or {r = v.r, g = v.g, b = v.b, a = 255})
            if v.sub_text ~= nil and v.sub_text ~= "" then
              DrawText3D(v.x, v.y, v.z + 1.6, v.sub_text, v.text_size * 0.7, {r = 255, g = 255, b = 255, a = 255})
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

        if not isProgress and IsControlJustReleased(1, 51) then
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
      Citizen.Wait(1)
      if isProgress then
        Citizen.Wait(1000)
        isProgress = false
      end
    end
  end
)

local markers2 = {
  ["basic"] = {240.20806884766, -880.08184814453, 30.492248535156, 1.1, {0, 255, 0, 100}, {"[매일 추첨박스]", "10만-1천만 상당의 상품"}},
  ["advanced"] = {242.18670654297, -880.69104003906, 30.492233276367, 1.1, {0, 255, 255, 100}, {"[고급 추첨박스]", "5천만-10억 상당의 상품"}},
  ["vip"] = {244.12371826172, -881.47534179688, 30.492219924927, 1.1, {255, 255, 0, 100}, {"[VIP 추첨박스]", "5억-100억 상당의 상품"}}
}

local markers3 = {
  ["potion1"] = {246.71891784668, -887.548828125, 30.491380691528, 0.6, {0, 255, 0, 100}, {"[행운의 물약]", "3천만원"}},
  ["potion2"] = {244.98139953613, -888.05480957031, 30.491380691528, 0.6, {255, 0, 255, 100}, {"[강화된 행운의 물약]", "5천만원"}},
  ["potion3"] = {243.28219604492, -888.83728027344, 30.491380691528, 0.6, {255, 0, 0, 100}, {"[강력한 행운의 물약]", "1억원"}}
}

local isAutoBet = false
local autoBetType = nil

Citizen.CreateThread(
  function()
    Citizen.Wait(500)
    while true do
      Citizen.Wait(1)
      local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
      local isSelect = false
      local selectBetType = nil
      for k, v in pairs(markers2) do
        DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
        v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
        if v.dist < v[4] then
          isSelect = true
          selectBetType = k
          if isAutoBet then
            DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~g~자동추첨중.. ~y~[Z]~w~키 ~b~자동추첨 종료", 1.5)
          else
            DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~y~[E]~w~키 ~g~추첨 ~w~/ ~y~[Z]~w~키 ~b~자동추첨", 1.5)
          end
          if not isAutoBet and IsControlJustReleased(1, 51) then
            vrp_lotteryS.lottery({k})
          elseif IsControlJustReleased(1, 20) then
            if isAutoBet then
              isAutoBet = false
              autoBetType = nil
              notify("자동추첨이 종료되었습니다.", "warning")
            else
              isAutoBet = true
              autoBetType = k
              notify("자동추첨이 시작되었습니다.", "success")
            end
          end
        end
      end
      if not isSelect then
        for k, v in pairs(markers2) do
          if v.dist > v[4] and v.dist < 10 then
            DrawText3D(v[1], v[2], v[3] + 0.8, v[6][1], 2.1, {r = v[5][1], g = v[5][2], b = v[5][3], a = 250})
            DrawText3D(v[1], v[2], v[3] + 0.6, v[6][2], 1.5, {r = 255, g = 255, b = 255, a = 250})
          end
        end
      end
      if isAutoBet and (not isSelect or selectBetType ~= autoBetType) then
        isAutoBet = false
        autoBetType = nil
        notify("자동추첨이 종료되었습니다.", "warning")
      end
    end
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(500)
    while true do
      Citizen.Wait(3000)
      if isAutoBet and autoBetType then
        vrp_lotteryS.lottery(
          {autoBetType},
          function(status)
            if not status then
              isAutoBet = false
              autoBetType = nil
              notify("자동추첨이 종료되었습니다.", "warning")
            end
          end
        )
      end
    end
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(500)
    while true do
      Citizen.Wait(1)
      local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
      local isSelect = false
      local selectBetType = nil
      for k, v in pairs(markers3) do
        DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
        v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
        if v.dist < v[4] then
          isSelect = true
          selectBetType = k
          DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~y~[E]~w~키를 눌러 구매", 1.5)
          if not isAutoBet and IsControlJustReleased(1, 51) then
            vrp_lotteryS.buyLuckyPotion({k})
          end
        end
      end
      if not isSelect then
        for k, v in pairs(markers3) do
          if v.dist > v[4] and v.dist < 10 then
            DrawText3D(v[1], v[2], v[3] + 0.8, v[6][1], 2.1, {r = v[5][1], g = v[5][2], b = v[5][3], a = 250})
            DrawText3D(v[1], v[2], v[3] + 0.6, v[6][2], 1.5, {r = 255, g = 255, b = 255, a = 250})
          end
        end
      end
    end
  end
)
