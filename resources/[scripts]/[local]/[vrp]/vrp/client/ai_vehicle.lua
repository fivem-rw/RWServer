local aiVehicleSpeed = 50.01

function tvRP.aiVehicleStartWaypoint()
  if DoesBlipExist(GetFirstBlipInfoId(8)) then
    local blipIterator = GetBlipInfoIdIterator(8)
    local blip = GetFirstBlipInfoId(8, blipIterator)
    local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
    local ped = GetPlayerPed(-1)
    ClearPedTasks(ped)
    local v = GetVehiclePedIsIn(ped, false)
    TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, tonumber(aiVehicleSpeed), 156, v, 2883621, 5.5, true)
    SetDriveTaskDrivingStyle(ped, 2883621)
    speedmit = true
  end
end
function tvRP.aiVehicleStartFree()
  local ped = GetPlayerPed(-1)
  ClearPedTasks(ped)
  local v = GetVehiclePedIsIn(ped, false)
  TaskVehicleDriveWander(ped, v, tonumber(aiVehicleSpeed), 8388636)
end
function tvRP.aiVehicleStop()
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
    ClearPedTasks(GetPlayerPed(-1))
  else
    ClearPedTasksImmediately(GetPlayerPed(-1))
  end
end
