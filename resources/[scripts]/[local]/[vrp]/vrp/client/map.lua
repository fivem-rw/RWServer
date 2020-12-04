-- BLIPS: see https://wiki.gtanet.work/index.php?title=Blips for blip id/color

-- TUNNEL CLIENT API

-- BLIP

-- create new blip, return native id

function tvRP.DrawText3D(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2.5
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(0, 255, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function tvRP.DrawText3D2(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.6 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    -- SetTextScale(0.0, 0.55)
    SetTextColour(255, 0, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function tvRP.DrawTextBottom(x, y, width, height, scale, text, r, g, b, a, outline)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  if (outline) then
    SetTextOutline()
  end
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end

function tvRP.addBlip(x, y, z, idtype, idcolor, text)
  local blip = AddBlipForCoord(x + 0.001, y + 0.001, z + 0.001) -- solve strange gta5 madness with integer -> double
  SetBlipSprite(blip, idtype)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip, idcolor)

  if text ~= nil then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
  end

  return blip
end

-- remove blip by native id
function tvRP.removeBlip(id)
  RemoveBlip(id)
end

local named_blips = {}

-- set a named blip (same as addBlip but for a unique name, add or update)
-- return native id
function tvRP.setNamedBlip(name, x, y, z, idtype, idcolor, text)
  tvRP.removeNamedBlip(name) -- remove old one

  named_blips[name] = tvRP.addBlip(x, y, z, idtype, idcolor, text)
  return named_blips[name]
end

-- remove a named blip
function tvRP.removeNamedBlip(name)
  if named_blips[name] ~= nil then
    tvRP.removeBlip(named_blips[name])
    named_blips[name] = nil
  end
end

-- GPS

-- set the GPS destination marker coordinates
function tvRP.setGPS(x, y)
  SetNewWaypoint(x + 0.0001, y + 0.0001)
end

-- set route to native blip id
function tvRP.setBlipRoute(id)
  SetBlipRoute(id, true)
end

-- MARKER

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

-- add a circular marker to the game map
-- return marker id
function tvRP.addMarker(x, y, z, sx, sy, sz, r, g, b, a, visible_distance, text)
  local marker = {
    x = x,
    y = y,
    z = z,
    sx = sx,
    sy = sy,
    sz = sz,
    r = r,
    g = g,
    b = b,
    a = a,
    visible_distance = visible_distance,
    text = text
  }

  -- default values
  if marker.sx == nil then
    marker.sx = 2.0
  end
  if marker.sy == nil then
    marker.sy = 2.0
  end
  if marker.sz == nil then
    marker.sz = 0.7
  end

  if marker.r == nil then
    marker.r = 0
  end
  if marker.g == nil then
    marker.g = 155
  end
  if marker.b == nil then
    marker.b = 255
  end
  if marker.a == nil then
    marker.a = 200
  end

  -- fix gta5 integer -> double issue
  marker.x = marker.x + 0.001
  marker.y = marker.y + 0.001
  marker.z = marker.z + 0.001
  marker.sx = marker.sx + 0.001
  marker.sy = marker.sy + 0.001
  marker.sz = marker.sz + 0.001

  if marker.visible_distance == nil then
    marker.visible_distance = 150
  end

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

-- remove marker
function tvRP.removeMarker(id)
  if markers[id] ~= nil then
    markers[id] = nil
    marker_ids:free(id)
  end
end

-- set a named marker (same as addMarker but for a unique name, add or update)
-- return id
function tvRP.setNamedMarker(name, x, y, z, sx, sy, sz, r, g, b, a, visible_distance)
  tvRP.removeNamedMarker(name) -- remove old marker

  named_markers[name] = tvRP.addMarker(x, y, z, sx, sy, sz, r, g, b, a, visible_distance)
  return named_markers[name]
end

function tvRP.removeNamedMarker(name)
  if named_markers[name] ~= nil then
    tvRP.removeMarker(named_markers[name])
    named_markers[name] = nil
  end
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(500)

      local px, py, pz = tvRP.getPosition()

      for k, v in pairs(markers) do
        v.dist = GetDistanceBetweenCoords(v.x, v.y, v.z, px, py, pz, true)
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)

      for k, v in pairs(markers) do
        if v.dist ~= nil and v.dist <= v.visible_distance then
          DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, v.sx, v.sy, v.sz, v.r, v.g, v.b, v.a, 0, 0, 0, 0)
          if v.dist >= 2 and v.dist <= v.visible_distance / 3 then
            tvRP.DrawText3D(v.x, v.y, v.z + 1.2, v.text)
          end
        end
      end
    end
  end
)

-- AREA

local areas = {}

-- create/update a cylinder area
function tvRP.setArea(name, x, y, z, radius, height)
  local area = {x = x + 0.001, y = y + 0.001, z = z + 0.001, radius = radius, height = height, player_in = false}

  -- default values
  if area.height == nil then
    area.height = 6
  end

  areas[name] = area
end

-- remove area
function tvRP.removeArea(name)
  if areas[name] ~= nil then
    areas[name] = nil
  end
end

local playerInAreaIndex = nil
local playerInAreaIndexOld = nil
local playerInKeyOn = false

-- areas triggers detections
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(100)

      local px, py, pz = tvRP.getPosition()

      playerInAreaIndex = nil

      for k, v in pairs(areas) do
        local player_in = (GetDistanceBetweenCoords(v.x, v.y, v.z, px, py, pz, true) <= v.radius and math.abs(pz - v.z) <= v.height)

        if player_in then
          playerInAreaIndex = k
        end

        if v.player_in and not player_in then
          vRPserver.leaveArea({k})
          v.player_in = false
        end
      end

      if playerInAreaIndexOld ~= nil and areas[playerInAreaIndexOld] ~= nil and areas[playerInAreaIndexOld].player_in and playerInAreaIndexOld ~= playerInAreaIndex then
        areas[playerInAreaIndexOld].player_in = false
        vRPserver.leaveArea({playerInAreaIndexOld})
      end

      if playerInKeyOn then
        playerInKeyOn = false
        if playerInAreaIndex ~= nil and areas[playerInAreaIndex] ~= nil then
          if areas[playerInAreaIndex].player_in then
            areas[playerInAreaIndex].player_in = false
            vRPserver.leaveArea({playerInAreaIndex})
          end
          areas[playerInAreaIndex].player_in = true
          vRPserver.enterArea({playerInAreaIndex})
        end
      end

      playerInAreaIndexOld = playerInAreaIndex
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1)
      if playerInAreaIndex ~= nil and areas[playerInAreaIndex] ~= nil then
        tvRP.DrawTextBottom(1.0, 1.0, 1.0, 1.0, 0.6, "~r~E ~w~키를 눌러주세요.", 255, 255, 255, 255)
        if IsControlJustReleased(1, 51) then
          playerInKeyOn = true
        end
      end
    end
  end
)

-- DOOR

-- set the closest door state
-- doordef: .model or .modelhash
-- locked: boolean
-- doorswing: -1 to 1
function tvRP.setStateOfClosestDoor(doordef, locked, doorswing)
  local x, y, z = tvRP.getPosition()
  local hash = doordef.modelhash
  if hash == nil then
    hash = GetHashKey(doordef.model)
  end

  SetStateOfClosestDoorOfType(hash, x, y, z, locked, doorswing + 0.0001)
end

function tvRP.openClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, false, 0)
end

function tvRP.closeClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, true, 0)
end
