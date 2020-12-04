local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_rcCar")

local stat = false

vRP.defInventoryItem({"binoclu", "Binoclu", "Poti sa vezi la distanta mare", function(args)
	local choices = {}
	
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			if stat then
				stat = false
				TriggerClientEvent('binoculars:Activate', player, false)
				vRPclient.notify(player,{"Ai dezactivat binoclul."})
				vRP.closeMenu({player})
			else
				stat = true
				TriggerClientEvent('binoculars:Activate', player, true)
				vRPclient.notify(player,{"Ai activat binoclul."})
				vRP.closeMenu({player})
			end
		end
	end}

	return choices
end, 0.01})
