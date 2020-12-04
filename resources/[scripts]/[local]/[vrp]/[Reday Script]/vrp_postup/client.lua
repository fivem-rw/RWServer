vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local quantidade = 0
local statuses = false
local nveh = nil
local pegando = false
local andamento = false
local propcaixa = nil
local propcaixa2 = nil
local propcaixa3 = nil
local propcaixa4 = nil
local propcaixa5 = nil
local propcaixa6 = nil
local propcaixa7 = nil
local propcaixa8 = nil
local propcaixa9 = nil
local propcaixa10 = nil
local caixanamao = false
local traseira = false
local portaaberta = false
local portaaberta2 = false
local encomendapega = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregavan = {
	[1] = {x = 6.54, y = -262.54, z = 47.22},
	[2] = {x = 56.31, y = -282.23, z = 47.42},
	[3] = {x = 79.20, y = -289.59, z = 46.67},
	[4] = {x = 47.11, y = -219.62, z = 51.49},
	[5] = {x = -48.41, y = -192.71, z = 52.14},
	[6] = {x = -56.66, y = -47.83, z = 62.53},
	[7] = {x = -334.99, y = 119.27, z = 66.91},
	[8] = {x = -395.92, y = 133.14, z = 65.46},
	[9] = {x = -598.03, y = 139.68, z = 60.00},
	[10] = {x = -644.00, y = 169.00, z = 61.17},
	[11] = {x = -633.66, y = 206.96, z = 73.93},
	[12] = {x = 492.35, y = -1747.04, z = 28.48},
	[13] = {x = 474.544, y = -1813.12, z = 27.97},
	[14] = {x = 422.03, y = -1865.57, z = 26.84},
	[15] = {x = 337.00, y = -1946.08, z = 24.30},
	[16] = {x = 207.10, y = -2042.77, z = 18.16}
}

local entregalocal = {
	[1] = {x = 8.68, y = -243.38, z = 47.66},
	[2] = {x = 66.41, y = -255.80, z = 52.35},
	[3] = {x = 85.61, y = -272.27, z = 47.41},
	[4] = {x = 18.69, y = -209.50, z = 52.85},
	[5] = {x = -44.81, y = -180.49, z = 54.26},
	[6] = {x = -40.96, y = -58.68, z = 63.81},
	[7] = {x = -333.12, y = 101.46, z = 71.21},
	[8] = {x = -383.78, y = 152.68, z = 65.53},
	[9] = {x = -598.77, y = 147.34, z = 61.67},
	[10] = {x = -628.07, y = 169.60, z = 61.15},
	[11] = {x = -620.04, y = 209.05, z = 74.20},
	[12] = {x = 479.64, y = -1735.80, z = 29.15},
	[13] = {x = 495.33, y = -1823.41, z = 28.86},
	[14] = {x = 437.81, y = -1876.05, z = 27.60},
	[15] = {x = 324.34, y = -1937.30, z = 25.01},
	[16] = {x = 200.18, y = -2002.28, z = 18.86}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_postup:permissao")
AddEventHandler(
	"vrp_postup:permissao",
	function()
		if not emservico then
			emservico = true
			parte = 0
			destino = math.random(1, 16)
			--TriggerEvent("Notify","importante","Voce entrou em <b>Serviço</b>, pegue a <b>Van</b>!")
			ShowNotification("~g~작업을 시작했습니다. 차고에서 밴 차량을 가져 가십시오!")
		--ColocarRoupa()
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			if GetDistanceBetweenCoords(GetEntityCoords(ped), -424.05, -2789.53, 6.39, true) <= 30 then
				DrawText3D(-424.05, -2789.53, 6.39 + 0.47, "~w~택배 배달", 1.0, 4)
				DrawText3D(-424.05, -2789.53, 6.39 + 0.33, "~b~택배직원시작장소", 0.9, 1)
				DrawMarker(39, -424.05, -2789.53, 6.39 - 0.1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 65, 105, 255, 50, 0, true, false, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), -424.05, -2789.53, 6.39, true) <= 1 then
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("vrp_postup:permissao")
					end
				end
			end
			if emservico and parte == 0 then
				if GetDistanceBetweenCoords(GetEntityCoords(ped), -411.87, -2797.83, 6.00, true) <= 20 then
					DrawMarker(21, -411.87, -2797.83, 6.00 - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 65, 105, 255, 50, 0, 0, 0, 1)
					if GetDistanceBetweenCoords(GetEntityCoords(ped), -411.87, -2797.83, 6.00, true) <= 1 then
						if IsControlJustPressed(0, 38) then
							Fade(1200)
							--TriggerEvent("Notify","importante","Voce pegou a <b>Van</b> na garagem, pegue as <b>encomendas</b> e coloque nela!")
							spawnVan()
							parte = 1
						end
					end
				end
			end
			if emservico and parte == 1 then
				local veh = GetVanPosition(10)
				local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
				local model = GetEntityModel(veh)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), -439.62, -2796.29, 7.29, true)
				local distance2 = GetDistanceBetweenCoords(GetEntityCoords(ped), coordsVan.x, coordsVan.y, coordsVan.z, true)
				if distance <= 50 and not pegando and portaaberta then
					DrawMarker(21, -439.62, -2796.29, 7.29 - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 65, 105, 255, 50, 0, 0, 0, 1)
					if distance < 1.5 and not IsPedInAnyVehicle(ped) then
						if IsControlJustPressed(0, 38) and not andamento then
							if quantidade < 10 then
								pegando = true
								andamento = true
								caixanamao = true
								TriggerEvent("cancelando", true)
								CarregarObjeto("anim@heists@box_carry@", "idle", "hei_prop_heist_box", 50, 28422)
							else
								--TriggerEvent("Notify","aviso","Voce colocou o máximo de <b>estoque</b> na <b>Van</b>!")
								PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0)
							end
						end
					end
				end
				if pegando and distance2 <= 1.5 and not IsPedInAnyVehicle(ped) then
					if model == 444171386 and GetVehicleNumberPlateText(veh) == "P " .. vRP.getRegistrationNumber({}) then
						DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.80, "~b~[E] ~w~Guardar")
						TriggerEvent("cancelando", false)
						if IsControlJustPressed(0, 38) and andamento then
							quantidade = quantidade + 1
							DeletarObjeto()
							FreezeEntityPosition(ped, true)
							RequestAnimDict("anim@heists@money_grab@briefcase")
							while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
								Citizen.Wait(0)
							end
							TaskPlayAnim(ped, "anim@heists@money_grab@briefcase", "put_down_case", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
							Wait(800)
							DeletarObjeto()
							CaixaVan(veh, model)
							Wait(600)
							caixanamao = false
							andamento = false
							pegando = false
							ClearPedTasksImmediately(ped)
							FreezeEntityPosition(ped, false)
							if quantidade == 10 then
								--TriggerEvent("Notify","importante","Voce colocou <b>"..quantidade.."/10 Encomendas</b> na <b>Van</b>, feche as portas traseiras, entre nela e aguarde até receber uma <b>Entrega</b>!")
								PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0)
								portaaberta = false
								time = math.random(10000, 15000)
								parte = 2
								Wait(time)
								--TriggerEvent("Notify","sucesso","Chamado recebido, entre na <b>Van</b>, e vá ao <b>local</b> entregar a <b>encomenda</b>!")
								PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
								CriandoBlip(entregalocal, destino)
							else
								--TriggerEvent("Notify","importante","Voce colocou <b>"..quantidade.."/10 Encomendas</b> na <b>Van</b>!")
								PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
							end
						end
					end
				end
			end
			if emservico and parte == 1 or parte == 2 then
				if GetDistanceBetweenCoords(GetEntityCoords(ped), -411.87, -2797.83, 6.00, true) <= 20 then
					DrawMarker(21, -411.87, -2797.83, 6.00 - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
					if GetDistanceBetweenCoords(GetEntityCoords(ped), -411.87, -2797.83, 6.00, true) <= 1 then
						if IsControlJustPressed(0, 38) then
							emservico = false
							quantidade = 0
							parte = 0
							statuses = false
							pegando = false
							andamento = false
							caixanamao = false
							traseira = false
							portaaberta = false
							portaaberta2 = false
							encomendapega = false
							TriggerEvent("cancelando", false)
							RemoveBlip(blip)
							PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
							--MainRoupa()
							if nveh then
								DeleteVehicle(nveh)
								nveh = nil
							end
							if DoesEntityExist(propcaixa) then
								DetachEntity(propcaixa, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa))
								propcaixa = nil
							end
							if DoesEntityExist(propcaixa2) then
								DetachEntity(propcaixa2, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa2))
								propcaixa2 = nil
							end
							if DoesEntityExist(propcaixa3) then
								DetachEntity(propcaixa3, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa3))
								propcaixa3 = nil
							end
							if DoesEntityExist(propcaixa4) then
								DetachEntity(propcaixa4, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa4))
								propcaixa4 = nil
							end
							if DoesEntityExist(propcaixa5) then
								DetachEntity(propcaixa5, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa5))
								propcaixa5 = nil
							end
							if DoesEntityExist(propcaixa6) then
								DetachEntity(propcaixa6, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa6))
								propcaixa6 = nil
							end
							if DoesEntityExist(propcaixa7) then
								DetachEntity(propcaixa7, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa7))
								propcaixa7 = nil
							end
							if DoesEntityExist(propcaixa8) then
								DetachEntity(propcaixa8, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa8))
								propcaixa8 = nil
							end
							if DoesEntityExist(propcaixa9) then
								DetachEntity(propcaixa9, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa9))
								propcaixa9 = nil
							end
							if DoesEntityExist(propcaixa10) then
								DetachEntity(propcaixa10, false, false)
								TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa10))
								propcaixa10 = nil
							end
						end
						ShowNotification("~r~당신은 밴을 차고에 집어넣었습니다.")
						ShowNotification("~r~자동으로 미션을 종료합니다.")
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			if emservico and parte == 2 then
				local veh = GetVanPosition(10)
				local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
				local model = GetEntityModel(veh)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), coordsVan.x, coordsVan.y, coordsVan.z, true)
				local distance2 = GetDistanceBetweenCoords(GetEntityCoords(ped), entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z, true)
				if not pegando and portaaberta2 and not encomendapega and distance <= 1.5 and not IsPedInAnyVehicle(ped) then
					if model == 444171386 and GetVehicleNumberPlateText(veh) == "P " .. vRP.getRegistrationNumber({}) then
						if IsControlJustPressed(0, 58) and not andamento then
							if quantidade > 0 then
								quantidade = quantidade - 1
								encomendapega = true
								TriggerEvent("cancelando", true)
								FreezeEntityPosition(ped, true)
								RequestAnimDict("pickup_object")
								while not HasAnimDictLoaded("pickup_object") do
									Citizen.Wait(0)
								end
								TaskPlayAnim(ped, "pickup_object", "pickup_low", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
								Wait(700)
								pegando = true
								ClearPedTasksImmediately(ped)
								FreezeEntityPosition(ped, false)
								PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
								--TriggerEvent("Notify","importante","Voce retirou <b>1x Encomenda</b> da <b>Van</b>!")
								CarregarObjeto("anim@heists@box_carry@", "idle", "hei_prop_heist_box", 50, 28422)
								TirarCaixa()
								andamento = true
							else
								parte = 1
								PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0)
								--TriggerEvent("Notify","aviso","Voce entregou todas as suas <b>encomendas</b>, volte para a central e pegue mais!")
								quantidade = 0
							end
						end
					end
				end
				if pegando and portaaberta2 and encomendapega and distance <= 1.5 and not IsPedInAnyVehicle(ped) then
					if model == 444171386 and GetVehicleNumberPlateText(veh) == "P " .. vRP.getRegistrationNumber({}) then
						TriggerEvent("cancelando", false)
						if IsControlJustPressed(0, 58) and andamento then
							quantidade = quantidade + 1
							encomendapega = false
							DeletarObjeto()
							FreezeEntityPosition(ped, true)
							RequestAnimDict("anim@heists@money_grab@briefcase")
							while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
								Citizen.Wait(0)
							end
							TaskPlayAnim(ped, "anim@heists@money_grab@briefcase", "put_down_case", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
							Wait(800)
							DeletarObjeto()
							CaixaVan(veh, model)
							Wait(600)
							caixanamao = false
							andamento = false
							pegando = false
							PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0)
							ClearPedTasksImmediately(ped)
							FreezeEntityPosition(ped, false)
						--TriggerEvent("Notify","importante","Voce colocou a <b>encomenda</b> na <b>Van</b>, atualmente com <b>"..quantidade.."/10 Encomendas</b>!")
						end
					end
				end
				if distance2 <= 50 and pegando and encomendapega then
					if distance2 < 1.5 and not IsPedInAnyVehicle(ped) then
						DrawText3Ds(entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z + 0.35, "~b~[E] ~w~Entregar Encomenda")
						TriggerEvent("cancelando", false)
						if IsControlJustPressed(0, 38) then
							if quantidade >= 0 then
								Fade(1200)
								local pagamento = math.random(1400, 2500)
								destinoantigo = destino
								pegando = false
								encomendapega = false
								andamento = false
								DeletarObjeto()
								ClearPedTasksImmediately(ped)
								TriggerServerEvent("vrp_postup:receber", pagamento)
								portaaberta = false
								RemoveBlip(blip)
								if quantidade > 0 then
									--TriggerEvent("Notify","sucesso","<b>Encomenda</b> entregue, voce ganhou <b>$"..pagamento.."</b>, faltam entregar <b>"..quantidade.."/10 <b>Encomendas</b>!")
									--TriggerEvent("Notify","importante","Feche as portas traseiras, entre na <b>Van</b> e aguarde até receber uma <b>Entrega</b>!")
									time = math.random(20000, 30000)
									Wait(time)
									--TriggerEvent("Notify","sucesso","Chamado recebido, entre na <b>Van</b>, e vá ao <b>local</b> entregar a <b>encomenda</b>!")
									PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
									while true do
										if destinoantigo == destino then
											destino = math.random(1, 16)
										else
											break
										end
										Citizen.Wait(1)
									end
									CriandoBlip(entregalocal, destino)
								else
									--TriggerEvent("Notify","aviso","Voce entregou todas as suas <b>encomendas</b>, volte para a central e pegue mais!")
									parte = 1
									PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0)
									quantidade = 0
									destino = math.random(1, 16)
									pegando = false
									encomendapega = false
									andamento = false
									portaaberta2 = false
									portaaberta = false
								end
							end
						end
					end
				elseif distance2 <= 50 and not pegando and not encomendapega then
					DrawMarker(21, entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 65, 105, 255, 50, 0, 0, 0, 1)
					if distance2 < 1.5 and not IsPedInAnyVehicle(ped) then
						DrawMarker(21, entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 65, 105, 255, 50, 0, 0, 0, 1)
						DrawText3Ds(entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z + 0.35, "~w~ Pegue a Encomenda na ~b~Van")
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			local veh = GetVanPosition(10)
			local coordsVan = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.7, 0.0)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coordsVan.x, coordsVan.y, coordsVan.z, true)
			local model = GetEntityModel(veh)
			if distance <= 2.0 and not IsPedInAnyVehicle(PlayerPedId()) and emservico then
				if model == 444171386 and GetVehicleNumberPlateText(veh) == "P " .. vRP.getRegistrationNumber({}) then
					if not traseira and not portaaberta and not portaaberta2 then
						DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.80, "~b~[E] ~w~열기")
						if IsControlJustPressed(0, 38) then
							SetVehicleDoorOpen(veh, 3, false, false)
							SetVehicleDoorOpen(veh, 2, false, false)
							traseira = true
							portaaberta2 = true
							if parte == 1 then
								portaaberta = true
							end
						end
					elseif traseira and not portaaberta then
						if parte == 1 then
							DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.80, "~b~[E] ~w~닫기")
						elseif parte == 2 and not encomendapega then
							DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.80, "~b~[E] ~w~닫기 | ~b~[G] ~w~수령")
						elseif parte == 2 and encomendapega then
							DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.80, "~b~[E] ~w~닫기 | ~b~[G] ~w~수령")
						end
						if IsControlJustPressed(0, 38) then
							SetVehicleDoorShut(veh, 3, false)
							SetVehicleDoorShut(veh, 2, false)
							traseira = false
							if parte == 2 then
								portaaberta2 = false
							end
						end
					end
				end
			end
			if distance <= 3.0 and not IsPedInAnyVehicle(PlayerPedId()) and emservico then
				if model == 444171386 and GetVehicleNumberPlateText(veh) == "P " .. vRP.getRegistrationNumber({}) then
					DrawText3Ds(coordsVan.x, coordsVan.y, coordsVan.z + 0.55, "  ~b~" .. quantidade .. "~w~  /  ~b~10    ")
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if andamento then
				BlockWeaponWheelThisFrame()
				DisableControlAction(0, 21, true)
				DisableControlAction(0, 22, true)
			end
		end
	end
)

function spawnVan()
	local mhash = "boxville4"
	if not nveh then
		while not HasModelLoaded(mhash) do
			RequestModel(mhash)
			Citizen.Wait(10)
		end
		local ped = PlayerPedId()
		local x, y, z = vRP.getPosition()
		nveh = CreateVehicle(RWV, mhash, -413.61, -2794.34, 5.90 + 0.5, 313.70, true, false)
		SetVehicleIsStolen(nveh, false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh, false)
		SetVehicleNumberPlateText(nveh, "P " .. vRP.getRegistrationNumber({}))
		Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
		SetVehicleHasBeenOwnedByPlayer(nveh, true)
		SetVehicleDirtLevel(nveh, 0.0)
		SetVehRadioStation(nveh, "OFF")
		SetVehicleEngineOn(GetVehiclePedIsIn(ped, false), true)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end

--[[function FadeRoupa(time,tipo,idle_copy)
	DoScreenFadeOut(800)
	Wait(time)
	if tipo == 1 then 
		vRP.setCustomization(idle_copy)
	else
		TriggerServerEvent("vrp_postup:roupa")
	end
	DoScreenFadeIn(800)
end]]
--[[local RoupaEntregador = {
	["Entregador"] = {
		[1885233650] = {                                      
            [1] = { -1,0 },
            [3] = { 0,0 },
            [4] = { 17,10 },
            [5] = { 42,0 },
            [6] = { 42,0 },
            [7] = { -1,0 },
            [8] = { 15,0 },
            [10] = { -1,0 },
            [11] = { 242,3 },
            ["p0"] = { 58,1 },
            ["p1"] = { 0,0 }
        },
        [-1667301416] = {
            [1] = { -1,0 },
            [3] = { 14,0 },
            [4] = { 14,1 },
            [5] = { 42,0 },
            [6] = { 10,1 },
            [7] = { -1,0 },
            [8] = { 6,0 },
            [9] = { -1,0 },
            [10] = { -1,0 },
            [11] = { 250,3 },
            ["p0"] = { 58,0 },
            ["p1"] = { 5,0 }
        }
	}
}]]
--[[function ColocarRoupa()
	if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
			local custom = RoupaEntregador["Entregador"]
			if custom then
				local old_custom = vRP.getCustomization()
				local idle_copy = {}

				idle_copy = job.SaveIdleCustom(old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
						idle_copy[l] = w
				end
				FadeRoupa(1200,1,idle_copy)
			end
		end
	end
end]]
--[[function MainRoupa()
	if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
	        FadeRoupa(1200,2)
	    end
	end
end]]
function CaixaVan(veh, model)
	if quantidade <= 10 then
		RequestModel(GetHashKey("hei_prop_heist_box"))
		while not HasModelLoaded(GetHashKey("hei_prop_heist_box")) do
			Citizen.Wait(10)
		end
		local coords = GetOffsetFromEntityInWorldCoords(veh, 0.0, 0.0, -5.0)
		if quantidade == 1 and model == 444171386 then
			propcaixa = nil
			propcaixa = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa, veh, 0.0, -0.25, -3.0, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa, true)
		elseif quantidade == 2 and model == 444171386 then
			propcaixa2 = nil
			propcaixa2 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa2, veh, 0.0, 0.25, -3.0, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa2, true)
		elseif quantidade == 3 and model == 444171386 then
			propcaixa3 = nil
			propcaixa3 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa3, veh, 0.0, -0.25, -2.55, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa3, true)
		elseif quantidade == 4 and model == 444171386 then
			propcaixa4 = nil
			propcaixa4 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa4, veh, 0.0, 0.25, -2.55, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa4, true)
		elseif quantidade == 5 and model == 444171386 then
			propcaixa5 = nil
			propcaixa5 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa5, veh, 0.0, -0.25, -2.1, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa5, true)
		elseif quantidade == 6 and model == 444171386 then
			propcaixa6 = nil
			propcaixa6 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa6, veh, 0.0, 0.25, -2.1, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa6, true)
		elseif quantidade == 7 and model == 444171386 then
			propcaixa7 = nil
			propcaixa7 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa7, veh, 0.0, -0.25, -1.65, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa7, true)
		elseif quantidade == 8 and model == 444171386 then
			propcaix8 = nil
			propcaixa8 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa8, veh, 0.0, 0.25, -1.65, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa8, true)
		elseif quantidade == 9 and model == 444171386 then
			propcaixa9 = nil
			propcaixa9 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa9, veh, 0.0, -0.25, -1.2, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa9, true)
		elseif quantidade == 10 and model == 444171386 then
			propcaix10 = nil
			propcaixa10 = CreateObject(RWO, GetHashKey("hei_prop_heist_box"), coords.x, coords.y, coords.z, true, true, true)
			AttachEntityToEntity(propcaixa10, veh, 0.0, 0.25, -1.2, -0.05, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
			FreezeEntityPosition(propcaixa10, true)
		end
	end
end

function TirarCaixa()
	if quantidade == 0 then
		if DoesEntityExist(propcaixa) then
			DetachEntity(propcaixa, false, false)
			FreezeEntityPosition(propcaixa, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa))
			propcaixa = nil
		end
	elseif quantidade == 1 then
		if DoesEntityExist(propcaixa2) then
			DetachEntity(propcaixa2, false, false)
			FreezeEntityPosition(propcaixa2, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa2))
			propcaixa2 = nil
		end
	elseif quantidade == 2 then
		if DoesEntityExist(propcaixa3) then
			DetachEntity(propcaixa3, false, false)
			FreezeEntityPosition(propcaixa3, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa3))
			propcaixa3 = nil
		end
	elseif quantidade == 3 then
		if DoesEntityExist(propcaixa4) then
			DetachEntity(propcaixa4, false, false)
			FreezeEntityPosition(propcaixa4, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa4))
			propcaixa4 = nil
		end
	elseif quantidade == 4 then
		if DoesEntityExist(propcaixa5) then
			DetachEntity(propcaixa5, false, false)
			FreezeEntityPosition(propcaixa5, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa5))
			propcaixa5 = nil
		end
	elseif quantidade == 5 then
		if DoesEntityExist(propcaixa6) then
			DetachEntity(propcaixa6, false, false)
			FreezeEntityPosition(propcaixa6, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa6))
			propcaixa6 = nil
		end
	elseif quantidade == 6 then
		if DoesEntityExist(propcaixa7) then
			DetachEntity(propcaixa7, false, false)
			FreezeEntityPosition(propcaixa7, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa7))
			propcaixa7 = nil
		end
	elseif quantidade == 7 then
		if DoesEntityExist(propcaixa8) then
			DetachEntity(propcaixa8, false, false)
			FreezeEntityPosition(propcaixa8, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa8))
			propcaixa8 = nil
		end
	elseif quantidade == 8 then
		if DoesEntityExist(propcaixa9) then
			DetachEntity(propcaixa9, false, false)
			FreezeEntityPosition(propcaixa9, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa9))
			propcaixa9 = nil
		end
	elseif quantidade == 9 then
		if DoesEntityExist(propcaixa10) then
			DetachEntity(propcaixa10, false, false)
			FreezeEntityPosition(propcaixa10, false)
			TriggerServerEvent("trydeleteobj", ObjToNet(propcaixa10))
			propcaixa10 = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetVanPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius + 0.00001, 0.0)
	local nearVehicle = GetVanDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
		return nearVehicle
	else
		local x, y, z = table.unpack(coordsx)
		if IsPedSittingInAnyVehicle(ped) then
			local veh = GetVehiclePedIsIn(ped, true)
			return veh
		else
			local veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 8192 + 4096 + 4 + 2 + 1)
			if not IsEntityAVehicle(veh) then
				veh = GetClosestVehicle(x + 0.0001, y + 0.0001, z + 0.0001, radius + 0.0001, 0, 4 + 2 + 1)
			end
			return veh
		end
	end
end

function GetVanDirection(coordFrom, coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(position)
	return vehicle
end

function DrawText3D(x, y, z, text, scl, font)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

	local scale = (1 / dist) * scl
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.0 * scale, 1.1 * scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 180)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.34, 0.34)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 370
	DrawRect(_x, _y + 0.0125, 0.001 + factor, 0.028, 0, 0, 0, 78)
end

function CriandoBlip(entregalocal, destino)
	blip = AddBlipForCoord(entregalocal[destino].x, entregalocal[destino].y, entregalocal[destino].z)
	SetBlipSprite(blip, 162)
	SetBlipColour(blip, 5)
	SetBlipScale(blip, 0.45)
	SetBlipAsShortRange(blip, false)
	SetBlipRoute(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Encomendas")
	EndTextCommandSetBlipName(blip)
end

function CarregarObjeto(dict, anim, prop, flag, mao, altura, pos1, pos2, pos3, pos4, pos5, tipo)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	if altura then
		CarregarAnim(dict)
		TaskPlayAnim(ped, dict, anim, 3.0, 3.0, -1, flag, 0, 0, 0, 0)
		local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
		object = CreateObject(RWO, GetHashKey(prop), coords.x, coords.y, coords.z, true, true, true)
		SetEntityCollision(object, false, false)
		if tipo == 1 then
			AttachEntityToEntity(object, ped, GetEntityBoneIndexByName(ped, mao), altura, pos1, pos2, pos3, pos4, pos5, true, false, false, true, 1, true)
			FreezeEntityPosition(object, true)
		elseif tipo == 2 then
			AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, mao), altura, pos1, pos2, pos3, pos4, pos5, true, false, false, true, 1, true)
			FreezeEntityPosition(object, true)
		end
	else
		CarregarAnim(dict)
		TaskPlayAnim(ped, dict, anim, 3.0, 3.0, -1, flag, 0, 0, 0, 0)
		local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
		object = CreateObject(RWO, GetHashKey(prop), coords.x, coords.y, coords.z, true, true, true)
		SetEntityCollision(object, false, false)
		AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, mao), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	end
	SetEntityAsMissionEntity(object, true, true)
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
		DetachEntity(object, false, false)
		TriggerServerEvent("trydeleteobj", ObjToNet(object))
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
AddEventHandler(
	"syncdeleteobj",
	function(index)
		Citizen.CreateThread(
			function()
				if NetworkDoesNetworkIdExist(index) then
					SetEntityAsMissionEntity(index, true, true)
					SetObjectAsNoLongerNeeded(index)
					local v = NetToObj(index)
					if DoesEntityExist(v) then
						DetachEntity(v, false, false)
						PlaceObjectOnGroundProperly(v)
						SetEntityAsNoLongerNeeded(v)
						SetEntityAsMissionEntity(v, true, true)
						DeleteObject(v)
					end
				end
			end
		)
	end
)

local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler(
	"cancelando",
	function(status)
		cancelando = status
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if cancelando then
				BlockWeaponWheelThisFrame()
				DisableControlAction(0, 288, true)
				DisableControlAction(0, 289, true)
				DisableControlAction(0, 170, true)
				DisableControlAction(0, 166, true)
				DisableControlAction(0, 187, true)
				DisableControlAction(0, 189, true)
				DisableControlAction(0, 190, true)
				DisableControlAction(0, 188, true)
				DisableControlAction(0, 57, true)
				DisableControlAction(0, 73, true)
				DisableControlAction(0, 167, true)
				DisableControlAction(0, 311, true)
				DisableControlAction(0, 344, true)
				DisableControlAction(0, 29, true)
				DisableControlAction(0, 182, true)
				DisableControlAction(0, 245, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 47, true)
				DisableControlAction(0, 38, true)
			end
		end
	end
)

function ShowNotification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end
