resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependencies {
	"vrp",
	"vrp_drugs"
}

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/styles.css",
	"html/scripts.js",
	"configNui.js",
	"html/debounce.min.js",
	"html/sweetalert2.all.min.js",
	"html/assets/icons/*.png"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}
