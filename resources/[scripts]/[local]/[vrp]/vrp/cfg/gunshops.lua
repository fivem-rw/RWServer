local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
  ["Paleto"] = {
    _config = {blipid = 110, blipcolor = 1},
    --["WEAPON_BOTTLE"] = {"병", 1500, 0, ""},
    --["WEAPON_BAT"] = {"야구방망이", 15000, 0, ""},
    --["WEAPON_KNUCKLE"] = {"너클 더스터", 20000, 0, ""},
    --["WEAPON_KNIFE"] = {"나이프", 30000, 0, ""},
    --["WEAPON_HAMMER"] = {"망치", 15000, 0, ""},
    --["WEAPON_HATCHET"] = {"손도끼", 28000, 0, ""},
    --["WEAPON_CROWBAR"] = {"쇠 지렛대", 7000, 0, ""},
    --["WEAPON_GOLFCLUB"] = {"골프채", 48000, 0, ""},
    --["WEAPON_SWITCHBLADE"] = {"스위치 블레이드", 35000, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"라이트", 100000, 0, ""}
    -- ["WEAPON_BOTTLE"] = {"병",1000,0,""},
    -- ["WEAPON_KNUCKLE"] = {"너클 더스터",10000,0,""},
    -- ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,2,""},
    -- ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,2,""},
    -- ["WEAPON_VINTAGEPISTOL"] = {"빈티지 피스톨",250000,2,""},
    -- ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨",500000,2,""},
    -- ["WEAPON_HEAVYPISTOL"] = {"헤비 피스톨",500000,2,""},
    -- ["WEAPON_APPISTOL"] = {"AP 피스톨",750000,2,""},
    -- ["WEAPON_DAGGER"] = {"고전적 기사 단검",10000,0,""},
    -- ["WEAPON_HAMMER"] = {"망치",5000,0,""},
    -- ["WEAPON_HATCHET"] = {"손도끼",10000,0,""},
    -- ["WEAPON_MICROSMG"] = {"마이크로 SMG",500000,5,""},
    -- ["WEAPON_SMG"] = {"SMG",500000,5,""},
    -- ["WEAPON_ASSAULTSMG"] = {"어썰트 SMG",550000,5,""},
    -- ["WEAPON_COMBATPDW"] = {"컴뱃 PDW",750000,5,""},
    -- ["WEAPON_MACHINEPISTOL"] = {"머신 Pistol",750000,5,""},
    -- ["WEAPON_CROWBAR"] = {"쇠 지렛대",7000,0,""},
    -- ["WEAPON_GOLFCLUB"] = {"골프채",3000,0,""},
    -- ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드",10000,0,""},
    -- ["WEAPON_MACHETE"] = {"마체테",15000,0,""},
    -- ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,5,""},
    -- ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,5,""},
    -- ["WEAPON_COMPACTRIFLE"] = {"마이크로 SMG",550000,10,""},
    -- ["WEAPON_ASSAULTRIFLE"] = {"어썰트 라이플",6500000,50,""},
    -- ["WEAPON_CARBINERIFLE"] = {"카빈 소총",6500000,50,""},
    -- ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    -- ["WEAPON_GUSENBERG"] = {"구젠버그 스위퍼",500000,5,""},
    -- ["WEAPON_MG"] = {"MG",10000000,75,""},
    -- ["WEAPON_COMBATMG"] = {"컴뱃 MG",15000000,100,""},
    -- ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,7,""},
    -- ["WEAPON_SNSPISTOL"] = {"피스톨",50000,7,""},
    -- ["WEAPON_MARKSMANRIFLE"] = {"마크스맨 라이플",10000000,100,""},
    -- ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플",20000000,75,""},
    -- ["WEAPON_BULLPUPRIFLE"] = {"불펍 라이플",5000000,45,""},
    -- ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플",6500000,50,""},
    -- ["WEAPON_SPECIALCARBINE"] = {"스페셜 카빈소총",6500000,50,""},
    -- ["WEAPON_FLARE"] = {"신호탄",1000,10,""},
    -- ["WEAPON_SAWNOFFSHOTGUN"] = {"소드오프 샷건",3000000,65,""},
    -- ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건",700000,20,""},
    -- ["WEAPON_BULLPUPSHOTGUN"] = {"불펍 샷건",1000000,30,""},
    -- ["WEAPON_HEAVYSHOTGUN"] = {"헤비 샷건",5000000,50,""},
    -- ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건",15000000,50,""},
    --["WEAPON_FIREWORK"] = {"폭죽",2000,0,""},
    -- ["WEAPON_SNOWBALL"] = {"눈",3000000,0,""},
    -- ["WEAPON_FLASHLIGHT"] = {"라이트",2000,0,""},
    -- ["WEAPON_MUSKET"] = {"머스킷",5000000,0,""},
    -- ["WEAPON_FLAREGUN"] = {"신호탄 총",3500,0,""},
    -- ["WEAPON_MARKSMANPISTOL"] = {"마크스맨 피스톨",150000,15,""},
    -- ["WEAPON_SNSPISTOL"] = {"SNS피스톨",250000,15,""},
    -- ["WEAPON_PETROLCAN"] = {"석유통",25000,0,""}
  },
  ["bunker"] = {
    _config = {blipid = 110, blipcolor = 1},
    ["WEAPON_BOTTLE"] = {"병", 1500, 0, ""},
    ["WEAPON_BAT"] = {"야구방망이", 15000, 0, ""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터", 20000, 0, ""},
    ["WEAPON_KNIFE"] = {"나이프", 30000, 0, ""},
    ["WEAPON_HAMMER"] = {"망치", 15000, 0, ""},
    ["WEAPON_HATCHET"] = {"손도끼", 28000, 0, ""},
    ["WEAPON_CROWBAR"] = {"쇠 지렛대", 7000, 0, ""},
    ["WEAPON_GOLFCLUB"] = {"골프채", 48000, 0, ""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드", 35000, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"라이트", 12000, 0, ""},
    ["WEAPON_FLARE"] = {"신호탄", 0, 50000, ""}
  },
  ["eastlossantos1"] = {
    _config = {blipid = 110, blipcolor = 1},
    ["WEAPON_BOTTLE"] = {"병", 1500, 0, ""},
    ["WEAPON_BAT"] = {"야구방망이", 15000, 0, ""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터", 20000, 0, ""},
    ["WEAPON_KNIFE"] = {"나이프", 30000, 0, ""},
    ["WEAPON_HAMMER"] = {"망치", 15000, 0, ""},
    ["WEAPON_HATCHET"] = {"손도끼", 28000, 0, ""},
    ["WEAPON_CROWBAR"] = {"쇠 지렛대", 7000, 0, ""},
    ["WEAPON_GOLFCLUB"] = {"골프채", 48000, 0, ""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드", 35000, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"라이트", 12000, 0, ""}
  },
  ["policeloadout"] = {
    _config = {permissions = {"police.loadshop"}},
    ["WEAPON_FLARE"] = {"신호탄", 0, 50000, ""},
    ["WEAPON_FLAREGUN"] = {"신호탄 총", 250000, 5000, ""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉", 120000, 0, ""},
    ["WEAPON_STUNGUN"] = {"스턴건", 500000, 0, ""},
    ["WEAPON_SNSPISTOL"] = {"피스톨", 950000, 1200, ""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨", 1200000, 1500, ""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총", 3500000, 2000, ""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건", 2600000, 3000, ""}
  },
  ["경찰무기"] = {
    _config = {permissions = {"SWAT.loadshop"}},
    ["WEAPON_FLARE"] = {"신호탄", 0, 50000, ""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉", 0, 0, ""},
    ["WEAPON_STUNGUN"] = {"스턴건", 0, 0, ""},
    ["WEAPON_SNSPISTOL"] = {"피스톨", 0, 100, ""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨", 0, 120, ""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건", 0, 200, ""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총 Origin", 0, 250, "장착가능 파츠<br>소음기<br>후레쉬<br>손잡이<br>무기스킨"},
    ["WEAPON_CARBINERIFLE_MK2"] = {"카빈소총 MK2", 0, 250, "장착가능 파츠<br>소음기<br>후레쉬<br>홀로그램 스코프<br>확장 탄창"},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플", 0, 5000, ""}
  },
  ["교정본부"] = {
    _config = {permissions = {"kys.loadshop"}},
    ["WEAPON_FLARE"] = {"신호탄", 0, 50000, ""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉", 120000, 0, ""},
    ["WEAPON_STUNGUN"] = {"스턴건", 500000, 0, ""},
    ["WEAPON_SNSPISTOL"] = {"피스톨", 50000, 100, ""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨", 500000, 120, ""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건", 1000000, 200, ""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총", 1500000, 250, ""}
  },
  ["경찰순경무기"] = {
    _config = {permissions = {"SWAT2.loadshop"}},
    ["WEAPON_NIGHTSTICK"] = {"야경봉", 120000, 0, ""},
    ["WEAPON_STUNGUN"] = {"스턴건", 500000, 0, ""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨", 500000, 120, ""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건", 1000000, 200, ""},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총", 1500000, 250, ""}
  },
  ["Mafia"] = {
    _config = {permissions = {"mafia.loadshop"}},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건", 2600000 * 1.5, 3000, ""},
    ["WEAPON_SNSPISTOL"] = {"피스톨", 950000 * 1.5, 1200, ""},
    ["WEAPON_ASSAULTRIFLE"] = {"AK47", 3200000 * 1.5, 2200, ""},
    ["WEAPON_COMPACTRIFLE"] = {"마이크로 SMG", 550000, 10, ""}
  },
  ["Bounty_Hunter"] = {
    _config = {blipid = 150, blipcolor = 1, permissions = {"Bounty.loadshop"}}
  },
  ["emsloadout"] = {
    _config = {permissions = {"ems.loadshop"}},
    ["WEAPON_STUNGUN"] = {"스턴 건", 500000, 3500, ""},
    ["WEAPON_PISTOL"] = {"피스톨", 950000, 1200, ""}
  },
  ["bombsticky"] = {
    _config = {blipid = 110, blipcolor = 1}
    --["WEAPON_STICKYBOMB"] = {"Sticky bomb",50000,50000,""}
  },
  ["admin1"] = {
    _config = {permissions = {"admin.store_weapons"}},
    ["WEAPON_BOTTLE"] = {"병", 0, 0, ""},
    ["WEAPON_BAT"] = {"야구방망이", 0, 0, ""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터", 0, 0, ""},
    ["WEAPON_KNIFE"] = {"나이프", 0, 0, ""},
    ["WEAPON_DAGGER"] = {"고전적 기사 단검", 0, 0, ""},
    ["WEAPON_HAMMER"] = {"망치", 0, 0, ""},
    ["WEAPON_HATCHET"] = {"손도끼", 0, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"손전등", 0, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"플래시", 0, 0, ""},
    ["WEAPON_FLARE"] = {"신호탄", 0, 0, ""},
    ["WEAPON_NIGHTSTICK"] = {"야경봉", 0, 0, ""},
    ["WEAPON_CROWBAR"] = {"쇠 지렛대", 0, 0, ""},
    ["WEAPON_GOLFCLUB"] = {"골프채", 0, 0, ""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드", 0, 0, ""},
    ["WEAPON_MACHETE"] = {"마체테", 0, 0, ""},
    ["WEAPON_FIREWORK"] = {"폭죽런처", 0, 0, ""},
    ["WEAPON_SNOWBALL"] = {"눈", 0, 0, ""},
    ["WEAPON_PETROLCAN"] = {"석유통", 0, 0, ""}
  },
  ["admin2"] = {
    _config = {permissions = {"admin.store_weapons"}},
    ["WEAPON_PISTOL"] = {"피스톨", 0, 0, ""},
    ["WEAPON_STUNGUN"] = {"스턴 건", 0, 0, ""},
    ["WEAPON_COMBATPISTOL"] = {"컴뱃 피스톨", 0, 0, ""},
    ["WEAPON_APPISTOL"] = {"AP 피스톨", 0, 0, ""},
    ["WEAPON_SNSPISTOL"] = {"SNS피스톨", 0, 0, ""},
    ["WEAPON_GRENADE"] = {"수류탄", 0, 0, ""}
  },
  ["admin3"] = {
    _config = {permissions = {"admin.store_weapons"}},
    ["WEAPON_CARBINERIFLE"] = {"카빈 소총", 0, 0, ""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건", 0, 0, ""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"어썰트 샷건", 0, 0, ""},
    ["WEAPON_SAWNOFFSHOTGUN"] = {"소드오프 샷건", 0, 0, ""},
    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건", 0, 0, ""},
    ["WEAPON_BULLPUPSHOTGUN"] = {"불펍 샷건", 0, 0, ""},
    ["WEAPON_HEAVYSHOTGUN"] = {"헤비 샷건", 0, 0, ""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플", 0, 0, ""},
    ["WEAPON_MARKSMANRIFLE"] = {"마크스맨 라이플", 0, 0, ""},
    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플", 0, 0, ""},
    ["WEAPON_BULLPUPRIFLE"] = {"불펍 라이플", 0, 0, ""},
    ["WEAPON_ADVANCEDRIFLE"] = {"차세대 라이플", 0, 0, ""},
    ["WEAPON_SPECIALCARBINE"] = {"스페셜 카빈소총", 0, 0, ""}
  },
  ["admin4"] = {
    _config = {permissions = {"admin.store_weapons"}},
    ["WEAPON_BFG9000"] = {"스페셜 BFG9000", 0, 0, ""}
  },
  ["최루탄 보급"] = {
    _config = {permissions = {"police.bg"}},
    ["WEAPON_BZGAS"] = {"최루탄", 0, 0, ""}
  },  
  ["근접 무기"] = {
    _config = {permissions = {"mk2w.a1"}},
    ["WEAPON_DAGGER"] = {"고전적 기사 단검", 50000, 0, ""},
    ["WEAPON_BAT"] = {"야구방망이", 50000, 0, ""},
    ["WEAPON_KNIFE"] = {"나이프", 50000, 0, ""},
    ["WEAPON_SWITCHBLADE"] = {"스위치 블레이드", 100000, 0, ""},
    ["WEAPON_KNUCKLE"] = {"너클 더스터", 100000, 0, ""},
    ["WEAPON_HATCHET"] = {"손도끼", 100000, 0, ""},
    ["WEAPON_FLASHLIGHT"] = {"손전등", 15000, 0, ""}
--    ["WEAPON_PISTOL"] = {"피스톨", 300000, 1200, ""},
--    ["WEAPON_MICROSMG"] = {"마이크로 SMG Origin", 1000000, 2500, "장착가능 파츠<br>소음기<br>후레쉬<br>무기스킨"},
--    ["WEAPON_ASSAULTRIFLE"] = {"AK47 Origin", 1000000, 2500, "장착가능 파츠<br>소음기<br>후레쉬<br>손잡이<br>무기스킨"},
--    ["WEAPON_PUMPSHOTGUN"] = {"펌프 샷건 Origin", 1000000, 2500, "장착가능 파츠<br>소음기<br>후레쉬<br>무기스킨"},
--    ["WEAPON_SNIPERRIFLE"] = {"스나이퍼 라이플", 300000000, 10000000, "장착가능 파츠<br>소음기<br>무기스킨"}
  }
}
-- list of gunshops positions

cfg.gunshops = {
  {"emsloadout", 339.22741699219, -583.87579345703, 28.898620605469}, -- EMS
  {"경찰순경무기", 461.33551025391, -981.11071777344, 30.689584732056},
  {"경찰무기", 457.29339599609, -982.48779296875, 30.689582824707}, -- 경찰서
  {"근접 무기", -90.662284851074, 992.79364013672, 234.56172180176}, -- 백사회 무기창고
  {"근접 무기", 1406.7689208984, 1164.8250732422, 114.33345794678}, -- 흑사회 무기창고
  {"근접 무기", -1521.8767089844, 832.03497314453, 186.14198303223}, -- 독사회 무기창고
  {"admin1", 1236.900390625, -1115.3175048828, 31.646614074707},
  {"admin2", 1238.6600341797, -1114.1680908203, 31.646614074707},
  {"admin3", 1237.2381591797, -1112.1555175781, 31.646614074707},
  {"admin4", 1235.4826660156, -1113.2536621094, 31.646614074707},
  {"최루탄 보급", 443.62768554688,-975.54791259766,30.689739227295},
  {"교정본부", 1778.1063232422, 2543.6577148438, 45.797950744629}
}

return cfg
