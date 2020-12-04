description "vRP atm"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts {
  "cfg/atm.lua",
  "client.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "cfg/atm.lua",
  "server.lua"
}
