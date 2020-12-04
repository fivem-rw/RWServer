-- Config
local useSMSService = true -- Send a SMS instead of the vRP Service Alert

-- Code
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_addons_gcphone")

local PhoneNumbers = {}

-- getting services from the vRP framework
local services = module("vrp", "cfg/phone")
for k,v in pairs(services.services) do
	PhoneNumbers[k] = v.alert_permission
end
---

RegisterServerEvent('vrp_addons_gcphone:startCall')
AddEventHandler('vrp_addons_gcphone:startCall', function(number, message, coords)
	startCall(source, number, message, coords)
end)

function startCall(src, number, message, coords)
	if not useSMSService or PhoneNumbers[number] == nil then
		vRP.sendServiceAlert({src, number,coords.x,coords.y,coords.z,message})
	else
		local serviceGroup = vRP.getUsersByPermission({PhoneNumbers[number]})
		getPhoneNumber(src, function(n)
			if n ~= nil then
				sendServiceSMS(number, {sender=n,message=message,coords={x=coords.x,y=coords.y,z=coords.z}}, serviceGroup)
				TriggerEvent('gcPhone:_internalAddMessage', number, n, message, 1, function(smsMess)
					TriggerClientEvent("gcPhone:receiveMessage", src, smsMess)
				end)
			end
		end)
	end
end

function getPhoneNumber(source, callback) 
	local user_id = vRP.getUserId({source})
	if user_id == nil then callback(nil) end
	MySQL.Async.fetchAll("SELECT vrp_user_identities.phone FROM vrp_user_identities WHERE vrp_user_identities.user_id = @user_id",{
		['@user_id'] = user_id
	}, function(result)
		callback(result[1].phone)
	end)
end

function sendServiceSMS(number, alert, ids)
	local mess = alert.sender..": "..alert.message
	if alert.coords ~= nil then
		mess = mess .. ' - ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
	for l,w in pairs(ids) do
		local player = vRP.getUserSource({w})
		getPhoneNumber(player, function(n)
			if n ~= nil then
				TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function(smsMess)
					TriggerClientEvent("gcPhone:receiveMessage", player, smsMess)
				end)
			end
		end)
	end
end

RegisterServerEvent('vrp_addons_gcphone:sendMessage')
AddEventHandler('vrp_addons_gcphone:sendMessage', function(number, alert, player)
	local mess = alert.message
	if alert.coords ~= nil then
		mess = mess .. ' GPS: ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
	getPhoneNumber(player, function (n)
		if n ~= nil then
			TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function(smsMess)
				TriggerClientEvent("gcPhone:receiveMessage", player, smsMess)
			end)
		end
	end)
end)
