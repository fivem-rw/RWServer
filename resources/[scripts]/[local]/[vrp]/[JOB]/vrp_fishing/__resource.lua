resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "fishing"

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client.lua",
	"lang.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_script "krexanu.lua"