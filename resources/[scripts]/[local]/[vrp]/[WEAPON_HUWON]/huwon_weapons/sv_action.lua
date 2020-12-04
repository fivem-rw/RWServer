local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
--MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","huwon_weapons")


RegisterServerEvent("khaichi:PSP")
AddEventHandler("khaichi:PSP", function(item)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local sourcePlayer = tonumber(source)
	
	if item == "c_marchette_lr_red" then
		local price = 0
		if vRP.hasPermission({user_id,"huwon1.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:Machette_lr_red", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end				
	end
	
	if item == "c_lightsaber" then
		local price = 0
		if vRP.hasPermission({user_id,"huwon2.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:Lightsaber", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end				
	end	
	
	if item == "c_machette_lrx_yellow" then
		local price = 0
		if vRP.hasPermission({user_id,"huwon3.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:Machette_lrx_yellow", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end				
	end	
	
	if item == "c_revolver" then
		local price = 15000000
		if vRP.hasPermission({user_id,"huwon3.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:Revolver", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
			vRPclient.notify(player,{"~o~[보급비용]~w~1500만원을 지불 했습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end					
	end	

	if item == "c_bladehw" then
		local price = 0
		if vRP.hasPermission({user_id,"huwon4.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:bladehw", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end					
	end

	if item == "c_axebat" then
		local price = 0
		if vRP.hasPermission({user_id,"huwon5.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:axebat", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end					
	end		

	if item == "c_sns_pistol" then
		local price = 15000000
		if vRP.hasPermission({user_id,"huwon5.weapon"}) then
		if vRP.tryFullPayment({user_id,price}) then
			TriggerClientEvent("huwon:sns_pistol", source)
			Citizen.Wait(4215)
			vRPclient.notify(player,{"~o~[보급완료]~w~무기를 보급 받았습니다."})
			vRPclient.notify(player,{"~o~[보급비용]~w~1500만원을 지불 했습니다."})
		else
			vRPclient.notify(player,{"~r~[실패]~w~금액이 부족합니다"})
		end
		else
		  vRPclient.notify(player,{"~r~[실패]~w~무기를 받을 수 없는 등급 입니다."})
        end					
	end

end)