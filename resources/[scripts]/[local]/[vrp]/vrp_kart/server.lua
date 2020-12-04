local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_kart")
vrp_kartC = Tunnel.getInterface("vrp_kart", "vrp_kart")

vrp_kartS = {}
Tunnel.bindInterface("vrp_kart", vrp_kartS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

local rented = {}

local rentCarType = {
  ["kart_rent1"] = {id = "lambokart", price = 20 * 10000, time = 10 * 60},
  ["kart_rent2"] = {id = "kart3", price = 50 * 10000, time = 10 * 60},
  ["kart_rent3"] = {id = "kart20", price = 50 * 10000, time = 10 * 60},
  ["kart_rent4"] = {id = "shifter_kart", price = 60 * 10000, time = 10 * 60}
}

function vrp_kartS.rent(type, x, y, z)
  local player = source
  local user_id = vRP.getUserId({player})
  local carInfo = rentCarType[type]
  if carInfo ~= nil then
    if rented[user_id] ~= nil and rented[user_id].endTime ~= nil and rented[user_id].endTime < os.time() - carInfo.time then
      rented[user_id] = nil
    end
    if rented[user_id] == nil then
      rented[user_id] = {}
      if vRP.tryPayment({user_id, carInfo.price}) then
        vrp_kartC.spawnRentCar(player, {carInfo.id, x, y, z, carInfo.time})
      else
        vRPclient.notify(player, {"~r~렌트할 현금이 부족합니다."})
      end
    else
      vRPclient.notify(player, {"~r~이미 렌트한 차량이 있습니다 반납 후 이용해주세요."})
    end
  end
end
function vrp_kartS.rentDone(netId, carId, time)
  local player = source
  local user_id = vRP.getUserId({player})
  if netId ~= nil then
    rented[user_id] = {
      carId = carId,
      netId = netId,
      startTime = os.time(),
      endTime = os.time() + time
    }
    vRPclient.notify(player, {"~g~차량을 렌트함. " .. parseInt(time / 60) .. "분 후 자동으로 반납됩니다."})
  end
end
function vrp_kartS.rentReturn(netId)
  local player = source
  local user_id = vRP.getUserId({player})
  local done = false
  if netId ~= nil then
    for k, v in pairs(rented) do
      if v.netId == netId then
        rented[k] = nil
        done = true
        break
      end
    end
  end
  if done then
    vrp_kartC.deleteRentCar(player, {netId})
    vRPclient.notify(player, {"~g~차량을 반납했습니다."})
  else
    vRPclient.notify(player, {"~r~차량을 반납할 수 없습니다."})
  end
end
