fx_version 'adamant'
games { 'gta5' }

shared_script "@evp/main.lua"
client_scripts { 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"config.lua",
	"client/*"
}
server_scripts { 
	"@vrp/lib/utils.lua",
	"config.lua",
	"server/*"
}