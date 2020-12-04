
description "vRP Casino Robberies"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts{ 
  "@vrp/client/Proxy.lua",
  "@vrp/client/Tunnel.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
