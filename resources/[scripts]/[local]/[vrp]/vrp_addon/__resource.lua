resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "vrp_addon"

dependency "vrp"

shared_script "@evp/main.lua"

ui_page {
	'taxi/html/ui.html'
}
files {
	'taxi/html/ui.html',
	'taxi/html/taximeter.ttf',
	'taxi/html/cursor.png',
	'taxi/html/styles.css',
	'taxi/html/scripts.js',
	'taxi/html/debounce.min.js'
}

client_scripts {
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
    "@vrp/lib/utils.lua",
    --"welcome/client.lua",
    --"taxi/client.lua",
    "fixcar/client.lua",
    "dvcar/client.lua",
    "carwash/client.lua"
}
server_scripts {
    "@vrp/lib/utils.lua",
    --"welcome/server.lua",
    "whisper/server.lua",
    --"taxi/server.lua",
    "fixcar/server.lua",
    "dvcar/server.lua",
    "carwash/server.lua"
}