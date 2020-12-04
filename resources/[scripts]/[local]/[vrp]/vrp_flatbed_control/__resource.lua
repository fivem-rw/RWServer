resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "vrp"

shared_scripts {
  "@evp/main.lua",
  "@vrp/shared/encrypt.lua"
}

client_scripts {
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts {
  "@vrp/lib/MySQL.lua",
  "@vrp/lib/utils.lua",
  "server.lua"
}
