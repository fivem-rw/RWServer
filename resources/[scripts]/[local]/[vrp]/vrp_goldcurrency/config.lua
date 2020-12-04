--------------------------------
----- Converting By. 알고리즘 -----
--------------------------------

Config = {}

-- 경찰 셋팅:
Config.RequiredPoliceOnline = 0 -- 플레이어가 미션을 수행하기 위해 필요한 온라인 경찰 n명
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

-- 금괴 습격 NPC 맵 아이콘 설정:
Config.EnableMapBlip = true -- 금괴 습격 장소 맵 아이콘 True = 활성화 False = 비활성화
Config.BlipNameOnMap = "금괴 습격 미션" -- 금괴 습격 미션 장소 이름 설정
Config.BlipSprite = 280 -- 맵 아이콘 스프라이트 설정, 스프라이트 ID 목록은 여기 참고: https://docs.fivem.net/game-references/blips/
Config.BlipDisplay = 4 -- 맵 아이콘 설정, 유형 목록 찾기: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.BlipScale = 0.8 -- 맵 아이콘 크기 설정
Config.BlipColour = 5 -- 맵 아이콘 색깔 설정, 색깔 목록은 여기 참고: https://docs.fivem.net/game-references/blips/

-- 금괴 습격을 시작했을때 습격 장소 또는 적 NPC 설정

Config.MissionPosition = {
	{
		Location = vector3(2212.9194335938, 5613.9643554688, 54.200061798096),
		InUse = false,
		Heading = 342.84,
		GoonSpawns = {
			NPC1 = {
				x = 2201.42,
				y = 5610.36,
				z = 53.53,
				h = 339.79,
				ped = "G_M_Y_Lost_02",
				animDict = "amb@world_human_cop_idles@female@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			},
			NPC2 = {
				x = 2194.21,
				y = 5614.47,
				z = 54.17,
				h = 271.37,
				ped = "G_M_Y_MexGang_01",
				animDict = "rcmme_amanda1",
				anim = "stand_loop_cop",
				weapon = "WEAPON_PISTOL"
			},
			NPC3 = {
				x = 2194.11,
				y = 5608.79,
				z = 53.64,
				h = 332.48,
				ped = "G_M_Y_SalvaBoss_01",
				animDict = "amb@world_human_leaning@male@wall@back@legs_crossed@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			}
			--[[			NPC4 = {
				x = 2218.32,
				y = 5616.02,
				z = 54.72,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			},
			NPC5 = {
				x = 2206.64,
				y = 5598.96,
				z = 53.74,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			}]]
		}
	},
	{
		Location = vector3(2539.3227539063, 4667.3051757813, 34.057430267334),
		InUse = false,
		Heading = 17.77,
		GoonSpawns = {
			NPC1 = {
				x = 2549.01,
				y = 4669.23,
				z = 34.08,
				h = 4.96,
				ped = "G_M_Y_Lost_02",
				animDict = "amb@world_human_cop_idles@female@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			},
			NPC2 = {
				x = 2558.2,
				y = 4673.08,
				z = 34.08,
				h = 48.73,
				ped = "G_M_Y_MexGang_01",
				animDict = "rcmme_amanda1",
				anim = "stand_loop_cop",
				weapon = "WEAPON_PISTOL"
			},
			NPC3 = {
				x = 2545.5776367188,
				y = 4675.0551757813,
				z = 34.009281158447,
				h = 331.84777832032,
				ped = "G_M_Y_SalvaBoss_01",
				animDict = "amb@world_human_leaning@male@wall@back@legs_crossed@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			}
			--[[			NPC4 = {
				x = 2543.25,
				y = 4659.06,
				z = 34.07,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			},
			NPC5 = {
				x = 2557.72,
				y = 4685.54,
				z = 34.06,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			}		]]
		}
	},
	{
		Location = vector3(1461.0035400391, 6549.5546875, 14.42578792572),
		InUse = false,
		Heading = 178.32929992676,
		GoonSpawns = {
			NPC1 = {
				x = 1465.4285888672,
				y = 6541.6909179688,
				z = 14.275111198425,
				h = 64.84741973877,
				ped = "G_M_Y_Lost_02",
				animDict = "amb@world_human_cop_idles@female@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			},
			NPC2 = {
				x = 1466.6131591797,
				y = 6553.9331054688,
				z = 13.999475479126,
				h = 131.08628845214,
				ped = "G_M_Y_MexGang_01",
				animDict = "rcmme_amanda1",
				anim = "stand_loop_cop",
				weapon = "WEAPON_PISTOL"
			},
			NPC3 = {
				x = 1458.552734375,
				y = 6559.8950195313,
				z = 14.043141365051,
				h = 172.92164611816,
				ped = "G_M_Y_SalvaBoss_01",
				animDict = "amb@world_human_leaning@male@wall@back@legs_crossed@base",
				anim = "base",
				weapon = "WEAPON_PISTOL"
			}
			--[[			NPC4 = {
				x = 1426.53,
				y = 6553.03,
				z = 15.50,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			},
			NPC5 = {
				x = 1431.70,
				y = 6565.39,
				z = 15.45,
				h = 332.48,
				ped = 'G_M_Y_SalvaBoss_01',
				animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base',
				anim = 'base',
				weapon = 'WEAPON_PISTOL',
			}]]
		}
	}
}

-- 금괴가 든 차량 배달 하는곳 설정:
Config.DeliveryPoints = {
	vector3(3333.92, 5161.19, 18.31)
}

-- 금괴가 든 차량 배달 하는곳 마커 설정:
Config.DeliveryDrawDistance = 50.0
Config.DeliveryMarkerType = 27
Config.DeliveryMarkerScale = {x = 3.0, y = 3.0, z = 1.0}
Config.DeliveryMarkerColor = {r = 255, g = 255, b = 0, a = 100}

-- GTA5 스타일로 미션 성공 또는 미션 실패 알림 True = 활성화 False = 비활성화
Config.EnableCustomNotification = true

-- 금괴 습격을하기위해 True = BlackMoney로 결제 False = 현금으로 결제 설정:
Config.UseBlackMoneyAsMissionCost = true

-- 금괴 습격을 하기위해 검은돈 n원 설정
Config.MissionCost = 1

-- 금괴 습격을 재시작 하려면 쿨타임 시간 설정 (분) 예시) 3분
Config.JobCooldownTime = 120

-- 보상 설정:
Config.ItemName1 = "goldwatch" -- 금괴가 든 차량을 배달할때 Goldwatch 아이템을 얻는다.
Config.ItemMinAmount1 = 1 -- ItemName1 아이템의 최소 보상 금액 설정
Config.ItemMaxAmount1 = 5 -- ItemName1 아이템의 최대 보상 금액 설정
Config.EnableSecondItemReward = false -- 랜덤 50% 확률로 다른아이템을 얻는다 True = 활성화 False = 비활성화 (비활성화 권장)
Config.ItemName2 = "special_goldbar" -- Goldwatch 아이템을 녹이면 goldbar 아이템을 얻는다.
Config.ItemMinAmount2 = 1 -- ItemName2 아이템의 최소 보상 금액 설정
Config.ItemMaxAmount2 = 3 -- ItemName2 아이템의 최대 보상 금액 설정
Config.RandomChance = 2 -- 확률 설정 1/2이 기본값이며 50% 확률입니다. 예를 들어 값을 4로 변경하면 1/4은 25% 확률입니다.

-- Goldwatch 를 얻고 goldbar 로 바꾸는 곳
Config.GoldSmeltery = {
	{["x"] = 1109.93, ["y"] = -2008.24, ["z"] = 31.06, ["h"] = 0}
}

-- 금을 녹이는곳 마커 설정
Config.SmelteryMarker = 27
Config.SmelteryMarkerColor = {r = 255, g = 255, b = 0, a = 100}

-- Goldwatch를 goldbar 바꾸는데에 걸리는 시간 설정 n 초 예시) 15초
Config.SmelteryTime = 120

-- 금을 녹이는곳 맵 아이콘 True = 활성화 Fasle = 비활성화
Config.EnableSmelteryBlip = true

-- 금괴를 현금으로 환전하는 장소 설정
Config.GoldExchange = {
	{["x"] = -112.09439849854, ["y"] = 6469.2270507813, ["z"] = 31.626708984375, ["h"] = 0}
}

-- 환전하는 장소 마커 설정
Config.ExchangeMarker = 27
Config.ExchangeMarkerColor = {r = 255, g = 255, b = 0, a = 100}

-- goldbar를 현금으로 바꾸는데에 걸리는 시간 설정 n초 예시) 10초
Config.ExchangeTime = 10

-- 금괴를 현금으로 환전 하는곳 맵 아이콘 True = 활성화 Fasle = 비활성화
Config.EnableExchangeBlip = true

-- Set cooldown for doing gold exchanges in minutes:
Config.ExchangeCooldown = 5
