---------------------------------------------------------
------------ VRP Reboot, RealWorld MAC ------------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_rebootC = {}
Tunnel.bindInterface("vrp_reboot", vrp_rebootC)
Proxy.addInterface("vrp_reboot", vrp_rebootC)
vRP = Proxy.getInterface("vRP")
vrp_rebootS = Tunnel.getInterface("vrp_reboot", "vrp_reboot")

local isSetLight = true
local remainTime = 0

function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end

function vrp_rebootC.setRebootTime(time)
  remainTime = time
end

function vrp_rebootC.setLight(set)
  isSetLight = set
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      if isSetLight then
        SetArtificialLightsState(false)
      else
        SetArtificialLightsState(true)
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if remainTime > 0 then
        DrawTxt(0.40, 0.05, 0.00, 0.00, 0.41, "~w~서버 리붓까지 남은시간: ~r~" .. parseInt(remainTime) .. "초", 255, 255, 255, 255)
        DrawTxt(0.40, 0.08, 0.00, 0.00, 0.41, "~y~안전한곳에서 게임 종료바랍니다.", 255, 255, 255, 255)
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      if remainTime > 0 then
        remainTime = remainTime - 1
      end
    end
  end
)
