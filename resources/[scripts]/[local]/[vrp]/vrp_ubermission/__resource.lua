-- This has been designed to work with my pack, if you're not using my pack and can't get this to work, don't request help.
-- Introduced in vRP (Dunko) V6.6

description "vRP Uber Mission"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}