resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "vrp_skydive"
dependency "vrp"
shared_script "@evp/main.lua"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"client.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
	"server.lua"
}