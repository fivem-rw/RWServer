local items = {}

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink", "intro_bottle", 1},
    {"mp_player_intdrink", "loop_bottle", 1},
    {"mp_player_intdrink", "outro_bottle", 1}
  }

  vRPclient.playAnim(player, {true, seq, false})
end

local pills_choices1 = {}
pills_choices1["*먹기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "pills", 1) then
        vRPclient.varyHealth(player, {-25})
        vRPclient.notify(player, {"~g~(구)진통제를 먹었습니다."})
        play_drink(player)
        vRP.closeMenu(player)
      end
    end
  end
}

local pills_choices2 = {}
pills_choices2["*먹기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "jtjc", 1) then
        vRPclient.varyHealth(player, {50})
        vRPclient.notify(player, {"~g~진통제를 먹었습니다."})
        play_drink(player)
        vRP.closeMenu(player)
      end
    end
  end
}

local pills_choices3 = {}
pills_choices3["*먹기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "jtjc2", 1) then
        vRPclient.varyHealth(player, {50})
        vRPclient.notify(player, {"~g~뉴비지원키트를 사용했습니다\n의료국을 통해 진통제를 구매할 수 있습니다."})
        play_drink(player)
        vRP.closeMenu(player)
      end
    end
  end
}

local function play_smoke(player)
  local seq2 = {
    {"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1},
    {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
    {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}
  }

  vRPclient.playAnim(player, {true, seq2, false})
end

local cigar1_choices = {}
cigar1_choices["*흡연"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "cigar1", 1) then
        vRPclient.notify(player, {"~g~말보로 레드를 피우는 중..."})
        vRPclient.playAnim(player, {false, {task = "WORLD_HUMAN_AA_SMOKE"}, false})
        Citizen.Wait(15000)
        vRPclient.stopAnim(player, {true}) -- upper
        vRPclient.stopAnim(player, {false}) -- full
        --play_smoke(player)
        vRP.closeMenu(player)
      end
    end
  end
}

local cigar2_choices = {}
cigar2_choices["*흡연"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "cigar2", 1) then
        vRPclient.notify(player, {"~g~마일드 세븐을 피우는 중..."})
        vRPclient.playAnim(player, {false, {task = "WORLD_HUMAN_AA_SMOKE"}, false})
        Citizen.Wait(15000)
        vRPclient.stopAnim(player, {true}) -- upper
        vRPclient.stopAnim(player, {false}) -- full
        vRP.closeMenu(player)
      end
    end
  end
}

local function play_smell(player)
  local seq3 = {
    {"mp_player_intdrink", "intro_bottle", 1},
    {"mp_player_intdrink", "loop_bottle", 1},
    {"mp_player_intdrink", "outro_bottle", 1}
  }

  vRPclient.playAnim(player, {true, seq3, false})
end

local function play_lsd(player)
  local seq4 = {
    {"mp_player_intdrink", "intro_bottle", 1},
    {"mp_player_intdrink", "loop_bottle", 1},
    {"mp_player_intdrink", "outro_bottle", 1}
  }

  vRPclient.playAnim(player, {true, seq4, false})
end

local lsd_choices = {}
lsd_choices["*빨기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "lsd5", 1) then
        vRP.varyThirst(user_id, (20))
        vRPclient.notify(player, {"~g~ LSD를 빨았습니다."})
        play_lsd(player)
        vRP.closeMenu(player)
      end
    end
  end
}

items["pills"] = {
  "💊 (구)진통제",
  "1개당 10,000원",
  function(args)
    return pills_choices1
  end,
  0.1
}
items["jtjc"] = {
  "💊 진통제",
  "통증완화 체력 50회복",
  function(args)
    return pills_choices2
  end,
  0.1
}
items["jtjc2"] = {
  "💊 뉴비지원키트",
  "[아이템 설명]<br>통증완화 체력 50회복<br><br>[진통제 구매안내]<br>모두 사용한다면 의료국을 통해 진통제를 구매하시면 됩니다.",
  function(args)
    return pills_choices3
  end,
  0.1
}
items["lsd5"] = {
  "💫 LSD",
  "소량의 LSD.",
  function(args)
    return lsd_choices
  end,
  0.1
}
items["cigar1"] = {
  "🚬 말보로 레드",
  "담배.",
  function(args)
    return cigar1_choices
  end,
  0.1
}
items["cigar2"] = {
  "🚬 마일드 세븐",
  "담배.",
  function(args)
    return cigar2_choices
  end,
  0.1
}
items["Presents"] = {"🎁 선물", "특별한 선물상자"}

return items
