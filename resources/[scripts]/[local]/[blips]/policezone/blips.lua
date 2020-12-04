local blips = {
  {x = 457.34768676758, y = -995.34466552734, z = 45.691661834717},
  {x = 323.59967041016, y = -584.08477783203, z = 92.61979675293},
  {x = -556.11553955078, y = -144.560546875, z = 38.209362030029}
}
Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 500.0)
        SetBlipSprite(zoneblip, 1)
        SetBlipColour(zoneblip, 3)
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
