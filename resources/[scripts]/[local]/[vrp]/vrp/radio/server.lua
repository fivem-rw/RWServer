RegisterServerEvent("chatCommandEntered")
RegisterServerEvent("chatMessageEntered")
AddEventHandler(
  "chatMessage",
  function(p, color, msg)
    if msg:sub(1, 1) == "/" then
      fullcmd = stringSplit(msg, " ")
      cmd = fullcmd[1]

      if cmd == "/radio" then
        if not fullcmd[2] then
          TriggerClientEvent("chatMessage", p, "^1Usage", {0, 0, 0}, "^1/radio URL")
        else
          TriggerClientEvent("playradio", p, fullcmd[2])
        end

        CancelEvent()
      elseif cmd == "/volume" then
        if not fullcmd[2] then
          TriggerClientEvent("chatMessage", p, "^1Usage", {0, 0, 0}, "^1/volume (0.0 - 1.0)")
        else
          TriggerClientEvent("changevolume", p, fullcmd[2])
        end

        CancelEvent()
      elseif cmd == "/moff" then
        TriggerClientEvent("stopradio", p)
        CancelEvent()
      elseif cmd == "/mon" then
        TriggerClientEvent("playradio", p, "http://218.150.35.59:8000/stream")
        CancelEvent()
      end
    end
  end
)

function stringSplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  i = 1
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

local choice_radioon = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      TriggerClientEvent("playradio", player, "http://218.150.35.59:8000/stream")
      CancelEvent()
    end
  end,
  "RealWorld.FM을 재생합니다."
}

local choice_radiooff = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      TriggerClientEvent("stopradio", player)
      CancelEvent()
    end
  end,
  "RealWorld.FM을 종료합니다."
}

local choice_changevolume = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      TriggerClientEvent("changevolume", player)
      CancelEvent()
    end
  end,
  "채팅창에 /volume 1 부터 0.001까지 원하는 값으로 맞춰서 사용 하시면 됩니다!"
}

-- add choices to the menu
vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local player = data.player

    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local choices = {}

      if vRP.hasPermission(user_id, "player.phone") then
        choices["라디오"] = {
          function(player, choice)
            vRP.buildMenu(
              "radio",
              {player = player},
              function(menu)
                menu.name = "Radio"
                menu.css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}

                if vRP.hasPermission(user_id, "player.phone") then
                  menu["1. RealWorld.FM 켜기"] = choice_radioon
                end

                if vRP.hasPermission(user_id, "player.phone") then
                  menu["2. RealWorld.FM 끄기"] = choice_radiooff
                end

                if vRP.hasPermission(user_id, "player.phone") then
                  menu["소리 조절 방법"] = choice_changevolume
                end
                vRP.openMenu(player, menu)
              end
            )
          end
        }
      end

      add(choices)
    end
  end
)
