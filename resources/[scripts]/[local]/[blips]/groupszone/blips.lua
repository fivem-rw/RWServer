local blips = {
  {x = -135.92427062988, y = 970.44915771484, z = 235.87889099121, r = 500.0}, -- 백사회존
  --{x = -2661.7358398438, y = 1307.9553222656, z = 150.84364318848, r = 500.0}, -- 에르지오존
  {x = -39.559116363525, y = -1113.4666748047, z = 26.437814712524, r = 500.0}, -- 뉴 에르지오존
  {x = 1395.3587646484, y = 1147.3421630859, z = 121.3426361084, r = 500.0}, -- 흑사회존
  {x = -1474.3212890625, y = 884.53479003906, z = 182.94036865234, r = 500.0}, -- 독사회존
  {x = -336.36993408203, y = -1000.5257568359, z = 30.804779052734, r = 500.0}, --리얼다이소
  {x = -911.66650390625, y = -2041.5988769531, z = 9.4052886962891, r = 500.0}, --방송국
  {x = 27.841377258301, y = -1074.4826660156, z = 38.152149200439, r = 350.0}, --리얼캐피탈
  {colour = 5, x = -1520.2717285156, y = 121.55750274658, z = 71.542404174805, r = 600.0}, --스태프
  {title = "사냥터", colour = 3, id = 442, x = -1496.7020263672, y = 4980.9282226563, z = 63.024227142334} -- 사냥터
}

Citizen.CreateThread(
  function()
    Citizen.Wait(0)
    local bool = true
    if bool then
      for k, v in pairs(blips) do
        zoneblip = AddBlipForRadius(v.x, v.y, v.z, v.r or 500.0)
        SetBlipSprite(zoneblip, 1)
        SetBlipColour(zoneblip, v.colour or 1)
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
