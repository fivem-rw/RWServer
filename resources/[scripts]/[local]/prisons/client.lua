local block_run = false

vRP = Proxy.getInterface("vRP")

RegisterNetEvent('block:run')
AddEventHandler('block:run', function()
	if block_run == false then
      block_run = true
      end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
		if GetDistanceBetweenCoords(1689.693, 2586.405, 51.2557, GetEntityCoords(playerPed)) < 195.0 then
      if block_run == false then
      TriggerServerEvent('block:checkper')
      Citizen.Wait(1000)
  end
else
  if block_run == true then
    block_run = false
    vRP.notify({"~g~[ 교정본부 퇴장 ]~w~\n점프가 ~g~활성화~w~ 되었습니다."})
    end
end
end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
    local playerPed = GetPlayerPed(-1)
		if GetDistanceBetweenCoords(1838.259765625, 2565.0881347656, 45.99670791626, GetEntityCoords(playerPed)) < 3.0 then
      DoScreenFadeOut(500)
        SetTimeout(1000, function()
            SetEntityCoords(GetPlayerPed(-1), 1855.60,2560.072,45.672, 1,0,0,1)
            SetEntityHeading(GetPlayerPed(-1), 274.7)
            DoScreenFadeIn(500)
            vRP.notify({"~r~[ 접 근 불 가 ]~w~\n이 지역은 접근 ~r~불가능~w~ 지역입니다."})
  end)
end
end
end)

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

Citizen.CreateThread(
  function()
    while true do
      if block_run == true then
          DisableControlAction(0, 22, true)
          DisableControlAction(0, 166, true)
          DisableControlAction(0, 167, true)
          DisableControlAction(0, 168, true)
       end
      Citizen.Wait(0)
    end
  end
)

--@EUNYUL