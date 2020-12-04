---------------------------------------------------------
------------ VRP Eventbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_eventbonusS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_eventbonus")
vrp_eventbonusC = Tunnel.getInterface("vrp_eventbonus", "vrp_eventbonus")
Tunnel.bindInterface("vrp_eventbonus", vrp_eventbonusS)

local playerPayTime = {}
local playerVIPPayTime = {}

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, first_spawn)
		if user_id ~= nil and first_spawn then
			playerPayTime[user_id] = {source, os.time()}

			if vRP.hasPermission({user_id, "crownmember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 50}
			elseif vRP.hasPermission({user_id, "trinitymember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 35}
			elseif vRP.hasPermission({user_id, "firstfmember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 20}
			elseif vRP.hasPermission({user_id, "firstmember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 15}
			elseif vRP.hasPermission({user_id, "noblemember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 10}
			elseif vRP.hasPermission({user_id, "royalmember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 6}
			elseif vRP.hasPermission({user_id, "acemember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 3}
			elseif vRP.hasPermission({user_id, "redmember"}) then
				playerVIPPayTime[user_id] = {source, os.time(), 1}
			end
		end
	end
)

AddEventHandler(
	"vRP:playerLeave",
	function(user_id, source)
		if playerPayTime[user_id] ~= nil then
			playerPayTime[user_id] = nil
		end
		if playerVIPPayTime[user_id] ~= nil then
			playerVIPPayTime[user_id] = nil
		end
	end
)

Citizen.CreateThread(
	function()
		while false do
			local setTime = os.time() - cfg.global.paytime
			for user_id, v in pairs(playerPayTime) do
				if user_id ~= nil and v ~= nil and v[2] < setTime then
					local source = v[1]
					playerPayTime[user_id] = {source, os.time()}
					--TriggerEvent("vrp_eventbox2:getItem", source, 8)
					--print("PayStone", user_id)
					Citizen.Wait(0)
				end
			end
			Citizen.Wait(60000)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		while true do
			local setTime = os.time() - cfg.global.vipPayTime
			for user_id, v in pairs(playerVIPPayTime) do
				local source = v[1]
				local stime = v[2]
				local amount = v[3]
				if user_id ~= nil and v ~= nil and stime < setTime then
					playerVIPPayTime[user_id][2] = os.time()
					vRP.giveInventoryItem({user_id, "lottery_ticket_gold", amount, true})
					vRPclient.notifyPicture(source, {cfg.paycheck.picture, 1, cfg.paycheck.title, false, cfg.paycheck.msg})
				else
					local remainTime = stime - setTime
					local rTime = parseInt(remainTime / 60)
					if rTime > 0 then
						vRPclient.notify(source, {"~y~골드추첨티켓 ~w~지급까지 ~r~" .. rTime .. "~w~분 남음"})
					else
						vRPclient.notify(source, {"~y~골드추첨티켓~w~이 곧 지급됩니다."})
					end
				end
			end
			Citizen.Wait(60000)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		vRP.getUserList(
			{
				function(userList)
					for k, v in pairs(userList) do
						playerPayTime[v.user_id] = {v.source, os.time()}
						if vRP.hasPermission({v.user_id, "crownmember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 50}
						elseif vRP.hasPermission({v.user_id, "trinitymember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 35}
						elseif vRP.hasPermission({v.user_id, "firstfmember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 20}
						elseif vRP.hasPermission({v.user_id, "firstmember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 15}
						elseif vRP.hasPermission({user_id, "noblemember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 10}
						elseif vRP.hasPermission({user_id, "royalmember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 6}
						elseif vRP.hasPermission({user_id, "acemember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 3}
						elseif vRP.hasPermission({user_id, "redmember"}) then
							playerVIPPayTime[v.user_id] = {v.source, os.time(), 1}
						end
					end
				end
			}
		)
	end
)
