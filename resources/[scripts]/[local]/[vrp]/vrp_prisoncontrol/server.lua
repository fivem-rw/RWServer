----------------- vRP PrisonControl
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_prisoncontrol")
vrp_prisoncontrolC = Tunnel.getInterface("vrp_prisoncontrol", "vrp_prisoncontrol")

vrp_prisoncontrolS = {}
Tunnel.bindInterface("vrp_prisoncontrol", vrp_prisoncontrolS)

local isAlarmOn = false
local isScreenOn = false

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    local player = source
    if isAlarmOn then
      vrp_prisoncontrolC.alarmON(player)
    else
      vrp_prisoncontrolC.alarmOFF(player)
    end
    if isScreenOn then
      vrp_prisoncontrolC.screenON(player)
    else
      vrp_prisoncontrolC.screenOFF(player)
    end
  end
)

RegisterNetEvent("vrp_prisoncontrol:g_alarm_on")
AddEventHandler(
  "vrp_prisoncontrol:g_alarm_on",
  function()
    if not isAlarmOn then
      isAlarmOn = true
      vrp_prisoncontrolC.alarmON(-1)
    end
  end
)

RegisterNetEvent("vrp_prisoncontrol:g_alarm_off")
AddEventHandler(
  "vrp_prisoncontrol:g_alarm_off",
  function()
    if isAlarmOn then
      isAlarmOn = false
      vrp_prisoncontrolC.alarmOFF(-1)
    end
  end
)

RegisterNetEvent("vrp_prisoncontrol:g_screen_on")
AddEventHandler(
  "vrp_prisoncontrol:g_screen_on",
  function()
    if not isScreenOn then
      isScreenOn = true
      vrp_prisoncontrolC.screenON(-1)
      TriggerEvent("proxy_vrp_bc:resume", 4)
    end
  end
)

RegisterNetEvent("vrp_prisoncontrol:g_screen_off")
AddEventHandler(
  "vrp_prisoncontrol:g_screen_off",
  function()
    if isScreenOn then
      isScreenOn = false
      vrp_prisoncontrolC.screenOFF(-1)
      TriggerEvent("proxy_vrp_bc:pause", 4)
    end
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(1000)
    vrp_prisoncontrolC.alarmOFF(-1)
    vrp_prisoncontrolC.screenOFF(-1)
  end
)
