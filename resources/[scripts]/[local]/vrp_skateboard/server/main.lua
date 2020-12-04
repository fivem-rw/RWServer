local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPSkateboardS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_skateboard")
vRPSkateboardC = Tunnel.getInterface("vrp_skateboard", "vrp_skateboard")
Tunnel.bindInterface("vrp_skateboard", vRPSkateboardS)

function vRPSkateboardS.reqPerm()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, Config.perm}) or vRP.CheckInventoryItem({user_id, Config.ticket, 1}) then
    vRPSkateboardC.startRCCar(source)
  else
    vRPclient.notify(source, {"~r~스케이트 사용권한이 없습니다!"})
  end
end
