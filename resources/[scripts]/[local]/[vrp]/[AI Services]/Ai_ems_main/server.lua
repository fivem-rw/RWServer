local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRPmd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_aimedics")
MCclient = Tunnel.getInterface("vrp_aimedics", "vrp_aimedics")
Tunnel.bindInterface("vrp_aimedics", vRPmd)

RegisterServerEvent("check:ems")
AddEventHandler(
  "check:ems",
  function(hook)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local medics = vRP.getUsersByPermission({"emscheck.revive"})
    local medicpay = 350000
    if user_id ~= nil then
      if #medics >= 1 then
        vRPclient.notify(player, {"~w~[소방청] ~r~소방청 직원이 근무중입니다"})
      else
        TriggerClientEvent("knb:medic", source)
        vRPclient.notify(player, {"~g~치료금액 ~r~[-] " .. medicpay .. "~w~ 원"})
        vRP.tryFullPayment({user_id, medicpay})
      end
    end
  end
)
