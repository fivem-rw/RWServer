local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "minner")

local reward = {1, 1}

local preco_venda = 0
local pode_comprar = "farm.legal123"
local emprego_legal = false

local arrRestTime = {}
local isTest = false

AddEventHandler(
	"chatMessage",
	function(source, n, message)
		command = stringsplit(message, " ")
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		if command[1] == "/mineradoron" then
			vRP.addUserGroup({user_id, "광부"})
		end

		if command[1] == "/mineradoroff" then
			vRP.removeUserGroup({user_id, "광부"})
		end
	end
)

RegisterServerEvent("minner:getminnerOnPalet")
AddEventHandler(
	"minner:getminnerOnPalet",
	function()
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id, pode_comprar}) then
			TriggerClientEvent("minner:getminnerOnPalet", source)
		else
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 광부가 아니여서 권한이없습니다.", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "Hit", "RESPAWN_SOUNDSET")
		end
	end
)

RegisterServerEvent("minner:reject")
AddEventHandler(
	"minner:reject",
	function()
		vRPclient.notify(source, {"~r~잠시 후 다시 작업이 가능합니다."})
	end
)

RegisterServerEvent("minner:getminnerItem")
AddEventHandler(
	"minner:getminnerItem",
	function()
		local player = source
		local user_id = vRP.getUserId({player})

		if not isTest then
			local ctime = os.time()
			if arrRestTime[user_id] ~= nil and ctime - 5 < arrRestTime[user_id] then
				vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
				return
			end
			arrRestTime[user_id] = ctime
		end

		local rndMin, rndMax = table.unpack(reward)
		local rndResult = math.random(rndMin, rndMax)
		if vRP.hasPermission({user_id, pode_comprar}) then
			if vRP.tryGetInventoryItem({user_id, "picareta", rndResult}) then
				vRP.giveInventoryItem({user_id, "ouro", rndResult, false})
				vRPclient.notify(source, {"~w~광석~g~1개~w~를 채굴하였습니다."})
				TriggerEvent("vrp_eventbox2:getItem", source, 4, {"eventitem_event2_vivestone4", "eventitem_event2_vivestone5"})
			else
				TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지]  곡괭이가 없습니다 광부상점에서 곡괭이를 구매해주십시요!", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5})
				vRPclient.notify(source, {"~r~곡괭이~w~가 부족합니다!"})
			end
		else
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 작업을 할 수 없습니다.", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "Hit", "RESPAWN_SOUNDSET")
			vRPclient.notify(source, {"~r~[시스템 메세지] 작업을 할 수 없습니다!"})
		end
	end
)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
