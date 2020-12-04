local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_ubereats")

function comma_Hi(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

RegisterServerEvent('vrp_ubereats:permissao')
AddEventHandler('vrp_ubereats:permissao', function()
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id,"domino.mission"}) then
		TriggerClientEvent('vrp_ubereats:permissao',player)
	else
   vRPclient.notify(player,{"~r~당신은 권한이 없습니다!"})
    end
end)

RegisterServerEvent('vrp_ubereats:receber')
AddEventHandler('vrp_ubereats:receber', function(pagamento)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    if user_id then
		vRP.giveMoney({user_id,parseInt(pagamento)})
		TriggerClientEvent("vrp_sound:source",source,'dinheiro',0.3)
		vRPclient.notify(player,{"~g~배달을 완료하여 "..comma_Hi(parseInt(pagamento)).."원을 받았습니다."})
	end
end)

RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)