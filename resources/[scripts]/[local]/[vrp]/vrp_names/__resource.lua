resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vrp_names"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts {
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
	"config.lua",
	"cl_main.lua"
}

server_scripts {
	"@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"sv_main.lua"
}

files {
	"icons/*.png"
}