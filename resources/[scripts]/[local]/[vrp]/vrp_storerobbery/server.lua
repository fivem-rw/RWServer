-- Remember to use the cop group or this won't work
-- K > Admin > Add Group > User ID > cop

--- EDIT BY jackiazzking69 And BigUnit

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bank")

local banks = {
	["Lindsay Circus"] = {
		position = { ['x'] = -705.94110107422, ['y'] = -915.48120117188, ['z'] = 18.215589523315 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Lindsay Circus LTD Gas Station",
		lastrobbed = 0
	},
	["Prosperity St"] = {
		position = { ['x'] = -1487.1322021484, ['y'] = -375.54638671875, ['z'] = 39.163433074951 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Prosperity St Robs Liquor",
		lastrobbed = 0
	},
	["Barbareno Road Great Ocean"] = {
		position = { ['x'] = -3241.7280273438, ['y'] = 999.95611572266, ['z'] = 11.830716133118 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Barbareno Road(Great Ocean) 24/7 Supermarket",
		lastrobbed = 0
	},
	["North Rockford Dr"] = {
		position = { ['x'] = -1828.9028320313, ['y'] = 798.63702392578, ['z'] = 137.18780517578 },
		reward = 100 + math.random(800,1500),
		nameofbank = "North Rockford Dr LTD Gas Station",
		lastrobbed = 0
	},
	["Great Ocean Hway East"] = {
		position = { ['x'] = 1727.6282958984, ['y'] = 6414.7607421875, ['z'] = 34.037220001221 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway East 24/7 Supermarket",
		lastrobbed = 0
	},
	["Alhambra Dr Sandy"] = {
		position = { ['x'] = 1960.3529052734, ['y'] = 3739.4997558594, ['z'] = 31.343742370605 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Alhambra Dr Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Palomino Fwy Reststop"] = {
		position = { ['x'] = 2549.2858886719, ['y'] = 384.96740722656, ['z'] = 107.62294769287 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Palomino Fwy Reststop 24/7 Supermarket",
		lastrobbed = 0
	},
	["Clinton Ave"] = {
		position = { ['x'] = 372.36227416992, ['y'] = 325.90933227539, ['z'] = 102.56638336182 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Clinton Ave 24/7 Supermarket",
		lastrobbed = 0
	},
	["Grove St/Davis St"] = {
		position = { ['x'] = -47.860702514648, ['y'] = -1759.3477783203, ['z'] = 28.421016693115 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Grove St/Davis St LTD Gas Station",
		lastrobbed = 0
	},
	["Innocence Blvd"] = {
		position = { ['x'] = 24.360492706299, ['y'] = -1347.8098144531, ['z'] = 28.497026443481 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Innocence Blvd 24/7 Supermarket",
		lastrobbed = 0
	},
	["San Andreas Ave"] = {
		position = { ['x'] = -1220.7747802734, ['y'] = -915.93646240234, ['z'] = 10.326335906982 },
		reward = 100 + math.random(800,1500),
		nameofbank = "San Andreas Ave Robs Liquor",
		lastrobbed = 0
	},
	["Route 68 Outside Sandy"] = {
		position = { ['x'] = 1169.2320556641, ['y'] = 2717.8083496094, ['z'] = 36.157665252686 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Route 68 Outside Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Great Ocean Hway"] = {
		position = { ['x'] = -2959.6359863281, ['y'] = 387.15356445313, ['z'] = 13.043292999268 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway Robs Liquor",
		lastrobbed = 0
	},
	["Inseno Rd Great Ocean"] = {
		position = { ['x'] = -3038.9475097656, ['y'] = 584.53924560547, ['z'] = 6.9089307785034 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Inseno Rd Great Ocean 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Grapeseed Main St"] = {
		position = { ['x'] = 1707.8717041016, ['y'] = 4920.2475585938, ['z'] = 41.063678741455 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Grapeseed Main St 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Algonquin Blvd"] = {
		position = { ['x'] = 1392.9791259766, ['y'] = 3606.5573730469, ['z'] = 33.980918884277 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Algonquin Blvd Ace Liquors",
		lastrobbed = 0
	},	
	["Panorama Dr"] = {
		position = { ['x'] = 1982.5057373047, ['y'] = 3053.4697265625, ['z'] = 46.215065002441 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Panorama Dr Yellow Jack Inn",
		lastrobbed = 0
	},	
	["Senora Fwy Sandy"] = {
		position = { ['x'] = 2678.1394042969, ['y'] = 3279.3344726563, ['z'] = 54.241130828857 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Senora Fwy Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Mirror Park Blvd"] = {
		position = { ['x'] = 1159.5697021484, ['y'] = -314.11761474609, ['z'] = 68.205139160156 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Mirror Park Blvd LTD Gas Station",
		lastrobbed = 0
	},	
	["El Rancho Blvd"] = {
		position = { ['x'] = 1134.2387695313, ['y'] = -982.76049804688, ['z'] = 45.415843963623 },
		reward = 100 + math.random(800,1500),
		nameofbank = "El Rancho Blvd Robs Liquor",
		lastrobbed = 0
	}	
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_bank:toofar')
AddEventHandler('es_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "강도사건이 취소되었습니다!!: ^2" .. banks[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:playerdied')
AddEventHandler('es_bank:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "강도 사건은 이곳에서 취소되었습니다. ^2" .. banks[robb].nameofbank)
	end
end)

RegisterServerEvent('es_bank:rob')
AddEventHandler('es_bank:rob', function(robb)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByGroup({"cop"}) -- remember to use the cop group or this won't work - K > Admin > Add Group > User ID > cop
    vRPclient.notify(player,{"~r~경찰은 상점을 털수없습니다!!"})
  else
    if #cops >= 1 then -- change 2 to the minimum amount online necessary
	  if banks[robb] then
		  local bank = banks[robb]

		  if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'ROBBERY', {255, 0, 0}, "이 상점은 이미 털렸습니다. 다음에 다시 시도해주세요: ^2" .. (1200 - (os.time() - bank.lastrobbed)) .. "^0 seconds.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "현재 강도짓을 하고있습니다. ^2" .. bank.nameofbank)
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "당신은 강도짓을 시작했습니다.: ^2" .. bank.nameofbank .. "^0, 상점에서 너무멀리 벗어나지마세요!")
		  TriggerClientEvent('chatMessage', player, 'SYSTEM', {255, 0, 0}, "고개를숙이고 조금더 머무르세요 ^1 3 ^0시간이되면 경찰 사이렌소리가 들릴겁니다 그떈잽싸게튀세요! 돈은당신껍니다!")
		  TriggerClientEvent('es_bank:currentlyrobbing', player, robb)
		  banks[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(180000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem({user_id,"dirty_money",bank.reward,true})
					  TriggerClientEvent('chatMessage', -1, 'NEWS', {255, 0, 0}, "Robbery is over at: ^2" .. bank.nameofbank .. "^0!")
					  TriggerClientEvent('es_bank:robberycomplete', savedSource, bank.reward)
				  end
			  end
		  end)		
	  end
    else
      vRPclient.notify(player,{"~r~출근중인 경찰이 부족합니다."})
    end
	end
end)