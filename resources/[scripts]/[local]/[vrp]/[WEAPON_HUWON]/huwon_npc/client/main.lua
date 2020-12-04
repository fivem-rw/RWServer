RegisterNetEvent("KhaichiPed:getWeapon")
AddEventHandler(
	"KhaichiPed:getWeapon",
	function(hash, type)
		PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)

		local Location = Config.Armory
		local PedLocation = Config.ArmoryPed

		local anim = type
		local weaponHash = hash

		local closestPed, closestPedDst = GetClosestPed(PedLocation)

		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ShowNotification("~r~[실패]~w~다시 시도해주세요")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ShowNotification("~r~[대기열]~w~잠시만 기다려주세요!")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({animLib})

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 1, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)

			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(3100)

			RemoveWeaponFromPed(closestPed, GetHashKey(weaponHash))

			Citizen.Wait(15)

			GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponHash), Config.ReceiveAmmo, false, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)

			ClearPedTasks(closestPed)

			TriggerServerEvent("KhaichiPed:giveWeapon", weaponHash)
		end

		UnloadModels()
	end
)

local Exists = nil
RegisterNetEvent("KhaichiPed:pedExists")
AddEventHandler(
	"KhaichiPed:pedExists",
	function(ret)
		Exists = ret
	end
)

RefreshPed = function(spawn)
	local Location = Config.ArmoryPed

	Exists = nil
	TriggerServerEvent("KhaichiPed:pedExists")
	while Exists == nil do
		Wait(0)
	end

	if Exists and not spawn then
		return
	else
		LoadModels({GetHashKey(Location["hash"])})

		local pedId = CreatePed(RWP, 5, Location["hash"], Location["x"], Location["y"], Location["z"] - 0.985, Location["h"], true)

		SetPedCombatAttributes(pedId, 46, true)
		SetPedFleeAttributes(pedId, 0, 0)
		SetBlockingOfNonTemporaryEvents(pedId, true)

		SetEntityAsMissionEntity(pedId, true, true)
		SetEntityInvincible(pedId, true)

		FreezeEntityPosition(pedId, true)
	end
end

local CachedModels = {}

LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		table.insert(CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)

				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)

				Citizen.Wait(10)
			end
		end
	end
end

UnloadModels = function()
	for modelIndex = 1, #CachedModels do
		local model = CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)
		end

		table.remove(CachedModels, modelIndex)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

--===================--
--== GetClosestPed ==--
--===================--
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(
		function()
			local iter, id = initFunc()
			if not id or id == 0 then
				disposeFunc(iter)
				return
			end

			local enum = {handle = iter, destructor = disposeFunc}
			setmetatable(enum, entityEnumerator)

			local next = true
			repeat
				coroutine.yield(id)
				next, id = moveFunc(iter)
			until not next

			enum.destructor, enum.handle = nil, nil
			disposeFunc(iter)
		end
	)
end
function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
function GetPeds(ignoreList)
	local ignoreList = ignoreList or {}
	local peds = {}

	for ped in EnumeratePeds() do
		local found = false

		for j = 1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end
function GetClosestPed(coords, ignoreList)
	local ignoreList = ignoreList or {}
	local peds = GetPeds(ignoreList)
	local closestDistance = -1
	local closestPed = -1

	for i = 1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestPed = peds[i]
			closestDistance = distance
		end
	end

	return closestPed, closestDistance
end
