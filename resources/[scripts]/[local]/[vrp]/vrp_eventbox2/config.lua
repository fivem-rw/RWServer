cfg = {}

cfg.global = {
	paytime = 3600,
	vipPayTime = 3600
}

cfg.arrStoneArea = {"eventitem_event2_vivestone1", "eventitem_event2_vivestone2", "eventitem_event2_vivestone3", "eventitem_event2_vivestone4", "eventitem_event2_vivestone5", "eventitem_event2_vivestone6", "eventitem_event2_vivestone7"}

cfg.giftbox = {
	open_amount = 1
}

-- 종류, 확률(%), 코드, 이름, 개수(숫자:지정,배열:범위랜덤), 전체알림여부
cfg.rewards = {
	{"item", 10.0, "eventitem_event2_ticket1", "🎫 문상교환권(만원권)", 1, true, 10000},
	{"item", 1.0, "eventitem_event2_ticket2", "🎫 문상교환권(오만원권)", 1, true, 50000},
	{"item", 0.1, "eventitem_event2_ticket3", "🔥 문상교환권(십만원권)", 1, true, 100000},
	--{"item", 0.05, "eventitem_event2_ticket4", "🔥 문상교환권(오십만원권)", 1, true, 500000},
	{"item", 0.05, "wbody|WEAPON_VIVEHAMMER", "🔩 부활의망치", 1, true},
	{"item", 1.0, "wbody|WEAPON_KNIFE_01", "🔪 부활의단검", 1, true},
	{"item", 0.5, "wbody|WEAPON_KNIFE_02", "🔪 부활의전투단검", 1, true},
	{"item", 0.1, "wbody|WEAPON_VIVEBAT", "🔪 부활의장검", 1, true},
	{"money", 80.0, 1000000, "💵 돈뭉치 100만원", 1, false},
	{"money", 50.0, 5000000, "💵 돈뭉치 500만원", 1, false},
	{"money", 20.0, 10000000, "💸 돈뭉치 1000만원", 1, true},
	{"money", 1.0, 50000000, "💸 돈뭉치 5000만원", 1, true},
	{"money", 0.5, 100000000, "💰 돈뭉치 1억원", 1, true},
	{"money", 0.05, 1000000000, "💰 돈뭉치 10억원", 1, true},
	{"skin", 0.1, "skinbox|699184", "🔮 예수스킨", 1, true, "u_m_m_jesus_01"},
	{"skin", 0.05, "skinbox|760294", "🔮 부활의예수스킨", 1, true, "u_m_m_jesus_02"}
}

cfg.paycheck = {
	picture = "CHAR_BANK_BOL",
	title = "[부활데이 후원자혜택]",
	msg = "~y~보너스박스~w~을 지급 받았습니다",
	amount = 1
}

cfg.open_giftbox = 1

function getConfig()
	return cfg
end
