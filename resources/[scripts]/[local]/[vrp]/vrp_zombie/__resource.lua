resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
resource_type "gametype" {name = "Zombie"}

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "config.lua"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"cl_utils.lua",
	"cl_entityenum.lua",
	"cl_player.lua",
	"cl_env.lua",
	"cl_groupholder.lua",
	"cl_pedscache.lua",
	"spawning/cl_player.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"sv_init.lua",
	"sv_main.lua"
}