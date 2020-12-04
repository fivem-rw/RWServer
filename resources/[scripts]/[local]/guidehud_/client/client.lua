Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 288) then
            SendNUIMessage({type = 'openGuideHud'})
        end
    end
end)
RegisterNUICallback('openGuideHud', function(data, cb)
	SetNuiFocus(true, true)
end)
RegisterNUICallback('closeGuideHud', function(data, cb)
	SetNuiFocus(false, false)
end)