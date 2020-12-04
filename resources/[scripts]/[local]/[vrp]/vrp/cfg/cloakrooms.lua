-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local surgery_male = {model = "mp_m_freemode_01"}
local surgery_female = {model = "mp_f_freemode_01"}
local emergency_male = {model = "s_m_m_paramedic_01"}
local emergency_female = {model = "s_f_y_paramedic_01"}
local emergency_female2 = {model = "naotora"}
local fbi_male = {model = "s_m_y_swat_01"}
local sheriff_male = {model = "s_m_y_sheriff_01"}
local sheriff_female = {model = "s_f_y_ranger_01"}
local hway_male = {model = "s_m_y_hwaycop_01"}
local cop_male = {model = "s_m_y_cop_01"}
local ups_male = {model = "S_M_Y_AIRWORKER"}
local cop_female = {model = "s_f_y_cop_01"}
local cop_iron = {model = "iron"}
local cop_iron1 = {model = "iron1"}
local cop_iron2 = {model = "iron2"}
local detective_male = {model = "s_m_m_CIASec_01"}
local officer_male = {model = "s_m_y_cop_01"}
local bounty_male = {model = "s_m_y_BlackOps_01"}
local captain_male = {model = "s_m_y_fibcop_01"}
local lieutenant_male = {model = "s_m_m_Armoured_02"}
local sergeant_male = {model = "s_m_y_Ranger_01"}
local deputy_male = {model = "s_m_y_ranger_01"}
local chief_male = {model = "s_m_m_ciasec_01"}
local santa = {model = "Santaclaus"}
local president_male = {model = "s_m_m_highsec_01"}
local president_male2 = {model = "s_m_m_highsec_02"}
local president_male3 = {model = "s_m_m_fiboffice_01"}
local president_male4 = {model = "s_m_m_fiboffice_02"}
local Sam = {model = "Sam"}
local Lana = {model = "Lana"}
local Mai = {model = "Mai"}
local two_default = {model = "2b"}
local two_dlc = {model = "2bdlc"}
local two_armor = {model = "2barmor"}
local one_w = {model = "a2w"}
local one_two = {model = "a2"}
local MaiBikini = {model = "MaiBikini"}
local MaiCasual = {model = "MaiCasual"}
local lunav = {model = "lunav"}
local kokoro_sporty = {model = "kokoro_sporty"}
local yakuza_male1 = {model = "yakuza01"}
local yakuza_male2 = {model = "a_m_y_business_01"}
local NoctisC = {model = "NoctisC"}
local NoctisB = {model = "NoctisB"}
local NoctisD = {model = "NoctisD"}
local yakuza_male4 = {model = "a_m_y_ktown_01"}
local yakuza_male5 = {model = "a_m_y_ktown_02"}
local yakuza_male6 = {model = "g_m_y_korean_01"}
local yakuza_male7 = {model = "g_m_y_korean_02"}
local yakuza_male8 = {model = "g_m_y_korlieut_01"}
local yakuza_female = {model = "YakuzaGirl"}
local compton = {model = "g_m_y_famfor_01"}
local brotherhood = {model = "g_m_y_lost_03"}
local dt = {model = "u_m_y_babyd"}
local wick = {model = "wick"}
local poodle = {model = "a_c_poodle"}
local pug = {model = "a_c_pug"}
local mtlion = {model = "a_c_mtlion"}
local deer = {model = "a_c_deer"}
local husky = {model = "a_c_husky"}
local retriever = {model = "a_c_retriever"}
local boar = {model = "a_c_boar"}
local pig = {model = "a_c_pig"}
local cat = {model = "a_c_cat_01"}
local rabbit = {model = "a_c_rabbit_01"}
local CSGOfbia = {model = "CSGOfbia"}
local emsasaki2 = {model = "emsasaki2"}
local emsasaki3 = {model = "emsasaki3"}
local prisoner = {model = "prisoner"}
local prisguard = {model = "s_m_m_prisguard_01"}
local kyojung_01 = {model = "kyojung_01"}
local kyojung_02 = {model = "kyojung_02"}
local kyojung_03 = {model = "kyojung_03"}
local kyojung_04 = {model = "a_f_m_eastsa_02"}
local Lanam = {model = "Lanam"}

local AddonSkin = {
  ["2BARMOR"] = {
    model = "2BARMOR"
  },
  ["krpolice"] = {
    model = "krpolice"
  },
  ["a_f_y_bevhills_04"] = {
    model = "a_f_y_bevhills_04"
  },
  ["A2"] = {
    model = "A2"
  },
  ["A2W"] = {
    model = "A2W"
  },
  ["army2"] = {
    model = "army2"
  },
  ["BabyMario"] = {
    model = "BabyMario"
  },
  ["BatmanBVS"] = {
    model = "BatmanBVS"
  },
  ["BlackPanther"] = {
    model = "BlackPanther"
  },
  ["Blackwidow_AE"] = {
    model = "Blackwidow_AE"
  },
  ["chiya"] = {
    model = "chiya"
  },
  ["Christiebikini"] = {
    model = "Christiebikini"
  },
  ["d3_wizard"] = {
    model = "d3_wizard"
  },
  ["Dpool"] = {
    model = "Dpool"
  },
  ["HarleyB"] = {
    model = "HarleyB"
  },
  ["HarleyQuinn"] = {
    model = "HarleyQuinn"
  },
  ["Helena"] = {
    model = "Helena"
  },
  ["hitomi"] = {
    model = "hitomi"
  },
  ["JackSparrow"] = {
    model = "JackSparrow"
  },
  ["JohnCena2017"] = {
    model = "JohnCena2017"
  },
  ["Joker"] = {
    model = "Joker"
  },
  ["KAKASHISharingan"] = {
    model = "KAKASHISharingan"
  },
  ["KimJiyun"] = {
    model = "KimJiyun"
  },
  ["kokoro_sporty"] = {
    model = "kokoro_sporty"
  },
  ["Lana"] = {
    model = "Lana"
  },
  ["leesin"] = {
    model = "leesin"
  },
  ["Leona"] = {
    model = "Leona"
  },
  ["LioMessiCiv"] = {
    model = "LioMessiCiv"
  },
  ["littlegroot"] = {
    model = "littlegroot"
  },
  ["Luigi"] = {
    model = "Luigi"
  },
  ["lunav"] = {
    model = "lunav"
  },
  ["Mai"] = {
    model = "Mai"
  },
  ["Mai4"] = {
    model = "Mai4"
  },
  ["MaiCasual"] = {
    model = "MaMaiCasualiBikini"
  },
  ["MaiHalloween"] = {
    model = "MaiHalloween"
  },
  ["MaiT"] = {
    model = "MaiT"
  },
  ["Mario"] = {
    model = "Mario"
  },
  ["Mitsuha"] = {
    model = "Mitsuha"
  },
  ["naotora"] = {
    model = "naotora"
  },
  ["NoctisA"] = {
    model = "NoctisA"
  },
  ["NoctisB"] = {
    model = "NoctisB"
  },
  ["NoctisC"] = {
    model = "NoctisC"
  },
  ["NoctisD"] = {
    model = "NoctisD"
  },
  ["NoctisE"] = {
    model = "NoctisE"
  },
  ["nova_terra"] = {
    model = "nova_terra"
  },
  ["impatriot"] = {
    model = "impatriot"
  },
  ["iron1"] = {
    model = "iron1"
  },
  ["iron2"] = {
    model = "iron2"
  },
  ["iron3"] = {
    model = "iron3"
  },
  ["mark24"] = {
    model = "mark24"
  },
  ["MK47"] = {
    model = "MK47"
  },
  ["MK85"] = {
    model = "MK85"
  },
  ["tonyhalf"] = {
    model = "tonyhalf"
  },
  ["Leo"] = {
    model = "Leo"
  },
  ["PayDayDallas"] = {
    model = "PayDayDallas"
  },
  ["Leo"] = {
    model = "Leo"
  },
  ["pennywise"] = {
    model = "pennywise"
  },
  ["rick"] = {
    model = "rick"
  },
  ["RobocopV2"] = {
    model = "RobocopV2"
  },
  ["Ronald"] = {
    model = "Ronald"
  },
  ["sagiri"] = {
    model = "sagiri"
  },
  ["Saitama"] = {
    model = "Saitama"
  },
  ["Sam"] = {
    model = "Sam"
  },
  ["Santaclaus"] = {
    model = "Santaclaus"
  },
  ["shrek"] = {
    model = "shrek"
  },
  ["Slimer"] = {
    model = "Slimer"
  },
  ["spiderm"] = {
    model = "spiderm"
  },
  ["spiderm1"] = {
    model = "spiderm1"
  },
  ["spiderm2"] = {
    model = "spiderm2"
  },
  ["spiderm3"] = {
    model = "spiderm3"
  },
  ["tasm2"] = {
    model = "tasm2"
  },
  ["superior"] = {
    model = "superior"
  },
  ["SupermanMkvsDc"] = {
    model = "SupermanMkvsDc"
  },
  ["thanos1"] = {
    model = "thanos1"
  },
  ["ThePredator"] = {
    model = "ThePredator"
  },
  ["thor"] = {
    model = "thor"
  },
  ["TRON"] = {
    model = "TRON"
  },
  ["Va"] = {
    model = "Va"
  },
  ["Vb"] = {
    model = "Vb"
  },
  ["wick"] = {
    model = "wick"
  },
  ["yakuza01"] = {
    model = "yakuza01"
  },
  ["YakuzaGirl"] = {
    model = "YakuzaGirl"
  },
  ["yasuo"] = {
    model = "yasuo"
  },
  ["Holly"] = {
    model = "Holly"
  },
  ["MaiCasual"] = {
    model = "MaiCasual"
  },
  ["marie"] = {
    model = "marie"
  },
  ["STR_GusionVS"] = {
    model = "STR_GusionVS"
  },
  ["Sylvia"] = {
    model = "Sylvia"
  },
  ["Sylvia2"] = {
    model = "Sylvia2"
  },
  ["tamaki_v"] = {
    model = "tamaki_v"
  },
  ["yoshino"] = {
    model = "yoshino"
  },
  -- 신규 스킨 패치
  ["AdaRE6"] = {
    model = "AdaRE6"
  },
  ["alex_claws"] = {
    model = "alex_claws"
  },
  ["alex_fists"] = {
    model = "alex_fists"
  },
  ["alex_sword"] = {
    model = "alex_sword"
  },
  ["alexmercer"] = {
    model = "alexmercer"
  },
  ["altair"] = {
    model = "altair"
  },
  ["bakjoker"] = {
    model = "bakjoker"
  },
  ["Gentiana"] = {
    model = "Gentiana"
  },
  ["KRRogue"] = {
    model = "KRRogue"
  },
  ["LelouchZ"] = {
    model = "LelouchZ"
  },
  ["MegamanEXE"] = {
    model = "MegamanEXE"
  },
  ["midoriya_rh7"] = {
    model = "midoriya_rh7"
  },
  ["miya"] = {
    model = "miya"
  },
  ["MK2"] = {
    model = "MK2"
  },
  ["moonkinght"] = {
    model = "moonkinght"
  },
  ["Mr Bean"] = {
    model = "Mr Bean"
  },
  ["mysterio"] = {
    model = "mysterio"
  },
  ["MrBean"] = {
    model = "MrBean"
  },
  ["Mysterio_FFH"] = {
    model = "Mysterio_FFH"
  },
  ["natsu"] = {
    model = "natsu"
  },
  ["Panda"] = {
    model = "Panda"
  },
  ["PunisherNoir"] = {
    model = "PunisherNoir"
  },
  ["Ronin"] = {
    model = "Ronin"
  },
  ["Ryuk"] = {
    model = "Ryuk"
  },
  ["s_m_y_blackops_01"] = {
    model = "s_m_y_blackops_01"
  },
  ["s_m_y_blackops_03"] = {
    model = "s_m_y_blackops_03"
  },
  ["Saitama"] = {
    model = "Saitama"
  },
  ["skeleton"] = {
    model = "skeleton"
  },
  ["SpiderManPS4"] = {
    model = "SpiderManPS4"
  },
  ["STR_AlucardFI"] = {
    model = "STR_AlucardFI"
  },
  ["STR_MuradAOVCCA"] = {
    model = "STR_MuradAOVCCA"
  },
  ["STR_WiroAOV"] = {
    model = "STR_WiroAOV"
  },
  ["Vanquish"] = {
    model = "Vanquish"
  },
  ["WinterSoldier2"] = {
    model = "WinterSoldier2"
  },
  ["WinterSoldier1"] = {
    model = "WinterSoldier1"
  },
  ["realfcop"] = {
    model = "realfcop"
  },
  -- 신규 스킨 05-14
  ["lubo"] = {
    model = "lubo"
  },
  ["lubo_5"] = {
    model = "lubo_5"
  },
  ["lubo_6"] = {
    model = "lubo_6"
  },
  ["arthur"] = {
    model = "arthur"
  },
  ["arthur_baseball"] = {
    model = "arthur_baseball"
  },
  ["arthur_frozen"] = {
    model = "arthur_frozen"
  },
  ["arthur_valentine"] = {
    model = "arthur_valentine"
  },
  ["astrid_2"] = {
    model = "astrid_2"
  },
  ["astrid_3"] = {
    model = "astrid_3"
  },
  ["gildur_2"] = {
    model = "gildur_2"
  },
  ["gildur_3"] = {
    model = "gildur_3"
  },
  ["llumia2"] = {
    model = "llumia2"
  },
  ["llumia3"] = {
    model = "llumia3"
  },
  ["llumia4"] = {
    model = "llumia4"
  },
  ["leesin_skt_t1"] = {
    model = "leesin_skt_t1"
  },
  ["lubu_cyper_samurai"] = {
    model = "lubu_cyper_samurai"
  },
  ["lubu_summer_bash"] = {
    model = "lubu_summer_bash"
  },
  ["murad_2"] = {
    model = "murad_2"
  },
  ["murad_3"] = {
    model = "murad_3"
  },
  ["murad_4"] = {
    model = "murad_4"
  },
  ["nakroth_2"] = {
    model = "nakroth_2"
  },
  ["nakroth_3"] = {
    model = "nakroth_3"
  },
  ["nakroth_4"] = {
    model = "nakroth_4"
  },
  ["natalya_2"] = {
    model = "natalya_2"
  },
  ["natalya_3"] = {
    model = "natalya_3"
  },
  ["natalya_5"] = {
    model = "natalya_5"
  },
  ["oddbods_bubble"] = {
    model = "oddbods_bubble"
  },
  ["oddbods_fuse"] = {
    model = "oddbods_fuse"
  },
  ["oddbods_jeff"] = {
    model = "oddbods_jeff"
  },
  ["oddbods_newt"] = {
    model = "oddbods_newt"
  },
  ["oddbods_pogo"] = {
    model = "oddbods_pogo"
  },
  ["oddbods_slick"] = {
    model = "oddbods_slick"
  },
  ["oddbods_zee"] = {
    model = "oddbods_zee"
  },
  ["Po"] = {
    model = "Po"
  },
  ["raz_2"] = {
    model = "raz_2"
  },
  ["raz_3"] = {
    model = "raz_3"
  },
  ["raz_4"] = {
    model = "raz_4"
  },
  ["raz_cypercore"] = {
    model = "raz_cypercore"
  },
  ["ryoma_gunslinger"] = {
    model = "ryoma_gunslinger"
  },
  ["Ryoma_Yakuya"] = {
    model = "Ryoma_Yakuya"
  },
  ["telannas"] = {
    model = "telannas"
  },
  ["telannas_agilespirit"] = {
    model = "telannas_agilespirit"
  },
  ["jerrymouse"] = {
    model = "jerrymouse"
  },
  ["telannas_woodland"] = {
    model = "telannas_woodland"
  },
  ["tomcat"] = {
    model = "tomcat"
  },
  ["valhein_nethra"] = {
    model = "valhein_nethra"
  },
  ["valhein_technotemplar"] = {
    model = "valhein_technotemplar"
  },
  ["zanis_ascended"] = {
    model = "zanis_ascended"
  },
  ["zanis_bloodknight"] = {
    model = "zanis_bloodknight"
  },
  ["zanis_casanova"] = {
    model = "zanis_casanova"
  },
  ["zanis_infinitecourage"] = {
    model = "zanis_infinitecourage"
  },
  ["lovesworn"] = {
    model = "lovesworn"
  },
  ["telannas_navycadet"] = {
    model = "telannas_navycadet"
  },
  ["HonokaALT"] = {
    model = "HonokaALT"
  },
  ["HonokaRegular"] = {
    model = "HonokaRegular"
  },
  ["playerpubg"] = {
    model = "playerpubg"
  },
  ["MaiBikini2"] = {
    model = "MaiBikini2"
  },
  ["gothboiclique"] = {
    model = "gothboiclique"
  },
  ["kororo_summer"] = {
    model = "kororo_summer"
  },
  ["himiko_toga"] = {
    model = "himiko_toga"
  },
  ["kfaiz"] = {
    model = "kfaiz"
  },
  ["mai_summer"] = {
    model = "mai_summer"
  },
  ["kokoro_summer2"] = {
    model = "kokoro_summer2"
  },
  ["MaikoreanBikini"] = {
    model = "MaikoreanBikini"
  },
  ["yui2"] = {
    model = "yui2"
  },
  ["lisa_summer"] = {
    model = "lisa_summer"
  },
  ["honoka"] = {
    model = "honoka"
  },
  ["karin"] = {
    model = "karin"
  },
  ["kotori"] = {
    model = "kotori"
  },
  ["maki"] = {
    model = "maki"
  },
  ["nico"] = {
    model = "nico"
  },
  ["setsuna"] = {
    model = "setsuna"
  },
  ["umida"] = {
    model = "umida"
  },
  ["knptraffic"] = {
    model = "knptraffic"
  }  
}

--s_m_m_paramedic_01
--s_f_y_scrubs_01
--mp_m_freemode_01
--mp_f_freemode_01

for i = 0, 19 do
  surgery_female[i] = {0, 0}
  surgery_male[i] = {0, 0}
end

-- cloakroom types (_config, map of name => customization)
--- _config:
---- permissions (optional)
---- not_uniform (optional): if true, the cloakroom will take effect directly on the player, not as a uniform you can remove
cfg.cloakroom_types = {
  ["police"] = {
    _config = {permissions = {"police.cloakroom"}},
    ["뉴비 복장"] = surgery_male,
    ["남성경찰 제복 복장"] = police_ganbu,
    ["남성경찰 근무 복장 A"] = officer_male,
    ["남성경찰 근무 복장 B"] = AddonSkin.krpolice,
    ["남성경찰 간부 복장"] = sheriff_male,
    ["여성경찰 근무 복장"] = AddonSkin.realfcop,
    ["여성경찰 간부 복장"] = sheriff_female,
    ["특수부대 근무 복장"] = fbi_male,
    ["파출소장 근무 복장"] = detective_male,
    ["교통 경찰"] = AddonSkin.knptraffic
  },
  ["죄수복"] = {
    _config = {permissions = {"user.paycheck"}},
    ["죄수복"] = prisoner
  },
  ["죄수복벗기"] = {
    _config = {permissions = {"user.paycheck"}}
  },
  ["교도관"] = {
    _config = {permissions = {"kys.cloakroom"}},
    ["뉴비 복장"] = surgery_male,
    ["교도관 근무복A"] = kyojung_01,
    ["교도관 근무복B"] = kyojung_02,
    ["교도관 근무복C"] = kyojung_03,
    ["교도관 여성 근무복"] = kyojung_04,
    ["교도관 근무복D"] = prisguard
  },
  ["Lawyer"] = {
    _config = {permissions = {"Lawyer.cloakroom"}},
    ["Male uniform"] = {
      [3] = {1, 0},
      [4] = {10, 0},
      [6] = {10, 0},
      [8] = {4, 0},
      [11] = {10, 0},
      ["p2"] = {-1, 0}
    },
    ["Female uniform"] = {
      [3] = {0, 0},
      [4] = {37, 0},
      [6] = {13, 0},
      [8] = {21, 1},
      [11] = {24, 3},
      ["p2"] = {-1, 0}
    }
  },
  ["성별전환"] = {
    _config = {not_uniform = true},
    ["남성"] = surgery_male,
    ["여성"] = surgery_female
  },
  ["일반복장"] = {
    _config = {permissions = {"user.paycheck"}},
    ["뉴비 복장"] = surgery_male
  },
  -- ["Santa"] = {
  -- _config = { permissions = {"santa.cloakroom"} },
  -- ["Santa Outfit"] = santa
  -- },
  ["emergency"] = {
    _config = {permissions = {"emergency.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["의료국 남성근무복A"] = emergency_male,
    ["의료국 검시관"] = emsasaki2,
    ["의료국 구조대"] = CSGOfbia,
    ["의료국 의사근무복"] = emsasaki3,
    ["의료국 여성근무복A"] = cop_female,
    ["의료국 여성근무복B"] = Lanam
  },
  ["Officer"] = {
    _config = {permissions = {"Officer.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Officer"] = officer_male,
    ["Female"] = cop_female
  },
  ["Chief"] = {
    _config = {permissions = {"Chief.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Chief"] = chief_male
  },
  ["Trooper"] = {
    _config = {permissions = {"Commander.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Trooper"] = hway_male
  },
  ["Lieutenant"] = {
    _config = {permissions = {"Lieutenant.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Lieutenant"] = lieutenant_male
  },
  ["Bounty"] = {
    _config = {permissions = {"Bounty.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Bounty"] = bounty_male
  },
  ["Captain"] = {
    _config = {permissions = {"Captain.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Captain"] = captain_male
  },
  ["Detective"] = {
    _config = {permissions = {"Detective.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Detective"] = detective_male
  },
  ["Deputy"] = {
    _config = {permissions = {"Deputy.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Deputy"] = deputy_male
  },
  ["Sergeant"] = {
    _config = {permissions = {"Sergeant.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Sergeant"] = sergeant_male
  },
  ["UPS"] = {
    _config = {permissions = {"ups.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Courier"] = ups_male
  },
  ["SWAT"] = {
    _config = {permissions = {"SWAT.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Male"] = fbi_male
  },
  ["sheriff"] = {
    _config = {permissions = {"sheriff.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Male"] = sheriff_male,
    ["Female"] = sheriff_female
  },
  ["president"] = {
    _config = {permissions = {"president.cloakroom"}},
    ["Secret Service 1"] = president_male,
    ["Secret Service 2"] = president_male2
  },
  ["couple"] = {
    _config = {permissions = {"couple.cloakroom"}},
    ["NoctisD"] = NoctisD,
    ["NoctisB"] = NoctisB,
    ["NoctisC"] = NoctisC,
    ["Compton Gangster"] = compton,
    ["Yakuza Female"] = yakuza_female,
    ["Samantha"] = Sam,
    ["Mai Siranui"] = Mai,
    ["Mai Siranui Bikini"] = MaiBikini,
    ["DOA Luna"] = lunav,
    ["Kokoro Sporty"] = kokoro_sporty,
    ["Mai Siranui Casual"] = MaiCasual,
    ["John Wick : Chapter 2"] = wick,
    ["*2B"] = two_default,
    ["*2B DLC"] = two_dlc,
    ["*A2"] = one_two,
    ["*A2W"] = one_w,
    ["*2B ARMOR"] = two_armor,
    ["*Lana"] = Lana
  },
  ["테스트스킨"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["HonokaALT"] = AddonSkin.HonokaALT,
    ["HonokaRegular"] = AddonSkin.HonokaRegular,
    ["playerpubg"] = AddonSkin.playerpubg,
    ["MaiBikini2"] = AddonSkin.MaiBikini2,
    ["gothboiclique"] = AddonSkin.gothboiclique,
    ["kororo_summer"] = AddonSkin.kororo_summer,
    ["himiko_toga"] = AddonSkin.himiko_toga,
    ["kfaiz"] = AddonSkin.kfaiz,
    ["mai_summer"] = AddonSkin.mai_summer,
    ["kokoro_summer2"] = AddonSkin.kokoro_summer2,
    ["MaikoreanBikini"] = AddonSkin.MaikoreanBikini,
    ["yui2"] = AddonSkin.yui2,
    ["lisa_summer"] = AddonSkin.lisa_summer,
    ["honoka"] = AddonSkin.honoka,
    ["karin"] = AddonSkin.karin,
    ["kotori"] = AddonSkin.kotori,
    ["maki"] = AddonSkin.maki,
    ["nico"] = AddonSkin.nico,
    ["setsuna"] = AddonSkin.setsuna,
    ["umida"] = AddonSkin.umida
  },
  ["animal"] = {
    _config = {permissions = {"admin.cloakroom"}}
  },
  ["shh"] = {
    _config = {permissions = {"shh.cloakroom"}},
    ["삼합회1"] = {
      model = "yakuza01"
    },
    ["삼합회2"] = yakuza_male2,
    ["삼합회3"] = yakuza_male4,
    ["삼합회4"] = yakuza_male5,
    ["삼합회5"] = yakuza_male6,
    ["삼합회6"] = yakuza_male7,
    ["삼합회7"] = yakuza_male8,
    ["삼합회 여자"] = {
      model = "YakuzaGirl"
    }
  },
  ["mafia"] = {
    _config = {permissions = {"mafia.cloakroom"}},
    ["마피아1"] = {
      model = "shh1"
    },
    ["마피아2"] = {
      model = "shh2"
    },
    ["마피아3"] = {
      model = "shh3"
    },
    ["마피아4"] = {
      model = "shh4"
    },
    ["마피아5"] = brotherhood,
    ["마피아6"] = dt
  },
  ["gm"] = {
    _config = {permissions = {"gm.cloakroom"}},
    ["에르지오1"] = {
      model = "Jules Winnfield"
    },
    ["에르지오2"] = {
      model = "Vincent Vega"
    },
    ["에르지오3"] = {
      model = "ig_bankman"
    }
  },
  ["gov"] = {
    _config = {permissions = {"gov.cloakroom"}},
    ["대통령"] = {
      model = "President"
    },
    ["대통령 비서"] = {
      model = "bodyguard"
    },
    ["대통령 경호원"] = {
      model = "bodyguard"
    },
    ["국무총리"] = {
      model = "kennedy"
    },
    ["국회의원"] = {
      model = "kennedy"
    }
  },
  ["tow"] = {
    _config = {permissions = {"tow.cloakroom"}},
    ["렉카남자"] = {
      model = "Salvador Dali"
    },
    ["렉카남자1"] = {
      model = "NoctisA"
    },
    ["렉카남자2"] = {
      model = "NoctisB"
    },
    ["렉카남자3"] = {
      model = "NoctisC"
    },
    ["렉카남자4"] = {
      model = "NoctisD"
    },
    ["렉카남자5"] = {
      model = "NoctisE"
    },
    ["렉카여자"] = {
      model = "scarlet"
    },
    ["렉카여자1"] = {
      model = "AVA"
    },
    ["렉카여자2"] = {
      model = "Cindy"
    },
    ["렉카여자3"] = {
      model = "KimJiyun1"
    },
    ["렉카여자4"] = {
      model = "leona"
    }
  },
  ["admin1"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["데드풀"] = AddonSkin.Dpool,
    ["잭스패로우"] = AddonSkin.JackSparrow,
    ["조커"] = AddonSkin.Joker,
    ["블랙펜서"] = AddonSkin.BlackPanther,
    ["블랙위도우"] = AddonSkin.Blackwidow_AE,
    ["마리오"] = AddonSkin.Mario,
    ["닌자거북이"] = AddonSkin.Leo,
    ["페니와이즈"] = AddonSkin.pennywise,
    ["스파이더맨1"] = AddonSkin.spiderm,
    ["스파이더맨2"] = AddonSkin.spiderm1,
    ["스파이더맨3"] = AddonSkin.spiderm2,
    ["스파이더맨4"] = AddonSkin.spiderm3,
    ["스파이더맨-파워업"] = AddonSkin.tasm2,
    ["슈퍼맨"] = AddonSkin.SupermanMkvsDc,
    ["프레데터"] = AddonSkin.ThePredator,
    ["트론"] = AddonSkin.TRON,
    ["존윅"] = AddonSkin.wick,
    ["아이언맨1"] = AddonSkin.iron1,
    ["아이언맨2"] = AddonSkin.iron2,
    ["아이언맨3"] = AddonSkin.iron3,
    ["아이언맨-마크24"] = AddonSkin.mark24,
    ["아이언맨-마크47"] = AddonSkin.MK47,
    ["아이언맨-마크85"] = AddonSkin.MK85,
    ["토니스타크"] = AddonSkin.tonyhalf,
    ["로보캅"] = AddonSkin.RobocopV2,
    ["타노스1"] = AddonSkin.thanos,
    ["타노스2"] = AddonSkin.thanos1,
    ["타노스3"] = AddonSkin.ThanosIW,
    ["토르"] = AddonSkin.thor
  },
  ["admin2"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["시야"] = AddonSkin.chiya,
    ["연구소장"] = AddonSkin.rick,
    ["Christiebikini"] = AddonSkin.Christiebikini,
    ["D3위자드"] = AddonSkin.d3_wizard,
    ["HarleyB"] = AddonSkin.HarleyB,
    ["HarleyQuinn"] = AddonSkin.HarleyQuinn,
    ["헬레나"] = AddonSkin.Helena,
    ["존세나"] = AddonSkin.JohnCena2017,
    ["KAKASHISharingan"] = AddonSkin.KAKASHISharingan,
    ["KimJiyun"] = AddonSkin.KimJiyun,
    ["코코로스포티"] = AddonSkin.kokoro_sporty,
    ["라나"] = AddonSkin.Lana,
    ["리신"] = AddonSkin.leesin,
    ["레오나"] = AddonSkin.Leona,
    ["메시"] = AddonSkin.LioMessiCiv,
    ["그루트"] = AddonSkin.littlegroot,
    ["마리오 - 그린"] = AddonSkin.Luigi,
    ["마이"] = AddonSkin.Mai,
    ["노바 테라"] = AddonSkin.nova_terra,
    ["페이데이"] = AddonSkin.PayDayDallas,
    ["도널드"] = AddonSkin.Ronald,
    ["슈렉"] = AddonSkin.shrek,
    ["tohru"] = AddonSkin.tohru,
    ["Va"] = AddonSkin.Va,
    ["Vb"] = AddonSkin.Vb,
    ["벨라"] = AddonSkin.vella,
    ["홀리 A"] = AddonSkin.Holly,
    ["메이 캐쥬얼"] = AddonSkin.MaiCasual,
    ["도아 마리"] = AddonSkin.marie,
    ["구시언 STR VS"] = AddonSkin.STR_GusionVS,
    ["실비아 A"] = AddonSkin.Sylvia,
    ["실비아 B"] = AddonSkin.Sylvia2,
    ["타마키"] = AddonSkin.tamaki_v
  },
  ["admin3"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["손오공"] = {
      model = "Goku"
    },
    ["손오공 초사이어인"] = {
      model = "GOKUMUI"
    },
    ["마인부우"] = {
      model = "SuperBuu"
    },
    ["베지터"] = {
      model = "vegeta base"
    },
    ["베지터 초사이어인"] = {
      model = "vegeta ssj"
    },
    ["베지터 초사이어인갓"] = {
      model = "vegeta ssjg"
    },
    ["AdaRE6"] = AddonSkin.AdaRE6,
    ["alex_claws"] = AddonSkin.alex_claws,
    ["alex_fists"] = AddonSkin.alex_fists,
    ["alex_sword"] = AddonSkin.alex_sword,
    ["alexmercer"] = AddonSkin.alexmercer,
    ["altair"] = AddonSkin.altair,
    ["bakjoker"] = AddonSkin.bakjoker,
    ["Gentiana"] = AddonSkin.Gentiana,
    ["KRRogue"] = AddonSkin.KRRogue,
    ["LelouchZ"] = AddonSkin.LelouchZ,
    ["MegamanEXE"] = AddonSkin.MegamanEXE,
    ["midoriya_rh7"] = AddonSkin.midoriya_rh7,
    ["miya"] = AddonSkin.miya,
    ["MK2"] = AddonSkin.MK2,
    ["moonkinght"] = AddonSkin.moonkinght,
    ["MrBean"] = AddonSkin.MrBean,
    ["Mysterio_FFH"] = AddonSkin.Mysterio_FFH,
    ["natsu"] = AddonSkin.natsu,
    ["mysterio"] = AddonSkin.mysterio,
    ["Panda"] = AddonSkin.Panda,
    ["PunisherNoir"] = AddonSkin.PunisherNoir,
    ["Ronin"] = AddonSkin.Ronin,
    ["Ryuk"] = AddonSkin.Ryuk,
    ["s_m_y_blackops_01"] = AddonSkin.s_m_y_blackops_01,
    ["s_m_y_blackops_03"] = AddonSkin.s_m_y_blackops_03,
    ["Saitama"] = AddonSkin.Saitama,
    ["skeleton"] = AddonSkin.skeleton,
    ["SpiderManPS4"] = AddonSkin.SpiderManPS4,
    ["STR_AlucardFI"] = AddonSkin.STR_AlucardFI,
    ["STR_MuradAOVCCA"] = AddonSkin.STR_MuradAOVCCA,
    ["STR_WiroAOV"] = AddonSkin.STR_WiroAOV,
    ["Vanquish"] = AddonSkin.Vanquish,
    ["WinterSoldier1"] = AddonSkin.WinterSoldier1,
    ["WinterSoldier2"] = AddonSkin.WinterSoldier2,
    ["realfcop"] = AddonSkin.realfcop,
    -------------
    ["lubo"] = AddonSkin.lubo,
    ["lubo_5"] = AddonSkin.lubo_5,
    ["lubo_6"] = AddonSkin.lubo_6,
    ["arthur"] = AddonSkin.arthur,
    ["arthur_baseball"] = AddonSkin.arthur_baseball,
    ["arthur_frozen"] = AddonSkin.arthur_frozen,
    ["arthur_valentine"] = AddonSkin.arthur_valentine,
    ["astrid_2"] = AddonSkin.astrid_2,
    ["astrid_3"] = AddonSkin.astrid_3,
    ["gildur_2"] = AddonSkin.gildur_2,
    ["gildur_3"] = AddonSkin.gildur_3,
    ["llumia2"] = AddonSkin.llumia2,
    ["llumia3"] = AddonSkin.llumia3,
    ["llumia4"] = AddonSkin.llumia4,
    ["leesin_skt_t1"] = AddonSkin.leesin_skt_t1,
    ["lubu_cyper_samurai"] = AddonSkin.lubu_cyper_samurai,
    ["lubu_summer_bash"] = AddonSkin.lubu_summer_bash,
    ["murad_2"] = AddonSkin.murad_2,
    ["murad_3"] = AddonSkin.murad_3,
    ["murad_4"] = AddonSkin.murad_4,
    ["nakroth_2"] = AddonSkin.nakroth_2,
    ["nakroth_3"] = AddonSkin.nakroth_3,
    ["nakroth_4"] = AddonSkin.nakroth_4,
    ["natalya_2"] = AddonSkin.natalya_2,
    ["natalya_3"] = AddonSkin.natalya_3,
    ["natalya_5"] = AddonSkin.natalya_5,
    ["oddbods_bubble"] = AddonSkin.oddbods_bubble,
    ["oddbods_fuse"] = AddonSkin.oddbods_fuse,
    ["oddbods_jeff"] = AddonSkin.oddbods_jeff,
    ["oddbods_newt"] = AddonSkin.oddbods_newt,
    ["oddbods_pogo"] = AddonSkin.oddbods_pogo,
    ["oddbods_slick"] = AddonSkin.oddbods_slick,
    ["oddbods_zee"] = AddonSkin.oddbods_zee,
    ["Po"] = AddonSkin.Po,
    ["raz_2"] = AddonSkin.raz_2,
    ["raz_3"] = AddonSkin.raz_3,
    ["raz_4"] = AddonSkin.raz_4,
    ["raz_cypercore"] = AddonSkin.raz_cypercore,
    ["ryoma_gunslinger"] = AddonSkin.ryoma_gunslinger,
    ["Ryoma_Yakuya"] = AddonSkin.Ryoma_Yakuya,
    ["telannas"] = AddonSkin.telannas,
    ["telannas_agilespirit"] = AddonSkin.telannas_agilespirit,
    ["jerrymouse"] = AddonSkin.jerrymouse,
    ["telannas_woodland"] = AddonSkin.telannas_woodland,
    ["tomcat"] = AddonSkin.tomcat,
    ["valhein_nethra"] = AddonSkin.valhein_nethra,
    ["valhein_technotemplar"] = AddonSkin.valhein_technotemplar,
    ["zanis_ascended"] = AddonSkin.zanis_ascended,
    ["zanis_bloodknight"] = AddonSkin.zanis_bloodknight,
    ["zanis_casanova"] = AddonSkin.zanis_casanova,
    ["zanis_infinitecourage"] = AddonSkin.zanis_infinitecourage,
    ["lovesworn"] = AddonSkin.lovesworn,
    ["telannas_navycadet"] = AddonSkin.telannas_navycadet    
  },
  ["admin4"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["charmander"] = {
      model = "charmander"
    },
    ["HulkHoganBeach"] = {
      model = "HulkHoganBeach"
    },
    ["ig_barry"] = {
      model = "ig_barry"
    },
    ["ig_bestmen"] = {
      model = "ig_bestmen"
    },
    ["ig_beverly"] = {
      model = "ig_beverly"
    },
    ["kanna"] = {
      model = "kanna"
    },
    ["PennyWise90"] = {
      model = "PennyWise90"
    },
    ["swordart"] = {
      model = "swordart"
    },
    ["Zeus"] = {
      model = "Zeus"
    },
    ["patrick"] = {
      model = "patrick"
    },
    ["BOB ESPONJA"] = {
      model = "BOB ESPONJA"
    },
    ["Calamardo"] = {
      model = "Calamardo"
    },
    ["Monkey D.Luffy"] = {
      model = "Monkey D.Luffy"
    },
    ["STR_Naruto"] = {
      model = "STR_Naruto"
    },
    ["yoshino"] = {
      model = "yoshino"
    },
    ["Calamardo"] = {
      model = "Calamardo"
    },
    ["AK_BatmanBeyond"] = {
      model = "AK_BatmanBeyond"
    },
    ["batmanbeyond"] = {
      model = "batmanbeyond"
    },
    ["batmanbeyondX"] = {
      model = "batmanbeyondX"
    },
    ["capmerica_modsoldier"] = {
      model = "capmerica_modsoldier"
    },
    ["GreenLanternInjustice"] = {
      model = "GreenLanternInjustice"
    },
    ["KuugaAmazingMighty"] = {
      model = "KuugaAmazingMighty"
    },
    ["overlord"] = {
      model = "overlord"
    },
    ["ShazamInjustice"] = {
      model = "ShazamInjustice"
    },
    ["Yellowjacket"] = {
      model = "Yellowjacket"
    },
    ["link"] = {
      model = "link"
    }
  },
  ["vip"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["Lana A"] = {
      model = "Lana A"
    },
    ["Lana B"] = {
      model = "Lana B"
    },
    ["Mila"] = {
      model = "Mila"
    },
    ["MomiC"] = {
      model = "MomiC"
    },
    ["Sam A"] = {
      model = "Sam A"
    },
    ["Sam B"] = {
      model = "Sam B"
    },
    ["Susan"] = {
      model = "Susan"
    },
    ["Susan2"] = {
      model = "Susan2"
    },
    ["Tifa"] = {
      model = "Tifa"
    },
    ["TifaB"] = {
      model = "TifaB"
    },
    ["TifaCA"] = {
      model = "TifaCA"
    },
    ["TifaCB"] = {
      model = "TifaCB"
    },
    ["TifaCC"] = {
      model = "TifaCC"
    },
    ["TifaCD"] = {
      model = "TifaCD"
    }
  },
  ["event"] = {
    _config = {permissions = {"admin.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["*fortnite_drift"] = {
      model = "fortnite_drift"
    },
    ["*fortnite_ragnarok"] = {
      model = "fortnite_ragnarok"
    },
    ["*fortnite_wukong"] = {
      model = "fortnite_wukong"
    },
    ["*inuyasha"] = {
      model = "inuyasha"
    },
    ["*krixi_summerbash"] = {
      model = "krixi_summerbash"
    },
    ["*ryoma_bloodthirst"] = {
      model = "ryoma_bloodthirst"
    },
    ["*valhein_paragon"] = {
      model = "valhein_paragon"
    },
    ["*zuka_principanda"] = {
      model = "zuka_principanda"
    },
    ["master_yi"] = {
      model = "master_yi"
    },
    ["raccoon"] = {
      model = "raccoon"
    },
    ["yasuo"] = {
      model = "yasuo"
    },
    ["zed"] = {
      model = "zed"
    }
  },
  ["newbie_helper"] = {
    _config = {permissions = {"helper.cloakroom"}},
    ["뉴비복장"] = surgery_male,
    ["라나"] = AddonSkin.Lana,
    ["마이"] = AddonSkin.Mai,
    ["tohru"] = AddonSkin.tohru,
    ["Va"] = AddonSkin.Va,
    ["Vb"] = AddonSkin.Vb,
    ["벨라"] = AddonSkin.vella,
    ["레오나"] = AddonSkin.Leona,
    ["블랙펜서"] = AddonSkin.BlackPanther,
    ["블랙위도우"] = AddonSkin.Blackwidow_AE,
    ["마리오"] = AddonSkin.Mario,
    ["KAKASHISharingan"] = AddonSkin.KAKASHISharingan,
    ["KimJiyun"] = AddonSkin.KimJiyun,
    ["kokoro_sporty"] = AddonSkin.kokoro_sporty,
    ["토르"] = AddonSkin.thor,
    ["캡틴아메리카"] = {
      model = "capmerica_modsoldier"
    },
    ["티파니A"] = {
      model = "TifaCA"
    },
    ["티파니B"] = {
      model = "TifaCB"
    },
    ["퍼지"] = {
      model = "fergie"
    },
    ["캡틴아메리카"] = {
      model = "capmerica_modsoldier"
    },
    ["쿠가"] = {
      model = "KuugaAmazingMighty"
    },
    ["세일러문"] = {
      model = "SailorMoon"
    },
    ["원더우먼"] = {
      model = "WonderWomanMovie"
    },
    ["소닉"] = {
      model = "Sonic"
    },
    ["*krixi"] = {
      model = "krixi"
    },
    ["*krixi_fairy"] = {
      model = "krixi_fairy"
    },
    ["*krixi_flowerchild"] = {
      model = "krixi_flowerchild"
    },
    ["*krixi_papillon"] = {
      model = "krixi_papillon"
    },
    ["*lu_bo_prom_king"] = {
      model = "lu_bo_prom_king"
    },
    ["*valhein_dandy"] = {
      model = "valhein_dandy"
    }
  }
}

cfg.cloakrooms = {
  {"police", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  {"police", 1848.2177734375, 3689.5593261719, 34.267040252686, "스킨"}, -- sandy shores
  {"police", -448.53857421875, 6009.2690429688, 31.716375350952, "스킨"}, -- paleto
  --{"Officer", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Chief", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Bounty", 575.40698242188, -3121.94921875, 18.768627166748, "스킨"},
  --{"Commander", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Captain", 451.85214, -973.87768, 30.68960, "스킨"},
  --{"Lieutenant", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Detective", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Sergeant", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"police", 369.9228515625,-1607.12976074219,29.291934967041, "스킨"},
  --{"SWAT", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"sheriff", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Deputy", 459.01037597656, -992.32800292969, 30.689575195313, "스킨"},
  --{"Deputy", 1849.7268066406, 3689.9221191406, 34.267040252686, "스킨"}, -- sandy shores
  --{"Deputy", -447.44305419922, 6007.9516601563, 31.716375350952, "스킨"}, -- paleto
  --{"sheriff", 1849.7268066406, 3689.9221191406, 34.267040252686, "스킨"}, -- sandy shores
  {"테스트스킨", -2611.0812988281, 1710.3438720703, 146.32257080078, "테스트 스킨"}, -- 테스트 스킨
  {"일반복장", -60.89111328125, 994.72985839844, 234.56858825684, "일반 복장"}, -- 백사회 일반복장
  {"일반복장", 1401.7242431641, 1134.4129638672, -1014.33365631104, ""}, -- 흑사회 일반복장
  {"일반복장", 1401.7242431641, 1134.4129638672, 114.33365631104, "일반 복장"}, -- 흑사회 일반복장
  {"성별전환", 1849.7425, 3686.5759, 34.2670, "성별 전환"},
  ----first spawn change skin
  {"성별전환", 75.3451766967773, -1392.86596679688, 29.3761329650879, "성별 전환"},
  ---skinsshops
  {"성별전환", -700.089477539063, -151.570571899414, 37.4151458740234, "성별 전환"},
  {"성별전환", -170.416717529297, -296.563873291016, 39.7332878112793, "성별 전환"},
  {"성별전환", 428.67544555664, -803.24554443359, 29.491147994995, "성별 전환"},
  {"성별전환", -2225.36, 265.47, 174.60, "성별 전환"},
  {"성별전환", -822.166687011719, -1073.58020019531, 11.3281087875366, "성별 전환"},
  {"성별전환", -1186.25744628906, -771.20166015625, 17.3308639526367, "성별 전환"},
  --{"UPS", 78.672370910645, 111.7912902832, 81.168083190918, "스킨"},
  {"성별전환", -1450.98388671875, -238.164260864258, 49.8105850219727, "성별 전환"},
  {"성별전환", 4.44537162780762, 6512.244140625, 31.8778476715088, "성별 전환"},
  {"성별전환", 1693.91735839844, 4822.66162109375, 42.0631141662598, "성별 전환"},
  {"성별전환", 118.071769714355, -224.893646240234, 54.5578384399414, "성별 전환"},
  {"성별전환", 620.459167480469, 2766.82641601563, 42.0881042480469, "성별 전환"},
  {"성별전환", 1196.89221191406, 2710.220703125, 38.2226066589355, "성별 전환"},
  {"성별전환", -3178.01000976563, 1043.21044921875, 20.8632164001465, "성별 전환"},
  {"성별전환", -1101.15161132813, 2710.8203125, 19.1078643798828, "성별 전환"},
  {"emergency", 315.43661499023, -603.70739746094, 43.292797088623, "EMS 스킨"},
  --{"president", -456.83062744141, 1092.4083251953, 327.68194580078, "스킨"},
  {"couple", 449.08935546875, -803.125, 27.804941177368, "스킨"},
  {"admin1", -2621.2749023438, 1712.0330810547, 146.32257080078, "관리자 스킨"},
  {"admin2", -2619.4523925781, 1712.7655029297, 146.32257080078, "관리자 스킨"},
  {"admin3", -2617.7395019531, 1713.7918701172, 146.32257080078, "관리자 스킨"},
  {"admin4", -2617.5737304688, 1711.4226074219, 146.32255554199, "관리자 스킨"},
  {"event", -2619.0620117188, 1710.9381103516, 146.32255554199, "관리자 스킨"},
  {"vip", -2620.7980957031, 1710.3306884766, 146.32255554199, "VIP 스킨"},
  {"죄수복", 1840.3272705078, 2589.9858398438, 45.897541046143, "죄수복 환복"},
  {"죄수복벗기", 1843.0241699219, 2581.0251464844, 45.891990661621, "죄수복 벗기"},
  {"교도관", 1843.3150634766, 2594.6437988281, 45.891986846924, ""}
}

return cfg
