local notifIn = false
local notifOut = false
local isInit = false
local protectMode = false
local defaultText = {
	"<b style='color:yellow'>회복구역에 진입하였습니다.</b>",
	"<b style='color:yellow'>회복구역에서 벗어났습니다.</b>"
}
local msgText = nil

local zones = {
	{
		points = {
			vector3(221.930, -919.046, 29.691),
			vector3(226.738, -912.218, 29.691),
			vector3(221.852, -908.788, 29.691),
			vector3(217.049, -915.655, 29.691)
		}
	}
}

function init()
	for k, v in pairs(zones) do
		v.area =
			pArea(
			{
				height = 2,
				color = {255, 255, 0, 10},
				border = {255, 255, 0, 100},
				fade = 50,
				wallFade = 50,
				threshold = 3.25,
				numbered = false
			}
		)
		for i, point in ipairs(v.points) do
			v.area.addPoint(point)
		end
	end
	msgText = defaultText
end

Citizen.CreateThread(
	function()
		init()
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			for k, v in pairs(zones) do
				if v.area ~= nil then
					v.area.draw()
					if v.area.isInside() then
						SetEntityInvincible(GetPlayerPed(-1), true)
						SetEntityHealth(GetPlayerPed(-1), 200)
						if not v.notifIn then
							ClearPlayerWantedLevel(PlayerId())
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
							notifIn = true
							v.notifIn = true
							v.notifOut = false
						end
					else
						if not v.notifOut then
							SetEntityInvincible(GetPlayerPed(-1), false)
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
							notifIn = false
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
		while true do
			Citizen.Wait(1000)
			if notifIn then
				Citizen.Wait(30000)
				if notifIn then
					TriggerServerEvent("zone3:getReward")
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(2000)
		isInit = true
	end
)
