local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPgb = {}
Tunnel.bindInterface("vRP_giftbox", vRPgb)
Proxy.addInterface("vRP_giftbox", vRPgb)

vRPclient = Tunnel.getInterface("vRP", "vRP_giftbox")

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/add_vehicle" .. rand, "INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")

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

RegisterServerEvent("vRP:giftboxopen")
AddEventHandler(
	"vRP:giftboxopen",
	function()
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

		if vRP.tryGetInventoryItem({user_id, "gift_box", cfg.giftbox.open_amount, true}) then
			usersOpenTime[user_id] = os.time()

			math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
			local rate = 10
			local arrSelect = {}
			local selectRewards = nil
			local chance = math.random(1, 100 * rate)
			for k, v in pairs(cfg.rewards) do
				if chance >= (100 * rate) - (v[2] * rate) then
					table.insert(arrSelect, v)
				end
			end

			if #arrSelect > 0 then
				selectRewards = arrSelect[math.random(1, #arrSelect)]
			end

			if selectRewards == nil then
				notify(player, "리얼박스를 개봉하였지만 아쉽게도 꽝이 당첨되었습니다!", "error")
			else
				if selectRewards[1] == "car" then
					notify(player, "축하합니다! " .. selectRewards[4] .. "가 당첨되었습니다!", "success")
					if selectRewards[6] then
						TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^6[리얼박스] ^2" .. GetPlayerName(player) .. "^0님이^2 ^1" .. selectRewards[4] .. "^0차량을 획득하였습니다.")
					end
					MySQL.execute("vRP/add_vehicle" .. rand, {user_id = user_id, vehicle = selectRewards[3]})
				elseif selectRewards[1] == "item" then
					local num = selectRewards[5]
					if type(num) == "table" then
						num = math.random(num[1], num[2])
					end
					notify(player, "리얼박스에서 " .. selectRewards[4] .. " " .. num .. "개가 나왔습니다!", "success")
					if selectRewards[6] then
						TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^6[리얼박스] ^2" .. GetPlayerName(player) .. "^0님이^2 ^1" .. selectRewards[4] .. "^0을(를) ^1" .. num .. "^0개 획득하였습니다.")
					end
					vRP.giveInventoryItem({user_id, selectRewards[3], num})
				end
			end
			
			TriggerEvent("vrp_eventbox2:getItem", player, 6, {"eventitem_event2_vivestone6", "eventitem_event2_vivestone7"})
		end
	end
)

RegisterServerEvent("vRP:gbpaycheck")
AddEventHandler(
	"vRP:gbpaycheck",
	function()
		local cfg = getConfig()
		local user_id = vRP.getUserId({source})
		vRP.giveInventoryItem({user_id, "gift_box", 1})
		vRPclient.notifyPicture(source, {cfg.paycheck.picture, 1, cfg.paycheck.title, false, cfg.paycheck.msg})
	end
)
