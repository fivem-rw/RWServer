----------------- vRP Lottery
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vrp_lottery_goldC = {}
Tunnel.bindInterface("vrp_lottery_gold", vrp_lottery_goldC)
Proxy.addInterface("vrp_lottery_gold", vrp_lottery_goldC)
vrp_lottery_goldS = Tunnel.getInterface("vrp_lottery_gold", "vrp_lottery_gold")

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
  {237.12724304199, -888.35870361328, 30.520883560181, 1.5, {255, 255, 0, 100}, {"[골드 추첨박스]", "금이 쏟아진다!"}, "gold"},
  {1774.3234863281, 2574.5314941406, 45.798046112061, 1.5, {255, 255, 0, 100}, {"[골드 추첨박스]", "금이 쏟아진다!"}, "gold"}
}

local markers3 = {
  ["make_goldbar"] = {234.76235961914, -884.42102050781, 30.520881652832, 1.0, {255, 255, 0, 100}, {"[골드바 제작]", "~g~[E]~w~키를 눌러 제작하기"}}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(500)
    while true do
      Citizen.Wait(1)
      local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
      local isSelect = false
      local selectBetType = nil
      for k, v in pairs(markers2) do
        DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5, 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
        v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
        if v.dist < v[4] then
          isSelect = true
          selectBetType = v[7]
          DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~y~[E]~w~키를 눌러 ~g~추첨~w~시작", 1.5)
          if IsControlJustReleased(1, 51) then
            vrp_lottery_goldS.lotteryGold({selectBetType})
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
    end
  end
)

function LoadAnim(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

local isMakeProcess = false

function vrp_lottery_goldC.playSuccessAnim()
  ClearPedTasksImmediately(GetPlayerPed(-1))
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CHEERING", 0, true)
  Citizen.Wait(5000)
  ClearPedTasks(GetPlayerPed(-1))
  isMakeProcess = false
end

function vrp_lottery_goldC.playFailedAnim()
  ClearPedTasksImmediately(GetPlayerPed(-1))
  local ChosenDict = "gestures@m@standing@casual"
  LoadAnim(ChosenDict)
  TaskPlayAnim(GetPlayerPed(-1), ChosenDict, "gesture_damn", 2.0, 2.0, 1000, 51, 0, false, false, false)
  RemoveAnimDict(ChosenDict)
  isMakeProcess = false
end

function vrp_lottery_goldC.startMakeGoldbar()
  ClearPedTasks(GetPlayerPed(-1))
  TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
  exports["progressBars"]:startUI(10000, "골드바를 제작하는중..")
  Citizen.Wait(10000)
  vrp_lottery_goldS.makeGoldbar()
  ClearPedTasks(GetPlayerPed(-1))
end

function vrp_lottery_goldC.stopMakeGoldbar()
  isMakeProcess = false
end

Citizen.CreateThread(
  function()
    Citizen.Wait(500)
    while true do
      Citizen.Wait(1)
      local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
      local isSelect = false
      local selectBetType = nil
      for k, v in pairs(markers3) do
        DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
        v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
        if v.dist < v[4] then
          isSelect = true
          selectBetType = k
          DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~y~[E]~w~키를 눌러 ~g~제작~w~시작", 1.5)
          if not isMakeProcess and IsControlJustReleased(1, 51) then
            isMakeProcess = true
            vrp_lottery_goldS.checkMakeGoldbar(
              {},
              function(valid)
                if not valid then
                  isMakeProcess = false
                  notify("골드바를 제작할 수 없습니다.", "error")
                end
              end
            )
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
