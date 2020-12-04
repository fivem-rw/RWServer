--how long you want the thing to last for. in seconds.
alertstring = false
lastfor = 5
doalert = false
--DO NOT TOUCH BELOW THIS LINE OR YOU /WILL/ FUCK SHIT UP.
--DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW.
RegisterNetEvent('alert')
announcestring = false
AddEventHandler('alert', function(msg)
	alertstring = msg
	doalert = true
	PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
	AddTextEntry("FACES_WARNH2", "공지사항")
	AddTextEntry("QM_NO_0", alertstring)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if doalert then
			if IsControlJustPressed(13,201) then
				print("yes")
				PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1);
				doalert = false
				alertstring = false
			end
			DrawFrontendAlert("FACES_WARNH2", "QM_NO_0", 2, nil, "", 0, 0, false, "FM_NXT_RAC", 1, true, false)
		end
	end
end)

