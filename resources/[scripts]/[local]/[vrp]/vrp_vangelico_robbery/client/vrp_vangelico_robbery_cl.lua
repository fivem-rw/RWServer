local holdingup = false
local store = ""
local secondsRemaining = 0

RegisterNetEvent('pogressBar:drawBar')
AddEventHandler('pogressBar:drawBar', function(time, text, cb, options)
	drawBar(time, text, cb, options)
end)

function jewel_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function jewel_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local Stores = cfg.jewels

RegisterNetEvent('vrp_vangelico_robbery:currentlyrobbing') -- substitua o evento existente
AddEventHandler('vrp_vangelico_robbery:currentlyrobbing', function(robb)
    holdingup = true
    store = robb
    secondsRemaining = cfg.seconds
    local pos = Stores[store].position
    TriggerServerEvent('robbaryInProgressPos', pos.x, pos.y, pos.z)
end)

RegisterNetEvent('vrp_vangelico_robbery:killblip')
AddEventHandler('vrp_vangelico_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('vrp_vangelico_robbery:setblip')
AddEventHandler('vrp_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 487)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('vrp_vangelico_robbery:toofarlocal')
AddEventHandler('vrp_vangelico_robbery:toofarlocal', function(robb)
	holdingup = false
	TriggerEvent('chatMessage', '[안내]', { 255, 69, 0 }, "당신은 멀리 도망갈 수 있습니다.",{255, 255, 255, 0.5,'',100,100,100, 0.5})
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('vrp_vangelico_robbery:playerdiedlocal')
AddEventHandler('vrp_vangelico_robbery:playerdiedlocal', function(robb)
	holdingup = false
	TriggerEvent('chatMessage', '[안내]', {255, 0, 0}, "절도를 성공하기 전에 사망하여 절도가 취소되었습니다.",{255, 255, 255, 0.5,'',100,100,100, 0.5})
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('vrp_vangelico_robbery:robberycomplete')
AddEventHandler('vrp_vangelico_robbery:robberycomplete', function(reward)
	holdingup = false
	TriggerEvent('chatMessage', '[안내]', { 255, 69, 0 }, "가방에 ^2 " .. reward .. "원 ^0 이 지급되었습니다..",{255, 255, 255, 0.5,'',100,100,100, 0.5})
	store = ""
	secondsRemaining = 0
	incircle = false
end)

if cfg.blips then -- blip settings
  Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		--local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Joalheria")
		EndTextCommandSetBlipName(blip)
	end
  end)
end


incircle = false

hasrobbed = false
hasrobbed2 = false
hasrobbed3 = false
hasrobbed4 = false
hasrobbed5 = false
hasrobbed6 = false
hasrobbed7 = false
hasrobbed8 = false
hasrobbed9 = false
hasrobbed10 = false
hasrobbed11 = false
hasrobbed12 = false
hasrobbed13 = false
hasrobbed14 = false
hasrobbed15 = false
hasrobbed16 = false
hasrobbed17 = false
hasrobbed18 = false
hasrobbed19 = false
hasrobbed20 = false

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 ~b~" .. v.nameofstore .. "~w~에서 강도를 시작할 수 있습니다.")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('vrp_vangelico_robbery:rob', k)
						end
						if IsPedShooting(GetPlayerPed(-1)) then

							gioielli1 = AddBlipForCoord(-626.5326, -238.3758, 38.05)
							SetBlipSprite(gioielli1,1)
							SetBlipColour(gioielli1,16742399)
							SetBlipScale(gioielli1,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli1)

							gioielli2 = AddBlipForCoord(-625.6032, -237.5273, 38.05)
							SetBlipSprite(gioielli2,1)
							SetBlipColour(gioielli2,16742399)
							SetBlipScale(gioielli2,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli2)

							gioielli3 = AddBlipForCoord(-626.9178, -235.5166, 38.05)
							SetBlipSprite(gioielli3,1)
							SetBlipColour(gioielli3,16742399)
							SetBlipScale(gioielli3,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli3)

							gioielli4 = AddBlipForCoord(-625.6701, -234.6061, 38.05)
							SetBlipSprite(gioielli4,1)
							SetBlipColour(gioielli4,16742399)
							SetBlipScale(gioielli4,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli4)


							gioielli5 = AddBlipForCoord(-626.8935, -233.0814, 38.05)
							SetBlipSprite(gioielli5,1)
							SetBlipColour(gioielli5,16742399)
							SetBlipScale(gioielli5,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli5)

							gioielli6 = AddBlipForCoord(-627.9514, -233.8582, 38.05)
							SetBlipSprite(gioielli6,1)
							SetBlipColour(gioielli6,16742399)
							SetBlipScale(gioielli6,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli6)

							gioielli7 = AddBlipForCoord(-624.5250, -231.0555, 38.05)
							SetBlipSprite(gioielli7,1)
							SetBlipColour(gioielli7,16742399)
							SetBlipScale(gioielli7,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli7)

							gioielli8 = AddBlipForCoord(-623.0003, -233.0833, 38.05)
							SetBlipSprite(gioielli8,1)
							SetBlipColour(gioielli8,16742399)
							SetBlipScale(gioielli8,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli8)

							gioielli9 = AddBlipForCoord(-620.1098, -233.3672, 38.05)
							SetBlipSprite(gioielli9,1)
							SetBlipColour(gioielli9,16742399)
							SetBlipScale(gioielli9,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli9)

							gioielli10 = AddBlipForCoord(-620.2979, -234.4196, 38.05)
							SetBlipSprite(gioielli10,1)
							SetBlipColour(gioielli10,16742399)
							SetBlipScale(gioielli10,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli10)

							gioielli11 = AddBlipForCoord(-619.0646, -233.5629, 38.05)
							SetBlipSprite(gioielli11,1)
							SetBlipColour(gioielli11,16742399)
							SetBlipScale(gioielli11,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli11)

							gioielli12 = AddBlipForCoord(-617.4846, -230.6598, 38.05)
							SetBlipSprite(gioielli12,1)
							SetBlipColour(gioielli12,16742399)
							SetBlipScale(gioielli12,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli12)

							gioielli13 = AddBlipForCoord(-618.3619, -229.4285, 38.05)
							SetBlipSprite(gioielli13,1)
							SetBlipColour(gioielli13,16742399)
							SetBlipScale(gioielli13,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli13)

							gioielli14 = AddBlipForCoord(-619.6064, -230.5518, 38.05)
							SetBlipSprite(gioielli14,1)
							SetBlipColour(gioielli14,16742399)
							SetBlipScale(gioielli14,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli14)

							gioielli15 = AddBlipForCoord(-620.8951, -228.6519, 38.05)
							SetBlipSprite(gioielli15,1)
							SetBlipColour(gioielli15,16742399)
							SetBlipScale(gioielli15,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli15)

							gioielli16 = AddBlipForCoord(-619.7905, -227.5623, 38.05)
							SetBlipSprite(gioielli16,1)
							SetBlipColour(gioielli16,16742399)
							SetBlipScale(gioielli16,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli16)

							gioielli17 = AddBlipForCoord(-620.6110, -226.4467, 38.05)
							SetBlipSprite(gioielli17,1)
							SetBlipColour(gioielli17,16742399)
							SetBlipScale(gioielli17,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli17)

							gioielli18 = AddBlipForCoord(-623.9951, -228.1755, 38.05)
							SetBlipSprite(gioielli18,1)
							SetBlipColour(gioielli18,16742399)
							SetBlipScale(gioielli18,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli18)

							gioielli19 = AddBlipForCoord(-624.8832, -227.8645, 38.05)
							SetBlipSprite(gioielli19,1)
							SetBlipColour(gioielli19,16742399)
							SetBlipScale(gioielli19,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli19)

							gioielli20 = AddBlipForCoord(-623.6746, -227.0025, 38.05)
							SetBlipSprite(gioielli20,1)
							SetBlipColour(gioielli20,16742399)
							SetBlipScale(gioielli20,0.5)
							BeginTextCommandSetBlipName("STRING")
							EndTextCommandSetBlipName(gioielli20)	
							
							TriggerServerEvent('vrp_vangelico_robbery:rob', k)
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.5326, -238.3758, 38.05, true) < 0.5 ) then
								if (hasrobbed == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 강탈하십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.5326, -238.3758, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli1)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -625.6032, -237.5273, 38.05, true) < 0.5 ) then
								if (hasrobbed2 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 집어들으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -625.6032, -237.5273, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli2)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed2 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.9178, -235.5166, 38.05, true) < 0.5 ) then
								if (hasrobbed3 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 가져오십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.9178, -235.5166, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli3)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed3 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -625.6701, -234.6061, 38.05, true) < 0.5 ) then
								if (hasrobbed4 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -625.6701, -234.6061, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli4)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								hasrobbed4 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -626.8935, -233.0814, 38.05, true) < 0.5 ) then
								if (hasrobbed5 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -626.8935, -233.0814, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli5)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed5 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -627.9514, -233.8582, 38.05, true) < 0.5 ) then
								if (hasrobbed6 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -627.9514, -233.8582, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli6)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed6 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.5250, -231.0555, 38.05, true) < 0.5 ) then
								if (hasrobbed7 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -624.5250, -231.0555, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli7)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed7 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.0003, -233.0833, 38.05, true) < 0.5 ) then
								if (hasrobbed8 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.0003, -233.0833, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli8)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed8 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.1098, -233.3672, 38.05, true) < 0.5 ) then
							if (hasrobbed9 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.1098, -233.3672, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli9)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed9 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.2979, -234.4196, 38.05, true) < 0.5 ) then
							if (hasrobbed10 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.2979, -234.4196, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli10)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed10 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.0646, -233.5629, 38.05, true) < 0.5 ) then
							if (hasrobbed11 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.0646, -233.5629, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli11)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed11 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -617.4846, -230.6598, 38.05, true) < 0.5 ) then
							if (hasrobbed12 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -617.4846, -230.6598, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli12)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed12 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -618.3619, -229.4285, 38.05, true) < 0.5 ) then
							if (hasrobbed13 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 룰 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -618.3619, -229.4285, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli13)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed13 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.6064, -230.5518, 38.05, true) < 0.5 ) then
							if (hasrobbed14 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.6064, -230.5518, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli14)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed14 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.8951, -228.6519, 38.05, true) < 0.5 ) then
							if (hasrobbed15 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.8951, -228.6519, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli15)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed15 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -619.7905, -227.5623, 38.05, true) < 0.5 ) then
							if (hasrobbed16 == false) then
							jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -619.7905, -227.5623, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli16)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed16 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -620.6110, -226.4467, 38.05, true) < 0.5 ) then
							if (hasrobbed17 == false) then
								jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
								if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -620.6110, -226.4467, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli17)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed17 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.9951, -228.1755, 38.05, true) < 0.5 ) then
							if (hasrobbed18 == false) then
								jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.9951, -228.1755, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli18)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed18 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.8832, -227.8645, 38.05, true) < 0.5 ) then
							if (hasrobbed19 == false) then
								jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -624.8832, -227.8645, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli19)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed19 = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -623.6746, -227.0025, 38.05, true) < 0.5 ) then
							if (hasrobbed20 == false) then
								jewel_DisplayHelpText("~INPUT_CONTEXT~ 를 눌러 보석을 얻으십시오")
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	                            RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	                            Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", -623.6746, -227.0025, 38.05, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								jewel_DisplayHelpText("~y~보석~w~을 얻는 중 입니다")
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								RemoveBlip(gioielli20)
								TriggerServerEvent('vrp_vangelico_robbery:gioielli1')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                hasrobbed20 = true
							end
							end
							end

							if (hasrobbed == true) and (hasrobbed2 == true) and (hasrobbed3 == true) and (hasrobbed4 == true) and (hasrobbed5 == true) and (hasrobbed6 == true) and (hasrobbed7 == true) and (hasrobbed8 == true) and (hasrobbed9 == true) and (hasrobbed10 == true) and (hasrobbed11 == true) and (hasrobbed12 == true) and (hasrobbed13 == true) and (hasrobbed14 == true) and (hasrobbed15 == true) and (hasrobbed16 == true) and (hasrobbed17 == true) and (hasrobbed18 == true) and (hasrobbed19 == true) and (hasrobbed20 == true) then
							holdingup = false
							
							hasrobbed = false
                            hasrobbed2 = false
                            hasrobbed3 = false
                            hasrobbed4 = false
                            hasrobbed5 = false
                            hasrobbed6 = false
                            hasrobbed7 = false
                            hasrobbed8 = false
                            hasrobbed9 = false
                            hasrobbed10 = false
                            hasrobbed11 = false
                            hasrobbed12 = false
                            hasrobbed13 = false
                            hasrobbed14 = false
                            hasrobbed15 = false
                            hasrobbed16 = false
                            hasrobbed17 = false
                            hasrobbed18 = false
                            hasrobbed19 = false
                            hasrobbed20 = false
							TriggerServerEvent('vrp_vangelico_robbery:endrob', store)
	                        end	

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('vrp_vangelico_robbery:toofar', store)
				holdingup = false
				RemoveBlip(gioielli1)
				RemoveBlip(gioielli2)
				RemoveBlip(gioielli3)
				RemoveBlip(gioielli4)
				RemoveBlip(gioielli5)
				RemoveBlip(gioielli6)
				RemoveBlip(gioielli7)
				RemoveBlip(gioielli8)
				RemoveBlip(gioielli9)
				RemoveBlip(gioielli10)
				RemoveBlip(gioielli11)
				RemoveBlip(gioielli12)
				RemoveBlip(gioielli13)
				RemoveBlip(gioielli14)
				RemoveBlip(gioielli15)
				RemoveBlip(gioielli16)
				RemoveBlip(gioielli17)
				RemoveBlip(gioielli18)
				RemoveBlip(gioielli19)
				RemoveBlip(gioielli20)
				
				hasrobbed = false
                hasrobbed2 = false
                hasrobbed3 = false
                hasrobbed4 = false
                hasrobbed5 = false
                hasrobbed6 = false
                hasrobbed7 = false
                hasrobbed8 = false
                hasrobbed9 = false
                hasrobbed10 = false
                hasrobbed11 = false
                hasrobbed12 = false
                hasrobbed13 = false
                hasrobbed14 = false
                hasrobbed15 = false
                hasrobbed16 = false
                hasrobbed17 = false
                hasrobbed18 = false
                hasrobbed19 = false
                hasrobbed20 = false
			end
		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('vrp_vangelico_robbery:togliblip')
AddEventHandler('vrp_vangelico_robbery:togliblip', function(robb)
	RemoveBlip(gioielli1)
	RemoveBlip(gioielli2)
	RemoveBlip(gioielli3)
	RemoveBlip(gioielli4)
	RemoveBlip(gioielli5)
	RemoveBlip(gioielli6)
	RemoveBlip(gioielli7)
	RemoveBlip(gioielli8)
	RemoveBlip(gioielli9)
	RemoveBlip(gioielli10)
	RemoveBlip(gioielli11)
	RemoveBlip(gioielli12)
	RemoveBlip(gioielli13)
	RemoveBlip(gioielli14)
	RemoveBlip(gioielli15)
	RemoveBlip(gioielli16)
	RemoveBlip(gioielli17)
	RemoveBlip(gioielli18)
	RemoveBlip(gioielli19)
	RemoveBlip(gioielli20)
end)

RegisterNetEvent("lester:createBlip")
AddEventHandler("lester:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 77)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lester")
		EndTextCommandSetBlipName(blip)
	end
end)

