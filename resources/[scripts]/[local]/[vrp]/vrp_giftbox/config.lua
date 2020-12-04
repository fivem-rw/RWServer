cfg = {}

cfg.global = {
	paytime = 1800
}

cfg.message = {
	offline = "~r~[시스템] ~w~플레이어가 접속하지 않았습니다.",
	invalid_number = "~r~[시스템] ~w~Number has to be a number!",
	not_enough_gb = "~g~리얼박스~w~가 부족합니다!",
	tr_succes = "~g~리얼박스~w~를 구매하셨습니다!",
	not_enough_m = "~r~[시스템] ~w~ 박스를 구매하기 위한 금액이 부족합니다!",
	only_has = "~r~[시스템] ~w~플레이어가 보유하고 있습니다. ~g~",
	only_have = "~r~[시스템] ~w~받기완료 ~g~",
	reset_msg = "~r~[시스템] ~w~초기화 완료 ~g~"
}

cfg.giftbox = {
	msg_got = "~g~리얼박스~w~ 개봉완료!",
	msg_got_n = "~r~리얼박스가 부족합니다!",
	open_amount = 1
}

cfg.trade = {
	msg_received = "~r~[시스템] ~w~당신은 ~y~리얼박스를 받았습니다.",
	msg_give = "~r~[시스템] ~w~당신은 ~y~리얼박스를 주었습니다."
}

-- 종류, 확률(%), 코드, 이름, 개수(숫자:지정,배열:범위랜덤), 전체알림여부
cfg.rewards = {
	{"car", 0.1, "20g80", "🚗 현대 제네시스 G80 2020", nil, true},
	{"car", 0.1, "pocky", "🚗 기아 스팅어 포키 에디션", nil, true},
	{"car", 0.2, "mohave20", "🚗 기아 더 뉴 모하비 마스터 2020", nil, true},
	{"car", 0.2, "sorento", "🚗 기아 더 뉴 쏘렌토 2020", nil, true},
	{"car", 0.7, "k52020", "🚗 기아 뉴 K5 2020", nil, true},
	{"car", 0.8, "19avante", "🚗 현대 아반떼 해외수출용 2019", nil, true},
	{"car", 14, "pride", "🚗 현대 프라이드", nil, true},
	{"item", 5, "special_goldticket", "🎫 금괴 미션 사용권", {1, 1}, false},
	{"item", 10, "zombie_ticket_1", "🎫 좀비존 입장권 (기본)", {1, 1}, false},
	{"item", 40, "armand", "🍹 아르망 드 브리냑", {1, 5}, false},
	{"item", 50, "dom", "🍸 돔 페리뇽", {1, 5}, false},
	{"item", 50, "absol", "🍷 앱솔루트 보드카", {1, 5}, false},
	{"item", 50, "jtj4", "🏐 플라스틱", {1, 1}, false},
	{"item", 20, "elixir", "🎆 파워 엘릭서", {1, 5}, false},
	{"item", 80, "trash", "🍪 쓰레기", {1, 10}, false}
}

cfg.market = {
	tr_succes = "~w~성공적으로 구매하였습니다!",
	not_enough_m = "~r~구매 금액이 부족합니다.",
	amount = 1000000
}

cfg.paycheck = {
	picture = "CHAR_BANK_BOL",
	title = "[보너스 타임]",
	msg = "~w~일정시간이 지나 ~y~리얼박스~w~를 받았습니다",
	amount = 1
}

cfg.menu = {
	permission = "giftbox.admin",
	name_desc = "",
	take_desc = "플레이어의 리얼박스를 가져옵니다.",
	give_desc = "플레이어에게 리얼박스를 줍니다.",
	open_desc = "리얼박스를 개봉하여 무작위 상품을 받아보세요!",
	reset_desc = "해당 플레이어의 리얼박스를 초기화 시킵니다.",
	giftbox_desc = "리얼박스",
	trade_desc = "리얼박스를 다른 플레이어와 교환합니다.",
	prompt_g = "리얼박스 : ",
	prompt_user_id = "아이디 : ",
	name = "리얼박스",
	give_t = "리얼박스 주기",
	take_t = "리얼박스 가져오기 ",
	reset_t = "리얼박스 초기화",
	open = "개봉하기",
	trade = "교환하기"
}

cfg.open_giftbox = 1

cfg.display_css =
	[[
	.div_giftbox {
  font-family: 'NanumSquare', sans-serif; /*a name to be used later*/
  src: url('https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css') format('css '); /*URL to font*/
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  position: absolute;
  top: 150px;
  right: 2px;
  padding: 0px;
  min-width : 170px;
  max-width: 250px;
  border-radius: 5px;
  font-size: 17px;
  font-weight: bold;
  color: #FFFFFF;
  text-shadow: 1px 1px 1px black;
	}
	.div_giftbox .symbol{
        content: url(https://i.imgur.com/OC8F9qj.png);
		margin-top: 1px;
		margin-left: 4px;
		margin-bottom: -3px;
	}
]]

function getConfig()
	return cfg
end
