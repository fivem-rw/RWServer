----------------- Object Manager
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ObjectManager")
ObjectManagerC = Tunnel.getInterface("ObjectManager", "ObjectManager")

ObjectManagerS = {}
Tunnel.bindInterface("ObjectManager", ObjectManagerS)

local perms = "player.tpto"

function ObjectManagerS.checkPerm()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, perms}) then
    return true
  end
  return false
end

function ObjectManagerS.deleteObjects(objList)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, perms}) then
    local players = GetPlayers()
    for _, i in ipairs(players) do
      local pnames = GetPlayerName(i)
      if i ~= nil then
        ObjectManagerC.deleteObjects(i, {objList})
      end
    end
  end
end
function ObjectManagerS.deletePeds(objList)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, perms}) then
    local players = GetPlayers()
    for _, i in ipairs(players) do
      local pnames = GetPlayerName(i)
      if i ~= nil then
        ObjectManagerC.deletePeds(i, {objList})
      end
    end
  end
end
function ObjectManagerS.deleteVehicles(objList)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, perms}) then
    local players = GetPlayers()
    for _, i in ipairs(players) do
      local pnames = GetPlayerName(i)
      if i ~= nil then
        ObjectManagerC.deleteVehicles(i, {objList})
      end
    end
  end
end
