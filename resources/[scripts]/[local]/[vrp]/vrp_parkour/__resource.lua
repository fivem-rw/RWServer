resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

shared_script "@evp/main.lua"

client_scripts {
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
	"cl-parkour.lua", -- Agile Player Movements / Parkour Movements
	"Config.lua" -- Literally the line I forgot to add to make the shit work...
}

server_scripts {
	"@vrp/lib/utils.lua",
	"sv-parkour.lua" -- Agile Player Movements / Parkour Movements
}
