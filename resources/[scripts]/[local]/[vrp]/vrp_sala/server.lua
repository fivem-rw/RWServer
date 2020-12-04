local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_sala")

local reward2 = 0.01
local reward3 = 0.01
local maxXp = 1200

AddEventHandler('chatMessage', function(source, n, message)
    command = stringsplit(message, " ")
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	if command[1] == "/뛰기" then
		TriggerClientEvent('vrp_sala:Corrida', source)
	end
end)

RegisterServerEvent('vrp_sala:enableExercise')
AddEventHandler('vrp_sala:enableExercise', function()
	TriggerClientEvent('vrp_sala:enableExercise', source)
end)

RegisterServerEvent('vrp_sala:exerciseRunning')
AddEventHandler('vrp_sala:exerciseRunning', function(rewardRunning)
	local user_id = vRP.getUserId({source})
	local xpAtual = vRP.getExp({user_id, "physical", "strength"})
	local pontoPorExerecicio = rewardRunning
	local novoXp = xpAtual + pontoPorExerecicio
	if xpAtual < maxXp then
		vRP.setExp({user_id, "physical", "strength", novoXp})
	end
end)

RegisterServerEvent('vrp_sala:exerciseGym')
AddEventHandler('vrp_sala:exerciseGym', function(rewardStrong)
	local user_id = vRP.getUserId({source})
	local xpAtual = vRP.getExp({user_id, "physical", "strength"})
	local pontoPorExerecicio = rewardStrong
	local novoXp = xpAtual + pontoPorExerecicio
	if xpAtual < maxXp then
		vRP.setExp({user_id, "physical", "strength", novoXp})
	end
end)

RegisterServerEvent('vrp_sala:exerciseGym2')
AddEventHandler('vrp_sala:exerciseGym2', function()
	local user_id = vRP.getUserId({source})
	local xpAtual = vRP.getExp({user_id, "physical", "strength"})
	local pontoPorExerecicio = reward2
	local novoXp = xpAtual + pontoPorExerecicio
	if xpAtual < maxXp then
		vRP.setExp({user_id, "physical", "strength", novoXp})
	end
end)

RegisterServerEvent('vrp_sala:exerciseGym3')
AddEventHandler('vrp_sala:exerciseGym3', function()
	local user_id = vRP.getUserId({source})
	local xpAtual = vRP.getExp({user_id, "physical", "strength"})
	local pontoPorExerecicio = reward3
	local novoXp = xpAtual + pontoPorExerecicio
	if xpAtual < maxXp then
		vRP.setExp({user_id, "physical", "strength", novoXp})
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end