local Keys = {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.Locations) do
                local pos = Config.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 1.5 and not exercising then
                    sleep = 5
                    DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                        startExercise(Config.Exercises[pos["exercise"]], pos)
                    end
                    else if dist <= 3.0 and not exercising then
                        sleep = 8
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function startExercise(animInfo, pos)
    local playerPed = PlayerPedId()

    LoadDict(animInfo["idleDict"])
    LoadDict(animInfo["enterDict"])
    LoadDict(animInfo["exitDict"])
    LoadDict(animInfo["actionDict"])

    if pos["h"] ~= nil then
        SetEntityCoords(playerPed, pos["x"], pos["y"], pos["z"])
        SetEntityHeading(playerPed, pos["h"])
    end

    TaskPlayAnim(playerPed, animInfo["enterDict"], animInfo["enterAnim"], 8.0, -8.0, animInfo["enterTime"], 0, 0.0, 0, 0, 0)
    Citizen.Wait(animInfo["enterTime"])

    canExercise = true
    exercising = true

    Citizen.CreateThread(function()
        while exercising do
            Citizen.Wait(8)
            if procent <= 24.99 then
                color = "~r~"
            elseif procent <= 49.99 then
                color = "~o~"
            elseif procent <= 74.99 then
                color = "~b~"
            elseif procent <= 100 then
                color = "~g~"
            end
            DrawText2D(0.505, 0.925, 1.0,1.0,0.33, "진행률 : " .. color..procent .. "%", 255, 255, 255, 255)
            DrawText2D(0.505, 0.95, 1.0,1.0,0.33, "~g~[SPACE]~w~ 운동 시작", 255, 255, 255, 255)
            DrawText2D(0.505, 0.975, 1.0,1.0,0.33, "~r~[DELETE]~w~ 운동 중단", 255, 255, 255, 255)
        end
    end)
	
    Citizen.CreateThread(function()
        while canExercise do
            Citizen.Wait(8)
            local playerCoords = GetEntityCoords(playerPed)
            if procent <= 99 then
                TaskPlayAnim(playerPed, animInfo["idleDict"], animInfo["idleAnim"], 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to exit training
                    canExercise = false
                    TaskPlayAnim(playerPed, animInfo["actionDict"], animInfo["actionAnim"], 8.0, -8.0, animInfo["actionTime"], 0, 0.0, 0, 0, 0)
                    AddProcent(animInfo["actionProcent"], animInfo["actionProcentTimes"], animInfo["actionTime"] - 70)
					TriggerServerEvent('vrp_sala:exerciseGym', 0.015)
                    canExercise = true
                end
                if IsControlJustPressed(0, Keys["DELETE"]) or GetEntityHealth(playerPed) <= 100 then -- press delete to exit training
                    ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                end
            else
                ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
				TriggerServerEvent('vrp_sala:exerciseGym', 0.045)
                -- Here u can put a event to update some sort of skill or something.
                -- this is when u finished your exercise
            end
        end
    end)
end
local motionProcent = 0
RegisterNetEvent("vrp_sala:Corrida")
AddEventHandler("vrp_sala:Corrida", function()
    doingMotion = not doingMotion  
    Citizen.CreateThread(function()
        while doingMotion do
            Citizen.Wait(7) 
            if IsPedSprinting(PlayerPedId()) then
                motionProcent = motionProcent + 9
            elseif IsPedRunning(PlayerPedId()) then
                motionProcent = motionProcent + 6
            elseif IsPedWalking(PlayerPedId()) then
                motionProcent = motionProcent + 3
            end
            
            DrawText2D(0.505, 0.95, 1.0,1.0,0.4, "~b~진행률 :~w~ " .. tonumber(string.format("%.1f", motionProcent/1000)) .. "%", 255, 255, 255, 255)
            if motionProcent >= 100000 then
				TriggerServerEvent('vrp_sala:exerciseRunning', motionProcent/10000)
                doingMotion = false
                motionProcent = 0
				TriggerEvent('chatMessage', '알림', {255, 0, 0}, "훈련을 중단 하였습니다.", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
            end
        end
    end)
	
    if doingMotion then
        motionTimesDone = motionTimesDone + 1
        if motionTimesDone <= 2 then
			TriggerEvent('chatMessage', '알림', {255, 0, 0}, "당신은 훈련을 시작하였습니다.", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
            print(motionTimesDone)
        else
			TriggerEvent('chatMessage', '알림', {255, 0, 0}, "당신은 지쳐서 훈련이 불가능합니다.", {255, 255, 255, 1.0,'', 100, 100, 0, 0.5})
            doingMotion = false
        end
    else
		TriggerEvent('chatMessage', '알림', {255, 0, 0}, "당신은 훈련을 멈추었습니다.", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
		TriggerServerEvent('vrp_sala:exerciseRunning', motionProcent/10000)
    end
end)




Citizen.CreateThread(function()
    while true do
	local ped = GetPlayerPed(-1)
	local mappedVehs = {
	{modelName = "tribike3"},
	}
	Citizen.Wait(3000)
		if IsPedInAnyVehicle(ped) then
			local veh = GetVehiclePedIsIn(ped, true)
			local model = GetEntityModel(veh)
			local bike = nil
			local vehSpeedKM = GetEntitySpeed(veh)*3.6
			for k,v in pairs(mappedVehs) do
				if model == GetHashKey(v.modelName) then
					bike = v.modelName
				end
			end
			
			if bike and (vehSpeedKM >= 10) and (vehSpeedKM < 40) then
				TriggerServerEvent('vrp_sala:exerciseGym2')
			elseif bike and (vehSpeedKM >= 40) then
				TriggerServerEvent('vrp_sala:exerciseGym3')
			end
		end
    end
end)

function ExitTraining(exitDict, exitAnim, exitTime)
    TaskPlayAnim(PlayerPedId(), exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    Citizen.Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

function AddProcent(amount, amountTimes, time)
    for i=1, amountTimes do
        Citizen.Wait(time/amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
      
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(1)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end