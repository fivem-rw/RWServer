local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","lixeiro")



local reward = {35000,60000}
local rndResult = math.random(1,1)
local grupoLixeiro = "환경미화원"

RegisterServerEvent('lixeiro:rewardTrash')
AddEventHandler('lixeiro:rewardTrash', function(farm)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local x,y = table.unpack(reward)
	local rewardValue = math.random(x, y)
	vRP.giveMoney({user_id,rewardValue})
	TriggerClientEvent('chatMessage', source, '', {30, 250, 120}, "쓰레기봉투"..rndResult.."개를 수거하였습니다. 쓰레기 수거 보상 : "..rewardValue.."원", {100,255,255,1.0,'',0, 100, 0, 0.5})
	TriggerEvent("DMN:farmLog", ""..GetPlayerName(player).." [고유번호 "..user_id.."] 잡힌 "..rndResult.." 쓰레기 봉투와 원 R$ "..rewardValue..".")
end)

RegisterServerEvent('lixeiro:checkjob')
AddEventHandler('lixeiro:checkjob', function()
	local player = source
	local user_id = vRP.getUserId({player})

	if vRP.hasGroup({user_id, grupoLixeiro}) then
		TriggerClientEvent('spawnTrashCAr', source)
	else
		TriggerClientEvent('notrashman', source)
	end
end)
