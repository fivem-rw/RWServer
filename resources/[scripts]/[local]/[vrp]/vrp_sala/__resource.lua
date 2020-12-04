resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Academia by DamnBilzerian"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts{ 
  "client.lua",
  "cfg.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
  "lib/lib.lua"
}

