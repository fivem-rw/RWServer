local hurt = false
local player = PlayerPedId()
local injuredcounter = 0
Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		setNotHurt()
		while true do
			local health = GetEntityHealth(GetPlayerPed(-1))
			if health < 160 then
				setHurt(health)
				StillInjured = true
			else
				if hurt then
					setNotHurt()
					showNotHurt()
				end
			end
			Citizen.Wait(500)
		end
	end
)

function setHurt(health)
	hurt = true
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
	Citizen.Wait(5000)
	if health > 120 then
		showHurt()
	end
end

function showHurt()
	DisplayNotification("~y~당신은 다쳤습니다. 진통제를 복용하세요.")
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if injuredcounter == 20000 then
				ApplyDamageToPed(GetPlayerPed(-1), 23, false)
			elseif injuredcounter == 36000 then
				local ped = GetPlayerPed(-1)
				local currentHealth = GetEntityHealth(ped)
				GetEntityHealth(ped, currentHealth - 5)
				Citizen.Wait(5000)
			elseif injuredcounter == 46000 then -- 46000
				DisplayNotification("~r~당신은 지금 병원에 가야합니다!")
			elseif injuredcounter == 54000 then -- 54000
				-- dead kill them AGAIN
				ApplyDamageToPed(player, 800, false)
				DisplayNotification("~r~당신은 제 시간에 치료를 받지 못했습니다.")
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if StillInjured then
				injuredcounter = injuredcounter + 1
			else
				Citizen.Wait(0)
			end
		end
	end
)

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function showNotHurt()
	DisplayNotification("~g~당신은 치료를 받았습니다.")
end

function setNotHurt()
	hurt = false
	StillInjured = false
	injuredcounter = 0
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end
