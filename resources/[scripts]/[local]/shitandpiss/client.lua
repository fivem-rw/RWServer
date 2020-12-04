-- CONFIG --
DelayPiss = 1 -- How long it takes for the percentage to add one % for piss
DelayShit = 1 -- How long it takes for the percentage to add one % for shit
EnableDebugHUD = false -- Enable the Debug HUD on the right of the screen allowing the user to see their piss and shit percentage

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

IsDead = false
piss = 0
shit = 0

RegisterCommand(
	"piss",
	function(source, args, rawCommand)
		handle_piss()
	end,
	false
)

RegisterCommand(
	"shit",
	function(source, args, rawCommand)
		handle_shit()
	end,
	false
)

Citizen.CreateThread(
	function()
		RequestAnimDict("missbigscore1switch_trevor_piss")
		while not HasAnimDictLoaded("missbigscore1switch_trevor_piss") do
			Citizen.Wait(100)
		end
		RequestAnimDict("switch@trevor@on_toilet")
		while not HasAnimDictLoaded("switch@trevor@on_toilet") do
			Citizen.Wait(100)
		end
	end
)

-- Handle Piss Incrementation
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(DelayPiss * 1000) -- Delay in incrementation in milliseconds
			piss = piss + 1
		end
	end
)

-- Handle Shit Incrementation
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(DelayShit * 2000) -- Delay in incrementation in milliseconds
			shit = shit + 1
		end
	end
)

-- Handle Notfications
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if piss == 100 then
				--DisplayNotification("당신은 소변이 마렵다")
			end
			if shit == 100 then
				--DisplayNotification("당신은 대변이 마렵다")
			end
			if piss > 119 then
				--DisplayNotification("You have pissed yourself!")
				--handle_piss()
			end
			if shit > 119 then
				--DisplayNotification("You have shit yourself!")
				--handle_shit()
			end
		end
	end
)

-- Handle HUD
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if EnableDebugHUD then
				textPiss(piss)
				textShit(shit)
			end
		end
	end
)

function handle_shit()
	local ped = PlayerPedId()
	if not IsEntityPlayingAnim(ped, "switch@trevor@on_toilet", "trev_on_toilet_exit", 3) then
		TaskPlayAnim(ped, "switch@trevor@on_toilet", "trev_on_toilet_exit", 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		--DisplayNotification("You have taken a shit!")
		Wait(8000)
		ClearPedTasksImmediately(ped)
	end
	shit = 0
	return
end

function handle_piss()
	local ped = PlayerPedId()
	if not IsEntityPlayingAnim(ped, "missbigscore1switch_trevor_piss", "piss_loop", 3) then
		TaskPlayAnim(ped, "missbigscore1switch_trevor_piss", "piss_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		--DisplayNotification("You have taken a piss!")
		Wait(8000)
		ClearPedTasksImmediately(ped)
	end
	piss = 0
	return
end

function textPiss(content)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextEntry("STRING")
	--AddTextComponentString("Bladder (Piss): " .. content .. "%")
	DrawText(0.84, 0.62)
end

function textShit(content)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextEntry("STRING")
	--AddTextComponentString("Bladder (Shit): " .. content .. "%")
	DrawText(0.84, 0.65)
end
