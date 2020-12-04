local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPhk = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_hotkeys")
HKclient = Tunnel.getInterface("vrp_hotkeys", "vrp_hotkeys")
Tunnel.bindInterface("vrp_hotkeys", vRPhk)
-- USE FOR NECESSARY SERVER FUNCTIONS

function vRPhk.test(msg)
  print("msg " .. msg .. " received from " .. source)
  return 42
end

function vRPhk.docsOnline()
  local docs = vRP.getUsersByPermission({"emscheck.revive"})
  return #docs
end

--edit by fenton
function vRPhk.canSkipComa()
  local user_id = vRP.getUserId({source})
  return vRP.hasPermission({user_id, "player.skip_coma"})
end

function vRPhk.helpComa(x, y, z)
  vRP.sendServiceAlert({source, "🔥 119 긴급", x, y, z, "살려주세요!"}) -- people will change this message anyway haha
end
