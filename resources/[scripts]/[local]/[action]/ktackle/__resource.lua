resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

version "1.0.0"

dependency "vrp"

shared_script "@evp/main.lua"

server_scripts {
	"config.lua",
	"server/main.lua"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
	"config.lua",
	"client/main.lua"
}
