local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_ciupercar")
vRPCciupercar = Tunnel.getInterface("vRP_ciupercar", "vRP_ciupercar")

vRPciupercar = {}
Tunnel.bindInterface("vRP_ciupercar", vRPciupercar)
Proxy.addInterface("vRP_ciupercar", vRPciupercar)

local arrRestTime = {}
local isTest = false

function vRPciupercar.verificaciuperci(ciuperci)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local money = math.random(50000, 300000)
    local ea = math.random(1, 5)
	if not isTest then
		local ctime = os.time()
		if arrRestTime[user_id] ~= nil and ctime - 100 < arrRestTime[user_id] then
			vRPclient.notify(player, {"~r~[오류] ~w~시스템 제한"})
			return
		end
		arrRestTime[user_id] = ctime
	end
    if ciuperci == 6 then
        vRP.giveMoney({user_id, money})
        vRP.giveInventoryItem({user_id, "mushroom", ea})
        vRPclient.notify(player, {"~o~[미션 보상] ~r~알 수 없는 버섯 " .. ea .. "개~w~와 ~g~수고비 " .. money .. "원~w~을 받았습니다!", "success"})
    else
        vRPclient.notify(player, {"~r~[실패] ~w~버섯이 충분하지 않습니다!", "success"})
    end
end
