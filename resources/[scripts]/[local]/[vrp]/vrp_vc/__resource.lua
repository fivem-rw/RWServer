resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "vrp_vc"

version "1.0.0"

dependencies {
    "vrp"
}

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

server_scripts {
    "@vrp/lib/MySQL.lua",
    "@vrp/lib/utils.lua",
    "config.lua",
    "server.lua"
}

client_scripts {
    "@vrp/client/Proxy.lua",
    "@vrp/client/Tunnel.lua",
    "@vrp/lib/utils.lua",
    "config.lua",
    "client.lua"
}