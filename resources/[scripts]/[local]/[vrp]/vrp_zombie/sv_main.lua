----------------- vRP Zombie
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_zombie")
vrp_zombieC = Tunnel.getInterface("vrp_zombie", "vrp_zombie")

vrp_zombieS = {}
Tunnel.bindInterface("vrp_zombie", vrp_zombieS)

local rewards = {
  {"item", 0.1, "wbody|WEAPON_COMBATMG", "🔫 컴뱃MG", 1, true},
  {"item", 0.1, "wbody|WEAPON_PISTOL50", "🔫 피스톨.50", 1, true},
  {"item", 0.1, "wbody|WEAPON_ASSAULTSHOTGUN", "🔫 어썰트샷건", 1, true},
  {"item", 0.1, "wbody|WEAPON_PUMPSHOTGUN", "🔫 펌프샷건", 1, true},
  {"item", 5, "wbody|WEAPON_BALL", "⚾ 공", 1, false},
  {"item", 5, "wbody|WEAPON_BAT", "🔩 야구방망이", 1, false},
  {"item", 5, "wbody|WEAPON_CROWBAR", "🔧 쇠지렛대", 1, false},
  {"item", 5, "wbody|WEAPON_HAMMER", "🔧 망치", 1, false},
  {"item", 5, "wbody|WEAPON_HATCHET", "🔧 손도끼", 1, false},
  {"item", 5, "wbody|WEAPON_GOLFCLUB", "🔧 골프채", 1, false},
  {"item", 3, "zombie_head", "💀 좀비머리", {1, 2}, false},
  {"item", 3, "zombie_ear", "👂 좀비귀", {1, 2}, false},
  {"item", 3, "zombie_arm", "💪 좀비팔", {1, 2}, false},
  {"item", 3, "zombie_leg", "🍤 좀비다리", {1, 2}, false},
  {"item", 3, "zombie_medkit", "🎃 좀비해독제", {1, 3}, false},
  {"item", 5, "gift_box", "🎁 선물상자", {1, 3}, false},
  {"item", 20, "water", "🌊 생수", {1, 5}, false},
  {"item", 20, "ramen", "🍜 신라면", {1, 5}, false},
  {"item", 20, "bread", "🍞 빵", {1, 5}, false},
  {"item", 20, "cigar2", "🚬 마일드 세븐", {1, 5}, false},
  {"item", 10, "lottery_ticket_basic", "📗 매일 추첨티켓", {1, 2}, false},
  {"item", 5, "lottery_ticket_advanced", "📘 고급 추첨티켓", 1, true},
  {"item", 2, "zombie_ticket_1", "🎫 좀비존 입장권 (기본)", 1, true},
  {"item", 0.1, "lottery_ticket_vip", "📒 VIP 추첨티켓", 1, true},
  {"item", 1, "lucky_potion1", "🔮 행운의 물약", {1, 2}, true},
  {"item", 0.1, "lucky_potion2", "🔮 강화된 행운의 물약", {1, 2}, true},
  {"item", 0.05, "lucky_potion3", "🔮 강력한 행운의 물약", 1, true},
  {"item", 0.5, "id_card", "💳 은행원 신분증", 1, true},
  {"bulkmoney", 30, "150000", "15만원 돈뭉치", 1, false},
  {"bulkmoney", 10, "300000", "30만원 돈뭉치", 1, false},
  {"bulkmoney", 5, "500000", "50만원 돈뭉치", 1, false}
}

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

local function save_idle_custom(player, custom)
  local r_idle = {}

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local data = vRP.getUserDataTable({user_id})
    if data then
      data.survival_idle = custom
      vRP.setUserDataTable({user_id, data})

      for k, v in pairs(data.survival_idle) do
        r_idle[k] = v
      end
    end
  end

  return r_idle
end

local function rollback_idle_custom(player)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local data = vRP.getUserDataTable({user_id})
    if data then
      if data.survival_idle ~= nil then
        vRPclient.setCustomization(player, {data.survival_idle})
        data.survival_idle = nil
      end
    end
  end
end

function vrp_zombieS.infectZombieSkin(modelhash, custom, save)
  local player = source
  local modelhash = modelhash
  local idle_copy = {}
  if save then
    idle_copy = save_idle_custom(player, custom)
  else
    idle_copy = custom
  end
  idle_copy.modelhash = modelhash
  vRPclient.setCustomization(player, {idle_copy})
end

function vrp_zombieS.recZombieSkin()
  local player = source
  rollback_idle_custom(player)
end

function vrp_zombieS.checkTicket()
  local player = source
  local user_id = vRP.getUserId({player})
  if vRP.tryGetInventoryItem({user_id, "zombie_ticket_1", 1}) then
    vrp_zombieC.authTicket(player, {true})
    return
  end
  vrp_zombieC.authTicket(player, {false})
end

function vrp_zombieS.kill(isBoss)
  local player = source
  local user_id = vRP.getUserId({player})

  math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
  local amount = math.random(20000, 120000)
  local addRate = 1.2
  if isBoss then
    math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
    mount = math.random(1000000, 5000000)
    addRate = 10
  end
  notify(player, "좀비사냥 보상: " .. amount .. "원")
  vRP.giveMoney({user_id, amount})

  if isBoss then
    TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[좀비사냥] ^2" .. GetPlayerName(player) .. "^0님이 ^2좀비보스^0를 사냥했습니다.")
  end

  local loop = 1
  if isBoss then
    math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
    loop = math.random(3, 10)
  end
  for i = 1, loop do
    math.randomseed((os.time() + math.random(1, 100000) + tonumber(player)) * i)
    local rate = 100
    local arrSelect = {}
    local selectRewards = nil
    local chance = math.random(1, 100 * rate)
    for k, v in pairs(rewards) do
      if chance >= (100 * rate) - (v[2] * rate * addRate) then
        table.insert(arrSelect, v)
      end
    end

    if #arrSelect > 0 then
      selectRewards = arrSelect[math.random(1, #arrSelect)]
    end

    if selectRewards ~= nil then
      if selectRewards[1] == "item" then
        local num = selectRewards[5]
        if type(num) == "table" then
          num = math.random(num[1], num[2])
        end
        notify(player, "좀비사냥 보상: " .. selectRewards[4] .. " " .. num .. "개가 나왔습니다!", "warning")
        if selectRewards[6] then
          TriggerClientEvent("chatMessage", player, "", {255, 255, 255}, "^*^1[좀비사냥보상] ^2" .. GetPlayerName(player) .. "^0님이^2 ^1" .. selectRewards[4] .. "^0을(를) ^1" .. num .. "^0개 획득하였습니다.")
        end
        vRP.giveInventoryItem({user_id, selectRewards[3], num})
      elseif selectRewards[1] == "bulkmoney" then
        local num = selectRewards[5]
        if type(num) == "table" then
          num = math.random(num[1], num[2])
        end
        notify(player, "좀비사냥 보상: " .. selectRewards[4] .. "가 나왔습니다!", "warning")
        if selectRewards[6] then
          TriggerClientEvent("chatMessage", player, "", {255, 255, 255}, "^*^1[좀비사냥보상] ^2" .. GetPlayerName(player) .. "^0님이^2 ^1" .. selectRewards[4] .. "^0을(를) ^1" .. num .. "^0개 획득하였습니다.")
        end
        vRP.giveMoney({user_id, tonumber(selectRewards[3])})
      end
    end
    Wait(0)
  end

  TriggerEvent("vrp_eventbox2:getItem", player, 1, {"eventitem_event2_vivestone1", "eventitem_event2_vivestone2"})
end

function vrp_zombieS.Medkit()
  local player = source
  local user_id = vRP.getUserId({player})
  if vRP.tryGetInventoryItem({user_id, "zombie_medkit", 1}) then
    vrp_zombieC.Medkit(player)
  else
    notify(player, "좀비해독제가 없습니다.", "error")
  end
end

function task_remove_ped()
  TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[좀비존알림] ^3좀비존이 시작되었습니다!!")
  TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[좀비존알림] ^2좀비바이러스 백신 살포!!")
  for _, player in pairs(GetPlayers()) do
    TriggerClientEvent("vrp_zombie:remove_ped", player)
  end
  SetTimeout(1800000, task_remove_ped)
end
task_remove_ped()
