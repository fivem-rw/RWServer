--------------------------------
----- Converting By. BLYYN -----
--------------------------------

Config = {}

-- 경찰 셋팅:
Config.RequiredPoliceOnline = 3 -- 플레이어가 미션을 수행하기 위해 필요한 온라인 경찰 n명
Config.PoliceDatabaseName = "cop.whitelisted" -- 경찰 직업 설정
Config.PoliceNotfiyEnabled = true -- 금괴 습격 당했다라는 경찰 알림 True = 활성화 false = 비활성화
Config.PoliceBlipShow = true -- 금괴 습격 당했을때의 맵 아이콘 위치 True = 활성화 false = 비활성화
Config.PoliceBlipTime = 30 -- 맵 아이콘 위치 활성화되는 시간 1(초당) (이 값은 Server.lua에서 4를 곱한 값)
Config.PoliceBlipRadius = 50.0 -- 금괴 습격 당했을때 맵 아이콘 반경 설정
Config.PoliceBlipAlpha = 250 -- 맵 아이콘 알파 설정
Config.PoliceBlipColor = 5 -- 맵 아이콘 색깔 설정

-- 금괴 습격 시작하는곳 설정:
Config.MissionNPC = {
	{
		Pos = {x = 3311.26, y = 5176.45, z = 19.61}, -- NPC 미션 받는곳
		Heading = 231.39, -- NPC 회전 값
		Ped = "s_m_y_dealer_01" -- NPC 모델(PED)코드
	}
}

-- NPC의 맵에서 깜박이기를 원하는지 여부에 따라 true / false로 설정하십시오.
Config.EnableGoldJobBlip = true

-- 습격 NPC 맵 아이콘 설정:
Config.EnableMapBlip = true -- 금괴 습격 장소 맵 아이콘 True = 활성화 False = 비활성화
Config.BlipNameOnMap = "월드 발전소" -- 금괴 습격 미션 장소 이름 설정
Config.BlipSprite = 280 -- 맵 아이콘 스프라이트 설정, 스프라이트 ID 목록은 여기 참고: https://docs.fivem.net/game-references/blips/
Config.BlipDisplay = 4 -- 맵 아이콘 설정, 유형 목록 찾기: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.BlipScale = 0.8 -- 맵 아이콘 크기 설정
Config.BlipColour = 5 -- 맵 아이콘 색깔 설정, 색깔 목록은 여기 참고: https://docs.fivem.net/game-references/blips/