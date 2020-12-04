---------------------------------------------------------
------------ VRP Eventbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_eventbox2C = {}
Tunnel.bindInterface("vrp_eventbox2", vrp_eventbox2C)
Proxy.addInterface("vrp_eventbox2", vrp_eventbox2C)
vRP = Proxy.getInterface("vRP")
vrp_eventbox2S = Tunnel.getInterface("vrp_eventbox2", "vrp_eventbox2")

incircle = false
giftBox = vector3(218.96659851074, -868.35919189453, 30.492237091064)
giftBoxOpen = vector3(219.3078918457, -863.89447021484, 30.283987045288)

local inProgress = false

function printStateText(text, y, s)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(s, s)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	--SetTextRightJustify(true)
	SetTextWrap(0.0, 0.45)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.015, y)
end

function giftbox_DisplayText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawTxt(x, y, z, text, zscale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

	local scale = (1 / dist) * 2
	local fov = (1 / GetGameplayCamFov()) * 70
	local scale = scale * fov

	if zscale == nil then
		zscale = 0.7
	end

	if onScreen then
		SetTextScale(0.0 * scale, zscale * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
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

eventStateText1 = ""
eventStateText2 = ""
eventStateText3 = ""

function vrp_eventbox2C.getState(state, total, user_id, name, amount)
	eventStateText1 = ""
	if state == true then
		eventStateText1 = eventStateText1 .. "~g~🔥 부활데이 이벤트 ~b~(진행중)"
	else
		eventStateText1 = eventStateText1 .. "~g~🔥 부활데이 이벤트 ~r~(마감) ~y~(교환중)"
	end

	eventStateText2 = ""
	eventStateText2 = eventStateText2 .. "~w~- 당첨 누적금액: ~y~" .. format_num(total) .. "원"

	eventStateText3 = ""
	if user_id ~= nil and name ~= nil and amount ~= nil and user_id ~= "" then
		eventStateText3 = eventStateText3 .. "~w~- 최고 당첨금액: ~r~" .. format_num(amount) .. "원" .. " ~w~(~w~" .. user_id .. " | " .. name .. ")"
	end
end

function vrp_eventbox2C.getEventBox(username, data)
	SetNuiFocus(true, true)
	SendNUIMessage(
		{
			type = "checkResult",
			username = username,
			data = data
		}
	)
end

RegisterNUICallback(
	"hideResult",
	function(data, cb)
		SetNuiFocus(false, false)
	end
)

Citizen.CreateThread(
	function()
		SetNuiFocus(false, false)
		while true do
			Citizen.Wait(1)

			--printStateText(eventStateText1, 0.48, 0.38)
			--printStateText(eventStateText2, 0.48 + 0.045, 0.3)
			--printStateText(eventStateText3, 0.48 + 0.07, 0.3)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			local px, py, pz = playerPos.x, playerPos.y, playerPos.z

			if GetDistanceBetweenCoords(giftBox.x, giftBox.y, giftBox.z, px, py, pz, true) <= 100 then
				DrawTxt(giftBox.x, giftBox.y, giftBox.z + 2.40, tostring(""))
				DrawMarker(1, giftBox.x, giftBox.y, giftBox.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 0.2, 255, 255, 0, 100, 0, 0, 0, 0)
			end

			local dist = Vdist(giftBox.x, giftBox.y, giftBox.z, px, py, pz)

			if dist < 50 and dist > 1.2 then
				DrawTxt(giftBox.x, giftBox.y, giftBox.z + 0.75, "~y~[부활데이 이벤트]", 1.2)
				--DrawTxt(giftBox.x, giftBox.y, giftBox.z + 0.55, "~r~[E]~w~키를 눌러 ~g~부활석 ~w~확인", 0.9)
				DrawTxt(giftBox.x, giftBox.y, giftBox.z + 0.55, "~r~[E]~w~키를 눌러 ~g~문화상품권 ~w~교환", 0.9)
			end

			if dist < 1.2 then
				--DrawTxt(px - 1.5, py - 1.5, pz, "~r~[E]~w~키를 눌러 ~g~부활석 ~w~확인", 1.0)
				--DrawTxt(px - 1.5, py - 1.5, pz - 0.3, "~r~[G]~w~키를 눌러 ~g~부활석 ~w~제작", 1.0)
				DrawTxt(px - 1.5, py - 1.5, pz - 0.3, "~r~[E]~w~키를 눌러 ~g~문화상품권 ~w~교환", 1.0)
				DrawTxt(px - 1.5, py - 1.5, pz - 0.6, "~r~[Z]~w~키를 눌러 ~y~문화상품권 ~w~확인", 1.0)
				if not inProgress then
					if IsControlJustReleased(1, 51) then
						vrp_eventbox2S.reqEventBox()
						--[[
						inProgress = true
						vrp_eventbox2S.checkOpenBox(
							{},
							function(ok)
								if ok then
									ClearPedTasks(GetPlayerPed(-1))
									TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_YOGA", 0, true)
									exports["progressBars"]:startUI(5000, "부활석에 소원을 비는중..")
									Citizen.Wait(5000)
									vrp_eventbox2S.openBox()
									ClearPedTasks(GetPlayerPed(-1))
									inProgress = false
								else
									inProgress = false
								end
							end
						)
						]]
					elseif (IsControlJustReleased(1, 47)) then
						inProgress = true
						vrp_eventbox2S.checkGenStone(
							{},
							function(ok)
								if ok then
									ClearPedTasks(GetPlayerPed(-1))
									TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
									exports["progressBars"]:startUI(5000, "부활석을 제작하는중..")
									Citizen.Wait(5000)
									vrp_eventbox2S.genStone()
									ClearPedTasks(GetPlayerPed(-1))
									inProgress = false
								else
									inProgress = false
								end
							end
						)
					elseif (IsControlJustReleased(1, 20)) then
						vrp_eventbox2S.viewEventResult()
					end
				end
			end
		end
	end
)
