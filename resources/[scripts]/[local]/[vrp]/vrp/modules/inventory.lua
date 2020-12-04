local lang = vRP.lang
local cfg = module("cfg/inventory")
local cfgItems = module("cfg/items")
local items = cfgItems.items

-- this module define the player inventory (lost after respawn, as wallet)

vRP.items = {}

-- define an inventory item (call this at server start) (parametric or plain text data)
-- idname: unique item name
-- name: display name or genfunction
-- description: item description (html) or genfunction
-- choices: menudata choices (see gui api) only as genfunction or nil
-- weight: weight or genfunction
--
-- genfunction are functions returning a correct value as: function(args) return value end
-- where args is a list of {base_idname,arg,arg,arg,...}

MySQL.createCommand("vRP/get_dataitem_id", "select get_dataitem_id(@data,@u_str) as id")

local customActionExecute = {}

function vRP.defInventoryCustomAction()
  for items_k, items_v in pairs(items) do
    if items_v[3] and type(items_v[3]) == "function" then
      customActionExecute[items_k] = items_v[3]
    end
  end
end

function vRP.executeInventoryCustomAction(player, idname, action)
  local args = {}
  if string.find(idname, "|") then
    local ss = splitString(idname, "|")
    if ss then
      for _, v in pairs(ss) do
        table.insert(args, v)
      end
    else
      table.insert(args, idname)
    end
  else
    table.insert(args, idname)
  end

  local name = args[1]

  if name and customActionExecute[name] then
    local arrActionList = customActionExecute[name](args)
    if arrActionList then
      for k, v in pairs(arrActionList) do
        if k == action and v[1] then
          v[1](player, action)
        end
      end
    end
  end
end

function vRP.defInventoryItem(idname, name, description, choices, weight, dataType)
  if weight == nil then
    weight = 0
  end

  local item = {name = name, description = description, choices = choices, weight = weight, dataType = dataType}
  vRP.items[idname] = item

  -- build give action
  item.ch_give = function(player, choice)
  end

  -- build trash action
  item.ch_trash = function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      -- prompt number
      vRP.prompt(
        player,
        lang.inventory.trash.prompt({format_num(vRP.getInventoryItemAmount(user_id, idname))}),
        "",
        function(player, amount)
          local amount = parseInt(amount)
          if vRP.tryGetInventoryItem(user_id, idname, amount, false) then
            vRPclient.notify(player, {lang.inventory.trash.done({vRP.getItemName(idname), format_num(amount)})})
            TriggerClientEvent("DropSystem:drop", player, idname, amount)
            vRPclient.playAnim(player, {true, {{"pickup_object", "pickup_low", 1}}, false})
          else
            vRPclient.notify(player, {lang.common.invalid_value()})
          end
        end
      )
    end
  end
end

-- give action
function ch_give(idname, player, choice)
  local user_id = vRP.getUserId(player)
  local my_name = GetPlayerName(source)
  if user_id ~= nil then
    -- get nearest player
    vRPclient.getNearestPlayer(
      player,
      {10},
      function(nplayer)
        if nplayer ~= nil then
          local nuser_id = vRP.getUserId(nplayer)
          local nuser_name = GetPlayerName(nplayer)
          if nuser_id ~= nil then
            -- prompt number
            vRP.prompt(
              player,
              lang.inventory.give.prompt({format_num(vRP.getInventoryItemAmount(user_id, idname))}),
              "",
              function(player, amount)
                local amount = parseInt(amount)
                -- weight check
                local new_weight = vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(idname) * amount
                if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
                  local result = vRP.tryGetInventoryItem(user_id, idname, amount, true, false, true)
                  if result then
                    if type(result) == "table" and result.type and result.content then
                      vRP.giveInventoryItem(nuser_id, idname, amount, result, true, false, true)
                    else
                      vRP.giveInventoryItem(nuser_id, idname, amount, true, false, true)
                    end

                    vRP.basicLog("logs/sendItem.txt", user_id .. " to " .. nuser_id .. " | " .. idname .. " | " .. amount)
                    if idname == "benzoyl" then
                      names = "🌿 벤조일"
                    elseif idname == "seeds" then
                      names = "🌾 대마씨"
                    elseif idname == "seeds" then
                      names = "🌾 대마씨"
                    elseif idname == "harness" then
                      ---------------------------------------------------------------------
                      names = "🍁 LSD 원료"
                    elseif idname == "AK47" then
                      names = "📦 AK47 부품"
                    elseif idname == "M4A1" then
                      names = "📦 M4A1 부품"
                    elseif idname == "credit" then
                      names = "💳 훔친 신용카드"
                    elseif idname == "casino_token" then
                      names = "🏮 (구형)카지노 칩"
                    elseif idname == "real_chip" then
                      names = "🏮 (구)카지노 칩"
                    elseif idname == "real_chipc" then
                      names = "🏮 카지노 칩"
                    elseif idname == "bank_money" then
                      names = "💵 포장된 현금"
                    elseif idname == "trash" then
                      names = "🍪 쓰레기"
                    elseif idname == "fake_id" then
                      names = "🎫 해킹 아이디"
                    elseif idname == "police_report" then
                      names = "📝 경찰 보고서"
                    elseif idname == "ems_report" then
                      names = "📝 의료국 보고서"
                    elseif idname == "cargo" then
                      ---------------------------------------------------------------------
                      names = "📦 수송물품"
                    elseif idname == "key_lspd" then
                      names = "🔑 LSPD 경찰서 키"
                    elseif idname == "key_lspd_boss" then
                      names = "🔑 LSPD 경찰서 룸 키"
                    elseif idname == "key_lsmc" then
                      names = "🔑 병원 키"
                    elseif idname == "key_casino_main" then
                      names = "🔑 카지노 키"
                    elseif idname == "key_prison_out" then
                      names = "🔑 교도소 입구 키"
                    elseif idname == "key_prison_in" then
                      names = "🔑 교도소 내부 키"
                    elseif idname == "key_chsr" then
                      names = "🔑 신전입구 룸 키"
                    elseif idname == "key_sb_room" then
                      names = "🔑 비밀요새 룸 키"
                    elseif idname == "key_sb_inside" then
                      names = "🔑 비밀요새 통로 키"
                    elseif idname == "key_shh_house" then
                      names = "🔑 흑사회 저택 키"
                    elseif idname == "key_mafia_house" then
                      names = "🔑 백사회 저택 키"
                    elseif idname == "key_gm_house" then
                      names = "🔑 에르지오 저택 키"
                    elseif idname == "key_newbie_main" then
                      names = "🔑 뉴비지원센터 키"
                    elseif idname == "key_tow_main" then
                      names = "🔑 리얼다이소 키"
                    elseif idname == "key_tow_room" then
                      names = "🔑 리얼다이소 대표실 키"
                    elseif idname == "key_drug_factory" then
                      ---------------------------------------------------------------------
                      names = "🔑 닭공장 키"
                    elseif idname == "Medical Weed" then
                      names = "🍃 의료용 대마"
                    elseif idname == "picareta" then
                      names = "⛏ 1회용 곡괭이"
                    elseif idname == "leather" then
                      names = "🐊 코끼리 가죽"
                    elseif idname == "ljmadeira" then
                      ---------------------------------------------------------------------
                      names = "🌱 장작"
                    elseif idname == "jtj1" then
                      names = "🌊 깨끗한 물"
                    elseif idname == "jtj2" then
                      names = "🍃 통마늘"
                    elseif idname == "jtj3" then
                      names = "🎑 튼튼한 짚"
                    elseif idname == "jtj4" then
                      names = "🏐 플라스틱"
                    elseif idname == "jtj5" then
                      names = "💉 진통 약물"
                    elseif idname == "jtj6" then
                      names = "🏺 응고된 가루"
                    elseif idname == "jtj7" then
                      names = "💊 시험용 진통제"
                    elseif idname == "jtj8" then
                      names = "💊 포장된 진통제"
                    elseif idname == "jtjc" then
                      names = "💊 진통제"
                    elseif idname == "hd1" then
                      names = "🍆 가지"
                    elseif idname == "hd2" then
                      names = "🍋 레몬"
                    elseif idname == "hd3" then
                      ---------------------------------------------------------------------
                      names = "🍎 사과"
                    elseif idname == "c4_box1" then
                      names = "📦 화약상자"
                    elseif idname == "c4_box2" then
                      names = "📦 C4 완성상자"
                    elseif idname == "e_bs" then
                      names = "💎 에메랄드"
                    elseif idname == "s_bs" then
                      names = "💎 사파이어"
                    elseif idname == "r_bs" then
                      names = "💎 루비"
                    elseif idname == "d_bs" then
                      names = "💎 다이아몬드"
                    elseif idname == "explosivo_c4" then
                      ---------------------------------------------------------------------
                      names = "💣 C4 폭발장치"
                    elseif idname == "ks1" then
                      names = "🔧 가공된 유리"
                    elseif idname == "ks2" then
                      names = "🔧 가공된 철근"
                    elseif idname == "ks3" then
                      names = "🔧 금속탐지샘플"
                    elseif idname == "sk1" then
                      names = "🔧 수리용 뺀찌"
                    elseif idname == "sk2" then
                      names = "🔧 수리도구함"
                    elseif idname == "sk3" then
                      names = "🔧 낡은 수리도구 세트"
                    elseif idname == "fl1" then
                      names = "🔧 라이트 헤더"
                    elseif idname == "fl2" then
                      names = "🔧 라이트 손잡이"
                    elseif idname == "fl3" then
                      names = "🔧 후레쉬 샘플"
                    elseif idname == "metaldetector" then
                      ---------------------------------------------------------------------
                      names = "📡 금속 탐지기"
                    elseif idname == "zombie_ear" then
                      names = "👂 좀비귀"
                    elseif idname == "zombie_arm" then
                      names = "💪 좀비팔"
                    elseif idname == "zombie_head" then
                      names = "💀 좀비머리"
                    elseif idname == "zombie_leg" then
                      names = "🍤 좀비다리"
                    elseif idname == "zombie_medkit" then
                      ---------------------------------------------------------------------
                      names = "🎃 좀비해독제"
                    elseif idname == "anti_market_item1" then
                      names = "💀 GRANADE샷건"
                    elseif idname == "anti_market_item2" then
                      names = "💀 컴뱃 MG 총알 10발"
                    elseif idname == "anti_market_item3" then
                      names = "💀 피스톨.50 총알 10발"
                    elseif idname == "anti_market_item4" then
                      names = "💀 GRANADE샷건 총알 10발"
                    elseif idname == "anti_market_item5" then
                      names = "💀 어썰트샷건 총알 10발"
                    elseif idname == "anti_market_item6" then
                      names = "💀 펌프샷건 총알 10발"
                    elseif idname == "anti_market_item7" then
                      names = "💀 Hunter 칭호"
                    elseif idname == "anti_market_item8" then
                      names = "💀 Undead 칭호"
                    elseif idname == "anti_market_item9" then
                      ---------------------------------------------------------------------
                      names = "💀 Pandemic 칭호"
                    elseif idname == "medkit" then
                      names = "💟 의료 도구"
                    elseif idname == "dirty_money" then
                      names = "💸 검은 돈"
                    elseif idname == "parcels" then
                      names = "📦 택배 소포"
                    elseif idname == "repairkit" then
                      names = "🔧 수리 도구"
                    elseif idname == "tunerchip" then
                      names = "🔧 튜닝 도구"
                    elseif idname == "driver" then
                      names = "🎫 운전면허증"
                    elseif idname == "body_armor" then
                      ---------------------------------------------------------------------
                      names = "👔 방탄복"
                    elseif idname == "aivehiclekit_basic" then
                      names = "💚 인공지능키트 기본"
                    elseif idname == "aivehiclekit_adv" then
                      names = "💜 인공지능키트 고급"
                    elseif idname == "aivehiclekit_vip" then
                      ---------------------------------------------------------------------
                      names = "💛 인공지능키트 VIP"
                    elseif idname == "supressor" then
                      names = "🔫 소음기[무기파츠]"
                    elseif idname == "flash" then
                      names = "🔫 후레쉬[무기파츠]"
                    elseif idname == "yusuf" then
                      names = "🔫 스폐셜 스킨[무기파츠]"
                    elseif idname == "grip" then
                      names = "🔫 손잡이[무기파츠]"
                    elseif idname == "holografik" then
                      names = "🔫 홀로그램 스코프[무기파츠]"
                    elseif idname == "powiekszonymagazynek" then
                      ---------------------------------------------------------------------
                      names = "🔫 확장탄창[무기파츠]"
                    elseif idname == "ak47_1" then
                      names = "📦 어썰트 라이플 MK2 조립상자"
                    elseif idname == "ak47_2" then
                      names = "📦 어썰트 라이플 MK2 부품상자"
                    elseif idname == "ak47_3" then
                      names = "📦 어썰트 라이플 MK2 완성상자"
                    elseif idname == "shotgun_1" then
                      names = "📦 펌프 샷건 MK2 조립상자"
                    elseif idname == "shotgun_2" then
                      names = "📦 펌프 샷건 MK2 부품상자"
                    elseif idname == "shotgun_3" then
                      names = "📦 펌프 샷건 MK2 완성상자"
                    elseif idname == "smg_1" then
                      names = "📦 SMG MK2 조립상자"
                    elseif idname == "smg_2" then
                      names = "📦 SMG MK2 부품상자"
                    elseif idname == "smg_3" then
                      names = "📦 SMG MK2 완성상자"
                    elseif idname == "smg_mk2_t" then
                      names = "📦 SMG MK2 탄약상자"
                    elseif idname == "ak47_mk2_t" then
                      names = "📦 어썰트 라이플 MK2 탄약상자"
                    elseif idname == "shotgun_mk2_t" then
                      ---------------------------------------------------------------------
                      names = "📦 펌프 샷건 MK2 탄약상자"
                    elseif idname == "aw2" then
                      names = "체포 영장"
                    elseif idname == "aw1" then
                      names = "구속 영장"
                    elseif idname == "aw3" then
                      names = "수색 영장"
                    elseif idname == "aw4" then
                      ---------------------------------------------------------------------
                      names = "수배 영장"
                    elseif idname == "elysiumid1" then
                      names = "공무원증"
                    elseif idname == "elysiumid2" then
                      names = "경찰공무원증"
                    elseif idname == "elysiumid3" then
                      ---------------------------------------------------------------------
                      names = " EMS공무원증"
                    elseif idname == "taxisnt" then
                      names = "🎫 개인택시 자격증(1회성)"
                    elseif idname == "hd5" then
                      names = "💊시험용 해독제"
                    elseif idname == "ksrandom" then
                      names = "🎫 희미한 티켓"
                    elseif idname == "ouro" then
                      names = "🗿 알수없는 돌"
                    elseif idname == "stone" then
                      names = "🗿 망가진 돌 조각"
                    elseif idname == "silver1" then
                      names = "⚪ 은광석"
                    elseif idname == "golden1" then
                      names = "🔮 금광석"
                    elseif idname == "diamond1" then
                      names = "💎 다이아몬드 광석"
                    elseif idname == "skateboard_ticket" then
                      names = "🌠 스케이트보드 이용권"
                    elseif idname == "randommoney" then
                      ---------------------------------------------------------------------
                      names = "와사비망고의 토사물"
                    elseif idname == "testtest" then
                      names = "🍷 돔 페리뇽 로제"
                    elseif idname == "sighmirnoff" then
                      names = "🍷 스미노프"
                    elseif idname == "adb" then
                      names = "🍷 아르망 드 브리냑"
                    elseif idname == "weed" then
                      names = "🍂 대마초"
                    elseif idname == "lsd" then
                      names = "💫 LSD"
                    elseif idname == "cocaine" then
                      names = "💫 코카인"
                    elseif idname == "armand" then
                      names = "🍹 아르망 드 브리냑"
                    elseif idname == "dom" then
                      names = "🍸 돔 페리뇽"
                    elseif idname == "absol" then
                      names = "🍷 앱솔루트 보드카"
                    elseif idname == "water" then
                      names = "🌊 생수"
                    elseif idname == "milk" then
                      names = "🍶 우유"
                    elseif idname == "coffee" then
                      names = "☕ 커피"
                    elseif idname == "tea" then
                      names = "🍵 홍차"
                    elseif idname == "icetea" then
                      names = "🍹 아이스티"
                    elseif idname == "orangejuice" then
                      names = "🍹 오렌지 주스"
                    elseif idname == "cocacola" then
                      names = "🎒 코카-콜라"
                    elseif idname == "redbull" then
                      names = "🍷 레드불"
                    elseif idname == "lemonade" then
                      names = "🍹 레몬에이드"
                    elseif idname == "vodka" then
                      names = "🍷 보드카"
                    elseif idname == "elixir" then
                      names = "🎆 파워 엘릭서"
                    elseif idname == "kanari" then
                      names = "🍶 까나리 액젓"
                    elseif idname == "meat" then
                      names = "🍖 코끼리 고기"
                    elseif idname == "bread" then
                      names = "🍞 빵"
                    elseif idname == "donut" then
                      names = "🍪 도넛"
                    elseif idname == "icecream" then
                      names = "🍧 메로나"
                    elseif idname == "ramen" then
                      names = "🍜 신라면"
                    elseif idname == "tacos" then
                      names = "🍡 타코벨"
                    elseif idname == "sandwich" then
                      names = "🎂 샌드위치"
                    elseif idname == "kebab" then
                      names = "🍚 케밥"
                    elseif idname == "pdonut" then
                      names = "🍩 고급 도넛"
                    elseif idname == "tofu" then
                      names = "👝 두부"
                    elseif idname == "pizza" then
                      names = "🍕 피자"
                    elseif idname == "catfish" then
                      names = "🐡 메기"
                    elseif idname == "bass" then
                      names = "🐟 베스"
                    elseif idname == "pills" then
                      names = "💊 (구)진통제"
                    elseif idname == "newbie_box" then
                      names = "♎ 뉴비지원상자"
                    elseif idname == "bonus_box" then
                      names = "🅱 보너스상자"
                    elseif idname == "lottery_ticket_basic" then
                      names = "📗 매일 추첨티켓"
                    elseif idname == "lottery_ticket_advanced" then
                      names = "📘 고급 추첨티켓"
                    elseif idname == "lottery_ticket_vip" then
                      names = "📒 VIP 추첨티켓"
                    elseif idname == "gift_box" then
                      names = "🎁 리얼박스"
                    elseif idname == "cash" then
                      ---------------------------------------------------------------------
                      names = "현금"
                    elseif idname == "wbody|WEAPON_BOTTLE" then
                      names = "🔪 병"
                    elseif idname == "wbody|WEAPON_KNUCKLE" then
                      names = "🔪 너클 더스터"
                    elseif idname == "wbody|WEAPON_KNIFE" then
                      names = "🔪 나이프"
                    elseif idname == "wbody|WEAPON_HAMMER" then
                      names = "🔪 망치"
                    elseif idname == "wbody|WEAPON_HATCHET" then
                      names = "🔪 손도끼"
                    elseif idname == "wbody|WEAPON_CROWBAR" then
                      names = "🔪 쇠 지렛대"
                    elseif idname == "wbody|WEAPON_GOLFCLUB" then
                      names = "🔪 골프채"
                    elseif idname == "wbody|WEAPON_BAT" then
                      names = "🔪 아구방망이"
                    elseif idname == "wbody|WEAPON_FLASHLIGHT" then
                      names = "🔪 손전등"
                    elseif idname == "wbody|WEAPON_NIGHTSTICK" then
                      names = "🔪 야경봉"
                    elseif idname == "wbody|WEAPON_SWITCHBLADE" then
                      names = "🔪 스위치 블레이드"
                    elseif idname == "wbody|WEAPON_DAGGER" then
                      names = "🔪 고전적 기사 단검"
                    elseif idname == "wbody|WEAPON_MACHETTE_LRX_YELLOW" then
                      names = "🔪 후원무기"
                    elseif idname == "wbody|WEAPON_HATCHEATX" then
                      names = "🔪 광선검 레드 [후원무기]"
                    elseif idname == "wbody|WEAPON_MACHETTE_LR_RED" then
                      names = "🔪 광선검 옐로우 [후원무기]"
                    elseif idname == "wbody|WEAPON_PETROLCAN" then
                      names = "💣 기름통"
                    elseif idname == "wbody|WEAPON_SNOWBALL" then
                      names = "💣 눈"
                    elseif idname == "wbody|WEAPON_FLARE" then
                      names = "💣 신호탄"
                    elseif idname == "wbody|WEAPON_PROXMINE" then
                      names = "⛔ 근접지뢰"
                    elseif idname == "wbody|WEAPON_FIREWORK" then
                      names = "⛔ 폭죽런쳐"
                    elseif idname == "wbody|WEAPON_STICKYBOMB" then
                      names = "⛔ 부착지뢰"
                    elseif idname == "wbody|WEAPON_RPG" then
                      names = "⛔ RPG-9"
                    elseif idname == "wbody|WEAPON_MUSKET" then
                      names = "⛔ 규칙위반 머스킷"
                    elseif idname == "wbody|WEAPON_STUNGUN" then
                      names = "🔫 스턴건"
                    elseif idname == "wbody|WEAPON_SNSPISTOL" then
                      names = "🔫 SNS 피스톨"
                    elseif idname == "wbody|WEAPON_CARBINERIFLE" then
                      names = "🔫 카빈 소총"
                    elseif idname == "wbody|WEAPON_ASSAULTSHOTGUN" then
                      names = "🔫 어썰트 샷건"
                    elseif idname == "wbody|WEAPON_ASSAULTRIFLE" then
                      names = "🔫 AK47"
                    elseif idname == "wbody|WEAPON_COMPACTRIFLE" then
                      names = "🔫 마이크로 SMG"
                    elseif idname == "wbody|WEAPON_APPISTOL" then
                      names = "🔫 AP피스톨"
                    elseif idname == "wbody|WEAPON_PUMPSHOTGUN" then
                      names = "🔫 펌프샷건"
                    elseif idname == "wbody|WEAPON_SAWNOFFSHOTGUN" then
                      names = "🔫 소드오프 샷건"
                    elseif idname == "wbody|WEAPON_FLAREGUN" then
                      names = "🔫 신호탄 총"
                    elseif idname == "wbody|WEAPON_STUNGUN" then
                      names = "🔫 스턴건"
                    elseif idname == "wbody|WEAPON_COMBATPISTOL" then
                      names = "🔫 컴뱃 피스톨"
                    elseif idname == "wbody|WEAPON_SNIPERRIFLE" then
                      names = "🔫 스나이퍼"
                    elseif idname == "wbody|WEAPON_SPECIALCARBINE" then
                      names = "🔫 특별 카빈소총"
                    elseif idname == "wbody|WEAPON_COMBATMG" then
                      names = "🔫 컴뱃 MG"
                    elseif idname == "wbody|WEAPON_ADVANCEDRIFLE" then
                      names = "🔫 차세대 라이플"
                    elseif idname == "wbody|WEAPON_PISTOL" then
                      names = "🔫 피스톨"
                    elseif idname == "wbody|WEAPON_MICROSMG" then
                      names = "🔫 마이크로 SMG"
                    elseif idname == "wbody|WEAPON_SMG_MK2" then
                      names = "🔫 SMG MK2"
                    elseif idname == "wbody|WEAPON_ASSAULTRIFLE_MK2" then
                      names = "🔫 어썰트 라이플 MK2"
                    elseif idname == "wbody|WEAPON_PUMPSHOTGUN_MK2" then
                      names = "🔫 펌프샷건 MK2"
                    elseif idname == "wbody|WEAPON_CARBINERIFLE_MK2" then
                      ---------------------------------------------------------------------
                      names = "🔫 카빈소총 MK2"
                    elseif idname == "wammo|WEAPON_PETROLCAN" then
                      names = "💣 기름통 탄약"
                    elseif idname == "wammo|WEAPON_SNOWBALL" then
                      names = "💣 눈 탄약"
                    elseif idname == "wammo|WEAPON_FLARE" then
                      names = "💣 신호탄 탄약"
                    elseif idname == "wammo|WEAPON_PROXMINE" then
                      names = "⛔ 근접지뢰 탄약"
                    elseif idname == "wammo|WEAPON_FIREWORK" then
                      names = "⛔ 폭죽런쳐 탄약"
                    elseif idname == "wammo|WEAPON_STICKYBOMB" then
                      names = "⛔ 부착지뢰 탄약"
                    elseif idname == "wammo|WEAPON_RPG" then
                      names = "⛔ RPG-9 탄약"
                    elseif idname == "wammo|WEAPON_MUSKET" then
                      names = "⛔ 규칙위반 머스킷 탄약"
                    elseif idname == "wammo|WEAPON_SNSPISTOL" then
                      names = "🌑 SNS 피스톨 탄약"
                    elseif idname == "wammo|WEAPON_CARBINERIFLE" then
                      names = "🌑 카빈 소총 탄약"
                    elseif idname == "wammo|WEAPON_ASSAULTSHOTGUN" then
                      names = "🌑 어썰트 샷건 탄약"
                    elseif idname == "wammo|WEAPON_ASSAULTRIFLE" then
                      names = "🌑 AK47 탄약"
                    elseif idname == "wammo|WEAPON_COMPACTRIFLE" then
                      names = "🌑 마이크로 SMG 탄약"
                    elseif idname == "wammo|WEAPON_APPISTOL" then
                      names = "🌑 AP피스톨 탄약"
                    elseif idname == "wammo|WEAPON_PUMPSHOTGUN" then
                      names = "🌑 펌프샷건 탄약"
                    elseif idname == "wammo|WEAPON_SAWNOFFSHOTGUN" then
                      names = "🌑 소드오프 샷건 탄약"
                    elseif idname == "wammo|WEAPON_FLAREGUN" then
                      names = "🌑 신호탄 총 탄약"
                    elseif idname == "wammo|WEAPON_STUNGUN" then
                      names = "🌑 스턴건 탄약"
                    elseif idname == "wammo|WEAPON_COMBATPISTOL" then
                      names = "🌑 컴뱃 피스톨 탄약"
                    elseif idname == "wammo|WEAPON_SNIPERRIFLE" then
                      names = "🌑 스나이퍼 탄약"
                    elseif idname == "wammo|WEAPON_SPECIALCARBINE" then
                      names = "🌑 특별 카빈소총 탄약"
                    elseif idname == "wammo|WEAPON_COMBATMG" then
                      names = "🌑 컴뱃 MG 탄약"
                    elseif idname == "wammo|WEAPON_ADVANCEDRIFLE" then
                      names = "🌑 차세대 라이플 탄약"
                    elseif idname == "wammo|WEAPON_PISTOL" then
                      names = "🌑 피스톨 탄약"
                    elseif idname == "wammo|WEAPON_MICROSMG" then
                      names = "🌑 마이크로 SMG 탄약"
                    elseif idname == "wammo|WEAPON_SMG_MK2" then
                      names = "🌑 SMG MK2 탄약"
                    elseif idname == "wammo|WEAPON_ASSAULTRIFLE_MK2" then
                      names = "🌑 어썰트 라이플 MK2 탄약"
                    elseif idname == "wammo|WEAPON_PUMPSHOTGUN_MK2" then
                      names = "🌑 펌프샷건 MK2 탄약"
                    elseif idname == "wammo|WEAPON_CARBINERIFLE_MK2" then
                      ---------------------------------------------------------------------
                      names = "🌑 카빈소총 MK2 탄약"
                    elseif idname == "titlebox_basic1" then
                      names = "💿 굳건한 칭호"
                    elseif idname == "titlebox_basic2" then
                      names = "💿 든든한 칭호"
                    elseif idname == "titlebox_basic3" then
                      names = "💿 따스한 칭호"
                    elseif idname == "titlebox_basic4" then
                      names = "💿 아름다운 칭호"
                    elseif idname == "titlebox_basic5" then
                      names = "💿 향기로운 칭호"
                    elseif idname == "titlebox_basic6" then
                      names = "💿 깔끔한 칭호"
                    elseif idname == "titlebox_basic7" then
                      names = "💿 더러운 칭호"
                    elseif idname == "titlebox_basic8" then
                      names = "💿 웅장한 칭호"
                    elseif idname == "titlebox_basic9" then
                      names = "💿 거대한 칭호"
                    elseif idname == "titlebox_basic10" then
                      names = "💿 날렵한 칭호"
                    elseif idname == "titlebox_basic11" then
                      names = "💿 의리하면 칭호"
                    elseif idname == "titlebox_basic12" then
                      names = "💿 잘생긴 칭호"
                    elseif idname == "titlebox_advanced1" then
                      names = "🍀 거인 칭호"
                    elseif idname == "titlebox_advanced2" then
                      names = "🍀 귀요미 칭호"
                    elseif idname == "titlebox_advanced3" then
                      names = "🍀 현자 칭호"
                    elseif idname == "titlebox_advanced4" then
                      names = "🍀 마법사 칭호"
                    elseif idname == "titlebox_advanced5" then
                      names = "🍀 전사 칭호"
                    elseif idname == "titlebox_advanced6" then
                      names = "🍀 궁수 칭호"
                    elseif idname == "titlebox_advanced7" then
                      names = "🍀 도적 칭호"
                    elseif idname == "titlebox_advanced8" then
                      names = "🍀 힐러 칭호"
                    elseif idname == "titlebox_advanced9" then
                      names = "🍀 보안관 칭호"
                    elseif idname == "titlebox_advanced10" then
                      names = "🍀 I'm 칭호"
                    elseif idname == "titlebox_rare1" then
                      names = "🔆 미인 칭호"
                    elseif idname == "titlebox_rare2" then
                      names = "🔆 선녀 칭호"
                    elseif idname == "titlebox_rare3" then
                      names = "🔆 초절정 칭호"
                    elseif idname == "titlebox_rare4" then
                      names = "🔆 전설적인 칭호"
                    elseif idname == "titlebox_rare5" then
                      names = "🔆 소문의주인공 칭호"
                    elseif idname == "titlebox_rare6" then
                      names = "🔆 고인물 칭호"
                    elseif idname == "titlebox_unique1" then
                      names = "💮 진(眞)칭호"
                    elseif idname == "titlebox_unique2" then
                      names = "💮 용(龍)칭호"
                    elseif idname == "titlebox_unique3" then
                      names = "💮 화(花)칭호"
                    elseif idname == "titlebox_unique4" then
                      names = "💮 신(神)칭호"
                    elseif idname == "titlebox_god1" then
                      names = "🔰 대장 칭호"
                    elseif idname == "titlebox_god2" then
                      names = "🎇 천사 칭호"
                    elseif idname == "titlebox_god3" then
                      names = "🎆 악마 칭호"
                    elseif idname == "titlebox_god4" then
                      names = "🌞 창조주 칭호"
                    elseif idname == "titlebox_zombie1" then
                      names = "💀 Hunter 칭호"
                    elseif idname == "titlebox_zombie2" then
                      names = "💀 Undead 칭호"
                    elseif idname == "titlebox_zombie3" then
                      names = "💀 Pandemic 칭호"
                    elseif idname == "titlebox_random" then
                      names = "🔯 이벤트박스"
                    elseif idname == "eventitem_event1_ticket1" then
                      names = "🔖 문상교환권(천원권)"
                    elseif idname == "eventitem_event1_ticket2" then
                      names = "🔖 문상교환권(오천원권)"
                    elseif idname == "eventitem_event1_ticket3" then
                      names = "🎫 문상교환권(만원권)"
                    elseif idname == "eventitem_event1_ticket4" then
                      names = "🎫 문상교환권(오만원권)"
                    elseif idname == "eventitem_event1_ticket5" then
                      names = "🔥 문상교환권(십만원권)"
                    elseif idname == "eventitem_event1_ticket6" then
                      -------------------------------------------
                      names = "🔥 문상교환권(오십만원권)"
                    elseif idname == "titlebox_supporter1" then
                      names = "🔥 '레드'칭호"
                    elseif idname == "titlebox_supporter2" then
                      names = "🔥 '에이스'칭호"
                    elseif idname == "titlebox_supporter3" then
                      names = "🔥 '로얄'칭호"
                    elseif idname == "titlebox_supporter4" then
                      names = "🔥 '노블레스'칭호"
                    elseif idname == "titlebox_supporter5" then
                      names = "🔥 '퍼스트'칭호"
                    elseif idname == "titlebox_supporter6" then
                      -------------------------------------------
                      names = "🔥 '퍼스트프라임'칭호"
                    elseif idname == "hw_01" then
                      names = "🎫 레드 등급업 티켓"
                    elseif idname == "hw_02" then
                      names = "🎫 에이스 등급업 티켓"
                    elseif idname == "hw_03" then
                      names = "🎫 로얄 등급업 티켓"
                    elseif idname == "hw_04" then
                      names = "🎫 노블레스 등급업 티켓"
                    elseif idname == "hw_05" then
                      names = "🎫 퍼스트 등급업 티켓"
                    elseif idname == "hw_06" then
                      -------------------------------------------
                      names = "🎫 퍼스트프라임 등급업 티켓"
                    elseif idname == "titlebox_random" then
                      names = "🉐 랜덤칭호상자"
                    elseif idname == "titlebox_return" then
                      names = "🔲 칭호해제키트"
                    else
                      names = ""
                    end
                    sendToDiscord_item(65280, "아이템 전달 보고서", "보내는 사람 : " .. my_name .. "(" .. user_id .. "번)\n\n받는 사람 : " .. nuser_name .. "(" .. nuser_id .. "번)\n\n보낸 아이템 : " .. names .. "\n\n보낸 갯수 : " .. comma_value(amount) .. "개", os.date("전달일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
                    vRPclient.playAnim(player, {true, {{"mp_common", "givetake1_a", 1}}, false})
                    vRPclient.playAnim(nplayer, {true, {{"mp_common", "givetake2_a", 1}}, false})
                  else
                    vRPclient.notify(player, {lang.common.invalid_value()})
                  end
                else
                  vRPclient.notify(player, {lang.inventory.full()})
                end
              end
            )
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        else
          vRPclient.notify(player, {lang.common.no_player_near()})
        end
      end
    )
  end
end

function sendToDiscord_item(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/689108977921163304/JX3rZgOdIs8qQYsfzOA7KEsgK4_J8M8ZqHZRBM-5yxTWHkZAxI1Pvg2kJoZmLsr9sQCi",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

-- trash action
function ch_trash(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- prompt number
    vRP.prompt(
      player,
      lang.inventory.trash.prompt({format_num(vRP.getInventoryItemAmount(user_id, idname))}),
      "",
      function(player, amount)
        local amount = parseInt(amount)
        if vRP.tryGetInventoryItem(user_id, idname, amount, false) then
          vRPclient.notify(player, {lang.inventory.trash.done({vRP.getItemName(idname), format_num(amount)})})
          TriggerClientEvent("DropSystem:drop", player, idname, amount)
          vRPclient.playAnim(player, {true, {{"pickup_object", "pickup_low", 1}}, false})
        else
          vRPclient.notify(player, {lang.common.invalid_value()})
        end
      end
    )
  end
end

function vRP.computeItemName(item, args)
  if type(item.name) == "string" then
    return item.name
  else
    return item.name(args)
  end
end

function vRP.computeItemDescription(item, args)
  if type(item.description) == "string" then
    return item.description
  else
    return item.description(args)
  end
end

function vRP.computeItemChoices(item, args)
  if item.choices ~= nil then
    return item.choices(args)
  else
    return {}
  end
end

function vRP.computeItemWeight(item, args)
  if type(item.weight) == "number" then
    return item.weight
  else
    return item.weight(args)
  end
end

function vRP.parseItem(idname)
  return splitString(idname, "|")
end

-- return name, description, weight
function vRP.getItemDefinition(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemName(item, args), vRP.computeItemDescription(item, args), vRP.computeItemWeight(item, args), item.dataType
  end

  return nil, nil, nil
end

function vRP.getItemName(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemName(item, args)
  end
  return args[1]
end

function vRP.getItemDescription(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemDescription(item, args)
  end
  return ""
end

function vRP.getItemChoices(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  local choices = {}
  if item ~= nil then
    -- compute choices
    local cchoices = vRP.computeItemChoices(item, args)
    if cchoices then -- copy computed choices
      for k, v in pairs(cchoices) do
        choices[k] = v
      end
    end

    -- add give/trash choices
    choices[lang.inventory.give.title()] = {
      function(player, choice)
        ch_give(idname, player, choice)
      end,
      lang.inventory.give.description()
    }
    choices[lang.inventory.trash.title()] = {
      function(player, choice)
        ch_trash(idname, player, choice)
      end,
      lang.inventory.trash.description()
    }
  end

  return choices
end

function vRP.getItemWeight(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemWeight(item, args)
  end
  return 0
end

-- compute weight of a list of items (in inventory/chest format)
function vRP.computeItemsWeight(items)
  local weight = 0

  for k, v in pairs(items) do
    local iweight = vRP.getItemWeight(k)
    weight = weight + iweight * v.amount
  end

  return weight
end

function vRP.getDataitemId(data, u_str, cbr)
  local task = Task(cbr)
  MySQL.query(
    "vRP/get_dataitem_id",
    {data = json.encode(data), u_str = u_str},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].id})
      else
        task({0})
      end
    end
  )
end

-- add item to a connected user inventory
function vRP.giveInventoryItem(user_id, idname, amount, itemData, notify, isSync, noLog)
  local isItemData = false
  if type(itemData) == "table" then
    isItemData = true
  else
    noLog = isSync
    isSync = notify
    notify = itemData
  end
  if notify == nil then
    notify = true
  end
  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    local newAmount = 0
    if entry then
      entry.amount = entry.amount + amount
      newAmount = entry.amount
    else
      if isItemData then
        data.inventory[idname] = {amount = amount, type = itemData.type, content = itemData.content}
      else
        data.inventory[idname] = {amount = amount}
      end
      newAmount = amount
    end

    if idname == "cash" and isSync ~= true then
      vRP.setMoney(user_id, newAmount)
    end

    if idname == "credit" and isSync ~= true then
      vRP.setCredit(user_id, newAmount)
    end

    if not noLog then
      vRP.basicLog("logs/giveInventoryItem.txt", user_id .. " | " .. idname .. " | " .. amount)
    end

    if notify then
      local player = vRP.getUserSource(user_id)
      if player ~= nil then
        vRPclient.notify(player, {lang.inventory.give.received({vRP.getItemName(idname), format_num(amount)})})
      end
    end
  end
end

function vRP.CheckInventoryItem(user_id, idname, amount, msg)
  if msg == nil then
    msg = "아이템"
  end
  local player = vRP.getUserSource(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    if entry and entry.amount >= amount then -- add to entry
      if entry.amount <= 0 then
        data.inventory[idname] = nil
      end
      if player ~= nil then
        vRPclient.notify(player, {"~g~" .. msg .. "이(가) 확인되었습니다!"})
      end
      return true
    else
      if player ~= nil then
        local entry_amount = 0
        if entry then
          entry_amount = entry.amount
        end
        vRPclient.notify(player, {"~r~" .. msg .. "이(가) 없습니다!"})
      end
    end
  end
  return false
end

-- try to get item from a connected user inventory
function vRP.tryGetInventoryItem(user_id, idname, amount, notify, isSync, noLog)
  if notify == nil then
    notify = true
  end -- notify by default

  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    local newAmount = 0
    if entry and entry.amount >= amount then -- add to entry
      entry.amount = entry.amount - amount
      newAmount = entry.amount

      -- remove entry if <= 0
      if entry.amount <= 0 then
        data.inventory[idname] = nil
      end

      if idname == "cash" and isSync ~= true then
        vRP.setMoney(user_id, newAmount)
      end

      if idname == "credit" and isSync ~= true then
        vRP.setCredit(user_id, newAmount)
      end      

      if not noLog then
        vRP.basicLog("logs/tryGetInventoryItem.txt", user_id .. " | " .. idname .. " | " .. amount)
      end

      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          vRPclient.notify(player, {lang.inventory.give.given({vRP.getItemName(idname), format_num(amount)})})
        end
      end

      if entry.type and entry.content then
        return {type = entry.type, content = entry.content}
      end

      return true
    else
      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          local entry_amount = 0
          if entry then
            entry_amount = entry.amount
          end
          vRPclient.notify(player, {lang.inventory.missing({vRP.getItemName(idname), format_num(amount - entry_amount)})})
        end
      end
    end
  end

  return false
end

-- get user inventory amount of item
function vRP.getInventoryItemAmount(user_id, idname)
  local data = vRP.getUserDataTable(user_id)
  if data and data.inventory then
    local entry = data.inventory[idname]
    if entry then
      return entry.amount
    end
  end

  return 0
end

-- return user inventory total weight
function vRP.getInventoryWeight(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data and data.inventory then
    return vRP.computeItemsWeight(data.inventory)
  end

  return 0
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
  local weigh = math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength"))) * cfg.inventory_weight_per_strength
  if vRP.hasPermission(user_id, "admin.market") then
    weigh = weigh + tonumber(50000)
  end
  if vRP.hasPermission(user_id, "crownmember") then
    weigh = weigh + tonumber(1500)
  elseif vRP.hasPermission(user_id, "trinitymember") then
    weigh = weigh + tonumber(1300)
  elseif vRP.hasPermission(user_id, "firstfmember") then
    weigh = weigh + tonumber(1300)
  elseif vRP.hasPermission(user_id, "firstmember") then
    weigh = weigh + tonumber(1100)
  elseif vRP.hasPermission(user_id, "noblemember") then
    weigh = weigh + tonumber(900)
  elseif vRP.hasPermission(user_id, "royalmember") then
    weigh = weigh + tonumber(700)
  elseif vRP.hasPermission(user_id, "acemember") then
    weigh = weigh + tonumber(500)
  elseif vRP.hasPermission(user_id, "redmember") then
    weigh = weigh + tonumber(300)
  end
  return weigh
end

-- clear connected user inventory
function vRP.clearInventory(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.inventory = {}
  end
end

-- INVENTORY MENU

-- open player inventory
function vRP.openInventory(source)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data then
      -- build inventory menu
      local menudata = {name = lang.inventory.title(), css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}}
      -- add inventory info
      local weight = vRP.getInventoryWeight(user_id)
      local max_weight = vRP.getInventoryMaxWeight(user_id)
      local hue = math.floor(math.max(125 * (1 - weight / max_weight), 0))
      menudata['<div class="dprogressbar" data-value="' .. string.format("%.2f", weight / max_weight) .. '" data-color="hsl(' .. hue .. ',100%,50%)" data-bgcolor="hsl(' .. hue .. ',100%,25%)" style="height: 12px; border: 3px solid black;"></div>'] = {
        function()
        end,
        lang.inventory.info_weight({string.format("%.2f", weight), max_weight})
      }
      local kitems = {}

      -- choose callback, nested menu, create the item menu
      local choose = function(player, choice)
        if string.sub(choice, 1, 1) ~= "@" then -- ignore info choices
          local choices = vRP.getItemChoices(kitems[choice])
          -- build item menu
          local submenudata = {name = choice, css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}}

          -- add computed choices
          for k, v in pairs(choices) do
            submenudata[k] = v
          end

          -- nest menu
          submenudata.onclose = function()
            vRP.openInventory(source) -- reopen inventory when submenu closed
          end

          -- open menu
          vRP.openMenu(source, submenudata)
        end
      end

      -- add each item to the menu
      for k, v in pairs(data.inventory) do
        local name, description, weight = vRP.getItemDefinition(k)
        if name ~= nil then
          local contentInfoText = ""
          if v.type and v.content then
            if v.type == "skin" then
              contentInfoText = "스킨:"
              contentInfoText = contentInfoText .. "<br>" .. v.content[1]
            elseif v.type == "smaskbox" then
              contentInfoText = "마스크:"
              contentInfoText = contentInfoText .. "<br>" .. v.content[1]
            elseif v.type == "carbox" then
              contentInfoText = "차량:"
              contentInfoText = contentInfoText .. "<br>" .. v.content[1]
            elseif v.type == "itembox" then
              contentInfoText = "아이템:"
              for cindex, citem in pairs(v.content) do
                if cindex and citem then
                  local name2 = vRP.getItemDefinition(cindex)
                  if name2 ~= nil then
                    contentInfoText = contentInfoText .. "<br>" .. name2
                    if citem.amount then
                      contentInfoText = contentInfoText .. " " .. citem.amount .. "개"
                    end
                  end
                end
              end
            end
          end
          kitems[name] = k -- reference item by display name
          menudata[name] = {choose, lang.inventory.iteminfo({format_num(parseInt(v.amount)), description, string.format("%.2f", weight), contentInfoText})}
        end
      end

      -- open menu
      vRP.openMenu(source, menudata)
    end
  end
end

-- init inventory
AddEventHandler(
  "vRP:playerJoin",
  function(user_id, source, name, last_login)
    local data = vRP.getUserDataTable(user_id)
    if data.inventory == nil then
      data.inventory = {}
    end
  end
)

-- add open inventory to main menu
local choices = {}
choices[lang.inventory.title()] = {
  function(player, choice)
    vRP.openInventory(player)
  end,
  lang.inventory.description()
}

vRP.registerMenuBuilder(
  "main",
  function(add, data)
    add(choices)
  end
)

-- CHEST SYSTEM

local chests = {}

-- build a menu from a list of items and bind a callback(idname)
local function build_itemlist_menu(name, items, cb)
  local menu = {name = name, css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}}

  local kitems = {}

  -- choice callback
  local choose = function(player, choice)
    local idname = kitems[choice]
    if idname then
      cb(idname)
    end
  end

  -- add each item to the menu
  for k, v in pairs(items) do
    local name, description, weight = vRP.getItemDefinition(k)
    if name ~= nil then
      kitems[name] = k -- reference item by display name
      menu[name] = {choose, lang.inventory.iteminfo({format_num(parseInt(v.amount)), description, string.format("%.2f", weight)})}
    end
  end

  return menu
end

-- open a chest by name
-- cb_close(): called when the chest is closed (optional)
-- cb_in(idname, amount): called when an item is added (optional)
-- cb_out(idname, amount): called when an item is taken (optional)
function vRP.openChest(source, name, max_weight, cb_close, cb_in, cb_out, check_cb_in, check_cb_out)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data.inventory ~= nil then
      if not chests[name] then
        local close_count = 0 -- used to know when the chest is closed (unlocked)

        -- load chest
        local chest = {max_weight = max_weight, lastAccessTime = os.time()}
        chests[name] = chest
        vRP.getSData(
          "chest:" .. name,
          function(cdata)
            chest.items = json.decode(cdata) or {} -- load items

            -- open menu
            local menu = {
              name = lang.inventory.chest.title(),
              css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}
            }
            -- take
            local cb_take = function(idname)
              if name == nil or chests[name] == nil then
                vRPclient.notify(source, {"~r~일정시간이 초과되어 자동으로 닫혔습니다. 처음부터 다시시도해주세요."})
                return
              end
              chests[name].lastAccessTime = os.time()
              local citem = chest.items[idname]
              vRP.prompt(
                source,
                lang.inventory.chest.take.prompt({format_num(citem.amount)}),
                "",
                function(player, amount)
                  amount = parseInt(amount)
                  if amount >= 0 and amount <= citem.amount then
                    if check_cb_out and not check_cb_out(idname, amount) then
                      if cb_out then
                        cb_out(nil)
                      end
                      return
                    end
                    -- take item

                    -- weight check
                    local new_weight = vRP.getInventoryWeight(user_id) + vRP.getItemWeight(idname) * amount
                    if new_weight <= vRP.getInventoryMaxWeight(user_id) then
                      if citem.type and citem.content then
                        vRP.giveInventoryItem(user_id, idname, amount, citem, true)
                      else
                        vRP.giveInventoryItem(user_id, idname, amount, true)
                      end
                      citem.amount = citem.amount - amount

                      if citem.amount <= 0 then
                        chest.items[idname] = nil -- remove item entry
                      end

                      vRP.setSData("chest:" .. name, json.encode(chest.items))

                      if cb_out then
                        cb_out(idname, amount)
                      end

                      -- actualize by closing
                      vRP.closeMenu(player)
                    else
                      vRPclient.notify(source, {lang.inventory.full()})
                    end
                  else
                    vRPclient.notify(source, {lang.common.invalid_value()})
                  end
                end
              )
            end

            local ch_take = function(player, choice)
              if name == nil or chests[name] == nil then
                vRPclient.notify(source, {"~r~일정시간이 초과되어 자동으로 닫혔습니다. 처음부터 다시시도해주세요."})
                return
              end
              chests[name].lastAccessTime = os.time()
              local submenu = build_itemlist_menu(lang.inventory.chest.take.title(), chest.items, cb_take)
              -- add weight info
              local weight = vRP.computeItemsWeight(chest.items)
              local hue = math.floor(math.max(125 * (1 - weight / max_weight), 0))
              submenu['<div class="dprogressbar" data-value="' .. string.format("%.2f", weight / max_weight) .. '" data-color="hsl(' .. hue .. ',100%,50%)" data-bgcolor="hsl(' .. hue .. ',100%,25%)" style="height: 12px; border: 3px solid black;"></div>'] = {
                function()
                end,
                lang.inventory.info_weight({string.format("%.2f", weight), max_weight})
              }

              submenu.onclose = function()
                close_count = close_count - 1
                vRP.openMenu(player, menu)
              end
              close_count = close_count + 1
              vRP.openMenu(player, submenu)
            end

            -- put
            local cb_put = function(idname)
              if name == nil or chests[name] == nil then
                vRPclient.notify(source, {"~r~일정시간이 초과되어 자동으로 닫혔습니다. 처음부터 다시시도해주세요."})
                return
              end
              if idname == "cash" then
                vRPclient.notify(source, {"~r~해당 아이템은 이용할 수 없습니다."})
                return
              end
              chests[name].lastAccessTime = os.time()
              vRP.prompt(
                source,
                lang.inventory.chest.put.prompt({format_num(vRP.getInventoryItemAmount(user_id, idname))}),
                "",
                function(player, amount)
                  amount = parseInt(amount)

                  -- weight check
                  local new_weight = vRP.computeItemsWeight(chest.items) + vRP.getItemWeight(idname) * amount
                  if new_weight <= max_weight then
                    if check_cb_in and not check_cb_in(idname, amount) then
                      if cb_in then
                        cb_in(nil)
                      end
                      return
                    end

                    local result = vRP.tryGetInventoryItem(user_id, idname, amount, true)
                    if amount >= 0 and result then
                      local citem = chest.items[idname]
                      if citem ~= nil then
                        citem.amount = citem.amount + amount
                      else -- create item entry
                        chest.items[idname] = {amount = amount}
                        citem = chest.items[idname]
                      end

                      if type(result) == "table" and result.type and result.content then
                        citem.type = result.type
                        citem.content = result.content
                      end

                      vRP.setSData("chest:" .. name, json.encode(chest.items))

                      -- callback
                      if cb_in then
                        cb_in(idname, amount)
                      end

                      -- actualize by closing
                      vRP.closeMenu(player)
                    end
                  else
                    vRPclient.notify(source, {lang.inventory.chest.full()})
                  end
                end
              )
            end

            local ch_put = function(player, choice)
              if name == nil or chests[name] == nil then
                vRPclient.notify(source, {"~r~일정시간이 초과되어 자동으로 닫혔습니다. 처음부터 다시시도해주세요."})
                return
              end
              chests[name].lastAccessTime = os.time()
              local submenu = build_itemlist_menu(lang.inventory.chest.put.title(), data.inventory, cb_put)
              -- add weight info
              local weight = vRP.computeItemsWeight(data.inventory)
              local max_weight = vRP.getInventoryMaxWeight(user_id)
              local hue = math.floor(math.max(125 * (1 - weight / max_weight), 0))
              submenu['<div class="dprogressbar" data-value="' .. string.format("%.2f", weight / max_weight) .. '" data-color="hsl(' .. hue .. ',100%,50%)" data-bgcolor="hsl(' .. hue .. ',100%,25%)" style="height: 12px; border: 3px solid black;"></div>'] = {
                function()
                end,
                lang.inventory.info_weight({string.format("%.2f", weight), max_weight})
              }

              submenu.onclose = function()
                close_count = close_count - 1
                vRP.openMenu(player, menu)
              end
              close_count = close_count + 1
              vRP.openMenu(player, submenu)
            end

            -- choices
            menu[lang.inventory.chest.take.title()] = {ch_take}
            menu[lang.inventory.chest.put.title()] = {ch_put}

            menu.onclose = function()
              if close_count == 0 then
                vRP.setSData("chest:" .. name, json.encode(chest.items))
                chests[name] = nil
                if cb_close then
                  cb_close()
                end
              end
            end

            -- open menu
            vRP.openMenu(source, menu)
          end
        )
      else
        vRPclient.notify(source, {lang.inventory.chest.already_opened()})
      end
    end
  end
end

function vRP.log(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("[%Y/%m/%d] %H:%M:%S") .. " -> " .. info .. "#")
  end
  file:close()
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if (k == 0) then
      break
    end
  end
  return formatted
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(10000)
      for k, v in pairs(chests) do
        if v ~= nil and v.lastAccessTime < os.time() - 300 then
          vRP.setSData("chest:" .. k, json.encode(v.items))
          chests[k] = nil
        end
      end
    end
  end
)
