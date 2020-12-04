local protectMode = false
local setTimer = 0
local currentCount = 0
local activeCount = 5

AddEventHandler(
  "explosionEvent",
  function(sender, ev)
    if currentCount >= activeCount or protectMode then
      if not protectMode then
        protectMode = true
        TriggerClientEvent("zone2:changeMode", -1, "protect")
        TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[알림] ^8폭발이 감지되어 핵 방어구역이 활성화되었습니다.")
      end

      setTimer = 120
    end

    currentCount = currentCount + 1

    if ev.ownerNetId == 0 and ev.isAudible == true then
    --ev.damageScale = 0.0
    --CancelEvent()
    end
    --print("explosionEvent", GetPlayerName(sender), json.encode(ev))
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(100)
    while true do
      currentCount = 0
      Citizen.Wait(30000)
    end
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(100)
    while true do
      if protectMode then
        if setTimer >= 0 then
          setTimer = setTimer - 1
        else
          protectMode = false
          currentCount = 0
          TriggerClientEvent("zone2:changeMode", -1, "default")
          TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[알림] ^2핵 방어구역이 해제되었습니다.")
        end
      end
      Citizen.Wait(1000)
    end
  end
)
