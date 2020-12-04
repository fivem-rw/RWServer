vRPpaintballC = {}
Tunnel.bindInterface("vRP_paintball",vRPpaintballC)
Proxy.addInterface("vRP_paintball",vRPpaintballC)
vRP = Proxy.getInterface("vRP")
vRPSpaintball = Tunnel.getInterface("vRP_paintball","vRP_paintball")

-- blue 3101.0104980469,-4813.201171875,15.261613845825
-- red 3006.9338378906,-4611.6850585938,15.261608123779
-- hub 132.7251739502,-633.80218505859,263.63641357422
local meniu = false

local gameStarted, playingGame = false, false

local redTeamSpawn = {598.29949951172,-3133.30078125,6.0692586898804 }
local blueTeamSpawn = {475.15884399414,-3368.6311035156,6.0699076652527}

function isCursorInPosition(x,y,width,height)
	local sx, sy = GetActiveScreenResolution()
  local cx, cy = GetNuiCursorPosition ( )
  local cx, cy = (cx / sx), (cy / sy)
  
	local width = width / 2
	local height = height / 2
  
  if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
	  return true
  else
	  return false
  end
end

function drawtxt(text,font,centre,x,y,scale,r,g,b,a)
    y = y - 0.010
    scale = scale/2
    y = y + 0.002
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(1)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("~h~"..text)
        DrawText(_x,_y)
    end
end

local chosenTeam = nil

function vRPpaintballC.drawhud()
    while meniu do
        Wait(0)

		ShowCursorThisFrame()
		DisableControlAction(0,51,true)
		DisableControlAction(0,24,true)
		DisableControlAction(0,47,true)
		DisableControlAction(0,58,true)
		DisableControlAction(0,263,true)
		DisableControlAction(0,264,true)
		DisableControlAction(0,257,true)
		DisableControlAction(0,140,true)
		DisableControlAction(0,141,true)
		DisableControlAction(0,142,true)
		DisableControlAction(0,143,true)
		DisableControlAction(0, 1, true)
		DisableControlAction(0, 2, true)
		DisableControlAction(0, 27, true)
		DisableControlAction(0, 172, true)
		DisableControlAction(0, 173, true)
		DisableControlAction(0, 174, true)
		DisableControlAction(0, 175, true)
		DisableControlAction(0, 176, true)
		DisableControlAction(0, 177, true)
		DrawRect(0.5,0.5,0.75,0.60, 25,25,25,225) --chenar
		-- caseta 1 --
		DrawRect(0.2+0.15,0.5-0.04,0.20,0.40, 255,255,255,80) --fundal alb
		DrawRect(0.2+0.15, 0.6+0.035, 0.20, 0.050, 0, 51, 0, 130) --buton
		-- caseta 2 --
		DrawRect(0.70-0.05,0.5-0.04,0.20,0.40, 255,255,255,80) --fundal alb
		DrawRect(0.70-0.05, 0.6+0.035, 0.20, 0.050, 0, 51, 0, 130) --buton

		DrawRect(0.45+0.05, 0.70+0.035, 0.22, 0.040, 255, 0, 0, 130) --buton2 rosu

		drawtxt("[팀참여] ~b~파랑팀",1,1,0.2+0.15, 0.6+0.028,0.95,255,255,255,255)
		drawtxt("[팀참여] ~r~빨강팀",1,1,0.70-0.05, 0.6+0.028,0.95,255,255,255,255)
		drawtxt("닫기",1,1,0.45+0.05, 0.697+0.028,0.95,255,255,255,255)

		if isCursorInPosition(0.35, 0.6+0.035, 0.20, 0.030) then -- blue
			SetCursorSprite(5)
			if IsDisabledControlJustPressed(0, 24) then
				vRPSpaintball.addInTeam({"파랑팀"})
				meniu = false
				chosenTeam = "파랑"
			end
		elseif isCursorInPosition(0.65, 0.6+0.035, 0.20, 0.030) then -- red
			SetCursorSprite(5)
			if IsDisabledControlJustPressed(0, 24) then
				vRPSpaintball.addInTeam({"빨강팀"})
				meniu = false
				chosenTeam = "빨강"
			end
		elseif isCursorInPosition(0.45+0.05, 0.70+0.035, 0.22, 0.040) then -- exit
			SetCursorSprite(5)
			if IsDisabledControlJustPressed(0, 24) then
				meniu = false
			end
		else
			SetCursorSprite(1)
		end
    end
end

function drawScreenText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(center)
    if outline then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local plyW = {}

function respawnPly()
	vRP.setHealth({200})
	vRP.giveWeapons({plyW, true})
	playingGame = false

	vRP.teleport({847.53863525391,-1019.9995727539,27.674083709717})
end

local blueSrcs, redSrcs = {}, {}

function startMatch(sblueSrcs, sredSrcs)
	vRP.setHealth({200})
	blueSrcs, redSrcs = sblueSrcs, sredSrcs
	plyW = vRP.getWeapons({})

	vRPSpaintball.getPlayerTeam({}, function(myTeam)
		if myTeam == "빨강팀" then
			SetEntityCoords(GetPlayerPed(-1), redTeamSpawn[1], redTeamSpawn[2], redTeamSpawn[3], false)
		elseif myTeam == "파랑팀" then
			SetEntityCoords(GetPlayerPed(-1), blueTeamSpawn[1], blueTeamSpawn[2], blueTeamSpawn[3], false)
		end
	end)

	playingGame = true
	Citizen.CreateThread(function()
		while playingGame do
			Wait(500)
			if vRP.isInComa({}) then
				vRPSpaintball.iDied()
				Wait(4000)
				respawnPly()
			end
		end
	end)
end

local GlobalSecRamase, redMembers, blueMembers = 0, 0, 0

function vRPpaintballC.updateLobbyData(sGlobalSecRamase, sredMembers, sblueMembers)
	GlobalSecRamase, redMembers, blueMembers = sGlobalSecRamase, sredMembers, sblueMembers
end

function vRPpaintballC.setGameStat(isOrNot, isPlaying, teams)
	gameStarted	= isOrNot
	if isPlaying == 1 then
		startMatch(teams.blue, teams.red)
	elseif isPlaying == 2 then
		meniu = false
		playingGame = false
		chosenTeam = "무소속"
		vRP.giveWeapons({plyW, true})
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(3000)
		if chosenTeam and not gameStarted then
			local pos = GetEntityCoords(GetPlayerPed(-1))
			if Vdist2(pos.x,pos.y,pos.z, 847.53863525391,-1019.9995727539,27.674083709717) > 30 then 
				vRPSpaintball.removeTeamMember({})
				meniu = false
				chosenTeam = "무소속"
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		while chosenTeam and tostring(chosenTeam) ~= "무소속" do
			Wait(1)

			drawScreenText(0.5, 0.050, 0,0, 0.65, "소속팀 : ~g~"..chosenTeam.."팀", 255, 255, 255, 250, 1, 7, 1)
			if not playingGame then
				drawScreenText(0.5, 0.165, 0,0, 0.55, "게임 시작 시간 : ~r~"..GlobalSecRamase.."초", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.230, 0,0, 0.35, "~r~[ 경고 ]", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.260, 0,0, 0.35, "~w~무기를 가방에 넣어주십시요.", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.285, 0,0, 0.35, "~w~안넣을 시 무기가 초기화 됩니다!", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.320, 0,0, 0.30, "~r~초기화시 복구 불가능합니다", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.100, 0,0, 0.35, "~r~빨강팀 ~w~: "..redMembers.."명 참여 | ~b~파랑팀 ~w~: "..blueMembers.."명 참여", 255, 255, 255, 250, 1, 7, 1)
			else
				drawScreenText(0.5, 0.135, 0,0, 0.4, "남은 시간 : ~o~"..GlobalSecRamase.."초", 255, 255, 255, 250, 1, 7, 1)
				drawScreenText(0.5, 0.100, 0,0, 0.35, "~r~빨강팀 ~w~생존자 : "..redMembers.."명 ~o~생존 ~w~| ~b~파랑팀 ~w~생존자 : "..blueMembers.."명 ~o~생존", 255, 255, 255, 250, 1, 7, 1)

				local selfPed = GetPlayerPed(-1)
				local selfPos = GetEntityCoords(selfPed)

				for _, src in pairs(blueSrcs) do
					local ped = GetPlayerPed(GetPlayerFromServerId(src))
					local pos = GetEntityCoords(ped)
					if Vdist(pos, selfPos) < 30 and selfPed ~= ped then
						DrawMarker(1, pos.x, pos.y, pos.z-0.7, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 0.4, 0, 132, 255, 140, false, true, 2, nil, nil, false)
					end
				end
				for _, src in pairs(redSrcs) do
					local ped = GetPlayerPed(GetPlayerFromServerId(src))
					local pos = GetEntityCoords(ped)
					if Vdist(pos, selfPos) < 30 and selfPed ~= ped then
						DrawMarker(1, pos.x, pos.y, pos.z-0.7, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 0.4, 255, 30, 0, 140, false, true, 2, nil, nil, false)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(GetPlayerPed(-1))
		-- if metri <=2 then
		while GetDistanceBetweenCoords(pos.x,pos.y,pos.z, 847.53863525391,-1019.9995727539,27.674083709717) < 2 do
			pos = GetEntityCoords(GetPlayerPed(-1))
			Wait(0)
			if not gameStarted and (not chosenTeam or tostring(chosenTeam) == "무소속") then
	            Draw3DText(pos.x,pos.y,pos.z+1.05, "~r~[전쟁 시스템]\n~y~[E]~w~를 눌러 ~b~팀~w~을 선택해주세요.", 0.7)
	            if IsControlJustPressed(1,51) then
	                if meniu == false then
	                    meniu = true
	                    vRPpaintballC.drawhud()
	                end
	            end
            elseif gameStarted then
            	Draw3DText(pos.x,pos.y,pos.z+1.1, "~r~[전쟁 시스템]\n~w~현재 전쟁이 진행 중 입니다.", 0.7)
            end
		end
	end
end)

local table = {
    {x = 847.53863525391, y = -1019.9995727539, z = 27.674083709717} -- Enter the coords of the maker here --
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            -- Draw Marker Here --
			DrawMarker(30, table[k].x, table[k].y, table[k].z, 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
			DrawMarker(6, table[k].x, table[k].y, table[k].z, 0, 0, 0, 0, 0, 0, 0.9501,0.9501,0.9501, 255, 210, 0, 255, 0, 0, 0, 1, 0, 0, 0)
			DrawMarker(1, table[k].x, table[k].y, table[k].z-1.2, 0, 0, 0, 0, 0, 0, 3.0,3.0,0.8, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
        end
    end
end)

local function Initialize(scaleform, isWinning)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
      Citizen.Wait(0)
    end
	
	if isWinning == true then
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString("~g~VICTORY")
		PushScaleformMovieFunctionParameterString("~w~소속된 팀이 대결에서 ~g~승리 ~w~하였습니다.")
		PopScaleformMovieFunctionVoid() 
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)	
	elseif isWinning == false then
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString("~r~L O S S")
		PushScaleformMovieFunctionParameterString("~w~소속된 팀이 대결에서 ~r~패배 ~w~하였습니다.")
		PopScaleformMovieFunctionVoid() 
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	else
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString("~o~D R A W")
		PushScaleformMovieFunctionParameterString("~w~양측간 팀이 대결에서 ~o~비겼습니다.")
		PopScaleformMovieFunctionVoid() 
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end

	return scaleform
end

function vRPpaintballC.drawScale(isWinning)
	local winning = true
	Citizen.CreateThread(function()
		Wait(5000)
		winning = false
	end)

	local initalizedScaleform = Initialize("mp_big_message_freemode", isWinning)
	while winning do
		DrawScaleformMovieFullscreen(initalizedScaleform, 255, 255, 255, 255, 0)
		Citizen.Wait(10)
	end
end