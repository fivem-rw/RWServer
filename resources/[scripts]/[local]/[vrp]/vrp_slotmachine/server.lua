--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_slots")


RegisterServerEvent('vrp_slotmachine:server:1')
AddEventHandler('vrp_slotmachine:server:1', function(amount,a,b,c)
	local source = source
	local user_id = vRP.getUserId({source})
	amount = tonumber(amount)
  if vRP.tryDepositToCompany({user_id,281,tonumber(amount)}) then
	--	if (vRP.getMoney({user_id}) >= tonumber(amount)) then
		--vRP.tryPayment({user_id,amount}) -- this gives the user the money
		-- if (vRP.getInventoryItemAmount({user_id,"dirty_money"}) >= tonumber(amount)) then
        	-- vRP.tryGetInventoryItem({user_id,"dirty_money",amount})
		TriggerClientEvent("vrp_slotmachine:1",source,tonumber(amount),tostring(a),tostring(b),tostring(c))
	else
		TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1^*당신은 그만한 돈을 가지고 있지 않습니다!") -- this is the message u get when u got no money
	end
end)

RegisterServerEvent('vrp_slotmachine:server:2')
AddEventHandler('vrp_slotmachine:server:2', function(amount)
	local source = source
	local user_id = vRP.getUserId({source})
  if vRP.tryWithdrawToCompany({user_id,281,tonumber(amount)}) then
	    --vRP.giveMoney({user_id,amount})
	    TriggerClientEvent('chatMessage', source, "", {0, 200, 60}, "상금  " .. amount .. ".") -- this is what u get if u win, u already get another one but this shows amount
      end
	end)

