local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_showimgS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_showimg")
vrp_showimgC = Tunnel.getInterface("vrp_showimg", "vrp_showimg")
Tunnel.bindInterface("vrp_showimg", vrp_showimgS)

RegisterNetEvent("proxy_showimg:show")
AddEventHandler(
  "proxy_showimg:show",
  function(p_user_id, p_url, p_time, p_alpha)
    if not p_user_id or not p_url then
      return
    end
    local player = vRP.getUserSource({tonumber(p_user_id)})
    local url = p_url
    local time = 10
    local alpha = 100
    if player then
      if p_time and p_time ~= "" then
        time = tonumber(p_time)
      end
      if p_alpha and p_alpha ~= "" then
        alpha = tonumber(p_alpha)
      end
      vrp_showimgC.showImg(player, {url, time, alpha})
    end
  end
)

RegisterCommand(
  "imgshow",
  function(source, args)
    TriggerEvent("proxy_showimg:show", args[1], args[2], args[3], args[4])
  end
)

RegisterCommand(
  "imghide",
  function(source, args)
    if not args[1] then
      return
    end
    local player = vRP.getUserSource({tonumber(args[1])})
    if player then
      vrp_showimgC.hideImg(player)
    end
  end
)

RegisterCommand(
  "imgshowall",
  function(source, args)
    if not args[1] then
      return
    end
    local url = args[1]
    local time = 10
    local alpha = 100
    if args[2] and args[2] ~= "" then
      time = tonumber(args[2])
    end
    if args[3] and args[3] ~= "" then
      alpha = tonumber(args[3])
    end
    vrp_showimgC.showImg(-1, {url, time, alpha})
  end
)

RegisterCommand(
  "imghideall",
  function(source, args)
    vrp_showimgC.hideImg(-1)
  end
)
