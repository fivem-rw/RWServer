resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts{
  "@vrp/client/Proxy.lua",
  "@vrp/client/Tunnel.lua",
  "@vrp/lib/utils.lua",
  "config/config.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config/config.lua",
  "server.lua"
}