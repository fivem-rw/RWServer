local blips = {
  {x = -2240.9223632813, y = 275.59896850586, z = 176.60171508789}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 1100.0)
        SetBlipSprite(zoneblip, 1)
        SetBlipColour(zoneblip, 2)
        SetBlipAlpha(zoneblip, 95)
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
  end
)
