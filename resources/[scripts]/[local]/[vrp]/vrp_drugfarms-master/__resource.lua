resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vRP drugfarms"

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts{ 
  "Proxy.lua",
  "warehouses.lua",
  "ipls.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
