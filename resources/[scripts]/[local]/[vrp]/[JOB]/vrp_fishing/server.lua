local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_fishing_animations")
vRPCpescar = Tunnel.getInterface("vRP_fishing_animations", "vRP_fishing_animations")

vRPpescar = {}
Tunnel.bindInterface("vRP_fishing_animations", vRPpescar)
Proxy.addInterface("vRP_fishing_animations", vRPpescar)

local arrRestTime = {}
local isTest = false

RegisterServerEvent("fishing:item")
AddEventHandler(
	"fishing:item",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local cops = vRP.getUsersByGroup({"Pescador"})
		local randomBreak = math.random(1, 20)
		if vRP.hasGroup({user_id, "user"}) then
			TriggerClientEvent("hasFishingPole", player)
		else
			vRPclient.notify(player, {"당신은 어부가 아닙니다!", "error"})
		end
	end
)
RegisterServerEvent("fishing:reward")
AddEventHandler(
	"fishing:reward",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})

		if not isTest then
			local ctime = os.time()
			if arrRestTime[user_id] ~= nil and ctime - 10 < arrRestTime[user_id] then
				vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
				return
			end
			arrRestTime[user_id] = ctime
		end

		local randomFish = math.random(1, 10)
		local new_weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"bass"})
		local new_weight2 = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"catfish"})
		local new_weight3 = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"rechin"})
		local new_weight4 = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"pescarus"})
		local new_weight5 = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({"pisicademare"})
		TriggerClientEvent("rechin", user_id)
		if randomFish >= 1 and randomFish <= 4 then
			if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
				vRPCpescar.pestele(player)
				vRP.giveInventoryItem({user_id, "bass", 1})
				vRPclient.notify(player, {"~y~베스~w~를 낚았습니다!"})
			else
				vRPclient.notify(player, {"전체 재고", "error"})
			end
		elseif randomFish == 5 then
			if new_weight2 <= vRP.getInventoryMaxWeight({user_id}) then
				vRPCpescar.pestele(player)
				vRP.giveInventoryItem({user_id, "catfish", 1})
				vRPclient.notify(player, {"~y~메기~w~를 낚았습니다!"})
			else
				vRPclient.notify(player, {"전체 재고", "error"})
			end
		elseif randomFish == 6 then
			if new_weight3 <= vRP.getInventoryMaxWeight({user_id}) then
				vRPCpescar.pestele4(player)
				vRP.giveInventoryItem({user_id, "rechin", 1})
				vRPclient.notify(player, {"~r~앗! ~y~상어~r~를 낚았습니다!"})
			else
				vRPclient.notify(player, {"전체 재고", "error"})
			end
		elseif randomFish >= 7 and randomFish <= 9 then
			if new_weight4 <= vRP.getInventoryMaxWeight({user_id}) then
				vRPCpescar.pestele3(player)
				vRP.giveInventoryItem({user_id, "pescarus", 1})
				vRPclient.notify(player, {"~y~갈매기~r~를 낚았습니다!"})
			else
				vRPclient.notify(player, {"전체 재고", "error"})
			end
		elseif randomFish == 10 then
			if new_weight5 <= vRP.getInventoryMaxWeight({user_id}) then
				vRPCpescar.pestele2(player)
				vRP.giveInventoryItem({user_id, "pisicademare", 1})
				vRPclient.notify(player, {"~r~앗! ~y~가오리~r~를 낚았습니다!"})
			else
				vRPclient.notify(player, {"전체 재고", "error"})
			end
		end
		TriggerEvent("vrp_eventbox2:getItem", player, 3, {"eventitem_event2_vivestone3", "eventitem_event2_vivestone4"})
	end
)
