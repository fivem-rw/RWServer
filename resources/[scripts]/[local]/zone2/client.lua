local notifIn = false
local notifOut = false
local isInit = false
local protectMode = true
local defaultText = {
	"<b style='color:rgba(121,255,0,1)'>보호구역에 진입하였습니다.</b>",
	"<b style='color:rgba(121,255,0,1)'>보호구역에서 벗어났습니다.</b>"
}
local protectText = {
	"<b style='color:red'>핵 방어구역에 진입하였습니다.</b>",
	"<b style='color:red'>핵 방어구역에서 벗어났습니다.</b>"
}
local msgText = nil

local zones = {
	{
		points = {
			vector3(261.776, -879.239, 28.155),
			vector3(211.406, -1018.058, 28.305),
			vector3(128.112, -989.577, 28.292),
			vector3(163.077, -893.555, 29.482),
			vector3(172.779, -877.982, 29.591),
			vector3(185.183, -844.169, 30.098),
			vector3(258.490, -870.804, 28.272)
		}
	},
	{
		points = {
			vector3(230.441, -818.019, 29.308),
			vector3(199.460, -806.758, 30.071),
			vector3(218.768, -754.260, 29.842),
			vector3(249.780, -764.997, 29.808)
		}
	},
	{
		points = {
			vector3(219.196, -752.639, 33.649),
			vector3(226.017, -733.666, 33.349),
			vector3(271.973, -749.351, 33.643),
			vector3(265.126, -768.173, 33.649)
		}
	},
	{
		points = {
			vector3(-2228.456, 286.827, 173.602),
			vector3(-2245.680, 279.154, 173.602),
			vector3(-2244.135, 275.644, 173.602),
			vector3(-2259.069, 268.949, 173.603),
			vector3(-2260.102, 265.097, 173.602),
			vector3(-2256.167, 256.479, 173.602),
			vector3(-2256.762, 235.828, 173.612),
			vector3(-2256.036, 233.664, 173.612),
			vector3(-2251.100, 233.593, 173.612),
			vector3(-2251.063, 235.578, 173.612),
			vector3(-2245.197, 235.443, 173.829),
			vector3(-2242.274, 234.509, 173.802),
			vector3(-2240.227, 233.049, 173.802),
			vector3(-2238.616, 230.993, 173.802),
			vector3(-2236.856, 227.177, 173.802),
			vector3(-2209.859, 239.189, 173.602),
			vector3(-2209.457, 240.231, 173.612),
			vector3(-2211.064, 243.815, 173.612),
			vector3(-2224.398, 277.969, 173.534)
		}
	}
}

zones = {}

RegisterNetEvent("zone2:changeMode")
AddEventHandler(
	"zone2:changeMode",
	function(mode)
		if mode == "protect" then
			protectMode = true
			init()
		else
			protectMode = false
			init()
		end
	end
)

function init()
	for k, v in pairs(zones) do
		if protectMode then
			v.area =
				pArea(
				{
					height = 30,
					color = {255, 0, 0, 20},
					border = {255, 0, 0, 200},
					fade = 100,
					wallFade = 50,
					threshold = 3.25,
					numbered = false
				}
			)
		else
			v.area =
				pArea(
				{
					height = 3,
					color = {0, 255, 0, 10},
					border = {0, 255, 0, 100},
					fade = 100,
					wallFade = 50,
					threshold = 3.25,
					numbered = false
				}
			)
		end
		for i, point in ipairs(v.points) do
			v.area.addPoint(point)
		end
	end
	if protectMode then
		msgText = protectText
	else
		msgText = defaultText
	end
end

Citizen.CreateThread(
	function()
		init()
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		SetEntityHealth(GetPlayerPed(-1),2000)
		SetEntityInvincible(GetPlayerPed(-1), true)
		NetworkSetFriendlyFireOption(true)
		while true do
			for k, v in pairs(zones) do
				if v.area ~= nil then
					v.area.draw()
					if v.area.isInside() then
						if protectMode then
							SetEntityInvincible(GetPlayerPed(-1), true)
							SetEntityHealth(GetPlayerPed(-1), 200)
						end
						if not v.notifIn then
							NetworkSetFriendlyFireOption(false)
							SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
							if isInit then
								TriggerEvent(
									"pNotify:SendNotification",
									{
										text = msgText[1],
										type = "success",
										timeout = (3000),
										layout = "bottomcenter",
										queue = "global"
									}
								)
							end
							v.notifIn = true
							v.notifOut = false
						end
					else
						if not v.notifOut then
							SetEntityInvincible(GetPlayerPed(-1), false)
							NetworkSetFriendlyFireOption(true)
							if isInit then
								TriggerEvent(
									"pNotify:SendNotification",
									{
										text = msgText[2],
										type = "error",
										timeout = (3000),
										layout = "bottomcenter",
										queue = "global"
									}
								)
							end
							v.notifOut = true
							v.notifIn = false
						end
					end
				end
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(2000)
		isInit = true
	end
)
