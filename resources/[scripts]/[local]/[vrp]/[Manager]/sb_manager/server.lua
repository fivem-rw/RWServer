----------------- Screen Monitoring System
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sb_manager")
sb_managerC = Tunnel.getInterface("sb_manager", "sb_manager")

sb_managerS = {}
Tunnel.bindInterface("sb_manager", sb_managerS)

function sb_managerS.save(playerName, data)
  local userId = vRP.getUserId({source})
  if data ~= nil and userId ~= nil then
    file = io.open("web/screenr/data/" .. userId, "w")
    if file then
      local _data = userId .. "|" .. playerName .. "|" .. data
      file:write(_data)
    end
    file:close()
  end
end

function sb_managerS.getUserInfo()
  local _source = source
  local user_id = vRP.getUserId({_source})
  local name = GetPlayerName(_source)
  return _source, user_id, name
end