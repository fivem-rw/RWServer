draCB = {}
draCB.CurrentRequestId          = 0
draCB.ServerCallbacks           = {}

draCB.TriggerServerCallback = function(name, cb, ...)
	draCB.ServerCallbacks[draCB.CurrentRequestId] = cb

	TriggerServerEvent('draCB:triggerServerCallback', name, draCB.CurrentRequestId, ...)

	if draCB.CurrentRequestId < 65535 then
		draCB.CurrentRequestId = draCB.CurrentRequestId + 1
	else
		draCB.CurrentRequestId = 0
	end
end

RegisterNetEvent('draCB:serverCallback')
AddEventHandler('draCB:serverCallback', function(requestId, ...)
	draCB.ServerCallbacks[requestId](...)
	draCB.ServerCallbacks[requestId] = nil
end)