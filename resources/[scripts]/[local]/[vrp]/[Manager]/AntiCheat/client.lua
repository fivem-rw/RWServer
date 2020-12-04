--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]
------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------

AntiCheat = true
AntiCheatStatus = "~g~활성화"
PedStatus = 0

CarsBL = {
    "vigilante",
    "hydra",
    "buzzard",
    "deluxo",
    "avenger",
    "akula",
    "apc",
    "barrage",
    "caracara",
    "cargobob",
    "chernobog",
    "hunter",
    "insurgent",
    "starling",
    "lazer",
    "bombushka",
    "savage",
    "rhino",
    "khanjali"
}

WeaponBL = {
    "WEAPON_RAILGUN",
    "WEAPON_GARBAGEBAG",
    "WEAPON_RPG",
    "WEAPON_MINIGUN",
    "WEAPON_PROXMINE"
}

ObjectsBL = {
    "hei_prop_carrier_radar_1_l1",
    "v_res_mexball",
    "prop_rock_1_a",
    "prop_rock_1_b",
    "prop_rock_1_c",
    "prop_rock_1_d",
    "prop_player_gasmask",
    "prop_rock_1_e",
    "prop_rock_1_f",
    "prop_rock_1_g",
    "prop_rock_1_h",
    "prop_test_boulder_01",
    "prop_test_boulder_02",
    "prop_test_boulder_03",
    "prop_test_boulder_04",
    "apa_mp_apa_crashed_usaf_01a",
    "ex_prop_exec_crashdp",
    "apa_mp_apa_yacht_o1_rail_a",
    "apa_mp_apa_yacht_o1_rail_b",
    "apa_mp_h_yacht_armchair_01",
    "apa_mp_h_yacht_armchair_03",
    "apa_mp_h_yacht_armchair_04",
    "apa_mp_h_yacht_barstool_01",
    "apa_mp_h_yacht_bed_01",
    "apa_mp_h_yacht_bed_02",
    "apa_mp_h_yacht_coffee_table_01",
    "apa_mp_h_yacht_coffee_table_02",
    "apa_mp_h_yacht_floor_lamp_01",
    "apa_mp_h_yacht_side_table_01",
    "apa_mp_h_yacht_side_table_02",
    "apa_mp_h_yacht_sofa_01",
    "apa_mp_h_yacht_sofa_02",
    "apa_mp_h_yacht_stool_01",
    "apa_mp_h_yacht_strip_chair_01",
    "apa_mp_h_yacht_table_lamp_01",
    "apa_mp_h_yacht_table_lamp_02",
    "apa_mp_h_yacht_table_lamp_03",
    "prop_flag_columbia",
    "apa_mp_apa_yacht_o2_rail_a",
    "apa_mp_apa_yacht_o2_rail_b",
    "apa_mp_apa_yacht_o3_rail_a",
    "apa_mp_apa_yacht_o3_rail_b",
    "apa_mp_apa_yacht_option1",
    "proc_searock_01",
    "apa_mp_h_yacht_",
    "apa_mp_apa_yacht_option1_cola",
    "apa_mp_apa_yacht_option2",
    "apa_mp_apa_yacht_option2_cola",
    "apa_mp_apa_yacht_option2_colb",
    "apa_mp_apa_yacht_option3",
    "apa_mp_apa_yacht_option3_cola",
    "apa_mp_apa_yacht_option3_colb",
    "apa_mp_apa_yacht_option3_colc",
    "apa_mp_apa_yacht_option3_cold",
    "apa_mp_apa_yacht_option3_cole",
    "apa_mp_apa_yacht_jacuzzi_cam",
    "apa_mp_apa_yacht_jacuzzi_ripple003",
    "apa_mp_apa_yacht_jacuzzi_ripple1",
    "apa_mp_apa_yacht_jacuzzi_ripple2",
    "apa_mp_apa_yacht_radar_01a",
    "apa_mp_apa_yacht_win",
    "prop_crashed_heli",
    "apa_mp_apa_yacht_door",
    "prop_shamal_crash",
    "xm_prop_x17_shamal_crash",
    "apa_mp_apa_yacht_door2",
    "apa_mp_apa_yacht",
    "prop_flagpole_2b",
    "prop_flagpole_2c",
    "prop_flag_canada",
    "apa_prop_yacht_float_1a",
    "apa_prop_yacht_float_1b",
    "apa_prop_yacht_glass_01",
    "apa_prop_yacht_glass_02",
    "apa_prop_yacht_glass_03",
    "apa_prop_yacht_glass_04",
    "apa_prop_yacht_glass_05",
    "apa_prop_yacht_glass_06",
    "apa_prop_yacht_glass_07",
    "apa_prop_yacht_glass_08",
    "apa_prop_yacht_glass_09",
    "apa_prop_yacht_glass_10",
    "prop_flag_canada_s",
    "prop_flag_eu",
    "prop_flag_eu_s",
    "prop_target_blue_arrow",
    "prop_target_orange_arrow",
    "prop_target_purp_arrow",
    "prop_target_red_arrow",
    "apa_prop_flag_argentina",
    "apa_prop_flag_australia",
    "apa_prop_flag_austria",
    "apa_prop_flag_belgium",
    "apa_prop_flag_brazil",
    "apa_prop_flag_canadat_yt",
    "apa_prop_flag_china",
    "apa_prop_flag_columbia",
    "apa_prop_flag_croatia",
    "apa_prop_flag_czechrep",
    "apa_prop_flag_denmark",
    "apa_prop_flag_england",
    "apa_prop_flag_eu_yt",
    "apa_prop_flag_finland",
    "apa_prop_flag_france",
    "apa_prop_flag_german_yt",
    "apa_prop_flag_hungary",
    "apa_prop_flag_ireland",
    "apa_prop_flag_israel",
    "apa_prop_flag_italy",
    "apa_prop_flag_jamaica",
    "apa_prop_flag_japan_yt",
    "apa_prop_flag_canada_yt",
    "apa_prop_flag_lstein",
    "apa_prop_flag_malta",
    "apa_prop_flag_mexico_yt",
    "apa_prop_flag_netherlands",
    "apa_prop_flag_newzealand",
    "apa_prop_flag_nigeria",
    "apa_prop_flag_norway",
    "apa_prop_flag_palestine",
    "apa_prop_flag_poland",
    "apa_prop_flag_portugal",
    "apa_prop_flag_puertorico",
    "apa_prop_flag_russia_yt",
    "apa_prop_flag_scotland_yt",
    "apa_prop_flag_script",
    "apa_prop_flag_slovakia",
    "apa_prop_flag_slovenia",
    "apa_prop_flag_southafrica",
    "apa_prop_flag_southkorea",
    "apa_prop_flag_spain",
    "apa_prop_flag_sweden",
    "apa_prop_flag_switzerland",
    "apa_prop_flag_turkey",
    "apa_prop_flag_uk_yt",
    "apa_prop_flag_us_yt",
    "apa_prop_flag_wales",
    "prop_flag_uk",
    "prop_flag_uk_s",
    "prop_flag_us",
    "prop_flag_usboat",
    "prop_flag_us_r",
    "prop_flag_us_s",
    "prop_flag_france",
    "prop_flag_france_s",
    "prop_flag_german",
    "prop_flag_german_s",
    "prop_flag_ireland",
    "prop_flag_ireland_s",
    "prop_flag_japan",
    "prop_flag_japan_s",
    "prop_flag_ls",
    "prop_flag_lsfd",
    "prop_flag_lsfd_s",
    "prop_flag_lsservices",
    "prop_flag_lsservices_s",
    "prop_flag_ls_s",
    "prop_flag_mexico",
    "prop_flag_mexico_s",
    "prop_flag_russia",
    "prop_flag_russia_s",
    "prop_flag_s",
    "prop_flag_sa",
    "prop_flag_sapd",
    "prop_flag_sapd_s",
    "prop_flag_sa_s",
    "prop_flag_scotland",
    "prop_flag_scotland_s",
    "prop_flag_sheriff",
    "prop_flag_sheriff_s",
    "prop_flag_uk",
    "prop_flag_uk_s",
    "prop_flag_us",
    "prop_flag_usboat",
    "prop_flag_us_r",
    "prop_flag_us_s",
    "prop_flamingo",
    "prop_swiss_ball_01",
    "prop_air_bigradar_l1",
    "prop_air_bigradar_l2",
    "prop_air_bigradar_slod",
    "p_fib_rubble_s",
    "prop_money_bag_01",
    "p_cs_mp_jet_01_s",
    "prop_poly_bag_money",
    "prop_air_radar_01",
    "hei_prop_carrier_radar_1",
    "prop_air_bigradar",
    "prop_carrier_radar_1_l1",
    "prop_asteroid_01",
    "prop_xmas_ext",
    "p_oil_pjack_01_amo",
    "p_oil_pjack_01_s",
    "p_oil_pjack_02_amo",
    "p_oil_pjack_03_amo",
    "p_oil_pjack_02_s",
    "p_oil_pjack_03_s",
    "prop_aircon_l_03",
    "prop_med_jet_01",
    "p_med_jet_01_s",
    "hei_prop_carrier_jet",
    "bkr_prop_biker_bblock_huge_01",
    "bkr_prop_biker_bblock_huge_02",
    "bkr_prop_biker_bblock_huge_04",
    "bkr_prop_biker_bblock_huge_05",
    "hei_prop_heist_emp",
    "prop_weed_01",
    "prop_air_bigradar",
    "prop_juicestand",
    "prop_lev_des_barge_02",
    "hei_prop_carrier_defense_01",
    "prop_aircon_m_04",
    "prop_mp_ramp_03",
    "stt_prop_stunt_track_bumps",
    "stt_prop_stunt_track_cutout",
    "stt_prop_stunt_track_dwlink",
    "stt_prop_stunt_track_dwlink_02",
    "stt_prop_stunt_track_dwsh15",
    "stt_prop_stunt_track_dwshort",
    "stt_prop_stunt_track_dwslope15",
    "stt_prop_stunt_track_dwslope30",
    "stt_prop_stunt_track_dwslope45",
    "stt_prop_stunt_track_dwturn",
    "stt_prop_stunt_track_dwuturn",
    "stt_prop_stunt_track_exshort",
    "stt_prop_stunt_track_fork",
    "stt_prop_stunt_track_funlng",
    "stt_prop_stunt_track_funnel",
    "stt_prop_stunt_track_hill",
    "stt_prop_stunt_track_hill2",
    "stt_prop_stunt_track_jump",
    "stt_prop_stunt_track_link",
    "stt_prop_stunt_track_otake",
    "stt_prop_stunt_track_sh15",
    "stt_prop_stunt_track_sh30",
    "stt_prop_stunt_track_sh45",
    "stt_prop_stunt_track_sh45_a",
    "stt_prop_stunt_track_short",
    "stt_prop_stunt_track_slope15",
    "stt_prop_stunt_track_slope30",
    "stt_prop_stunt_track_slope45",
    "stt_prop_stunt_track_st_01",
    "stt_prop_stunt_track_st_02",
    "stt_prop_stunt_track_start",
    "stt_prop_stunt_track_start_02",
    "stt_prop_stunt_track_straight",
    "stt_prop_stunt_track_straightice",
    "stt_prop_stunt_track_turn",
    "stt_prop_stunt_track_turnice",
    "stt_prop_stunt_track_uturn",
    "stt_prop_stunt_bowling_pin",
    "stt_prop_stunt_soccer_ball",
    "stt_prop_stunt_soccer_lball",
    "stt_prop_stunt_soccer_sball",
    "ch3_12_animplane1_lod",
    "ch3_12_animplane2_lod",
    "hei_prop_hei_pic_pb_plane",
    "light_plane_rig",
    "prop_cs_plane_int_01",
    "prop_dummy_plane",
    "prop_mk_plane",
    "v_44_planeticket",
    "prop_planer_01",
    "ch3_03_cliffrocks03b_lod",
    "ch3_04_rock_lod_02",
    "csx_coastsmalrock_01_",
    "csx_coastsmalrock_02_",
    "csx_coastsmalrock_03_",
    "csx_coastsmalrock_04_",
    "mp_player_introck",
    "Heist_Yacht",
    "csx_coastsmalrock_05_",
    "mp_player_int_rock",
    "mp_player_introck",
    "prop_flagpole_1a",
    "prop_flagpole_2a",
    "prop_flagpole_3a",
    "prop_a4_pile_01",
    "cs2_10_sea_rocks_lod",
    "cs2_11_sea_marina_xr_rocks_03_lod",
    "prop_gold_cont_01",
    "prop_hydro_platform",
    "ch3_04_viewplatform_slod",
    "ch2_03c_rnchstones_lod",
    "proc_mntn_stone01",
    "prop_beachflag_le",
    "proc_mntn_stone02",
    "cs2_10_sea_shipwreck_lod",
    "des_shipsink_02",
    "prop_dock_shippad",
    "des_shipsink_03",
    "des_shipsink_04",
    "prop_mk_flag",
    "prop_mk_flag_2",
    "proc_mntn_stone03",
    "FreeModeMale01",
    "rsn_os_specialfloatymetal_n",
    "rsn_os_specialfloatymetal",
    "cs1_09_sea_ufo",
    "dt1_tc_dufo_core",
    "dt1_tc_ufocore",
    "imp_prop_ship_01a",
    "dt1_tc_dufo_core_lod",
    "dt1_tc_dufo_core",
    "dt1_tc_dufo_lights",
    "dt1_tc_ufo_pivot",
    "dt1_tc_ufocore_col",
    "rsn_os_specialfloaty2_light2",
    "rsn_os_specialfloaty2_light",
    "rsn_os_specialfloaty2",
    "rsn_os_specialfloatymetal_n",
    "rsn_os_specialfloatymetal",
    "P_Spinning_Anus_S_Main",
    "P_Spinning_Anus_S_Root",
    "cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a",
    "sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a",
    "rnbj_wallsigns_0001",
    "proc_sml_stones01",
    "proc_sml_stones02",
    "maverick",
    "Miljet",
    "proc_sml_stones03",
    "proc_stones_01",
    "proc_stones_02",
    "proc_stones_03",
    "proc_stones_04",
    "proc_stones_05",
    "proc_stones_06",
    "prop_coral_stone_03",
    "prop_coral_stone_04",
    "prop_gravestones_01a",
    "prop_gravestones_02a",
    "prop_gravestones_03a",
    "prop_gravestones_04a",
    "prop_gravestones_05a",
    "prop_gravestones_06a",
    "prop_gravestones_07a",
    "prop_gravestones_08a",
    "prop_gravestones_09a",
    "prop_gravestones_10a",
    "prop_prlg_gravestone_05a_l1",
    "prop_prlg_gravestone_06a",
    "test_prop_gravestones_04a",
    "test_prop_gravestones_05a",
    "test_prop_gravestones_07a",
    "test_prop_gravestones_08a",
    "test_prop_gravestones_09a",
    "prop_prlg_gravestone_01a",
    "prop_prlg_gravestone_02a",
    "prop_prlg_gravestone_03a",
    "prop_prlg_gravestone_04a",
    "prop_stoneshroom1",
    "prop_stoneshroom2",
    "v_res_fa_stones01",
    "test_prop_gravestones_01a",
    "test_prop_gravestones_02a",
    "prop_prlg_gravestone_05a",
    "FreemodeFemale01",
    "p_cablecar_s",
    "stt_prop_stunt_tube_l",
    "stt_prop_stunt_track_dwuturn",
    "p_spinning_anus_s",
    "prop_windmill_01",
    "prop_windmill_01_l1",
    "prop_windmill_01_slod",
    "prop_windmill_01_slod2",
    "prop_rural_windmill",
    "prop_rural_windmill_l1",
    "prop_rural_windmill_l2",
    "prop_windmill1",
    "prop_windmill2",
    "ch2_03c_props_rrlwindmill_lod",
    "ch3_01_windmill_01",
    "ch3_01_windmill_02",
    "ch3_01_windmill_03",
    "ch3_01_windmill_04",
    "ch3_01_windmill_05",
    "ch3_01_windmill_06",
    "ch3_01_windmill_07",
    "ch3_01_windmill_08",
    "ch3_01_windmill_09",
    "ch3_01_windmill_10",
    "ch3_01_windmill_11",
    "ch3_01_windmill_12",
    "ch3_01_windmill_13",
    "ch3_01_windmill_14",
    "ch3_01_windmill_15",
    "cs2_03_windmill_dummy_01",
    "cs2_03_windmill_lod",
    "hei_prop_heist_tug",
    "prop_air_bigradar",
    "p_oil_slick_01",
    "prop_dummy_01",
    "hei_prop_heist_emp",
    "p_tram_cash_s",
    "hw1_blimp_ce2",
    "prop_fire_exting_1a",
    "prop_fire_exting_1b",
    "prop_fire_exting_2a",
    "prop_fire_exting_3a",
    "hw1_blimp_ce2_lod",
    "hw1_blimp_ce_lod",
    "hw1_blimp_cpr003",
    "hw1_blimp_cpr_null",
    "hw1_blimp_cpr_null2",
    "prop_lev_des_barage_02",
    "hei_prop_carrier_defense_01",
    "prop_juicestand",
    "S_M_M_MovAlien_01",
    "s_m_m_movalien_01",
    "s_m_m_movallien_01",
    "u_m_y_babyd",
    "CS_Orleans",
    "A_M_Y_ACult_01",
    "S_M_M_MovSpace_01",
    "U_M_Y_Zombie_01",
    "s_m_y_blackops_01",
    "a_f_y_topless_01",
    "a_c_boar",
    "a_c_cat_01",
    "a_c_chickenhawk",
    "a_c_chimp",
    "s_f_y_hooker_03",
    "a_c_chop",
    "a_c_cormorant",
    "a_c_coyote",
    "v_ilev_found_cranebucket",
    --"p_cs_sub_hook_01_s",
    "a_c_crow",
    "a_c_dolphin",
    "a_c_fish",
    --"hei_prop_heist_hook_01",
    --"prop_rope_hook_01",
    --"prop_sub_crane_hook",
    "s_f_y_hooker_01",
    --"prop_vehicle_hook",
    --"prop_v_hook_s",
    --"prop_dock_crane_02_hook",
    --"prop_winch_hook_long",
    "a_c_killerwhale",
    --"prop_coathook_01",
    --"prop_cs_sub_hook_01",
    "a_c_pug",
    "a_c_rabbit_01",
    "a_c_rat",
    "a_c_retriever",
    "a_c_rhesus",
    "a_c_rottweiler",
    "a_c_sharkhammer",
    "a_c_sharktiger",
    "a_c_shepherd",
    "a_c_stingray",
    "a_c_westy",
    "CS_Orleans",
    "prop_Ld_ferris_wheel",
    "p_tram_crash_s",
    "p_oil_slick_01",
    "p_ld_soc_ball_01",
    "p_parachute1_s",
    "p_cablecar_s",
    "prop_beach_fire",
    "prop_lev_des_barge_02",
    "prop_lev_des_barge_01",
    "prop_sculpt_fix",
    "prop_flagpole_2b",
    "prop_flagpole_2c",
    --"prop_winch_hook_short",
    "prop_flag_canada",
    "prop_flag_canada_s",
    "prop_flag_eu",
    "prop_flag_eu_s",
    "prop_flag_france",
    "prop_flag_france_s",
    "prop_flag_german",
    --"prop_ld_hook",
    "prop_flag_german_s",
    "prop_flag_ireland",
    "prop_flag_ireland_s",
    "prop_flag_japan",
    "prop_flag_japan_s",
    "prop_flag_ls",
    "prop_flag_lsfd",
    "prop_flag_lsfd_s",
    --"prop_cable_hook_01",
    "prop_flag_lsservices",
    "prop_flag_lsservices_s",
    "prop_flag_ls_s",
    "prop_flag_mexico",
    "prop_flag_mexico_s",
    "csx_coastboulder_00",
    "des_tankercrash_01",
    "des_tankerexplosion_01",
    "des_tankerexplosion_02",
    "des_trailerparka_02",
    "des_trailerparkb_02",
    "des_trailerparkc_02",
    "des_trailerparkd_02",
    "des_traincrash_root2",
    "des_traincrash_root3",
    "des_traincrash_root4",
    "des_traincrash_root5",
    "des_finale_vault_end",
    "des_finale_vault_root001",
    "des_finale_vault_root002",
    "des_finale_vault_root003",
    "des_finale_vault_root004",
    "des_finale_vault_start",
    "des_vaultdoor001_root001",
    "des_vaultdoor001_root002",
    "des_vaultdoor001_root003",
    "des_vaultdoor001_root004",
    "des_vaultdoor001_root005",
    "des_vaultdoor001_root006",
    "des_vaultdoor001_skin001",
    "des_vaultdoor001_start",
    "des_traincrash_root6",
    "prop_ld_vault_door",
    "prop_vault_door_scene",
    "prop_vault_door_scene",
    "prop_vault_shutter",
    "p_fin_vaultdoor_s",
    "v_ilev_bk_vaultdoor",
    "prop_gold_vault_fence_l",
    "prop_gold_vault_fence_r",
    "prop_gold_vault_gate_01",
    "prop_bank_vaultdoor",
    "des_traincrash_root7",
    "prop_flag_russia",
    "prop_flag_russia_s",
    "prop_flag_s",
    "ch2_03c_props_rrlwindmill_lod",
    "prop_flag_sa",
    "prop_flag_sapd",
    "prop_flag_sapd_s",
    "prop_flag_sa_s",
    "prop_flag_scotland",
    "prop_flag_scotland_s",
    "prop_flag_sheriff",
    "prop_flag_sheriff_s",
    "prop_flag_uk",
    "prop_yacht_lounger",
    "prop_yacht_seat_01",
    "prop_yacht_seat_02",
    "prop_yacht_seat_03",
    "marina_xr_rocks_02",
    "marina_xr_rocks_03",
    "prop_test_rocks01",
    "prop_test_rocks02",
    "prop_test_rocks03",
    "prop_test_rocks04",
    "marina_xr_rocks_04",
    "marina_xr_rocks_05",
    "marina_xr_rocks_06",
    "prop_yacht_table_01",
    "csx_searocks_02",
    "csx_searocks_03",
    "csx_searocks_04",
    "csx_searocks_05",
    "csx_searocks_06",
    "p_yacht_chair_01_s",
    "p_yacht_sofa_01_s",
    "prop_yacht_table_02",
    "csx_coastboulder_00",
    "csx_coastboulder_01",
    "csx_coastboulder_02",
    "csx_coastboulder_03",
    "csx_coastboulder_04",
    "csx_coastboulder_05",
    "csx_coastboulder_06",
    "csx_coastboulder_07",
    "csx_coastrok1",
    "csx_coastrok2",
    "csx_coastrok3",
    "csx_coastrok4",
    "csx_coastsmalrock_01",
    "csx_coastsmalrock_02",
    "csx_coastsmalrock_03",
    "csx_coastsmalrock_04",
    "csx_coastsmalrock_05",
    "prop_yacht_table_03",
    "prop_flag_uk_s",
    "prop_flag_us",
    "prop_flag_usboat",
    "prop_flag_us_r",
    "prop_flag_us_s",
    "p_gasmask_s",
    "prop_flamingo"
}

Citizen.CreateThread(
    function()
        while true do
            Wait(500)
            if (AntiCheat == true) then
                if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    v = GetVehiclePedIsIn(playerPed, false)
                end
                playerPed = GetPlayerPed(-1)
                if playerPed and v then
                    if GetPedInVehicleSeat(v, -1) == playerPed then
                        checkCar(GetVehiclePedIsIn(playerPed, false))
                    end
                end
            end
        end
    end
)

function checkCar(car)
    if car then
        carModel = GetEntityModel(car)
        carName = GetDisplayNameFromVehicleModel(carModel)
        if isCarBlacklisted(carModel) then
            _DeleteEntity(car)
            --TriggerServerEvent("AntiCheat:Cars", blacklistedCar)
        end
    end
end

function isCarBlacklisted(model)
    for _, blacklistedCar in pairs(CarsBL) do
        if model == GetHashKey(blacklistedCar) then
            return true
        end
    end

    return false
end

function _DeleteEntity(entity)
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            for _, theWeapon in ipairs(WeaponBL) do
                Wait(1)
                if (AntiCheat == true) then
                    if HasPedGotWeapon(PlayerPedId(), GetHashKey(theWeapon), false) == 1 then
                    --RemoveAllPedWeapons(PlayerPedId(),false)
                    end
                end
            end
        end
    end
)

function DeleteObjects(object, detach)
    if DoesEntityExist(object) or true then
        NetworkRequestControlOfEntity(object)
		--[[
        while not NetworkHasControlOfEntity(object) do
            Citizen.Wait(1)
        end
		]]
        if detach then
            DetachEntity(object, 0, false)
        end

        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            local ped = PlayerPedId()
            local handle, object = FindFirstObject()
            local finished = false
            repeat
                Wait(1)
                if (AntiCheat == true) then
                    if IsEntityAttached(object) and DoesEntityExist(object) then
                        if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
                            DeleteObjects(object, true)
                        end
                    end
                    for i = 1, #ObjectsBL do
					
                        local dd = GetEntityModel(object)
						if dd then
							local d = GetDisplayNameFromVehicleModel(dd)
							if d ~= "CARNOTFOUND" then
								DeleteObjects(object, false)
							end
						end
                        if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
                            DeleteObjects(object, true)
                        end
                    end
                end
                finished, object = FindNextObject(handle)
            until not finished
            EndFindObject(handle)
        end
    end
)

Citizen.CreateThread(
    function()
        while false do
            Citizen.Wait(1)
            if (AntiCheat == true) then
                if IsPedJumping(PlayerPedId()) then
                    local jumplength = 0
                    repeat
                        Wait(0)
                        jumplength = jumplength + 1
                        local isStillJumping = IsPedJumping(PlayerPedId())
                    until not isStillJumping
                    if jumplength > 250 then
                        --TriggerServerEvent("AntiCheat:Jump", jumplength)
                    end
                end
            end
        end
    end
)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieFunctionParameterString(anticheatm)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        --SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if anticheatm then
                scaleform = Initialize("mp_big_message_freemode")
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if (AntiCheat == true) then
                SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
            else
                SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
            end
        end
    end
)
--[[
RegisterNetEvent("AntiCheat:Toggle")
AddEventHandler(
    "AntiCheat:Toggle",
    function()
        if (AntiCheat == false) then
            AntiCheat = true
            AntiCheatStatus = "~g~Activ"
            anticheatm = "~y~AntiCheat ~g~Pornit"
            Citizen.Wait(5000)
            anticheatm = false
        else
            AntiCheat = false
            AntiCheatStatus = "~r~Inactiv"
            anticheatm = "~y~AntiCheat ~r~Oprit"
            PedStatus = "OFF"
            Citizen.Wait(5000)
            anticheatm = false
        end
    end
)

[[--Citizen.CreateThread(
    function()
        while (true) do
            Citizen.Wait(3000)
            if (AntiCheat == true) then
                KillAllPeds()
                DeleteEntity(ped)
            end
        end
    end
)]]

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)

            local next = true
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3000)
            if (AntiCheat == true) then
                thePeds = EnumeratePeds()
                PedStatus = 0
                for ped in thePeds do
                    PedStatus = PedStatus + 1
                    if not (IsPedAPlayer(ped)) then
                        DeleteEntity(ped)
                        RemoveAllPedWeapons(ped, true)
                    end
                end
            end
        end
    end
)

function ACstatus(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if (outline) then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function KillAllPeds()
    local pedweapon
    local pedid
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) then
            pedid = GetEntityModel(ped)
            pedweapon = GetSelectedPedWeapon(ped)
            if pedweapon == -1312131151 or false then
                ApplyDamageToPed(ped, 1000, false)
                DeleteEntity(ped)
            else
                switch = function(choice)
                    choice = choice and tonumber(choice) or choice

                    case = {
                        [451459928] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [1684083350] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [451459928] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [1096929346] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [880829941] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [-1404353274] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        [2109968527] = function()
                            ApplyDamageToPed(ped, 1000, false)
                            DeleteEntity(ped)
                        end,
                        default = function()
                        end
                    }

                    if case[choice] then
                        case[choice]()
                    else
                        case["default"]()
                    end
                end
                switch(pedid)
            end
        end
    end
end

--[[
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            rgb = RGBRainbow(2)
            ACstatus(0.28, 0.90, 1.0, 1.0, 0.35, "안티치트: " .. AntiCheatStatus, rgb.r, rgb.g, rgb.b, 255, 200)
            ACstatus(0.28, 0.90 + 0.03, 1.0, 1.0, 0.3, "~w~접속인원: ~r~" .. PedStatus, rgb.r, rgb.g, rgb.b, 225)
        end
    end
)
]]