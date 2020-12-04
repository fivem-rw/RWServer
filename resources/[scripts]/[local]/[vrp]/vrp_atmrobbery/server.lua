local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_atm")

local atms = cfg.atms

local robbers = {}

local porC4 = {
	{"mp_car_bomb","car_bomb_mechanic",1}
}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_atm:toofar')
AddEventHandler('es_atm:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_atm:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '🚨 속보', { 105, 105, 105 }, "ATM 털이범이 도주 하였습니다. ^2" .. atms[robb].nameofatm ..".")
	end
end)

RegisterServerEvent('es_atm:playerdied')
AddEventHandler('es_atm:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_atm:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '🚨 속보', { 105, 105, 105 }, "ATM 털이범들이 도주 하였습니다. ^2" .. atms[robb].nameofatm ..".")
	end
end)

RegisterServerEvent('es_atm:rob')
AddEventHandler('es_atm:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByPermission({"cop"}) 
  local xpAtual = vRP.getExp({user_id, "user", "atm"})
  local xpEarned = atms[robb].pontosXp
  local pontoPorAcao = xpEarned
  local novoXp = xpAtual + pontoPorAcao
  if (vRP.hasGroup({user_id,"cop"}) or vRP.hasGroup({user_id,"EMS"}) or vRP.hasGroup({user_id,"FIB"}) ) then
    vRPclient.notify(player,{"~r~공무원 직업은 범죄를 저지를 수 없습니다."})
  else
	if not (vRP.getInventoryItemAmount({user_id,"explosivo_c4"}) >=1) then
		vRPclient.notify(player,{"~r~C4 폭발물이 필요합니다."})
	else
		if #cops >= 2 then 
		  if atms[robb] then
			--vRPclient.playAnim(source,{false,porC4,false})
			  local atm = atms[robb]
			  local sourcePlayer = tonumber(source)

			  if (os.time() - atm.lastrobbed) < atms[robb].seconds+cfg.cooldown and atm.lastrobbed ~= 0 then
				  TriggerClientEvent('chatMessage', sourcePlayer, '', {255, 0, 0}, "방금 ATM 기기에서 강도가 발생해 돈이 없습니다. ^2" .. (atms[robb].seconds+cfg.cooldown - (os.time() - atm.lastrobbed)) .. "^0초 남음.", {255, 69, 0, 0.5}, "", "")
				  return
			  end
		      TriggerClientEvent("chatMessage", -1, "🚨 ^1속보 ", {255, 255, 255}, "^2" .. GetPlayerName(player) .. " ^*( " .. user_id .. " )님이 ^2ATM털이 RP^0를 시작 하였습니다!")
			  TriggerClientEvent('chatMessage', -1, '🚨 ^1속보 ', { 128, 0, 0 }, "".. atm.nameofatm.."에서 ATM 기기에서 강도가 발생하였습니다.")
			  vRP.tryGetInventoryItem({user_id,"explosivo_c4",1})
			  TriggerClientEvent('chatMessage', sourcePlayer, '', {255, 0, 0}, "[".. atm.nameofatm.."]에서 ATM 털이 RP를 시작하였습니다.^2^0", "폭발물이 터질때까지 빨간원을 벗어나지 마십시오!", {18,177,255, 0.5}, "", "")
			  TriggerClientEvent('chatMessage', sourcePlayer, '', {255, 0, 0}, "[폭파 알림]"..atms[robb].seconds.."초 후 폭발장치가 발동되어 ATM이 폭파 됩니다. 폭파 후 당신이 승리합니다.", {18,177,255, 0.5}, "", "")
			  TriggerClientEvent('es_atm:currentlyrobbing', player, robb)
			  atms[robb].lastrobbed = os.time()
			  robbers[player] = robb
			  local savedSource = player
			  SetTimeout(atms[robb].seconds*1000, function()
				  if(robbers[savedSource])then
					  if(user_id)then
						  local xpBonus = vRP.getExp({user_id, "user", "atm"})
						  local rewardBonus = atm.reward + tonumber(xpBonus)*10
						  vRP.varyExp({user_id,"user","atm",pontoPorAcao})
						  if xpAtual < 1000 then
							  vRP.setExp({user_id, "user", "atm", novoXp})
							else
							  vRP.setExp({user_id, "user", "atm", 1000})	
						  end
						  vRP.giveMoney({user_id, rewardBonus})
						  TriggerClientEvent('chatMessage', -1, '뉴스', { 128, 0, 0 }, "ATM털이가 끝났습니다. ^2" .. atm.nameofatm .. "^0!")	
						  TriggerClientEvent('es_atm:robberycomplete', savedSource, atm.reward)
						  TriggerEvent("DMN:regLogCriminal", ""..GetPlayerName(player).."("..user_id..")님이 ATM 털이에 성공하여 "..atm.nameofatm.."에서 "..rewardBonus.."원을 훔쳐 갔습니다.[근무 중인 경찰 : "..#cops.."명]")
					  end
				  end
			  end)
		  end
		else
		  vRPclient.notify(player,{"~r~[알림]~w~ 경찰이 2명 이상 없어서 진행이 불가합니다.[현재 인원 : " ..#cops.."명]"})
		end
	end
	
  end
end)

local bag = {}
RegisterServerEvent('DropBagSystem:create')
AddEventHandler('DropBagSystem:create', function(bags, item, count)
	bag[bags] = {item = item, count = count}
	TriggerClientEvent('DropBagSystem:createForAll', -1, bags)
end)

RegisterServerEvent('DropBagSystem:take')
AddEventHandler('DropBagSystem:take', function(bags)
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
		vRP.giveInventoryItem({user_id,bag[bags].item,bag[bags].count,true})
		vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
end)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3ATM RP가 시작되었습니다!!")
	end
)