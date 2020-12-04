---------------------------------------------------------
------------ VRP Eventbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_eventbox1S = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_eventbox1")
vrp_eventbox1C = Tunnel.getInterface("vrp_eventbox1", "vrp_eventbox1")
Tunnel.bindInterface("vrp_eventbox1", vrp_eventbox1S)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/event1_get" .. rand, "SELECT dvalue FROM vrp_srv_data WHERE dkey = 'vRP:event1_state'")
MySQL.createCommand("vRP/event1_set" .. rand, "update vrp_srv_data set dvalue = @dvalue WHERE dkey = 'vRP:event1_state'")
MySQL.createCommand("vRP/event1_setTicket" .. rand, "update vrp_event1_tickets set user_id = @user_id, state = 1, updated_at=now() WHERE state = 0 and type = @type limit 1")
MySQL.createCommand("vRP/event1_getTickets" .. rand, "select * from vrp_event1_tickets where user_id = @user_id and state = 1 order by type asc")

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
	vrp_eventbox1C.getState(-1, {eventStateData.state, eventStateData.total, eventStateData.highRewards.user_id, eventStateData.highRewards.name, eventStateData.highRewards.amount})

	local dvalue = json.encode(eventStateData)
	if dvalue then
		MySQL.execute("vRP/event1_set" .. rand, {dvalue = dvalue})
	end

	SetTimeout(
		10000,
		function()
			--taskGetState()
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

function vrp_eventbox1S.openBox()
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

	if vRP.tryGetInventoryItem({user_id, "eventbox1", cfg.giftbox.open_amount, true}) then
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
			notify(player, "이벤트박스를 개봉하였지만 아쉽게도 꽝이 당첨되었습니다!", "error")
		else
			if selectRewards[1] == "money" then
				notify(player, "이벤트박스에서 " .. selectRewards[4] .. "이 나왔습니다!", "success")
				if selectRewards[6] then
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[당첨소식] ^2" .. GetPlayerName(player) .. "^0님이^2 이벤트박스^0에서 ^1" .. selectRewards[4] .. "^0을 획득하였습니다.")
				end
				vRP.giveMoney({user_id, selectRewards[3]})
			elseif selectRewards[1] == "item" then
				notify(player, "이벤트박스에서 " .. selectRewards[4] .. "이 나왔습니다!", "success")
				if selectRewards[6] then
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[당첨소식] ^2" .. GetPlayerName(player) .. "^0님이^2 이벤트박스^0에서 ^1" .. selectRewards[4] .. "^0을 획득하였습니다.")
				end
				vRP.giveInventoryItem({user_id, selectRewards[3], 1})
				updateState(selectRewards[7], user_id, GetPlayerName(player))
			end
		end
	end
end

local arrEventItenName = {"eventitem_event1_ticket1", "eventitem_event1_ticket2", "eventitem_event1_ticket3", "eventitem_event1_ticket4", "eventitem_event1_ticket5", "eventitem_event1_ticket6"}
local arrEventItemSName = {"1천원권","5천원권","1만원권","5만원권","10만원권","50만원권"}

function procEventItemGet(user_id, cbr)
	MySQL.query(
		"vRP/event1_getTickets" .. rand,
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
		"vRP/event1_setTicket" .. rand,
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

function vrp_eventbox1S.reqEventBox()
	local _source = source
	local user_id = vRP.getUserId({_source})
	if user_id == nil then
		return false
	end
	if false then 
		notify(_source, "현재 교환 준비중. 곧 업데이트 될 예정입니다.", "error")
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
						TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[문상이벤트] ^2" .. GetPlayerName(_source) .. "^0님이^3 문화상품권 "..arrEventItemSName[k].."^0을 교환했습니다.")
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

function vrp_eventbox1S.viewEventResult()
	local _source = source
	local user_id = vRP.getUserId({_source})
	procEventItemGet(
		user_id,
		function(data)
			vrp_eventbox1C.getEventBox(_source, {GetPlayerName(_source), data})
		end
	)
end

Citizen.CreateThread(
	function()
		Wait(100)
		MySQL.query(
			"vRP/event1_get" .. rand,
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
