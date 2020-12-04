vrp_rouletteC = {}
Tunnel.bindInterface("vrp_roulette", vrp_rouletteC)
Proxy.addInterface("vrp_roulette", vrp_rouletteC)
vRP = Proxy.getInterface("vRP")
vrp_rouletteS = Tunnel.getInterface("vrp_roulette", "vrp_roulette")

local blipX = -1400.94
local blipY = -605.00
local blipZ = 29.50
local pic = "CHAR_SOCIAL_CLUB"
local game_during = false
local elements = {}

forceExitShit = false
waitingForBetState = false
waitingForSitDownState = false
waitingForStandOrHitState = false

vectorChairPos = {944.62817382813, 55.98815536499, 75.991271972656}

casinoBlackjackDealerPositions = {
	{947.92932128906, 57.477630615234, 75.991287231445, 155.51},
	{943.21966552734, 58.985263824463, 75.991287231445, 248.51},
	{941.76458740234, 54.759304046631, 75.991180419922, 332.51},
	{946.38342285156, 52.836837768555, 75.991218566895, 50.51}
}

dealerPeds = {}
blackjackTableData = {}

closestChair = -1
closestChairDist = 1000
sittingAtBlackjackTable = false

function showHowToBlackjack(flag)
	if closestChair <= 15 then
		RageUI.Visible(RMenu:Get("cmgblackjack", "instructions"), flag)
	else
		RageUI.Visible(RMenu:Get("cmgblackjack_high", "instructions"), flag)
	end
end

RegisterNUICallback(
	"exit",
	function(data, cb)
		cb("ok")
		SetNuiFocus(false, false)
		forceExitShit = true
	end
)

RegisterNUICallback(
	"betup",
	function(data, cb)
		cb("ok")
		TriggerServerEvent("InteractSound_SV:PlayOnSource", "betup", 1.0)
	end
)

RegisterNUICallback(
	"roll",
	function(data, cb)
		cb("ok")
		vrp_rouletteC.start_game(data.kolor, data.kwota)
	end
)

function vrp_rouletteC.notify(msg, type, timer)
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

function vrp_rouletteC.start()
	vrp_rouletteS.check_money(
		{},
		function(quantity)
			if quantity >= 10 then
				SendNUIMessage(
					{
						type = "show_table",
						zetony = quantity
					}
				)
				SetNuiFocus(true, true)
			else
				vrp_rouletteC.notify("칩이 최소 10개 있어야 게임을 시작할 수 있습니다.", "error")
				SendNUIMessage(
					{
						type = "reset_bet"
					}
				)
			end
		end
	)
end

function vrp_rouletteC.start_game(action, amount)
	local amount = amount
	vrp_rouletteS.checkBetRange(
		{amount},
		function(valid)
			if not valid then
				vrp_rouletteC.notify("최대 1000개까지 베팅가능합니다.", "error")
			else
				if game_during == false then
					vrp_rouletteS.removemoney({amount})
					local kolorBetu = action
					vrp_rouletteC.notify("당신은 " .. kolorBetu .. "에 칩 " .. amount .. "개를 베팅 했습니다. 휠을 돌립니다!", "warning")
					game_during = true
					local randomNumber = math.floor(math.random() * 36)
					--local randomNumber = 0
					SendNUIMessage(
						{
							type = "show_roulette",
							hwButton = randomNumber
						}
					)
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "ruletka", 1.0)
					Citizen.Wait(10000)
					local red = {32, 19, 21, 25, 34, 27, 36, 30, 23, 5, 16, 1, 14, 9, 18, 7, 12, 3}
					local black = {15, 4, 2, 17, 6, 13, 11, 8, 10, 24, 33, 20, 31, 22, 29, 28, 35, 26}
					local function has_value(tab, val)
						for index, value in ipairs(tab) do
							if value == val then
								return true
							end
						end
						return false
					end
					if action == "black" then
						if has_value(black, randomNumber) then
							local win = amount * 2
							vrp_rouletteC.notify("당신은 승리했습니다! 칩 " .. win .. "개 획득")
							vrp_rouletteS.givemoney({action, amount})
						else
							vrp_rouletteC.notify("아깝네요! 당신은 패배했습니다.", "error")
						end
					elseif action == "red" then
						local win = amount * 2
						if has_value(red, randomNumber) then
							vrp_rouletteC.notify("당신은 승리했습니다! 칩 " .. win .. "개 획득")
							vrp_rouletteS.givemoney({action, amount})
						else
							vrp_rouletteC.notify("아깝네요! 당신은 패배했습니다.", "error")
						end
					elseif action == "green" then
						local win = amount * 32
						if randomNumber == 0 then
							vrp_rouletteC.notify("당신은 승리했습니다! 칩 " .. win .. "개 획득")
							vrp_rouletteS.givemoney({action, amount})
						else
							vrp_rouletteC.notify("아깝네요! 당신은 패배했습니다.", "error")
						end
					end
					SendNUIMessage({type = "hide_roulette"})
					SetNuiFocus(false, false)
					game_during = false
					vrp_rouletteC.start()
				else
					vrp_rouletteC.notify("게임이 이미 진행중 입니다. 잠시후 다시 시도해주세요.", "error")
				end
			end
		end
	)
end

function vrp_rouletteC.sendTableData(data)
	blackjackTableData = data
end

Citizen.CreateThread(
	function()
		while true do
			if closestChair ~= -1 and closestChairDist < 2 then
				if IsControlJustPressed(0, 38) then
					if not blackjackTableData[closestChair] then
						vrp_rouletteS.requestSit(
							{closestChair},
							function(v)
								if v then
									vrp_rouletteC.start()
									goToBlackjackSeat(closestChair)
								else
									vrp_rouletteC.notify({"의자에 앉을 수 없습니다.", "error"})
								end
							end
						)
					else
						vrp_rouletteC.notify({"의자에 앉을 수 없습니다.", "error"})
					end
				end
			end
			Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if sittingAtBlackjackTable and canExitBlackjack then
				SetPedCapsule(PlayerPedId(), 0.2)
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
					vrp_rouletteS.leaveTable()
					closestDealerPed, closestDealerPedDistance = getClosestDealer()
					PlayAmbientSpeech1(closestDealerPed, "MINIGAME_DEALER_LEAVE_NEUTRAL_GAME", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR", 1)
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

Citizen.CreateThread(
	function()
		SetNuiFocus(false, false)
		while true do
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local closestChairDist = #(vec(playerCoords.x, playerCoords.y, playerCoords.z) - vec(table.unpack(vectorChairPos)))
			if closestChairDist < 200 then
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
				for i = 0, 15, 1 do
					local vectorOfBlackjackSeat = blackjack_func_348(i)
					local playerCoords = GetEntityCoords(GetPlayerPed(-1))
					local distToBlackjackSeat = #(vec(playerCoords.x, playerCoords.y, playerCoords.z) - vec(vectorOfBlackjackSeat.x, vectorOfBlackjackSeat.y, vectorOfBlackjackSeat.z))
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
			if not sittingAtBlackjackTable then
				if closestChair ~= nil and closestChairDist < 2 then
					if not timeoutHowToBlackjack then
						if not blackjackTableData[closestChair] then
						else
							drawNativeNotification("다른 자리에 착석해주세요.")
						end
						showHowToBlackjack(true)
						if not playedCasinoGuiSound then
							playedCasinoGuiSound = true
							PlaySoundFrontend(-1, "DLC_VW_RULES", "dlc_vw_table_games_frontend_sounds", 1)
							PlaySoundFrontend(-1, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", 1)
						end
					end
				end
			end
			Wait(1)
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
		maleCasinoDealer = GetHashKey("S_M_Y_Casino_01")
		femaleCasinoDealer = GetHashKey("S_F_Y_Casino_01")
		math.randomseed(GetGameTimer())

		dealerAnimDict = "anim_casino_b@amb@casino@games@shared@dealer@"
		RequestAnimDict(dealerAnimDict)
		while not HasAnimDictLoaded(dealerAnimDict) do
			RequestAnimDict(dealerAnimDict)
			print("Requesting dealer anim dict")
			Wait(0)
		end
		for _, v in pairs(casinoBlackjackDealerPositions) do
			math.random()
			math.random()
			math.random()
			randomBlackShit = math.random(1, 13)
			if randomBlackShit < 7 then
				dealerModel = maleCasinoDealer
			else
				dealerModel = femaleCasinoDealer
			end
			RequestModel(dealerModel)
			while not HasModelLoaded(dealerModel) do
				RequestModel(dealerModel)
				Wait(0)
			end
			dealerEntity = CreatePed(RWP, 26, dealerModel, v[1], v[2], v[3], v[4], false, true)
			table.insert(dealerPeds, dealerEntity)
			SetModelAsNoLongerNeeded(dealerModel)
			SetEntityCanBeDamaged(dealerEntity, 0)
			SetPedAsEnemy(dealerEntity, 0)
			SetBlockingOfNonTemporaryEvents(dealerEntity, 1)
			SetPedResetFlag(dealerEntity, 249, 1)
			SetPedConfigFlag(dealerEntity, 185, true)
			SetPedConfigFlag(dealerEntity, 108, true)
			SetPedCanEvasiveDive(dealerEntity, 0)
			SetPedCanRagdollFromPlayerImpact(dealerEntity, 0)
			SetPedConfigFlag(dealerEntity, 208, true)
			setBlackjackDealerPedVoiceGroup(randomBlackShit, dealerEntity)
			setBlackjackDealerClothes(randomBlackShit, dealerEntity)
			SetEntityCoordsNoOffset(dealerEntity, v[1], v[2], v[3], 0, 0, 1)
			SetEntityHeading(dealerEntity, v[4])
			if dealerModel == maleCasinoDealer then
				TaskPlayAnim(dealerEntity, dealerAnimDict, "idle", 1000.0, -2.0, -1, 2, 1148846080, 0) --anim_name is idle or female_idle depending on gender
			else
				TaskPlayAnim(dealerEntity, dealerAnimDict, "female_idle", 1000.0, -2.0, -1, 2, 1148846080, 0) --anim_name is idle or female_idle depending on gender
			end
			PlayFacialAnim(dealerEntity, "idle_facial", dealerAnimDict)
			RemoveAnimDict(dealerAnimDict)
		end
	end
)
