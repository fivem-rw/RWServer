local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_sitchairS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_sitchair")
vrp_sitchairC = Tunnel.getInterface("vrp_sitchair", "vrp_sitchair")
Tunnel.bindInterface("vrp_sitchair", vrp_sitchairS)

local seatsTaken = {}

RegisterNetEvent("esx_sit:takePlace")
AddEventHandler(
	"esx_sit:takePlace",
	function(objectCoords)
		seatsTaken[objectCoords] = true
	end
)

RegisterNetEvent("esx_sit:leavePlace")
AddEventHandler(
	"esx_sit:leavePlace",
	function(objectCoords)
		if seatsTaken[objectCoords] then
			seatsTaken[objectCoords] = nil
		end
	end
)

function vrp_sitchairS.getPlace(objectCoords)
	return seatsTaken[objectCoords]
end