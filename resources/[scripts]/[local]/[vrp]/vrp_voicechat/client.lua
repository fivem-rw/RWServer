---------------------------------------------------------
------------ VRP VoiceChat, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_voicechatC = {}
Tunnel.bindInterface("vrp_voicechat", vrp_voicechatC)
Proxy.addInterface("vrp_voicechat", vrp_voicechatC)
vRP = Proxy.getInterface("vRP")
vrp_voicechatS = Tunnel.getInterface("vrp_voicechat", "vrp_voicechat")

function vrp_voicechatC.play(text, coords, name)
	if coords.x == 0 and coords.y == 0 and coords.z == 0 then
		SendNUIMessage(
			{
				type = "play",
				message = {
					text = text,
					name = name
				}
			}
		)
	else
		local mCoords = GetEntityCoords(GetPlayerPed(-1))
		local dist = GetDistanceBetweenCoords(mCoords, coords, 1)
		if dist < 15 then
			SendNUIMessage(
				{
					type = "play",
					message = {
						text = text,
						name = name
					}
				}
			)
		end
	end
end
