local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

function notify(player, msg, type, timer)
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

local arrPayTime = {}

RegisterServerEvent("zone3:getReward")
AddEventHandler(
  "zone3:getReward",
  function()
    local player = source
    local user_id = vRP.getUserId({player})
    local rand = math.random(1, 10)
    if user_id == nil then
      return
    end
    if arrPayTime[user_id] ~= nil and arrPayTime[user_id] > os.time() - 30 then
      return
    end
    if rand < 5 then
      return
    end

    local getAmount = math.random(1, 20000)
    arrPayTime[user_id] = os.time()
    vRP.giveMoney({user_id, getAmount})
    notify(player, "잠수 타다가 " .. format_num(getAmount) .. "원을 획득했습니다.", "success", 20000)
  end
)
