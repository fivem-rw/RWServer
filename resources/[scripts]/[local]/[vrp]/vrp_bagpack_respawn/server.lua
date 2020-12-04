----------------- vRP Bagpack Respawn
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_bagpack_respawnS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_bagpack_respawn")
vrp_bagpack_respawnC = Tunnel.getInterface("vrp_bagpack_respawn", "vrp_bagpack_respawn")
Tunnel.bindInterface("vrp_bagpack_respawn", vrp_bagpack_respawnS)

RegisterCommand(
  "givebag",
  function(source, args)
    local player = vRP.getUserSource({tonumber(args[1])})
    if player then
      vrp_bagpack_respawnC.setSkin(player, {9, tonumber(args[2]), tonumber(args[3]), tonumber(args[4])})
    end
  end
)

RegisterCommand(
  "getbagcode",
  function(source, args)
    local player = source
    vrp_bagpack_respawnC.getCode(player)
  end
)

RegisterCommand(
  "setskin",
  function(source, args)
    local player = vRP.getUserSource({tonumber(args[1])})
    if player then
      vrp_bagpack_respawnC.setSkin(player, {tonumber(args[2]), tonumber(args[3]), tonumber(args[4]), tonumber(args[5])})
    end
  end
)