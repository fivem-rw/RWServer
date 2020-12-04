local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_gpstracker")

RegisterServerEvent("vrp_gpstracker:sendblip")
AddEventHandler(
	"vrp_gpstracker:sendblip",
	function(veh)
		vRP.getUserList(
			{
				function(userList)
					for k, v in pairs(userList) do
						if v.jobType == "cop" then
							TriggerClientEvent("vrp_gpstracker:trackerset", v.source, veh)
						end
					end
				end
			}
		)
	end
)

RegisterServerEvent("vrp_gpstracker:removetracker")
AddEventHandler(
	"vrp_gpstracker:removetracker",
	function(gps)
		vRP.getUserList(
			{
				function(userList)
					for k, v in pairs(userList) do
						if v.jobType == "cop" then
							TriggerClientEvent("vrp_gpstracker:trackerremove", v.source, gps)
						end
					end
				end
			}
		)
	end
)

RegisterServerEvent("vrp_gpstracker:PlayWithinDistance")
AddEventHandler(
	"vrp_gpstracker:PlayWithinDistance",
	function(maxDistance, soundFile, soundVolume)
		--TriggerClientEvent("vrp_gpstracker:playsoundlocal", -1, source, maxDistance, soundFile, soundVolume)
	end
)

RegisterServerEvent("vrp_gpstracker:findtrackedcar")
AddEventHandler(
	"vrp_gpstracker:findtrackedcar",
	function(vehicle)
		TriggerClientEvent("vrp_gpstracker:playsoundontrackedcar", -1, vehicle)
	end
)
