local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_postup")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

local post_job = "postup.job" -- 택배 직업란

RegisterServerEvent("vrp_postup:permissao")
AddEventHandler("vrp_postup:permissao",function()
	local source = source
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id,post_job}) then
	TriggerClientEvent("vrp_postup:permissao",player)
    else
	vRPclient.notify(player,{'~r~당신은 택배 직업이 아닙니다!'})
end


RegisterServerEvent("vrp_postup:receber")
AddEventHandler("vrp_postup:receber", function(pagamento)
	local source = source
	local user_id = vRP.getUserId({source})
    if user_id then
		vRP.giveMoney({user_id,parseInt(pagamento)})
		TriggerClientEvent("vrp_sound:source",source,"dinheiro",0.3)
	end
end)

RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)