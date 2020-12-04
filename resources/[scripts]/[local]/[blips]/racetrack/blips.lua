local blips = {

	{x = 3546.0183105469, y = 3720.9621582031, z = 0.0},
	{x = 1779.3786621094, y = 3800.8916015625, z = 40.374320983887},
	{x = 1553.0021972656, y = 3571.4299316406, z = -4.3129768371582}
}

Citizen.CreateThread(function()

		Citizen.Wait(0)

local bool = true
  
  if bool then
        
		for k,v in pairs(blips) do
           

               zoneblip = AddBlipForRadius(v.x,v.y,v.z, 1100.0)
                          SetBlipSprite(zoneblip,1)
                          SetBlipColour(zoneblip,1)
                          SetBlipAlpha(zoneblip,95)
                         
        end
         
    
         for _, info in pairs(blips) do
        
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
	   
	   bool = false
   
   end
end)