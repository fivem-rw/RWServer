vrp_slotC = {}
Tunnel.bindInterface("vrp_slot", vrp_slotC)
Proxy.addInterface("vrp_slot", vrp_slotC)
vRP = Proxy.getInterface("vRP")
vrp_slotS = Tunnel.getInterface("vrp_slot", "vrp_slot")

vectorChairPos = {944.62817382813, 55.98815536499, 75.991271972656}
closestChair = -1
closestChairDist = 1000
sittingAtBlackjackTable = false
forceExitShit = false

local PlayerData = {}
local open = false

function drawNativeNotification(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function showHowToBlackjack(flag)
	if Config.Sloty[closestChair][6] then
		RageUI.Visible(RMenu:Get(Config.Sloty[closestChair][6], "instructions"), flag)
	end
end

function vrp_slotC.notify(msg, type, timer)
	TriggerEvent(
		"pNotify:SendNotification",
		{
			text = msg,
			type = type or "success",
			timeout = timer or 3000,
			layout = "centerleft",
			queue = "global"
		}
	)
end

local function drawHint(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNUICallback(
	"updateBets",
	function(data)
		TriggerServerEvent("esx_slots:updateCoins", data.bets)
	end
)

function KeyboardInput(textEntry, inputText, maxLength)
	AddTextEntry("FMMC_KEY_TIP1", textEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

function vrp_slotC.UpdateSlots(lei)
	SetNuiFocus(true, true)
	open = true
	SendNUIMessage(
		{
			showPacanele = "open",
			coinAmount = tonumber(lei)
		}
	)
end

RegisterNUICallback(
	"exitWith",
	function(data, cb)
		cb("ok")
		SetNuiFocus(false, false)
		open = false
		vrp_slotS.PayOutRewards({math.floor(data.coinAmount)})
		forceExitShit = true
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if open then
				DisableControlAction(0, 1, true) -- LookLeftRight
				DisableControlAction(0, 2, true) -- LookUpDown
				DisableControlAction(0, 24, true) -- Attack
				DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
				DisableControlAction(0, 142, true) -- MeleeAttackAlternate
				DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			for _, v in pairs(Config.Sloty) do
				local dis = GetDistanceBetweenCoords(coords, v[1], v[2], v[3], true)
				if dis <= 1.5 then
					DrawMarker(1, v[1], v[2], v[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 70, 163, 76, 50, false, true, 2, nil, nil, false)
				elseif dis <= 10.0 then
					DrawMarker(1, v[1], v[2], v[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 158, 52, 235, 50, false, true, 2, nil, nil, false)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			if not sittingAtBlackjackTable then
				if closestChair ~= -1 and closestChairDist < 2 then
					showHowToBlackjack(true)
					if IsControlJustReleased(1, 38) then
						vrp_slotS.BetsAndMoney()
						goToBlackjackSeat(closestChair)
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if closestChair ~= -1 then
				if closestChairDist > 2 then
					showHowToBlackjack(false)
					ClearHelp(true)
					playedCasinoGuiSound = false
				end
			end
			Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		SetNuiFocus(false, false)
		while true do
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local closestChairDistBase = #(vec(playerCoords.x, playerCoords.y, playerCoords.z) - vec(table.unpack(vectorChairPos)))
			if closestChairDistBase < 200 then
				closeToCasino = true
			else
				closeToCasino = false
			end
			Wait(1000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if closeToCasino then
				closestChairDist = 1000
				closestChair = -1
				for i, v in pairs(Config.Sloty) do
					local playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local distToBlackjackSeat = #(vec(playerCoords.x, playerCoords.y, playerCoords.z) - vec(v[1], v[2], v[3]))
					if distToBlackjackSeat < closestChairDist then
						closestChairDist = distToBlackjackSeat
						closestChair = i
					end
				end
			end
			Wait(100)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if sittingAtBlackjackTable and canExitBlackjack then
				--SetPedCapsule(PlayerPedId(), 0.2)
				if (IsControlJustPressed(0, 202) or forceExitShit) and not waitingForSitDownState then
					forceExitShit = false
					shouldForceIdleCardGames = false
					Wait(0)
					blackjackAnimDictToLoad = "anim_casino_b@amb@casino@games@shared@player@"
					RequestAnimDict(blackjackAnimDictToLoad)
					while not HasAnimDictLoaded(blackjackAnimDictToLoad) do
						RequestAnimDict(blackjackAnimDictToLoad)
						Wait(0)
					end
					--FreezeEntityPosition(GetPlayerPed(-1),false)
					--SetEntityCollision(GetPlayerPed(-1),true,true)
					NetworkStopSynchronisedScene(Local_198f_255)
					TaskPlayAnim(GetPlayerPed(-1), blackjackAnimDictToLoad, "sit_exit_left", 1.0, 1.0, 2500, 0)
					--SetPlayerControl(PlayerId(),1,256,0)
					sittingAtBlackjackTable = false
					timeoutHowToBlackjack = true
					blackjackInstructional = nil
					bettingInstructional = nil
					waitingForBetState = false
					drawCurrentHand = false
					drawTimerBar = false
					SetTimeout(
						2500,
						function()
							ClearPedTasksImmediately(GetPlayerPed(-1))
						end
					)
					SetTimeout(
						5000,
						function()
							timeoutHowToBlackjack = false
						end
					)
				end
			end
			Wait(0)
		end
	end
)

local coordonate = {
	{1088.1, 221.11, -49.21, nil, 185.5, nil, 1535236204},
	{1100.61, 195.55, -49.45, nil, 316.5, nil, -1371020112},
	{1134.33, 267.23, -51.04, nil, 135.5, nil, -245247470},
	{1128.82, 261.75, -51.04, nil, 321.5, nil, 691061163},
	{1143.83, 246.72, -51.04, nil, 320.5, nil, -886023758},
	{1149.33, 252.24, -51.04, nil, 138.5, nil, -1922568579},
	{1149.48, 269.11, -51.85, nil, 49.5, nil, -886023758},
	{1151.25, 267.3, -51.85, nil, 227.5, nil, 469792763},
	{1143.89, 263.71, -51.85, nil, 45.5, nil, 999748158},
	{1145.77, 261.883, -51.85, nil, 222.5, nil, -254493138}
}

Citizen.CreateThread(
	function()
		for _, v in pairs(coordonate) do
			RequestModel(v[7])
			while not HasModelLoaded(v[7]) do
				Wait(1)
			end

			RequestAnimDict("mini@strip_club@idles@bouncer@base")
			while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
				Wait(1)
			end
			ped = CreatePed(RWP, 4, v[7], v[1], v[2], v[3] - 1, 3374176, false, true)
			SetEntityHeading(ped, v[5])
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskPlayAnim(ped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end
	end
)

local heading = 254.5
local vehicle = nil

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1099.84, 219.86, -49.38, true) < 40 then
				if DoesEntityExist(vehicle) == false then
					RequestModel(GetHashKey("nero2"))
					while not HasModelLoaded(GetHashKey("nero2")) do
						Wait(1)
					end
					vehicle = CreateVehicle(RWV, GetHashKey("nero2"), 1099.84, 219.86, -49.38, heading, false, false)
					FreezeEntityPosition(vehicle, true)
					SetEntityInvincible(vehicle, true)
					SetEntityCoords(vehicle, 1099.84, 219.86, -49.38, false, false, false, true)
					local props = ESX.Game.GetVehicleProperties(vehicle)
					props["wheelColor"] = 147
					props["plate"] = "DIAMONDS"
					ESX.Game.SetVehicleProperties(vehicle, props)
				else
					SetEntityHeading(vehicle, heading)
					heading = heading + 0.1
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10000)
			if vehicle ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed - 1), 1099.84, 219.86, -49.38, true) < 40 then
				SetEntityCoords(vehicle, 1099.84, 219.86, -49.38, false, false, false, true)
			end
		end
	end
)
