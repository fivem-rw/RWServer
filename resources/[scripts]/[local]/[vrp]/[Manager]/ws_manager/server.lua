----------------- Asynchronous Message Exchanger
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ws_manager")
ws_managerC = Tunnel.getInterface("ws_manager", "ws_manager")

ws_managerS = {}
Tunnel.bindInterface("ws_manager", ws_managerS)

local function send(msg, endpoint)
  TriggerEvent("WebSocketServer:broadcast", msg)
end

local function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  i = 1
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

local function genMessage(id, msg)
  return id .. "|" .. msg
end

AddEventHandler(
  "WebSocketServer:onMessage",
  function(message, endpoint)
    sm = stringsplit(message, "|")
    if sm[1] == nil then
      return
    end
    if sm[2] == "ping" then
      send(genMessage(sm[1], "pong"), endpoint)
      return
    elseif sm[2] == "kick" and sm[3] ~= nil then
      local source = vRP.getUserSource({tonumber(sm[3])})
      if source ~= nil then
        vRP.kick({source, sm[4] or ""})
        send(genMessage(sm[1], "true"), endpoint)
        return
      end
    elseif sm[2] == "kickall" then
      for _, v in ipairs(GetPlayers()) do
        if v ~= nil then
          vRP.kick({v, sm[3] or ""})
        end
      end
      send(genMessage(sm[1], "true"), endpoint)
      return
    elseif sm[2] == "ban" and sm[3] ~= nil then
      local source = vRP.getUserSource({tonumber(sm[3])})
      if source == nil then
        vRP.setBanned({tonumber(sm[3]), true})
      else
        vRP.setBanned({tonumber(sm[3]), true})
        vRP.ban({source, sm[4] or ""})
      end
      send(genMessage(sm[1], "true"), endpoint)
      return
    elseif sm[2] == "unban" and sm[3] ~= nil then
      vRP.setBanned({tonumber(sm[3]), false})
      send(genMessage(sm[1], "true"), endpoint)
      return
    elseif sm[2] == "addgroup" and sm[3] ~= nil and sm[4] ~= nil then
      vRP.addUserGroup({tonumber(sm[3]), sm[4]})
      send(genMessage(sm[1], "true"), endpoint)
      return
    elseif sm[2] == "removegroup" and sm[3] ~= nil and sm[4] ~= nil then
      vRP.removeUserGroup({tonumber(sm[3]), sm[4]})
      send(genMessage(sm[1], "true"), endpoint)
      return
    elseif sm[2] == "notice" and sm[3] ~= nil then
      TriggerClientEvent(
        "chat:addMessage",
        -1,
        {
          template = '<div class="notice-box"><span class="title">{0}</span><span>{1}<span></div>',
          args = {"공지", sm[3]}
        }
      )
      send(genMessage(sm[1], "true"), endpoint)
      return
    end
    send(genMessage(sm[1], "false"), endpoint)
  end
)

AddEventHandler(
  "WebSocketServer:onConnect",
  function(endpoint)
  end
)

AddEventHandler(
  "WebSocketServer:onDisconnect",
  function(endpoint)
  end
)
