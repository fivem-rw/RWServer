posX = 0.01
posY = 0.0-- 0.0152

width = 0.180
height = 0.22--0.354

Citizen.CreateThread(function()
	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

	SetMinimapClipType(1)
	SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, width, height)
	--SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.032, 0.101, 0.259)
	SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.012, 0.022, 0.256, 0.337)

    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

--[[Citizen.CreateThread(function()
	while true do
		Wait(0)

		SetScriptGfxAlign(string.byte('L'), string.byte('B'))
		DrawRect(posX + (width / 2), posY + (height / 2), width, height, 0, 0, 0, 50)
		ResetScriptGfxAlign()
	end
end)]]

local uiHidden = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsBigmapActive() then
			if not uiHidden then
				SendNUIMessage({
					action = "hideUI"
				})
				uiHidden = true
			end
		elseif uiHidden then
			SendNUIMessage({
				action = "displayUI"
			})
			uiHidden = false
		end
	end
end)

Citizen.CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
	if IsPedOnFoot(GetPlayerPed(-1)) then 
		SetRadarZoom(1100)
	elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		SetRadarZoom(1100)
	end
	end
end)

function SetData()
	players = {}
	for i = 0, 31 do
		if NetworkIsPlayerActive( i ) then
			table.insert( players, i )
		end
	end
	
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~g~'  .. name .. "~w~님 환영합니다!")
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_PANE_LEAVE', '~r~서버 종료')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_PANE_QUIT', '~w~윈도우로 나가기')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_MAP', '~b~지도 정보')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_GAM', '~r~게임 종료')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_INF', '~w~알림 메뉴')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_SET', '~w~설정 메뉴')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_STA', '~w~미사용 메뉴')
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'PM_SCR_RPL', '~y~락스타')
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)

local show = true

if show == true then

    RegisterNetEvent('playerSpawned')
    AddEventHandler('playerSpawned', function(spawn)


    Citizen.CreateThread(function() 
        while show == true do     
            Citizen.Wait(1)	
            local playercoords = GetEntityCoords(GetPlayerPed(-1))
			Drawing.draw3DText(playercoords.x, playercoords.y + 10, playercoords.z + 1.700, "~w~리얼월드 ~g~접속 완료", 6, 1.0, 0.8)
			Drawing.draw3DText(playercoords.x, playercoords.y + 10, playercoords.z, "~b~디스코드 ~w~discord.gg/realw ", 8, 0.4, 0.3)
			Drawing.draw3DText(playercoords.x, playercoords.y + 10, playercoords.z - .700, "~y~규칙 사항~w~을 준수 해주십시요!", 8, 0.4, 0.3)
        end
    end)

    Citizen.CreateThread(function()
        if show == true then
          Citizen.Wait(10000)
          show = false
        end
    end)


    Drawing = setmetatable({}, Drawing)
    Drawing.__index = Drawing

    function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

        local scale = (1/dist)*20
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov

        SetTextScale(scaleX*scale, scaleY*scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 190)
        SetTextDropshadow(1, 1, 1, 0, 255)
        SetTextEdge(2, 0, 0, 0, 220)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(textInput)
        SetDrawOrigin(x,y,z+2, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
    
    end)


end
