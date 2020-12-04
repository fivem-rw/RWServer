local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_wdcardS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_wdcard")
vrp_wdcardC = Tunnel.getInterface("vrp_wdcard", "vrp_wdcard")
Tunnel.bindInterface("vrp_wdcard", vrp_wdcardS)

RegisterNetEvent("proxy_vrp_wdcard:open")
AddEventHandler(
	"proxy_vrp_wdcard:open",
	function(p)
		local player = source
		if p then
			player = p
		end
		vrp_wdcardC.open(player)
	end
)

RegisterCommand(
	"wd",
	function(source, args)
		local player = source
		if args[1] == "open" then
			vrp_wdcardC.open(player)
		end
		if args[1] == "close" then
			vrp_wdcardC.close(player)
		end
	end
)
