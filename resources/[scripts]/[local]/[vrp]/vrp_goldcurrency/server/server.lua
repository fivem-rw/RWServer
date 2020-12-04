--------------------------------
----- Converting By. 알고리즘 -----
--------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_GoldCurrency")

local SmelteryTimer = {}
local ExchangeTimer = {}
local GoldJobTimer = {}

local NPC = 0

function comma_Hi(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k == 0) then
			break
		end
	end
	return formatted
end

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		while false do
			NPC = math.random(1, #Config.MissionNPC)
			--TriggerClientEvent("esx_goldCurrency:spawnNPC", -1, Config.MissionNPC[NPC])
			Citizen.Wait(7200000 * 2)
		end
	end
)

AddEventHandler(
	"vRP:playerSpawn",
	function(source)
		if NPC ~= 0 and Config.MissionNPC[NPC] ~= nil then
			--TriggerClientEvent("esx_goldCurrency:spawnNPC", -1, Config.MissionNPC[NPC])
		end
	end
)

RegisterServerEvent("esx_goldCurrency:MeltingCooldown")
AddEventHandler(
	"esx_goldCurrency:MeltingCooldown",
	function(source)
		table.insert(SmelteryTimer, {MeltingTimer = GetPlayerIdentifier(source), time = (Config.SmelteryTime * 1000)})
	end
)

RegisterServerEvent("esx_goldCurrency:ExhangeCooldown")
AddEventHandler(
	"esx_goldCurrency:ExhangeCooldown",
	function(source)
		table.insert(ExchangeTimer, {ExchangeTimer = GetPlayerIdentifier(source), timeExchange = (Config.ExchangeCooldown * 60000)})
	end
)

RegisterServerEvent("esx_goldCurrency:GoldJobCooldown")
AddEventHandler(
	"esx_goldCurrency:GoldJobCooldown",
	function(source)
		table.insert(GoldJobTimer, {GoldJobTimer = GetPlayerIdentifier(source), timeGoldJob = (2 * 60000)})
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			for k, v in pairs(SmelteryTimer) do
				if v.time <= 0 then
					RemoveSmelteryTimer(v.MeltingTimer)
				else
					v.time = v.time - 1000
				end
			end
			for k, v in pairs(ExchangeTimer) do
				if v.timeExchange <= 0 then
					RemoveExchangeTimer(v.ExchangeTimer)
				else
					v.timeExchange = v.timeExchange - 1000
				end
			end
			for k, v in pairs(GoldJobTimer) do
				if v.timeGoldJob <= 0 then
					RemoveGoldJobTimer(v.GoldJobTimer)
				else
					v.timeGoldJob = v.timeGoldJob - 1000
				end
			end
		end
	end
)

RegisterServerEvent("esx_goldCurrency:getGoldJobCoolDown")
AddEventHandler(
	"esx_goldCurrency:getGoldJobCoolDown",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		if not CheckGoldJobTimer(GetPlayerIdentifier(source)) then
			TriggerClientEvent("esx_goldCurrency:getGoldJobCoolDown", source, false)
		else
			TriggerClientEvent("esx:showNotification", source, string.format("~b~%s~s~분 이후에 ~r~다시 시도~w~하여주십시오!", GetGoldJobTimer(GetPlayerIdentifier(source))))
			TriggerClientEvent("esx_goldCurrency:getGoldJobCoolDown", source, true)
		end
	end
)

-- 경찰 빌립스
RegisterServerEvent("esx_goldCurrency:isPlayerWhitelisted")
AddEventHandler(
	"esx_goldCurrency:isPlayerWhitelisted",
	function()
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id, Config.PoliceDatabaseName}) then
			TriggerClientEvent("esx_goldCurrency:isPlayerWhitelisted", source, true)
		else
			TriggerClientEvent("esx_goldCurrency:isPlayerWhitelisted", source, false)
		end
	end
)

RegisterServerEvent("esx_goldCurrency:missionAccepted")
AddEventHandler(
	"esx_goldCurrency:missionAccepted",
	function()
		TriggerClientEvent("esx_goldCurrency:startMission", source, 0)
	end
)

RegisterServerEvent("esx_goldCurrency:getPayment")
AddEventHandler(
	"esx_goldCurrency:getPayment",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local blackMoney = 0
		local dirtyMoney = "special_goldticket" -- Config.UseBlackMoneyAsMissionCost True 했을경우 dirty_money 아이템 Config.MissionCost 개 차감.
		blackMoney = vRP.getInventoryItemAmount({user_id, dirtyMoney})
		local moneyCash = 0
		moneyCash = vRP.getMoney({user_id})
		if Config.UseBlackMoneyAsMissionCost == true then
			if blackMoney <= Config.MissionCost then
				vRPclient.notify(player, {"~r~금괴 습격을 하는데에" .. vRP.getItemName({dirtyMoney}) .. " 아이템이 부족합니다."})
				TriggerClientEvent("esx_goldCurrency:getPayment", source, false)
			else
				vRP.tryGetInventoryItem({user_id, dirtyMoney, Config.MissionCost})
				TriggerEvent("esx_goldCurrency:GoldJobCooldown", source)
				TriggerClientEvent("esx_goldCurrency:getPayment", source, true)
			end
		else
			if moneyCash <= Config.MissionCost then
				vRPclient.notify(player, {"~r~금괴 습격을 시작하는데에 현금이 부족합니다."})
				TriggerClientEvent("esx_goldCurrency:getPayment", source, false)
			else
				vRP.tryPayment({user_id, Config.MissionCost})
				TriggerEvent("esx_goldCurrency:GoldJobCooldown", source)
				TriggerClientEvent("esx_goldCurrency:getPayment", source, true)
			end
		end
	end
)

RegisterServerEvent("esx_goldCurrency:getMissionavailability")
AddEventHandler(
	"esx_goldCurrency:getMissionavailability",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local policeOnline = 0
		local cops = vRP.getUsersByPermission({Config.PoliceDatabaseName})

		policeOnline = #cops
		if policeOnline >= Config.RequiredPoliceOnline then
			TriggerClientEvent("esx_goldCurrency:getMissionavailability", source, true)
		else
			TriggerClientEvent("esx_goldCurrency:getMissionavailability", source, false)
			vRPclient.notify(player, {"~r~서버에 경찰이 충분하지 않아서 습격을 진행할수 없습니다."})
		end
	end
)

-- 경찰직업은 이 습격을 할수 없는구문.
RegisterServerEvent("esx_goldCurrency:getcopnomisssion")
AddEventHandler(
	"esx_goldCurrency:getcopnomisssion",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})

		if vRP.hasPermission({user_id, Config.PoliceDatabaseName}) then
			TriggerClientEvent("esx_goldCurrency:getcopnomisssion", source, false)
			vRPclient.notify(player, {"~r~경찰 직업은 할수 없는 미션입니다."})
		else
			TriggerClientEvent("esx_goldCurrency:getcopnomisssion", source, true)
		end
	end
)

RegisterServerEvent("esx_goldCurrency:reward")
AddEventHandler(
	"esx_goldCurrency:reward",
	function()
		local _source = source
		local user_id = vRP.getUserId({_source})
		local player = vRP.getUserSource({user_id})
		local SecondItem = false

		local itemAmount1 = ((math.random(Config.ItemMinAmount1, Config.ItemMaxAmount1)) * 1)
		local item1 = vRP.getItemName({Config.ItemName1})

		local itemAmount2 = math.random(Config.ItemMinAmount2, Config.ItemMaxAmount2)
		local item2 = vRP.getItemName({Config.ItemName2})

		local chance = math.random(1, Config.RandomChance)
		if chance == 1 then
			SecondItem = true
		end

		if Config.EnableSecondItemReward == true and SecondItem == true then
			vRP.giveInventoryItem({user_id, Config.ItemName1, itemAmount1})
			vRP.giveInventoryItem({user_id, Config.ItemName2, itemAmount2})
			if Config.EnableCustomNotification == true then
				TriggerClientEvent("esx_goldCurrency:missionComplete", source, itemAmount1, item1, itemAmount2, item2)
			else
				vRPclient.notify(player, {"[~g~※습격 성공 보상※~w~]:~y~\n" .. vRP.getItemName({item1}) .. "~b~ " .. comma_Hi(itemAmount1) .. "~s~개\n~y~" .. vRP.getItemName({item2}) .. "~b~" .. comma_Hi(itemAmount2) .. "~s~개 ~g~받았습니다."})
			end
		else
			vRP.giveInventoryItem({user_id, Config.ItemName1, itemAmount1})
			if Config.EnableCustomNotification == true then
				TriggerClientEvent("esx_goldCurrency:missionComplete", source, itemAmount1, item1)
			else
				vRPclient.notify(player, {"[~g~※습격 성공 보상※~w~]:~y~\n" .. vRP.getItemName({item1}) .. "~b~ " .. comma_Hi(itemAmount1) .. "~w~개 ~g~받았습니다."})
			end
		end
	end
)

RegisterServerEvent("esx_goldCurrency:GoldJobInProgress")
AddEventHandler(
	"esx_goldCurrency:GoldJobInProgress",
	function(targetCoords, streetName)
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		TriggerClientEvent("esx_goldCurrency:outlawNotify", -1, string.format("^8알수 없는 조직들이 금괴 차량을 탈취하고 있습니다!! 위치: %s", streetName))
		TriggerClientEvent("chatMessage", -1, "🚨 ^1속보 ", {255, 255, 255}, "^2" .. GetPlayerName(player) .. " ^*( " .. user_id .. " )님이 ^2금괴 습격 미션 RP^0를 시작 하였습니다!")
		TriggerClientEvent("esx_goldCurrency:GoldJobInProgress", -1, targetCoords)
	end
)

RegisterServerEvent("esx_goldCurrency:syncMissionData")
AddEventHandler(
	"esx_goldCurrency:syncMissionData",
	function(data)
		TriggerClientEvent("esx_goldCurrency:syncMissionData", -1, data)
	end
)

RegisterServerEvent("esx_goldCurrency:goldMelting")
AddEventHandler(
	"esx_goldCurrency:goldMelting",
	function()
		local _source = source
		local user_id = vRP.getUserId({_source})
		local player = vRP.getUserSource({user_id})
		local goldbaritem = "special_goldbar" -- 골드바 아이템
		local goldwatchitem = "goldwatch" -- 금시계 아이템
		local goldbaramount = 1 -- 갯수 설정

		if vRP.getInventoryItemAmount({user_id, goldwatchitem}) >= 1 then
			if vRP.getInventoryItemAmount({user_id, goldbaritem}) <= 99 then
				if not CheckIfMelting(GetPlayerIdentifier(source)) then
					TriggerEvent("esx_goldCurrency:MeltingCooldown", source)

					vRP.tryGetInventoryItem({user_id, goldwatchitem, 1})

					TriggerClientEvent("GoldWatchToGoldBar", source)
					TriggerClientEvent("chatMessage", -1, "🚨 ^1금괴 습격 미션 ", {255, 255, 255}, "^2" .. GetPlayerName(player) .. " ^*(" .. user_id .. ")^0님이 ^2금괴^0를 융해하고 있습니다")
					Citizen.Wait((Config.SmelteryTime * 1000))

					vRP.giveInventoryItem({user_id, goldbaritem, 1})
				else
					TriggerClientEvent("esx:showNotification", source, string.format("~r~이미 금을 융해 하고 있습니다.", GetTimeForMelting(GetPlayerIdentifier(source))))
				end
			else
				vRPclient.notify(player, {"~r~최대 ~y~" .. vRP.getItemName({goldbaritem}) .. " ~r~99개 까지만 가질수있습니다."})
			end
		else
			vRPclient.notify(player, {"~y~" .. vRP.getItemName({goldwatchitem}) .. "~w~가 부족합니다.\n~r~1개이상 있어야합니다."})
		end
	end
)

RegisterServerEvent("esx_goldCurrency:goldExchange")
AddEventHandler(
	"esx_goldCurrency:goldExchange",
	function()
		local _source = source
		local user_id = vRP.getUserId({_source})
		local player = vRP.getUserSource({user_id})
		local goldbaritem = "special_goldbar" -- 골드바 아이템
		local goldbaramount = 1 -- 갯수 설정
		local goldbbox = math.random(1, 5)
		if not CheckIfExchanging(GetPlayerIdentifier(source)) then
			if vRP.getInventoryItemAmount({user_id, goldbaritem}) >= goldbaramount then
				TriggerEvent("esx_goldCurrency:ExhangeCooldown", source)

				vRP.tryGetInventoryItem({user_id, goldbaritem, goldbaramount})

				TriggerClientEvent("GoldBarToCash", source)
				Citizen.Wait((Config.ExchangeTime * 1000))

				vRP.giveInventoryItem({user_id, "special_goldb", goldbbox})
			else
				vRPclient.notify(player, {"~r~최소~y~ " .. vRP.getItemName({goldbaritem}) .. " " .. comma_Hi(goldbaramount) .. " 개가 필요합니다."})
			end
		else
			TriggerClientEvent("esx:showNotification", source, string.format("~r~[쿨타임]\n~b~%s분~w~ 후에 다시 시도 해주세요.", GetTimeForExchange(GetPlayerIdentifier(source))))
		end
	end
)

function RemoveSmelteryTimer(source)
	for k, v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			table.remove(SmelteryTimer, k)
		end
	end
end

function GetTimeForMelting(source)
	for k, v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return math.ceil(v.time / 1000)
		end
	end
end

function CheckIfMelting(source)
	for k, v in pairs(SmelteryTimer) do
		if v.MeltingTimer == source then
			return true
		end
	end
	return false
end

function RemoveExchangeTimer(source)
	for k, v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			table.remove(ExchangeTimer, k)
		end
	end
end

function GetTimeForExchange(source)
	for k, v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return math.ceil(v.timeExchange / 60000)
		end
	end
end

function CheckIfExchanging(source)
	for k, v in pairs(ExchangeTimer) do
		if v.ExchangeTimer == source then
			return true
		end
	end
	return false
end

function RemoveGoldJobTimer(source)
	for k, v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			table.remove(GoldJobTimer, k)
		end
	end
end

function GetGoldJobTimer(source)
	for k, v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return math.ceil(v.timeGoldJob / 60000)
		end
	end
end

function CheckGoldJobTimer(source)
	for k, v in pairs(GoldJobTimer) do
		if v.GoldJobTimer == source then
			return true
		end
	end
	return false
end

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3금괴 RP가 시작되었습니다!!")
	end
)