local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
 
vRPcs = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_truckerJob")
Tunnel.bindInterface("vRP_truckerJob", vRPcs)

function vRPcs.success(amount) -- handles the event
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    vRP.giveMoney({user_id,amount})
    vRPclient.notify(player,{"트레일러 배송 수고비 ~g~"..amount.."원~w~을 받았습니다."})
end

function vRPcs.test(amount) -- handles the event
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if truckerjob(user_id) then
    TriggerClientEvent('okcok', -1)
    else
    vRPclient.notify(player,{"~r~트럭 기사 직업군만 이용 가능합니다!"})
    end
end

function truckerjob(uid)
  local testtest = 1
    if vRP.hasPermission({uid,"trucker.mission"}) then
      return true
    else
            return false
    end
end