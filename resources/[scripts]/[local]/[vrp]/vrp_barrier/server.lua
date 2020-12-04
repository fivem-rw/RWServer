local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPpm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_barrier")
PMclient = Tunnel.getInterface("vrp_barrier", "vrp_barrier")
vRPpm = Tunnel.getInterface("vrp_barrier", "vrp_barrier")
Tunnel.bindInterface("vrp_barrier", vRPpm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")

-- REMEMBER TO ADD THE PERMISSIONS FOR WHAT YOU WANT TO USE
-- CREATES PLAYER SUBMENU AND ADD CHOICES
local police = {}
local menu = {}

menu["콘 설치"] = {
	function(player, choice)
		PMclient.isCloseToCone(
			player,
			{},
			function(closeby)
				if closeby and (police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.removeCone(player, {})
					police[player] = false
				elseif not closeby and (not police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.setConeOnGround(player, {})
					police[player] = true
				end
			end
		)
	end
}

menu["배리어1 설치"] = {
	function(player, choice)
		PMclient.isCloseToBarrier(
			player,
			{},
			function(closeby)
				if closeby and (police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.removeBarrier(player, {})
					police[player] = false
				elseif not closeby and (not police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.setBarrierOnGround(player, {})
					police[player] = true
				end
			end
		)
	end
}

menu["배리어2 설치"] = {
	function(player, choice)
		PMclient.isCloseToBarrier2(
			player,
			{},
			function(closeby)
				if closeby and (police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.removeBarrier2(player, {})
					police[player] = false
				elseif not closeby and (not police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.setBarrierWorkOnGround(player, {})
					police[player] = true
				end
			end
		)
	end
}

menu["스파이크 설치"] = {
	function(player, choice)
		PMclient.isCloseToSpikes(
			player,
			{},
			function(closeby)
				if closeby and (police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.removeSpikes(player, {})
					police[player] = false
				elseif not closeby and (not police[player] or vRP.hasPermission({user_id, "police.menu_interaction"})) then
					PMclient.setSpikesOnGround(player, {})
					police[player] = true
				end
			end
		)
	end
}

local ch_police = {
	function(player, choice)
		local user_id = vRP.getUserId({player})
		menu.name = "경찰 용품"
		menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
		menu.onclose = function(player)
			vRP.openMainMenu({player})
		end -- nest menu

		vRP.openMenu({player, menu})
	end,
	"경찰 용품"
}

-- REGISTER MAIN MENU CHOICES
vRP.registerMenuBuilder(
	{
		"main",
		function(add, data)
			local user_id = vRP.getUserId({data.player})
			if user_id ~= nil then
				local choices = {}

				if vRP.hasPermission({user_id, "police.menu_interaction"}) then
					choices["경찰 용품"] = ch_police
				end

				add(choices)
			end
		end
	}
)

RegisterNetEvent("proxy_vrp_barrier:action")
AddEventHandler(
	"proxy_vrp_barrier:action",
	function(type)
		local player = source
		local user_id = vRP.getUserId({player})
		if not user_id then
			return
		end
		if type == "vrp_barrier_ch_barrier_1" then
			if vRP.hasPermission({user_id, "police.menu_interaction"}) then
				menu["배리어1 설치"][1](source, "")
			end
		elseif type == "vrp_barrier_ch_barrier_2" then
			if vRP.hasPermission({user_id, "police.menu_interaction"}) then
				for k, v in pairs(menu) do
					print(k, v)
				end
				menu["배리어2 설치"][1](source, "")
			end
		elseif type == "vrp_barrier_ch_barrier_cone" then
			if vRP.hasPermission({user_id, "police.menu_interaction"}) then
				menu["콘 설치"][1](source, "")
			end
		elseif type == "vrp_barrier_ch_barrier_spikes" then
			if vRP.hasPermission({user_id, "police.menu_interaction"}) then
				menu["스파이크 설치"][1](source, "")
			end
		end
	end
)
