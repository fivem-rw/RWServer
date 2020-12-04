vRP = Proxy.getInterface("vRP")
local emservico = false
local quantidade = 0
local statuses = false
local nveh = nil
local pegando = false
local andamento = false
local andamento2 = false
local object = nil
local encomendapega = false
local ped_infooord = false


local blips = {
	{title="피자 배달부", colour=66, id=267, x = -1533.0552978516, y = -423.16159057617, z = 35.587196350098},
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local ped_infolocal = {
	[1] = {x=152.42,y=-1478.68,z=29.35,hash=0xDB9C0997,hash2="s_m_m_linecook"}, 
	[2] = {x=-180.64,y=-1429.02,z=31.30,hash=0xED0CE4C6,hash2="s_m_m_migrant_01"},
	[3] = {x=-842.47,y=-1128.33,z=7.01,hash=0xD55B2BF5,hash2="s_f_y_migrant_01"},
	[4] = {x=804.11,y=-731.09,z=27.59,hash=0xDB9C0997,hash2="s_m_m_linecook"}, 
	[5] = {x=-627.66,y=239.05,z=81.89,hash=0xED0CE4C6,hash2="s_m_m_migrant_01"},
	[6] = {x=90.76,y=298.28,z=110.21,hash=0xD55B2BF5,hash2="s_f_y_migrant_01"}, 
	[7] = {x=1247.16,y=-349.87,z=69.20,hash=0xDB9C0997,hash2="s_m_m_linecook"}
}

local pegarlocal = {
	[1] = {x=147.10,y=-1463.41,z=29.14}, 
	[2] = {x=-187.12,y=-1423.76,z=31.47}, 
	[3] = {x=-845.79,y=-1141.37,z=6.75}, 
	[4] = {x=788.74,y=-733.80,z=27.70}, 
	[5] = {x=-641.96,y=236.11,z=81.69}, 
	[6] = {x=98.35,y=287.85,z=109.97}, 
	[7] = {x=1227.00,y=-353.99,z=69.11}
}

local motolocal = {
	[1] = {x=143.72,y=-1462.58,z=29.35},
	[2] = {x=-188.72,y=-1422.01,z=31.33}, 
	[3] = {x=-843.08,y=-1146.02,z=6.79}, 
	[4] = {x=785.54,y=-734.35,z=27.63}, 
	[5] = {x=-644.88,y=232.17,z=80.77}, 
	[6] = {x=95.43,y=285.05,z=110.20},
	[7] = {x=1223.85,y=-353.38,z=68.97} 
}

local entregalocal = {
	[1] = {x=8.68,y=-243.38,z=47.66}, 
	[2] = {x=66.41,y=-255.80,z=52.35},
	[3] = {x=85.61,y=-272.27,z=47.41}, 
	[4] = {x=18.69,y=-209.50,z=52.85}, 
	[5] = {x=-44.81,y=-180.49,z=54.26}, 
	[6] = {x=-40.96,y=-58.68,z=63.81}, 
	[7] = {x=-333.12,y=101.46,z=71.21}, 
	[8] = {x=-383.78,y=152.68,z=65.53}, 
	[9] = {x=-598.77,y=147.34,z=61.67}, 
	[10] = {x=-628.07,y=169.60,z=61.15}, 
	[11] = {x=-620.04,y=209.05,z=74.20}, 
	[12] = {x=479.64,y=-1735.80,z=29.15}, 
	[13] = {x=495.33,y=-1823.41,z=28.86}, 
	[14] = {x=437.81,y=-1876.05,z=27.60}, 
	[15] = {x=324.34,y=-1937.30,z=25.01}, 
	[16] = {x=200.18,y=-2002.28,z=18.86},
	[17] = {x=1203.61,y=-598.37,z=68.06},
	[18] = {x=414.99,y=-217.31,z=59.91},
	[19] = {x=-664.49,y=-391.42,z=34.59},
	[20] = {x=-668.29,y=-971.36,z=22.34}
}

RegisterNetEvent('vrp_ubereats:permissao')
AddEventHandler('vrp_ubereats:permissao',function()
	if not emservico then
		ShowNotification("~g~작업을 시작했습니다. 차고에서 배달오토바이를 가져 가십시오!")
		parte = 0
		emservico = true
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local coordsx,coordsy,coordsz = table.unpack(GetEntityCoords(ped))
    if not emservico then
		if GetDistanceBetweenCoords(GetEntityCoords(ped), -1533.48,-423.06,35.59,true) <= 30 then
		    DrawText3D(-1533.48,-423.06,35.597+0.47, "~w~배달의 민족", 1.0, 4)
		    DrawText3D(-1533.48,-423.06,35.59+0.35, "~b~음식 배달", 0.8, 1)
		    DrawMarker(37, -1533.48,-423.06,35.59-0.07, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 1.1, 65, 105, 255, 50, 0, true, false, false)
		    if GetDistanceBetweenCoords(GetEntityCoords(ped), -1533.48,-423.06,35.59,true) <= 1 then
          help_message("~INPUT_PICKUP~를 눌러 배달을 시작하세요.")
								if IsControlJustPressed(0,38) then	
									ShowNotification("~r~[업무 시작]\n~g~피자 배달부~w~ 일을 시작합니다.")
				    TriggerServerEvent('vrp_ubereats:permissao')
				end
			end
		end
    end
		if emservico and parte == 0 then
			if GetDistanceBetweenCoords(GetEntityCoords(ped), -1528.03,-416.12,35.59,true) <= 20 then
				DrawText3D(-1528.03,-416.12,35.59+0.47, "~r~피자 배달부", 0.8, 1)		
				DrawText3D(-1528.03,-416.12,35.59+0.35, "~w~[E]~b~오토바이 대여", 0.8, 1)
		        DrawMarker(21,-1528.03,-416.12,35.59-0.2,0,0,0,0.0,0,0,0.8,0.8,0.4,65,105,255,50,0,0,0,1)
		        if GetDistanceBetweenCoords(GetEntityCoords(ped), -1528.03,-416.12,35.59,true) <= 1 then
                    if IsControlJustPressed(0,38) then	
                    	Fade(1200)
						ShowNotification("~g~당신은 차고에 배달오토바이를 가지고, 전화를 기다립니다!")
		                spawnMoto()
		                Wait(10000)
						ShowNotification("~g~당신은 차고에 배달오토바이를 가지고, 전화를 기다립니다!")
						ShowNotification("~g~전화를 받고 그 장소로 가서 음식을 얻으십시오!")
                        parte = 1
                        destino = math.random(1,7)
		                CriandoBlipPegar(motolocal,destino)
				    end
			    end
		    end
		end
		if emservico and parte == 1 then
		    local veh = GetMotoPosition(10)
			local coordsMoto = GetOffsetFromEntityInWorldCoords(veh, 0.0, -0.9, 0.0)
			local model = GetEntityModel(veh)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),motolocal[destino].x,motolocal[destino].y,motolocal[destino].z,true)
			local distance2 = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsMoto.x,coordsMoto.y,coordsMoto.z,true)
			local distance3 = GetDistanceBetweenCoords(GetEntityCoords(ped),pegarlocal[destino].x,pegarlocal[destino].y,pegarlocal[destino].z,true)
			local distancecar = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsMoto.x,coordsMoto.y,coordsMoto.z, true)
			if distance <= 50 and not pegando and not ped_infooord then
				DrawMarker(21,motolocal[destino].x,motolocal[destino].y,motolocal[destino].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
        help_message("표시된 위치로 가서\n~INPUT_PICKUP~을 눌러 음식을 주문하세요!")
                if IsControlJustPressed(0,38) and not andamento and not andamento2 and distance <= 2.0 then
                	Fade(1200)
                	RequestModel(GetHashKey(ped_infolocal[destino].hash2))
					while not HasModelLoaded(GetHashKey(ped_infolocal[destino].hash2)) do
						Citizen.Wait(1)
					end
                    ped_info = CreatePed(4,ped_infolocal[destino].hash,ped_infolocal[destino].x,ped_infolocal[destino].y,ped_infolocal[destino].z-1,3374176,true,false)
					SetBlockingOfNonTemporaryEvents(ped_info,true)
					SetPedSeeingRange(ped_info,0.0)
					SetPedHearingRange(ped_info,0.0)
					SetPedFleeAttributes(ped_info,0,false)
					SetPedKeepTask(ped_info,true)
					SetEntityInvincible(ped_info,true)
					SetPedCanRagdoll(ped_info,false)
					SetPedDiesWhenInjured(ped_info,false)
					SetPedCombatMovement(ped_info,false)
					numero = math.random(1,3)
                    if numero == 1 then
                        RequestModel(GetHashKey("prop_paper_bag_01"))
                        while not HasModelLoaded(GetHashKey("prop_paper_bag_01")) do
                            Citizen.Wait(10)
                        end
                        local coords = GetOffsetFromEntityInWorldCoords(ped_info,0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey("prop_paper_bag_01"),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,ped_info,GetPedBoneIndex(ped_info,28422),0.25,0.0,0.06,65.0,-130.0,-65.0,true,true,false,true,0,true)
                        SetEntityAsMissionEntity(object,true,true)
                    elseif numero == 2 then
                        CarregarAnim("anim@heists@box_carry@")
                        RequestModel(GetHashKey("prop_pizza_box_02"))
                        while not HasModelLoaded(GetHashKey("prop_pizza_box_02")) do
                            Citizen.Wait(10)
                        end
                        TaskPlayAnim(ped_info,"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
                        local coords = GetOffsetFromEntityInWorldCoords(ped_info,0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey("prop_pizza_box_02"),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,ped_info,GetPedBoneIndex(ped_info,11816),-0.05,0.38,-0.050,15.0,285.0,270.0,true,false,false,true,1,true)
                        SetEntityAsMissionEntity(object,true,true)
                        SetEntityAsMissionEntity(object,true,true)
                    elseif numero == 3 then
                        CarregarAnim("anim@heists@box_carry@")
                        RequestModel(GetHashKey("prop_pizza_box_01"))
                        while not HasModelLoaded(GetHashKey("prop_pizza_box_01")) do
                            Citizen.Wait(10)
                        end
                        TaskPlayAnim(ped_info,"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
                        local coords = GetOffsetFromEntityInWorldCoords(ped_info,0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey("prop_pizza_box_01"),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,ped_info,GetPedBoneIndex(ped_info,11816),-0.05,0.38,-0.050,15.0,285.0,270.0,true,false,false,true,1,true)
                        SetEntityAsMissionEntity(object,true,true)
                    end
					TaskGoToCoordAnyMeans(ped_info, pegarlocal[destino].x,pegarlocal[destino].y,pegarlocal[destino].z, 1.0, 0, 0, 786603, 0xbf800000)
					ped_infooord = true
				end
			end
			if distance3 <= 50 and not pegando and ped_infooord then
				if distance3 < 1.3 and not IsPedInAnyVehicle(ped) and ped_infooord and GetDistanceBetweenCoords(GetEntityCoords(ped_info),pegarlocal[destino].x,pegarlocal[destino].y,pegarlocal[destino].z,true) <= 0.5 then
					FreezeEntityPosition(ped_info,true)
					DrawText3Ds(pegarlocal[destino].x,pegarlocal[destino].y,pegarlocal[destino].z+0.55,"~b~[E] ~w~음식 잡기")
                    if IsControlJustPressed(0,38) and not andamento and not andamento2 then
                    	quantidade = 0
                        TriggerEvent('cancelando',true)
                        Wait(1000)
                        pegando = true
                        ClearPedTasksImmediately(ped)
                        if DoesEntityExist(object) then
                            DetachEntity(object,false,false)
                            TriggerServerEvent("trydeleteobj",ObjToNet(object))
                            object = nil
                        end
                        ClearPedSecondaryTask(ped_info)
                        ClearPedTasks(ped_info)
                        FreezeEntityPosition(ped_info,false)
                        TaskGoToCoordAnyMeans(ped_info, ped_infolocal[destino].x,ped_infolocal[destino].y,ped_infolocal[destino].z, 1.0, 0, 0, 786603, 0xbf800000)
                        ped_infooord = false
                        RemoveBlip(blip)
						ShowNotification("~g~음식을 가져다가 오토바이에 보관하십시오")
                        if numero == 1 then
                            RequestModel(GetHashKey("prop_paper_bag_01"))
                            while not HasModelLoaded(GetHashKey("prop_paper_bag_01")) do
                                Citizen.Wait(10)
                            end
                        	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
                            object = CreateObject(GetHashKey("prop_paper_bag_01"),coords.x,coords.y,coords.z,true,true,true)
                            SetEntityCollision(object,false,false)
                            AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,28422),0.25,0.0,0.06,65.0,-130.0,-65.0,true,true,false,true,0,true)
                            SetEntityAsMissionEntity(object,true,true)
                        	andamento = true
                        elseif numero == 2 then
                        	CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,11816,-0.05,0.38,-0.050,15.0,285.0,270.0,2)
                        	andamento2 = true
                        elseif numero == 3 then
                        	CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_01",50,11816,-0.05,0.38,-0.050,15.0,285.0,270.0,2)
                        	andamento2 = true
                        end
					end
				end
			end
			if distancecar <= 1.0 and not IsPedInAnyVehicle(ped) and pegando then
	                if GetVehicleNumberPlateText(veh) == "P "..vRP.getRegistrationNumber({}) then
					DrawText3Ds(coordsMoto.x,coordsMoto.y,coordsMoto.z+0.80,"~b~[E] ~w~음식 보관")
	                TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,38) then
                        if quantidade == 0 then
                            quantidade = quantidade + 1
                            andamento = false
                            andamento2 = false
                            encomendapega = false
				            ClearPedTasksImmediately(ped)
				            DeletarObjeto()
				            stopAnim(true)
                            if DoesEntityExist(object) then
                                DetachEntity(object,false,false)
                                TriggerServerEvent("trydeleteobj",ObjToNet(object))
                                object = nil
                            end
							ShowNotification("~g~음식을 넣었습니다.\n배달을 기다리세요!")
                            time = math.random(5000,10000)
                            destinoantigo2 = destino2
                            destino2 = math.random(1,20)
                            while true do
                                if destinoantigo2 == destino2 then
                                    destino2 = math.random(1,20)
                                else
                                    break
                                end
                                Citizen.Wait(1)
                            end
                            SetTimeout(400,function()
                        	    pegando = false
                                parte = 2
                            end)
                            Wait(time)
							ShowNotification("~g~위치가 접수되면 장소로 이동하여 음식을 배달하십시오!")
                            CriandoBlipEntrega(entregalocal,destino2)
                        else
                            parte = 1
							ShowNotification("~r~피자를 꺼냈습니다!\n표시된 위치로 배달을 완료하세요!")
                            quantidade = 0
                        end
	                end
				end
			end
			if not ped_infooord then
				if DoesEntityExist(ped_info) then
				   if GetDistanceBetweenCoords(GetEntityCoords(ped_info),ped_infolocal[destino].x,ped_infolocal[destino].y,ped_infolocal[destino].z,true) <= 1.1 then
					   Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(ped_info))
                       ped_info = nil
                   end
                end
            end
		end
		if emservico and parte == 1 or parte == 2 then
			if GetDistanceBetweenCoords(GetEntityCoords(ped), -1528.03,-416.12,35.59,true) <= 20 then
		        DrawMarker(21,-1528.03,-416.12,35.59-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
            help_message("빨간 표시로 가 ~INPUT_PICKUP~을 눌러 오토바이를 반납하세요!")
		        if GetDistanceBetweenCoords(GetEntityCoords(ped), -1528.03,-416.12,35.59,true) <= 1 then
                    if IsControlJustPressed(0,38) then	
                    	DeleteVehicle(nveh)
                      quantidade = 0
						emservico = false
						statuses = false
						pegando = false
						andamento = false
						andamento2 = false
						encomendapega = false
						ped_infooord = false
            nveh = nil
						parte = 3
						RemoveBlip(blip)
						ShowNotification("~r~당신은 오토바이를 차고에 집어넣었습니다.")
						ShowNotification("~r~자동으로 미션을 종료합니다.")
				    end
			    end
		    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if emservico and parte == 2 then
		    local veh = GetMotoPosition(10)
			local coordsMoto = GetOffsetFromEntityInWorldCoords(veh, 0.0, -0.9, 0.0)
			local model = GetEntityModel(veh)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z,true)
			local distancecar = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsMoto.x,coordsMoto.y,coordsMoto.z, true)
			if distancecar <= 1.0 and not IsPedInAnyVehicle(ped) and not pegando then
	                if GetVehicleNumberPlateText(veh) == "P "..vRP.getRegistrationNumber({}) then
					DrawText3Ds(coordsMoto.x,coordsMoto.y,coordsMoto.z+0.80,"~b~[E] ~w~꺼내기")
                    if IsControlJustPressed(0,38) and not andamento and not andamento2 and not encomendapega then
                        if quantidade > 0 then
                    	    quantidade = quantidade - 1
                    	    pegando = true
                            TriggerEvent('cancelando',true)
				            ClearPedTasksImmediately(ped)
				            FreezeEntityPosition(ped,false)
							ShowNotification("~r~음식을 꺼냈습니다!\n표시된 위치로 배달을 완료하세요!")
                            SetTimeout(400,function()
                        	    encomendapega = true
                            end)
                            if numero == 1 then
                                RequestModel(GetHashKey("prop_paper_bag_01"))
                                while not HasModelLoaded(GetHashKey("prop_paper_bag_01")) do
                                    Citizen.Wait(10)
                                end
                        	    local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
                                object = CreateObject(GetHashKey("prop_paper_bag_01"),coords.x,coords.y,coords.z,true,true,true)
                                SetEntityCollision(object,false,false)
                                AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,28422),0.25,0.0,0.06,65.0,-130.0,-65.0,true,true,false,true,0,true)
                                SetEntityAsMissionEntity(object,true,true)
                        	    andamento = true
                            elseif numero == 2 then
                        	    CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",50,11816,-0.05,0.38,-0.050,15.0,285.0,270.0,2)
                        	    andamento2 = true
                            elseif numero == 3 then
                        	    CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_01",50,11816,-0.05,0.38,-0.050,15.0,285.0,270.0,2)
                        	    andamento2 = true
                            end
                        else
                            parte = 1
                            ShowNotification("~g~당신은 그에게 음식을 주었다!")
							quantidade = 0
					    end
				    end
				end
			end			
			if distancecar <= 1.0 and not IsPedInAnyVehicle(ped) and pegando then
	                if GetVehicleNumberPlateText(veh) == "P "..vRP.getRegistrationNumber({}) then
					DrawText3Ds(coordsMoto.x,coordsMoto.y,coordsMoto.z+0.80,"~b~[E] ~w~배달통에 넣기")
	                TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,38) and encomendapega then
                        if quantidade >= 0  then
                            quantidade = quantidade + 1
                            pegando = false
                            andamento = false
                            andamento2 = false
                            FreezeEntityPosition(ped,true)
                            RequestAnimDict("pickup_object")
				            while not HasAnimDictLoaded("pickup_object") do
					            Citizen.Wait(0) 
				            end
				            TaskPlayAnim(ped,"pickup_object","pickup_low",100.0,200.0,0.3,120,0.2,0,0,0)
				            ClearPedTasksImmediately(ped)
				            FreezeEntityPosition(ped,false)
				            DeletarObjeto()
				            stopAnim(true)
                            if DoesEntityExist(object) then
                                DetachEntity(object,false,false)
                                TriggerServerEvent("trydeleteobj",ObjToNet(object))
                                object = nil
                            end
							ShowNotification("~g~음식이 저장되었습니다!")
                            SetTimeout(400,function()
                                encomendapega = false
                            end)
                        else
                            parte = 1
                            ShowNotification("~r~배달을 완료하세요!")
                            quantidade = 0
                        end
					end
				end
			end
			if distance <= 50 and pegando and encomendapega then
        help_message("음식을 목적지에 배달하세요.")
				if distance < 5.0 and not IsPedInAnyVehicle(ped) then
					DrawText3Ds(entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z+0.35,"~b~[E] ~w~배달을 완료 하십시오!")
					TriggerEvent('cancelando',false)
                    if IsControlJustPressed(0,38) then
                    	if quantidade == 0 then
                    		Fade(1200)
                    		local pagamento = math.random(600000,1300000) -- 배달비 설정
                    		destinoantigo = destino
							pegando = false
							encomendapega = false
                            andamento = false
                            andamento2 = false
                            DeletarObjeto()
                            stopAnim(true)
                            if DoesEntityExist(object) then
                                DetachEntity(object,false,false)
                                TriggerServerEvent("trydeleteobj",ObjToNet(object))
                                object = nil
                            end
                            ClearPedTasksImmediately(ped)
                            TriggerServerEvent("vrp_ubereats:receber",pagamento)
							ShowNotification("~g~음식이 배달이 완료되어 수당이 입금되었습니다!")
              RemoveBlip(blip)
              Citizen.Wait(5000)
							ShowNotification("~g~오토바이를 타고 다음 배달을받을 때까지 기다리십시오.")
                            time = math.random(10000,25000)
                        	Wait(time)
							ShowNotification("~g~전화를 받고 장소로 가서 음식을 얻습니다.")
                            while true do
                                if destinoantigo == destino then
                                    destino = math.random(1,7)
                                else
                                    break
                                end
                                Citizen.Wait(1)
                            end
                            CriandoBlipPegar(motolocal,destino)
		                    parte = 1
                        else
                        	parte = 1
                        	quantidade = 0
							ShowNotification("~r~배달을 완료하세요!")
                        end
					end
				end
			elseif distance <= 50 and not pegando and not encomendapega then
				DrawMarker(21,entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
				if distance < 1.5 and not IsPedInAnyVehicle(ped) then
					DrawMarker(21,entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,65,105,255,50,0,0,0,1)
					DrawText3Ds(entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z+0.35,"~w~ 오토바이에서 음식을 꺼내십시오")
			    end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if andamento then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,22,true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if andamento2 then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
		end
	end
end)

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end

function spawnMoto()
	local mhash = "tmax"
	if not nveh then
	 while not HasModelLoaded(mhash) do
	  RequestModel(mhash)
	    Citizen.Wait(10)
	 end
		local ped = PlayerPedId()
		local x,y,z = vRP.getPosition({})
		nveh = CreateVehicle(mhash,-1525.93,-424.72,35.44+0.5,198.20,true,false)
		SetVehicleIsStolen(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,"P "..vRP.getRegistrationNumber({}))
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetModelAsNoLongerNeeded(mhash)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,168) and emservico and (nveh) then
			emservico = false
			pegando = false
			andamento = false
			andamento2 = false
			quantidade = 0
			parte = 0
			encomendapega = false
			ped_infooord = false
			TriggerEvent('cancelando',false)
			RemoveBlip(blip)
			if nveh then
			   DeleteVehicle(nveh)
			   nveh = nil
			end
		end
	end
end)

function GetMotoPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetMotoDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetMotoDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end

function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 180)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

function CriandoBlipPegar(motolocal,destino)
	blip = AddBlipForCoord(motolocal[destino].x,motolocal[destino].y,motolocal[destino].z)
	SetBlipSprite(blip,162)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("배달의 집합체")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlipEntrega(entregalocal,destino2)
	blip = AddBlipForCoord(entregalocal[destino2].x,entregalocal[destino2].y,entregalocal[destino2].z)
	SetBlipSprite(blip,162)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("배달의 민족")
	EndTextCommandSetBlipName(blip)
end
function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

function CarregarObjeto(dict,anim,prop,flag,mao,altura,pos1,pos2,pos3,pos4,pos5,tipo)
    local ped = PlayerPedId()

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(10)
    end

    if altura then
        CarregarAnim(dict)
        TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
        local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
        object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
        SetEntityCollision(object,false,false)
        if tipo == 1 then
            AttachEntityToEntity(object,ped,GetEntityBoneIndexByName(ped,mao),altura,pos1,pos2,pos3,pos4,pos5,true,false,false,true,1,true)
            FreezeEntityPosition(object,true)
        elseif tipo == 2 then
            AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,mao),altura,pos1,pos2,pos3,pos4,pos5,true,false,false,true,1,true)
            FreezeEntityPosition(object,true)
        end
    else
        CarregarAnim(dict)
        TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
        local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
        object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
        SetEntityCollision(object,false,false)
        AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,mao),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
    end
    SetEntityAsMissionEntity(object,true,true)
end

function stopAnim(upper)
  anims = {} -- stop all sequences
  if upper then
    ClearPedSecondaryTask(GetPlayerPed(-1))
  else
    ClearPedTasks(GetPlayerPed(-1))
  end
end

function DeletarObjeto()
	stopAnim(true)
	TriggerEvent("binoculos")
	if DoesEntityExist(object) then
		DetachEntity(object,false,false)
		TriggerServerEvent("trydeleteobj",ObjToNet(object))
		object = nil
	end
end

function CarregarAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			SetEntityAsMissionEntity(index,true,true)
			SetObjectAsNoLongerNeeded(index)
			local v = NetToObj(index)
			if DoesEntityExist(v) then
				DetachEntity(v,false,false)
				PlaceObjectOnGroundProperly(v)
				SetEntityAsNoLongerNeeded(v)
				SetEntityAsMissionEntity(v,true,true)
				DeleteObject(v)
			end
		end
	end)
end)

local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
	cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end
end)

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

