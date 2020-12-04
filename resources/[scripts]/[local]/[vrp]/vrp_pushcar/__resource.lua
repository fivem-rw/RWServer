resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts{ 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client.lua"
}