local cfg = {}

-- size of the sms history
cfg.sms_history = 15

-- maximum size of an sms
cfg.sms_size = 500

-- duration of a sms position marker (in seconds)
cfg.smspos_duration = 300

-- define phone services
-- blipid, blipcolor (customize alert blip)
-- alert_time (alert blip display duration in seconds)
-- alert_permission (permission required to receive the alert)
-- alert_notify (notification received when an alert is sent)
-- notify (notification when sending an alert)
cfg.services = {
  ["🚨 경찰 호출"] = {
    blipid = 304,
    blipcolor = 38,
    alert_time = 300, -- 5 minutes
    alert_permission = "police.service",
    alert_notify = "~r~경찰 알림 :~n~~s~",
    notify = "~b~경찰을 호출했습니다.",
    answer_notify = "~b~경찰이 출발했습니다."
  },
  ["🔥 119 긴급"] = {
    blipid = 153,
    blipcolor = 1,
    alert_time = 600, -- 10 minutes
    alert_permission = "emergency.service",
    alert_notify = "~r~긴급 알림 :~n~~s~",
    notify = "~b~구급대원을 호출했습니다.",
    answer_notify = "~b~구급대원이 출발했습니다."
  },
  ["🚕 택시 호출"] = {
    blipid = 198,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "uber.service",
    alert_notify = "~y~택시 알림 :~n~~s~",
    notify = "~y~택시 기사를 호출했습니다.",
    answer_notify = "~y~택시 기사가 출발했습니다."
  },  
  ["🚧 렉카 호출"] = {
    blipid = 446,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "fristrc.service",
    alert_notify = "~y~견인 알림 :~n~~s~",
    notify = "~y~퍼스트 렉카를 호출했습니다.",
    answer_notify = "~y~퍼스트 렉카 기사가 출발했습니다."
  },
  ["🔧 출장 수리"] = {
    blipid = 446,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "repair.service",
    alert_notify = "~y~수리 알림 :~n~~s~",
    notify = "~y~수리기사를 호출했습니다.",
    answer_notify = "~y~수리기사가 출발 했습니다."
  }
  --[[
  ["렉카 호출(준비중)"] = {
    blipid = 446,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "tow2.service",
    alert_notify = "~y~견인 알림 :~n~~s~",
    notify = "~y~월드렉카를 호출했습니다.",
    answer_notify = "~y~월드렉카 기사가 출발 했습니다."
  },
  ["물건 배달(준비중)"] = {
    blipid = 494,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "delivery2.service",
    alert_notify = "~y~배달 알림 :~n~~s~",
    notify = "~y~물건 배달을 호출했습니다.",
    answer_notify = "~y~물건 배달이 출발했습니다."
  },
  ["도미노 피자(준비중)"] = {
    blipid = 494,
    blipcolor = 5,
    alert_time = 300,
    alert_permission = "domino2.service",
    alert_notify = "~y~배달 알림 :~n~~s~",
    notify = "~y~피자 배달을 호출했습니다.",
    answer_notify = "~y~피자 배달이 출발했습니다."
  }
  ]]
}

-- define phone announces
-- image: background image for the announce (800x150 px)
-- price: amount to pay to post the announce
-- description (optional)
-- permission (optional): permission required to post the announce
cfg.announces = {
  ["*🚨 관리자 공지배너"] = {
    --image = "nui://vrp_mod/announce_admin.png",
    image = "https://i.imgur.com/d7o0ipO.png",
    price = 0,
    description = "관리자전용 공지사항 입니다.",
    permission = "admin.announce"
  },
  ["*🚨 경찰 공지배너"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "https://i.imgur.com/KyKN6OC.png",
    price = 0,
    description = "경찰전용 공지사항 입니다.",
    permission = "police.announce"
  },
  ["*🚨 교정본부 공지배너"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "https://i.imgur.com/OgNoE0g.png",
    price = 0,
    description = "교정본부 공지사항 입니다.",
    permission = "kys.whitelisted"
  },  
  ["*🚨 EMS 공지배너"] = {
    --image = "nui://vrp_mod/announce_police.png",
    image = "",
    price = 0,
    description = "EMS전용 공지사항 입니다.",
    permission = "ems.announce"
  }
}

return cfg
