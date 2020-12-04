local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_phone_controlS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_phone_control")
vrp_phone_controlC = Tunnel.getInterface("vrp_phone_control", "vrp_phone_control")
Tunnel.bindInterface("vrp_phone_control", vrp_phone_controlS)

function vrp_phone_controlS.checkPhone()
  local player = source
  local user_id = vRP.getUserId({player})
  local data = vRP.getUserDataTable({user_id})
  if data and data.phoneitem and data.phoneitem.id then
    return data.phoneitem.id
  end
  return false
end
