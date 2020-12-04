local items = {}

items["medkit"] = {"💟 의료 도구", "혼수상태인 사람들을 회복시킬때 사용.", nil, 0.5}
items["dirtymoney"] = {"💸 검은 돈", "불법적으로 얻은 돈.", nil, 0}
items["parcels"] = {"📦 택배 소포", "배달 할 소포.", nil, 0.10}
items["repairkit"] = {"🔧 수리 도구", "차량 수리에 사용.", nil, 0.5}
items["fr_repairkit"] = {"🔧 특수한 수리 도구", "[퍼스트렉카 전용]차량 수리에 사용.", nil, 0.5}
items["hwrepairkit"] = {"🔧 특별 수리 도구", "[아이템 설명]<br>크라운 등급 이상부터 사용할 수 있습니다.<br><br>[효과]<br>일반 수리 도구보다 조금 더 빠르게 수리가 가능합니다.", nil, 0.5}
items["tunerchip"] = {"🔧 튜닝 도구", "차량 튜닝에 사용.", nil, 0.5}

--[[ 페스티벌 세트(09.04까지)

items["festival_box_g"] = {
  "🎉 페스티벌 글자 상자",
  "[아이템 설명]<br>2020년 리얼월드 여름 페스티벌 글자 상자 입니다.<br>글자를 모아 상품을 획득하세요!",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*상자 열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 110)
            if (chance >= 1) and (chance <= 5) then
              local randoms1 = math.random(1, 1)
              vRP.giveInventoryItem(user_id, "event_01", randoms1, true)
              vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~그 ~w~" .. randoms1 .. "개가 나왔습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 6) and (chance <= 10) then
                local randoms2 = math.random(1, 1)
                vRP.giveInventoryItem(user_id, "event_02", randoms2, true)
                vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~래 ~w~" .. randoms2 .. "개가 나왔습니다."})
              else
                vRP.closeMenu(player)
                if (chance >= 11) and (chance <= 12) then
                  local randoms3 = math.random(1, 1)
                  vRP.giveInventoryItem(user_id, "event_03", randoms3, true)
                  vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~픽 ~w~" .. randoms3 .. "개가 나왔습니다."})
                else
                  vRP.closeMenu(player)
                  if (chance >= 13) and (chance <= 15) then
                    local randoms4 = math.random(1, 1)
                    vRP.giveInventoryItem(user_id, "event_04", randoms4, true)
                    vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~카 ~w~" .. randoms4 .. "개가 나왔습니다."})
                  else
                    vRP.closeMenu(player)
                    if (chance >= 16) and (chance <= 18) then
                      local randoms5 = math.random(1, 1)
                      vRP.giveInventoryItem(user_id, "event_05", randoms5, true)
                      vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~드 ~w~" .. randoms5 .. "개가 나왔습니다."})
                    else
                      vRP.closeMenu(player)
                      if (chance >= 19) and (chance <= 25) then
                        local randoms6 = math.random(1, 1)
                        vRP.giveInventoryItem(user_id, "event_16", randoms6, true)
                        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~문 ~w~" .. randoms6 .. "개가 나왔습니다."})
                      else
                        vRP.closeMenu(player)
                        if (chance >= 26) and (chance <= 31) then
                          local randoms7 = math.random(1, 1)
                          vRP.giveInventoryItem(user_id, "event_17", randoms7, true)
                          vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~화 ~w~" .. randoms7 .. "개가 나왔습니다."})
                        else
                          vRP.closeMenu(player)
                          if (chance >= 32) and (chance <= 37) then
                            local randoms8 = math.random(1, 1)
                            vRP.giveInventoryItem(user_id, "event_18", randoms8, true)
                            vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~상 ~w~" .. randoms8 .. "개가 나왔습니다."})
                          else
                            vRP.closeMenu(player)
                            if (chance >= 38) and (chance <= 43) then
                              local randoms9 = math.random(1, 1)
                              vRP.giveInventoryItem(user_id, "event_19", randoms9, true)
                              vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~품 ~w~" .. randoms9 .. "개가 나왔습니다."})
                            else
                              vRP.closeMenu(player)
                              if (chance >= 44) and (chance <= 49) then
                                local randoms10 = math.random(1, 1)
                                vRP.giveInventoryItem(user_id, "event_20", randoms10, true)
                                vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~권 ~w~" .. randoms10 .. "개가 나왔습니다."})
                              else
                                vRP.closeMenu(player)
                                if (chance >= 50) and (chance <= 55) then
                                  local randoms11 = math.random(1, 1)
                                  vRP.giveInventoryItem(user_id, "event_06", randoms11, true)
                                  vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~헤 ~w~" .. randoms11 .. "개가 나왔습니다."})
                                else
                                  vRP.closeMenu(player)
                                  if (chance >= 56) and (chance <= 58) then
                                    local randoms12 = math.random(1, 1)
                                    vRP.giveInventoryItem(user_id, "event_07", randoms12, true)
                                    vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~드 ~w~" .. randoms12 .. "개가 나왔습니다."})
                                  else
                                    vRP.closeMenu(player)
                                    if (chance >= 59) and (chance <= 62) then
                                      local randoms13 = math.random(1, 1)
                                      vRP.giveInventoryItem(user_id, "event_08", randoms13, true)
                                      vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~셋 ~w~" .. randoms13 .. "개가 나왔습니다."})
                                    else
                                      vRP.closeMenu(player)
                                      if (chance >= 63) and (chance <= 65) then
                                        local randoms14 = math.random(1, 1)
                                        vRP.giveInventoryItem(user_id, "event_09", randoms14, true)
                                        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~키 ~w~" .. randoms14 .. "개가 나왔습니다."})
                                      else
                                        vRP.closeMenu(player)
                                        if (chance >= 66) and (chance <= 68) then
                                          local randoms15 = math.random(1, 1)
                                          vRP.giveInventoryItem(user_id, "event_10", randoms15, true)
                                          vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~보 ~w~" .. randoms15 .. "개가 나왔습니다."})
                                        else
                                          vRP.closeMenu(player)
                                          if (chance >= 69) and (chance <= 70) then
                                            local randoms16 = math.random(1, 1)
                                            vRP.giveInventoryItem(user_id, "event_11", randoms16, true)
                                            vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~드 ~w~" .. randoms16 .. "개가 나왔습니다."})
                                          else
                                            vRP.closeMenu(player)
                                            if (chance >= 71) and (chance <= 75) then
                                              local randoms17 = math.random(1, 1)
                                              vRP.giveInventoryItem(user_id, "event_12", randoms17, true)
                                              vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~기 ~w~" .. randoms17 .. "개가 나왔습니다."})
                                            else
                                              vRP.closeMenu(player)
                                              if (chance >= 76) and (chance <= 80) then
                                                local randoms18 = math.random(1, 1)
                                                vRP.giveInventoryItem(user_id, "event_13", randoms18, true)
                                                vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~프 ~w~" .. randoms18 .. "개가 나왔습니다."})
                                              else
                                                vRP.closeMenu(player)
                                                if (chance >= 81) and (chance <= 85) then
                                                  local randoms19 = math.random(1, 1)
                                                  vRP.giveInventoryItem(user_id, "event_14", randoms19, true)
                                                  vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~티 ~w~" .. randoms19 .. "개가 나왔습니다."})
                                                else
                                                  vRP.closeMenu(player)
                                                  if (chance >= 86) and (chance <= 90) then
                                                    local randoms20 = math.random(1, 1)
                                                    vRP.giveInventoryItem(user_id, "event_15", randoms20, true)
                                                    vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~콘 ~w~" .. randoms20 .. "개가 나왔습니다."})
                                                  else
                                                    vRP.closeMenu(player)
                                                    if (chance >= 91) and (chance <= 95) then
                                                      local randoms21 = math.random(1, 1)
                                                      vRP.giveInventoryItem(user_id, "event_21", randoms21, true)
                                                      vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~현 ~w~" .. randoms21 .. "개가 나왔습니다."})
                                                    else
                                                      vRP.closeMenu(player)
                                                      if (chance >= 96) and (chance <= 100) then
                                                        local randoms22 = math.random(1, 1)
                                                        vRP.giveInventoryItem(user_id, "event_22", randoms22, true)
                                                        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~실 ~w~" .. randoms22 .. "개가 나왔습니다."})
                                                      else
                                                        vRP.closeMenu(player)
                                                        if (chance >= 101) and (chance <= 105) then
                                                          local randoms23 = math.random(1, 1)
                                                          vRP.giveInventoryItem(user_id, "event_23", randoms23, true)
                                                          vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~실 ~w~" .. randoms23 .. "개가 나왔습니다."})
                                                        else
                                                          vRP.closeMenu(player)
                                                          if (chance >= 106) and (chance <= 110) then
                                                            local randoms24 = math.random(1, 1)
                                                            vRP.giveInventoryItem(user_id, "event_24", randoms24, true)
                                                            vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~계 ~w~" .. randoms24 .. "개가 나왔습니다."})
                                                          else
                                                            vRP.closeMenu(player)
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}]]

items["festival_box"] = {
  "*🔥 썸머 페스티벌 상자",
  "[아이템 설명]<br>2020년 리얼월드 여름 페스티벌 상자 입니다.<br>열심히 모아서 사용하면 좋은 일이 일어납니다.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*상자 열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 80)
            if (chance >= 1) and (chance <= 50) then
              local randoms1 = math.random(1, 3)
              vRP.giveInventoryItem(user_id, "elixir", randoms1, true)
              vRPclient.notify(player, {"~p~[보상 안내]\n ~g~파워 엘릭서 ~w~" .. randoms1 .. "개가 나왔습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 51) and (chance <= 60) then
                local randoms2 = math.random(1, 2)
                vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", randoms2, true)
                vRPclient.notify(player, {"~p~[보상 안내]\n ~g~고급추첨티켓 ~w~" .. randoms2 .. "개가 나왔습니다."})
              else
                vRP.closeMenu(player)
                if (chance >= 61) and (chance <= 65) then
                  local randoms3 = math.random(1, 2)
                  vRP.giveInventoryItem(user_id, "lottery_ticket_vip", randoms3, true)
                  vRPclient.notify(player, {"~p~[보상 안내]\n ~g~VIP추첨 티켓 ~w~" .. randoms3 .. "개가 나왔습니다."})
                else
                  vRP.closeMenu(player)
                  if (chance >= 66) and (chance <= 72) then
                    local randoms4 = math.random(1, 1)
                    vRP.giveInventoryItem(user_id, "ksrandom", randoms4, true)
                    vRPclient.notify(player, {"~p~[보상 안내]\n ~g~희미한 티켓 ~w~" .. randoms4 .. "개가 나왔습니다."})
                  else
                    vRP.closeMenu(player)
                    if (chance >= 73) and (chance <= 77) then
                      local randoms5 = math.random(1, 1)
                      vRP.giveInventoryItem(user_id, "titlebox_random", randoms5, true)
                      vRPclient.notify(player, {"~p~[보상 안내]\n ~g~칭호랜덤상자 ~w~" .. randoms5 .. "개가 나왔습니다."})
                    else
                      vRP.closeMenu(player)
                      if (chance >= 78) and (chance <= 80) then
                        local randoms6 = math.random(1, 1)
                        vRP.giveInventoryItem(user_id, "festival_maskbox", randoms6, true)
                        vRPclient.notify(player, {"~p~[축하드립니다!]\n ~g~가면 추첨상자 ~w~" .. randoms6 .. "개가 나왔습니다."})
                      else
                        vRP.closeMenu(player)
                          vRP.closeMenu(player)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

-- 가면 세트

items["festival_maskbox"] = {
  "🎭 가면 추첨 상자",
  "[아이템 설명]<br>꽝 혹은 당첨만이 존재 합니다.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*상자 열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 55)
            if (chance >= 1) and (chance <= 58) then
              vRPclient.notify(player, {"~r~[두근 두근]\n ~w~아쉽게도 ~r~꽝~w~이였습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 51) and (chance <= 58) then
                vRP.giveInventoryItem(user_id, "mask_ticket", randoms2, true)
                vRPclient.notify(player, {"~p~[두근 두근]\n ~g~축하드립니다. ~w~가면 이용권이 당첨 되었습니다!"})
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["mask_ticket"] = {
  "🎭 가면 이용권",
  "[아이템 설명]<br>사용 후 가면 상점을 이용하실 수 있습니다.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*권한 획득"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "mask.shop")
            vRPclient.notify(player, {"~g~가면 이용권~w~을 사용하였습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

--- 총알 세트

items["pistol_t"] = {
  "*🌑 피스톨 100발 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🌑 피스톨 탄약 100개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wammo|WEAPON_PISTOL", 100, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ak47_t"] = {
  "*🌑 어썰트 라이플 100발 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🌑 어썰트 라이플 탄약 100개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wammo|WEAPON_ASSAULTRIFLE", 100, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["smg_t"] = {
  "*🌑 마이크로 SMG 100발 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🌑 마이크로 SMG 탄약 100개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wammo|WEAPON_MICROSMG", 100, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["sniper_t"] = {
  "*🌑 스나이퍼 5발 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🌑 스나이퍼 탄약 5개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wammo|WEAPON_SNIPERRIFLE", 5, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["shotgun_t"] = {
  "*🌑 펌프 샷건 100발 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🌑 펌프 샷건 탄약 100개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wammo|WEAPON_PUMPSHOTGUN", 100, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

--- 몸체

items["pistol_m"] = {
  "*🔫 피스톨 몸체 상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🔫 피스톨 몸체~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL", 1, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ak47_m"] = {
  "*🔫 어썰트 라이플 몸체 상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🔫 어썰트 라이플 몸체~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wbody|WEAPON_ASSAULTRIFLE", 1, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["smg_m"] = {
  "*🔫 마이크로 SMG 몸체 상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🔫 마이크로 SMG 몸체~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wbody|WEAPON_MICROSMG", 1, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["sniper_m"] = {
  "*🔫 스나이퍼 몸체 상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🔫 스나이퍼 몸체~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wbody|WEAPON_SNIPERRIFLE", 1, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["shotgun_m"] = {
  "*🔫 펌프 샷건 몸체 상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 1)
            if (chance >= 1) and (chance <= 1) then
              vRPclient.notify(player, {"~g~[시스템 안내]\n~y~🔫 펌프 샷건 1개~w~가 지급 되었습니다."})
              vRP.giveInventoryItem(user_id, "wbody|WEAPON_PUMPSHOTGUN", 1, true)
            else
              vRP.closeMenu(player)
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

---

items["gold_boxrandom"] = {
  "🎫 알 수 없는 현금봉투",
  "[아이템 설명]<br>금괴 습격 관련 칭호를 교환할 수 있습니다.<br><br>[보상 종류]<br>찢어진 백지수표 최대 3개<br>그을린 백지수표 최대 3개",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*보상 확인"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 34) then
              local randomsp1 = math.random(1, 3)
              vRP.giveInventoryItem(user_id, "gold_mission_sp1", randomsp1, true)
              vRPclient.notify(player, {"~p~[보상 안내]\n ~g~찢어진 백지수표 ~w~" .. randomsp1 .. "개가 나왔습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 35) and (chance <= 50) then
                local randomsp2 = math.random(1, 3)
                vRP.giveInventoryItem(user_id, "gold_mission_sp2", randoms2, true)
                vRPclient.notify(player, {"~p~[보상 안내]\n ~g~그을린 백지수표  ~w~" .. randomsp2 .. "개가 나왔습니다."})
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["special_goldbox"] = {
  "🎫 금괴습격 미션보상",
  "[아이템 설명]<br>금괴 습격 미션에 성공시 주어지는 보상 입니다.<br><br>[보상 종류]<br>용해된 금괴 최대 10개<br>특수 재료상자 1개",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*보상 확인"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 80)
            if (chance >= 1) and (chance <= 40) then
              local randoms1 = math.random(1, 3)
              vRP.giveInventoryItem(user_id, "goldwatch", randoms1, true)
              vRPclient.notify(player, {"~p~[보상 안내]\n ~g~금시계 ~w~" .. randoms1 .. "개가 나왔습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 41) and (chance <= 61) then
                local randoms2 = math.random(1, 5)
                vRP.giveInventoryItem(user_id, "goldwatch", randoms2, true)
                vRPclient.notify(player, {"~p~[보상 안내]\n ~g~금시계 ~w~" .. randoms2 .. "개가 나왔습니다."})
              else
                vRP.closeMenu(player)
                if (chance >= 62) and (chance <= 72) then
                  local randoms3 = math.random(3, 10)
                  vRP.giveInventoryItem(user_id, "goldwatch", randoms3, true)
                  vRPclient.notify(player, {"~p~[보상 안내]\n ~g~금시계 ~w~" .. randoms3 .. "개가 나왔습니다."})
                else
                  vRP.closeMenu(player)
                  if (chance >= 73) and (chance <= 80) then
                    local randoms4 = math.random(3, 10)
                    vRP.giveInventoryItem(user_id, "goldwatch", randoms4, true)
                    vRP.giveInventoryItem(user_id, "gold_boxrandom", 1, true)
                    vRPclient.notify(player, {"~p~[보상 안내]\n ~g~금시계 ~w~" .. randoms4 .. "개와 칭호재료상자 1개가 나왔습니다."})
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["special_goldb"] = {
  "🎁 현금다발 상자",
  "[아이템 설명]<br>최소 500만원부터 최대 5000만원까지 획득할 수 있습니다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*보상 확인"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local goldbmoney = math.random(5000000, 50000000)
            vRPclient.notify(player, {"~o~[보상 안내]\n ~w~미션 보상금액 ~y~" .. goldbmoney .. "원~w~을 받았습니다."})
            vRP.giveMoney(user_id, goldbmoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["special_foodbox"] = {
  "🎁 알쏭달쏭 음식상자",
  "[아이템 설명]<br>총 14가지의 다양한 음식이 들어있는 음식상자 입니다.<br><br>[음식 종류]<br>일반 음식 10가지<br>특수 음식 4가지",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*상자 오픈"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 253)
            if (chance >= 1) and (chance <= 20) then
              vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~빵~w~이 나왔습니다!"})
              vRP.giveInventoryItem(user_id, "bread", 1, true)
            else
              vRP.closeMenu(player)
              if (chance >= 21) and (chance <= 41) then
                vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~메로나~w~가 나왔습니다!"})
                vRP.giveInventoryItem(user_id, "icecream", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 42) and (chance <= 62) then
                  vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~라면~w~이 나왔습니다!"})
                  vRP.giveInventoryItem(user_id, "ramen", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 63) and (chance <= 83) then
                    vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~타코벨~w~이 나왔습니다!"})
                    vRP.giveInventoryItem(user_id, "tacos", 1, true)
                  else
                    vRP.closeMenu(player)
                    if (chance >= 84) and (chance <= 104) then
                      vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~오렌지 쥬스~w~가 나왔습니다!"})
                      vRP.giveInventoryItem(user_id, "orangejuice", 1, true)
                    else
                      vRP.closeMenu(player)
                      if (chance >= 105) and (chance <= 125) then
                        vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~코카 콜라~w~가 나왔습니다!"})
                        vRP.giveInventoryItem(user_id, "cocacola", 1, true)
                      else
                        vRP.closeMenu(player)
                        if (chance >= 126) and (chance <= 146) then
                          vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~레드불~w~이 나왔습니다!"})
                          vRP.giveInventoryItem(user_id, "redbull", 1, true)
                        else
                          vRP.closeMenu(player)
                          if (chance >= 147) and (chance <= 167) then
                            vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~아르망드~w~가 나왔습니다!"})
                            vRP.giveInventoryItem(user_id, "armand", 1, true)
                          else
                            vRP.closeMenu(player)
                            if (chance >= 168) and (chance <= 188) then
                              vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~돔페리뇽~w~이 나왔습니다!"})
                              vRP.giveInventoryItem(user_id, "dom", 1, true)
                            else
                              vRP.closeMenu(player)
                              if (chance >= 189) and (chance <= 199) then
                                vRPclient.notify(player, {"~p~[일반 음식 획득] \n~w~상자를 열어보니 ~g~레몬에이드~w~가 나왔습니다!"})
                                vRP.giveInventoryItem(user_id, "lemonade", 1, true)
                              else
                                vRP.closeMenu(player)
                                if (chance >= 200) and (chance <= 210) then
                                  vRPclient.notify(player, {"~o~[특수 음식 획득] \n~w~상자를 열어보니 ~r~꽃게 튀김~w~이 나왔습니다!"})
                                  vRP.giveInventoryItem(user_id, "crap_food", 1, true)
                                else
                                  vRP.closeMenu(player)
                                  if (chance >= 211) and (chance <= 221) then
                                    vRPclient.notify(player, {"~o~[특수 음식 획득] \n~w~상자를 열어보니 ~r~새우 튀김~w~이 나왔습니다!"})
                                    vRP.giveInventoryItem(user_id, "shrimp_food", 1, true)
                                  else
                                    vRP.closeMenu(player)
                                    if (chance >= 222) and (chance <= 237) then
                                      vRPclient.notify(player, {"~o~[특수 음식 획득] \n~w~상자를 열어보니 ~r~딸기 케이크~w~가 나왔습니다!"})
                                      vRP.giveInventoryItem(user_id, "cake_food", 1, true)
                                    else
                                      vRP.closeMenu(player)
                                      if (chance >= 238) and (chance <= 253) then
                                        vRPclient.notify(player, {"~o~[특수 음식 획득] \n~w~상자를 열어보니 ~r~레드 와인~w~이 나왔습니다!"})
                                        vRP.giveInventoryItem(user_id, "wine_food", 1, true)
                                      else
                                        vRP.closeMenu(player)
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["driver"] = {
  "🎫 운전면허증",
  "[아이템 설명]<br>리얼월드에 꼭 필요한 운전면허증 입니다.<br><br>[효과]<br>면허 상태가 정상or정지 여부를 확인할 수 있습니다.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["상태 보기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          if vRP.getLicenseStatus(user_id) == 0 then
            vRPclient.notify(player, {"면허 상태 : ~g~ 정상"})
          else
            vRPclient.notify(player, {"면허 상태 : ~r~ 정지"})
          end
        end
      end
    }

    return choices
  end,
  0
}

function aivehiclekit(args)
  local choices = {}
  local idname = args[1]
  choices["*웨이포인트로운전"] = {
    function(player, choice, mod)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        vRPclient.aiVehicleStartWaypoint(player, {})
        vRP.closeMenu(player)
      end
    end
  }
  choices["*알아서운전"] = {
    function(player, choice, mod)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        vRPclient.aiVehicleStartFree(player, {})
        vRP.closeMenu(player)
      end
    end
  }
  choices["*멈추기"] = {
    function(player, choice, mod)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        vRPclient.aiVehicleStop(player, {})
        vRP.closeMenu(player)
      end
    end
  }
  return choices
end

items["aivehiclekit_basic"] = {"💚 인공지능키트 기본", "차량 자동운전 키트 (1분)", aivehiclekit, 0.1}
items["aivehiclekit_adv"] = {"💜 인공지능키트 고급", "차량 자동운전 키트 (10분)", aivehiclekit, 0.1}
items["aivehiclekit_vip"] = {"💛 인공지능키트 VIP", "차량 자동운전 키트 (무제한)", aivehiclekit, 0.1}

items["test"] = {
  "테스트",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["사용"] = {
      function(player, choice, mod)
        print(player, choice)
      end
    }

    return choices
  end,
  0
}

--무기파츠

local supressor_choices = {}
supressor_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "supressor", 1) then
        TriggerClientEvent("alex:supp", player)
      end
    end
  end
}

local flash_choices = {}
flash_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "flash", 1) then
        TriggerClientEvent("alex:flashlight", player)
      end
    end
  end
}

local yusuf_choices = {}
yusuf_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "yusuf", 1) then
        TriggerClientEvent("alex:yusuf", player)
      end
    end
  end
}

local grip_choices = {}
grip_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "grip", 1) then
        TriggerClientEvent("alex:grip", player)
      end
    end
  end
}

local holografik_choices = {}
holografik_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "holografik", 1) then
        TriggerClientEvent("alex:holografik", player)
      end
    end
  end
}

local powiekszonymagazynek_choices = {}
powiekszonymagazynek_choices["장착하기"] = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, "powiekszonymagazynek", 1) then
        TriggerClientEvent("alex:powiekszonymagazynek", player)
      end
    end
  end
}

items["supressor"] = {
  "🔫 소음기[무기파츠]",
  "",
  function(args)
    return supressor_choices
  end,
  0.1
}
items["flash"] = {
  "🔫 후레쉬[무기파츠]",
  "",
  function(args)
    return flash_choices
  end,
  0.1
}
items["yusuf"] = {
  "🔫 스폐셜 스킨[무기파츠]",
  "",
  function(args)
    return yusuf_choices
  end,
  0.1
}
items["grip"] = {
  "🔫 손잡이[무기파츠]",
  "",
  function(args)
    return grip_choices
  end,
  0.1
}
items["holografik"] = {
  "🔫 홀로그램 스코프[무기파츠]",
  "",
  function(args)
    return holografik_choices
  end,
  0.1
}
items["powiekszonymagazynek"] = {
  "🔫 확장탄창[무기파츠]",
  "",
  function(args)
    return powiekszonymagazynek_choices
  end,
  0.1
}

--- weapon ammo

items["aw2"] = {
  "체포 영장",
  "리얼월드 대검찰청",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["영장 사용"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 대검찰청에서 발부된 ^1체포 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }

    return choices
  end,
  0
}

items["aw1"] = {
  "구속 영장",
  "리얼월드 대검찰청",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["영장 사용"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 대검찰청에서 발부된 ^1구속 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }

    return choices
  end,
  0
}

items["aw3"] = {
  "수색 영장",
  "리얼월드 대검찰청",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["영장 사용"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 대검찰청에서 발부된 ^1수색 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }

    return choices
  end,
  0
}

items["aw4"] = {
  "수배 영장",
  "리얼월드 대검찰청",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["영장 사용"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 대검찰청에서 발부된 ^1수배 영장^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }

    return choices
  end,
  0
}

items["elysiumid1"] = {
  "공무원증",
  "리얼월드 총리부",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["보여주기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 총리부에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0
}

items["elysiumid2"] = {
  "경찰공무원증",
  "리얼월드 경찰청",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["보여주기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 경찰청에서 발급된 ^4경찰공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0
}

items["elysiumid3"] = {
  "공무원증",
  "리얼월드 의료국",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["보여주기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 총리부에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0
}

items["elysiumid4"] = {
  "공무원증",
  "리얼월드 대검찰청",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["보여주기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then -- unpack the money
            local name = GetPlayerName(player)
            local message = "리얼월드 대검찰청에서 발급된 ^4공무원증^0을 보여준다."
            TriggerClientEvent("sendProximityMessageW", -1, player, name, message)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0
}

-- money
items["money"] = {
  "돈",
  "묶어둔 돈.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["묶음 해제"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          vRP.prompt(
            player,
            "How much to unpack ? (max " .. amount .. ")",
            "",
            function(player, ramount)
              ramount = parseInt(ramount)
              if vRP.tryGetInventoryItem(user_id, idname, ramount, true) then -- unpack the money
                vRP.giveMoney(user_id, ramount)
                vRP.closeMenu(player)
              end
            end
          )
        end
      end
    }

    return choices
  end,
  0
}

items["ak47_2"] = {
  "*📦 어썰트 라이플 MK2 부품상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 139) then
              vRPclient.notify(player, {"~r~[실패]~w~조립에 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 140) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~어썰트 라이플 MK2 완성상자~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "ak47_2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["shotgun_2"] = {
  "*📦 펌프 샷건 MK2 부품상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 139) then
              vRPclient.notify(player, {"~r~[실패]~w~조립에 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 140) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~펌프 샷건 MK2 완성상자~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "ak47_2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["smg_2"] = {
  "*📦 SMG MK2 부품상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 139) then
              vRPclient.notify(player, {"~r~[실패]~w~조립에 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 140) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~SMG MK2 완성상자~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "ak47_2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ak47_3"] = {
  "*📦 어썰트 라이플 MK2 완성상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 140) then
              vRPclient.notify(player, {"~r~[실패]~w~총기가 부식 되어 부셔졌습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 141) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~총기를 조심스레 장착하여 ~y~어썰트 라이플 MK2~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_ASSAULTRIFLE_MK2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["smg_3"] = {
  "*📦 SMG MK2 완성상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 140) then
              vRPclient.notify(player, {"~r~[실패]~w~총기가 부식 되어 부셔졌습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 141) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~총기를 조심스레 장착하여 ~y~SMG MK2~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_SMG_MK2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["shotgun_3"] = {
  "*📦 펌프 샷건 MK2 완성상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 140) then
              vRPclient.notify(player, {"~r~[실패]~w~총기가 부식 되어 부셔졌습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 141) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~총기를 조심스레 장착하여 ~y~펌프 샷건 MK2~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PUMPSHOTGUN_MK2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["smg_mk2_t"] = {
  "*📦 SMG MK2 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 120) then
              vRPclient.notify(player, {"~r~[실패]~w~탄약 조립이 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 121) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~SMG MK2 탄약 150개~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wammo|WEAPON_SMG_MK2", 150, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ak47_mk2_t"] = {
  "*📦 어썰트 라이플 MK2 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 120) then
              vRPclient.notify(player, {"~r~[실패]~w~탄약 조립이 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 121) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~어썰트 라이플 MK2 탄약 100개~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wammo|WEAPON_ASSAULTRIFLE_MK2", 100, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["shotgun_mk2_t"] = {
  "*📦 펌프 샷건 MK2 탄약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*조립하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 200)
            if (chance >= 1) and (chance <= 120) then
              vRPclient.notify(player, {"~r~[실패]~w~탄약 조립이 실패했습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 121) and (chance <= 200) then
                vRPclient.notify(player, {"~g~[성공]~w~조립에 성공하여 ~y~펌프 샷건 MK2 탄약 150개~w~를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "wammo|WEAPON_PUMPSHOTGUN_MK2", 150, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["hw_01"] = {
  "*🎫 레드 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "redmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter1", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~r~레드 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_02"] = {
  "*🎫 에이스 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "acemember")
            vRP.removeUserGroup(user_id, "redmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter2", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~g~에이스 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_03"] = {
  "*🎫 로얄 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "royalmember")
            vRP.removeUserGroup(user_id, "acemember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter3", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~g~로얄 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_04"] = {
  "*🎫 노블레스 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "noblemember")
            vRP.removeUserGroup(user_id, "royalmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter4", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~y~노블레스 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_05"] = {
  "*🎫 퍼스트 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "firstmember")
            vRP.addUserGroup(user_id, "musicboxmember")
            vRP.removeUserGroup(user_id, "noblemember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter5", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~r~퍼스트 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_06"] = {
  "*🎫 퍼스트프라임 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "firstfmember")
            vRP.removeUserGroup(user_id, "firstmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter6", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~r~퍼스트 프라임 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_07"] = {
  "*🎫 트리니티 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "trinitymember")
            vRP.removeUserGroup(user_id, "firstfmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter7", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~r~트리니티 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_08"] = {
  "*🎫 크라운 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "crownmember")
            vRP.removeUserGroup(user_id, "trinitymember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter8", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~y~크라운 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_09"] = {
  "*🎫 프레스티지 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "prestizimember")
            vRP.removeUserGroup(user_id, "crownmember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter9", 1, true)
            vRPclient.notify(player, {"~y~[UP]~w~ 리얼월드 ~y~프레스티지 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["hw_10"] = {
  "*🎫 하이엔드 등급업 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "highendmember")
            vRP.removeUserGroup(user_id, "prestizimember")
            vRP.giveInventoryItem(user_id, "titlebox_supporter10", 1, true)
            vRPclient.notify(player, {"~y~[최고등급 달성]\n~y~하이앤드 VIP 멤버~w~가 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["musicbox_ticket"] = {
  "*🎫 뮤직박스티켓",
  "사용시 뮤직박스를 사용하실 수 있게 됩니다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "musicboxmember")
            vRPclient.notify(player, {"~p~[사용완료]\n~w~뮤직박스 이용이 가능하게 되었습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["taxisnt"] = {
  "*🎫 개인택시 자격증(1회성)",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "개인택시")
            vRPclient.notify(player, {"~g~[성공]~w~축하드립니다 당신은 이제부터 ~y~개인 택시기사 ~w~입니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["moder_ticket"] = {
  "*🎫 모더레이터 아이콘 칭호",
  "사용시 사라집니다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*사용하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "nameicon.moderator")
            vRPclient.notify(player, {"~g~[성공]~w~모더레이터 아이콘 칭호를 장착하였습니다"})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["jtj7"] = {
  "*💊 시험용 진통제",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*시험하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 51) then
              vRPclient.notify(player, {"~r~[실패]~w~실패한 약물 입니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 52) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~실험에 성공하여 ~y~포장된 진통제를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "jtj8", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["hd5"] = {
  "*💊 시험용 해독제",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*시험하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 51) then
              vRPclient.notify(player, {"~r~[실패]~w~실패한 약물 입니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 52) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~실험에 성공하여 ~y~포장된 진통제를 제작했습니다."})
                vRP.giveInventoryItem(user_id, "zombie_medkit", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["sk3"] = {
  "*🔧 낡은 수리도구 세트",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*고치기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 31) then
              vRPclient.notify(player, {"~r~[실패]~w~수리도구가 부서졌습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 32) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~수리도구가 ~y~성공적으로 제작했습니다."})
                vRP.giveInventoryItem(user_id, "repairkit", 5, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["c4_box1"] = {
  "*📦 화약상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*화약 뭉치기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 31) then
              vRPclient.notify(player, {"~r~[실패]~w~화약을 조합하였지만 실패하였습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 32) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~C4상자 조합이 성공 하였습니다."})
                vRP.giveInventoryItem(user_id, "c4_box2", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["c4_box2"] = {
  "*📦 C4 완성상자",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*상자열기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 11) then
              vRPclient.notify(player, {"~r~[실패]~w~완성상자를 사용해봤지만 부서졌습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 22) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~C4를 꺼냈습니다."})
                vRP.giveInventoryItem(user_id, "explosivo_c4", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ks3"] = {
  "*🔧 금속탐지샘플",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*샘플 고르기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 31) then
              vRPclient.notify(player, {"~r~[실패]~w~샘플을 사용해봤지만 불량품 입니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 32) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~샘플이 정상적 입니다."})
                vRP.giveInventoryItem(user_id, "metaldetector", 2, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["fl3"] = {
  "*🔧 후레쉬 샘플",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*샘플 고르기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 102)
            if (chance >= 1) and (chance <= 51) then
              vRPclient.notify(player, {"~r~[실패]~w~샘플을 사용해봤지만 불량품 입니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 52) and (chance <= 102) then
                vRPclient.notify(player, {"~g~[성공]~w~샘플이 정상적 입니다."})
                vRP.giveInventoryItem(user_id, "flash", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ksrandom"] = {
  "🎫 희미한 티켓",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*티켓확인"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 37000)
            if (chance >= 1) and (chance <= 15000) then
              vRPclient.notify(player, {"~r~티켓을 확인해보니 꽝이 적혀있습니다."})
            else
              vRP.closeMenu(player)
              if (chance >= 15001) and (chance <= 20000) then
                vRPclient.notify(player, {"~g~티켓을 확인해보니 ~y~곡괭이 5개 지급이 적혀있습니다."})
                vRP.giveInventoryItem(user_id, "picareta", 5, true)
              else
                vRP.closeMenu(player)
                if (chance >= 20001) and (chance <= 28300) then
                  vRPclient.notify(player, {"~g~티켓을 확인해보니 ~r~격발 버튼 1개~w~ 지급이 적혀있습니다."})
                  vRP.giveInventoryItem(user_id, "button_bomb", 1, true)
                else
                  vRP.closeMenu(player)
                if (chance >= 28301) and (chance <= 34000) then
                  vRPclient.notify(player, {"~g~티켓을 확인해보니 ~y~파워엘릭서 10개 지급이 적혀있습니다."})
                  vRP.giveInventoryItem(user_id, "elixir", 10, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 34001) and (chance <= 36000) then
                    vRPclient.notify(player, {"~g~티켓을 확인해보니 ~y~금괴미션 사용권 1개 지급이 적혀있습니다."})
                    vRP.giveInventoryItem(user_id, "special_goldticket", 1, true)
                  else
                    vRP.closeMenu(player)
                    if (chance >= 36001) and (chance <= 36500) then
                      vRPclient.notify(player, {"~g~티켓을 확인해보니 ~y~좀비존 입장티켓 1개 지급이 적혀있습니다."})
                      vRP.giveInventoryItem(user_id, "zombie_ticket_1", 1, true)
                    else
                      vRP.closeMenu(player)
                      if (chance >= 36501) and (chance <= 37000) then
                        vRPclient.notify(player, {"~g~티켓을 확인해보니 ~y~칭호상자 1개 지급이 적혀있습니다."})
                        vRP.giveInventoryItem(user_id, "titlebox_random", 1, true)
                      else
                        vRP.closeMenu(player)
                      end
                    end
                  end
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["real_chips"] = {
  "*(구) 카지노칩",
  "개당 1천원",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*교환하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local stonemoney = math.random(1000, 1000)
            vRPclient.notify(player, {"카지노칩을 교환해서 ~g~" .. stonemoney .. "원을 받았습니다."})
            vRP.giveMoney(user_id, stonemoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["real_chip"] = {
  "*(구) 카지노칩",
  "개당 1천원",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*교환하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local stonemoney = math.random(1000, 1000)
            vRPclient.notify(player, {"카지노칩을 교환해서 ~g~" .. stonemoney .. "원을 받았습니다."})
            vRP.giveMoney(user_id, stonemoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["ouro"] = {
  "**🗿 알수없는 돌",
  "희미하게 반짝인다.",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["*감정하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 40340)
            if (chance >= 1) and (chance <= 11111) then
              vRPclient.notify(player, {"~r~아쉽게도 돌맹이 입니다."})
              vRP.giveInventoryItem(user_id, "stone", 1, true)
            else
              vRP.closeMenu(player)
              if (chance >= 11112) and (chance <= 22222) then
                vRPclient.notify(player, {"~r~아쉽게도 돌맹이 2개 입니다."})
                vRP.giveInventoryItem(user_id, "stone", 2, true)
              else
                vRP.closeMenu(player)
                if (chance >= 22223) and (chance <= 32222) then
                  vRPclient.notify(player, {"~g~은 광석 입니다!"})
                  vRP.giveInventoryItem(user_id, "silver1", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 32223) and (chance <= 35333) then
                    vRPclient.notify(player, {"~g~금 광석 입니다!"})
                    vRP.giveInventoryItem(user_id, "golden1", 1, true)
                  else
                    vRP.closeMenu(player)
                  if (chance >= 35334) and (chance <= 40334) then
                    vRPclient.notify(player, {"~r~화약~w~ 입니다!"})
                    vRP.giveInventoryItem(user_id, "gunpowder", 1, true)
                  else
                    vRP.closeMenu(player)
                    if (chance >= 40335) and (chance <= 40340) then
                      vRPclient.notify(player, {"~g~다이아광석 입니다!"})
                      vRP.giveInventoryItem(user_id, "diamond1", 1, true)
                    else
                      vRP.closeMenu(player)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["bass"] = {
  "🐡 베스",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 해체 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~해체에 실패했습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 26) then
                vRPclient.notify(player, {"~w~해체를 통해 ~y~베스 몸통~w~을 획득하였습니다."})
                vRP.giveInventoryItem(user_id, "bass_body", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 27) and (chance <= 35) then
                  vRPclient.notify(player, {"~w~해체를 통해 ~y~베스 머리~w~를 획득하였습니다."})
                  vRP.giveInventoryItem(user_id, "bass_head", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 36) and (chance <= 50) then
                    vRPclient.notify(player, {"~w~해체를 통해 ~y~베스 지느러미~w~를 획득하였습니다."})
                    vRP.giveInventoryItem(user_id, "bass_j", 1, true)
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["catfish"] = {
  "🐡 메기",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 해체 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~해체에 실패했습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 26) then
                vRPclient.notify(player, {"~w~해체를 통해 ~y~메기 몸통~w~을 획득하였습니다."})
                vRP.giveInventoryItem(user_id, "catfish_body", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 27) and (chance <= 35) then
                  vRPclient.notify(player, {"~w~해체를 통해 ~y~메기 머리~w~를 획득하였습니다."})
                  vRP.giveInventoryItem(user_id, "catfish_head", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 36) and (chance <= 50) then
                    vRPclient.notify(player, {"~w~해체를 통해 ~y~메기 지느러미~w~를 획득하였습니다."})
                    vRP.giveInventoryItem(user_id, "catfish_j", 1, true)
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["pisicademare"] = {
  "🐡 가오리",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 해체 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~해체에 실패했습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 26) then
                vRPclient.notify(player, {"~w~해체를 통해 ~y~가오리 몸통~w~을 획득하였습니다."})
                vRP.giveInventoryItem(user_id, "pisicademare_body", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 27) and (chance <= 35) then
                  vRPclient.notify(player, {"~w~해체를 통해 ~y~가오리 머리~w~를 획득하였습니다."})
                  vRP.giveInventoryItem(user_id, "pisicademare_head", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 36) and (chance <= 50) then
                    vRPclient.notify(player, {"~w~해체를 통해 ~y~가오리 꼬리~w~를 획득하였습니다."})
                    vRP.giveInventoryItem(user_id, "pisicademare_j", 1, true)
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["pescarus"] = {
  "🐧 갈매기",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 해체 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~해체에 실패했습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 26) then
                vRPclient.notify(player, {"~w~해체를 통해 ~y~갈매기 몸통~w~을 획득하였습니다."})
                vRP.giveInventoryItem(user_id, "pescarus_body", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 27) and (chance <= 35) then
                  vRPclient.notify(player, {"~w~해체를 통해 ~y~갈매기 날개~w~를 획득하였습니다."})
                  vRP.giveInventoryItem(user_id, "pescarus_wing", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 36) and (chance <= 50) then
                    vRPclient.notify(player, {"~w~해체를 통해 ~y~갈매기 꼬리~w~를 획득하였습니다."})
                    vRP.giveInventoryItem(user_id, "pescarus_kori", 1, true)
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["rechin"] = {
  "🐳 상어",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 해체 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~해체에 실패했습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 26) then
                vRPclient.notify(player, {"~w~해체를 통해 ~y~상어 몸통~w~을 획득하였습니다."})
                vRP.giveInventoryItem(user_id, "rechin_body", 1, true)
              else
                vRP.closeMenu(player)
                if (chance >= 27) and (chance <= 35) then
                  vRPclient.notify(player, {"~w~해체를 통해 ~y~상어 머리~w~를 획득하였습니다."})
                  vRP.giveInventoryItem(user_id, "rechin_head", 1, true)
                else
                  vRP.closeMenu(player)
                  if (chance >= 36) and (chance <= 50) then
                    vRPclient.notify(player, {"~w~해체를 통해 ~y~상어 지느러미~w~를 획득하였습니다."})
                    vRP.giveInventoryItem(user_id, "rechin_j", 1, true)
                  else
                    vRP.closeMenu(player)
                  end
                end
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["mushroom"] = {
  "*🍄 알 수 없는 버섯",
  "",
  function(args)
    local choices = {}
    local idname = args[1]

    choices["* 감정 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local chance = math.random(1, 50)
            if (chance >= 1) and (chance <= 15) then
              vRPclient.notify(player, {"~r~버섯이 으스라졌습니다"})
            else
              vRP.closeMenu(player)
              if (chance >= 16) and (chance <= 50) then
                vRPclient.notify(player, {"~o~[감정 결과] ~w~일반 버섯"})
                vRP.giveInventoryItem(user_id, "mushroom_i", 1, true)
              else
                vRP.closeMenu(player)
              end
            end
          end
        end
      end
    }
    return choices
  end,
  0
}

items["ljmadeira"] = {
  "*🌱 장작",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*판매하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local stonemoney = math.random(30000, 70000)
            vRPclient.notify(player, {"장작을 팔아 ~g~" .. format_num(stonemoney) .. "원을 받았습니다."})
            vRP.giveMoney(user_id, stonemoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["dirty_money"] = {
  "*💸 검은 돈",
  "",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*세탁 하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local stonemoney = math.random(50000, 200000)
            vRPclient.notify(player, {"돈 세탁을 해서 ~g~" .. stonemoney .. "원을 받았습니다."})
            vRP.giveMoney(user_id, stonemoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["stone"] = {
  "*🗿 망가진 돌 조각",
  "그래도 팔아보자",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*판매하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local stonemoney = math.random(5000, 35000)
            vRPclient.notify(player, {"돌을 팔아 ~g~" .. format_num(stonemoney) .. "원을 받았습니다."})
            vRP.giveMoney(user_id, stonemoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["silver1"] = {
  "*⚪ 은광석",
  "살짝 가치가 있어보인다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*판매하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local silvermoney = math.random(40000, 100000)
            vRPclient.notify(player, {"은광석을 팔아 ~g~" .. format_num(silvermoney) .. "원을 받았습니다."})
            vRP.giveMoney(user_id, silvermoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["golden1"] = {
  "*🔮 금광석",
  "꽤 비싸보이는 광석이다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*판매하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local goldenmoney = math.random(200000, 500000)
            vRPclient.notify(player, {"금광석을 팔아 ~g~" .. format_num(goldenmoney) .. "원을 받았습니다."})
            vRP.giveMoney(user_id, goldenmoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["diamond1"] = {
  "*💎 다이아몬드 광석",
  "매우 고가에 거래되는 광석이다.",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*판매하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local diamondmoney = math.random(8000000, 20000000)
            vRPclient.notify(player, {"다이아몬드를 팔아 ~g~" .. format_num(diamondmoney) .. "원을 받았습니다."})
            vRP.giveMoney(user_id, diamondmoney)
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["skateboard_ticket"] = {
  "🌠 스케이트보드 이용권",
  "주의! 사용시 사라집니다!",
  function(args)
    local choices = {}
    local idname = args[1]
    choices["*이용시작"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)
          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            vRP.addUserGroup(user_id, "skateboard")
            vRPclient.notify(player, {"~g~🌠 스케이트보드 이용권~w~을 사용하였습니다."})
          end
          vRP.closeMenu(player)
        end
      end
    }
    return choices
  end,
  0.1
}

items["randommoney"] = {
  "와사비망고의 토사물",
  "최소 100,000부터 100,000,000까지 랜덤!",
  function(args)
    local choices = {}
    local idname = args[1]
    --[[
    choices["토사물 조사하기"] = {
      function(player, choice, mod)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          local amount = vRP.getInventoryItemAmount(user_id, idname)

          if vRP.tryGetInventoryItem(user_id, idname, 1, true) then
            local randommoneys = {
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              100000,
              1000000,
              1000000,
              1000000,
              1000000,
              1000000,
              1000000,
              1000000,
              1000000,
              10000000,
              10000000,
              10000000,
              10000000,
              10000000,
              10000000,
              10000000,
              10000000,
              100000000,
              100000000
            }
            local randommoneysCount = 29
            local randommoneysPos = math.random(randommoneysCount)
            vRPclient.notify(player, {"와사비 망고의 토사물을 조사하는중입니다!"})
            Citizen.Wait(3000)
            vRPclient.notify(player, {"이런! 토사물에서 ~g~" .. randommoneys[randommoneysPos] .. "이 검출되었어요!"})
            vRP.giveMoney(user_id, randommoneys[randommoneysPos])
            vRP.closeMenu(player)
          end
        end
      end
    }
    ]]
    return choices
  end,
  0
}

-- parametric weapon items
-- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id, "WEAPON_", "")
  name = string.upper(string.sub(name, 1, 1)) .. string.lower(string.sub(name, 2))
  return name
end

--- weapon body
local wbody_name = function(args)
  return "🔫 " .. get_wname(args[2]) .. " 몸체"
end

local wbody_desc = function(args)
  return ""
end

local wbody_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args, "|")

  choices["*착용"] = {
    function(player, choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id, fullidname, 1, true) then -- give weapon body
          local weapons = {}
          weapons[args[2]] = {ammo = 0}
          vRPclient.giveWeapons(player, {weapons})

          vRP.closeMenu(player)
        end
      end
    end
  }

  return choices
end

local wbody_weight = function(args)
  return 0.75
end

items["wbody"] = {wbody_name, wbody_desc, wbody_choices, wbody_weight}

--- weapon ammo
local wammo_name = function(args)
  return "🌑 " .. get_wname(args[2]) .. " 탄약"
end

local wammo_desc = function(args)
  return ""
end

local wammo_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args, "|")

  choices["*장전"] = {
    function(player, choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        local amount = vRP.getInventoryItemAmount(user_id, fullidname)
        vRP.prompt(
          player,
          "몇개를 장전 하시겠습니까? (최대: " .. amount .. ")",
          "",
          function(player, ramount)
            ramount = parseInt(ramount)

            vRPclient.getWeapons(
              player,
              {},
              function(uweapons)
                if uweapons[args[2]] ~= nil then -- check if the weapon is equiped
                  if vRP.tryGetInventoryItem(user_id, fullidname, ramount, true) then -- give weapon ammo
                    local weapons = {}
                    weapons[args[2]] = {ammo = ramount}
                    vRPclient.giveWeapons(player, {weapons, false})
                    vRP.closeMenu(player)
                  end
                end
              end
            )
          end
        )
      end
    end
  }

  return choices
end

local wammo_weight = function(args)
  return 0.01
end

items["wammo"] = {wammo_name, wammo_desc, wammo_choices, wammo_weight}

return items
