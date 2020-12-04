local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
--MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","police_weapons")


RegisterServerEvent("Police:PSP")
AddEventHandler("Police:PSP", function(item)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local sourcePlayer = tonumber(source)
	
	if item == "c_combatpistol" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:CombatPistol", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end
	
	if item == "c_carbine" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT2.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:Carbine", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end	
	
	if item == "c_tazer" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT2.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:Tazer", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end	
	
	if item == "c_nightstick" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT2.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:Nightstick", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end					
	end	
	
	if item == "c_appistol" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT2.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:APPistol", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end	
	
	if item == "c_sniperrifle" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT3.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:Sniperrifle", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end	
	
	if item == "c_assaultshotgun" then
		local price = 0
		if vRP.hasPermission({user_id,"SWAT.loadshop"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("police:AssaultShotgun", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 직급 입니다."})
        end				
	end	
	
	
end)