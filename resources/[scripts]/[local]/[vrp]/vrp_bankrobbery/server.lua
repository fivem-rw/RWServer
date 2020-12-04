-- Remember to use the cop group or this won't work
-- K > Admin > Add Group > User ID > cop

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_bankrobbery")

local isTest = false

local banks = {
	["fleeca"] = {
		position = {["x"] = 147.04908752441, ["y"] = -1044.9448242188, ["z"] = -1229.36802482605},
		reward = 50000000 + math.random(50000, 300000000),
		nameofbank = "플리카 은행",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["fleeca2"] = {
		position = {["x"] = -2957.6674804688, ["y"] = 481.45776367188, ["z"] = -1215.697026252747},
		reward = 10000000 + math.random(10000, 50000000),
		nameofbank = "서부 플리카 은행",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["blainecounty"] = {
		position = {["x"] = -107.06505584717, ["y"] = 6474.8012695313, ["z"] = -1331.62670135498},
		reward = 20000000 + math.random(20000, 100000000),
		nameofbank = "블레인 카운티 저축은행",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["fleeca3"] = {
		position = {["x"] = -1212.2568359375, ["y"] = -336.128295898438, ["z"] = -1336.7907638549805},
		reward = 10000000 + math.random(10000, 50000000),
		nameofbank = "플리카은행 (바인우드 힐즈)",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["fleeca4"] = {
		position = {["x"] = -354.452575683594, ["y"] = -53.8204879760742, ["z"] = -1348.0463104248047},
		reward = 10000000 + math.random(10000, 50000000),
		nameofbank = "플리카은행 (버튼)",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["fleeca5"] = {
		position = {["x"] = 309.967376708984, ["y"] = -283.033660888672, ["z"] = -1353.1745223999023},
		reward = 10000000 + math.random(10000, 50000000),
		nameofbank = "플리카은행 (알타)",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["fleeca6"] = {
		position = {["x"] = 1176.86865234375, ["y"] = 2711.91357421875, ["z"] = -1338.097785949707},
		reward = 10000000 + math.random(10000, 20000000),
		nameofbank = "플리카은행 (그랜드 세뇨라 사막)",
		lastrobbed = 0,
		reTime = 3600,
		time = 3600
	},
	["pacific"] = {
		position = {["x"] = 255.001098632813, ["y"] = 225.855895996094, ["z"] = 101.005694274902},
		reward = 300000000 + math.random(100000, 200000000),
		nameofbank = "퍼시픽 스탠다드 은행",
		lastrobbed = 0,
		reTime = 3600,
		time = 600
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent("es_bank:init")
AddEventHandler(
	"es_bank:init",
	function()
		local player = source
		TriggerClientEvent("es_bank:init", player, banks)
	end
)

RegisterServerEvent("es_bank:updateOnline")
AddEventHandler(
	"es_bank:updateOnline",
	function()
		local player = source
		local user_id = vRP.getUserId({player})
		if user_id == nil then
			return
		end
		if robbers[user_id] then
			robbers[user_id][1] = true
		end
	end
)

RegisterServerEvent("es_bank:toofar")
AddEventHandler(
	"es_bank:toofar",
	function(robb)
		local player = source
		local user_id = vRP.getUserId({player})
		if user_id == nil then
			return
		end
		if (robbers[user_id]) then
			TriggerClientEvent("es_bank:toofarlocal", player)
			robbers[user_id] = nil
			if not isTest then
				TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "은행 강도를 모두 체포했습니다. ^2" .. banks[robb].nameofbank)
			end
			banks[robb].lastrobbed = os.time()
		end
	end
)

RegisterServerEvent("es_bank:playerdied")
AddEventHandler(
	"es_bank:playerdied",
	function(robb)
		local player = source
		local user_id = vRP.getUserId({player})
		if user_id == nil then
			return
		end
		if (robbers[user_id]) then
			TriggerClientEvent("es_bank:playerdiedlocal", player)
			robbers[user_id] = nil
			if not isTest then
				TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "은행 강도를 모두 체포했습니다. ^2" .. banks[robb].nameofbank)
			end
			banks[robb].lastrobbed = os.time()
		end
	end
)

RegisterServerEvent("es_bank:rob")
AddEventHandler(
	"es_bank:rob",
	function(robb)
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local cops = vRP.getUsersByPermission({"police.check"})
		if user_id == nil then
			return
		end
		if vRP.hasPermission({user_id, "police.check"}) then
			vRPclient.notify(player, {"~r~경찰은 은행강도를 진행 할 수 없습니다."})
		else
			if #cops >= 5 then
				if banks[robb] then
					local bank = banks[robb]
					if (os.time() - bank.lastrobbed) < bank.reTime and bank.lastrobbed ~= 0 then
						TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "이 은행은 이미 최근에 강도가 발생하였습니다. 은행 강도는 ^2" .. (bank.reTime - (os.time() - bank.lastrobbed)) .. "^0 초 후에 진행할 수 있습니다.")
						return
					end
					if not isTest then
						TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
						TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "^0" .. bank.nameofbank .. " 에서 강도가 발생하였습니다! ")
					end
					TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "당신은 ^2" .. bank.nameofbank .. "^0 에서 강도를 시작하였습니다. 빨간 비콘에서 너무 멀리 떨어지지 마세요.")
					TriggerClientEvent("chatMessage", player, "알림", {255, 0, 0}, "^1 " .. math.floor(bank.time / 60) .. " ^0분간 체포 또는 사망하지 않고 현 지점을 점령하면 보상이 주어집니다!")
					bank.lastrobbed = os.time()
					robbers[user_id] = {true, robb}
					TriggerClientEvent("es_bank:currentlyrobbing", player, robb, bank.time)
					local savedSource = player
					SetTimeout(
						bank.time * 1000,
						function()
							if robbers[user_id] then
								robbers[user_id] = nil
								bank.lastrobbed = os.time()
								vRP.giveInventoryItem({user_id, "money", bank.reward, true})
								if not isTest then
									TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, " 충격. 경찰은 무얼 하고 있었나? ^2" .. bank.nameofbank .. "^0 에서 은행 강도를 성공한 일당이 도주!")
								end
								TriggerClientEvent("es_bank:robberycomplete", savedSource, bank.reward)
							end
						end
					)
				end
			else
				vRPclient.notify(player, {"~r~접속 중인 경찰이 충분하지 않습니다."})
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			for k, v in pairs(robbers) do
				if v then
					if v[1] then
						v[1] = false
					else
						if not isTest then
							TriggerClientEvent("chatMessage", -1, "속보 ", {255, 0, 0}, "은행 강도가 사망했습니다. ^2" .. banks[v[2]].nameofbank)
						end
						banks[v[2]].lastrobbed = os.time()
						robbers[k] = nil
					end
				end
			end
			Citizen.Wait(10000)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3은행 RP가 시작되었습니다!!")
	end
)