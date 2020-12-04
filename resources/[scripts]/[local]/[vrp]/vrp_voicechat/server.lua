---------------------------------------------------------
------------ VRP VoiceChat, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_voicechatS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_voicechat")
vrp_voicechatC = Tunnel.getInterface("vrp_voicechat", "vrp_voicechat")
Tunnel.bindInterface("vrp_voicechat", vrp_voicechatS)

local price = 100000

AddEventHandler(
	"chatMessage",
	function(source, name, message, custom)
		local player = source
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			if message:sub(1, 1) == "!" then
				if vRP.tryPayment({user_id, price}) then
					vRPclient.notify(player, {"~g~[음성채팅] 음성채팅 비용을 지불했습니다. ~w~(" .. format_num(price) .. "원)"})
					vRPclient.getPosition(
						player,
						{},
						function(x, y, z)
							vrp_voicechatC.play(-1, {message, vector3(x, y, z), GetPlayerName(player)})
						end
					)
				else
					vRPclient.notify(player, {"~r~[음성채팅] 음성채팅 비용을 지불할 수 없습니다."})
				end
			elseif message:sub(1, 7) == "/공지" or message:sub(1, 3) == "/nc" then
				local isValid = false
				if message:sub(8, 9) == " !" then
					message = message:sub(10, message:len())
					isValid = true
				elseif message:sub(5, 6) == " !" then
					message = message:sub(7, message:len())
					isValid = true
				end
				if isValid then
					vrp_voicechatC.play(-1, {"공지 " .. message, vector3(0, 0, 0), ""})
				end
			elseif message:sub(1, 7) == "/광고" or message:sub(1, 3) == "/ad" then
				local isValid = false
				if message:sub(8, 9) == " !" then
					message = message:sub(10, message:len())
					isValid = true
				elseif message:sub(4, 5) == " !" then
					message = message:sub(6, message:len())
					isValid = true
				end
				if isValid then
					if vRP.tryPayment({user_id, price * 10}) then
						vRPclient.notify(player, {"~g~[음성채팅] 광고 음성채팅 비용을 지불했습니다. ~w~(" .. format_num(price * 10) .. "원)"})
						vrp_voicechatC.play(-1, {"광고 " .. message, vector3(0, 0, 0), GetPlayerName(player) .. " 님의 "})
					else
						vRPclient.notify(player, {"~r~[음성채팅] 광고 음성채팅 비용을 지불할 수 없습니다."})
					end
				end
			end
		end
	end
)
