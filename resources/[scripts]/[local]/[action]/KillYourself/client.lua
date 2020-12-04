local validWeapons = {
	-- Pistols
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	-- SMGs
	"WEAPON_MICROSMG",
	"WEAPON_MACHINEPISTOL"
}

function KillYourself()
	Citizen.CreateThread(
		function()
			local playerPed = GetPlayerPed(-1)

			local canSuicide = false
			local foundWeapon = nil

			for i = 1, #validWeapons do
				if HasPedGotWeapon(playerPed, GetHashKey(validWeapons[i]), false) then
					if GetAmmoInPedWeapon(playerPed, GetHashKey(validWeapons[i])) > 0 then
						canSuicide = true
						foundWeapon = GetHashKey(validWeapons[i])

						break
					end
				end
			end

			if canSuicide then
				if not HasAnimDictLoaded("mp_suicide") then
					RequestAnimDict("mp_suicide")

					while not HasAnimDictLoaded("mp_suicide") do
						Wait(1)
					end
				end

				SetCurrentPedWeapon(playerPed, foundWeapon, true)

				TaskPlayAnim(playerPed, "mp_suicide", "pistol", 8.0, 1.0, -1, 2, 0, 0, 0, 0)

				Wait(750)

				SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
				SetEntityHealth(playerPed, 0)
			end
		end
	)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if not IsControlPressed(0, 21) and IsControlPressed(0, 124) and IsControlPressed(0, 125) and IsControlJustReleased(0, 126) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				KillYourself()
			end
		end
	end
)