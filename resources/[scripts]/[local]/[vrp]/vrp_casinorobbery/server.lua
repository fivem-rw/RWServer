local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_bank")

local banks = {
	["pacific"] = {
		position = {["x"] = 942.69689941406, ["y"] = 7.6961789131165, ["z"] = 75.741485595703},
		reward = 100000000 + math.random(50000000, 120000000),
		nameofbank = "리얼월드 카지노",
		lastrobbed = 0,
		reTime = 3600,
		time = 1800
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent("casino_rb:init")
AddEventHandler(
	"casino_rb:init",
	function()
		TriggerClientEvent("casino_rb:init", source, banks)
	end
)

RegisterServerEvent("casino_rb:toofar")
AddEventHandler(
	"casino_rb:toofar",
	function(robb)
		if (robbers[source]) then
			TriggerClientEvent("casino_rb:toofarlocal", source)
			robbers[source] = nil
			TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "카지노 강도를 모두 사살했습니다. ^2" .. banks[robb].nameofbank)
			banks[robb].lastrobbed = os.time()
		end
	end
)

RegisterServerEvent("casino_rb:playerdied")
AddEventHandler(
	"casino_rb:playerdied",
	function(robb)
		if (robbers[source]) then
			TriggerClientEvent("casino_rb:playerdiedlocal", source)
			robbers[source] = nil
			TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "카지노 강도를 모두 사살했습니다. ^2" .. banks[robb].nameofbank)
			banks[robb].lastrobbed = os.time()
		end
	end
)

RegisterServerEvent("casino_rb:rob")
AddEventHandler(
	"casino_rb:rob",
	function(robb)
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local cops = vRP.getUsersByPermission({"cop.whitelisted"})
		local mafias = vRP.getUsersByPermission({"gang.whitelisted"})
		if vRP.hasPermission({user_id, "cop.whitelisted"}) or vRP.hasPermission({user_id, "gang.whitelisted"}) then
			vRPclient.notify(player, {"~r~조직 또는 경찰은 카지노강도를 진행 할 수 없습니다."})
		else
			if #cops >= 3 and #mafias >= 3 then
				if banks[robb] then
					local bank = banks[robb]
					if (os.time() - bank.lastrobbed) < bank.reTime and bank.lastrobbed ~= 0 then
						TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "카지노 강탈전이 진행된지 얼마 안되었습니다. 강탈 재시작이 ^2" .. (bank.reTime - (os.time() - bank.lastrobbed)) .. "^0 초 후에 진행할 수 있습니다.")
						return
					end
					TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
					TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
					TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "당신은 ^2" .. bank.nameofbank .. "^0 에서 강도를 시작하였습니다. 빨간 비콘에서 너무 멀리 떨어지지 마세요.")
					TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "^1 " .. math.floor(bank.time / 60) .. " ^0분간 체포 또는 사망하지 않고 현 지점을 점령하면 보상이 주어집니다!")
					TriggerClientEvent("casino_rb:currentlyrobbing", player, robb, bank.time)
					robbers[player] = robb
					local savedSource = player
					SetTimeout(
						bank.time * 1000,
						function()
							if (robbers[savedSource]) then
								if (user_id) then
									vRP.giveInventoryItem({user_id, "casino_token", bank.reward, true})
									TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, " 충격. 조직과 경찰은 무얼 하고 있었나? ^2" .. bank.nameofbank .. "^0 에서 카지노 강탈을 성공한 일당이 도주하였습니다!")
									TriggerClientEvent("casino_rb:robberycomplete", savedSource, bank.reward)
									bank.lastrobbed = os.time()
								end
							end
						end
					)
				end
			else
				vRPclient.notify(player, {"~r~접속 중인 조직 또는 경찰이 충분하지 않습니다."})
			end
		end
	end
)
