----------------- vRP Lottery
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_lottery_gold")
vrp_lottery_goldC = Tunnel.getInterface("vrp_lottery_gold", "vrp_lottery_gold")

vrp_lottery_goldS = {}
Tunnel.bindInterface("vrp_lottery_gold", vrp_lottery_goldS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

local lotteries = {
  ["gold"] = {name = "골드", itemname = "lottery_ticket_gold"}
}

local goldAmountType = {
  [1] = {"✨ 금", "g"},
  [2] = {"📏 골드바", "kg"}
}

local typeName = {
  ["gold"] = "^*^3[골드추첨박스]"
}

local goldbarValue = 1000

local userLotterySetTime = 5
local userBuySetTime = 1
local usersLotteryTime = {}
local usersBuyTime = {}
local winningsDefault = {
  gold = {15, 35}
}
local winnings = {
  gold = winningsDefault.gold[1]
}

local function setRandomRate()
  local lrate = GetConvar("lotteryrate", "reset")
  if lrate == "reset" then
    math.randomseed((os.time() + math.random(1, 100000)) * math.random(1, 999))
    winnings.gold = math.random(winningsDefault.gold[1], winningsDefault.gold[2])
  end
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(10000)
      setRandomRate()
      Citizen.Wait(50000)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(10000)
      local lrate = GetConvar("lotteryrate", "reset")
      print("Lottery Gold Rate", lrate, winnings.gold)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      local lrate = GetConvar("lotteryrate", "reset")
      if lrate == "low" then
        winnings.gold = winningsDefault.gold[1]
      elseif lrate == "high" then
        winnings.gold = winningsDefault.gold[2]
      end
    end
  end
)

local function notify(player, msg, type, timer)
  TriggerClientEvent(
    "pNotify:SendNotification",
    player,
    {
      text = msg,
      type = type or "success",
      timeout = timer or 3000,
      layout = "centerleft",
      queue = "global"
    }
  )
end

local function lotteryMoney(player, type)
  math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
  local rand = math.random(1, 100000)
  math.randomseed((os.time() + rand + tonumber(player)) * math.random(1, 999))
  local randSet = math.random(1, 100)
  local amountType = 0
  local amount = 0
  local winNum = 100 - winnings[type]
  local user_id = vRP.getUserId({player})
  local spick = GetConvar("lotterypick", "0")
  if type == "gold" then
    if randSet >= winNum then
      if rand == 77777 or (tonumber(spick) == tonumber(user_id)) then
        SetConvar("lotterypick", "0")
        amountType = 2
        amount = math.random(1, 10)
      elseif rand > 99900 then
        amountType = 2
        amount = math.random(1, 2)
      elseif rand > 99000 then
        amountType = 2
        amount = 1
      elseif rand > 95000 then
        amountType = 1
        amount = math.random(100, 500)
      elseif rand > 80000 then
        amountType = 1
        amount = math.random(50, 100)
      elseif rand > 70000 then
        amountType = 1
        amount = math.random(20, 50)
      elseif rand > 60000 then
        amountType = 1
        amount = math.random(10, 20)
      else
        amountType = 1
        amount = math.random(1, 5)
      end
    else
      amountType = 1
      amount = math.random(1, 2)
    end
  end
  local result = {
    user_id = user_id,
    winner = false,
    win_amount_type = amountType,
    win_amount = amount,
    type = type
  }
  if amount > 0 then
    result.winner = true
    if amountType == 1 then
      vRP.giveInventoryItem({user_id, "gold", amount, true})
    elseif amountType == 2 then
      vRP.giveInventoryItem({user_id, "goldbar", amount, true})
    end
  end
  return result
end

local arrLotteryQueue = {}
local arrLotteryresult = {}

Citizen.CreateThread(
  function()
    while true do
      usersLotteryTime = {}
      Citizen.Wait(5000)
      for k, v in pairs(arrLotteryQueue) do
        local lresult = lotteryMoney(v[1], v[2])
        table.insert(arrLotteryresult, lresult)
      end
      arrLotteryQueue = {}
      for k, v in pairs(arrLotteryresult) do
        local player = vRP.getUserSource({v.user_id})
        local amountTypeName = goldAmountType[v.win_amount_type]
        if v.winner and amountTypeName then
          notify(player, "축하합니다! " .. amountTypeName[1] .. " " .. format_num(v.win_amount) .. amountTypeName[2] .. "에 당첨되었습니다!", "success")
          if v.win_amount_type == 1 and v.win_amount >= 100 then
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, typeName[v.type] .. " ^2" .. GetPlayerName(player) .. "^0님이 ^3" .. amountTypeName[1] .. " " .. format_num(v.win_amount) .. amountTypeName[2] .. "^0에 당첨되었습니다!")
          end
          if v.win_amount_type == 2 and v.win_amount >= 1 then
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, typeName[v.type] .. " ^0와우! ^2" .. GetPlayerName(player) .. "^0님이 ^3" .. amountTypeName[1] .. " " .. format_num(v.win_amount) .. amountTypeName[2] .. "^0에 당첨되었습니다!")
          end
        else
          notify(player, "꽝! 다음기회에~", "error", 1000)
        end
      end
      arrLotteryresult = {}
    end
  end
)

function vrp_lottery_goldS.lotteryGold(type)
  local player = source
  local user_id = vRP.getUserId({player})
  if usersLotteryTime[user_id] ~= nil then
    return true
  end
  if lotteries[type] == nil or lotteries[type].itemname == nil then
    return false
  end
  if not vRP.tryGetInventoryItem({user_id, lotteries[type].itemname, 1}) then
    vRPclient.notify(player, {"~r~" .. lotteries[type].name .. "골드 추첨티켓을 보유하고 있지 않습니다."})
    return false
  end
  local ramount = vRP.getInventoryItemAmount({user_id, lotteries[type].itemname})
  local ramount_text = ""
  if ramount > 0 then
    ramount_text = " 남은개수: " .. ramount .. "개"
  end
  usersLotteryTime[user_id] = os.time()
  arrLotteryQueue[user_id] = {player, type, os.time()}
  notify(player, "추첨중 입니다.." .. ramount_text, "warning", 4000)
  return true
end

function checkMakeGoldbar(user_id)
  local amount = vRP.getInventoryItemAmount({user_id, "gold"})
  if amount >= goldbarValue then
    return true
  end
  return false
end

function vrp_lottery_goldS.checkMakeGoldbar()
  local player = source
  local user_id = vRP.getUserId({player})
  if user_id == nil then
    notify(player, "이용할 수 없습니다.", "warning", 10000)
    return false
  end
  if not checkMakeGoldbar(user_id) then
    local ramount = vRP.getInventoryItemAmount({user_id, "gold"})
    local reqAmount = goldbarValue - ramount
    notify(player, "금이 부족합니다. (부족한 개수: " .. reqAmount .. "g)", "warning", 10000)
    return false
  end
  vRP.prompt(
    {
      player,
      "금(1000g)을 녹여서 골드바(1kg) 1개를 제작합니다.<br>제작하려면 '제작' 이라고 입력해주세요.<br>(제작성공확률: 68%)",
      "",
      function(player, value)
        if value ~= nil and value == "제작" then
          vrp_lottery_goldC.startMakeGoldbar(player)
        else
          vrp_lottery_goldC.stopMakeGoldbar(player)
        end
      end
    }
  )
  return true
end

function vrp_lottery_goldS.makeGoldbar()
  local player = source
  local user_id = vRP.getUserId({player})
  if user_id == nil then
    return false
  end
  if checkMakeGoldbar(user_id) then
    if vRP.tryGetInventoryItem({user_id, "gold", goldbarValue}) then
      math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
      local rand = math.random(1, 100)
      if rand < 20 then
        vRP.giveInventoryItem({user_id, "goldbar", 1, true})
        notify(player, "축하합니다. 제작을 성공했습니다.", "success", 10000)
        TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[골드바제작] ^2" .. GetPlayerName(player) .. "^0님이 ^3골드바 ^0제작에 성공했습니다.")
        vrp_lottery_goldC.playSuccessAnim(player)
      else
        vRP.giveInventoryItem({user_id, "gold", math.random(1, goldbarValue / 2), true})
        notify(player, "제작을 실패했습니다.", "error", 10000)
        vrp_lottery_goldC.playFailedAnim(player)
      end
    end
  else
    local ramount = vRP.getInventoryItemAmount({user_id, "gold"})
    local reqAmount = goldbarValue - ramount
    notify(player, "금이 부족합니다. (부족한 개수: " .. reqAmount .. "g)", "error", 10000)
  end
end
