guardOBJ = true

ObjectsBL={
"prop_fnclink_09a",
"prop_fnclink_09e",
"prop_fnclink_09b",
}

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
	local ped = PlayerPedId()
	local handle, object = FindFirstObject()
	local finished = false
	repeat
        Wait(0)
        if (guardOBJ == true)then
		for i=1,#ObjectsBL do
		if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
      SetEntityInvincible(object, true)
      FreezeEntityPosition(object, true)
      SetEntityHealth(object,999999999999)
		end
        end
    end
        finished, object = FindNextObject(handle)
	until not finished
	EndFindObject(handle)
	end
end)