resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

shared_script "@evp/main.lua"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua",
  "config.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}