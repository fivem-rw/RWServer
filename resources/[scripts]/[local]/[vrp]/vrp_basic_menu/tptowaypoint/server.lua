local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_basic_menu:TpToWaypoint")
AddEventHandler(
	"vrp_basic_menu:TpToWaypoint",
	function()
		local _source = source
		local user_id = vRP.getUserId({_source})
		if vRP.hasPermission({user_id, "player.tptowaypoint"}) then
			TriggerClientEvent("TpToWaypoint", _source)
		end
	end
)
