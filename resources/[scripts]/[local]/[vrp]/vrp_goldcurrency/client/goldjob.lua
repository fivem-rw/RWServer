--------------------------------
----- Converting By. 알고리즘 -----
--------------------------------

local timing, isPlayerWhitelisted = math.ceil(1 * 60000), false

local CurrentMission = nil
local StopMission = false
local Goons = {}
local JobVan

local DeliveryBlip
local blip
local DeliveryBlipCreated = false

local talkingWithNPC = false
local JobInProgress = false

local JobVanSpawned = false
local GoonsSpawned = false
local JobPlayer = false

local isVehicleLockPicked = false
local JobVanPlate = ""
local DeliveryInProgress = false
local InsideJobVan = false
local vanIsDelivered = false

local streetName
local _
local playerGender

RegisterNetEvent("esx_goldCurrency:startMission")
AddEventHandler(
	"esx_goldCurrency:startMission",
	function(spot)
		local num = math.random(1, #Config.MissionPosition)
		local numy = 0
		while Config.MissionPosition[num].InUse and numy < 100 do
			numy = numy + 1
			num = math.random(1, #Config.MissionPosition)
		end
		if numy == 100 then
			ShowNotification("~r~나중에 다시 시도하십시오!")
		else
			CurrentMission = num
			TriggerEvent("esx_goldCurrency:startTheEvent", num)
			PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
		end
		talkingWithNPC = false
	end
)

RegisterNetEvent("esx_goldCurrency:outlawNotify")
AddEventHandler(
	"esx_goldCurrency:outlawNotify",
	function(alert)
		isPlayerWhitelisted = nil
		TriggerServerEvent("esx_goldCurrency:isPlayerWhitelisted")
		while isPlayerWhitelisted == nil do
			Wait(0)
		end

		if isPlayerWhitelisted then
			TriggerEvent("chat:addMessage", {args = {"^8[※금괴 차량 탈취※] " .. alert}})
		end
	end
)

RegisterNetEvent("esx_goldCurrency:GoldJobInProgress")
AddEventHandler(
	"esx_goldCurrency:GoldJobInProgress",
	function(targetCoords)
		isPlayerWhitelisted = nil
		TriggerServerEvent("esx_goldCurrency:isPlayerWhitelisted")
		while isPlayerWhitelisted == nil do
			Wait(0)
		end
		if isPlayerWhitelisted and Config.PoliceBlipShow then
			local alpha = Config.PoliceBlipAlpha
			local policeNotifyBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.PoliceBlipRadius)

			SetBlipHighDetail(policeNotifyBlip, true)
			SetBlipColour(policeNotifyBlip, Config.PoliceBlipColor)
			SetBlipAlpha(policeNotifyBlip, alpha)
			SetBlipAsShortRange(policeNotifyBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.PoliceBlipTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(policeNotifyBlip, alpha)

				if alpha == 0 then
					RemoveBlip(policeNotifyBlip)
					return
				end
			end
		end
	end
)

local AnnounceString = false
local AnnounceHeader = false

function Initialize(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(AnnounceHeader)
	PushScaleformMovieFunctionParameterString(AnnounceString)
	PopScaleformMovieFunctionVoid()
	return scaleform
end

RegisterNetEvent("esx_goldCurrency:missionComplete")
AddEventHandler(
	"esx_goldCurrency:missionComplete",
	function(itemAmount1, item1, itemAmount2, item2)
		SetAudioFlag("LoadMPData", true)
		PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", 1)
		ShowNotification("~g~[미션 성공]\n~g~금괴 습격 미션~w~을 성공하였습니다.")
		AnnounceHeader = "~g~ ~g~금괴 습격 미션 성공"
		if itemAmount2 or item2 then
			AnnounceString = "보상: ~y~" .. item1 .. "~b~ " .. itemAmount1 .. "~s~개 ~y~" .. item2 .. "~b~ " .. itemAmount2 .. "~w~개"
		else
			AnnounceString = "보상: ~y~" .. item1 .. "~b~ " .. itemAmount1 .. "~s~개"
		end
		Citizen.Wait(5 * 1000)
		AnnounceString = false
	end
)
RegisterNetEvent("esx_goldCurrency:missionFailDeath")
AddEventHandler(
	"esx_goldCurrency:missionFailDeath",
	function()
		SetAudioFlag("LoadMPData", true)
		PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", 1)
		AnnounceHeader = "~r~ ~r~금괴 습격 실패"
		AnnounceString = "당신은 죽었습니다."
		Citizen.Wait(5 * 1000)
		AnnounceString = false
	end
)

local MissionPED = nil
RegisterNetEvent("esx_goldCurrency:spawnNPC")
AddEventHandler(
	"esx_goldCurrency:spawnNPC",
	function(NPC)
		local LocationNPC = NPC.Pos
		local heading = NPC.Heading
		RequestModel(GetHashKey(NPC.Ped))
		while not HasModelLoaded(GetHashKey(NPC.Ped)) do
			Citizen.Wait(100)
		end
		MissionPED = CreatePed(RWP, 7, GetHashKey(NPC.Ped), LocationNPC.x, LocationNPC.y, LocationNPC.z - 1, heading, 0, true, true)
		FreezeEntityPosition(MissionPED, true)
		SetBlockingOfNonTemporaryEvents(MissionPED, true)
		TaskStartScenarioInPlace(MissionPED, "WORLD_HUMAN_AA_SMOKE", 0, false)
		SetEntityInvincible(MissionPED, true)
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local playerPos = GetEntityCoords(GetPlayerPed(-1))
			for k, v in pairs(Config.MissionNPC) do
				local pos = v.Pos
				local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z)
				if distance <= 1.5 and (JobInProgress == false and talkingWithNPC == false) then
					DrawText3Ds(pos.x, pos.y, pos.z, "~g~[E]~s~키를 눌러 ~y~NPC~s~에게 대화 하십시오!")
					if IsControlJustPressed(0, 38) then
						requestMissionFromNPC()
						Citizen.Wait(500)
					end
				end
			end
		end
	end
)

cooldownTimer = nil
RegisterNetEvent("esx_goldCurrency:getGoldJobCoolDown")
AddEventHandler(
	"esx_goldCurrency:getGoldJobCoolDown",
	function(ret)
		cooldownTimer = ret
	end
)

missionPossible = nil
RegisterNetEvent("esx_goldCurrency:getMissionavailability")
AddEventHandler(
	"esx_goldCurrency:getMissionavailability",
	function(ret)
		missionPossible = ret
	end
)

payment = nil
RegisterNetEvent("esx_goldCurrency:getPayment")
AddEventHandler(
	"esx_goldCurrency:getPayment",
	function(ret)
		payment = ret
	end
)

copnomisssion = nil
RegisterNetEvent("esx_goldCurrency:getcopnomisssion")
AddEventHandler(
	"esx_goldCurrency:getcopnomisssion",
	function(ret)
		copnomisssion = ret
	end
)

function requestMissionFromNPC()
	talkingWithNPC = true
	local player = PlayerPedId()
	local anim_lib = "missheistdockssetup1ig_5@base"
	local anim_dict = "workers_talking_base_dockworker1"

	RequestAnimDict(anim_lib)
	while not HasAnimDictLoaded(anim_lib) do
		Citizen.Wait(0)
	end

	cooldownTimer = nil
	TriggerServerEvent("esx_goldCurrency:getGoldJobCoolDown")
	while cooldownTimer == nil do
		Wait(0)
	end
	if not cooldownTimer then
		FreezeEntityPosition(player, true)
		TaskPlayAnim(player, anim_lib, anim_dict, 3.0, 0.5, -1, 31, 1.0, 0, 0)
		ShowNotification("~r~[미션 시작]\n~g~금괴 습격 미션~w~시작 장소를 물어보는 중 입니다.")
		exports["progressBars"]:startUI(9.5 * 1000, "금괴 습격할 장소 말하는중...")
		Citizen.Wait((9.5 * 1000))

		FreezeEntityPosition(player, false)
		ClearPedTasks(player)
		ClearPedSecondaryTask(player)
		copnomisssion = nil
		TriggerServerEvent("esx_goldCurrency:getcopnomisssion")
		while copnomisssion == nil do
			Wait(10)
		end
		if copnomisssion then
			missionPossible = nil
			TriggerServerEvent("esx_goldCurrency:getMissionavailability")
			while missionPossible == nil do
				Wait(10)
			end
			if missionPossible then
				payment = nil
				TriggerServerEvent("esx_goldCurrency:getPayment")
				while payment == nil do
					Wait(10)
				end
				if payment then
					TriggerServerEvent("esx_goldCurrency:missionAccepted")
				else
					talkingWithNPC = false
				end
			else
				talkingWithNPC = false
			end
		else
			talkingWithNPC = false
		end
	else
		talkingWithNPC = false
	end
	Citizen.Wait(500)
end

local MissionVehicle = nil

RegisterNetEvent("esx_goldCurrency:startTheEvent")
AddEventHandler(
	"esx_goldCurrency:startTheEvent",
	function(num)
		local Goons = {}
		local loc = Config.MissionPosition[num]
		Config.MissionPosition[num].InUse = true
		local playerped = GetPlayerPed(-1)

		TriggerServerEvent("esx_goldCurrency:syncMissionData", Config.MissionPosition)
		local JobCompleted = false
		local blip = CreateMissionBlip(loc.Location)
		JobInProgress = true

		while not JobCompleted and not StopMission do
			Citizen.Wait(0)

			if JobInProgress == true then
				local coords = GetEntityCoords(GetPlayerPed(-1))

				if (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) > 60) and DeliveryInProgress == false then
					ShowNotification("~r~[미션 시작]\n~g~지도~w~에 표시된 위치로 이동 하십시요!")
					DrawMissionText("지도에 표시된 ~y~위치~w~에 가십시오!")
				end

				if (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 150) and not JobVanSpawned then
					ClearAreaOfVehicles(loc.Location.x, loc.Location.y, loc.Location.z, 15.0, false, false, false, false, false)
					local missionCoords = {loc.Location.x, loc.Location.y, loc.Location.z}
					RequestModel(GetHashKey("speedo4"))
					while not HasModelLoaded(GetHashKey("speedo4")) do
						Citizen.Wait(1)
					end
					JobVanSpawned = true
					MissionVehicle = CreateVehicle(RWV, GetHashKey("speedo4"), loc.Location.x, loc.Location.y, loc.Location.z, loc.heading, true, true)
					SetEntityCoordsNoOffset(MissionVehicle, loc.Location.x, loc.Location.y, loc.Location.z)
					SetEntityHeading(MissionVehicle, loc.Heading)
					FreezeEntityPosition(MissionVehicle, true)
					SetVehicleOnGroundProperly(MissionVehicle)
					FreezeEntityPosition(MissionVehicle, false)
					JobVan = MissionVehicle
					SetEntityAsMissionEntity(JobVan, true, true)
					SetVehicleDoorsLockedForAllPlayers(JobVan, true)
					SetVehicleDoorsLocked(JobVan, 2)
				end

				if (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 150) and not GoonsSpawned then
					ClearAreaOfPeds(loc.Location.x, loc.Location.y, loc.Location.z, 50, 1)
					GoonsSpawned = true
					SetPedRelationshipGroupHash(GetPlayerPed(-1), GetHashKey("PLAYER"))
					AddRelationshipGroup("MissionNPCs")
					local i = 0
					for k, v in pairs(loc.GoonSpawns) do
						RequestModel(GetHashKey(v.ped))
						while not HasModelLoaded(GetHashKey(v.ped)) do
							Wait(1)
						end
						Goons[i] = CreatePed(RWP, 4, GetHashKey(v.ped), v.x, v.y, v.z, v.h, false, true)
						NetworkRegisterEntityAsNetworked(Goons[i])
						SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(Goons[i]), true)
						SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(Goons[i]), true)
						SetPedCanSwitchWeapon(Goons[i], true)
						SetPedArmour(Goons[i], 100)
						SetPedAccuracy(Goons[i], 60)
						SetEntityInvincible(Goons[i], false)
						SetEntityVisible(Goons[i], true)
						SetEntityAsMissionEntity(Goons[i])
						RequestAnimDict(v.animDict)
						while not HasAnimDictLoaded(v.animDict) do
							Citizen.Wait(0)
						end
						TaskPlayAnim(Goons[i], v.animDict, v.anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
						GiveWeaponToPed(Goons[i], GetHashKey(v.weapon), 255, false, false)
						SetPedFleeAttributes(Goons[i], 0, false)
						SetPedRelationshipGroupHash(Goons[i], GetHashKey("MissionNPCs"))
						TaskGuardCurrentPosition(Goons[i], 5.0, 5.0, 1)
						i = i + 1
					end
				end

				if DeliveryInProgress == false and (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 60) and (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) > 10) then
					DrawMissionText("~y~차량~w~을 지키는 ~r~NPC~w~를 ~r~처치~w~ 하십시오!")
				end

				if (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 40) and (not JobPlayer and JobVanSpawned) then
					JobPlayer = true
					SetPedRelationshipGroupHash(GetPlayerPed(-1), GetHashKey("PLAYER"))
					AddRelationshipGroup("MissionNPCs")
					local i = 0
					for k, v in pairs(loc.GoonSpawns) do
						ClearPedTasksImmediately(Goons[i])
						i = i + 1
					end
					SetRelationshipBetweenGroups(0, GetHashKey("MissionNPCs"), GetHashKey("MissionNPCs"))
					SetRelationshipBetweenGroups(5, GetHashKey("MissionNPCs"), GetHashKey("PLAYER"))
					SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("MissionNPCs"))
				end

				if isVehicleLockPicked == false and (GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 10) then
					DrawMissionText("문을 따고 ~y~차량~w~을 ~r~훔치십시오!")
				end

				local VanPosition = GetEntityCoords(JobVan)

				if (GetDistanceBetweenCoords(coords, VanPosition.x, VanPosition.y, VanPosition.z, true) <= 2) and isVehicleLockPicked == false then
					DrawText3Ds(VanPosition.x, VanPosition.y, VanPosition.z, "~g~[G]~s~키를 눌러 ~y~문~s~을 따십시오!")
					if IsControlJustPressed(1, 47) then
						LockpickVanDoor()
						Citizen.Wait(500)
					end
				end

				if IsPedInAnyVehicle(GetPlayerPed(-1), true) and isVehicleLockPicked == true then
					if GetDistanceBetweenCoords(coords, loc.Location.x, loc.Location.y, loc.Location.z, true) < 5 then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						if GetEntityModel(vehicle) == GetHashKey("speedo4") then
							RemoveBlip(blip)
							for k, v in pairs(Config.DeliveryPoints) do
								if DeliveryBlipCreated == false then
									PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
									DeliveryBlipCreated = true
									DeliveryBlip = AddBlipForCoord(v.x, v.y, v.z)
									SetBlipColour(DeliveryBlip, 5)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString("배달 지점")
									EndTextCommandSetBlipName(DeliveryBlip)
									JobVanPlate = GetVehicleNumberPlateText(vehicle)
									SetBlipRoute(DeliveryBlip, true)
									SetBlipRouteColour(DeliveryBlip, 5)
								end
							end

							DeliveryInProgress = true
						end
					end
				end

				if DeliveryInProgress == true and isVehicleLockPicked == true then
					ShowNotification("~r~[탈취 성공]\n~g~습격 차량~w~을 타고 목적지로 이동 하십시요!")
					DrawMissionText("~y~차량~w~을 지도의 새로운 ~g~목적지~w~로 배달하십시오!")
				end

				if DeliveryInProgress == true then
					local coords = GetEntityCoords(GetPlayerPed(-1))
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if GetEntityModel(vehicle) == GetHashKey("speedo4") then
						InsideJobVan = true
					else
						InsideJobVan = false
					end
					for k, v in pairs(Config.DeliveryPoints) do
						if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DeliveryDrawDistance) then
							DrawMarker(Config.DeliveryMarkerType, v.x, v.y, v.z - 0.97, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.DeliveryMarkerScale.x, Config.DeliveryMarkerScale.y, Config.DeliveryMarkerScale.z, Config.DeliveryMarkerColor.r, Config.DeliveryMarkerColor.g, Config.DeliveryMarkerColor.b, Config.DeliveryMarkerColor.a, false, true, 2, false, false, false, false)
						end
						if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0) and vanIsDelivered == false then
							DrawText3Ds(v.x, v.y, v.z, "~g~[E]~s~키를 눌러 ~y~배달~s~을 완료 하십시오!")
							if IsControlJustPressed(0, 38) then
								RemoveBlip(DeliveryBlip)
								vanIsDelivered = true
								DeleteVehicle(JobVan)
								Citizen.Wait(500)
							end
						end
					end
				end

				if vanIsDelivered == true then
					TriggerServerEvent("esx_goldCurrency:reward")
					Config.MissionPosition[num].InUse = false
					TriggerServerEvent("esx_goldCurrency:syncMissionData", Config.MissionPosition)

					local i = 0
					for k, v in pairs(loc.GoonSpawns) do
						if DoesEntityExist(Goons[i]) then
							DeleteEntity(Goons[i])
						end
						i = i + 1
					end

					JobCompleted = true
					JobInProgress = false
					JobVanSpawned = false
					GoonsSpawned = false
					JobPlayer = false
					JobVanPlate = ""
					isVehicleLockPicked = false
					DeliveryInProgress = false
					vanIsDelivered = false
					DeliveryBlipCreated = false
					break
				end

				if StopMission == true then
					if Config.EnableCustomNotification == true then
						TriggerEvent("esx_goldCurrency:missionFailDeath")
					else
						ShowNotification("~r~미션 실패:~s~ 당신은 죽었습니다.")
					end

					Config.MissionPosition[num].InUse = false
					TriggerServerEvent("esx_goldCurrency:syncMissionData", Config.MissionPosition)
					DeleteVehicle(JobVan)

					if DeliveryInProgress == true then
						RemoveBlip(DeliveryBlip)
					else
						RemoveBlip(blip)
					end

					local i = 0
					for k, v in pairs(loc.GoonSpawns) do
						if DoesEntityExist(Goons[i]) then
							DeleteEntity(Goons[i])
						end
						i = i + 1
					end

					JobCompleted = true
					JobInProgress = false
					JobVanSpawned = false
					GoonsSpawned = false
					JobPlayer = false
					JobVanPlate = ""
					isVehicleLockPicked = false
					DeliveryInProgress = false
					vanIsDelivered = false
					DeliveryBlipCreated = false
					break
				end
			end
		end
	end
)

RegisterNetEvent("esx_goldCurrency:isPlayerWhitelisted")
AddEventHandler(
	"esx_goldCurrency:isPlayerWhitelisted",
	function(ret)
		isPlayerWhitelisted = ret
	end
)

function LockpickVanDoor()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
	while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
		Citizen.Wait(50)
	end

	if Config.PoliceNotfiyEnabled == true then
		TriggerServerEvent("esx_goldCurrency:GoldJobInProgress", GetEntityCoords(PlayerPedId()), streetName)
	end

	SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
	Citizen.Wait(750)
	FreezeEntityPosition(playerPed, true)
	TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3.0, -8, -1, 63, 0, 0, 0, 0)
	ShowNotification("~r~[진행중]\n~g~습격 차량~w~의 문을 따는 중 입니다")
	exports["progressBars"]:startUI(7500, "차량 문 따는중...")
	Citizen.Wait(7500)

	ClearPedTasks(playerPed)
	FreezeEntityPosition(playerPed, false)
	isVehicleLockPicked = true
	SetVehicleDoorsLockedForAllPlayers(JobVan, false)
	SetVehicleDoorsLocked(JobVan, 1)
	ShowNotification("~g~당신은 성공적으로 차량 문을 땄습니다.")
end

function CreateMissionBlip(location)
	local blip = AddBlipForCoord(location.x, location.y, location.z)
	SetBlipSprite(blip, 1)
	SetBlipColour(blip, 5)
	AddTextEntry("MYBLIP", "금괴 습격 미션")
	BeginTextCommandSetBlipName("MYBLIP")
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	SetBlipScale(blip, 0.9)
	SetBlipAsShortRange(blip, true)
	SetBlipRoute(blip, true)
	SetBlipRouteColour(blip, 5)
	return blip
end

function DrawMissionText(text)
	SetTextScale(0.5, 0.5)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextOutline()
	AddTextComponentString(text)
	DrawText(0.5, 0.955)
end

function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.32, 0.32)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 360
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3000)
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			streetName, _ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			streetName = GetStreetNameFromHashKey(streetName)
		end
	end
)

Citizen.CreateThread(
	function()
		if Config.EnableGoldJobBlip == true then
			for k, v in ipairs(Config.MissionNPC) do
				local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
				SetBlipSprite(blip, Config.BlipSprite)
				SetBlipDisplay(blip, Config.BlipDisplay)
				SetBlipScale(blip, Config.BlipScale)
				SetBlipColour(blip, Config.BlipColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.BlipNameOnMap)
				EndTextCommandSetBlipName(blip)
			end
		end
	end
)

AddEventHandler(
	"esx:onPlayerDeath",
	function(data)
		StopMission = true
		TriggerServerEvent("esx_goldCurrency:syncMissionData", Config.MissionPosition)
		Citizen.Wait(5000)
		StopMission = false
	end
)

AddEventHandler(
	"playerSpawned",
	function(spawn)
		isDead = false
	end
)

RegisterNetEvent("esx_goldCurrency:syncMissionData")
AddEventHandler(
	"esx_goldCurrency:syncMissionData",
	function(data)
		Config.ArmoredTruck = data
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if AnnounceString then
				scaleform = Initialize("mp_big_message_freemode")
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
			end
		end
	end
)

function ShowNotification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

RegisterNetEvent("esx:showNotification")
AddEventHandler(
	"esx:showNotification",
	function(ret)
		ShowNotification(ret)
	end
)
