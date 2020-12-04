local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_pizza")
vRPcs = {}
Tunnel.bindInterface("vRP_pizza", vRPcs)

function vRPcs.propina(propina)
	local user_id = vRP.getUserId({source})
	vRP.giveMoney({user_id, propina})
	--[[	TriggerEvent('es:getPlayerFromId',source, function(user)
			user.addMoney((propina))
	end)]]
	--
end

function vRPcs.checkjob()
	local player = source
	local user_id = vRP.getUserId({player})

	if vRP.hasGroup({user_id, "피자배달부"}) then
		TriggerClientEvent("okpizza", source)
	else
		vRPclient.notify(player, {"~r~피자배달부만 이용 가능합니다!"})
	end
end