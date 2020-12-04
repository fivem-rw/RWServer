-- define some basic inventory items

local items = {}

function play_eat(player)
  local seq = {
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter", 1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger", 1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 1},
    {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger", 1}
  }

  vRPclient.playAnim(player, {true, seq, false})
end

function play_drink(player)
  local seq = {
    {"mp_player_intdrink", "intro_bottle", 1},
    {"mp_player_intdrink", "loop_bottle", 1},
    {"mp_player_intdrink", "outro_bottle", 1}
  }

  vRPclient.playAnim(player, {true, seq, false})
end

-- gen food choices as genfunc
-- idname
-- ftype: eat or drink
-- vary_hunger
-- vary_thirst
function gen(ftype, vary_hunger, vary_thirst)
  local fgen = function(args)
    local idname = args[1]
    local choices = {}
    local act = "Unknown"
    if ftype == "eat" then
      act = "먹기"
    elseif ftype == "drink" then
      act = "마시기"
    end

    choices[act] = {
      function(player, choice)
        local user_id = vRP.getUserId(player)
        local name = vRP.getItemName(idname)
        if user_id ~= nil then
          if vRP.tryGetInventoryItem(user_id, idname, 1, false) then
            if vary_hunger ~= 0 then
              vRP.varyHunger(user_id, vary_hunger)
            end
            if vary_thirst ~= 0 then
              vRP.varyThirst(user_id, vary_thirst)
            end

            if ftype == "drink" then
              vRPclient.notify(player, {"~b~" .. name .. " 마심."})
              play_drink(player)
            elseif ftype == "eat" then
              vRPclient.notify(player, {"~o~" .. name .. " 먹음."})
              play_eat(player)
            end

            vRP.closeMenu(player)
          end
        end
      end
    }

    return choices
  end

  return fgen
end

-- CLUB DRINKS --

items["armand"] = {"🍹 아르망 드 브리냑", "유형 : 주류<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}
items["dom"] = {"🍸 돔 페리뇽", "유형 : 주류<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}
items["absol"] = {"🍷 앱솔루트 보드카", "유형 : 주류<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}
items["xrated"] = {"🌠 X-RATED", "유형 : 주류<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}

-- DRINKS --

items["water"] = {"🌊 생수", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}
items["milk"] = {"🍶 우유", "유형 : 음료<br>배고픔 : 10회복<br>목마름 : 5회복<br>무게 : 0.5kg", gen("drink", -10, -5), 0.5}
items["coffee"] = {"☕ 커피", "유형 : 음료<br>배고픔 : 20감소<br>목마름 : 10회복<br>무게 : 0.2kg", gen("drink", 20, -10), 0.2}
items["tea"] = {"🍵 홍차", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 15회복<br>무게 : 0.2kg", gen("drink", 0, -15), 0.2}
items["icetea"] = {"🍹 아이스티", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 20회복<br>무게 : 0.5kg", gen("drink", 0, -20), 0.5}
items["orangejuice"] = {"🍹 오렌지 주스", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 25회복<br>무게 : 0.5kg", gen("drink", 0, -25), 0.5}
items["cocacola"] = {"🎒 코카-콜라", "유형 : 음료<br>배고픔 : 5회복<br>목마름 : 35회복<br>무게 : 0.3kg", gen("drink", -5, -35), 0.3}
items["redbull"] = {"🍷 레드불", "유형 : 음료<br>배고픔 : 10감소<br>목마름 : 40회복<br>무게 : 0.3kg", gen("drink", 10, -40), 0.3}
items["lemonade"] = {"🍹 레몬에이드", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 45회복<br>무게 : 0.3kg", gen("drink", 0, -45), 0.3}
items["vodka"] = {"🍷 보드카", "유형 : 음료<br>배고픔 : 15감소<br>목마름 : 65회복<br>무게 : 0.5kg", gen("drink", 15, -65), 0.5}
items["elixir"] = {"🎆 파워 엘릭서", "유형 : 음료<br>배고픔 : 100회복<br>목마름 : 100회복<br>무게 : 없음", gen("drink", -100, -100), 0}
items["kanari"] = {"🍶 까나리 액젓", "유형 : 음료<br>배고픔 : 0회복<br>목마름 : 100감소<br>무게 : 0.5kg", gen("drink", 0, 100), 0.5}
--FOOD

items["meat"] = {"🍖 멧돼지 고기", "유형 : 음식<br>배고픔 : 30회복<br>목마름 : 15감소<br>무게 : 0.5kg", gen("eat", -30, 15), 0.5}
items["garrafa_leite"] = {"🍼 흰우유", "유형 : 음식<br>배고픔 : 30회복<br>목마름 : 15감소<br>무게 : 0.5kg", gen("eat", -30, 15), 0.5}

-- create Breed item
items["bread"] = {"🍞 빵", "유형 : 음식<br>배고픔 : 10회복<br>목마름 : 0회복<br>무게 : 0.5kg", gen("eat", -10, 0), 0.5}
items["donut"] = {"🍪 도넛", "유형 : 음식<br>배고픔 : 15회복<br>목마름 : 0회복<br>무게 : 0.2kg", gen("eat", -15, 0), 0.2}
items["icecream"] = {"🍧 메로나", "유형 : 간식<br>배고픔 : 0회복<br>목마름 : 60회복<br>무게 : 0.3kg", gen("eat", 0, -60), 0.3}
items["ramen"] = {"🍜 신라면", "유형 : 음식<br>배고픔 : 80회복<br>목마름 : 20감소<br>무게 : 0.2kg", gen("eat", -80, 20), 0.2}
items["tacos"] = {"🍡 타코벨", "유형 : 음식<br>배고픔 : 20회복<br>목마름 : 0회복<br>무게 : 0.2kg", gen("eat", -20, 0), 0.2}
items["sandwich"] = {"🎂 샌드위치", "유형 : 음식<br>배고픔 : 25회복<br>목마름 : 0회복<br>무게 : 0.5kg", gen("eat", -25, 0), 0.5}
items["kebab"] = {"🍚 케밥", "유형 : 음식<br>배고픔 : 45회복<br>목마름 : 0회복<br>무게 : 0.85kg", gen("eat", -45, 0), 0.85}
items["pdonut"] = {"🍩 고급 도넛", "유형 : 음식<br>배고픔 : 25회복<br>목마름 : 0회복<br>무게 : 0.5kg", gen("eat", -25, 0), 0.5}
items["tofu"] = {"👝 두부", "유형 : 음식<br>배고픔 : 25회복<br>목마름 : 0회복<br>무게 : 0.5kg", gen("eat", -25, 0), 0.5}
items["pizza"] = {"🍕 피자", "유형 : 음식<br>배고픔 : 70회복<br>목마름 : 0회복<br>무게 : 1.0kg", gen("eat", -70, 0), 1.0}
items["trash"] = {"🍪 쓰레기", "", nil, 0.3}

return items
