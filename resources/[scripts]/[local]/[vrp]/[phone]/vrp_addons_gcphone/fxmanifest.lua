fx_version "adamant"
game "gta5"

name "gcPhone Addons"
description "Addons for GCPhone for vrp"
author "Draco"
version "3.0"

shared_script "@evp/main.lua"
client_script {
	"client.lua"
}

server_script {
	"@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"server.lua"
}

server_export "startCall"
