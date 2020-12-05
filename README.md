# RWServer
FiveM RealWorld Server

<h3>설치 방법</h3>

```diff

1. vrpfx.sql DB덤프파일 실행

2. configs/server-new.cfg 설정
set mysql_connection_string "mysql://[사용자]:[비밀번호]@[DB주소]/[DB명]?multipleStatements=true&connectTimeout=30000"
sv_licensekey [FiveM 라이센스 키]

3. starter/ServerStart-New.cmd 실행

```

<h3>리얼월드서버 디렉토리 구조</h3>

```diff
+ 코어:
C:\RWServer\core

+ 이미지 파일:
C:\RWServer\assets

+ 설정 파일:
C:\RWServer\configs

+ 로그 파일:
C:\RWServer\logs

+ 스타터:
C:\RWServer\starter

+ 서버웹:
C:\RWServer\web

+ 스크립트:
C:\RWServer\resources\[scripts]

+ VRP:
C:\RWServer\resources\[scripts]\[local]\[vrp]

+ 정적 파일:
C:\RWServer\resources\[static]
정적 파일은 맵,스킨,차량,무기 등의 리소스가 위치합니다. (별도로 제공되는 링크에서 파일을 설치)
```

<h3>리얼월드 주요 스크립트 설명</h3>

```diff
+ doorlockcop
키 아이템으로 도어 제어가 가능한 도어락
슬라이드문 강제닫음 기능
100개 이상의 도어락 적용가능 하도록 최적화

+ evp
기본 핵방지 시스템
CreateObject, CreateObjectNoOffset, CreateForcedObject, CreateVehicle, CreatePed, AddExplosion API 함수 악의적인 실행 방지
클라이언트단 암호화 적용

+ showimg
사용자에게 이미지 출력
특정 유저 또는 모든 유저에게 출력 가능

+ zone2 + parea
광장 및 메인차고 안전구역

+ zone3 + parea
잠수존

+ [vrp]/vrp/shared/encrypt.lua
이벤트 변조 방지 및 암호화

+ [vrp]/vrp/cfg/item/dataitems.lua + [vrp]/vrp/modules/inventory.lua
동적아이템 설정
동적아이템: 아이템안에 데이터를 동적으로 설정 할 수 있는 아이템
스킨박스, 차량지급권, 마스크박스 등

+ [vrp]/[JOB]/*
일반 직업

+ [vrp]/vrp_goldcurrency
금괴 RP

+ [vrp]/[Manager]/ObjectManager
차량,오브젝트,페드 등 범위 제거

+ [vrp]/[Manager]/dh
핵감지 및 자동 벤, 로그 실행

+ [vrp]/[Manager]/sb_manager
사용자 모니터링

+ [vrp]/[Manager]/ws_manager + WebSocketServer
웹소켓 통신 모듈
웹소켓을 이용하여 서버 <-> 외부서버 의 통신이 가능

+ [vrp]/[phone]/*
리얼월드 신형 휴대폰

+ [vrp]/vrp_area_control
리얼월드 매미게임

+ [vrp]/vrp_bag
리얼월드 가방

+ [vrp]/vrp_backpack_respawn
커스텀 백팩 사라짐 오류 픽스

+ [vrp]/vrp_bc
DUI 방송 모듈
범위를 벗어나면 영상 종료
범위에 들어오면 모든유저와 같은화면이 출력되도록 동기화
신규유저가 접속했을 경우에도 같은 화면이 출력되도록 동기화

+ [vrp]/vrp_deathmatch
데스매치
개인전 및 팀전

+ [vrp]/vrp_lottery
추첨박스

+ [vrp]/vrp_musicbox
뮤직박스
HTML UI 제공
범위설정 및 소리 설정기능
뮤직박스와의 거래에 따라 소리 크기 자동 조절
뮤직박스 범위를 벗어나면 자동 OFF
뮤직박스 범위안에 들어오면 기존유저와 재생위치 동기화

+ [vrp]/vrp_names
유저 이름 출력

+ [vrp]/vrp_newbie
뉴비인증

+ [vrp]/vrp_rw_userlist
스코어보드

+ [vrp]/vrp_teleport
범위 텔레포트

+ [vrp]/vrp_vc
라이브 카지노

+ [vrp]/vrp_voicechat
채팅 리딩 시스템

+ [vrp]/vrp_zombie
좀비존
구역별 좀비존 생성 가능
좀비 바이러스 감염 및 바이러스 해독 기능
```
