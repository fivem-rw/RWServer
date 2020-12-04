local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_vangelico_robbery")

local stores = cfg.jewels

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('vrp_vangelico_robbery:toofar')
AddEventHandler('vrp_vangelico_robbery:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '🚨 속보', { 105, 105, 105 }, "보석상 강도들은 이미 도망가고 없습니다! ^2" .. stores[robb].nameofstore..".")
	end
end)


RegisterServerEvent('vrp_vangelico_robbery:rob')
AddEventHandler('vrp_vangelico_robbery:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByPermission({"cop"})
  local xpAtual = vRP.getExp({user_id, "user", "보석상"})
  local xpEarned = stores[robb].pontosXp
  local pontoPorAcao = xpEarned
  local novoXp = xpAtual + pontoPorAcao
  if vRP.hasPermission({user_id,cfg.permission}) then
    vRPclient.notify(player,{"~r~ 경찰은 범죄를 저지를 수 없습니다."})
  else
    if #cops >= 4 then 
	  if stores[robb] then
		  local store = stores[robb]

		  if (os.time() - store.lastrobbed) <  cfg.seconds+cfg.cooldown and store.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, '보석상', { 255, 69, 0 }, "방금 강도가 휩쓸고 가서 보석이 없습니다. 잠시후에 다시 와주세요. ^2" .. (cfg.seconds+cfg.cooldown - (os.time() - store.lastrobbed)) .. "^0 초.")
			  return
		  end
		  TriggerClientEvent("chatMessage", -1, "🚨 ^1속보 ", {255, 255, 255}, "^2" .. GetPlayerName(player) .. " ^*( " .. user_id .. " )^0님이 ^2보석상 RP^0를 시작 하였습니다!")
		  TriggerClientEvent('chatMessage', player, '🚨 ^1속보 ', { 0, 0x99, 255 }, "경찰은 보석상으로 빠른 이동을 요청합니다!")
		  TriggerClientEvent('vrp_vangelico_robbery:currentlyrobbing', player, robb)
		  stores[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(cfg.seconds*1000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  local xpBonus = vRP.getExp({user_id, "user", "보석상"})
					  local rewardBonus = store.reward + tonumber(xpBonus)*20
					  --vRP.giveInventoryItem({user_id,"dirty_money",rewardBonus,true})
					  vRP.varyExp({user_id,"user","보석상",pontoPorAcao})
					  if xpAtual < 1000 then
						  vRP.setExp({user_id, "user", "보석상", novoXp})
					  end
					  vRP.giveMoney({user_id, rewardBonus})
					  TriggerClientEvent('chatMessage', -1, '🚨 속보 ', { 128, 0, 0 }, "보석상 강도상황이 종료되었습니다.^0!")
					  TriggerClientEvent('vrp_vangelico_robbery:robberycomplete', savedSource, rewardBonus)
					  TriggerEvent("DMN:regLogCriminal", ""..GetPlayerName(player).." ["..user_id.."]님이 보석상에서 도주 하였습니다.")
				  end
			  end
		  end)		
	  end
    else
      vRPclient.notify(player,{"~r~[알림]~w~ 경찰이 4명 이상 없어서 진행이 불가합니다.[현재 인원 : " ..#cops.."명]"})
    end
  end
end)

RegisterServerEvent('vrp_vangelico_robbery:playerdied')
AddEventHandler('vrp_vangelico_robbery:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_vangelico_robbery:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, '🚨 속보', { 105, 105, 105 }, "강도들은 이미 도망가고 없습니다!. ^2" .. stores[robb].nameofstore..".",{255, 255, 255, 1.0,'',100,100,100, 0.5})
	end
end)

RegisterServerEvent('vrp_vangelico_robbery:gioielli1')
AddEventHandler('vrp_vangelico_robbery:gioielli1', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local randomJewel = math.random(1,10)
	
	if randomJewel == 1 or randomJewel == 2 or randomJewel == 3 or randomJewel == 4 then
		vRP.giveInventoryItem({user_id,"e_bs",math.random(1, 10),true})
	elseif randomJewel == 5 or randomJewel == 6 or randomJewel == 7 then
		vRP.giveInventoryItem({user_id,"s_bs",math.random(1, 8),true})
	elseif randomJewel == 8 or randomJewel == 9 then
		vRP.giveInventoryItem({user_id,"r_bs",math.random(1, 6),true})
	else
		vRP.giveInventoryItem({user_id,"d_bs",math.random(1, 4),true})
	end
end)


RegisterServerEvent('lester:nvendita')
AddEventHandler('lester:nvendita', function()
	local _source = source
	PlayersCrafting[_source] = false
end)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3보석상 RP가 시작되었습니다!!")
	end
)