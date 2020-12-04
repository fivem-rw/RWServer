Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP", "vrp_pets_server")

local pets = {
	["dog"] = {
		name = "Dog",
		price = 500000
	},
	["cat"] = {
		name = "Cat",
		price = 150000
	},
	["wolf"] = {
		name = "Wolf",
		price = 300000
	},
	["bunny"] = {
		name = "Bunny",
		price = 250000
	},
	["husky"] = {
		name = "Husky",
		price = 350000
	},
	["pig"] = {
		name = "Pig",
		price = 100000
	},
	["poodle"] = {
		name = "Poodle",
		price = 500000
	},
	["pug"] = {
		name = "Pug",
		price = 50000
	},
	["retriever"] = {
		name = "Retriever",
		price = 100000
	},
	["alsatian"] = {
		name = "Alsatian Dog",
		price = 550000
	},
	["westie"] = {
		name = "Westie",
		price = 500000
	}
}

RegisterServerEvent("vrp_pets:animalname")
AddEventHandler("vrp_pets:animalname", function (source, method)
	local _source = source
	local player = vRP.getUserId({_source})
	MySQL.Async.fetchAll('SELECT * FROM vrp_users WHERE id = @id', {['@id'] = player}, function(result)
		if method == "callPet" then
			TriggerClientEvent("vrp_pets:callPet", _source, result[1].pet)
		elseif method == "orders" then
			TriggerClientEvent("vrp_pets:orders", _source, result[1].pet)
		end
	end)
end)

RegisterServerEvent("vrp_pets:dead")
AddEventHandler("vrp_pets:dead", function()
	local _source = source
	local player = vRP.getUserId({_source})
	
	MySQL.Async.execute('UPDATE vrp_users SET pet = NULL WHERE id = @id', {['@id'] = player})
end)

RegisterServerEvent('vrp_pets:startHarvest')
AddEventHandler('vrp_pets:startHarvest', function()
	local _source = source
	local player = vRP.getUserId({_source})
	vRP.tryGetInventoryItem({player, 'croquettes', 1})
end)

RegisterServerEvent('vrp_pets:takeanimal')
AddEventHandler('vrp_pets:takeanimal', function (source, petid, price)
	local _source = source
	local player = vRP.getUserId({_source})
	local playerMoney = vRP.getMoney({player})

	if playerMoney >= price then
		vRP.tryPayment({player, price})
		MySQL.Async.execute('UPDATE vrp_users SET pet = @pet WHERE id = @id', {['@id'] = player, ['@pet'] = petid})
		vRPclient.notify(_source, {"Compras-te um " .. pets[petid].name .. " por " .. price})
	else
		vRPclient.notify(_source, {"~r~Dinheiro Insuficiente!"})
	end
end)

RegisterServerEvent("vrp_pets:buypet")
AddEventHandler("vrp_pets:buypet", function ()
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}
	
	menudata.name = "Loja de Animais"
	menudata.css = "align = 'top-left'"

	for k, v in pairs(pets) do
		menudata[v.name] = {function (choice)
			TriggerEvent("vrp_pets:takeanimal", _source, k, v.price)
			vRP.closeMenu({_source})
		end, "" .. v.price}
	end
	
	vRP.openMenu({_source, menudata})
end)

RegisterServerEvent("vrp_pets:petMenu")
AddEventHandler("vrp_pets:petMenu", function (status, come, isInVehicle)
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}

	menudata.name = "펫 관리"
	menudata.css = {align = 'top-left'}

	if come == 1 then
		menudata["음식 주기"] = {function (choice)
			local data = vRP.getUserDataTable({player})
			TriggerClientEvent("vrp_pets:givefood", _source, data.inventory)
			vRP.closeMenu({_source})
		end, "배고픔 :" .. status .. "%"}
		menudata["Attach or detach your pet"] = {function (choice)
			TriggerClientEvent("vrp_pets:attachdetach", _source)
			vRP.closeMenu({_source})
		end}

		if isInVehicle then
			menudata["펫 차량 내리기"] = {function (choice)
				TriggerClientEvent("vrp_pets:enterleaveveh", _source)
				vRP.closeMenu({_source})
			end}
		else
			menudata["펫 차량 태우기"] = {function (choice)
				TriggerClientEvent("vrp_pets:enterleaveveh", _source)
				vRP.closeMenu({_source})
			end}
		end

		menudata["명령하기"] = {function (choice)
			TriggerEvent("vrp_pets:animalname", _source, "orders")
			vRP.closeMenu({_source})
		end}
	else
		menudata["부르기"] = {function (choice)
			if come == 0 then
				TriggerEvent("vrp_pets:animalname", _source, "callPet")
				vRP.closeMenu({_source})
			end
		end}
	end

	vRP.openMenu({_source, menudata})
end)

RegisterServerEvent("vrp_pets:ordersMenu")
AddEventHandler("vrp_pets:ordersMenu", function (data, model, inanimation)
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}

	menudata.name = "펫 명령"
	menudata.css = {align = 'top-left'}
	
	if not inanimation then
		if model ~= 1462895032 then
			menudata["Procurar a bola"] = {function (choice) -- balle
				TriggerClientEvent("vrp_pets:findball", _source)
				vRP.closeMenu({_source})
			end}
		end
		menudata["따라와"] = {function (choice) -- pied
			TriggerClientEvent("vrp_pets:followme", _source)
			vRP.closeMenu({_source})
		end}
		menudata["집에 들어가"] = {function (choice) -- niche
			TriggerClientEvent("vrp_pets:goHome", _source)
			vRP.closeMenu({_source})
		end}
		
		if (data == "dog") then
			menudata["Sentar"] = {function (choice) -- assis
				TriggerClientEvent("vrp_pets:seat", _source, 1)
				vRP.closeMenu({_source})
			end}
			menudata["누워"] = {function (choice) -- coucher
				TriggerClientEvent("vrp_pets:laydown", _source, 1)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "cat") then
			menudata["누워"] = {function (choice) -- coucher2
				TriggerClientEvent("vrp_pets:laydown", _source, 2)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "wolf") then
			menudata["누워"] = {function (choice) -- coucher3
				TriggerClientEvent("vrp_pets:laydown", _source, 3)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "pug") then
			menudata["Sentar"] = {function (choice) -- assis2
				TriggerClientEvent("vrp_pets:seat", _source, 2)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "retriever") then
			menudata["Sentar"] = {function (choice) -- assis3
				TriggerClientEvent("vrp_pets:seat", _source, 3)
				vRP.closeMenu({_source})
			end}
		end
	else
		menudata["일어나"] = {function (choice) -- debout
			TriggerClientEvent("vrp_pets:standup", _source)
			vRP.closeMenu({_source})
		end}
	end

	vRP.openMenu({_source, menudata})
end)