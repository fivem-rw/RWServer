
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPbp = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","damn_backpacks")
BPclient = Tunnel.getInterface("damn_backpacks","damn_backpacks")
Tunnel.bindInterface("damn_backpacks",vRPbp)


Citizen.CreateThread(function()
  for k,v in pairs(mochilas) do
    vRP.defInventoryItem({k,v.name,v.desc,v.choices,v.weight})
  end
end)

mochilas = {
	["realw_bag01"] = {
		name = "가방 (소)",
		desc = "작은 크기의 가방",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,1)
				vRP.setMochila({user_id,10})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,{"~r~먼저 가방을 비워주세요!"})
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["realw_bag02"] = {
		name = "대형 더플백",
		desc = "Made in Daiso",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,2)
				vRP.setMochila({user_id,50})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,"~r~먼저 가방을 비워주세요!")
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["realw_bag03"] = {
		name = "가방 (중)",
		desc = "보통 크기의 가방",
		choices = function(args)
			local menu = {}
			menu["착용"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('vestir:mochila',player,3)
				vRP.setMochila({user_id,30})
			end}
			menu["착용 해제"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setMochila({user_id,0}) then 
					TriggerClientEvent('despir:mochila',player)
				else
					vRPclient._notify(player,{"~r~먼저 가방을 비워주세요!"})
				end
			end}
			return menu
		end,
		weight = 2.0
	},
  ["lvca1"] = {
		name = "[차량교환권] BMW Z4 Convertable 교환권",
		desc = "",
		choices = function(args)
			local menu = {}
			menu["교환"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.tryGetInventoryItem({user_id, "lvca1", 1, false}) then -- unpack the money
        local vname = "z4"
        local coupon = "lvca1"
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vname}, function(rows, affected)
        if #rows > 0 then
        vRPclient.notify(player,{"~r~이미 가지고 있는 차량입니다."})
        vRP.giveInventoryItem({user_id, coupon, 1, false})
        else
        vRPclient.notify(player,{"~g~교환 완료"})
        vRP.getUserIdentity({user_id, function(identity)
        MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vname, vehicle_plate = "P "..identity.registration, veh_type = "car"})
        vRP.closeMenu({player})
      end})
    end
    end)
        end
			end}
    return menu
		end,
		weight = 0
  }
}