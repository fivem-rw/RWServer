----------------- vRP Castle Control
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vrp_castle_controlC = {}
Tunnel.bindInterface("vrp_castle_control", vrp_castle_controlC)
Proxy.addInterface("vrp_castle_control", vrp_castle_controlC)
vRP = Proxy.getInterface("vRP")
vrp_castle_controlS = Tunnel.getInterface("vrp_castle_control", "vrp_castle_control")

local notifIn = false
local isInit = false
local protectMode = false
local defaultText = {
	"<b style='color:yellow'>진입하였습니다.</b>",
	"<b style='color:yellow'>벗어났습니다.</b>"
}
local msgText = nil

local isAuth = false
local isFired = false
local isPassed = false
local fthrow_net = nil

local zones = {
	{
		points = {
			vector3(1837.276, 258.013, 130.000),
			vector3(1874.414, 209.390, 130.000),
			vector3(1983.587, 137.958, 130.000),
			vector3(2036.574, 164.274, 130.000),
			vector3(2057.454, 300.365, 130.000),
			vector3(1913.697, 394.309, 130.000),
			vector3(1835.015, 342.359, 130.000)
		}
	}
	--[[,
	{
		points = {
			vector3(-1663.365, -818.625, 9.198),
			vector3(-1745.587, -903.363, 6.714),
			vector3(-1823.612, -821.194, 5.210),
			vector3(-1753.381, -735.723, 9.242)
		}
	}
	]]
}

function init()
	for k, v in pairs(zones) do
		v.area =
			pArea(
			{
				height = 100,
				color = {255, 255, 255, 5},
				border = {255, 255, 0, 50},
				fade = 300,
				wallFade = 300,
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

local fthrow_net = nil

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			for k, v in pairs(zones) do
				if v.area ~= nil then
					v.area.draw()

					if v.area.isInside() then
						if not v.notifIn then
							if isInit then
								--FreezeEntityPosition(GetPlayerPed(-1), true)
							end
							notifIn = true
							v.notifIn = true
							v.notifOut = false
						end
					else
						if not v.notifOut then
							if isInit then
								--FreezeEntityPosition(GetPlayerPed(-1), false)
							end
							isAuth = false
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

local isAuthProcess = false

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(2000)
			if notifIn then
				local ped = GetPlayerPed(-1)
				local isComa = vRP.isInComa({})
				if isComa then
					FreezeEntityPosition(ped, true)
					if NetworkGetEntityIsNetworked(ped) then
						fthrow_net = PedToNet(ped)
						if fthrow_net then
							TriggerServerEvent("fthrow:SyncStartParticles", fthrow_net, 5.0, -1.5, "exp_sht_flame", 1)
						end
					end
					Citizen.Wait(5000)
					SetEntityHealth(ped, 200)
					Citizen.Wait(100)
					SetEntityCoords(ped, 1912.5197753906, 215.96340942383, 165.0701751709)
					Citizen.Wait(1000)
					if fthrow_net then
						TriggerServerEvent("fthrow:SyncStopParticles", fthrow_net)
					end
					FreezeEntityPosition(ped, false)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while false do
			Citizen.Wait(100)
			if notifIn and not isAuth and not isAuthProcess then
				isAuthProcess = true
				DetachEntity(GetPlayerPed(-1), true, false)
				vrp_castle_controlS.checkTicket(
					{},
					function(status)
						local ped = GetPlayerPed(-1)
						isAuthProcess = false
						if status then
							isAuth = true
							FreezeEntityPosition(ped, false)
							if NetworkGetEntityIsNetworked(ped) then
								fthrow_net = PedToNet(ped)
								if fthrow_net then
									isPassed = true
									TriggerServerEvent("fthrow:SyncStartParticles", fthrow_net, 10.0, 0.0, "water_splash_shark_wade", 1)
								end
							end
						else
							isAuth = false
							SetEntityCoords(ped, 31.747270584106, -279.43103027344, 470.726169586182)
							if NetworkGetEntityIsNetworked(ped) then
								fthrow_net = PedToNet(ped)
								if fthrow_net then
									isFired = true
									TriggerServerEvent("fthrow:SyncStartParticles", fthrow_net, 5.0, -1.5, "exp_sht_flame", 1)
								end
							end
							Citizen.Wait(1000)
							FreezeEntityPosition(ped, false)
						end
					end
				)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(100)
			if isFired then
				isFired = false
				Citizen.Wait(30000)
				if fthrow_net then
					TriggerServerEvent("fthrow:SyncStopParticles", fthrow_net)
				end
			end
			if isPassed then
				isPassed = false
				Citizen.Wait(5000)
				if fthrow_net then
					TriggerServerEvent("fthrow:SyncStopParticles", fthrow_net)
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
