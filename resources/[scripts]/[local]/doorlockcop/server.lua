----------------- DoorLock System
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "doorsControl")

local cfg = module("doorlockcop", "config")
local doorList = cfg.list

RegisterServerEvent("door:check")
AddEventHandler(
  "door:check",
  function(id, status)
    local player = source
    local user_id = vRP.getUserId({player})
    if vRP.getInventoryItemAmount({user_id, doorList[id].key}) > 0 then
      TriggerClientEvent("door:process", player, id, status)
    else
      vRPclient.notify(player, {"~r~해당 문을 열수 있는 키가 없습니다."})
      TriggerClientEvent("door:reject", player, id, status)
    end
  end
)

RegisterServerEvent("door:status")
AddEventHandler(
  "door:status",
  function(id, status)
    local player = source
    local user_id = vRP.getUserId({player})
    if vRP.getInventoryItemAmount({user_id, doorList[id].key}) > 0 then
      doorList[id].locked = status
      TriggerClientEvent("door:statusSend", -1, id, status)
      if status then
        vRPclient.notify(player, {"~w~문이 ~r~잠겼~w~습니다."})
        TriggerClientEvent("RealWorldEffectSound:PlayWithinDistance", -1, player, 3.0, "DoorClose", 1.0)
      else
        vRPclient.notify(player, {"~w~문이 ~g~열렸~w~습니다."})
        TriggerClientEvent("RealWorldEffectSound:PlayWithinDistance", -1, player, 3.0, "LockerOpen", 1.0)
      end
    end
  end
)

RegisterServerEvent("door:load")
AddEventHandler(
  "door:load",
  function(id, status)
    local list = {}
    for k, v in pairs(doorList) do
      list[k] = v.locked
    end
    TriggerClientEvent("door:loadSend", -1, list)
  end
)

local function doorSync()
  TriggerClientEvent("door:loadSend", -1, doorList)
  SetTimeout(5000, doorSync)
end
