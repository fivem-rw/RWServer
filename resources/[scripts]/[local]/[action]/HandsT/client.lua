keybind = 20 -- E Key
tpose = "hands_up" -- Try these others to find the one u like (fist | flail | flat_floor | grab | hands_up | impact | middle_finger | natural)
dict = "nm@hands" -- leave

Citizen.CreateThread(
	function()
		while true do
			Wait(0)
			local player = GetPlayerPed(-1)
			if (DoesEntityExist(player) and not IsEntityDead(player)) then
				loadAnimDict(dict)
				if IsControlJustPressed(0, keybind) then
					if (IsEntityPlayingAnim(player, dict, tpose, 3)) then
						ClearPedSecondaryTask(GetPlayerPed(-1))
					else
						TaskPlayAnim(player, dict, tpose, 5.0, -1, -1, 50, 0, false, false, false)
					end
				elseif IsControlJustReleased(0, keybind) then
					ClearPedSecondaryTask(GetPlayerPed(-1))
				end
			end
		end
	end
)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
