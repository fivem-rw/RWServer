vrp_area_controlC = {}
Tunnel.bindInterface("vrp_area_control", vrp_area_controlC)
Proxy.addInterface("vrp_area_control", vrp_area_controlC)
vRP = Proxy.getInterface("vRP")
vrp_area_controlS = Tunnel.getInterface("vrp_area_control", "vrp_area_control")

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
			vector3(213.072, -924.993, 29.691),
			vector3(209.188, -922.626, 29.826),
			vector3(214.085, -915.673, 29.856),
			vector3(217.598, -918.606, 29.691)
		}
	}
}

local markers3 = {
	["lucky1"] = {213.71647644043, -919.64672851563, 30.691400527954, 2.0, {0, 255, 0, 100}, {"[매미게임]", "당첨금: 50만원 - 5억원"}}
}

function DrawText3D(x, y, z, text, size, color)
	if size == nil then
		size = 2
	end
	if color == nil then
		color = {
			r = 0,
			g = 255,
			b = 0,
			a = 255
		}
	end
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

	local scale = (1 / dist) * size
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.6 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(color.r, color.g, color.b, color.a)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

local defaultAreaColor = {255, 255, 255, 10}

function init()
	for k, v in pairs(zones) do
		v.area =
			pArea(
			{
				height = 3,
				color = defaultAreaColor,
				border = {255, 255, 255, 50},
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
		local ped = GetPlayerPed(-1)
		FreezeEntityPosition(ped, false)
		init()
	end
)

local isChanged = false

function vrp_area_controlC.startEffect()
	if not isChanged then
		isChanged = true
		for k, v in pairs(zones) do
			v.area.setColor({255, 0, 0, 20})
		end
		Citizen.Wait(10000)
		for k, v in pairs(zones) do
			v.area.setColor(defaultAreaColor)
		end
		isChanged = false
	end
end

local fthrow_net = nil

Citizen.CreateThread(
	function()
		while true do
			for k, v in pairs(zones) do
				if v.area ~= nil then
					v.area.draw()
					if v.area.isInside() then
						if not v.notifIn then
							if isInit and not isAuthProcess then
								local ped = GetPlayerPed(-1)
								isAuthProcess = true
								FreezeEntityPosition(ped, true)
								DetachEntity(ped, true, false)
								vrp_area_controlS.checkTicket(
									{},
									function(status)
										if status then
											FreezeEntityPosition(ped, false)
											if NetworkGetEntityIsNetworked(ped) then
												fthrow_net = PedToNet(ped)
												if fthrow_net then
													TriggerServerEvent("fthrow:SyncStartParticles", fthrow_net, 3.0, 0.0, "water_splash_shark_wade", 1)
												end
											end
											isPassed = true
											isAuthProcess = false
										else
											SetEntityCoords(ped, 213.61709594727 + (math.random(1, 20) / 10), -909.59857177734 + (math.random(1, 20) / 10), 32.093395233154 + (math.random(1, 20) / 10))
											Citizen.Wait(10000)
											FreezeEntityPosition(ped, false)
											isAuthProcess = false
										end
									end
								)
							end
							notifIn = true
							v.notifIn = true
							v.notifOut = false
						end
					else
						if not v.notifOut then
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
					SetEntityCoords(ped, 218.85963439941, -910.32873535156, 30.691402435303)
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
		Citizen.Wait(500)
		while true do
			Citizen.Wait(1)
			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			local isSelect = false
			local selectBetType = nil
			for k, v in pairs(markers3) do
				DrawMarker(1, v[1], v[2], v[3] - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, v[5][1], v[5][2], v[5][3], v[5][4], 0, 0, 0, 0)
				v.dist = Vdist(playerPos.x, playerPos.y, playerPos.z, v[1], v[2], v[3])
				if v.dist < v[4] then
					isSelect = true
					selectBetType = k
					--DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, "~y~[E]~w~키를 눌러 구매", 1.5)
					if not isAutoBet and IsControlJustReleased(1, 51) then
					end
				end
			end
			if not isSelect then
				for k, v in pairs(markers3) do
					if v.dist > v[4] and v.dist < 10 then
						DrawText3D(v[1], v[2], v[3] + 0.8, v[6][1], 2.1, {r = v[5][1], g = v[5][2], b = v[5][3], a = 250})
						DrawText3D(v[1], v[2], v[3] + 0.6, v[6][2], 1.5, {r = 255, g = 255, b = 255, a = 250})
					end
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
