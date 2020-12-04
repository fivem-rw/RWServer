local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_area_controlS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_area_control")
vrp_area_controlC = Tunnel.getInterface("vrp_area_control", "vrp_area_control")
Tunnel.bindInterface("vrp_area_control", vrp_area_controlS)

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

local itemId = "wbody|WEAPON_NIGHTSTICK2"

function vrp_area_controlS.checkTicket()
  local player = source
  local user_id = vRP.getUserId({player})
  local price = math.random(100000, 1000000)
  if not vRP.tryPayment({user_id, price}) then
    return false
  end
  notify(player, format_num(price) .. "원을 지불 했습니다.", "warning", 5000)
  local rand = math.random(1, 100)
  if rand > 90 then
    local getAmount = math.random(500000, 5000000)
    if getAmount > 4955000 then
      getAmount = math.random(10000000, 100000000)
    elseif getAmount > 4950000 then
        getAmount = math.random(5000000, 50000000)
    end
    vRP.giveMoney({user_id, getAmount})
    notify(player, format_num(getAmount) .. "원을 획득했습니다.", "success", 10000)
    if getAmount >= 3000000 then
      TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^5[매미게임] ^0" .. GetPlayerName(player) .. "^0님이 ^2" .. format_num(getAmount) .. "원^0에 당첨되었습니다!")
    end
    return true
  end
  if vRP.getInventoryItemAmount({user_id, itemId}) > 0 and vRP.tryGetInventoryItem({user_id, itemId, 1}) then
    return true
  end

  return false
end
