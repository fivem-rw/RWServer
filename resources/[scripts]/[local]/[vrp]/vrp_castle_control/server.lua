----------------- vRP Castle Control
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_castle_controlS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_castle_control")
vrp_castle_controlC = Tunnel.getInterface("vrp_castle_control", "vrp_castle_control")
Tunnel.bindInterface("vrp_castle_control", vrp_castle_controlS)

function vrp_castle_controlS.checkTicket()
  if true then
    return
  end
  local player = source
  local user_id = vRP.getUserId({player})
  if vRP.tryGetInventoryItem({user_id, "festival_ticket_1", 1}) then
    return true
  end
  return false
end
