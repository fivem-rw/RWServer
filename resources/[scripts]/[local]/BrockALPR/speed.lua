local radarDefault = {
	shown = false,
	freeze = false,
	info = "~w~차량이 감지되지 않았습니다.",
	info2 = "~w~차량이 감지되지 않았습니다.",
	minSpeed = 5.0,
	maxSpeed = 75.0
}

local radar = {
	shown = false,
	freeze = false,
	info = radarDefault.info,
	info2 = radarDefault.info2,
	minSpeed = radarDefault.minSpeed,
	maxSpeed = radarDefault.maxSpeed
}

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1 + w, y - 0.02 + h)
end

Citizen.CreateThread(
	function()
		while true do
			Wait(0)
			if IsControlJustPressed(1, 128) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
				if radar.shown then
					radar.shown = false
					radar = radarDefault
				else
					radar.shown = true
				end
				Wait(75)
			end
			if IsControlJustPressed(1, 127) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
				if radar.freeze then
					radar.freeze = false
				else
					radar.freeze = true
				end
			end
			if radar.shown then
				if radar.freeze then
					DrawAdvancedText(0.591, 0.065, 0.005, 0.0028, 0.3, "정면 카메라", 255, 0, 0, 255, 6, 0)
					DrawAdvancedText(0.591, 0.125, 0.005, 0.0028, 0.3, "후면 카메라", 255, 0, 0, 255, 6, 0)
				else
					DrawAdvancedText(0.591, 0.065, 0.005, 0.0028, 0.3, "정면 카메라", 0, 191, 255, 255, 6, 0)
					DrawAdvancedText(0.591, 0.125, 0.005, 0.0028, 0.3, "후면 카메라", 0, 191, 255, 255, 6, 0)
				end
				DrawRect(0.508, 0.10, 0.380, 0.135, 0, 0, 0, 150)
				DrawAdvancedText(0.6, 0.090, 0.005, 0.0028, 0.35, radar.info, 255, 255, 255, 255, 6, 0)
				DrawAdvancedText(0.6, 0.150, 0.005, 0.0028, 0.35, radar.info2, 255, 255, 255, 255, 6, 0)
			end

			if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
				radar.shown = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Wait(100)
			if radar.shown then
				if radar.freeze == false then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)

					if IsEntityAVehicle(e) then
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						local fvspeed = GetEntitySpeed(e) * 3.6
						local fplate = GetVehicleNumberPlateText(e)
						radar.info = string.format("~y~번호판: ~w~%s  ~y~모델: ~w~%s  ~y~속도: ~w~%s km/h", fplate, fmodel, math.ceil(fvspeed))
						radar.updated = true
					end

					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)

					if IsEntityAVehicle(j) then
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						local bvspeed = GetEntitySpeed(j) * 3.6
						local bplate = GetVehicleNumberPlateText(j)
						radar.info2 = string.format("~y~번호판: ~w~%s  ~y~모델: ~w~%s  ~y~속도: ~w~%s km/h", bplate, bmodel, math.ceil(bvspeed))
						radar.updated2 = true
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			radar.updated = false
			Wait(10000)
			if not radar.updated and not radar.freeze then
				radar.info = radarDefault.info
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			radar.updated2 = false
			Wait(10000)
			if not radar.updated2 and not radar.freeze then
				radar.info2 = radarDefault.info2
			end
		end
	end
)
