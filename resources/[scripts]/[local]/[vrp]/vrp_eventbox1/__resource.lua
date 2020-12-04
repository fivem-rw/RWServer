description "vrp_eventbox1"

dependency "vrp"

shared_script "@evp/main.lua"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua",
}

server_scripts {
  "@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua",
	"paycheck.lua"
}

ui_page {
	"html/index.html"
}

files {
	"html/*.*",
}
