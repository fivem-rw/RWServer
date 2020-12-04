
description "vRP Revive"

dependency "vrp"
shared_script "@evp/main.lua"
server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
