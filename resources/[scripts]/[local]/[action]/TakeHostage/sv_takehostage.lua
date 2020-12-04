local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_takehostageS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_takehostage")
vrp_takehostageC = Tunnel.getInterface("vrp_takehostage", "vrp_takehostage")
Tunnel.bindInterface("vrp_takehostage", vrp_takehostageS)

RegisterServerEvent("cmg3_animations:sync")
AddEventHandler(
	"cmg3_animations:sync",
	function(target, animationLib, animationLib2, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget, attachFlag)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			local user_id_me = vRP.getUserId({source})
			if user_id then
				if not vRP.hasPermission({user_id, "player.givemoney"}) or (user_id == 1 and user_id_me == 1108) then
					TriggerClientEvent("cmg3_animations:syncTarget", targetSrc, source, animationLib2, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget, attachFlag)
					TriggerClientEvent("cmg3_animations:syncMe", source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
				else
					TriggerClientEvent("cmg3_animations:cl_stop", source)
					TriggerClientEvent("cmg3_animations:kill", source)
					vRPclient.notify(source, {"~y~" .. GetPlayerName(targetSrc) .. "~r~님에게 행동을 시도하다 죽었습니다."})
					vRPclient.notify(targetSrc, {"~y~" .. GetPlayerName(source) .. "~r~님이 행동을 시도하다 죽었습니다."})
				end
			end
		end
	end
)

RegisterServerEvent("cmg3_animations:stop")
AddEventHandler(
	"cmg3_animations:stop",
	function(targetSrc)
		if targetSrc then
			local user_id = vRP.getUserId({targetSrc})
			if user_id then
				TriggerClientEvent("cmg3_animations:cl_stop", targetSrc)
			end
		end
	end
)
