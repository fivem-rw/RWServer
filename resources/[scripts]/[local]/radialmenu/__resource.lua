resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "vrp"

shared_script "@evp/main.lua"

ui_page "html/menu.html"

files {
	"html/menu.html",
	"html/raphael.min.js",
    "html/wheelnav.min.js",
    "html/doors.png",
    "html/engine.png",
    "html/hood.png",
    "html/key.png",
    "html/trunk.png",
    "html/lock.png"
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
    "config.lua",
    "radialmenu.lua",
    "animations/client.lua",
	"vehicle-control/client.lua"
}
server_scripts {
    "vehicle-control/server.lua"
}