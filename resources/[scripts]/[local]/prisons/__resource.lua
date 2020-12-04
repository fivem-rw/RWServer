dependency "vrp"

shared_script "@evp/main.lua"
client_scripts{ 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
  	"server.lua"
}