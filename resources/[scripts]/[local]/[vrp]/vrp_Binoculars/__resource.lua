
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@evp/main.lua"

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
    "config.lua",
    "client.lua"
}