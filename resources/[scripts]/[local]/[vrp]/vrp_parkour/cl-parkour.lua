--[[	
			Increased Player Agility & Ability
					By Silence

				But client stuff...
--]]

RegisterNetEvent("Parkour:KeybindsToggleTrue.cl")
RegisterNetEvent("Parkour:KeybindsToggleFalse.cl")
RegisterNetEvent("Parkour:NotifToggle.cl")

AddEventHandler("Parkour:KeybindsToggleTrue.cl", function(resName)
	if Config.ParkControls == false then
		Config.ParkControls = true
		Notif("~c~Parkour Keybinds have been ~b~Enabled")
	else
		Notif("~c~Parkour Keybinds have already been ~b~Enabled")
	end
end)
AddEventHandler("Parkour:KeybindsToggleFalse.cl", function(resName)
	if Config.ParkControls == true then
		Config.ParkControls = false
		Notif("~c~Parkour Keybinds have been ~r~Disabled")
	else
		Notif("~c~Parkour Keybinds have already been ~r~Disabled")
	end
end)
AddEventHandler("Parkour:NotifToggle.cl", function(resName)
	if Config.NotiToggle == true then
		Config.NotiToggle = false
		Notif("~c~Parkour Notifications have been ~r~Disabled")
	else
		Config.NotiToggle = true
		Notif("~c~Parkour Notifications have been ~b~Enabled")
	end
end)

Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "explosions"
		local anim = "react_blown_forwards"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForwardLeap) then
						if Config.ParkControls == true then
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 1.8, true, true, true, true)
							  Wait(100)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 1.8, true, true, true, true)
							  Wait(100)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 1.8, true, true, true, true)
							  Wait(100)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 1.8, true, true, true, true)
							  Wait(2450)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Forward Leap Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "anim@veh@apc@ps@enter_exit_common"
		local anim = "jump_out"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForceLadderClimb) then
						if Config.ParkControls == true then
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskClimbLadder(ped, 1)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(150)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 4.8, true, true, true, true)
							  Wait(1700)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Force Ladder Climb Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "mini@tennis"
		local anim = "dive_bh_long_lo"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.LeftLongDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							GivePlayerRagdollControl(ped, true)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 2, 2, true, true, true, true)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(1700)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Long Left Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "mini@tennis"
		local anim = "dive_bh_short_lo"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
					Wait(100)
					if IsControlPressed(0, Config.ShortLeftDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							GivePlayerRagdollControl(ped, true)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(1000)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Short Left Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "mini@tennis"
		local anim = "dive_fh_long_hi"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.LongRightDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							GivePlayerRagdollControl(ped, true)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 2, 2, true, true, true, true)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(1700)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Long Right Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "mini@tennis"
		local anim = "dive_fh_short_lo"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ShortRightDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							GivePlayerRagdollControl(ped, true)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(1300)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Short Right Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_avoidance@generic_m"
		local anim = "react_right_side_dive_back"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.BackwardDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(800)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Backward Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_action@generic@core"
		local anim = "run_down"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.TipToe) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(350)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_action@generic@core"
		local anim = "rstart_r_180"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.FastRightTurn) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(300)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_action@generic@core"
		local anim = "rstart_l_-180"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.FastLeftTurn) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(300)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_strafe@first_person@generic"
		local anim = "walk_bwd_180_loop"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.BackwardWalk) then 
						loadAnimDict(ad)
						TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
						TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
						  Wait(400)
						TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_fall"
		local anim = "land_roll"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForwardRoll) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 4.8, 0, true, true, true, true)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(500)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 7.8, 0, true, true, true, true)
							  Wait(500)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer / 2)
							if Config.NotiToggle == true then
								Notif("~g~Forward Roll Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "missfra0_chop_fchase"
		local anim = "ballasog_carbonnetslide"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.OverJump) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(1000)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 3.8, 6.8, true, true, true, true)
							  Wait(1500)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer / 2)
							if Config.NotiToggle == true then
								Notif("~g~Over Jump Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "move_climb"
		local anim = "clamberpose_to_dive"
		local ad2 = "move_fall"
		local anim2 = "land_roll"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForwardDive) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							loadAnimDict(ad2)
							SetPedMoveRateOverride(ped, 1.25)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(400)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 7.8, 5.8, true, true, true, true)
							  Wait(325)
							TaskPlayAnim(ped, ad2, anim2, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(500)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 7.8, 0, true, true, true, true)
							  Wait(500)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Forward Dive Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "missheistfbi3b_ig6_v2"
		local anim = "rubble_slide_gunman"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForwardSlide) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 12.8, 0.8, true, true, true, true)
							  Wait(250)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Forward Dash Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "anim@arena@celeb@flat@solo@no_props@"
		local anim = "flip_a_player_a"
			if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.BackFlip) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							--ApplyForceToEntityCenterOfMass(ped, 1, 0, 12.8, 0.8, true, true, true, true)
							  Wait(2500)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Back Flip Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "misssolomon_3"
		local anim = "plyr_roll_left"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.PassiveKey) then
				  Wait(100)
					if IsControlPressed(0, Config.ForceClimb) then
						if Config.ParkControls == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							TaskClimb(ped, false)
							  Wait(150)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 0, 4.8, true, true, true, true)
							--TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							  Wait(750)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.BufferTimer)
							if Config.NotiToggle == true then
								Notif("~g~Force Climb Ready.")
							end
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)

	-- Extra functions
function Notif(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
	DrawNotification(false, false)
		Wait(Config.NotificationSpeed)
	ThefeedRemoveItem()
end
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end