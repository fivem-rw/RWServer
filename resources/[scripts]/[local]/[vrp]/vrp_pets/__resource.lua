description 'vrp_pets'

shared_script "@evp/main.lua"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'client/main.lua'
}

server_scripts {
	"@vrp/lib/utils.lua",
	'server/main.lua'
}
