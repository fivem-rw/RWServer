whistle = false

function getSurrenderStatus()
	return whistle
end

RegisterNetEvent("whistle:Status")
AddEventHandler(
	"whistle:Status",
	function(event, source)
		if whistle then
			TriggerServerEvent("whistle:Hands", event, source, true)
		else
			TriggerServerEvent("whistle:Hands", event, source, false)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local lPed = GetPlayerPed(-1)
			RequestAnimDict("rcmnigel1c")
			if
				not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and
					not IsPedRunning(lPed) and
					not IsPedUsingAnyScenario(lPed) and
					not IsPedInParachuteFreeFall(lPed)
			 then
				if IsControlPressed(1, 125) then
					if DoesEntityExist(lPed) then
						SetCurrentPedWeapon(lPed, 0xA2719263, true)
						Citizen.CreateThread(
							function()
								RequestAnimDict("rcmnigel1c")
								while not HasAnimDictLoaded("rcmnigel1c") do
									Citizen.Wait(100)
								end

								if not whistle then
									whistle = true
									TaskPlayAnim(lPed, "rcmnigel1c", "hailing_whistle_waive_a", 2.7, 2.7, -1, 49, 0, 0, 0, 0)
								end
							end
						)
					end
				end
			end
			if not IsControlPressed(0, 21) and IsControlReleased(1, 125) then
				if DoesEntityExist(lPed) then
					Citizen.CreateThread(
						function()
							RequestAnimDict("rcmnigel1c")
							while not HasAnimDictLoaded("rcmnigel1c") do
								Citizen.Wait(100)
							end

							if whistle then
								whistle = false
								ClearPedSecondaryTask(lPed)
							end
						end
					)
				end
			end
		end
	end
)
