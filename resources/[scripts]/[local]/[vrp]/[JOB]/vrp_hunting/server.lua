local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_hunting")

local player_jobs = "huntingjobs"

--MeatPrice = cfg.MeatPrice
--LeatherPrice = cfg.LeatherPrice

RegisterServerEvent("vrp-koyou-hunting:reward")
AddEventHandler(
	"vrp-koyou-hunting:reward",
	function(Weight)
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local AnimalWeight = math.random(1, 3)
		vRP.giveInventoryItem({user_id, "leather", math.random(0, 1)})
		if AnimalWeight == 1 then
			vRP.giveInventoryItem({user_id, "meat", 1})
		elseif AnimalWeight == 2 then
			vRP.giveInventoryItem({user_id, "meat", 2})
		elseif AnimalWeight == 3 then
			vRP.giveInventoryItem({user_id, "meat", 3})
		end
		TriggerClientEvent("pNotify:SendNotification", player, {text = "멧돼지 무게가 대략 " .. AnimalWeight * 50 .. " Kg 입니다!", type = "success", queue = "global", timeout = 5000, layout = "centerRight"})
		--vRP.giveInventoryItem({user_id,"leather", math.random(1, 4)})
	end
)

RegisterServerEvent("koyou:vrphuntingpermission")
AddEventHandler(
	"koyou:vrphuntingpermission",
	function()
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id, player_jobs}) then
			TriggerClientEvent("koyou:vrphuntingpermission", source)
		else
			TriggerClientEvent("chatMessage", source, "[사냥]", {255, 0, 0}, "^0 사냥꾼이 되어야 합니다!", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "Hit", "RESPAWN_SOUNDSET")
		end
	end
)

RegisterServerEvent("vrp-koyou-hunting:sell")
AddEventHandler(
	"vrp-koyou-hunting:sell",
	function()
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})

		local MeatPrice = 200000
		local LeatherPrice = 100000

		if vRP.tryGetInventoryItem({user_id, "meat", 1, true}) then
			vRP.giveMoney({user_id, MeatPrice})
			TriggerClientEvent("pNotify:SendNotification", player, {text = "고기 1 개를 팔아 " .. MeatPrice .. "원을 받았습니다.", type = "success", queue = "global", timeout = 8000, layout = "centerRight"})
		else
			TriggerClientEvent("pNotify:SendNotification", player, {text = "고기가 없습니다!", type = "error", queue = "global", timeout = 8000, layout = "centerRight"})
		end
		if vRP.tryGetInventoryItem({user_id, "leather", 1, true}) then
			vRP.giveMoney({user_id, MeatPrice})
			TriggerClientEvent("pNotify:SendNotification", player, {text = "가죽 1 개를 팔아 " .. LeatherPrice .. "원을 받았습니다.", type = "success", queue = "global", timeout = 8000, layout = "centerRight"})
		else
			TriggerClientEvent("pNotify:SendNotification", player, {text = "가죽이 없습니다!", type = "error", queue = "global", timeout = 8000, layout = "centerRight"})
		end
	end
)

function sendNotification(source, message, messageType, messageTimeout)
	TriggerClientEvent(
		"pNotify:SendNotification",
		player,
		{
			text = message,
			type = messageType,
			queue = "mosho",
			timeout = messageTimeout,
			layout = "bottomCenter"
		}
	)
end
