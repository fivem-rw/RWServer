--[[Tudo deve ser alterado no vrp/modules/inventory.lua]]--

--[[FUNÇÃO COMPLETAMENTE NOVA (apenas colar no arquivo]]--

mochila = {}

function vRP.setMochila(user_id,tMochila)
	if not mochila[user_id] then mochila[user_id] = 0 end
	
	if vRP.getInventoryWeight(user_id) <= (vRP.getInventoryMaxWeight(user_id) - mochila[user_id] + tMochila) then
		mochila[user_id] = tMochila
		if tMochila == 0 then
			TriggerClientEvent('despir:mochila',source)
		end
		return true
	else 
		return false
	end
end

function vRP.getMochila(user_id)
	if user_id then
		return mochila[user_id]
	end
end


--[[FUNÇÕES A SEREM EDITADAS (devem ser adicionadas todas as linhas marcadas, o resto provavelmente ja tem na sua vrp)]]--

-- give action
function ch_give(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id then
    -- get nearest player
    local nplayer = vRPclient.getNearestPlayer(player,10)
    if nplayer then
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id then
        -- prompt number
        local amount = vRP.prompt(player,lang.inventory.give.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"")
        local amount = parseInt(amount)
        -- weight check
		local peso = true																--[[NOVO]]--
		if idname == "mochila" or idname == "mochila2" or idname == "mochila3" then		--[[NOVO]]--
			peso = vRP.setMochila(user_id,0)											--[[NOVO]]--
		end																				--[[NOVO]]--
		if peso then																	--[[NOVO]]--
			local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
			if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
			  if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
				vRP.giveInventoryItem(nuser_id,idname,amount,true)
				TriggerClientEvent('ch:give', source, idname, user_id, nuser_id)
				vRPclient.playAnim(player,true,{{"mp_common","givetake1_a",1}},false)
				vRPclient.playAnim(nplayer,true,{{"mp_common","givetake2_a",1}},false)
			  else
				vRPclient.notify(player,lang.common.invalid_value())
			  end
			else
			  vRPclient.notify(player,lang.inventory.full())
			end
		else  																--[[NOVO]]--
			vRPclient.notify(player,"~r~Esvazie a mochila primeiro.")		--[[NOVO]]--
		end																	--[[NOVO]]--
      else
        vRPclient.notify(player,lang.common.no_player_near())
      end
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end
  end
end

-- trash action
function ch_trash(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id then
    -- prompt number
    local amount = vRP.prompt(player,lang.inventory.trash.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"")
    local amount = parseInt(amount)
	local peso = true															--[[NOVO]]--
	if idname == "mochila" or idname == "mochila2" or idname == "mochila3" then	--[[NOVO]]--
		peso = vRP.setMochila(user_id,0)										--[[NOVO]]--
	end																			--[[NOVO]]--
	if peso then 																--[[NOVO]]--
		if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
		  vRPclient.notify(player,lang.inventory.trash.done({vRP.getItemName(idname),amount}))
		  TriggerClientEvent('ch:trash', source, idname)
		  vRPclient.playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
		  TriggerEvent("VxServer:ch_trash", "ID "..user_id.." destruiu "..amount.." "..vRP.getItemName(idname)..".")
		else
		  vRPclient.notify(player,lang.common.invalid_value())
		end
	else 																		--[[NOVO]]--
      vRPclient.notify(player,"~r~Esvazie a mochila primeiro.")				--[[NOVO]]--
    end																			--[[NOVO]]--
  end
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
  if not mochila[user_id] then mochila[user_id] = 0 end
  return math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength")))*cfg.inventory_weight_per_strength + mochila[user_id] --[[SUBSTITUIR]]--
end


		local cb_put = function(idname)
          local amount = vRP.prompt(source, lang.inventory.chest.put.prompt({vRP.getInventoryItemAmount(user_id, idname)}), "")
          amount = parseInt(amount)
			local peso = true 																--[[NOVO]]--
			if idname == "mochila" or idname == "mochila2" or idname == "mochila3" then 	--[[NOVO]]--
				peso = vRP.setMochila(user_id,0) 											--[[NOVO]]--
			end 																			--[[NOVO]]--
			if peso then 																	--[[NOVO]]--
			  local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
			  if new_weight <= max_weight then
				if amount >= 0 and vRP.tryGetInventoryItem(user_id, idname, amount, true) then
				  local citem = chest.items[idname]
				  if citem ~= nil then
					citem.amount = citem.amount+amount
				  else
					chest.items[idname] = {amount=amount}
				  end
				  if cb_in then cb_in(idname,amount) end
				  vRP.closeMenu(source)
				end
			  else
				vRPclient.notify(source,lang.inventory.chest.full())
			  end
			else																		--[[NOVO]]--
				vRPclient.notify(source,"Voce esta com a mochila equipada.")			--[[NOVO]]--
			end																			--[[NOVO]]--
        end