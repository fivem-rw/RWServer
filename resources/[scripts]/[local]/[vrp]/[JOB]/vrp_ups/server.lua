local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_ups")

local arrRestTime = {}
local isTest = false

RegisterServerEvent("pop_ups:propina")
AddEventHandler(
	"pop_ups:propina",
	function(propina)
		local player = source
		local user_id = vRP.getUserId({player})

		if not isTest then
			local ctime = os.time()
			if arrRestTime[user_id] ~= nil and ctime - 100 < arrRestTime[user_id] then
				vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
				return
			end
			arrRestTime[user_id] = ctime
		end

		vRP.giveMoney({user_id, propina})
	end
)

RegisterServerEvent("ups:checkjob")
AddEventHandler(
	"ups:checkjob",
	function()
		local player = source
		local user_id = vRP.getUserId({player})

		if vRP.hasGroup({user_id, "택배기사"}) then
			TriggerClientEvent("okups", source)
		else
			vRPclient.notify(player, {"~r~택배기사만 이용 가능합니다!"})
		end
	end
)
