local tempoEmSegundos = 30

local milkFarm = {
	{2521.2504882813, 4735.826171875, 34.159198760986},
	{2504.2822265625, 4753.5966796875, 34.303859710693},
	{2495.5502929688, 4762.5810546875, 34.355045318604},
	{2474.2600097656, 4760.8950195313, 34.30383682251},
	{2457.6149902344, 4777.2543945313, 34.489437103271},
	{2448.9133300781, 4785.765625, 34.629295349121},
	{2441.1857910156, 4792.9594726563, 34.665573120117},
	{2442.1330566406, 4735.3676757813, 34.300285339355},
	{2426.421875, 4751.8276367188, 34.304100036621},
	{2417.7512207031, 4762.0649414063, 34.304431915283},
	{2401.0290527344, 4777.9848632813, 34.538898468018},
	{2408.294921875, 4769.2783203125, 34.302276611328}
}

local alreadyCut = {}

local tempoEmMilssegundos = tempoEmSegundos * 1000

local isProcessing = false

local PedList = {
	{type = 3, hash = "a_c_cow", animdict1 = "mini@strip_club@idles@bouncer@base", animdict2 = "base", rotation = 50.0, x = 2522.4904785156, y = 4738.5825195313, z = 34.218292236328, a = 3374176}
}

Citizen.CreateThread(
	function()
		for _, item in pairs(PedList) do
			RequestModel(GetHashKey(item.hash))
			while not HasModelLoaded(GetHashKey(item.hash)) do
				Wait(1)
			end

			RequestAnimDict(item.animdict1)
			while not HasAnimDictLoaded(item.animdict1) do
				Wait(1)
			end
			for k, v in pairs(milkFarm) do
				local x, y, z = table.unpack(v)
				mainped = CreatePed(RWP, item.type, GetHashKey(item.hash), x, y, z - 1.0, item.a, false, true)
				SetEntityHeading(mainped, item.rotation)
				FreezeEntityPosition(mainped, true)
				SetEntityInvincible(mainped, true)
				SetBlockingOfNonTemporaryEvents(mainped, true)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			for k, v in pairs(milkFarm) do
				local x, y, z = table.unpack(v)
				z = z - 1
				local pCoords = GetEntityCoords(GetPlayerPed(-1))
				local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
				local alpha = math.floor(255 - (distance * 30))
				if alreadyCut[k] ~= nil then
					local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
					if timeDiff < tempoEmMilssegundos then
						if distance < 5.0 then
							local seconds = math.ceil(tempoEmSegundos - timeDiff / 1000)
							DrawText3d(x, y, z + 1.5, "~w~ ~r~" .. tostring(seconds) .. "~w~초 남음", alpha)
						end
					else
						alreadyCut[k] = nil
					end
				else
					if distance < 1.5 then
						DrawText3d(x, y, z + 1.5, " ~b~[E]젖짜기", alpha)
						if (IsControlJustPressed(1, 38)) then
							if alreadyCut[k] ~= nil then
								if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
									alreadyCut[k] = GetGameTimer()
									TriggerServerEvent("milkfarm:getMilkOnPalet")
								end
							else
								alreadyCut[k] = GetGameTimer()
								TriggerServerEvent("milkfarm:getMilkOnPalet")
							end
						end
					elseif distance < 5.0 then
						DrawText3d(x, y, z + 1.5, "~w~젖소", alpha)
					end
				end
			end
		end
	end
)

local lastProcess = 0

RegisterNetEvent("milkfarm:getMilkOnPalet")
AddEventHandler(
	"milkfarm:getMilkOnPalet",
	function(tree)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		while (not HasAnimDictLoaded("mp_common")) do
			RequestAnimDict("mp_common")
			Citizen.Wait(5)
		end
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BUM_WASH", 0, true)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		Citizen.Wait(3000)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerServerEvent("milkfarm:getMilkItem")
	end
)

function DrawText3d(x, y, z, text, alpha)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.5, 0.5)
		SetTextFont(1)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, alpha)
		SetTextDropshadow(0, 0, 0, 0, alpha)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x, y, z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
