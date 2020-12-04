----------------- Object Manager
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
ObjectManagerS = Tunnel.getInterface("ObjectManager", "ObjectManager")

ObjectManagerC = {}
Tunnel.bindInterface("ObjectManager", ObjectManagerC)
Proxy.addInterface("ObjectManager", ObjectManagerC)

local KeyMarker = {1, 212}
local KeyMarkerName = "HOME"
local text_take = "차를 보관하려면 [" .. KeyMarkerName .. "] 키를 누르세요."
local trustVehicleNetIds = {}
local showInfoCount = 0
local maskList = {
	GetHashKey("prop_smask_arnold"),
	GetHashKey("prop_smask_buttercup_girls"),
	GetHashKey("prop_smask_cj"),
	GetHashKey("prop_smask_dr_neo"),
	GetHashKey("prop_smask_fallout_vault"),
	GetHashKey("prop_smask_flutterbat"),
	GetHashKey("prop_smask_fluttershy"),
	GetHashKey("prop_smask_homer_simpson"),
	GetHashKey("prop_smask_ironman"),
	GetHashKey("prop_smask_jack_frost_smt"),
	GetHashKey("prop_smask_james"),
	GetHashKey("prop_smask_jinx"),
	GetHashKey("prop_smask_joker"),
	GetHashKey("prop_smask_kamen_rider"),
	GetHashKey("prop_smask_kamen_rider2"),
	GetHashKey("prop_smask_lemon"),
	GetHashKey("prop_smask_marty_mcfly"),
	GetHashKey("prop_smask_mechanist_fallout"),
	GetHashKey("prop_smask_ninja_donatello"),
	GetHashKey("prop_smask_ninja_leonardo"),
	GetHashKey("prop_smask_ninja_michelangelo"),
	GetHashKey("prop_smask_ninja_raphael"),
	GetHashKey("prop_smask_robocop"),
	GetHashKey("prop_smask_runescape"),
	GetHashKey("prop_smask_skull"),
	GetHashKey("prop_smask_smallville"),
	GetHashKey("prop_smask_solid_sparkle"),
	GetHashKey("prop_smask_spiderman"),
	GetHashKey("prop_smask_steve"),
	GetHashKey("prop_smask_tolalan"),
	GetHashKey("prop_smask_tommy_vercetti"),
	GetHashKey("prop_smask_twilight_sparkle"),
	GetHashKey("prop_smask_undertale_sans")
}

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName("[" .. showInfoCount .. "]" .. text)
	DrawNotification(false, false)
	showInfoCount = showInfoCount + 1
end

function scenrionahoi(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

function DeletePed(ped)
	if not (IsPedAPlayer(ped)) or true then
		DeleteEntity(ped)
		RemoveAllPedWeapons(ped, true)
	end
end

function DeleteObjects(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)

		local timeout = 2000
		while timeout > 0 and not NetworkHasControlOfEntity(object) do
			Wait(100)
			timeout = timeout - 100
		end

		SetEntityAsMissionEntity(object, true, true)

		local timeout = 2000
		while timeout > 0 and not IsEntityAMissionEntity(object) do
			Wait(100)
			timeout = timeout - 100
		end

		if detach then
			DetachEntity(object, 0, false)
		end

		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		DeleteEntity(object)
	end
end

local maxSpeed = 0.0
local cx, cy, cz = 0.0

function ObjectManagerC.deleteObjects(objList)
	for k, v in pairs(objList) do
		if v[1] == "net" then
			local obj = NetToObj(v[2])
			if obj > 0 then
				DeleteObjects(obj, true)
			end
		elseif v[1] == "local" then
			local obj = GetClosestObjectOfType(v[2], v[3], v[4], v[5], v[6], false, true, true)
			if obj > 0 then
				DeleteObjects(obj, true)
			end
		end
	end
end
function ObjectManagerC.deletePeds(objList)
	for k, v in pairs(objList) do
		if v[1] == "net" then
			local obj = NetToPed(v[2])
			if obj > 0 then
				DeletePed(obj)
			end
		elseif v[1] == "local" then
			local obj = GetClosestObjectOfType(v[2], v[3], v[4], v[5], v[6], false, true, true)
			if obj > 0 then
				DeletePed(obj)
			end
		end
	end
end
function ObjectManagerC.deleteVehicles(objList)
	for k, v in pairs(objList) do
		if v[1] == "net" then
			local obj = NetToVeh(v[2])
			if obj > 0 then
				_DeleteEntity(obj)
			end
		elseif v[1] == "local" then
			local obj = GetClosestObjectOfType(v[2], v[3], v[4], v[5], v[6], false, true, true)
			if obj > 0 then
				--SetEntityAsMissionEntity(obj, true)
				--DeleteVehicle(obj)
				--DeleteEntity(obj)
				_DeleteEntity(obj)
			end
		end
	end
end

local distInit = 2.01
local dist = distInit
local isDetectObject = false
local isDetectObjectMask = false
local isDetectPed = false
local isDetectVehicle = false
local isPermOK = false

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			ObjectManagerS.checkPerm(
				{},
				function(ok)
					if ok then
						isPermOK = true
					else
						isPermOK = false
					end
				end
			)
			Citizen.Wait(60000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if isPermOK and IsControlPressed(1, 19) and IsControlJustReleased(1, 96) then
				dist = dist + 1
				if dist > 30 then
					dist = 30
				end
				ShowInfo("탐지 범위: " .. parseInt(dist))
			end
			if isPermOK and IsControlPressed(1, 19) and IsControlJustReleased(1, 97) then
				dist = dist - 1
				if dist < 1 then
					dist = 1
				end
				ShowInfo("탐지 범위: " .. parseInt(dist))
			end
			if isPermOK and IsControlPressed(1, 19) and IsControlJustReleased(1, 117) then
				isDetectObject = not isDetectObject
				if isDetectObject then
					isDetectPed = false
					isDetectVehicle = false
					ShowInfo("오브젝트 탐지 ON")
				else
					ShowInfo("오브젝트 탐지 OFF")
				end
			end
			if isPermOK and IsControlPressed(1, 19) and IsControlJustReleased(1, 111) then
				isDetectObject = not isDetectObject
				if isDetectObject then
					isDetectPed = false
					isDetectVehicle = false
					isDetectObjectMask = true
					ShowInfo("특별마스크 제거모드 ON")
				else
					isDetectObjectMask = false
					ShowInfo("특별마스크 제거모드 OFF")
				end
			end
			if isPermOK and IsControlPressed(1, 19) and IsControlJustReleased(1, 118) then
				isDetectVehicle = not isDetectVehicle
				if isDetectVehicle then
					isDetectObject = false
					isDetectPed = false
					ShowInfo("차량 탐지 ON")
				else
					ShowInfo("차량 탐지 OFF")
				end
			end
			Citizen.Wait(10)
		end
	end
)

local objList = {}
local pedList = {}
local vehList = {}

Citizen.CreateThread(
	function()
		while true do
			if isDetectObject or isDetectPed or isDetectVehicle then
				local ped = GetPlayerPed(-1)
				local pos = GetEntityCoords(ped)
				DrawMarker(1, pos.x, pos.y, pos.z - 1.5, 0, 0, 0, 0, 0, 0, dist * 2.01, dist * 2.01, 3.5, 255, 0, 0, 100, 0, 0, 2, 0, 0, 0, 0)
			end
			Citizen.Wait(0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if isDetectObject == true then
				if #objList > 0 then
					scenrionahoi("오브젝트를 제거하려면 E키를 누르세요. (" .. #objList .. "개)")
					if IsControlJustReleased(1, 38) then
						ObjectManagerS.deleteObjects({objList})
					end
				end
			elseif isDetectPed == true then
				if #pedList > 0 then
					scenrionahoi("사람을 제거하려면 E키를 누르세요. (" .. #pedList .. "명)")
					if IsControlJustReleased(1, 38) then
						ObjectManagerS.deletePeds({pedList})
					end
				end
			elseif isDetectVehicle == true then
				if #vehList > 0 then
					scenrionahoi("차량을 제거하려면 E키를 누르세요. (" .. #vehList .. "대)")
					if IsControlJustReleased(1, 38) then
						ObjectManagerS.deleteVehicles({vehList})
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
			local ped = GetPlayerPed(-1)
			local pos = GetEntityCoords(ped)
			if isDetectObject == true then
				objList = {}
				for entity in Enumerator.EnumerateObjects() do
					if Vdist(GetEntityCoords(entity), GetEntityCoords(ped), true) < dist then
						local isMask = false
						local modelHash = GetEntityModel(entity)
						for k, v in pairs(maskList) do
							if v == modelHash then
								isMask = true
								break
							end
						end
						if isMask then
							if isDetectObjectMask then
								table.insert(objList, {"local", pos.x, pos.y, pos.z, dist, modelHash})
							else
								local p_entity = GetEntityAttachedTo(entity)
								if p_entity == 0 or not DoesEntityExist(p_entity) then
									table.insert(objList, {"local", pos.x, pos.y, pos.z, dist, modelHash})
								end
							end
						else
							if not isDetectObjectMask then
								table.insert(objList, {"local", pos.x, pos.y, pos.z, dist, modelHash})
							end
						end
					end
				end
			elseif isDetectPed == true then
				pedList = {}
				for obj in Enumerator.EnumeratePeds() do
					if obj ~= ped then
						if GetDistanceBetweenCoords(GetEntityCoords(obj), GetEntityCoords(ped), true) < dist then
							NetworkRequestControlOfEntity(obj)

							local timeout = 2000
							while timeout > 0 and not NetworkHasControlOfEntity(obj) do
								Wait(100)
								timeout = timeout - 100
							end

							SetEntityAsMissionEntity(obj, true, true)

							local timeout = 2000
							while timeout > 0 and not IsEntityAMissionEntity(obj) do
								Wait(100)
								timeout = timeout - 100
							end

							if NetworkGetEntityIsNetworked(obj) then
								local netId = PedToNet(obj)
								if netId ~= nil then
									table.insert(pedList, {"net", netId})
								end
							elseif NetworkGetEntityIsLocal(obj) then
								table.insert(pedList, {"local", pos.x, pos.y, pos.z, dist, GetEntityModel(obj)})
							end
						end
					end
				end
			elseif isDetectVehicle == true then
				vehList = {}
				for obj in Enumerator.EnumerateVehicles() do
					if Vdist(GetEntityCoords(obj), GetEntityCoords(ped), true) < dist then
						if NetworkGetEntityIsNetworked(obj) then
							local netId = VehToNet(obj)
							if netId ~= nil then
								table.insert(vehList, {"net", netId})
							end
						elseif NetworkGetEntityIsLocal(obj) then
							table.insert(vehList, {"local", pos.x, pos.y, pos.z, dist, GetEntityModel(obj)})
						end
					end
				end
			end
			Citizen.Wait(100)
		end
	end
)
