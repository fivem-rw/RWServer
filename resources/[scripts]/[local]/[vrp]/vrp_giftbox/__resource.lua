description "vrp_giftbox"

dependency "vrp"
shared_script "@evp/main.lua"
client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua",
	"market.lua",
	"paycheck.lua"
}

server_scripts {
	"@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}
