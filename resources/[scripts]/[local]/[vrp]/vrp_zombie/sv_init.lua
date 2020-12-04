----------------- vRP Zombie
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_zombie")
vrp_zombieC = Tunnel.getInterface("vrp_zombie", "vrp_zombie")

vrp_zombieS = {}
Tunnel.bindInterface("vrp_zombie", vrp_zombieS)

local n = 0.189247812947

function vrp_zombieS.Init()
  math.randomseed(n)
  local nn = math.random(1, 999)
  local d = LoadResourceFile("vrp_zombie", "spawning/cl_zombies.lua")
  local encoded =
    d:gsub(
    ".",
    function(bb)
      return "#" .. tonumber(bb:byte()) * nn
    end
  )
  vrp_zombieC.s1(source, {encoded, n})
end

Citizen.CreateThread(
  function()
    Wait(100)
    --TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^6좀비존시작!")
  end
)
