local items = {}

local function openBoxAnim(player)
  local seq = {
    {"anim@heists@box_carry@", "run", 1},
    {"anim@heists@box_carry@", "walk", 1},
    {"anim@heists@box_carry@", "run", 1}
  }

  vRPclient.playAnim(player, {true, seq, false})
end

local newbie_box_open = {}
newbie_box_open["*상자열기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      openBoxAnim(player)
      vRPclient.notify(player, {"♎ 뉴비지원상자를 여는중..."})
      Wait(5000)
      vRP.openNewbieBox(user_id)
      vRP.closeMenu(player)
    end
  end
}

items["newbie_box"] = {
  "♎ 뉴비지원상자",
  "[아이템 설명]<br>1천만원~100억원 랜덤지급상자<br>추가로 뉴비지원키트가 지급됩니다",
  function(args)
    return newbie_box_open
  end,
  0.1
}

local bonus_box_open = {}
bonus_box_open["*상자열기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      openBoxAnim(player)
      vRPclient.notify(player, {"🅱 보너스상자를 여는중..."})
      Wait(5000)
      vRP.openBonusBox(user_id)
      vRP.closeMenu(player)
    end
  end
}

items["bonus_box"] = {
  "🅱 보너스상자",
  "돈부터 희귀아이템까지 랜덤지급상자",
  function(args)
    return bonus_box_open
  end,
  0.0
}

---- 페스티벌 아이템 사용 기록

items["event_trade_01_t"] = {
  "🈲 그래픽카드 추첨권",
  "[아이템설명]<br>응모 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox1(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["event_trade_02_t"] = {
  "🛐 헤드셋 추첨권",
  "[아이템설명]<br>응모 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox2(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["event_trade_03_t"] = {
  "🛐 키보드 추첨권",
  "[아이템설명]<br>응모 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox3(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["event_trade_04_t"] = {
  "🛐 문화상품권 5만원 추첨권",
  "[아이템설명]<br>당첨 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox4(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["event_trade_05_t"] = {
  "🛐 치킨 기프티콘 추첨권",
  "[아이템설명]<br>당첨 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox5(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["event_trade_06_t"] = {
  "🈲 리얼월드 굿즈 추첨권",
  "[아이템설명]<br>당첨 or 꽝 최종 형태",
  function(args)
    return {
      ["*당첨 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🅱 당첨을 확인 하는중..."})
            Wait(5000)
            vRP.openfestivalBox6(user_id)
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

-----------------------------------

items["lottery_ticket_basic"] = {"📗 매일 추첨티켓", "시청앞에 추첨센터에서 사용", nil, 0.0}
items["lottery_ticket_advanced"] = {"📘 고급 추첨티켓", "시청앞에 추첨센터에서 사용", nil, 0.0}
items["lottery_ticket_vip"] = {"📒 VIP 추첨티켓", "시청앞에 추첨센터에서 사용", nil, 0.0}
items["lottery_ticket_gold"] = {"📒 골드 추첨티켓", "시청앞에 추첨센터에서 사용", nil, 0.0}
items["gift_box"] = {"🎁 리얼박스", "아이템부터 차량까지 랜덤지급상자", nil, 0.0}
items["eventbox1"] = {"🔯 이벤트박스", "문화상품권 추첨 이벤트상자", nil, 0.0}
items["eventitem_event1_ticket1"] = {"🔖 문상교환권(천원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event1_ticket2"] = {"🔖 문상교환권(오천원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event1_ticket3"] = {"🎫 문상교환권(만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event1_ticket4"] = {"🎫 문상교환권(오만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event1_ticket5"] = {"🔥 문상교환권(십만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event1_ticket6"] = {"🔥 문상교환권(오십만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}

items["eventitem_event2_vivestone"] = {"💠 이벤트부활석", "부활데이 이벤트에서 확인", nil, 0.0}
items["eventitem_event2_vivestone1"] = {"♉ 부활석조각[A]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone2"] = {"♎ 부활석조각[B]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone3"] = {"♏ 부활석조각[C]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone4"] = {"♐ 부활석조각[D]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone5"] = {"♑ 부활석조각[E]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone6"] = {"♒ 부활석조각[F]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_vivestone7"] = {"♓ 부활석조각[G]", "부활석을 만들수 있는 재료 (A~G)", nil, 0.0}
items["eventitem_event2_ticket1"] = {"🎫 문상교환권(만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event2_ticket2"] = {"🎫 문상교환권(오만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event2_ticket3"] = {"🔥 문상교환권(십만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}
items["eventitem_event2_ticket4"] = {"🔥 문상교환권(오십만원권)", "문화상품권으로 교환할 수 있는 티켓", nil, 0.0}

return items
