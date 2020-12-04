local robbing = false
local atm = ""
local secondsRemaining = 0

local text_take = "" .. cfg.KeyMarkerName .. "키를 눌러 수령합니다."

local dropList = {}

function scenrionahoi(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)
end

function atm_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.75, 0.75)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
end

local atms = cfg.atms

RegisterNetEvent("es_atm:currentlyrobbing") -- substitua o evento existente
AddEventHandler(
	"es_atm:currentlyrobbing",
	function(robb)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		while (not HasAnimDictLoaded("mp_car_bomb")) do
			RequestAnimDict("mp_car_bomb")
			Citizen.Wait(5)
		end
		propbomb = CreateObject(RWO, GetHashKey("prop_bomb_01_s"), x, y, z + 0.2, true, true, true)
		AttachEntityToEntity(propbomb, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 80.0, 160.0, 0, true, true, false, true, 1, true)
		TaskPlayAnim(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		Citizen.Wait(2000)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		FreezeEntityPosition(propbomb, true)
		DetachEntity(propbomb, 1, 1)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		robbing = true
		atm = robb
		secondsRemaining = atms[robb].seconds
		Citizen.Wait(10000)
		DeleteObject(propbomb)
		local pos = atms[atm].position
		TriggerServerEvent("robbaryInProgressPos", pos.x, pos.y, pos.z)
	end
)

RegisterNetEvent("es_atm:toofarlocal")
AddEventHandler(
	"es_atm:toofarlocal",
	function(robb)
		robbing = false
		TriggerEvent("chatMessage", "", {255, 0, 0}, "ATM 기기 근처에있던 범인이 도망갔습니다.", {255, 69, 0, 0.5}, "", "")
		robbingName = ""
		secondsRemaining = 0
		incircle = false
	end
)

RegisterNetEvent("es_atm:playerdiedlocal")
AddEventHandler(
	"es_atm:playerdiedlocal",
	function(robb)
		robbing = false
		TriggerEvent("chatMessage", "", {255, 0, 0}, "ATM 기기를 열기전에 사망하여 강도가 취소되었습니다.", {255, 255, 255, 0.5, "", 100, 0, 0, 0.5}, "", "")
		robbingName = ""
		secondsRemaining = 0
		incircle = false
	end
)

RegisterNetEvent("es_atm:robberycomplete")
AddEventHandler(
	"es_atm:robberycomplete",
	function(reward)
		robbing = false
		local pos = atms[atm].position
		TriggerEvent("chatMessage", "", {255, 0, 0}, "가방에  " .. reward .. " 원이 지급 되었습니다.", {0, 255, 0, 0.5}, "", "")
		AddExplosion(RWE, pos.x, pos.y, pos.z, 1, 1.0, 1, 0, 2.0)
		--SetPedComponentVariation(PlayerPedId(), 5, 41, 0, 2)
		atm = ""
		secondsRemaining = 0
		incircle = false
	end
)

Citizen.CreateThread(
	function()
		while true do
			if robbing then
				Citizen.Wait(1000)
				if (secondsRemaining > 0) then
					secondsRemaining = secondsRemaining - 1
				end
			end

			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			for k, v in pairs(atms) do
				local pos2 = v.position

				if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0) then
					if IsPlayerWantedLevelGreater(PlayerId(), 0) or ArePlayerFlashingStarsAboutToDrop(PlayerId()) then
						local wanted = GetPlayerWantedLevel(PlayerId())
						Citizen.Wait(5000)
						SetPlayerWantedLevel(PlayerId(), wanted, 0)
						SetPlayerWantedLevelNow(PlayerId(), 0)
					end
				end
			end
			Citizen.Wait(0)
		end
	end
)

if cfg.blips then -- blip settings
	Citizen.CreateThread(
		function()
			for k, v in pairs(atms) do
				local ve = v.position

				--local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
				SetBlipSprite(blip, 278)
				SetBlipScale(blip, 0.8)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("ATMS para Assalto")
				EndTextCommandSetBlipName(blip)
			end
		end
	)
end
incircle = false

Citizen.CreateThread(
	function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)

			for k, v in pairs(atms) do
				local pos2 = v.position

				if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 10.0) then
					if not robbing then
						--DrawMarker(23, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

						if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2) then
							if (incircle == false) then
								atm_DisplayHelpText("~y~ E키~w~를 눌러 기기를 폭파시켜 돈을 훔치세요!")
							end
							incircle = true
							if (IsControlJustReleased(1, 51)) then
								TriggerServerEvent("es_atm:rob", k)
							end
						elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2) then
							incircle = false
						end
					end
				end
			end

			if robbing then
				--SetPlayerWantedLevel(PlayerId(), 4, 0)
				--SetPlayerWantedLevelNow(PlayerId(), 0)
				local posATM = atms[atm].position
				DrawText3D(posATM.x, posATM.y, posATM.z + 1.0, "BOOM TIME : ~r~" .. secondsRemaining .. "")
				DrawMarker(1, posATM.x, posATM.y, posATM.z - 1, 0, 0, 0, 0, 0, 0, 29.0, 29.0, 1.5001, 1555, 0, 0, 255, 0, 0, 0, 0)
				PlaySoundFromCoord(-1, "scanner_alarm_os", posATM.x, posATM.y, posATM.z, "dlc_xm_iaa_player_facility_sounds", 1, 100, 0)
				local pos2 = atms[atm].position
				local ped = GetPlayerPed(-1)

				if IsEntityDead(ped) then
					TriggerServerEvent("es_atm:playerdied", atm)
				elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15) then
					TriggerServerEvent("es_atm:toofar", atm)
				end
			end

			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local ped = GetPlayerPed(-1)
			local pedCoord = GetEntityCoords(ped)
			for k, v in pairs(dropList) do
				--DrawMarker(22,  x, y, z-0.5, 0, 0, 0, 180.0--[[Rotação]], 0, 0, 0.3--[[x]], 0.3--[[y]], 0.3--[[Z]], 255--[[R]], 255--[[G]], 255--[[B]],255--[[A]], 0--[[ANIMAÇÃO]], 0, 0,1--[[ROTAÇÃO]])
				if DoesObjectOfTypeExistAtCoords(pedCoord["x"], pedCoord["y"], pedCoord["z"], 1.3, GetHashKey("prop_money_bag_01"), true) then
					Bag = GetClosestObjectOfType(pedCoord["x"], pedCoord["y"], pedCoord["z"], 1.3, GetHashKey("prop_money_bag_01"), false, false, false)
					if NetworkGetEntityIsNetworked(Bag) then
						if ObjToNet(Bag) == k then
							scenrionahoi(text_take)
							if IsControlJustPressed(table.unpack(cfg.KeyMarker)) then
								TriggerServerEvent("DropBagSystem:take", k)
								--SetPedComponentVariation(GetPlayerPed(-1), 5, 45,0,2)
								DeleteBag(Bag)
							end
						end
					end
				end
			end
		end
	end
)

function DeleteBag(Bag)
	SetEntityAsMissionEntity(Bag, true, true)
	DeleteObject(Bag)
end

function SetBagOnGround()
	local posATM = atms[atm].position
	Bag = GetHashKey("prop_money_bag_01")
	RequestModel(Bag)
	while not HasModelLoaded(Bag) do
		Citizen.Wait(0)
	end
	local object = CreateObject(RWO, Bag, posATM.x, posATM.y, posATM.z, true, true, true) -- x+1
	PlaceObjectOnGroundProperly(object)
	FreezeEntityPosition(object, true)
	local network = nil
	if NetworkGetEntityIsNetworked(object) then
		network = ObjToNet(object)
	end
	return network
end

RegisterNetEvent("DropBagSystem:drop")
AddEventHandler(
	"DropBagSystem:drop",
	function(item, amount)
		local bag = SetBagOnGround()
		if bag then
			TriggerServerEvent("DropBagSystem:create", bag, item, amount)
		end
	end
)

RegisterNetEvent("DropBagSystem:createForAll")
AddEventHandler(
	"DropBagSystem:createForAll",
	function(bag)
		dropList[bag] = true
	end
)
