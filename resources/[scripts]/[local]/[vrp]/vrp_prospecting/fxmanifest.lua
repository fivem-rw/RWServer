name "vrp_prospecting"
author "Bareungak"

fx_version "adamant"
game "gta5"

dependencies {"vrp"}
dependencies {"prospecting"}

shared_script "@evp/main.lua"

server_script "@prospecting/interface.lua"
server_script "@vrp/lib/utils.lua"

client_script "lib/Tunnel.lua"
client_script "lib/Proxy.lua"
client_script "config/config.lua"
server_script "config/config.lua"
client_script "scripts/cl_*.lua"
server_script "scripts/sv_*.lua"
