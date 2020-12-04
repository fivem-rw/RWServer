-- define emotes
-- use the custom emotes admin action to test emotes on-the-fly
-- animation list: http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm

local cfg = {}

-- map of emote_name => {upper,seq,looping}
-- seq can also be a task definition, check the examples below
cfg.emotes = {
  ["양손들기"] = {
    -- handsup state, use clear to lower hands
    true,
    {
      -- sequence, list of {dict,name,loops}
      {"random@mugging3", "handsup_standing_base", 1}
    },
    true
  },
  ["아니"] = {
    true,
    {{"gestures@f@standing@casual", "gesture_head_no", 1}},
    false
  },
  ["젠장"] = {
    true,
    {{"gestures@f@standing@casual", "gesture_damn", 1}},
    false
  },
  ["춤추기"] = {
    false,
    {
      {"rcmnigel1bnmt_1b", "dance_intro_tyler", 1},
      {"rcmnigel1bnmt_1b", "dance_loop_tyler", 1}
    },
    false
  },
  ["거수경례"] = {true, {{"mp_player_int_uppersalute", "mp_player_int_salute", 1}}, false},
  ["락"] = {true, {{"mp_player_introck", "mp_player_int_rock", 1}}, false},
  ["의자에 앉기"] = {false, {task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER"}, false},
  --  ["Cop"] = {false, {task="WORLD_HUMAN_COP_IDLES"}, false},
  ["망원경"] = {false, {task = "WORLD_HUMAN_BINOCULARS"}, false},
  ["축하"] = {false, {task = "WORLD_HUMAN_CHEERING"}, false},
  ["커피"] = {false, {task = "WORLD_HUMAN_DRINKING"}, false},
  --["Smoke"] = {false, {task="WORLD_HUMAN_SMOKING"}, false},
  --  ["Film"] = {false, {task="WORLD_HUMAN_MOBILE_FILM_SHOCKING"}, false},
  --  ["Plant"] = {false, {task="WORLD_HUMAN_GARDENER_PLANT"}, false},
  ["경호원 자세"] = {false, {task = "WORLD_HUMAN_GUARD_STAND"}, false},
  --  ["Hammer"] = {false, {task="WORLD_HUMAN_HAMMERING"}, false},
  --  ["Hangout"] = {false, {task="WORLD_HUMAN_HANG_OUT_STREET"}, false},
  -- ["Hiker"] = {false, {task="WORLD_HUMAN_HIKER_STANDING"}, false},
  ["석상 마임"] = {false, {task = "WORLD_HUMAN_HUMAN_STATUE"}, false},
  ["조깅"] = {false, {task = "WORLD_HUMAN_JOG_STANDING"}, false},
  ["기대기"] = {false, {task = "WORLD_HUMAN_LEANING"}, false},
  ["힘자랑"] = {false, {task = "WORLD_HUMAN_MUSCLE_FLEX"}, false},
  ["카메라"] = {false, {task = "WORLD_HUMAN_PAPARAZZI"}, false},
  ["앉기"] = {false, {task = "WORLD_HUMAN_PICNIC"}, false},
  ["유혹1"] = {false, {task = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}, false},
  ["유혹2"] = {false, {task = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS"}, false},
  ["팔굽혀펴기"] = {false, {task = "WORLD_HUMAN_PUSH_UPS"}, false},
  ["윗몸일으키기"] = {false, {task = "WORLD_HUMAN_SIT_UPS"}, false},
  --  ["Fish"] = {false, {task="WORLD_HUMAN_STAND_FISHING"}, false},
  --  ["Impatient"] = {false, {task="WORLD_HUMAN_STAND_IMPATIENT"}, false},
  ["휴대폰"] = {false, {task = "WORLD_HUMAN_STAND_MOBILE"}, false},
  ["리듬타기"] = {false, {task = "WORLD_HUMAN_STRIP_WATCH_STAND"}, false},
  ["일광욕"] = {false, {task = "WORLD_HUMAN_SUNBATHE_BACK"}, false},
  ["일광욕2"] = {false, {task = "WORLD_HUMAN_SUNBATHE"}, false},
  --  ["Weld"] = {false, {task="WORLD_HUMAN_WELDING"}, false},
  --  ["Kneel"] = {false, {task="CODE_HUMAN_MEDIC_KNEEL"}, false},
  --  ["Crowdcontrol"] = {false, {task="CODE_HUMAN_POLICE_CROWD_CONTROL"}, false},
  --  ["Investigate"] = {false, {task="CODE_HUMAN_POLICE_INVESTIGATE"}, false},
  ["요가"] = {false, {task = "WORLD_HUMAN_YOGA"}, false}
}

return cfg
