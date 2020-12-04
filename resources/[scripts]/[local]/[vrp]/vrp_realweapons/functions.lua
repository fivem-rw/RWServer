RW = {}

function RW.RequestModel(modelHash, cb)
	modelHash = (type(modelHash) == "number" and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

RW.SpawnObject = function(model, coords, cb)
	local model = (type(model) == "number" and model or GetHashKey(model))

	Citizen.CreateThread(
		function()
			RW.RequestModel(model)

			local obj = CreateObject(RWO, model, coords.x, coords.y, coords.z, true, false, true)

			if cb then
				cb(obj)
			end
		end
	)
end

RW.DeleteObject = function(object)
	SetEntityAsMissionEntity(object, false, true)
	DetachEntity(object, true, true)
	DeleteObject(object)
end
