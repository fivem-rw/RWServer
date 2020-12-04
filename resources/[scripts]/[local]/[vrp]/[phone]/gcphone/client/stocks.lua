local second = 1000
local minute = 60 * second
local hour = 60 * minute

local display = false

-- PREZZI INIZIALI --
AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent("gcPhone:GeneratePrices", object)
  TriggerServerEvent("gcPhone:allUpdate")
  while true do
    Citizen.Wait(StockUpdateTime * hour)
    TriggerServerEvent("gcPhone:GeneratePrices", object)
    TriggerServerEvent("gcPhone:allUpdate")
  end
end)