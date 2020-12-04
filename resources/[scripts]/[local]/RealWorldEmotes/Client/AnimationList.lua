DP = {}

DP.Expressions = {
    ["화남"] = {"Expression", "mood_angry_1"},
    ["음주"] = {"Expression", "mood_drunk_1"},
    ["우둔하게"] = {"Expression", "pose_injured_1"},
    ["감전됨"] = {"Expression", "electrocuted_1"},
    ["심술"] = {"Expression", "effort_1"},
    ["심술2"] = {"Expression", "mood_drivefast_1"},
    ["심술3"] = {"Expression", "pose_angry_1"},
    ["행복한"] = {"Expression", "mood_happy_1"},
    ["부상"] = {"Expression", "mood_injured_1"},
    ["즐거운"] = {"Expression", "mood_dancing_low_1"},
    ["한숨"] = {"Expression", "smoking_hold_1"},
    ["깜박이지않음"] = {"Expression", "pose_normal_1"},
    ["깜박"] = {"Expression", "pose_aiming_1"},
    ["충격"] = {"Expression", "shocked_1"},
    ["충격2"] = {"Expression", "shocked_2"},
    ["자기"] = {"Expression", "mood_sleeping_1"},
    ["자기2"] = {"Expression", "dead_1"},
    ["자기3"] = {"Expression", "dead_2"},
    ["스머그"] = {"Expression", "mood_smug_1"},
    ["추측"] = {"Expression", "mood_aiming_1"},
    ["스트레스"] = {"Expression", "mood_stressed_1"},
    ["찡그림"] = {"Expression", "mood_sulk_1"},
    ["이상한"] = {"Expression", "effort_2"},
    ["이상한2"] = {"Expression", "effort_3"}
}

DP.Walks = {
    ["외계인"] = {"move_m@alien"},
    ["기갑"] = {"anim_group_move_ballistic"},
    ["거만한"] = {"move_f@arrogant@a"},
    ["용감한"] = {"move_m@brave"},
    ["캐주얼"] = {"move_m@casual@a"},
    ["캐주얼2"] = {"move_m@casual@b"},
    ["캐주얼3"] = {"move_m@casual@c"},
    ["캐주얼4"] = {"move_m@casual@d"},
    ["캐주얼5"] = {"move_m@casual@e"},
    ["캐주얼6"] = {"move_m@casual@f"},
    ["치치"] = {"move_f@chichi"},
    ["자신감"] = {"move_m@confident"},
    ["경찰"] = {"move_m@business@a"},
    ["경찰2"] = {"move_m@business@b"},
    ["경찰3"] = {"move_m@business@c"},
    ["기본 여자"] = {"move_f@multiplayer"},
    ["기본 남자"] = {"move_m@multiplayer"},
    ["취한"] = {"move_m@drunk@a"},
    ["취한"] = {"move_m@drunk@slightlydrunk"},
    ["취한2"] = {"move_m@buzzed"},
    ["취한3"] = {"move_m@drunk@verydrunk"},
    ["팜므"] = {"move_f@femme@"},
    ["불"] = {"move_characters@franklin@fire"},
    ["불2"] = {"move_characters@michael@fire"},
    ["불3"] = {"move_m@fire"},
    ["서두르기"] = {"move_f@flee@a"},
    ["프랭클린"] = {"move_p_m_one"},
    ["갱스터"] = {"move_m@gangster@generic"},
    ["갱스터2"] = {"move_m@gangster@ng"},
    ["갱스터3"] = {"move_m@gangster@var_e"},
    ["갱스터4"] = {"move_m@gangster@var_f"},
    ["갱스터5"] = {"move_m@gangster@var_i"},
    ["그루빙"] = {"anim@move_m@grooving@"},
    ["가드"] = {"move_m@prison_gaurd"},
    ["수갑"] = {"move_m@prisoner_cuffed"},
    ["뒷굽"] = {"move_f@heels@c"},
    ["뒷굽2"] = {"move_f@heels@d"},
    ["등산"] = {"move_m@hiking"},
    ["유행"] = {"move_m@hipster@a"},
    ["노동자"] = {"move_m@hobo@a"},
    ["서두르기2"] = {"move_f@hurry@a"},
    ["관리인"] = {"move_p_m_zero_janitor"},
    ["관리인2"] = {"move_p_m_zero_slow"},
    ["가벼운 흔들림"] = {"move_m@jog@"},
    ["레마르"] = {"anim_group_move_lemar_alley"},
    ["레스터"] = {"move_heist_lester"},
    ["레스터2"] = {"move_lester_caneup"},
    ["매너"] = {"move_f@maneater"},
    ["마이클"] = {"move_ped_bucket"},
    ["돈"] = {"move_m@money"},
    ["근육"] = {"move_m@muscle@a"},
    ["우아한"] = {"move_m@posh@"},
    ["우아한2"] = {"move_f@posh@"},
    ["빨리"] = {"move_m@quick"},
    ["달리기"] = {"female_fast_runner"},
    ["슬픈"] = {"move_m@sad@a"},
    ["콧대"] = {"move_m@sassy"},
    ["콧대2"] = {"move_f@sassy"},
    ["깜짝 놀란"] = {"move_f@scared"},
    ["섹시"] = {"move_f@sexy@a"},
    ["그늘진"] = {"move_m@shadyped@a"},
    ["느리게"] = {"move_characters@jimmy@slow@"},
    ["스웨거"] = {"move_m@swagger"},
    ["강인한"] = {"move_m@tough_guy@"},
    ["강인한2"] = {"move_f@tough_guy@"},
    ["부랑자"] = {"clipset@move@trash_fast_turn"},
    ["부랑자2"] = {"missfbi4prepp1_garbageman"},
    ["트레버"] = {"move_p_m_two"},
    ["넓게"] = {"move_m@bag"}
}

DP.Shared = {
    --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
    -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
    -- targetemote is used for animations that have a corresponding animation to the other player.
    ["handshake"] = {
        "mp_ped_interaction",
        "handshake_guy_a",
        "악수",
        "handshake2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000,
            SyncOffsetFront = 0.9
        }
    },
    ["handshake2"] = {
        "mp_ped_interaction",
        "handshake_guy_b",
        "악수2",
        "handshake",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["hug"] = {
        "mp_ped_interaction",
        "kisses_guy_a",
        "포옹",
        "hug2",
        AnimationOptions = {
            EmoteMoving = false,
            EmoteDuration = 5000,
            SyncOffsetFront = 1.05
        }
    },
    ["hug2"] = {
        "mp_ped_interaction",
        "kisses_guy_b",
        "포옹2",
        "hug",
        AnimationOptions = {
            EmoteMoving = false,
            EmoteDuration = 5000,
            SyncOffsetFront = 1.13
        }
    },
    ["bro"] = {
        "mp_ped_interaction",
        "hugs_guy_a",
        "형제",
        "bro2",
        AnimationOptions = {
            SyncOffsetFront = 1.14
        }
    },
    ["bro2"] = {
        "mp_ped_interaction",
        "hugs_guy_b",
        "형제2",
        "bro",
        AnimationOptions = {
            SyncOffsetFront = 1.14
        }
    },
    ["give"] = {
        "mp_common",
        "givetake1_a",
        "주기",
        "give2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["give2"] = {
        "mp_common",
        "givetake1_b",
        "주기2",
        "give",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "야구", "baseballthrow"},
    ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "야구 던지기", "baseball"},
    ["stickup"] = {
        "random@countryside_gang_fight",
        "biker_02_stickup_loop",
        "스틱 업",
        "stickupscared",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["stickupscared"] = {
        "missminuteman_1ig_2",
        "handsup_base",
        "스틱업 놀란",
        "stickup",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "펀치", "punched"},
    ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "펀치맞음", "punch"},
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "박치기", "headbutted"},
    ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "박치기2", "headbutt"},
    ["slap2"] = {
        "melee@unarmed@streamed_variations",
        "plyr_takedown_front_backslap",
        "슬랩2",
        "slapped2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["slap"] = {
        "melee@unarmed@streamed_variations",
        "plyr_takedown_front_slap",
        "슬랩",
        "slapped",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
    ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"}
}

DP.Dances = {
    ["dancef"] = {
        "anim@amb@nightclub@dancers@solomun_entourage@",
        "mi_dance_facedj_17_v1_female^1",
        "댄스 F",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancef2"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "high_center",
        "댄스 F2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancef3"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "high_center_up",
        "댄스 F3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancef4"] = {
        "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity",
        "hi_dance_facedj_09_v2_female^1",
        "댄스 F4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancef5"] = {
        "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity",
        "hi_dance_facedj_09_v2_female^3",
        "댄스 F5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancef6"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "high_center_up",
        "댄스 F6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceslow2"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "low_center",
        "느린 댄스 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceslow3"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "low_center_down",
        "느린 댄스 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceslow4"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
        "low_center",
        "느린 댄스 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance"] = {
        "anim@amb@nightclub@dancers@podium_dancers@",
        "hi_dance_facedj_17_v2_male^5",
        "댄스",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance2"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
        "high_center_down",
        "댄스 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance3"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@",
        "high_center",
        "댄스 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance4"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
        "high_center_up",
        "댄스 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceupper"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
        "high_center",
        "상체 댄스",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["danceupper2"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
        "high_center_up",
        "상체 댄스 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["danceshy"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@",
        "low_center",
        "수줍은 댄스",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceshy2"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
        "low_center_down",
        "수줍은 댄스 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceslow"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
        "low_center",
        "느린 댄스",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly9"] = {
        "rcmnigel1bnmt_1b",
        "dance_loop_tyler",
        "바보 댄스 9",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance6"] = {
        "misschinese2_crystalmazemcs1_cs",
        "dance_loop_tao",
        "댄스 6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance7"] = {
        "misschinese2_crystalmazemcs1_ig",
        "dance_loop_tao",
        "댄스 7",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance8"] = {
        "missfbi3_sniping",
        "dance_m_default",
        "댄스 8",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly"] = {
        "special_ped@mountain_dancer@monologue_3@monologue_3a",
        "mnt_dnc_buttwag",
        "바보 댄스",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly2"] = {
        "move_clown@p_m_zero_idles@",
        "fidget_short_dance",
        "바보 댄스 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly3"] = {
        "move_clown@p_m_two_idles@",
        "fidget_short_dance",
        "바보 댄스 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly4"] = {
        "anim@amb@nightclub@lazlow@hi_podium@",
        "danceidle_hi_11_buttwiggle_b_laz",
        "바보 댄스 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly5"] = {
        "timetable@tracy@ig_5@idle_a",
        "idle_a",
        "바보 댄스 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly6"] = {
        "timetable@tracy@ig_8@idle_b",
        "idle_d",
        "바보 댄스 6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance9"] = {
        "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        "med_center_up",
        "댄스 9",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly8"] = {
        "anim@mp_player_intcelebrationfemale@the_woogie",
        "the_woogie",
        "바보 댄스 8",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dancesilly7"] = {
        "anim@amb@casino@mini@dance@dance_solo@female@var_b@",
        "high_center",
        "바보 댄스 7",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["dance5"] = {
        "anim@amb@casino@mini@dance@dance_solo@female@var_a@",
        "med_center",
        "댄스 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["danceglowstick"] = {
        "anim@amb@nightclub@lazlow@hi_railing@",
        "ambclub_13_mi_hi_sexualgriding_laz",
        "스틱 댄스",
        AnimationOptions = {
            Prop = "ba_prop_battle_glowstick_01",
            PropBone = 28422,
            PropPlacement = {0.0700, 0.1400, 0.0, -80.0, 20.0},
            SecondProp = "ba_prop_battle_glowstick_01",
            SecondPropBone = 60309,
            SecondPropPlacement = {0.0700, 0.0900, 0.0, -120.0, -20.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["danceglowstick2"] = {
        "anim@amb@nightclub@lazlow@hi_railing@",
        "ambclub_12_mi_hi_bootyshake_laz",
        "스틱 댄스 2",
        AnimationOptions = {
            Prop = "ba_prop_battle_glowstick_01",
            PropBone = 28422,
            PropPlacement = {0.0700, 0.1400, 0.0, -80.0, 20.0},
            SecondProp = "ba_prop_battle_glowstick_01",
            SecondPropBone = 60309,
            SecondPropPlacement = {0.0700, 0.0900, 0.0, -120.0, -20.0},
            EmoteLoop = true
        }
    },
    ["danceglowstick3"] = {
        "anim@amb@nightclub@lazlow@hi_railing@",
        "ambclub_09_mi_hi_bellydancer_laz",
        "스틱 댄스 3",
        AnimationOptions = {
            Prop = "ba_prop_battle_glowstick_01",
            PropBone = 28422,
            PropPlacement = {0.0700, 0.1400, 0.0, -80.0, 20.0},
            SecondProp = "ba_prop_battle_glowstick_01",
            SecondPropBone = 60309,
            SecondPropPlacement = {0.0700, 0.0900, 0.0, -120.0, -20.0},
            EmoteLoop = true
        }
    },
    ["dancehorse"] = {
        "anim@amb@nightclub@lazlow@hi_dancefloor@",
        "dancecrowd_li_15_handup_laz",
        "말타기 댄스",
        AnimationOptions = {
            Prop = "ba_prop_battle_hobby_horse",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["dancehorse2"] = {
        "anim@amb@nightclub@lazlow@hi_dancefloor@",
        "crowddance_hi_11_handup_laz",
        "말타기 댄스 2",
        AnimationOptions = {
            Prop = "ba_prop_battle_hobby_horse",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true
        }
    },
    ["dancehorse3"] = {
        "anim@amb@nightclub@lazlow@hi_dancefloor@",
        "dancecrowd_li_11_hu_shimmy_laz",
        "말타기 댄스 3",
        AnimationOptions = {
            Prop = "ba_prop_battle_hobby_horse",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true
        }
    }
}

DP.Emotes = {
    ["drink"] = {
        "mp_player_inteat@pnq",
        "loop",
        "음주",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2500
        }
    },
    ["beast"] = {
        "anim@mp_fm_event@intro",
        "beast_transform",
        "짐승",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 5000
        }
    },
    ["chill"] = {
        "switch@trevor@scares_tramp",
        "trev_scares_tramp_idle_tramp",
        "오한",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["cloudgaze"] = {
        "switch@trevor@annoys_sunbathers",
        "trev_annoys_sunbathers_loop_girl",
        "바라보기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["cloudgaze2"] = {
        "switch@trevor@annoys_sunbathers",
        "trev_annoys_sunbathers_loop_guy",
        "바라보기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["prone"] = {
        "missfbi3_sniping",
        "prone_dave",
        "수그리기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pullover"] = {
        "misscarsteal3pullover",
        "pull_over_right",
        "풀오버",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1300
        }
    },
    ["idle"] = {
        "anim@heists@heist_corona@team_idles@male_a",
        "idle",
        "멍때리기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
    ["idle9"] = {
        "friends@fra@ig_1",
        "base_idle",
        "멍때리기 9",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle10"] = {
        "mp_move@prostitute@m@french",
        "idle",
        "멍때리기 10",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["idle11"] = {
        "random@countrysiderobbery",
        "idle_a",
        "멍때리기 11",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle2"] = {
        "anim@heists@heist_corona@team_idles@female_a",
        "idle",
        "멍때리기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle3"] = {
        "anim@heists@humane_labs@finale@strip_club",
        "ped_b_celebrate_loop",
        "멍때리기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle4"] = {
        "anim@mp_celebration@idles@female",
        "celebration_idle_f_a",
        "멍때리기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle5"] = {
        "anim@mp_corona_idles@female_b@idle_a",
        "idle_a",
        "멍때리기 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle6"] = {
        "anim@mp_corona_idles@male_c@idle_a",
        "idle_a",
        "멍때리기 6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idle7"] = {
        "anim@mp_corona_idles@male_d@idle_a",
        "idle_a",
        "멍때리기 7",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["wait3"] = {
        "amb@world_human_hang_out_street@female_hold_arm@idle_a",
        "idle_a",
        "기다림 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idledrunk"] = {
        "random@drunk_driver_1",
        "drunk_driver_stand_loop_dd1",
        "취한",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idledrunk2"] = {
        "random@drunk_driver_1",
        "drunk_driver_stand_loop_dd2",
        "취한 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["idledrunk3"] = {
        "missarmenian2",
        "standing_idle_loop_drunk",
        "취한 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "에어 기타"},
    ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "에어 북"},
    ["argue"] = {
        "misscarsteal4@actor",
        "actor_berating_loop",
        "설득",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["argue2"] = {
        "oddjobs@assassinate@vice@hooker",
        "argue_a",
        "설득 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["bartender"] = {
        "anim@amb@clubhouse@bar@drink@idle_a",
        "idle_a_bartender",
        "바텐더",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
    ["blowkiss2"] = {
        "anim@mp_player_intselfieblow_kiss",
        "exit",
        "Blow Kiss 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
    ["bringiton"] = {
        "misscommon@response",
        "bring_it_on",
        "Bring It On",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["comeatmebro"] = {
        "mini@triathlon",
        "want_some_of_this",
        "Come at me bro",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["cop2"] = {
        "anim@amb@nightclub@peds@",
        "rcmme_amanda1_stand_loop_cop",
        "경찰 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["cop3"] = {
        "amb@code_human_police_investigate@idle_a",
        "idle_b",
        "경찰 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["crossarms"] = {
        "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        "idle_a",
        "팔짱끼기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["crossarms2"] = {
        "amb@world_human_hang_out_street@male_c@idle_a",
        "idle_b",
        "팔짱끼기 2",
        AnimationOptions = {
            EmoteMoving = true
        }
    },
    ["crossarms3"] = {
        "anim@heists@heist_corona@single_team",
        "single_team_loop_boss",
        "팔짱끼기 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["crossarms4"] = {
        "random@street_race",
        "_car_b_lookout",
        "팔짱끼기 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["crossarms5"] = {
        "anim@amb@nightclub@peds@",
        "rcmme_amanda1_stand_loop_cop",
        "팔짱끼기 5",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["foldarms2"] = {
        "anim@amb@nightclub@peds@",
        "rcmme_amanda1_stand_loop_cop",
        "팔접기 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["crossarms6"] = {
        "random@shop_gunstore",
        "_idle",
        "팔짱끼기 6",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["foldarms"] = {
        "anim@amb@business@bgen@bgen_no_work@",
        "stand_phone_phoneputdown_idle_nowork",
        "팔접기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["crossarmsside"] = {
        "rcmnigel1a_band_groupies",
        "base_m2",
        "팔짱끼기 측면",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["damn"] = {
        "gestures@m@standing@casual",
        "gesture_damn",
        "젠장",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["damn2"] = {
        "anim@am_hold_up@male",
        "shoplift_mid",
        "젠장 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["pointdown"] = {
        "gestures@f@standing@casual",
        "gesture_hand_down",
        "포인트 다운",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["surrender"] = {
        "random@arrests@busted",
        "idle_a",
        "항복",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["facepalm2"] = {
        "anim@mp_player_intcelebrationfemale@face_palm",
        "face_palm",
        "페이스팜 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 8000
        }
    },
    ["facepalm"] = {
        "random@car_thief@agitated@idle_a",
        "agitated_idle_a",
        "페이스팜",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 8000
        }
    },
    ["facepalm3"] = {
        "missminuteman_1ig_2",
        "tasered_2",
        "페이스팜 3",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 8000
        }
    },
    ["facepalm4"] = {
        "anim@mp_player_intupperface_palm",
        "idle_a",
        "페이스팜 4",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
    ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
    ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
    ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
    ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
    ["fallasleep"] = {
        "mp_sleep",
        "sleep_loop",
        "Fall Asleep",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
    ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
    ["finger"] = {
        "anim@mp_player_intselfiethe_bird",
        "idle_a",
        "뻐큐",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["finger2"] = {
        "anim@mp_player_intupperfinger",
        "idle_a_fp",
        "뻐큐 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["handshake"] = {
        "mp_ped_interaction",
        "handshake_guy_a",
        "악수",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["handshake2"] = {
        "mp_ped_interaction",
        "handshake_guy_b",
        "악수 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["wait4"] = {
        "amb@world_human_hang_out_street@Female_arm_side@idle_a",
        "idle_a",
        "기다림 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["wait5"] = {
        "missclothing",
        "idle_storeclerk",
        "기다림 5",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait6"] = {
        "timetable@amanda@ig_2",
        "ig_2_base_amanda",
        "기다림 6",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait7"] = {
        "rcmnigel1cnmt_1c",
        "base",
        "기다림 7",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait8"] = {
        "rcmjosh1",
        "idle",
        "기다림 8",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait9"] = {
        "rcmjosh2",
        "josh_2_intp1_base",
        "기다림 9",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait10"] = {
        "timetable@amanda@ig_3",
        "ig_3_base_tracy",
        "기다림 10",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait11"] = {
        "misshair_shop@hair_dressers",
        "keeper_base",
        "기다림 11",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["hiking"] = {
        "move_m@hiking",
        "idle",
        "등산",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "포옹"},
    ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "포옹 2"},
    ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "포옹 3"},
    ["inspect"] = {"random@train_tracks", "idle_e", "검사"},
    ["jazzhands"] = {
        "anim@mp_player_intcelebrationfemale@jazz_hands",
        "jazz_hands",
        "재즈 핸즈",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 6000
        }
    },
    ["jog2"] = {
        "amb@world_human_jog_standing@male@idle_a",
        "idle_a",
        "가벼운 흔들림 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["jog3"] = {
        "amb@world_human_jog_standing@female@idle_a",
        "idle_a",
        "가벼운 흔들림 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["jog4"] = {
        "amb@world_human_power_walker@female@idle_a",
        "idle_a",
        "가벼운 흔들림 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["jog5"] = {
        "move_m@joy@a",
        "walk",
        "가벼운 흔들림 5",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["jumpingjacks"] = {
        "timetable@reunited@ig_2",
        "jimmy_getknocked",
        "점프 잭",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["kneel2"] = {
        "rcmextreme3",
        "idle",
        "무릎 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["kneel3"] = {
        "amb@world_human_bum_wash@male@low@idle_a",
        "idle_a",
        "무릎 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["knock"] = {
        "timetable@jimmy@doorknock@",
        "knockdoor_idle",
        "노크",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["knock2"] = {
        "missheistfbi3b_ig7",
        "lift_fibagent_loop",
        "노크 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["knucklecrunch"] = {
        "anim@mp_player_intcelebrationfemale@knuckle_crunch",
        "knuckle_crunch",
        "노크 크런치",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
    ["lean2"] = {
        "amb@world_human_leaning@female@wall@back@hand_up@idle_a",
        "idle_a",
        "기대기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lean3"] = {
        "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a",
        "idle_a",
        "기대기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lean4"] = {
        "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
        "idle_a",
        "기대기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lean5"] = {
        "amb@world_human_leaning@male@wall@back@hands_together@idle_b",
        "idle_b",
        "기대기 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["leanflirt"] = {
        "random@street_race",
        "_car_a_flirt_girl",
        "기대기 급격히",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["leanbar2"] = {
        "amb@prop_human_bum_shopping_cart@male@idle_a",
        "idle_c",
        "바에 기대기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["leanbar3"] = {
        "anim@amb@nightclub@lazlow@ig1_vip@",
        "clubvip_base_laz",
        "바에 기대기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["leanbar4"] = {
        "anim@heists@prison_heist",
        "ped_b_loop_a",
        "바에 기대기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["leanhigh"] = {
        "anim@mp_ferris_wheel",
        "idle_a_player_one",
        "기대기 높이",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["leanhigh2"] = {
        "anim@mp_ferris_wheel",
        "idle_a_player_two",
        "기대기 높이 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["leanside"] = {
        "timetable@mime@01_gc",
        "idle_a",
        "측면 기대기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["leanside2"] = {
        "misscarstealfinale",
        "packer_idle_1_trevor",
        "측면 기대기 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["leanside3"] = {
        "misscarstealfinalecar_5_ig_1",
        "waitloop_lamar",
        "측면 기대기 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["leanside4"] = {
        "misscarstealfinalecar_5_ig_1",
        "waitloop_lamar",
        "측면 기대기 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false
        }
    },
    ["leanside5"] = {
        "rcmjosh2",
        "josh_2_intp1_base",
        "측면 기대기 5",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false
        }
    },
    ["me"] = {
        "gestures@f@standing@casual",
        "gesture_me_hard",
        "나",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["mechanic"] = {
        "mini@repair",
        "fixing_a_ped",
        "메카닉",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["mechanic2"] = {
        "amb@world_human_vehicle_mechanic@male@base",
        "idle_a",
        "메카닉 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["mechanic3"] = {
        "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        "machinic_loop_mechandplayer",
        "메카닉 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["mechanic4"] = {
        "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        "machinic_loop_mechandplayer",
        "메카닉 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["medic2"] = {
        "amb@medic@standing@tendtodead@base",
        "base",
        "메딕 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["meditate"] = {
        "rcmcollect_paperleadinout@",
        "meditiate_idle",
        "명상",
        AnimationOptions = {
            -- CHANGE ME
            EmoteLoop = true
        }
    },
    ["meditate2"] = {
        "rcmepsilonism3",
        "ep_3_rcm_marnie_meditating",
        "명상 2",
        AnimationOptions = {
            -- CHANGE ME
            EmoteLoop = true
        }
    },
    ["meditate3"] = {
        "rcmepsilonism3",
        "base_loop",
        "명상 3",
        AnimationOptions = {
            -- CHANGE ME
            EmoteLoop = true
        }
    },
    ["metal"] = {
        "anim@mp_player_intincarrockstd@ps@",
        "idle_a",
        "금속",
        AnimationOptions = {
            -- CHANGE ME
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["no"] = {
        "anim@heists@ornate_bank@chat_manager",
        "fail",
        "아니요",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["no2"] = {
        "mp_player_int_upper_nod",
        "mp_player_int_nod_no",
        "아니요 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["nosepick"] = {
        "anim@mp_player_intcelebrationfemale@nose_pick",
        "nose_pick",
        "Nose Pick",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["noway"] = {
        "gestures@m@standing@casual",
        "gesture_no_way",
        "절대 안되",
        AnimationOptions = {
            EmoteDuration = 1500,
            EmoteMoving = true
        }
    },
    ["ok"] = {
        "anim@mp_player_intselfiedock",
        "idle_a",
        "좋아",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["outofbreath"] = {
        "re@construction",
        "out_of_breath",
        "숨 내뱉기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
    ["push"] = {
        "missfinale_c2ig_11",
        "pushcar_offcliff_f",
        "밀기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["push2"] = {
        "missfinale_c2ig_11",
        "pushcar_offcliff_m",
        "밀기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["point"] = {
        "gestures@f@standing@casual",
        "gesture_point",
        "포인트",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["pushup"] = {
        "amb@world_human_push_ups@male@idle_a",
        "idle_d",
        "팔굽혀펴기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["countdown"] = {
        "random@street_race",
        "grid_girl_race_start",
        "카운트다운",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["pointright"] = {
        "mp_gun_shop_tut",
        "indicate_right",
        "포인트 오른쪽",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["salute"] = {
        "anim@mp_player_intincarsalutestd@ds@",
        "idle_a",
        "경례",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["salute2"] = {
        "anim@mp_player_intincarsalutestd@ps@",
        "idle_a",
        "경례 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["salute3"] = {
        "anim@mp_player_intuppersalute",
        "idle_a",
        "경례 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["scared"] = {
        "random@domestic",
        "f_distressed_loop",
        "깜짝 놀란",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["scared2"] = {
        "random@homelandsecurity",
        "knees_loop_girl",
        "깜짝 놀란 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["screwyou"] = {
        "misscommon@response",
        "screw_you",
        "Screw You",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["shakeoff"] = {
        "move_m@_idles@shake_off",
        "shakeoff_1",
        "Shake Off",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3500
        }
    },
    ["shot"] = {
        "random@dealgonewrong",
        "idle_a",
        "사격",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sleep"] = {
        "timetable@tracy@sleep@",
        "idle_c",
        "자기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["shrug"] = {
        "gestures@f@standing@casual",
        "gesture_shrug_hard",
        "어깨를 으쓱",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["shrug2"] = {
        "gestures@m@standing@casual",
        "gesture_shrug_hard",
        "어깨를 으쓱 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["sit"] = {
        "anim@amb@business@bgen@bgen_no_work@",
        "sit_phone_phoneputdown_idle_nowork",
        "앉기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit2"] = {
        "rcm_barry3",
        "barry_3_sit_loop",
        "앉기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit3"] = {
        "amb@world_human_picnic@male@idle_a",
        "idle_a",
        "앉기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit4"] = {
        "amb@world_human_picnic@female@idle_a",
        "idle_a",
        "앉기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit5"] = {
        "anim@heists@fleeca_bank@ig_7_jetski_owner",
        "owner_idle",
        "앉기 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit6"] = {
        "timetable@jimmy@mics3_ig_15@",
        "idle_a_jimmy",
        "앉기 6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit7"] = {
        "anim@amb@nightclub@lazlow@lo_alone@",
        "lowalone_base_laz",
        "앉기 7",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit8"] = {
        "timetable@jimmy@mics3_ig_15@",
        "mics3_15_base_jimmy",
        "앉기 8",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sit9"] = {
        "amb@world_human_stupor@male@idle_a",
        "idle_a",
        "앉기 9",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitlean"] = {
        "timetable@tracy@ig_14@",
        "ig_14_base_tracy",
        "앉기 기대기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitsad"] = {
        "anim@amb@business@bgen@bgen_no_work@",
        "sit_phone_phoneputdown_sleeping-noworkfemale",
        "앉기 슬픈",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitscared"] = {
        "anim@heists@ornate_bank@hostages@hit",
        "hit_loop_ped_b",
        "앉기 놀란",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitscared2"] = {
        "anim@heists@ornate_bank@hostages@ped_c@",
        "flinch_loop",
        "앉기 놀란 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitscared3"] = {
        "anim@heists@ornate_bank@hostages@ped_e@",
        "flinch_loop",
        "앉기 놀란 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitdrunk"] = {
        "timetable@amanda@drunk@base",
        "base",
        "앉기 취한",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchair2"] = {
        "timetable@ron@ig_5_p3",
        "ig_5_p3_base",
        "의자에 앉기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchair3"] = {
        "timetable@reunited@ig_10",
        "base_amanda",
        "의자에 앉기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchair4"] = {
        "timetable@ron@ig_3_couch",
        "base",
        "의자에 앉기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchair5"] = {
        "timetable@jimmy@mics3_ig_15@",
        "mics3_15_base_tracy",
        "의자에 앉기 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchair6"] = {
        "timetable@maid@couch@",
        "base",
        "의자에 앉기 6",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sitchairside"] = {
        "timetable@ron@ron_ig_2_alt1",
        "ig_2_alt1_base",
        "의자에 앉기 측면",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["situp"] = {
        "amb@world_human_sit_ups@male@idle_a",
        "idle_a",
        "일어나기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["clapangry"] = {
        "anim@arena@celeb@flat@solo@no_props@",
        "angry_clap_a_player_a",
        "빠른 박수",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["slowclap3"] = {
        "anim@mp_player_intupperslow_clap",
        "idle_a",
        "느린 박수 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["clap"] = {
        "amb@world_human_cheering@male_a",
        "base",
        "박수",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["slowclap"] = {
        "anim@mp_player_intcelebrationfemale@slow_clap",
        "slow_clap",
        "느린 박수",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["slowclap2"] = {
        "anim@mp_player_intcelebrationmale@slow_clap",
        "slow_clap",
        "느린 박수 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["smell"] = {
        "move_p_m_two_idles@generic",
        "fidget_sniff_fingers",
        "냄새",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["stickup"] = {
        "random@countryside_gang_fight",
        "biker_02_stickup_loop",
        "스틱 업",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["stumble"] = {
        "misscarsteal4@actor",
        "stumble",
        "채이기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["stunned"] = {
        "stungun@standing",
        "damage",
        "기절",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sunbathe"] = {
        "amb@world_human_sunbathe@male@back@base",
        "base",
        "일광욕",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["sunbathe2"] = {
        "amb@world_human_sunbathe@female@back@base",
        "base",
        "일광욕 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["t"] = {
        "missfam5_yoga",
        "a2_pose",
        "T",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["t2"] = {
        "mp_sleep",
        "bind_pose_180",
        "T 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["think5"] = {
        "mp_cp_welcome_tutthink",
        "b_think",
        "생각 5",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["think"] = {
        "misscarsteal4@aliens",
        "rehearsal_base_idle_director",
        "생각",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["think3"] = {
        "timetable@tracy@ig_8@base",
        "base",
        "생각 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["think2"] = {
        "missheist_jewelleadinout",
        "jh_int_outro_loop_a",
        "생각 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["thumbsup3"] = {
        "anim@mp_player_intincarthumbs_uplow@ds@",
        "enter",
        "엄지 손가락 3",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["thumbsup2"] = {
        "anim@mp_player_intselfiethumbs_up",
        "idle_a",
        "엄지 손가락 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["thumbsup"] = {
        "anim@mp_player_intupperthumbs_up",
        "idle_a",
        "엄지 손가락",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["type"] = {
        "anim@heists@prison_heiststation@cop_reactions",
        "cop_b_idle",
        "유형",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["type2"] = {
        "anim@heists@prison_heistig1_p1_guard_checks_bus",
        "loop",
        "유형 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["type3"] = {
        "mp_prison_break",
        "hack_loop",
        "유형 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["type4"] = {
        "mp_fbi_heist",
        "loop",
        "유형 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["warmth"] = {
        "amb@world_human_stand_fire@male@idle_a",
        "idle_a",
        "따뜻함",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave4"] = {
        "random@mugging5",
        "001445_01_gangintimidation_1_female_idle_b",
        "웨이브 4",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["wave2"] = {
        "anim@mp_player_intcelebrationfemale@wave",
        "wave",
        "웨이브 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave3"] = {
        "friends@fra@ig_1",
        "over_here_idle_a",
        "웨이브 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave"] = {
        "friends@frj@ig_1",
        "wave_a",
        "웨이브",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave5"] = {
        "friends@frj@ig_1",
        "wave_b",
        "웨이브 5",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave6"] = {
        "friends@frj@ig_1",
        "wave_c",
        "웨이브 6",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave7"] = {
        "friends@frj@ig_1",
        "wave_d",
        "웨이브 7",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave8"] = {
        "friends@frj@ig_1",
        "wave_e",
        "웨이브 8",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wave9"] = {
        "gestures@m@standing@casual",
        "gesture_hello",
        "웨이브 9",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["whistle"] = {
        "taxi_hail",
        "hail_taxi",
        "휘파람",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 1300
        }
    },
    ["whistle2"] = {
        "rcmnigel1c",
        "hailing_whistle_waive_a",
        "휘파람 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["yeah"] = {
        "anim@mp_player_intupperair_shagging",
        "idle_a",
        "네",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["lift"] = {
        "random@hitch_lift",
        "idle_f",
        "승강기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["lol"] = {
        "anim@arena@celeb@flat@paired@no_props@",
        "laugh_a_player_b",
        "웃기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lol2"] = {
        "anim@arena@celeb@flat@solo@no_props@",
        "giggle_a_player_b",
        "웃기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["statue2"] = {
        "fra_0_int-1",
        "cs_lamardavis_dual-1",
        "동상 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["statue3"] = {
        "club_intro2-0",
        "csb_englishdave_dual-0",
        "동상 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["gangsign"] = {
        "mp_player_int_uppergang_sign_a",
        "mp_player_int_gang_sign_a",
        "갱 표시",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["gangsign2"] = {
        "mp_player_int_uppergang_sign_b",
        "mp_player_int_gang_sign_b",
        "갱 표시 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["passout"] = {
        "missarmenian2",
        "drunk_loop",
        "유월절",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["passout2"] = {
        "missarmenian2",
        "corpse_search_exit_ped",
        "유월절 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["passout3"] = {
        "anim@gangops@morgue@table@",
        "body_search",
        "유월절 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["passout4"] = {
        "mini@cpr@char_b@cpr_def",
        "cpr_pumpchest_idle",
        "유월절 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["passout5"] = {
        "random@mugging4",
        "flee_backward_loop_shopkeeper",
        "유월절 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["petting"] = {
        "creatures@rottweiler@tricks@",
        "petting_franklin",
        "더듬기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["crawl"] = {
        "move_injured_ground",
        "front_loop",
        "포복",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "플립 2"},
    ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "플립"},
    ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "슬라이드"},
    ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "슬라이드 2"},
    ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "슬라이드 3"},
    ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "슬러거"},
    ["flipoff"] = {
        "anim@arena@celeb@podium@no_prop@",
        "flip_off_a_1st",
        "뒤집기",
        AnimationOptions = {
            EmoteMoving = true
        }
    },
    ["flipoff2"] = {
        "anim@arena@celeb@podium@no_prop@",
        "flip_off_c_1st",
        "뒤집기 2",
        AnimationOptions = {
            EmoteMoving = true
        }
    },
    ["bow"] = {
        "anim@arena@celeb@podium@no_prop@",
        "regal_c_1st",
        "활",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["bow2"] = {
        "anim@arena@celeb@podium@no_prop@",
        "regal_a_1st",
        "활 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["keyfob"] = {
        "anim@mp_player_intmenu@key_fob@",
        "fob_click",
        "열쇠 고리",
        AnimationOptions = {
            EmoteLoop = false,
            EmoteMoving = true,
            EmoteDuration = 1000
        }
    },
    ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
    ["eat"] = {
        "mp_player_inteat@burger",
        "mp_player_int_eat_burger",
        "먹기",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["reaching"] = {
        "move_m@intimidation@cop@unarmed",
        "idle",
        "도달",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait"] = {
        "random@shop_tattoo",
        "_idle_a",
        "기다림",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait2"] = {
        "missbigscore2aig_3",
        "wait_for_van_c",
        "기다림 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait12"] = {
        "rcmjosh1",
        "idle",
        "기다림 12",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["wait13"] = {
        "rcmnigel1a",
        "base",
        "기다림 13",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["lapdance2"] = {
        "mini@strip_club@private_dance@idle",
        "priv_dance_idle",
        "랩 댄스 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lapdance3"] = {
        "mini@strip_club@private_dance@part2",
        "priv_dance_p2",
        "랩 댄스 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["lapdance3"] = {
        "mini@strip_club@private_dance@part3",
        "priv_dance_p3",
        "랩 댄스 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["twerk"] = {
        "switch@trevor@mocks_lapdance",
        "001443_01_trvs_28_idle_stripper",
        "트워크",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["slap"] = {
        "melee@unarmed@streamed_variations",
        "plyr_takedown_front_slap",
        "슬랩",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
            EmoteDuration = 2000
        }
    },
    ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "박치기"},
    ["fishdance"] = {
        "anim@mp_player_intupperfind_the_fish",
        "idle_a",
        "물고기 춤",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["peace"] = {
        "mp_player_int_upperpeace_sign",
        "mp_player_int_peace_sign",
        "브이",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["peace2"] = {
        "anim@mp_player_intupperpeace",
        "idle_a",
        "브이 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["cpr"] = {
        "mini@cpr@char_a@cpr_str",
        "cpr_pumpchest",
        "심폐 소생술",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["cpr2"] = {
        "mini@cpr@char_a@cpr_str",
        "cpr_pumpchest",
        "심폐 소생술 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["ledge"] = {
        "missfbi1",
        "ledge_loop",
        "선반",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["airplane"] = {
        "missfbi1",
        "ledge_loop",
        "비행기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["peek"] = {
        "random@paparazzi@peek",
        "left_peek_a",
        "몰래 엿보기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["cough"] = {
        "timetable@gardener@smoking_joint",
        "idle_cough",
        "기침",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["stretch"] = {
        "mini@triathlon",
        "idle_e",
        "뻗기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["stretch2"] = {
        "mini@triathlon",
        "idle_f",
        "뻗기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["stretch3"] = {
        "mini@triathlon",
        "idle_d",
        "뻗기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["stretch4"] = {
        "rcmfanatic1maryann_stretchidle_b",
        "idle_e",
        "뻗기 4",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["celebrate"] = {
        "rcmfanatic1celebrate",
        "celebrate",
        "세상에 알리기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["punching"] = {
        "rcmextreme2",
        "loop_punching",
        "펀칭",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["superhero"] = {
        "rcmbarry",
        "base",
        "슈퍼 히어로",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["superhero2"] = {
        "rcmbarry",
        "base",
        "슈퍼 히어로 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["mindcontrol"] = {
        "rcmbarry",
        "mind_control_b_loop",
        "마인드 컨트롤",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["mindcontrol2"] = {
        "rcmbarry",
        "bar_1_attack_idle_aln",
        "마인드 컨트롤 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["clown"] = {
        "rcm_barry2",
        "clown_idle_0",
        "시골뜨기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["clown2"] = {
        "rcm_barry2",
        "clown_idle_1",
        "시골뜨기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["clown3"] = {
        "rcm_barry2",
        "clown_idle_2",
        "시골뜨기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["clown4"] = {
        "rcm_barry2",
        "clown_idle_3",
        "시골뜨기 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    --[[
    ["clown5"] = {
        "rcm_barry2",
        "clown_idle_6",
        "시골뜨기 5",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ]]
    ["tryclothes"] = {
        "mp_clothing@female@trousers",
        "try_trousers_neutral_a",
        "옷 입어보기",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["tryclothes2"] = {
        "mp_clothing@female@shirt",
        "try_shirt_positive_a",
        "옷 입어보기 2",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["tryclothes3"] = {
        "mp_clothing@female@shoes",
        "try_shoes_positive_a",
        "옷 입어보기 3",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["nervous2"] = {
        "mp_missheist_countrybank@nervous",
        "nervous_idle",
        "긴장한 2",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["nervous"] = {
        "amb@world_human_bum_standing@twitchy@idle_a",
        "idle_c",
        "긴장한",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["nervous3"] = {
        "rcmme_tracey1",
        "nervous_loop",
        "긴장한 3",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["uncuff"] = {
        "mp_arresting",
        "a_uncuff",
        "수갑풀기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["namaste"] = {
        "timetable@amanda@ig_4",
        "ig_4_base",
        "나마스테",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["dj"] = {
        "anim@amb@nightclub@djs@dixon@",
        "dixn_dance_cntr_open_dix",
        "디제이",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["threaten"] = {
        "random@atmrobberygen",
        "b_atm_mugging",
        "협박",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["radio"] = {
        "random@arrests",
        "generic_radio_chatter",
        "라디오",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["pull"] = {
        "random@mugging4",
        "struggle_loop_b_thief",
        "당기기",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["bird"] = {"random@peyote@bird", "wakeup", "새"},
    ["chicken"] = {
        "random@peyote@chicken",
        "wakeup",
        "치킨",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["bark"] = {"random@peyote@dog", "wakeup", "나무 껍질"},
    ["rabbit"] = {"random@peyote@rabbit", "wakeup", "토끼"},
    ["spiderman"] = {
        "missexile3",
        "ex03_train_roof_idle",
        "스파이더맨",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["boi"] = {
        "special_ped@jane@monologue_5@monologue_5c",
        "brotheradrianhasshown_2",
        "BOI",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 3000
        }
    },
    ["adjust"] = {
        "missmic4",
        "michael_tux_fidget",
        "맞추기",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 4000
        }
    },
    ["handsup"] = {
        "missminuteman_1ig_2",
        "handsup_base",
        "손들기",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["pee"] = {
        "misscarsteal2peeing",
        "peeing_loop",
        "오줌",
        AnimationOptions = {
            EmoteStuck = true,
            PtfxAsset = "scr_amb_chop",
            PtfxName = "ent_anim_dog_peeing",
            PtfxNoProp = true,
            PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]["pee"],
            PtfxWait = 3000
        }
    },
    -----------------------------------------------------------------------------------------------------------
    ------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
    -----------------------------------------------------------------------------------------------------------

    ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
    ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "비비큐"},
    ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "범 빈"},
    ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "부랑자"},
    ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "격려"},
    ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "턱걸이"},
    ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "클립보드 2"},
    ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "경찰"},
    ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "경찰 비콘"},
    ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "충격적인 영화"},
    ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "굽힘"},
    ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "가드"},
    ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "망치"},
    ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "행 아웃"},
    ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "참을성이없는"},
    ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "관리인"},
    ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "가벼운 흔들림"},
    ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "무릎"},
    ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "송풍기"},
    ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "기대기"},
    ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "바에 기대기"},
    ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "임무"},
    ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "하녀"},
    ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "메딕"},
    ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "음악가"},
    ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "메모장 2"},
    ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "주차료 징수"},
    ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "파티"},
    ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "문자 메시지"},
    ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "하이클래스 매춘부"},
    ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "매춘부"},
    ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "흐리게"},
    ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "기록"},
    -- Sitchair is a litte special, since you want the player to be seated correctly.
    -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
    ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "의자에 앉기"},
    ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "담배"},
    ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "대마초"},
    ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "동상"},
    ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "일광욕 3"},
    ["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "일광욕 뒤로"},
    ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "용접"},
    ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "상품 구격"},
    ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "요가"},
    -- CASINO DLC EMOTES (STREAMED)
    ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "카라테"},
    ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "카라테 2"},
    ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "목 자르기"},
    ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "목 자르기 2"},
    ["mindblown"] = {
        "anim@mp_player_intcelebrationmale@mind_blown",
        "mind_blown",
        "부푼 마음",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 4000
        }
    },
    ["mindblown2"] = {
        "anim@mp_player_intcelebrationfemale@mind_blown",
        "mind_blown",
        "부푼 마음 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 4000
        }
    },
    ["boxing"] = {
        "anim@mp_player_intcelebrationmale@shadow_boxing",
        "shadow_boxing",
        "권투",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 4000
        }
    },
    ["boxing2"] = {
        "anim@mp_player_intcelebrationfemale@shadow_boxing",
        "shadow_boxing",
        "권투 2",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 4000
        }
    },
    ["stink"] = {
        "anim@mp_player_intcelebrationfemale@stinker",
        "stinker",
        "악취",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["think4"] = {
        "anim@amb@casino@hangout@ped_male@stand@02b@idles",
        "idle_a",
        "생각 4",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["adjusttie"] = {
        "clothingtie",
        "try_tie_positive_a",
        "타이 조정",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteDuration = 5000
        }
    }
}

DP.PropEmotes = {
    ["umbrella"] = {
        "amb@world_human_drinking@coffee@male@base",
        "base",
        "우산",
        AnimationOptions = {
            Prop = "p_amb_brolly_01",
            PropBone = 57005,
            PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
            --
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    -----------------------------------------------------------------------------------------------------
    ------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
    -----------------------------------------------------------------------------------------------------

    ["notepad"] = {
        "missheistdockssetup1clipboard@base",
        "base",
        "메모장",
        AnimationOptions = {
            Prop = "prop_notepad_01",
            PropBone = 18905,
            PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
            SecondProp = "prop_pencil_01",
            SecondPropBone = 58866,
            SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
            -- EmoteLoop is used for emotes that should loop, its as simple as that.
            -- Then EmoteMoving is used for emotes that should only play on the upperbody.
            -- The code then checks both values and sets the MovementType to the correct one
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["box"] = {
        "anim@heists@box_carry@",
        "idle",
        "박스",
        AnimationOptions = {
            Prop = "hei_prop_heist_box",
            PropBone = 60309,
            PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["rose"] = {
        "anim@heists@humane_labs@finale@keycards",
        "ped_a_enter_loop",
        "장미",
        AnimationOptions = {
            Prop = "prop_single_rose",
            PropBone = 18905,
            PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["smoke2"] = {
        "amb@world_human_aa_smoke@male@idle_a",
        "idle_c",
        "담배 2",
        AnimationOptions = {
            Prop = "prop_cs_ciggy_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["smoke3"] = {
        "amb@world_human_aa_smoke@male@idle_a",
        "idle_b",
        "담배 3",
        AnimationOptions = {
            Prop = "prop_cs_ciggy_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["smoke4"] = {
        "amb@world_human_smoking@female@idle_a",
        "idle_b",
        "담배 4",
        AnimationOptions = {
            Prop = "prop_cs_ciggy_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["bong"] = {
        "anim@safehouse@bong",
        "bong_stage3",
        "봉",
        AnimationOptions = {
            Prop = "hei_heist_sh_bong_01",
            PropBone = 18905,
            PropPlacement = {0.10, -0.25, 0.0, 95.0, 190.0, 180.0}
        }
    },
    ["suitcase"] = {
        "missheistdocksprep1hold_cellphone",
        "static",
        "여행 가방",
        AnimationOptions = {
            Prop = "prop_ld_suitcase_01",
            PropBone = 57005,
            PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["suitcase2"] = {
        "missheistdocksprep1hold_cellphone",
        "static",
        "여행 가방 2",
        AnimationOptions = {
            Prop = "prop_security_case_01",
            PropBone = 57005,
            PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["mugshot"] = {
        "mp_character_creation@customise@male_a",
        "loop",
        "머그 샷",
        AnimationOptions = {
            Prop = "prop_police_id_board",
            PropBone = 58868,
            PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["coffee"] = {
        "amb@world_human_drinking@coffee@male@idle_a",
        "idle_c",
        "커피",
        AnimationOptions = {
            Prop = "p_amb_coffeecup_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["whiskey"] = {
        "amb@world_human_drinking@coffee@male@idle_a",
        "idle_c",
        "위스키",
        AnimationOptions = {
            Prop = "prop_drink_whisky",
            PropBone = 28422,
            PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["beer"] = {
        "amb@world_human_drinking@coffee@male@idle_a",
        "idle_c",
        "맥주",
        AnimationOptions = {
            Prop = "prop_amb_beer_bottle",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["cup"] = {
        "amb@world_human_drinking@coffee@male@idle_a",
        "idle_c",
        "컵",
        AnimationOptions = {
            Prop = "prop_plastic_cup_02",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["donut"] = {
        "mp_player_inteat@burger",
        "mp_player_int_eat_burger",
        "도넛",
        AnimationOptions = {
            Prop = "prop_amb_donut",
            PropBone = 18905,
            PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
            EmoteMoving = true
        }
    },
    ["burger"] = {
        "mp_player_inteat@burger",
        "mp_player_int_eat_burger",
        "햄버거",
        AnimationOptions = {
            Prop = "prop_cs_burger_01",
            PropBone = 18905,
            PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
            EmoteMoving = true
        }
    },
    ["sandwich"] = {
        "mp_player_inteat@burger",
        "mp_player_int_eat_burger",
        "샌드위치",
        AnimationOptions = {
            Prop = "prop_sandwich_01",
            PropBone = 18905,
            PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
            EmoteMoving = true
        }
    },
    ["soda"] = {
        "amb@world_human_drinking@coffee@male@idle_a",
        "idle_c",
        "탄산 음료",
        AnimationOptions = {
            Prop = "prop_ecola_can",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["egobar"] = {
        "mp_player_inteat@burger",
        "mp_player_int_eat_burger",
        "에고 바",
        AnimationOptions = {
            Prop = "prop_choc_ego",
            PropBone = 60309,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteMoving = true
        }
    },
    ["wine"] = {
        "anim@heists@humane_labs@finale@keycards",
        "ped_a_enter_loop",
        "와인",
        AnimationOptions = {
            Prop = "prop_drink_redwine",
            PropBone = 18905,
            PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["flute"] = {
        "anim@heists@humane_labs@finale@keycards",
        "ped_a_enter_loop",
        "플루트",
        AnimationOptions = {
            Prop = "prop_champ_flute",
            PropBone = 18905,
            PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["champagne"] = {
        "anim@heists@humane_labs@finale@keycards",
        "ped_a_enter_loop",
        "샴페인",
        AnimationOptions = {
            Prop = "prop_drink_champ",
            PropBone = 18905,
            PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["cigar"] = {
        "amb@world_human_smoking@male@male_a@enter",
        "enter",
        "시가",
        AnimationOptions = {
            Prop = "prop_cigar_02",
            PropBone = 47419,
            PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }
    },
    ["cigar2"] = {
        "amb@world_human_smoking@male@male_a@enter",
        "enter",
        "시가 2",
        AnimationOptions = {
            Prop = "prop_cigar_01",
            PropBone = 47419,
            PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }
    },
    ["guitar"] = {
        "amb@world_human_musician@guitar@male@idle_a",
        "idle_b",
        "기타",
        AnimationOptions = {
            Prop = "prop_acc_guitar_01",
            PropBone = 24818,
            PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["guitar2"] = {
        "switch@trevor@guitar_beatdown",
        "001370_02_trvs_8_guitar_beatdown_idle_busker",
        "기타 2",
        AnimationOptions = {
            Prop = "prop_acc_guitar_01",
            PropBone = 24818,
            PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["guitarelectric"] = {
        "amb@world_human_musician@guitar@male@idle_a",
        "idle_b",
        "전자 기타",
        AnimationOptions = {
            Prop = "prop_el_guitar_01",
            PropBone = 24818,
            PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["guitarelectric2"] = {
        "amb@world_human_musician@guitar@male@idle_a",
        "idle_b",
        "전자 기타 2",
        AnimationOptions = {
            Prop = "prop_el_guitar_03",
            PropBone = 24818,
            PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["book"] = {
        "cellphone@",
        "cellphone_text_read_base",
        "책",
        AnimationOptions = {
            Prop = "prop_novel_01",
            PropBone = 6286,
            PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["bouquet"] = {
        "impexp_int-0",
        "mp_m_waremech_01_dual-0",
        "꽃다발",
        AnimationOptions = {
            Prop = "prop_snow_flower_02",
            PropBone = 24817,
            PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["teddy"] = {
        "impexp_int-0",
        "mp_m_waremech_01_dual-0",
        "테디",
        AnimationOptions = {
            Prop = "v_ilev_mr_rasberryclean",
            PropBone = 24817,
            PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["backpack"] = {
        "move_p_m_zero_rucksack",
        "idle",
        "배낭",
        AnimationOptions = {
            Prop = "p_michael_backpack_s",
            PropBone = 24818,
            PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["clipboard"] = {
        "missfam4",
        "base",
        "클립보드",
        AnimationOptions = {
            Prop = "p_amb_clipboard_01",
            PropBone = 36029,
            PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["map"] = {
        "amb@world_human_tourist_map@male@base",
        "base",
        "지도",
        AnimationOptions = {
            Prop = "prop_tourist_map_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["beg"] = {
        "amb@world_human_bum_freeway@male@base",
        "base",
        "빌다",
        AnimationOptions = {
            Prop = "prop_beggers_sign_03",
            PropBone = 58868,
            PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["makeitrain"] = {
        "anim@mp_player_intupperraining_cash",
        "idle_a",
        "비가오게",
        AnimationOptions = {
            Prop = "prop_anim_cash_pile_01",
            PropBone = 60309,
            PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
            EmoteMoving = true,
            EmoteLoop = true,
            PtfxAsset = "scr_xs_celebration",
            PtfxName = "scr_xs_money_rain",
            PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]["makeitrain"],
            PtfxWait = 500
        }
    },
    ["camera"] = {
        "amb@world_human_paparazzi@male@base",
        "base",
        "카메라",
        AnimationOptions = {
            Prop = "prop_pap_camera_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true,
            PtfxAsset = "scr_bike_business",
            PtfxName = "scr_bike_cfid_camera_flash",
            PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]["camera"],
            PtfxWait = 200
        }
    },
    ["champagnespray"] = {
        "anim@mp_player_intupperspray_champagne",
        "idle_a",
        "샴페인 스프레이",
        AnimationOptions = {
            Prop = "ba_prop_battle_champ_open",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteMoving = true,
            EmoteLoop = true,
            PtfxAsset = "scr_ba_club",
            PtfxName = "scr_ba_club_champagne_spray",
            PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            PtfxInfo = Config.Languages[Config.MenuLanguage]["spraychamp"],
            PtfxWait = 500
        }
    },
    ["joint"] = {
        "amb@world_human_smoking@male@male_a@enter",
        "enter",
        "관절",
        AnimationOptions = {
            Prop = "p_cs_joint_02",
            PropBone = 47419,
            PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }
    },
    ["cig"] = {
        "amb@world_human_smoking@male@male_a@enter",
        "enter",
        "시가",
        AnimationOptions = {
            Prop = "prop_amb_ciggy_01",
            PropBone = 47419,
            PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
            EmoteMoving = true,
            EmoteDuration = 2600
        }
    },
    ["brief3"] = {
        "missheistdocksprep1hold_cellphone",
        "static",
        "간결한 3",
        AnimationOptions = {
            Prop = "prop_ld_case_01",
            PropBone = 57005,
            PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["tablet"] = {
        "amb@world_human_tourist_map@male@base",
        "base",
        "태블릿",
        AnimationOptions = {
            Prop = "prop_cs_tablet",
            PropBone = 28422,
            PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["tablet2"] = {
        "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
        "idle_a",
        "태블릿 2",
        AnimationOptions = {
            Prop = "prop_cs_tablet",
            PropBone = 28422,
            PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["phonecall"] = {
        "cellphone@",
        "cellphone_call_listen_base",
        "전화걸기",
        AnimationOptions = {
            Prop = "prop_npc_phone_02",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["phone"] = {
        "cellphone@",
        "cellphone_text_read_base",
        "전화",
        AnimationOptions = {
            Prop = "prop_npc_phone_02",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["clean"] = {
        "timetable@floyd@clean_kitchen@base",
        "base",
        "깨끗한",
        AnimationOptions = {
            Prop = "prop_sponge_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    },
    ["clean2"] = {
        "amb@world_human_maid_clean@",
        "base",
        "깨끗한 2",
        AnimationOptions = {
            Prop = "prop_sponge_01",
            PropBone = 28422,
            PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
            EmoteLoop = true,
            EmoteMoving = true
        }
    }
}
