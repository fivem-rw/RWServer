---------------------------------------------------------
------------ VRP VideoCasino, RealWorld MAC -------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_vcS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_vc")
vrp_vcC = Tunnel.getInterface("vrp_vc", "vrp_vc")
Tunnel.bindInterface("vrp_vc", vrp_vcS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/vc_get_last_winning_odds" .. rand, "SELECT * FROM vrp_vc_odds WHERE is_enable = 0 and is_winner = 1 and run_id = (select run_id from vrp_vc_odds where is_enable = 0 and is_winner = 1 order by run_id desc limit 1)")
MySQL.createCommand("vRP/vc_get_odds" .. rand, "SELECT * FROM vrp_vc_odds WHERE is_enable = 1")
MySQL.createCommand("vRP/vc_bets" .. rand, "insert into vrp_vc_bets set user_id=@user_id,player_name=@player_name,player_src=@player_src,run_id=@run_id,odd_id=@odd_id,odd_value=@odd_value,bet_amount=@bet_amount,created_at=now()")
MySQL.createCommand("vRP/vc_get_result_bets" .. rand, "SELECT * FROM vrp_vc_bets WHERE is_result = 1 and is_execute = 0 order by id asc; update vrp_vc_bets set is_execute = 1 WHERE is_result = 1 and is_execute = 0")
MySQL.createCommand("vRP/vc_get_pending_bets" .. rand, "SELECT * FROM vrp_vc_bets WHERE user_id=@user_id and is_result = 0 and is_execute = 0 and is_cancel = 0 and is_error_recv = 0 and is_process = 0 and created_at < DATE_SUB(NOW(),INTERVAL 600 SECOND) order by id asc; update vrp_vc_bets set is_execute = 0, is_cancel = 1 WHERE user_id=@user_id and is_result = 0 and is_execute = 0 and is_cancel = 0 and is_process = 0 and created_at < DATE_SUB(NOW(),INTERVAL 600 SECOND)")
MySQL.createCommand("vRP/vc_get_error_bets" .. rand, "select a.id,a.run_id,a.user_id,a.bet_amount,a.odd_value,a.odd_id,a.created_at from vrp_vc_bets as a left join vrp_vc_odds as b on a.run_id = b.run_id and a.odd_id = b.odd_id and a.odd_value = b.odd_value where b.is_winner = 1 and a.is_winner = 0 and a.is_result = 1 and a.is_cancel = 0 and a.is_error_recv = 0 and a.user_id=@user_id order by a.id asc limit 1")
MySQL.createCommand("vRP/vc_get_error_bets2" .. rand, "select id,run_id,user_id,bet_amount,odd_value,odd_id,created_at from vrp_vc_bets where is_result = 1 and is_winner = 1 and is_execute = 1 and is_get_money = 0 and is_cancel = 0 and is_error_recv = 0 and user_id=@user_id order by id asc limit 1")
MySQL.createCommand("vRP/vc_update_error_bets" .. rand, "update vrp_vc_bets set is_error_recv=1 where id in (@ids)")
MySQL.createCommand("vRP/vc_update_get_money" .. rand, "update vrp_vc_bets set is_get_money=1 where id in (@ids)")

MySQL.createCommand("vRP/vc_revive_new" .. rand, "insert into vrp_vc_revive set user_id=@user_id,amount=@amount,created_at=now()")
MySQL.createCommand("vRP/vc_revive_get" .. rand, "SELECT sum((bet_amount*odd_value)-bet_amount) as amount FROM vrp_vc_bets WHERE user_id=@user_id and is_result = 1 and is_execute = 1 and is_winner = 1 and is_cancel = 0;SELECT sum(bet_amount) as amount FROM vrp_vc_bets WHERE user_id=@user_id and is_result = 1 and is_execute = 1 and is_winner = 0 and is_cancel = 0;select sum(amount) as amount from vrp_vc_revive where user_id=@user_id")

local moneyNetIds = {}
local payBetIds = {}
local betLimit = {
	min = 1,
	max = 1000000000
}
local reviveRate = 5

local lastIds = {}
local lastWinningOdds = {}
local isAvalBet = false

function notify(player, msg, type, timer)
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

function getLastWinningOdds()
	local isSetEnableTimer = false
	local isNextGame = false
	MySQL.query(
		"vRP/vc_get_last_winning_odds" .. rand,
		{},
		function(rows, affected)
			lastWinningOdds = {}
			if rows and #rows > 0 then
				for k, v in pairs(rows) do
					table.insert(lastWinningOdds, v.odd_id)
				end
			end
			vrp_vcC.showWinningMarker(-1, {lastWinningOdds})
		end
	)
end

function refreshOddsInfo()
	local isSetEnableTimer = false
	local isNextGame = false
	MySQL.query(
		"vRP/vc_get_odds" .. rand,
		{},
		function(rows, affected)
			if rows and #rows > 0 then
				local isInit = false
				local isInitRound = false
				for k, v in pairs(rows) do
					if v.run_id and gameInfo.run_id ~= v.run_id then
						print("[RealCasino] New Game")
						isAvalBet = true
						gameInfo.run_id = v.run_id
						isNextGame = true
						if not isInitRound then
							isInitRound = true
							gameInfo.round = 1
						end
					end
					if v.odd_id then
						if lastIds[v.odd_id] ~= v.id then
							lastIds[v.odd_id] = v.id
							if not isInit then
								isInit = true
								for k, v in pairs(gameInfo.odds) do
									v[2] = false
									v[3] = false
								end
							end
							if v.is_enable then
								isSetEnableTimer = true
							end
							v.is_active = false
							if not isInitRound then
								isInitRound = true
								if gameInfo.round == 1 then
									gameInfo.round = 2
									print("[RealCasino] Round 2 Game")
									isAvalBet = true
								end
							end
						else
							v.is_active = gameInfo.odds[v.odd_id][3]
						end
						gameInfo.odds[v.odd_id] = {v.odd_value, v.is_enable, v.is_active}
					end
				end
				if isNextGame then
					isNextGame = false
					SetTimeout(
						10000,
						function()
							payBetIds = {}
							for k, v in pairs(gameInfo.odds) do
								if v[2] then
									v[3] = true
								end
							end
							--vrp_vcC.removeDropMoney(-1, {moneyNetIds})
							moneyNetIds = {}
							processResults()
							getLastWinningOdds()
						end
					)
				else
					if isSetEnableTimer then
						isSetEnableTimer = false
						SetTimeout(
							5000,
							function()
								payBetIds = {}
								for k, v in pairs(gameInfo.odds) do
									if v[2] then
										v[3] = true
									end
								end
								--vrp_vcC.removeDropMoney(-1, {moneyNetIds})
								moneyNetIds = {}
								processResults()
							end
						)
					end
				end
			end
		end
	)
end

function processResults()
	MySQL.query(
		"vRP/vc_get_result_bets" .. rand,
		{},
		function(rows, affected)
			if rows and #rows > 0 then
				print("[RealCasino] Resulting Start")
				local ids = {}
				for k, v in pairs(rows[1]) do
					if v.user_id ~= nil then
						local source = vRP.getUserSource({v.user_id})
						if source ~= nil then
							if v.is_winner == true then
								local winning = parseInt(parseFloat(v.odd_value) * parseFloat(v.bet_amount))
								if winning > 0 then
									table.insert(ids, v.id)
									vRP.giveMoney({v.user_id, winning})
									notify(source, "당신은 승리했습니다. (승리: " .. format_num(winning) .. "원)")
								end
							else
								notify(source, "당신은 돈을 잃었습니다.", "error")
							end
						end
					end
					Wait(0)
				end
				if #ids > 0 then
					MySQL.execute(
						"vRP/vc_update_get_money" .. rand,
						{
							ids = ids
						}
					)
				end
				print("[RealCasino] Resulting Done")
			end
		end
	)
end

function checkEnableBet(type)
	local oddsInfo = gameInfo.odds[type]
	if not isAvalBet or not oddsInfo or oddsInfo[2] == false or oddsInfo[3] == false then
		return false
	end
	return true
end

function vrp_vcS.bet(type)
	local source = source
	local user_id = vRP.getUserId({source})

	if not checkEnableBet(type) or (GetConvar("restvc", "") == "true" and user_id ~= 1) then
		notify(source, "지금은 베팅할 수 없습니다.", "warning")
		return
	end
	local remainBetAmount = 0
	if gameInfo.odds[type] and gameInfo.odds[type][1] then
		remainBetAmount = parseInt(betLimit.max / tonumber(gameInfo.odds[type][1]))
	end
	if payBetIds[user_id] ~= nil then
		remainBetAmount = remainBetAmount - payBetIds[user_id]
	end
	if user_id == 1 then
		--remainBetAmount = remainBetAmount * 100
	else
		--return
	end
	vRP.prompt(
		{
			source,
			"얼마를 베팅하시겠습니까? (최대: " .. format_num(remainBetAmount) .. "원)<br><br><span class='subtext'>[입력옵션]<br>입력한 금액 뒤에 * 를 붙이면 금액에 10000을 곱합니다.<br>예시: 1000* 입력시 10,000,000(천만원) 으로 자동변경</span>",
			"",
			function(player, amount)
				if not checkEnableBet(type) then
					notify(source, "지금은 베팅할 수 없습니다.", "warning")
					return
				end
				local strFindStart, strFindEnd = string.find(amount, "*")
				if strFindStart ~= nil then
					local len = string.len(amount)
					if strFindStart == len and strFindEnd == len then
						amount = string.sub(amount, 1, len - 1)
						amount = amount .. "0000"
					else
						notify(player, "잘못된 금액.", "warning")
						return
					end
				end
				amount = parseInt(amount)
				local oddsInfo = gameInfo.odds[type]
				if amount >= betLimit.min and amount <= remainBetAmount and vRP.tryPayment({user_id, amount}) then
					MySQL.execute(
						"vRP/vc_bets" .. rand,
						{
							user_id = user_id,
							player_name = GetPlayerName(source),
							player_src = player,
							run_id = gameInfo.run_id,
							odd_id = type,
							odd_value = oddsInfo[1],
							bet_amount = amount
						}
					)
					if payBetIds[user_id] == nil then
						payBetIds[user_id] = amount
					else
						payBetIds[user_id] = payBetIds[user_id] + amount
					end
					notify(player, format_num(amount) .. "원을 베팅했습니다.<br>[베팅: " .. gameTypeName[type] .. "]<br>[배당: x" .. oddsInfo[1] .. "]", "success", 15000)
				else
					notify(player, "베팅할 수 없습니다.", "warning")
				end
			end
		}
	)
end

function vrp_vcS.getGameInfo()
	return gameInfo
end

function vrp_vcS.cancelBet()
	local player = source
	local user_id = vRP.getUserId({player})
	MySQL.query(
		"vRP/vc_get_pending_bets" .. rand,
		{user_id = user_id},
		function(rows, affected)
			local isResult = false
			if rows and #rows > 0 then
				for k, v in pairs(rows[1]) do
					isResult = true
					vRP.giveMoney({v.user_id, v.bet_amount})
					notify(player, "카지노 미정산금" .. format_num(v.bet_amount) .. "원이 복구되었습니다.", "success", 5000)
				end
			end
			if isResult then
				notify(player, "카지노 미정산금아 모두 복구되었습니다.", "success", 5000)
			else
				notify(player, "카지노 미정산금이 없습니다.", "warning", 5000)
			end
		end
	)
end

function vrp_vcS.getPayErrorBets()
	local player = source
	local user_id = vRP.getUserId({player})
	if true then
		return
	end
	MySQL.query(
		"vRP/vc_get_error_bets" .. rand,
		{user_id = user_id},
		function(rows, affected)
			local isResult = false
			if rows and #rows > 0 then
				local ids = {}
				local arrData = {}
				for k, v in pairs(rows) do
					isResult = true
					table.insert(ids, v.id)
					table.insert(arrData, v)
				end
				if #ids > 0 then
					MySQL.execute(
						"vRP/vc_update_error_bets" .. rand,
						{
							ids = ids
						}
					)
				end
				for k, v in pairs(arrData) do
					local winningAmount = parseInt(v.bet_amount * v.odd_value)
					vRP.giveMoney({v.user_id, winningAmount})
					notify(player, "카지노 결과처리 오류금액 " .. format_num(winningAmount) .. "원이 복구되었습니다.<br>베팅날짜: " .. os.date("%Y-%m-%d %H:%M:%S", v.created_at / 1000) .. "<br>베팅원금: " .. format_num(v.bet_amount) .. "원<br>배당률: x" .. v.odd_value, "success", 10000)
				end
			end
			if isResult then
				notify(player, "카지노 오류 내역이 복구되었습니다.", "success", 5000)
			else
				notify(player, "카지노 오류 내역 없습니다.", "warning", 5000)
			end
		end
	)
end

function vrp_vcS.getPayErrorBets2()
	local player = source
	local user_id = vRP.getUserId({player})
	MySQL.query(
		"vRP/vc_get_error_bets2" .. rand,
		{user_id = user_id},
		function(rows, affected)
			local isResult = false
			if rows and #rows > 0 then
				local ids = {}
				local arrData = {}
				for k, v in pairs(rows) do
					isResult = true
					table.insert(ids, v.id)
					table.insert(arrData, v)
				end
				if #ids > 0 then
					MySQL.execute(
						"vRP/vc_update_error_bets" .. rand,
						{
							ids = ids
						}
					)
				end
				for k, v in pairs(arrData) do
					local winningAmount = parseInt(v.bet_amount * v.odd_value)
					vRP.giveMoney({v.user_id, winningAmount})
					notify(player, "카지노 미수령금액 " .. format_num(winningAmount) .. "원이 복구되었습니다.<br>베팅날짜: " .. os.date("%Y-%m-%d %H:%M:%S", v.created_at / 1000) .. "<br>베팅원금: " .. format_num(v.bet_amount) .. "원<br>배당률: x" .. v.odd_value, "success", 10000)
				end
			end
			if isResult then
				notify(player, "카지노 미수령금액이 복구되었습니다.", "success", 5000)
			else
				notify(player, "카지노 미수령금액이 없습니다.", "warning", 5000)
			end
		end
	)
end

function vrp_vcS.reviveBet()
	local player = source
	local user_id = vRP.getUserId({player})
	local gm = vRP.getMoney({user_id})
	local gbm = vRP.getBankMoney({user_id})
	if gm > 0 or gbm > 0 then
		notify(player, "[개인회생/파산]<br>모든 자산을 카지노에 잃었을경우 이용가능합니다.", "warning", 5000)
		return
	end
	MySQL.query(
		"vRP/vc_revive_get" .. rand,
		{user_id = user_id},
		function(rows, affected)
			local isResult = false
			if rows and #rows > 0 then
				local winAmount = parseInt(rows[1][1].amount)
				local lossAmount = parseInt(rows[2][1].amount)
				local reviveAmount = parseInt(rows[3][1].amount)

				local realLossAmount = lossAmount - winAmount
				if realLossAmount < 0 then
					realLossAmount = 0
				end

				local newReviveAmount = parseInt(realLossAmount / 100 * reviveRate)
				newReviveAmount = newReviveAmount - reviveAmount
				if newReviveAmount < 0 then
					newReviveAmount = 0
				end

				if newReviveAmount >= 100000 then
					MySQL.execute(
						"vRP/vc_revive_new" .. rand,
						{
							user_id = user_id,
							amount = newReviveAmount
						}
					)
					vRP.giveMoney({user_id, newReviveAmount})
					notify(player, "[개인회생/파산]<br>개인회생 지원금액 " .. format_num(newReviveAmount) .. "원이 지급되었습니다.", "success", 10000)
					TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[개인회생/파산] ^2" .. GetPlayerName(player) .. "^0님이 파산했습니다. 개인회생 지원금 ^2" .. format_num(newReviveAmount) .. "^0원을 지급받았습니다.")
				else
					notify(player, "[개인회생/파산]<br>지급할 금액이 없습니다.", "warning", 5000)
				end
			end
		end
	)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isAvalBet then 
				Citizen.Wait(25000)
				isAvalBet = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3광장카지노가 시작되었습니다!!")
		while true do
			Citizen.Wait(1000)
			refreshOddsInfo()
		end
	end
)
