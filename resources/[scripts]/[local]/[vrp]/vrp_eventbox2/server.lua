---------------------------------------------------------
------------ VRP Eventbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_eventbox2S = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_eventbox2")
vrp_eventbox2C = Tunnel.getInterface("vrp_eventbox2", "vrp_eventbox2")
Tunnel.bindInterface("vrp_eventbox2", vrp_eventbox2S)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/event2_get" .. rand, "SELECT dvalue FROM vrp_srv_data WHERE dkey = 'vRP:event2_state'")
MySQL.createCommand("vRP/event2_set" .. rand, "update vrp_srv_data set dvalue = @dvalue WHERE dkey = 'vRP:event2_state'")
MySQL.createCommand("vRP/event2_setTicket" .. rand, "update vrp_event2_tickets set user_id = @user_id, state = 1, updated_at=now() WHERE state = 0 and type = @type limit 1")
MySQL.createCommand("vRP/event2_getTickets" .. rand, "select * from vrp_event2_tickets where user_id = @user_id and state = 1 order by type asc")

local function notify(player, msg, type, timer)
	TriggerClientEvent(
		"pNotify:SendNotification",
		player,
		{
			text = msg,
			type = type or "success",
			timeout = timer or 3000,
			layout = "centerleft",
			queue = "global"
		}
	)
end

local usersOpenTime = {}
local userOpenSetTime = 1

local isState = false
local maxTotal = 1000000
local eventStateData = {}

function getDoneRate(total)
	return total / maxTotal * 100
end

function isSelectChance(chance, rChance, rate)
	if chance % 2 == 1 then
		return chance <= rChance * rate
	end
	return chance >= (100 * rate) - (rChance * rate)
end

function taskGetState()
	vrp_eventbox2C.getState(-1, {eventStateData.state, eventStateData.total, eventStateData.highRewards.user_id, eventStateData.highRewards.name, eventStateData.highRewards.amount})

	local dvalue = json.encode(eventStateData)
	if dvalue then
		MySQL.execute("vRP/event2_set" .. rand, {dvalue = dvalue})
	end

	SetTimeout(
		10000,
		function()
			taskGetState()
		end
	)
end

function updateState(amount, user_id, name)
	eventStateData.total = eventStateData.total + amount
	if eventStateData.highRewards == nil or eventStateData.highRewards.amount == nil or (eventStateData.highRewards.amount ~= nil and amount >= eventStateData.highRewards.amount) then
		eventStateData.highRewards = {
			user_id = user_id,
			name = name,
			amount = parseInt(amount)
		}
	end
	if eventStateData.total >= maxTotal then
		eventStateData.state = false
	end
end

function vrp_eventbox2S.checkOpenBox()
	local player = source
	local user_id = vRP.getUserId({player})
	if vRP.getInventoryItemAmount({user_id, "eventitem_event2_vivestone"}) > 0 then
		return true
	else
		notify(player, "부활석이 없습니다.", "error")
	end
	return false
end

function vrp_eventbox2S.openBox()
	local cfg = getConfig()
	local player = source
	local user_id = vRP.getUserId({player})

	if usersOpenTime[user_id] == nil then
		usersOpenTime[user_id] = 0
	else
		if usersOpenTime[user_id] > os.time() - userOpenSetTime then
			vRPclient.notify(player, {"~r~잠시후 이용해주세요."})
			return
		end
	end

	if eventStateData.total >= maxTotal or not isState then
		vRPclient.notify(player, {"~r~이벤트가 종료 되었습니다."})
		return false
	end

	if vRP.tryGetInventoryItem({user_id, "eventitem_event2_vivestone", cfg.giftbox.open_amount, true}) then
		usersOpenTime[user_id] = os.time()

		math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
		local rate = 10000
		local arrSelect = {}
		local selectRewards = nil
		local chance = math.random(1, 100 * rate)
		for k, v in pairs(cfg.rewards) do
			local rChance = v[2]
			if getDoneRate(eventStateData.total) >= 80 then
				rChance = v[2] / 4
			elseif getDoneRate(eventStateData.total) >= 50 then
				rChance = v[2] / 2
			end
			if isSelectChance(chance, rChance, rate) then
				table.insert(arrSelect, v)
			end
		end

		if #arrSelect > 0 then
			selectRewards = arrSelect[math.random(1, #arrSelect)]
		end

		if selectRewards == nil then
			notify(player, "부활석에 소원을 빌었지만 아무것도 받지 못했습니다!", "error")
		else
			if selectRewards[1] == "money" then
				notify(player, "부활석에 소원을 빌었더니 " .. selectRewards[4] .. "이 나왔습니다!", "success")
				if selectRewards[6] then
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[부활데이이벤트] ^2" .. GetPlayerName(player) .. "^0님이^2 부활석^0에 소원을 빌고 ^1" .. selectRewards[4] .. "^0을 획득하였습니다.")
				end
				vRP.giveMoney({user_id, selectRewards[3]})
			elseif selectRewards[1] == "item" then
				notify(player, "부활석을 소원을 빌었더니 " .. selectRewards[4] .. "이 나왔습니다!", "success")
				if selectRewards[6] then
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[부활데이이벤트] ^2" .. GetPlayerName(player) .. "^0님이^2 부활석^0에 소원을 빌고 ^1" .. selectRewards[4] .. "^0을 획득하였습니다.")
				end
				vRP.giveInventoryItem({user_id, selectRewards[3], 1})
				if selectRewards[7] then
					updateState(selectRewards[7], user_id, GetPlayerName(player))
				end
			elseif selectRewards[1] == "skin" then
				notify(player, "부활석을 소원을 빌었더니 " .. selectRewards[4] .. "이 나왔습니다!", "success")
				if selectRewards[6] then
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[부활데이이벤트] ^2" .. GetPlayerName(player) .. "^0님이^2 부활석^0에 소원을 빌고 ^1" .. selectRewards[4] .. "^0을 획득하였습니다.")
				end
				local itemData = {}
				itemData.type = selectRewards[1]
				itemData.content = {selectRewards[7]}
				vRP.giveInventoryItem({user_id, selectRewards[3], 1, itemData, true})
			end
		end
	end
end

local arrEventItenName = {"eventitem_event2_ticket1", "eventitem_event2_ticket2", "eventitem_event2_ticket3", "eventitem_event2_ticket4"}
local arrEventItemSName = {"1만원권", "5만원권", "10만원권", "50만원권"}

function procEventItemGet(user_id, cbr)
	MySQL.query(
		"vRP/event2_getTickets" .. rand,
		{user_id = user_id},
		function(rows, affected)
			if #rows > 0 then
				local arr = {}
				for k, v in pairs(rows) do
					table.insert(arr, {v.type, v.value})
				end
				cbr(arr)
			else
				cbr(false)
			end
		end
	)
end

function procEventItemUpdate(type, user_id, cbr)
	MySQL.query(
		"vRP/event2_setTicket" .. rand,
		{type = type, user_id = user_id},
		function(rows, affected)
			if rows ~= nil and rows.changedRows == 1 then
				cbr(true)
			else
				cbr(false)
			end
		end
	)
end

function vrp_eventbox2S.reqEventBox()
	local _source = source
	local user_id = vRP.getUserId({_source})
	if user_id == nil then
		return false
	end
	for k, v in pairs(arrEventItenName) do
		local count = vRP.getInventoryItemAmount({user_id, v})
		if count > 0 and vRP.tryGetInventoryItem({user_id, v, 1}) then
			procEventItemUpdate(
				k,
				user_id,
				function(state)
					if state then
						TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^3[부활데이이벤트] ^2" .. GetPlayerName(_source) .. "^0님이^3 문화상품권 " .. arrEventItemSName[k] .. "^0을 교환했습니다.")
						notify(_source, "교환 완료. Z키를 눌러 결과를 확인하세요.", "success")
					else
						vRP.giveInventoryItem({user_id, v, 1})
						notify(_source, "현재 교환 준비중. 곧 업데이트 될 예정입니다.", "error")
					end
				end
			)
			return
		end
	end
	notify(_source, "교환할 문상교환권이 없습니다.", "error")
end

function checkGenStone(user_id)
	local isCheck = true
	for k, v in pairs(cfg.arrStoneArea) do
		if vRP.getInventoryItemAmount({user_id, v}) <= 0 then
			isCheck = false
		end
	end
	if isCheck then
		return true
	end
	return false
end

function vrp_eventbox2S.checkGenStone()
	local player = source
	local user_id = vRP.getUserId({player})
	if user_id == nil then
		return false
	end
	if checkGenStone(user_id) then
		return true
	else
		notify(player, "부활석을 제작할 수 없습니다.<br>재료가 부족합니다.", "error")
	end
	return false
end

function vrp_eventbox2S.genStone()
	local _source = source
	local user_id = vRP.getUserId({_source})
	if user_id == nil then
		return false
	end
	if checkGenStone(user_id) then
		for k, v in pairs(cfg.arrStoneArea) do
			vRP.tryGetInventoryItem({user_id, v, 1, false})
		end
		vRP.giveInventoryItem({user_id, "eventitem_event2_vivestone", 1})
		notify(_source, "부활석을 성공적으로 제조했습니다.", "success")
	else
		notify(_source, "부활석을 제작할 수 없습니다.", "error")
	end
end

function vrp_eventbox2S.viewEventResult()
	local _source = source
	local user_id = vRP.getUserId({_source})
	procEventItemGet(
		user_id,
		function(data)
			vrp_eventbox2C.getEventBox(_source, {GetPlayerName(_source), data})
		end
	)
end

Citizen.CreateThread(
	function()
		Wait(100)
		MySQL.query(
			"vRP/event2_get" .. rand,
			{},
			function(rows, affected)
				if #rows > 0 then
					eventStateData = json.decode(rows[1].dvalue)
					if eventStateData.highRewards == nil then
						eventStateData.highRewards = {}
					end
					isState = eventStateData.state
					taskGetState()
				end
			end
		)
	end
)

local actionRate = {
	[1] = 10,
	[2] = 50,
	[3] = 10,
	[4] = 10,
	[5] = 10,
	[6] = 10,
	[7] = 10,
	[8] = 50
}

local getItemTime = {}

RegisterServerEvent("vrp_eventbox2:getItem")
AddEventHandler(
	"vrp_eventbox2:getItem",
	function(player, action, list)
		if true then
			return
		end
		if source ~= "" and source ~= nil and tonumber(source) > 0 then
			player = source
		end
		local user_id = vRP.getUserId({player})
		if action == nil or user_id == nil then
			return
		end

		if getItemTime[user_id] == nil then
			getItemTime[user_id] = os.time()
		else
			if getItemTime[user_id] > os.time() - 30 then
				return
			else
				getItemTime[user_id] = os.time()
			end
		end

		local selItemId = ""
		local selItemName = ""

		local rate = actionRate[action]
		if rate == nil then
			rate = 0
		end

		math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
		local rateRand = math.random(1, 100)
		if rateRand > rate then
			return
		end

		math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
		if list == nil then
			local rand = math.random(1, #cfg.arrStoneArea)
			selItemId = cfg.arrStoneArea[rand]
			selItemName = vRP.getItemName({selItemId})
		elseif type(list) == "table" then
			local rand = math.random(1, #list)
			selItemId = list[rand]
			selItemName = vRP.getItemName({selItemId})
		end

		if action == nil or selItemId == "" or selItemName == "" then
			return
		end

		vRP.giveInventoryItem({user_id, selItemId, 1})

		local notifyText = ""
		if action == 1 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 좀비를 사냥하다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 2 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 보물을 찾다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 3 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 낚시질을 하다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 4 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 광질을 하다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 5 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 도끼질을 하다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 6 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 리얼박스를 열다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 7 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 추첨박스를 열다가 ^1" .. selItemName .. " ^0를 발견했습니다!"
		elseif action == 8 then
			notifyText = "^2" .. GetPlayerName(player) .. "^0님이 멍때리다가 ^1" .. selItemName .. " ^0를 얻었습니다!"
		end
		TriggerClientEvent("chatMessage", player, "[부활데이이벤트] ", {255, 255, 0}, notifyText)
	end
)
