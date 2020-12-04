local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "lenhador")

local reward = {1, 5}
local preco_venda = 40000

local arrRestTime = {}
local isTest = false

RegisterServerEvent("lenhador:reject")
AddEventHandler(
	"lenhador:reject",
	function()
		vRPclient.notify(source, {"~r~잠시 후 다시 작업이 가능합니다."})
	end
)

RegisterServerEvent("lenhador:rewardWood")
AddEventHandler(
	"lenhador:rewardWood",
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
		local new_weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"ljmadeira"})
		if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
			vRP.giveInventoryItem({user_id, "ljmadeira", rndResult, false})
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "[시스템 메세지] 나무를 열심히 패서 장작 " .. rndResult .. "개를 획득 하였습니다.", {255, 255, 255, 0.5, "", 0, 100, 0, 0.50})
			vRPclient.notify(source, {"~y~장작 " .. rndResult .. "개~w~를 획득하였습니다."})
			TriggerEvent("vrp_eventbox2:getItem", source, 5, {"eventitem_event2_vivestone5", "eventitem_event2_vivestone6"})
		else
			TriggerClientEvent("chatMessage", source, "", {255, 0, 0}, "", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5})
		end
	end
)

RegisterServerEvent("lenhador:processWood")
AddEventHandler(
	"lenhador:processWood",
	function()
		local player = source
		local user_id = vRP.getUserId({player})

		if not isTest then
			local ctime = os.time()
			if arrRestTime[user_id] ~= nil and ctime - 2 < arrRestTime[user_id] then
				vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
				return
			end
			arrRestTime[user_id] = ctime
		end

		if vRP.tryGetInventoryItem({user_id, "ljmadeira", 1, true}) then
			vRP.giveMoney({user_id, preco_venda})
		end
	end
)
