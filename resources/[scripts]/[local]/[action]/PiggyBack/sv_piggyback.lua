local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_piggybackS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_piggyback")
vrp_piggybackC = Tunnel.getInterface("vrp_piggyback", "vrp_piggyback")
Tunnel.bindInterface("vrp_piggyback", vrp_piggybackS)

RegisterServerEvent("cmg2_animations:sync")
AddEventHandler(
	"cmg2_animations:sync",
	function(target, animationLib, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			local user_id_me = vRP.getUserId({source})
			if user_id then
				if not vRP.hasPermission({user_id, "player.givemoney"}) or (user_id == 1 and user_id_me == 1108) then
					TriggerClientEvent("cmg2_animations:syncTarget", targetSrc, source, animationLib, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget)
					TriggerClientEvent("cmg2_animations:syncMe", source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
				else
					TriggerClientEvent("cmg2_animations:cl_stop", source)
					TriggerClientEvent("cmg2_animations:kill", source)
					vRPclient.notify(source, {"~y~" .. GetPlayerName(targetSrc) .. "~r~님에게 행동을 시도하다 죽었습니다."})
					vRPclient.notify(targetSrc, {"~y~" .. GetPlayerName(source) .. "~r~님이 행동을 시도하다 죽었습니다."})
				end
			end
		end
	end
)

RegisterServerEvent("cmg2_animations:stop")
AddEventHandler(
	"cmg2_animations:stop",
	function(targetSrc)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			if user_id then
				TriggerClientEvent("cmg2_animations:cl_stop", targetSrc)
			end
		end
	end
)
