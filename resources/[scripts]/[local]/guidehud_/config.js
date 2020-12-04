var config = {
  'title': '리얼월드 - 리얼 캐쥬얼 롤플레잉 (RC RP)',
  'welcomeMessage': '리얼월드에 오신것을 환영합니다.',
  // Add images for the loading screen background.
  images: [
    '../assets/img/back1.jpg', '../assets/img/back2.jpg', '../assets/img/back3.jpg', '../assets/img/back4.jpg', '../assets/img/back5.jpg', '../assets/img/back6.jpg',
  ],
  // Turn on/off music
  enableMusic: true,
  // Music list. (Youtube video IDs). Last one should not have a comma at the end.
  music: [
    ['tzKvhiTmDnQ',0],
    ['Re-kcP0OTqs',0],
    //['mDS4-3k3Lu4',11],
    ['2Wzzb3KbSzQ',0]
  ],
  // Change music volume 0-100.
  musicVolume: 10,
  // Change Discord settings and link.
  'discord': {
    'show': true,
    'discordLink': 'https://discord.gg/realw',
  },
  // Change which key you have set in guidehud/client/client.lua
  'menuHotkey': 'F1',
  // Turn on/off rule tabs. true/false
  'rules': {
    'generalconduct': true,
    'roleplaying': true,
    'rdmvdm': true,
    'metagaming': true,
    'newlife': true,
    'abuse': true,
  },
}

// Home page annountments.
var announcements = [
  '* 세계관 및 규칙',
  '현실세계와 매우 흡사한 리얼리티 롤플레잉을 추구합니다.',
  '게임의 최종 목표는 유저가 조직 또는 기업을 만들고 많은 불로소득을 받을 수 있는 레벨을 달성하는 것입니다.',
  '인게임상의 물가는 현실세계의 물가를 그대로 반영하였습니다.',
  '리얼월드는 안전구역과 제한구역이 존재합니다 디스코드를 통해 해당 구역을 확인 하신 후 플레이하시길 바랍니다.',
  '리얼월드 디스코드: <span style="color:yellow">https://discord.gg/realw</span>'
]



// Modify hotkeys below.
var generalhotkeys = [
  '<kbd>F2</kbd> 접속 인원 확인',
  '<kbd>F11</kbd> 리얼월드 매뉴얼',
  '<kbd>HOME</kbd> 음성채팅 범위조절',
  '<kbd>OOC</kbd> RP외의 일반 전체대화: /ooc [할말] (예: /ooc 안녕하세요.)',
  '<kbd>TWIT</kbd> RP 전체 대화: /twit [할말] (예: /twit 출근했습니다.)',
  '※ 개인 귓속말: /w [고유번호] [할말] (예: /w 1 관리자님 안녕하세요)'
]

var rphotkeys = [
  '<kbd>W</kbd> 앞으로 가기',
  '<kbd>A</kbd> 왼쪽으로 가기',
  '<kbd>D</kbd> 오른쪽으로 가기',
  '<kbd>S</kbd> 뒤로 가기',
  '<kbd>R</kbd> 때리기',
  '<kbd>X</kbd> 손들기',
  '<kbd>H</kbd> 손들고있기',
  '<kbd>K</kbd> 휴대폰 열기',
  '<kbd>B</kbd> 손가락으로 가리키기',
  '<kbd>P</kbd> 지도 열기',
  '<kbd>F5</kbd> 걷기 포즈',
  '<kbd>F6</kbd> 물건사용 행동하기',
  '<kbd>F7</kbd> 댄스',
  '<kbd>Shift+N</kbd> 닉네임 가리기',
  '<kbd>Z</kbd> 해독제사용/금속탐지기 사용',
  '<kbd>U</kbd> 인벤토리 열기',
  '<kbd>`</kbd> 쓰러지기',
  '<kbd>Tab</kbd> 무기 인벤토리',
  '<kbd>Ctrl</kbd> 웅크리기',
  '<kbd>Insert</kbd> 안전벨트',
  '<kbd>Backspace</kbd> 휴대폰 닫기'
]

var vehiclehotkeys = [
  '<kbd>Delitte</kbd> 차량 문 잠그기/열기',
  '<kbd>M</kbd> 차량 잠금 메뉴',
]

var jobshotkeys = [
]