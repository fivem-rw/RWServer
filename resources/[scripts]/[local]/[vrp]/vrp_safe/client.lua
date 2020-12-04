vRP = Proxy.getInterface("vRP")
vrp_safeC = {}
Tunnel.bindInterface("vrp_safe", vrp_safeC)
Proxy.addInterface("vrp_safe", vrp_safeC)
vrp_safeS = Tunnel.getInterface("vrp_safe", "vrp_safe")

function DrawText3d(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())

  if onScreen then
    SetTextScale(0.5, 0.5)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
  end
end

local objects = {
  {-1463.1921386719, -1466.4349365234, 2.1601762771606, "prop_ld_int_safe_01", 290.00}
}

Citizen.CreateThread(
  function()
    for k, v in pairs(objects) do
      RequestModel(GetHashKey(v[4]))
      while not HasModelLoaded(GetHashKey(v[4])) do
        Citizen.Wait(0)
      end
      local object = CreateObjectNoOffset(RWO, GetHashKey(v[4]), v[1], v[2], v[3], false, true, false)
      SetEntityHeading(object, v[5])
      PlaceObjectOnGroundProperly(object)
    end
  end
)
local isAtt = false
Citizen.CreateThread(
  function()
    while true do
      local playerCoords = GetEntityCoords(GetPlayerPed(-1))
      local hash = GetHashKey("prop_ld_int_safe_01")
      local closeDoor = GetClosestObjectOfType(playerCoords[1], playerCoords[2], playerCoords[3], 1.0, hash, false, false, false)
      if closeDoor and closeDoor > 0 then
        DrawText3d(playerCoords[1], playerCoords[2], playerCoords[3], "E키를 눌러주세요")
        if IsControlJustReleased(0, 20) then
          if not isAtt then
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(closeDoor, myped, 4103, 11816, 0.60, 0.20, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            isAtt = true
          else
            DetachEntity(closeDoor, true, false)
            isAtt = false
          end
        end
      end
      Citizen.Wait(10)
    end
  end
)
