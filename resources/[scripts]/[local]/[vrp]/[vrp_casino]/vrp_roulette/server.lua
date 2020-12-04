local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_rouletteS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_roulette")
vrp_rouletteC = Tunnel.getInterface("vrp_roulette", "vrp_roulette")
Tunnel.bindInterface("vrp_roulette", vrp_rouletteS)

local chipName = "real_chip_n"
local blackjackTables = {}

function vrp_rouletteS.requestSit(chairId)
	local source = source
	local valid = false

	if source ~= nil then
		for k, v in pairs(blackjackTables) do
			if v == source then
				blackjackTables[k] = false
				return
			end
		end
		blackjackTables[chairId] = source
		vrp_rouletteC.sendTableData(-1, {blackjackTables})
		valid = true
	end
	return valid
end

function vrp_rouletteS.leaveTable()
	local source = source
	if source ~= nil then
		for k, v in pairs(blackjackTables) do
			if v == source then
				blackjackTables[k] = false
			end
		end
		vrp_rouletteC.sendTableData(-1, {blackjackTables})
	end
end

function vrp_rouletteS.checkBetRange(amount)
	local amount = tonumber(amount)
	if amount > 0 and amount <= 1000 then
		return true
	end
	return false
end

function vrp_rouletteS.removemoney(amount)
	local amount = amount
	local _source = source
	local user_id = vRP.getUserId({_source})
	return vRP.tryGetInventoryItem({user_id, chipName, amount, true, false, true})
end

function vrp_rouletteS.givemoney(action, amount)
	local amount = amount
	local aciton = aciton
	local amount = amount
	local _source = source
	local user_id = vRP.getUserId({_source})
	if action == "black" or action == "red" then
		local win = amount * 2
		vRP.giveInventoryItem({user_id, chipName, win, true, false, true})
	elseif action == "green" then
		local win = amount * 32
		vRP.giveInventoryItem({user_id, chipName, win, true, false, true})
	else
	end
end

function vrp_rouletteS.check_money(cb)
	local _source = source
	local user_id = vRP.getUserId({_source})
	return vRP.getInventoryItemAmount({user_id, chipName})
end
