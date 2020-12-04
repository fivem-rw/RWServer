----------------- vRP Lottery
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_lottery")
vrp_lotteryC = Tunnel.getInterface("vrp_lottery", "vrp_lottery")

vrp_lotteryS = {}
Tunnel.bindInterface("vrp_lottery", vrp_lotteryS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/last_user_id" .. rand, "SELECT id FROM vrp_users order by id desc")
MySQL.createCommand("vRP/get_ids" .. rand, "SELECT * FROM vrp_user_ids WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_ids_old" .. rand, "SELECT * FROM vrp_user_ids_old WHERE identifier = @identifier")
MySQL.createCommand("vRP/titlebox_olduser_new" .. rand, "INSERT INTO vrp_titlebox_olduser(user_id,count,created_at) VALUES(@user_id,@count,now());")
MySQL.createCommand("vRP/titlebox_olduser_get" .. rand, "SELECT * FROM vrp_titlebox_olduser WHERE user_id = @user_id")

local lotteries = {
  ["basic"] = {name = "매일", price = 100000, itemname = "lottery_ticket_basic"},
  ["advanced"] = {name = "고급", price = 5000000, itemname = "lottery_ticket_advanced"},
  ["vip"] = {name = "VIP", price = 50000000, itemname = "lottery_ticket_vip"}
}

local luckyPotions = {
  ["potion1"] = {name = "행운의 물약", price = 30000000, itemname = "lucky_potion1"},
  ["potion2"] = {name = "강화된 행운의 물약", price = 50000000, itemname = "lucky_potion2"},
  ["potion3"] = {name = "강력한 행운의 물약", price = 100000000, itemname = "lucky_potion3"}
}

local typeName = {
  ["basic"] = "^*^3[매일추첨박스]",
  ["advanced"] = "^*^3[고급추첨박스]",
  ["vip"] = "^*^3[VIP추첨박스]"
}

local userLotterySetTime = 5
local userBuySetTime = 1
local usersLotteryTime = {}
local usersBuyTime = {}
local winningsDefault = {
  basic = {400, 500},
  advanced = {400, 500},
  vip = {400, 500}
}
local winnings = {
  basic = winningsDefault.basic[1],
  advanced = winningsDefault.advanced[1],
  vip = winningsDefault.vip[1]
}
local setLuckyUserIds = {}

local function setRandomRate()
  local lrate = GetConvar("lotteryrate", "reset")
  if lrate == "reset" then
    math.randomseed((os.time() + math.random(1, 100000)) * math.random(1, 999))
    winnings.basic = math.random(winningsDefault.basic[1], winningsDefault.basic[2])
    math.randomseed((os.time() + math.random(1, 100000)) * math.random(1, 999))
    winnings.advanced = math.random(winningsDefault.advanced[1], winningsDefault.advanced[2])
    math.randomseed((os.time() + math.random(1, 100000)) * math.random(1, 999))
    winnings.vip = math.random(winningsDefault.vip[1], winningsDefault.vip[2])
  end
end

local limitUserId = nil

Citizen.CreateThread(
  function()
    Citizen.Wait(1000)
    while true do
      MySQL.query(
        "vRP/last_user_id" .. rand,
        {},
        function(rows, affected)
          if rows and #rows > 0 then
            limitUserId = tonumber(rows[1].id) - 500 or nil
          end
        end
      )
      Citizen.Wait(60000)
    end
  end
)

Citizen.CreateThread(
  function()
    Citizen.Wait(1000)
    function task_get_last_user_id()
      MySQL.query(
        "vRP/last_user_id" .. rand,
        {},
        function(rows, affected)
          if rows and #rows > 0 then
            limitUserId = tonumber(rows[1].id) - 500 or nil
          end
          SetTimeout(60000, task_get_last_user_id)
        end
      )
    end
    task_get_last_user_id()
  end
)

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
      print("Lottery Rate", lrate, winnings.basic, winnings.advanced, winnings.vip)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      local lrate = GetConvar("lotteryrate", "reset")
      if lrate == "low" then
        winnings.basic = winningsDefault.basic[1]
        winnings.advanced = winningsDefault.advanced[1]
        winnings.vip = winningsDefault.vip[1]
      elseif lrate == "high" then
        winnings.basic = winningsDefault.basic[2]
        winnings.advanced = winningsDefault.advanced[2]
        winnings.vip = winningsDefault.vip[2]
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
  local randSet = math.random(1, 1000)
  local amount = 0
  local winNum = 1000 - winnings[type]
  local user_id = vRP.getUserId({player})
  local spick = GetConvar("lotterypick", "0")
  local luckyActive = false
  if type == "basic" then
    if setLuckyUserIds[user_id] then
      if math.random(1, 2) == 2 then
        luckyActive = true
      end
    end
    if randSet >= winNum or luckyActive then
      if rand == 77777 then
        amount = math.random(100 * 10000, 1000 * 10000)
      elseif rand > 90000 then
        amount = math.random(20 * 10000, 30 * 10000)
      elseif rand > 50000 then
        amount = math.random(10 * 10000, 25 * 10000)
      else
        amount = math.random(10 * 10000, 12 * 10000)
      end
    end
  elseif type == "advanced" then
    if setLuckyUserIds[user_id] then
      if math.random(1, 12) == 3 then
        luckyActive = true
      end
    end
    if randSet >= winNum or luckyActive then
      if rand == 77777 or (tonumber(spick) == tonumber(user_id)) then
        SetConvar("lotterypick", "0")
        amount = math.random(10000 * 10000, 100000 * 10000)
      elseif rand > 99000 then
        amount = math.random(5000 * 10000, 50000 * 10000)
      elseif rand > 95000 then
        amount = math.random(5000 * 10000, 25000 * 10000)
      elseif rand > 90000 then
        amount = math.random(5000 * 10000, 10000 * 10000)
      elseif rand > 80000 then
        amount = math.random(5000 * 10000, 9000 * 10000)
      elseif rand > 70000 then
        amount = math.random(5000 * 10000, 8000 * 10000)
      elseif rand > 60000 then
        amount = math.random(5000 * 10000, 7000 * 10000)
      else
        amount = math.random(5000 * 10000, 6000 * 10000)
      end
    end
  elseif type == "vip" then
    if setLuckyUserIds[user_id] then
      if math.random(1, 18) == 3 then
        luckyActive = true
      end
    end
    if randSet >= winNum or luckyActive then
      if rand == 77777 or (tonumber(spick) == tonumber(user_id)) then
        SetConvar("lotterypick", "0")
        amount = math.random(100000 * 10000, 10000000 * 10000)
      elseif rand > 99900 then
        amount = math.random(50000 * 10000, 500000 * 10000)
      elseif rand > 95000 then
        amount = math.random(50000 * 10000, 250000 * 10000)
      elseif rand > 90000 then
        amount = math.random(50000 * 10000, 100000 * 10000)
      elseif rand > 80000 then
        amount = math.random(50000 * 10000, 90000 * 10000)
      elseif rand > 70000 then
        amount = math.random(50000 * 10000, 80000 * 10000)
      elseif rand > 60000 then
        amount = math.random(50000 * 10000, 70000 * 10000)
      else
        amount = math.random(50000 * 10000, 60000 * 10000)
      end
    end
  end
  if luckyActive then
    setLuckyUserIds[user_id] = nil
  end
  local result = {
    user_id = user_id,
    winner = false,
    win_amount = amount,
    type = type
  }
  if amount > 0 then
    result.winner = true
    vRP.giveMoney({user_id, amount})
  --vRP.basicLog({"logs/lottery.txt", user_id .. " | " .. type .. " | " .. amount})
  end
  return result
end

local arrLotteryQueue = {}
local arrLotteryresult = {}

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(5000)
      usersLotteryTime = {}
      for k, v in pairs(arrLotteryQueue) do
        table.insert(arrLotteryresult, lotteryMoney(v[1], v[2]))
      end
      arrLotteryQueue = {}
      for k, v in pairs(arrLotteryresult) do
        local player = vRP.getUserSource({v.user_id})
        if v.winner then
          notify(player, "축하합니다! " .. format_num(v.win_amount) .. "원이 당첨되었습니다!", "success")
          if v.win_amount >= 1000000 then
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, typeName[v.type] .. " ^0" .. GetPlayerName(player) .. "^0님이 ^2" .. format_num(v.win_amount) .. "원^0에 당첨되었습니다!")
          end
        else
          notify(player, "꽝! 다음기회에~", "error", 1000)
        end
      end
      arrLotteryresult = {}
    end
  end
)

function vrp_lotteryS.lottery(type)
  local player = source
  local user_id = vRP.getUserId({player})
  if usersLotteryTime[user_id] ~= nil then
    return true
  end
  if limitUserId ~= nil and tonumber(user_id) > limitUserId then
    vRPclient.notify(player, {"~r~뉴비는 이용할 수 없습니다."})
    return false
  end
  if lotteries[type] == nil or lotteries[type].itemname == nil then
    return false
  end
  if not vRP.tryGetInventoryItem({user_id, lotteries[type].itemname, 1}) then
    vRPclient.notify(player, {"~r~" .. lotteries[type].name .. "티켓을 보유하고 있지 않습니다. 티켓을 구매한 후 이용해주세요."})
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

function vrp_lotteryS.buyLottery(type)
  local player = source
  local user_id = vRP.getUserId({player})
  if limitUserId ~= nil and tonumber(user_id) > limitUserId then
    vRPclient.notify(player, {"~r~뉴비는 이용할 수 없습니다."})
    return
  end
  if false then
    vRPclient.notify(player, {"~g~일시적으로 티켓구매를 중단합니다."})
    return
  end
  if usersBuyTime[user_id] == nil then
    usersBuyTime[user_id] = 0
  else
    if usersBuyTime[user_id] > os.time() - userBuySetTime then
      vRPclient.notify(player, {"~r~단기간에 구매량이 너무 많습니다. 잠시후 이용해주세요."})
      return
    end
  end
  if lotteries[type] ~= nil and lotteries[type].price > 0 then
    if vRP.tryPayment({user_id, lotteries[type].price}) then
      usersBuyTime[user_id] = os.time()
      vRP.giveInventoryItem({user_id, lotteries[type].itemname, 1, true})
      notify(player, lotteries[type].name .. "추첨티켓 구입완료!", "success", 1000)
    else
      vRPclient.notify(player, {"~r~티켓을 구매할 돈이 부족합니다."})
    end
  end
end

local userTitleBoxTime = {}
local usertitleBoxSetTime = 15

function vrp_lotteryS.getTitleBox()
  local player = source
  local user_id = vRP.getUserId({player})
  if userTitleBoxTime[user_id] == nil then
    userTitleBoxTime[user_id] = 0
  else
    if userTitleBoxTime[user_id] > os.time() - usertitleBoxSetTime then
      local remain = userTitleBoxTime[user_id] - (os.time() - usertitleBoxSetTime)
      vRPclient.notify(player, {"~r~잠시 후 이용해주세요."})
      return
    end
  end
  if true then
    vRPclient.notify(player, {"~r~지급 중단."})
    return
  end
  userTitleBoxTime[user_id] = os.time()
  MySQL.query(
    "vRP/titlebox_olduser_get" .. rand,
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        vRPclient.notify(player, {"~r~이미 랜덤칭호상자를 지급받았습니다."})
      else
        MySQL.query(
          "vRP/get_ids" .. rand,
          {user_id = user_id},
          function(rows, affected)
            if #rows > 0 then
              local iden = nil
              for k, v in pairs(rows) do
                if string.find(v.identifier, "license:") ~= nil then
                  iden = v.identifier
                end
              end
              if iden == nil then
                vRPclient.notify(player, {"~r~신원확인 오류."})
              else
                MySQL.query(
                  "vRP/get_ids_old" .. rand,
                  {identifier = iden},
                  function(rows, affected)
                    if #rows > 0 then
                      local giveCount = 5
                      MySQL.query(
                        "vRP/titlebox_olduser_new" .. rand,
                        {user_id = user_id, count = giveCount},
                        function(rows, affected)
                          vRP.giveInventoryItem({user_id, "titlebox_random", giveCount, true})
                          vRPclient.notify(player, {"~g~기존회원님 반갑습니다. 랜덤칭호상자가 지급되었습니다!"})
                        end
                      )
                    else
                      vRPclient.notify(player, {"~r~기존회원만 지급받을 수 있습니다."})
                    end
                  end
                )
              end
            end
          end
        )
      end
    end
  )
end

function vrp_lotteryS.buyLuckyPotion(type)
  local player = source
  local user_id = vRP.getUserId({player})
  if limitUserId ~= nil and tonumber(user_id) > limitUserId then
    vRPclient.notify(player, {"~r~뉴비는 이용할 수 없습니다."})
    return
  end
  if false then
    vRPclient.notify(player, {"~g~일시적으로 티켓구매를 중단합니다."})
    return
  end
  if usersBuyTime[user_id] == nil then
    usersBuyTime[user_id] = 0
  else
    if usersBuyTime[user_id] > os.time() - userBuySetTime then
      vRPclient.notify(player, {"~r~단기간에 구매량이 너무 많습니다. 잠시후 이용해주세요."})
      return
    end
  end
  if luckyPotions[type] ~= nil and luckyPotions[type].price > 0 then
    if vRP.tryPayment({user_id, luckyPotions[type].price}) then
      usersBuyTime[user_id] = os.time()
      vRP.giveInventoryItem({user_id, luckyPotions[type].itemname, 1, true})
      notify(player, luckyPotions[type].name .. " 구입완료!", "success", 1000)
    else
      vRPclient.notify(player, {"~r~구매할 돈이 부족합니다."})
    end
  end
end

RegisterNetEvent("lucky_potion:drink")
AddEventHandler(
  "lucky_potion:drink",
  function(user_id, time)
    setLuckyUserIds[user_id] = os.time() + time
  end
)

Citizen.CreateThread(
  function()
    while true do
      for k, v in pairs(setLuckyUserIds) do
        print("Lucky Potion", k, v)
      end
      Citizen.Wait(2000)
      local currentSetTime = os.time()
      for k, v in pairs(setLuckyUserIds) do
        if v and v < currentSetTime then
          setLuckyUserIds[k] = nil
        end
      end
    end
  end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3추첨박스가 시작되었습니다!!")
	end
)