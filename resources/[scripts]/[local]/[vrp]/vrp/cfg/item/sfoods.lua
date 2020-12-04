local items = {}

items["crap_food"] = {
  "🦀 특제 꽃게 튀김",
  "[아이템 설명]<br>요리를 통해 만들어진 특수 음식 입니다.<br><br>[효과 설명]</span><br>5분간 수영 속도가 15퍼 빨라집니다.",
  function(args)
    return {
      ["*먹기"] = {
        function(player, choice, mod)
          local user_id = vRP.getUserId(player)
          local player = vRP.getUserSource(user_id)
          if user_id ~= nil then
            if vRP.tryGetInventoryItem(user_id, "crap_food", 1, true) then
              TriggerClientEvent("bagaefect", player, "scuba", 150.0, 5)
              vRPclient.notify(player, {"~p~[음식 효과 적용]\n~w~음식을 섭취해서 특수한 효과가 발휘 됩니다."})
              vRP.closeMenu(player) --max 300.0
            end
          end
        end
      }
    }
  end,
  1.5
}

items["shrimp_food"] = {
  "🍤 특제 새우 튀김",
  "[아이템 설명]<br>요리를 통해 만들어진 특수 음식 입니다.<br><br>[효과 설명]<br>5분간 달리기 속도가 15퍼 빨라집니다.",
  function(args)
    return {
      ["*먹기"] = {
        function(player, choice, mod)
          local user_id = vRP.getUserId(player)
          local player = vRP.getUserSource(user_id)
          if user_id ~= nil then
            if vRP.tryGetInventoryItem(user_id, "shrimp_food", 1, true) then
              TriggerClientEvent("bagaefect", player, "speed", 1.10, 5) -- max 1.49
              vRPclient.notify(player, {"~p~[음식 효과 적용]\n~w~음식을 섭취해서 특수한 효과가 발휘 됩니다."})
              vRP.closeMenu(player)
            end
          end
        end
      }
    }
  end,
  1.5
}

items["fish_food"] = {
  "🐟 특별 생선찜",
  "[특별 아이템]<br>관리자 및 스태프에게만 주어지는 특수 음식 입니다.<br><br>[효과 설명]<br>5분간 점프력이 크게 상승합니다.",
  function(args)
    return {
      ["*먹기"] = {
        function(player, choice, mod)
          local user_id = vRP.getUserId(player)
          local player = vRP.getUserSource(user_id)
          if user_id ~= nil then
            if vRP.tryGetInventoryItem(user_id, "fish_food", 1, true) then
              TriggerClientEvent("bagaefect", player, "jump", 100, 5)
              vRPclient.notify(player, {"~p~[음식 효과 적용]\n~w~음식을 섭취해서 특수한 효과가 발휘 됩니다."})
              vRP.closeMenu(player)
            end
          end
        end
      }
    }
  end,
  1.5
}

items["cake_food"] = {
  "🍰 특제 딸기 케이크",
  "[아이템 설명]<br>요리를 통해 만들어진 특수 음식 입니다.<br><br>[효과 설명]<br>5분간 배고픔 게이지가 닳지 않습니다.",
  function(args)
    return {
      ["*먹기"] = {
        function(player, choice, mod)
          local user_id = vRP.getUserId(player)
          local player = vRP.getUserSource(user_id)
          if user_id ~= nil then
            if vRP.tryGetInventoryItem(user_id, "cake_food", 1, true) then
              TriggerClientEvent("bagaefect", player, "hunger", 5, 5)
              vRP.setHunger(user_id, -20)
              vRPclient.notify(player, {"~p~[음식 효과 적용]\n~w~음식을 섭취해서 특수한 효과가 발휘 됩니다."})
              vRP.closeMenu(player)
            end
          end
        end
      }
    }
  end,
  1.5
}

items["wine_food"] = {
  "🍷 특제 레드 와인",
  "[아이템 설명]<br>요리를 통해 만들어진 특수 음식 입니다.<br><br>[효과 설명]<br>5분간 목마름 게이지가 닳지 않습니다.",
  function(args)
    return {
      ["*먹기"] = {
        function(player, choice, mod)
          local user_id = vRP.getUserId(player)
          local player = vRP.getUserSource(user_id)
          if user_id ~= nil then
            if vRP.tryGetInventoryItem(user_id, "wine_food", 1, true) then
              TriggerClientEvent("bagaefect", player, "thirst", 5, 5)
              vRP.setThirst(user_id, -20)
              vRPclient.notify(player, {"~p~[음식 효과 적용]\n~w~음식을 섭취해서 특수한 효과가 발휘 됩니다."})
              vRP.closeMenu(player)
            end
          end
        end
      }
    }
  end,
  1.5
}

return items
