------------------------------------------------------
----------https://github.com/DaviReisVieira-----------
------------EMAIL:VIEIRA08DAVI38@GMAIL.COM------------
---------------DISCORD: DAVI REIS #2602---------------
------------------------------------------------------

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "vrp"

shared_script "@evp/main.lua"

ui_page "html/index.html"

description "Tuner Chip"

client_script {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
  "client.lua",
}

server_script {
  "@vrp/lib/utils.lua",
  "server.lua"
}

files {
	"html/index.html",
	"html/index.css",
	"html/index.js",	
	"html/bg.jpg",
	"html/bg-2.jpg"
}