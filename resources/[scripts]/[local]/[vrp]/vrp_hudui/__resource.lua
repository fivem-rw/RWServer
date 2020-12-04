resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "HUD UI"

dependency "vrp"

shared_script "@evp/main.lua"

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/css/*.css",
	"html/js/*.js",
	"html/img/*.*",
	"html/img/weapons/*.*",
	"html/sounds/*.ogg"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"locales/languages.lua",
	"config.lua",
	"client.lua",
	"MINIANCHOR.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"locales/languages.lua",
	"config.lua",
	"server.lua"
}
