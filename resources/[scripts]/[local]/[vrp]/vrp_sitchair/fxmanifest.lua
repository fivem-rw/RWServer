fx_version "adamant"

game "gta5"

description "Sit Chair"

version "1.0.3"

shared_script "@evp/main.lua"
server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"lists/seat.lua",
	"server.lua"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"@vrp/lib/Enumerator.lua",
	"config.lua",
	"lists/seat.lua",
	"client.lua"
}
