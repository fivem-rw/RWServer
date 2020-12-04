local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_aRevive")

local a_revive = {
	function(player, choice)
		vRP.prompt(
			{
				player,
				"플레이어 고유번호:",
				"",
				function(player, target_id)
					if target_id ~= nil and target_id ~= "" then
						local nplayer = vRP.getUserSource({tonumber(target_id)})
						if nplayer ~= nil and nplayer ~= "" then
							vRPclient.isInComa(
								nplayer,
								{},
								function(in_coma)
									if in_coma then
										vRPclient.varyHealth(nplayer, {100})
										SetTimeout(
											150,
											function()
												vRPclient.varyHealth(nplayer, {100})
												vRP.varyHunger({target_id, -100})
												vRP.varyThirst({target_id, -100})
											end
										)
										vRPclient.notify(player, {"~g~" .. GetPlayerName(nplayer) .. "~w~ 이(가) 관리자에 의해 부활하였습니다."})
										vRPclient.notify(nplayer, {"관리자 ~g~" .. GetPlayerName(player) .. "~w~ 에 의해 부활하였습니다."})
									else
										vRPclient.notify(player, {"~r~해당 플레이어는 혼수상태가 아닙니다."})
									end
								end
							)
						else
							vRPclient.notify(player, {"~r~접속한 플레이이어가 아닙니다."})
						end
					else
						vRPclient.notify(player, {"~r~선택한 플레이어 ID가 없습니다."})
					end
				end
			}
		)
	end,
	"죽은 플레이어를 부활 시키십시오."
}

vRP.registerMenuBuilder(
	{
		"admin",
		function(add, data)
			local user_id = vRP.getUserId({data.player})
			if user_id ~= nil then
				local choices = {}

				if vRP.hasPermission({user_id, "admin.revive"}) then
					choices["*부활"] = a_revive
				end
				add(choices)
			end
		end
	}
)

RegisterNetEvent("proxy_vrp_arevive:action")
AddEventHandler(
	"proxy_vrp_arevive:action",
	function(type)
		local player = source
		local user_id = vRP.getUserId({player})
		if not user_id then
			return
		end
		if type == "vrp_arevive_a_revive" then
			if vRP.hasPermission({user_id, "admin.revive"}) then
				a_revive[1](source, "")
			end
		end
	end
)
