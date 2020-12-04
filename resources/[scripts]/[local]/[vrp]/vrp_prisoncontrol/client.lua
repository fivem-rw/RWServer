----------------- vRP PrisonControl
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vrp_prisoncontrolC = {}
Tunnel.bindInterface("vrp_prisoncontrol", vrp_prisoncontrolC)
Proxy.addInterface("vrp_prisoncontrol", vrp_prisoncontrolC)
vrp_prisoncontrolS = Tunnel.getInterface("vrp_prisoncontrol", "vrp_prisoncontrol")

function vrp_prisoncontrolC.alarmON()
  local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

  RefreshInterior(alarmIpl)
  EnableInteriorProp(alarmIpl, "prison_alarm")

  Citizen.CreateThread(
    function()
      while not PrepareAlarm("PRISON_ALARMS") do
        Citizen.Wait(100)
      end
      StartAlarm("PRISON_ALARMS", true)
    end
  )
end

function vrp_prisoncontrolC.alarmOFF()
  local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

  RefreshInterior(alarmIpl)
  DisableInteriorProp(alarmIpl, "prison_alarm")

  Citizen.CreateThread(
    function()
      while not PrepareAlarm("PRISON_ALARMS") do
        Citizen.Wait(100)
      end
      StopAllAlarms(true)
    end
  )
end

function vrp_prisoncontrolC.screenON()
  local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

  RefreshInterior(alarmIpl)
  EnableInteriorProp(alarmIpl, "prison_screen")
end

function vrp_prisoncontrolC.screenOFF()
  local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

  RefreshInterior(alarmIpl)
  DisableInteriorProp(alarmIpl, "prison_screen")
end