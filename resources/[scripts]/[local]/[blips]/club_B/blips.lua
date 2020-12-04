local blips = {
  {x = 210.10662841797, y = -900.58465576172, z = 32.097579956055, r = 450.0},
  {x = 230.87841796875, y = -793.89642333984, z = 30.01, r = 270.0}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, v.r)
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

local blips2 = {
  {x = 1689.1423339844, y = 2582.5002441406, z = 50.184032440186}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips2) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 210.0)
        SetBlipSprite(zoneblip, 9)
        SetBlipColour(zoneblip, 27)
        SetBlipAlpha(zoneblip, 95)
      end

      for _, info in pairs(blips2) do
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

local blips3 = {
  {x = 338.47674560547, y = -1394.6995849609, z = 32.509201049805},
  {x = -233.81575012207, y = 6317.7827148438, z = 31.497011184692},
  {x = 1841.7899169922, y = 3669.2983398438, z = 33.680004119873}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips3) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 60.0)
        SetBlipSprite(zoneblip, 9)
        SetBlipColour(zoneblip, 2)
        SetBlipAlpha(zoneblip, 95)
      end

      for _, info in pairs(blips3) do
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

local blips4 = {
  {x = 150.30406188965, y = -1040.2572021484, z = 29.374101638794}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips4) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 30.0)
        SetBlipSprite(zoneblip, 9)
        SetBlipColour(zoneblip, 2)
        SetBlipAlpha(zoneblip, 95)
      end

      for _, info in pairs(blips4) do
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

local blips5 = {
  {x = -565.30505371094, y = 5580.8076171875, z = 49.018497467041}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips5) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 100.0)
        SetBlipSprite(zoneblip, 9)
        SetBlipColour(zoneblip, 15)
        SetBlipAlpha(zoneblip, 95)
      end

      for _, info in pairs(blips5) do
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

local blips6 = {
  {x = -2338.1730957031, y = -1329.3078613281, z = 0},
  {x = 4224.3237304688, y = 4593.4858398438, z = 0}
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)

    local bool = true

    if bool then
      for k, v in pairs(blips6) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, 100.0)
        SetBlipSprite(zoneblip, 9)
        SetBlipColour(zoneblip, 3)
        SetBlipAlpha(zoneblip, 95)
      end

      for _, info in pairs(blips6) do
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
