local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "milkfarm")

local reward = {1, 1}

local preco_venda = 0
local preco_compra = 0
local pode_comprar = "farm.legal"

local arrRestTime = {}
local isTest = false

AddEventHandler(
	"chatMessage",
	function(source, n, message)
		command = stringsplit(message, " ")
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		if command[1] == "/leiteiroon" then
			vRP.addUserGroup({user_id, "Leiteiro"})
			TriggerClientEvent("chatMessage", player, "농장", {255, 255, 255}, "직업을 끝낼려면 /leiteirooff 를입력하십시오.", {255, 255, 255, 1.0, "", 10, 10, 10, 0.5}, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET")
		end

		if command[1] == "/leiteirooff" then
			vRP.removeUserGroup({user_id, "Leiteiro"})
			TriggerClientEvent("chatMessage", player, "농장", {255, 255, 255}, "사냥꾼 목장 일을 시작할려면 /leiteiroon 를입력하십시오", {255, 255, 255, 1.0, "", 10, 10, 10, 0.5}, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET")
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

RegisterServerEvent("milkfarm:getMilkOnPalet")
AddEventHandler(
	"milkfarm:getMilkOnPalet",
	function()
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id, pode_comprar}) then
			TriggerClientEvent("milkfarm:getMilkOnPalet", source)
		else
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 사냥꾼이 아니여서 실행이 불가합니다.", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "Hit", "RESPAWN_SOUNDSET")
		end
	end
)

RegisterServerEvent("milkfarm:getMilkItem")
AddEventHandler(
	"milkfarm:getMilkItem",
	function()
		local player = source
		local user_id = vRP.getUserId({player})

		if not isTest then
			local ctime = os.time()
			if arrRestTime[user_id] ~= nil and ctime - 10 < arrRestTime[user_id] then
				vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
				return
			end
			arrRestTime[user_id] = ctime
		end
		
		local rndMin, rndMax = table.unpack(reward)
		local rndResult = math.random(rndMin, rndMax)
		if vRP.hasPermission({user_id, pode_comprar}) then
			if vRP.tryGetInventoryItem({user_id, "garrafa_vazia", rndResult}) then
				vRP.giveInventoryItem({user_id, "garrafa_leite", rndResult, false})
				vRPclient.notify(source, {"~g~🐄 흰우유~w~ 1개를 받았습니다."})
			else
				TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 우유박스가 부족합니다!", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5})
				vRPclient.notify(source, {"~r~🐄 우유박스~w~가 부족합니다!"})
			end
		else
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 사냥꾼이 아니여서 실행이 불가합니다.", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "Hit", "RESPAWN_SOUNDSET")
		end
	end
)
