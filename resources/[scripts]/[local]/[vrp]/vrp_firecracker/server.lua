local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_firecrackerS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_firecracker")
vrp_firecrackerC = Tunnel.getInterface("vrp_firecracker", "vrp_firecracker")
Tunnel.bindInterface("vrp_firecracker", vrp_firecrackerS)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  i = 1
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

RegisterCommand(
  "firecracker",
  function(source, args)
    local player = source
    if not args[1] then
      return
    end
    if args[1] == "off" then
      vrp_firecrackerC.setOff(-1)
    else
      local arrPos = {0}
      if args[1] == "my" then
        local getCoords = GetEntityCoords(GetPlayerPed(player))
        if getCoords then
          arrPos = {getCoords.x, getCoords.y, getCoords.z}
        end
      else
        arrPos = stringsplit(args[1], ",")
      end
      local area = 100
      local volume = 5
      if args[2] and args[2] ~= "" then
        area = tonumber(args[2])
        if not (area >= 10 and area <= 1000) then
          return
        end
      end
      if args[3] and args[3] ~= "" then
        volume = tonumber(args[3])
        if not (volume >= 1 and volume <= 10) then
          return
        end
      end
      if #arrPos >= 3 then
        vrp_firecrackerC.setOn(-1, {arrPos, area, volume})
      end
    end
  end
)
