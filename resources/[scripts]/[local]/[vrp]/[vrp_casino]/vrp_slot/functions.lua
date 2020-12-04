function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawNativeNotification(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function getClosestDealer()
	local tmpclosestDealerPed = nil
	local tmpclosestDealerPedDistance = 100000
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	for k, v in pairs(dealerPeds) do
		local dealerPed = v
		--print("Entity ID of this dealer ped: " .. tostring(dealerPed))
		local distanceToDealer = #(playerCoords - GetEntityCoords(dealerPed))
		--print("Distance to dealer ped: " .. tostring(distanceToDealer))
		if distanceToDealer < tmpclosestDealerPedDistance then
			tmpclosestDealerPedDistance = distanceToDealer
			tmpclosestDealerPed = dealerPed
		end
	end
	--print("Closest dealer ped is: " .. tostring(tmpclosestDealerPed))
	closestDealerPed = tmpclosestDealerPed
	closestDealerPedDistance = tmpclosestDealerPedDistance
	return closestDealerPed, closestDealerPedDistance
end

function goToBlackjackSeat(blackjackSeatID)
	sittingAtBlackjackTable = true
	waitingForSitDownState = true
	canExitBlackjack = true
	currentHand = 0
	dealersHand = 0
	showHowToBlackjack(false)
	blackjackAnimsToLoad = {
		"anim_casino_b@amb@casino@games@blackjack@dealer",
		"anim_casino_b@amb@casino@games@shared@dealer@",
		"anim_casino_b@amb@casino@games@blackjack@player",
		"anim_casino_b@amb@casino@games@shared@player@"
	}
	for k, v in pairs(blackjackAnimsToLoad) do
		RequestAnimDict(v)
		while not HasAnimDictLoaded(v) do
			RequestAnimDict(v)
			--print("Stuck loading anim dict: " .. tostring(v))
			Wait(0)
		end
	end
	--print("[CMG Casino] blackjack anims loaded")
	Local_198f_247 = blackjackSeatID
	--print("blackjackSeatID: " .. blackjackSeatID)
	fVar3 = blackjack_func_217(PlayerPedId(), blackjack_func_218(Local_198f_247, 0), 1)
	fVar4 = blackjack_func_217(PlayerPedId(), blackjack_func_218(Local_198f_247, 1), 1)
	fVar5 = blackjack_func_217(PlayerPedId(), blackjack_func_218(Local_198f_247, 2), 1)
	--print("[CMG Casino] fVars passed")
	if (fVar4 < fVar5 and fVar4 < fVar3) then
		Local_198f_251 = 1
	elseif (fVar5 < fVar4 and fVar5 < fVar3) then
		Local_198f_251 = 2
	else
		Local_198f_251 = 0
	end
	--blackjack_func_218 is get_anim_offset
	--param0 is 0-3 && param1 is 0-15? (OF blackjack_func_218)
	local walkToVector = blackjack_func_218(Local_198f_247, Local_198f_251)
	local targetHeading = blackjack_func_216(Local_198f_247, Local_198f_251)
	--print("[CMG Casino] walking to seat, x: " .. tostring(walkToVector.x) .. " y: " .. tostring(walkToVector.y) .. " z: " .. tostring(walkToVector.z))
	TaskGoStraightToCoord(PlayerPedId(), walkToVector.x, walkToVector.y, walkToVector.z, 1.0, 5000, targetHeading, 0.01)

	local goToVector = blackjack_func_348(Local_198f_247)
	local xRot, yRot, zRot = blackjack_func_215(Local_198f_247)
	print("tet", blackjackSeatID, goToVector)
	--print("[CMG Casino] Blackjack sit at table net scene starting")
	--print("[CMG Casino] creating Scene at, x: " .. tostring(goToVector.x) .. " y: " .. tostring(goToVector.y) .. " z: " .. tostring(goToVector.z))
	Local_198f_255 = NetworkCreateSynchronisedScene(goToVector.x, goToVector.y, goToVector.z, xRot, yRot, zRot, 2, 1, 0, 1065353216, 0, 1065353216)
	NetworkAddPedToSynchronisedScene(PlayerPedId(), Local_198f_255, "anim_casino_b@amb@casino@games@shared@player@", blackjack_func_213(Local_198f_251), 2.0, -2.0, 13, 16, 2.0, 0) -- 8.0, -1.5, 157, 16, 1148846080, 0) ?
	NetworkStartSynchronisedScene(Local_198f_255)
	--print("[CMG Casino] Blackjack sit at table net scene started")
	--Local_198.f_255 = NETWORK::NETWORK_CREATE_SYNCHRONISED_SCENE(func_348(Local_198.f_247), func_215(Local_198.f_247), 2, 1, 0, 1065353216, 0, 1065353216)
	--NETWORK::NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE(PLAYER::PLAYER_PED_ID(), Local_198.f_255, "anim_casino_b@amb@casino@games@shared@player@", blackjack_func_213(Local_198f_251), 2f, -2f, 13, 16, 2f, 0)
	--NETWORK::NETWORK_START_SYNCHRONISED_SCENE(Local_198.f_255)

	--NEXT --> Line 5552
	Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
	Wait(6000)
	--print("STOP STITTING ")
	--Wait for sit down anim to end
	Locali98f_55 = NetworkCreateSynchronisedScene(goToVector.x, goToVector.y, goToVector.z, xRot, yRot, zRot, 2, 1, 1, 1065353216, 0, 1065353216)
	NetworkAddPedToSynchronisedScene(PlayerPedId(), Locali98f_55, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 2.0, -2.0, 13, 16, 1148846080, 0)
	NetworkStartSynchronisedScene(Locali98f_55)
	StartAudioScene("DLC_VW_Casino_Table_Games") --need to stream this
	Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
	waitingForSitDownState = false
	shouldForceIdleCardGames = true
end
function setBlackjackDealerPedVoiceGroup(randomNumber, dealerPed)
	if randomNumber == 0 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
	elseif randomNumber == 1 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_ASIAN_01"))
	elseif randomNumber == 2 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_ASIAN_02"))
	elseif randomNumber == 3 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_ASIAN_01"))
	elseif randomNumber == 4 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
	elseif randomNumber == 5 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_WHITE_02"))
	elseif randomNumber == 6 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
	elseif randomNumber == 7 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_ASIAN_01"))
	elseif randomNumber == 8 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_ASIAN_02"))
	elseif randomNumber == 9 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_ASIAN_01"))
	elseif randomNumber == 10 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_ASIAN_02"))
	elseif randomNumber == 11 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_LATINA_01"))
	elseif randomNumber == 12 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_LATINA_02"))
	elseif randomNumber == 13 then
		SetPedVoiceGroup(dealerPed, GetHashKey("S_F_Y_Casino_01_LATINA_01"))
	end
end

function setBlackjackDealerClothes(randomNumber, dealerPed)
	if randomNumber == 0 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 1 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 2, 2, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 2 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 2, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 3 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 1, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 4 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 4, 2, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 5 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 4, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 6 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 4, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 1, 0, 0)
	elseif randomNumber == 7 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 1, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
	elseif randomNumber == 8 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 1, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 1, 1, 0)
		SetPedComponentVariation(dealerPed, 3, 1, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
	elseif randomNumber == 9 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 2, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
	elseif randomNumber == 10 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 2, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 2, 1, 0)
		SetPedComponentVariation(dealerPed, 3, 3, 3, 0)
		SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
	elseif randomNumber == 11 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 3, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 0, 1, 0)
		SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
		SetPedPropIndex(dealerPed, 1, 0, 0, false)
	elseif randomNumber == 12 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 3, 1, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 3, 1, 0)
		SetPedComponentVariation(dealerPed, 3, 1, 1, 0)
		SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
	elseif randomNumber == 13 then
		SetPedDefaultComponentVariation(dealerPed)
		SetPedComponentVariation(dealerPed, 0, 4, 0, 0)
		SetPedComponentVariation(dealerPed, 1, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 2, 4, 0, 0)
		SetPedComponentVariation(dealerPed, 3, 2, 1, 0)
		SetPedComponentVariation(dealerPed, 4, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 6, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 7, 1, 0, 0)
		SetPedComponentVariation(dealerPed, 8, 2, 0, 0)
		SetPedComponentVariation(dealerPed, 10, 0, 0, 0)
		SetPedComponentVariation(dealerPed, 11, 0, 0, 0)
		SetPedPropIndex(dealerPed, 1, 0, 0, false)
	end
end

function blackjack_func_218(iParam0, iParam1) --//param0 is 0-3 && param1 is 0-15?
	local goToVector = blackjack_func_348(iParam0)
	local xRot, yRot, zRot = blackjack_func_215(iParam0)
	vVar0 = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@", blackjack_func_213(iParam1), goToVector.x, goToVector.y, goToVector.z, xRot, yRot, zRot, 0.01, 2)
	return vVar0
end

function blackjack_func_216(iParam0, iParam1)
	local goToVector = blackjack_func_348(iParam0)
	local xRot, yRot, zRot = blackjack_func_215(iParam0)
	vVar0 = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@", blackjack_func_213(iParam1), goToVector.x, goToVector.y, goToVector.z, xRot, yRot, zRot, 0.01, 2)
	return vVar0.z
end

function blackjack_func_213(sitAnimID)
	if sitAnimID == 0 then
		return "sit_enter_left"
	elseif sitAnimID == 1 then
		return "sit_enter_left_side"
	elseif sitAnimID == 2 then
		return "sit_enter_right_side"
	end
	return "sit_enter_left"
end

function blackjack_func_348(iParam0) --GetVectorFromChairId
	local blackjackTableObj = nil
	local x, y, z, r, obj = blackjack_func_70(blackjack_func_368(iParam0))
	blackjackTableObj = GetClosestObjectOfType(x, y, z, 3.0, obj, 0, 0, 0)
	if DoesEntityExist(blackjackTableObj) and DoesEntityHaveDrawable(blackjackTableObj) then
		return GetWorldPositionOfEntityBone_2(blackjackTableObj, GetEntityBoneIndexByName(blackjackTableObj, "Chair_Base_01"))
	end
	return vector3(0.0, 0.0, 0.0)
end
function blackjack_func_215(iParam0)
	local blackjackTableObj = nil
	local x, y, z, r, obj = blackjack_func_70(blackjack_func_368(iParam0))
	blackjackTableObj = GetClosestObjectOfType(x, y, z, 3.0, obj, 0, 0, 0)
	if DoesEntityExist(blackjackTableObj) and DoesEntityHaveDrawable(blackjackTableObj) then
		return GetWorldRotationOfEntityBone(blackjackTableObj, GetEntityBoneIndexByName(blackjackTableObj, "Chair_Base_01"))
	end
	return vector3(0.0, 0.0, 0.0)
end

function blackjack_func_217(iParam0, vParam1, bParam2)
	local vVar0 = {}

	if not IsEntityDead(iParam0, 0) then
		vVar0 = GetEntityCoords(iParam0, 1)
	else
		vVar0 = GetEntityCoords(iParam0, 0)
	end
	return GetDistanceBetweenCoords(vVar0.x, vVar0.y, vVar0.z, vParam1.x, vParam1.y, vParam1.z, bParam2)
end

function blackjack_func_218(iParam0, iParam1) --//param0 is 0-3 && param1 is 0-15?
	local goToVector = blackjack_func_348(iParam0)
	local xRot, yRot, zRot = blackjack_func_215(iParam0)
	vVar0 = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@", blackjack_func_213(iParam1), goToVector.x, goToVector.y, goToVector.z, xRot, yRot, zRot, 0.01, 2)
	return vVar0
end

function blackjack_func_368(state) --returns tableID based on chairID
	return state
end

function blackjack_func_70(id)
	--Local_198f_257 == 1 only when penthouse?
	local Local_198f_257 = 0
	--print("[blackjack_func_70] id is " .. tostring(id))
	if Local_198f_257 == 1 then
		return 947.92932128906, 57.477630615234, 75.991287231445
	else
		return table.unpack(Config.Sloty[id])
	end
	return 0.0, 0.0, 0.0
end
