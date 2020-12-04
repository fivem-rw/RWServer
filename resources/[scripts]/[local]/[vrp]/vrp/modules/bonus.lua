function vRP.openNewbieBox(user_id)
  math.randomseed(os.time())
  local rand = math.random(1, 100000)
  local amount = 0
  if rand == 77777 then
    amount = math.random(100000 * 10000, 1000000 * 10000)
  elseif rand > 99000 then
    amount = math.random(10000 * 10000, 50000 * 10000)
  elseif rand > 95000 then
    amount = math.random(10000 * 10000, 30000 * 10000)
  elseif rand > 90000 then
    amount = math.random(5000 * 10000, 20000 * 10000)
  elseif rand > 80000 then
    amount = math.random(5000 * 10000, 10000 * 10000)
  elseif rand > 70000 then
    amount = math.random(5000 * 10000, 9000 * 10000)
  elseif rand > 60000 then
    amount = math.random(5000 * 10000, 8000 * 10000)
  elseif rand > 50000 then
    amount = math.random(5000 * 10000, 7000 * 10000)
  else
    amount = math.random(5000 * 10000, 6000 * 10000)
  end
  local available = false
  local data = vRP.getUserDataTable(user_id)
  if data then
    if data.newbie_box_count then
      if data.newbie_box_count < 1 then
        data.newbie_box_count = data.newbie_box_count + 1
        available = true
      end
    else
      data.newbie_box_count = 1
      available = true
    end
  end
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    if available then
      if vRP.tryGetInventoryItem(user_id, "newbie_box", 1) then
        vRPclient.notify(player, {"~g~상자를 열었습니다."})
        vRP.giveMoney(user_id, amount)
        vRP.giveInventoryItem(user_id, "jtjc2", 5, true)
        vRPclient.notify(player, {"~g~상자에서 " .. format_num(amount) .. "원이 나왔습니다!"})
        TriggerClientEvent("chatMessage", -1, "뉴비지원상자 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2" .. format_num(amount) .. "원^0과 ^2뉴비지원키트^0 5개가 나왔습니다!")
      end
    else
      vRPclient.notify(player, {"~g~상자를 열수있는 한도를 초과했습니다."})
    end
  end
end

function vRP.openBonusBox(user_id)
  math.randomseed(os.time())
  local rand = math.random(1, 100000)
  local amount = 0
  if rand == 77777 then
    amount = math.random(10000 * 10000, 200000 * 10000)
  elseif rand > 90000 then
    amount = math.random(1000 * 10000, 9000 * 10000)
  elseif rand > 80000 then
    amount = math.random(1000 * 10000, 8000 * 10000)
  elseif rand > 70000 then
    amount = math.random(1000 * 10000, 7000 * 10000)
  elseif rand > 60000 then
    amount = math.random(1000 * 10000, 6000 * 10000)
  elseif rand > 50000 then
    amount = math.random(1000 * 10000, 5000 * 10000)
  else
    amount = math.random(1000 * 10000, 2000 * 10000)
  end
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    if vRP.tryGetInventoryItem(user_id, "bonus_box", 1) then
      vRPclient.notify(player, {"~g~상자를 열었습니다."})
      vRP.giveMoney(user_id, amount)
      vRPclient.notify(player, {"~g~상자에서 " .. format_num(amount) .. "원이 나왔습니다!"})
      TriggerClientEvent("chatMessage", -1, "보너스상자 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2" .. format_num(amount) .. "원^0이 나왔습니다!")
    end
  end
end

----- 페스티벌

local festivalType = {
  [1] = {whUrl = "https://discordapp.com/api/webhooks/746392701599088660/6iEN0lAT9jSu-ZXDEopi0zC4EaRikrtUhsshrkRkyiDSptaS4Fs-Aeb4VF9dq-L3AgrT"},
  [2] = {whUrl = "https://discordapp.com/api/webhooks/746401730920579244/qBl9DhPBtsFiHfcyg96wB5k9UeO68VaBtOPUKJC4wRsT9tKtlQIxn20ldSfKdu4ROE1Z"},
  [3] = {whUrl = "https://discordapp.com/api/webhooks/746401862055493825/KMJH59amIv4sJfDUlfOAaSRaCJDKK2231qU7XK_4c1XiZGiDDlpSeLRUtPnfjymVAvR9"},
  [4] = {whUrl = "https://discordapp.com/api/webhooks/746400406954967071/koQuaZay_iPxJkQi8w9BDLoqjcxhNPFjHiKF0Z4faIJ4CrmOmqmyVYJjlOh0bHra3YoW"},
  [5] = {whUrl = "https://discordapp.com/api/webhooks/746400406954967071/koQuaZay_iPxJkQi8w9BDLoqjcxhNPFjHiKF0Z4faIJ4CrmOmqmyVYJjlOh0bHra3YoW"},
  [6] = {whUrl = "https://discordapp.com/api/webhooks/746402877525852170/aeDPcBIff2W2cpR7RAdxaoytdkDM5lHN_iT3ZtU0lvUYQo6w7uCMBYPs4kP-GWdKijb6"}
}

function vRP.sendToDiscord_festival(type, color, name, message, footer)
  if not festivalType[type] then
    return
  end
  local selFestivalType = festivalType[type]
  if selFestivalType.whUrl and selFestivalType.whUrl ~= "" then
    local embed = {
      {
        ["color"] = color,
        ["title"] = "**" .. name .. "**",
        ["description"] = message,
        ["url"] = "https://i.imgur.com/xGCgBw1.png",
        ["footer"] = {
          ["text"] = footer
        }
      }
    }
    PerformHttpRequest(
      selFestivalType.whUrl,
      function(err, text, headers)
      end,
      "POST",
      json.encode({embeds = embed}),
      {["Content-Type"] = "application/json"}
    )
  end
end

function vRP.openfestivalBox1(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_01_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 3) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~그래픽카드 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 그래픽카드 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(1, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 그래픽 카드 2070 Super", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end

function vRP.openfestivalBox2(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_02_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 20) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~헤드셋 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 게이밍 헤드셋 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(2, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 게이밍 헤드셋", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end

function vRP.openfestivalBox3(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_03_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 20) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~키보드 및 마우스 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 키보드 및 마우스 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(3, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 키보드 및 마우스", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end

function vRP.openfestivalBox4(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_04_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 20) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~문화상품권 5만원 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 문화상품권 5만원 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(4, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 문화상품권 5만원권", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end

function vRP.openfestivalBox5(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_05_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 20) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~치킨 기프티콘 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 치킨 기프티콘 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(5, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 치킨 기프티콘", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end

function vRP.openfestivalBox6(user_id)
  if not user_id then
    return
  end
  math.randomseed(os.time())
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    local amount = vRP.getInventoryItemAmount(user_id, idname)
    if vRP.tryGetInventoryItem(user_id, "event_trade_06_t", 1) then
      local chance = math.random(1, 60)
      if (chance >= 1) and (chance <= 20) then
        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~리얼월드 굿즈 상품 ~w~응모에 ~g~성공~w~ 하셨습니다."})
        --TriggerClientEvent("chatMessage", -1, "페스티벌 안내 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2 리얼월드 굿즈 상품 응모에^0 성공하였습니다!")
        vRP.sendToDiscord_festival(6, 16711680, "당첨 소식", "당첨 고유번호 : " .. user_id .. "번\n\n당첨 아이템 : 리얼월드 굿즈 상품", os.date("당첨 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
      else
        vRPclient.notify(player, {"~r~아쉽게도 꽝 입니다."})
      end
      vRP.closeMenu(player)
    end
  end
end
