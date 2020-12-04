-- define all language properties

local lang = {
  common = {
    welcome = "리얼월드에 오신것을 환영합니다. K를 누르면 핸드폰을 꺼낼수 있습니다.~n~",
    no_player_near = "~r~근처에 플레이어가 없습니다.",
    invalid_value = "~r~잘못된 값.",
    invalid_name = "~r~잘못된 이름.",
    not_found = "~r~찾을 수 없습니다.",
    request_refused = "~r~요청 거부.",
    wearing_uniform = "~r~조심하세요! 당신은 유니폼을 입고 있습니다.",
    not_allowed = "~r~허용되지 않음."
  },
  weapon = {
    pistol = "피스톨"
  },
  survival = {
    starving = "배고픔",
    thirsty = "목마름"
  },
  money = {
    display = '<span class="symbol"></span> {1}',
    bdisplay = '<span class="symbol"></span> {1}',
    given = "~r~{1} 줌.",
    received = "~g~{1} 받음.",
    not_enough = "~r~돈이 충분하지 않습니다.",
    paid = "결제 승인 ~r~{1}",
    give = {
      title = "현금 주기",
      description = "가장 가까운 사람에게 현금 주기.",
      prompt = "송금 할 액수:"
    }
  },
  credit = {
    display = '<span class="symbol"></span> {1}',
    bdisplay = '<span class="symbol"></span> {1}',
    given = "~r~{1} 배틀코인 줌.",
    received = "~g~{1} 배틀코인 받음.",
    not_enough = "~r~배틀코인이 충분하지 않습니다.",
    paid = "결제 승인 ~r~{1}",
    give = {
      title = "배틀코인 주기",
      description = "가장 가까운 사람에게 배틀코인 주기.",
      prompt = "송금 할 액수:"
    }
  },
  inventory = {
    title = "*가방",
    description = "가방 열기.",
    iteminfo = "({1})<br /><br />{2}<br /><em>{3} kg</em><br /><br />{4}",
    info_weight = "무게 {1}/{2} kg",
    give = {
      title = "선물",
      description = "가까운 플레이어에게 아이템을 줍니다.",
      prompt = "선물할 양 (최대 {1}):",
      given = "~r~{1} ~s~{2} 개 줌.",
      received = "받음 ~g~{1} ~s~{2}."
    },
    trash = {
      title = "버리기",
      description = "아이템을 버립니다.",
      prompt = "버릴 양 (최대 {1}):",
      done = "버림 ~r~{1} ~s~{2}."
    },
    missing = "~r~실패 {2} {1}.",
    full = "~r~가방이 꽉 찼습니다.",
    chest = {
      title = "액션",
      already_opened = "~r~이미 열려있습니다. 잠시후 다시 시도해주세요.",
      full = "~r~가방 꽉 참.",
      take = {
        title = "가지기",
        prompt = "가져갈 양 (최대 {1}):"
      },
      put = {
        title = "넣기",
        prompt = "넣을 양 (최대 {1}):"
      }
    }
  },
  atm = {
    title = "ATM",
    info = {
      title = "계좌 잔액",
      bank = "은행: {1}"
    },
    loaninfo = {
      title = "대출금 조회",
      bank = "대출금: {1}<br />(상환수수료 포함)"
    },
    noloaninfo = {
      title = "대출금 조회",
      bank = "대출금이 없습니다."
    },
    checkloanlimit = {
      title = "대출한도 조회",
      bank = "고객님의 현재 대출 한도는<br /> {1} 입니다."
    },
    deposit = {
      title = "*입금",
      description = "돈을 입금합니다",
      prompt = "입금할 액수를 입력하십시오.:",
      deposited = "~r~{1}~s~ 입금되었습니다."
    },
    depositcredit = {
      title = "크레딧 환전",
      description = "크레딧을 게임머니로 환전합니다",
      prompt = "환전 할 액수를 입력하십시오. 1크레딧 = 1,000:",
      deposited = "~r~{1} 크레딧~s~이 환전되었습니다."
    },
    moneytocredit = {
      title = "크레딧 역환전",
      description = "게임머니를 크레딧으로 환전합니다",
      prompt = "원하는 크레딧 금액을 입력하십시오. 1크레딧 = 1,200:",
      deposited = "~r~{1} 크레딧~s~이 지급되었습니다."
    },
    withdraw = {
      title = "*출금",
      description = "돈을 출금합니다",
      prompt = "출금할 액수를 입력하십시오.:",
      withdrawn = "~g~{1} ~s~출금되었습니다.",
      not_enough = "~r~한도초과(은행에 돈이 없습니다)."
    }
  },
  business = {
    title = "상공 회의소",
    directory = {
      title = "저장소",
      description = "사업 저장소.",
      dprev = "> 이전",
      dnext = "> 다음",
      info = "<em>capital: </em>{1} <br /><em>owner: </em>{2} {3}<br /><em>registration n°: </em>{4}<br /><em>phone: </em>{5}"
    },
    info = {
      title = "사업 정보",
      info = "<em>name: </em>{1}<br /><em>capital: </em>{2} <br /><em>capital transfer: </em>{3}<br /><br/>Capital transfer is the amount of money transfered for a business economic period, the maximum is the business capital."
    },
    addcapital = {
      title = "자본 추가",
      description = "자본을 당신의 사업에 추가합니다.",
      prompt = "사업 자본에 추가할 금액:",
      added = "~r~{1} ~s~사업 자본에 추가되었습니다."
    },
    launder = {
      title = "돈 세탁",
      description = "사업을 이용해 검은 돈 세탁.",
      prompt = "세탁할 검은 돈의 액수 (최대 {1}): ",
      laundered = "~g~{1} ~s~세탁됨.",
      not_enough = "~r~세탁할 돈이 존재하지 않음."
    },
    open = {
      title = "사업 열기",
      description = "최소한의 자본으로 사업을 여십시오 {1}.",
      prompt_name = "사업 이름 (can't change after, max {1} chars):",
      prompt_capital = "초기 자본 (최소 {1})",
      created = "~g~사업 생성됨."
    }
  },
  cityhall = {
    title = "주민등록증 발급",
    identity = {
      title = "주민등록증 발급",
      description = "주민등록증의 가격<br>~y~{1}",
      prompt_firstname = "성을 입력하세요:",
      prompt_name = "이름을 입력하세요:",
      prompt_age = "나이를 입력하세요:"
    },
    menu = {
      title = "*내 정보",
      info = "성: {2}<br />이름: {1}<br />나이: {3}<br />주민등록번호 : {4}<br />전화번호: {5}<br />신용등급 : {8} 등급 <br /> 누적 경험치 : {9}"
    }
  },
  police = {
    title = "경찰",
    wanted = "수배 등급 {1}",
    not_handcuffed = "~r~수갑이 채워지지 않음",
    cloakroom = {
      title = "소지품 보관소",
      uniform = {
        title = "유니폼",
        description = "유니폼 넣기."
      }
    },
    pc = {
      title = "PC",
      searchreg = {
        title = "주민등록번호 검색",
        description = "주민등록번호로 신분증 검색",
        prompt = "주민등록번호 입력:"
      },
      closebusiness = {
        title = "사업 닫기",
        description = "가장 가까운 플레이어 사업 닫기",
        request = "진짜 사업을 닫으시겠습니까? {3} 에 의해 소유된 {1} {2} ?",
        closed = "~g~사업을 닫았습니다."
      },
      trackveh = {
        title = "차량 추적",
        description = "차량 번호로 차량 추적",
        prompt_reg = "차량 번호 입력:",
        prompt_note = "차량 추적 사유:",
        tracking = "~b~추적이 시작되었습니다.",
        track_failed = "~b~의 추적 {1}~s~ ({2}) ~n~~r~실패함.",
        tracked = "추적됨 {1} ({2})"
      },
      records = {
        show = {
          title = "기록 보기",
          description = "주민등록번호로 경찰 기록 보기"
        },
        delete = {
          title = "기록 삭제",
          description = "주민등록번호로 경찰 기록 삭제",
          deleted = "~b~경찰 기록이 삭제되었습니다"
        }
      }
    },
    menu = {
      handcuff = {
        title = "수갑",
        description = "근처 플레이어 수갑채우기/수갑풀기."
      },
      putinveh = {
        title = "차량에 태우기",
        description = "플레이어를 차량에 태우기."
      },
      getoutveh = {
        title = "차량에서 내쫓기",
        description = "플레이어를 차량에서 내쫓습니다."
      },
      askid = {
        title = "확인: 신분증 확인 요청",
        description = "가까운 플레이어의 신분증을 확인합니다.",
        request = "신분증을 건냅니까?",
        request_hide = "신분증을 숨깁니다.",
        asked = "신분증을 요청중..."
      },
      check = {
        title = "확인: 소지품 확인 요청",
        description = "가까운 플레이어의 현금, 소지품, 착용중인무기를 확인합니다.",
        request = "소지품 확인 요청을 수락합니까?",
        request_hide = "검사 리포트 숨기기.",
        info = "<em>소지품: </em><br>{1}<br /><br /><em>착용중인무기: </em>{2}",
        checked = "조회되었습니다.",
        asked = "소지품 확인 요청중...",
        driver = {
          title = "확인 : 면허증 보유 여부",
          description = "가까운 플레이어의 운전 면허 보유 여부를 검사합니다."
          }
      },
      seize = {
        seized = "소유중 {2} ~r~{1}",
        weapons = {
          title = "압수: 소유중인 무기",
          description = "가장 가까운 플레이어의 소유중인 무기 압수",
          seized = "~b~소유한 무기를 압수했습니다."
        },
        items = {
          title = "압수: 불법적 물건",
          description = "가장 가까운 플레이어의 소유중인 불법적 물건 압수",
          seized = "~b~불법적인 물건을 압수했습니다."
        }
      },
      jail = {
        title = "감옥",
        description = "가까운 감옥의 플레이어 수감/석방.",
        not_found = "~r~감옥을 찾울 수 없음.",
        jailed = "~b~수감됨.",
        unjailed = "~b~석방됨.",
        notify_jailed = "~b~당신은 수감 되었습니다.",
        notify_unjailed = "~b~당신은 석방 되었습니다."
      },
      fine = {
        title = "벌금",
        description = "가장 가까운 플레이어 찾기.",
        fined = "~b~벌금 부과 됨 ~s~{2} for ~b~{1}.",
        notify_fined = "~b~당신은 벌금을 물었습니다 ~s~ {2} for ~b~{1}.",
        record = "[벌금]  {1} 에게 {2}"
      },
      store_weapons = {
        title = "무기 가방에 넣기",
        description = "착용중인 무기를 가방에 넣습니다."
      }
    },
    identity = {
      info = "<em>고유번호: </em>{8}<br /><em>닉네임: </em>{9}<br /><em>이름: </em>{2} {1}<br /><em>나이: </em>{3}<br /><em>주민등록번호: </em>{4}<br /><em>전화번호: </em>{5}<br /><em>사업: </em>{6}<br /><em>사업 자본: </em>{7}"
    }
  },
  emergency = {
    menu = {
      revive = {
        title = "살리기",
        description = "가장 가까운 플레이어를 살립니다.",
        not_in_coma = "~r~혼수상태가 아닙니다."
      }
    }
  },
  loan = {
    title = "*금융"
  },
  phone = {
    title = "*전화",
    directory = {
      title = "연락처",
      description = "연락처를 엽니다.",
      add = {
        title = "➕ 추가",
        prompt_number = "전화번호를 입력하십시오:",
        prompt_name = "이름을 입력하십시오:",
        added = "~g~추가되었습니다."
      },
      sendsms = {
        title = "문자 보내기",
        prompt = "메세지 내용 입력 (최대 {1} 글자):",
        sent = "~g~ {1}에게 발송.",
        not_sent = "~r~ {1} 발송 실패함."
      },
      sendpos = {
        title = "위치 전송"
      },
      remove = {
        title = "삭제"
      }
    },
    sms = {
      title = "문자 기록",
      description = "문자 기록을 삭제합니다.",
      info = "<em>{1}</em><br /><br />{2}",
      notify = "문자~b~ {1}:~s~ ~n~{2}"
    },
    smspos = {
      notify = "문자-위치 ~b~ {1}"
    },
    service = {
      title = "서비스",
      description = "서비스 또는 긴급 전화 번호로 전화하십시오.",
      prompt = "필요한 경우 서비스 메시지를 입력하십시오.:",
      ask_call = "{1} 전화 받음, 수락하시겠습니까? <em>{2}</em>",
      taken = "~r~이 통화는 이미 완료되었습니다."
    },
    breifing = {
      title = "지원요청",
      description = "서비스 또는 긴급 전화 번호로 전화하십시오.",
      ask_call = "{1} 지원요청이 들어왔습니다! <em>{2}</em>"
    },
    announce = {
      title = "공지",
      description = "몇 초 동안 모든 사람에게 공지 사항 게시.",
      item_desc = "{1}<br /><br/>{2}",
      prompt = "공지 발표 (10-1000 최대): "
    }
  },
  emotes = {
    title = "퀵 플레이",
    clear = {
      title = "> 없음",
      description = "모든 퀵플레이를 취소합니다."
    }
  },
  home = {
    buy = {
      title = "Buy",
      description = "집을 구입합니다. 가격은 {1}.",
      bought = "~g~구매 완료.",
      full = "~r~이 집은 꽉찼습니다.",
      have_home = "~r~당신은 이미 집을 소유중입니다."
    },
    sell = {
      title = "Sell",
      description = " {1} 에 집을 판매합니다.",
      sold = "~g~판매 완료.",
      no_home = "~r~당신은 이 집의 소유주가 아닙니다."
    },
    intercom = {
      title = "초인종",
      description = "친구 집에 들어가기.",
      prompt = "(호)수:",
      not_available = "~r~사용 불가.",
      refused = "~r~초대 거부.",
      prompt_who = "누구시죠?:",
      asked = "질문중...",
      request = "누군가 너의 집에 들어가고 싶어합니다: <em>{1}</em>"
    },
    slot = {
      leave = {
        title = "나가기"
      },
      ejectall = {
        title = "모두 나가기",
        description = "나를 포함하여 모든 손님을 내보내고 집을 닫는다"
      }
    },
    wardrobe = {
      title = "옷장",
      save = {
        title = "> 저장",
        prompt = "이름:"
      }
    },
    gametable = {
      title = "게임 테이블",
      bet = {
        title = "배팅(내기) 시작",
        description = "근처에 있는 플레이어와 배팅를 시작하면 상대가 무작위로 선택됩니다.",
        prompt = "배팅할 액수:",
        request = "[배팅] 배팅하시겠습니까? {1} ?",
        started = "~g~배팅 시작."
      }
    }
  },
  garage = {
    title = "차고 ({1})",
    owned = {
      title = "소유중",
      description = "소유중인 차량."
    },
    buy = {
      title = "구입",
      description = "차량 구입.",
      info = "{1}<br /><br />{2}"
    },
    sell = {
      title = "판매",
      description = "차량 판매."
    },
    rent = {
      title = "렌트",
      description = "차량을 렌트합니다 (세션에서 나갈때까지)."
    },
    store = {
      title = "돌려놓기",
      description = "현재 차량을 차고에 보관."
    }
  },
  vehicle = {
    title = "*차량",
    no_owned_near = "~r~근처에 소유중인 차량 없음.",
    trunk = {
      title = "*트렁크",
      description = "차량의 트렁크를 염."
    },
    detach_trailer = {
      title = "트레일러 분리",
      description = "트레일러를 분리합니다."
    },
    detach_towtruck = {
      title = "견인차 분리",
      description = "견인차를 분리 합니다."
    },
    detach_cargobob = {
      title = "카고밥 분리",
      description = "카고밥을 분리 합니다."
    },
    lock = {
      title = "*잠금/잠금 해제",
      description = "차량 잠금 또는 잠금해제."
    },
    engine = {
      title = "시동 ON/OFF",
      description = "시동을 켜거나 끕니다."
    },
    asktrunk = {
      title = "트렁크 열기 요청",
      asked = "~g~요청중...",
      request = "트렁크를 열어달라는 요청이 왔습니다. 승인합니까?"
    },
    replace = {
      title = "차량 교체",
      description = "가장 가까운 차량을 교체합니다."
    },
    repair = {
      title = "차량 수리",
      description = "근처에 있는 차량을 수리합니다."
    },
    hwrepair = {
      title = "[특별]차량 수리",
      description = "특별기능 : 근처에 있는 차량을 수리합니다."
    },
    sellTP = {
      title = "차량 판매",
      description = "가까운 플레이어에게 차량 판매."
    }
  },
  gunshop = {
    title = "아뮤네이션 ({1})",
    prompt_ammo = "구매할 탄약의 양 {1}:",
    info = "<em>몸체: </em> {1}<br /><em>탄약: </em> {2} /u<br /><br />{3}"
  },
  market = {
    title = "상점 ({1})",
    prompt = "금액 {1} 구매하기:",
    info = "{1}<br /><br />{2}"
  },
  skinshop = {
    title = "미용실"
  },
  cloakroom = {
    title = "옷장 ({1})",
    undress = {
      title = "> 복장"
    }
  },
  itemtr = {
    informer = {
      title = "불법 정보 제공자",
      description = "{1}",
      bought = "~g~위치가 GPS로 전송되었습니다.."
    }
  },
  mission = {
    blip = "미션 ({1}) {2}/{3}",
    display = '<span class="name">{1}</span> <span class="step">{2}/{3}</span><br /><br />{4}',
    cancel = {
      title = "미션 취소"
    }
  },
  aptitude = {
    title = "스탯",
    description = "스탯을 봅니다.",
    lose_exp = "~b~{1}/{2} ~w~경험치 ~r~{3}~w~이 하락 하였습니다.",
    earn_exp = "~b~{1}/{2} ~w~경험치 ~g~{3}~w~이 상승 하였습니다.",
    level_down = "~b~{1}/{2} ~r~{3}~w~레벨로 하락 하였습니다.",
    level_up = "~b~{1}/{2} ~g~{3}~w~레벨로 상승 하였습니다.",
    display = {
      group = "{1}: ",
      aptitude = "--- {1} | exp {2} | lvl {3} | 진행도 {4}%"
    }
  }
}

return lang
