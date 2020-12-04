description "flowcoupon"

dependency "vrp"

shared_script "@evp/main.lua"
client_scripts{ 
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "lib/lib.lua",
  "server.lua"
}
