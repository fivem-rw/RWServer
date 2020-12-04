----------------- Detect Hack
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "dh")
dhC = Tunnel.getInterface("dh", "dh")

dhS = {}
Tunnel.bindInterface("dh", dhS)

local env = "dev"
if GetConvar("server_env", "dev") == "pro" then
  env = "pro"
end

local sendUserIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 14, 16, 17, 1107, 194, 13088, 16337, 13215, 13228, 16337, 29289, 10010}

local hackType = {
  ["exp"] = "폭탄",
  ["tp"] = "텔레포트",
  ["speed"] = "스피드",
  ["jump"] = "점프",
  ["god"] = "무적",
  ["monitor"] = "모니터링",
  ["CreateObject"] = "오브젝트생성",
  ["CreateVehicle"] = "차량생성",
  ["CreatePed"] = "NPC생성",
  ["AddExplosion"] = "폭발생성"
}

function logInfoToFile(file, info)
  if false then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end

function notifyHack(source, type)
  local hackName = type
  if type ~= nil and hackType[type] ~= nil then
    hackName = hackType[type]
  end
  if source ~= nil then
    local userId = vRP.getUserId({source})
    if tonumber(userId) == 1 or tonumber(userId) == 1108 then
    --return
    end
    local reason = userId .. "|" .. GetPlayerName(source) .. ": " .. hackName .. "핵 사용"
    logInfoToFile("logs/hackdetect.txt", reason)
    for _, v in pairs(sendUserIds) do
      local player = vRP.getUserSource({v})
      if player ~= nil then
        TriggerClientEvent("chatMessage", player, "속보 ", {255, 0, 0}, reason)
      end
    end
  end
end

function dhS.NotifyHack(type)
  notifyHack(source, type)
end

function dhS.printEntity(name)
  print("entityCreated", name)
end

RegisterServerEvent("rwHack")
AddEventHandler(
  "rwHack",
  function(body)
    if body == nil then
      body = ""
    end
    local hackName = nil
    if body ~= nil and hackType[body] ~= nil then
      hackName = hackType[body]
    end
    local player = source
    local playerName = GetPlayerName(player)
    local userId = vRP.getUserId({player})
    local reason = ""
    if userId then
      reason = userId .. "|" .. playerName .. "|" .. body
    end
    if env == "pro" then
      local desc = "[핵] 리얼월드 보안시스템"
      if hackName then
        desc = "[핵] 리얼월드 보안시스템 (" .. hackName .. ")"
      end
      if true then
        vRP.ban({player, desc})
      else
        TriggerClientEvent("chatMessage", player, "", {255, 0, 0}, desc)
      end
    else
      print("rwHack", body)
    end
    if playerName == nil then
      playerName = ""
    end
    logInfoToFile("logs/hackautoban.txt", reason)
  end
)

RegisterServerEvent("rwHackLog")
AddEventHandler(
  "rwHackLog",
  function(body)
    if body == nil then
      body = ""
    end
    local player = source
    local playerName = GetPlayerName(player)
    local userId = vRP.getUserId({player})
    if env == "pro" then
      --vRP.ban({player, "[핵] 리얼월드 보안시스템"})
      notifyHack(player, body)
    else
      notifyHack(player, body)
    end
    if playerName == nil then
      playerName = ""
    end
    local reason = userId .. "|" .. playerName .. "|" .. body
    logInfoToFile("logs/hacklogs.txt", reason)
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(100)
      --local player = vRP.getUserSource({1})
      --dhC.addE(player)
    end
  end
)

local exploUserIds = {}
local isProtect = false

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(100)
      if isProtect then
        Citizen.Wait(60000)
        isProtect = false
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(5000)
      for k, v in pairs(exploUserIds) do
        if v.c > 10 then
          notifyHack(v.source, "exp")
          isProtect = true
        end
        v.c = 0
      end
    end
  end
)

AddEventHandler(
  "explosionEvent",
  function(sender, ev)
    local user_id = vRP.getUserId({sender})
    if exploUserIds[user_id] then
      exploUserIds[user_id].c = exploUserIds[user_id].c + 1
    else
      exploUserIds[user_id] = {}
      exploUserIds[user_id].c = 1
      exploUserIds[user_id].source = sender
    end
    if isProtect then
      CancelEvent()
    end
    print("explosionEvent", user_id)
  end
)
--[[
AddEventHandler(
  "entityCreated",
  function(entity)
    local sendPlayerId = vRP.getUserSource({sendUserId})
    if sendPlayerId ~= nil then
      local player = NetworkGetEntityOwner(entity)
      local userId = vRP.getUserId({player})
      local name = vRP.getPlayerName({player})
      local type = GetEntityType(entity)
      local reason = userId .. "|" .. name .. "|" .. type
    --TriggerClientEvent("chatMessage", sendPlayerId, "속보 ", {255, 0, 0}, reason)
    --print("entityCreated: " .. reason)
    --dhC.printEntity(sendPlayerId, {entity})
    end
  end
)
]]
