--#####################################################--
--               SCRIPT MADE BY TERBIUM                --
--#####################################################--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_AdminRevive")

local groups = {"superadmin", "rpadmin", "소방총감", "소방정감", "소방감","소방준감", "소방정","소방령", "소방경", "소방위", "소방장", "소방대원", "helper"};

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/rv" or msg == "/revive" or msg == "/hl" or msg == "/heal" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
	  for k,v in ipairs(groups) do
		if vRP.hasGroup({user_id,v}) then
	  		vRPclient.varyHealth(player,{100})
	  end
	  end
	end
end)