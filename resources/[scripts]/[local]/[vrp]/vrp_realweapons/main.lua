vrp_realweaponsC = {}
Tunnel.bindInterface("vrp_realweapons", vrp_realweaponsC)
Proxy.addInterface("vrp_realweapons", vrp_realweaponsC)
vRP = Proxy.getInterface("vRP")
vrp_realweaponsS = Tunnel.getInterface("vrp_realweapons", "vrp_realweapons")

local Weapons = {}
local currentModelHash = nil

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			local playerPed = PlayerPedId()

			local modelHash = GetEntityModel(playerPed)
			if modelHash ~= currentModelHash then
				currentModelHash = modelHash
				RemoveGears()
				SetGears()
			end

			for i = 1, #Config.RealWeapons, 1 do
				local weaponHash = GetHashKey(Config.RealWeapons[i].name)

				if HasPedGotWeapon(playerPed, weaponHash, false) then
					local onPlayer = false

					for weaponName, entity in pairs(Weapons) do
						if weaponName == Config.RealWeapons[i].name then
							onPlayer = true
							break
						end
					end

					if not onPlayer and weaponHash ~= GetSelectedPedWeapon(playerPed) then
						SetGear(Config.RealWeapons[i].name)
					elseif onPlayer and weaponHash == GetSelectedPedWeapon(playerPed) then
						RemoveGear(Config.RealWeapons[i].name)
					end
				else
					RemoveGear(Config.RealWeapons[i].name)
				end
			end
		end
	end
)

-- Remove only one weapon that's on the ped
function RemoveGear(weapon)
	local _Weapons = {}

	for weaponName, entity in pairs(Weapons) do
		if weaponName ~= weapon then
			_Weapons[weaponName] = entity
		else
			RW.DeleteObject(entity)
		end
	end

	Weapons = _Weapons
end

-- Remove all weapons that are on the ped
function RemoveGears()
	for weaponName, entity in pairs(Weapons) do
		RW.DeleteObject(entity)
	end
	Weapons = {}
end

-- Add one weapon on the ped
function SetGear(weapon)
	local bone = nil
	local boneX = 0.0
	local boneY = 0.0
	local boneZ = 0.0
	local boneXRot = 0.0
	local boneYRot = 0.0
	local boneZRot = 0.0
	local playerPed = PlayerPedId()
	local model = nil

	for i = 1, #Config.RealWeapons, 1 do
		if Config.RealWeapons[i].name == weapon then
			bone = Config.RealWeapons[i].bone
			boneX = Config.RealWeapons[i].x
			boneY = Config.RealWeapons[i].y
			boneZ = Config.RealWeapons[i].z
			boneXRot = Config.RealWeapons[i].xRot
			boneYRot = Config.RealWeapons[i].yRot
			boneZRot = Config.RealWeapons[i].zRot
			model = Config.RealWeapons[i].model
			break
		end
	end

	RW.SpawnObject(
		model,
		{
			x = x,
			y = y,
			z = z
		},
		function(object)
			local boneIndex = GetPedBoneIndex(playerPed, bone)
			local bonePos = GetWorldPositionOfEntityBone(playerPed, boneIndex)
			AttachEntityToEntity(object, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
			Weapons[weapon] = object
		end
	)
end

-- Add all the weapons in the xPlayer's loadout
-- on the ped
function SetGears()
	local bone = nil
	local boneX = 0.0
	local boneY = 0.0
	local boneZ = 0.0
	local boneXRot = 0.0
	local boneYRot = 0.0
	local boneZRot = 0.0
	local playerPed = PlayerPedId()
	local model = nil
	local weapon = nil

	local loadout = vRP.getWeapons()
	for k, v in pairs(loadout) do
		for j = 1, #Config.RealWeapons, 1 do
			if Config.RealWeapons[j].name == k then
				bone = Config.RealWeapons[j].bone
				boneX = Config.RealWeapons[j].x
				boneY = Config.RealWeapons[j].y
				boneZ = Config.RealWeapons[j].z
				boneXRot = Config.RealWeapons[j].xRot
				boneYRot = Config.RealWeapons[j].yRot
				boneZRot = Config.RealWeapons[j].zRot
				model = Config.RealWeapons[j].model
				weapon = Config.RealWeapons[j].name

				break
			end
		end

		local _wait = true

		RW.SpawnObject(
			model,
			{
				x = x,
				y = y,
				z = z
			},
			function(object)
				local boneIndex = GetPedBoneIndex(playerPed, bone)
				local bonePos = GetWorldPositionOfEntityBone(playerPed, boneIndex)

				AttachEntityToEntity(object, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)

				Weapons[weapon] = object
				_wait = false
			end
		)

		-- wait for async task
		while _wait do
			Citizen.Wait(10)
		end
	end
end
