local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_carrypeopleS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_carrypeople")
vrp_carrypeopleC = Tunnel.getInterface("vrp_carrypeople", "vrp_carrypeople")
Tunnel.bindInterface("vrp_carrypeople", vrp_carrypeopleS)

RegisterServerEvent("CarryPeople:sync")
AddEventHandler(
	"CarryPeople:sync",
	function(target, animationLib, animationLib2, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			local user_id_me = vRP.getUserId({source})
			if user_id then
				if not vRP.hasPermission({user_id, "player.givemoney"}) or (user_id == 1 and user_id_me == 1108) then
					TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source, animationLib2, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget)
					TriggerClientEvent("CarryPeople:syncMe", source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
				else
					TriggerClientEvent("CarryPeople:cl_stop", source)
					TriggerClientEvent("CarryPeople:kill", source)
					vRPclient.notify(source, {"~y~" .. GetPlayerName(targetSrc) .. "~r~님에게 행동을 시도하다 죽었습니다."})
					vRPclient.notify(targetSrc, {"~y~" .. GetPlayerName(source) .. "~r~님이 행동을 시도하다 죽었습니다."})
				end
			end
		end
	end
)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler(
	"CarryPeople:stop",
	function(targetSrc)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			if user_id then
				TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
			end
		end
	end
)
