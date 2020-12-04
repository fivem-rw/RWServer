local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fixcar")

RegisterCommand("fix", function(player, args, msg)
	local source = player
  local user_id = vRP.getUserId({player})
	if vRP.hasGroup({user_id,"관리자"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방총감"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방정감"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방감"}) then
		CancelEvent();		
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방준감"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방령"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방정"}) then
		CancelEvent();		
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"소방경"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	elseif vRP.hasGroup({user_id,"소방위"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	elseif vRP.hasGroup({user_id,"소방장"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"스태프"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"경찰특공대장"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"임시스태프"}) then
		CancelEvent();
    TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"스태프장"}) then
		CancelEvent();
		 TriggerClientEvent('murtaza:fix', source);
    elseif vRP.hasGroup({user_id,"admin"}) then
		CancelEvent();
		TriggerClientEvent('murtaza:fix', source);
	end
end)