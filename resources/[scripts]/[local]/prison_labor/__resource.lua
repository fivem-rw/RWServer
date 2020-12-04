dependency "vrp"

shared_script "@evp/main.lua"

client_scripts {
	"client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}