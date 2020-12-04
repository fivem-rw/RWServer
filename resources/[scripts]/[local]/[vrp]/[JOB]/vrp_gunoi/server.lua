local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunoi")

local arrRestTime = {}
local isTest = false

RegisterServerEvent("vrp:primeste")
AddEventHandler(
    "vrp:primeste",
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

        local noroc = math.random(0, 200)
        local suma = math.random(1, 3)

        if noroc >= 0 and noroc <= 100 then
            vRP.giveInventoryItem({user_id, "trash", suma})
            vRPclient.notify(player, {"~r~쓰레기통~w~을 뒤져 ~r~쓰레기~w~ " .. suma .. "개 가 나왔습니다!"})
        elseif noroc >= 101 and noroc <= 151 then
            vRP.giveInventoryItem({user_id, "trash", suma})
            vRPclient.notify(player, {"~r~쓰레기통~w~을 뒤져 ~r~쓰레기~w~ " .. suma .. "개가 나왔습니다!"})
        elseif noroc >= 152 and noroc <= 172 then
            vRP.giveInventoryItem({user_id, "ouro", suma})
            vRPclient.notify(player, {"~r~쓰레기통~w~을 뒤져 ~r~알 수 없는 돌~w~ " .. suma .. "개가 나왔습니다!"})
        elseif noroc >= 173 and noroc <= 200 then
            vRP.giveInventoryItem({user_id, "ksrandom", suma})
            vRPclient.notify(player, {"~r~쓰레기통~w~을 뒤져 ~r~희미한 티켓~w~ " .. suma .. "개가 나왔습니다!"})
        end
    end
)
